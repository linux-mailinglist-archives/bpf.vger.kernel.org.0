Return-Path: <bpf+bounces-77509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D46CE942A
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 10:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6584E301F278
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DCF27B4E8;
	Tue, 30 Dec 2025 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZQAma2nr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579B2BE02D
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088172; cv=none; b=pYXfi/fPcP3Lj7NjFmu8BHUG6XWoKuZAs4nqZr3GV/xUaQUUeTH5WhutU0qIDfyV5V53dNnUEWaRnEw5YGDzwDB8h9LKDSdhW2S78EDL3sTMWDOO/64ZsA0ZZJdWlzZsBp5t0QtdE5osWTH9F7PekGEWKs+NC9iR/FVmxUyoPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088172; c=relaxed/simple;
	bh=4eaz+1wTZP7cgGZagXDHTekg6d8pOXeESnOgAUpsxzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdmi53hNMm5rAS7d7cMJczNxDl74LsEesY/hBdlNpEUW3aF0QLbSqFL9hKg8ppV7E2cpB/OBfaVgXTXNPKvuVT8W1KLaoQf03r0ccGfe2VA1+HBTpuK1XwPxs1pieR/U1vGvJc2tH24b9uK8qD0VIvftitLfh8AqFqxIW+8JUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZQAma2nr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so64125815e9.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767088169; x=1767692969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4eaz+1wTZP7cgGZagXDHTekg6d8pOXeESnOgAUpsxzY=;
        b=ZQAma2nr5pZ0Tm9NvnkydNlm2b+C0Iq5FbZGwJHmDZbAe8V8u0gO3Kf+09VffzAWtQ
         tnaV71XLrdiHOOx67n0CE/xBYYQuHg0+zhSBMHHUFVX6ZTeEc40P5sbQrcdmgJ2lb7i7
         kmjgxNbSDKx0QucmBhXyxKa50pSC5IXcmN6KiOxw5H3msVrJpVUdM0Lv5jxB8haRHcE+
         hUUobucRpA7sAGfOYiKOmb2+5MQmo404KQJ3R8NEQHEPur+vNzS5M4KJfEk5gg4JYSjA
         /ZR/41OLus4cVLISqulvTT1fLrTWsFF1W7Q1l3XtwYggtSIbcKl7i0oRJlP7D3kcTH0w
         P8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767088169; x=1767692969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eaz+1wTZP7cgGZagXDHTekg6d8pOXeESnOgAUpsxzY=;
        b=h7qDrFNUONssfhKRY0U3IiBpezL7o7Z5gZ7vgC17DQHe5lI5B7/TJgt4cb51GuzYfi
         2u2tk4BMnjAXle8d+6/y0f95qU/n6AqGm4n+F6MzoxGiLDzkizDV6xmGW+f1QWwqhfI1
         r0RZerCFXhZl7eYY2K7Xwp4dRLc8SYHfDwvWnUYCJOPklZbRTq9nDscdAB8YlFeEz3Ir
         mduiJ6wSUf2JCiDODHg4Iq55a6tK8j5stMLUURileZaRxyXVnPFzXqQo3vWlYpXqDIYo
         5ySaYdgTgfcLrDuP7ALGZOzeyDtDxuZMFzAvE3hbeIhlFSLQdcsFbeoxDy8iE6mDxNLM
         GtRg==
X-Forwarded-Encrypted: i=1; AJvYcCXjvQsn4MZs++bBlTK7k9/VEQnF4a0fLKzLLgfV7TxOTBN4Ker/f1DlMs29xVtcRsQv+b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QZtgerBED565vxTge/yM3zpgbZiJci8pegJ4Tqw34vIp5bpT
	M1M2BGHFTR7Cw/TZ/HbT/ZYl2QgVyHW0LlHnwliPwuV0bcsXH/sgYTTqQngNS4bGNjc=
