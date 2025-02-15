Return-Path: <bpf+bounces-51652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB02A36D91
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C118968D9
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580A70824;
	Sat, 15 Feb 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMClMz6u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DDF1A841A
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617476; cv=none; b=GJ6VvaMlg5x7z3bOzlrnCTbeNFrQ64685O1iloeBpUY5XlDzc3RoElNdj+HcpVh5DkPEUj/RWbJruMJXp78udYiBZPxQavCI4BGqXThZSaT/bEonkBWo50sYzcI80U/XYLvPPaQFk9doFDkJUDZ+hbhEfkZ+zFt+L5qtHFdGqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617476; c=relaxed/simple;
	bh=i+7JT73zOvHWrIOe7tS5snCvt4cQ5nFjNPFm4hDEZfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLRRNDFa27RuXwwhkyB2bMIc3ZlmOIt3RiQdzNNdXoa5HrDqJ6eg0Oyg8KI3E7/XJn/qK8bINgI2r2wJh9u8DaPyHW4lrO77TJPowiZFweRCicUS5fNNViv4nKwAixtbf9O/Ju6vIArbaWUmUBW5RhgOO4+T5WY4iylpLzmhaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMClMz6u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c8f38febso53510565ad.2
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 03:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739617474; x=1740222274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjlDCIWwGo32gH8E4EO6vOfzFuAH4iigeCMDvhoWpo0=;
        b=SMClMz6ucR5Omywge9Mh5Nh8UqOATPYVXnMpcs/A2UjVTE1u9hHLB3q2dfQKX0bs/9
         mQdBXWcBOTPBQjIlwHhPWQ7KFUENqgbSx/LLIkSC3yy93O6Zj63IMlPfU/myQGhWomY5
         4GqFO0smXDKyFfcul9L8XGwicdSeTlsD/1BdcVlcQPvUtNBOmDAeYZfwULCozlkPAqpp
         Vgnz2SDpGWxZJ+A7iuqL0Apzue5FFU3j8smvrKZcXNwUFivvfeA/fSxbomGGxMAVFpOw
         4EEeDLllKhtaItIn5INBUc+Tx919oZH1K7XbOd0PSKS38t9Pj32Ya1ut/92iJp5KsBpo
         fCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617474; x=1740222274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjlDCIWwGo32gH8E4EO6vOfzFuAH4iigeCMDvhoWpo0=;
        b=X0fxyQaETa57npwtOKl2iRFMJw3342vDl1V1dc/RzkYxzIxmLCuYR3iUSB2eYmMCTr
         Ov3Ya7+2/WEFztgmpwN2FVg8t+WXD4xjWisZYY1gymgqhkdPXACsXvWKgNhzHuxbdK+T
         n2NIzDJRh/OsFZwbv9QJ/bFOPGbglJm0xRiEbdHPamgBWa4XXXVm9z+2stgn7cqHfrRz
         d5wo9vhWbV9zU3L9jPK8sMhbyz8CRPiQWCBDuygV9AUCotjOYpoa4NwtYHxRueHFVAnz
         tDkBvTJ5RA2964x4/ODUg+lQnPI69rwbrfx3hxOVyyb3136i0VpIjdWZ4BCVfF5IGatE
         4DLg==
X-Gm-Message-State: AOJu0YzxoyGCfj+A3BgodX7OUqwfbuiRiKIkLYvVyChqfoMBYRZJhxiD
	ENQbr5siO3KOVuoBmNdN3g7p4+0ZjTkFEKR7MN0FBfPUqi2mWHwY7bHdEg==
X-Gm-Gg: ASbGncurhEoar5ByTpOxwF0SK+KhclX00m28pGLyC9lhvO8+nhiaRCChqu5XT1xDVq3
	aj0nSeU/cSmiNdAWzoF377Vya/9aNCcMH6XWxRuIFYIUu95bgYPD4s/r+sCe4J/mHDclc9dGU9k
	JBpwDwl2lQVsS0Pr8gicvi6bGodmY5Erj7jocs+/BL/fD2byFxeLR2W0p8kxmQA5S1eIQYiTCE/
	3E7hRLmpIKs8b4SiTzOlYfYUCs5UDo84yihMxHQhUwSJgbvxIgyMqLJ9VPfVuJAk+ufIjt3PhLR
	NmsqhnXeGSM=
X-Google-Smtp-Source: AGHT+IHT9oB1SgXYNBRy7hYEqPtbU8hieBvqAPfkxvPBRC7SeX+MWqWTqS/auVERHXO+6W5ozAL3Hw==
X-Received: by 2002:a05:6a21:4ccc:b0:1e1:aa10:5491 with SMTP id adf61e73a8af0-1ee8cb814bbmr5942181637.24.1739617473760;
        Sat, 15 Feb 2025 03:04:33 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326d58d4d0sm72435b3a.94.2025.02.15.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 03:04:33 -0800 (PST)
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
Subject: [PATCH bpf-next v1 05/10] bpf: detect infinite loop in get_loop_entry()
Date: Sat, 15 Feb 2025 03:03:56 -0800
Message-ID: <20250215110411.3236773-6-eddyz87@gmail.com>
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

