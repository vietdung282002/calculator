import 'package:calculator/screen/home_provider.dart';
import 'package:calculator/utils/app_text_style.dart';
import 'package:calculator/widget/button_widget.dart';
import 'package:calculator/theme_provider.dart';
import 'package:calculator/widget/toggle_widget.dart';
import 'package:calculator/utils/button_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const ToggleWidget(),
              outPutSection(),
              inPutSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget inPutSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        for (int i = 0; i < 5; i++) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int j = 0; j < 4; j++)
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return ButtonWidget(
                      width: (size.width - 30) / 4,
                      height: (size.height - 30) / 10,
                      backgroundColor: ButtonData.getButtonColor(
                          ButtonData.buttons[i][j], themeProvider.mode),
                      onPressed: () {
                        Provider.of<HomeProvider>(context, listen: false)
                            .updateOperation(ButtonData.buttons[i][j].label);
                      },
                      child: ButtonData.getButtonChild(
                        ButtonData.buttons[i][j],
                        themeProvider.mode,
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget outPutSection() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Selector<HomeProvider, String>(
                  selector: (context, homeProvider) => homeProvider.operation,
                  builder: (context, operation, child) {
                    return Opacity(
                      opacity: 0.4,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          operation,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: AppTextStyle.operator,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Selector<HomeProvider, String>(
                  selector: (context, homeProvider) =>
                      homeProvider.resultString,
                  builder: (context, result, child) {
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        result,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: AppTextStyle.result,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