X-Gm-Gg: AY/fxX59jRAaIauXI23NnJ4P82H5us3+PXpHpgyUSr8CFw4nM8i80wdPKIohDJgqNft
	EFuZbjWnTCcPhYLDqt9A+oWc6rOl4DOYgBFEJakhTjDdSlCUo1xvupiv3jjXBLrCym0Xcivoi0i
	9Zss5EkDTTjoblDgbO+hyaICs3FEeJq4iDA2R9CMpNeNlqOqa0ioIqoYbYNOEufbEL5saNFxHrg
	7u/CjsopTyHyviNq8L9UNSGyYusKhdzjlOwVBM1I5DsahfhfYKpKTrp0e0fX9iUXAIRx8kipi+g
	k1+8IEL4LW/JJOzb+qmwRLvGHDjbhqGBUWEcAfYfFmMd4yyrQlqGExy82DTHHM5hph8n05oSdwj
	lxsWY/ImyMr5llEHqplRKSaPtJR3fuDAMXJqU3ANYPXEqiXdMZjZw6crleoB1b1fMf2VZNEjKh8
	2CsqSpiS1UZKwotOTWXSWmushiYOYCH2s86jd57IYvBw==
X-Google-Smtp-Source: AGHT+IEN/UHYtedJC5gNScUIjciAIBz4WtImq8j9JAVWa7kOqzOpjNxabiVdwQI/0HAatQaCg3ghcQ==
X-Received: by 2002:a05:600c:1d0b:b0:479:2a0b:180d with SMTP id 5b1f17b1804b1-47d1954a5f7mr386619925e9.11.1767088168725;
        Tue, 30 Dec 2025 01:49:28 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be26a81b6sm657711035e9.0.2025.12.30.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 01:49:28 -0800 (PST)
Date: Tue, 30 Dec 2025 10:49:25 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, davem@davemloft.net, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH v2 0/3] Memory Controller eBPF support
Message-ID: <enlefo5mmoha2htsrvv76tdmj6yum4jan6hgym76adtpxuhvrp@aug6qh3ocde5>
References: <cover.1767012332.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nav7xplzwe6tizdp"
Content-Disposition: inline
In-Reply-To: <cover.1767012332.git.zhuhui@kylinos.cn>


--nav7xplzwe6tizdp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2 0/3] Memory Controller eBPF support
MIME-Version: 1.0

Hi Hui.

On Tue, Dec 30, 2025 at 11:01:58AM +0800, Hui Zhu <hui.zhu@linux.dev> wrote:
> This allows administrators to suppress low-priority cgroups' memory
> usage based on custom policies implemented in BPF programs.

BTW memory.low was conceived as a work-conserving mechanism for
prioritization of different workloads. Have you tried that? No need to
go directly to (high) limits. (<- Main question, below are some
secondary implementation questions/remarks.)

=2E..
> This series introduces a BPF hook that allows reporting
> additional "pages over high" for specific cgroups, effectively
> increasing memory pressure and throttling for lower-priority
> workloads when higher-priority cgroups need resources.

Have you considered hooking into calculate_high_delay() instead? (That
function has undergone some evolution so it'd seem like the candidate
for BPFication.)

=2E..
> 3. Cgroup hierarchy management (inheritance during online/offline)

I see you're copying the program upon memcg creation.
Configuration copies aren't such a good way to properly handle
hierarchical behavior.
I wonder if this could follow the more generic pattern of how BPF progs
are evaluated in hierarchies, see BPF_F_ALLOW_OVERRIDE and
BPF_F_ALLOW_MULTI.


> Example Results
=2E..
> Results show the low-priority cgroup (/sys/fs/cgroup/low) was
> significantly throttled:
> - High-priority cgroup: 21,033,377 bogo ops at 347,825 ops/s
> - Low-priority cgroup: 11,568 bogo ops at 177 ops/s
>=20
> The stress-ng process in the low-priority cgroup experienced a
> ~99.9% slowdown in memory operations compared to the
> high-priority cgroup, demonstrating effective priority
> enforcement through BPF-controlled memory pressure.

As a demonstrator, it'd be good to compare this with a baseline without
any extra progs, e.g. show that high-prio performed better and low-prio
wasn't throttled for nothing.

Thanks,
Michal

--nav7xplzwe6tizdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaVOgEhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjqkwEAsnaDJnUrbpBZvRNgWKP5
6Sa4JrRHis7FmRcVhJPNvUUA/1AnWVzTnXOrXQlAm2C1hsfhl2QuvaTzWc6hD0j/
y5wD
=OLWl
-----END PGP SIGNATURE-----

--nav7xplzwe6tizdp--

