Return-Path: <bpf+bounces-78206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96FD01535
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 07:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC84030C611E
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D062B33B946;
	Thu,  8 Jan 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmuNdiS/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08083242A9
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855323; cv=none; b=PM9Y+h05PH1LnbrxKPcX7godDaE+lNNaz+/t3clwK+IpnpjFeZMdXtdd9akNU9K3DpGpFc4LMzg4DrS88fq9uqaBrrUihxp51fKVeJ2RZgLQcpyvgxPNt1+OJ6bkiNWOoy9i3r6dpnO2Sae3eTgoZeNNbPxt4fzgdYT6NrSfAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855323; c=relaxed/simple;
	bh=9KeU3ewFZY19yiUSpEs+0VJaxman+6R9i0GOo6eGmkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V8VfGaettINnhq0Fla24BKaA2iQPGoiLWf9OfcLpNAfDhPfp0+zJxQ5zKlxpAL/wh6kway7mUH0/smVhzeKF+lx21hqpqYhIMHC7vArrIITHEM6kwbFJG6I4TTc+zP41y+oBQK086xfI01ixeZ/1V5RYUY7u6uufPNCu/nGLL4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmuNdiS/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0c09bb78cso13681375ad.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 22:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767855321; x=1768460121; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TA8hv2Hv3TZlOk9rbByZhhwXn8FpkKBu03VFVVVH6Zc=;
        b=XmuNdiS/T/YHTFroNW6QHDvztry95aupi5k7fKo8WifFeGJa7aC5ryLyu+tpz/S6hx
         BvaHDgE314hSKt0gKtaEcJrn11VGD9ooGSVOTrTz7mKp3+rFbxvLOwXCBwnhXnU1G+Bs
         ZK0MnrWIsXGOkyE6Vs7aCcR59zz4D+r11mbhXu1rySUazU54Vw7oS2c0Pyi00uC9XRQa
         //G4L+b27lGzkI7VflrZgR0SweXBKjZsQLJ3HUOuzAQ962lknrwlKfiyiyygdfcRXE4C
         fz3fPWDuJntfxynjJaGBDtG1TjYTOsW0KkyeQ/9T8D/zaP0x3ehxkrex66kcTTQ62Vzr
         j4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767855321; x=1768460121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TA8hv2Hv3TZlOk9rbByZhhwXn8FpkKBu03VFVVVH6Zc=;
        b=JxA4TvH074UL4XcA3DJ9wUeidkQT+meMBe9IBsYR2BGettI8CPunecOlUPuNlya7gt
         dDwE4AcrMY21JxXt2AwPIRs9MpzdNZM/kuzCbV2xEzX4C34lqeLIkG26cDuCWLJeesbn
         B+OHlQIYsWBUbFg0TVER9FMvcnoC7NU55aT9xjJ9nPoTyc49GQ7bkIQKt6JtsIdyUKgc
         rmUpDisSMZ/T+7uxiv3lfbzQpYpjctBLWFN5FvukYVIuT3GzTaJ70S3UNwmx3tB6oYMP
         fUufdUKKZcWzR9JvQUYegM9+ovtvwvr+poQjoa9vNjfp0dQ6Xk/t9JaYfR0/rhjB5anH
         pjNA==
X-Forwarded-Encrypted: i=1; AJvYcCWt+f8Ov+PY1XeKHgQDw/UePjQzPZ/Hw1gr7neVd7J3xom8cEJ+BI3UdabQMOeZZqGFRWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjNGPgcB7x+mAamt14uqdIR9Mi9ewlsTx3RsfIbdOhz0eU6as
	0Odo8jYyD828D2PJcdQ0siRtnLOEiIP1lYocXkcLdqv1nneGSw2n6hFQmK0UnxEe
