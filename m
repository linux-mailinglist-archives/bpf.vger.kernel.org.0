Return-Path: <bpf+bounces-48183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F92A04E53
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5723E3A4BE0
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C8F27713;
	Wed,  8 Jan 2025 00:55:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239E70825;
	Wed,  8 Jan 2025 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297726; cv=none; b=D6/LjvjUo8VHCQ+Qf1rIGGYoiJdU59e+GL+LCLy0IeOxct0QbT7LrS+h82I85bjUQ7tIw8Z/vbJAN5D1gfSga1+zteXZcB4iVU9dDyvOTLV8ydaVQwlMgR7T3l8x5bywdz7Mi9xlyiELmIoay/A9LO8ONN6vPeJgmFXSaTBtyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297726; c=relaxed/simple;
	bh=YxUKGwjULBtJEi0m1wVyQjktdIwoL5Ke73ijlRMY2lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzey3VMLWV9TYYGUZ1eSphebIgIoOvcU6fZJLD6EnyRR57NkGKsoqtxeeBDERLvmqqqaSBaZ1/Caktw366VqB3kcG3XUP3GupwbI+fkpKXl5K6ECuB98Yk16dCHDCjxICdCK6vfjbafyWJwiejb5n31+PsWIB6MqPVtikIiHWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YSTwV2k53z4f3jqy;
	Wed,  8 Jan 2025 08:55:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5EC841A0E7F;
	Wed,  8 Jan 2025 08:55:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S5;
	Wed, 08 Jan 2025 08:55:21 +0800 (CST)
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
Subject: [PATCH bpf-next v2 01/16] bpf: Remove migrate_{disable|enable} from LPM trie
Date: Wed,  8 Jan 2025 09:07:13 +0800
Message-Id: <20250108010728.207536-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250108010728.207536-1-houtao@huaweicloud.com>
References: <20250108010728.207536-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy8tr1kXr15Ar1rKr1kGrg_yoW5Xr1xpF
	WxKr9Yyr4UXF4Yqr40vrZ5Ar98Aw4xKay7GaykWa4Iqas09as7Jw48ZF10qFy5AFWUtr4a
	qF15K340vr48CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Both bpf program and bpf syscall may invoke ->update or ->delete
operation for LPM trie. For bpf program, its running context has already
disabled migration explicitly through (migrate_disable()) or implicitly
through (preempt_disable() or disable irq). For bpf syscall, the
migration is disabled through the use of bpf_disable_instrumentation()
before invoking the corresponding map operation callback.

Therefore, it is safe to remove the migrate_{disable|enable){} pair from
LPM trie.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index f8bc1e0961823..e8a772e643242 100644
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
@@ -342,10 +337,8 @@ static long trie_update_elem(struct bpf_map *map,
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	/* Allocate and fill a new node. Need to disable migration before
-	 * invoking bpf_mem_cache_alloc().
-	 */
-	new_node = lpm_trie_node_alloc(trie, value, true);
+	/* Allocate and fill a new node */
+	new_node = lpm_trie_node_alloc(trie, value);
 	if (!new_node)
 		return -ENOMEM;
 
@@ -425,8 +418,7 @@ static long trie_update_elem(struct bpf_map *map,
 		goto out;
 	}
 
-	/* migration is disabled within the locked scope */
-	im_node = lpm_trie_node_alloc(trie, NULL, false);
+	im_node = lpm_trie_node_alloc(trie, NULL);
 	if (!im_node) {
 		trie->n_entries--;
 		ret = -ENOMEM;
@@ -452,11 +444,9 @@ static long trie_update_elem(struct bpf_map *map,
 out:
 	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
 
-	migrate_disable();
 	if (ret)
 		bpf_mem_cache_free(&trie->ma, new_node);
 	bpf_mem_cache_free_rcu(&trie->ma, free_node);
-	migrate_enable();
 
 	return ret;
 }
@@ -555,10 +545,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
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


