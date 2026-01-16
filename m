Return-Path: <bpf+bounces-79176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF71D2A8AF
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 04:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3878301D0DE
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 03:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCED3385B3;
	Fri, 16 Jan 2026 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3Jomh/q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D8258EE9
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768532951; cv=pass; b=baMu8bGamYxnonqQH1STU2bV7AV/8G6Gs1pmlV1G5jQuBNKKQ5Nj5jePb95jx4ldoQ2Gmw/kgQfJvuVOvXlbPpzPlSBFZRz7M/qmbMExK9EW72JjBJq7d6UY00mP6OP/+3aUKDgaKB/DcM81WPGt1gYfk2lGoJc2cmyIC8kPW1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768532951; c=relaxed/simple;
	bh=o+wb0HhfAjHefi8w1oFvRa5XqgZXNWf+79ibKBn2cEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1iuTyHqjMkExvd+oGaD80k7N+bNof/z5nH7bVwa5JRKB/0We1j0IycNoW+pA031Iv+KXPP2EJUFuDh3CX7xDi5gituO0ccaY/uXBXss5A5PMA3EdZXmoThlH7rde2QYJX15HZoBdpoDIYD/cte+GBRvdgnqUHTlsQleGj6YNS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3Jomh/q; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so9389655e9.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:09:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768532948; cv=none;
        d=google.com; s=arc-20240605;
        b=YHrpwhXAL9DRtgMO1quBi6MLKjEQZFbR82UdIpLuzT8/lSULpNCGOmaa7DBoLFB5N5
         kEIo1KilJ5/qii1M53O5fj6keNTBEY8kKxycSq0fxcz5RjucwfqxKR7SpR0F2MszZKFn
         DPE3hZh9MziB3ol1Y5n78PfZdSCmzGiflk6d6RjVJCMp3sMNIlVmI5OytFQ3HtmRH2QX
         rRXNMdW0aNIVNaVP6CCOl/fg/QShbwQfmvc8PB+BwpZwalGCtdKCQWoYpLStByEquBPg
         IDnMy/HLxAHnXzO9q5SqNUUJdfaUXRaflSTMkBJkcRNEfQ6+dOBjiGRNYDT5NkY4nVip
         uQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xYocvVK4L6qLbnMfm6XylvFO7S1SvCD5DiE0ZwY9R8=;
        fh=p4vdSA/l9PtCjzZNxpKkplvinhK0Lhq+qyrTMC9gefU=;
        b=cLJkZmmUACL39rGlaXTdw+pZaVzxyT2LQVqbFVeCnh1iG9F+i6oe3hk9zyGUWwaejl
         XanR3YBWZ0sWMkWF22Sxgq7SN2sG2puqxyGntm2QRgnCFnK6mQIyyYPEaIjCx8VP4vWk
         nuydsSLxX6MX+actN5LV7XhqfJtC3QvJ6RX80sn7RGfJGMRUWZlqtr99Awt8/5reXrH9
         ZOt711QxBleNaSyKIePz4jP9sz4x/ItkZd9TjpKTZTlgulRAAi3CMpm0elaZZWhTzFl9
         pn6mcVPZ7WQPfTv++h6w1GQejDLefCZXh/TNYcoRiwsBfonDJPaqtTAyiH52ddWXZbhu
         /i6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768532948; x=1769137748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xYocvVK4L6qLbnMfm6XylvFO7S1SvCD5DiE0ZwY9R8=;
        b=W3Jomh/qnsmPPw2Zlh/oqsacF0hvNL37Wi+rynFakM2i3wd7hB5GNIbjLEiYD67vtB
         z967Fy5v9B9VfegTToaq4lpkXlR6qjx44aRLMrWokKNq9gwxDN3dRCNPFRB1gLlHZGmn
         EN8QcMzjxkf2VodIsGfu2eSlLu+kxc3gTnyXwOgqj/zHlc8uZwW7gbjZIQLIZmB2ZJ6C
         1eTbkJfwDSMCjbJrMFpBebdOEyXEle27RXBtkh0+JtjkDgQvzdZkOPQzBLw0aUcfgcdq
         rxaN5qlxnWfsVhS7INyoKKKbgSj65WmGSgRCMVXJHPXsbeTgk2FSDxJmKyGODQU9/KqR
         s8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768532948; x=1769137748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xYocvVK4L6qLbnMfm6XylvFO7S1SvCD5DiE0ZwY9R8=;
        b=lL3OevmORXt0XRRvkkauz08ngDRVbVSVYlqGojCAwrVJkSiPxZpQFymtweeZIyCqR3
         tSMTtidFoNJeH8COvHLqj0LyDIh4WhUXHCClHxWeULACV/usMf72AGfeFzqKp5jjPdZQ
         m7F21UMBe611UjCp3wT70sTEhDtC+NZ4gCYpWwVHa3D6puXMYjQhCTJa9tsP37eJEJUL
         UxdWGEq42ryphtj0y0Pzwkca3Bi3djtGyxw1SfDVv2r/PNuc+5tXrY25mnsTTylVr6yu
         p4ds7WaLZol6L0vMkpIyeJxIcyGiHLc+U+yn8RduaL1CACCNN2qdfE9HoG0/kcfZYWq8
         jl4w==
