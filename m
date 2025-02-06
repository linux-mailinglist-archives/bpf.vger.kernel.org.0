Return-Path: <bpf+bounces-50658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBEA2A693
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 12:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39573A8A45
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037752343C2;
	Thu,  6 Feb 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqvz62n+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86B227560;
	Thu,  6 Feb 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839315; cv=none; b=hWK5G6+b1/X2Hs5nl+nYA3QwhNZP4UeBJJd+cFyxKgEWAi+Nj47uvD09bYk3BBbYnTy6GdaVXiUjrzuX5JjoYdIoFixi7T+CAHYI9x3TUoRBDWFP9r/2RA4CxqRjsMvgpNBRLDbJznLjgx/bwaYZIHgZCighZxRkmeil+zV0ipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839315; c=relaxed/simple;
	bh=CpkXgirFn/osRo9yRzXQj0S5SI5kmNKbptLkawFmaSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLNkidODfjHHfa7906zVR1oJN59BEXKfG8wj3uDaWlpzSpnipSOWLeIKwPOi+noo1X+DlovsglCyhxwte2K8jsUxKf6zZ50bWL/hGkp1xwgfXs6O9/N0x1V1y7eI2bBdi+CoUZl64z3Q5oxaC/jWZhy3c7BlvHAMrYFI9ZMR5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqvz62n+; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4361815b96cso4771885e9.1;
        Thu, 06 Feb 2025 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839311; x=1739444111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEAtfk9sZ7vuzt+HmDZCm4BnfnO/7nvi4Al6O9lbnV0=;
        b=aqvz62n+cISyS51gPBqfK3FuRwPLR+5fpzyvuBIGJNSHPJ1wUpRrJflBRhPjONNwko
         2lEFyb7H01XM2fr70NclNQzAmKNomcERAMNy9hOP+dvanKP1SqIZcXuJNBe6waU7MLOv
         PWF3EtlGe1tz6PTs8wuI6JdWzZq09yBZ7s5Y1XsBxfPEFvpUFny5LAZM/nUA1kUgs0QS
         L+Ln/4/brMtYN9Siq3WJAsJWSOOoO3RUXLYYMJV+XBLSxg3Jf56bsXcQqc5B74mAGXgS
         jS+eBjCzDDoU+aVqLGWIw1NWp01iRoAUjuPTpfz+h5BpBxjhZLKK2XjGxx5YMh4O03/Q
         C/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839311; x=1739444111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEAtfk9sZ7vuzt+HmDZCm4BnfnO/7nvi4Al6O9lbnV0=;
        b=q7d8nyO2WDpdkI/rZSWOTCe5KXU+fWc0+BAjnTJkYN0OODQvWIoEBzAtTgCIgiOjCr
         LF1Ok/8TqcVSmAfNjhaypjxfjElkDdfAlwAqd5kH+fBk3GBWPvyLQbwQJq5HpJr5Agr0
         yrwEeG2XHrI4x8lpoycVsWWp4Xe+azEVdXUzkHIIkDQXpakqhYlt0Hw8MYVq2yNp21MW
         QIC2Mbm/GXzr094A/N4j993Jtifc2dtuCKHQnTdjyGXi5JpMS3SBOb4qBugL2fJBp58U
         Oiu30koA57DTZrzd3AqHGHCC5clbZKT/W+h2Tpq8qaHFj+qpTQGkkx8Xr2AH/agmzeD2
         qEnw==
X-Forwarded-Encrypted: i=1; AJvYcCUmVEeP9Qr0hl2pSpmhnu4QHnMGeNavjwWCbjcKaQmamuZxhEo0vhCAx9CqC0lPjBG6TJFQBC9yBLT0Ai0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1NEaUZsm+bHVnkjsoH+F0pxXT3T1egO/PH3Ko2wuGeZKvq8+S
	zuUyWK5t7Jii/LG0Fp8rxv0cgqmgr+0SdDDH85LfOEMVuxHDU68PI9ZwfOic7wg=
