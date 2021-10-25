Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABA543A527
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 22:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhJYU63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhJYU61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 16:58:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B5C061745
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:56:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 65so10358356ljf.9
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USyQCAwnVpfrQy5qb2RoSXJSCIXJaXwpovwGbyAm9Vg=;
        b=MgkVecsSHFR+C5RN2+Lim2/bx63FD7+Iy00D44KSooRHVPj0zvMhEZxWKZsmtQAJXH
         110k4lSVVKlm6yXmLv1MrJXk9SonF+pLcHl9azcB6NEKOhJD1gxaSephQ8dmSKzUjZTg
         Umx0llfz/TNkE+o+8i+n2/vf2dYIlEyyYg3gDijtwtrx2RyorMi+m+W1hFp0yD0InyQ8
         mzrdQvT4AL/efjSb9jMmUm7Y6e7zDWcq0d0Fxp5YquuPT5M9rlAhawU6d2JjbHZkEixK
         Et4mx0Q0VDhWjMGuWTxKApCsUrqgJJNj8qiVuRoUiZnj2MUf7Cst/yT5bG4w1OkhDTQH
         W2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USyQCAwnVpfrQy5qb2RoSXJSCIXJaXwpovwGbyAm9Vg=;
        b=Uxcoh5tCWMxqplFgjuWr8U7WQvsKdpd3xYiWqVTosoxjjNQ6Xv55z+jz7D96dky9N8
         8A1/za7Ev4pgW2V/YuK+RdlOWclipRQshRbHm2V4wNZW+ANeRe6vz9peWUsSvSNvJLQ7
         hMVpql3SeyriYL8hHmlqczFBHQJt2XwJxB6tabDMM5S7SPIIT9H7QhNlsrnrcQI0ImKi
         S2axmriNSL3c4N/019vu8ikfAFwLx6dqUmdBtm91B0Ijk3qHnUI1hFTmq/LCHO18aH8f
         sVaub4Khkvkv2TxBjC6vhwemzNxgmYeeck67YDHttXgn4M9HQbmwPQLmHgnCg+4zTULP
         IEqQ==
X-Gm-Message-State: AOAM531gCRLXAsPqvlbf/WMutOmioUIUGEXSKIW59Y4VHjn0f/sCC+8x
        +6ZlwUwq5n5RDMLtLSK2YuHM38js5R1HNJHhI04=
X-Google-Smtp-Source: ABdhPJyJ1dsCDtFUfixUJPGy9dXH/Mg5SFP3q3jgnEQliT32VVo10SGuhO/PM1pG2YOhe5DCh+3mUTVN16ndTE6NbdE=
X-Received: by 2002:a05:651c:2128:: with SMTP id a40mr21412651ljq.148.1635195361897;
 Mon, 25 Oct 2021 13:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211022223228.99920-1-andrii@kernel.org> <20211022223228.99920-3-andrii@kernel.org>
 <CAJygYd1qr5yi0i0wfPuz4yBj61TjcXqBRWKoLUa=XkUp+7g1Vg@mail.gmail.com> <CAEf4BzZ3_COLB32D7oktOPKBGzU3LZ7N=Bd-H-Lf0KWb-Qc7NA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ3_COLB32D7oktOPKBGzU3LZ7N=Bd-H-Lf0KWb-Qc7NA@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Mon, 25 Oct 2021 13:55:35 -0700
Message-ID: <CAJygYd1ctJpaNmL8eyGs66UpFCrSdRo7SQZbnpUnpMufKfcnug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: support multiple tests per file
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 1:39 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 1:13 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> >
> > On Fri, Oct 22, 2021 at 3:33 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > Revamp how test discovery works for test_progs and allow multiple test
> > > entries per file. Any global void function with no arguments and
> > > serial_test_ or test_ prefix is considered a test.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/Makefile | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > index 498222543c37..ac47cf9760fc 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -421,10 +421,9 @@ ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
> > >  $(TRUNNER_TESTS_DIR)-tests-hdr := y
> > >  $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
> > >         $$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
> > > -       $$(shell ( cd $(TRUNNER_TESTS_DIR);                             \
> > > -                 echo '/* Generated header, do not edit */';           \
> > > -                 ls *.c 2> /dev/null |                                 \
> > > -                       sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';      \
> > > +       $$(shell (echo '/* Generated header, do not edit */';                                   \
> > > +                 sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'     \
> >
> > probably not that important :  allow \s* before void and after void.
> > Or,  maybe we can just  (?!static)  instead of anchoring to line
> > start.
>
> Selftests source code is pretty strict with formatting, so I don't
> think we'll deviate from the strict `^void <name>` pattern (and we
> certainly don't want to deviate). So I didn't want to overcomplicate
> regexes unnecessarily.
>
> >
> > > +                       $(TRUNNER_TESTS_DIR)/*.c | sort ;       \
> >
> > to be super safe : maybe add a check here to ensure each file contains
> > at least one test function.
>
> It's actually a useful property to have .c files that don't have
> tests. This can be used for adding various shared helpers. Currently
> all *_helpers.c are in selftests/bpf/ directory and have to be
> explicitly wired in Makefile, which is a bit annoying. With this setup
> we can just put a new .c file in the selftests/bpf/prog_tests/ and it
> will be automatically compiled and linked.
>
> It also will significantly hurt readability to add some sort of
> per-file check in there, do you think it's worth it?

You are right, probably not really worth it. we just have to watch the
total test numbers, it should always goes up :-D

>
> >
> > >                  ) > $$@)
> > >  endif
> > >
> > > --
> > > 2.30.2
> > >
