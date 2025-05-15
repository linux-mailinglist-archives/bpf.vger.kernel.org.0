Return-Path: <bpf+bounces-58285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EDEAB8526
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 13:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D23716C000
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EA0297B62;
	Thu, 15 May 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRJv+f8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BF31DD873
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309557; cv=none; b=jK5tmzRN3lFTy5PeJYRWg1kSGUPT98VnRZ9yvlT5i2oVkJ9NkCP9zTPkev9sNnoxphfMNlU8SpYf/KkWIHJe8aTPTz7okut7fLPNFtrIhiwy8mACtBqSSc6Elg51jGvo2Kt+Kr/WYyEystOIwhB6Iso5LgrIGx2cGiPDkKs63eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309557; c=relaxed/simple;
	bh=yoypDI2IJwR69RW/KrS2yj8ulZjIRZBabt+HJXnc3oc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=POTZZeNznC//nBP6yszlXAjQ1x0+FZSxVWWaw6ZResI0g4G9b9Hthy2JUe2sviW0BEsLbUF9RBO50Zl6cWcBzCVbm03gl+RpwGA5Oechby/rEjuUCXDsDBYRaqkEfO0AHDExKLIg+umMdrtnwYmqLNPEcUgGqiclESyZMZUqnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRJv+f8D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so15098675e9.1
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747309553; x=1747914353; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCogRsIG4EQ2fdX9qBC72sn2w4Yo2Qma/I4Lr1WW9KQ=;
        b=XRJv+f8D/qHHlFw2RWLgFGnM435C/AnS1S3e8He7tYlruffs/LmjeHhVnNrPc6iLFs
         doQsYo529A/eabPkWTPd8do4iO6vCWpWsxP0QVKaN9zEHXdKtA0NqrTUl3SoUuGRwAEb
         vkhiT4JQ7PsCXbC7aDs2qtQy5d0Nd3QBLHfjk97ICF9QpzahWP1uv4SppuJg5xFaYhu1
         kom2DSRRKXlajuLmH8sVqYEPMQ06xTaNSuqFMaJvvU/LgLc0mtTs4iIs6zANTj5tgU4/
         4J8cGBolPPC/YyCxbp2MA20Le3/Juw/rY8qEjofQGLsWcQSRxdcsav/fcY+x4OwWoTbX
         oYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747309553; x=1747914353;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCogRsIG4EQ2fdX9qBC72sn2w4Yo2Qma/I4Lr1WW9KQ=;
        b=XOa5N2ohfQuPTFK20ff0MXxOTkxbD6zence5ifk7ZbFBdbCvqyK5cXgttONzP+KAjd
         6PnaEvSPbSZ81I75ComMWwKyunaP/fXKcD9sWXCoYSK+ALjSlf3ylqcIhzDYkW3NfuES
         rQCn8xJOrihqk3h1PgF6+ZcsEkgqAFFtUQQ95T7ud60CDCRHCr3HmwObiHh464FaKFNb
         79JfqdTQLOQ2C3lgYmCZHZdEaJIkK8zDIjgwQQ/gSsR48zqlJPq3zhslODsJLd4A2rVy
         sSJ/sBi540YwmvX/NrbBg+d5JAQVkli92FxCCGvef4g/+atwJOCsDI3gC5kvGKkUEpWI
         Bj/A==
X-Gm-Message-State: AOJu0YzhJ2fJhcpkgk8Y1ccdTt4pRwZcsyviRlZ6HxPm51h2dHekC8VY
	bb/U77ItXiZS8WPDo9YqGJqdfrGhUrWvHs3a90bSobShhYO2R7Zqu2p4wW+TqA==
X-Gm-Gg: ASbGnct+2UNj744DCm6VkktgQamrUgCVW7hwHlyluhQcbJPC/6v87wZjvAv99XdAsFg
	QLXNixaHFXyhMgJ9qXBgfc/TTY/KzrAsizBHjL0wxMdETNqTCT+TPN4v1vVkpHcpoHDo5bM3O+F
	mzHw5z9fYYqSFGBN0Db4Af3+6rCfRzpEAg4blbgV6XI/2kXoDUi+g8F6Ctn9hpPxjn+mLXC/OVS
	ActXnG7JiUhOBgzul9cu3O7g/G2juGQVuZyFvB8J/Omlp7CPhjaLJ5TXO5/6+AlpkYK/0pB3YfW
	gIrhUS74vR8BRFT+yZ/Qzs8W5ofGqDTPY88xJCS6seaOiw4RNTwinOIx8dsb7B+dja6akOJNgBC
	Qu0NGZ4e/MLasliHEDuN7ithgAUZeYd8JZzCQbqkEtrOLEIeu
