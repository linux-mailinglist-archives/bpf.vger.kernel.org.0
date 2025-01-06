Return-Path: <bpf+bounces-47916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6190CA0203A
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52177A1814
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619851D88AD;
	Mon,  6 Jan 2025 08:07:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACA1D7E5B;
	Mon,  6 Jan 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150820; cv=none; b=kkVeMTiK7ZC5g1UwGMd9pTYySlbOMgpgFclq0ZgB8niMMUShmlsc55+RcttjX3SkfDdrTIkXrPvRh6YTX+Ve1dk55Wb4kwy0LDIW2HNTrg9B8TIeO66xmpzYgv0J8ktLCYItEvFGQZH6B2yxGIoFxSzXlLyNAspyCkDJ2mYGKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150820; c=relaxed/simple;
	bh=VCq7PzB+FtO3wyqs9j/jG+yOuA3G8HstksXwcT6fueQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3p1jRLHDpE5pIvs8xoGbjTD97Jf2a0x2dWg9z7f7mV10p5jVUFy1/0GnCe1K8xQUB0bE5QTEK+QC3Gi9acGKnHi0neU6W2o90xpdM0WQWyCH+kBmhVV5rl7Cp01c5guXyHc9H0ucU1PdfI4yD3paPsexnDQL3fDuYYUGO4jm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbG4JBdz4f3jR3;
	Mon,  6 Jan 2025 16:06:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AF47B1A1496;
	Mon,  6 Jan 2025 16:06:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S5;
	Mon, 06 Jan 2025 16:06:54 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 01/19] bpf: Remove migrate_{disable|enable} from LPM trie
Date: Mon,  6 Jan 2025 16:18:42 +0800
Message-Id: <20250106081900.1665573-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250106081900.1665573-1-houtao@huaweicloud.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy5XryDCw4fWw18ZrWfGrg_yoW5CFyxpF
	WxK3sYyr4UXr4Ygr4IqrZ5Jry5Aw4xKay7Gayvga40q3s09F97Jr18Z3W0gFy5ArW7tr4a
	qF1UK34IvF48CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Both bpf program and bpf syscall may invoke ->update or ->delete
operation for LPM trie. For bpf program, its running context has already
disabled migration explicitly through (migrate_disable()) or implicitly
through (preempt_disable() or disable irq). For bpf syscall, the
migration is disabled through the use of bpf_disable_instrumentation()
before invoking the corresponding map operation callback.

Therefore, it is safe to remove the migrate_{disable|enable){} pair from
LPM trie. To ensure the guarantee will not be voilated later, also add
cant_migrate() check in both update and delete operation.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index f8bc1e096182..1a3585a485df 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -289,16 +289,11 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 }
 
 static struct lpm_trie_node *lpm_trie_node_alloc(struct lpm_trie *trie,
-						 const void *value,
-						 bool disable_migration)
+						 const void *value)
 {
 	struct lpm_trie_node *node;
 
-	if (disable_migration)
-		migrate_disable();
 	node = bpf_mem_cache_alloc(&trie->ma);
-	if (disable_migration)
-		migrate_enable();
 
 	if (!node)
 		return NULL;
@@ -342,10 +337,10 @@ static long trie_update_elem(struct bpf_map *map,
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	/* Allocate and fill a new node. Need to disable migration before
-	 * invoking bpf_mem_cache_alloc().
-	 */
-	new_node = lpm_trie_node_alloc(trie, value, true);
+	cant_migrate();
+
+	/* Allocate and fill a new node */
+	new_node = lpm_trie_node_alloc(trie, value);
 	if (!new_node)
 		return -ENOMEM;
 
@@ -425,8 +420,7 @@ static long trie_update_elem(struct bpf_map *map,
 		goto out;
 	}
 
-	/* migration is disabled within the locked scope */
-	im_node = lpm_trie_node_alloc(trie, NULL, false);
+	im_node = lpm_trie_node_alloc(trie, NULL);
 	if (!im_node) {
 		trie->n_entries--;
 		ret = -ENOMEM;
@@ -452,11 +446,9 @@ static long trie_update_elem(struct bpf_map *map,
 out:
 	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
 
-	migrate_disable();
 	if (ret)
 		bpf_mem_cache_free(&trie->ma, new_node);
 	bpf_mem_cache_free_rcu(&trie->ma, free_node);
-	migrate_enable();
 
 	return ret;
 }
@@ -477,6 +469,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
+	cant_migrate();
+
 	raw_spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Walk the tree looking for an exact key/length match and keeping
@@ -555,10 +549,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 out:
 	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
 
-	migrate_disable();
 	bpf_mem_cache_free_rcu(&trie->ma, free_parent);
 	bpf_mem_cache_free_rcu(&trie->ma, free_node);
-	migrate_enable();
 
 	return ret;
 }
-- 
2.29.2


