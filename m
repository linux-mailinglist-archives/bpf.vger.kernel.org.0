Return-Path: <bpf+bounces-68065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E27B52572
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A399F5807AD
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065D84D02;
	Thu, 11 Sep 2025 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt5YZzTu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E6136351
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552695; cv=none; b=p9/3owu2Q7e8Bh9RY1aqRBtIVnIf5yN31dwP1iHZN71MJxG7/KOwyRxdFRdeCSQhoBgqlnrq5nWT+qABHlGa3RhhpeX5G771CBg+uegprgeyaKlMLZ2zaD1mbiC2/E3wHrol+3cptcuiWlBBMB48SqE3iu4Ohyv6JFn8R43e500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552695; c=relaxed/simple;
	bh=EKwwlIVKeRLhQ4gy807euTryQaIaf+K+6aFMrvW4JOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaC4TD/LW22OBUeKodywkZTJPbEOlxXhhOVHhmtw+AstxMUkH7EQbqjbZVzSy+WkbH6WOYSS5coP18BNzp6ip5AOR1yNwxIwVX5E3268KRZJLBspRQJLPMnNeTNgzyiS1SMNCAespSMwFuo94TOvMCJiUXWcKok+dTf6wIm7Vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt5YZzTu; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso94725a91.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552692; x=1758157492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INkSsUnpk9QKv+1kbA0t/s1rDeUngnvIz4mdyqDCq1A=;
        b=Wt5YZzTu6naUZSKwvHSebZWD7nmGFtd2985TEbA/fmaqrzWyEmlbSlBJ0plG2/lHMj
         DBW4PXfySZn/99XvBA6MxJWnCZDpHjwP6DwQE0m7lVgDyJZufXw9PvJm/ReKh+9O9dkW
         FAFCfh5A47s0JvBh10UUbeQZXlD/nDeMBreaZDIuzYvgKHg1m1VA06TsWgig54lGUmRI
         1lryO/zNXPI8v0tt706pED7xPyJGQKefI/fPK2Q7zdPL/+oJl26q9jQg9I8o0xiyxmq6
         YcqumD2xeFjpZItEr/tZxGzO/3HVbkz5xuNCcGpAGoljcw7P4TuKpLGfKDYQjn8KIIN4
         4IMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552692; x=1758157492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INkSsUnpk9QKv+1kbA0t/s1rDeUngnvIz4mdyqDCq1A=;
        b=Vus5urRJzW1UjQRtt+CL4I3N0YQnf4rhlR41Kdlup9YnPqSrrdADP1e3yWVEppVEAk
         AKWZNz6yAB9+sGTUIi2CtqowppEsBoPDZWnGcAznpFACH4IqaRZPU6GRthO40B+DCORp
         CEOZXPWXIzjN3273ZD9qha7OdS0AyQdQaDlfD79YHjqp5LB5el6Vx1O5c8xCpdtGFqKr
         e4EY2Dfdt88ghEcZzP/1TKBevx+I5h9bml1JI3tIzRVMs8Y4QfmCQ8LtswxK5EyAZBj3
         zGcVgf+eqTNjEFNvxDAd8b0w5Bh/sNWcr1XB7LiMj3i2IkccGKr6SqqakugECWNR5sOC
         ozGw==
X-Gm-Message-State: AOJu0YyovDK9htKm4EjTW10KYOyakM8Ft9w/9gIeodTuh0qM8hy4s6oO
	vSwyLqgXD+xWVuTGQGj6cxtX7VuiAXQnHl6v+so0RNWC2ZbiNAcQ3cnDe+T4jw==
X-Gm-Gg: ASbGncvAJK34XVl7RezwTDrdHrGbV+KDIZjHcfeS+FGLB0Hv0qAvczDusUQqjeQpyoP
	C7PpAOpqCQJ25jRzP7rj2JXLIcVkfhM/FTlGE0tgDMExc1d2MNcbxyHzgBrubqWiq8XidfUPb4a
	H/i0Ph+Q86r7A1pBaqOu0iLWAm52R284eBk1zHgAkOALdzqK4/sDEPTHJR+2tN2njg7w9OK0Pgn
	poPoWlaE1FxZwxyrJwcAamp9OBcVceznWQjpJHErrRJrWYatzynjYhggQqIpw0ISKZ+0KZvX/6C
	SYV1eDqGJq5DDRdsa71yHDxD1JS7x4w3cDKiz+sUj4pqnVbDuKmAG+as9+nWMRDRSNT4iJ/W+DQ
	qT+RbHjGKtZDYK7+9kcC16Q+eJAAjLfmyoA==
X-Google-Smtp-Source: AGHT+IGgzrD2qixULy8fGjTIQfGg5xsUvvvwW2XNqgqYa32yv2d0jkkMCzRrA33rqY46MxFyzD1Cgw==
X-Received: by 2002:a17:90b:3904:b0:32b:6132:5f94 with SMTP id 98e67ed59e1d1-32d43f95d02mr23153409a91.21.1757552692469;
        Wed, 10 Sep 2025 18:04:52 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 01/10] bpf: bpf_verifier_state->cleaned flag instead of REG_LIVE_DONE
Date: Wed, 10 Sep 2025 18:04:26 -0700
Message-ID: <20250911010437.2779173-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bpf_reg_state->live field removal by introducing a
separate flag to track if clean_verifier_state() had been applied to
the state. No functional changes.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/log.c             |  6 ++----
 kernel/bpf/verifier.c        | 13 ++++---------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 020de62bd09c..ac16da8b49dc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -45,7 +45,6 @@ enum bpf_reg_liveness {
 	REG_LIVE_READ64 = 0x2, /* likewise, but full 64-bit content matters */
 	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
 	REG_LIVE_WRITTEN = 0x4, /* reg was written first, screening off later reads */
-	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
 };
 
 #define ITER_PREFIX "bpf_iter_"
@@ -445,6 +444,7 @@ struct bpf_verifier_state {
 
 	bool speculative;
 	bool in_sleepable;
+	bool cleaned;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e4983c1303e7..0d6d7bfb2fd0 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -545,14 +545,12 @@ static char slot_type_char[] = {
 static void print_liveness(struct bpf_verifier_env *env,
 			   enum bpf_reg_liveness live)
 {
-	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN | REG_LIVE_DONE))
-	    verbose(env, "_");
+	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN))
+		verbose(env, "_");
 	if (live & REG_LIVE_READ)
 		verbose(env, "r");
 	if (live & REG_LIVE_WRITTEN)
 		verbose(env, "w");
-	if (live & REG_LIVE_DONE)
-		verbose(env, "D");
 }
 
 #define UNUM_MAX_DECIMAL U16_MAX
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9394f8fac0e..46a6d69de309 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1758,6 +1758,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return err;
 	dst_state->speculative = src->speculative;
 	dst_state->in_sleepable = src->in_sleepable;
+	dst_state->cleaned = src->cleaned;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
@@ -3574,11 +3575,6 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 		/* if read wasn't screened by an earlier write ... */
 		if (writes && state->live & REG_LIVE_WRITTEN)
 			break;
-		if (verifier_bug_if(parent->live & REG_LIVE_DONE, env,
-				    "type %s var_off %lld off %d",
-				    reg_type_str(env, parent->type),
-				    parent->var_off.value, parent->off))
-			return -EFAULT;
 		/* The first condition is more likely to be true than the
 		 * second, checked it first.
 		 */
@@ -18472,7 +18468,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	for (i = 0; i < BPF_REG_FP; i++) {
 		live = st->regs[i].live;
 		/* liveness must not touch this register anymore */
-		st->regs[i].live |= REG_LIVE_DONE;
 		if (!(live & REG_LIVE_READ))
 			/* since the register is unused, clear its state
 			 * to make further comparison simpler
@@ -18483,7 +18478,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
 		live = st->stack[i].spilled_ptr.live;
 		/* liveness must not touch this stack slot anymore */
-		st->stack[i].spilled_ptr.live |= REG_LIVE_DONE;
 		if (!(live & REG_LIVE_READ)) {
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
@@ -18497,6 +18491,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i;
 
+	st->cleaned = true;
 	for (i = 0; i <= st->curframe; i++)
 		clean_func_state(env, st->frame[i]);
 }
@@ -18524,7 +18519,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
  * their final liveness marks are already propagated.
  * Hence when the verifier completes the search of state list in is_state_visited()
  * we can call this clean_live_states() function to mark all liveness states
- * as REG_LIVE_DONE to indicate that 'parent' pointers of 'struct bpf_reg_state'
+ * as st->cleaned to indicate that 'parent' pointers of 'struct bpf_reg_state'
  * will not be used.
  * This function also clears the registers and stack for states that !READ
  * to simplify state merging.
@@ -18547,7 +18542,7 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			continue;
-		if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE)
+		if (sl->state.cleaned)
 			/* all regs in this state in all frames were already marked */
 			continue;
 		if (incomplete_read_marks(env, &sl->state))
-- 
2.47.3


