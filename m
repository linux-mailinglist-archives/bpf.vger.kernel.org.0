Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA341E6995
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 20:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405896AbgE1SkE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 14:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405845AbgE1SkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 14:40:03 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12FC08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:40:02 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb16so13435990qvb.5
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mjBp2b2wb8hw/jyu/3PKGEVyTSa6ovxRfN4lgSREqc=;
        b=nuFN5M+GsgzB8+rqt3VHG/4WgnHFcHkTQ2fdswyWFp2w11TGvm1ohx2BgXCcjICjsc
         auG1Q5cMTe1WIYUdCN86LgQR7SiFwy/ZIju91DnIYn4mujusGInhMbfjNGWi4DXT4hAy
         2F+3BCfC7tsxssxJg32lzDsdkCob6ey9es6dHlCBAPyh20xNVZTfRa7tzaCWBssRDUaX
         jdCH0T+PK8+K/+rrjsGVfk9OSxTPh817Wqr5DrNpKhb7znJjTsjkSkFFcXyV5RkBvd/t
         H23yxK3Vj2r/t5dWCllKZgI3nS+86yHIaz94P0FGvPsFg+g+obQan5M+2Js+wh1Hhc/S
         OBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mjBp2b2wb8hw/jyu/3PKGEVyTSa6ovxRfN4lgSREqc=;
        b=dxMsesFzTBz9OPDrGai0aoVRt+0/1CuvAlEjWKXFLLhEHJ3rz272NsjKV59726a3aO
         BV1I3XtIygFjOWAn+MrW3nyQ8myogyJU39RLccR2e/APblSqs8pYv+POib9fngYCQVrx
         cI1Zrj2L+rcxfqJhn3ireLHzxaHO4Xfk7FgPADYbbi3hIsmVlOeWa00wUs4aiAjkwLSg
         UcKvSvEHgixLUfx6HvuVXc3PijZxDG9tW1GosYIjDnpALC14irxqhcU23wew+qLsat8p
         mFbZmb5UcXAdnayrcijk/HyvxsrWTJGCkAoSKgbe1/mHouYCFxTw/ZQ29GJLz9NVh5GC
         2Neg==
X-Gm-Message-State: AOAM531bV+Rq0+QLkPoKLDMGBc2rbOP4Zvq852342Wgkdu82G/Eh0kLp
        3L+FZ5/hP5NDv8xdf+5teyGbqNU6juROk6TZ5kw=
X-Google-Smtp-Source: ABdhPJxgSceKNtkiGL2q+mxp3AxRQVi/IOHKmU7kwRwOnamQYUSkk1lzSxA3zkUSRu+A90sHFkZHTPid+leEwnnI6r8=
X-Received: by 2002:a0c:a9c6:: with SMTP id c6mr4585767qvb.224.1590691201383;
 Thu, 28 May 2020 11:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
 <20200522041310.233185-5-yauheni.kaliuta@redhat.com> <CAEf4BzZN=cMSFtinNOHMkDhposYPeHqgtJSwnpFSnQ2bX8BfyA@mail.gmail.com>
 <xunyeer6ot1f.fsf@redhat.com>
In-Reply-To: <xunyeer6ot1f.fsf@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 May 2020 11:39:50 -0700
Message-ID: <CAEf4BzbgGnJ8d+q5KyjdXYMHFOoyi7UJpKWLS1t_oNh2dhKy+g@mail.gmail.com>
Subject: Re: [PATCH 4/8] selftests/bpf: fix object files installation
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 26, 2020 at 10:17 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii!
>
> >>>>> On Tue, 26 May 2020 15:30:19 -0700, Andrii Nakryiko  wrote:
>
>  > On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >>
>  >> There are problems with bpf test programs object files:
>  >>
>  >> 1) some of them are build for flavored test runner and should be
>  >> installed in the subdirectory;
>  >> 2) it's possible that the same file mentioned several times (added
>  >> for every different unflavored test runner);
>  >> 3) some generated files are not treated properly.
>  >>
>  >> Fix 1) by adding subdirectory to the list. rsync -a in the install
>  >> target will handle it.
>  >>
>  >> Fix 2) by filtering the list. Performance should not matter for such
>  >> amount of files.
>  >>
>  >> Fix 3) by use proper (TEST_GEN_FILES) variable for the list.
>  >>
>  >> Fixes: 309b81f0fdc4 ("selftests/bpf: Install generated test progs")
>  >> Fixes: e47a179997ce ("bpf, testing: Add missing object file to
>  >> TEST_FILES")
>  >>
>  >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
>  >> ---
>  >> tools/testing/selftests/bpf/Makefile | 9 ++++++---
>  >> 1 file changed, 6 insertions(+), 3 deletions(-)
>  >>
>  >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>  >> index 19091dbc8ca4..1ba3d72c3261 100644
>  >> --- a/tools/testing/selftests/bpf/Makefile
>  >> +++ b/tools/testing/selftests/bpf/Makefile
>  >> @@ -42,8 +42,7 @@ ifneq ($(BPF_GCC),)
>  >> TEST_GEN_PROGS += test_progs-bpf_gcc
>  >> endif
>  >>
>  >> -TEST_GEN_FILES =
>  >> -TEST_FILES = test_lwt_ip_encap.o \
>  >> +TEST_GEN_FILES = test_lwt_ip_encap.o \
>  >> test_tc_edt.o
>  >>
>  >> BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
>  >> @@ -273,7 +272,11 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
>  >> TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,      \
>  >> $$(filter-out $(SKEL_BLACKLIST),       \
>  >> $$(TRUNNER_BPF_SRCS)))
>  >> -TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
>  >> +
>  >> +TO_ADD := $(if $2,$$(TRUNNER_OUTPUT),$$(TRUNNER_BPF_OBJS))
>  >> +$$(foreach i,$$(TO_ADD),\
>  >> +       $$(eval \
>  >> +               TEST_GEN_FILES += $$(if $$(filter $$i,$$(TEST_GEN_FILES)),,$$i)))
>
>  > This makes me cringe. Can we not have three levels of nested
>  > evals, please? I also didn't get exactly what's the problem
>  > you are trying to solve, could you give some example, please?
>
> It's sort of `unique` functionality.

`unique` in make world is just $(sort $VAR). Isn't that a more
light-weight and generic way to avoid duplicates in lib.mk?

>
> With the current approach TEST_GEN_FILES has at least 2 copies of
> an object file (for call test_progs and test_maps) which is both
> inaccurate and increasing the length of the variable (even if
> copying the same file should not cause problems).
>
>
> (Without sub-directory handling it's even overwritten by
> flavoured binaries in between).
>
> BTW, how would you like to change $(call ...) with $(value ...)?
> It will get rid of one level of indirection but requires
> rule-specific variables for rule generation, since some
> evaluations are done in recipies.

I don't exactly understand the implications, so don't know. But the
less changes to this Makefile, the happier I am, so... :)

>
>  >>
>  >> # Evaluate rules now with extra TRUNNER_XXX variables above already defined
>  >> $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
>  >> --
>  >> 2.26.2
>  >>
>
>
> --
> WBR,
> Yauheni Kaliuta
>
