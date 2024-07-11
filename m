Return-Path: <bpf+bounces-34582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4E592ECD9
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335251C213EA
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A39316D4E2;
	Thu, 11 Jul 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1vjIwBql";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6+8AlnT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1vjIwBql";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6+8AlnT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0015EFB8;
	Thu, 11 Jul 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715751; cv=none; b=eAxxn2zktkNlaz/EOGWv3PI/oWD5qSq6fHDrKV3shZEnF6ZvTPEecbrBX5yJ1eKylA+KOVh4DC9R35h8eChX2XWPDqYzEjL1dUd+Uf6VUtGeVlaz4VP8GWbWhp3mqa/2ItmxUVgTJ5KDfocm0maRoLnpeVJKCLH24L4EopE6shc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715751; c=relaxed/simple;
	bh=4AqxrxUC+zfM0+8kA2b6/+AVqXKWW+es4dahXRrWf9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpTC6CGCqfvVP4FOgNg/NuXHW1MRLYHSam0ygPAO1ugzbqCFjbdk0sBM6MTi2kyqQuyLKUerAsyMzYxI2IeNW3Zji53zS5jOH/46PE7lpOWMiF+I7gyHQE4x3rkorOOC3ApdC2TRIerhkYp494FxdqV6FE1zDbq19AR8/k9DViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1vjIwBql; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6+8AlnT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1vjIwBql; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6+8AlnT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDA3C1FB45;
	Thu, 11 Jul 2024 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720715747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/ijafGrQuEAmygURDp1dii/TCJWacbVmiHu5ugO0M=;
	b=1vjIwBqlGi1zXkVB5eD7IxpkGp+lGUlKXzS1EhgL9L5bUX7xPFJ50YnopKvq5nhFA+m9FV
	sIfpuoRVBCqjmCXCeWZSMtwBrihjUWupaq2v397zz8OZ9bl5FMAZIthTlCyTO3DmG5iV0J
	8iKiXQWD+Zm4y9BvYrx1asJMWUvo264=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720715747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/ijafGrQuEAmygURDp1dii/TCJWacbVmiHu5ugO0M=;
	b=e6+8AlnTfXhubvRLZci/XZtXlROwS05vLXKyQh0zw+SiMf76sXetl2mfZ9yTsc7keb6668
	vRrkuEQ6yh2nJ+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720715747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/ijafGrQuEAmygURDp1dii/TCJWacbVmiHu5ugO0M=;
	b=1vjIwBqlGi1zXkVB5eD7IxpkGp+lGUlKXzS1EhgL9L5bUX7xPFJ50YnopKvq5nhFA+m9FV
	sIfpuoRVBCqjmCXCeWZSMtwBrihjUWupaq2v397zz8OZ9bl5FMAZIthTlCyTO3DmG5iV0J
	8iKiXQWD+Zm4y9BvYrx1asJMWUvo264=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720715747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J+/ijafGrQuEAmygURDp1dii/TCJWacbVmiHu5ugO0M=;
	b=e6+8AlnTfXhubvRLZci/XZtXlROwS05vLXKyQh0zw+SiMf76sXetl2mfZ9yTsc7keb6668
	vRrkuEQ6yh2nJ+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A696713A63;
	Thu, 11 Jul 2024 16:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FFeKOMJkGa0NwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Jul 2024 16:35:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Jul 2024 18:35:31 +0200
Subject: [PATCH 2/2] mm, page_alloc: put should_fail_alloc_page() back
 behing CONFIG_FAIL_PAGE_ALLOC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-fault-injection-reverts-v1-2-9e2651945d68@suse.cz>
References: <20240711-b4-fault-injection-reverts-v1-0-9e2651945d68@suse.cz>
In-Reply-To: <20240711-b4-fault-injection-reverts-v1-0-9e2651945d68@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Christoph Lameter <cl@linux.com>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3580; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=4AqxrxUC+zfM0+8kA2b6/+AVqXKWW+es4dahXRrWf9U=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmkAngPeXxGyMkwii0N7B0er/MDHjesPfUH0C4n
 M4O0JQqZxOJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZpAJ4AAKCRC74LB10kWI
 mlNMCACBpN6laStmKCOU85jVrU53kCUjhV4Tx585ZQSz63G/gfS43dJ8ggD9B5v3hDdKWrDtCmW
 q/n8NzPhr7PQMY6Ke66DfHbCiUXslGBJE8ij1AwDLkrISD444GFfvfp5PCAeOQ0GsOmMdsf4vjg
 tQRJcaIPmF43S0R5etsONl9qvK/HfD1SsVZ8LPLIzl96Y0B6BUUAerap+qLTATzqvzYw1S+lGnk
 IA1dgU6v3DaYMg36THyW8dwuReZhA67MDZ3gDlz2SRPY5Qr9ScCc5ADqVoSKkmTSL1tRXGIxm51
 CBhnsQGN83sj8kU2W2ZOTQIftp6fYEz//VkHvDX1D+/br88v
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	REPLY(-4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,linux.com,vger.kernel.org,kvack.org,suse.cz];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

This mostly reverts commit af3b854492f3 ("mm/page_alloc.c: allow error
injection"). The commit made should_fail_alloc_page() a noinline
function that's always called from the page allocation hotpath,
even if it's empty because CONFIG_FAIL_PAGE_ALLOC is not enabled, and
there is no option to disable it and prevent the associated function
call overhead.

As with the preceding patch "mm, slab: put should_failslab back behind
CONFIG_SHOULD_FAILSLAB" and for the same reasons, put the
should_fail_alloc_page() back behind the config option. When enabled,
the ALLOW_ERROR_INJECTION and BTF_ID records are preserved so it's not
a complete revert.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/fault-inject.h | 6 ++----
 kernel/bpf/verifier.c        | 2 ++
 mm/fail_page_alloc.c         | 4 +++-
 mm/page_alloc.c              | 6 ------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index be6d0bc111ad..354413950d34 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -91,12 +91,10 @@ static inline void fault_config_init(struct fault_config *config,
 
 struct kmem_cache;
 
-bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
-
 #ifdef CONFIG_FAIL_PAGE_ALLOC
-bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
+bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
 #else
-static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+static inline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return false;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e455654f3b91..a81e18409ec9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21122,7 +21122,9 @@ BTF_SET_START(btf_non_sleepable_error_inject)
  * Assume non-sleepable from bpf safety point of view.
  */
 BTF_ID(func, __filemap_add_folio)
+#ifdef CONFIG_FAIL_PAGE_ALLOC
 BTF_ID(func, should_fail_alloc_page)
+#endif
 #ifdef CONFIG_FAILSLAB
 BTF_ID(func, should_failslab)
 #endif
diff --git a/mm/fail_page_alloc.c b/mm/fail_page_alloc.c
index b1b09cce9394..532851ce5132 100644
--- a/mm/fail_page_alloc.c
+++ b/mm/fail_page_alloc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fault-inject.h>
+#include <linux/error-injection.h>
 #include <linux/mm.h>
 
 static struct {
@@ -21,7 +22,7 @@ static int __init setup_fail_page_alloc(char *str)
 }
 __setup("fail_page_alloc=", setup_fail_page_alloc);
 
-bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	int flags = 0;
 
@@ -41,6 +42,7 @@ bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 
 	return should_fail_ex(&fail_page_alloc.attr, 1 << order, flags);
 }
+ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..91b7234f1d7e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3031,12 +3031,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 	return page;
 }
 
-noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
-{
-	return __should_fail_alloc_page(gfp_mask, order);
-}
-ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
-
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
 {

-- 
2.45.2


