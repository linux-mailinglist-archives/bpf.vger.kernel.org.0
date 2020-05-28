Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3800C1E69B6
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405964AbgE1SrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 14:47:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25342 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405901AbgE1SrA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 May 2020 14:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590691617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PWJqP/HCf/c2Ghf4DKArS8KnR6WQQ0V92J/bZb88PA=;
        b=HFP8nMEqQd+kGA85V5uOloTPXgs+0H2v0HDi0M6tkUmCAbaYocFCD2S2vNcYznUw/1sQ1A
        tRuYXk5cky8ShtDcvtooSJA22HCnK7EG9ShOr3t7pDLo/c99I8imNTTUpGuJ0+27keNkzO
        WRL2rnhd8/uppyS2p9llLhEliVMidxM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-IF5bf1ehPmaAr0rD8urP4Q-1; Thu, 28 May 2020 14:46:54 -0400
X-MC-Unique: IF5bf1ehPmaAr0rD8urP4Q-1
Received: by mail-oi1-f199.google.com with SMTP id w196so497981oia.12
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 11:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PWJqP/HCf/c2Ghf4DKArS8KnR6WQQ0V92J/bZb88PA=;
        b=H3bB+/OYHl7lGTaF46xXqjnrve19YvVqtQZNoZYatRoXwyfi2sOgO5NfcEYTeC/iu2
         Sa5oMxfITEP+uPwrSUAtedyDqtivBcSbwmqgF23VJtuqcDj1uq876EbiQBAMqACkMVCP
         UjPKYG9o1yz5c6lisR//qMV0LdZXdHuTHjOduUzhqXcDlNfLCgk1/BPFcAG5hXhSBn+8
         A7GrNLhBJ2yebbdg3gM5aC3ZUPQuuZrIXDlGx4MB47m3o3vCq62BlEu5dWxt0RUIrdsW
         XGsdsZtcuIckmes0GFEdXYDVJI9ib8BP+5fb8GkZDbDuEO73r5rIAa+IeWwXnJLmnL4B
         xkAg==
X-Gm-Message-State: AOAM531NqOlePTxXzfkGD11rI9tvNq5TerxA6Twt6USvXK2+kjhISdV8
        oWzTNoWoKUtjFleuXGItdFjIL/UNfQlDrNdZlRITh/EDU5kjthShfEjN76TkJb0OrMwMJe81APS
        SnYMlHhDan/g6GRKIHzVu5if4nzIa
X-Received: by 2002:a9d:65cc:: with SMTP id z12mr3328780oth.37.1590691613852;
        Thu, 28 May 2020 11:46:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdku0ONiHHrYOdKY3J5BAI3BU6VdmJOsK336yPVRPdM3vC6HrjjjGFzL1YaD/wGl2c1qw8mAE5ryjdqrXKgd0=
X-Received: by 2002:a9d:65cc:: with SMTP id z12mr3328758oth.37.1590691613469;
 Thu, 28 May 2020 11:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
 <20200522041310.233185-5-yauheni.kaliuta@redhat.com> <CAEf4BzZN=cMSFtinNOHMkDhposYPeHqgtJSwnpFSnQ2bX8BfyA@mail.gmail.com>
 <xunyeer6ot1f.fsf@redhat.com> <CAEf4BzbgGnJ8d+q5KyjdXYMHFOoyi7UJpKWLS1t_oNh2dhKy+g@mail.gmail.com>
