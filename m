Return-Path: <bpf+bounces-73533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C2BC336E4
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733AE18C4CF2
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E934B671;
	Tue,  4 Nov 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IriDAt95"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492134AAF1
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300345; cv=none; b=DGQ/czByPx5+VwkZvQEHLeMpRaBZH8HdHT8R8jvSn21BVZoLE5Oyn8WupO1c+T31LrNMrk6T/osjKyOapKsmXRd59dwgDGpbilluTFKGTaKhd6jzwphf7PJlqWUV7lI9+cryXg9hcicvcnDRYK/xWa4mAsMZsdGqpUJYbJaTg9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300345; c=relaxed/simple;
	bh=X9pzuci0xDRWBJScPVmHnsADaYEmW96GYCLWT+M7sE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxdaHgE7QxTEuNUmD4ZiABgVuE/XhyDOcS1kFdPHpPaxil9lC0JEMheX3x9QTXiBSt+YLswwEac3LUGk3K/hmLlP/GLg+WyMjmdxAtuO+cXurObMv97WyaJW5Osp1Pj+w6+XdunQEu5n4IohYPw0bKTp8+VksDkffWCMe/JPAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IriDAt95; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so33128535e9.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 15:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762300341; x=1762905141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iAwhN1/FAWCNhMDAxo6TB/rEw9bBFUMecX3kDQXX5I=;
        b=IriDAt95e+FdUp6paI1BWYPmAYnXb3iCt+OT57yV+8peV2UlA9VeVNgwD8jkBy2IyO
         bs33q3KpNCeT56o2WCW/xbk74IkbVmY0CQoIqzmuVVdDckt7zwbJbqFikKbqexN+R5P5
         XHWvO1Ym1ynV1NRdhzdOj+1hH9OrGqjUTj1CrImS0qWjQjvLRZRMNrfJYE1yMxln1DVc
         FQFlGMZoNGmH9DYFfMncGWW9FTF/GrOZZvWsfuAEEBA3Kmsao+1pixML2v6dojV6Qh4A
         psaQyCtZbNQPhxs317o+ufQCeKnyyCFUCUB/BholSlT5xLi5CsD2cnA1N7ZRR5gZSnWN
         Gv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762300341; x=1762905141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iAwhN1/FAWCNhMDAxo6TB/rEw9bBFUMecX3kDQXX5I=;
        b=etZ2arKFsQwtc7j9PMjpEen9uwi7yxPRy5/2NmgtN8fcVItVy+26Fy4VqHbmXzf3u4
         r7UGknUQIfeZxNmA0r2rrgxfkJQgJpt77oFYqKDdtbnpdfy7/UNY7DrAipqJ//YRwXK+
         BUI3pwQbyNhI9hmrqniu5iFBqkidWwnzO9xvS0PIKNej+xD7oXEns8lsjZWV/PhJ3BZj
         UZClm0H7Dot2C98XBbz8EEjOHA8jxSwZNpuD7BeoWwmoqoxtB6WVNTTBzVJIKIwLiqHI
         r1ynPvB+H68eayiuH6bnwhhUhgAswKDzyQy4KWu8a+NsBVSqcTMdl5HclNYgJnVB0PIs
         kYLQ==
X-Gm-Message-State: AOJu0Yx+0mW48VjduvQao567KskeVE9PVUYJo+t7P+0eiEaiOYfodkVe
	FuaSWHLKypKxz95R2HqAG0laguz4fbexjhBpKwRp63Lv2GRgPA8I0USJQuPWu25unvweheuK/vW
	K89lHjAGuiR+7Ztp5FINTGIQGGNimKsc=
X-Gm-Gg: ASbGncso2JIuYfkmm5LHtJ7CBTUvtzEg01U939JMeulICQBjHIgdBfKT/LhOpuszNmx
	5fntuzMq0ScWUtYrqjeGE4Hm1XgDZ4OVDPZccWLj/prwf7PSc2AWW7EF1cq82N6VT35wMFftgeA
	Z9rYhxq1wKl/ZFmWBDH97gG0J+6CRL2E0Rg3esolMJIkYiWqW105vHhLDsqRokK1c+jvkiVoL60
	ddHsWnOmPS8qqsIGQP7QBmP0r4qCWFhMkLhjTy3qfW+yEae2/NXvnCJSsp1569j8e9vnq1SjDg8
	TNXEs2tZ787HG7HZjQ==
