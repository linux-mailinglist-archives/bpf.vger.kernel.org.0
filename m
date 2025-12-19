Return-Path: <bpf+bounces-77158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1E7CD067E
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E23430865DB
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300AC33B973;
	Fri, 19 Dec 2025 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrNIoHw2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB35329E55
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155920; cv=none; b=dN5R/sNgNIrDFKCpm6TA1Wls5nNVLT8Zg7cjNnOId+rn4dpqTB1HfiKQIb9vZJE89TJFHhnHYU3TN6ZIc2xUAZfnuDIOeq0rfyr6LgN0T7TXOFf9tVAzOKguGettoO8lWROt/IBFhz6KoKatA0FDdGaImYrp8MkMldlmdaklCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155920; c=relaxed/simple;
	bh=T34RqGeGnjOKUGciQBRx+nn+LJqaJ4XQvp2thwWEcfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+/6jREVSHv+cCwW8Z+/yzr2qnjEsO10RyMKtmwhbGkwhv4e8wSYp2bzSTLOP6L/f2Q6TYVu41nxekXwgKIhX36djwO3HS2QrE/rWVy6Uwe6nSbg/nOAHGoILT39JtMNmv7KQeeoUqXHOm7gYdvY6RfvoNGmu28se1a7bc4e/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrNIoHw2; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-6420c08f886so2401236d50.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766155914; x=1766760714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T34RqGeGnjOKUGciQBRx+nn+LJqaJ4XQvp2thwWEcfc=;
        b=BrNIoHw2unRe0F+MelRGJL1TMDcPLhrNsd1BColv1tm5UT91OyHeH2mFK4EkOIJt+k
         NfS6/3OHE23FgL2aNsowm/z3mJGIWO/SQDqcm8+sEOiZJwQdNuqHZdXp9vdtimxCCU/q
         XZyfTTVPHdi4c9G2uaEmBr47ZK85wiyWcQY9byMeGV1Zs3J/+YEM72JXy64ZkO3F2xa8
         vTm6IheV6EEgtplPRQ0szx/eC+F4bfe2FfBxD0FmFR2CUZpkNF/NZmmUWB7BVZs9U1lG
         ymkgu+5iuiQsbzm5mxaZgxT0yl/bqEATGrJ8XtISwalym8JEZl+YUfmIvkh1KYwodNfV
         +EAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155914; x=1766760714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T34RqGeGnjOKUGciQBRx+nn+LJqaJ4XQvp2thwWEcfc=;
        b=vpj/+N34hXuIl6XfLgvb3tcX8GxY+eu05pzvWRD2G3VuT2MrPrtR8kkM7ZRfma7HiC
         vz6kCORALynJqJzmV1lCa0x7iVwTfjg1KSm8JqsLazJ6nN0EwQMS+SzvZhhuqP+3zK6K
         MWP4PpFWoB+Kh6DDMIXvbUKDQl3YuIg6FDec9Y8A1+56vtDU/IyCtLAiU8G1D0MyyX7A
         t/w+hmXXISR63xCuVqSGGkfR1MVavE3AXUFtahG/01gaXT7tRQ+lM6if93s6i+9cGSDn
         K/z5GvWI7OqxX+YEl59Y3mbWpH/FOMv87tF+8a4Bz84xDse1xIS2jy/d2pgFj7c09P0V
         OveA==
X-Forwarded-Encrypted: i=1; AJvYcCUQpqe4NuodYJvz5zxb0rBN/ys6/+Z3z1qDjYccT6Mf0AMrUS4yX5qDt73HjZbW2OOPHbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0caGwUOCZsGmYLyy543Lfjy0hM90VkQrl8Eves06rQQah8geN
	A/sJEvXVktadhc1FDLXA6Ah4OE7guBrquD0a/3l0rPxj69ljKtcpp+/0LAaXH51hgg+a4VDnoFm
	iS59ToDA9szpsWNcHvysMXpHOtDvZc+U=
X-Gm-Gg: AY/fxX7Hy0yzLmQRBdmfJy1fUtj9+KB20i9B7xedv79FrSQRhP6HT23wxkHDIEhBuYH
	GUkTp/admZwhmj1vSg5dRWNo1ZzUW6xOu15jFN/+GSpL4MiPo2p5WC3l9N4UB/haevU4a1Wi38R
	HeAeXv2jPjrO7WDK35tboQetedmq3AI9Dz2NXyYD5flHMQfaQOBwo4lXjuMDrUDay7SGqACnD6m
	OLXFzIoVV8jeYbUrr3IGdqXGW8XV+wi9RZ756vcA4Awy9Z/T/PPotph7RtYsPZdbHW7XctvDXw=
X-Google-Smtp-Source: AGHT+IGYt3hmA6z9rLwLs0TIpkxe/pEyyQuxnSnakYVCr+VNSwGyLqdmFy7K/kMsU9Wlx3pkt6/LyQ7Ql8eFrG9EgOM=
X-Received: by 2002:a05:690e:44e:b0:644:6fab:5644 with SMTP id
 956f58d0204a3-6466a8b4d23mr1962313d50.51.1766155914532; Fri, 19 Dec 2025
 06:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD_bPKbZaEHmKzVcLPGJuR3Y3MO1AJDA0TmLZrLkCJ0PzCM1A@mail.gmail.com>
