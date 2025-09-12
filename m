Return-Path: <bpf+bounces-68249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A1B55597
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3C0AE312C
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B547277004;
	Fri, 12 Sep 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="szwTwO06"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533F19004E
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699255; cv=none; b=NOECgU/hJLCKswO9cnkqsaPHM1w9L5xNPu8fw1an5pvoCHCR1x23tJArESTym2vktMuocXASY7+MERTENdPX2/DH/Kx4HHF07qHeIzXLJaEX7i4gIQUrxH6xJ+CQIZeviu88pTMMnA3OKZzHPGdjAePo8Nx7EWP/Mj1ZJKzLCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699255; c=relaxed/simple;
	bh=A61Su6k/dp1CpP7dEIqbrQHFodSxJ3sWcXDRAOmxb70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFHZtgzVaNZL9QrgzQOpI2iVXLr+lpvXl86Xu1UISDOMu4XiUXq8+3H6Fpylg4OL2Eh0gNz47jYSQ7ehG6EG4waCzERvopzVoLxPza+QkxCy1jvYzBlf9u+K6TQe9Z1+9xFWjmCMqwT6TsOkIOqRps0S1Zk6ZzLvacRsRKW6G+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=szwTwO06; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 10:47:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757699251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUI9puXoXEZZrLl1P89JxrjIx1+qg9LD/VjY/AoyGf8=;
	b=szwTwO06r2E5qVvdExD2md6215HmJd6XdwvLUmDx+MavynFdUduMvmdOgcuEJkzBHMhR3L
	i1tPw4L7zqTd7wb90PyaUiVP9inl42N983nf2Y9VHbMRUyPyUKMLuEI0T4hUFWuN16/Ouf
	ctElUUUl/eWQp3YwxQ9EGLGRSTV7/kk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, mhocko@suse.com, bigeasy@linutronix.de, andrii@kernel.org, 
	memxor@gmail.com, akpm@linux-foundation.org, peterz@infradead.org, 
	rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 2/6] mm: Allow GFP_ACCOUNT to be used in
 alloc_pages_nolock().
Message-ID: <fbzqv6b4lvfqjyvpszqa7fzpbytywbjamehjez7yshc26ugdiv@e3edtofa4pwu>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-3-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 08, 2025 at 06:00:03PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Change alloc_pages_nolock() to default to __GFP_COMP when allocating
> pages, since upcoming reentrant alloc_slab_page() needs __GFP_COMP.
> Also allow __GFP_ACCOUNT flag to be specified,
> since most of BPF infra needs __GFP_ACCOUNT except BPF streams.
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>


