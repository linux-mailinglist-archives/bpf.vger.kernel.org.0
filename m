Return-Path: <bpf+bounces-79283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEDD32DA8
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7950931087E1
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F53A0B3E;
	Fri, 16 Jan 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLuX480n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJ/JWdnM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLuX480n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJ/JWdnM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2083A1A37
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574509; cv=none; b=EdbAcdUZkB90wlvrmRhxFxWCGnX+0WIRyF3Vurj5BWjJOJ7ouxxaMqyegGJFEyCPjxBjcvqxGL7Rvh6FNjsChDbUpsOven7trYW4iMrXdfKiy9vO3zzR2aAUdHz2E+DN7eUqeWqJ4r2qMghFnrhudNXy987tLsczoiG7+Dj+2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574509; c=relaxed/simple;
	bh=G4KiAiN4WPPoE0dwnfw2x30xfunXGI/HmbzOlowzMXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5t7B8bZo/lgXc/KaDXPE3SmKpJyerjVCdTopkGcIjIN0kqHLVPWq7sYwPK8BlZe27QsYi8h93zH9wHgzPkFCvGd0Pv9uf4k8KYT2fdeKT9Hqsvd/bqtXoJw4FX9/WL1vNqx5ZfxwA+VkYRJTsDqs2Qe5ynCU3ALn1CXSA2MrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FLuX480n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJ/JWdnM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FLuX480n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJ/JWdnM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8815BE95;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/x3VSl+z38DX55xEQiDw1zpCdC7JNkQuXeiqMr2GloI=;
	b=FLuX480nnxr2LCrWzGHmf9yMjIJp+7pc0EZ/9aFuMwCmQlGvmnSsq9vKrquCQTg1QTGu1s
	sYollNtHUNJrYR6V1ybengYbGfp1O3jGD3Z7278eWf//9Tj0vBkyrb2aCAuRH8u6AqDnTd
	H0Y7R05XSFVxPYuS3pEibGSWYdj4IgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/x3VSl+z38DX55xEQiDw1zpCdC7JNkQuXeiqMr2GloI=;
	b=ZJ/JWdnMIUYuzJE/R75O0PN8fcbxjb2kKwKGZoruoAD76vtcG8/431leNkJCKQlNPC99GJ
	Oi8gjzF9Ffvc9YCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FLuX480n;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ZJ/JWdnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/x3VSl+z38DX55xEQiDw1zpCdC7JNkQuXeiqMr2GloI=;
	b=FLuX480nnxr2LCrWzGHmf9yMjIJp+7pc0EZ/9aFuMwCmQlGvmnSsq9vKrquCQTg1QTGu1s
	sYollNtHUNJrYR6V1ybengYbGfp1O3jGD3Z7278eWf//9Tj0vBkyrb2aCAuRH8u6AqDnTd
	H0Y7R05XSFVxPYuS3pEibGSWYdj4IgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/x3VSl+z38DX55xEQiDw1zpCdC7JNkQuXeiqMr2GloI=;
	b=ZJ/JWdnMIUYuzJE/R75O0PN8fcbxjb2kKwKGZoruoAD76vtcG8/431leNkJCKQlNPC99GJ
	Oi8gjzF9Ffvc9YCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FFFC3EA66;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KFb5HuZNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:38 +0100
Subject: [PATCH v3 18/21] slab: update overview comments
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-18-5595cb000772@suse.cz>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
To: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq),to(RL941jgdop1fyjkq8h4)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9B8815BE95
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

The changes related to sheaves made the description of locking and other
details outdated. Update it to reflect current state.

Also add a new copyright line due to major changes.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 141 +++++++++++++++++++++++++++++---------------------------------
 1 file changed, 67 insertions(+), 74 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2c522d2bf547..476a279f1a94 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1,13 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SLUB: A slab allocator that limits cache line use instead of queuing
- * objects in per cpu and per node lists.
+ * SLUB: A slab allocator with low overhead percpu array caches and mostly
+ * lockless freeing of objects to slabs in the slowpath.
  *
- * The allocator synchronizes using per slab locks or atomic operations
- * and only uses a centralized lock to manage a pool of partial slabs.
+ * The allocator synchronizes using spin_trylock for percpu arrays in the
+ * fastpath, and cmpxchg_double (or bit spinlock) for slowpath freeing.
+ * Uses a centralized lock to manage a pool of partial slabs.
  *
  * (C) 2007 SGI, Christoph Lameter
  * (C) 2011 Linux Foundation, Christoph Lameter
