Return-Path: <bpf+bounces-79122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E8D27BE5
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B4B6308E45C
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111A3BF2F6;
	Thu, 15 Jan 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9eyddHz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C03BF316
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502382; cv=none; b=Joja/jcKJJiJis1sFkd76K1QTlvGlTYeEH8Mg+mtZWNE8HTAusz5y6I+ufggghCKpkrRZV9tDjaa6aKqlcLg+6i2eMoGHDhm16tbpCaDfCrSXjTMaT4D7ZsSNg99nHO61SUEOsvieyj7aOQs+jv9SZ5RPXVYsFTqkxzl2Zy4tj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502382; c=relaxed/simple;
	bh=O2Qra3s2cKAZ6ALeEo5aNnzoUKiEpCbJIutibdYL/Yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRN8EmmHyncwYGBDeloG0FGUkcIQN4tTFOJ3DdlIqDObXZ9jx3EdiKXtL4iPRqVlC+bPFT6R1zKHUDNe+0SXsm+okopebOkchrGqth8k/vkk9vs9jXU8K3qizDY3dFlzGRS3Lg32HA/QvjiwcXISYL5Fi8CFZE+kM68DuCBNQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9eyddHz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b553412a19bso539886a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768502380; x=1769107180; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wXH1yYhikFMfEHmz4LBOVS4kb+PgYFt0fPvLItCZg4M=;
        b=T9eyddHzm+q260Oawt8d5kX0RTGNs5y3UE7yIar4Jg6PQAQ4RnIsY+QXfOAMQaI4uN
         1PRk1qmuTmaQ/djeNVYe74Cp1V0ku25ocYNZ7BqtmZPF8HHMomWveo0JoQ59+k+Xo+S/
         feIh7QYJQYEesfyJpnIWPNGDLsvkHghYXYOSpjkbP2r+85oG0/ShrpC94/PHUwKOdftm
         +1B1PYWKy7Omm/9NAlvt2MsoyxaVznaMGtNj2BsKI5byCQc1l+I0uL9UQimAnffnfyOc
         U0wihnHYTrxgeONhtGd3A3Bmpj5Sdbx1dQZ1QAIpv0GelhKaoNX76ingGQFxiwzNW/RC
         92lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502380; x=1769107180;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXH1yYhikFMfEHmz4LBOVS4kb+PgYFt0fPvLItCZg4M=;
        b=YHJNCu115uTC2tTTvGgo2AaKIFOs/eWrZkhKmiFzzRcLmdvmX3YcfcffXxNG5zL4zH
         uNuvqQONRoYoW8HXiC30RsDnk9kkQDldsEGWSnbY2FWZMxg2qYxCQjnGTBk/H8jEJNOm
         7qV0Sr/Rdi3KlIt/NdODTTEw3if5ECn6Mv/yWlltISJrHhsy6CBXjxrASVFsHrXog8nc
         e6QJpA99O+HcnO8huHI2o7G+fKN7tKYrJw3EavMIMXn+zWAJGm8rSpsdW/810mZnaF+1
         Quyq3lXoB74Bnbe49is7snIdX4GdFMcJJJqn7nDaziOe3toAB2x8lagpZ2y3y8icSLu0
         q5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCViRQ/epn4HWTvC6OlyDJ9L1roi8g7GVTvuN8eEdYm8zG+9sJyRlAjIZ8bmt+XAkltdyz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMBH59R8jxsofLAEfpeEJYmkp9hN5htAvcRYCIaDmtsF5yXct
	Spoo61fueZ+C5rewn5Besr7zArK2kLWQaIrUbQfzvFNa9WBfvgCu7+gA+ulTBgo5
X-Gm-Gg: AY/fxX519nwXw49hC3P26itIPLnvxFry3F+vYUiB7CNy3i/Kill+042hloRR79hIzXq
	rA1Sracc4DCFIe3MmvW4/LjCOlp+t++X5qk0sKQEFaG+Wh1m6TAANSLcC4cZ+hXM4VhZwCJ8/Ml
	C3R86S3mJSKuRFpv9aex3bO0yu6nSAQFuzXN1gM9LNpB0jXVBhod2pC+okQweMcgSbUvZVfAimc
	BIvxaFASxBndXfADiQoo4ySiacrOdfutfAjDkzgEEelBsROClTlPykT/on/H+cZQkneuZRTX4BE
	3htjNuvbeYgwutrmgZvI7i2/PDpYqxIj+VDvbrEkNoueB39Gs6UQDyfzz6HWlsfETwfQGG6QzVq
	txGvwzbHUZZZ/5qIFhWhOM1Cq2t8ZqLclwwz8EMNwu/5Q4hoxDXxTf14SndgNvRY7+slY8/2HKW
	Rfn9pzjJUooB3zo1pEuFFFNDjCQfIG7sA36/Ogjqd3zRHGSaN8LP4=
X-Received: by 2002:a05:6a20:1590:b0:387:5ded:994a with SMTP id adf61e73a8af0-38dfe77232bmr569577637.60.1768502380441;
        Thu, 15 Jan 2026 10:39:40 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37c9d7sm129416a12.35.2026.01.15.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:39:40 -0800 (PST)
Message-ID: <0306a02b93e0be00b90b8bd0724a63e782f15630.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve id of register in
 sync_linked_regs()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Thu, 15 Jan 2026 10:39:37 -0800
In-Reply-To: <20260115151143.1344724-2-puranjay@kernel.org>
References: <20260115151143.1344724-1-puranjay@kernel.org>
	 <20260115151143.1344724-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 07:11 -0800, Puranjay Mohan wrote:
> sync_linked_regs() copies the id of known_reg to reg when propagating
> bounds of known_reg to reg using the off of known_reg, but when
> known_reg was linked to reg like:
>=20
> known_reg =3D reg         ; both known_reg and reg get same id
> known_reg +=3D 4          ; known_reg gets off =3D 4, and its id gets BPF=
_ADD_CONST
>=20
> now when a call to sync_linked_regs() happens, let's say with the followi=
ng:
>=20
> if known_reg >=3D 10 goto pc+2
>=20
> known_reg's new bounds are propagated to reg but now reg gets
> BPF_ADD_CONST from the copy.
>=20
> This means if another link to reg is created like:
>=20
> another_reg =3D reg       ; another_reg should get the id of reg but
>                           assign_scalar_id_before_mov() sees
>                           BPF_ADD_CONST on reg and assigns a new id to it=
.
>=20
> As reg has a new id now, known_reg's link to reg is broken. If we find
> new bounds for known_reg, they will not be propagated to reg.
>=20
> This can be seen in the selftest added in the next commit:
>=20
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
>=20
> When 4 is verified, r1's bounds are propagated to r0 but r0 also gets
> BPF_ADD_CONST (bug).
> When 5 is verified, r0 gets a new id (2) and its link with r1 is broken.
>=20
> After 6 we know r1 has bounds [14, 259] and therefore r0 should have
> bounds [10, 255], therefore the branch at 7 is always taken. But because
> r0's id was changed to 2, r1's new bounds are not propagated to r0.
> The verifier still thinks r0 has bounds [6, 255] before 7 and execution
> can reach div by zero.
>=20
> Fix this by preserving id in sync_linked_regs() like off and subreg_def.
>=20
> Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

