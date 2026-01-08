Return-Path: <bpf+bounces-78172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B94D00934
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 02:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14D6E305745B
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 01:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D919CCEF;
	Thu,  8 Jan 2026 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESgSPmgA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F8020F09C
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836431; cv=none; b=WAhOoLV/1hNgwjTHGRYanG6xBdwiT1SbyVCuzpsTD5NS23fjeOqHAXzsHUJFmT2bfUXBhHLbI4E3GyDulEBmuxcbY8qdDGtEBfIs+YI3iTV1TeUTm7TvMfHFYqk2ehGHXxVHf/SvzmaDFIpQCv+1vJ60+gRzsckVP0ub2FrtntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836431; c=relaxed/simple;
	bh=PwHydhDacUe3W5rFPFOu28oCv1fK0C1/EOtozbtqfB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ex9c7kRO6FI+/NLAGFzMgXr3e1GRF8SFMKmRLW4r44ekeLWNGfXOkqAigGf6913QFXgjEjyn/jHgqVksz+GVPDsYjvBs/lE7pdplQKUykQfovJV2umXkedLvefLcYgAzpCpBoKG9UZ7kstW491XVYTpZSUkPr/PqDMpaaQaYtlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESgSPmgA; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ae38f81be1so2398536eec.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 17:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767836429; x=1768441229; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lc8xI9VIunlf2s3ghYVPad78J1NbZFJiY8N31bPwlqQ=;
        b=ESgSPmgAaJvqWKVopHYLdt8uiuSWHKffVkCcudZrczIl5HzB1DblPRJDD8R6OZ8zLe
         9LzOAr/eL+WK/Nd6iZ5IAPdcm/LrxNxk4hAtlcpH0cOkw4hJBv12BZGXfCoGLzHlsO5v
         ZG66z5RBlQtxSoWdBSkyJehKHUhnelOMlkEXLC50syQ2paHJtzNbS32EaBYPHp5YFS6a
         crIsh7criHzurc+Lzl+4J8Y+qV9eafm4y0AqbQBpQLVyGbYimPQ0+rmr5ZkDuvA6yVCV
         4ypgwr3uWFrKvEQdsngzDzGRtXHKezw1vEj+ABc0vjRhXf5mf0f1G37gjG9bh3rH1dMN
         kMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836429; x=1768441229;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lc8xI9VIunlf2s3ghYVPad78J1NbZFJiY8N31bPwlqQ=;
        b=ManKUnXnhItluNo9WFXFlCw1soO4ejZqaWODNEAqrXrvtXGeLeET5nhroSpTL49mR0
         BEPuViup3TUzH9GFuyi6kNLGU3rT+TsceLE/GRMyLj+NjfSaun+7XIfAsY6QFV45ZEPX
         Dhur+hjWcbPv2B71qlL5f/62JGoMzO3jLKwJ9kmI5picBernbbDfDFBWp+AnLfvvAdjd
         hDQI0WNowiZnbTYVwDGGzUY6Jirxsy20ljpWCBmJpx5cKKkZnYK0mralwayNDKirtFb1
         +Oq6H6pLIYuXVPB8P/dE74uzhw5ie6iG+HV9iagXrziPXSJFhsvbGT+WIQtrT0AJ7Qxy
         v5HA==
X-Forwarded-Encrypted: i=1; AJvYcCXfstQ8v5Ll9YwNZBvsmy8S7jvk9sKGGqOSENc16Cl+1s8zdycNX6VcEvrpCpHJllg1MPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9PVrB3NJAmc4ESndzgT15+M3XwIxAg8L1pJZvBpdtTf9esgtb
	RVYTxTJvicTEZXClWHv8p7koGe8PyUqXh62wrzqwAc/CGY+dL/6WJaQd
X-Gm-Gg: AY/fxX6XieroogAnfWYljlZqfSigQ2/jQZp8ucAWwIdeyRYBW8OOv0xKSWfAOOMK2Ky
	RtRNpnYzOtiVdzlBAOxvQ+aXWUIcm7B4EuJbeI+CnoZOgiWhmsTnSkoNJ+FpNut6WX4Hd+Kk222
	F0ZkYL/HLZqpVBxS5KYBQ7ODIEHE4L35v1r9puyfZpy3M94OmiBmC4fr+f8BvcOp6E7WoNq+zP1
	m2EtGbyaifvAYWkVvYKQXRE4dl+eIeRkXvQLUELxKjssrzVctI+XciCUZPKvZ1NeQ/89cG4JbcO
	j2rFDodBqvp3AUUFrucsEMTmPRO4TYQVOZBjNuWm3XPRyBnyCPDB1YgAHlHkE5Svhe7pxaL9Vcz
	A3umBCsWlEGhAmKqQhwNl532CpgZTCcK2sSv+hCuVy8IF4WkKrFWvEZC9lyNVUc27M7qr2ZoJpT
	tvhd/YoePSJ/TZrwc5BJumoriAFeaHNFAuxX4X
X-Google-Smtp-Source: AGHT+IFgu53KxhK5I2f6jPLkubEA8MEFGhDJ7ohWCrHQeIksjKWWEQuE/jhrxaOGDhFhxOsQy4s5aQ==
X-Received: by 2002:a05:693c:3116:b0:2ae:5e28:743a with SMTP id 5a478bee46e88-2b17d212fe0mr3442955eec.17.1767836428944;
        Wed, 07 Jan 2026 17:40:28 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6741:9f57:1ccc:45f2? ([2620:10d:c090:500::2:4706])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a6386sm8055140eec.14.2026.01.07.17.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:40:28 -0800 (PST)
Message-ID: <5fa1d856b98cb7f0cb4eb402f616946b0c6c9211.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Support negative offsets and BPF_SUB
 for linked register tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 07 Jan 2026 17:40:25 -0800
In-Reply-To: <20260107203941.1063754-2-puranjay@kernel.org>
References: <20260107203941.1063754-1-puranjay@kernel.org>
	 <20260107203941.1063754-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
> Extend the linked register tracking to support:
>=20
> 1. Negative offsets via BPF_ADD (e.g., r1 +=3D -4)
> 2. BPF_SUB operations (e.g., r1 -=3D 4), which is treated as r1 +=3D -4
>=20
> Previously, the verifier only tracked positive constant deltas between
> linked registers using BPF_ADD. This limitation meant patterns like:
>=20
>   r1 =3D r0
>   r1 +=3D -4
>   if r1 s>=3D 0 goto ...   // r1 >=3D 0 implies r0 >=3D 4
>   // verifier couldn't propagate bounds back to r0
>=20
> With this change, the verifier can now track negative deltas in reg->off
> (which is already s32), enabling bound propagation for the above pattern.
>=20
> The changes include:
> - Accept BPF_SUB in addition to BPF_ADD
> - Change overflow check from val > (u32)S32_MAX to checking if val fits
>   in s32 range: (s64)val !=3D (s64)(s32)val
> - For BPF_SUB, negate the offset with a guard against S32_MIN overflow
> - Keep !alu32 restriction as 32-bit ALU has known issues with upper bits

This is because we don't know if other registers with the same id have
their upper 32-bits as zeroes, right?
I'm curious how often we hit this limitation in practice, I would
expect code operating on 32-bit values to hit this from time to time.
E.g. see example in [1] (but it is mitigated by an LLVM workaround).

[1] https://github.com/eddyz87/cauldron-25-llvm-workarounds/blob/master/dra=
ft.md#bpfadjustoptimplserializeicmpcrossbb

>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

