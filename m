Return-Path: <bpf+bounces-17420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47C80D3EE
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEF0282020
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8C04E605;
	Mon, 11 Dec 2023 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="IDD5FiNd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81945EA
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:34:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so59265101fa.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1702316096; x=1702920896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NdntKpoFqEp565dhKg1sipm9uz6YZ2T0KuB0vGO17X4=;
        b=IDD5FiNdk8G5ShXCcmbO74sNPQt6a6KAwiVf+jV0aaXrTVT3t1sLoWqPSkK4kQ5FPa
         LDCImOtpdxH7u4j8/dPFfij99W2uIgZV/nyAwutwHL2ZXmg6blCl1BsH5Zyzx958ksoD
         2eSqH6i7B7/T+lulICxjx3PyBdLiDm+QxEQc+HIokH+I2xMPWW+a50K1tiWaxdVFzJ0t
         ohTlZTPADKQSanTCSK3I30odqjSYBsTdEtkSIn/mxBMy5GIyLbmLsWyUBpSwUEL8lZF/
         jzbF/8M9e7RUY8dgGBsF8ocmsZ/cYcuWt2bokQkKqhAiz8n2d7zoIjJPMVP3xtl5nv9j
         dZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316096; x=1702920896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdntKpoFqEp565dhKg1sipm9uz6YZ2T0KuB0vGO17X4=;
        b=Iwdrz399U460ZPiQsPWJ5It6k/meKUGv4eTcyoJvzQnVUxJfQgp3NFr+zsTg1DY008
         7QF2/PaJ8frcD6IHdqaWmNLl0dWDPULrlGaCFTN/VIdYNfs9c+q/sKJ/LTpjQyEYkVGB
         IdBaYb3szZosMz0aZVuE21TBnlfah9HuV5qUe4YimQBKL3LR36m5KsBfpcp8X8C6p0qx
         9fOG0u3sp3pnYZob1jncbMpxdykVOSOQLZ+eEu0/M4K0L+s2x3UsS3RdZ0zN9VvkNiok
         eyqYLaPz4+EXYpjWgmD0hkHYLUhxbjt8CQkofb6n5ahIlBpNtf7NeGGlQCu0gtTuqjdN
         tTxQ==
X-Gm-Message-State: AOJu0YxFOO8y6DmInkNZBVlt6QoNYanqqNtXF28JgrwV7Q9DQwjdetEC
	B4ztiFDaSYCTbD4OzGF5LJcJ2Q==
X-Google-Smtp-Source: AGHT+IEUifuKCuhx+BOn5jaBiE7KhjVAiRTio474dljS05Eg0bsVyB9zQoitCqgX1srL22+FbFYf7A==
X-Received: by 2002:a19:6555:0:b0:50b:fa2e:4bce with SMTP id c21-20020a196555000000b0050bfa2e4bcemr2079599lfj.9.1702316096512;
        Mon, 11 Dec 2023 09:34:56 -0800 (PST)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id th19-20020a1709078e1300b00a1bda8db043sm5027770ejc.120.2023.12.11.09.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:34:55 -0800 (PST)
Date: Mon, 11 Dec 2023 17:31:31 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Message-ID: <ZXdHc7xoAVf1g4a9@zh-lab-node-5>
References: <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5>
 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>

