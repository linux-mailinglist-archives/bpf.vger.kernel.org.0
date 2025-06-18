Return-Path: <bpf+bounces-60933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6FADEE95
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06777165DAD
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6148B2EA739;
	Wed, 18 Jun 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXLa9lvU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B82EA733;
	Wed, 18 Jun 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254941; cv=none; b=jRrbyim23EgC2Nhq2hz/Lv9Upcr5cgMIpdo7sjAp3vWqCt00CwGG7uD2ETw3kqsyTqSk+7JbNqC+Tg1v9/v6NDldh3TBQrHH7ncsK/p59X/6yek/6/uXGwsLGXiXQFnSh9PPw/kmTOVSPQ7JymzwI/3eBPKmQTTvZ20sOSTv0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254941; c=relaxed/simple;
	bh=gx+h3lSh4Jepxc+O8pXLQ82fTA6oke/o0DXkKDYoMJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdI51It0Bknn1jA0IJ7uP0gCDxGYhCW1H2SvB/cidsHgWTa7J2GNY5G4I9ghFwOtdPvSY4Trsc4zsH5JVozB+qUt3lsIyruK48XGsqiaShUjXtUnBCpVILlEMI3UXLI5gVYq12nt4ULmU9nreSHEjNKTADwVwk/ZqpFZ/JKDwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXLa9lvU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cf214200so60234915e9.1;
        Wed, 18 Jun 2025 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750254938; x=1750859738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gx+h3lSh4Jepxc+O8pXLQ82fTA6oke/o0DXkKDYoMJA=;
        b=AXLa9lvUEh3j3vNkqnm+G4asiw+lP6caJScDSQbeHBscSXp8pbIHFT/CIvjLgpddzc
         9OUedXM4lfjs5cZ0G0ciS2PfOjozRewpPgx5M0UCG/hYSlq3UUnyi5rFDfe9cOM2TkdH
         XJ10nhI6F+qwFnsOfj+1x7X4RoiSH4D0lOq+McKEfBWLvFpiOFjYDLyaytGBOj/nBvJg
         xtc569S9vpoyK8eavWWtrfVPxhXNVQxvwET5K7AxswLYB2qVWTEOa7r8qhMBzVIDWbnl
         i9dhHGGeBB5jK6Ob5eTuO4EZfVZCRkK/TpDY4xghn0AXaDzFjL47FgcAIVR6lJ1AsWRf
         TGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254938; x=1750859738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gx+h3lSh4Jepxc+O8pXLQ82fTA6oke/o0DXkKDYoMJA=;
        b=frEKAiQffdYIa3BnKFNovACcpBipN48ZdfWgANOD46AFjXY/W+7jTcpVUZPU4xj3LF
         HJDaQShciTY9SO+Mm+cmKBk98EyVZpdkmbr9rjEs6EFLmp16OfcfpUUj6P62piHhjbhh
         KB3dHjX2OcJvKvtY6XerB0HGQx0VxQEQyirwz4c6gq85uo8Sk7oDKA60Pks+v5DvFo3X
         atDsRYD1QuXfbFG/IocIHZ2U4seKTH0gsqxn5B7IsgW6blo5LUHYF5UU3BD86v8FQxeG
         Ljf1R9op40bItjJx5LxOAXRPUYpzCDDEYLUlZ0VDTmoFiwmVMOEtH5HeCRssQ8EF3k16
         zeJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMeGekd/dLlGukZRDsw4fxQp5nvdusxWblPnyrfDfINe1Jblr9G0+9sXltPUuIiZej6Nn+e7A7@vger.kernel.org, AJvYcCVe++pRHEfrgSo4uFurR7UJxHsKYMER67KpXYOnaj2rLznQYfeESY+pxU8WcnHX0Kq4R88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvDe+Qrm7I6xvaqd1g2mrW6gOMkjKzINx1ljjlZytTkKcqddA
	W7QRMMzF/4QaZa8+jqZhzYc8EWzM+lvbBtT82qfLnOlZyhOH6kp2cgmNelwrK4fHq72BgNJRqLk
	lJMuzyeLGckoYhrLRwmEaPhuyO6IKtx36jw==
X-Gm-Gg: ASbGncuHUs7Lh8QXWqW8gae3U2+5JlM6dbKInXBSfgcWTqVsNtlgYkkq7kXeq4xYlGo
	qH8NuP4D9OrZSJpyLc/UvGtN6/y6i8QX/sxjKe2zC+WDWap77MkrEkZdca6k9knssKtA12/YAo2
	ixwHHIb8tx0Purdy6LxLs55Q9mY91S2mqV1St/p6QeVo5dKcNq5hALPXi7fs983df8r/0wsLiYm
	aZ6bTy+HoY=
X-Google-Smtp-Source: AGHT+IHDoKNc8XOtTbe2orSChEcrWqEC8PHhmYDUT8YfV2CDPcqRIsj9tUSL68FxNGM41+8brCOybvH3mptxoFLHPEw=
X-Received: by 2002:a05:600c:3e19:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-4533cadf928mr170600855e9.30.1750254938270; Wed, 18 Jun 2025
 06:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com> <aFLFkFpQP789M1Tx@mail.gmail.com>
In-Reply-To: <aFLFkFpQP789M1Tx@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Jun 2025 06:55:26 -0700
X-Gm-Features: Ac12FXxJByYbVqEo1nTEMnir_otv-CadiwMHeSWF5PYiM4XSd4cdw3LKtJhQ9b0
Message-ID: <CAADnVQJ9e3Sf_kAh1LNqqeVvs7dwOC-AY_KEj5eRGGLGyC1F5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: lru: adjust free target to avoid global
 table starvation
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 6:50=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/06/16 10:38AM, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
> > map is full, due to percpu reservations and force shrink before
> > neighbor stealing. Once a CPU is unable to borrow from the global map,
> > it will once steal one elem from a neighbor and after that each time
> > flush this one element to the global list and immediately recycle it.
> >
> > Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
> > with 79 CPUs. CPU 79 will observe this behavior even while its
> > neighbors hold 78 * 127 + 1 * 15 =3D=3D 9921 free elements (99%).
> >
> > CPUs need not be active concurrently. The issue can appear with
> > affinity migration, e.g., irqbalance. Each CPU can reserve and then
> > hold onto its 128 elements indefinitely.
> >
> > Avoid global list exhaustion by limiting aggregate percpu caches to
> > half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count.
> > This change has no effect on sufficiently large tables.
> >
> > Similar to LOCAL_NR_SCANS and lru->nr_scans, introduce a map variable
> > lru->free_target. The extra field fits in a hole in struct bpf_lru.
> > The cacheline is already warm where read in the hot path. The field is
> > only accessed with the lru lock held.
>
> Hi Willem! The patch looks very reasonable. I've bumbed into this
> issue before (see https://lore.kernel.org/bpf/ZJwy478jHkxYNVMc@zh-lab-nod=
e-5/)
> but didn't follow up, as we typically have large enough LRU maps.
>
> I've tested your patch (with a patched map_tests/map_percpu_stats.c
> selftest), works as expected for small maps. E.g., before your patch
> map of size 4096 after being updated 2176 times from 32 threads on 32
> CPUS contains around 150 elements, after your patch around (expected)
> 2100 elements.
>
> Tested-by: Anton Protopopov <a.s.protopopov@gmail.com>

Looks like we have consensus.

Willem,
please target bpf tree when you respin.

