Return-Path: <bpf+bounces-17363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F280BFEA
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 04:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BA21C2090C
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264321641D;
	Mon, 11 Dec 2023 03:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbZb+O/5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF7EA
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 19:33:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33340c50af9so4201739f8f.3
        for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 19:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702265623; x=1702870423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sKK04kxxzdNmn7VQGcn2hkwY/961fnw/HrZCIZ/nUM=;
        b=MbZb+O/5dTfc3f51stis7/yxUAL9xUTXAPsIbXnqnYaxY70B7gp8EJsGRc1umjZH52
         YxPulMZ0VS27gu0usF/MoRE8oFHHWFLbx0v4jZO1Pzm+AZgyGuSX6uWUGievgTFskdrh
         STzvWzPip/lw4KBB4XvzYW+Rs9WrNjHoYuLQbFLH32XxW6/r1sHpcXG+W5dlA2FZ4jNt
         umC8DdQ9ptHMWhpYhW1ihc0IMsx9cib0hSEjIXpTLvrH9p6aXm2c2qrGoRjLQvxmMoY1
         OACJQ8wDWB3xNjFDU9DUGAEfHYsqmBZ3HTIazzqpNVR3xCAi1tMlpq+hAjFpCJho10PU
         oMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702265623; x=1702870423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sKK04kxxzdNmn7VQGcn2hkwY/961fnw/HrZCIZ/nUM=;
        b=u3YlclcHss0A+uTc8pF+JdnYZjalvhsPZcgTGMVb1gw6AxS77D7rJQknJo5Uc0cNhN
         9Sz4WcAU1XszwERxHiE7ryJq1cU4jMtBpB0vPlQaE7bIjJEGl66Dcv+NWD58HX8yKPXt
         LoB8dl2FM2MhzDbRcwILFQhdHxFxV81VxYPxlXDuQiXFVWz4OVNsFj65cQECm9kVviwv
         xowDyuZnqy94BmtvJofGfzUAkedyqHvrbWjbn31oFVlYzLfao+L9BKhbd4GbGYF5eaN1
         8MaP2H8hTz/gv4Wyy53WMLMcCh/dJd4KSkqzxdx5M2OZNffBXNkrx75Wkfom8Rul5FXI
         X9BA==
X-Gm-Message-State: AOJu0YwQOqxQUxxSYDUL8c8FAmqFvVtb0RBsANDSEVjMbRCceqnYMbLa
	ewlffT+R4Yqp7xXwGIMmA+wDpVWzqe11xa7ur5Y=
X-Google-Smtp-Source: AGHT+IFphaTetg1O6j7pYPLQeI41RsIjaONUR9HBrhJdv99OlWdpOWU4YN1+kYK7Ac7yQOCrkN8t/Sps6tHM/76/ikc=
X-Received: by 2002:a05:600c:518e:b0:40c:4292:1e59 with SMTP id
 fa14-20020a05600c518e00b0040c42921e59mr605347wmb.117.1702265622837; Sun, 10
 Dec 2023 19:33:42 -0800 (PST)
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
In-Reply-To: <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 10 Dec 2023 19:33:31 -0800
Message-ID: <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Anton Protopopov <aspsk@isovalent.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 2:30=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> How about a slightly different modification of the Anton's idea.
> Suppose that, as before, there is a special map type:
>
>     struct {
>         __uint(type, BPF_MAP_TYPE_ARRAY);
>         __type(key, __u32);
>         __type(value, __u32);
>         __uint(map_flags, BPF_F_STATIC_KEY);
>         __uint(max_entries, 1);
>     } skey1 SEC(".maps")

Instead of special map that the kernel has to know about
the same intent can be expressed with:
int skey1;
r0 =3D %[skey1] ll;
and then the kernel needs no extra map type while the user space
can collect all static_branches that use &skey1 by
iterating insn stream and comparing addresses.

> Which is used as below:
>
>     __attribute__((naked))
>     int foo(void) {
>       asm volatile (
>                     "r0 =3D %[skey1] ll;"
>                     "if r0 !=3D r0 goto 1f;"
>                     "r1 =3D r10;"
>                     "r1 +=3D -8;"
>                     "r2 =3D 1;"
>                     "call %[bpf_trace_printk];"
>             "1:"
>                     "exit;"
>                     :: __imm_addr(skey1),
>                        __imm(bpf_trace_printk)
>                     : __clobber_all
>       );
>     }
>
> Disassembly of section .text:
>
> 0000000000000000 <foo>:
>        0:   r0 =3D 0x0 ll
>         0000000000000000:  R_BPF_64_64  skey1  ;; <---- Map relocation as=
 usual
>        2:   if r0 =3D=3D r0 goto +0x4 <foo+0x38>   ;; <---- Note conditio=
n
>        3:   r1 =3D r10
>        4:   r1 +=3D -0x8
>        5:   r2 =3D 0x1
>        6:   call 0x6
>        7:   exit
>
> And suppose that verifier is modified in the following ways:
> - treat instructions "if rX =3D=3D rX" / "if rX !=3D rX" (when rX points =
to
>   static key map) in a special way:
>   - when program is verified, the jump is considered non deterministic;
>   - when program is jitted, the jump is compiled as nop for "!=3D" and as
>     unconditional jump for "=3D=3D";
> - build a table of static keys based on a specific map referenced in
>   condition, e.g. for the example above it can be inferred that insn 2
>   associates with map skey1 because "r0" points to "skey1";
> - jit "rX =3D <static key> ll;" as nop;
>
> On the plus side:
> - any kinds of jump tables are omitted from system call;
> - no new instruction is needed;
> - almost no modifications to libbpf are necessary (only a helper macro
>   to convince clang to keep "if rX =3D=3D rX");

Reusing existing insn means that we're giving it new meaning
and that always comes with danger of breaking existing progs.
In this case if rX =3D=3D rX isn't very meaningful and new semantics
shouldn't break anything, but it's a danger zone.

If we treat:
if r0 =3D=3D r0
as JA
then we have to treat
if r1 =3D=3D r1
as JA as well and it becomes ambiguous when prog_info needs
to return the insns back to user space.

If we go with rX =3D=3D rX approach we should probably limit it
to one specific register. r0, r10, r11 can be considered
and they have their own pros and cons.

Additional:
r0 =3D %[skey1] ll
in front of JE/JNE is a waste. If we JIT it to useless native insn
we will be burning cpu for no reason. So we should probably
optimize it out. If we do so, then this inline insn becomes a nop and
it's effectively a relocation. The insn stream will carry this
rX =3D 64bit_const insn to indicate the scope of the next insn.
It's pretty much like Anton's idea of using extra bits in JA
to encode an integer key_id.
With ld_imm64 we will encode 64-bit key_id.
Another insn with more bits to burn that has no effect on execution.

It doesn't look clean to encode so much extra metadata into instructions
that JITs and the interpreter have to ignore.
If we go this route:
  r11 =3D 64bit_const
  if r11 =3D=3D r11 goto
is a lesser evil.
Still, it's not as clean as JA with extra bits in src_reg.
We already optimize JA +0 into a nop. See opt_remove_nops().
So a flavor of JA insn looks the most natural fit for a selectable
JA +xx or JA +0.

And the special map really doesn't fit.
Whatever we do, let's keep text_poke-able insn logic separate
from bookkeeping of addresses of those insns.
I think a special prefixed section that is understood by libbpf
(like what I proposed with "name.static_branch") will do fine.
If it's not good enough we can add a "set" map type
that will be a generic set of values.
It can be a set of 8-byte addresses to keep locations of static_branches,
but let's keep it generic.
I think it's fine to add:
__uint(type, BPF_MAP_TYPE_SET)
and let libbpf populate it with addresses of insns,
or address of variables, or other values
when it prepares a program for loading.
But map_update_elem should never be doing text_poke on insns.
We added prog_array map type is the past, but that was done
during the early days. If we were designing bpf today we would have
gone a different route.

