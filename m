Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74713EE494
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 04:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhHQCqX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 22:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhHQCqX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 22:46:23 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C011C061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:45:51 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w17so36680655ybl.11
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGm7DaBYnwlo0A7vA8cSs9dFfvijBp9C/DucBBgXDxQ=;
        b=YXJx6J7Tk6fKcJFiZpEo8dnMKs5bRBaA7PW/BLg5zX0c3W+/10WWs005GHO/1A8ISk
         Njxq4dR2anr08o1YUuK/33FP9tId6Z1N6nAvN0OQMjGZcM7PSOWfDVSLx8Onclf1YHgY
         Pvvriu6TIYsA2erTtbtE2La013Sj3D/wGnXEWyYsgjb9QYg6mlKJiKZPgVfCwBv9CRo2
         6Y8qzQ0SeMRLfnGZLZ0h8QUKFYVyRLAfmkYLQFwAZEdaR3C0SHVCIiuwYJUp3MBRFz+h
         PjljWgxO5fCBZk1SDLkoIRELKWFQzI0sBvl/Y2DbGYWFHtbVJwGgMPEg5vK0gqePv5sl
         Xcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGm7DaBYnwlo0A7vA8cSs9dFfvijBp9C/DucBBgXDxQ=;
        b=Ak+LbdKWmsTHISkVLgTgWcb5i9f0MiD+J+KJuVc/srpWk6ywuohH/zMRJSW/K7sffb
         JJQk8R8JrjEFv5GdN2iaDxhz1pGhhTqtIPnZU7I4Qh0CwB7cNpDspfRTTTLNwUm6OR4i
         eS67IfVwlwBxZQc4WRh3EaPITyF1INGRzir/gUKEvXlXX3R/+L5+ri8BjajpxYBfsykK
         /tpAouUXPZ92OqRTNKKnp01QAMVs1HDiIvEhKfhXeYs0T96wgcffkP8QTVtS644xnFEM
         U3bNmLNDzJZ78V3IsNjlsOeOZSS2xGE7hZrtOxPveGV1KWo9mu9ZyFs7H6uiprN3mY4Y
         UvmQ==
X-Gm-Message-State: AOAM533gUJjwpTnSdNtUwIm1jgMhqSi9PkfqaT0g4heLPLgIi7x1klsW
        +QvUBuxfu5KVd/oNrWKhsCoi6/2iEUtBtbGTsn0=
X-Google-Smtp-Source: ABdhPJzaRBLbQnIJbFN5YCaJB4xVqmG7EyMHz0z4gbrRV/S24X1Rz3z0p4oGBpKAmfaFPtkUyez2V7f8ECi/evCYITg=
X-Received: by 2002:a5b:648:: with SMTP id o8mr1615287ybq.260.1629168350269;
 Mon, 16 Aug 2021 19:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210817010310.2300741-1-fallentree@fb.com> <20210817010310.2300741-5-fallentree@fb.com>
In-Reply-To: <20210817010310.2300741-5-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 Aug 2021 19:45:39 -0700
Message-ID: <CAEf4Bza73q02zj_O6RNNF9HaQfLWajOFJgZXrztDvAZFV8n8Ug@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/4] selftests/bpf: Support glob matching for
 test selector.
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 6:03 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This patch adds '-a' and '-d' arguments, supporting exact string match, as well
> as using '*' wildcard in test/subtests selection. The old '-t' '-b' arguments
> still supports partial string match, but they can't be used together yet.

typo: support

>
> Caveat: As same as the current substring matching mechanism, test and subtest

"Same as"

> selector applies independently, 'a*/b*' will execute all tests matches "a*",

s/matches/matching/ same below

> and with subtest name matches "b*", but tests matches "a*" but has no subtests
> will also be executed.
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 64 +++++++++++++++++++++---
>  tools/testing/selftests/bpf/test_progs.h |  1 +
>  2 files changed, 57 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 90539b15b744..f5dbaa29d370 100644
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
> @@ -508,8 +536,14 @@ static int parse_str_list(const char *s, struct str_set *set)
>                 if (!tmp)
>                         goto err;
>                 strs = tmp;
> +               if (is_glob_pattern)
> +                       strs[cnt] = strdup(next);

coding style: if one branch of if/else uses {}, the other has to use it as well

> +               else {
> +                       char* pat = malloc(strlen(next) + 2 + 1);

coding style: empty line after variable declaration (but I'd just use
strs[cnt] twice without extra var)

also `char *pat`, please use checkpatch.pl to double check your
changes until kernel code style becomes second nature (and even then
it's probably useful to run it from time to time). We do have few
errors reported in test_progs.c, but the script would reported 2 out
of 3 of these problems. At some point we should see if it makes sense
to run checkpatch.pl as one of BPF CI steps.

> +                       sprintf(pat, "*%s*", next);
> +                       strs[cnt] = pat;
> +               }
>
> -               strs[cnt] = strdup(next);
>                 if (!strs[cnt])
>                         goto err;
>
> @@ -553,29 +587,43 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>                 }
>                 break;
>         }
> +       case ARG_TEST_NAME_GLOB_ALLOWLIST:
>         case ARG_TEST_NAME: {
> +               if (env->test_selector.whitelist.cnt || env->subtest_selector.whitelist.cnt) {
> +                       fprintf(stderr, "-a and -t are mutually exclusive, you can only specify one.\n");
> +                       return -EINVAL;
> +               }

Why are they still exclusive? They are now just alternative ways to
specify the same set of filters, one as substring match, another as
explicit globs. Just like you can use '-t a,b', you can also have '-t
a -a "*b*"', right? They can totally co-exist and it might be useful
to use both sometimes.

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
> +               if (env->test_selector.blacklist.cnt || env->subtest_selector.blacklist.cnt) {
> +                       fprintf(stderr, "-d and -b are mutually exclusive, you can only specify one.\n");
> +                       return -EINVAL;
> +               }

same, they can organically co-exist

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
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> index c8c2bf878f67..c475d65dce4f 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -49,6 +49,7 @@ enum verbosity {
>  struct str_set {
>         const char **strs;
>         int cnt;
> +       bool is_glob_pattern;


leftovers? doesn't seem to be used

>  };
>
>  struct test_selector {
> --
> 2.30.2
>
