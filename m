Return-Path: <bpf+bounces-79441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626AD3A325
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EA97301E23C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C2350D43;
	Mon, 19 Jan 2026 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YV3pO5JV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKszw5nA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YV3pO5JV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKszw5nA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD22D592C
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768815251; cv=none; b=AQe2vJHWp3Ot4YfoSrP9APajG52LGmXFDC+AI0V3V90id/gW0uyt0nssnIDJq6LgWweI/VlQTapM8xGFXSrPgHP9CulobeBnJ74QxiXnJ8t7duWxThhiRwsFcLReulN0h5u6c12fnXsR+GFtuDeOI8e45GrQa3gNzQ2HKl8cYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768815251; c=relaxed/simple;
	bh=zy0m8KyGGXtRgZboVqpo1cve5LZBEcm71zJBkfjVIzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYA9hnNG4ScjB/LgdQi4NcqheUwbgxpkwwVSkNfrmsBcxxLsaSblX53TOfZr2L74efzN9CdHwjkFb1sP/9Gw/ak9b3iYhjNz8BR3cXakZEqUMJRx9UMg0xkvoSJFJX56OoaN7oL51XSXtI4l+hpPR+6Ht3Nr+H4XmKnJ5/F3bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YV3pO5JV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKszw5nA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YV3pO5JV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKszw5nA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CA145BD44;
	Mon, 19 Jan 2026 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768815248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikLK1Mgji5k5g6jyOPReFRltrTEuDlSX80eK5Jr1uK4=;
	b=YV3pO5JVs8tDCn2O+3X6BUTQW3U0ouPlo7goLSDSkyDXIP4iSVccogJ4/KzR4YGddJJXMu
	9q4auK2Z/0Ose/Y9XPpcwV2AqXI1lOixpZY6hNHwgEdpXqjZahn8psPFZK0Epmi0MPw6zS
	HuWkje/2RsjmVKFhfVnM4arp1Cyelbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768815248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikLK1Mgji5k5g6jyOPReFRltrTEuDlSX80eK5Jr1uK4=;
	b=wKszw5nAQu/uhKci0sbkUFQPyyKLfp1ADEz2oKYEn6PsIFmUJcOltygGTf36ztv3TIRxWR
	3b5QzNODRwBSevBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YV3pO5JV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wKszw5nA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768815248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikLK1Mgji5k5g6jyOPReFRltrTEuDlSX80eK5Jr1uK4=;
	b=YV3pO5JVs8tDCn2O+3X6BUTQW3U0ouPlo7goLSDSkyDXIP4iSVccogJ4/KzR4YGddJJXMu
	9q4auK2Z/0Ose/Y9XPpcwV2AqXI1lOixpZY6hNHwgEdpXqjZahn8psPFZK0Epmi0MPw6zS
	HuWkje/2RsjmVKFhfVnM4arp1Cyelbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768815248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikLK1Mgji5k5g6jyOPReFRltrTEuDlSX80eK5Jr1uK4=;
	b=wKszw5nAQu/uhKci0sbkUFQPyyKLfp1ADEz2oKYEn6PsIFmUJcOltygGTf36ztv3TIRxWR
	3b5QzNODRwBSevBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EFFC3EA63;
	Mon, 19 Jan 2026 09:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QpVoBpD6bWn1WAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Jan 2026 09:34:08 +0000
