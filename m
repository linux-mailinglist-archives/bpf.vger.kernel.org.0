Return-Path: <bpf+bounces-50655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806CA2A689
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B353A895C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2D232376;
	Thu,  6 Feb 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3TygDOt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D59231A54;
	Thu,  6 Feb 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839309; cv=none; b=BJ2YSCkjTYimbZM82Kw6kQx32KwAwggMFTqbRIpyoLe2QsemGZtLdaF6oDl5UlIYIIimHbKNhFbAKZRjUFpp8I/4mvc4dvQ/C9bv2QDI+U4BEAspKRhSPJLP8sMDQyxZnPaeJainzxcPVTOCcIlXB3POxQseF7EPg8SArpUckVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839309; c=relaxed/simple;
	bh=7psEOc+yd4qPNsI4KRxI79thdXuYqSsZXOHrdwDSR0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWYlkXFN8nLAJdeWGMoybQX38Sz+AM1r5H0pzHPgyph6xZncZGtuoXKJcviwMZ62SxbpBlDBUd2TkvhbID9DNZoKU8isLrArHcHbzYtXZ4F5sriBB8RiY9hqyOlyNFjQ9iIqoS6P1C9NAw92SHERHzukOcVhSIedwZLSkLpPNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3TygDOt; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38db0c06e96so491207f8f.2;
        Thu, 06 Feb 2025 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839306; x=1739444106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNqgh98W4funKculi1nvK5lPwgfxfi44KHpp2hUPVk4=;
        b=P3TygDOtWfUL8j5tsxvtl7s58UFN6Pjol6oGkHwCYFdx0S357gmVQCsm0P2T4pyxrD
         5R5wa6PueMNQ/gTZWqwp1P/gXF4Fy9yqzDcshWLhLJyjB5Qj2D2tiJQGu2TOURwOcmIP
         FaKEtIIq7NYVl5MLlLnnzRskR9Ov/0qjEWHmJ8HTjUW6yArP5s05hNlwqqC/kMCzVB+Z
         o3raM75FjZeCt8E9YdxM/oB3OjHrqM0sKLDtsn2ErhzrxyV8DLRK8PhESP6rM5Tkz3Dy
         0RgwtMm/O8lOomwGTw9aP2TSLVRspPZmsB+gde95ZfumbxVQs+ZeyYZ6sNP+Rgtf//m2
         YaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839306; x=1739444106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNqgh98W4funKculi1nvK5lPwgfxfi44KHpp2hUPVk4=;
        b=IZ0MSTiDfITcqBaQqSXn0srgVCxwcpGHFy7Q0ja0nzkcJ1efX4zJgGNehUVTRo9bKY
         FKujO4+5Me/yUKpB5ynfSjWBYLNMuPhwRObWhZosE1aPf2I0nOkyKWMDVb+sI2HAzDHg
         G9CFpHp3X4h6DXw6zaPTP/gPTSRiJ3WV75LfuvimdzcPEr67hFwn24A0+RO4SbCR4DU7
         Ruvn7EEjV2KeT3ZcAAsn4rfBybGb5tsFHtzQ7EzQhy3sAfPrgtLIIjOeXBcTnSNkC/7i
         5hzIdeIWg4jCl0p/fNCZdTYx5eC4Lgco6CutAAkm47TWrzZIRjpJm4g8Z69GmWcgpkTB
         SnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvVuEw3qLWR9FMHLEwXDECrVHIBcsn3JaL4LI4PJifRD6KR9WvgTenJixPttXc7FGt+Kez0DwescRrsSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nH0MJAkQ+lH6efWgyX3pJdztXY5Mi6ggm7X0McRLsSXS2+ou
	k9rDuebjz03sSGAROCnV9XRWP4yJChhlS541GtJ2dp9GzXFvz3FRWExeMNjjBK0=
X-Gm-Gg: ASbGncuwylITTc23oQ5zcxR/FYLu2K89kraO9U4hHXCj5TDfD0HKsz2pJaOx3JkO8Fu
	8gZfFb6Oq6x1GnRfaeeSPYXJdYXpwJ7WIaoXncenvLFVH3PJJ+5aDbE/g25UjDJaNXtDLxBnK16
	GXn2s+S5Q3/SSAqC+MgQIyWjH1oYvHXq43nnGzb5VtoiFjZPZ3Rkzdsx4cTmnY43NtQ4tbiJI6l
	VuD+EFUov5GaDT1C4jwMmsNws7xbNnDLvDvn3Nd3omjVQhzXDPlt92QtVzEaVmwqsM+IcZ6jgOY
	Zbv20w==
X-Google-Smtp-Source: AGHT+IGl6SmZaMuRp7oUK50tAaXGFTAXDbbBuYWF+LV4jkLjehRBR+yIALlWuxWr7fqUlT9fVpNuwQ==
X-Received: by 2002:a05:6000:154a:b0:38d:b125:3783 with SMTP id ffacd0b85a97d-38db4869738mr5279252f8f.18.1738839305846;
        Thu, 06 Feb 2025 02:55:05 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d96530fsm50029725e9.19.2025.02.06.02.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:05 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 21/26] bpf: Convert lpm_trie.c to rqspinlock
