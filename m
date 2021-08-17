Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D73EF1F8
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhHQShJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhHQShJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 14:37:09 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A642C061764
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 11:36:35 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i8so101414ybt.7
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fe2m5+2u/+/nOJMRBhN3gv7rPBuah6+6HomXy7Ia3as=;
        b=U09vQvzdK5/Psv1sIkS1DEKua7gkFAGcUdVHZXz7bxpMVotaoxj6/7p0nTyQpyMc8k
         z6pQiobQ3aLDxd53pznjY4e/fnEr7SGwPiT95KhlrzhJxxetNDOS5f7zlMLKgMuxlDb2
         y7+khmvIE2/2uYUpKh/dDa+GovYTwXdVJ5o31ORLnMCS+s2JPlgYbljxLh3lyqp5n5Bm
         HL9p6pDTSdOsuNRbypVukLrxOa92sAJu5nc/LmioGr/z/QgOJN7kk/iz5HBmhWW74oMX
         TR1cjZCLE+kx/fbOyM2CTCco4+vYqFKQ6c/4dPASYEvHCmTOjMfhTVdg3yBOmretZEp1
         C6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fe2m5+2u/+/nOJMRBhN3gv7rPBuah6+6HomXy7Ia3as=;
        b=A6pZx2yngJzgf+y+TbOhu1ICAgDnpEDTn5vEfz2no4BBY0Q0MCAxU+CEIjA9KEMGHS
         0jBQttOvElW9kh9xFtSaMZUmZb0zLbQn6ffApT1KKdbbOmIsaZWjVQVSsl872A+nVO0e
         eWWgOZp7MBJ74uDkrUlfJqikwcbCHtiSFh/7qartg+w28BpWd28v6iyHf2p6uCCc0xLF
         //eIkg61InbSO92ob92b7A7OuI78pYf1hJWfPEVJeVgQ6RzaT0R2cGoY3oTkecrSk5ur
         QHqyYGwGXQZGsb6t+c24IOhCD1ImH2nAw96yJBpAoQInJC+NWjqj6gldrdI0jKPqfKMJ
         rpJQ==
X-Gm-Message-State: AOAM533VpC9SUeBa1L2xT4MER9phUqIVzSA6Alm2KVm08LDX6d61VbI9
        i9SGgtz/3TmMeV0YMm+S+wbp1tQ4RpH2r98rufA=
X-Google-Smtp-Source: ABdhPJyzl22ShH/ci5YKcMHj+dqFp9ndgbc7FwhY+7Ov8vExeuJMG1ajOCCYwoyBXryGYSfErUwqgJU9Pko+c4FTt00=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr6251164ybg.347.1629225394891;
 Tue, 17 Aug 2021 11:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210817044732.3263066-1-fallentree@fb.com> <20210817044732.3263066-5-fallentree@fb.com>