In-Reply-To: <CAJD_bPKbZaEHmKzVcLPGJuR3Y3MO1AJDA0TmLZrLkCJ0PzCM1A@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 19 Dec 2025 22:51:43 +0800
X-Gm-Features: AQt7F2rB5ZoVFLuFvudPA_r_ARNanxGv0N4ryxkcn2Ub_wWbOu7U5KxZi_0OWGc
Message-ID: <CADxym3b=gBhefPMUCeiE_H0WPbG9AuL5tGe_6gsCZ8wi1ifJoA@mail.gmail.com>
Subject: Re: [REGRESSION] Cannot boot 6.19-rc1 on riscv64 with BPF enabled.
To: Jason Montleon <jmontleo@redhat.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, ast@kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:36=E2=80=AFPM Jason Montleon <jmontleo@redhat.co=
m> wrote:
>
> When booting riscv64 systems with BPF enabled using 6.19-rc1 the
> system produces the following panic. I tried on several boards and
> they resulted in the same error.

Sorry about the problem. I have sent a fix for this issue:
https://lore.kernel.org/bpf/20251219124748.81133-1-dongml2@chinatelecom.cn/=
T/#u

And here is the discussion about it:
https://lore.kernel.org/bpf/CADxym3Y098836fHHRSjeryxCp=3DCPB8sDU19TBBVs07VZ=
OERJXw@mail.gmail.com/T/#u

Thanks!
Menglong Dong

>
> [ 5.380583] Insufficient stack space to handle exception!
> [ 5.385986] Task stack: [0xffffffc600020000..0xffffffc600024000]
> [ 5.392339] Overflow stack: [0xffffffd7fef7a070..0xffffffd7fef7b070]
> [ 5.398693] CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G W
> 6.19.0-rc1-00001-g74d9cab5b6c1 #15 NONE
> [ 5.409302] Tainted: [W]=3DWARN
> [ 5.412271] Hardware name: starfive StarFive VisionFive 2
> v1.3B/StarFive VisionFive 2 v1.3B, BIOS 2024.10-rc3 10/01/2024
> [ 5.423134] epc : copy_from_kernel_nofault_allowed+0xa/0x28
> [ 5.428718] ra : copy_from_kernel_nofault+0x28/0x198
> [ 5.433774] epc : ffffffff8024062a ra : ffffffff80240670 sp : ffffffc6000=
1fff0
> [ 5.440997] gp : ffffffff82464ce8 tp : 0000000000000000 t0 : ffffffff8002=
4620
> [ 5.448219] t1 : ffffffff8017c052 t2 : 0000000000000000 s0 : ffffffc60002=
0030
> [ 5.455442] s1 : ffffffd6c2198260 a0 : ffffffd6c2198260 a1 : 000000000000=
0008
> [ 5.462664] a2 : 0000000000000008 a3 : 000000000000009d a4 : 000000000000=
0000
> [ 5.469885] a5 : 0000000000000000 a6 : 0000000000000021 a7 : 000000000000=
0003
> [ 5.477106] s2 : ffffffc600020070 s3 : 0000000000000008 s4 : 000000000000=
0000
> [ 5.484327] s5 : ffffffc600020080 s6 : 0000000000000000 s7 : 000000000003=
8000
> [ 5.491549] s8 : 0000000000008002 s9 : 0000000000380000 s10: ffffffc60002=
3cf8
> [ 5.498771] s11: ffffffd6c419bf00 t3 : 0000000077ab9db9 t4 : 000000001139=
18e7
> [ 5.505993] t5 : ffffffff9e9bcc29 t6 : ffffffc600023ad4
> [ 5.511304] status: 0000000200000120 badaddr: ffffffc60001fff0 cause:
> 000000000000000f
> [ 5.519221] Kernel panic - not syncing: Kernel stack overflow
> [ 5.524967] CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G W
> 6.19.0-rc1-00001-g74d9cab5b6c1 #15 NONE
> [ 5.535574] Tainted: [W]=3DWARN
> [ 5.538544] Hardware name: starfive StarFive VisionFive 2
> v1.3B/StarFive VisionFive 2 v1.3B, BIOS 2024.10-rc3 10/01/2024
> [ 5.549408] Call Trace:
> [ 5.551859] [<ffffffff8001e438>] dump_backtrace+0x28/0x38
> [ 5.557262] [<ffffffff80002462>] show_stack+0x3a/0x50
> [ 5.562317] [<ffffffff80016d02>] dump_stack_lvl+0x5a/0x80
> [ 5.567720] [<ffffffff80016d40>] dump_stack+0x18/0x20
> [ 5.572776] [<ffffffff80002b7a>] vpanic+0xf2/0x2d0
> [ 5.577570] [<ffffffff80002d96>] panic+0x3e/0x48
> [ 5.582191] [<ffffffff8001e110>] handle_bad_stack+0x98/0xc0
> [ 5.587765] [<ffffffff80240670>] copy_from_kernel_nofault+0x28/0x198
> [ 5.594122] SMP: stopping secondary CPUs
> [ 5.598070] ---[ end Kernel panic - not syncing: Kernel stack overflow ]-=
--
>
> A bisect identified 47c9214dcb as the problematic commit:
> [47c9214dcbea9043ac20441a285c7bb5486b8b2d] bpf: fix the usage of
> BPF_TRAMP_F_SKIP_FRAME
>
> This commit reverts cleanly and when building 6.19-rc1 without it I am
> able to boot successfully.
>
> A copy of the trace, bisect log, and config used to reproduce the
> problem are at:
> https://gist.github.com/jmontleon/b8b861352e7b9bc9fd3a93d391926dec
>
> #regzbot introduced: 47c9214dcb
>
> Thank you,
> Jason Montleon
>

