Return-Path: <bpf+bounces-58184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8CAB6A19
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 13:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C16F4C00FD
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A62701B1;
	Wed, 14 May 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1+IGMGE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264961A0BE1
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222523; cv=none; b=cH7x4NW+2ie2PXLCZa2a/Zvi97YOWNkX4mQc6tfvaBc2P0LYFrcK8QOuNUEwJnx3hJjKqUi8q9EnTXP0/O1UDusu3ZOjgJDJOIQL2tfG9xV8yHwfXRrJIYr4dqHyZdKEn2lgnKADTFc0zN4ZX000isFtiMDaWVTM+fRCJuBPoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222523; c=relaxed/simple;
	bh=CNOo0E8a2madFfSVo1/LCgZOJ7PBZTWt5+Du6kW+vw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sqHdPmRlMDv9Ym8OnsXlYAB/D/drX6UrVhs3pWx13iRtT3cgZOKcchB8Yeld4NMoMXWBOT5JNU5pQD0/uiFk9DOk+5B4w0YPDp56kHv/2ZI9E9xtGK0J3VEwNVEFj7Tm9JqhuFq8tIVLdLMf4hfAXUhK8e88j8GPWyLmiwC+TVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1+IGMGE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so6552224f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747222519; x=1747827319; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cz+r1b2V+1J8dEqWSicbGdUnDOA7Ul8oPIEDqBeRRkg=;
        b=W1+IGMGEmK7XwegTqRWQ+WE2IOhMOpUdgG6s0yB1XGcGJYMbjXuLSH8EZz0JrSbscQ
         4d3Ft8IaYy3XaRXlw8YsMtfxKN2JVhCh6GtzE6u38qZTTq0H1PkBkTyLbaZXz/6EE2OL
         hnnewQ/0m4sIG0Jqv8ifMOBrRtg4MuIpusVP9i1J7C1xAf6kNYmlfmaGePGuM3BLfEIj
         +yW6dnKv5NtjQP72VnbkpMDKISDK4bgoFxY3AS5xMi9aamhZmrPwifm45rmDvYB4CgJE
         Vfhux1SjMGdrZSupB2xNOr1rTZfV/vLuzljWuoL/197V5WDoRpcMbI6r7tYrwe5KjTJV
         SQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747222519; x=1747827319;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz+r1b2V+1J8dEqWSicbGdUnDOA7Ul8oPIEDqBeRRkg=;
        b=o715ZEbGONdOFhZDjffgjBpePh6XgxawJvFCqn4Pz29qjXJRC/yK87I9JgNwu8wjfw
         RemPYev03QLuKQqmv7YADqna1NxH7vVsiX0UR6E9jklQ9HZ5q491T3GUGj8KhQtvKwTk
         TQWV10UPJFP1h0ZlJUaa2l2KgZNz8bqfuvGmb9iqM1HqX5sJMz7NgKAyH8PGlo2lYEnZ
         bpkuZSzEWZzQGjilyIUzl6c4H8AO1+ukmY9fHrlDg/mTzOEkZa0SskCCfvdtr7ke8TSC
         Y5UtxXFckHlOZ/exI5TQKEtc2UX9CGPI25oGZW6ItCHbrIPoKtx//aOAKQB+QRX0+31o
         LyEA==
X-Gm-Message-State: AOJu0Yx2fvqDJYGCfvvpvpvpnfwVOOqtZe3BbIefxcDS/ktzmCjl47IK
	7viRD3wWRrzkU6ap24gIQpAyKE8AsYXiJraXBwRL6TwbF6qTI4NJCF36kg==
X-Gm-Gg: ASbGncs+s1tCwg5MqOspjsh6q7M7Eb4td47EgTLWPxUKYCxC1BnDsx4qSHtOWHuczo1
	0pLFj9H/x+DM5BCNar8CH3PinE6VKgrR86t7OIHJF6y3IXV5VZX1Ixvyh0sIMmLup1gzOm7LBAg
	zvvlMFIe/UjgP8cIM8nTnZ2fJtJi5082FQc+cULVIhgo/26QIwu7pglcfnaQjQgEOhOVvRCYcGa
	EHQqq78zs8oxubby5v/7jIjBzgHq63TWEDIAAx/xECYsC2Sl5d0jjOmMH784a2jQwyIw0Uz8gL0
	p8NIZbTnqd4m4kveu36W0j8moVNR7EkKlFMm+Obb/eBohygUhHh3MYrJcr3CXGnR+75ovcjn2/9
	/IpjXqg4k4GJwLaVtkZDIIB6105ohiGjP7ESkUZOKJ9BG23RyN4xg2ROH2CWu
