Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF4F43A587
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 23:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhJYVLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 17:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhJYVLj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 17:11:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B2C061348
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:09:17 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v7so29554924ybq.0
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMOs6cxMHZeY7p7bnLVrVa+nRYtiWwqokE5opzamm5s=;
        b=qSOuZF0SKslyezv3ziYUivJgvvV5MqNlrELCCyjObUDtajwbaRdXuDEeS0gzWK6RVv
         kaXKVeeo5VAttaOVOammEDiQHMnc0vMjShI2qD/Qx0V05Br087dZFVAZfATJe8+1nxL0
         gfHvxNE0wWebxzsftiI/4yv+v0Hvx+8BhF6y3W/87MPRuDXhoqNj/odWgFYUUnmCTNbd
         0FHfnV+kRZOlMAILuQd4hOM+xNVXY+GtUgumwq2r4gKV3fTNZXKc4iWaiMp8Vo2bT8Bf
         fKdu8AxnI7ewxYsqwrByBQmZ3nIXwQAaPTU+DYSkAxMrmw5LywF84yiWThYbylAsxIug
         TzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMOs6cxMHZeY7p7bnLVrVa+nRYtiWwqokE5opzamm5s=;
        b=28N2+m1+W18aJlOOPIN5/2OjjCDjHNVSxv+6N9SthZftfCctm+dpBbdYAlb+oPSq2g
         Swjmo69e18t2Nf5XxG/wukrjLV8VdUkdjeJEP2C3V+Qory2hQfbqBPRbaL7rPW91wikW
         df398+X+shf+K7VZRTLPdi83zgsiLkTSjwobTpEzkCufME2ZW5VbNNTb3pysanJZZKkS
         qpgB1m3pbExl316L3CnDNfmNuBqUXq4PhntGxJKMuVID+KSqfOpltmhEDu5V8K7xFeeU
         W75xO4CK1zNkpTQICRZG83IqYlqjdzOI/PCBgGx33pHzWfWyEFFqvaED2Yn/3VN57cZZ
         Gfvg==
X-Gm-Message-State: AOAM530gCHdeAU1uppf5GElyOCtoevce0bmzwsm6R7CkNF9ZB6VRNfq2
        nqpbbN01Xw1nEk2WaT3c3kGWUNbrRU8g6Lv84iQ=
X-Google-Smtp-Source: ABdhPJwfHm+EQ5md579aZoNLdY/sGMU3AriFORSuQub+hP34o4wAIepuNtmwct+09J6si10PcPKBj6BVkL/L1hGGtkQ=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr20745586ybj.504.1635196156332;
 Mon, 25 Oct 2021 14:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211022223228.99920-1-andrii@kernel.org> <20211022223228.99920-3-andrii@kernel.org>
 <CAJygYd1qr5yi0i0wfPuz4yBj61TjcXqBRWKoLUa=XkUp+7g1Vg@mail.gmail.com>
 <CAEf4BzZ3_COLB32D7oktOPKBGzU3LZ7N=Bd-H-Lf0KWb-Qc7NA@mail.gmail.com> <CAJygYd1ctJpaNmL8eyGs66UpFCrSdRo7SQZbnpUnpMufKfcnug@mail.gmail.com>
In-Reply-To: <CAJygYd1ctJpaNmL8eyGs66UpFCrSdRo7SQZbnpUnpMufKfcnug@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 14:09:05 -0700
Message-ID: <CAEf4BzYoGY_eBP0vjb8W7VRgeZjo=49_eqFwPSeA0VwAJHKAZA@mail.gmail.com>
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

On Mon, Oct 25, 2021 at 1:56 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 1:39 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 1:13 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
> > >
> > > On Fri, Oct 22, 2021 at 3:33 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > Revamp how test discovery works for test_progs and allow multiple test
> > > > entries per file. Any global void function with no arguments and
> > > > serial_test_ or test_ prefix is considered a test.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  tools/testing/selftests/bpf/Makefile | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > > > index 498222543c37..ac47cf9760fc 100644
> > > > --- a/tools/testing/selftests/bpf/Makefile
> > > > +++ b/tools/testing/selftests/bpf/Makefile
> > > > @@ -421,10 +421,9 @@ ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
> > > >  $(TRUNNER_TESTS_DIR)-tests-hdr := y
> > > >  $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
> > > >         $$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
> > > > -       $$(shell ( cd $(TRUNNER_TESTS_DIR);                             \
> > > > -                 echo '/* Generated header, do not edit */';           \
> > > > -                 ls *.c 2> /dev/null |                                 \
> > > > -                       sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';      \
> > > > +       $$(shell (echo '/* Generated header, do not edit */';                                   \
> > > > +                 sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'     \
> > >
> > > probably not that important :  allow \s* before void and after void.
> > > Or,  maybe we can just  (?!static)  instead of anchoring to line
> > > start.
> >
> > Selftests source code is pretty strict with formatting, so I don't
> > think we'll deviate from the strict `^void <name>` pattern (and we
> > certainly don't want to deviate). So I didn't want to overcomplicate
> > regexes unnecessarily.
> >
> > >
> > > > +                       $(TRUNNER_TESTS_DIR)/*.c | sort ;       \
> > >
> > > to be super safe : maybe add a check here to ensure each file contains
> > > at least one test function.
> >
> > It's actually a useful property to have .c files that don't have
> > tests. This can be used for adding various shared helpers. Currently
> > all *_helpers.c are in selftests/bpf/ directory and have to be
> > explicitly wired in Makefile, which is a bit annoying. With this setup
> > we can just put a new .c file in the selftests/bpf/prog_tests/ and it
> > will be automatically compiled and linked.
> >
> > It also will significantly hurt readability to add some sort of
> > per-file check in there, do you think it's worth it?
>
> You are right, probably not really worth it. we just have to watch the
> total test numbers, it should always goes up :-D

Yep. We should be able to automate this once we have some sort of
baseline comparison functionality in BPF CI.

>
> >
> > >
> > > >                  ) > $$@)
> > > >  endif
> > > >
> > > > --
> > > > 2.30.2
> > > >
