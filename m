Return-Path: <bpf+bounces-73600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 343F7C34AD3
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACD4F34B457
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216D2F3C35;
	Wed,  5 Nov 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqN8C7wL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qp3nFStx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqN8C7wL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qp3nFStx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860422F363A
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333534; cv=none; b=mUq39SkwfEHZ+h5EMiwJ/p+zB48qXT5GmczdGvmsK3tPJh0zsqHsurz2lkPOKhLpidITTgK21cSY3/+MmsNdR9uQCKVNmiHhwlKf/yNV2014uWx0C1G32wQByVaEiyc1KUgyaMOUPj8D4ktIkcrXEwTyrNvOcTRYBMmr36tHGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333534; c=relaxed/simple;
	bh=mKCpFsvDNsc2yiGtg7SQr8oWI/UUG8xVoL88QGsKeYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/WNebdV4W3kkmbqsF7q+lbOF/xHgJ6BdfrT7WnGutHkUreoeOFEeuKK98I4XmbQxWXUk0mYVMZoUeFVR19HXS/S2Q2D7SBjmMudLSoUkjBb8IzJZBOan9lklK5Y66TPgiLgAajqVY6UELLzPH0bT9lKssC4drz237hXZQnbNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqN8C7wL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qp3nFStx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqN8C7wL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qp3nFStx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B87E921181;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dS0i3Iby0OJwb+mg8PeOF13C4McpBxa53amtQoTdGRo=;
	b=JqN8C7wLBSfHWyDRgrkAOSu/ZqlR3yJqJ8KU2mHbmcLeRJR3Puhk1VkHbhS+DnYUo84Rxj
	Bp6tmt/H6vXLVTlJ9sgHP38KdoeBkJ4wsk6+6RsDMDrAFDbzB/YDGEnUdskgN1Xt4CySuV
	1i6OfYeQsJhfHbErsMnTeYmaTR8DRSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dS0i3Iby0OJwb+mg8PeOF13C4McpBxa53amtQoTdGRo=;
	b=qp3nFStxU4c7UxtZa4zaEZis3Q2Owsk6R3hvx8A9339erKrkkHtqvwDTDHrSVq/PWep5rB
	uEB+BSnmsqmqRqDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JqN8C7wL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qp3nFStx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dS0i3Iby0OJwb+mg8PeOF13C4McpBxa53amtQoTdGRo=;
	b=JqN8C7wLBSfHWyDRgrkAOSu/ZqlR3yJqJ8KU2mHbmcLeRJR3Puhk1VkHbhS+DnYUo84Rxj
	Bp6tmt/H6vXLVTlJ9sgHP38KdoeBkJ4wsk6+6RsDMDrAFDbzB/YDGEnUdskgN1Xt4CySuV
	1i6OfYeQsJhfHbErsMnTeYmaTR8DRSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dS0i3Iby0OJwb+mg8PeOF13C4McpBxa53amtQoTdGRo=;
	b=qp3nFStxU4c7UxtZa4zaEZis3Q2Owsk6R3hvx8A9339erKrkkHtqvwDTDHrSVq/PWep5rB
	uEB+BSnmsqmqRqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A87613A91;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AEN5JVoTC2lSBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 09:05:30 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 05 Nov 2025 10:05:30 +0100
Subject: [PATCH 2/5] slab: move kfence_alloc() out of internal bulk alloc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
In-Reply-To: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 kasan-dev@googlegroups.com, Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B87E921181
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:mid,suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
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
index 074abe8e79f8..0237a329d4e5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5540,6 +5540,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
  *
  * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
  * memcg charging is forced over limit if necessary, to avoid failure.
+ *
+ * It is possible that the allocation comes from kfence and then the sheaf
+ * size is not decreased.
  */
 void *
 kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
@@ -5551,7 +5554,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
 	if (sheaf->size == 0)
 		goto out;
 
-	ret = sheaf->objects[--sheaf->size];
+	ret = kfence_alloc(s, s->object_size, gfp);
+
+	if (likely(!ret))
+		ret = sheaf->objects[--sheaf->size];
 
 	init = slab_want_init_on_alloc(gfp, s);
 
@@ -7399,14 +7405,8 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
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
@@ -7487,6 +7487,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 				 void **p)
 {
 	unsigned int i = 0;
+	void *kfence_obj;
 
 	if (!size)
 		return 0;
@@ -7495,6 +7496,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
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
 
@@ -7506,10 +7521,23 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
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