Date: Thu,  6 Feb 2025 02:54:29 -0800
Message-ID: <20250206105435.2159977-22-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3797; h=from:subject; bh=7psEOc+yd4qPNsI4KRxI79thdXuYqSsZXOHrdwDSR0g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRnw6DiRxO330wCUMflYYf1S6rgXtusJs7sBci+ PMosJk6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZwAKCRBM4MiGSL8Rypr6D/ 0XU5AM+X7xrBbdXvcrdW6JR+XH2p7xDA8af4vJJme6W9rY9nqzM+aeJbS2fsqkaBOjvGhsrm6KSEvU h5nXKuyn5/iiNQyeA2eBNyNmynnhzv6V3d0A7NJwIL2gaLY06/KM6un/G5Zg7met6nyIaESxte16Zt Tj5PkEGuw2YWZIcBVnQHV1DCr9Cc2YERSgY31ol47Dox5OeIfV2Y+ur+/UmtHmdvZ5+g/plLlYxItA 3Mzw1TkFtwsYfMPR4b35Lo1IhYbORKAi5irpZ7F2x9vPeQ2b3wSFo+UjysbmMLgCp4k+cpHnPU+p16 ETzQsMxtY4lYN51QY3p+/yat8sRLixm842KUr+YDb385pgKtUe5qoiH+F47vXvN87HX4t1ptQ2/H7R gu1PEJN4dsT8I3PQzCGdlQoj17l0rZMaNn3acsxv41JTaPrIZgwx7fpOoB8x903xvDrzFJXqGVrwsG ibywFOJqfclF2qvVUO3ygHfXLFXMLus0EHad+VZzDPc0+wy53OQPcURCkt5UiaTENbTuGscfNR9GHT PtQksRTWgfDQgzrDx4EEkFvZ8uKGPHwtH3SAxFXLdTMysqVjm14CT2if0p9yCYswzH/yX3dA7ImI7q xLGCvaXy82YcKX7auIkK8zCMUWSP5gJB30nAtkG1jSBLXHv9M0FKHlbziHLA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert all LPM trie usage of raw_spinlock to rqspinlock.

Note that rcu_dereference_protected in trie_delete_elem is switched over
to plain rcu_dereference, the RCU read lock should be held from BPF
program side or eBPF syscall path, and the trie->lock is just acquired
before the dereference. It is not clear the reason the protected variant
was used from the commit history, but the above reasoning makes sense so
switch over.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/lpm_trie.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index e8a772e64324..be66d7e520e0 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -15,6 +15,7 @@
 #include <net/ipv6.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
+#include <asm/rqspinlock.h>
 #include <linux/bpf_mem_alloc.h>
 
 /* Intermediate node */
@@ -36,7 +37,7 @@ struct lpm_trie {
 	size_t				n_entries;
 	size_t				max_prefixlen;
 	size_t				data_size;
-	raw_spinlock_t			lock;
+	rqspinlock_t			lock;
 };
 
 /* This trie implements a longest prefix match algorithm that can be used to
@@ -342,7 +343,9 @@ static long trie_update_elem(struct bpf_map *map,
 	if (!new_node)
 		return -ENOMEM;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	ret = raw_res_spin_lock_irqsave(&trie->lock, irq_flags);
+	if (ret)
+		goto out_free;
 
 	new_node->prefixlen = key->prefixlen;
 	RCU_INIT_POINTER(new_node->child[0], NULL);
@@ -356,8 +359,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*slot))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -442,8 +444,8 @@ static long trie_update_elem(struct bpf_map *map,
 	rcu_assign_pointer(*slot, im_node);
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
-
+	raw_res_spin_unlock_irqrestore(&trie->lock, irq_flags);
+out_free:
 	if (ret)
 		bpf_mem_cache_free(&trie->ma, new_node);
 	bpf_mem_cache_free_rcu(&trie->ma, free_node);
@@ -467,7 +469,9 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	ret = raw_res_spin_lock_irqsave(&trie->lock, irq_flags);
+	if (ret)
+		return ret;
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
@@ -478,8 +482,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference_protected(
-		       *trim, lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*trim))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -543,7 +546,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	free_node = node;
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
+	raw_res_spin_unlock_irqrestore(&trie->lock, irq_flags);
 
 	bpf_mem_cache_free_rcu(&trie->ma, free_parent);
 	bpf_mem_cache_free_rcu(&trie->ma, free_node);
@@ -592,7 +595,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
-	raw_spin_lock_init(&trie->lock);
+	raw_res_spin_lock_init(&trie->lock);
 
 	/* Allocate intermediate and leaf nodes from the same allocator */
 	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
-- 
2.43.5