X-Google-Smtp-Source: AGHT+IEVzK6HzhqEXIQl5fElXMA6+7gPKZwie2nB2bbs/u3GBL6U/eBIQEoZAopiYjSDcg4ySVwK5Q==
X-Received: by 2002:a05:6000:2908:b0:3a3:4b8a:b2f1 with SMTP id ffacd0b85a97d-3a34b8ab3f6mr1904840f8f.16.1747222519164;
        Wed, 14 May 2025 04:35:19 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00115f8f671ea56e36.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:115f:8f67:1ea5:6e36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2af7sm19657081f8f.52.2025.05.14.04.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 04:35:18 -0700 (PDT)
Date: Wed, 14 May 2025 13:35:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2] bpf: WARN_ONCE on verifier bugs
Message-ID: <aCR_9Ahv4DpvK-Vy@mail.gmail.com>
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
Changes in v2:
  - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
    CONFIG_DEBUG_KERNEL, as per reviews.
  - Use the new helper function for verifier bugs missed in v1,
    particularly around backtracking.

 include/linux/bpf.h          |   6 ++
 include/linux/bpf_verifier.h |   6 ++
 kernel/bpf/btf.c             |   4 +-
 kernel/bpf/verifier.c        | 119 +++++++++++++++++------------------
 4 files changed, 70 insertions(+), 65 deletions(-)

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
index 9734544b6957..6f809ad3d3dd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -838,6 +838,12 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...);
 
+#define verifier_bug(env, fmt, args...)					\
+	do {								\
+		BPF_WARN_ONCE(1, "verifier bug: " fmt, ##args);		\
+		bpf_log(&env->log, "verifier bug: " fmt, ##args);	\
+	} while (0)
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
index 28f5a7899bd6..49eea17c7b17 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1924,8 +1924,7 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 
 	while (topmost && topmost->loop_entry) {
 		if (steps++ > st->dfs_depth) {
-			WARN_ONCE(true, "verifier bug: infinite loop in get_loop_entry\n");
-			verbose(env, "verifier bug: infinite loop in get_loop_entry()\n");
+			verifier_bug(env, "infinite loop in get_loop_entry\n");
 			return ERR_PTR(-EFAULT);
 		}
 		topmost = topmost->loop_entry;
@@ -3460,9 +3459,9 @@ static int mark_reg_read(struct bpf_verifier_env *env,
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
@@ -3857,14 +3856,14 @@ static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_s
 		/* atomic instructions push insn_flags twice, for READ and
 		 * WRITE sides, but they should agree on stack slot
 		 */
-		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
-			  (env->cur_hist_ent->flags & insn_flags) != insn_flags,
-			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
-			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
+		if (unlikely((env->cur_hist_ent->flags & insn_flags) &&
+			     (env->cur_hist_ent->flags & insn_flags) != insn_flags))
+			verifier_bug(env, "insn history: insn_idx %d cur flags %x new flags %x\n",
+				     env->insn_idx, env->cur_hist_ent->flags, insn_flags);
 		env->cur_hist_ent->flags |= insn_flags;
-		WARN_ONCE(env->cur_hist_ent->linked_regs != 0,
-			  "verifier insn history bug: insn_idx %d linked_regs != 0: %#llx\n",
-			  env->insn_idx, env->cur_hist_ent->linked_regs);
+		if (unlikely(env->cur_hist_ent->linked_regs != 0))
+			verifier_bug(env, "insn history: insn_idx %d linked_regs != 0: %#llx\n",
+				     env->insn_idx, env->cur_hist_ent->linked_regs);
 		env->cur_hist_ent->linked_regs = linked_regs;
 		return 0;
 	}
@@ -3987,8 +3986,7 @@ static inline u32 bt_empty(struct backtrack_state *bt)
 static inline int bt_subprog_enter(struct backtrack_state *bt)
 {
 	if (bt->frame == MAX_CALL_FRAMES - 1) {
-		verbose(bt->env, "BUG subprog enter from frame %d\n", bt->frame);
-		WARN_ONCE(1, "verifier backtracking bug");
+		verifier_bug(bt->env, "subprog enter from frame %d\n", bt->frame);
 		return -EFAULT;
 	}
 	bt->frame++;
@@ -3998,8 +3996,7 @@ static inline int bt_subprog_enter(struct backtrack_state *bt)
 static inline int bt_subprog_exit(struct backtrack_state *bt)
 {
 	if (bt->frame == 0) {
-		verbose(bt->env, "BUG subprog exit from frame 0\n");
-		WARN_ONCE(1, "verifier backtracking bug");
+		verifier_bug(bt->env, "subprog exit from frame 0\n");
 		return -EFAULT;
 	}
 	bt->frame--;
@@ -4277,14 +4274,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * should be literally next instruction in
 				 * caller program
 				 */
-				WARN_ONCE(idx + 1 != subseq_idx, "verifier backtracking bug");
+				if (unlikely(idx + 1 != subseq_idx))
+					verifier_bug(env, "extra insn from subprog");
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
@@ -4298,16 +4296,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
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
@@ -4330,13 +4328,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
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
@@ -4358,8 +4356,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				/* if backtracing was looking for registers R1-R5
 				 * they should have been found already.
 				 */
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "regs not found %x\n", bt_reg_mask(bt));
 				return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
@@ -4377,8 +4374,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "regs not found %x\n", bt_reg_mask(bt));
 				return -EFAULT;
 			}
 
@@ -4719,9 +4715,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				return 0;
 			}
 
-			verbose(env, "BUG backtracking func entry subprog %d reg_mask %x stack_mask %llx\n",
-				st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
-			WARN_ONCE(1, "verifier backtracking bug");
+			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %llx\n",
+				     st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
 			return -EFAULT;
 		}
 
@@ -4757,8 +4752,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				 * It means the backtracking missed the spot where
 				 * particular register was initialized with a constant.
 				 */
-				verbose(env, "BUG backtracking idx %d\n", i);
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "backtracking idx %d\n", i);
 				return -EFAULT;
 			}
 		}
