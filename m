Return-Path: <bpf+bounces-31005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3438D5E5F
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 11:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B41287615
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CE14263B;
	Fri, 31 May 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cq3ZS3Bb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQK9iHyh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cq3ZS3Bb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WQK9iHyh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1E8287F;
	Fri, 31 May 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148025; cv=none; b=VTyRqa/4k3sXQ5mjfJihsB+OTM4Ea+qe7FQg1+4ng/JhH1t6SipwvFjJP6dq5Gq7HBWx3GPZlVWOmBYn3cbXMq4ao/ZCCa2hlFKjTLmUBW3P1tA33UClR29Spk9OQDLDdxFD9zz1tGEYQHeYmJW8kwNVy10s3Gu+YBYNFobpbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148025; c=relaxed/simple;
	bh=WyUHxaHQtVv8tJZ85Q3rEFl1YlXxFbSGzC4RdBJxkTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVF3LFtUeRRs6wDJOBj4bT9BBTfzNn78UpLArnuUQarUbmwRowxWamLcua/CG1maERTq5PsfagBK0p5XOLXP7l3gJ47F+n3tLDSVlb4Wo8MZ2L7Htz3xxZ4zEOUEnbcTxYehKibNCyRUaGBe8VtkyqHlaL3mhn9+BdYl7UHWtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cq3ZS3Bb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQK9iHyh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cq3ZS3Bb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WQK9iHyh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6322421B2C;
	Fri, 31 May 2024 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr3/XI/R4rZyT+/e67qBFKZJGDvaAXhwDIbiD/WM1m0=;
	b=cq3ZS3BbflQ7N2K6lBu8bapgCyqq54EbZLCUHI5AOJr2zGvzJwjgIv1pOlAsS/4VJ+HD//
	DqP8gM6quCsk/Rf4szRlG7kaJ5KOQrpnHm+OrwzFSPVsOugt54MfF1PraU/+2ZdMSbMJUb
	WfFBo7wBG5E4quordFfd4kyyCdsRO1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr3/XI/R4rZyT+/e67qBFKZJGDvaAXhwDIbiD/WM1m0=;
	b=WQK9iHyhgXJjz5UKPeIRCrBHBTFp99Hwb64bZURii7O8xDLTgt/3LGZGt8RkE0fHxqXxKb
	zTsFKRohlCJOaEDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717148020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr3/XI/R4rZyT+/e67qBFKZJGDvaAXhwDIbiD/WM1m0=;
	b=cq3ZS3BbflQ7N2K6lBu8bapgCyqq54EbZLCUHI5AOJr2zGvzJwjgIv1pOlAsS/4VJ+HD//
	DqP8gM6quCsk/Rf4szRlG7kaJ5KOQrpnHm+OrwzFSPVsOugt54MfF1PraU/+2ZdMSbMJUb
	WfFBo7wBG5E4quordFfd4kyyCdsRO1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717148020;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr3/XI/R4rZyT+/e67qBFKZJGDvaAXhwDIbiD/WM1m0=;
	b=WQK9iHyhgXJjz5UKPeIRCrBHBTFp99Hwb64bZURii7O8xDLTgt/3LGZGt8RkE0fHxqXxKb
	zTsFKRohlCJOaEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45159132C2;
	Fri, 31 May 2024 09:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eAqVEHSZWWZKHQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 31 May 2024 09:33:40 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 31 May 2024 11:33:35 +0200
Subject: [PATCH RFC 4/4] mm, page_alloc: add static key for
 should_fail_alloc_page()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-fault-injection-statickeys-v1-4-a513fd0a9614@suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-3.98 / 50.00];
	REPLY(-4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.18)[70.22%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.98
X-Spam-Flag: NO

Similarly to should_failslab(), remove the overhead of calling the
noinline function should_fail_alloc_page() with a static key that guards
the allocation hotpath callsite and is controlled by the fault and error
injection frameworks.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/fail_page_alloc.c |  3 ++-
 mm/internal.h        |  2 ++
 mm/page_alloc.c      | 11 ++++++++---
 3 files changed, 12 insertions(+), 4 deletions(-)

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
index 2e22ce5675ca..e5dc3bafa549 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -274,6 +274,8 @@ int user_min_free_kbytes = -1;
 static int watermark_boost_factor __read_mostly = 15000;
 static int watermark_scale_factor = 10;
 
+DEFINE_STATIC_KEY_FALSE(should_fail_alloc_page_active);
+
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
 EXPORT_SYMBOL(movable_zone);
@@ -3012,7 +3014,7 @@ noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return __should_fail_alloc_page(gfp_mask, order);
 }
-ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
+ALLOW_ERROR_INJECTION_KEY(should_fail_alloc_page, TRUE, &should_fail_alloc_page_active);
 
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
@@ -4430,8 +4432,11 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	might_alloc(gfp_mask);
 
-	if (should_fail_alloc_page(gfp_mask, order))
-		return false;
+	if (static_branch_unlikely(&should_fail_alloc_page_active)) {
+		if (should_fail_alloc_page(gfp_mask, order)) {
+			return false;
+		}
+	}
 
 	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
 

-- 
2.45.1


