Return-Path: <bpf+bounces-54136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273E5A633A7
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BD3A68BC
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605921A3A8D;
	Sun, 16 Mar 2025 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAiQjva1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF01152196;
	Sun, 16 Mar 2025 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097973; cv=none; b=YndlOTeO83hhdf8OqqjtGHC52WlAL7B4CnqsHkNe4N3n9hWzRAjf0lqaLDIJTr9hBEqIsu/EShd10OG5vty6VdiVj8eAWVymaGIBrluPm1hqUpBPYHCfwCfmDe6z+1rtidh5UB5CdMl2z25ww2nLFJOk+MhJilnz3dD3grPneKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097973; c=relaxed/simple;
	bh=JAC4N7kXKK3pnjvfn/+uPUJ4VSIRwkWi681l7P20D6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4d/EqYrSFynQ83TzwohbsW4Ret6YkLluBTUu4hTiiP6gvAsq86rKvObW/kkx6gUCTI6gOSytPH+CF8lUGnqhpViQ+YEohw1BJizpFkEf337pI//xWXR7aTzniJu01vVvZaALLbrnPXLZadpCqMk/sv7zPpWKihOL3UD3Lk0qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAiQjva1; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39127512371so2030582f8f.0;
        Sat, 15 Mar 2025 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097970; x=1742702770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm/TjLVsOIQb5qeMDxohaetZDngVOOW8hl6xb9zJkyk=;
        b=KAiQjva1Q73G11teLexaRECthUojBwqOfHqC9XJ2pJOCJkqA+m8OGPCQtffaYyFV1W
         9MT1ApUHsgE4NfS4zZPzJkdznDHTscfG7zkF8KlkGFSC28E/ad8a1WLyOCgdvgGrlZvy
         dt5eVyGLBrPcHS+eTbNLRbLrjoBuCKsvP3eAf29sRrVw+NRteSwEr6j4UBz9eiMxPwGw
         lL758Q1wizhlrPI6vsBDDVmFFZQm491IEVIaOgFercb+JDof4HLngPwGqwxuY6F17U56
         n5wd0epKO8MGLkHV2jW3SrcrTQwznxjQdaISSbnJG/ci2E9f5lAzKN4PVvO+WipyDboR
         DikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097970; x=1742702770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm/TjLVsOIQb5qeMDxohaetZDngVOOW8hl6xb9zJkyk=;
        b=gJcJWGMwQRpcisaHszV3alP6eVTGSU6AfhoCbfkqdOe3ck+x5A4hWF2SmUD+VVCNCo
         nyN5HNfvexcJm8viEm4ItzTChOmJT+wVcHLWxm2E/esKiieuRBW2EzmH4jURrJ47faQP
         qIiERHYBTQ+jI+6Zur8TV8Wb9N7syCtGyhSr47fBkNtsfWNVz9rS3B3cX1RBzBNeJxw4
         8Nq9YNwuaoXa0S1Amk/dpBRtEeqmNgF3XOGXRnivL0s4Rw39lHEp/1sNf0bLilLQLVg9
         rN7CBKex0BPLWXBVuf/c6Qo9nns0/sy675S5B5CAho2CL15xQZQvx9BeWSVDvB57CKPz
         2Asg==
X-Forwarded-Encrypted: i=1; AJvYcCUhuVxccmnklnc6qWKjfS3xeKvulc5xaOznXqRU1GpEH53vxSfwJ6prpdOsCWrvA7bRfVJd0zKVCqL3yfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VSj4fJy0by8/6eRaNWDWFcSg8DABxjKBJ+RiEVTf5jagEio1
	PBeIfNxogz3Aiy7anergV46OSSKl64VhPUFWgE0YPYa2e03AGc0FwKdAyr7epVo=
X-Gm-Gg: ASbGncv0+Woe6RChK+cCFDLDsjkOCTjnKPJVQa9OPFgHi2m/CpsnSjZlAbBcvxSTx1R
	hAsP94CV6g5CJXqd1VhadrESmCniQIf0UEf1VWXo2s4+DbfTJyNZrkJ7S/N6mirG+dwV7gZuNeh
	iDfCfBxSNAGFzMXXu+mPvf7acIh9G+uBl1BLl3xYw6Ye5ZneybpT/KQ1Q4YULGqNVQEFDRNGB7Z
	0o/R9rumQILvJPVoyXdaHvJFS7suZZRIHRe7ReUZ65/fYgpLZ3HzFKfd6D9Rv80VqwSzCNWSYWa
	6tgI++IQag5Pn2AWlIpELChKhZhDAbUHeZQ=
X-Google-Smtp-Source: AGHT+IGURbU24AaTjAxqIKJjqCn2mEjZeMLGKyXVZQ1FJ1WehOwHXfyeGE85aKEnu+FeFGs/jt2rrQ==
X-Received: by 2002:adf:a39b:0:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-3975de869d5mr7109406f8f.41.1742097970041;
        Sat, 15 Mar 2025 21:06:10 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c2690sm10726584f8f.25.2025.03.15.21.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:09 -0700 (PDT)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 21/25] bpf: Convert lpm_trie.c to rqspinlock
Date: Sat, 15 Mar 2025 21:05:37 -0700
Message-ID: <20250316040541.108729-22-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3875; h=from:subject; bh=JAC4N7kXKK3pnjvfn/+uPUJ4VSIRwkWi681l7P20D6I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3ePndVFVpKoLfCEr0LeaQTth201gHenOAJqnlp 4yxo4/+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3gAKCRBM4MiGSL8RyqETD/ wPY/kdxYtWMwPuTaaDUV/B3x37peOYAWOdkQcKpbuywBe0gInjoXHOEs+9kkyNps+nUXY3V1aFV1sh HCKWqCMPO7iBeiB4f45fMwvNewTenIvKf+TNJluOSt/v1CzNEil4pBSqsDlCXmZr8B7JXHb796aCm+ 5WfEq7kYFsgD21IEcJQNF4uTNry5R1ceqOAZvdd4y1NmNljt/7G8QS0IJv3zlu/0+BIunPtpqFbpVP 5z55MtMIE1CGFkAHVq48XJVIB9TfWzMIoyD6LKaRKQbrABVSTvT2LTCRcJkvJFKXpEKGbuYcmjo0pK O1yf/FMseMc11MT7/8ZDm/ezGZao7FjQfCb3U94APSqklR8acBNVZlQeLBwTSY1KIAnQu5C4zjoEme yPoSD0GDwU1vuNhQZvVvL5JSlqw6LXR5JgtO2hm1HOvelVuwOon0Mimv8uG/tiH9K7vPJr83ZdKO6X G4BmtnD77NsUAbSGZsNDHKg0c8/kyezVplqtG2Su21wBajRyeNwORZRBpxsxuP6d6oi3H2Fw43nklC +4rCMj1HNzhTA2XLuXrVuqohGykMqtcQZZNUzk4T6xxGMDuQYGV53FMQZWK9zFKZckR/KT1y/gf3zD rVdO2lI+Ki076kbGMvCDeNlQEq7beSPEriiu/ij7C2wMIRHqnyK28WWFR79w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert all LPM trie usage of raw_spinlock to rqspinlock.

Note that rcu_dereference_protected in trie_delete_elem is switched over
to plain rcu_dereference, the RCU read lock should be held from BPF
program side or eBPF syscall path, and the trie->lock is just acquired
before the dereference. It is not clear the reason the protected variant
was used from the commit history, but the above reasoning makes sense so
switch over.

Closes: https://lore.kernel.org/lkml/000000000000adb08b061413919e@google.com
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
2.47.1


