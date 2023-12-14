Return-Path: <bpf+bounces-17756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F9812441
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF181C21408
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD7644;
	Thu, 14 Dec 2023 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBntZ0O/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341BDD;
	Wed, 13 Dec 2023 17:03:51 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a22ed5f0440so329238166b.1;
        Wed, 13 Dec 2023 17:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702515829; x=1703120629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3SrlC+hYpSzPLFr5CjSsgsdPY2n8eJmYDX6I87pUTc=;
        b=DBntZ0O/dXo5URmWdmvNcDuoMZUZkOvmo82um/rtkAgVQOiKk1IO4CrpymynbuMkdr
         Tou9QUl6749O+gWBa2r+HDpszzpGs+v3XLzhi1QQtfZH3deT+Jsf3RY7F48OcYYmCxKA
         HYDr4FWlUE0CK9sykxG4l1CnqyFDm/tjaMFhfkscz3MqICg36dsVGbjQd6RmHCCcf3/R
         YjTRaGdrH82TAfWfqZTsR13AwOfPP5aiWXhYBUNLFKN3lr3FmfxiqjBP1fq5+8ZsdKOb
         +ogug6gsdE2lSKXYIc2DmDmfuTdmArkJiGF9vBiaWjz4QuRhdIWgjy4RTACU+2TXDAZM
         PQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515829; x=1703120629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3SrlC+hYpSzPLFr5CjSsgsdPY2n8eJmYDX6I87pUTc=;
        b=PqbMj+hfxQhr2wOumKkRNkW2cFO+PQ5jXg6vq4XMLUPDm7FQ9k13gc1nbwn9zOJo5w
         J4XRwXNZs41q9zT4OUyHxrdm6YWIk/KHmQXdsetbn3EBssI0tdi7cy/HrSKrtf/8ZR+o
         WHGUuwF++Zi13jDU5K6lag5sLcyud66ldM4bE9jm3FQi2+Hl4ddJN+svOHelhe5O+AA8
         mnQt88vsKjJDUGlfKOJ6Pv9nwQSVEOeQsbaJc5pXwgINn1CLGA+3yP8wFQ9Fg2IIXCFP
         z9U6Y5FnLQjsRtnJokKSmKGJLsAbmlU8ZlZGTycKDU0czgtzC2Z6AaAFQpzlCaEuYGRN
         +ZDw==
X-Gm-Message-State: AOJu0YxMnXd1sqbgui9QTmFTFVmGfhCpibacc4tq1MEImTLAkU3gAshx
	hvqfG/xqbNG2pZxNtzhFG6YQSutZh/LT/u08V2I=
X-Google-Smtp-Source: AGHT+IHtdAC0Njvzbhql3hnkBalQDvwqLHHiYtb7gJxUQoTrEykoi/Iw+Z87qLn/YqRAsdlrl1ug0++YSdsDfz3utkI=
X-Received: by 2002:a17:906:10cb:b0:a1f:99e1:8a65 with SMTP id
 v11-20020a17090610cb00b00a1f99e18a65mr2364384ejv.155.1702515829319; Wed, 13
 Dec 2023 17:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsaecr+VjmfOHzaMbiei5G3WMDjvjp4kZVE79Bn8ib1-Rg@mail.gmail.com>
 <CAEf4BzYVRwpP6TbXdJeFwMot80FodexyOk2_Y9H2tsJC-3FBUA@mail.gmail.com> <CACkBjsae4bwde6133GrUh-2EcdEhKjb9zj5baRyUxyxdhqQUfQ@mail.gmail.com>
