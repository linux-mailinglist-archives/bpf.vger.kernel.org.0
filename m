Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24F54549E2
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 16:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhKQPbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 10:31:48 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36078 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhKQPbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 10:31:47 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0E20620C56D1
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 07:28:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E20620C56D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1637162929;
        bh=rNEY0TBABFQgU3JV3Pca4VGni4BTQEUdOLPn7LFs0cM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nZxcRMucMD1/XBRlhX44i0E9OIIloi5l26+ve64DqvSUHHWCK4PWPYG0aE+PqJokN
         m1PpoR6ZZchRYiEowYv91KmsC77tptFAl8dZpRljExpT1z6uIKpIGMM/l+1UU3wHd4
         1nNbwj1LS/3yBdo9tAmJcHjMMjfZgb9M/gBRrDP4=
Received: by mail-pj1-f44.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so2880072pjb.4
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 07:28:48 -0800 (PST)
X-Gm-Message-State: AOAM531feltD/KvSFFj37igV4+TUBxdE5rE6MKyEXGNUvWkL5KoLlJqI
        XYPHquiVBPckIE9kTZmQluQkFJEQkCjXCRdsCRo=
X-Google-Smtp-Source: ABdhPJyjy6CIUe5NSfRfCVXvhU/BpRLzsdysYU63uT/r3xDHMMDifHp8QUzEIWkoF2DTtoItR6ewJveRqcx5uvSBVmc=
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr679244pjb.20.1637162928580;
 Wed, 17 Nov 2021 07:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
 <CAFnufp20BUGADHQLPWsa2BDorS+_pDxT2Sn1GKkSHGBw1RgMFA@mail.gmail.com> <CAEf4BzbhzNU-ydvTYa8XG3jRxae+83d_w7EkHaOkySQVH1BHww@mail.gmail.com>
