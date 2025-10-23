Return-Path: <bpf+bounces-71912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F35C01958
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699B63B3106
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36C322C9D;
	Thu, 23 Oct 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mdy9BKbL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+uOlwOB7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPf6Y90J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P0Lui0/h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DF2320CA8
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227594; cv=none; b=g+1GCRxwrelut1GuAaJPSU6dQZ9BQ38kPm5V6HitDEWvzKghIlkWlyLQEw4vS6xBAaulZ7s9bsWgeZRAweBPF8fqxS9+NULHHmFrCPW3X0G3enmuS4xtUkn3N4EBdIzoNNvF+vrpyf9VHzR3RV9KX81f6ak7Cfu4T2tKHSjJdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227594; c=relaxed/simple;
	bh=6Iiz3AHt1Z1Af2WpTwoU9QnqqUvhGzaiRG7A77s07W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scu93iV8k2Dd34KUqyaC8td35fzN/EbH7aJGtq6vUsdiMUgyBCwW7qExumOJn8iY0arHRDIuUfWbfI8RMIu2XCdirAys6yRcK8iDWMpBMCXIS2A+YMgqd4eHSWxxWKINsVXQfQ55c0cjcXbnC/WJIkmSZqxyTT6QsZyE/ZrCMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mdy9BKbL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+uOlwOB7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPf6Y90J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P0Lui0/h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 356491F7E1;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMsUktfL5WtFwPCNB5fqm7HAiF7pw4pM7Su8oc/8OIE=;
	b=Mdy9BKbLm2lN1RACuTP3IEWpgAFVa7Fshte+HriO9fKIlEuuHazko/HNUO+TrJCgysS6DP
	qbMkOSPnAP/Vc0fvnG7qJZY442AWC0MLCqAkwZuFx2sHw/wyTOc+6YgPhSLN2lLdrUj0Ip
	gGDRhrZlP/wqYtKY9DGJUZXjMoYobRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMsUktfL5WtFwPCNB5fqm7HAiF7pw4pM7Su8oc/8OIE=;
	b=+uOlwOB7G6UnQ7VofjGwWpSWB1tS3X/MTsf0Mh39EL30Li3sFkbLqfoTr0+SKSACmSseLj
	v75xnLK2L6+NXeCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMsUktfL5WtFwPCNB5fqm7HAiF7pw4pM7Su8oc/8OIE=;
	b=EPf6Y90JOImCC0jua9VvOIFRXsPvKG0JuNSvVby2rlaB3k8Xbx7Jhme7+aJ2qa/lBKSjDQ
	mZokjHpOlgVfrSoTzRwMAY7Hs+WayoqduU/NJiVdK1sSb+gGEm0ZveoYdySE3r2ODfmuDS
	ThembSqD8ecUvAKO2Y+xRGATadJj/yg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMsUktfL5WtFwPCNB5fqm7HAiF7pw4pM7Su8oc/8OIE=;
	b=P0Lui0/h5SvlSmXMW6h8A4EhWC9Ya74OAhUoHOBv352Z7+wG0GrnqfP5cCtHxbpB0f+Jg1
	IO7ol//+pdxU3YDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D48139D2;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6O8UBDUz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 15:52:23 +0200
Subject: [PATCH RFC 01/19] slab: move kfence_alloc() out of internal bulk
 alloc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sheaves-for-all-v1-1-6ffa2c9941c0@suse.cz>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>, Alexander Potapenko <glider@google.com>, 
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 

SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
but it's conceptually the wrong layer, as KFENCE allocations should only
happen when objects are actually handed out from slab to its users.

Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
was refilled with KFENCE objects. Continuing like this would also
complicate the upcoming sheaf refill changes.

Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
to the places that return slab objects to users. slab_alloc_node() is
already covered (see above). Add kfence_alloc() to
kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
prefilled sheafs, with a comment that the caller should not expect the
sheaf size to decrease after every allocation because of this
possibility.

For kmem_cache_alloc_bulk() implement a different strategy to handle
KFENCE upfront and rely on internal batched operations afterwards.
Assume there will be at most once KFENCE allocation per bulk allocation
and then assign its index in the array of objects randomly.

Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 87a1d2f9de0d..4731b9e461c2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5530,6 +5530,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
  *
  * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
  * memcg charging is forced over limit if necessary, to avoid failure.
+ *
+ * It is possible that the allocation comes from kfence and then the sheaf
+ * size is not decreased.
  */
 void *
 kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
@@ -5541,7 +5544,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 	if (sheaf->size == 0)
 		goto out;
 
-	ret = sheaf->objects[--sheaf->size];
+	ret = kfence_alloc(s, s->object_size, gfp);
+
+	if (likely(!ret))
+		ret = sheaf->objects[--sheaf->size];
 
 	init = slab_want_init_on_alloc(gfp, s);
 
@@ -7361,14 +7367,8 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
 
 	for (i = 0; i < size; i++) {
-		void *object = kfence_alloc(s, s->object_size, flags);
-
-		if (unlikely(object)) {
-			p[i] = object;
-			continue;
-		}
+		void *object = c->freelist;
 
-		object = c->freelist;
 		if (unlikely(!object)) {
 			/*
 			 * We may have removed an object from c->freelist using
@@ -7449,6 +7449,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 				 void **p)
 {
 	unsigned int i = 0;
+	void *kfence_obj;
 
 	if (!size)
 		return 0;
@@ -7457,6 +7458,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 	if (unlikely(!s))
 		return 0;
 
+	/*
+	 * to make things simpler, only assume at most once kfence allocated
+	 * object per bulk allocation and choose its index randomly
+	 */
+	kfence_obj = kfence_alloc(s, s->object_size, flags);
+
+	if (unlikely(kfence_obj)) {
+		if (unlikely(size == 1)) {
+			p[0] = kfence_obj;
+			goto out;
+		}
+		size--;
+	}
+
 	if (s->cpu_sheaves)
 		i = alloc_from_pcs_bulk(s, size, p);
 
@@ -7468,10 +7483,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 		if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
 			if (i > 0)
 				__kmem_cache_free_bulk(s, i, p);
+			if (kfence_obj)
+				__kfence_free(kfence_obj);
 			return 0;
 		}
 	}
 
+	if (unlikely(kfence_obj)) {
+		int idx = get_random_u32_below(size + 1);
+
+		if (idx != size)
+			p[size] = p[idx];
+		p[idx] = kfence_obj;
+
+		size++;
+	}
+
+out:
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
 	 * Done outside of the IRQ disabled fastpath loop.

-- 
2.51.1