X-Gm-Message-State: AOJu0Yw7m8mkZaaqgJAS9ejXSwSYjOaVyMJFzHMwT6xzA1OqRuU46QrO
	j3E2sK0+wUb6RudPNPldi8MY+mM+CcyoRdX2Fjd5TAgXO8MPWAiJoQwjEyN1L8gYuyTnABFPQlE
	pUBuE7KbuaIR1XiSqyIVXagKjqKTz8so=
X-Gm-Gg: AY/fxX6fM3NzIOAbQEeApO0OIK5L5yNwfPfQlqx8cw1kiInao4qgy1cvn+/0S2ji9df
	WELLWwVzSwXEXJvnGBzfFnYVlFjCxQBoAnDPNVZMlzGhYye0CabIq3+jhvhN3ZeFA0TRZb0b0BU
	icLTu+bbYGDTXxKP69jekfYEnyIvlDgtfhENk3eqD5epS82D3ZblEMoqtSNwC26aYhBI+ZDuGJx
	JqFSOwun1CCdp4XMYdMsi31L9NcnxRHNtJsqSDcW61I9ajP8WkMzPb7m9btZN2K5mtC3A+U+yWg
	uO4GfME6sZ+4LkT5//8iPneVSzdqXE3bX/tzda1GD3cME+Jy4w6aSfZWRfEM8vYAdnxMCESUZeI
	6HO9E46YJSOmzDg==
X-Received: by 2002:a05:6000:2f85:b0:432:e00b:8669 with SMTP id
 ffacd0b85a97d-4356a029a98mr1499338f8f.18.1768532948389; Thu, 15 Jan 2026
 19:09:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115151143.1344724-1-puranjay@kernel.org> <20260115151143.1344724-2-puranjay@kernel.org>
In-Reply-To: <20260115151143.1344724-2-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Jan 2026 19:08:57 -0800
X-Gm-Features: AZwV_Qj0rwTlMjvYsfgOBNgmwVcVhboJ0qzD8Ra4rX8ak1HCohbYJmxeyz-uvd8
Message-ID: <CAADnVQJLQ4hQTEKVPntpRe6=qsXQffno65OJjAG-H+Vw0i1Tzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve id of register in sync_linked_regs()
To: Puranjay Mohan <puranjay@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 7:11=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> sync_linked_regs() copies the id of known_reg to reg when propagating
> bounds of known_reg to reg using the off of known_reg, but when
> known_reg was linked to reg like:
>
> known_reg =3D reg         ; both known_reg and reg get same id
> known_reg +=3D 4          ; known_reg gets off =3D 4, and its id gets BPF=
_ADD_CONST
>
> now when a call to sync_linked_regs() happens, let's say with the followi=
ng:
>
> if known_reg >=3D 10 goto pc+2
>
> known_reg's new bounds are propagated to reg but now reg gets
> BPF_ADD_CONST from the copy.
>
> This means if another link to reg is created like:
>
> another_reg =3D reg       ; another_reg should get the id of reg but
>                           assign_scalar_id_before_mov() sees
>                           BPF_ADD_CONST on reg and assigns a new id to it=
.
>
> As reg has a new id now, known_reg's link to reg is broken. If we find
> new bounds for known_reg, they will not be propagated to reg.
>
> This can be seen in the selftest added in the next commit:
>
> 0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> 1: (57) r0 &=3D 255                     ; R0=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))
> 2: (bf) r1 =3D r0                       ; R0=3Dscalar(id=3D1,smin=3Dsmin3=
2=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff)) R1=3Dscala=
r(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0=
x0; 0xff))
> 3: (07) r1 +=3D 4                       ; R1=3Dscalar(id=3D1+4,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D4,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x0;=
 0x1ff))
