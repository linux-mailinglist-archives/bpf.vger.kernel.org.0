Return-Path: <bpf+bounces-68489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03BB59352
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 12:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80C77ACD49
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 10:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07BE2F7AB7;
	Tue, 16 Sep 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHhmcomd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2IEMIuj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHhmcomd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2IEMIuj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69327A92E
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018089; cv=none; b=p8J0MaUWbRCnLHr4qEaavMRrGqQT/9dXisTJd1iGi/FHSQ3TO8WTWHr6/RzpeVe3qCt3X18/2mLmdYX/PFE6iq5vNSQXH89NZqeT2qE081yjnUZhDD34tqwvRkCohl6ZF1s/HzkglV5TCpJSRWugxPagQpX9RHH1aiY5TcjKU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018089; c=relaxed/simple;
	bh=XlLPwRBun/nBjS8fZQsZVOi+H3Upg+IMpQpkviXVoNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm6IxZrjt7j0vZ650WrmbFB6blpisgHF61dE+hiIymPNeoiNmNS++Ck+rwAGSkS2pEicredDYWAqG4F1xNxLpcZgMBQGJzFM4K44GuLZYhyjBcy138eoEGD+0LzTn8pksRsxz9LUqXrANXL7g80DMfUkGA+NstY/O7oYRkGaimc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHhmcomd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2IEMIuj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHhmcomd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2IEMIuj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E2851F805;
	Tue, 16 Sep 2025 10:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758018085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x60UAmmdtyxUGPNMyl1h14VzGLr5bgbrZHtvveeVkQY=;
	b=uHhmcomdT48oChR7TsvJuX9515nG5TF2KzkCfT5Ym6OnFncF5XdDc1p12RKBPp/EQYxegd
	TrUMAyiz+J1AOLeRrRBJZWhkVLcSJ+tXPXN4/twp5pQzQJb63Dw0IXRYkZ9O1dck60TUvn
	SRVrKZbYiSB7AsWjbp2ZoVPoks0sLN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758018085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x60UAmmdtyxUGPNMyl1h14VzGLr5bgbrZHtvveeVkQY=;
	b=T2IEMIujbvQGmfC6QOhfQ6BZC4SVfH32JahhIjyi2F2dSnV91a8TXhBhgFQnR0zux+ASAx
	GZB/XmuaqZTzSADQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758018085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x60UAmmdtyxUGPNMyl1h14VzGLr5bgbrZHtvveeVkQY=;
	b=uHhmcomdT48oChR7TsvJuX9515nG5TF2KzkCfT5Ym6OnFncF5XdDc1p12RKBPp/EQYxegd
	TrUMAyiz+J1AOLeRrRBJZWhkVLcSJ+tXPXN4/twp5pQzQJb63Dw0IXRYkZ9O1dck60TUvn
	SRVrKZbYiSB7AsWjbp2ZoVPoks0sLN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758018085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x60UAmmdtyxUGPNMyl1h14VzGLr5bgbrZHtvveeVkQY=;
	b=T2IEMIujbvQGmfC6QOhfQ6BZC4SVfH32JahhIjyi2F2dSnV91a8TXhBhgFQnR0zux+ASAx
	GZB/XmuaqZTzSADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7677713A63;
	Tue, 16 Sep 2025 10:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4DiWHCU6yWhDTAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 16 Sep 2025 10:21:25 +0000
Message-ID: <ef34e217-580d-4d91-9bfb-4db1699e249a@suse.cz>
Date: Tue, 16 Sep 2025 12:21:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab] slab: Clarify comments regarding pfmemalloc and NUMA
 preferences
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org
References: <20250916014609.47273-1-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <20250916014609.47273-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 9/16/25 03:46, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Clarify comments regarding pfmemalloc and NUMA preferences
> when ___slab_alloc() operating in !allow_spin mode.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Folding that into "slab: Introduce kmalloc_nolock() and kfree_nolock()." in
slab/for-next, thanks.

> ---
>  mm/slub.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 83983de948f3..c995f3bec69d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4456,9 +4456,17 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		/*
>  		 * same as above but node_match() being false already
>  		 * implies node != NUMA_NO_NODE.
> -		 * Reentrant slub cannot take locks necessary to
> -		 * deactivate_slab, hence ignore node preference.
> -		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
> +		 *
> +		 * We don't strictly honor pfmemalloc and NUMA preferences
> +		 * when !allow_spin because:
> +		 *
> +		 * 1. Most kmalloc() users allocate objects on the local node,
> +		 *    so kmalloc_nolock() tries not to interfere with them by
> +		 *    deactivating the cpu slab.
> +		 *
> +		 * 2. Deactivating due to NUMA or pfmemalloc mismatch may cause
> +		 *    unnecessary slab allocations even when n->partial list
> +		 *    is not empty.
>  		 */
>  		if (!node_isset(node, slab_nodes) ||
>  		    !allow_spin) {
> @@ -4547,11 +4555,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		slab = slub_percpu_partial(c);
>  		slub_set_percpu_partial(c, slab);
>  
> -		/*
> -		 * Reentrant slub cannot take locks necessary for
> -		 * __put_partials(), hence ignore node preference.
> -		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
> -		 */
>  		if (likely(node_match(slab, node) &&
>  			   pfmemalloc_match(slab, gfpflags)) ||
>  		    !allow_spin) {


