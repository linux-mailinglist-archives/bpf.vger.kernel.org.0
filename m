Return-Path: <bpf+bounces-78898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52784D1F117
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70319302C9FD
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AEE39B4B0;
	Wed, 14 Jan 2026 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv9tX6eu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBCB399014
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397298; cv=none; b=Q2Zdt31HKxBWp7/WhyAHUOqth4oArb9B2sOtvRPT7L5e+oXlQFtZOmEf+HgiIM7mTOFEq49QrRlYPhyB+RDvlMwrWknegm69AKKfbckoA/JhkD4Yse8qAW6RDnxxEGHRz6NCNa4VB6wEgnfKsHXuZ3qwK4xjcJ5SDgXQD20CsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397298; c=relaxed/simple;
	bh=Im6bFFOWCZHNQmvVcStDOCqucQWQnhngVNCS+3mOv7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaSQbW1VeZPDM/Ve7BAZxHhNDRm1dQ+xOzTSWYOrd8U1GNz8k4S1hWsDn5bAVvODyP/iIKL++MLKn5UPoX/GZJ2rgdRu5uV4waUylMVzQNP27eNBkokoaJOa5p5L5QyVbZLNMehMypnOPUT9H/vRanvCL+Gv8q40wRC2xgeoZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv9tX6eu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b876798b97eso102533266b.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 05:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768397295; x=1769002095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPuWU9//ujmew4iC2kB4nYXlchEdkz9YGRuomWYtLeA=;
        b=Hv9tX6eukJGSkB7qkwqOm9L5UITah8rzceq03fxkqssiY5/9rkTGOuECBz68xjG6mK
         P+9UqcI27FE93exLMOim9KIzhf6d2vA5YTx6hDOffw9yQ/RMgL4KrNcV3aDLcVwDJEH5
         vNLRxJm38snERqt6IIVNuweQfr5Dygd2dZ+KNtSEtdP1D5oWqj81LQpUr9SUjwqZeXGe
         xuepS/N2ScJa0Ji+ukCxiW4FK7BVIzcxBu+MJoWAvZCOiwS+cjCxWJSpGUnTdHen7z8I
         0lYYOT/yYHfPsA/+M8MTvD2SpVO1CfRiFvydWSfm+U/d1OkVIufPfFpPbzpDWBbiS6xq
         xtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768397295; x=1769002095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPuWU9//ujmew4iC2kB4nYXlchEdkz9YGRuomWYtLeA=;
        b=Wvbd/kywSe55hTUMM607rQSRi9xM06r7iWR8+TW6CQ5PZMKtyE4qJHghWkCGZpk5i4
         aX3FNqcAa/S6Td48BKfXh/RW2C/wNPHe9JaerAr7jes8qBasSv+Sr7VjaK8IxH6AgJDd
         bU+CJfT88zFmtoAt25PA6Dcqz8XNBFTaZrpl3SumEuFPJ76nPMjM4LfD66BSmysGj+Ht
         QdGQfQJUijTAfPG08MzNNr8XufJN2OgIle4GTyDGKBZZaeghUDF8SLASnRzZwK6jzAJU
         g/a8YITh5GV9KXLWEv4uK0lPnZ2P6Bx+HvGe7GwSKloN6d36X2ulD9YVfZXRPAhMHxRi
         RsMw==
X-Gm-Message-State: AOJu0YyZZmy7sAMUFQoP2MPPn1CPt0etWcwN3xJGjrRQljca69gMhg3P
	WMICmeNYq4gdbkcTVhud6SU1wNafRSkJZSYpy52joJfSdc2A6zFKxuF5aZJrpAntGDQvNlnTZFJ
	rqAHoyLhuHpPG3GGsX+oVCZVnn17+7+A=
X-Gm-Gg: AY/fxX6qWW8smpKgQGhymrPOgPW6wOZQ2EHQZyJJ4YuYkyLEXqKuOdHJeTMj1DynAbB
	ir0z6tWkGG65FaG0bYxHDpHqGkwg65XhhJ6rZ39PUQMMiP0CE0/LmuytMdp0CVsYhqHuPjyzrNA
	85LAJyJAHMrxnlJ/I6/br0YBFXALpSm7jPTi5qdRjijq2tw/if3Tf22ZNaBJr2fx1hfAvDooo77
	jb2XL/tLrnPkehJQkDQXHHf1pLKD33xpAcCRXx9LqUzifqnS1PyF96c1/pzXiDnRRNLBZw=
X-Received: by 2002:a17:907:6d14:b0:b7d:1d1b:217a with SMTP id
 a640c23a62f3a-b87611110eamr199892866b.34.1768397294753; Wed, 14 Jan 2026
 05:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113152529.3217648-1-puranjay@kernel.org> <20260113152529.3217648-2-puranjay@kernel.org>
 <0f112826107932ab0a6c897505e9e4c13c999527.camel@gmail.com>