+ * (C) 2025 SUSE, Vlastimil Babka
  */
 
 #include <linux/mm.h>
@@ -53,11 +55,13 @@
 
 /*
  * Lock order:
- *   1. slab_mutex (Global Mutex)
- *   2. node->list_lock (Spinlock)
- *   3. kmem_cache->cpu_slab->lock (Local lock)
- *   4. slab_lock(slab) (Only on some arches)
- *   5. object_map_lock (Only for debugging)
+ *   0.  cpu_hotplug_lock
+ *   1.  slab_mutex (Global Mutex)
+ *   2a. kmem_cache->cpu_sheaves->lock (Local trylock)
+ *   2b. node->barn->lock (Spinlock)
+ *   2c. node->list_lock (Spinlock)
+ *   3.  slab_lock(slab) (Only on some arches)
+ *   4.  object_map_lock (Only for debugging)
  *
  *   slab_mutex
  *
@@ -78,31 +82,38 @@
  *	C. slab->objects	-> Number of objects in slab
  *	D. slab->frozen		-> frozen state
  *
- *   Frozen slabs
+ *   SL_partial slabs
+ *
+ *   Slabs on node partial list have at least one free object. A limited number
+ *   of slabs on the list can be fully free (slab->inuse == 0), until we start
+ *   discarding them. These slabs are marked with SL_partial, and the flag is
+ *   cleared while removing them, usually to grab their freelist afterwards.
+ *   This clearing also exempts them from list management. Please see
+ *   __slab_free() for more details.
  *
- *   If a slab is frozen then it is exempt from list management. It is
- *   the cpu slab which is actively allocated from by the processor that
- *   froze it and it is not on any list. The processor that froze the
- *   slab is the one who can perform list operations on the slab. Other
- *   processors may put objects onto the freelist but the processor that
- *   froze the slab is the only one that can retrieve the objects from the
- *   slab's freelist.
+ *   Full slabs
  *
- *   CPU partial slabs
+ *   For caches without debugging enabled, full slabs (slab->inuse ==
+ *   slab->objects and slab->freelist == NULL) are not placed on any list.
+ *   The __slab_free() freeing the first object from such a slab will place
+ *   it on the partial list. Caches with debugging enabled place such slab
+ *   on the full list and use different allocation and freeing paths.
+ *
+ *   Frozen slabs
  *
- *   The partially empty slabs cached on the CPU partial list are used
- *   for performance reasons, which speeds up the allocation process.
- *   These slabs are not frozen, but are also exempt from list management,
- *   by clearing the SL_partial flag when moving out of the node
- *   partial list. Please see __slab_free() for more details.
+ *   If a slab is frozen then it is exempt from list management. It is used to
+ *   indicate a slab that has failed consistency checks and thus cannot be
+ *   allocated from anymore - it is also marked as full. Any previously
+ *   allocated objects will be simply leaked upon freeing instead of attempting
+ *   to modify the potentially corrupted freelist and metadata.
  *
  *   To sum up, the current scheme is:
- *   - node partial slab: SL_partial && !frozen
- *   - cpu partial slab: !SL_partial && !frozen
- *   - cpu slab: !SL_partial && frozen
- *   - full slab: !SL_partial && !frozen
+ *   - node partial slab:            SL_partial && !full && !frozen
+ *   - taken off partial list:      !SL_partial && !full && !frozen
+ *   - full slab, not on any list:  !SL_partial &&  full && !frozen
+ *   - frozen due to inconsistency: !SL_partial &&  full &&  frozen
  *
- *   list_lock
+ *   node->list_lock (spinlock)
  *
  *   The list_lock protects the partial and full list on each node and
  *   the partial slab counter. If taken then no new slabs may be added or
@@ -112,47 +123,46 @@
  *
  *   The list_lock is a centralized lock and thus we avoid taking it as
  *   much as possible. As long as SLUB does not have to handle partial
- *   slabs, operations can continue without any centralized lock. F.e.
- *   allocating a long series of objects that fill up slabs does not require
- *   the list lock.
+ *   slabs, operations can continue without any centralized lock.
  *
  *   For debug caches, all allocations are forced to go through a list_lock
  *   protected region to serialize against concurrent validation.
  *
- *   cpu_slab->lock local lock
+ *   cpu_sheaves->lock (local_trylock)
  *
- *   This locks protect slowpath manipulation of all kmem_cache_cpu fields
- *   except the stat counters. This is a percpu structure manipulated only by
- *   the local cpu, so the lock protects against being preempted or interrupted
- *   by an irq. Fast path operations rely on lockless operations instead.
+ *   This lock protects fastpath operations on the percpu sheaves. On !RT it
+ *   only disables preemption and does no atomic operations. As long as the main
+ *   or spare sheaf can handle the allocation or free, there is no other
+ *   overhead.
  *
- *   On PREEMPT_RT, the local lock neither disables interrupts nor preemption
- *   which means the lockless fastpath cannot be used as it might interfere with
- *   an in-progress slow path operations. In this case the local lock is always
- *   taken but it still utilizes the freelist for the common operations.
+ *   node->barn->lock (spinlock)
  *
- *   lockless fastpaths
+ *   This lock protects the operations on per-NUMA-node barn. It can quickly
+ *   serve an empty or full sheaf if available, and avoid more expensive refill
+ *   or flush operation.
  *
- *   The fast path allocation (slab_alloc_node()) and freeing (do_slab_free())
- *   are fully lockless when satisfied from the percpu slab (and when
- *   cmpxchg_double is possible to use, otherwise slab_lock is taken).
- *   They also don't disable preemption or migration or irqs. They rely on
- *   the transaction id (tid) field to detect being preempted or moved to
- *   another cpu.
+ *   Lockless freeing
+ *
+ *   Objects may have to be freed to their slabs when they are from a remote
+ *   node (where we want to avoid filling local sheaves with remote objects)
+ *   or when there are too many full sheaves. On architectures supporting
+ *   cmpxchg_double this is done by a lockless update of slab's freelist and
+ *   counters, otherwise slab_lock is taken. This only needs to take the
+ *   list_lock if it's a first free to a full slab, or when there are too many
+ *   fully free slabs and some need to be discarded.
  *
  *   irq, preemption, migration considerations
  *
- *   Interrupts are disabled as part of list_lock or local_lock operations, or
+ *   Interrupts are disabled as part of list_lock or barn lock operations, or
  *   around the slab_lock operation, in order to make the slab allocator safe
  *   to use in the context of an irq.
+ *   Preemption is disabled as part of local_trylock operations.
+ *   kmalloc_nolock() and kfree_nolock() are safe in NMI context but see
+ *   their limitations.
  *
- *   In addition, preemption (or migration on PREEMPT_RT) is disabled in the
- *   allocation slowpath, bulk allocation, and put_cpu_partial(), so that the
- *   local cpu doesn't change in the process and e.g. the kmem_cache_cpu pointer
- *   doesn't have to be revalidated in each section protected by the local lock.
- *
- * SLUB assigns one slab for allocation to each processor.
- * Allocations only occur from these slabs called cpu slabs.
+ * SLUB assigns two object arrays called sheaves for caching allocation and
+ * frees on each cpu, with a NUMA node shared barn for balancing between cpus.
+ * Allocations and frees are primarily served from these sheaves.
  *
  * Slabs with free elements are kept on a partial list and during regular
  * operations no list for full slabs is used. If an object in a full slab is
@@ -160,25 +170,8 @@
  * We track full slabs for debugging purposes though because otherwise we
  * cannot scan all objects.
  *
- * Slabs are freed when they become empty. Teardown and setup is
- * minimal so we rely on the page allocators per cpu caches for
- * fast frees and allocs.
- *
- * slab->frozen		The slab is frozen and exempt from list processing.
- * 			This means that the slab is dedicated to a purpose
- * 			such as satisfying allocations for a specific
- * 			processor. Objects may be freed in the slab while
- * 			it is frozen but slab_free will then skip the usual
- * 			list operations. It is up to the processor holding
- * 			the slab to integrate the slab into the slab lists
- * 			when the slab is no longer needed.
- *
- * 			One use of this flag is to mark slabs that are
- * 			used for allocations. Then such a slab becomes a cpu
- * 			slab. The cpu slab may be equipped with an additional
- * 			freelist that allows lockless access to
- * 			free objects in addition to the regular freelist
- * 			that requires the slab lock.
+ * Slabs are freed when they become empty. Teardown and setup is minimal so we
+ * rely on the page allocators per cpu caches for fast frees and allocs.
  *
  * SLAB_DEBUG_FLAGS	Slab requires special handling due to debug
  * 			options set. This moves	slab handling out of

-- 
2.52.0


