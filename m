Return-Path: <bpf+bounces-57077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB72AA52D4
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57CE47AB8E5
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECE2609C8;
	Wed, 30 Apr 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Rsf6T7J9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BE8635B
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035130; cv=none; b=ttpTv2GdxdFFhkfzvfa+ars0Bixkq2vHpkE3KXxLP9VIKHztxqaeLIIpfZV+WXaFRGqlGcZWux/bZ+Z2cOCifAFUOqi/gqrmobuU2dyMxp9wCVAi8QEXBPybDkyFosM3/SxhXvjOCHOl2uuScugDPbKTXlwNXHqy25kdQD2xK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035130; c=relaxed/simple;
	bh=wc5lHge24RhSpCH8xV3bziMGtYMZptmDvluTNg9zx3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQMT4UGJ5moH/Jcf9wZAchdLusKv9UA5ZdOVD55X8rK38m/Ayyx+v8Vak1wrmtM/PVSc5wJApZwKrNHLNYy5M0YZKxmSNu8YSto8mkvYJ18TAUPROkLe1yTa2eM8jgY9EAhRn3UsE0+E8yFmso/rmgrkCf05ejtysXPdZX9q3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Rsf6T7J9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769f3e19a9so1499731cf.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746035126; x=1746639926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LX5E5+yrclRPYO7bZmzsNdM00rttbtt2kuIHVXURFJI=;
        b=Rsf6T7J9SKc/swAQmEf6H3RMBA5qf88TqE/vSKuq+BJ9yQtMPNA2Lc5hqIQN5RCH8h
         cnZfIo2OD62EAcQNwyfAm9XJzR5acktPFX0IWD/FeS8iA2+tu7QewDNcGh+qdedqhAqF
         aL/aIj8Y0zjGAW6iExjrrvO75Exhe3n+yRfy0McKcNfUGV7nrDvWBkyUPBruWFuNU03s
         AHez1FRIJT/2pdWlmYj21zEMHLno2H9zmxfDTq3W4tLfXcXAvnujzpEXZh6jzc+DRNWu
         VjdRjsDMoASCyQf9fYA5/QkeQxUDVFmfQZoUCYISvMz5l4M4QlFQdJt2hm70SPetFpt4
         BfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035126; x=1746639926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LX5E5+yrclRPYO7bZmzsNdM00rttbtt2kuIHVXURFJI=;
        b=n7zuyKHX1XG5b9JeS7f0arldcJomvlAOF8JmXZ1SVO9ZF+DeWc80ZvGZXhZnnK2AuX
         b4gRcV7XRgXrxaY7gLxW/WTMiGrdDeIKETTegiFAw4JWjvCiS6dooO1TxUsnIBxe7qrr
         NcS117TzMEoXQXmzz9coNjEIOVVnZ5erMGZjIM6R23m5QYNo0v+gv3bT4IPx/lZMC8Ru
         BM95oWQ8WGcxzGXUrbBKRYUeIJSQPNBiUIcF6CKr3bnnrIDEqmt5IZjCFEtOS+cQGIs1
         owR66whW4x31R9YKnK0VAc/zL8sXb1hk/6FGptmiV6IoJKLSsgf1HzF2/3rZrrN7hOuO
         44Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXLFA2a7v2HBF+7djwjMspPslBP/lBwJAIhnlR0u5J45eaVBUF/lAMnlG11lEgUWC5AhRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/AYOHon9VnaJb7QndMtfy+s1sUINpX8mQdYTtvhap/SiCoEq
	ffFfT/Zzf97AHmjI8zRaXw/sckFsHGzpVI3hvuXejfDZ26arYr3f1L7AdFJ4v58=
X-Gm-Gg: ASbGncubZs2LZ0tzXbeKOluHZVFLBoShL1YfkLqvPcrALH+jxt+qE61gHh32M9Jx/5b
	RDqYzRT+GzS80e4vA2A6YZbpSiNzivRxtnpAhDxp6LXkqxJD4Tv4qMsBwbBctxsCApEbxjm6DlW
	VygLFm1/fINdtxtsPmNBI7qERhdFYNTegYt35MmzZD+CjNtC5P4w99NR4QslFPjjvW8qtCXpjQ6
	0VqGYVauqnV/HGnKSucUKBX/0MbwHwWmAInoFPaAGos5ORnqIbvCNfxrh8O7rZRXuOsYQDw73yo
	x0fRZ/HlrBySUhgzNY3584lPb/T4M5yz+laneTajEIPOob80+w==
X-Google-Smtp-Source: AGHT+IEIZMLWdLqJD/uNwidEmAHFL2Y/jtLrtYAogpz0B6nNFsiF9JKltQEiqtFavjMny+xp28chhA==
X-Received: by 2002:a05:622a:5516:b0:476:87dd:16f9 with SMTP id d75a77b69052e-489c3a9aademr70947351cf.18.1746035126307;
        Wed, 30 Apr 2025 10:45:26 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ea169304dsm94893631cf.54.2025.04.30.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 10:45:25 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:45:21 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Zi Yan <ziy@nvidia.com>,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, David Hildenbrand <david@redhat.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Message-ID: <20250430174521.GC2020@cmpxchg.org>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
 <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>

On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
> > > > If it isn't, can you state why?
> > > >
> > > > The main difference is that you are saying it's in a container that you
> > > > don't control.  Your plan is to violate the control the internal
> > > > applications have over THP because you know better.  I'm not sure how
> > > > people might feel about you messing with workloads,
> > >
> > > It’s not a mess. They have the option to deploy their services on
> > > dedicated servers, but they would need to pay more for that choice.
> > > This is a two-way decision.
> >
> > This implies you want a container-level way of controlling the setting
> > and not a system service-level?
> 
> Right. We want to control the THP per container.

This does strike me as a reasonable usecase.

I think there is consensus that in the long-term we want this stuff to
just work and truly be transparent to userspace.

In the short-to-medium term, however, there are still quite a few
caveats. thp=always can significantly increase the memory footprint of
sparse virtual regions. Huge allocations are not as cheap and reliable
as we would like them to be, which for real production systems means
having to make workload-specifcic choices and tradeoffs.

There is ongoing work in these areas, but we do have a bit of a
chicken-and-egg problem: on the one hand, huge page adoption is slow
due to limitations in how they can be deployed. For example, we can't
do thp=always on a DC node that runs arbitary combinations of jobs
from a wide array of services. Some might benefit, some might hurt.

Yet, it's much easier to improve the kernel based on exactly such
production experience and data from real-world usecases. We can't
improve the THP shrinker if we can't run THP.

So I don't see it as overriding whoever wrote the software running
inside the container. They don't know, and they shouldn't have to care
about page sizes. It's about letting admins and kernel teams get
started on using and experimenting with this stuff, given the very
real constraints right now, so we can get the feedback necessary to
improve the situation.

