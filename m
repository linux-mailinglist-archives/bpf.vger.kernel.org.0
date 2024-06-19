Return-Path: <bpf+bounces-32545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6990F968
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA261C21E83
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC515E5C6;
	Wed, 19 Jun 2024 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OctDuuKS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j+2cW9Bf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="njbQ6Amv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6ttRn13"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2682869;
	Wed, 19 Jun 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837388; cv=none; b=sQKXDHwXPenm44P4dDnFh2cEdv4KKeqCqpb/nJMU0Emry70Ca/JQE57wTHuzRTc9j67T5ClQwCZRgA+odVC4UN55R6L12O3DmQBXcqSgr4AFz7AlC0Ufhdymmy8SNY+v/AmYfc/oXP7RAEhBZyBg2I3sYf9oan92W6YVxna0Gm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837388; c=relaxed/simple;
	bh=ldvIP2V3S2F517OMbSSDg7KW3uQS+0XOj9fkVOyN4sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3cRLwL36IVZK3GrsZdYnydwi/CiAdfsmOKxtQs+t1DUsFYRcHaH8Q/jWPn9N8YiTXPbVW1bUomHGqRTf++j/pYJlGlcjs0XSFw6Br6SETcoBCNZrnzAUvLQUhMQeLYCDZ/XiHC6LTiMhCRBTpalSN326G8pWZmZDAo8gWuSvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OctDuuKS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j+2cW9Bf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=njbQ6Amv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W6ttRn13; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6C7121A61;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKuT+N7+Lb5VqApn1kbaOItiOKwDSbQEIH+cYViP3f4=;
	b=OctDuuKSC4UF+wjKtoVyH0QvGLpF8XAqLyIbYfZfqUqDqbAwL2bcO3E1Pn+AnZ3eyibQfJ
	6tYt02lob+xX6VBjZqZpNYNoAFLn6kK0OzL6sjX7j4tN4Djr5FmBiXSud2Nwi+ztUQq/Zn
	90QlsQZrnKA+lNEaCE4uWXQHIrkgSYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKuT+N7+Lb5VqApn1kbaOItiOKwDSbQEIH+cYViP3f4=;
	b=j+2cW9Bfl+vq0dFzwR4Z8VJ/wS4ujClcEsbZnU5mUWOOkqMaN8pzA61v7a4cLcVPI6cou5
	oo7W4FlMxtS0HUCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKuT+N7+Lb5VqApn1kbaOItiOKwDSbQEIH+cYViP3f4=;
	b=njbQ6AmvOqf/I3slNL642nz7dBav5v8cX1pr5wFiS4LsJeEcIXUKP4JeIGDMoYpMT1ZHst
	BoNAr/7ULUHsi0/LTIHKAQvyJs2XwZsVIxHGH1g8+c1W4/i2GGHXiON2JJcEy7S/UNuL8L
	xJNvP++tshk5rMe3z2U9GcJdCDP19Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IKuT+N7+Lb5VqApn1kbaOItiOKwDSbQEIH+cYViP3f4=;
	b=W6ttRn13nlD24fhIhJolQ8tSxHCj36d2kgYmU/rAvTHIozAnRoU5Z5qBqx+Xe4FxOmedZz
	1dd53nZh0GPG6TCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972F913AAA;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eNSiJIdgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 20 Jun 2024 00:49:00 +0200
Subject: [PATCH v2 6/7] mm, slab: add static key for should_failslab()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-fault-injection-statickeys-v2-6-e23947d3d84b@suse.cz>
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
In-Reply-To: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz>
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
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5370; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=ldvIP2V3S2F517OMbSSDg7KW3uQS+0XOj9fkVOyN4sA=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2CAyioCEBExL2f8WncWFmFMWNZmaTFD1Cae+
 fsvxwAVOTSJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNggAAKCRC74LB10kWI
 moEGB/9t+BV2+IAq6SNJND2pIHnMkyYyiUiRMgkXxQEQLNZbKEmMr1y1PoT7g7IbtFutozCfC6P
 bWrARbt2jfDNJOj/yOgVfB0zY6h9vQlmoqe8jjatje4Lt3s25DwGW6BgQl8PwkCPUNdQLfBevS/
 AYIXYRcHbUOYW/qvyFYFXpUaCDhSmv0MLe1twno9XP42wpIZW1tw1gBuz+4UY284502W7uAXa2g
 cySWbAiKUS9owip7X8JnR7HvnnWXngktOPjsSzDdpuHPNzMa+FjgMBXyHemCi0nrD5+CCZyLUBo
 WPwX6uGMzVlf+cD+P/EYDIixpxBcEuaOvo6PBJfQfQxFxkWP
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,google.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,arm.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RL5nkphuxq5kxo98ppmuqoc8wo)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.dev:email]