Tejun Heo reported an infinite loop in get_loop_entry(),
when verifying a sched_ext program layered_dispatch in [1].
After some investigation I'm sure that root cause is fixed by patches
1,3 in this patch-set.

To err on the safe side, this commit modifies get_loop_entry() to
detect infinite loops and abort verification in such cases.
The number of steps get_loop_entry(S) can make while moving along the
bpf_verifier_state->loop_entry chain is bounded by the DFS depth of
state S. This fact is exploited to implement the check.

To avoid dealing with the potential error code returned from
get_loop_entry() in update_loop_entry(), remove the get_loop_entry()
calls there:
- This change does not affect correctness. Loop entries would still be
  updated during the backward DFS move in update_branch_counts().
- This change does not affect performance. Measurements show that
  get_loop_entry() performs at most 1 step on selftests and at most 2
  steps on sched_ext programs (1 step in 17 cases, 2 steps in 3
  cases, measured using "do-not-submit" patches from [2]).

[1] https://github.com/sched-ext/scx/
    commit f0b27038ea10 ("XXX - kernel stall")
[2] https://github.com/eddyz87/bpf/tree/get-loop-entry-hungup

Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 945a13b2cfeb..f750c8607470 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1792,12 +1792,9 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
  *             h = entries[h]
  *         return h
  *
- *     # Update n's loop entry if h's outermost entry comes
- *     # before n's outermost entry in current DFS path.
+ *     # Update n's loop entry if h comes before n in current DFS path.
  *     def update_loop_entry(n, h):
- *         n1 = get_loop_entry(n) or n
- *         h1 = get_loop_entry(h) or h
- *         if h1 in path and depths[h1] <= depths[n1]:
+ *         if h in path and depths[entries.get(n, n)] < depths[n]:
  *             entries[n] = h1
  *
  *     def dfs(n, depth):
@@ -1809,7 +1806,7 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
  *                 # Case A: explore succ and update cur's loop entry
  *                 #         only if succ's entry is in current DFS path.
  *                 dfs(succ, depth + 1)
- *                 h = get_loop_entry(succ)
+ *                 h = entries.get(succ, None)
  *                 update_loop_entry(n, h)
  *             else:
  *                 # Case B or C depending on `h1 in path` check in update_loop_entry().
@@ -1824,12 +1821,20 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
  * - handle cases B and C in is_state_visited();
  * - update topmost loop entry for intermediate states in get_loop_entry().
  */
-static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_state *st)
+static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
+						 struct bpf_verifier_state *st)
 {
 	struct bpf_verifier_state *topmost = st->loop_entry, *old;
+	u32 steps = 0;
 
-	while (topmost && topmost->loop_entry && topmost != topmost->loop_entry)
+	while (topmost && topmost->loop_entry && topmost != topmost->loop_entry) {
+		if (steps++ > st->dfs_depth) {
+			WARN_ONCE(true, "verifier bug: infinite loop in get_loop_entry\n");
+			verbose(env, "verifier bug: infinite loop in get_loop_entry()\n");
+			return ERR_PTR(-EFAULT);
+		}
 		topmost = topmost->loop_entry;
+	}
 	/* Update loop entries for intermediate states to avoid this
 	 * traversal in future get_loop_entry() calls.
 	 */
@@ -1843,17 +1848,13 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_state *st)
 
 static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf_verifier_state *hdr)
 {
-	struct bpf_verifier_state *cur1, *hdr1;
-
-	cur1 = get_loop_entry(cur) ?: cur;
-	hdr1 = get_loop_entry(hdr) ?: hdr;
-	/* The head1->branches check decides between cases B and C in
-	 * comment for get_loop_entry(). If hdr1->branches == 0 then
+	/* The hdr->branches check decides between cases B and C in
+	 * comment for get_loop_entry(). If hdr->branches == 0 then
 	 * head's topmost loop entry is not in current DFS path,
 	 * hence 'cur' and 'hdr' are not in the same loop and there is
 	 * no need to update cur->loop_entry.
 	 */
-	if (hdr1->branches && hdr1->dfs_depth <= cur1->dfs_depth) {
+	if (hdr->branches && hdr->dfs_depth <= (cur->loop_entry ?: cur)->dfs_depth) {
 		cur->loop_entry = hdr;
 		hdr->used_as_loop_entry = true;
 	}
@@ -17821,8 +17822,8 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 	while (sl) {
 		if (sl->state.branches)
 			goto next;
-		loop_entry = get_loop_entry(&sl->state);
-		if (loop_entry && loop_entry->branches)
+		loop_entry = get_loop_entry(env, &sl->state);
+		if (!IS_ERR_OR_NULL(loop_entry) && loop_entry->branches)
 			goto next;
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
@@ -18700,7 +18701,9 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 *
 		 * Additional details are in the comment before get_loop_entry().
 		 */
-		loop_entry = get_loop_entry(&sl->state);
+		loop_entry = get_loop_entry(env, &sl->state);
+		if (IS_ERR(loop_entry))
+			return PTR_ERR(loop_entry);
 		force_exact = loop_entry && loop_entry->branches > 0;
 		if (states_equal(env, &sl->state, cur, force_exact ? RANGE_WITHIN : NOT_EXACT)) {
 			if (force_exact)
-- 
2.48.1


