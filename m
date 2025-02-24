Return-Path: <bpf+bounces-52437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E042A42EBB
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9766317ABE3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468B198822;
	Mon, 24 Feb 2025 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gg8HKjQ8"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D8154C1D
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431535; cv=none; b=b273hneaow8bDO0EXqrSsnA0nM5fUo3U25ahLWjKUYqoVSft43yEkWWL/88liJPVgWfpZvABIztGcJexsrDhdLPuZu3l3OBwlnrGZDwk4y3mUTFvkB/nAvKu3OlMSo3KrmbBA0JZdIVdEySZ5AAfGJ8tox52NQE2pfaAdd8RIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431535; c=relaxed/simple;
	bh=XrC5FY2BIb4fvHLfwJnLYYKgmtxKgk49PCsu38AA0eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geQyi03saeMOScCUDGxeu9ewI/4JAaq9LGM2mPNKUFnARz6oniyIzlXXnSQ+bnJquW46BDH+VZq05V2oFEsbNGb3pw+yLoU48DRvErWAv+qSrfnXmC+NQE4z78beVvMn8kIubReL5GTdvnAAQ8I2ThS1DT+n84BjQ5RHlMMXU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gg8HKjQ8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 13:12:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740431531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YiAYqnScgnVRUYWYH85PXsYdGcZ7vXE3qYfG5M99a1I=;
	b=gg8HKjQ8NQhLfgWAghKC05rgJaPjwqxBVY0+SdqPy2N7ZOoy1x0CPxmIixmb+Dkv9rkkOI
	Id5zUsqb0hOjn/rX7wVaKeONxUunSnVPk+TyosGNFgc7li8dVtAWMw35kMCrSIgU0icE3T
	i0GDcn2vsWjPUfusJfvs4zlDjSwx5Lc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, bpf <bpf@vger.kernel.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching
 layer
Message-ID: <7wjnfy7cvmxzcmh4rs5xqi7qmurj365wa4kf252u7bnjgo4bqb@x42ceby4d27p>
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
 <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>
 <svy4dxxdgbt4mnapfrqod7c2imufgb4daao7id3j5p7tgeok4j@jtknbmybpqsg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <svy4dxxdgbt4mnapfrqod7c2imufgb4daao7id3j5p7tgeok4j@jtknbmybpqsg>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 07:46:52PM +0100, Mateusz Guzik wrote:
> On Mon, Feb 24, 2025 at 10:02:09AM -0800, Shakeel Butt wrote:
> > What about pre-memcg-charged sheaves? We had to disable memcg charging
> > of some kernel allocations and I think sheaves can help in reenabling
> > it.
> 
> It has been several months since last I looked at memcg, so details are
> fuzzy and I don't have time to refresh everything.
> 
> However, if memory serves right the primary problem was the irq on/off
> trip associated with them (sometimes happening twice, second time with
> refill_obj_stock()).
> 
> I think the real fix(tm) would recognize only some allocations need
> interrupt safety -- as in some slabs should not be allowed to be used
> outside of the process context. This is somewhat what sheaves is doing,
> but can be applied without fronting the current kmem caching mechanism.
> This may be a tough sell and even then it plays whackamole with patching
> up all consumers.
> 
> Suppose it is not an option.
> 
> Then there are 2 ways that I considered.
> 
> The easiest splits memcg accounting for irq and process level -- similar
> to what localtry thing is doing. this would only cost preemption off/on
> trip in the common case and a branch on the current state. But suppose
> this is a no-go as well.

Have you seen 559271146efc ("mm/memcg: optimize user context object
stock access"). It got reverted for RT (or something). Maybe we can look
at it again.

> 
> My primary idea was using hand-rolled sequence counters and local 8-byte
> cmpxchg (*without* the lock prefix, also not to be confused with 16-byte
> used by the current slub fast path). Should this work, it would be
> significantly faster than irq trips. 
> 
> The irq thing is there only to facilitate several fields being updated
> or memcg itself getting replaced in an atomic manner for process vs
> interrupt context.
> 
> The observation is that all values which are getting updated are 4
> bytes. Then perhaps an additional counter can be added next to each one
> so that an 8-byte cmpxchg is going to fail should an irq swoop in and
> change stuff from under us.
> 
> The percpu state would have a sequence counter associated with the
> assigned memcg_stock_pcp. The memcg_stock_pcp object would have the same
> value replicated inside for every var which can be updated in the fast
> path.
> 
> Then the fast path would only succeed if the value read off from per-cpu
> did not change vs what's in the stock thing.
> 
> Any change to memcg_stock_pcp (e.g., rolling up bytes after passing the
> page size threshold) would disable interrupts and modify all these
> counters.
> 
> There is some more work needed to make sure the stock obj can be safely
> swapped out for a new one and not accidentally have a value which lines
> up with the prevoius one, I don't remember what I had for that (and yes,
> I recognize a 4 byte value will invariably roll over and *in principle*
> a conflict will be possible).
> 
> This is a rough outline since Vlasta keeps prodding me about it.

By chance do you have this code lying around somewhere? Not saying this
is the way to go but wanted to take a look.

> 
> That said, maybe someone will have a better idea. The above is up for
> grabs if someone wants to do it, I can't commit to looking at it.

