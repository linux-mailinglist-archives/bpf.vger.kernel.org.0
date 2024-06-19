Return-Path: <bpf+bounces-32546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A563990F969
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 00:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B5E1C21315
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8F15ECFC;
	Wed, 19 Jun 2024 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oBxQ6Ia7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hkjarJfU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TynXPAks";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L985X4si"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD88286D;
	Wed, 19 Jun 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837388; cv=none; b=j4It1QX0ql8bzH3VdP2tqtTD1dNPOt8xp7OklR8fK4jtUftSysLkGMLIeMQl2AH9CYxjUYkDWFUeBTK54mbq3oc0PTONpeqXbu0QPdu6aQ9RQ9DCZ8dLWW6nhuNhCgvI99VFwbzfu8WnbUw5OTMo6Z6R/7PjFQlGqlOtUHx4MRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837388; c=relaxed/simple;
	bh=lrkvm9m+5V6rPH6PUfaXjT75wU3B7FL1fWu0EmMg4jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UB0ehRKwEkG7Q0IofgjgtfhbwqBIOG0hm+TWygaA5xRSBLtoUFrhkt1WdAwOps/1cffDjgnQHkxfE0eZsZHI4oT1HO/b9SPB1EUG7lihKrnTd0K297QU8VUlskx8F/hhqJd5b7oVpglc0RDiMQln0bu/qe88/4oP0S1aj/LpUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oBxQ6Ia7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hkjarJfU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TynXPAks; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L985X4si; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D50FF21A6D;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=En1fgwGBp3akxqcTlyA7z2SXZocSGyKqoIqkTPWBt38=;
	b=oBxQ6Ia700L8P7MHC2ZSj7lYOClW/b+nn74PtnoV77STyNfZuJ3s/3FxFvQ5ON/6/R+4CE
	h1v2V61d1EUmbIDPC9LkVI94UA1fx7FZyzcOsTllmIb3LpdGX+e/CqM1Qq4PPQSvsp62af
	TuKzhlqNZ2MZIuhtI7+mCA6VvjGjO2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=En1fgwGBp3akxqcTlyA7z2SXZocSGyKqoIqkTPWBt38=;
	b=hkjarJfUCCuhuk1r1+VTczH1jn0SrePROWGO6/JuDQUTIuFa3Kwopbx0FvR7OLsgc+7hff
	PXUElSpJDIwp0hBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718837383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=En1fgwGBp3akxqcTlyA7z2SXZocSGyKqoIqkTPWBt38=;
	b=TynXPAkshMLovoWJEyMGcwthd+0VNECCmYJf+upAlVaI4TBVa+V6WzmLxCDjoVKizHIo8z
	beBAnPxk8Tok4UFc8dN+SfSIuFPzGJKktIyQ5FT2rmT7UliqCKiboQSnua+P+muJ5d4aOd
	fgXUBfIUGrD6WUh4tQSVTqKwK0xvg9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718837383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=En1fgwGBp3akxqcTlyA7z2SXZocSGyKqoIqkTPWBt38=;
	b=L985X4siXKopQT7WhbmtjCdC4M0g8YD/5UflTdx8IHiUaLXCG9QyIeO73rbief4APg1G1f
	rLISpErk9/ETi2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4FCC13ABD;
	Wed, 19 Jun 2024 22:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +GboK4dgc2aFIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 19 Jun 2024 22:49:43 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 20 Jun 2024 00:49:01 +0200
Subject: [PATCH v2 7/7] mm, page_alloc: add static key for
 should_fail_alloc_page()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-fault-injection-statickeys-v2-7-e23947d3d84b@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4477; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=lrkvm9m+5V6rPH6PUfaXjT75wU3B7FL1fWu0EmMg4jI=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmc2CDq4C5vfd3OGsJTJXwWPnIR++a/CyqxA3pF
 yu5aRhqYhCJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZnNggwAKCRC74LB10kWI
 mtY9B/9F48jU4mg4DvmDG0e36QW+ooxwNCrSVM1MXSjv46DlcqK9YtApZrvOymhCnd03BmprQnE
 cTZiAw/ZIIuNLlW8D09hcNpB/oGulWuhpMehEB0iTP3UfItTOMOU1N30LODDF/abWn0v2qzp6LD
 ZtThwT/w0IM8z8/K4/oMDfoZinMXGXnFPV+b4fBbs/27R3btbUs9N3VZFkDLvC7eXmK3vAl0Bzw
 updjoZ7nNW0dqQnrOjDOl1T/DzDGQYdzGRoD3k7b3RnW8x25qFRY/ZejhS3tKEntPDl8Cg3C89i
 t0Jo4FimVrnSavpJWzGth87QCgsmpfVPo2Almyo5yxTbQ8Ee
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,linux.com,google.com,kernel.org,iogearbox.net,linux.ibm.com,intel.com,davemloft.net,goodmis.org,arm.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org,kvack.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RL5nkphuxq5kxo98ppmuqoc8wo)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