On Sat, Dec 09, 2023 at 10:32:42PM -0800, Yonghong Song wrote:
> 
> On 12/9/23 9:18 AM, Alexei Starovoitov wrote:
> > On Fri, Dec 8, 2023 at 9:05 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> > > 
> > > On 12/8/23 8:25 PM, Alexei Starovoitov wrote:
> > > > On Fri, Dec 8, 2023 at 8:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> > > > > On 12/8/23 8:05 PM, Alexei Starovoitov wrote:
> > > > > > On Fri, Dec 8, 2023 at 2:04 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > I feel like embedding some sort of ID inside the instruction is very..
> > > > > > > unusual, shall we say?
> > > > > > yeah. no magic numbers inside insns pls.
> > > > > > 
> > > > > > I don't like JA_CFG name, since I read CFG as control flow graph,
> > > > > > while you probably meant CFG as configurable.
> > > > > > How about BPF_JA_OR_NOP ?
> > > > > > Then in combination with BPF_JMP or BPF_JMP32 modifier
> > > > > > the insn->off|imm will be used.
> > > > > > 1st bit in src_reg can indicate the default action: nop or jmp.
> > > > > > In asm it may look like asm("goto_or_nop +5")
> > > > > How does the C source code looks like in order to generate
> > > > > BPF_JA_OR_NOP insn? Any source examples?
> > > > It will be in inline asm only. The address of that insn will
> > > > be taken either via && or via asm (".long %l[label]").
> > > >   From llvm pov both should go through the same relo creation logic. I hope :)
> > > A hack in llvm below with an example, could you check whether the C
> > > syntax and object dump result
> > > is what you want to see?
> > Thank you for the ultra quick llvm diff!
> > 
> > > diff --git a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> > > b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> > > index 90697c6645be..38b1cbc31f9a 100644
> > > --- a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> > > +++ b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> > > @@ -231,6 +231,7 @@ public:
> > >            .Case("call", true)
> > >            .Case("goto", true)
> > >            .Case("gotol", true)
> > > +        .Case("goto_or_nop", true)
> > >            .Case("*", true)
> > >            .Case("exit", true)
> > >            .Case("lock", true)
> > > @@ -259,6 +260,7 @@ public:
> > >            .Case("bswap64", true)
> > >            .Case("goto", true)
> > >            .Case("gotol", true)
> > > +        .Case("goto_or_nop", true)
> > >            .Case("ll", true)
> > >            .Case("skb", true)
> > >            .Case("s", true)
> > > diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td
> > > b/llvm/lib/Target/BPF/BPFInstrInfo.td
> > > index 5972c9d49c51..a953d10429bf 100644
> > > --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
> > > +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
> > > @@ -592,6 +592,19 @@ class BRANCH<BPFJumpOp Opc, string OpcodeStr,
> > > list<dag> Pattern>
> > >      let BPFClass = BPF_JMP;
> > >    }
> > > 
> > > +class BRANCH_OR_NOP<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
> > > +    : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
> > > +                   (outs),
> > > +                   (ins brtarget:$BrDst),
> > > +                   !strconcat(OpcodeStr, " $BrDst"),
> > > +                   Pattern> {
> > > +  bits<16> BrDst;
> > > +
> > > +  let Inst{47-32} = BrDst;
> > > +  let Inst{31-0} = 1;
> > > +  let BPFClass = BPF_JMP;
> > > +}
> > > +
> > >    class BRANCH_LONG<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
> > >        : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
> > >                       (outs),
> > > @@ -632,6 +645,7 @@ class CALLX<string OpcodeStr>
> > >    let isBranch = 1, isTerminator = 1, hasDelaySlot=0, isBarrier = 1 in {
> > >      def JMP : BRANCH<BPF_JA, "goto", [(br bb:$BrDst)]>;
> > >      def JMPL : BRANCH_LONG<BPF_JA, "gotol", []>;
> > > +  def JMP_OR_NOP : BRANCH_OR_NOP<BPF_JA, "goto_or_nop", []>;
> > I was thinking of burning the new 0xE opcode for it,
> > but you're right. It's a flavor of existing JA insn and it's indeed
> > better to just use src_reg=1 bit to indicate so.
> 
> Right, using src_reg to indicate a new flavor of JA insn sounds
> a good idea. My previously-used 'imm' field is a pure hack.
> 
> > 
> > We probably need to use the 2nd bit of src_reg to indicate its default state
> > (jmp or fallthrough).
> 
> Good point.
> 
> > 
> > >           asm volatile goto ("r0 = 0; \
> > >                               goto_or_nop %l[label]; \
> > >                               r2 = 2; \
> > >                               r3 = 3; \
> > Not sure how to represent the default state in assembly though.
> > "goto_or_nop" defaults to goto
> > "nop_or_goto" default to nop
> > ?
> > 
> > Do we need "gotol" for imm32 or will it be automatic?
> 
> It won't be automatic.
> 
> At the end of this email, I will show the new change
> to have gotol_or_nop and nop_or_gotol insn and an example

Thanks a lot Yonghong! May I ask you to send a full patch for LLVM
(with gotol) so that I can test it?

Overall, I think that JA + flags in SRC_REG is indeed better than a
new instruction, as a new code is not used.

This looks for me that two bits aren't enough, and the third is
required, as the second bit seems to be overloaded:

  * bit 1 indicates that this is a "JA_MAYBE"
  * bit 2 indicates a jump or nop (i.e., the current state)

However, we also need another bit which indicates what to do with the
instruction when we issue [an abstract] command

  flip_branch_on_or_off(branch, 0/1)

Without this information (and in the absense of external meta-data on
how to patch the branch) we can't determine what a given (BPF, not
jitted) program currently does. For example, if we issue

  flip_branch_on_or_off(branch, 0)

then we can't reflect this in the xlated program by setting the second
bit to jmp/off. Again, JITted program is fine, but it will be
desynchronized from xlated in term of logic (some instructions will be
mapped as NOP -> x86_JUMP, others as NOP -> x86_NOP).

In my original patch we kept this triplet as

  (offset to indicate a "special jump", JA+0/JA+OFF, Normal/Inverse)

> to show it in asm. But there is an issue here.
> In my example, the compiler (more specifically
> the InstCombine pass) moved some code after
> the 'label' to before the 'label'. Not exactly
> sure how to prevent this. Maybe current
> 'asm goto' already have a way to handle
> this. Will investigate this later.
> 
> 
> =========================
> 
> $ cat t.c
> int bar(void);
> int foo1()
> {
>         int a, b;
>         asm volatile goto ("r0 = 0; \
>                             gotol_or_nop %l[label]; \
>                             r2 = 2; \
>                             r3 = 3; \
>                            "::::label);
>         a = bar();
> label:
>         b = 20 * a;
>         return b;
> }
> int foo2()
> {
>         int a, b;
>         asm volatile goto ("r0 = 0; \
>                             nop_or_gotol %l[label]; \
>                             r2 = 2; \
>                             r3 = 3; \
>                            "::::label);
>         a = bar();
> label:
>         b = 20 * a;
>         return b;
> }
> $ clang --target=bpf -O2 -g -c t.c
> $ llvm-objdump -S t.o
> 
> t.o:    file format elf64-bpf
> 
> Disassembly of section .text:
> 
> 0000000000000000 <foo1>:
> ; {
>        0:       b7 00 00 00 00 00 00 00 r0 = 0x0
> ;       asm volatile goto ("r0 = 0; \
>        1:       b7 00 00 00 00 00 00 00 r0 = 0x0
>        2:       06 10 00 00 04 00 00 00 gotol_or_nop +0x4 <LBB0_2>
>        3:       b7 02 00 00 02 00 00 00 r2 = 0x2
>        4:       b7 03 00 00 03 00 00 00 r3 = 0x3
> ;       a = bar();
>        5:       85 10 00 00 ff ff ff ff call -0x1
> ;       b = 20 * a;
>        6:       27 00 00 00 14 00 00 00 r0 *= 0x14
> 
> 0000000000000038 <LBB0_2>:
> ;       return b;
>        7:       95 00 00 00 00 00 00 00 exit
> 
> 0000000000000040 <foo2>:
> ; {
>        8:       b7 00 00 00 00 00 00 00 r0 = 0x0
> ;       asm volatile goto ("r0 = 0; \
>        9:       b7 00 00 00 00 00 00 00 r0 = 0x0
>       10:       06 20 00 00 04 00 00 00 nop_or_gotol +0x4 <LBB1_2>
>       11:       b7 02 00 00 02 00 00 00 r2 = 0x2
>       12:       b7 03 00 00 03 00 00 00 r3 = 0x3
> ;       a = bar();
>       13:       85 10 00 00 ff ff ff ff call -0x1
> ;       b = 20 * a;
>       14:       27 00 00 00 14 00 00 00 r0 *= 0x14
> 
> 0000000000000078 <LBB1_2>:
> ;       return b;
>       15:       95 00 00 00 00 00 00 00 exit
> 

