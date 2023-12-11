Return-Path: <bpf+bounces-17431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F6F80D8FD
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721D6B2160A
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC17524B3;
	Mon, 11 Dec 2023 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM58BtmK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2BB8
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:50:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1e35c2807fso644032166b.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702320598; x=1702925398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oImnlLmnah8bDjUGNDwl87Fht0G2nPycSLh58pjax1I=;
        b=lM58BtmKJEz825DJWxDHXMsRGWdyMV/5hb/RtlQ/GKoZV8Q1nGIk9SP1ZnEf5pT54u
         oMWAhCc3r/yrpk+2RwKa7nCa26E4Q4nDK8mVwl3kBANGohjmtreTh7is2JSls2FLZbDY
         SBKn+7fFw7VRD5m8gT2t9TiH3FmkwDdbGm0XC9jU5jV6pHFoARc6AwXltRgibychmJ1C
         cpD3WQSnUFWvNaY/RLj5f91dGOjeh7JYdH+m+w95uH5oQ/MBatsWlZM74jAIAXUm6guj
         VTCfVDIIK516MZOQdbWoUo2r3uO7KZVnmevX435sSOrki7uqOF0L9V7kIzfnUNpaUG+L
         KyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702320598; x=1702925398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oImnlLmnah8bDjUGNDwl87Fht0G2nPycSLh58pjax1I=;
        b=uUrtga07Zjqvg/zRt1DdgAaKavx35Zrf3SqeZmE2NPbXfPID25h2npEn4VreVaRINt
         IaivjDe+RGPrjubitmKHumrURsyOW1SJi6bLXbfZce30357G6tcd1Yv5ckxl5W4hWCf+
         qIVFbny//zx+WH1XgkKKVBSTKMNEIhN0TAYgRPhExj0Kq8Yemm9Poq6SHnn+/HlD9g//
         JccJXLpr8qetcdGz1AYkP++57NqEty2YBIK8mP9CI2Prmn+PcNtwve0wLXY+C6bUToB8
         yCwnyKIR51iy0o5B++PEFOEQ4IRh6WaWeBywRA9lpRAweLeDzdsYDj0N+wC+Pqfw8+MG
         kZHg==
X-Gm-Message-State: AOJu0Yxa/NmOUwXXZjKVanxlnZscl4CzLp+vl5GLEApf5oxBnAakasdE
	Z/wyAEqku7xaTMC6n4OYAtd/y28LsdMGcuy0xv8=
X-Google-Smtp-Source: AGHT+IED3GKVPs/klWwOQbRDe3ROL82PHDbDj0VN5v5ZQ+U1zKym29A2EHFkZ2LGdh4cRw0l+ifiyZg5a218/13rCyg=
X-Received: by 2002:a17:906:3f4b:b0:a1e:ef3d:7b63 with SMTP id
 f11-20020a1709063f4b00b00a1eef3d7b63mr2564644ejj.0.1702320598291; Mon, 11 Dec
 2023 10:49:58 -0800 (PST)
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
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev> <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev> <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
 <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>
