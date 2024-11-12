Return-Path: <bpf+bounces-44617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437C9C577A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 13:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663E3B47BFC
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED182141B5;
	Tue, 12 Nov 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tfh5Jh1L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+BujC0L1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tfh5Jh1L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+BujC0L1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE742141A2;
	Tue, 12 Nov 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409776; cv=none; b=V06+NJZTBdVdeJJaL3Q0/LQ2dILIEBmfKLmmlmKc3Twt1Vn0Gjj7hIrr3GppfdYpCHCN6CsTNpiCdptOZANni3NhkRdGQwFMf8yJR1605ppWpSp9YHILU4TUA/6ji4EwAw6Yh5TSlnnXL+aCAyFCBjqH3mQoGZNUg+TMXct2xIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409776; c=relaxed/simple;
	bh=uvU86PZmsTw7fLmxJyD27WBfsIY4qydtW6qXekwUqJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOwHgy9ZVSkxW/T4xIMC8st6nfRBSRATaYNo06FIy4mxvzML4XGbg73UAmaMb9hrpcXmejhEvscO6RBEYglwRqJ8Blk9Bu35NEnuY6y7NmeA3xIgCEoXmw2QzYFNmEkdUH6VdpEXS5y9rZa+NPDUJtKuBQAnGAc6WMJkxcnpgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tfh5Jh1L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+BujC0L1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tfh5Jh1L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+BujC0L1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0380C215D5;
	Tue, 12 Nov 2024 11:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731409767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7Z2UQlbAHlFmfwFU/o6qE0CBbboWdDKwMbTIfHRy04=;
	b=Tfh5Jh1LsY55iCTuS8r3sNq89ZmdVjMM3II27wyqK8j1Jw/lvsSH+nZZmNlNT3l2Afwcw5
	WSmBMjM5n+OHSeONm/aXqGq8l4YwNlov1Okc+3ZsTFPEtFOEeXOHVRxH3JbrDZvBKNCFm6
	vKyYnVLuIqWKFEYsymDMuYHE2bU9HQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731409767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7Z2UQlbAHlFmfwFU/o6qE0CBbboWdDKwMbTIfHRy04=;
	b=+BujC0L11HpxMYY8xeM5+In+jZIrRfAlIK5RMdnNY5p4M/o8MhSPk+ojXq1HPW9Y+TN9pP
	aX0qtSQDomnrfJBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731409767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7Z2UQlbAHlFmfwFU/o6qE0CBbboWdDKwMbTIfHRy04=;
	b=Tfh5Jh1LsY55iCTuS8r3sNq89ZmdVjMM3II27wyqK8j1Jw/lvsSH+nZZmNlNT3l2Afwcw5
	WSmBMjM5n+OHSeONm/aXqGq8l4YwNlov1Okc+3ZsTFPEtFOEeXOHVRxH3JbrDZvBKNCFm6
	vKyYnVLuIqWKFEYsymDMuYHE2bU9HQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731409767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z7Z2UQlbAHlFmfwFU/o6qE0CBbboWdDKwMbTIfHRy04=;
	b=+BujC0L11HpxMYY8xeM5+In+jZIrRfAlIK5RMdnNY5p4M/o8MhSPk+ojXq1HPW9Y+TN9pP
	aX0qtSQDomnrfJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72E6A13301;
	Tue, 12 Nov 2024 11:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a/OeGmY3M2eDPgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 11:09:26 +0000