@@ -4784,9 +4778,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
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
 
@@ -6562,13 +6555,13 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
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
@@ -6676,8 +6669,8 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 
 	subprog = find_subprog(env, start);
 	if (subprog < 0) {
-		WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-			  start);
+		verifier_bug(env, "No program starts at insn %d\n",
+			     start);
 		return -EFAULT;
 	}
 	return env->subprog_info[subprog].stack_depth;
@@ -7984,7 +7977,7 @@ static int check_stack_range_initialized(
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
-			verbose(env, "verifier bug: allocated_stack too small\n");
+			verbose(env, "allocated_stack too small\n");
 			return -EFAULT;
 		}
 
@@ -8413,7 +8406,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (meta->map_ptr) {
-		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
+		verifier_bug(env, "Two map pointers in a timer helper\n");
 		return -EFAULT;
 	}
 	meta->map_uid = reg->map_uid;
@@ -10285,8 +10278,8 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	}
 
 	if (state->frame[state->curframe + 1]) {
-		verbose(env, "verifier bug. Frame %d already allocated\n",
-			state->curframe + 1);
+		verifier_bug(env, "Frame %d already allocated\n",
+			     state->curframe + 1);
 		return -EFAULT;
 	}
 
@@ -10400,8 +10393,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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
@@ -10464,13 +10457,13 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
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
 
@@ -10523,7 +10516,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	target_insn = *insn_idx + insn->imm + 1;
 	subprog = find_subprog(env, target_insn);
 	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n", target_insn);
+		verifier_bug(env, "No program starts at insn %d\n", target_insn);
 		return -EFAULT;
 	}
 
@@ -11124,7 +11117,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
 	if (err) {
-		verbose(env, "verifier bug\n");
+		verbose(env, "failed to retrieve map value address\n");
 		return -EFAULT;
 	}
 	fmt = (char *)(long)fmt_addr + fmt_map_off;
@@ -19689,8 +19682,8 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
-						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+					if (unlikely(env->cur_state->loop_entry)) {
+						verifier_bug(env, "env->cur_state->loop_entry != NULL\n");
 						return -EFAULT;
 					}
 					do_print_state = true;
@@ -20750,8 +20743,8 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		if (bpf_pseudo_kfunc_call(&insn))
 			continue;
 
-		if (WARN_ON(load_reg == -1)) {
-			verbose(env, "verifier bug. zext_dst is set, but no reg is defined\n");
+		if (unlikely(load_reg == -1)) {
+			verifier_bug(env, "zext_dst is set, but no reg is defined\n");
 			return -EFAULT;
 		}
 
@@ -21071,8 +21064,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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
@@ -22433,7 +22426,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		/* We need two slots in case timed may_goto is supported. */
 		if (stack_slots > slots) {
-			verbose(env, "verifier bug: stack_slots supports may_goto only\n");
+			verifier_bug(env, "stack_slots supports may_goto only\n");
 			return -EFAULT;
 		}
 
-- 
2.43.0


