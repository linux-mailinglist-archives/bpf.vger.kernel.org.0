Return-Path: <bpf+bounces-45668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AA9DA004
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50075168DE9
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 00:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97064A00;
	Wed, 27 Nov 2024 00:34:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231D2F32
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732667683; cv=none; b=pGzIyBw6UH2Zx6EZmOXZt11fUigX5A7dxX+a8ugqcWzK201ptda332tFrjlXPivCpEGIc7Ol0rYcJ8MX/3hCchRHYhwFR2bC1Rf8bVC40/Tvi7ynLKfH7QVR4ZyXEYTGxBlWkRh5lizglt8nnN+TUZVye/gTtXdDnC4XlLQMBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732667683; c=relaxed/simple;
	bh=5mkm3P/6m2mRpUgioF564dpPfayqGF4fdgCMEoOutYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rsLJT6ZQHq84/YJGDNU8at5Ng8Jfb2IMwjeL4dTfJ6gIOVkEU60gM3jznw8ZT/9bxjLYqqnJJQfI4U1FUt4mWy1ERV3DOzEzfdSp4E0R0jzu5r+pwhilhkAi03TdbyjXTwQqbEsn93zLTAe6kn1gf/6pVRnSTDlj1g4pNZR79u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XygRz0NxRz4f3jt1
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:34:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BD8C61A018C
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:34:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4cVaUZn5pO9Cw--.38194S8;
	Wed, 27 Nov 2024 08:34:36 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v2 4/9] bpf: Handle in-place update for full LPM trie correctly
Date: Wed, 27 Nov 2024 08:46:36 +0800
Message-Id: <20241127004641.1118269-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241127004641.1118269-1-houtao@huaweicloud.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4cVaUZn5pO9Cw--.38194S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWxKF1DZr17Jw47tr47urg_yoW5Zr4UpF
	WSkF9Iyr18Xr15Ww4Fv398JFZ8Xw48G3yj9F93Ka4SyFyS9r9xtF18ua4rtFW5ArW8ur4a
	yF45tFyqqrZ5ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U0sqXPUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When a LPM trie is full, in-place updates of existing elements
incorrectly return -ENOSPC.

Fix this by deferring the check of trie->n_entries. For new insertions,
n_entries must not exceed max_entries. However, in-place updates are
allowed even when the trie is full.

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 44 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 4300bd51ec6e..3b43ebae9cc9 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -310,6 +310,16 @@ static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
 	return node;
 }
 
+static int trie_check_add_elem(struct lpm_trie *trie, u64 flags)
+{
+	if (flags == BPF_EXIST)
+		return -ENOENT;
+	if (trie->n_entries == trie->map.max_entries)
+		return -ENOSPC;
+	trie->n_entries++;
+	return 0;
+}
+
 /* Called from syscall or from eBPF program */
 static long trie_update_elem(struct bpf_map *map,
 			     void *_key, void *value, u64 flags)
@@ -333,20 +343,12 @@ static long trie_update_elem(struct bpf_map *map,
 	spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Allocate and fill a new node */
-
-	if (trie->n_entries == trie->map.max_entries) {
-		ret = -ENOSPC;
-		goto out;
-	}
-
 	new_node = lpm_trie_node_alloc(trie, value);
 	if (!new_node) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	trie->n_entries++;
-
 	new_node->prefixlen = key->prefixlen;
 	RCU_INIT_POINTER(new_node->child[0], NULL);
 	RCU_INIT_POINTER(new_node->child[1], NULL);
@@ -375,10 +377,10 @@ static long trie_update_elem(struct bpf_map *map,
 	 * simply assign the @new_node to that slot and be done.
 	 */
 	if (!node) {
-		if (flags == BPF_EXIST) {
-			ret = -ENOENT;
+		ret = trie_check_add_elem(trie, flags);
+		if (ret)
 			goto out;
-		}
+
 		rcu_assign_pointer(*slot, new_node);
 		goto out;
 	}
@@ -392,10 +394,10 @@ static long trie_update_elem(struct bpf_map *map,
 				ret = -EEXIST;
 				goto out;
 			}
-			trie->n_entries--;
-		} else if (flags == BPF_EXIST) {
-			ret = -ENOENT;
-			goto out;
+		} else {
+			ret = trie_check_add_elem(trie, flags);
+			if (ret)
+				goto out;
 		}
 
 		new_node->child[0] = node->child[0];
@@ -407,10 +409,9 @@ static long trie_update_elem(struct bpf_map *map,
 		goto out;
 	}
 
-	if (flags == BPF_EXIST) {
-		ret = -ENOENT;
+	ret = trie_check_add_elem(trie, flags);
+	if (ret)
 		goto out;
-	}
 
 	/* If the new node matches the prefix completely, it must be inserted
 	 * as an ancestor. Simply insert it between @node and *@slot.
@@ -424,6 +425,7 @@ static long trie_update_elem(struct bpf_map *map,
 
 	im_node = lpm_trie_node_alloc(trie, NULL);
 	if (!im_node) {
+		trie->n_entries--;
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -445,12 +447,8 @@ static long trie_update_elem(struct bpf_map *map,
 	rcu_assign_pointer(*slot, im_node);
 
 out:
-	if (ret) {
-		if (new_node)
-			trie->n_entries--;
+	if (ret)
 		kfree(new_node);
-	}
-
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
 	kfree_rcu(free_node, rcu);
 
-- 
2.29.2


