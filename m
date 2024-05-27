Return-Path: <bpf+bounces-30650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF48D02E2
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E6F29A970
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA215FA7C;
	Mon, 27 May 2024 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDXLWkD1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187B15FA68;
	Mon, 27 May 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819143; cv=none; b=d2Ta3v+mUsK1ePcfwxX6875+1lehEcQiDE/nwDar6bjQMJ7TCrZGqEWG2zr0yCxQR+HaR1INRu325A5DZ47zXFwsS//6T5K+OAwCuFhgRpPLjMexx7lnHezmTXRefKXPLq/8VtI/jwEPIeclidLPAKPErzvd1+54fkhjAeSU58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819143; c=relaxed/simple;
	bh=HrTEdUzVuB12p0SLte4yR5sIXNZvCTC49ZZH/0a3r8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPgW371rU8wNKzlixRtIBfaXvhHZfRTIf3BP0RKf8PVna7qy560beEcQfraaW4YgihZ/s7N6uCiAT5A8rVszgRlfLnvIXq+RNuqRtDrc6aAFV0SOcptCBAZBDvK3h7aEdF1uBGgxJ9QJsSstYg7cPT2vmbOIDJRa+xyqDBLntkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDXLWkD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E51C2BBFC;
	Mon, 27 May 2024 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819142;
	bh=HrTEdUzVuB12p0SLte4yR5sIXNZvCTC49ZZH/0a3r8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDXLWkD1nmVnKXp9ts/EVvNEYh1mEPHky2W+KngWs3JRsJkNIWPUew6yZRxrybl8B
	 LdPY4/yfTxj1o9ZBeJegJ9WCKPnUKL4O4zYcricgmHlkwHSXTQz7lBHlPcepUP4Hm2
	 38wdT6p1ToPz5cpQFY0CKpDn82ABIa0zsqufnYzC4a/PwVV0E4lYbFa0nJeTnyuHF6
	 WqlsNkiEV2BbqXU+ppP2d9rZiS/28peJqL0wf7SKgFNtubqQ/MZ2xoAD08auyQPMv8
	 C4Ex3jxRmKAakheC/q5A9aF8hIFE+aYY10OL6XflJtgVGh/WBGlHvLoYBB1jQX1JpT
	 4lbcyfC4g5mWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 04/35] bpf: Avoid kfree_rcu() under lock in bpf_lpm_trie.
Date: Mon, 27 May 2024 10:11:09 -0400
Message-ID: <20240527141214.3844331-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 59f2f841179aa6a0899cb9cf53659149a35749b7 ]

syzbot reported the following lock sequence:
cpu 2:
  grabs timer_base lock
    spins on bpf_lpm lock

cpu 1:
  grab rcu krcp lock
    spins on timer_base lock

cpu 0:
  grab bpf_lpm lock
    spins on rcu krcp lock

bpf_lpm lock can be the same.
timer_base lock can also be the same due to timer migration.
but rcu krcp lock is always per-cpu, so it cannot be the same lock.
Hence it's a false positive.
To avoid lockdep complaining move kfree_rcu() after spin_unlock.

Reported-by: syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240329171439.37813-1-alexei.starovoitov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/lpm_trie.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 050fe1ebf0f7d..d0febf07051ed 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -308,6 +308,7 @@ static long trie_update_elem(struct bpf_map *map,
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
+	struct lpm_trie_node *free_node = NULL;
 	struct lpm_trie_node __rcu **slot;
 	struct bpf_lpm_trie_key_u8 *key = _key;
 	unsigned long irq_flags;
@@ -382,7 +383,7 @@ static long trie_update_elem(struct bpf_map *map,
 			trie->n_entries--;
 
 		rcu_assign_pointer(*slot, new_node);
-		kfree_rcu(node, rcu);
+		free_node = node;
 
 		goto out;
 	}
@@ -429,6 +430,7 @@ static long trie_update_elem(struct bpf_map *map,
 	}
 
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
@@ -437,6 +439,7 @@ static long trie_update_elem(struct bpf_map *map,
 static long trie_delete_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
+	struct lpm_trie_node *free_node = NULL, *free_parent = NULL;
 	struct bpf_lpm_trie_key_u8 *key = _key;
 	struct lpm_trie_node __rcu **trim, **trim2;
 	struct lpm_trie_node *node, *parent;
@@ -506,8 +509,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 		else
 			rcu_assign_pointer(
 				*trim2, rcu_access_pointer(parent->child[0]));
-		kfree_rcu(parent, rcu);
-		kfree_rcu(node, rcu);
+		free_parent = parent;
+		free_node = node;
 		goto out;
 	}
 
@@ -521,10 +524,12 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
 		rcu_assign_pointer(*trim, rcu_access_pointer(node->child[1]));
 	else
 		RCU_INIT_POINTER(*trim, NULL);
-	kfree_rcu(node, rcu);
+	free_node = node;
 
 out:
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
+	kfree_rcu(free_parent, rcu);
+	kfree_rcu(free_node, rcu);
 
 	return ret;
 }
-- 
2.43.0