Since commit 4f6923fbb352 ("mm: make should_failslab always available for
fault injection") should_failslab() is unconditionally a noinline
function. This adds visible overhead to the slab allocation hotpath,
even if the function is empty. With CONFIG_FAILSLAB=y there's additional
overhead, even when the functionality is not activated by a boot
parameter or via debugfs.

The overhead can be eliminated with a static key around the callsite.
Fault injection and error injection frameworks including bpf can now be
told that this function has a static key associated, and are able to
enable and disable it accordingly.

Additionally, compile out all relevant code if neither CONFIG_FAILSLAB
nor CONFIG_FUNCTION_ERROR_INJECTION is enabled. When only the latter is
not enabled, make should_failslab() static inline instead of noinline.

To demonstrate the reduced overhead of calling an empty
should_failslab() function, a kernel build with
CONFIG_FUNCTION_ERROR_INJECTION enabled but CONFIG_FAILSLAB disabled,
and CPU mitigations enabled, was used in a qemu-kvm (virtme-ng) on AMD
Ryzen 7 2700 machine, and execution of a program trying to open() a
non-existent file was measured 3 times:

    for (int i = 0; i < 10000000; i++) {
        open("non_existent", O_RDONLY);
    }

After this patch, the measured real time was 4.3% smaller. Using perf
profiling it was verified that should_failslab was gone from the
profile.

With CONFIG_FAILSLAB also enabled, the patched kernel performace was
unaffected, as expected, while unpatched kernel's performance was worse,
resulting in the relative speedup being 10.5%. This means it no longer
needs to be an option suitable only for debug kernel builds.

Acked-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/fault-inject.h |  4 +++-
 mm/failslab.c                |  2 +-
 mm/slab.h                    |  3 +++
 mm/slub.c                    | 30 +++++++++++++++++++++++++++---
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index cfe75cc1bac4..0d0fa94dc1c8 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -107,9 +107,11 @@ static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 }
 #endif /* CONFIG_FAIL_PAGE_ALLOC */
 
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
 int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
+#endif
 #ifdef CONFIG_FAILSLAB
-extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
+bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #else
 static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 {
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
index 0809760cf789..11980aa94631 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3874,13 +3874,37 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 			0, sizeof(void *));
 }
 
-noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
+#if defined(CONFIG_FUNCTION_ERROR_INJECTION) || defined(CONFIG_FAILSLAB)
+DEFINE_STATIC_KEY_FALSE(should_failslab_active);
+
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
+noinline
+#else
+static inline
+#endif
+int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 {
 	if (__should_failslab(s, gfpflags))
 		return -ENOMEM;
 	return 0;
 }
-ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
+ALLOW_ERROR_INJECTION_KEY(should_failslab, ERRNO, &should_failslab_active);
+
+static __always_inline int should_failslab_wrapped(struct kmem_cache *s,
+						   gfp_t gfp)
+{
+	if (static_branch_unlikely(&should_failslab_active))
+		return should_failslab(s, gfp);
+	else
+		return 0;
+}
+#else
+static __always_inline int should_failslab_wrapped(struct kmem_cache *s,
+						   gfp_t gfp)
+{
+	return false;
+}
+#endif
 
 static __fastpath_inline
 struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
@@ -3889,7 +3913,7 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 
 	might_alloc(flags);
 
-	if (unlikely(should_failslab(s, flags)))
+	if (should_failslab_wrapped(s, flags))
 		return NULL;
 
 	return s;

-- 
2.45.2


