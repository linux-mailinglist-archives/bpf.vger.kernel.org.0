Return-Path: <bpf+bounces-49975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC6A21077
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 19:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BB51886376
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A071DE4CE;
	Tue, 28 Jan 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YI5hZtm4"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E051B040E
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087767; cv=none; b=tnBjXBHPExW8QGD7e+t/Wl/eK9dVCTaPTG72UUAR1wBhx89cVN64cK/1/1S0cUR8HqVok6qYnhwDTxm5cEdR20HdKlNJdSkc0yJML3IUvJ9ksHZcFPQSn8Xo/ifCZzL3PosSpeEnQJzJ3AsQ0iRhGXEC7pn04v6LPucfWgzMu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087767; c=relaxed/simple;
	bh=ulrF22hA5mUoBiAKIqH9rVm4zj/OAEQm7yodllRuO+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS3c2Q6xFCMH0I17q7xfJXsC6r3/5K45M+kvUmxhhku0sqDK14ESJYL17lW6RVXupY+zueTwNxx82wN3WdjsOQd+j3tDVhiZq70SV6fkn4ZlVTi9iD5UgQLrTyTk1QLGTOF4X4xKWFY8zhVzqs3aQynigB414ZWYLntnqiOr/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YI5hZtm4; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 10:09:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738087762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMNVtdoOiiJwZdxUc7AuXSiKJz6d1qLJ0rKkYN+iS44=;
	b=YI5hZtm4eC3jSHGxtikZmBgF6/JzhZ52EzoW+botP7fF1+/ycnqA039CDOjiP01F81WegL
	WDXddekl/cO/sM5cPVt97dxpVvqJJowZ7xPQ/UMeSTlVM3qtahZZpUA0hFEJ7d7ps4mGx9
	f9RiwoJoWYjIAGP8raDH8thDJDiRfBc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, mhocko@suse.com, 
	willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v6 1/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <xmuu4yauy2mlkikoxajtdihokooyjloxeawe2dokce4f5ivoxp@b6poujc5ei5f>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <20250124035655.78899-2-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124035655.78899-2-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 07:56:50PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Tracing BPF programs execute from tracepoints and kprobes where
> running context is unknown, but they need to request additional
> memory. The prior workarounds were using pre-allocated memory and
> BPF specific freelists to satisfy such allocation requests.
> Instead, introduce gfpflags_allow_spinning() condition that signals
> to the allocator that running context is unknown.
> Then rely on percpu free list of pages to allocate a page.
> try_alloc_pages() -> get_page_from_freelist() -> rmqueue() ->
> rmqueue_pcplist() will spin_trylock to grab the page from percpu
> free list. If it fails (due to re-entrancy or list being empty)
> then rmqueue_bulk()/rmqueue_buddy() will attempt to
> spin_trylock zone->lock and grab the page from there.
> spin_trylock() is not safe in PREEMPT_RT when in NMI or in hard IRQ.
> Bailout early in such case.
> 
> The support for gfpflags_allow_spinning() mode for free_page and memcg
> comes in the next patches.
> 
> This is a first step towards supporting BPF requirements in SLUB
> and getting rid of bpf_mem_alloc.
> That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

