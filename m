Return-Path: <bpf+bounces-71919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66676C019B8
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CA23B545D
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF147320CB1;
	Thu, 23 Oct 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MOGWAwma";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0KxwQdA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mOq003rK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2xmdjNN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73A732C933
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227618; cv=none; b=RC14ecJVtfhVWMX5bpcQvbvLRRjbeSO5lKB2+2W0cfWRltE/BbfSsmFpXb4ZNy5yOVq+E9Dkon7vrAa4aKXt+YoMsPQsI5eXzBJANd7QxEDDlYCuQwu855t2Xwv/QOaUgGWg7aMsPnF4uKgznfBm/XNmpZ+9dul5Pc4y/cHQaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227618; c=relaxed/simple;
	bh=kGlyss7yiKflS0OqDJoFDJV4rSVeHfAEYl0ytzW/v5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUDQTZaSn0cY2zykt58iWdULSoUk7w/49eRUQ6nz14tsOmULnVt8ICkMxWGKr3mYBRRr4JccQfsSHkntKkUCzSOINv4cFwnmcUjT2+ePbfVo2NHbrnvPIfCDYGSvu87Ju1XLce+JdaUw0PFG1yU6Ll87fVZfBmjm8/JsawprFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MOGWAwma; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0KxwQdA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mOq003rK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2xmdjNN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F26121254;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDkwJ98STTAq4ia+HrB8vgXHgqJB0sa+3LSjpxlnzDw=;
	b=MOGWAwmaoxKEnh8vs74Hcm4pw0oIiAYpsXZriSfUVqTO/TTa8aNIVXta266scg2cOMd8Qv
	t0qZZ1IcDUG8vgfvKosfoeXzmGfX2CYXEvSHE8e0Li/jkQWECrSx8AwJAlNCCVznLZgFvm
	x/lEzypTjtiF6PJSDGm4mtligfLvMgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDkwJ98STTAq4ia+HrB8vgXHgqJB0sa+3LSjpxlnzDw=;
	b=r0KxwQdAaUdUL4Xo2aWfDNJ8mH2RKeMubLYcyQhUHULjZ+J+e0eb5HEK0MXimGt8QpDGSr
	B+knkOqEOuW2NXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDkwJ98STTAq4ia+HrB8vgXHgqJB0sa+3LSjpxlnzDw=;
	b=mOq003rKXktTSzUTadRVLVn+t7Jn4gCK9rN8teDDA5fd73LlacqNoctDMLg0dFwi71e3qd
	J9RHX5su+pP2opVCJ2x9Hu6RYb4+HFHiTIdXgd4LYOONkTfEJcFE4wHb8dzkLFYTn+okwI
	mBJLCh5CGmyCJBOkIVIPfuixg8XbQ5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDkwJ98STTAq4ia+HrB8vgXHgqJB0sa+3LSjpxlnzDw=;
	b=G2xmdjNN0GsWMJ3Iha/JmZA9J9YOZT7o/B2QC0VLw6OCrLfwqlMPo5Dbd8VJ7+qsYZj41S
	UN/NXM8hjUDvw8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61FE713AE7;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aBahFzUz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 15:52:26 +0200
Subject: [PATCH RFC 04/19] slab: prevent recursive kmalloc() in
 alloc_empty_sheaf()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sheaves-for-all-v1-4-6ffa2c9941c0@suse.cz>
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
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -8.30

We want to expand usage of sheaves to all non-boot caches, including
kmalloc caches. Since sheaves themselves are also allocated by
kmalloc(), we need to prevent excessive or infinite recursion -
depending on sheaf size, the sheaf can be allocated from smaller, same
or larger kmalloc size bucket, there's no particular constraint.

This is similar to allocating the objext arrays so let's just reuse the
existing mechanisms for those. __GFP_NO_OBJ_EXT in alloc_empty_sheaf()
will prevent a nested kmalloc() from allocating a sheaf itself - it will
either have sheaves already, or fallback to a non-sheaf-cached
allocation (so bootstrap of sheaves in a kmalloc cache that allocates
sheaves from its own size bucket is possible). Additionally, reuse
OBJCGS_CLEAR_MASK to clear unwanted gfp flags from the nested
allocation.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp_types.h |  6 ------
 mm/slub.c                 | 36 ++++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..3de43b12209e 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -55,9 +55,7 @@ enum {
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
 #endif
-#ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
-#endif
 	___GFP_LAST_BIT
 };
 
@@ -98,11 +96,7 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
-#ifdef CONFIG_SLAB_OBJ_EXT
 #define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
-#else
-#define ___GFP_NO_OBJ_EXT       0
-#endif
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
diff --git a/mm/slub.c b/mm/slub.c
index 68867cd52c4f..f2b2a6180759 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2031,6 +2031,14 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 }
 #endif /* CONFIG_SLUB_DEBUG */
 
+/*
+ * The allocated objcg pointers array is not accounted directly.
+ * Moreover, it should not come from DMA buffer and is not readily
+ * reclaimable. So those GFP bits should be masked off.
+ */
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
+				__GFP_ACCOUNT | __GFP_NOFAIL)
+
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
@@ -2081,14 +2089,6 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
-/*
- * The allocated objcg pointers array is not accounted directly.
- * Moreover, it should not come from DMA buffer and is not readily
- * reclaimable. So those GFP bits should be masked off.
- */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
-				__GFP_ACCOUNT | __GFP_NOFAIL)
-
 static inline void init_slab_obj_exts(struct slab *slab)
 {
 	slab->obj_exts = 0;
@@ -2590,8 +2590,24 @@ static void *setup_object(struct kmem_cache *s, void *object)
 
 static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
 {
-	struct slab_sheaf *sheaf = kzalloc(struct_size(sheaf, objects,
-					s->sheaf_capacity), gfp);
+	struct slab_sheaf *sheaf;
+	size_t sheaf_size;
+
+	if (gfp & __GFP_NO_OBJ_EXT)
+		return NULL;
+
+	gfp &= ~OBJCGS_CLEAR_MASK;
+
+	/*
+	 * Prevent recursion to the same cache, or a deep stack of kmallocs of
+	 * varying sizes (sheaf capacity might differ for each kmalloc size
+	 * bucket)
+	 */
+	if (s->flags & SLAB_KMALLOC)
+		gfp |= __GFP_NO_OBJ_EXT;
+
+	sheaf_size = struct_size(sheaf, objects, s->sheaf_capacity);
+	sheaf = kzalloc(sheaf_size, gfp);
 
 	if (unlikely(!sheaf))
 		return NULL;

-- 
2.51.1


