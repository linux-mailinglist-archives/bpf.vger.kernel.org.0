Return-Path: <bpf+bounces-54139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD50A633AB
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73E31893377
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810811AA1F6;
	Sun, 16 Mar 2025 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXbd+0ua"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D33154433;
	Sun, 16 Mar 2025 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097978; cv=none; b=en9+4nW3TGYUx91EZAbZ93ZwmeouQdhn9tUJLeef1YESRY11ZV2GR0+oC0zLlK3oChLt8tqlh1RQNGnMdCDoZzjQe6brFJdF1Cx50rPkKl8wizvHSKWJiZtz/1XHOOvyUBVKR1dZjHJTAvCnyEjG/5hWNLJZJd9IHxJX731kLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097978; c=relaxed/simple;
	bh=O+lyN4oVrvKYSSQbJkMNs01queFf9cpPeUOzO9ERMeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jenYxAx8GYjHJrwa2Mbb53Bu+GhhZdgOSLuYXAvzgNpCueLajIoT+sYieKig/t6HpYVvFTyZR6LhHokHv9/Dq5ASgvtiwI2U/d/F5ZF/dPC+3ChAzJcb+FwELwDKt2j0MjrCpAJNp4zTR5QRSh7/MLEQ0Mgx7KyDV6IzyhSoUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXbd+0ua; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso6727935e9.1;
        Sat, 15 Mar 2025 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097974; x=1742702774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td96SnjkiCjYPsW/BwStDtEmfD+sdWIVQooAZW8vma4=;
        b=AXbd+0uaLFCNLNMpAcdWfWnyt39Uhl6m3WrcVD+twq8mpxmq0nSADrQUP67pBYoFF3
         uaro9lkT9UV5kX+snwWQZCOeuca0mmoXt5A/tnge1hi+Pva7vVTs/m3bNxIxplCy+wQ2
         SYSZBkB9S8VCHBzL/9mghyyw9RSY9ft8bcz4Jis7dTnKongs2PPXzVSX/kOiPt7gNRA9
         ZytyMMce0VRALeslOJ4NJjq03piukmYv3JRCF4U8DFEaQPj7w4FcydEND0DV9bY9EBtT
         tblP79n12B/PJI7/hXQbWN7wggpemvLGaVa8IUyj8T0LIIEAiZI+eQzBslcxIsx4kb6D
         04cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097974; x=1742702774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Td96SnjkiCjYPsW/BwStDtEmfD+sdWIVQooAZW8vma4=;
        b=UbO46qN+9+aEeovuwn/GaywxUAq+JKJPjZN+e0rovr/SgTuuFh7FLpSPjbBbtddJdb
         FTQC4o+gyqPCjGgKBb0m/m7FBduIv6ojXhfLer1e682Ef3bHxqnQAergSZA29lYmjrkl
         EjCN5FgggzKZewC1/6fpNi3CHF/x0J4zd6MiEymRHaz39Gxs/kp9kJYciSH7YKSz5tqx
         ngbXCYGQy8w4hXQ/TIUdSAZW91e7V2CvZfYdnA69s3nz8DI26THjpIOMhCF+YDn/MzD4
         G9jm2nhzBpTDNdLEE+x79uBFL5zNkMsOUG4QB67VYgPtm/4V1ioLR8aodMUfkvCclZx8
         Cbig==
X-Forwarded-Encrypted: i=1; AJvYcCWaHhqmBAvXPAGQvEK6hZeL1jNTtGIZ9mqpKghbFm46dxp6NrDCqwfamRKiqcywa9svliiPUCqDaC0ub5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvmrwX0wEUgg81m7ar47rqRuUIXpm/fYAsoK+giLq2sKZ9yEL
	nYTR9EdMPMluWDv0BcQdH1ak9XoJ2H24WKoSwiIdfbziNrVEqPdzsT2JBHOsKb0=
X-Gm-Gg: ASbGncvcrVRRqf2683OaMfQkJM+57nHwai5vVD1SYHMXer4U/pm+1ZWSG3uvntbUBOj
	QRVpTrYInsSJzXJQb1Vj/cWgCLP1R2qQGJD/dNaVl7orBjKeR0iY3iEOUEquymjTS6QzLkp4S+a
	nbPcUW4hjUUeZJfL1MRAOTgRpC+63e2pbdkNS1/aOYxlW6yf4QbXeER9wev/+SSDkmL6csuIW+v
	VVyMxUSw2gkFQKd1YHZGfDoUTvmnDie1L185gFtR+gmZctLU8eaZjxxiCnHf5uwkTBtWvdSLvos
	hFbkOVtLSQ7oVZuokrVEo+k3BRKMoZTW93M=
X-Google-Smtp-Source: AGHT+IEe2u4p0LnlngF0w6iSDydFegjZ1jArOy5WfyUzD1CS7GnhmMYyuaPdi7pWrq/MX6Cd47TJfw==
X-Received: by 2002:a05:600c:4fd3:b0:43d:8ea:8d80 with SMTP id 5b1f17b1804b1-43d1ec9071amr97461285e9.5.1742097973885;
        Sat, 15 Mar 2025 21:06:13 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe15488sm68116955e9.16.2025.03.15.21.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 24/25] bpf: Maintain FIFO property for rqspinlock unlock