Similarly to should_failslab(), remove the overhead of calling the
noinline function should_fail_alloc_page() with a static key that guards
the callsite in the page allocator hotpath, and is controlled by the
fault and error injection frameworks and bpf.

Additionally, compile out all relevant code if neither
CONFIG_FAIL_ALLOC_PAGE nor CONFIG_FUNCTION_ERROR_INJECTION is enabled.
When only the latter is not enabled, make should_fail_alloc_page()
static inline instead of noinline.

No measurement was done other than verifying the should_fail_alloc_page
is gone from the perf profile. A measurement with the analogical change
for should_failslab() suggests that for a page allocator intensive
workload there might be noticeable improvement. It also makes
CONFIG_FAIL_ALLOC_PAGE an option suitable not only for debug kernels.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/fault-inject.h |  3 ++-
 mm/fail_page_alloc.c         |  3 ++-
 mm/internal.h                |  2 ++
 mm/page_alloc.c              | 30 +++++++++++++++++++++++++++---
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 0d0fa94dc1c8..1a782042ae80 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -96,8 +96,9 @@ static inline void fault_config_init(struct fault_config *config,
 
 struct kmem_cache;
 
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
 bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
-
+#endif
 #ifdef CONFIG_FAIL_PAGE_ALLOC
 bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
 #else
diff --git a/mm/fail_page_alloc.c b/mm/fail_page_alloc.c
index b1b09cce9394..0906b76d78e8 100644
--- a/mm/fail_page_alloc.c
+++ b/mm/fail_page_alloc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fault-inject.h>
 #include <linux/mm.h>
+#include "internal.h"
 
 static struct {
 	struct fault_attr attr;
@@ -9,7 +10,7 @@ static struct {
 	bool ignore_gfp_reclaim;
 	u32 min_order;
 } fail_page_alloc = {
-	.attr = FAULT_ATTR_INITIALIZER,
+	.attr = FAULT_ATTR_INITIALIZER_KEY(&should_fail_alloc_page_active.key),
 	.ignore_gfp_reclaim = true,
 	.ignore_gfp_highmem = true,
 	.min_order = 1,
diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..8539e39b02e6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -410,6 +410,8 @@ extern char * const zone_names[MAX_NR_ZONES];
 /* perform sanity checks on struct pages being allocated or freed */
 DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
+DECLARE_STATIC_KEY_FALSE(should_fail_alloc_page_active);
+
 extern int min_free_kbytes;
 
 void setup_per_zone_wmarks(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e22ce5675ca..b6e246acb4aa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3008,11 +3008,35 @@ struct page *rmqueue(struct zone *preferred_zone,
 	return page;
 }
 
-noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+#if defined(CONFIG_FUNCTION_ERROR_INJECTION) || defined(CONFIG_FAIL_PAGE_ALLOC)
+DEFINE_STATIC_KEY_FALSE(should_fail_alloc_page_active);
+
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
+noinline
+#else
+static inline
+#endif
+bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return __should_fail_alloc_page(gfp_mask, order);
 }
-ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
+ALLOW_ERROR_INJECTION_KEY(should_fail_alloc_page, TRUE, &should_fail_alloc_page_active);
+
+static __always_inline bool
+should_fail_alloc_page_wrapped(gfp_t gfp_mask, unsigned int order)
+{
+	if (static_branch_unlikely(&should_fail_alloc_page_active))
+		return should_fail_alloc_page(gfp_mask, order);
+
+	return false;
+}
+#else
+static __always_inline bool
+should_fail_alloc_page_wrapped(gfp_t gfp_mask, unsigned int order)
+{
+	return false;
+}
+#endif
 
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
@@ -4430,7 +4454,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	might_alloc(gfp_mask);
 
-	if (should_fail_alloc_page(gfp_mask, order))
+	if (should_fail_alloc_page_wrapped(gfp_mask, order))
 		return false;
 
 	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);

-- 
2.45.2


