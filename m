Return-Path: <bpf+bounces-79159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C29D2912F
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D600302AFB3
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47D32C949;
	Thu, 15 Jan 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luEaPJLb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB8329360
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516994; cv=none; b=tGavcC+JPM2IzSjb91W2QInLXCIB3O8JGRlw97DFOXlH3eBAOTTvX+I8AbzEb8ep/EeMMRNBxQJiURg6wCpLvTw+89E5B+zcm8zfnsOeUuglkk3tM0rqZSfHI8f7EeM0fZlYIaFN3XpD/BXXKllHO8XmkqCtl/Ih+X3CP/ii0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516994; c=relaxed/simple;
	bh=gh1pNl7LPSQFOZPIz4mHeTSUTsEsDoIlvib8JR2knYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9cvlcRpJ72iFvEQqNUZ1tzp2/5ck3sKc7Y2sSy8j1Ths141LvxDQttS9W5K1PwptCVOmcODyH8zKns+rACU728JcrvngoPS0cfXBBMvJTtESEegcV5rgoLXysQeOO3AAmrs56FIQIy/jPhuYxDy3+iIz0LLYcVNLtTzy+9Cpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luEaPJLb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a110548cdeso10226915ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 14:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768516992; x=1769121792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duM97sOSvXaLJaguXwRBTTE1MCMFcHLX7byg5/C/R0k=;
        b=luEaPJLboa/5xW/YAIdYjyNPAzMcCIg4Of8gTf3HSJYkKmV0+hzKCmd9UhrmjC/165
         rQMFB7+Yli7nn/5GEem8VTc2MH2BjHH47PMwZhbj7m2RaiUNrd7pTFqOa6CfMF3/BTSk
         CIl1FPdPH0ytcdg2Pw7zzx8n8z6E7Q0FyY5vPm8lo2dBVJw+h6Te1LvEnZsH+PN0agN1
         NeVTlrkXVQaGV4+IKp9HDoP3TVp0Kfw3ogRs+Jso+qeWfjk1ZBe8wlI5ZJuqxjtfIRun
         1PlxqpW8XB0UqMqGwAYcTnOZpKU/pKWMuZNPPbOlbwQGX3Q1V6/a+Ao7uxeQOXfXhKnT
         sx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516992; x=1769121792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=duM97sOSvXaLJaguXwRBTTE1MCMFcHLX7byg5/C/R0k=;
        b=uFzqb9awDwl4ozuTk20tWzFgkzJNFmHC7fP07mG84vcT3noRbS77hOfo2j4f/SLnW3
         80Fk9He9z+eA4HdE/BsZlvv2Lv+quCnDRpFReI/dTsi6m4uQKqjRZGYqhzsJ6zBv7u7r
         7FluRLEBRnjl7XvvzpsAFS/Tx93RUgfJ3WbyX/hYjWGfivs+nPsA2q1/2KOC7ryV1yJi
         ffR/JvcpC+YXFxt3nDCL8A3OErsHNTZVyfWBvxO2qO1FZYmFJxuNv8OcTKGub0AiiEgi
         wLkSO29kKxgiWpgTcVEh7lEtcazxmn0SDx0IX18xwtYUVyBl0JnCRexboWK99AJmdO6u
         kn6A==
X-Gm-Message-State: AOJu0Yxy/5a1PCeSyzPCFTteZ3MxOWamNnyvwxWSb6dL3fVu3pc/iLlp
	lls8xHcsOCq3gAydthIHPR/aA/1zdzX+W0i/1RlDHpUqZZr+qVddRxkaBPn8w3K0gOcsNww8sz0
	148NwPikMR/gssttm4ksIe/31JFVrIvw=
X-Gm-Gg: AY/fxX78HTi63C6ctVPVFqcqLj5l27RR1lww3qdjbXGQ8s6PC9s2XQIzSk9APNEVlBk
	M4iU5pBQtDGPiBUJb69QyjW+jDsZnHdLjy1FaahSkcqjXokIydQf4slzTeYx1vniF2VBiRlZenS
	vd6HIRjoBdXBqo1QXsiyKQiXzHprclAvFI/7f1+sN76ZNgxbMvcTiwei/ChmaCI4FJuiRiKhUnb
	/nQOtaT2rp2moloUpB41AtcdWfUvgPinMWV9Tz2rOL840LKZ/H/k4siAmv9hEIvlf1xteod5pqV
	49zWzgAw
X-Received: by 2002:a17:903:40cb:b0:2a0:bb3b:4193 with SMTP id
 d9443c01a7336-2a7176cc6c7mr8851845ad.40.1768516991964; Thu, 15 Jan 2026
 14:43:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115151143.1344724-1-puranjay@kernel.org> <20260115151143.1344724-2-puranjay@kernel.org>
In-Reply-To: <20260115151143.1344724-2-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 14:42:59 -0800
X-Gm-Features: AZwV_QjUujNnW7O_dseo7MwKvax6zPhMk5eEtdwBO3vYWC99QrBzH4DRCIAFXxU
Message-ID: <CAEf4BzbXo0FCxJwjrk_O0YBCPkDW0a5-gFW8VEbQDqu4P-XP+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve id of register in sync_linked_regs()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
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

We should mark_reg_scratched() all the registers that got new IDs or
new ranges or offsets. Basically, if anything about register state was
changed, even if verified instruction doesn't work with that register
directly, all affected registers (we can think about this as side
effects) should be "scratched" and emitted in the verifier log.

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
>                         reg->subreg_def =3D saved_subreg_def;
>
>                         scalar32_min_max_add(reg, &fake_reg);
> --
> 2.47.3
>

