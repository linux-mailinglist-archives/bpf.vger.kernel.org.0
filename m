Return-Path: <bpf+bounces-58557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4244ABD8FE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202D78A7E0D
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560822D781;
	Tue, 20 May 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZmt+6sW"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF411187
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746628; cv=none; b=dJ7wYRW4qNwcQqgWweBp8YBgXuJpE7nXxdXg1GzYYBjHNu+fLnxcZ4rNwYSie0FxNinq8CtNDQDqUjFTeCx4NyVYWnCggbHebnvnaWy9yG0eSxrA9zbNuyf/laOK9jsWDGWjouRQQzkspUzUMWyhc+zlOmyEPIG9LrzcEQvNq2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746628; c=relaxed/simple;
	bh=T5tn3S6QAe7g+1q/Cz5JqW4UrYk3AzOtpbnceO/Rhf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8JAU3FRPh02xn/7+OlCbtqnK1rLDp5FDlyQGXkaEfMl6DjwLwCQWGISnjjQyuP50yaNkGET1Hf42p+BOQxll05QAJKKqCXsiiIfMzLEqq+O+34tBLaEZqx7Co5wMma7sHLywiVQXnnTSqyuLbE9hFyqEx3cIfQSSTekOQUD+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZmt+6sW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bz6Z9hDKtS0paPGIr6RPt2j7CPSGJofKn6vv5s6lY/4=; b=NZmt+6sWJtSYETPLZSyMipPVa1
	9Fq5G7m3Cc3LlCR2mijSBOw35CKA0Pe1NJ6GQlEBXSyYzMYcVOAIzH5IA2Fr7vTQ+fv4c65jDjCBO
	ke79Q7fI3lZs0Lz2UVwmONC1kmH7LYyTvIpblj0vr8xZlBTSIgXQrwCGD7OsO0casQT27skWdhe7Z
	RhwGWfbjhB+h4k7q3LwZ0kGnwcRVoV9GhCO7sWZWsxY+8G9DiDotfrC57ONBsf8a9SJ3lUPk0vuZw
	lDSPrO5PJaZqxigBs8JqSxTF+HP3T162UyDBawuB971T9WTjXx2wu4ZlF+nRJZdzkU26M0sVo7KRX
	EnZ8dOhg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHMjW-00000003IV3-17wq;
	Tue, 20 May 2025 13:10:14 +0000
Date: Tue, 20 May 2025 14:10:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Nico Pache <npache@redhat.com>, akpm@linux-foundation.org,
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Message-ID: <aCx_Ngyjl3oOwJKG@casper.infradead.org>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>

On Tue, May 20, 2025 at 03:25:07PM +0800, Yafang Shao wrote:
> The challenge we face is that our system administration team doesn't
> permit enabling THP globally in production by setting it to "madvise"
> or "always". As a result, we can only experiment with your feature on
> our test servers at this stage.

That's a you problem.  You need to figure out how to influence your
sysadmin team to change their mind; whether it's by talking to their
superiors or persuading them directly.  It's not a justification for why
upstream should take this patch.

