Return-Path: <bpf+bounces-79268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D688D32D08
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EADD30B6021
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF563939BA;
	Fri, 16 Jan 2026 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WOx4muwU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXLrQM1d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WOx4muwU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXLrQM1d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877B39341D
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574443; cv=none; b=ipFjBnXw7TXnt4jSkJS43bNOCKuytGgFT/iLbVy4zAQIiesXzpKms6n2Vy7AaN/fvKXDtrQPrwU0K6VSbpfBh2iokisCR5RHxX9QzFMslixzMjifndABU3MYQS6jgC14C08vYYElqKanisrhnEvgeeV4jAJ0m+KvtMKJ/NauBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574443; c=relaxed/simple;
	bh=iiq9ToqvCwwtbxB8Fq4JKkh4aOFecJ/GDIngPYWepls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGKN/68wKffoxZtwQ0DneTjbOcmFOzoQ1T0CiW20pl4iHfgq/ya5ICP3jUwkIWA1tVeyjHtB0mDG39Qrg6cU4SB+UBk3vI+TmhqPOe/Ci87lvt8Y3xrkJqnRv3mTVbLbsxkchDECbRbOk4AEkasS5dnJq+IsvzP22cAPokgCt/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WOx4muwU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXLrQM1d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WOx4muwU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXLrQM1d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D0215BE7B;
	Fri, 16 Jan 2026 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOKU0T0kl+7yhz3gb2FHYxgpYP3PPC7SU1SA5tPPFio=;
	b=WOx4muwUs5VNrGMMl+iGp6qNTHt/zCHS+NULZpOZ60mqn8cpA+h+ANefjC7gK/4bQ5VdQE
	QGrdfqMdmkmJmtMPWuxvxdG2z9dofBXhXqNmJy/6JQryRGo20hXw6wemYEl4YgPL0XHhES
	r6g2a6Mcfc9iFnbQPBGWopPawLqszrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOKU0T0kl+7yhz3gb2FHYxgpYP3PPC7SU1SA5tPPFio=;
	b=xXLrQM1doOZOK+z+kEfNdy9xu9Ar+wPaRQ0sxFVDxxVILn0t921o7EfXjIr/aia6HHws0R
	EvC5p14cKUiZznBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WOx4muwU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xXLrQM1d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOKU0T0kl+7yhz3gb2FHYxgpYP3PPC7SU1SA5tPPFio=;
	b=WOx4muwUs5VNrGMMl+iGp6qNTHt/zCHS+NULZpOZ60mqn8cpA+h+ANefjC7gK/4bQ5VdQE
	QGrdfqMdmkmJmtMPWuxvxdG2z9dofBXhXqNmJy/6JQryRGo20hXw6wemYEl4YgPL0XHhES
	r6g2a6Mcfc9iFnbQPBGWopPawLqszrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOKU0T0kl+7yhz3gb2FHYxgpYP3PPC7SU1SA5tPPFio=;
	b=xXLrQM1doOZOK+z+kEfNdy9xu9Ar+wPaRQ0sxFVDxxVILn0t921o7EfXjIr/aia6HHws0R
	EvC5p14cKUiZznBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2B5D3EA63;
	Fri, 16 Jan 2026 14:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eB0QN+RNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:36 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:24 +0100
Subject: [PATCH v3 04/21] mm/slab: make caches with sheaves mergeable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-4-5595cb000772@suse.cz>
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
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 0D0215BE7B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Before enabling sheaves for all caches (with automatically determined
capacity), their enablement should no longer prevent merging of caches.
Limit this merge prevention only to caches that were created with a
specific sheaf capacity, by adding the SLAB_NO_MERGE flag to them.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ee245a880603..5c15a4ce5743 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -162,9 +162,6 @@ int slab_unmergeable(struct kmem_cache *s)
 		return 1;
 #endif
 
-	if (s->cpu_sheaves)
-		return 1;
-
 	/*
 	 * We may have set a slab to be unmergeable during bootstrap.
 	 */
@@ -189,9 +186,6 @@ static struct kmem_cache *find_mergeable(unsigned int size, slab_flags_t flags,
 	if (IS_ENABLED(CONFIG_HARDENED_USERCOPY) && args->usersize)
 		return NULL;
 
-	if (args->sheaf_capacity)
-		return NULL;
-
 	flags = kmem_cache_flags(flags, name);
 
 	if (flags & SLAB_NEVER_MERGE)
@@ -336,6 +330,13 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 	flags &= ~SLAB_DEBUG_FLAGS;
 #endif
 
+	/*
+	 * Caches with specific capacity are special enough. It's simpler to
+	 * make them unmergeable.
+	 */
+	if (args->sheaf_capacity)
+		flags |= SLAB_NO_MERGE;
+
 	mutex_lock(&slab_mutex);
 
 	err = kmem_cache_sanity_check(name, object_size);

-- 
2.52.0