Message-ID: <5f95c0d7-01a4-485d-a9d7-1a39acf9c680@suse.cz>
Date: Tue, 12 Nov 2024 12:09:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] perf lock contention: Resolve slab object name
 using BPF
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <20241108061500.2698340-4-namhyung@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241108061500.2698340-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,infradead.org,vger.kernel.org,google.com,linux.dev,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 11/8/24 07:14, Namhyung Kim wrote:
> The bpf_get_kmem_cache() kfunc can return an address of the slab cache
> (kmem_cache).  As it has the name of the slab cache from the iterator,
> we can use it to symbolize some dynamic kernel locks in a slab.
> 
> Before:
>   root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl sleep 1
>    contended   total wait     max wait     avg wait            address   symbol
> 
>            2      3.34 us      2.87 us      1.67 us   ffff9d7800ad9600    (mutex)
>            2      2.16 us      1.93 us      1.08 us   ffff9d7804b992d8    (mutex)
>            4      1.37 us       517 ns       343 ns   ffff9d78036e6e00    (mutex)
>            1      1.27 us      1.27 us      1.27 us   ffff9d7804b99378    (mutex)
>            2       845 ns       599 ns       422 ns   ffffffff9e1c3620   delayed_uprobe_lock (mutex)
>            1       845 ns       845 ns       845 ns   ffffffff9da0b280   jiffies_lock (spinlock)
>            2       377 ns       259 ns       188 ns   ffffffff9e1cf840   pcpu_alloc_mutex (mutex)
>            1       305 ns       305 ns       305 ns   ffffffff9e1b4cf8   tracepoint_srcu_srcu_usage (mutex)
>            1       295 ns       295 ns       295 ns   ffffffff9e1c0940   pack_mutex (mutex)
>            1       232 ns       232 ns       232 ns   ffff9d7804b7d8d8    (mutex)
>            1       180 ns       180 ns       180 ns   ffffffff9e1b4c28   tracepoint_srcu_srcu_usage (mutex)
>            1       165 ns       165 ns       165 ns   ffffffff9da8b3a0   text_mutex (mutex)
> 
> After:
>   root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl sleep 1
>    contended   total wait     max wait     avg wait            address   symbol
> 
>            2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   &task_struct (mutex)
>            1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   &task_struct (mutex)
>            4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   &kmalloc-cg-512 (mutex)
>            2       859 ns       617 ns       429 ns   ffffffffa41c3620   delayed_uprobe_lock (mutex)
>            3       691 ns       388 ns       230 ns   ffffffffa41c0940   pack_mutex (mutex)
>            3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0   text_mutex (mutex)
>            1       409 ns       409 ns       409 ns   ffffffffa41b4cf8   tracepoint_srcu_srcu_usage (mutex)
>            2       362 ns       239 ns       181 ns   ffffffffa41cf840   pcpu_alloc_mutex (mutex)
>            1       220 ns       220 ns       220 ns   ffff9d5e82b534d8   &signal_cache (mutex)
>            1       215 ns       215 ns       215 ns   ffffffffa41b4c28   tracepoint_srcu_srcu_usage (mutex)
> 
> Note that the name starts with '&' sign for slab objects to inform they
> are dynamic locks.  It won't give the accurate lock or type names but
> it's still useful.  We may add type info to the slab cache later to get
> the exact name of the lock in the type later.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

<snip>

> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index fd24ccb00faec0ba..b5bc37955560a58e 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -123,6 +123,8 @@ struct mm_struct___new {
>  	struct rw_semaphore mmap_lock;
>  } __attribute__((preserve_access_index));
>  
> +extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
> +
>  /* control flags */
>  const volatile int has_cpu;
>  const volatile int has_task;
> @@ -496,8 +498,23 @@ int contention_end(u64 *ctx)
>  		};
>  		int err;
>  
> -		if (aggr_mode == LOCK_AGGR_ADDR)
> -			first.flags |= check_lock_type(pelem->lock, pelem->flags);
> +		if (aggr_mode == LOCK_AGGR_ADDR) {
> +			first.flags |= check_lock_type(pelem->lock,
> +						       pelem->flags & LCB_F_TYPE_MASK);
> +
> +			/* Check if it's from a slab object */
> +			if (bpf_get_kmem_cache) {
> +				struct kmem_cache *s;
> +				struct slab_cache_data *d;
> +
> +				s = bpf_get_kmem_cache(pelem->lock);
> +				if (s != NULL) {
> +					d = bpf_map_lookup_elem(&slab_caches, &s);
> +					if (d != NULL)
> +						first.flags |= d->id;
> +				}

Is this being executed as part of obtaining a perf event record, or as part
of a postprocessing pass? I'm not familiar enough with the code to be certain.

- if it's part of perf event record, can you just store 's' and defer
resolving the cache by bpf_map_lookup_elem() to postprocessing?
- if it's postprocessing, it would be too late for bpf_get_kmem_cache() as
the object might be gone already?

The second alternative would be worse as it could miss the cache or
misattribute (in case page is reallocated by another cache), the first is
just less efficient than possible.

> +			}
> +		}
>  
>  		err = bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
>  		if (err < 0) {


