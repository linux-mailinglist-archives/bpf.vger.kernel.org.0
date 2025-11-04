Return-Path: <bpf+bounces-73508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AB0C33223
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372D83B9C21
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124BD2D23A3;
	Tue,  4 Nov 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="HL8+OWMk"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402E2BE7B2;
	Tue,  4 Nov 2025 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294286; cv=none; b=F7auticTsl88G0inMkOSLSD5maUtcMcBKUukSfvqB/Q+VQ3efsMCNJkcLRl5qE0rrhzn0RhMxp89M3lePB1PbClyS1fJHozUSSN97qdY7oQXWiq0Fj3DXCynqqA2HUvNW678cWVPtDScC0qZyiv4NsoW4aKTjAkIIR8muxLUQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294286; c=relaxed/simple;
	bh=/BlojT3ZNpb08cgBE5OnkdRei3sKYEo3Zbg5wHQuBX4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rxcnPr0jkBb0ImtWFYNoKnvyfe68O1SVBRs+iGDTIxwtTgLhK/M9q147Qvv/9HNZYmkLZq4w7uPlYPEwZigGHIqtQEOynKIbvWtmPToWOhevhrxH7hfQYXWjCUumCs37Vjz/ErncWWOA4Zh8ehdy0L6QbnKdn38TYuQvAsvHZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=HL8+OWMk; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1762294278;
	bh=/BlojT3ZNpb08cgBE5OnkdRei3sKYEo3Zbg5wHQuBX4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HL8+OWMki6jvFLVTzvijjMKsacdQgaB8EP0E9FXTOv8VtzXVmj8iaskuVHjHDwXU1
	 F/X3reeJs0CiPIfv+15OHdZv0PNQvrryiBq7UlG6XL57DZ/v217i5hup1kftWnIjMm
	 7cJ4cOMPCI62TYmS62eD8VNQgOa6x7knQBKSkdAc=
Received: by gentwo.org (Postfix, from userid 1003)
	id 822DC4015D; Tue, 04 Nov 2025 14:11:18 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7E34A4014B;
	Tue, 04 Nov 2025 14:11:18 -0800 (PST)
Date: Tue, 4 Nov 2025 14:11:18 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    David Rientjes <rientjes@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
    bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
    Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
    Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH RFC 00/19] slab: replace cpu (partial) slabs with
 sheaves
In-Reply-To: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
Message-ID: <f7c33974-e520-387e-9e2f-1e523bfe1545@gentwo.org>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Oct 2025, Vlastimil Babka wrote:

> Besides (hopefully) improved performance, this removes the rather
> complicated code related to the lockless fastpaths (using
> this_cpu_try_cmpxchg128/64) and its complications with PREEMPT_RT or
> kmalloc_nolock().

Going back to a strict LIFO scheme for alloc/free removes the following
performance features:

1. Objects are served randomly from a variety of slab pages instead of
serving all available objects from a single slab page and then from the
next. This means that the objects require a larger set of TLB entries to
cover. TLB pressure will increase.

2. The number of partial slabs will increase since the free objects in a
partial page are not used up before moving onto the next. Instead free
objects from random slab pages are used.

Spatial object locality is reduced. Temporal object hotness increases.

> The lockless slab freelist+counters update operation using
> try_cmpxchg128/64 remains and is crucial for freeing remote NUMA objects
> without repeating the "alien" array flushing of SLUB, and to allow
> flushing objects from sheaves to slabs mostly without the node
> list_lock.

Hmm... So potential cache hot objects are lost that way and reused on
another node next. The role of the alien caches in SLAB was to cover that
case and we saw performance regressions without these caches.

The method of freeing still reduces the amount of remote partial slabs
that have to be managed and increases the locality of the objects.

