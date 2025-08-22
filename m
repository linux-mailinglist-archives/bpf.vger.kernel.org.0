Return-Path: <bpf+bounces-66304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7DB32284
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 20:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EA01D63395
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6752C158E;
	Fri, 22 Aug 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNCYx8vZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81662393DCB
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889169; cv=none; b=JFPDsarlKPx8xGkGQ03qrK4PHScbA0rKWZgAd3QPXowASixxyLtfL7o0AVYRY0ZqruDUSQDIgUUXivSPYLbrJRfeudkbLLDoOEGHsNFE8QMN2Ur2iZYddGKKPQgX6qTv6LiEXrtE4pJe0xsWNfqNapckGjwIl0ERhOCS9e0pLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889169; c=relaxed/simple;
	bh=ETeRUOMEw3+6n7+mCMZH564aJZopSlJYu0PcVJEuorg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVbaXaMsnIqiJFGLsQwHROEECBm9OuG21GULt1sjVsv4ChxNNqOAc6bcNRtkErc9UwR0SEfoBeh7R7EXn4tgVE7u8/geURjgTvbocEKAksiX0bChiGW9bbCwClyuJzguiTTOxLdKsCGQD6fAKghiv9IHKKzwnqOTFUYM4g70iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNCYx8vZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24664469fd9so3687945ad.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755889168; x=1756493968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W/olc5tWsWInj+Ci1aJTYYWNGt32UcuvRYXGxa59Avc=;
        b=nNCYx8vZ9XUq73MUdX9XjOywle5by5E/+EZVcDnGvVvAkOMxED2amfYkzh+gzfdQfO
         T05ap29Q5uvu9JFD1+3DuPscJkn/eM89tCDVmDKsR+vGSSNM9A476D1UGiAcA6MdQN9n
         FeEufq1eLykuOTGM7vh8Qy1942M4ZD6Fuxu2ER8VRqTvHzQpAZNnscq2bSATjrXXmqnE
         AEOtXXv0BAmD9jBAfoyuHkpKIia1Qx6kApCtft4sqDmXHR5StY7YwI4KmM3BsZhPH2YK
         BLcz+RLytbVWUwdpljV1y3GRHF0hCWf8MCKor7jb4oJiqRIozlK9EsvaA25wphjJfQWX
         2Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889168; x=1756493968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/olc5tWsWInj+Ci1aJTYYWNGt32UcuvRYXGxa59Avc=;
        b=H6CGBDlgWqWm4yTZ/X2qziy2zNBMVGhgdw8ESerq8MBmsj4u7qalo3OElwJshhKbZU
         ajWwqH09neBj62c8fBxh3pGP97KKYIhiWKvmi1VU6F0Kmb5SAJhNda9NvNTcOESjorPY
         yg8OqO5m1VAg9KWehK6nkmHx6K2MXJj2sesnblPkD2TC0xsJFtZU/7rTdL81Y2Y1OsvF
         UA+ZMmFjzPA3q9hrucg2D3v1POiMlCx+39ncI+gWXHEOlbQfg9sGZe1MTIcUC4wmX9i2
         bD9ZXFC68fJoMX4nUxvk5ENRIDCED09JJ5KehwO8kB6rbUdLILmNTptMbNawH5agNifz
         3lVg==
X-Gm-Message-State: AOJu0YxLAqFQUbk5A+whGwWj3X1VI/TBxZejcq6UdHh3CUoMUB0d3Sms
	f387jwjgPZ6laqMYs8U6gxdIfpO4nv8/q8RvOVfWR5+XKj6kFgVLlW1z5ufRdP9Z
X-Gm-Gg: ASbGncs1kSlRJy4J5fQihCFlyQMIy5d8yIx0YvcEoGDe/v0YIo+hLe+wbx/SoWwoq/U
	ghlYuU4szaFLuD/Wisl2UH3utQA34aqX1ILczmLzdGmYoDA7XaUr/klvScb3bHe+9MtOh8IiV+m
	vcxdqDXlabjMOvVIDKKQSVoj9NvOpzyK7vjjbNp23niJmoRxRaUfijkzjZ5NYT13oZ+/e5CriZo
	65xpan0RRzd35S1BAAi+l1QyjchqQG1G35Ojdsk7wOpXzmxnlhIjIu9C4zWrplLCrAV88Bf0YH4
	vuSXQ6Hjs5GK904bAceyL2DL3DtyQpxuHNiKpFbEGVTdvoKy8F9UnIVzv5KFuSIwhlCjj83OU0i
	71BhCvpM3dESQ8/uHleA=
X-Google-Smtp-Source: AGHT+IEpsHSkSnS09WOXRo4TnzqQU/oSaXE67uaUBwv6tUe1R6YWXj0G5hzu7yG4qwJ7lieVu8xm7g==
X-Received: by 2002:a17:903:943:b0:246:2e9:da9e with SMTP id d9443c01a7336-2462edd79f2mr64106525ad.6.1755889167736;
        Fri, 22 Aug 2025 11:59:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887ff04sm3138915ad.120.2025.08.22.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:59:27 -0700 (PDT)
Message-ID: <6a0de8b66fcf9b0bcf36849a81a8dd4e17648aa8.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] bpf: add selftest to check the
 verifier's abstract multiplication
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Fri, 22 Aug 2025 11:59:20 -0700
In-Reply-To: <20250822170821.2053848-2-nandakumar@nandakumar.co.in>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
	 <20250822170821.2053848-2-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-22 at 22:38 +0530, Nandakumar Edamana wrote:
> This commit adds selftest to test the abstract multiplication
> technique(s) used by the verifier, following the recent improvement in
> tnum multiplication (tnum_mul). One of the newly added programs,
> verifier_mul/mul_precise, results in a false positive with the old
> tnum_mul, while the program passes with the latest one.
>=20
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

Thank you for adding the test cases.

[...]

Given that other two cases pass both with old and new algo and don't
look particularly interesting I'd keep only this one.

> +SEC("fentry/bpf_fentry_test1")
> +void BPF_PROG(mul_precise, int x)
> +{
> +	/* First, force the verifier to be uncertain about the value:
> +	 *     unsigned int a =3D (bpf_get_prandom_u32() & 0x2) | 0x1;
> +	 *
> +	 * Assuming the verifier is using tnum, a must be tnum{.v=3D0x1, .m=3D0=
x2}.
> +	 * Then a * 0x3 would be m0m1 (m for uncertain). Added imprecision
> +	 * would cause the following to fail, because the required return value
> +	 * is 0:
> +	 *     return (a * 0x3) & 0x4);
> +	 */
> +	asm volatile ("\
> +	call %[bpf_get_prandom_u32];\
> +	r0 &=3D 0x2;\
> +	r0 |=3D 0x1;\
> +	r0 *=3D 0x3;\
> +	r0 &=3D 0x4;\
> +	if r0 !=3D 0 goto l0_%=3D;\
> +	r0 =3D 0;\
> +	goto l1_%=3D;\
> +l0_%=3D:\
> +	r0 =3D 1;\
> +l1_%=3D:\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

