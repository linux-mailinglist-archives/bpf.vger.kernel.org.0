Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5077243A4E0
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 22:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhJYUlu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhJYUlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 16:41:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892DC061348
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:39:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b9so29175482ybc.5
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+x53/PZweOJT2an76Lhzk+na+OzBM4p4LNLJHtZe+Zg=;
        b=GxytfKCPHOxOBCUSU5Uwwu1kF6y7t73CoNfMxlIIH0eRGLoemjTfANGitGtmg8UgUl
         JLokvlggXFcymOtnoNye8ilPf/e6M6iy8O5CfuSmQTm0L74qjlctg9BuFf6WA596hKOL
         1AQTz6YnJBjub0vNKoFSqiuxC0XQTIQBRxTZMHEGRJQ9Wz/1zid8rx68cAwcOF1AOCup
         xKTx3X5l9qNUHhtAo/RJO6wyXOVuymySzPRNSnhene/IP+hjhSc1Zx+3XHkD1z1Iw6TP
         ajlofhzRVMC3Y04+Mds110odwUjLelQySw+sEyDScxW9PKRLIb0fwi2QQdd9gleqxmsl
         Tj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+x53/PZweOJT2an76Lhzk+na+OzBM4p4LNLJHtZe+Zg=;
        b=cbkUhz9cQBcq1JAp1iMC8YvycF5tWjLPlhW34wx6CqDYu7gBMFKFS+qljqz55TBlRc
         KAhbAvABlSCEXWVeAt4ot8E3NEQ/SBeXdn7k/UYdYYvCP0BJnhpGWNyzyhSpM1hCx7SM
         UPpGKZp6QjHQguwB0pa/iiJTjSPl5GVOulwFo/SqDNj41Q8qDMPOseoVEsouudKBoyhL
         MvfMeaj1bnY/QrZJdkJrVQUTRP6PPDqLBvbTkze1tl13ORqY/G3Crk7JtzKn/t1HPm4I
         /2UIyj+nuah59tZFjzSEOfXwH4PRUo+phAZaqEiqn5ajkFMeqkvujNj/+qKhbM9rZdZE
         0iHw==
X-Gm-Message-State: AOAM5305aVEjZZ74PkpiWzI7j7RcbzVx9p26Z14rBkuuWuYWlMeJMoV2
        9rfTQrkLlN0cbnX7PbRKOZyXbJM8et8qoTPTzKE=
X-Google-Smtp-Source: ABdhPJy7WeHUjJx/Eqoq9NWGx+vyZbh2JRpDogttnyqbqGvqSrzwNGUY+TgcMobLDKjQkEXeOA1h+ojVDtgz/3BRLcw=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr20584509ybj.504.1635194365889;
 Mon, 25 Oct 2021 13:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211022223228.99920-1-andrii@kernel.org> <20211022223228.99920-3-andrii@kernel.org>
 <CAJygYd1qr5yi0i0wfPuz4yBj61TjcXqBRWKoLUa=XkUp+7g1Vg@mail.gmail.com>
In-Reply-To: <CAJygYd1qr5yi0i0wfPuz4yBj61TjcXqBRWKoLUa=XkUp+7g1Vg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 13:39:14 -0700
Message-ID: <CAEf4BzZ3_COLB32D7oktOPKBGzU3LZ7N=Bd-H-Lf0KWb-Qc7NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: support multiple tests per file
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 1:13 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Fri, Oct 22, 2021 at 3:33 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Revamp how test discovery works for test_progs and allow multiple test
> > entries per file. Any global void function with no arguments and
> > serial_test_ or test_ prefix is considered a test.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 498222543c37..ac47cf9760fc 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -421,10 +421,9 @@ ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
> >  $(TRUNNER_TESTS_DIR)-tests-hdr := y
> >  $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
> >         $$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
> > -       $$(shell ( cd $(TRUNNER_TESTS_DIR);                             \
> > -                 echo '/* Generated header, do not edit */';           \
> > -                 ls *.c 2> /dev/null |                                 \
> > -                       sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';      \
> > +       $$(shell (echo '/* Generated header, do not edit */';                                   \
> > +                 sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'     \
>
> probably not that important :  allow \s* before void and after void.
> Or,  maybe we can just  (?!static)  instead of anchoring to line
> start.

Selftests source code is pretty strict with formatting, so I don't
think we'll deviate from the strict `^void <name>` pattern (and we
certainly don't want to deviate). So I didn't want to overcomplicate
regexes unnecessarily.

>
> > +                       $(TRUNNER_TESTS_DIR)/*.c | sort ;       \
>
> to be super safe : maybe add a check here to ensure each file contains
> at least one test function.

It's actually a useful property to have .c files that don't have
tests. This can be used for adding various shared helpers. Currently
all *_helpers.c are in selftests/bpf/ directory and have to be
explicitly wired in Makefile, which is a bit annoying. With this setup
we can just put a new .c file in the selftests/bpf/prog_tests/ and it
will be automatically compiled and linked.

It also will significantly hurt readability to add some sort of
per-file check in there, do you think it's worth it?

>
> >                  ) > $$@)
> >  endif
> >
> > --
> > 2.30.2
> >