X-Gm-Gg: ASbGncve1v+FZwtYCMRgdJB9DOet3Lxb8YF0ZFSFQFAlOnvz2bezinAJVXnOszWdaDP
	g8QbL5A6XIHVsWZCu4oIGd8qgcDixm04HZIm8FDSrBPGIx4p8jSp9ZxHQHYGqg/GNl7aXzbkdHw
	YRpXa/Honwml9KtL1JMtERB1dednKGZ32zBeN13A2ih33Cw6tKfndo8QKwG+AnE38xzSoxiLuuR
	wumEFgoJtWmuIab08kOP17J7yUNRtzv4OKFfbfv0w+u+DJHlfAUwh2CAV613rGxuTtCsOpiMY+x
	JS0RSA==
X-Google-Smtp-Source: AGHT+IFqbAZGecNZkCkV4EyCt9uLl+Me6VZBFwE4Ef4f+7NoRNBRql5C5/fdSnEXvukiZ8DRRQsg4A==
X-Received: by 2002:a05:600c:3502:b0:434:a468:4a57 with SMTP id 5b1f17b1804b1-4390d56d740mr41168565e9.26.1738839311535;
        Thu, 06 Feb 2025 02:55:11 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:18::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d966faasm51736715e9.23.2025.02.06.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:10 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 25/26] bpf: Maintain FIFO property for rqspinlock unlock
Date: Thu,  6 Feb 2025 02:54:33 -0800
Message-ID: <20250206105435.2159977-26-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4773; h=from:subject; bh=CpkXgirFn/osRo9yRzXQj0S5SI5kmNKbptLkawFmaSc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRn9kSW/6/ffD2Y5sJ0f0LySFJbetcpzORHAy69 oJgq0WmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZwAKCRBM4MiGSL8RysTTEA Cs/dM0FPIuRegO0Ni1ae0PS45twSts6Al635nhtr0pJrXE19WwWgKiImtGQFXqq3EPB5/8SvfuaE8G J1P1qGxlxHodgTsNGv+svmEY0/JEu+q38yAWvB4eRw3JLHg9CbMW51ggxE1p3ZpyZYdbpTgg6oxbQE tBXlQcMrV6jKRRSW1tnaKkmrC9wWPdweMrStWBRYVKxQBsyiRvRP58LTSpAeAwLr8stkpLRqzpdlUM WixOEfnvLFoJZoPEOHf1EBfFZyIThmEomcF7O0RKWuNsk5bXmo/QkqIcglaJT064UNbt+Xcpn2Bdgv Q+c7mIOHcVf31dJK9WBMiOB2YeIOcQuybv5/L73vuSoYFc4o2Hj5Rl0C+sRvUP8mIlwf25+jxQvYBP 4tTP5udWN/wvGI3i3o1VSO5asN9D7U6bGMJ1ZAfO4SBI7Jy7BbBDsa143gR8A2A30Kw9d5HSmip4a0 DmlaU7qWHdV2XFecXaKQvl/1VrvRH9XWp3ofuOWKzZkjOYKHnOjpcqd9d0JVn9LNE+45UH8SAgmHyl VGJ9BQJpdJmgnhnBI4c3ltCVvXs7IkhGfKc0k5MJwxPnQTv+uV0xjj9cFG4MJ77JOXjgkV1tpM1Nka 70APhaWwVIcUoIfaNj8H3ninXADBCDCYIA8glTB00cVm16MtNyCn/PsFhxVQ==
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
index ed444e44f524..92cd2289b743 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -269,6 +269,7 @@ struct bpf_reference_state {
 		REF_TYPE_LOCK		= (1 << 3),
 		REF_TYPE_RES_LOCK 	= (1 << 4),
 		REF_TYPE_RES_LOCK_IRQ	= (1 << 5),
+		REF_TYPE_LOCK_MASK	= REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
 	} type;
 	/* Track each reference created with a unique id, even if the same
 	 * instruction creates the reference multiple times (eg, via CALL).
@@ -435,6 +436,8 @@ struct bpf_verifier_state {
 	u32 active_locks;
 	u32 active_preempt_locks;
 	u32 active_irq_id;
+	u32 active_lock_id;
+	void *active_lock_ptr;
 	bool active_rcu_lock;
 
 	bool speculative;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 294761dd0072..9cac6ea4f844 100644
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
 
@@ -1559,16 +1563,24 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 
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
@@ -8123,6 +8135,14 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
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
@@ -12284,8 +12304,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 	if (!env->cur_state->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env->cur_state, REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
-			    id, ptr);
+	s = find_lock_state(env->cur_state, REF_TYPE_LOCK_MASK, id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
@@ -18288,6 +18307,10 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
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


