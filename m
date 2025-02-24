Return-Path: <bpf+bounces-52401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96FA42A89
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66731896E53
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6F263F48;
	Mon, 24 Feb 2025 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fREhkmz8"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7C7BAEC
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420145; cv=none; b=Yp8oo3kx3iKSxGbwcWum/KF1dhDcygxVEQi1vzAB/hePfDx9kqhPvHGS0Tc7qsy4W5eZ3m8nVZ1ZnXRfD3n67tUSWKsi4SCSmHoMpwtXxVewu27zjddUpFXLcCM6Hon6WmjafbIXlfjBSQNzGOqtCqT0UslWQGfON/fI0L1jIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420145; c=relaxed/simple;
	bh=4lUOTIUqwRcFGbYd9XdbPtE0t9z9ACKvI5SOsaeAbJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADdlvrphzjAYo3T5jy+9yCaGWjb/j9lYyl5e0B0skCN+v7DOmsopWlnPWYofVD2C6RUK15uVYDaHTnUGrgmbdnYf02iWEyof5x0tGe2715gmUaS9GuqQBegSptv0eN612J+BI8yaH5jTDWmLi+cEA30Vs6Pz5wnQMbO3i9eyOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fREhkmz8; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 24 Feb 2025 10:02:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740420136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pUi0j0NH+2Nm8G2EyjCJc5I0bdo9iNSE1fivswXWbI=;
	b=fREhkmz8N7UuFk2SdutLbx1ycQZ4cG5VsR3I/Hd2Cvb2GFpvGaN1apfZez+2/G6QNmP/41
	M3cVSBBu0cynKsmbaXw/sJXNy9dsrPChQrMBR8bUUt8+7Fff+chF9eqKKqUwEozCM3Zd7j
	yl40olKVf+zuW0c365UkhHnmkdj7sos=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	bpf <bpf@vger.kernel.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] SLUB allocator, mainly the sheaves caching
 layer
Message-ID: <e2fz26kcbni37rp2rdqvac7mljvrglvtzmkivfpsnibubu3g3t@blz27xo4honn>
References: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14422cf1-4a63-4115-87cb-92685e7dd91b@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 05:13:25PM +0100, Vlastimil Babka wrote:
> Hi,
> 
> I'd like to propose a session about the SLUB allocator.
> 
> Mainly I would like to discuss the addition of the sheaves caching layer,
> the latest RFC posted at [1].
> 
> The goals of that work is to:
> 
> - Reduce fastpath overhead. The current freeing fastpath only can be used if
> the same target slab is still the cpu slab, which can be only expected for a
> very short term allocations. Further improvements should come from the new
> local_trylock_t primitive.
> 
> - Improve efficiency of users such as like maple tree, thanks to more
> efficient preallocations, and kfree_rcu batching/reusal
> 
> - Hopefully also facilitate further changes needed for bpf allocations, also
> via local_trylock_t, that could possibly extend to the other parts of the
> implementation as needed.
> 
> The controversial discussion points I expect about this approach are:
> 
> - Either sheaves will not support NUMA restrictions (as in current RFC), or
> bring back the alien cache flushing issues of SLAB (or there's a better idea?)
> 
> - Will it be possible to eventually have sheaves enabled for every cache and
> replace the current slub's fastpaths with it? Arguably these are also not
> very efficient when NUMA-restricted allocations are requested for varying
> NUMA nodes (cpu slab is flushed if it's from a wrong node, to load a slab
> from the requested node).
> 
> Besides sheaves, I'd like to summarize recent kfree_rcu() changes and we
> could discuss further improvements to that.
> 
> Also we can discuss what's needed to support bpf allocations. I've talked
> about it last year, but then focused on other things, so Alexei has been
> driving that recently (so far in the page allocator).

What about pre-memcg-charged sheaves? We had to disable memcg charging
of some kernel allocations and I think sheaves can help in reenabling
it.


