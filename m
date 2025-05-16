Return-Path: <bpf+bounces-58391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C081AB98F8
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 11:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4543A9596
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FCB230BFF;
	Fri, 16 May 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI7NOEu1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984421171C
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388078; cv=none; b=duzkAWq6Lv9JAeDHzS5bpdgAL6E5c7V+QTXiVKuVzWycETmqM/47aKdFdH+sLQ5aot8+HJbLQ69tOFUBIy9aBqw8R75oPpUyqPgt8Ckyr6ILAPEZX/GsjUpK/SUiAAuia+WgALbun9vdfE7BrrVGJKMqqUzTUm6myhzURmTb0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388078; c=relaxed/simple;
	bh=piPbWBELCfLjojo+CGD7wA/gUjhQJWTEVeYivslo7zI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cphWXOjRdzY+K4skIKIMs+BOwtShw3jRRamVDWShv3McnvTYtWZhWj6A7RIrsSzysidntkJDj1QTca7QfDZQeTPBrMSBbylJvVeof1YW/K7sjTADe3kY4leWUIpbHcP4GoujLHfMHT97jX586bgks9An3OVxQ4jBz0agfxMexgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI7NOEu1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso13851165e9.3
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747388074; x=1747992874; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7t1zuuYg/4s6jqEqQcwbGnnmp1LaZGBgqePm9ya8qRk=;
        b=BI7NOEu19jV0k5Lf75FwwrxL5Hh43Xjntfz44QUtQmtcOVRQ4/hGXP6bs7UpAMIo9Q
         rt7sOOjUYFm2NpmBALw1GPylQtKzz6SvTSAkFMgnDkk5pPDNXw9UqVnkGez8UqvVKpt+
         2aF8ZqWzpfxy0wSgsCKt0YsYhZ9/QobOZX8jo/GLhUDf692TKw2ASeK3jxHesxSEyWEU
         2ad9Ke6ScVZFswWxmWsPC5Qdu7C0HbKC5BlVEMSGTRCTBUycb8TyGaKATrQgV1B49iri
         Ifbc3ASQushEYFCtvA+QbdnCcOCC9PxumkQwdwnwE/8Yi9t6Kw8UH6b7ppD1Du2Q9pUo
         QfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747388074; x=1747992874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t1zuuYg/4s6jqEqQcwbGnnmp1LaZGBgqePm9ya8qRk=;
        b=Kl5Dnxj0m5K4EEgDhEnPiaE0ToPYLu/Wb+7PBrRtcp6Ex0aIbzT6viRwQAvK5b3QfY
         TUyQpaKLO7P1jqcQmSWWQ/rJb1s+jW8BqLHLLj9rsrcGZcJOdtvBjGjQTQSiHmzDbzca
         lrb9R+k0XKY9TxkpdK0ov6jKdwBkhyTs5OZo8fLWN8Tx2hudGcQl0COsPK+ZWaCKTL1V
         fVPZWOUaOOtx8YmXNzcLgbKyRgyOzZanXyVOrkDxlMhWr7cuAeqQrfHzadV1Cqy3RM4M
         LD898cCUBW4kv2tah2XHELNZqeLxOL3lGmuy4cZTFvC1ahZ/Uepk1rD4YRrLx1NIRX/G
         xlHA==
X-Gm-Message-State: AOJu0YwrXYnJiLbBQ+DxWD4xaQ6ShzuBNYWJlVizL+Xv0Zoz1oXWNLFE
	MhVKUooYEsobwYrVnldELN3Nkw8jQ1ucAAHHXPwIdJvpmW68n3rzLmaGRVKcpA==
X-Gm-Gg: ASbGncuk32WyJpjhXP/rJlAPj2RtFdU6/Wv7/OhEB9CT1WffU6eGpWsm+LS4j15kKxb
	xOBKmtEAxTC+iTWEjByFdgpu6sjWpEUCyVfYze+TMcVqCKzMSDa8hM9AsRCXhgBAhVCvF0O7mHd
	ha/C/nao5qzhF15nFoLU/5+0/mZ58tcqaet9k2rd2hjvi2ozOSKACP3iirAJWT92N0QkHrlVnS1
	HNXs3nz2u17qJTq200dxLi+JNLRbvV50j8yTNOG2evldBjm9H1d4ZvZ+ESTprF0+TNOmPwoTMlB
	amxvUe5e6x//Gzal5xziwWmCjJwRecniRX/7q2IIHmaygFOZOLg8BhIIRaZBe9dVAQCYnfSWuWM
	eeNMoEfIca2JkOK3l59j0yVx+6Z7Fu9Vm3T8R99P5QDViKuYIZA==
