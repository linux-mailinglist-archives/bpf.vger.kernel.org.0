Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5B4F54E6
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 07:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbiDFFVI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 01:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842546AbiDFBby (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 21:31:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7FF1B785
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 16:14:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id x9so716181ilc.3
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 16:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jV5AjJ1zPgXJSuZlhvWQ5OTeQeQgB4LqOcBYHXbKvgI=;
        b=oqUF+eFyJWvNOrUw21bR0GV8yWRU4hbtygAIbm2O+qrngZD3B3Wgvs+9MXhQUrONQp
         qL/aoafzzet1LYaHVwYawj3P3c4FiWLdsPg9cNsRxbC491+FYdg5F45Y2yuw3X49Sovn
         9ft9oKXOnB9qck7Eq50W7/fcL103Id8jqBQWiGpUez3D5Gtwq4mCzyiaYCcrnJwChMnR
         RjEHYDAhD2/qD7CgWZEb7c6qIgcS0jVO+oMZQHb2XjBf7YliRwekWWYBYeH6U9AqU7q3
         nV1X39CaatOYCxTbTCMZCM2EcSjmcMG7/J9Lro25Z/7AGaVmjmKTp5VdKjOo8oVTwSzI
         cmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jV5AjJ1zPgXJSuZlhvWQ5OTeQeQgB4LqOcBYHXbKvgI=;
        b=xThKmtmsbBLV5KPZ1+MH4SMndgp8YhDzrRCdsj25Li41RDAuO7HpSa2PcdFERc8VIa
         W6OFp7cZtLosyLi970IMCtXagEBsL6aIqlvv0X7Kk+OoBtQ4pPlfbPUK7Rmp7pRgCuLR
         vhcqp9MazJrKJnacm+iUf3CPuI+SETAEtoRiCUKh6KoOoJkFseNKcSiu/lpl5Lyl/Ly8
         No1PzebU9Yj6UI3fVl7sVPbi4m8CYkMdz/FDPnmMH3XA3wUKDteSDs3woskTZCynYbn2
         PQEun6IxyIrfBfPCmjZvBBz9TQMpZqdyNZoF1xzeLjUx1XpsrCLTxHg8kXAy5NXkTPKP
         ohDg==
X-Gm-Message-State: AOAM533bnc5TwcZAllvVhMMyl38PkvWjhdKyK7TsI2SSir5ubi6HaphB
        8MFbNMlGs/pIYNbeVTLTFt0AOmxMu9ogl1u51oA=
X-Google-Smtp-Source: ABdhPJwT9TodnnIecDeI2kAprSBLbY4u8ErSZlalBeYSGDZ0mrhPWCD8/hzwveMIgiyc2U6rF9STyTk6lZr5QC/3asE=
X-Received: by 2002:a92:cd89:0:b0:2c9:bdf3:c5dd with SMTP id
 r9-20020a92cd89000000b002c9bdf3c5ddmr2604934ilb.252.1649200468315; Tue, 05
 Apr 2022 16:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220405204158.2496618-1-mykolal@fb.com>
In-Reply-To: <20220405204158.2496618-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Apr 2022 16:14:17 -0700
Message-ID: <CAEf4BzYhUp3UqfMfENqM_A7Dz=TkaV44eCoNzoD6x2yRs1NNyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Improve by-name subtest selection
 logic in prog_tests
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 5, 2022 at 1:45 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> Improve subtest selection logic when using -t/-a/-d parameters.
> In particular, more than one subtest can be specified or a
> combination of tests / subtests.
>
> -a send_signal -d send_signal/send_signal_nmi* - runs send_signal
> test without nmi tests
>
> -a send_signal/send_signal_nmi*,find_vma - runs two send_signal
> subtests and find_vma test
>

Only somewhat related, but while we are at this topic. Can you please
check whether equivalent approach works:

-a send_signal/send_signal_nmi* -a find_vma

i.e., multi -a/-d/-t/-b are concatenating their selectors.

> This will allow us to have granular control over which subtests
> to disable in the CI system instead of disabling whole tests.
>
> Also, add new selftest to avoid possible regression when
> changing prog_test test name selection logic.
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---
>  .../selftests/bpf/prog_tests/arg_parsing.c    |  88 ++++++++++
>  tools/testing/selftests/bpf/test_progs.c      | 157 +++++++++---------
>  tools/testing/selftests/bpf/test_progs.h      |  16 +-
>  tools/testing/selftests/bpf/testing_helpers.c |  87 ++++++++++
>  tools/testing/selftests/bpf/testing_helpers.h |   6 +
>  5 files changed, 266 insertions(+), 88 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arg_parsing.c
>

[...]

> +static void test_parse_test_list(void)
> +{
> +       struct test_set test_set;
> +
> +       init_test_set(&test_set);
> +
> +       parse_test_list("arg_parsing", &test_set, true);

ASSER_OK() return value?

> +       if (CHECK(test_set.cnt != 1, "parse_test_list subtest argument", "Unexpected number of tests in num table %d\n", test_set.cnt))

please don't use CHECK()s in new tests, we only add ASSERT_xxx() now.
Also line length should be under 100 characters (except for the case
when we have a long string literal, we don't break string literals, no
matter how long).

> +               goto error;
> +       if (!ASSERT_OK_PTR(test_set.tests, "tests__initialized"))
> +               goto error;
> +       if (CHECK(!test_set.tests[0].whole_test, "parse_test_list subtest argument", "Expected test 0 to be initialized"))
> +               goto error;
> +       if (CHECK(strcmp("arg_parsing", test_set.tests[0].name), "parse_test_list subtest argument", "Expected test 0 to be initialized"))
> +               goto error;
> +       free_test_set(&test_set);
> +
> +       parse_test_list("arg_parsing,bpf_cookie", &test_set, true);
> +       if (CHECK(test_set.cnt != 2, "parse_test_list subtest argument", "Unexpected number of tests in num table %d\n", test_set.cnt))
> +               goto error;
> +       if (!ASSERT_OK_PTR(test_set.tests, "tests__initialized"))
> +               goto error;
> +       if (CHECK(!test_set.tests[0].whole_test, "parse_test_list subtest argument", "Expected test 0 to be fully runnable"))
> +               goto error;
> +       if (CHECK(!test_set.tests[1].whole_test, "parse_test_list subtest argument", "Expected test 1 to be fully runnable"))
> +               goto error;

nit: I think there is no need to goto error after each check. We need
goto error if subsequent checks can crash due to some invalid state.
In this case, validating the value of few independent values is ok to
always check without goto error jumps. Makes tests shorter and
simpler.


> +       if (CHECK(strcmp("arg_parsing", test_set.tests[0].name), "parse_test_list subtest argument", "Expected test 0 to be arg_parsing"))
> +               goto error;
> +       if (CHECK(strcmp("bpf_cookie", test_set.tests[1].name), "parse_test_list subtest argument", "Expected test 1 to be bpf_cookie"))
> +               goto error;
> +       free_test_set(&test_set);
> +
> +       parse_test_list("arg_parsing/test_parse_test_list,bpf_cookie", &test_set, true);
> +       if (CHECK(test_set.cnt != 2, "parse_test_list subtest argument", "Unexpected number of tests in num table %d\n", test_set.cnt))
> +               goto error;

[...]

> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 0a4b45d7b515..671e37cada4b 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -3,6 +3,7 @@
>   */
>  #define _GNU_SOURCE
>  #include "test_progs.h"
> +#include "testing_helpers.h"
>  #include "cgroup_helpers.h"
>  #include <argp.h>
>  #include <pthread.h>
> @@ -82,14 +83,14 @@ int usleep(useconds_t usec)
>  static bool should_run(struct test_selector *sel, int num, const char *name)
>  {
>         int i;
> -

keep empty line between variable declaration block and first statement

>         for (i = 0; i < sel->blacklist.cnt; i++) {
> -               if (glob_match(name, sel->blacklist.strs[i]))
> +               if (glob_match(name, sel->blacklist.tests[i].name) &&
> +                   sel->blacklist.tests[i].whole_test)
>                         return false;
>         }
>
>         for (i = 0; i < sel->whitelist.cnt; i++) {
> -               if (glob_match(name, sel->whitelist.strs[i]))
> +               if (glob_match(name, sel->whitelist.tests[i].name))
>                         return true;
>         }
>

[...]

> -bool test__start_subtest(const char *name)
> +bool test__start_subtest(const char *subtest_name)
>  {
>         struct prog_test_def *test = env.test;
>
> @@ -205,17 +246,21 @@ bool test__start_subtest(const char *name)
>
>         test->subtest_num++;
>
> -       if (!name || !name[0]) {
> +       if (!subtest_name || !subtest_name[0]) {
>                 fprintf(env.stderr,
>                         "Subtest #%d didn't provide sub-test name!\n",
>                         test->subtest_num);
>                 return false;
>         }
>
> -       if (!should_run(&env.subtest_selector, test->subtest_num, name))
> +       if (!should_run_subtest(&env.test_selector,
> +                               &env.subtest_selector,

we don't have subtest_selector anymore, do we?

also, do you think that maybe combining should_run and
should_rub_subtest would be a good idea? You can distinguish by having
subtest_name NULL when you need to check only test?

> +                               test->subtest_num,
> +                               test->test_name,
> +                               subtest_name))
>                 return false;
>
> -       test->subtest_name = strdup(name);
> +       test->subtest_name = strdup(subtest_name);
>         if (!test->subtest_name) {
>                 fprintf(env.stderr,
>                         "Subtest #%d: failed to copy subtest name!\n",
> @@ -527,63 +572,29 @@ static int libbpf_print_fn(enum libbpf_print_level level,
>         return 0;
>  }
>

[...]

> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index eec4c7385b14..6a465a98341e 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -37,7 +37,6 @@ typedef __u16 __sum16;
>  #include <bpf/bpf_endian.h>
>  #include "trace_helpers.h"
>  #include "testing_helpers.h"
> -#include "flow_dissector_load.h"
>
>  enum verbosity {
>         VERBOSE_NONE,
> @@ -46,14 +45,21 @@ enum verbosity {
>         VERBOSE_SUPER,
>  };
>
> -struct str_set {
> -       const char **strs;
> +struct prog_test {
> +       char *name;
> +       char **subtests;
> +       int subtest_cnt;
> +       bool whole_test;
> +};
> +
> +struct test_set {
> +       struct prog_test *tests;

prog_test is a bad name, IMO. it's a "test filter", right? Let's call it that?

test_set isn't most accurate as well, maybe test_filter_set or test_set_filter?

>         int cnt;
>  };
>
>  struct test_selector {
> -       struct str_set whitelist;
> -       struct str_set blacklist;
> +       struct test_set whitelist;
> +       struct test_set blacklist;
>         bool *num_set;
>         int num_set_len;
>  };
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index 795b6798ccee..d2160d2a1303 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -6,6 +6,7 @@
>  #include <errno.h>
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> +#include "test_progs.h"
>  #include "testing_helpers.h"
>
>  int parse_num_list(const char *s, bool **num_set, int *num_set_len)
> @@ -69,6 +70,92 @@ int parse_num_list(const char *s, bool **num_set, int *num_set_len)
>         return 0;
>  }
>
> +int parse_test_list(const char *s,
> +                   struct test_set *test_set,
> +                   bool is_glob_pattern)
> +{
> +       char *input, *state = NULL, *next;
> +       struct prog_test *tmp, *tests = NULL;
> +       int i, j, cnt = 0;
> +
> +       input = strdup(s);
> +       if (!input)
> +               return -ENOMEM;
> +
> +       while ((next = strtok_r(state ? NULL : input, ",", &state))) {
> +               char *subtest_str = strchr(next, '/');
> +               char *pattern = NULL;
> +
> +               tmp = realloc(tests, sizeof(*tests) * (cnt + 1));
> +               if (!tmp)
> +                       goto err;
> +               tests = tmp;
> +
> +               tests[cnt].subtest_cnt = 0;
> +               tests[cnt].subtests = NULL;
> +               tests[cnt].whole_test = false;
> +
> +               if (subtest_str) {
> +                       char **tmp_subtests = NULL;

need an empty line between variable declarations and statements

> +                       *subtest_str = '\0';
> +                       int subtest_cnt = tests[cnt].subtest_cnt;
> +
> +                       tmp_subtests = realloc(tests[cnt].subtests,
> +                                              sizeof(*tmp_subtests) *
> +                                              (subtest_cnt + 1));
> +                       if (!tmp_subtests)
> +                               goto err;
> +                       tests[cnt].subtests = tmp_subtests;
> +
> +                       tests[cnt].subtests[subtest_cnt] = strdup(subtest_str + 1);
> +                       if (!tests[cnt].subtests[subtest_cnt])
> +                               goto err;
> +
> +                       tests[cnt].subtest_cnt++;
> +               } else {
> +                       tests[cnt].whole_test = true;

isn't whole_test equivalent to subtest_cnt > 0? Why keeping extra bool
of state then?

> +               }
> +
> +               if (is_glob_pattern) {
> +                       pattern = "%s";
> +                       tests[cnt].name = malloc(strlen(next) + 1);
> +               } else {
> +                       pattern = "*%s*";
> +                       tests[cnt].name = malloc(strlen(next) + 2 + 1);
> +               }
> +
> +               if (!tests[cnt].name)
> +                       goto err;
> +
> +               sprintf(tests[cnt].name, pattern, next);
> +
> +               cnt++;
> +       }
> +
> +       tmp = realloc(test_set->tests, sizeof(*tests) * (cnt + test_set->cnt));
> +       if (!tmp)
> +               goto err;
> +
> +       memcpy(tmp + test_set->cnt, tests, sizeof(*tests) * cnt);
> +       test_set->tests = tmp;
> +       test_set->cnt += cnt;
> +
> +       free(tests);
> +       free(input);
> +       return 0;
> +
> +err:
> +       for (i = 0; i < cnt; i++) {
> +               for (j = 0; j < tests[i].subtest_cnt; j++)
> +                       free(tests[i].subtests[j]);
> +
> +               free(tests[i].name);
> +       }
> +       free(tests);
> +       free(input);
> +       return -ENOMEM;
> +}
> +
>  __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info)
>  {
>         __u32 info_len = sizeof(*info);
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index f46ebc476ee8..d2f502184cd1 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -12,3 +12,9 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
>                           size_t insns_cnt, const char *license,
>                           __u32 kern_version, char *log_buf,
>                           size_t log_buf_sz);
> +
> +/*
> + * below function is exported for testing in prog_test test
> + */
> +struct test_set;
> +int parse_test_list(const char *s, struct test_set *test_set, bool is_glob_pattern);
> --
> 2.30.2
>
