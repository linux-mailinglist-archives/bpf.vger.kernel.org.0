Return-Path: <bpf+bounces-61006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F29ADF928
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 00:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB7D3B9C46
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08BC27E04A;
	Wed, 18 Jun 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkCExPN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB0186294;
	Wed, 18 Jun 2025 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284185; cv=none; b=J23xNFMSguGz/qgxbVRVo5mDQKmOgwS7PGnBTfIrddDMoJWbah9zstZti2NmlaPEJ8E8xvEeTyumr8ZwkaPA0FdljTo3+8kLPeum70jqy7ISNuuw7aN65W8j1pYnivaq/RVhkq6pztELVRX3+ljCU0Ulq9gmbozJkChQPJFSiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284185; c=relaxed/simple;
	bh=XCrE9YZpd1aOHLMWh4zYUf3neHcw+UBD/EiQR4z9ErM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CcvrpfbKy91uDcli5hDaKW0A9/RD7AXmEKEQE9+uoONOoB/iGJrFZY5nBS07z6KrpddzEtW+k+BoOgu52r3Dpjx+IUvWGcF5NbfB6abTpN+hYP66XM+8eILKDeChkYInFbmi4Fvb97npv3AZ3hPfyGv/Y9a/qYp6obx4BFQCHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkCExPN0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70a57a8ffc3so1704727b3.0;
        Wed, 18 Jun 2025 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284182; x=1750888982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCrE9YZpd1aOHLMWh4zYUf3neHcw+UBD/EiQR4z9ErM=;
        b=JkCExPN07UMYjpnHyVp/Oo5M6aagFSfGCf7LLBCBb89k79dXUlkgfUyweeXMQNh6dd
         riMZ/+SvQftmmNzmpcczgCi3p06HgolRPP9KavU8cIVo/nxiL5cghujqdDsTlC9upjE2
         tIQRpS9YUc01Mq3lc0WrQny54O/eikm46z7b2Q78LIWfbpqUoNvUcef2jZ9WgAPrM/Z6
         MHvwNe2Rb/8sYEnWMKyzLrPfyiz8Au2YoI1k62gx+JLZWzc3AI3myHrh3/okDvOgEqVQ
         AJTe2MQhaOzDjnYUZGURh6q21qH7MRz875oDPmrDn7Kje64MCCb2nFqVMZqwMI374jSj
         shug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284182; x=1750888982;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XCrE9YZpd1aOHLMWh4zYUf3neHcw+UBD/EiQR4z9ErM=;
        b=vzc6WUVIr5z/pVkQXp8E5QTytAkT2XkFOhrGAOsjkb2CQUNQsWHOVTZi3fkWHUeo+K
         rV6At5IsE70ELLUN9ToWGXEQIPCbSAEQff1ssLfrsaiWEIhZixPreMy8BNsflYo2tzRs
         A9K7zhOT2g3yhYJSCRtiYi4d+cIEequiLa2uygjZqMsz4q4wBxDmYb7oWjlvYk1Hu5As
         6r1Vi+u7a1F/YPORDjK1m7yLed8tZexxCE1jrukPygox18iPHUwVeYnmGR7Dkw5agMg5
         4IXWfHrM9hkqiorZt/t3qFeTZEiBJGyDyFVBRRAalfkbHe593cY/T9RGBQBZvb5rRUtQ
         p6Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUwlV5M22dBBlLf7KKA8U8QIh/IGaomcQOU/adT+YDupDQ0SaSOZO9QuSHHaoR/xpmBoMgwF3iT@vger.kernel.org, AJvYcCWDAETDyqId8JJCy0or9eKVWI6wB5qepr1ZfmqAlXqwmUTKpIBfRUEpCL6cIMlRyIlAor0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCW7UhySKPk6v9EKKeyvMz95QHhy2y7rISgfbNFthHKEz9jiSK
	HzUL1WXZTIo3s2+NrDmmEklwSPvpwqO8++I3ESN3uBPDQvVpNkNVEpNr
