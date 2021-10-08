Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885964273E3
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhJHWtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHWtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:49:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ADBC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:47:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m3so45217397lfu.2
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuumanNWkBsxYAZDXpTvk0KGVijWoy4AeMPN/jz1pKA=;
        b=YpU3x7yEF84UKP8PKcWa9HPYNF9ZkDnnG4XZ/ohbt9KeY4IeVl+HM4xKvBTUw7fj5j
         vFXMmriMmK62mtQNhxi5qFSSm5aMNYEltuslNMRTHXFXhURA7XMyIRRfLRqLnLV1L+nC
         K+iLtyDueTH40eELwm/cYVR3Dveh4lN6bG/+Qi9WLT/pTDvRfXSJMyvLE1SBUVMJvcsa
         5RYytyrkUOOEswBhbPbgxGW05CLJj7gCsAK4TH5hzw9FMhJ2hIDkAvCzEasZl/0O12m8
         eirm7BaWlclYgu38rnVJxHXM3LCwPvBN9Dkb34M+e6jWEqkb4wYwPT0qAYXg0WA8vUow
         9oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuumanNWkBsxYAZDXpTvk0KGVijWoy4AeMPN/jz1pKA=;
        b=uid40yX4wuRJuCbZe46vPGhA5EVNflD7SGPO0QsiqRp8Z43/+was6rDBysXWHfK/kV
         PPniedVpAlcXhmmJcz1rXel/eFw+oI1v1vzOXqKn3/LlWuwY/oBoyeviefwGgS8yfjCP
         dWzQLvQ8JVkouXnAzqMZr4etJDhec4e9J9UWSmk07VHw+gt0En9munjNg25d+unRWNRw
         7r0MoJ2jDyRYHJ2eAH6Bm709XviEXZh4V1sJkv+EkFe0QPjuuCpx2Jg0KtHKpiTmkYXh
         6hJe4GpwXha0RkPjS7KbBO/JEPZ9Sgo9jnkwfYEI/F3xbiQvQVsgf8C8mMbWClfIV+Sq
         OFWw==
X-Gm-Message-State: AOAM531IkP4WilsSIzcYiZ7sADQxQupacmydb+Y9r2d3DRbEJRPoO3g4
        bwCVSG+70rFYQpITGj2x1W0veRzuVVbR07I4U2g=
X-Google-Smtp-Source: ABdhPJyNnvdmCh29UYdr8uw9NoGAz2oNLJTb8ka9OuO0MM6GRsyPVjwqDfu52C1PxIgla+5b3dENBcPcVfY6ONEbnUY=
X-Received: by 2002:ac2:508b:: with SMTP id f11mr13290192lfm.239.1633733229806;
 Fri, 08 Oct 2021 15:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-10-fallentree@fb.com>
 <CAEf4BzYO+XD9Aa0o1BWfk8q4vE3Aon12bRWJjvz6RtWrT0o=WA@mail.gmail.com>
In-Reply-To: <CAEf4BzYO+XD9Aa0o1BWfk8q4vE3Aon12bRWJjvz6RtWrT0o=WA@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 8 Oct 2021 15:46:43 -0700
Message-ID: <CAJygYd39oi4UB=orVSBb_V5c6nBw6TMymq=JsbhHMsfoDOAyEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 09/14] selftests/bpf: Make uprobe tests use
 different attach functions.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, Song Liu <songliubraving@fb.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:27 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > Using same address on different processes of the same binary often fail
