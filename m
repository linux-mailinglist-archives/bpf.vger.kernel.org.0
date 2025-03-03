Return-Path: <bpf+bounces-53092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5808A4C521
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F0216986F
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD74723959B;
	Mon,  3 Mar 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDl/zvub"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9B23909C;
	Mon,  3 Mar 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015426; cv=none; b=fv5mVwBTXsoj7nZHw+quwegW+ziYjxHOt07vah5u51YcMZTIvBgKgEdWo4blwkdAl9RgKijtSFst23u8KQW/oA5rkcs8MGQDkN7rJsDd1WsYeSL3x3eo77FPSON7coh3TNeY53mkJPYlNJX61zdaNgnxziwLfJHRLL47GJW0qgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015426; c=relaxed/simple;
	bh=yd3gRpKNHABqLGxFwmo4qitDCfszyenvxRvQDwJYTjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkjQokhZaovb6BWZwvXOJeLKxjCi1DO4nUP7bVqy96w62XyaaRFnZYwHuBOTyWHZSzZNIEuUFxVpVYxQ5q22NJHl2M4rJsareYbEK+JwqFJBkDHFIohkzo9A+dlRkgQlajLybYurzKXHoktSXZYjSTO5dukZGBm2QqjnoncB53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDl/zvub; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-390effd3e85so3257382f8f.0;
        Mon, 03 Mar 2025 07:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015421; x=1741620221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK06538PoT0hdERtpqSLZ9dXgVnOMpofNScplUny+Pg=;
        b=gDl/zvub9tYQEpfE8tziR5SbZ72TGGOg4J6glV0DxW4iF/MreCWZfVVmaE+XujCFvK
         j1ZjIPSTdiBCQcRndtg7lE2Kd3strHDyH8lmMQAbQm1pHNI4tFa5mqfGfiPN0YZyB4ur
         NLpAx8zHe/Q06Z6yPXfXCXq5tD7wFXKc/LWtdwgyUYucDeGRcZ7Gf31GS5sk6HS4AqLI
         m+WPDU7s+1CfqIwaOZ/HmWjvGTjRcmMIkyGsN+rX0bRNtWSPOxKl1XZLle3oK1tOmEoA
         gyV1YKm7fk2xJaKvVfzaDYLCyjWUh1ody+tlfrf6RE7DsdU9Ak3eN/uE9A8JLP+qodCi
         pGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015421; x=1741620221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JK06538PoT0hdERtpqSLZ9dXgVnOMpofNScplUny+Pg=;
        b=pAeG0yzcg7MdoUyRp5M1urStVy30ct4qDrIgOyES5r07axv2J9G7cip5/ME0vdco5Z
         8z4NbQwZBFBgq0gJxC7YOw+LCpo7x2VFNVKzkIZ4GaJrrYuuoqkAgvTI2g0O94MaePSX
         XUxq3C+tukQ2Gs6VNUY6w+6H92kEEFS9rNbwdpRl+rNfJkiCAglHFZQVMvpMwlICLXj+
         N5kqzjE2JUYfaC3ncthVpldI8O33GWs6e8xg0ACm+D/gGIMIJ0Camh190iEBlkdKptwQ
         owuDq3QhPlIVqt5CMD5SSRblYg0wARAGJD25dll2nKpBuu0tk0r5nDjNeFVA3Nt0GM9m
         Uy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfSg8NQxqF+i754jFCvUFbWjCsMZiGpnHCWCAnQ4AlK+HQPhjYuWSxtJOdlnhCAM7GeljPo7SRTEVDYPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOOtQcKKLxasqsnX+rqof2Iz1CRmdfA3XfJSYvSoPm0DH8U0Ce
	XpRUnw/aKDJ1tu+SKltGxQcofRqzK6gH7now7Rw/DuTzmg/Vt2aNlwrn+cwXXWE=
X-Gm-Gg: ASbGncvV4XMuxuAouIb4Q71ZcbwcymYwIHHAs7CZh8nuLcgYQV/orq9yMMbOrX+4LaW
	xitjdPIcAj86dZGzskj/ABRpm24Uh9pmekx9QsrKGeEgNiSVtt9EzeF6I3GHpIC9C2yFHrnQhQB
	KeAyMvrEbhYulwdEPyuiWxi7glOvuTBy7a7IIr365+uc2B1wIRYbLeAg4YocrK6Xr2cjNDXthrK
	vNh92aHMI/IAYQJ0/pkq7vj08bEypnp3+ning44bA86l46UQShgEn7c9iWLRQvVRV/4YirdmSuG
	GpiqTPgTsOJHMOo88ekNVF18tJlr+DmrS0M=
