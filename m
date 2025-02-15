Return-Path: <bpf+bounces-51655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5464A36D94
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0DC189685A
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8380F1A23BD;
	Sat, 15 Feb 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzVvSZPx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188C1A9B39
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617480; cv=none; b=Md7i+Q+wjISTN7MtVyHPIUfD2le+6VkKnXOhupOGFD87uZ17jlroNPFhvVfgmdQgQzdX7swxLDMSgK8p510li0A3PLUBo+uJLXqpbB6PHUzvdFCAPhXH8ayeboM835rEiWG7rG6LvrNh/NJKJ2JGPNzK6OQJ1XEOhd1WaloYC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617480; c=relaxed/simple;
	bh=znfSnaYoA7dCF7AWy0G4YR2r/ImBgWEfa88RBqrB39g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1y292Cm6P1Tq3vvZPJEX1G4HnC27bm1ViE9v+Uha53KfH4i8e3KjPkpUYrph5idlZN7YEPmKRO5GfvEK0/s6ZHkt0f5t3jEf7X0W2DuRDqlIuCFdDF4qV359ljgM/o4MjpJOlf4qbU4zVgUUwKwgG4jkHM0H8Mh7uvIepi7pYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzVvSZPx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22100006bc8so15929625ad.0
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617477; x=1740222277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffDif9cLlzs8ZbWp40VK6UKD3HwOOkOekNENzc4XXA4=;
        b=AzVvSZPx8BprxUx+fwYRsAxtF/NM3o8as9sEXFpFxlRMGqLjQGr+1Or+YoDVY9XHer
         xvz6KXPk/FxGkv3b67Ro/Bn8Rn5i/1xfsDOlDr8daqc5lbgQ/4xE05ivUDOQaJ/B/us7
         wNFCPvVBDGrc08uLtSobRA7R977PGyOdprUSRxVxDOEgr7QEvoO/nZSFQ+EAH7eSzYTg
         Yq2/C8Y9cmMJp3UtFLwt/aveDpyruf5wUcHXfm/h/PeNazrECId4WhcXsBsb3HQNCszJ
         wYh+ReqJ0PnqNOhckrBUPDh6X0zJfSiQH2kQPJHTbNT/U23ZHwPuXx4YWp0Ynexyu4vM
         2tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617477; x=1740222277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffDif9cLlzs8ZbWp40VK6UKD3HwOOkOekNENzc4XXA4=;
        b=SOgqAnKlQdAoCbnAvfDLtOS/sifmmlfaEpIL0Bh27VmrZ3KntxsHAVMjeTV2Sqi0ya
         O+ZQGl+i/B/GqXtz2u+TFmZ3pkqn7+XfToeUp1KDnhF4ZUoBSuoHJsXYxBrhRhYL7OZ5
         DGmglDtPvs8eMr3Elu1Gi1hi+sQNqRvskW2YNfKDtXm/W70A44sMr1wtITEkjUYMjVou
         yYtYrboWmNiB25pTp2FGdAAELzTHvIvMz+F3yxeJ7zppqNfWlBVuaBROVnuitww7bErg
         TEgnSsF18U0kmVSQIoPVmw4Ak3w5l7QB6hdqcr8KqbyraUGtxxyjOibZg8qcbvtiA/rf
         e5lQ==
X-Gm-Message-State: AOJu0Yze+Ubgkbundzdm7bkAU8kDPiHBXX4A543d4ADddZzSp3FryMF5
	vj6yYvOokRUADVvbm+5nXWMn/+/7bEN1wuH/UEm0nG+gVW0sSQA4yHdUBg==
X-Gm-Gg: ASbGnctK90RN2W2yv4fpc0D4p8SfhW5T8O/+CmG9XLVStiHzYfbuuWcouMkIFNGMbOa
	9DzAg6CVIRTP7AagO7UBTc01SFEWF5W3ToVpYjSweNcES6dQmRntrQgQpA+UJg7TkcOFj6DJrfy
	NvptK4Eoc5Ao4QuMs0fiRVszOK9ga4Z4rDbqHPQLuG5XvgG46cikf89ws2IDls7FYMbXdSalSLM
	POpIdASsF9dZXh9IHFUoXZo2Cjrqj24uKXCAZRJ6agj6IsSoXIKfx2AH00+HS694dfIqUwwdQTT
	8GYIZhKAwwQ=
