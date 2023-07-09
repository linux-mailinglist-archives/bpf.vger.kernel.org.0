Return-Path: <bpf+bounces-4546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5E74C617
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 17:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C6D28104F
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F620134D7;
	Sun,  9 Jul 2023 15:16:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62EBE57D
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 15:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C50C433CD;
	Sun,  9 Jul 2023 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915796;
	bh=9rSVqdKcxx7I835Y7LAo46+7GLpjCTaOzwiFWPXuui4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrRSfALM0OEcCptNqwbeSdRcJ4M2pMQTnz16RY45ns2jZm6xsms/Aav1/iQK2ZFNd
	 W2tnlOKibJLTM+r0M094BkmJDvarSaW7TxnC6YJtWMYLJbdfKMO2mcN/wXn4fJtAVC
	 h5XiEiXuObvjIabpUmOodIjQkwAGGaqtnKd8rv4+CEgXqvB4PYsa4dGdsvKJLP2Kbk
	 E3+nEr1SwtPmdK3tH61oTrpJpRTUvYoPvHBh5KR0SpPhiin80bQ+g2sBJfoLJiJxDZ
	 2fIZaBfOmxFcuEs8C0tnqDyrwilzOJ7VfM/yXOjFjM4veU5Mm8PkNn+oZe0lhXF9t7
	 rWGsjsn60ZjkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com,
	Yonghong Song <yhs@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/5] bpf: Address KCSAN report on bpf_lru_list
Date: Sun,  9 Jul 2023 11:16:27 -0400
Message-Id: <20230709151632.514098-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151632.514098-1-sashal@kernel.org>
References: <20230709151632.514098-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.288
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit ee9fd0ac3017c4313be91a220a9ac4c99dde7ad4 ]

KCSAN reported a data-race when accessing node->ref.
Although node->ref does not have to be accurate,
take this chance to use a more common READ_ONCE() and WRITE_ONCE()
pattern instead of data_race().

There is an existing bpf_lru_node_is_ref() and bpf_lru_node_set_ref().
This patch also adds bpf_lru_node_clear_ref() to do the
WRITE_ONCE(node->ref, 0) also.

==================================================================
BUG: KCSAN: data-race in __bpf_lru_list_rotate / __htab_lru_percpu_map_update_elem

write to 0xffff888137038deb of 1 bytes by task 11240 on cpu 1:
__bpf_lru_node_move kernel/bpf/bpf_lru_list.c:113 [inline]
__bpf_lru_list_rotate_active kernel/bpf/bpf_lru_list.c:149 [inline]
__bpf_lru_list_rotate+0x1bf/0x750 kernel/bpf/bpf_lru_list.c:240
bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:329 [inline]
bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
bpf_lru_pop_free+0x638/0xe20 kernel/bpf/bpf_lru_list.c:499
prealloc_lru_pop kernel/bpf/hashtab.c:290 [inline]
__htab_lru_percpu_map_update_elem+0xe7/0x820 kernel/bpf/hashtab.c:1316
bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
__sys_bpf+0x338/0x810
__do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888137038deb of 1 bytes by task 11241 on cpu 0:
bpf_lru_node_set_ref kernel/bpf/bpf_lru_list.h:70 [inline]
__htab_lru_percpu_map_update_elem+0x2f1/0x820 kernel/bpf/hashtab.c:1332
bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
__sys_bpf+0x338/0x810
__do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x01 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 11241 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00136-g6a66fdd29ea1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================

Reported-by: syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20230511043748.1384166-1-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_lru_list.c | 21 +++++++++++++--------
 kernel/bpf/bpf_lru_list.h |  7 ++-----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 9b5eeff72fd37..39a0e768adc39 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -44,7 +44,12 @@ static struct list_head *local_pending_list(struct bpf_lru_locallist *loc_l)
 /* bpf_lru_node helpers */
 static bool bpf_lru_node_is_ref(const struct bpf_lru_node *node)
 {
-	return node->ref;
+	return READ_ONCE(node->ref);
+}
+
+static void bpf_lru_node_clear_ref(struct bpf_lru_node *node)
+{
+	WRITE_ONCE(node->ref, 0);
 }
 
 static void bpf_lru_list_count_inc(struct bpf_lru_list *l,
@@ -92,7 +97,7 @@ static void __bpf_lru_node_move_in(struct bpf_lru_list *l,
 
 	bpf_lru_list_count_inc(l, tgt_type);
 	node->type = tgt_type;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_move(&node->list, &l->lists[tgt_type]);
 }
 
@@ -113,7 +118,7 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
 		bpf_lru_list_count_inc(l, tgt_type);
 		node->type = tgt_type;
 	}
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 
 	/* If the moving node is the next_inactive_rotation candidate,
 	 * move the next_inactive_rotation pointer also.
@@ -356,7 +361,7 @@ static void __local_list_add_pending(struct bpf_lru *lru,
 	*(u32 *)((void *)node + lru->hash_offset) = hash;
 	node->cpu = cpu;
 	node->type = BPF_LRU_LOCAL_LIST_T_PENDING;
-	node->ref = 0;
+	bpf_lru_node_clear_ref(node);
 	list_add(&node->list, local_pending_list(loc_l));
 }
 
@@ -422,7 +427,7 @@ static struct bpf_lru_node *bpf_percpu_lru_pop_free(struct bpf_lru *lru,
 	if (!list_empty(free_list)) {
 		node = list_first_entry(free_list, struct bpf_lru_node, list);
 		*(u32 *)((void *)node + lru->hash_offset) = hash;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_INACTIVE);
 	}
 
@@ -525,7 +530,7 @@ static void bpf_common_lru_push_free(struct bpf_lru *lru,
 		}
 
 		node->type = BPF_LRU_LOCAL_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_move(&node->list, local_free_list(loc_l));
 
 		raw_spin_unlock_irqrestore(&loc_l->lock, flags);
@@ -571,7 +576,7 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
@@ -597,7 +602,7 @@ static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
 		node = (struct bpf_lru_node *)(buf + node_offset);
 		node->cpu = cpu;
 		node->type = BPF_LRU_LIST_T_FREE;
-		node->ref = 0;
+		bpf_lru_node_clear_ref(node);
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		i++;
 		buf += elem_size;
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index 7d4f89b7cb841..08da78b59f0b9 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -66,11 +66,8 @@ struct bpf_lru {
 
 static inline void bpf_lru_node_set_ref(struct bpf_lru_node *node)
 {
-	/* ref is an approximation on access frequency.  It does not
-	 * have to be very accurate.  Hence, no protection is used.
-	 */
-	if (!node->ref)
-		node->ref = 1;
+	if (!READ_ONCE(node->ref))
+		WRITE_ONCE(node->ref, 1);
 }
 
 int bpf_lru_init(struct bpf_lru *lru, bool percpu, u32 hash_offset,
-- 
2.39.2