X-Google-Smtp-Source: AGHT+IEweTs/zATUnTWNkGKje0S3P8yntylXGxSussD9GmjwKYpqCKDRcdw8xyshs0ThMGrb8SmqTw==
X-Received: by 2002:a05:600c:64c5:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-442fefdad81mr16841235e9.1.1747388073824;
        Fri, 16 May 2025 02:34:33 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004ca374c5854e9ed0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4ca3:74c5:854e:9ed0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50b983sm26563175e9.11.2025.05.16.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:34:33 -0700 (PDT)
Date: Fri, 16 May 2025 11:34:31 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v4] bpf: WARN_ONCE on verifier bugs
Message-ID: <aCcGpxnlfOOiOJ-b@mail.gmail.com>
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
Changes in v4:
  - Evaluate condition once and stringify it, as suggested by Alexei.
  - Use verifier_bug_if instead of verifier_bug where it can help
    disambiguate the callsite or shorten the message.
  - Add newline character in verifier_bug_if directly.
Changes in v3:
  - Introduce and use verifier_bug_if, as suggested by Andrii.
Changes in v2:
  - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
    CONFIG_DEBUG_KERNEL, as per reviews.
  - Use the new helper function for verifier bugs missed in v1,
    particularly around backtracking.

 include/linux/bpf.h          |   6 ++
 include/linux/bpf_verifier.h |  11 +++
 kernel/bpf/btf.c             |   4 +-
 kernel/bpf/verifier.c        | 140 +++++++++++++++--------------------
 4 files changed, 77 insertions(+), 84 deletions(-)

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
index cedd66867ecf..7edb15830132 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -839,6 +839,17 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...);
 
