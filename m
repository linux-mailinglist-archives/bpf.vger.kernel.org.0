Return-Path: <bpf+bounces-52430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29832A42E50
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 21:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2ED1897723
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACD25A347;
	Mon, 24 Feb 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJ/xwPJe"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1683B2A0
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430381; cv=none; b=AAjDbrS5l4xNy+tkVYTKGn2RLDc9IU0jsVpYANK38idgvKInbpYkHW2sqxI4IfEiLYh9EReTh7rmmSUSWiEWDnrVXsE1jTnJ1V7mY8aLvVSOCClLfwvRv90zOx2TY4NGBSdafBd6fBdkdjwqjDgQNlN9m2YYyVwMcU5f4vpsCkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430381; c=relaxed/simple;
	bh=ISY5TErpMbBWybP6vz/g0eLIWMJosjFxnWWmQkQe6WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3XKa5K0m6zid4l7NRqSBvoe5dyGP14qcUq4hhlBmCjvpmxg3PcdNmO7gr516pPowrN9JJ1Wg48hbJAEhZB9j4OBV0TsNhE1tiDYdKfzjH6G76WAH+J7CN1az5CV7Vo2dL14OI4noILHnAOtSHgDe5u2Khnx6kdfxnRe8420P/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJ/xwPJe; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 12:52:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740430377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxMpDa0xMnH1ZIMUjjLgz553O/WGtdR5AKi8JCJQOAI=;
	b=GJ/xwPJelPfSC8eMwZ4zP4uLV5EZKY9maAjtWDIju3E4ZgxCkkfhgwnM/X8n/F0F73DOBY
	HUSo4gttew5+DYUQ2sGM1SMLCtGfv6UFLQ2uVU3Sys/Yf8KFB6WRW9tz1IOkzAaagTaFnn
	Ud1R1Q9olhOGRFjFsONi4tBtjoYH3Ho=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	bpf <bpf@vger.kernel.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching
 layer
Message-ID: <tjujhf3jewd2d5gn7myyscbnfr7oie53ff6ibmy3ockxyf5zb4@pbabk5h2slpq>
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
 <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>
 <704ba4a7-37ec-4c6b-9de4-0c662e5c5ce1@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <704ba4a7-37ec-4c6b-9de4-0c662e5c5ce1@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 07:15:16PM +0100, Vlastimil Babka wrote:
> On 2/24/25 19:02, Shakeel Butt wrote:
> > On Mon, Feb 24, 2025 at 05:13:25PM +0100, Vlastimil Babka wrote:
> >> Hi,
> >> 
> >> I'd like to propose a session about the SLUB allocator.
> >> 
> >> Mainly I would like to discuss the addition of the sheaves caching layer,
> >> the latest RFC posted at [1].
> >> 
> >> The goals of that work is to:
> >> 
> >> - Reduce fastpath overhead. The current freeing fastpath only can be used if
> >> the same target slab is still the cpu slab, which can be only expected for a
> >> very short term allocations. Further improvements should come from the new
> >> local_trylock_t primitive.
> >> 
> >> - Improve efficiency of users such as like maple tree, thanks to more
> >> efficient preallocations, and kfree_rcu batching/reusal
> >> 
> >> - Hopefully also facilitate further changes needed for bpf allocations, also
> >> via local_trylock_t, that could possibly extend to the other parts of the
> >> implementation as needed.
> >> 
> >> The controversial discussion points I expect about this approach are:
> >> 
> >> - Either sheaves will not support NUMA restrictions (as in current RFC), or
> >> bring back the alien cache flushing issues of SLAB (or there's a better idea?)
> >> 
> >> - Will it be possible to eventually have sheaves enabled for every cache and
> >> replace the current slub's fastpaths with it? Arguably these are also not
> >> very efficient when NUMA-restricted allocations are requested for varying
> >> NUMA nodes (cpu slab is flushed if it's from a wrong node, to load a slab
> >> from the requested node).
> >> 
> >> Besides sheaves, I'd like to summarize recent kfree_rcu() changes and we
> >> could discuss further improvements to that.
> >> 
> >> Also we can discuss what's needed to support bpf allocations. I've talked
> >> about it last year, but then focused on other things, so Alexei has been
> >> driving that recently (so far in the page allocator).
> > 
> > What about pre-memcg-charged sheaves? We had to disable memcg charging
> > of some kernel allocations
> 
> You mean due to bad performance? Which ones for example? Was the overhead
> due to accounting of how much is charged, or due to the associating memcgs
> with objects?
> 

I know of the following two cases but we do hear frequently that kmemcg
accounting is not cheap.

3754707bcc3e ("Revert "memcg: enable accounting for file lock caches"")
0bcfe68b8767 ("Revert "memcg: enable accounting for pollfd and select
bits arrays"")

> > and I think sheaves can help in reenabling
> > it.
> 
> You mean by mean having separate sheaves per memcg? Wouldn't that mean
> risking that too many objects could be cached in them, we'd have to flush
> eventually e.g. the least recently used ones, etc? Or do you mean some other
> scheme?
> 

As you pointed out a simple scheme of separate sheaves per memcg might
not work. Maybe targeting specific kmem caches or allocation sites would
be a first step. I will need to think more on this.

