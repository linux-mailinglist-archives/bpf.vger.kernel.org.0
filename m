Return-Path: <bpf+bounces-17316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8469A80B57C
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 18:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2390A1F21170
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55551864B;
	Sat,  9 Dec 2023 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er5NztCs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5ED10D0
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 09:18:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3316d09c645so3104826f8f.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 09:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702142318; x=1702747118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnaU/yasbIqLbyPTQVtrOLz5qqpUe31+pcmivTOBXa0=;
        b=Er5NztCsumq3Pe08YYrGH33egtuXV6YG7id3xk3hWT71VXV688bYmQdKJmLnUhIZ4z
         SQbn25ZxDlJc5jj3w2Q+9MiWzKjrM5C2HiELK6RwLv71DHMEKWw7KMTHR65rlUbXDsvq
         vGdoAngTdTQcIXlQoINdrwNQML3W32PYUsFU/uB4jPqVrqHoT6tfz4iIyTHV3TfctUEg
         FChoZiJDtGjT/HwsVLfM7ssfw2H4f8uu2nSITkWcpCv3hta6IIU5QUUzMRhgcx0lWUyv
         IsfAm1YRoWpJYFEruH/97d5SozrYlMDfxoFvcDM33aRreR1Q0CyEI1SNlXmXbAK92wOV
         NuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142318; x=1702747118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnaU/yasbIqLbyPTQVtrOLz5qqpUe31+pcmivTOBXa0=;
        b=vBEx8zUWYLEbroF2ZLKjYCgdeiDMmPfCAutz81sC5pJNb2Nxu6214pj3nn/Vpn3L7o
         ErTntO2KidCovERO856Mbr/P30DPB2myu7dbZIc7JA1nspYF0cT2WJdjh9r70xxGm7lY
         R0L9RaT2caulsPyU75Zi8ExD8mDG8mJuBlpv+Bw4tW64/T26fThQ+wQUzWGJ+YZ/tNT7
         Nc4q9feQnRyNvKZ9VGPw30XGQWCDTh7Axc3EMUQFpF06WteR6yGmgTbWWYIKvGk/gdTL
         P9Hx/JyL+TlmhfVE/F+jJBysgfrNUjBIKHqLRZCuI3zcmzXnnbp7dnELKJzDVbUICJkb
         UJ3w==
X-Gm-Message-State: AOJu0Yx8uh8PNhRZC5r0KggXB9v1VxDqrzT+J80U5plWC1SSN+OqE2d7
	Ipq9Qu1CiZRniRA6qFIG+ZpmSX13mjfJbt+wxJM=
X-Google-Smtp-Source: AGHT+IGCldRPG5i10wK5V1tnP5XhUxtpiXqjKQvWW6nkIup9DlF36oQxHegymp7xhOa4PTxhwYrk+nyCFCaCxtuzlQc=
X-Received: by 2002:a5d:58e3:0:b0:333:424:9338 with SMTP id
 f3-20020a5d58e3000000b0033304249338mr975885wrd.32.1702142318041; Sat, 09 Dec
 2023 09:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141030.1478753-1-aspsk@isovalent.com> <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5> <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev> <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
In-Reply-To: <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Dec 2023 09:18:26 -0800
Message-ID: <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Anton Protopopov <aspsk@isovalent.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:05=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 12/8/23 8:25 PM, Alexei Starovoitov wrote:
> > On Fri, Dec 8, 2023 at 8:15=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>
> >> On 12/8/23 8:05 PM, Alexei Starovoitov wrote:
> >>> On Fri, Dec 8, 2023 at 2:04=E2=80=AFPM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>> I feel like embedding some sort of ID inside the instruction is very=
..
> >>>> unusual, shall we say?
> >>> yeah. no magic numbers inside insns pls.
> >>>
> >>> I don't like JA_CFG name, since I read CFG as control flow graph,
> >>> while you probably meant CFG as configurable.
> >>> How about BPF_JA_OR_NOP ?
> >>> Then in combination with BPF_JMP or BPF_JMP32 modifier
> >>> the insn->off|imm will be used.
> >>> 1st bit in src_reg can indicate the default action: nop or jmp.
> >>> In asm it may look like asm("goto_or_nop +5")
> >> How does the C source code looks like in order to generate
> >> BPF_JA_OR_NOP insn? Any source examples?
> > It will be in inline asm only. The address of that insn will
> > be taken either via && or via asm (".long %l[label]").
> >  From llvm pov both should go through the same relo creation logic. I h=
ope :)
>
> A hack in llvm below with an example, could you check whether the C
> syntax and object dump result
> is what you want to see?

Thank you for the ultra quick llvm diff!

>
> diff --git a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> index 90697c6645be..38b1cbc31f9a 100644
> --- a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> +++ b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
> @@ -231,6 +231,7 @@ public:
>           .Case("call", true)
>           .Case("goto", true)
>           .Case("gotol", true)
> +        .Case("goto_or_nop", true)
>           .Case("*", true)
>           .Case("exit", true)
>           .Case("lock", true)
> @@ -259,6 +260,7 @@ public:
>           .Case("bswap64", true)
>           .Case("goto", true)
>           .Case("gotol", true)
> +        .Case("goto_or_nop", true)
>           .Case("ll", true)
>           .Case("skb", true)
>           .Case("s", true)
> diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td
> b/llvm/lib/Target/BPF/BPFInstrInfo.td
> index 5972c9d49c51..a953d10429bf 100644
> --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
> +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
> @@ -592,6 +592,19 @@ class BRANCH<BPFJumpOp Opc, string OpcodeStr,
> list<dag> Pattern>
>     let BPFClass =3D BPF_JMP;
>   }
>
> +class BRANCH_OR_NOP<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
> +    : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
> +                   (outs),
> +                   (ins brtarget:$BrDst),
> +                   !strconcat(OpcodeStr, " $BrDst"),
> +                   Pattern> {
> +  bits<16> BrDst;
> +
> +  let Inst{47-32} =3D BrDst;
> +  let Inst{31-0} =3D 1;
> +  let BPFClass =3D BPF_JMP;
> +}
> +
>   class BRANCH_LONG<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
>       : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
>                      (outs),
> @@ -632,6 +645,7 @@ class CALLX<string OpcodeStr>
>   let isBranch =3D 1, isTerminator =3D 1, hasDelaySlot=3D0, isBarrier =3D=
 1 in {
>     def JMP : BRANCH<BPF_JA, "goto", [(br bb:$BrDst)]>;
>     def JMPL : BRANCH_LONG<BPF_JA, "gotol", []>;
> +  def JMP_OR_NOP : BRANCH_OR_NOP<BPF_JA, "goto_or_nop", []>;

I was thinking of burning the new 0xE opcode for it,
but you're right. It's a flavor of existing JA insn and it's indeed
better to just use src_reg=3D1 bit to indicate so.

We probably need to use the 2nd bit of src_reg to indicate its default stat=
e
(jmp or fallthrough).

>          asm volatile goto ("r0 =3D 0; \
>                              goto_or_nop %l[label]; \
>                              r2 =3D 2; \
>                              r3 =3D 3; \

Not sure how to represent the default state in assembly though.
"goto_or_nop" defaults to goto
"nop_or_goto" default to nop
?

Do we need "gotol" for imm32 or will it be automatic?

