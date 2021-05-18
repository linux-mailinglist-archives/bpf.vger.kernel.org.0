Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD13881FE
	for <lists+bpf@lfdr.de>; Tue, 18 May 2021 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhERVSv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 May 2021 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhERVSv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 May 2021 17:18:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA08C061573
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 14:17:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q7so14605769lfr.6
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4kaDl4IeLSSFf2/I4guz64hGWOIlpr9Jcd9MFvMSk4=;
        b=je0N1GZ8+YSC80JyF8yAjo3jwEoq49lPZ1x0rQFEg9rCiEZc1LFMyZpLFWm7dnNrf3
         hj7fQ4kyMdOSVElncxlY2a/NN9k6ifgLdg3mo4ef8rKFjQbhhsgJx5emCvb8EeXusOrd
         0m4x9heRwq3F3VtaM+NGuF5k94YnBGoqFm5X2USEcAElksKei4y9zrUQJcMDxB9nAJFO
         nInZfKVFpmGb11PXJ12H4C7RnwzLAZyT+qk3nB0sLbgj4a7Y6OtmR9drcR9M+b3+dH4x
         8UTcUwlfvfeeh3myuOwCSpFBqeGSaaznhuJJYVTMa4/Sx7W3mM732EJQDXUR9IDyJr5Z
         YO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4kaDl4IeLSSFf2/I4guz64hGWOIlpr9Jcd9MFvMSk4=;
        b=P2R6DZ84NoY03tIzV8QmhVYh8o2/hIgWKtJ8yywPsrtzgAA0wA9bksE3wUt9Nk1bjE
         1JoLMck9+7aQWwSx+fbaw8icDFhdboFiKSPxQ2dzbe1tPqdgkSkEYhNH1Cuj80DENWh2
         gnwpn73dfTDiTeW5eMhC04ofhjnaa0rxIs4abnZS8iyg3xabOu2stPAI0BIcWD5PHUXa
         4PzWDpPMWQSfG/btFIuNqpBeN9kA/yjDkmP0B583yqbKt5ClVe1wHiCobyxOiQgEZAYs
         iVzfYzEnEq2RYuqh2Ra0Cy2P5khxvOoxn6aUO/isYSaBwev1KXXoL/qWCX0B+vsowzL4
         fFSQ==
X-Gm-Message-State: AOAM532W6LPYnW+OFoCzGWii/RbTAT6X6rNuiDUkyYHgiGivWPMzC6s0
        nzuT6/DPaCQnzFjLRjWYo2ksQ2i3jLN1cnm9e8I=
X-Google-Smtp-Source: ABdhPJxnZ3xTiTx7AoQt0ZLv4bVHogtVc8+Zu/yuMAx6i8bbR+uzcM9ClsCj01pyQ5t4sDiWhBcUgvIBCd+tzyqmWN8=
X-Received: by 2002:ac2:4838:: with SMTP id 24mr1299545lft.214.1621372650248;
 Tue, 18 May 2021 14:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com> <4a843738-4eb1-d993-6b64-7f36144d2456@iogearbox.net>
In-Reply-To: <4a843738-4eb1-d993-6b64-7f36144d2456@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 May 2021 14:17:18 -0700
Message-ID: <CAADnVQ+1enHX1wgh7yj=2Kh6pScWcnxV_oqz+526Es7N3-FtYA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 00/21] bpf: syscall program, FD array, loader
 program, light skeleton.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 18, 2021 at 12:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/14/21 2:36 AM, Alexei Starovoitov wrote:
> [...]
> > This is a first step towards signed bpf programs and the third approach of that kind.
> > The first approach was to bring libbpf into the kernel as a user-mode-driver.
> > The second approach was to invent a new file format and let kernel execute
> > that format as a sequence of syscalls that create maps and load programs.
> > This third approach is using new type of bpf program instead of inventing file format.
> > 1st and 2nd approaches had too many downsides comparing to this 3rd and were discarded
> > after months of work.
> >
> > To make it work the following new concepts are introduced:
> > 1. syscall bpf program type
> > A kind of bpf program that can do sys_bpf and sys_close syscalls.
> > It can only execute in user context.
> >
> > 2. FD array or FD index.
> > Traditionally BPF instructions are patched with FDs.
> > What it means that maps has to be created first and then instructions modified
> > which breaks signature verification if the program is signed.
> > Instead of patching each instruction with FD patch it with an index into array of FDs.
> > That makes the program signature stable if it uses maps.
> >
> > 3. loader program that is generated as "strace of libbpf".
> > When libbpf is loading bpf_file.o it does a bunch of sys_bpf() syscalls to
> > load BTF, create maps, populate maps and finally load programs.
> > Instead of actually doing the syscalls generate a trace of what libbpf
> > would have done and represent it as the "loader program".
> > The "loader program" consists of single map and single bpf program that
> > does those syscalls.
> > Executing such "loader program" via bpf_prog_test_run() command will
> > replay the sequence of syscalls that libbpf would have done which will result
> > the same maps created and programs loaded as specified in the elf file.
> > The "loader program" removes libelf and majority of libbpf dependency from
> > program loading process.
>
> More of a general question since afaik from prior discussion it didn't came up.
> I think conceptually, it's rather weird to only being able to execute the loader
> program which is later also supposed to do signing through the BPF_PROG_TEST_RUN
> aka our _testing_ infrastructure. Given it's not mentioned in future steps, is
> there anything planned before it becomes uapi and fixed part of skeleton (in
> particular the libbpf bpf_load_and_run() helper officially calling into the
> skel_sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr))) on this regard or is the
> BPF_PROG_TEST_RUN really supposed to be the /main/ interface going forward;
> what's the plan on this?

Few things here:
1. using TEST_RUN command beyond testing.
That ship already sailed. The perf using this command to trigger
prog execution not in a testing environment. See bperf_trigger_reading().
In the past we agreed not to rename commands whose purpose
doesn't strictly fit the name any more. Like RAW_TP_OPEN does a lot more
than just attaching raw_tracepoints.
TEST_RUN command is also no longer for testing only.
That's one of the reasons why bpf_load_and_run() helper is
called such instead of bpf_load_and_test_run().
It's running the program and not testing it.
The kernel cmd is unfortunately misnamed.

2. singing parts that are still to be designed.
We've discussed a few ways of doing it including having
another prog type responsible for it.
In all cases it will be done outside of test_run cmd context.
The actual signing will be completely in user space similar to kernel
modules. No kernel syscalls will be invoked.
The signature verification will be at the program load time.
The loader map and the loader prog will be signed and signature
has to be verified prior to execution. I think load time is the best
place to do it.
Currently Arnaldo's approach of extra sign_add+sign_sz fields to prog_load
and map_create cmds look like the best fit.
Together the map + prog will be checked as one entity and once
created+loaded the loader prog is ready to be executed to
produce other progs/maps.
Such 'run/execute' step (via test_run cmd) can happen many times later,
but at that time there will be no signature creation or signature
checking steps.
The more flexible approach to this is to add a sign checking program
that will be invoked and executed by the kernel during loader prog
loading and during map create. Both approaches can co-exist too.
And in both approaches signature checking steps are not in
test_run cmd user context.
All these future steps are up for discussion of course.

3. fixed part of skeleton
The skeleton is not cast in stone.
Quite the opposite.
It will change as loader prog will support more features.
The bpf_load_and_run() helper may change as well.
That's why it's in skel_internal.h and not part of libbpf api.
Essentially all C code in skel_internal.h are internal to lskel.
They are just as good as being auto-generated by bpftool
during light skeleton creation.
The bpftool could have emitted skel_internal.h just as well.
But it's kinda ugly to let it emit the whole .h file that could be
shared by multiple light skels.
Since it's a .h file it's not a static or shared library. It's not a .c file.
It's guaranteed to be compiled into whatever app that is using light skel.
So there are no backward compat concerns when skel_internal.h
will inevitably change in next revs of lskel.
Same thing with struct bpf_map/prog_desc. They are part of skel_internal.h
and match to what loader prog and lskel gen are doing.
Not only their layout will change, but depending on bpftool
cmdline flags that generated lskel might use different bpf_map_desc.
For example when lskel user needs more or less debuggability from the
loader prog the generated bpf prog will be different and will use
different contract between loader prog and auto-generated light skel .h

Does it answer your questions?