In-Reply-To: <20210817044732.3263066-5-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 Aug 2021 11:36:23 -0700
Message-ID: <CAEf4BzYfbpBSn8aqUAm=pHNO_vp4n=A6p-CPgAKBhFmuGTueDA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Support glob matching for
 test selector.
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 9:47 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch adds '-a' and '-d' arguments, support exact string match, as well as
> using '*' wildcard in test/subtests selection. The old '-t' '-b' arguments
> still supports partial string match, but they can't be used together yet.
>
> This patach also adds support for mulitple '-a' '-d' '-t' '-b' arguments.
>
> Caveat: Same as the current substring matching mechanism, test and subtest
> selector applies independently, 'a*/b*' will execute all tests matching "a*",
> and with subtest name matching "b*", but tests matching "a*" that has no
> subtests will also be executed.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 72 +++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 90539b15b744..c34eb818f115 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -13,6 +13,28 @@
>  #include <execinfo.h> /* backtrace */
>  #include <linux/membarrier.h>
>
> +/* Adapted from perf/util/string.c */
> +static bool glob_match(const char *str, const char *pat)
> +{
> +       while (*str && *pat && *pat != '*') {
> +               if (*str != *pat)
> +                       return false;
> +               str++;
> +               pat++;
> +       }
> +       /* Check wild card */
> +       if (*pat == '*') {
> +               while (*pat == '*')
> +                       pat++;
> +               if (!*pat) /* Tail wild card matches all */
> +                       return true;
> +               while (*str)
> +                       if (glob_match(str++, pat))
> +                               return true;
> +       }
> +       return !*str && !*pat;
> +}
> +
>  #define EXIT_NO_TEST           2
>  #define EXIT_ERR_SETUP_INFRA   3
>
> @@ -55,12 +77,12 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
>         int i;
>
>         for (i = 0; i < sel->blacklist.cnt; i++) {
> -               if (strstr(name, sel->blacklist.strs[i]))
> +               if (glob_match(name, sel->blacklist.strs[i]))
>                         return false;
>         }
>
>         for (i = 0; i < sel->whitelist.cnt; i++) {
> -               if (strstr(name, sel->whitelist.strs[i]))
> +               if (glob_match(name, sel->whitelist.strs[i]))
>                         return true;
>         }
>
> @@ -450,6 +472,8 @@ enum ARG_KEYS {
>         ARG_VERBOSE = 'v',
>         ARG_GET_TEST_CNT = 'c',
>         ARG_LIST_TEST_NAMES = 'l',
> +       ARG_TEST_NAME_GLOB_ALLOWLIST = 'a',
> +       ARG_TEST_NAME_GLOB_DENYLIST = 'd',
>  };
>
>  static const struct argp_option opts[] = {
> @@ -467,6 +491,10 @@ static const struct argp_option opts[] = {
>           "Get number of selected top-level tests " },
>         { "list", ARG_LIST_TEST_NAMES, NULL, 0,
>           "List test names that would run (without running them) " },
> +       { "allow", ARG_TEST_NAME_GLOB_ALLOWLIST, "NAMES", 0,
> +         "Run tests with name matching the pattern (support *)." },
> +       { "deny", ARG_TEST_NAME_GLOB_DENYLIST, "NAMES", 0,
> +         "Don't run tests with name matching the pattern (support *)." },
>         {},
>  };
>
> @@ -491,7 +519,7 @@ static void free_str_set(const struct str_set *set)
>         free(set->strs);
>  }
>
> -static int parse_str_list(const char *s, struct str_set *set)
> +static int parse_str_list(const char *s, struct str_set *set, bool is_glob_pattern)
>  {
>         char *input, *state = NULL, *next, **tmp, **strs = NULL;
>         int cnt = 0;
> @@ -500,28 +528,38 @@ static int parse_str_list(const char *s, struct str_set *set)
>         if (!input)
>                 return -ENOMEM;
>
> -       set->cnt = 0;
> -       set->strs = NULL;
> -
>         while ((next = strtok_r(state ? NULL : input, ",", &state))) {
>                 tmp = realloc(strs, sizeof(*strs) * (cnt + 1));
>                 if (!tmp)
>                         goto err;
>                 strs = tmp;
> +               if (is_glob_pattern) {
> +                       strs[cnt] = strdup(next);
> +               } else {
> +                       strs[cnt] = malloc(strlen(next) + 2 + 1);
> +                       if (!strs[cnt])
> +                               goto err;
> +                       sprintf(strs[cnt], "*%s*", next);
> +               }
>
> -               strs[cnt] = strdup(next);
>                 if (!strs[cnt])
>                         goto err;
>
>                 cnt++;
>         }
>
> -       set->cnt = cnt;
> -       set->strs = (const char **)strs;
> +       tmp = realloc(set->strs, sizeof(*strs) * (cnt + set->cnt));
> +       if (!tmp)
> +               goto err;
> +       memcpy(tmp + set->cnt,  strs,  sizeof(*strs) * (cnt));
> +       set->strs = (const char **)tmp;
> +       set->cnt += cnt;
>         free(input);
> +       free(strs);
>         return 0;
>  err:
> -       free(strs);
> +       if (strs)
> +               free(strs);

free(NULL) is noop, so no need to check if(strs)

You also missed the need to free all those strdup()'ed strings, so I added

for (i = 0; i < cnt; i++)
    free(strs[i]);

We didn't need it originally, because eventually we call
free_str_set(), but in this case those strings will be leaked, because
we don't assign strs to set->strs.

BTW, a bit cleaner approach would be to just work on set->strs
directly, and realloc()ing it as necessary, and only at the end
updating set->cnt. You wouldn't need to memcpy and realloc one extra
time at the end, and no need for that for + free loop. But it's fine
the way it is as well.

Applied to bpf-next, thanks a lot for the improvements.

>         free(input);
>         return -ENOMEM;
>  }
> @@ -553,29 +591,35 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>                 }
>                 break;
>         }
> +       case ARG_TEST_NAME_GLOB_ALLOWLIST:
>         case ARG_TEST_NAME: {
>                 char *subtest_str = strchr(arg, '/');
>
>                 if (subtest_str) {
>                         *subtest_str = '\0';
>                         if (parse_str_list(subtest_str + 1,
> -                                          &env->subtest_selector.whitelist))
> +                                          &env->subtest_selector.whitelist,
> +                                          key == ARG_TEST_NAME_GLOB_ALLOWLIST))
>                                 return -ENOMEM;
>                 }
> -               if (parse_str_list(arg, &env->test_selector.whitelist))
> +               if (parse_str_list(arg, &env->test_selector.whitelist,
> +                                  key == ARG_TEST_NAME_GLOB_ALLOWLIST))
>                         return -ENOMEM;
>                 break;
>         }
> +       case ARG_TEST_NAME_GLOB_DENYLIST:
>         case ARG_TEST_NAME_BLACKLIST: {
>                 char *subtest_str = strchr(arg, '/');
>
>                 if (subtest_str) {
>                         *subtest_str = '\0';
>                         if (parse_str_list(subtest_str + 1,
> -                                          &env->subtest_selector.blacklist))
> +                                          &env->subtest_selector.blacklist,
> +                                          key == ARG_TEST_NAME_GLOB_DENYLIST))
>                                 return -ENOMEM;
>                 }
> -               if (parse_str_list(arg, &env->test_selector.blacklist))
> +               if (parse_str_list(arg, &env->test_selector.blacklist,
> +                                  key == ARG_TEST_NAME_GLOB_DENYLIST))
>                         return -ENOMEM;
>                 break;
>         }
> --
> 2.30.2
>
