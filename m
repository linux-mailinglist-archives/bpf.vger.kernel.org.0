Return-Path: <bpf+bounces-34580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E192ECD5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 18:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265CE1C21AD5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA716D334;
	Thu, 11 Jul 2024 16:35:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A216B752;
	Thu, 11 Jul 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715751; cv=none; b=GpggJUhlv9t5PzKyrcopAz6LQC7jVewuhvgHgCZbi5eUGU1gP7uDhJqLTOrqYWlc6SRMHrsXjQXaB+8WrAs4nAJPNhj1tpr0r9WbZo5eT+F+zZsOgutfFigIbU9v8GSdBb9DauB7XZxc/fd/8aXl69kjiu3QU8bi29BiEvv1r/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715751; c=relaxed/simple;
	bh=zbEHVRkDsvgXvgy7ePG+HZP/L/SCK/mB/uExSVUIwQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhOn9ibjwUyGgxIYgSF7rETCiiL8Qbc1L1flav3IAXZnrvCazPnF/Pi0+XHI2GaMdS20FQ/MXF4s4wee/miIdSnB1TrE/2bcAoR1EdRmEuAcIWA3Nw0k3sWY/ZFqtRhyvnwY/41MMUtcWMbXfY1lk8JEXjmGa6vFPKALd6naYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B66EA21BDB;
	Thu, 11 Jul 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86C80139E7;
	Thu, 11 Jul 2024 16:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ID2lIOMJkGa0NwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Jul 2024 16:35:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Jul 2024 18:35:30 +0200
Subject: [PATCH 1/2] mm, slab: put should_failslab() back behind
 CONFIG_SHOULD_FAILSLAB
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-fault-injection-reverts-v1-1-9e2651945d68@suse.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4644; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=zbEHVRkDsvgXvgy7ePG+HZP/L/SCK/mB/uExSVUIwQ4=;
 b=owEBbQGS/pANAwAIAbvgsHXSRYiaAcsmYgBmkAne2MB78FAzF9cge2o8lX8PRgTFUuIDeWIGI
 vdS6xc0p1CJATMEAAEIAB0WIQR7u8hBFZkjSJZITfG74LB10kWImgUCZpAJ3gAKCRC74LB10kWI
 mpD+CACkvSZCKzbtwIQGbMaxAGE6arvHPzZDGEKnPm90OsjQ/svV+W/kmwFLbyfc9FYzxoK7Q3+
 XeRX2uxBj6CFYm2iYuBMkUlG9xYT/UHDhBfzRXSF503fcD0Px26q9Nt9FlPJu9/5MtWy3kQpTZr
 6yO3l/UZ0qWsLBv56Mwncrimgdlg+heHDFAVYpK5OCkwWwoUMyn/7Xd+JdZWBRTnqL2xRTcpGM+
 sE/rGJwqp/2ZX1qRjeW/brP+D7fFM/dAmT+hQ8WBkvOF3mLabth3TiaI/mDt/nn5scYFegTcj1+
 ZwtvW3N3vnLh8kRVJ2NmmQMdl6Lf1XhMqrKOt4CvjLYnWfwt
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: B66EA21BDB
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Level: 

This mostly reverts commit 4f6923fbb352 ("mm: make should_failslab
always available for fault injection"). The commit made
should_failslab() a noinline function that's always called from the slab
allocation hotpath, even if it's empty because CONFIG_SHOULD_FAILSLAB is
not enabled, and there is no option to disable that call. This is
visible in profiles and the function call overhead can be noticeable
especially with cpu mitigations.

Meanwhile the bpftrace program example in the commit silently does not
work without CONFIG_SHOULD_FAILSLAB anyway with a recent gcc, because
the empty function gets a .constprop clone that is actually being called
(uselessly) from the slab hotpath, while the error injection is hooked
to the original function that's not being called at all [1].

Thus put the whole should_failslab() function back behind
CONFIG_SHOULD_FAILSLAB. It's not a complete revert of 4f6923fbb352 - the
int return type that returns -ENOMEM on failure is preserved, as well
ALLOW_ERROR_INJECTION annotation. The BTF_ID() record that was meanwhile
added is also guarded by CONFIG_SHOULD_FAILSLAB.

[1] https://github.com/bpftrace/bpftrace/issues/3258

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/fault-inject.h |  5 ++---
 kernel/bpf/verifier.c        |  2 ++
 mm/failslab.c                | 14 ++++++++------
 mm/slub.c                    |  8 --------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 6d5edef09d45..be6d0bc111ad 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -102,11 +102,10 @@ static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 }
 #endif /* CONFIG_FAIL_PAGE_ALLOC */
 
-int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #ifdef CONFIG_FAILSLAB
-extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
+int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #else
-static inline bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
+static inline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 {
 	return false;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 214a9fa8c6fb..e455654f3b91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21123,7 +21123,9 @@ BTF_SET_START(btf_non_sleepable_error_inject)
  */
 BTF_ID(func, __filemap_add_folio)
 BTF_ID(func, should_fail_alloc_page)
+#ifdef CONFIG_FAILSLAB
 BTF_ID(func, should_failslab)
+#endif
 BTF_SET_END(btf_non_sleepable_error_inject)
 
 static int check_non_sleepable_error_inject(u32 btf_id)
diff --git a/mm/failslab.c b/mm/failslab.c
index ffc420c0e767..af16c2ed578f 100644
--- a/mm/failslab.c
+++ b/mm/failslab.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fault-inject.h>
+#include <linux/error-injection.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include "slab.h"
@@ -14,23 +15,23 @@ static struct {
 	.cache_filter = false,
 };
 
-bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
+int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 {
 	int flags = 0;
 
 	/* No fault-injection for bootstrap cache */
 	if (unlikely(s == kmem_cache))
-		return false;
+		return 0;
 
 	if (gfpflags & __GFP_NOFAIL)
-		return false;
+		return 0;
 
 	if (failslab.ignore_gfp_reclaim &&
 			(gfpflags & __GFP_DIRECT_RECLAIM))
-		return false;
+		return 0;
 
 	if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
-		return false;
+		return 0;
 
 	/*
 	 * In some cases, it expects to specify __GFP_NOWARN
@@ -41,8 +42,9 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 	if (gfpflags & __GFP_NOWARN)
 		flags |= FAULT_NOWARN;
 
-	return should_fail_ex(&failslab.attr, s->object_size, flags);
+	return should_fail_ex(&failslab.attr, s->object_size, flags) ? -ENOMEM : 0;
 }
+ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
 
 static int __init setup_failslab(char *str)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 4927edec6a8c..2e7c7289de91 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3875,14 +3875,6 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 			0, sizeof(void *));
 }
 
-noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
-{
-	if (__should_failslab(s, gfpflags))
-		return -ENOMEM;
-	return 0;
-}
-ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
-
 static __fastpath_inline
 struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s, gfp_t flags)
 {

-- 
2.45.2