X-Google-Smtp-Source: AGHT+IG+MvrlwT2J5ustfqvU2r0Mu/34fFy+P3qociM6wR0dczyCbC6xgmBhhxYWi9C7xG7KNsAcKA==
X-Received: by 2002:a05:600c:510e:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-442f84ca35amr24202495e9.4.1747309552674;
        Thu, 15 May 2025 04:45:52 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e008d04156504b0d7b1.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8d04:1565:4b0:d7b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f396c3a4sm68414755e9.26.2025.05.15.04.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:45:51 -0700 (PDT)
Date: Thu, 15 May 2025 13:45:50 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3] bpf: WARN_ONCE on verifier bugs
Message-ID: <aCXT7kLv-SHy44Vx@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Throughout the verifier's logic, there are multiple checks for
inconsistent states that should never happen and would indicate a
verifier bug. These bugs are typically logged in the verifier logs and
sometimes preceded by a WARN_ONCE.

This patch reworks these checks to consistently emit a verifier log AND
a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
where they are actually able to reach one of those buggy verifier
states.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v3:
  - Introduce and use verifier_bug_if, as suggested by Andrii.
Changes in v2:
  - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
    CONFIG_DEBUG_KERNEL, as per reviews.
  - Use the new helper function for verifier bugs missed in v1,
    particularly around backtracking.

 include/linux/bpf.h          |   6 ++
 include/linux/bpf_verifier.h |  10 +++
 kernel/bpf/btf.c             |   4 +-
 kernel/bpf/verifier.c        | 121 ++++++++++++++++-------------------
 4 files changed, 74 insertions(+), 67 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 83c56f40842b..5b25d278409b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -346,6 +346,12 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 	}
 }
 