+#define verifier_bug_if(cond, env, fmt, args...)						\
+	({											\
+		bool __cond = unlikely(cond);							\
+		if (__cond) {									\
+			BPF_WARN_ONCE(1, "verifier bug: " fmt "(" #cond ")\n", ##args);		\
+			bpf_log(&env->log, "verifier bug: " fmt "(" #cond ")\n", ##args);	\
+		}										\
+		(__cond);									\
+	})
+#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##args)
+
 static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *cur = env->cur_state;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b21ca67070c..0f7828380895 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7659,7 +7659,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		return 0;
 
 	if (!prog->aux->func_info) {
-		bpf_log(log, "Verifier bug\n");
+		verifier_bug(env, "func_info undefined");
 		return -EFAULT;
 	}
 
@@ -7683,7 +7683,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	tname = btf_name_by_offset(btf, fn_t->name_off);
 
 	if (prog->aux->func_info_aux[subprog].unreliable) {
-		bpf_log(log, "Verifier bug in function %s()\n", tname);
+		verifier_bug(env, "unreliable BTF for function %s()", tname);
 		return -EFAULT;
 	}
 	if (prog_type == BPF_PROG_TYPE_EXT)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6d3655b3a7a..cec35daf2b77 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1924,11 +1924,9 @@ static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_env *env,
 	u32 steps = 0;
 
 	while (topmost && topmost->loop_entry) {
-		if (steps++ > st->dfs_depth) {
-			WARN_ONCE(true, "verifier bug: infinite loop in get_loop_entry\n");
-			verbose(env, "verifier bug: infinite loop in get_loop_entry()\n");
+		if (verifier_bug_if(steps++ > st->dfs_depth, env,
+				    "infinite loop"))
 			return ERR_PTR(-EFAULT);
-		}
 		topmost = topmost->loop_entry;
 	}
 	return topmost;
@@ -3460,12 +3458,11 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 		/* if read wasn't screened by an earlier write ... */
 		if (writes && state->live & REG_LIVE_WRITTEN)
 			break;
-		if (parent->live & REG_LIVE_DONE) {
-			verbose(env, "verifier BUG type %s var_off %lld off %d\n",
-				reg_type_str(env, parent->type),
-				parent->var_off.value, parent->off);
+		if (verifier_bug_if(parent->live & REG_LIVE_DONE, env,
+				    "type %s var_off %lld off %d",
+				    reg_type_str(env, parent->type),
+				    parent->var_off.value, parent->off))
 			return -EFAULT;
-		}
 		/* The first condition is more likely to be true than the
 		 * second, checked it first.
 		 */
@@ -3858,14 +3855,14 @@ static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_s
 		/* atomic instructions push insn_flags twice, for READ and
 		 * WRITE sides, but they should agree on stack slot
 		 */
-		WARN_ONCE((env->cur_hist_ent->flags & insn_flags) &&
-			  (env->cur_hist_ent->flags & insn_flags) != insn_flags,
-			  "verifier insn history bug: insn_idx %d cur flags %x new flags %x\n",
-			  env->insn_idx, env->cur_hist_ent->flags, insn_flags);
+		verifier_bug_if((env->cur_hist_ent->flags & insn_flags) &&
+				(env->cur_hist_ent->flags & insn_flags) != insn_flags,
+				env, "insn history: insn_idx %d cur flags %x new flags %x",
+				env->insn_idx, env->cur_hist_ent->flags, insn_flags);
 		env->cur_hist_ent->flags |= insn_flags;
-		WARN_ONCE(env->cur_hist_ent->linked_regs != 0,
-			  "verifier insn history bug: insn_idx %d linked_regs != 0: %#llx\n",
-			  env->insn_idx, env->cur_hist_ent->linked_regs);
+		verifier_bug_if(env->cur_hist_ent->linked_regs != 0, env,
+				"insn history: insn_idx %d linked_regs: %#llx",
+				env->insn_idx, env->cur_hist_ent->linked_regs);
 		env->cur_hist_ent->linked_regs = linked_regs;
 		return 0;
 	}
@@ -3988,8 +3985,7 @@ static inline u32 bt_empty(struct backtrack_state *bt)
 static inline int bt_subprog_enter(struct backtrack_state *bt)
 {
 	if (bt->frame == MAX_CALL_FRAMES - 1) {
-		verbose(bt->env, "BUG subprog enter from frame %d\n", bt->frame);
-		WARN_ONCE(1, "verifier backtracking bug");
+		verifier_bug(bt->env, "subprog enter from frame %d", bt->frame);
 		return -EFAULT;
 	}
 	bt->frame++;
@@ -3999,8 +3995,7 @@ static inline int bt_subprog_enter(struct backtrack_state *bt)
 static inline int bt_subprog_exit(struct backtrack_state *bt)
 {
 	if (bt->frame == 0) {
-		verbose(bt->env, "BUG subprog exit from frame 0\n");
-		WARN_ONCE(1, "verifier backtracking bug");
+		verifier_bug(bt->env, "subprog exit from frame 0");
 		return -EFAULT;
 	}
 	bt->frame--;
@@ -4278,14 +4273,15 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
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
+					verifier_bug(env, "scratch reg set: regs %x",
+						     bt_reg_mask(bt));
 					return -EFAULT;
 				}
 				/* global subprog always sets R0 */
@@ -4299,16 +4295,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				 * the current frame should be zero by now
 				 */
 				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
-					verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-					WARN_ONCE(1, "verifier backtracking bug");
+					verifier_bug(env, "unexpected precise regs %x",
+						     bt_reg_mask(bt));
 					return -EFAULT;
 				}
 				/* we are now tracking register spills correctly,
 				 * so any instance of leftover slots is a bug
 				 */
 				if (bt_stack_mask(bt) != 0) {
-					verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
-					WARN_ONCE(1, "verifier backtracking bug (subprog leftover stack slots)");
+					verifier_bug(env, "subprog leftover stack slots %llx",
+						     bt_stack_mask(bt));
 					return -EFAULT;
 				}
 				/* propagate r1-r5 to the caller */
@@ -4331,13 +4327,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * not actually arguments passed directly to callback subprogs
 			 */
 			if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "unexpected precise regs %x",
+					     bt_reg_mask(bt));
 				return -EFAULT;
 			}
 			if (bt_stack_mask(bt) != 0) {
-				verbose(env, "BUG stack slots %llx\n", bt_stack_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug (callback leftover stack slots)");
+				verifier_bug(env, "callback leftover stack slots %llx",
+					     bt_stack_mask(bt));
 				return -EFAULT;
 			}
 			/* clear r1-r5 in callback subprog's mask */
@@ -4359,8 +4355,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				/* if backtracing was looking for registers R1-R5
 				 * they should have been found already.
 				 */
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "regs not found %x", bt_reg_mask(bt));
 				return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
