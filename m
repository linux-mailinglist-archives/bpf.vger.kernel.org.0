Return-Path: <bpf+bounces-79269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D31E7D32EC4
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B6C3079ACD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB438F22E;
	Fri, 16 Jan 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0uDN5flZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JWo3tguL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0uDN5flZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JWo3tguL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A66394462
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574456; cv=none; b=MFfTQQRNc2Trj2wmLlOdXAtHzgvHS84uZuPxMtOHhjkyNCqC2xqYvKg3hZp/3PfK5lPWHRUv8u2Q+eFetYeS3zHtzXEFlxM3YZFCff+u92R7mWeTFzIYI20+4dRaTD+62bqzdWtiEJafVvKdzhGhRdZIsrVGk7d40T6CiQdweF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574456; c=relaxed/simple;
	bh=0mh2Zw5MmsaTt80OTB41lStZ/fL7xJJSY1ezw3C8GyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiUoiqRYLyBEQHvmSxsp7eqP+UqohdSszK8YibHYdK4UgoComfdnrLItuXJ2T2KBjsiORF8flVfxLhTZ+H1UALj7PqPrsOXaP0pNWzu5H5FnYPfa03FGfmzkFY9oHHzXD2p2m7ZUorFbkKGJl0Xca6/StSK9DMWfeZNk6PGmWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0uDN5flZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JWo3tguL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0uDN5flZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JWo3tguL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC4BA337F3;
	Fri, 16 Jan 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROlivulU3ZUUmQJGgAdryy78yr1ISK1JLKlofJUd2Bs=;
	b=0uDN5flZo3M3oKooVLtgw+1lGKk3BNo1NGV6Q+KZ0hpQVUJswdO5WN4miVeMNmspxouANY
	R+7UYkcGL+0au9gjLCXfyFcPDhQLP4V+cROAaH0xQhIMWn6Fzk6GPsDMpVr44n/97gkS0N
	nsT1knhA/mMiM0SUCKDp7oDo2BKrqm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROlivulU3ZUUmQJGgAdryy78yr1ISK1JLKlofJUd2Bs=;
	b=JWo3tguLRb0u9hBzlNubo9IPlGnwnN0zFKl8NeAdJ568/UV/thCxqZKK9r/jh3KPEhOm/x
	gDHOe3cDQxTghDCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROlivulU3ZUUmQJGgAdryy78yr1ISK1JLKlofJUd2Bs=;
	b=0uDN5flZo3M3oKooVLtgw+1lGKk3BNo1NGV6Q+KZ0hpQVUJswdO5WN4miVeMNmspxouANY
	R+7UYkcGL+0au9gjLCXfyFcPDhQLP4V+cROAaH0xQhIMWn6Fzk6GPsDMpVr44n/97gkS0N
	nsT1knhA/mMiM0SUCKDp7oDo2BKrqm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROlivulU3ZUUmQJGgAdryy78yr1ISK1JLKlofJUd2Bs=;
	b=JWo3tguLRb0u9hBzlNubo9IPlGnwnN0zFKl8NeAdJ568/UV/thCxqZKK9r/jh3KPEhOm/x
	gDHOe3cDQxTghDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A881F3EA66;
	Fri, 16 Jan 2026 14:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEjcKORNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:36 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:22 +0100
Subject: [PATCH v3 02/21] slab: add SLAB_CONSISTENCY_CHECKS to
 SLAB_NEVER_MERGE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-2-5595cb000772@suse.cz>
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
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

All the debug flags prevent merging, except SLAB_CONSISTENCY_CHECKS. This
is suboptimal because this flag (like any debug flags) prevents the
usage of any fastpaths, and thus affect performance of any aliased
cache. Also the objects from an aliased cache than the one specified for
debugging could also interfere with the debugging efforts.

Fix this by adding the whole SLAB_DEBUG_FLAGS collection to
SLAB_NEVER_MERGE instead of individual debug flags, so it now also
includes SLAB_CONSISTENCY_CHECKS.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ee994ec7f251..e691ede0e6a8 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -45,9 +45,8 @@ struct kmem_cache *kmem_cache;
 /*
  * Set of flags that will prevent slab merging
  */
-#define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
-		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE)
+#define SLAB_NEVER_MERGE (SLAB_DEBUG_FLAGS | SLAB_TYPESAFE_BY_RCU | \
+		SLAB_NOLEAKTRACE | SLAB_FAILSLAB | SLAB_NO_MERGE)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)

-- 
2.52.0


