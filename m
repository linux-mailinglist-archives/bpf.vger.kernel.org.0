Return-Path: <bpf+bounces-46262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A64F9E6CA3
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A393188431E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC71DFD89;
	Fri,  6 Dec 2024 10:54:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AF1FA844
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482466; cv=none; b=J7/mTMrj1gBqTGd9pFI9CRtHnC7oGqX4GKRO80PuKa6RnZZZi9jZhVvroKlhdk4KXy3TzT9q34jnX3reDKNZEH1lFErhm9CcE6K8RZ51QP4hS9w6Q+PKC3BCx4xJ3Nal4wCUJ1fF391yVddF4gWy+lkvQ/EXBHSCRtDwV2DjefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482466; c=relaxed/simple;
	bh=4gQcOKNc8rbg0jwgKEPSroZhPSLyqfl/FJKW2UYgXhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBURyM1pXErn+51GFvzGlTqM9FL6dmyXKDPvXkEYBMFguLsR7PCwuQ87AsutmfuJsB48e2XTmvApiuXlRpJqfmhBYy+2/2AWs0Dhx4bTh/GdpkAz+2bH9pZds/Xf01pJgy+BqUb+6pPbHBFa//8OJdxMXn7IWmrYXrDtfCUna/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y4Smj2mT5z4f3jdS
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:53:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 77B921A0359
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:54:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4fS11JnmMhIDw--.40874S7;
	Fri, 06 Dec 2024 18:54:16 +0800 (CST)
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
Subject: [PATCH bpf v3 3/9] bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
Date: Fri,  6 Dec 2024 19:06:16 +0800
Message-Id: <20241206110622.1161752-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241206110622.1161752-1-houtao@huaweicloud.com>
References: <20241206110622.1161752-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4fS11JnmMhIDw--.40874S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4xXr1xuFyftr4xAF4fXwb_yoW8Aw17pF
	4SkFWYgFW8JF13Cw4Sv3Z3JFy5Wa48G342gFyIk3yayFWjkF9IqF1rXay5tF43JrW7Zry3
	AF4YqFyqgryDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU04x
	RDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add the currently missing handling for the BPF_EXIST and BPF_NOEXIST
flags. These flags can be specified by users and are relevant since LPM
trie supports exact matches during update.

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index b5e281a55760..be5bf0389532 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -375,6 +375,10 @@ static long trie_update_elem(struct bpf_map *map,
 	 * simply assign the @new_node to that slot and be done.
 	 */
 	if (!node) {
+		if (flags == BPF_EXIST) {
+			ret = -ENOENT;
+			goto out;
+		}
 		rcu_assign_pointer(*slot, new_node);
 		goto out;
 	}
@@ -383,18 +387,31 @@ static long trie_update_elem(struct bpf_map *map,
 	 * which already has the correct data array set.
 	 */
 	if (node->prefixlen == matchlen) {
+		if (!(node->flags & LPM_TREE_NODE_FLAG_IM)) {
+			if (flags == BPF_NOEXIST) {
+				ret = -EEXIST;
+				goto out;
+			}
+			trie->n_entries--;
+		} else if (flags == BPF_EXIST) {
+			ret = -ENOENT;
+			goto out;
+		}
+
 		new_node->child[0] = node->child[0];
 		new_node->child[1] = node->child[1];
 
-		if (!(node->flags & LPM_TREE_NODE_FLAG_IM))
-			trie->n_entries--;
-
 		rcu_assign_pointer(*slot, new_node);
 		free_node = node;
 
 		goto out;
 	}
 
+	if (flags == BPF_EXIST) {
+		ret = -ENOENT;
+		goto out;
+	}
+
 	/* If the new node matches the prefix completely, it must be inserted
 	 * as an ancestor. Simply insert it between @node and *@slot.
 	 */
-- 
2.29.2


