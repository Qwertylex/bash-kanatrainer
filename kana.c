/* gcc kana.c -lreadline */

#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <wchar.h>
#include <limits.h>

#define NUM(x) (sizeof (x) / sizeof (*x))

static const char *romaji[] = { "a", "i", "u", "e", "o", "ka", "ki",
    "ku", "ke", "ko", "sa", "shi", "su", "se", "so", "ta", "chi", "tsu",
    "te", "to", "na", "ni", "nu", "ne", "no", "ha", "hi", "fu", "he",
    "ho", "ma", "mi", "mu", "me", "mo", "ya", "yu", "yo", "ra", "ri",
    "ru", "re", "ro", "wa", "wo", "n"
};

static const wchar_t *hiras[] = { L"あ", L"い", L"う", L"え", L"お", L"か", L"き",
    L"く", L"け", L"こ", L"さ", L"し", L"す", L"せ", L"そ", L"た", L"ち", L"つ",
    L"て", L"と", L"な", L"に", L"ぬ", L"ね", L"の", L"は", L"ひ", L"ふ", L"へ",
    L"ほ", L"ま", L"み", L"む", L"め", L"も", L"や", L"ゆ", L"よ", L"ら", L"り",
    L"る", L"れ", L"ろ", L"わ", L"を", L"ん"
};

static const wchar_t *katas[] = { L"ア", L"イ", L"ウ", L"エ", L"オ", L"カ", L"キ",
    L"ク", L"ケ", L"コ", L"サ", L"シ", L"ス", L"セ", L"ソ", L"タ", L"チ", L"ツ",
    L"テ", L"ト", L"ナ", L"ニ", L"ヌ", L"ネ", L"ノ", L"ハ", L"ヒ", L"フ", L"ヘ",
    L"ホ", L"マ", L"モ", L"ム", L"メ", L"モ", L"ヤ", L"ユ", L"ヨ", L"ラ", L"リ",
    L"ル", L"レ", L"ロ", L"ワ", L"ヲ", L"ン"
};

static int correct = 0, total = 0, running = 0;
static char buf[LINE_MAX];

static void
score(void) {
    wprintf(L"Score: %d\nCorrect: %d/%d\n", 2 * correct - total, correct, total);
}

static void
kana_loop(int mode) {
    const char *r;
    const wchar_t **p;
    int rand_val = random() % NUM(romaji);

    r = romaji[rand_val];
    if (mode == 0)
        p = hiras;
    else
        p = katas;
    wprintf(L"Guess: ");
    wprintf(p[rand_val]);
    if (fgets(buf, LINE_MAX, stdin) == NULL)
        exit(EXIT_FAILURE);
    if (!strcmp(buf, r)) {
        wprintf(L"Correct!\n");
        correct++;
    } else
        wprintf(L"Incorrect! The answer was: %s\n", r);
    total++;
}

int
main(void) {
    int c, mode;

    srandom(time(NULL));
    setlocale(LC_CTYPE, "");
    wprintf(L"[H]ira or [K]ata ([q] to quit): ");
    if (fgets(buf, LINE_MAX, stdin) == NULL)
        exit(EXIT_FAILURE);
    switch (buf[0]) {
        case 'q':
            exit(EXIT_SUCCESS);
        break;
        case 'h':
        case 'H':
            mode = 0;
        break;
        case 'k':
        case 'K':
            mode = 1;
        break;
        default:
            mode = 1;
        break;
    }
    running = 1;
    for (; running;) {
        kana_loop(mode);
        score();
    }
    return 0;
}
/* vim: et ts=4 sw=4 tw=80
 */