In-Reply-To: <0f112826107932ab0a6c897505e9e4c13c999527.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 14 Jan 2026 14:28:03 +0100
X-Gm-Features: AZwV_QhLcpBIuqvwA0YxNFPvcHSbOt0ONRVTURTyi7xtxNyChNK7giKCR7ZFG90
Message-ID: <CANk7y0j7RndsruVO3H2ymy+gKdr9i=+ceLuwyDjMp08jGKmcDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support negative offsets, BPF_SUB,
 and alu32 for linked register tracking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 4:27=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-01-13 at 07:25 -0800, Puranjay Mohan wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 53635ea2e41b..8a4f00d237ee 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15706,26 +15706,41 @@ static int adjust_reg_min_max_vals(struct bpf=
_verifier_env *env,
> >        * r1 +=3D 0x1
> >        * if r2 < 1000 goto ...
> >        * use r1 in memory access
> > -      * So for 64-bit alu remember constant delta between r2 and r1 an=
d
> > -      * update r1 after 'if' condition.
> > +      * So remember constant delta between r2 and r1 and update r1 aft=
er
> > +      * 'if' condition.
> >        */
> >       if (env->bpf_capable &&
> > -         BPF_OP(insn->code) =3D=3D BPF_ADD && !alu32 &&
> > -         dst_reg->id && is_reg_const(src_reg, false)) {
> > -             u64 val =3D reg_const_value(src_reg, false);
> > +         (BPF_OP(insn->code) =3D=3D BPF_ADD || BPF_OP(insn->code) =3D=
=3D BPF_SUB) &&
> > +         dst_reg->id && is_reg_const(src_reg, alu32)) {
> > +             u64 val =3D reg_const_value(src_reg, alu32);
> > +             s32 off;
> >
> > -             if ((dst_reg->id & BPF_ADD_CONST) ||
> > -                 /* prevent overflow in sync_linked_regs() later */
> > -                 val > (u32)S32_MAX) {
> > +             if (!alu32 && ((s64)val < S32_MIN || (s64)val > S32_MAX))
> > +                     goto clear_id;
> > +
> > +             off =3D (s32)val;
> > +
> > +             if (BPF_OP(insn->code) =3D=3D BPF_SUB) {
> > +                     /* Negating S32_MIN would overflow */
> > +                     if (off =3D=3D S32_MIN)
> > +                             goto clear_id;
> > +                     off =3D -off;
> > +             }
> > +
> > +             if (dst_reg->id & BPF_ADD_CONST) {
>
> This logic is not correct, consider the following example:
>
>     SEC("socket")
>     __success
>     __naked void bug1(void)
>     {
>             asm volatile ("                                 \
>             call %[bpf_get_prandom_u32];                    \
>             r1 =3D r0;                                        \
>             w1 +=3D 1;                                        \
>             if r1 > 10 goto 1f;                             \
>             r0 >>=3D 32;                                      \
>             if r0 =3D=3D 0 goto 1f;                             \
>             r0 /=3D 0;                                        \
>     1:                                                      \
>             r0 =3D 0;                                         \
>             exit;                                           \
>     "       :
>             : __imm(bpf_get_prandom_u32)
>             : __clobber_all);
>     }
>
> It is verified as follows:
>
>     Global function bug1() doesn't return scalar. Only those are supporte=
d.
>     0: R1=3Dctx() R10=3Dfp0
>     ; asm volatile ("                                       \ @ verifier_=
linked_scalars.c:266
>     0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
>     1: (bf) r1 =3D r0                       ; R0=3Dscalar(id=3D1) R1=3Dsc=
alar(id=3D1)
>     2: (04) w1 +=3D 1                       ; R1=3Dscalar(id=3D1+1,smin=
=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
>     3: (25) if r1 > 0xa goto pc+3         ; R1=3Dscalar(id=3D1+1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D10,var_off=3D(0x0; 0xf))
>     4: (77) r0 >>=3D 32                     ; R0=3D0
>     5: (15) if r0 =3D=3D 0x0 goto pc+1
>     mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
>     mark_precise: frame0: regs=3Dr0 stack=3D before 4: (77) r0 >>=3D 32
>     mark_precise: frame0: regs=3Dr0 stack=3D before 3: (25) if r1 > 0xa g=
oto pc+3
>     mark_precise: frame0: regs=3Dr0,r1 stack=3D before 2: (04) w1 +=3D 1
>     mark_precise: frame0: regs=3Dr0,r1 stack=3D before 1: (bf) r1 =3D r0
>     mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_=
prandom_u32#7
>     5: R0=3D0
>     7: (b7) r0 =3D 0                        ; R0=3D0
>     8: (95) exit
>
>     from 3 to 7: R0=3Dscalar(id=3D1+0,smin=3D0,smax=3D0xffffffff,umin=3Du=
min32=3D10,umax=3Dumax32=3D0xfffffffe,var_off=3D(0x0; 0xffffffff)) R1=3Dsca=
lar(id=3D1+1,smin=3Dumin=3Dumin32=3D11,smax=3Dumax=3D0xffffffff,var_off=3D(=
0x0; 0xffffffff)) R10=3Dfp0
>     7: R0=3Dscalar(id=3D1+0,smin=3D0,smax=3D0xffffffff,umin=3Dumin32=3D10=
,umax=3Dumax32=3D0xfffffffe,var_off=3D(0x0; 0xffffffff)) R1=3Dscalar(id=3D1=
+1,smin=3Dumin=3Dumin32=3D11,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfff=
fffff)) R10=3Dfp0
>     7: (b7) r0 =3D 0                        ; R0=3D0
>     8: (95) exit
>     processed 10 insns (limit 1000000) max_states_per_insn 0 total_states=
 1 peak_states 1 mark_read 0
>
> The problem here is that at instruction `2: w1 +=3D 1` id of the
> register is preserved, while this instruction destructs higher bits of
> the register.
>
> After each instruction you must maintain that for a set of linked registe=
rs R
> =E2=88=80 r =E2=88=88 R: value(r) - off(r) =3D=3D C, where C is some cons=
tant representing the id.
> This is not the case for operation `w1 +=3D 1` if you don't make sure
> prior to the operation that upper bits of `r1` are zero.


Thanks for the detailed explanation. My fix of BPF_ADD_CONST32 and
BPF_ADD_CONST64 was trying to fix the symptom but not the bug. As you
explained, the link should be broken if we do an alu32 operation and
the upper 32 bits are non-zero. I will fix it properly and send the
next version.