> > with EINVAL, this patch make these tests use distinct methods, so they
> > can run in parallel.
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/attach_probe.c | 8 ++++++--
> >  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c   | 8 ++++++--
> >  tools/testing/selftests/bpf/prog_tests/task_pt_regs.c | 8 ++++++--
> >  3 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > index 6c511dcd1465..eff36ba9c148 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> > @@ -5,6 +5,10 @@
> >  /* this is how USDT semaphore is actually defined, except volatile modifier */
> >  volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
> >
> > +static int method() {
>
> wrong style: { should be on separate line
>
> > +       return get_base_addr();
>
> there is nothing special about get_base_addr(), except that it's a
> global function in a different file and won't be inlined, while this
> method() approach has no such guarantee
>
> I've dropped this patch for now.
>
> But I'm surprised that attaching to the same uprobe few times doesn't
> work. Song, is there anything in kernel that could cause this?


libbpf: uprobe perf_event_open() failed: Invalid argument
libbpf: prog 'handle_uprobe': failed to create uprobe
'/proc/self/exe:0x144d59' perf event: Invalid argument
uprobe_subtest:FAIL:link1 unexpected error: -22

The problem only happens when several different processes of the same
binary are trying to attach uprobe on the same function. I am guessing
it is due to address space randomization ?

I traced through the code and the EINVAL is returned right after this warning

[    1.375901] ref_ctr_offset mismatch. inode: 0x55a0 offset: 0x144d59
ref_ctr_offset(old): 0x554a00 ref_ctr_offset(new): 0x0


This could be easily be reproduced by    ./test_progs -t
attach_probe,bpf_cookie,test_pt_regs -j

>
>
> > +}
> > +
> >  void test_attach_probe(void)
> >  {
> >         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> > @@ -33,7 +37,7 @@ void test_attach_probe(void)
> >         if (CHECK(base_addr < 0, "get_base_addr",
> >                   "failed to find base addr: %zd", base_addr))
> >                 return;
> > -       uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
> > +       uprobe_offset = get_uprobe_offset(&method, base_addr);
> >
> >         ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
> >         if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
> > @@ -98,7 +102,7 @@ void test_attach_probe(void)
> >                 goto cleanup;
> >
> >         /* trigger & validate uprobe & uretprobe */
> > -       get_base_addr();
> > +       method();
> >
> >         if (CHECK(skel->bss->uprobe_res != 3, "check_uprobe_res",
> >                   "wrong uprobe res: %d\n", skel->bss->uprobe_res))
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> > index 19c9f7b53cfa..5ebd8ba988e2 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> > @@ -8,6 +8,10 @@
> >  #include <test_progs.h>
> >  #include "test_bpf_cookie.skel.h"
> >
> > +static int method() {
> > +       return get_base_addr();
> > +}
> > +
> >  static void kprobe_subtest(struct test_bpf_cookie *skel)
> >  {
> >         DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> > @@ -66,7 +70,7 @@ static void uprobe_subtest(struct test_bpf_cookie *skel)
> >         ssize_t base_addr;
> >
> >         base_addr = get_base_addr();
> > -       uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
> > +       uprobe_offset = get_uprobe_offset(&method, base_addr);
> >
> >         /* attach two uprobes */
> >         opts.bpf_cookie = 0x100;
> > @@ -99,7 +103,7 @@ static void uprobe_subtest(struct test_bpf_cookie *skel)
> >                 goto cleanup;
> >
> >         /* trigger uprobe && uretprobe */
> > -       get_base_addr();
> > +       method();
> >
> >         ASSERT_EQ(skel->bss->uprobe_res, 0x100 | 0x200, "uprobe_res");
> >         ASSERT_EQ(skel->bss->uretprobe_res, 0x1000 | 0x2000, "uretprobe_res");
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> > index 37c20b5ffa70..4d2f1435be90 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> > @@ -3,6 +3,10 @@
> >  #include <test_progs.h>
> >  #include "test_task_pt_regs.skel.h"
> >
> > +static int method() {
> > +       return get_base_addr();
> > +}
> > +
> >  void test_task_pt_regs(void)
> >  {
> >         struct test_task_pt_regs *skel;
> > @@ -14,7 +18,7 @@ void test_task_pt_regs(void)
> >         base_addr = get_base_addr();
> >         if (!ASSERT_GT(base_addr, 0, "get_base_addr"))
> >                 return;
> > -       uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
> > +       uprobe_offset = get_uprobe_offset(&method, base_addr);
> >
> >         skel = test_task_pt_regs__open_and_load();
> >         if (!ASSERT_OK_PTR(skel, "skel_open"))
> > @@ -32,7 +36,7 @@ void test_task_pt_regs(void)
> >         skel->links.handle_uprobe = uprobe_link;
> >
> >         /* trigger & validate uprobe */
> > -       get_base_addr();
> > +       method();
> >
> >         if (!ASSERT_EQ(skel->bss->uprobe_res, 1, "check_uprobe_res"))
> >                 goto cleanup;
> > --
> > 2.30.2
> >
