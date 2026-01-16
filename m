Return-Path: <bpf+bounces-79274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95860D32D39
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F80A30C7B93
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AC39901F;
	Fri, 16 Jan 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IjRAZpDJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqLsDMNQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bHTXKLTC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9axPLR58"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D6396B92
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574476; cv=none; b=CeccAL/xAFUcITVAsqufLMzaZjk3JEYYF2IKx34I9uSb61YfyZVa/UBbSU4QI594DusLEUGY4GM8ZPmf8uy+MkDELD85lKSFcYFQOYq23oO39FI6WAqd1TrAc2yeEl0yvp/R5+mVlEwTs0iJeM0h4uBEBgbSDm94qsOndO4zEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574476; c=relaxed/simple;
	bh=zFTorHp4uuIPhlvBn+XEeOW3w7haz6p12YzyIkFz4c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1o9N/9RmfGFgDrTOhX52PjXZK19Y6sDMLZmPxJUrTpW5O+h9+JABK97Uto8AyhCha+2YtkscLfKBzC96MONuRaqIgwv1mgesjCoYp4xn0cglob3gsrJss/pfjagpJfqmBhSAz3NU6jWBSARTj1D2xeEN5emTBnx6pyaHMeulTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IjRAZpDJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqLsDMNQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bHTXKLTC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9axPLR58; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E79D3337F7;
	Fri, 16 Jan 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NQimX2qnHyu3iifkMxRzCZm5f98wg6UoDIBK4sRJ+Q=;
	b=IjRAZpDJbvGkZ4PRHVRMajXUaylUKsG2mFfcgvO/CHqSHN2cJ8yClC0ETic9AFyX2fQK6y
	8yF6iEBZZf6rixxCayVusw0ognFkGoKkkB++gVL19t5zGyAzd1grPKGWiQGIfnoxC1YLjH
	7jZdt7MQMtW0oQnIqIXHOFiPgebfa5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NQimX2qnHyu3iifkMxRzCZm5f98wg6UoDIBK4sRJ+Q=;
	b=qqLsDMNQEMi6oQ6kdtboFIM7Vl7xlGejWKY6vneFK8/3wYjx7lqIVGyZhMRdD5DgKu/bBy
	1SgGxa62xjciYwDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bHTXKLTC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9axPLR58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NQimX2qnHyu3iifkMxRzCZm5f98wg6UoDIBK4sRJ+Q=;
	b=bHTXKLTCNaMmnRR8mday6p5+H8tMJLbOk/PFtk+8rHeqahiIL/IEnHVlMu6Be/QQ7ebuuB
	eENPdKKsDHwm3EjnXW7hqfdSOcx2z3I+M+CK35A2Pkw1HeasgV/h1rVQOOxNzkaiUjtAxD
	9VR2K7fsdnFTQEj3oPWIv6ewrVJzW44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NQimX2qnHyu3iifkMxRzCZm5f98wg6UoDIBK4sRJ+Q=;
	b=9axPLR58O7D5zJ0fVfsle5q3EiPj0vyaTRz/qy585O/0mapFnq4eXTGymbxfuwAOIspUUs
	rKfoa/KpWMmGzHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5E313EA67;
	Fri, 16 Jan 2026 14:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ECUEMORNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:36 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:23 +0100
Subject: [PATCH v3 03/21] mm/slab: move and refactor __kmem_cache_alias()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-3-5595cb000772@suse.cz>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E79D3337F7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Move __kmem_cache_alias() to slab_common.c since it's called by
__kmem_cache_create_args() and calls find_mergeable() that both
are in this file. We can remove two slab.h declarations and make
them static. Instead declare sysfs_slab_alias() from slub.c so
that __kmem_cache_alias() can keep calling it.

Add args parameter to __kmem_cache_alias() and find_mergeable() instead
of align and ctor. With that we can also move the checks for usersize
and sheaf_capacity there from __kmem_cache_create_args() and make the
result more symmetric with slab_unmergeable().