In-Reply-To: <CACkBjsae4bwde6133GrUh-2EcdEhKjb9zj5baRyUxyxdhqQUfQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 17:03:37 -0800
Message-ID: <CAEf4BzY=a==C3-ww4GxdLQa=mdCia7Yq+SD8t7B6Ak4oRf+vAg@mail.gmail.com>
Subject: Re: [Bug Report] bpf: reg invariant voilation after JSLE
To: Hao Sun <sunhao.th@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:44=E2=80=AFPM Hao Sun <sunhao.th@gmail.com> wrot=
e:
>
> On Wed, Nov 29, 2023 at 6:43=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Nov 21, 2023 at 7:08=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> w=
rote:
> > >
> > > Hi,
> > >
> > > The following program (reduced) breaks reg invariant:
> > >
> > > C Repro: https://pastebin.com/raw/SRQJYx91
> > >
> > > -------- Verifier Log --------
> > > func#0 @0
> > > 0: R1=3Dctx() R10=3Dfp0
> > > 0: (b7) r0 =3D -2                       ; R0_w=3D-2
> > > 1: (37) r0 /=3D 1                       ; R0_w=3Dscalar()
> > > 2: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=
=3Dscalar(id=3D1)
> > > 3: (56) if w8 !=3D 0xfffffffe goto pc+4         ;
> > > R8_w=3Dscalar(id=3D1,smin=3D0x80000000fffffffe,smax=3D0x7ffffffffffff=
ffe,umin=3Dumin32=3D0xfffffffe,umax=3D0xfffffffffffffffe,smin32=3D-2,smax32=
=3D-2,umax32=3D0xfffffffe,var_off=3D(0xfffffffe;
> > > 0xffffffff00000000))
> >
> > this part looks suspicious, I'll take a look a bit later
> >

No, it actually is fine. We know that lower 32 bits are exactly
0xfffffffe (-2), and we propagate that into smin/smax, which are
narrowed from [0x80....00, 0x7ffff...ff] to [0x80000000fffffffe,
0x7ffffffffffffffe]. This all looks correct so far. This is not the
issue.


> > > 4: (65) if r8 s> 0xd goto pc+3        ;
> > > R8_w=3Dscalar(id=3D1,smin=3D0x80000000fffffffe,smax=3D13,umin=3Dumin3=
2=3D0xfffffffe,umax=3D0xfffffffffffffffe,smin32=3D-2,smax32=3D-2,umax32=3D0=
xfffffffe,var_off=3D(0xfffffffe;
> > > 0xffffffff00000000))
> > > 5: (b7) r4 =3D 2                        ; R4_w=3D2
> > > 6: (dd) if r8 s<=3D r4 goto pc+1
> > > REG INVARIANTS VIOLATION (false_reg1): range bounds violation
> > > u64=3D[0xfffffffe, 0xd] s64=3D[0xfffffffe, 0xd] u32=3D[0xfffffffe, 0x=
d]
> > > s32=3D[0x3, 0xfffffffe] var_off=3D(0xfffffffe, 0x0)
> > > 6: R4_w=3D2 R8_w=3D0xfffffffe
> > > 7: (cc) w8 s>>=3D w0                    ; R0=3D0xfffffffe R8=3Dscalar=
()
> > > 8: (77) r0 >>=3D 32                     ; R0_w=3D0
> > > 9: (57) r0 &=3D 1                       ; R0_w=3D0
> > > 10: (95) exit
> > >
> > > from 6 to 8: safe
> > >
> > > from 4 to 8: safe
> > >
> > > from 3 to 8: safe
> > > processed 14 insns (limit 1000000) max_states_per_insn 0 total_states
> > > 1 peak_states 1 mark_read 1
> > >
> > >
> > > Besides, the verifier enforces the return value of some prog types to
> > > be zero, the bug may lead to programs with arbitrary values loaded.
> >
> > Generally speaking, if the verifier reports "REG INVARIANTS VIOLATION"
> > warning above, it doesn't necessarily mean that verifier has some bug.
> > We do know that in some conditions verifier doesn't detect conditions
> > that *will not* be taken, and in such cases we might get reg
> > invariants violation. But in such case verifier will revert to
> > conservative unknown scalar state, which is correct, even if
> > potentially unnecessarily pessimistic.
> >
>
> Yes, I'm aware of that, which is why I only selected two suspicious cases
> to report. Also, this is true after the check (5f99f312bd3be: bpf: add
> register bounds sanity checks and sanitization), but these cases may
> cause some issues in the previous releases. Your recent improvement in
> return value check also helps.
>
> I will see what I can do, maybe add more checks by using both tnum and
> ranges information in is_scalar_branch_taken().
>
> Thanks!

