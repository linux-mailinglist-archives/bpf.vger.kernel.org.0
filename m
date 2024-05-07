Return-Path: <bpf+bounces-28833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8878BE4F0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 15:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84A11F21AFE
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633DC15ECF1;
	Tue,  7 May 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xfGM7AWT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ss+M+pRo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kM7ddcqE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pWJA8U/t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA215E816;
	Tue,  7 May 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090136; cv=none; b=T/+B+dYJfq6B/RnEZTd1gmbD+7pBGW6ifhS3NExmjr85IVu3ImOtIWXqi8b8BAWRV48o8AH34TKvLVXne8QEMhKE6ZD3VGW0K+Tecx41TUq0CwSB2a1yl7IUMTxGH9gwctxgFbjUHbrFHrqeP6I8s5k9KzvPwps+83y6j2LgFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090136; c=relaxed/simple;
	bh=rtP40c4gsi/v/C47Z0AIYr1cqXmVXqCKXrh9hJ9l0F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6G/zFn+Pro5ZL4VesnB/SWaJHJ6ZCqAgSsZOOyWZH6TUZv2tDiW2MMAtDwpKsD9hKuxx2T4vpZ4P3/OaBOPJE/xwsXKBTP64WUOj0qpAwGuhQAn/eMIRtQuonIJPAEq10t2bPu+/YXkpU0MHkFam6W+QRM98WmfIRH4q85VrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xfGM7AWT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ss+M+pRo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kM7ddcqE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pWJA8U/t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9E5720AE1;
	Tue,  7 May 2024 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715090133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kisJu+ayWULyIY3ote/9ApIfabGyrFRB2ZIL5nsy1L8=;
	b=xfGM7AWTssIrfUkgzEKYPUbFI7tAZWkTB8bxQ1/Hi9kbP0LMvKvuEN3EWWoYoNgU0Z48Ad
	K117uQ7O1wkvmMDXeR8rVPPcqbAb9fFdwZC3HG1u/rxmzX4NocT7wDiAFkrccHAZGO5jMX
	qzHMRbvBAL6+UjrrqtuONSsOwaTlJL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715090133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kisJu+ayWULyIY3ote/9ApIfabGyrFRB2ZIL5nsy1L8=;
	b=Ss+M+pRoK2m5vgHFu6kByPE4GaGndngCSHHAMLo56BOIeQ4Sz18AZFLLkaWDdFGLHkhgBj
	BmwH3T5snmuXqECg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kM7ddcqE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="pWJA8U/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715090130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kisJu+ayWULyIY3ote/9ApIfabGyrFRB2ZIL5nsy1L8=;
	b=kM7ddcqEsJB9crRdxmNBuMoauvRguNZXE5GCt0K1XLR+hO8AVZNah7i1hFGirQwltg5H8Y
	RpDnyS/NHshyCjkpiL1kIEgzzOMzDgTnkJGPVMuMg97+7cjmQbUJfOT1I2CqB8SJZfXZNN
	VYZbf2B8n75qaDxhgd+eqpi1iPPmg2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715090130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kisJu+ayWULyIY3ote/9ApIfabGyrFRB2ZIL5nsy1L8=;
	b=pWJA8U/tbTqwJXPN93nm7OYMWoVduQ7bGd2El1C6khv0ML+3jbEM49kl/7pYACEg3s+i0N
	rwBp7ghcfJ0XsNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B3B013A2D;
	Tue,  7 May 2024 13:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e+SSJdIyOmbBMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 07 May 2024 13:55:30 +0000
Message-ID: <0e8b7482-478e-4efc-ad5f-76d60cf02bfd@suse.cz>
Date: Tue, 7 May 2024 15:55:30 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] objpool: enable inlining objpool_push() and
 objpool_pop() operations
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org
Cc: bpf@vger.kernel.org, Matt Wu <wuqiang.matt@bytedance.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240424215214.3956041-1-andrii@kernel.org>
 <20240424215214.3956041-2-andrii@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240424215214.3956041-2-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B9E5720AE1
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,bytedance.com:email]