@@ -4378,8 +4373,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
-				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
-				WARN_ONCE(1, "verifier backtracking bug");
+				verifier_bug(env, "regs not found %x", bt_reg_mask(bt));
 				return -EFAULT;
 			}
 
@@ -4720,9 +4714,8 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				return 0;
 			}
 
-			verbose(env, "BUG backtracking func entry subprog %d reg_mask %x stack_mask %llx\n",
-				st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
-			WARN_ONCE(1, "verifier backtracking bug");
+			verifier_bug(env, "backtracking func entry subprog %d reg_mask %x stack_mask %llx",
+				     st->frame[0]->subprogno, bt_reg_mask(bt), bt_stack_mask(bt));
 			return -EFAULT;
 		}
 
@@ -4751,17 +4744,14 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 			i = get_prev_insn_idx(env, st, i, hist_start, &hist_end);
 			if (i == -ENOENT)
 				break;
-			if (i >= env->prog->len) {
+			if (verifier_bug_if(i >= env->prog->len, env, "backtracking idx %d", i))
 				/* This can happen if backtracking reached insn 0
 				 * and there are still reg_mask or stack_mask
 				 * to backtrack.
 				 * It means the backtracking missed the spot where
 				 * particular register was initialized with a constant.
 				 */
-				verbose(env, "BUG backtracking idx %d\n", i);
-				WARN_ONCE(1, "verifier backtracking bug");
 				return -EFAULT;
-			}
 		}
 		st = st->parent;
 		if (!st)
@@ -4784,12 +4774,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 
 			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
 			for_each_set_bit(i, mask, 64) {
-				if (i >= func->allocated_stack / BPF_REG_SIZE) {
-					verbose(env, "BUG backtracking (stack slot %d, total slots %d)\n",
-						i, func->allocated_stack / BPF_REG_SIZE);
-					WARN_ONCE(1, "verifier backtracking bug (stack slot out of bounds)");
+				if (verifier_bug_if(i >= func->allocated_stack / BPF_REG_SIZE,
+						    env, "stack slot %d, total slots %d",
+						    i, func->allocated_stack / BPF_REG_SIZE))
 					return -EFAULT;
-				}
 
 				if (!is_spilled_scalar_reg(&func->stack[i])) {
 					bt_clear_frame_slot(bt, fr, i);
@@ -6562,21 +6550,18 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
 		sidx = find_subprog(env, next_insn);
-		if (sidx < 0) {
-			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-				  next_insn);
+		if (verifier_bug_if(sidx < 0, env, "No program starts at insn %d", next_insn))
 			return -EFAULT;
-		}
 		if (subprog[sidx].is_async_cb) {
 			if (subprog[sidx].has_tail_call) {
-				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
+				verifier_bug(env, "subprog has tail_call and async cb");
 				return -EFAULT;
 			}
 			/* async callbacks don't increase bpf prog stack size unless called directly */
 			if (!bpf_pseudo_call(insn + i))
 				continue;
 			if (subprog[sidx].is_exception_cb) {
-				verbose(env, "insn %d cannot call exception cb directly\n", i);
+				verbose(env, "insn %d cannot call exception cb directly", i);
 				return -EINVAL;
 			}
 		}
@@ -6676,11 +6661,8 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 	int start = idx + insn->imm + 1, subprog;
 
 	subprog = find_subprog(env, start);
-	if (subprog < 0) {
-		WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-			  start);
+	if (verifier_bug_if(subprog < 0, env, "No program starts at insn %d", start))
 		return -EFAULT;
-	}
 	return env->subprog_info[subprog].stack_depth;
 }
 #endif