X-Google-Smtp-Source: AGHT+IEWrOLXEnoxplL0eXEi/SpthtQwbZ6y7pKL2e59tZ8s3JQadQxULhRUvfXdSLXbDwyc9fQvQw==
X-Received: by 2002:a5d:5f42:0:b0:391:5f:fa4e with SMTP id ffacd0b85a97d-391005ffe69mr4807658f8f.29.1741015421039;
        Mon, 03 Mar 2025 07:23:41 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7868sm14700001f8f.24.2025.03.03.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:40 -0800 (PST)
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
Subject: [PATCH bpf-next v3 24/25] bpf: Maintain FIFO property for rqspinlock unlock
Date: Mon,  3 Mar 2025 07:23:04 -0800
Message-ID: <20250303152305.3195648-25-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4773; h=from:subject; bh=yd3gRpKNHABqLGxFwmo4qitDCfszyenvxRvQDwJYTjI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWZ7k4vMGesNz3gUHT6LOfeGtXRbGBf+aKUvuv/ umGpqdqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmQAKCRBM4MiGSL8RygluD/ 4uWKUHAjRffEJ86xP+I5MHqRuOHQ9jEAhSSdV7VPagDzTfZS8/JrswTTGLd4rS2xgwcFBwODkZ2aBs ayN+aLN1VPfzRRauqqYTO74IQCjSQVlRfrUc7QPeFDKF5iD9QPiLL3exq4eW9AGB7e+PuYaWH0wp3Q Wo/2jS/gXUhBTx2P5Iv9Lj56om69Hq7TGuUFrQVyvaC0CeinRJzaROx754KgWhnijwvOYUHsFZNFWS BR9qzsCLUTJhZhlEoX1z+ckbFZlKaMumFJaLjFUi3LW0r0wppTr+j6iVZ29CPh4p0x4H1/YOVIOehV mrk58kirt5EbcalsufoTGdl152sD0qdKJHO0pIefGYB9QVp9zzHJp+dGg5erc8UIcmn6J/IJuehSWC KgKZF6l00P5i0xwwz7h3GxNqSOfKGemo+nMTASSCL5HQGjzyWrrTOl3Yt5Sztu7F+qo4kTW554DaT6 z+9LE7AOC45QooYOFu15kG+QAhLeo+5nrl38cyPi60IHkU1JQ74e4y/92wb+i1BJsmtndDZAcwh48I YcPMi8nG85nDdwOaRNx4VNvVKDPLz3FdagXogkzXKN9BtKEUy/7x5cVgwICmIOCmHC3fqFTyvAimEK 8q9RN8RRT/ciTibX4PZBm9gB4uF8rSuHE+89XzSMRgzUjf0vXy/Qf6oVA84w==
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
index 269449363f78..7348bd824e16 100644
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
index 6c8ef72ee6bc..d3be8932abe4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1421,6 +1421,8 @@ static int copy_reference_state(struct bpf_verifier_state *dst, const struct bpf
 	dst->active_preempt_locks = src->active_preempt_locks;
 	dst->active_rcu_lock = src->active_rcu_lock;
 	dst->active_irq_id = src->active_irq_id;
+	dst->active_lock_id = src->active_lock_id;
+	dst->active_lock_ptr = src->active_lock_ptr;
 	return 0;
 }
 
@@ -1520,6 +1522,8 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 	s->ptr = ptr;
 
 	state->active_locks++;
+	state->active_lock_id = id;
+	state->active_lock_ptr = ptr;
 	return 0;
 }
 
@@ -1570,16 +1574,24 @@ static bool find_reference_state(struct bpf_verifier_state *state, int ptr_id)
 
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
@@ -8201,6 +8213,14 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
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
@@ -12393,8 +12413,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 	if (!env->cur_state->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env->cur_state, REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
-			    id, ptr);
+	s = find_lock_state(env->cur_state, REF_TYPE_LOCK_MASK, id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
@@ -18449,6 +18468,10 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
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
2.43.5


