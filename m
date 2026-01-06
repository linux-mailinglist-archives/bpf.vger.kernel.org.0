Return-Path: <bpf+bounces-78001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C32CFA1CD
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7CC7300E408
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 18:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E162366550;
	Tue,  6 Jan 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfG8s8+t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA093659E3
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723950; cv=none; b=jGCYkRE0fafsPt+7t0lNsi2NY+yZuJ2PUOMZK9Rzicb0dzZDcsCSRFYdNKsbFskbvSkCP0QJLAfD6aAvEGLPdJvAxWpGhd4BCMzQ7+UQM3E7vAyTHXYhrSUHeQS4ksu6lJS5LHgcNaJginTEFgN8GNBRIwRuodP7aRCUJ8nY/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723950; c=relaxed/simple;
	bh=4/uoYwkQGGTtpzX8u/eo6P+kwZj4cFQPvTLf1lRyWpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGtiVJPpxe9XXxK/K0s+Ch/zfVKMZkgOCcKoVmAjUr91+7aKg8DR8+Bb1OHPh9aOKQh+bvwkbFT4FDVTz5bgX82NkpKXO4Yy/7z5JzIrFz4a8ztN5yUJ2UWSzfYaKepC2SjLMiO+8i4VMHW5tsAVEqA7DQ6gpMM2OblmxodFFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfG8s8+t; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so10376415e9.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767723947; x=1768328747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AoW3ejQJ9eJjCHqIfu+Ch/7dBIUphGUj0Go0KFZrfM=;
        b=DfG8s8+tadcL4jRIo/J0HtPnNGyrbsa2sDc8TZ93u+c0UQEbolmmt/zfQQZwxU2ilz
         jsF3QysM8ChrgxrHkl+fYTjVpqTrQJoQegvNajGXOVS8d071ho4vzUqIw3qoTsp7/EKd
         Uo6vxiRCoYD69EUESADbGPWXUeXHJLgcctzp8ZZeaPxXm3cfzIKvvA0tBv6lxLuKI/aD
         El8l/VDbIkvpEm/QU+oOBNSM3EUsbApmjDvqkm+jsJscvKqmmeiHlX8n2BA/WoE4NVSG
         GUQcH7el3obAojQ8EG//K+EkOuYXUlOPAtylwG+o7hR2qrJpiRaKrDmYprBZqKCUu08I
         HkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723947; x=1768328747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AoW3ejQJ9eJjCHqIfu+Ch/7dBIUphGUj0Go0KFZrfM=;
        b=dvU+EhyrxfkoIsD2WLLw7MRBTz9DhQ3d0habuDHtNk096AlsFfFHtIFvkkkEOUnfux
         K8SjJJLUlq22rYX6Be6iktbobS5QerPtQrQdIQJIML4TQxVNo1CfpCIMU6kPI2py/nLH
         lkWv9jnDprwvoxJW94ItbMpkk4sjbPD8q581kLRpyNqoWO1JR2mP1HicjLDhLPwA+oJf
         q6qLvKurYoWQf0W0s1g4eIvJYwiJt2WF/yisbCg6Sm6G0YFJf8wS8qK0/xPwA1bs57UM
         yFBFx2ek1xLfaKvFJnILwW3bqYqNBOyM71sKCabzAprtUylWyTa4TpMfriJNq1HNqqXZ
         haIg==
X-Gm-Message-State: AOJu0Yxm3HxFnMQFDwLdFKlv9gCL2F2AhQ8/jnOYtxN5+oTLKL8TQ93E
	HH9muvjOFzMZldaP8v4FYZP+MpP0dIenKwokgxCXN5ovG8G4x20Z2oVRoAnVXdmfhdLs0yFlpD6
	IgklI22U8y1mfMhwPj7B/kPZSZk3IM4E=
X-Gm-Gg: AY/fxX7euLVvn3kH5dWYBTkXOfeP8SQjcjAK+FnBC8RDVNXHULM5OpW7lJipbKAlz3l
	c4bFcdYPjczOWhb46/01OLrBk/9DFcTp4TwF9UERi/+N5lU5f2bIkuiRY1vUremcWOvo17Zob1X
	J7FVQ3Mg3hcQtSKWEPiY0w3nInLSlHgJ+S8n/RGi51UyQy4dSPbTLvk02j3TULeIoZhzFHYxN48
	0MXn8pOl+kXEoNWbFgg6Ku56Wou9G1flTRknVKoAItRQBfum3tgTCXO9yQPaOnJvRE0Fw0LS8Gw
	p22FEH3T3Y8=
X-Google-Smtp-Source: AGHT+IGsGnfJfAF5gkbuaYurEsk4m0EVmraVoF9eJkmzNVjRcPqqWh0CPN/0EqZ+853//q0ziJrMzLBUR+RerHVtZoI=
X-Received: by 2002:a05:6000:1862:b0:431:8ff:206b with SMTP id
 ffacd0b85a97d-432c3628095mr123323f8f.2.1767723946574; Tue, 06 Jan 2026
 10:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126145039.15715-1-leon.hwang@linux.dev>
In-Reply-To: <20251126145039.15715-1-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 10:25:33 -0800
X-Gm-Features: AQt7F2pJ_Liu0LKeNcvMVLFvGCOlEacrr7yy9EMutoWB-gdLesv_S3yuLaz6VF4
Message-ID: <CAADnVQLisw1HFdDKWvSyWGdpVE1wSUdUBB=5aE7srHjsLNELPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 0/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Tobias Klauser <tklauser@distanz.ch>, kernel-patches-bot@fb.com, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 6:51=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch set introduces the BPF_F_CPU and BPF_F_ALL_CPUS flags for
> percpu maps, as the requirement of BPF_F_ALL_CPUS flag for percpu_array
> maps was discussed in the thread of
> "[PATCH bpf-next v3 0/4] bpf: Introduce global percpu data"[1].
>
> The goal of BPF_F_ALL_CPUS flag is to reduce data caching overhead in lig=
ht
> skeletons by allowing a single value to be reused to update values across=
 all
> CPUs. This avoids the M:N problem where M cached values are used to updat=
e a
> map on N CPUs kernel.
>
> The BPF_F_CPU flag is accompanied by *flags*-embedded cpu info, which
> specifies the target CPU for the operation:
>
> * For lookup operations: the flag field alongside cpu info enable queryin=
g
>   a value on the specified CPU.
> * For update operations: the flag field alongside cpu info enable
>   updating value for specified CPU.
>
> Links:
> [1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.d=
ev/
>
> Changes:
> v11 -> v12:
> * Dropped the v11 changes.
> * Stabilized the lru_percpu_hash map test by keeping an extra spare entry=
,
>   which can be used temporarily during updates to avoid unintended LRU
>   evictions.

Please rebase and resend.
This set got lost during holidays.

