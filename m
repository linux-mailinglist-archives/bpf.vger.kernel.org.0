Return-Path: <bpf+bounces-17771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E0E81251C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 03:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA68E28244B
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0C6808;
	Thu, 14 Dec 2023 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJLU/sZi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4910F
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:15:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so61380025e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 18:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702520132; x=1703124932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m28s3RzLB5fbgewnlSV/1cnF9y/loI3MsMlbPUB1xLg=;
        b=LJLU/sZia3EIZz9ABiW0+xHueyyyDSKBw1ujozKLpRTs+koIzJuGl8Sci+vilXsqiB
         iKaRYCYbqC3V65kCb6mYGsa87MOC9cm/N22u9GD7hmAH3RDq2L5ThI6GNmPPMt7+sn3/
         gfo5wgmS4Q/iwSk73cwDANhX5sD5g7h7cyImppU49PqTVZkbXT61ISPE+QoOfP6boVkR
         EqH7PYs/xIDXt3HjFs7IpE157P2RAqWtHPNa3/dWLDuqM4DbtGa0LadCJfwrA3upHXIe
         6wl8crkPXDWA+U0kBx7PZXFDN7wDHPeyxAQiFVLNP2Evskz2CmNOy1X7A6PJseLQBITG
         xAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702520132; x=1703124932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m28s3RzLB5fbgewnlSV/1cnF9y/loI3MsMlbPUB1xLg=;
        b=EEmjQOVsPzeleQkk7OqHcwVsbXkuzMd2NfW3erIpeCIltFa8ZXPUtoEa2mX4jBB8kJ
         VXqqupAFnn7oeVqvnmPe4Nr9U5MVk/p4IbqGgFMoR+ChG114K3Tg5HZZ9f2svzS98XDS
         NRtJLMTxOZbUovoOz0NtlO1k2aXkpVccyZmO6dcZAdhIvCMEHbWM2YoIotTVP4usIkuB
         8/jvPayxnQT/uCjd7S8fCppuWSLCtIBww7zxkVgVWai3nMbdsOhGoi2EE6OojHCenUzo
         hxvsQ/9ZYpEzMRN2ehbDQcT7WCKdc9qPaKRta+gKJPGqAvxg2S8eBXRalhH8GjaNPv71
         GYbg==
X-Gm-Message-State: AOJu0YzcZmlisaNGSgKSLPG74lwBGO/XKD2Wfhz05Nm7AoFgXHL/HTEE
	8M9c7TAIJ7f/bNJITRBf78Zi4tXc5KUyX6Cgpmk=
X-Google-Smtp-Source: AGHT+IFMEhXdmUmv7ePzw2Xovts/8V2xpTdKLORoxBnkm0plTA13qLQtvrpmjm3PMAbMHgfrqYyFMzydwqLVKnpThZM=
X-Received: by 2002:a05:600c:1503:b0:40c:3624:fc40 with SMTP id
 b3-20020a05600c150300b0040c3624fc40mr4811013wmg.15.1702520132205; Wed, 13 Dec
 2023 18:15:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXNCB5sEendzNj6+@zh-lab-node-5> <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev> <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev> <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev> <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
 <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com> <ZXg1ApeYXi0g7WeM@zh-lab-node-5>
In-Reply-To: <ZXg1ApeYXi0g7WeM@zh-lab-node-5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Dec 2023 18:15:20 -0800
Message-ID: <CAADnVQ+b3_5qzaR9pr6B23xDxCO10iz685tHfsakW3MnoVYMbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 2:28=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
>
> This seems to have a benefit that there is no back compatibility issue
> (if we use r1, because r0/r11 will be rejected by old verifiers). We
> can have
>
>     r1 =3D 64bit_const
>     if r1 =3D=3D r1 goto
>
> and
>
>     r1 =3D 64bit_const
>     if r1 !=3D r1 goto
>
> and translate it on prog load to new instruction as JUMP_OF_NOP and
> NOP_OR_JUMP, correspondingly. On older kernels it will have the
> default (key is off) behaviour.

