Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B8316E25
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhBJSLS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 13:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhBJSJM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 13:09:12 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC770C06174A
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 10:08:31 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id y199so3023517oia.4
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bp3Gpjv6OJluXrw28P9o+O4dQOhUhGs2gAV7zZEjb0U=;
        b=hiqkg6j8581YLIgBXH+60Oeu1AGifzuF9fdE2ckosYy03AzPYPOcPrIYUw6nkdv/gN
         lGrkOHGgHVvxbqK9t1jV1WMhJIwg7Y6Q76jP8rumtmEbn+NrEF0IEDBo9qRLgKPXUc4T
         O2zzRoP72p3LWA/ruB2WsKzvT0xO82Gt0p5dPRF/tbE45iU2KWVxZ4GEBStvYS7Xn9r5
         m412sS2vqlaykOPAqwebbFT6pwHVYpVNqIryPwqdXyMI1FGqjOL9wKt1ChBZZtSfApDe
         1NwDsr1GFtKrgU4hf5kTPLAUIZ8+cGA6VpgSoIEP3gxGM/XdkVRpbwrRYPYKIV0g6DlI
         eAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bp3Gpjv6OJluXrw28P9o+O4dQOhUhGs2gAV7zZEjb0U=;
        b=lzR/yaqH7YtClRJf4g4gRGI3EYu6m9xA2eMHJSK3hkSiw4OEP5XTZIuTTm57PLGS1Z
         qylvFLhi1u/fhtvYSGnrJdtRX+Hyossq0cvjWcizLlSsNT0HLWB+F8Kwensg8bcEj2Zz
         a1rnKD77OaoO0RAUTZP7seuAmql3/jAXmLTm6kPzfxl1d32LYqNoMUk9tcxVQxxjbosL
         u4NNy3U4+/lwUZmcA5wSjFey20EyeceRd3nVF6gxQ3FzWhNqXBlm3fKj5K3gVZh1v+6g
         pd4YdFrzGqskgpF9pEvHR2qvLECclIICHRlsf9wYqc+JD3r0M3OYhQ6Gt46qwEzpgjDZ
         6uBA==
X-Gm-Message-State: AOAM531Rb+UqHu83dJedV19h0Pw+KkdaPotWrtJhDNm6jy2QmO07nz0b
        16ws0sL1EyfA9HszJx2iJKl3sTxddlWtiEpEPrXEvjqz
X-Google-Smtp-Source: ABdhPJz5aKReoPMV6sBgzn41LbwLL+DFb2vSsBAm0UP7kaGVq0ch/RYDXRd3xDulsc+RsO7ropBh8hTmQLyMBON9nCI=
X-Received: by 2002:aca:3b8b:: with SMTP id i133mr129374oia.132.1612980511284;
 Wed, 10 Feb 2021 10:08:31 -0800 (PST)
MIME-Version: 1.0
References: <b1792bb3c51eb3e94b9d27e67665d3f2209bba7e.camel@linux.ibm.com>
 <CAADnVQJFcFwxEz=wnV=hkie-EDwa8s5JGbBQeFt1TGux1OihJw@mail.gmail.com> <5c6501bea0f7ae9dcb9d5f2071441942d5d3dc0f.camel@linux.ibm.com>
