Return-Path: <bpf+bounces-31001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CB8D5E58
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39C22875C0
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2813664E;
	Fri, 31 May 2024 09:33:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E91824AE;
	Fri, 31 May 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148023; cv=none; b=GMqeWCNrQiRG+8MYx22/HZev2M6vLvBTu+fFmupGphK+6AswsUcl8OI/LruaMXUlYYfHqCXQYcqp74wJrhX4CUpDh82MJR13GqqALRSmx+mcMgJVeyYnxWQYOukzBaAdODkQYGbEL2dvdfNZp4KTRusBvMY1QDuOHLHrNnjj+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148023; c=relaxed/simple;
	bh=HXLpUt3u08PbLaYHcXEZO2EchcuhFgTaickGYh+hsNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCUee8sE615NYutI5xD280yN2fxgfY28t0jwmxSLyZKvS45CaLB1fudrDX+3X4ezlfjRaE1L/dEI8F3uZH7pbAuMa5/pCMvRAkoc53s1LYzNxdKheHo8cLfZMXS2eNZEmE+fq6cf0JqzcTfzvo3Pg/rQ0Jx2WIqKUBXm0pzHHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49B0E21B2B;
	Fri, 31 May 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2907813A91;
	Fri, 31 May 2024 09:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2I+7CXSZWWZKHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 31 May 2024 09:33:40 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 31 May 2024 11:33:34 +0200
Subject: [PATCH RFC 3/4] mm, slab: add static key for should_failslab()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-fault-injection-statickeys-v1-3-a513fd0a9614@suse.cz>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
In-Reply-To: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
To: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
 David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.13.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 49B0E21B2B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

Since commit 4f6923fbb352 ("mm: make should_failslab always available for
fault injection") should_failslab() is unconditionally a noinline
function. This adds visible overhead to the slab allocation hotpath,
even if the function is empty. With CONFIG_FAILSLAB=y there's additional
overhead when the functionality is not enabled by a boot parameter or
debugfs.

The overhead can be eliminated with a static key around the callsite.
Fault injection and error injection frameworks can now be told that the
this function has a static key associated, and are able to enable and
disable it accordingly.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/failslab.c |  2 +-
 mm/slab.h     |  3 +++
 mm/slub.c     | 10 +++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/failslab.c b/mm/failslab.c
index ffc420c0e767..878fd08e5dac 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -9,7 +9,7 @@ static struct {
 	bool ignore_gfp_reclaim;
 	bool cache_filter;
 } failslab = {
-	.attr = FAULT_ATTR_INITIALIZER,
+	.attr = FAULT_ATTR_INITIALIZER_KEY(&should_failslab_active.key),
 	.ignore_gfp_reclaim = true,
 	.cache_filter = false,
 };
diff --git a/mm/slab.h b/mm/slab.h
index 5f8f47c5bee0..792e19cb37b8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -11,6 +11,7 @@
 #include <linux/memcontrol.h>
 #include <linux/kfence.h>
 #include <linux/kasan.h>
+#include <linux/jump_label.h>
 
 /*
  * Internal slab definitions
@@ -160,6 +161,8 @@ static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)
  */
 #define slab_page(s) folio_page(slab_folio(s), 0)
 
+DECLARE_STATIC_KEY_FALSE(should_failslab_active);
+
 /*
  * If network-based swap is enabled, sl*b must keep track of whether pages
  * were allocated from pfmemalloc reserves.
diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..3bb579760a37 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3874,13 +3874,15 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 			0, sizeof(void *));
 }
 
+DEFINE_STATIC_KEY_FALSE(should_failslab_active);
+
 noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 {
 	if (__should_failslab(s, gfpflags))
 		return -ENOMEM;
 	return 0;
 }
-ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
+ALLOW_ERROR_INJECTION_KEY(should_failslab, ERRNO, &should_failslab_active);
 
 static __fastpath_inline
 struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
@@ -3889,8 +3891,10 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 
 	might_alloc(flags);
 
-	if (unlikely(should_failslab(s, flags)))
-		return NULL;
+	if (static_branch_unlikely(&should_failslab_active)) {
+		if (should_failslab(s, flags))
+			return NULL;
+	}
 
 	return s;
 }

-- 
2.45.1