As Andrii pointed out any new insn either JA with extra bits
or special meaning if rX =3D=3D rX can be sanitized by libbpf
into plain JA.
There will be no backward compat issues.

> Ok, from BPF arch perspective this can work with two bits (not for
> practical purposes though, IMO, see my next e-mail).

I read this email and I still don't understand why you need a 3rd bit.

>
> > And the special map really doesn't fit.
> > Whatever we do, let's keep text_poke-able insn logic separate
> > from bookkeeping of addresses of those insns.
> > I think a special prefixed section that is understood by libbpf
> > (like what I proposed with "name.static_branch") will do fine.
> > If it's not good enough we can add a "set" map type
> > that will be a generic set of values.
> > It can be a set of 8-byte addresses to keep locations of static_branche=
s,
> > but let's keep it generic.
> > I think it's fine to add:
> > __uint(type, BPF_MAP_TYPE_SET)
> > and let libbpf populate it with addresses of insns,
> > or address of variables, or other values
> > when it prepares a program for loading.
>
> What is the higher-level API in this case? The static_branch_set(branch,
> bool on) is not enough because we want to distinguish between "normal"
> and "inverse" branches (for unlikely/likely cases).

What is "likely/unlikely cases" ?
likely() is a hint to the compiler to order basic blocks in
a certain way. There is no likely/unlikely bit in the binary code
after compilation on x86 or other architectures.

There used to be a special bit on sparc64 that would mean
a default jmp|fallthrough action for a conditional jmp.
But that was before sparc became out of order and gained proper
branch predictor in HW.

>  We can implement
> this using something like this:
>
> static_key_set(key, bool new_value)
> {
>     /* true if we change key value */
>     bool key_changed =3D key->old_value ^ new_value;
>
>     for_each_prog(prog, key)
>         for_each_branch(branch, prog, key)
>             static_branch_flip(prog, branch, key_changed)
> }
>
> where static_branch_flip flips the second bit of SRC_REG.

I don't understand why you keep bringing up 'flip' use case.
The kernel doesn't have such an operation on static branches.
Which makes me believe that it wasn't necessary.
Why do we need one for the bpf static branch?

> We need to
> keep track of prog->branches and key->progs. How is this different
> from what my patch implements?

What I'm proposing is to have a generic map __uint(type, BPF_MAP_TYPE_SET)
and by naming convention libbpf will populate it with addresses
of JA_OR_NOP from all progs.
In asm it could be:
asm volatile ("r0 =3D %[set_A] ll; goto_or_nop ...");
(and libbpf will remove ld_imm64 from the prog before loading.)

or via
asm volatile ("goto_or_nop ...; .pushsection set_A_name+suffix; .long");
(and libbpf will copy from the special section into a set and remove
special section).

It will be a libbpf convention and the kernel doesn't need
to know about a special static branch map type or array of addresses
in prog_load cmd.
Only JA insn is relevant to the verifier and JITs.

Ideally we don't need to introduce SET map type and
libbpf wouldn't need to populate it.
If we can make it work with an array of values that .pushsection + .long
automatically populates and libbpf treats it as a normal global data array
that would be ideal.
Insn addresses from all progs will be in that array after loading.
Sort of like ".kconfig" section that libbpf populates,
but it's a normal array underneath.

> If this is implemented in userspace, then how we prevent synchronous
> updates of the key (and a relocation variant doesn't seem to work from
> userspace)? Or is this a new kfunc? If yes, then how is it
> executed,

then user space can have small helper in libbpf that iterates
over SET (or array) and
calls sys_bpf(cmd=3DSTATIC_BRANCH_ENABLE, one_value_from_set)

Similar in the kernel. When bpf progs want to enable a key it does
bpf_for_each(set) { // open coded iterator
   bpf_static_branch_enable(addr); // kfunc call
}