On 4/24/24 11:52 PM, Andrii Nakryiko wrote:
> objpool_push() and objpool_pop() are very performance-critical functions
> and can be called very frequently in kretprobe triggering path.
> 
> As such, it makes sense to allow compiler to inline them completely to
> eliminate function calls overhead. Luckily, their logic is quite well
> isolated and doesn't have any sprawling dependencies.
> 
> This patch moves both objpool_push() and objpool_pop() into
> include/linux/objpool.h and marks them as static inline functions,
> enabling inlining. To avoid anyone using internal helpers
> (objpool_try_get_slot, objpool_try_add_slot), rename them to use leading
> underscores.
> 
> We used kretprobe microbenchmark from BPF selftests (bench trig-kprobe
> and trig-kprobe-multi benchmarks) running no-op BPF kretprobe/kretprobe.multi
> programs in a tight loop to evaluate the effect. BPF own overhead in
> this case is minimal and it mostly stresses the rest of in-kernel
> kretprobe infrastructure overhead. Results are in millions of calls per
> second. This is not super scientific, but shows the trend nevertheless.
> 
> BEFORE
> ======
> kretprobe      :    9.794 ± 0.086M/s
> kretprobe-multi:   10.219 ± 0.032M/s
> 
> AFTER
> =====
> kretprobe      :    9.937 ± 0.174M/s (+1.5%)
> kretprobe-multi:   10.440 ± 0.108M/s (+2.2%)
> 
> Cc: Matt (Qiang) Wu <wuqiang.matt@bytedance.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Hello,

this question is not specific to your patch, but since it's a recent thread,
I'll ask it here instead of digging up the original objpool patches.

I'm trying to understand how objpool works and if it could be integrated
into SLUB, for the LSF/MM discussion next week:

https://lore.kernel.org/all/b929d5fb-8e88-4f23-8ec7-6bdaf61f84f9@suse.cz/

> +/* adding object to slot, abort if the slot was already full */

I don't see any actual abort in the code (not in this code nor in the
deleted code - it's the same code, just moved for inlining purposes).