Ok, so I did take a look at this over last two days as well. There is
indeed a problem, and it's basically another variation on the same
issue: getting to the point of two disjoint ranges. Here's the repro
program in the form that's easy to compile and work with with
veristat:

+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 SUSE LLC */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("?raw_tp")
+__success __log_level(2)
+__naked int bpf_blah(void)
+{
+       asm volatile (
+               "r0 =3D -2;"
+               "r0 /=3D 1;"
+               "r8 =3D r0;"
+               "if w8 !=3D 0xfffffffe goto 1f;"
+               "if r8 s> 0xd goto 1f;"
+               "r4 =3D 2;"
+               "if r8 s<=3D r4 goto 1f;"
+               "w8 s>>=3D w0;"
+       "1:"
+               "r0 >>=3D 32;"
+               "r0 &=3D 1;"
+               "exit;"
+               ::: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";


The problem here is that we end up with the state of r8 before `if r8
s<=3D r4` (r4 is just 2, simple) where we estimate that 32-bit
subregister is -2 (0xfffffffe), while full smin/smax is some
0x8000....fffffe stuff. And so when we do comparison, we end up with
smin/smax estimate that is disjoint with 0xfffffffe (it's [3, 13] or
something like that in the fall through case). tnum is also
interferes, btw.

Anyways. I tried some ideas on how to prevent this. One of them is to
forget about 32-bit and opposite signedness estimates and re-derive
them in reg_bounds_sync(). The code below achieves this, but it breaks
a ton of other tests that expect tighter bounds. So it's not really a
solution, but I'll leave it below just to give an idea.

In short, this simultaneous 5 domain representation we use in register
state (tnum + s64 + u64 + s32 + u32) is really tricky to get right in
*all* possible cases, there are highly non-trivial interactions.
Perhaps someone can come up with the "unifying" implementation that
will be perfect, but for now reg_bounds_sanity_check() gives us a bit
of a safety net, at least.


commit 285068a77ca4e856faf695b41d17d7b5347ded0d (HEAD -> bpf-reg-bounds-deb=
ug)
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Wed Dec 13 09:27:22 2023 -0800

    bpf: reset irrelevant numeric domains in inequality conditionals

    Forfeit previous knowledge of other numeric domains, as they become
    invalidated anyways. If we don't reset them, they can bite us back with
    at best irrelevant and at worst wrong range estimates.

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb64203c5d89..dc3aaed15940 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1911,6 +1911,34 @@ static void __mark_reg32_unbounded(struct
bpf_reg_state *reg)
        reg->u32_max_value =3D U32_MAX;
 }

+static void __mark_reg32_signed_unbounded(struct bpf_reg_state *reg)
+{
+       reg->s32_min_value =3D S32_MIN;
+       reg->s32_max_value =3D S32_MAX;
+       reg->var_off =3D tnum_with_subreg(reg->var_off, tnum_unknown);
+}
+
+static void __mark_reg32_unsigned_unbounded(struct bpf_reg_state *reg)
+{
+       reg->u32_min_value =3D 0;
+       reg->u32_max_value =3D U32_MAX;
+       reg->var_off =3D tnum_with_subreg(reg->var_off, tnum_unknown);
+}
+
+static void __mark_reg64_signed_unbounded(struct bpf_reg_state *reg)
+{
+       reg->smin_value =3D S64_MIN;
+       reg->smax_value =3D S64_MAX;
+       reg->var_off =3D tnum_unknown;
+}
+
+static void __mark_reg64_unsigned_unbounded(struct bpf_reg_state *reg)
+{
+       reg->umin_value =3D 0;
+       reg->umax_value =3D U64_MAX;
+       reg->var_off =3D tnum_unknown;
+}
+
 static void __update_reg32_bounds(struct bpf_reg_state *reg)
 {
        struct tnum var32_off =3D tnum_subreg(reg->var_off);
@@ -14409,36 +14437,60 @@ static void regs_refine_cond_op(struct
bpf_reg_state *reg1, struct bpf_reg_state
                if (is_jmp32) {
                        reg1->u32_max_value =3D min(reg1->u32_max_value,
reg2->u32_max_value);
                        reg2->u32_min_value =3D max(reg1->u32_min_value,
reg2->u32_min_value);
+                       __mark_reg32_signed_unbounded(reg1);
+                       __mark_reg32_signed_unbounded(reg2);
                } else {
                        reg1->umax_value =3D min(reg1->umax_value,
reg2->umax_value);
                        reg2->umin_value =3D max(reg1->umin_value,
reg2->umin_value);
+                       __mark_reg64_signed_unbounded(reg1);
+                       __mark_reg64_signed_unbounded(reg2);
+                       __mark_reg32_unbounded(reg1);
+                       __mark_reg32_unbounded(reg2);
                }
                break;
        case BPF_JLT:
                if (is_jmp32) {
                        reg1->u32_max_value =3D min(reg1->u32_max_value,
reg2->u32_max_value - 1);
                        reg2->u32_min_value =3D max(reg1->u32_min_value
+ 1, reg2->u32_min_value);
+                       __mark_reg32_signed_unbounded(reg1);
+                       __mark_reg32_signed_unbounded(reg2);
                } else {
                        reg1->umax_value =3D min(reg1->umax_value,
reg2->umax_value - 1);
                        reg2->umin_value =3D max(reg1->umin_value + 1,
reg2->umin_value);
+                       __mark_reg64_signed_unbounded(reg1);
+                       __mark_reg64_signed_unbounded(reg2);
+                       __mark_reg32_unbounded(reg1);
+                       __mark_reg32_unbounded(reg2);
                }
                break;
        case BPF_JSLE:
                if (is_jmp32) {
                        reg1->s32_max_value =3D min(reg1->s32_max_value,
reg2->s32_max_value);
                        reg2->s32_min_value =3D max(reg1->s32_min_value,
reg2->s32_min_value);
+                       __mark_reg32_unsigned_unbounded(reg1);
+                       __mark_reg32_unsigned_unbounded(reg2);
                } else {
                        reg1->smax_value =3D min(reg1->smax_value,
reg2->smax_value);
                        reg2->smin_value =3D max(reg1->smin_value,
reg2->smin_value);
+                       __mark_reg64_unsigned_unbounded(reg1);
+                       __mark_reg64_unsigned_unbounded(reg2);
+                       __mark_reg32_unbounded(reg1);
+                       __mark_reg32_unbounded(reg2);
                }
                break;
        case BPF_JSLT:
                if (is_jmp32) {
                        reg1->s32_max_value =3D min(reg1->s32_max_value,
reg2->s32_max_value - 1);
                        reg2->s32_min_value =3D max(reg1->s32_min_value
+ 1, reg2->s32_min_value);
+                       __mark_reg32_unsigned_unbounded(reg1);
+                       __mark_reg32_unsigned_unbounded(reg2);
                } else {
                        reg1->smax_value =3D min(reg1->smax_value,
reg2->smax_value - 1);
                        reg2->smin_value =3D max(reg1->smin_value + 1,
reg2->smin_value);
+                       __mark_reg64_unsigned_unbounded(reg1);
+                       __mark_reg64_unsigned_unbounded(reg2);
+                       __mark_reg32_unbounded(reg1);
+                       __mark_reg32_unbounded(reg2);
                }
                break;
        case BPF_JGE:

