Return-Path: <bpf+bounces-19137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A4825956
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5692B1C235AF
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CBC328BC;
	Fri,  5 Jan 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB3sJFzX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07710328B7
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368b1e056eso1478470f8f.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 09:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704476833; x=1705081633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwDrNHWs+nclnCLGKPo8QPG6tUeZD4KYs3OfiL8rxWY=;
        b=CB3sJFzXPtECDbwXcuapwtpirtAqj0W8NUrUKjwGkmaDLl5xc2i3IKyAil6UiyGrwU
         LbIYCJum11ynIr4cseDNc6nJ2U+XCQQg/ZyoamYD3IKcTo9GPFxYoqPcSImdKJBIc0dR
         Yep0rxnSW5kGp3jH7Vqs7Jx1NPDJcKlKKaKxuV8Ryo/piWiqm9ToFHXcsTr68pRB/7mP
         UYqVQrajEqY0/YKzRNU91CDi0AX7Nn+YibcRfEZOl0WQfX6QRpOqHIP2YYhcddvusHz8
         g1LkyBeC+S8m7OlQQnc6b0UoIR874bh8TwhgaeECLiG9jJJ/h/oNEU4V6zArn+cl1nP0
         kBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476833; x=1705081633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwDrNHWs+nclnCLGKPo8QPG6tUeZD4KYs3OfiL8rxWY=;
        b=IX+7ZtswVf2N++Ia2/NYeLqWmA6bkMsCR3R6ZcQQ0mCcl0TVNH+yN2IVizj+3eR7ut
         rz/nOF0M9sj+ZiAghrVr87umPh3aB8Davu6km/hUza3Ys3k8hgoZytt1f6lTqSBBaONs
         UtRNjNCBxO86tHVvWPegTyTheULZQXYlNewmNGQU0uLRiCjRgmKirT4G4t5iPAedNHbr
         OZ792fhMX096L1F+Dnpnzpg4w7hEgKVdKiCs2vMqjZAY6C2UURSMyrpJmnARiT7cMnJ4
         Nln4n1L0gfpcKyZigtIRCbTQeJft4bQSlqJ29Vk5q9MPBd7+obKZBdazwiEKJgOpMl8Q
         xyOA==
X-Gm-Message-State: AOJu0Ywwez0GL9PBg45x4WdPWw40iclBBE+O6/7ESqISED2sjxqYyuvz
	V+KxqNC1qVFSpYxhbSF6uNo44JKpt+s6XhkKxns=
X-Google-Smtp-Source: AGHT+IF4mF18YHRQiLCANZYDUqjOSyFEyhJpP1rzNnWOskHJVvxWmPDttxtexcLT7dNmcc8MebvjEXW5cX58On38sqE=
X-Received: by 2002:adf:f78d:0:b0:336:677f:bd06 with SMTP id
 q13-20020adff78d000000b00336677fbd06mr1235318wrp.110.1704476833155; Fri, 05
 Jan 2024 09:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com> <b2f808ba-56c9-4104-939a-4eed36159bd4@gmail.com>
In-Reply-To: <b2f808ba-56c9-4104-939a-4eed36159bd4@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Jan 2024 09:47:02 -0800
Message-ID: <CAADnVQ+qh0KFJkmRo5NxhfHS2othCJU=q=jcPrr2pNUGSUvR6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:34=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
>
> On 5/1/24 12:15, Alexei Starovoitov wrote:
> > On Thu, Jan 4, 2024 at 6:23=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com>=
 wrote:
> >>
> >>
> >> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> >> index fe30b9ebb8de4..67fa337fc2e0c 100644
> >> --- a/arch/x86/net/bpf_jit_comp.c
> >> +++ b/arch/x86/net/bpf_jit_comp.c
> >> @@ -259,7 +259,7 @@ struct jit_context {
> >>  /* Number of bytes emit_patch() needs to generate instructions */
> >>  #define X86_PATCH_SIZE         5
> >>  /* Number of bytes that will be skipped on tailcall */
> >> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
> >> +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
> >>
> >>  static void push_r12(u8 **pprog)
> >>  {
> >> @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_=
depth, bool ebpf_from_cbpf,
> >>          */
> >>         emit_nops(&prog, X86_PATCH_SIZE);
> >>         if (!ebpf_from_cbpf) {
> >> -               if (tail_call_reachable && !is_subprog)
> >> +               if (tail_call_reachable && !is_subprog) {
> >>                         /* When it's the entry of the whole tailcall c=
ontext,
> >>                          * zeroing rax means initialising tail_call_cn=
t.
> >>                          */
> >> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
> >> -               else
> >> -                       /* Keep the same instruction layout. */
> >> -                       EMIT2(0x66, 0x90); /* nop2 */
> >> +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
> >> +                       EMIT1(0x50);             /* push rax */
> >> +                       /* Make rax as ptr that points to tail_call_cn=
t. */
> >> +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
> >> +                       EMIT1_off32(0xE8, 2);    /* call main prog */
> >> +                       EMIT1(0x59);             /* pop rcx, get rid o=
f tail_call_cnt */
> >> +                       EMIT1(0xC3);             /* ret */
> >> +               } else {
> >> +                       /* Keep the same instruction size. */
> >> +                       emit_nops(&prog, 13);
> >> +               }
> >
> > I'm afraid the extra call breaks stack unwinding and many other things.
> > The proper frame needs to be setup (push rbp; etc)
> > and 'leave' + emit_return() is used.
> > Plain 'ret' is not ok.
> > x86_call_depth_emit_accounting() needs to be used too.
> > That will make X86_TAIL_CALL_OFFSET adjustment very complicated.
> > Also the fix doesn't address the stack size issue.
> > We shouldn't allow all the extra frames at run-time.
> >
> > The tail_cnt_ptr approach is interesting but too heavy,
> > since arm64, s390 and other JITs would need to repeat it with equally
> > complicated calculations in TAIL_CALL_OFFSET.
> >
> > The fix should really be thought through for all JITs. Not just x86.
> >
> > I'm thinking whether we should do the following instead:
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index 0bdbbbeab155..0b45571559be 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -910,7 +910,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *=
map,
> >         if (IS_ERR(prog))
> >                 return prog;
> >
> > -       if (!bpf_prog_map_compatible(map, prog)) {
> > +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cnt)=
 {
> >                 bpf_prog_put(prog);
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > This will stop stack growth, but it will break a few existing tests.
> > I feel it's a price worth paying.
>
> I don't think this can avoid this issue completely.
>
> For example:
>
> #include "vmlinux.h"
>
> #include "bpf_helpers.h"
>
> struct {
>     __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>     __uint(max_entries, 1);
>     __uint(key_size, sizeof(__u32));
>     __uint(value_size, sizeof(__u32));
> } prog_array SEC(".maps");
>
>
> static __noinline int
> subprog(struct __sk_buff *skb)
> {
>     volatile int retval =3D 0;
>
>     bpf_tail_call(skb, &prog_array, 0);
>
>     return retval;
> }
>
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
>     const int N =3D 10000;
>
>     for (int i =3D 0; i < N; i++)
>         subprog(skb);
>
>     return 0;
> }
>
> char _license[] SEC("license") =3D "GPL";
>
> Then, objdump its asm:
>
> Disassembly of section .text:
>
> 0000000000000000 <subprog>:
> ; {
>        0:       b7 02 00 00 00 00 00 00 r2 =3D 0x0
> ;     volatile int retval =3D 0;
>        1:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) =3D r2
> ;     bpf_tail_call(skb, &prog_array, 0);
>        2:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 =3D 0x=
0 ll
>        4:       b7 03 00 00 00 00 00 00 r3 =3D 0x0
>        5:       85 00 00 00 0c 00 00 00 call 0xc
> ;     return retval;
>        6:       61 a1 fc ff 00 00 00 00 r1 =3D *(u32 *)(r10 - 0x4)
>        7:       95 00 00 00 00 00 00 00 exit
>
> Disassembly of section tc:
>
> 0000000000000000 <entry>:
> ; {
>        0:       bf 16 00 00 00 00 00 00 r6 =3D r1
>        1:       b7 07 00 00 10 27 00 00 r7 =3D 0x2710
>
> 0000000000000010 <LBB0_1>:
> ;         subprog(skb);
>        2:       bf 61 00 00 00 00 00 00 r1 =3D r6
>        3:       85 10 00 00 ff ff ff ff call -0x1
> ;     for (int i =3D 0; i < N; i++)
>        4:       07 07 00 00 ff ff ff ff r7 +=3D -0x1
>        5:       bf 71 00 00 00 00 00 00 r1 =3D r7
>        6:       67 01 00 00 20 00 00 00 r1 <<=3D 0x20
>        7:       77 01 00 00 20 00 00 00 r1 >>=3D 0x20
>        8:       15 01 01 00 00 00 00 00 if r1 =3D=3D 0x0 goto +0x1 <LBB0_=
2>
>        9:       05 00 f8 ff 00 00 00 00 goto -0x8 <LBB0_1>
>
> 0000000000000050 <LBB0_2>:
> ;     return 0;
>       10:       b7 00 00 00 00 00 00 00 r0 =3D 0x0
>       11:       95 00 00 00 00 00 00 00 exit
>
> As a result, the bpf prog in prog_array can be tailcalled for N times,
> even though there's no subprog in the bpf prog in prog_array.

You mean that total execution time is N*N ?
and tailcall is a way to increase loop count?
We allow BPF_MAX_LOOPS =3D 8 * 1024 * 1024 in bpf_loop,
so many calls to subprog(skb); is not an issue
as long as they don't stall cpu and don't increase stack size.

