Return-Path: <bpf+bounces-58566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178B5ABDDA3
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD957B6D4B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AB524A057;
	Tue, 20 May 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkhPg54B"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DDC24888F
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752191; cv=none; b=ELqCG/MhvmrbKdSI4bicqhEdnL8N94zoupIHdv5dtCGbLqNxzIfAlbTOYTSqUVVy8zfrxLd4RFTLUZn+leoeO1fWfPXtvkPqmLgvEXDQyxen6+XnIDzydQVLPw9m4AEEj2W/MjXOikZPpPYI7/7g7zbyHIX7R7FnjBo773Rd0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752191; c=relaxed/simple;
	bh=LU160R2Llg42X3BICGVqtCkRAUYr1Mq2mFf+KM3KQVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPy9HVLWsSiaeYtmTL8LL+AyFPxsD2Dzn9meInqI6SJXh2pYc+l9fKoOor9icyiDC69qNegEMtAJfWLFY5LAAuJG+FkmCZXADPO5qAo/Xu5mcBp4bKHqub4nAEBhl7rm93qrzxaEk7MM+b9XtW+Mnfd4bmyQPRvb+RMeu5oTXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkhPg54B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EAPATIh1fAZtjZuQSTR1ra9E8nQTaxiqjCg+FNJ+QM0=; b=qkhPg54BkM9rkl50v1YZujRl/M
	rwazdKek/mePfCntGVEBxZUo2FtSbyt7RpSpQ4YMj2O2R6eh732jIlxHFYECEUT2Ha8sVIwN3A26E
	CVan7is2mJh2fBJ0Ih4PBA0RoupNG6UUGnABnHeIfQHotHEgxp0WXBMesxstgmZR/0kC/zKow9dDw
	gOLmGVgvtfBdd1VXnMxMGbUamLk90Kf/BQPUhzkHNjJmot8m1d8PWahfYi9pc9Jbq8qqrvwoFlpP/
	OIhiBXL5T9xj9/8qycETzXh9O2E+z9KmHlzkS+LkXHxBV/KUwiNzRkkOiOTEYRfbGpNC9KSFjMuge
	WSmhAabQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOBC-00000003OFy-0Yyy;
	Tue, 20 May 2025 14:42:54 +0000
Date: Tue, 20 May 2025 15:42:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Yafang Shao <laoar.shao@gmail.com>,
	Nico Pache <npache@redhat.com>, akpm@linux-foundation.org,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
	hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <aCyU7Q2DhPPF3Oau@casper.infradead.org>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org>
 <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
 <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
 <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
 <a3dfae27-2372-47b7-bc67-49a0c5be422b@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3dfae27-2372-47b7-bc67-49a0c5be422b@lucifer.local>

On Tue, May 20, 2025 at 03:35:49PM +0100, Lorenzo Stoakes wrote:
> I agree global settings are not fine-grained enough, but 'sys admins refuse
> to do X so we want to ignore what they do' is... really not right at all.

Oh, we do that all the time,  Leave the interface around but document
it's now a no-op.  For example, file-backed memory ignores the THP
settings completely.  And mounting an NFS filesystem as "intr" has
been a no-op for over a decade.