+#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
+#define BPF_WARN_ONCE(cond, format...) WARN_ONCE(cond, format)
+#else
+#define BPF_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
+#endif
+
 static inline u32 btf_field_type_size(enum btf_field_type type)
 {
 	switch (type) {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cedd66867ecf..c3fd6905793a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -839,6 +839,16 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...);
 
+#define verifier_bug_if(cond, env, fmt, args...)				\
+	({									\
+		if (unlikely(cond)) {						\
+			BPF_WARN_ONCE(1, "verifier bug: " fmt, ##args);		\
+			bpf_log(&env->log, "verifier bug: " fmt, ##args);	\
+		}								\
+		(cond);								\
+	})
+#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)
+
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b21ca67070c..743b45d80269 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7659,7 +7659,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		return 0;
 
 	if (!prog->aux->func_info) {
-		bpf_log(log, "Verifier bug\n");
+		verifier_bug(env, "func_info undefined\n");
 		return -EFAULT;
 	}
 
@@ -7683,7 +7683,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	tname = btf_name_by_offset(btf, fn_t->name_off);
 
 	if (prog->aux->func_info_aux[subprog].unreliable) {
-		bpf_log(log, "Verifier bug in function %s()\n", tname);
+		verifier_bug(env, "unreliable BTF for function %s()\n", tname);
 		return -EFAULT;
 	}
 	if (prog_type == BPF_PROG_TYPE_EXT)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6d3655b3a7a..8ab6b65f136d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1925,8 +1925,7 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 
 	while (topmost && topmost->loop_entry) {
 		if (steps++ > st->dfs_depth) {
-			WARN_ONCE(true, "verifier bug: infinite loop in get_loop_entry\n");
-			verbose(env, "verifier bug: infinite loop in get_loop_entry()\n");
+			verifier_bug(env, "infinite loop in get_loop_entry\n");
 			return ERR_PTR(-EFAULT);
 		}
 		topmost = topmost->loop_entry;
@@ -3461,9 +3460,9 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 		if (writes && state->live & REG_LIVE_WRITTEN)
 			break;
 		if (parent->live & REG_LIVE_DONE) {
-			verbose(env, "verifier BUG type %s var_off %lld off %d\n",
-				reg_type_str(env, parent->type),
-				parent->var_off.value, parent->off);
+			verifier_bug(env, "type %s var_off %lld off %d\n",
+				     reg_type_str(env, parent->type),
+				     parent->var_off.value, parent->off);
 			return -EFAULT;
 		}
 		/* The first condition is more likely to be true than the
@@ -3858,14 +3857,14 @@ static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_s
 		/* atomic instructions push insn_flags twice, for READ and
 		 * WRITE sides, but they should agree on stack slot
 		 */
-		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
-			  (env->cur_hist_ent->flags & insn_flags) != insn_flags,
-			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
-			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
+		verifier_bug_if((env->cur_hist_ent->flags & insn_flags) &&
+				(env->cur_hist_ent->flags & insn_flags) != insn_flags,
+				env, "insn history: insn_idx %d cur flags %x new flags %x\n",
+				env->insn_idx, env->cur_hist_ent->flags, insn_flags);
 		env->cur_hist_ent->flags |= insn_flags;
-		WARN_ONCE(env->cur_hist_ent->linked_regs != 0,
-			  "verifier insn history bug: insn_idx %d linked_regs != 0: %#llx\n",
-			  env->insn_idx, env->cur_hist_ent->linked_regs);
+		verifier_bug_if(env->cur_hist_ent->linked_regs != 0, env,
+				"insn history: insn_idx %d linked_regs != 0: %#llx\n",
+				env->insn_idx, env->cur_hist_ent->linked_regs);
 		env->cur_hist_ent->linked_regs = linked_regs;
 		return 0;
 	}
@@ -3988,8 +3987,7 @@ static inline u32 bt_empty(struct backtrack_state *bt)
 static inline int bt_subprog_enter(struct backtrack_state *bt)
 {
 	if (bt->frame == MAX_CALL_FRAMES - 1) {
-		verbose(bt->env, "BUG subprog enter from frame %d\n", bt->frame);
-		WARN_ONCE(1, "verifier backtracking bug");
+		verifier_bug(bt->env, "subprog enter from frame %d\n", bt->frame);
 		return -EFAULT;
 	}
 	bt->frame++;
@@ -3999,8 +3997,7 @@ static inline int bt_subprog_enter(struct backtrack_state *bt)
 static inline int bt_subprog_exit(struct backtrack_state *bt)
 {
 	if (bt->frame == 0) {
-		verbose(bt->env, "BUG subprog exit from frame 0\n");
-		WARN_ONCE(1, "verifier backtracking bug");
+		verifier_bug(bt->env, "subprog exit from frame 0\n");
 		return -EFAULT;
 	}
 	bt->frame--;
@@ -4278,14 +4275,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * should be literally next instruction in
 				 * caller program
 				 */
-				WARN_ONCE(idx + 1 != subseq_idx, "verifier backtracking bug");
+				verifier_bug_if(idx + 1 != subseq_idx, env,
+						"extra insn from subprog");
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
 				 */
 				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-					WARN_ONCE(1, "verifier backtracking bug");
+					verifier_bug(env, "scratch reg set: regs %x\n",
+						     bt_reg_mask(bt));
 					return -EFAULT;
 				}
 				/* global subprog always sets R0 */
@@ -4299,16 +4297,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * the current frame should be zero by now
 				 */
 				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
-					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-					WARN_ONCE(1, "verifier backtracking bug");
+					verifier_bug(env, "unexpected precise regs %x\n",
+						     bt_reg_mask(bt));
 					return -EFAULT;
 				}
 				/* we are now tracking register spills correctly,
 				 * so any instance of leftover slots is a bug
 				 */
 				if (bt_stack_mask(bt) != 0) {
-					verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
-					WARN_ONCE(1, "verifier backtracking bug (subprog leftover stack slots)");
+					verifier_bug(env, "subprog leftover stack slots %llx\n",
+						     bt_stack_mask(bt));
 					return -EFAULT;
 				}
 				/* propagate r1-r5 to the caller */
@@ -4331,13 +4329,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * not actually arguments passed directly to callback subprogs
 			 */
 			if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "unexpected precise regs %x\n",
+					     bt_reg_mask(bt));
 				return -EFAULT;
 			}
 			if (bt_stack_mask(bt) != 0) {
-				verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug (callback leftover stack slots)");
+				verifier_bug(env, "callback leftover stack slots %llx\n",
+					     bt_stack_mask(bt));
 				return -EFAULT;
 			}
 			/* clear r1-r5 in callback subprog's mask */
@@ -4359,8 +4357,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				/* if backtracing was looking for registers R1-R5
 				 * they should have been found already.
 				 */
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "regs not found %x\n", bt_reg_mask(bt));
 				return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
@@ -4378,8 +4375,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "regs not found %x\n", bt_reg_mask(bt));
 				return -EFAULT;
 			}
 
@@ -4720,9 +4716,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				return 0;
 			}
 
-			verbose(env, "BUG backtracking func entry subprog %d reg_mask %x stack_mask %llx\n",
-				st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
-			WARN_ONCE(1, "verifier backtracking bug");
+			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %llx\n",
+				     st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
 			return -EFAULT;
 		}
 
@@ -4758,8 +4753,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				 * It means the backtracking missed the spot where
 				 * particular register was initialized with a constant.
 				 */
-				verbose(env, "BUG backtracking idx %d\n", i);
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "backtracking idx %d\n", i);
 				return -EFAULT;
 			}
 		}
@@ -4785,9 +4779,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
 			for_each_set_bit(i, mask, 64) {
 				if (i >= func->allocated_stack / BPF_REG_SIZE) {
-					verbose(env, "BUG backtracking (stack slot %d, total slots %d)\n",
-						i, func->allocated_stack / BPF_REG_SIZE);
-					WARN_ONCE(1, "verifier backtracking bug (stack slot out of bounds)");
+					verifier_bug(env, "stack slot %d, total slots %d\n",
+						     i, func->allocated_stack / BPF_REG_SIZE);
 					return -EFAULT;
 				}
 
@@ -6563,13 +6556,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		next_insn = i + insn[i].imm + 1;
 		sidx = find_subprog(env, next_insn);
 		if (sidx < 0) {
-			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-				  next_insn);
+			verifier_bug(env, "No program starts at insn %d\n",
+				     next_insn);
 			return -EFAULT;
 		}
 		if (subprog[sidx].is_async_cb) {
 			if (subprog[sidx].has_tail_call) {
-				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
+				verifier_bug(env, "subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
 			/* async callbacks don't increase bpf prog stack size unless called directly */
@@ -6677,8 +6670,8 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 
 	subprog = find_subprog(env, start);
 	if (subprog < 0) {
-		WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-			  start);
+		verifier_bug(env, "No program starts at insn %d\n",
+			     start);
 		return -EFAULT;
 	}
 	return env->subprog_info[subprog].stack_depth;
@@ -7985,7 +7978,7 @@ static int check_stack_range_initialized(
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
-			verbose(env, "verifier bug: allocated_stack too small\n");
+			verbose(env, "allocated_stack too small\n");
 			return -EFAULT;
 		}
 
@@ -8414,7 +8407,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (meta->map_ptr) {
-		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
+		verifier_bug(env, "Two map pointers in a timer helper\n");
 		return -EFAULT;
 	}
 	meta->map_uid = reg->map_uid;
@@ -10286,8 +10279,8 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	}
 
 	if (state->frame[state->curframe + 1]) {
-		verbose(env, "verifier bug. Frame %d already allocated\n",
-			state->curframe + 1);
+		verifier_bug(env, "Frame %d already allocated\n",
+			     state->curframe + 1);
 		return -EFAULT;
 	}
 
@@ -10401,8 +10394,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (err)
 				return err;
 		} else {
-			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
-				i, arg->arg_type);
+			verifier_bug(env, "unrecognized arg#%d type %d\n",
+				     i, arg->arg_type);
 			return -EFAULT;
 		}
 	}
@@ -10465,13 +10458,13 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
-		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
-			func_id_name(insn->imm), insn->imm);
+		verifier_bug(env, "kfunc %s#%d not marked as callback-calling\n",
+			     func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
 	} else if (!bpf_pseudo_kfunc_call(insn) &&
 		   !is_callback_calling_function(insn->imm)) { /* helper */
-		verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
-			func_id_name(insn->imm), insn->imm);
+		verifier_bug(env, "helper %s#%d not marked as callback-calling\n",
+			     func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
 	}
 
@@ -10524,7 +10517,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	target_insn = *insn_idx + insn->imm + 1;
 	subprog = find_subprog(env, target_insn);
 	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n", target_insn);
+		verifier_bug(env, "No program starts at insn %d\n", target_insn);
 		return -EFAULT;
 	}
 
@@ -11125,7 +11118,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
 	if (err) {
-		verbose(env, "verifier bug\n");
+		verbose(env, "failed to retrieve map value address\n");
 		return -EFAULT;
 	}
 	fmt = (char *)(long)fmt_addr + fmt_map_off;
@@ -19706,10 +19699,9 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
-						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+					if (verifier_bug_if(env->cur_state->loop_entry, env,
+							    "cur_state->loop_entry not null\n"))
 						return -EFAULT;
-					}
 					do_print_state = true;
 					continue;
 				}
@@ -20767,10 +20759,9 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		if (bpf_pseudo_kfunc_call(&insn))
 			continue;
 
-		if (WARN_ON(load_reg == -1)) {
-			verbose(env, "verifier bug. zext_dst is set, but no reg is defined\n");
+		if (verifier_bug_if(load_reg == -1, env,
+				    "zext_dst is set, but no reg is defined\n"))
 			return -EFAULT;
-		}
 
 		zext_patch[0] = insn;
 		zext_patch[1].dst_reg = load_reg;
@@ -21088,8 +21079,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 */
 		subprog = find_subprog(env, i + insn->imm + 1);
 		if (subprog < 0) {
-			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-				  i + insn->imm + 1);
+			verifier_bug(env, "No program starts at insn %d\n",
+				     i + insn->imm + 1);
 			return -EFAULT;
 		}
 		/* temporarily remember subprog id inside insn instead of
@@ -22454,7 +22445,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		/* We need two slots in case timed may_goto is supported. */
 		if (stack_slots > slots) {
-			verbose(env, "verifier bug: stack_slots supports may_goto only\n");
+			verifier_bug(env, "stack_slots supports may_goto only\n");
 			return -EFAULT;
 		}
 
-- 
2.43.0