In-Reply-To: <5c6501bea0f7ae9dcb9d5f2071441942d5d3dc0f.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Feb 2021 10:08:20 -0800
Message-ID: <CAADnVQ+gnQED7WYAw7Vmm5=omngCKYXnmgU_NqPUfESBerH8gQ@mail.gmail.com>
Subject: Re: What should BPF_CMPXCHG do when the values match?
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 5:28 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Tue, 2021-02-09 at 20:14 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 9, 2021 at 4:43 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Hi,
> > >
> > > I'm implementing BPF_CMPXCHG for the s390x JIT and noticed that the
> > > doc, the interpreter and the X64 JIT do not agree on what the
> > > behavior
> > > should be when the values match.
> > >
> > > If the operand size is BPF_W, this matters, because, depending on
> > > the
> > > answer, the upper bits of R0 are either zeroed out out or are left
> > > intact.
> > >
> > > I made the experiment based on the following modification to the
> > > "atomic compare-and-exchange smoketest - 32bit" test on top of
> > > commit
> > > ee5cc0363ea0:
> > >
> > > --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> > > +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> > > @@ -57,8 +57,8 @@
> > >                 BPF_MOV32_IMM(BPF_REG_1, 4),
> > >                 BPF_MOV32_IMM(BPF_REG_0, 3),
> > >                 BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10,
> > > BPF_REG_1, -4),
> > > -               /* if (old != 3) exit(4); */
> > > -               BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
> > > +               /* if ((u64)old != 3) exit(4); */
> > > +               BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
> > >                 BPF_MOV32_IMM(BPF_REG_0, 4),
> > >                 BPF_EXIT_INSN(),
> > >                 /* if (val != 4) exit(5); */
> > >
> > > and got the following results:
> > >
> > > 1) Documentation: Upper bits of R0 are zeroed out - but it looks as
> > > if
> > >    there is a typo and either a period or the word "otherwise" is
> > >    missing?
> > >
> > >    > If they match it is replaced with ``src_reg``, The value that
> > > was
> > >    > there before is loaded back to ``R0``.
> > >
> > > 2) Interpreter + KVM: Upper bits of R0 are zeroed out (C semantics)
> > >
> > > 3) X64 JIT + KVM: Upper bits of R0 are untouched (cmpxchg
> > > semantics)
> > >
> > >    => 0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
> > >       0xffffffffc0146bcc: cmp $0x3,%rax
> > >    (gdb) p/x $rax
> > >    0x6bd5720c00000003
> > >    (gdb) x/d $rbp-4
> > >    0xffffc90001263d5c: 3
> > >
> > >       0xffffffffc0146bc7: lock cmpxchg %edi,-0x4(%rbp)
> > >    => 0xffffffffc0146bcc: cmp $0x3,%rax
> > >    (gdb) p/x $rax
> > >    0x6bd5720c00000003
> > >
> > > 4) X64 JIT + TCG: Upper bits of R0 are zeroed out (qemu bug?)
> > >
> > >    => 0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
> > >       0xffffffffc0144201: cmp $0x3,%rax
> > >    (gdb) p/x $rax
> > >    0x81776ea600000003
> > >    (gdb) x/d $rbp-4
> > >    0xffffc90001117d5c: 3
> > >
> > >       0xffffffffc01441fc: lock cmpxchg %edi,-0x4(%rbp)
> > >    => 0xffffffffc0144201: cmp $0x3,%rax
> > >    (gdb) p/x $rax
> > >    $3 = 0x3
> > >
> > > So which option is the right one? In my opinion, it would be safer
> > > to
> > > follow what the interpreter does and zero out the upper bits.
> >
> > Wow. What a find!
> > I thought that all 32-bit x86 ops zero-extend the dest register.
>
> I think that's true, it's just that when the values match, cmpxchg is
> specified to do nothing.
>
> > I agree that it's best to zero upper bits for cmpxchg as well.
>
> I will send a doc patch to clarify the wording then.
>
> > I wonder whether compilers know about this exceptional behavior.
>
> I'm not too familiar with the BPF LLVM backend, but at least CMPXCHG32
> is defined in a similar way to XFALU32, so it should be fine. Maybe
> Yonghong can comment on this further.

I meant x86 backends in gcc and llvm.
bpf backend in llvm I've already checked.

> > I believe the bpf backend considers full R0 to be used by bpf's
> > cmpxchg.
>
> It's a little bit inconsistent at the moment. I don't know why yet,
> but on s390 the subreg optimization kicks in and I have to run with the
> following patch in order to avoid stack pointer zero extension:

makes sense.
This is needed not only for cmpxchg, but for all bpf_fetch variants, right?

> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10588,6 +10588,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct
> bpf_verifier_env *env,
>         for (i = 0; i < len; i++) {
>                 int adj_idx = i + delta;
>                 struct bpf_insn insn;
> +               u8 load_reg;
>
>                 insn = insns[adj_idx];
>                 if (!aux[adj_idx].zext_dst) {
> @@ -10630,9 +10631,29 @@ static int
> opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>                 if (!bpf_jit_needs_zext())
>                         continue;
>
> +               /* zext_dst means that we want to zero-extend whatever
> register
> +                * the insn defines, which is dst_reg most of the time,
> with
> +                * the notable exception of BPF_STX + BPF_ATOMIC +
> BPF_FETCH.
> +                */
> +               if (BPF_CLASS(insn.code) == BPF_STX &&
> +                   BPF_MODE(insn.code) == BPF_ATOMIC) {
> +                       /* BPF_STX + BPF_ATOMIC insns without BPF_FETCH
> do not
> +                        * define any registers, therefore zext_dst
> cannot be
> +                        * set.
> +                        */
> +                       if (WARN_ON_ONCE(!(insn.imm & BPF_FETCH)))
> +                               return -EINVAL;

warn makes sense.

> +                       if (insn.imm == BPF_CMPXCHG)
> +                               load_reg = BPF_REG_0;
> +                       else
> +                               load_reg = insn.src_reg;

pls use ?:.
I think it will read easier.
And submit it as an official patch. Please.

> +               } else {
> +                       load_reg = insn.dst_reg;
> +               }
> +
>                 zext_patch[0] = insn;
> -               zext_patch[1].dst_reg = insn.dst_reg;
> -               zext_patch[1].src_reg = insn.dst_reg;
> +               zext_patch[1].dst_reg = load_reg;
> +               zext_patch[1].src_reg = load_reg;
>                 patch = zext_patch;
>                 patch_len = 2;
>  apply_patch_buffer:
>
> However, this doesn't seem to affect x86_64.

Right, but it will affect x86-32. It doesn't implement atomics yet,
but would be good to keep zext correct.

> > Do you know what xchg does on x86? What about arm64 with cas?
>
> xchg always zeroes out the upper half.
> Unlike x86_64's cmpxchg, arm64's cas is specified to always zero out
> the upper half, even if the values match. I don't have access to arm8.1
> machine to test this, but at least QEMU does behave this way.
> s390's cs does not zero out the upper half, we need to use llgfr in
> addition (which doesn't sound like a big deal to me).

thanks for checking!

Brendan,
could you please follow up with x64 jit fix to add 'mov eax,eax'  for
u32-sized cmpxchg  ?