@@ -7985,7 +7967,7 @@ static int check_stack_range_initialized(
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
 		if (state->allocated_stack <= slot) {
-			verbose(env, "verifier bug: allocated_stack too small\n");
+			verbose(env, "allocated_stack too small\n");
 			return -EFAULT;
 		}
 
@@ -8414,7 +8396,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		return -EINVAL;
 	}
 	if (meta->map_ptr) {
-		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
+		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
 	meta->map_uid = reg->map_uid;
@@ -10286,8 +10268,8 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	}
 
 	if (state->frame[state->curframe + 1]) {
-		verbose(env, "verifier bug. Frame %d already allocated\n",
-			state->curframe + 1);
+		verifier_bug(env, "Frame %d already allocated",
+			     state->curframe + 1);
 		return -EFAULT;
 	}
 
@@ -10401,8 +10383,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			if (err)
 				return err;
 		} else {
-			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
-				i, arg->arg_type);
+			verifier_bug(env, "unrecognized arg#%d type %d",
+				     i, arg->arg_type);
 			return -EFAULT;
 		}
 	}
@@ -10465,13 +10447,13 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
-		verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
-			func_id_name(insn->imm), insn->imm);
+		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",
+			     func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
 	} else if (!bpf_pseudo_kfunc_call(insn) &&
 		   !is_callback_calling_function(insn->imm)) { /* helper */
-		verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
-			func_id_name(insn->imm), insn->imm);
+		verifier_bug(env, "helper %s#%d not marked as callback-calling",
+			     func_id_name(insn->imm), insn->imm);
 		return -EFAULT;
 	}
 
@@ -10523,10 +10505,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	target_insn = *insn_idx + insn->imm + 1;
 	subprog = find_subprog(env, target_insn);
-	if (subprog < 0) {
-		verbose(env, "verifier bug. No program starts at insn %d\n", target_insn);
+	if (verifier_bug_if(subprog < 0, env, "No program starts at insn %d", target_insn))
 		return -EFAULT;
-	}
 
 	caller = state->frame[state->curframe];
 	err = btf_check_subprog_call(env, subprog, caller->regs);
@@ -11125,7 +11105,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
 	if (err) {
-		verbose(env, "verifier bug\n");
+		verbose(env, "failed to retrieve map value address\n");
 		return -EFAULT;
 	}
 	fmt = (char *)(long)fmt_addr + fmt_map_off;
@@ -19706,10 +19686,9 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
-						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+					if (verifier_bug_if(env->cur_state->loop_entry, env,
+							    "broken loop detection"))
 						return -EFAULT;
-					}
 					do_print_state = true;
 					continue;
 				}
@@ -20767,10 +20746,9 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 		if (bpf_pseudo_kfunc_call(&insn))
 			continue;
 
-		if (WARN_ON(load_reg == -1)) {
-			verbose(env, "verifier bug. zext_dst is set, but no reg is defined\n");
+		if (verifier_bug_if(load_reg == -1, env,
+				    "zext_dst is set, but no reg is defined"))
 			return -EFAULT;
-		}
 
 		zext_patch[0] = insn;
 		zext_patch[1].dst_reg = load_reg;
@@ -21087,11 +21065,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 * propagated in any case.
 		 */
 		subprog = find_subprog(env, i + insn->imm + 1);
-		if (subprog < 0) {
-			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
-				  i + insn->imm + 1);
+		if (verifier_bug_if(subprog < 0, env, "No program starts at insn %d",
+				    i + insn->imm + 1))
 			return -EFAULT;
-		}
 		/* temporarily remember subprog id inside insn instead of
 		 * aux_data, since next loop will split up all insns into funcs
 		 */
@@ -22454,7 +22430,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		/* We need two slots in case timed may_goto is supported. */
 		if (stack_slots > slots) {
-			verbose(env, "verifier bug: stack_slots supports may_goto only\n");
+			verifier_bug(env, "stack_slots supports may_goto only");
 			return -EFAULT;
 		}
 
-- 
2.43.0


