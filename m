Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89E31C8E1
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 11:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBPKeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 05:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhBPKdy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 05:33:54 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE305C061574
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:33:13 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q9so7892598ilo.1
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+xKbGN45JwLd06eh5o+6Cf0CVKycCicadOHxtEqAOI=;
        b=dBWAJ/wRuSwmxh6XgdInVhJAxIBUHs0/lVFPyTNrEGKCzwj62LrFvTATMW67isqVBn
         VI0M1WbJ7zTVMePt1zXCa5bgMlA5seUThyPZlh7QJK8YCLNRhR9KlS0s1GnjQ1a91WRf
         hF9Qh/18uhDshnAFR3eUkEnpqNPigmt8dU7/wqVeB207wc/jDRZzhMjjr9a8AXHUocHc
         j8j9GSF6XKHS9Ximue7y0DMniCiBLXr/f151TN2auCLu8eTwj+1jd+Z/IHeW6/LuXLI1
         t3Xpfp08OWibDuu6tE2Wge54SWQc9KVqBlz/C6UV6+kqBLr5lClJtLoQO3ew4Pr8HqYN
         8YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+xKbGN45JwLd06eh5o+6Cf0CVKycCicadOHxtEqAOI=;
        b=RKo78A5cHVArInXfG7TX069hy1CutWS6dRGVz3KVUyjA+8he44HL+HKqD2Lg1T/Rbc
         GWd6/fIdQSSpQLNFVZI9IKEr/Lzf5Hn0cRpRsjHb3iR+lP8M2+lRr9Q1+12VFRH5xNsZ
         WmS+6vB9QCzr10z8Y/jhCQEKC/08rbp+7FALyhLuxmDDjpbO7L0RFwNfo80s4qZ6lWIN
         zyYw9PT+osDeyRjOk6n+D5ri5HmbfJ9eHmFdImV68IEXE1faQaFtxxaVXzJtzI04kCD0
         XKhLoVZOiU7RxkpMSSfmU8gyDBI+z0+gsTPHnd4VThB++OsQH+Ph4RjADvA8sPRa4QOv
         k9sQ==
X-Gm-Message-State: AOAM530QX7Pbcz4XdtXrg5pmIKYCzys9vIvmBqyarUv5f05ExT/ossvd
        YJ/O4bYMsXAfCG6tbb3DchKxO7TkRo7ME9SLIgrvOw==
X-Google-Smtp-Source: ABdhPJykGah0UBjiyr061MxaeE0xSF19vYgelzznrg6UV4HN56nY6Fu/eW7zwuRy+CZjmhx/MdWOlR7f2jwM0vUy/Bs=
X-Received: by 2002:a05:6e02:194a:: with SMTP id x10mr16312938ilu.165.1613471592935;
 Tue, 16 Feb 2021 02:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20210215160044.1108652-1-jackmanb@google.com> <CACYkzJ6fwJNv6r3CvY7uO5xjZsXDVuuFrkMieLzOKsqQZ_0Jzw@mail.gmail.com>
In-Reply-To: <CACYkzJ6fwJNv6r3CvY7uO5xjZsXDVuuFrkMieLzOKsqQZ_0Jzw@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 16 Feb 2021 11:33:01 +0100
Message-ID: <CA+i-1C3guH-jDbSiF03frBsopKhn2RphTsv3zPpXW4tmXmZPdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: x86: Fix BPF_FETCH atomic and/or/xor with
 r0 as src
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Feb 2021 at 22:09, KP Singh <kpsingh@kernel.org> wrote:
>
> On Mon, Feb 15, 2021 at 5:00 PM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > This code generates a CMPXCHG loop in order to implement atomic_fetch
> > bitwise operations. Because CMPXCHG is hard-coded to use rax (which
> > holds the BPF r0 value), it saves the _real_ r0 value into the
> > internal "ax" temporary register and restores it once the loop is
> > complete.
> >
> > In the middle of the loop, the actual bitwise operation is performed
> > using src_reg. The bug occurs when src_reg is r0: as described above,
> > r0 has been clobbered and the real r0 value is in the ax register.
> >
> > Therefore, perform this operation on the ax register instead, when
> > src_reg is r0.
> >
> > Fixes: 981f94c3e921 ("bpf: Add bitwise atomic instructions")
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c                   |  7 +++---
> >  .../selftests/bpf/verifier/atomic_and.c       | 23 +++++++++++++++++++
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 79e7a0ec1da5..0c9edfe42340 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1349,6 +1349,7 @@ st:                       if (is_imm8(insn->off))
> >                             insn->imm == (BPF_XOR | BPF_FETCH)) {
> >                                 u8 *branch_target;
> >                                 bool is64 = BPF_SIZE(insn->code) == BPF_DW;
> > +                               u32 real_src_reg = src_reg == BPF_REG_0 ? BPF_REG_AX : src_reg;
>
> I think it would be more readable as:
>
>  u32 real_src_reg =  src_reg;
>
> /* Add a comment here why this is needed */
> if (src_reg == BPF_REG_0)
>   real_src_reg = BPF_REG_AX;

Yes good idea - actually if I put it next to the relevant mov:

  /* Will need RAX as a CMPXCHG operand so save R0 */
  emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0)
  if (src_reg == BPF_REG_0)
        real_src_reg = BPF_REG_AX;

I don't think it even needs a comment - what do you think?

> >
> >                                 /*
> >                                  * Can't be implemented with a single x86 insn.
> > @@ -1366,9 +1367,9 @@ st:                       if (is_imm8(insn->off))
> >                                  * put the result in the AUX_REG.
> >                                  */
> >                                 emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
> > -                               maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
> > +                               maybe_emit_mod(&prog, AUX_REG, real_src_reg, is64);
> >                                 EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
> > -                                     add_2reg(0xC0, AUX_REG, src_reg));
> > +                                     add_2reg(0xC0, AUX_REG, real_src_reg));
> >                                 /* Attempt to swap in new value */
> >                                 err = emit_atomic(&prog, BPF_CMPXCHG,
> >                                                   dst_reg, AUX_REG, insn->off,
> > @@ -1381,7 +1382,7 @@ st:                       if (is_imm8(insn->off))
> >                                  */
> >                                 EMIT2(X86_JNE, -(prog - branch_target) - 2);
> >                                 /* Return the pre-modification value */
> > -                               emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
> > +                               emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
> >                                 /* Restore R0 after clobbering RAX */
> >                                 emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
>
> [...]
>
> >
> > base-commit: 5e1d40b75ed85ecd76347273da17e5da195c3e96
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