No functional changes intended.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |  8 +++-----
 mm/slab_common.c | 44 +++++++++++++++++++++++++++++++++++++-------
 mm/slub.c        | 30 +-----------------------------
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index e767aa7e91b0..cb48ce5014ba 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -281,9 +281,12 @@ struct kmem_cache {
 #define SLAB_SUPPORTS_SYSFS 1
 void sysfs_slab_unlink(struct kmem_cache *s);
 void sysfs_slab_release(struct kmem_cache *s);
+int sysfs_slab_alias(struct kmem_cache *, const char *);
 #else
 static inline void sysfs_slab_unlink(struct kmem_cache *s) { }
 static inline void sysfs_slab_release(struct kmem_cache *s) { }
+static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
+							{ return 0; }
 #endif
 
 void *fixup_red_left(struct kmem_cache *s, void *p);
@@ -400,11 +403,6 @@ extern void create_boot_cache(struct kmem_cache *, const char *name,
 			unsigned int useroffset, unsigned int usersize);
 
 int slab_unmergeable(struct kmem_cache *s);
-struct kmem_cache *find_mergeable(unsigned size, unsigned align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *));
-struct kmem_cache *
-__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, void (*ctor)(void *));
 
 slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e691ede0e6a8..ee245a880603 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -174,15 +174,22 @@ int slab_unmergeable(struct kmem_cache *s)
 	return 0;
 }
 
-struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
-		slab_flags_t flags, const char *name, void (*ctor)(void *))
+static struct kmem_cache *find_mergeable(unsigned int size, slab_flags_t flags,
+		const char *name, struct kmem_cache_args *args)
 {
 	struct kmem_cache *s;
+	unsigned int align;
 
 	if (slab_nomerge)
 		return NULL;
 
-	if (ctor)
+	if (args->ctor)
+		return NULL;
+
+	if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
+		return NULL;
+
+	if (args->sheaf_capacity)
 		return NULL;
 
 	flags = kmem_cache_flags(flags, name);
@@ -191,7 +198,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 		return NULL;
 
 	size = ALIGN(size, sizeof(void *));
-	align = calculate_alignment(flags, align, size);
+	align = calculate_alignment(flags, args->align, size);
 	size = ALIGN(size, align);
 
 	list_for_each_entry_reverse(s, &slab_caches, list) {
@@ -252,6 +259,31 @@ static struct kmem_cache *create_cache(const char *name,
 	return ERR_PTR(err);
 }
 
+static struct kmem_cache *
+__kmem_cache_alias(const char *name, unsigned int size, slab_flags_t flags,
+		   struct kmem_cache_args *args)
+{
+	struct kmem_cache *s;
+
+	s = find_mergeable(size, flags, name, args);
+	if (s) {
+		if (sysfs_slab_alias(s, name))
+			pr_err("SLUB: Unable to add cache alias %s to sysfs\n",
+			       name);
+
+		s->refcount++;
+
+		/*
+		 * Adjust the object sizes so that we clear
+		 * the complete object on kzalloc.
+		 */
+		s->object_size = max(s->object_size, size);
+		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
+	}
+
+	return s;
+}
+
 /**
  * __kmem_cache_create_args - Create a kmem cache.
  * @name: A string which is used in /proc/slabinfo to identify this cache.
@@ -323,9 +355,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
-	if (!args->usersize && !args->sheaf_capacity)
-		s = __kmem_cache_alias(name, object_size, args->align, flags,
-				       args->ctor);
+	s = __kmem_cache_alias(name, object_size, flags, args);
 	if (s)
 		goto out_unlock;
 
diff --git a/mm/slub.c b/mm/slub.c
index df71c156d13c..2dda2fc57ced 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -350,11 +350,8 @@ enum track_item { TRACK_ALLOC, TRACK_FREE };
 
 #ifdef SLAB_SUPPORTS_SYSFS
 static int sysfs_slab_add(struct kmem_cache *);
-static int sysfs_slab_alias(struct kmem_cache *, const char *);
 #else
 static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
-static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
-							{ return 0; }
 #endif
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
@@ -8553,31 +8550,6 @@ void __init kmem_cache_init_late(void)
 	WARN_ON(!flushwq);
 }
 
-struct kmem_cache *
-__kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
-		   slab_flags_t flags, void (*ctor)(void *))
-{
-	struct kmem_cache *s;
-
-	s = find_mergeable(size, align, flags, name, ctor);
-	if (s) {
-		if (sysfs_slab_alias(s, name))
-			pr_err("SLUB: Unable to add cache alias %s to sysfs\n",
-			       name);
-
-		s->refcount++;
-
-		/*
-		 * Adjust the object sizes so that we clear
-		 * the complete object on kzalloc.
-		 */
-		s->object_size = max(s->object_size, size);
-		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
-	}
-
-	return s;
-}
-
 int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 			 unsigned int size, struct kmem_cache_args *args,
 			 slab_flags_t flags)
@@ -9810,7 +9782,7 @@ struct saved_alias {
 
 static struct saved_alias *alias_list;
 
-static int sysfs_slab_alias(struct kmem_cache *s, const char *name)
+int sysfs_slab_alias(struct kmem_cache *s, const char *name)
 {
 	struct saved_alias *al;
 

-- 
2.52.0


