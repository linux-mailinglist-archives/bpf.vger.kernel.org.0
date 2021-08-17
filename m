Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1893EE5E4
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 06:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhHQEvk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 00:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhHQEvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Aug 2021 00:51:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01714C061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:51:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h9so30865127ljq.8
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wpkONwo94SIpc7xgQR9tH+0IMJM6GibG7HuAjfDFHU=;
        b=hxhwhXlsppV7GKWRMVwweU4AvB2OJueUVKK1KzQdr0F/eHp3ruR2K880P7acHYHHas
         YZL9t7MhmQy6v+OgUvYc2CD327K9sVflT6ypj+UQs4v6vNetpKqq+6Ud4n0+zKP4T+8v
         QA5wilnb1UrhWwlPPLtZVilRTbpY7JI66h+M3RoDJrbbpjo77Lorp1RBigdJAvlgRIie
         uGc6HhJHj5d62FyGhohXfZVJ9Fq/yL3lZE1qIEGAapI4SIpJN9mLltlATvTrtwSjhrMg
         nsPeIwMat2GBkzq82bzsp5mvWScA2A4EL3Hu4pweHONXcy8y9WL3NxHMQay8f6HFhXCD
         6WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wpkONwo94SIpc7xgQR9tH+0IMJM6GibG7HuAjfDFHU=;
        b=dvH+U42Kld9qfdTQZsnS/qOMe+iygF97B7JtQ5a8tdxPjhOWXyAzrilDjZVcx7tS+0
         6ha87LQdJCqAA/9NewWcrmzziIEdUr+Et0Ijqr099QJGxhdc65iohVbL3TnRC4PlTTN7
         0syZS8kyHgnuLnoZUNGBvBaWO3OU+PA3jqoycH0t98glXKSKc/jpJmI8Nu0uDXPO9R5X
         gGpCPOGNH/etbigJ+AB0HXtahPXZ4zj9VWt7qiAbDTCbRhIHFIfmgaDWp5dAcwzTjwlq
         gRg/yZN6PTJY3L5gJBBOkRwcmJNkrdh3oZCdvvF/qjXSPHL1f/yi0oyDyT1MB4tbJrwN
         Y0MA==
X-Gm-Message-State: AOAM532G0rQXPdmZCWgHTq/S7EmiUoTKbaDwX1EID8x69gCQoKRFXTOm
        /eQyD6hRcEDZe8bPWtW1pE3qKMeXLGCaXelScas=
X-Google-Smtp-Source: ABdhPJy6qe1MUKPsuV7LxiFjqCsbFbKIKEB2UZTOPuW3Dcamfn8X/ul9exGZS2q20v7bOMbLdBzskUhS7skjF9YSLqQ=
X-Received: by 2002:a2e:f02:: with SMTP id 2mr1487705ljp.112.1629175865253;
 Mon, 16 Aug 2021 21:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210817010310.2300741-1-fallentree@fb.com> <20210817010310.2300741-5-fallentree@fb.com>
 <CAEf4Bza73q02zj_O6RNNF9HaQfLWajOFJgZXrztDvAZFV8n8Ug@mail.gmail.com>
In-Reply-To: <CAEf4Bza73q02zj_O6RNNF9HaQfLWajOFJgZXrztDvAZFV8n8Ug@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Mon, 16 Aug 2021 21:50:38 -0700
Message-ID: <CAJygYd0ojV0r1WrXtcQMDYzoE8gk742Pmdo275e14raiLifE2g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/4] selftests/bpf: Support glob matching for
 test selector.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 7:45 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 16, 2021 at 6:03 PM Yucong Sun <fallentree@fb.com> wrote:
> >
> > This patch adds '-a' and '-d' arguments, supporting exact string match, as well
> > as using '*' wildcard in test/subtests selection. The old '-t' '-b' arguments
> > still supports partial string match, but they can't be used together yet.
>
> typo: support
>
> >
> > Caveat: As same as the current substring matching mechanism, test and subtest
>
> "Same as"
>
> > selector applies independently, 'a*/b*' will execute all tests matches "a*",
>
> s/matches/matching/ same below
>
> > and with subtest name matches "b*", but tests matches "a*" but has no subtests
> > will also be executed.
> >
> > Signed-off-by: Yucong Sun <fallentree@fb.com>
> > ---
> >  tools/testing/selftests/bpf/test_progs.c | 64 +++++++++++++++++++++---
> >  tools/testing/selftests/bpf/test_progs.h |  1 +
> >  2 files changed, 57 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> > index 90539b15b744..f5dbaa29d370 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -13,6 +13,28 @@
> >  #include <execinfo.h> /* backtrace */
> >  #include <linux/membarrier.h>
> >
> > +/* Adapted from perf/util/string.c */
> > +static bool glob_match(const char *str, const char *pat)
> > +{
> > +       while (*str && *pat && *pat != '*') {
> > +               if (*str != *pat)
> > +                       return false;
> > +               str++;
> > +               pat++;
> > +       }
> > +       /* Check wild card */
> > +       if (*pat == '*') {
> > +               while (*pat == '*')
> > +                       pat++;
> > +               if (!*pat) /* Tail wild card matches all */
> > +                       return true;
> > +               while (*str)
> > +                       if (glob_match(str++, pat))
> > +                               return true;
> > +       }
> > +       return !*str && !*pat;
> > +}
> > +
> >  #define EXIT_NO_TEST           2
> >  #define EXIT_ERR_SETUP_INFRA   3
> >
> > @@ -55,12 +77,12 @@ static bool should_run(struct test_selector *sel, int num, const char *name)
> >         int i;
> >
> >         for (i = 0; i < sel->blacklist.cnt; i++) {
> > -               if (strstr(name, sel->blacklist.strs[i]))
> > +               if (glob_match(name, sel->blacklist.strs[i]))
> >                         return false;
> >         }
> >
> >         for (i = 0; i < sel->whitelist.cnt; i++) {
> > -               if (strstr(name, sel->whitelist.strs[i]))
> > +               if (glob_match(name, sel->whitelist.strs[i]))
> >                         return true;
> >         }
> >
> > @@ -450,6 +472,8 @@ enum ARG_KEYS {
> >         ARG_VERBOSE = 'v',
> >         ARG_GET_TEST_CNT = 'c',
> >         ARG_LIST_TEST_NAMES = 'l',
> > +       ARG_TEST_NAME_GLOB_ALLOWLIST = 'a',
> > +       ARG_TEST_NAME_GLOB_DENYLIST = 'd',
> >  };
> >
> >  static const struct argp_option opts[] = {
> > @@ -467,6 +491,10 @@ static const struct argp_option opts[] = {
> >           "Get number of selected top-level tests " },
> >         { "list", ARG_LIST_TEST_NAMES, NULL, 0,
> >           "List test names that would run (without running them) " },
> > +       { "allow", ARG_TEST_NAME_GLOB_ALLOWLIST, "NAMES", 0,
> > +         "Run tests with name matching the pattern (support *)." },
> > +       { "deny", ARG_TEST_NAME_GLOB_DENYLIST, "NAMES", 0,
> > +         "Don't run tests with name matching the pattern (support *)." },
> >         {},
> >  };
> >
> > @@ -491,7 +519,7 @@ static void free_str_set(const struct str_set *set)
> >         free(set->strs);
> >  }
> >
> > -static int parse_str_list(const char *s, struct str_set *set)
> > +static int parse_str_list(const char *s, struct str_set *set, bool is_glob_pattern)
> >  {
> >         char *input, *state = NULL, *next, **tmp, **strs = NULL;
> >         int cnt = 0;
> > @@ -508,8 +536,14 @@ static int parse_str_list(const char *s, struct str_set *set)
> >                 if (!tmp)
> >                         goto err;
> >                 strs = tmp;
> > +               if (is_glob_pattern)
> > +                       strs[cnt] = strdup(next);
>
> coding style: if one branch of if/else uses {}, the other has to use it as well
>
> > +               else {
> > +                       char* pat = malloc(strlen(next) + 2 + 1);
>
> coding style: empty line after variable declaration (but I'd just use
> strs[cnt] twice without extra var)
>
> also `char *pat`, please use checkpatch.pl to double check your
> changes until kernel code style becomes second nature (and even then
> it's probably useful to run it from time to time). We do have few
> errors reported in test_progs.c, but the script would reported 2 out
> of 3 of these problems. At some point we should see if it makes sense
> to run checkpatch.pl as one of BPF CI steps.

Sorry, done!

>
> > +                       sprintf(pat, "*%s*", next);
> > +                       strs[cnt] = pat;
> > +               }
> >
> > -               strs[cnt] = strdup(next);
> >                 if (!strs[cnt])
> >                         goto err;
> >
> > @@ -553,29 +587,43 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
> >                 }
> >                 break;
> >         }
> > +       case ARG_TEST_NAME_GLOB_ALLOWLIST:
> >         case ARG_TEST_NAME: {
> > +               if (env->test_selector.whitelist.cnt || env->subtest_selector.whitelist.cnt) {
> > +                       fprintf(stderr, "-a and -t are mutually exclusive, you can only specify one.\n");
> > +                       return -EINVAL;
> > +               }
>
> Why are they still exclusive? They are now just alternative ways to
> specify the same set of filters, one as substring match, another as
> explicit globs. Just like you can use '-t a,b', you can also have '-t
> a -a "*b*"', right? They can totally co-exist and it might be useful
> to use both sometimes.

I added the logic to accept multiple -a -d -t -d switches as requested.

>
> >                 char *subtest_str = strchr(arg, '/');
> >
> >                 if (subtest_str) {
> >                         *subtest_str = '\0';
> >                         if (parse_str_list(subtest_str + 1,
> > -                                          &env->subtest_selector.whitelist))
> > +                                          &env->subtest_selector.whitelist,
> > +                                          key == ARG_TEST_NAME_GLOB_ALLOWLIST))
> >                                 return -ENOMEM;
> >                 }
> > -               if (parse_str_list(arg, &env->test_selector.whitelist))
> > +               if (parse_str_list(arg, &env->test_selector.whitelist,
> > +                                  key == ARG_TEST_NAME_GLOB_ALLOWLIST))
> >                         return -ENOMEM;
> >                 break;
> >         }
> > +       case ARG_TEST_NAME_GLOB_DENYLIST:
> >         case ARG_TEST_NAME_BLACKLIST: {
> > +               if (env->test_selector.blacklist.cnt || env->subtest_selector.blacklist.cnt) {
> > +                       fprintf(stderr, "-d and -b are mutually exclusive, you can only specify one.\n");
> > +                       return -EINVAL;
> > +               }
>
> same, they can organically co-exist
>
> >                 char *subtest_str = strchr(arg, '/');
> >
> >                 if (subtest_str) {
> >                         *subtest_str = '\0';
> >                         if (parse_str_list(subtest_str + 1,
> > -                                          &env->subtest_selector.blacklist))
> > +                                          &env->subtest_selector.blacklist,
> > +                                          key == ARG_TEST_NAME_GLOB_DENYLIST))
> >                                 return -ENOMEM;
> >                 }
> > -               if (parse_str_list(arg, &env->test_selector.blacklist))
> > +               if (parse_str_list(arg, &env->test_selector.blacklist,
> > +                                  key == ARG_TEST_NAME_GLOB_DENYLIST))
> >                         return -ENOMEM;
> >                 break;
> >         }
> > diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
> > index c8c2bf878f67..c475d65dce4f 100644
> > --- a/tools/testing/selftests/bpf/test_progs.h
> > +++ b/tools/testing/selftests/bpf/test_progs.h
> > @@ -49,6 +49,7 @@ enum verbosity {
> >  struct str_set {
> >         const char **strs;
> >         int cnt;
> > +       bool is_glob_pattern;
>
>
> leftovers? doesn't seem to be used

Deleted.

>
> >  };
> >
> >  struct test_selector {
> > --
> > 2.30.2
> >
