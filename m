Return-Path: <bpf+bounces-51842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA02A3A16A
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 16:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1198188D446
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668926D5C6;
	Tue, 18 Feb 2025 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M/UhEGLU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QlBU0glQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVfGLPsx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HRB/heOS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965F26D5B8
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893018; cv=none; b=XGK1OfByPmtU3qTXPAylbiLGNGlmLeH/U2BTlLOfFSNGVoT4X96+dzPl33dHHYi+Y71P+zDIVJo2VFycRzWPv5LK2E2QktiB9Lq+sne6xR5rQ+QA4y6CRnnrnyQp8pnRk6wfx9vPrzr3G1h7Ra4kvzIdIPdKGGngsWJpl/s05os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893018; c=relaxed/simple;
	bh=OZozONMRjPQROB3vJ1IHN6cd6MaS0jPbjI0mxltW1cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEPtVvmMxIPzEIy1NpNr6ffVC9r6reTyHfkacbp74spZqWTayxx8mbywvPG2qdPi1x/t8WjwYPx6h9gd7wtd4fPlz7N61lZzsLTQsnEe9k4gAc8lKGu5XhYbN6EvdstqWowrMOPgh5lELYDmm7orA0sv6M5pH8hdJkRZtuw2pTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M/UhEGLU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QlBU0glQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVfGLPsx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HRB/heOS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF2CB1F396;
	Tue, 18 Feb 2025 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739893014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7XVfHDnYTGNXta2to7TPE1bHpAn7BKEBdi3qr0AJHLE=;
	b=M/UhEGLUbhj8BamTZKZEcMbPOE3uEE72TvcLOT2/WMSvoKuTZSYg4uJ+vekwbuVqu6H1dP
	gzQ4Uq9nPidRy2nRrNxYDcxwgMmZYxnRvRDv5K2kCXoKov23w+BbFaFU8u9n6CkQDmM+p1
	W8GKoPk+GqVrPoCf/oZRpJlZsRunU8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739893014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7XVfHDnYTGNXta2to7TPE1bHpAn7BKEBdi3qr0AJHLE=;
	b=QlBU0glQjebA+IxsHC94oxfZ69kcWCoKJAobYGZc4oFkqV3K5vUJFHJ7ViIPNgcPftKqro
	sgklmayAVgm7wjDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZVfGLPsx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="HRB/heOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739893013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7XVfHDnYTGNXta2to7TPE1bHpAn7BKEBdi3qr0AJHLE=;
	b=ZVfGLPsxasKDifm5itDF6WoYRs+eLtzs4MnIpgcUjsAd0xNlO7qJpC8jMD8FPMe0OIl/9l
	RUNaYf5lmYGNaHXW1mKlCVeYU62lynV0DsNyK3PHktaCh/qGq7n2buQMQBObV9Y8/CYdQH
	M+1x/6RW6q8HU4HEc66+bmNg2rOsV6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739893013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7XVfHDnYTGNXta2to7TPE1bHpAn7BKEBdi3qr0AJHLE=;
	b=HRB/heOSozxChrHgcKfQsABAuFVvQCKeEKrgT9GljFxrpW5SQhNCuM11UvkeDOyPGU/gEK
	UZijYq9MCNU3a+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B29BF13A1D;
	Tue, 18 Feb 2025 15:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TNe9KhWptGfreQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 18 Feb 2025 15:36:53 +0000
Message-ID: <fb983185-a577-405e-8fb4-b506d894cec5@suse.cz>
Date: Tue, 18 Feb 2025 16:36:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 6/6] bpf: Use try_alloc_pages() to allocate
 pages for bpf needs.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
 <20250213033556.9534-7-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250213033556.9534-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF2CB1F396
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/13/25 04:35, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Use try_alloc_pages() and free_pages_nolock() for BPF needs
> when context doesn't allow using normal alloc_pages.
> This is a prerequisite for further work.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf.h  |  2 +-
>  kernel/bpf/arena.c   |  5 ++---
>  kernel/bpf/syscall.c | 23 ++++++++++++++++++++---
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f3f50e29d639..e1838a341817 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2348,7 +2348,7 @@ int  generic_map_delete_batch(struct bpf_map *map,
>  struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
>  struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
>  
> -int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
> +int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  			unsigned long nr_pages, struct page **page_array);
>  #ifdef CONFIG_MEMCG
>  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 0975d7f22544..8ecc62e6b1a2 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -287,7 +287,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  		return VM_FAULT_SIGSEGV;
>  
>  	/* Account into memcg of the process that created bpf_arena */
> -	ret = bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE, 1, &page);
> +	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
>  		return VM_FAULT_SIGSEGV;
> @@ -465,8 +465,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	if (ret)
>  		goto out_free_pages;
>  
> -	ret = bpf_map_alloc_pages(&arena->map, GFP_KERNEL | __GFP_ZERO,
> -				  node_id, page_cnt, pages);
> +	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
>  	if (ret)
>  		goto out;
>  
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..a7af8d0185d0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -569,7 +569,24 @@ static void bpf_map_release_memcg(struct bpf_map *map)
>  }
>  #endif
>  
> -int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
> +static bool can_alloc_pages(void)
> +{
> +	return preempt_count() == 0 && !irqs_disabled() &&
> +		!IS_ENABLED(CONFIG_PREEMPT_RT);
> +}
> +

I see this is new since v6 and wasn't yet discussed (or I missed it?)

I wonder how reliable these preempt/irq_disabled checks are for correctness
purposes, e.g. we don't have CONFIG_PREEMPT_COUNT enabled always? As longs
as the callers of bpf_map_alloc_pages() know the context and pass gfp
accordingly, can't we use i.e. gfpflags_allow_blocking() to determine if
try_alloc_pages() should be used or not?

> +static struct page *__bpf_alloc_page(int nid)
> +{
> +	if (!can_alloc_pages())
> +		return try_alloc_pages(nid, 0);
> +
> +	return alloc_pages_node(nid,
> +				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
> +				| __GFP_NOWARN,
> +				0);
> +}
> +
> +int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
>  			unsigned long nr_pages, struct page **pages)
>  {
>  	unsigned long i, j;
> @@ -582,14 +599,14 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
>  	old_memcg = set_active_memcg(memcg);
>  #endif
>  	for (i = 0; i < nr_pages; i++) {
> -		pg = alloc_pages_node(nid, gfp | __GFP_ACCOUNT, 0);
> +		pg = __bpf_alloc_page(nid);
>  
>  		if (pg) {
>  			pages[i] = pg;
>  			continue;
>  		}
>  		for (j = 0; j < i; j++)
> -			__free_page(pages[j]);
> +			free_pages_nolock(pages[j], 0);
>  		ret = -ENOMEM;
>  		break;
>  	}