In-Reply-To: <CAEf4BzbgGnJ8d+q5KyjdXYMHFOoyi7UJpKWLS1t_oNh2dhKy+g@mail.gmail.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 28 May 2020 21:46:37 +0300
Message-ID: <CANoWswmmjKmC8L8Fo27cUzGAF_vhWBgY52PForTfsffir7Qpyg@mail.gmail.com>
Subject: Re: [PATCH 4/8] selftests/bpf: fix object files installation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 9:40 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 26, 2020 at 10:17 PM Yauheni Kaliuta
> <yauheni.kaliuta@redhat.com> wrote:
> >
> > Hi, Andrii!
> >
> > >>>>> On Tue, 26 May 2020 15:30:19 -0700, Andrii Nakryiko  wrote:
> >
> >  > On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
> >  > <yauheni.kaliuta@redhat.com> wrote:
> >  >>
> >  >> There are problems with bpf test programs object files:
> >  >>
> >  >> 1) some of them are build for flavored test runner and should be
> >  >> installed in the subdirectory;
> >  >> 2) it's possible that the same file mentioned several times (added
> >  >> for every different unflavored test runner);
> >  >> 3) some generated files are not treated properly.
> >  >>
> >  >> Fix 1) by adding subdirectory to the list. rsync -a in the install
> >  >> target will handle it.
> >  >>
> >  >> Fix 2) by filtering the list. Performance should not matter for such
> >  >> amount of files.
> >  >>
> >  >> Fix 3) by use proper (TEST_GEN_FILES) variable for the list.
> >  >>
> >  >> Fixes: 309b81f0fdc4 ("selftests/bpf: Install generated test progs")
> >  >> Fixes: e47a179997ce ("bpf, testing: Add missing object file to
> >  >> TEST_FILES")
> >  >>
> >  >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> >  >> ---
> >  >> tools/testing/selftests/bpf/Makefile | 9 ++++++---
> >  >> 1 file changed, 6 insertions(+), 3 deletions(-)
> >  >>
> >  >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >  >> index 19091dbc8ca4..1ba3d72c3261 100644
> >  >> --- a/tools/testing/selftests/bpf/Makefile
> >  >> +++ b/tools/testing/selftests/bpf/Makefile
> >  >> @@ -42,8 +42,7 @@ ifneq ($(BPF_GCC),)
> >  >> TEST_GEN_PROGS += test_progs-bpf_gcc
> >  >> endif
> >  >>
> >  >> -TEST_GEN_FILES =
> >  >> -TEST_FILES = test_lwt_ip_encap.o \
> >  >> +TEST_GEN_FILES = test_lwt_ip_encap.o \
> >  >> test_tc_edt.o
> >  >>
> >  >> BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
> >  >> @@ -273,7 +272,11 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
> >  >> TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,      \
> >  >> $$(filter-out $(SKEL_BLACKLIST),       \
> >  >> $$(TRUNNER_BPF_SRCS)))
> >  >> -TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
> >  >> +
> >  >> +TO_ADD := $(if $2,$$(TRUNNER_OUTPUT),$$(TRUNNER_BPF_OBJS))
> >  >> +$$(foreach i,$$(TO_ADD),\
> >  >> +       $$(eval \
> >  >> +               TEST_GEN_FILES += $$(if $$(filter $$i,$$(TEST_GEN_FILES)),,$$i)))
> >
> >  > This makes me cringe. Can we not have three levels of nested
> >  > evals, please? I also didn't get exactly what's the problem
> >  > you are trying to solve, could you give some example, please?
> >
> > It's sort of `unique` functionality.
>
> `unique` in make world is just $(sort $VAR). Isn't that a more
> light-weight and generic way to avoid duplicates in lib.mk?

Oh, my bad, totally forgot it. Sure! Thanks!

>
> >
> > With the current approach TEST_GEN_FILES has at least 2 copies of
> > an object file (for call test_progs and test_maps) which is both
> > inaccurate and increasing the length of the variable (even if
> > copying the same file should not cause problems).
> >
> >
> > (Without sub-directory handling it's even overwritten by
> > flavoured binaries in between).
> >
> > BTW, how would you like to change $(call ...) with $(value ...)?
> > It will get rid of one level of indirection but requires
> > rule-specific variables for rule generation, since some
> > evaluations are done in recipies.
>
> I don't exactly understand the implications, so don't know. But the
> less changes to this Makefile, the happier I am, so... :)

So, no way ;)

It would be relatively many changes, but more simple code without extra $$.

>
> >
> >  >>
> >  >> # Evaluate rules now with extra TRUNNER_XXX variables above already defined
> >  >> $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
> >  >> --
> >  >> 2.26.2
> >  >>
> >
> >
> > --
> > WBR,
> > Yauheni Kaliuta
> >
>


-- 
WBR, Yauheni