X-Gm-Gg: ASbGncvfEG38bVj+yojJJSKVPjQ3fY/Mr6NoNQ2rSML0aHLrJqguwfrxyZzJ2Z3JMTg
	1VVPS4Hu8styZjNWdPF8bAUF5IF41j/MvamSOO4A5r4xqwImx2qoNJUJEWfAPmu7wThYZVR0qRR
	GmXgUOV47IAjclvcJorlkdzdBKB/HC9WNylLa6n23g3oqCxS5ddBJYP6s1oXu9wVTZIAzvdyEsV
	OkOlc7fQPWK4ijm9NYoiLyhcMGxTAAM/q4MSbls1w9M00lOZLsXWRBe6x2gb+maYFXkk8Mz7Oya
	AmKVT5TSTAZbwfVRqG2/jgPzcrkO8lMtiw+dX+9Svqrbrlylt/bweB/dEU7fkrIzzvyaytEho45
	RT9pYmSOliLx78g0Iz4wN3e9DUEsq2QZeGpnhCiB4Qw==
X-Google-Smtp-Source: AGHT+IH/0+BZXssfQvwAQjkInwKwqJzwZ7siKQhj/08N0p9PmdqMfx2lOhibjDK4nAR8ejA5fMc+JA==
X-Received: by 2002:a05:690c:4c0f:b0:70e:a1e:d9c7 with SMTP id 00721157ae682-7117545bf11mr267700867b3.10.1750284182608;
        Wed, 18 Jun 2025 15:03:02 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712b7b99eabsm262107b3.89.2025.06.18.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:03:02 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:03:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 bpf <bpf@vger.kernel.org>, 
 Network Development <netdev@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <685337959d81b_36b4e62943a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAADnVQJ9e3Sf_kAh1LNqqeVvs7dwOC-AY_KEj5eRGGLGyC1F5A@mail.gmail.com>
References: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>
 <aFLFkFpQP789M1Tx@mail.gmail.com>
 <CAADnVQJ9e3Sf_kAh1LNqqeVvs7dwOC-AY_KEj5eRGGLGyC1F5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: lru: adjust free target to avoid global
 table starvation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov wrote:
> On Wed, Jun 18, 2025 at 6:50=E2=80=AFAM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/06/16 10:38AM, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before =
the
> > > map is full, due to percpu reservations and force shrink before
> > > neighbor stealing. Once a CPU is unable to borrow from the global m=
ap,
> > > it will once steal one elem from a neighbor and after that each tim=
e
> > > flush this one element to the global list and immediately recycle i=
t.
> > >
> > > Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
> > > with 79 CPUs. CPU 79 will observe this behavior even while its
> > > neighbors hold 78 * 127 + 1 * 15 =3D=3D 9921 free elements (99%).
> > >
> > > CPUs need not be active concurrently. The issue can appear with
> > > affinity migration, e.g., irqbalance. Each CPU can reserve and then=

> > > hold onto its 128 elements indefinitely.
> > >
> > > Avoid global list exhaustion by limiting aggregate percpu caches to=

> > > half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count=
.
> > > This change has no effect on sufficiently large tables.
> > >
> > > Similar to LOCAL_NR_SCANS and lru->nr_scans, introduce a map variab=
le
> > > lru->free_target. The extra field fits in a hole in struct bpf_lru.=

> > > The cacheline is already warm where read in the hot path. The field=
 is
> > > only accessed with the lru lock held.
> >
> > Hi Willem! The patch looks very reasonable. I've bumbed into this
> > issue before (see https://lore.kernel.org/bpf/ZJwy478jHkxYNVMc@zh-lab=
-node-5/)
> > but didn't follow up, as we typically have large enough LRU maps.
> >
> > I've tested your patch (with a patched map_tests/map_percpu_stats.c
> > selftest), works as expected for small maps. E.g., before your patch
> > map of size 4096 after being updated 2176 times from 32 threads on 32=

> > CPUS contains around 150 elements, after your patch around (expected)=

> > 2100 elements.
> >
> > Tested-by: Anton Protopopov <a.s.protopopov@gmail.com>
> =

> Looks like we have consensus.

Great. Thanks for the reviews and testing. Good to have more data that
the issue is well understood and the approach helps.

> Willem,
> please target bpf tree when you respin.

Done: https://lore.kernel.org/bpf/20250618215803.3587312-1-willemdebruijn=
.kernel@gmail.com/T/#u=