> 4: (a5) if r1 < 0xa goto pc+4         ; R1=3Dscalar(id=3D1+4,smin=3Dumin=
=3Dsmin32=3Dumin32=3D10,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x0;=
 0x1ff))
> 5: (bf) r2 =3D r0                       ; R0=3Dscalar(id=3D2,smin=3Dumin=
=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D255) R2=3Dscalar(id=
=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D255)
> 6: (a5) if r1 < 0xe goto pc+2         ; R1=3Dscalar(id=3D1+4,smin=3Dumin=
=3Dsmin32=3Dumin32=3D14,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x0;=
 0x1ff))
> 7: (35) if r0 >=3D 0xa goto pc+1        ; R0=3Dscalar(id=3D2,smin=3Dumin=
=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D9,var_off=3D(0x0; 0x=
f))
> 8: (37) r0 /=3D 0
> div by zero
>
> When 4 is verified, r1's bounds are propagated to r0 but r0 also gets
> BPF_ADD_CONST (bug).
> When 5 is verified, r0 gets a new id (2) and its link with r1 is broken.
>
> After 6 we know r1 has bounds [14, 259] and therefore r0 should have
> bounds [10, 255], therefore the branch at 7 is always taken. But because
> r0's id was changed to 2, r1's new bounds are not propagated to r0.
> The verifier still thinks r0 has bounds [6, 255] before 7 and execution
> can reach div by zero.
>
> Fix this by preserving id in sync_linked_regs() like off and subreg_def.
>
> Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  kernel/bpf/verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7a375f608263..9de0ec0c3ed9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16871,6 +16871,7 @@ static void sync_linked_regs(struct bpf_verifier_=
state *vstate, struct bpf_reg_s
>                 } else {
>                         s32 saved_subreg_def =3D reg->subreg_def;
>                         s32 saved_off =3D reg->off;
> +                       u32 saved_id =3D reg->id;
>
>                         fake_reg.type =3D SCALAR_VALUE;
>                         __mark_reg_known(&fake_reg, (s32)reg->off - (s32)=
known_reg->off);
> @@ -16878,10 +16879,11 @@ static void sync_linked_regs(struct bpf_verifie=
r_state *vstate, struct bpf_reg_s
>                         /* reg =3D known_reg; reg +=3D delta */
>                         copy_register_state(reg, known_reg);
>                         /*
> -                        * Must preserve off, id and add_const flag,
> +                        * Must preserve off, id and subreg_def flag,
>                          * otherwise another sync_linked_regs() will be i=
ncorrect.
>                          */
>                         reg->off =3D saved_off;
> +                       reg->id =3D saved_id;

What is the veristat difference for meta/scx ?

I don't trust CI at the moment:

026-01-16T01:26:34.7163235Z Failed to open 'c-scheds_lib_sdt_task.bpf.o': -=
2
2026-01-16T01:26:34.7240161Z Failed to open
'c-scheds_scheds_c_scx_sdt.bpf.o': -2
2026-01-16T01:26:34.7298286Z Failed to open
'rust-scheds_scx_arena-9355999175dda454_out_arena.bpf.o': -2
2026-01-16T01:26:34.7353438Z Failed to open
'rust-scheds_scx_arena-9355999175dda454_out_atq.bpf.o': -2
2026-01-16T01:26:34.7414081Z Failed to open
'rust-scheds_scx_arena-9355999175dda454_out_bitmap.bpf.o': -2
...

2026-01-16T01:27:52.3087135Z # No changes in verification performance

something fishy.

