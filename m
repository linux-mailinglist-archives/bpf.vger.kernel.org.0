Return-Path: <bpf+bounces-48117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522EA0418A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9A1887769
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC81F542B;
	Tue,  7 Jan 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+3rddgo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA91F3D5E;
	Tue,  7 Jan 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258447; cv=none; b=FEnDxmJGnQAeHHKMFBfH5fg9O4cShJkQb6FZJV0rG5IrupEenw0WL3quWjZg4IQpOKim1hbQ129mosfTmSSsU5lxH0rNjI8vbkfoEEWe1MVfUVyqQorCOi++NncGpVk9TRsZ3uWdz9cGawqjZ3DTqcjS0bZZm2/iTmnNmYFb7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258447; c=relaxed/simple;
	bh=BnUg1f24H681x4s6tZsYG9ygsb1F2ahmvkZk5xJQiW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjXzy234y7XaNAFL52AL8+ZWBdm+qkr/hQst31rmaXr/EFRgXtyB6KBzwqn0VnIjF3Ebk8iltsWohKUOd9iikmCZYOB2Ejl3qhq18gnV81KeL0lYT+MkqD4ElgUvdyPBRHv8kjebj9J25F1ZHB5RauVagMvzOkJZrj5hH2Pe13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+3rddgo; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4368a293339so123361385e9.3;
        Tue, 07 Jan 2025 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258439; x=1736863239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7YmiHBR09Kpn1D1jyqv5Fld/aOBGo7wbnsSpE/rATA=;
        b=b+3rddgodN4+0mVKvpA8BwCa5xroQ2WaF/eBF/LU+vWeqkGwX2/UZg/lMhwLvZUg4z
         neWea1L+snN7voQx0ZkitYX6qpc+YU9aBKE8u+eqTiO0EBnBW1HrMavmCIr/av9tbq8y
         78qvJS7TkYBjdGQCtGYcsz0Wp28g7tbnYQQS7KiqW8BvL17VbLPxR6hcHNP+gbUnh2Pw
         slH+P3Ur/P05qlTvPvaH/Nw7Ei8rD569RAXYqBVhLsyxDxX0ShIZ+VnATksWmn7tKmW9
         O+UeFZN1v9gNHEEtVbO5fdz5IAB5ez38v7dfAg2evrEOuvs2Q1MFH2t+JyB9y05EqiMb
         LXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258439; x=1736863239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7YmiHBR09Kpn1D1jyqv5Fld/aOBGo7wbnsSpE/rATA=;
        b=ENIQqyUoZUDhC6yqG3+rdCHWp94aqSSpSZhrWJomaL5znd0lQT1UcWDnGj3eAGYgU4
         SyD6z7oVo2NKjBuTYlqIOoDxEK3KCP6zn0N3OcjbIojpzQRDRNN1otHhOZIRHv3wi53o
         I0rUQ1J8WQQ3MIst9z0lg2ys3EBVp5uFVOXO7jOoaS4lWDbEBZb58yZMj7ZHPW4wHQQB
         cdJXRqydw9PByVaUqkVW10e7aR8DXFXhGdBBMpagVCmDVCb0pSWsq0JWCiUrciSSBT8r
         BuD6+pxl7fbAZKp5biiuTxKsqvXoT2d7h/t4D/RLy742S+VTTDsPZ8zUKGSVM8Kx0t1o
         8o1A==
X-Forwarded-Encrypted: i=1; AJvYcCW4jJml6ITeA/BJaME3vyrsHIFigpffB4/PGDQlyKy/VKCplxjKWTYWLwMw28W4AtWJFDHVxUsKzdSousc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7SXd5kBfSitKNu8QUE0+H9GTaguhO1x3dPUGQHhWR8BIBKcc
	X6SdmuTrjyF/8uawqBfG37M+LVmFAeD5Ie14pGgwy+juNZOzgA70sxzEQ+6DAKNdIw==
X-Gm-Gg: ASbGnctv88t7KuDs0//yGGvCj6EMEL0zJ+CEV1+zu5A/OuBkcwgZYG0ZxMR4KPfybtg
	GZwz9kRwgBC+kVSx643TkVzy3su4E6ruSjiaKjBSrMQtlcPlAgjFlA0Xx+p2pC6muLE2Hszkxc0
	d+ZdRTpgnybvvv8LjgO7DsJmMnDxRwq4zepG/MQCILmlHZYFfiOhvDn4lqYYdYpgzdijTCuz2Mh
	iykByvEh/IsjaSlfnXdcos62T+CLbNc+Rq36bU5t1k++4s=