In-Reply-To: <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Dec 2023 10:49:45 -0800
Message-ID: <CAEf4BzbTQCc6Ogruu_ANaQE4Tv6xVicayz8O6mDkWixJr5Uf_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 7:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Dec 10, 2023 at 2:30=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > How about a slightly different modification of the Anton's idea.
> > Suppose that, as before, there is a special map type:
> >
> >     struct {
> >         __uint(type, BPF_MAP_TYPE_ARRAY);
> >         __type(key, __u32);
> >         __type(value, __u32);
> >         __uint(map_flags, BPF_F_STATIC_KEY);
> >         __uint(max_entries, 1);
> >     } skey1 SEC(".maps")
>
> Instead of special map that the kernel has to know about
> the same intent can be expressed with:
> int skey1;
> r0 =3D %[skey1] ll;
> and then the kernel needs no extra map type while the user space
> can collect all static_branches that use &skey1 by
> iterating insn stream and comparing addresses.
>
> > Which is used as below:
> >
> >     __attribute__((naked))
> >     int foo(void) {
> >       asm volatile (
> >                     "r0 =3D %[skey1] ll;"
> >                     "if r0 !=3D r0 goto 1f;"
> >                     "r1 =3D r10;"
> >                     "r1 +=3D -8;"
> >                     "r2 =3D 1;"
> >                     "call %[bpf_trace_printk];"
> >             "1:"
> >                     "exit;"
> >                     :: __imm_addr(skey1),
> >                        __imm(bpf_trace_printk)
> >                     : __clobber_all
> >       );
> >     }
> >
> > Disassembly of section .text:
> >
> > 0000000000000000 <foo>:
> >        0:   r0 =3D 0x0 ll
> >         0000000000000000:  R_BPF_64_64  skey1  ;; <---- Map relocation =
as usual
> >        2:   if r0 =3D=3D r0 goto +0x4 <foo+0x38>   ;; <---- Note condit=
ion
> >        3:   r1 =3D r10
> >        4:   r1 +=3D -0x8
> >        5:   r2 =3D 0x1
> >        6:   call 0x6
> >        7:   exit
> >
> > And suppose that verifier is modified in the following ways:
> > - treat instructions "if rX =3D=3D rX" / "if rX !=3D rX" (when rX point=
s to
> >   static key map) in a special way:
> >   - when program is verified, the jump is considered non deterministic;
> >   - when program is jitted, the jump is compiled as nop for "!=3D" and =
as
> >     unconditional jump for "=3D=3D";
> > - build a table of static keys based on a specific map referenced in
> >   condition, e.g. for the example above it can be inferred that insn 2
> >   associates with map skey1 because "r0" points to "skey1";
> > - jit "rX =3D <static key> ll;" as nop;
> >
> > On the plus side:
> > - any kinds of jump tables are omitted from system call;
> > - no new instruction is needed;
> > - almost no modifications to libbpf are necessary (only a helper macro
> >   to convince clang to keep "if rX =3D=3D rX");
>
> Reusing existing insn means that we're giving it new meaning
> and that always comes with danger of breaking existing progs.
> In this case if rX =3D=3D rX isn't very meaningful and new semantics
> shouldn't break anything, but it's a danger zone.
>
> If we treat:
> if r0 =3D=3D r0
> as JA
> then we have to treat
> if r1 =3D=3D r1
> as JA as well and it becomes ambiguous when prog_info needs
> to return the insns back to user space.
>
> If we go with rX =3D=3D rX approach we should probably limit it
> to one specific register. r0, r10, r11 can be considered
> and they have their own pros and cons.
>
> Additional:
> r0 =3D %[skey1] ll
> in front of JE/JNE is a waste. If we JIT it to useless native insn
> we will be burning cpu for no reason. So we should probably
> optimize it out. If we do so, then this inline insn becomes a nop and
> it's effectively a relocation. The insn stream will carry this
> rX =3D 64bit_const insn to indicate the scope of the next insn.
> It's pretty much like Anton's idea of using extra bits in JA
> to encode an integer key_id.
> With ld_imm64 we will encode 64-bit key_id.
> Another insn with more bits to burn that has no effect on execution.
>
> It doesn't look clean to encode so much extra metadata into instructions
> that JITs and the interpreter have to ignore.
> If we go this route:
>   r11 =3D 64bit_const
>   if r11 =3D=3D r11 goto
> is a lesser evil.
> Still, it's not as clean as JA with extra bits in src_reg.
> We already optimize JA +0 into a nop. See opt_remove_nops().
> So a flavor of JA insn looks the most natural fit for a selectable
> JA +xx or JA +0.

Another point for special jump instruction is that libbpf can be
taught to patch it into a normal JA or NOP on old kernels, depending
on likely/unlikely bit. You won't be able to flip it, of course, but
at least you don't have to compile two separate versions of the BPF
object file. Instead of "jump maybe" it will transparently become
"jump/don't jump for sure". This should definitely help with backwards
compatibility.

>
> And the special map really doesn't fit.
> Whatever we do, let's keep text_poke-able insn logic separate
> from bookkeeping of addresses of those insns.
> I think a special prefixed section that is understood by libbpf
> (like what I proposed with "name.static_branch") will do fine.
> If it's not good enough we can add a "set" map type
> that will be a generic set of values.
> It can be a set of 8-byte addresses to keep locations of static_branches,
> but let's keep it generic.
> I think it's fine to add:
> __uint(type, BPF_MAP_TYPE_SET)
> and let libbpf populate it with addresses of insns,
> or address of variables, or other values
> when it prepares a program for loading.
> But map_update_elem should never be doing text_poke on insns.
> We added prog_array map type is the past, but that was done
> during the early days. If we were designing bpf today we would have
> gone a different route.