X-Google-Smtp-Source: AGHT+IEcT7tuWqiFoWrgl5ub9F95ReRxgaGqb8SROawxNLmKbGuq8Mlq2X7LuExoaGVTjnpYUqNaSz7a6aCGkJCya14=
X-Received: by 2002:a05:600c:821b:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-4775cdf259amr9587355e9.27.1762300341336; Tue, 04 Nov 2025
 15:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104164948.33408-1-puranjay@kernel.org>
In-Reply-To: <20251104164948.33408-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 15:52:10 -0800
X-Gm-Features: AWmQ_bkQM9RwFq-CjpBrj5dMDirnAQ7QVCp-GvnDWcYmcybui2nxo7sHJB4wyyg
Message-ID: <CAADnVQJabNCvyT_b2JcW6YdtwCaSs8YVPcdk1FacLJjpz=KFqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Optimize recursion detection for arm64
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:49=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> BPF programs detect recursion by a per-cpu active flag in struct
> bpf_prog. This flag is set/unset in the trampoline using atomic
> operations to prevent inter-context recursion.
>
> Some arm64 platforms have slow per-CPU atomic operations, for example,
> the Neoverse V2.  This commit therefore changes the recursion detection
> mechanism to allow four levels of recursion (normal -> softirq -> hardirq
> -> NMI). With allowing limited recursion, we can now stop using atomic
> operations. This approach is similar to get_recursion_context() in perf.
>
> Change active to a per-cpu array of four u8 values, one for each context
> and use non-atomic increment/decrement on them.
>
> This improves the performance on ARM64 (64-CPU Neoverse-N1):
>
>  +----------------+-------------------+-------------------+---------+
>  |    Benchmark   |     Base run      |   Patched run     |  =CE=94 (%)  =
|
>  +----------------+-------------------+-------------------+---------+
>  | fentry         |  3.694 =C2=B1 0.003M/s |  3.828 =C2=B1 0.007M/s | +3.=
63%  |
>  | fexit          |  1.389 =C2=B1 0.006M/s |  1.406 =C2=B1 0.003M/s | +1.=
22%  |
>  | fmodret        |  1.366 =C2=B1 0.011M/s |  1.398 =C2=B1 0.002M/s | +2.=
34%  |
>  | rawtp          |  3.453 =C2=B1 0.026M/s |  3.714 =C2=B1 0.003M/s | +7.=
56%  |
>  | tp             |  2.596 =C2=B1 0.005M/s |  2.699 =C2=B1 0.006M/s | +3.=
97%  |
>  +----------------+-------------------+-------------------+---------+

The gain is nice, but absolute numbers look very low.
I see fentry doing 52M on the debug kernel with kasan inside VM.

The patch itself looks good to me, but I realized that we cannot
use this approach for progs with a private stack,
since they require a strict one user per cpu.

Also tracing progs might have conceptually similar restriction.
A prog could use per-cpu map to store some data.
If prog is attached to some function that may be called from
task and irq context the irq execution will write over per-cpu data
and when it returns the same prog in task context will see garbage.
I'm afraid get_recursion_context() approach won't work. Sorry for
not-thought-through suggestion.

Looking at the other thread it looks like this_cpu_inc_return()
is actually fast on arm64, while this_cpu_inc() is horrible.
And we're using _return() flavor almost everywhere,
so it's probably fine, but this patch shows that there is room
for improvement.
Please check why absolute numbers are so low though.

Also let's benchmark xchg(prog->active, 1) vs this_cpu_inc_return().
And its variant this_cpu_xchg().
xchg() will probably be slower.
this_cpu_xchg() may be faster?
pls test a few x86 and arm64 setups.

pw-bot: cr

