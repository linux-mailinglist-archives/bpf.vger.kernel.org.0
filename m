Return-Path: <bpf+bounces-46256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8C69E6C9D
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 11:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185C716573B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712FC1FBE90;
	Fri,  6 Dec 2024 10:54:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891171BA86C
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482462; cv=none; b=elTWciDlFqudqHlKYmwNEZKlLTjBVa600eqHCstijXduxgkQfrlD2qUMf1DSZhT7PGfNSZj2XTjpyb4uFUd9phZvMTwzoJWQfBKSt8/HmdwMGL1Wqx2WmfERN0e0yiP06iEOizjE3AeDkBJTfqjIf8BnXH5WJ6SlxUjORks+CJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482462; c=relaxed/simple;
	bh=HPtZP1Cy5Y7R5JlxG7hEZsrlqahg6lYSgQHvMEUvOSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tggdEtrDIXuZSG0+Lh97ppGpkh4E1QMyrO/iZuc1Z1jJXszesttFtnAu0Dn+n8ghW/mRboIQB7Xlefirm9bALCoMISyi/w1q1S110Hz+URD91AQzLh8ek6MnxHIVZFBIjKtU3r+yMSxzvzUBncGUduIvB9nQozaibRMcmjnENeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4Smn51P8z4f3jqF
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:54:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BF0E91A018D
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:54:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4fS11JnmMhIDw--.40874S6;
	Fri, 06 Dec 2024 18:54:15 +0800 (CST)
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
Subject: [PATCH bpf v3 2/9] bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
Date: Fri,  6 Dec 2024 19:06:15 +0800
Message-Id: <20241206110622.1161752-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHI4fS11JnmMhIDw--.40874S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw48ZF18XF45CFW3KrWkCrg_yoW8JF1xpF
	48K3s0yr4rJr45Ww4vvFWrZr98Xw13Gw47Wa4kGayftFy5Kr93WF18ZFyj9F45JFW0yrs8
	AF1Ygryvvw4kurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0I3
	85UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

There is no need to call kfree(im_node) when updating element fails,
because im_node must be NULL. Remove the unnecessary kfree() for
im_node.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 73fd593d3745..b5e281a55760 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -315,7 +315,7 @@ static long trie_update_elem(struct bpf_map *map,
 			     void *_key, void *value, u64 flags)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
-	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
+	struct lpm_trie_node *node, *im_node, *new_node = NULL;
 	struct lpm_trie_node *free_node = NULL;
 	struct lpm_trie_node __rcu **slot;
 	struct bpf_lpm_trie_key_u8 *key = _key;
@@ -431,9 +431,7 @@ static long trie_update_elem(struct bpf_map *map,
 	if (ret) {
 		if (new_node)
 			trie->n_entries--;
-
 		kfree(new_node);
-		kfree(im_node);
 	}
 
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
-- 
2.29.2