In-Reply-To: <CAEf4BzbhzNU-ydvTYa8XG3jRxae+83d_w7EkHaOkySQVH1BHww@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 17 Nov 2021 16:28:12 +0100
X-Gmail-Original-Message-ID: <CAFnufp1f_==QV3L31z4iknZVvoWzH6yKJ3zttvVpMJEj+kOxEA@mail.gmail.com>
Message-ID: <CAFnufp1f_==QV3L31z4iknZVvoWzH6yKJ3zttvVpMJEj+kOxEA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/12] bpf: CO-RE support in the kernel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 5:34 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 16, 2021 at 4:48 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > On Fri, Nov 12, 2021 at 6:02 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > v1->v2:
> > > . Refactor uapi to pass 'struct bpf_core_relo' from LLVM into libbpf and further
> > > into the kernel instead of bpf_core_apply_relo() bpf helper. Because of this
> > > change the CO-RE algorithm has an ability to log error and debug events through
> > > the standard bpf verifer log mechanism which was not possible with helper
> > > approach.
> > > . #define RELO_CORE macro was removed and replaced with btf_member_bit_offset() patch.
> > >
> > > This set introduces CO-RE support in the kernel.
> > > There are several reasons to add such support:
> > > 1. It's a step toward signed BPF programs.
> > > 2. It allows golang like languages that struggle to adopt libbpf
> > >    to take advantage of CO-RE powers.
> > > 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
> > >    by the verifier purely based on +10 offset. If R1 points to a union
> > >    the verifier picks one of the fields at this offset.
> > >    With CO-RE the kernel can disambiguate the field access.
> > >
> >
> > Great, I tested the same code which was failing with the RFC series,
> > now there isn't any error.
> > This is the output with pr_debug() enabled:
> >
> > root@debian64:~/core# ./core
> > [    5.690268] prog '(null)': relo #-2115894237: kind <(null)>
> > (163299788), spec is
> > [    5.690272] prog '(null)': relo #-2115894246: (null) candidate #-2115185528
> > [    5.690392] prog '(null)': relo #2: patched insn #208 (LDX/ST/STX)
> > off 208 -> 208
> > [    5.691045] prog '(efault)': relo #-2115894237: kind <(null)>
> > (163299788), spec is
> > [    5.691047] prog '(efault)': relo #-2115894246: (null) candidate
> > #-2115185528
> > [    5.691148] prog '(efault)': relo #3: patched insn #208
> > (LDX/ST/STX) off 208 -> 208
> > [    5.692456] prog '(null)': relo #-2115894237: kind <(null)>
> > (163302708), spec is
> > [    5.692459] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
> > [    5.692564] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
> > off 104 -> 104
> > [    5.693179] prog '(efault)': relo #-2115894237: kind <(null)>
> > (163299788), spec is
> > [    5.693181] prog '(efault)': relo #-2115894246: (null) candidate
> > #-2115185528
> > [    5.693258] prog '(efault)': relo #3: patched insn #208
> > (LDX/ST/STX) off 208 -> 208
> > [    5.696141] prog '(null)': relo #-2115894237: kind <(null)>
> > (163302708), spec is
> > [    5.696143] prog '(null)': relo #-2115894246: (null) candidate #-2115185668
> > [    5.696255] prog '(null)': relo #2: patched insn #104 (LDX/ST/STX)
> > off 104 -> 104
> > [    5.696733] prog '(efault)': relo #-2115894237: kind <(null)>
> > (163299788), spec is
> > [    5.696734] prog '(efault)': relo #-2115894246: (null) candidate
> > #-2115185528
> > [    5.696833] prog '(efault)': relo #3: patched insn #208
> > (LDX/ST/STX) off 208 -> 208
>
> All the logged values are completely wrong, some corruption somewhere.
>
> But I tried to see it for myself and I couldn't figure out how to get
> these logs with lskel. How did you get the above?
>
> Alexei, any guidance on how to get those verifier logs back with
> test_progs? ./test_progs -vvv didn't help, I also checked trace_pipe
> output, it was empty. I thought that maybe verifier truncates logs on
> success and simulated failed prog validation, but still nothing.
>
> >
> > And the syscall returns success:
> >
> > bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0,
> > data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0,
> > ctx_size_in=68, ctx_size_out=0, ctx_in=0x5590b97dd2a0, ctx_out=NULL}},
> > 160) = 0
> >
> > Regards,
> > --
> > per aspera ad upstream

Sorry, there was an off-by-one in the macro.
I just aliased all the pr_* to printk, this is the correct output:

# core/core
[    3.686333] prog '': relo #0: kind <byte_off> (0), spec is
[    3.686337] prog '': relo #0: matching candidate #0
[    3.686471] prog '': relo #0: patched insn #2 (LDX/ST/STX) off 208 -> 208
[    3.687209] prog '': relo #1: kind <byte_off> (0), spec is
[    3.687211] prog '': relo #1: matching candidate #0
[    3.687251] prog '': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208
[    3.688193] prog '': relo #0: kind <byte_off> (0), spec is
[    3.688196] prog '': relo #0: matching candidate #0
[    3.688238] prog '': relo #0: patched insn #2 (LDX/ST/STX) off 104 -> 104
[    3.688781] prog '': relo #1: kind <byte_off> (0), spec is
[    3.688783] prog '': relo #1: matching candidate #0
[    3.688820] prog '': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208
[    3.691529] prog '': relo #0: kind <byte_off> (0), spec is
[    3.691531] prog '': relo #0: matching candidate #0
[    3.691610] prog '': relo #0: patched insn #2 (LDX/ST/STX) off 104 -> 104
[    3.692158] prog '': relo #1: kind <byte_off> (0), spec is
[    3.692160] prog '': relo #1: matching candidate #0
[    3.692256] prog '': relo #1: patched insn #3 (LDX/ST/STX) off 208 -> 208

Regards,
-- 
per aspera ad upstream
