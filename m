Return-Path: <bpf+bounces-45057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5069D0757
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 01:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332EC1F21B82
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 00:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6C10957;
	Mon, 18 Nov 2024 00:56:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C468C07
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731891372; cv=none; b=fxP1JoEghIIKOG5P6QOsITlrURj9J4sQO9/TCAcy88Tsj+6+EZY93poqSsiJLVnUDUSTEzrfucXL4RMH5Vgj4HJTjBJOCC7uU6QrctDQEGnVjDVECJbldMs7ZelB/o8KN7WyZ0RlOHfEzWcNwGQkxSfQLgTxlxvbAzHOzj1tLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731891372; c=relaxed/simple;
	bh=IGjvc+sJPUpcJEIdMIioYXehKMCaHh0dsUy/W8AwIAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQm/zpmaBsy8jFLoCvEtittowCeV5b3L29FlnXevVivghMj7VuZofX2gxJfPDiSRz1mBIxmKeDNq0fu5E69qOk0B9JFGk4TRKlnFLnGIk3LVoQfbmrTzQqYPk9JsJrcsqGkIviipsLcuwCtETHnoAtWCMs02k3QD0FW9vxupcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xs8Lq1H8rz4f3lfZ
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:55:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7ED8C1A0197
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:56:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eckDpn2G5fCA--.44635S12;
	Mon, 18 Nov 2024 08:56:06 +0800 (CST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 08/10] bpf: Use raw_spinlock_t for LPM trie
Date: Mon, 18 Nov 2024 09:08:06 +0800
Message-Id: <20241118010808.2243555-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241118010808.2243555-1-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eckDpn2G5fCA--.44635S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4Utr17Wr1kWr43Aw4fKrg_yoW5GryDpF
	4xG3s0yw48Ar4Ygw4vqrZ0q3y5Ww4kWw4UGas5Wa4xJr90q3sxJr18AFy09F15AFWIyrsx
	tF15tFWSvrW8uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

After switching from kmalloc() to the bpf memory allocator, there will be
no blocking operation during the update of LPM trie. Therefore, change
trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable in
atomic context, even on RT kernels.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index d8995acecedf..f8ff2bfcd704 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -46,7 +46,7 @@ struct lpm_trie {
 	size_t				n_entries;
 	size_t				max_prefixlen;
 	size_t				data_size;
-	spinlock_t			lock;
+	raw_spinlock_t			lock;
 };
 
 /* This trie implements a longest prefix match algorithm that can be used to
@@ -365,7 +365,7 @@ static long trie_update_elem(struct bpf_map *map,
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	spin_lock_irqsave(&trie->lock, irq_flags);
+	raw_spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Allocate and fill a new node */
 	new_node = lpm_trie_node_alloc(trie, value);
@@ -478,7 +478,7 @@ static long trie_update_elem(struct bpf_map *map,
 	if (ret)
 		bpf_mem_cache_free(trie->leaf_ma, new_node);
 
-	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
 	lpm_trie_node_free(trie, free_node, true);
 
 	return ret;
@@ -500,7 +500,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	if (key->prefixlen > trie->max_prefixlen)
 		return -EINVAL;
 
-	spin_lock_irqsave(&trie->lock, irq_flags);
+	raw_spin_lock_irqsave(&trie->lock, irq_flags);
 
 	/* Walk the tree looking for an exact key/length match and keeping
 	 * track of the path we traverse.  We will need to know the node
@@ -576,7 +576,7 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 	free_node = node;
 
 out:
-	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	raw_spin_unlock_irqrestore(&trie->lock, irq_flags);
 	lpm_trie_node_free(trie, free_parent, true);
 	lpm_trie_node_free(trie, free_node, true);
 
@@ -624,7 +624,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 			  offsetof(struct bpf_lpm_trie_key_u8, data);
 	trie->max_prefixlen = trie->data_size * 8;
 
-	spin_lock_init(&trie->lock);
+	raw_spin_lock_init(&trie->lock);
 
 	size = sizeof(struct lpm_trie_node) + trie->data_size;
 	err = bpf_mem_alloc_init(&trie->ma[LPM_TRIE_MA_IM], size, false);
-- 
2.29.2


