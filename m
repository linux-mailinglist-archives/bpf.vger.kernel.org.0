Return-Path: <bpf+bounces-57222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36EAA72DC
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92267189C247
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39682253F34;
	Fri,  2 May 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NU+Kh4kQ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76A126BF1
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191286; cv=none; b=tB/n3gWh7p1XWCrb+XEk2qp+qP9G0V0bUr4WM5mb7ue0UNEXRnqq2MqZaSGgyQq75BpPGXdvDiuSa3ClBeitIp9gC7dr54v5nWNbjSKf+SDBI1tIW/I/+70Mb+FPkYxuwizBagL8u4mvJy5p4BodDYx+rvtzawXBP0m+iA2zaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191286; c=relaxed/simple;
	bh=JOO5HGGM6E0ClZz1GNoJDgfzewpSBCPTbDSKUhqXOxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doguJ+HWVdRGHszIlQYmwt1nJ4A31YZe0Z2Yz10tzX3TygyTJ56s9kLTLPJTNfwIoRJ+ZjQbo1czj2i1r1OILwYQlbHmRwAiGxD0ArzosL9rk48SYifcrgSM53PpEFjxVlnKaFd5YJpG3T0Ii2rpQEXkkGWC+R3RCzFHnhKVG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NU+Kh4kQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JOO5HGGM6E0ClZz1GNoJDgfzewpSBCPTbDSKUhqXOxg=; b=NU+Kh4kQNJirBpXbLdTy3gxaTx
	Cd9qYKSnMuJK1CMobMCwkUEAqhEEqydcRiQEQbx84aChHy08WVTAEp95ijiXCw0iLBuyS7wzkKo/c
	ZUYZ/XHhrzdkANgtrdJnIwKTRqRWkkNIhwMzBbFNMKIpuOUB4vw+GtYsBUujnPcXczchpBTBodNHQ
	U2pE5fWakfBhWT39QCZrv/5GnLc6TU9rzUylKV/8Rgi8SQVbtWbE8xnkyEiziPNo4V2yhNKCxUvbE
	OozZUqJVY3IwI9MZSSjI442eC9BNMl+TTdQDEF2ZLUJN8hEXnHwb06E6HjQhsZkJOUjVdxxi59CsG
	7cnurz1w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAq6I-00000000Z3b-1Big;
	Fri, 02 May 2025 13:06:46 +0000
Date: Fri, 2 May 2025 14:06:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Zi Yan <ziy@nvidia.com>,
	Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Message-ID: <aBTDZpxhaYjiMmiz@casper.infradead.org>
References: <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
 <20250430174521.GC2020@cmpxchg.org>
 <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
 <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
 <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
 <3006EA5B-3E02-4D82-8626-90735FE8F656@nvidia.com>
 <CALOAHbA6uWTGZ10n3Lk2Jm5xBPC5ob9aw87EHmkvm6__PYJ_5g@mail.gmail.com>
 <4883bdec-f7f2-4350-bf72-f0fa75c9ddd5@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4883bdec-f7f2-4350-bf72-f0fa75c9ddd5@redhat.com>

On Fri, May 02, 2025 at 03:04:12PM +0200, David Hildenbrand wrote:
> I mean, READ_ONLY_THP_FOR_FS is still around and still EXPERIMENTAL ...

It's going away RSN.