X-Google-Smtp-Source: AGHT+IGSgvBvZQd8CCejELJFSxcTouIhTLCjN6i+gokvYx+LYvSej1O7cOKbH3DC1KuS4PCD7YLjOQ==
X-Received: by 2002:a05:6a00:3d55:b0:730:7d3f:8c7d with SMTP id d2e1a72fcca58-732618c23d0mr3830636b3a.15.1739617477423;
        Sat, 15 Feb 2025 03:04:37 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:36 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	patsomaru@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 08/10] bpf: use list_head to track explored states and free list
Date: Sat, 15 Feb 2025 03:03:59 -0800
Message-ID: <20250215110411.3236773-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215110411.3236773-1-eddyz87@gmail.com>
References: <20250215110411.3236773-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch in the set needs the ability to remove individual
states from env->free_list while only holding a pointer to the state.
Which requires env->free_list to be a doubly linked list.
This patch converts env->free_list and struct bpf_verifier_state_list
to use struct list_head for this purpose. The change to
env->explored_states is collateral.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  9 +++--
 kernel/bpf/verifier.c        | 74 ++++++++++++++++++------------------
 2 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 32c23f2a3086..222f6af278ec 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -498,7 +498,7 @@ struct bpf_verifier_state {
 /* linked list of verifier states used to prune search */
 struct bpf_verifier_state_list {
 	struct bpf_verifier_state state;
-	struct bpf_verifier_state_list *next;
+	struct list_head node;
 	int miss_cnt, hit_cnt;
 };
 
@@ -710,8 +710,11 @@ struct bpf_verifier_env {
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
-	struct bpf_verifier_state_list **explored_states; /* search pruning optimization */
-	struct bpf_verifier_state_list *free_list;
+	/* Search pruning optimization, array of list_heads for
+	 * lists of struct bpf_verifier_state_list.
+	 */
+	struct list_head *explored_states;
+	struct list_head free_list;	/* list of struct bpf_verifier_state_list */
 	struct bpf_map *used_maps[MAX_USED_MAPS]; /* array of map's used by eBPF program */
 	struct btf_mod_pair used_btfs[MAX_USED_BTFS]; /* array of BTF's used by BPF program */
 	u32 used_map_cnt;		/* number of used maps */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c3f33d90fc0..1016481ea754 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1680,7 +1680,7 @@ static u32 state_htab_size(struct bpf_verifier_env *env)
 	return env->prog->len;
 }
 
-static struct bpf_verifier_state_list **explored_state(struct bpf_verifier_env *env, int idx)
+static struct list_head *explored_state(struct bpf_verifier_env *env, int idx)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
 	struct bpf_func_state *state = cur->frame[cur->curframe];
@@ -8422,10 +8422,12 @@ static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
 {
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *st;
+	struct list_head *pos, *head;
 
 	/* Explored states are pushed in stack order, most recent states come first */
-	sl = *explored_state(env, insn_idx);
-	for (; sl; sl = sl->next) {
+	head = explored_state(env, insn_idx);
+	list_for_each(pos, head) {
+		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		/* If st->branches != 0 state is a part of current DFS verification path,
 		 * hence cur & st for a loop.
 		 */
@@ -17808,20 +17810,20 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 {
 	struct bpf_verifier_state *loop_entry;
 	struct bpf_verifier_state_list *sl;
+	struct list_head *pos, *head;
 
-	sl = *explored_state(env, insn);
-	while (sl) {
+	head = explored_state(env, insn);
+	list_for_each(pos, head) {
+		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		if (sl->state.branches)
-			goto next;
+			continue;
 		loop_entry = get_loop_entry(env, &sl->state);
 		if (!IS_ERR_OR_NULL(loop_entry) && loop_entry->branches)
-			goto next;
+			continue;
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
-			goto next;
+			continue;
 		clean_verifier_state(env, &sl->state);
-next:
-		sl = sl->next;
 	}
 }
 
@@ -18512,10 +18514,11 @@ static bool iter_active_depths_differ(struct bpf_verifier_state *old, struct bpf
 static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state_list *new_sl;
-	struct bpf_verifier_state_list *sl, **pprev;
+	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state, *new, *loop_entry;
 	int i, j, n, err, states_cnt = 0;
 	bool force_new_state, add_new_state, force_exact;
+	struct list_head *pos, *tmp, *head;
 
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
 			  /* Avoid accumulating infinitely long jmp history */
@@ -18534,15 +18537,14 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	    env->insn_processed - env->prev_insn_processed >= 8)
 		add_new_state = true;
 
-	pprev = explored_state(env, insn_idx);
-	sl = *pprev;
-
 	clean_live_states(env, insn_idx, cur);
 
-	while (sl) {
+	head = explored_state(env, insn_idx);
+	list_for_each_safe(pos, tmp, head) {
+		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		states_cnt++;
 		if (sl->state.insn_idx != insn_idx)
-			goto next;
+			continue;
 
 		if (sl->state.branches) {
 			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
@@ -18747,7 +18749,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			/* the state is unlikely to be useful. Remove it to
 			 * speed up verification
 			 */
-			*pprev = sl->next;
+			list_del(&sl->node);
 			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE &&
 			    !sl->state.used_as_loop_entry) {
 				u32 br = sl->state.branches;
@@ -18763,15 +18765,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				 * walk it later. Add it for free_list instead to
 				 * be freed at the end of verification
 				 */
-				sl->next = env->free_list;
-				env->free_list = sl;
+				list_add(&sl->node, &env->free_list);
 			}
-			sl = *pprev;
-			continue;
 		}
-next:
-		pprev = &sl->next;
-		sl = *pprev;
 	}
 
 	if (env->max_states_per_insn < states_cnt)
@@ -18820,8 +18816,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	cur->first_insn_idx = insn_idx;
 	cur->insn_hist_start = cur->insn_hist_end;
 	cur->dfs_depth = new->dfs_depth + 1;
-	new_sl->next = *explored_state(env, insn_idx);
-	*explored_state(env, insn_idx) = new_sl;
+	list_add(&new_sl->node, head);
+
 	/* connect new state to parentage chain. Current frame needs all
 	 * registers connected. Only r6 - r9 of the callers are alive (pushed
 	 * to the stack implicitly by JITs) so in callers' frames connect just
@@ -22138,31 +22134,29 @@ static int remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 
 static void free_states(struct bpf_verifier_env *env)
 {
-	struct bpf_verifier_state_list *sl, *sln;
+	struct bpf_verifier_state_list *sl;
+	struct list_head *head, *pos, *tmp;
 	int i;
 
-	sl = env->free_list;
-	while (sl) {
-		sln = sl->next;
+	list_for_each_safe(pos, tmp, &env->free_list) {
+		sl = container_of(pos, struct bpf_verifier_state_list, node);
 		free_verifier_state(&sl->state, false);
 		kfree(sl);
-		sl = sln;
 	}
-	env->free_list = NULL;
+	INIT_LIST_HEAD(&env->free_list);
 
 	if (!env->explored_states)
 		return;
 
 	for (i = 0; i < state_htab_size(env); i++) {
-		sl = env->explored_states[i];
+		head = &env->explored_states[i];
 
-		while (sl) {
-			sln = sl->next;
+		list_for_each_safe(pos, tmp, head) {
+			sl = container_of(pos, struct bpf_verifier_state_list, node);
 			free_verifier_state(&sl->state, false);
 			kfree(sl);
-			sl = sln;
 		}
-		env->explored_states[i] = NULL;
+		INIT_LIST_HEAD(&env->explored_states[i]);
 	}
 }
 
@@ -23120,12 +23114,16 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
 
 	env->explored_states = kvcalloc(state_htab_size(env),
-				       sizeof(struct bpf_verifier_state_list *),
+				       sizeof(struct list_head),
 				       GFP_USER);
 	ret = -ENOMEM;
 	if (!env->explored_states)
 		goto skip_full_check;
 
+	for (i = 0; i < state_htab_size(env); i++)
+		INIT_LIST_HEAD(&env->explored_states[i]);
+	INIT_LIST_HEAD(&env->free_list);
+
 	ret = check_btf_info_early(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.48.1