X-Google-Smtp-Source: AGHT+IGZyPa9R33aq2JpOxc9kugP+dU++zJ66alv9d3hN8OpcZQ1LjBlVx6RK9mlqXXXNRO+WdmQnQ==
X-Received: by 2002:a05:600c:3596:b0:434:f9c4:a850 with SMTP id 5b1f17b1804b1-4366864408emr670578235e9.10.1736258438463;
        Tue, 07 Jan 2025 06:00:38 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:16::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e8asm49803208f8f.37.2025.01.07.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:37 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 19/22] bpf: Convert lpm_trie.c to rqspinlock
Date: Tue,  7 Jan 2025 06:00:01 -0800
Message-ID: <20250107140004.2732830-20-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3743; h=from:subject; bh=BnUg1f24H681x4s6tZsYG9ygsb1F2ahmvkZk5xJQiW4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCegcGW0MW2yG0ktCYIRed6zs2NCP/iPVubtbeM TBWdKC2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wngAKCRBM4MiGSL8RytxnEA CRugYoDt1TViRjiWaOmnYg7F0TMOIiNLOFNXg2c69baFonjpx8Wu1QeZ92fhOhDtKLncj20f9ifM+j meCI78Y2zitLQx6BcUO4pN/RFJoKqnVVt0R5/7P0UtPCo44jgLjaH9bca8IGYF4iv4740H0PJ4w0sW ImDBP5D2gbuGIv2lnw6bqJ/IS2QU20Y0Qqqk3naXvbrfzr6Wt+JJIJHRR2QNCf90AXBTB3s4hdUZQs K90JLK1Xo9ohmAAqa6hHcr57mfA4CMgRN6jOLv1/wxBLInZjemt77nrTsKfwoSX1FBdlpUPCBkKiVL aUsAyZSFjTLhd+TvsOtIuhAqaFXrwJH5kKpTK/P9rOC+rETUWnuO5D0nmA0m6YnAv0Pxesccns9T4Z SMDY3NBTiMd/Vwzyz3AVHADnCHIIfCX4AU1hiUc8nHcnQfls4IRqedIWnz3CnagBMPYCPXyuRMDmv0 pAdW7ZOoputWmr53st5fAIjsb8yXFihBmq9LB2ttBZSSgi/H71K5CbTpHj1mDKrv1Zyx/cL6CZhfc6 8PHxvWPQJOzKfOhlObcBkOK7865u6jqv48zncKgL5u4eMayuq1WoLTSjw6YBtRgyZbCWPHDG2MD+Pq gayB+QEIerRZscc3gjw4CvMmgI3QBaDDdJ9bwFPBrqRiaZH6FdMWVnx5qccA==
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
index f8bc1e096182..a92d1eeafb33 100644
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
@@ -349,7 +350,9 @@ static long trie_update_elem(struct bpf_map *map,
 	if (!new_node)
 		return -ENOMEM;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	ret = raw_res_spin_lock_irqsave(&trie->lock, irq_flags);
+	if (ret)
+		goto out_free;
 
 	new_node->prefixlen = key->prefixlen;
 	RCU_INIT_POINTER(new_node->child[0], NULL);
@@ -363,8 +366,7 @@ static long trie_update_elem(struct bpf_map *map,
 	 */
 	slot = &trie->root;
 
-	while ((node = rcu_dereference_protected(*slot,
-					lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*slot))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -450,8 +452,8 @@ static long trie_update_elem(struct bpf_map *map,
 	rcu_assign_pointer(*slot, im_node);
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
-
+	raw_res_spin_unlock_irqrestore(&trie->lock, irq_flags);
+out_free:
 	migrate_disable();
 	if (ret)
 		bpf_mem_cache_free(&trie->ma, new_node);
@@ -477,7 +479,9 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&trie->lock, irq_flags);
+	ret = raw_res_spin_lock_irqsave(&trie->lock, irq_flags);
+	if (ret)
+		return ret;
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
@@ -488,8 +492,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	trim = &trie->root;
 	trim2 = trim;
 	parent = NULL;
-	while ((node = rcu_dereference_protected(
-		       *trim, lockdep_is_held(&trie->lock)))) {
+	while ((node = rcu_dereference(*trim))) {
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
@@ -553,7 +556,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	free_node = node;
 
 out:
-	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
+	raw_res_spin_unlock_irqrestore(&trie->lock, irq_flags);
 
 	migrate_disable();
 	bpf_mem_cache_free_rcu(&trie->ma, free_parent);
@@ -604,7 +607,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
-	raw_spin_lock_init(&trie->lock);
+	raw_res_spin_lock_init(&trie->lock);
 
 	/* Allocate intermediate and leaf nodes from the same allocator */
 	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
-- 
2.43.5