X-Gm-Gg: AY/fxX4JWx5hZvZsssXPj3c4dV6jhLufp8kE79pn0IQ9dDmEFN9zbYqhzHOsdyOoYUR
	92KaXo/XD4x2gW2hlSZ34dM4I50o4WEzOOJEnQ2QB10f32ey0W3eC6OhK4JfwU38PuwpAaMeeGB
	hhoV5o6GPb/Y/Y6LvAnaCE37cZ3KT/pRDQ3jgdAge7tQNk+z8W3w3LOfvm7b/tGd7KPQHXrsDNR
	PFaphxN/j/y4nYjM/RmcwY0NlPoFi1PPLypREP7LTTAQo6jZFcS8+fMRzlsisK7ef9GaO3211hV
	0OsU6fBgtKHJ+HFmq0MorBHXpSuuLFzyT+FRF/4qnIgdsRyTWcOAwHXzy0MC7JGhj0oPQfcV7l2
	oKbRYa+tg+m3daqHk6K6E0Nx1F0k0rmLfD2lUOeDO8vFAGuE0nymj4pP3HPq8ihoMey/leGSp2p
	oYqz7c+EN5
X-Google-Smtp-Source: AGHT+IE+tbGlSM6mSOmVElMbeiXPvqvRVi9xTxqxH9+9Ca0FagMwVpsynca+ghZTBP1YBkB5ll6KWw==
X-Received: by 2002:a17:902:e542:b0:2a0:acb8:9e80 with SMTP id d9443c01a7336-2a3e39fe508mr93493255ad.29.1767855320887;
        Wed, 07 Jan 2026 22:55:20 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a303sm68044875ad.5.2026.01.07.22.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:55:20 -0800 (PST)
Message-ID: <c58877171779ba86762ff413007a61227e7a928c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tests for linked
 register tracking with negative offsets
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 07 Jan 2026 22:55:17 -0800
In-Reply-To: <20260107203941.1063754-3-puranjay@kernel.org>
References: <20260107203941.1063754-1-puranjay@kernel.org>
	 <20260107203941.1063754-3-puranjay@kernel.org>
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

[...]

> +/*
> + * Test that sync_linked_regs() correctly handles large offset differenc=
es.
> + * r1.off =3D S32_MIN, r2.off =3D 1, delta =3D S32_MIN - 1 requires 64-b=
it math.
> + */
> +SEC("socket")
> +__description("scalars: linked regs sync with large delta (S32_MIN offse=
t)")
> +__success
> +__naked void scalars_sync_delta_overflow(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r2 =3D r0;					\
> +	r1 +=3D %[s32_min];				\
> +	r2 +=3D 1;					\
> +	if r2 s< 100 goto l2_overflow;			\

If I remove the above check the test case still passes.
What is the purpose of the test?
If the purpose is to check that S32_MIN can be used as delta for
BPF_ADD operations, then constants in the second comparison should be
picked in a way for comparison to be unpredictable w/o first comparison.

> +	if r1 s< 0 goto l2_overflow;			\

> +	r0 /=3D 0;					\
> +l2_overflow:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32),
> +	  [s32_min]"i"((int)(-2147483647 - 1))
> +	: __clobber_all);
> +}
> +
> +/*
> + * Another large delta case: r1.off =3D S32_MAX, r2.off =3D -1.
> + * delta =3D S32_MAX - (-1) =3D S32_MAX + 1 requires 64-bit math.
> + */
> +SEC("socket")
> +__description("scalars: linked regs sync with large delta (S32_MAX offse=
t)")
> +__success
> +__naked void scalars_sync_delta_overflow_large_range(void)
> +{
> +	asm volatile ("					\
> +	call %[bpf_get_prandom_u32];			\
> +	r0 &=3D 0xff;					\
> +	r1 =3D r0;					\
> +	r2 =3D r0;					\
> +	r1 +=3D %[s32_max];				\
> +	r2 +=3D -1;					\
> +	if r2 s< 0 goto l2_large;			\

Same issue here.

> +	if r1 s>=3D 0 goto l2_large;			\
> +	r0 /=3D 0;					\
> +l2_large:						\
> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm(bpf_get_prandom_u32),
> +	  [s32_max]"i"((int)2147483647)
                       ^^^^^^^^^^^^^^^
Out of curiosity, did you write this by hand or was it generated?

> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