Message-ID: <4f60e230-c76e-4ab3-a0f0-7598dcb15d1a@suse.cz>
Date: Mon, 19 Jan 2026 10:34:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/21] slab: introduce percpu sheaves bootstrap
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-6-5595cb000772@suse.cz>
 <CAJuCfpERcCzBysPVh63g7d0FpUBNQeq9nCL+ycem1iR08gDmaQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpERcCzBysPVh63g7d0FpUBNQeq9nCL+ycem1iR08gDmaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4CA145BD44
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/17/26 03:11, Suren Baghdasaryan wrote:
> On Fri, Jan 16, 2026 at 2:40 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> Thus sharing the single bootstrap sheaf like this for multiple caches
>> and cpus is safe.
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 119 ++++++++++++++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 81 insertions(+), 38 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index edf341c87e20..706cb6398f05 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -501,6 +501,18 @@ struct kmem_cache_node {
>>         struct node_barn *barn;
>>  };
>>
>> +/*
>> + * Every cache has !NULL s->cpu_sheaves but they may point to the
>> + * bootstrap_sheaf temporarily during init, or permanently for the boot caches
>> + * and caches with debugging enabled, or all caches with CONFIG_SLUB_TINY. This
>> + * helper distinguishes whether cache has real non-bootstrap sheaves.
>> + */
>> +static inline bool cache_has_sheaves(struct kmem_cache *s)
>> +{
>> +       /* Test CONFIG_SLUB_TINY for code elimination purposes */
>> +       return !IS_ENABLED(CONFIG_SLUB_TINY) && s->sheaf_capacity;
>> +}
>> +
>>  static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>>  {
>>         return s->node[node];
>> @@ -2855,6 +2867,10 @@ static void pcs_destroy(struct kmem_cache *s)
>>                 if (!pcs->main)
>>                         continue;
>>
>> +               /* bootstrap or debug caches, it's the bootstrap_sheaf */
>> +               if (!pcs->main->cache)
>> +                       continue;
> 
> I wonder why we can't simply check cache_has_sheaves(s) at the
> beginning and skip the loop altogether.
> I realize that __kmem_cache_release()->pcs_destroy() is called in the
> failure path of do_kmem_cache_create() and s->cpu_sheaves might be
> partially initialized if alloc_empty_sheaf() fails somewhere in the
> middle of the loop inside init_percpu_sheaves(). But for that,
> s->sheaf_capacity should still be non-zero, so checking
> cache_has_sheaves() at the beginning of pcs_destroy() should still
> work, no?

I think it should, will do.

> BTW, I see one last check for s->cpu_sheaves that you didn't replace
> with cache_has_sheaves() inside __kmem_cache_release(). I think that's
> because it's also in the failure path of do_kmem_cache_create() and
> it's possible that s->sheaf_capacity > 0 while s->cpu_sheaves == NULL
> (if alloc_percpu(struct slub_percpu_sheaves) fails). It might be
> helpful to add a comment inside __kmem_cache_release() to explain why
> cache_has_sheaves() can't be used there.

The reason is rather what Harry said. I'll move the check to pcs_destroy()
and add comment there.

diff --git a/mm/slub.c b/mm/slub.c
index 706cb6398f05..6b19aa518a1a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2858,19 +2858,26 @@ static void pcs_destroy(struct kmem_cache *s)
 {
 	int cpu;
 
+	/*
+	 * We may be unwinding cache creation that failed before or during the
+	 * allocation of this.
+	 */
+	if (!s->cpu_sheaves)
+		return;
+
+	/* pcs->main can only point to the bootstrap sheaf, nothing to free */
+	if (!cache_has_sheaves(s))
+		goto free_pcs;
+
 	for_each_possible_cpu(cpu) {
 		struct slub_percpu_sheaves *pcs;
 
 		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-		/* can happen when unwinding failed create */
+		/* This can happen when unwinding failed cache creation. */
 		if (!pcs->main)
 			continue;
 
-		/* bootstrap or debug caches, it's the bootstrap_sheaf */
-		if (!pcs->main->cache)
-			continue;
-
 		/*
 		 * We have already passed __kmem_cache_shutdown() so everything
 		 * was flushed and there should be no objects allocated from
@@ -2889,6 +2896,7 @@ static void pcs_destroy(struct kmem_cache *s)
 		}
 	}
 
+free_pcs:
 	free_percpu(s->cpu_sheaves);
 	s->cpu_sheaves = NULL;
 }
@@ -5379,6 +5387,9 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 	struct slab_sheaf *sheaf = NULL;
 	struct node_barn *barn;
 
+	if (unlikely(!size))
+		return NULL;
+
 	if (unlikely(size > s->sheaf_capacity)) {
 
 		sheaf = kzalloc(struct_size(sheaf, objects, size), gfp);
@@ -7833,8 +7844,7 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 void __kmem_cache_release(struct kmem_cache *s)
 {
 	cache_random_seq_destroy(s);
-	if (s->cpu_sheaves)
-		pcs_destroy(s);
+	pcs_destroy(s);
 #ifdef CONFIG_PREEMPT_RT
 	if (s->cpu_slab)
 		lockdep_unregister_key(&s->lock_key);