> +static inline int
> +__objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
> +{
> +	struct objpool_slot *slot = pool->cpu_slots[cpu];
> +	uint32_t head, tail;
> +
> +	/* loading tail and head as a local snapshot, tail first */
> +	tail = READ_ONCE(slot->tail);
> +
> +	do {
> +		head = READ_ONCE(slot->head);
> +		/* fault caught: something must be wrong */
> +		WARN_ON_ONCE(tail - head > pool->nr_objs);

So this will only WARN if we go over the capacity, but continue and
overwrite a pointer that was already there, effectively leaking said object, no?

> +	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> +
> +	/* now the tail position is reserved for the given obj */
> +	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> +	/* update sequence to make this obj available for pop() */
> +	smp_store_release(&slot->last, tail + 1);
> +
> +	return 0;
> +}
>  
>  /**
>   * objpool_push() - reclaim the object and return back to objpool
> @@ -134,7 +219,19 @@ void *objpool_pop(struct objpool_head *pool);
>   * return: 0 or error code (it fails only when user tries to push
>   * the same object multiple times or wrong "objects" into objpool)
>   */
> -int objpool_push(void *obj, struct objpool_head *pool);
> +static inline int objpool_push(void *obj, struct objpool_head *pool)
> +{
> +	unsigned long flags;
> +	int rc;
> +
> +	/* disable local irq to avoid preemption & interruption */
> +	raw_local_irq_save(flags);
> +	rc = __objpool_try_add_slot(obj, pool, raw_smp_processor_id());

And IIUC, we could in theory objpool_pop() on one cpu, then later another
cpu might do objpool_push() and cause the latter cpu's pool to go over
capacity? Is there some implicit requirements of objpool users to take care
of having matched cpu for pop and push? Are the current objpool users
obeying this requirement? (I can see the selftests do, not sure about the
actual users).
Or am I missing something? Thanks.

> +	raw_local_irq_restore(flags);
> +
> +	return rc;
> +}
> +
>  
>  /**
>   * objpool_drop() - discard the object and deref objpool
> diff --git a/lib/objpool.c b/lib/objpool.c
> index cfdc02420884..f696308fc026 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -152,106 +152,6 @@ int objpool_init(struct objpool_head *pool, int nr_objs, int object_size,
>  }
>  EXPORT_SYMBOL_GPL(objpool_init);
>  
> -/* adding object to slot, abort if the slot was already full */
> -static inline int
> -objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
> -{
> -	struct objpool_slot *slot = pool->cpu_slots[cpu];
> -	uint32_t head, tail;
> -
> -	/* loading tail and head as a local snapshot, tail first */
> -	tail = READ_ONCE(slot->tail);
> -
> -	do {
> -		head = READ_ONCE(slot->head);
> -		/* fault caught: something must be wrong */
> -		WARN_ON_ONCE(tail - head > pool->nr_objs);
> -	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> -
> -	/* now the tail position is reserved for the given obj */
> -	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> -	/* update sequence to make this obj available for pop() */
> -	smp_store_release(&slot->last, tail + 1);
> -
> -	return 0;
> -}
> -
> -/* reclaim an object to object pool */
> -int objpool_push(void *obj, struct objpool_head *pool)
> -{
> -	unsigned long flags;
> -	int rc;
> -
> -	/* disable local irq to avoid preemption & interruption */
> -	raw_local_irq_save(flags);
> -	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
> -	raw_local_irq_restore(flags);
> -
> -	return rc;
> -}
> -EXPORT_SYMBOL_GPL(objpool_push);
> -
> -/* try to retrieve object from slot */
> -static inline void *objpool_try_get_slot(struct objpool_head *pool, int cpu)
> -{
> -	struct objpool_slot *slot = pool->cpu_slots[cpu];
> -	/* load head snapshot, other cpus may change it */
> -	uint32_t head = smp_load_acquire(&slot->head);
> -
> -	while (head != READ_ONCE(slot->last)) {
> -		void *obj;
> -
> -		/*
> -		 * data visibility of 'last' and 'head' could be out of
> -		 * order since memory updating of 'last' and 'head' are
> -		 * performed in push() and pop() independently
> -		 *
> -		 * before any retrieving attempts, pop() must guarantee
> -		 * 'last' is behind 'head', that is to say, there must
> -		 * be available objects in slot, which could be ensured
> -		 * by condition 'last != head && last - head <= nr_objs'
> -		 * that is equivalent to 'last - head - 1 < nr_objs' as
> -		 * 'last' and 'head' are both unsigned int32
> -		 */
> -		if (READ_ONCE(slot->last) - head - 1 >= pool->nr_objs) {
> -			head = READ_ONCE(slot->head);
> -			continue;
> -		}
> -
> -		/* obj must be retrieved before moving forward head */
> -		obj = READ_ONCE(slot->entries[head & slot->mask]);
> -
> -		/* move head forward to mark it's consumption */
> -		if (try_cmpxchg_release(&slot->head, &head, head + 1))
> -			return obj;
> -	}
> -
> -	return NULL;
> -}
> -
> -/* allocate an object from object pool */
> -void *objpool_pop(struct objpool_head *pool)
> -{
> -	void *obj = NULL;
> -	unsigned long flags;
> -	int i, cpu;
> -
> -	/* disable local irq to avoid preemption & interruption */
> -	raw_local_irq_save(flags);
> -
> -	cpu = raw_smp_processor_id();
> -	for (i = 0; i < num_possible_cpus(); i++) {
> -		obj = objpool_try_get_slot(pool, cpu);
> -		if (obj)
> -			break;
> -		cpu = cpumask_next_wrap(cpu, cpu_possible_mask, -1, 1);
> -	}
> -	raw_local_irq_restore(flags);
> -
> -	return obj;
> -}
> -EXPORT_SYMBOL_GPL(objpool_pop);
> -
>  /* release whole objpool forcely */
>  void objpool_free(struct objpool_head *pool)
>  {