Date: Sat, 15 Mar 2025 21:05:40 -0700
Message-ID: <20250316040541.108729-25-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4773; h=from:subject; bh=O+lyN4oVrvKYSSQbJkMNs01queFf9cpPeUOzO9ERMeU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3eZlk7c0Ywl88mFKBS1oFXTDuU3/IFonJhUClr HKe1WSqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3gAKCRBM4MiGSL8RyjP4D/ 4qY2ygrw3rIEgXKa12ik0/oktnV0e/sgD/scWu+14+mWArsWSQ8UUjlTmpeZtHx1UMMimJTVgA8JWn ErwnoS51+LKONrfuBOnb8WiSnFeLF2kEEfBXZQhz52hCEM91I4VjacRj/HFnavXb8dOXViHZOtiFYp tA8XV+c68vvKXklV2jpo5wQkhg4tl3j7veEwJrpGTnt1ANUxSd/148gUr43wVDaWrSgg0QTfjMnt2k goGCGNX40txTa7gZVvoN/8zUCK+ll8jaMBMQ+wXgziu1+Yxk9+wlg2NDfkV+ao2pAFbE2K59WELhhm zH40fY8ghmeKSCcSjq49JyGkr5NuuFkIKX9CxCU42wXXArAMCTvksaIBgF7yX6OcFX13Yd45mH2eQD ugV1igIdF9xIUeRIsnMvEEbbiDCD3kD8Zq8gI8qaaKFsk/czJpoEggouEQbtcPaJjppZjtejTeiJ60 lRqpK1fksWewmXvWLmFMlepLnJ23LvW+pPoJ8fBE0oSJuVXPW2+zmqm1tPHFkN7PEBinvfYBocQLPo HJmKqN3bK3Ub6nxUL5gU8yHrGZ6D9lv3K2LvmqUCYq8IJ9WdhSpT8wCA4I7oyLhMrvQs/sXiLR24eK rPTfZ7DZ+EFlgOEIzpWNR+wfqUw8Eo8o/ueXBPEQAa+d6DeACjG6ZPXCAJmw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Since out-of-order unlocks are unsupported for rqspinlock, and irqsave
variants enforce strict FIFO ordering anyway, make the same change for
normal non-irqsave variants, such that FIFO ordering is enforced.

Two new verifier state fields (active_lock_id, active_lock_ptr) are used
to denote the top of the stack, and prev_id and prev_ptr are ascertained
whenever popping the topmost entry through an unlock.

Take special care to make these fields part of the state comparison in
refsafe.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/verifier.c        | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bc073a48aed9..9734544b6957 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -268,6 +268,7 @@ struct bpf_reference_state {
 		REF_TYPE_LOCK		= (1 << 3),
 		REF_TYPE_RES_LOCK 	= (1 << 4),
 		REF_TYPE_RES_LOCK_IRQ	= (1 << 5),
+		REF_TYPE_LOCK_MASK	= REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
 	} type;
 	/* Track each reference created with a unique id, even if the same
 	 * instruction creates the reference multiple times (eg, via CALL).
@@ -434,6 +435,8 @@ struct bpf_verifier_state {
 	u32 active_locks;
 	u32 active_preempt_locks;
 	u32 active_irq_id;
+	u32 active_lock_id;
+	void *active_lock_ptr;
 	bool active_rcu_lock;
 
 	bool speculative;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 29121ad32a89..4057081e996f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1428,6 +1428,8 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->active_preempt_locks = src->active_preempt_locks;
 	dst->active_rcu_lock = src->active_rcu_lock;
 	dst->active_irq_id = src->active_irq_id;
+	dst->active_lock_id = src->active_lock_id;
+	dst->active_lock_ptr = src->active_lock_ptr;
 	return 0;
 }
 
@@ -1527,6 +1529,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	s->ptr = ptr;
 
 	state->active_locks++;
+	state->active_lock_id = id;
+	state->active_lock_ptr = ptr;
 	return 0;
 }
 
@@ -1577,16 +1581,24 @@ static bool find_reference_state(struct bpf_verifier_state *state, int ptr_id)
 
 static int release_lock_state(struct bpf_verifier_state *state, int type, int id, void *ptr)
 {
+	void *prev_ptr = NULL;
+	u32 prev_id = 0;
 	int i;
 
 	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].type != type)
-			continue;
-		if (state->refs[i].id == id && state->refs[i].ptr == ptr) {
+		if (state->refs[i].type == type && state->refs[i].id == id &&
+		    state->refs[i].ptr == ptr) {
 			release_reference_state(state, i);
 			state->active_locks--;
+			/* Reassign active lock (id, ptr). */
+			state->active_lock_id = prev_id;
+			state->active_lock_ptr = prev_ptr;
 			return 0;
 		}
+		if (state->refs[i].type & REF_TYPE_LOCK_MASK) {
+			prev_id = state->refs[i].id;
+			prev_ptr = state->refs[i].ptr;
+		}
 	}
 	return -EINVAL;
 }
@@ -8342,6 +8354,14 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 			type = REF_TYPE_RES_LOCK;
 		else
 			type = REF_TYPE_LOCK;
+		if (!find_lock_state(cur, type, reg->id, ptr)) {
+			verbose(env, "%s_unlock of different lock\n", lock_str);
+			return -EINVAL;
+		}
+		if (reg->id != cur->active_lock_id || ptr != cur->active_lock_ptr) {
+			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
+			return -EINVAL;
+		}
 		if (release_lock_state(cur, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
@@ -12534,8 +12554,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 	if (!env->cur_state->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env->cur_state, REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
-			    id, ptr);
+	s = find_lock_state(env->cur_state, REF_TYPE_LOCK_MASK, id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
@@ -18591,6 +18610,10 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	if (!check_ids(old->active_irq_id, cur->active_irq_id, idmap))
 		return false;
 
+	if (!check_ids(old->active_lock_id, cur->active_lock_id, idmap) ||
+	    old->active_lock_ptr != cur->active_lock_ptr)
+		return false;
+
 	for (i = 0; i < old->acquired_refs; i++) {
 		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) ||
 		    old->refs[i].type != cur->refs[i].type)
-- 
2.47.1


