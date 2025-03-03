Return-Path: <bpf+bounces-53094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF63A4C55B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 199DE7A94E1
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03F23A99C;
	Mon,  3 Mar 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pyh3rxiO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268923908C;
	Mon,  3 Mar 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015428; cv=none; b=iAlGwwjpOuoRml2fNcTHbUak4/UQyf7V4J9p8kk74u6gw2wzhk2T0xs4Fi9AYLhO0xF7XjHFOLBcJuGbC5IZR0A+WZHVy+IKgs2WqSM89rfaNKFIAlFZzu6nIwPyqBbxcyILWN3bNpxOdSwEuoQe4FbAsX4RcUq6ZRqg3s0TUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015428; c=relaxed/simple;
	bh=MO7GJTSenU9MV6IQtiRHmjgSgn53O+a0eeEhZHGj470=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDp7mOY2bsn2F5NiXcxV7MCF7HTWvPMcCVbj0yS9rJbrBpoYBMUm/rjN/EcTmj/kxOIv8w5frPUbAIa5zmM1MEUwN+mh6IiUjtuc2kQ6Qqkfo6Zi2u89ho2aLJDVVouIne8tIL6UOLoKff8S5aSR4tiRocaBY3rIj/oEEgfYwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pyh3rxiO; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso11284795e9.3;
        Mon, 03 Mar 2025 07:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015420; x=1741620220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4h+ukFvLyEJPpccEjjwwvawjNKj/Xrf/LqUnWOEd4Y=;
        b=Pyh3rxiOQSnrOSxW+Dw79e5FHhpcNOwIwHrI6AgsAcAUvLXwm9yZgRxcZpuCY91+43
         TzEjVTpE23gq2nn17b7jVNjvXOvbthW1i3TxylKmxJSODE/aowgTNH+rQlInt/hnkqSd
         +gOStsjjV219VoVErI2hEI3Hvx1cGEe7PbJdFkw+EetOHQ6AJes0/U+tuXHxKtUENd42
         rYinUFUu9psfuy6lvgJWR6sWbLI/qwzZ9gkb1MTDAeCrCBpeFzXXhWUPh1Z5Lwq30s0m
         YQP82Ax5WWAbfwXwBesyqJdsKQ/Ho1Yd9sYsPjKoCVKZZwLqcoG+Pm4bu73c33euyp/W
         t8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015420; x=1741620220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4h+ukFvLyEJPpccEjjwwvawjNKj/Xrf/LqUnWOEd4Y=;
        b=lOAwSw5oHa++4gpAAZZTzkRb/8qOJg4QRBF3szafaNJIIYmuK++mJP3jj+kgHVUiGf
         O8K/VLYchBYUH8zvo4zD2lxJf7eEQ3PGvM/vVUNatd1cRPOJFpNGbbb4EiXIjHhyadEU
         EGCeZ/ryJX0lsu6zOCfVJ2q3joBEldTDvkQs71LFKwTluSdpXxER38bZ4+LbElxjt6ao
         qwIgI0TJteeFVotO4CgNOh6E8WcsW9LkOHBxnrkfniq4RnNClZvvHSlSL+a7DctU1RVD
         wID0AA2miJwypDnfpunZ8EFKlJnFCM5F0BWlbvz6t5sgU27VZnlz46aDUlbcd3rVuicO
         u36w==
X-Forwarded-Encrypted: i=1; AJvYcCVyE1UA2o+X2KGUmetSsE6Vgqa7YcSMr1BkkwdSFhR/F4ZPj5rBw3SJo7MRRh/Hp3Gy4E9EUaTovKvu2bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEx2R/YnS5pGYAAAmY5n3myZFmeXDqm8sBbIDkiDdMQpqKsdJ
	dNmxGa8UGOpNdpWKJYLfEwW2eCltHX9Pidbs4fRi70hi8DWxKaN+INWP5GMF5/c=
X-Gm-Gg: ASbGnctoBxHLlzyJx3iPIZ7Tyry5Z4KUZlOJM3EjPQ7HrexGulFGuaz/hDPd8U8bo6s
	W4mWAAlmtSrghJB6DcVYUNCLz+58vBKNeNmD7K5auUBG7MdHO+MVJduJkiijyK6MtUpj2xYzmKU
	zkqHU1Uida8VrFIYsqoSM3/S8nEb5ezXo1k7z7ivsORXECfSHm4rta/J8A7pBgnJSCPHDTElVJt
	Y7RiBUB/qlizYACQfKoC5w8yCRwWauPHxs+e43574QKMOW9ICbCij7VmFYInvWroGrfDv2YeQmC
	Z1l2zlHmv9pdV5XbiWzvVYHl8KlsaahGRYs=
X-Google-Smtp-Source: AGHT+IEdAQLbk3XWgP5dxzDcU8Ji7pMN7/8gM3fi+1QJQlX4tiY+pFVN015rHmkdZZHHkiT9FlYiGA==
X-Received: by 2002:a05:600c:a4b:b0:439:8185:4ad4 with SMTP id 5b1f17b1804b1-43ba6747082mr109032045e9.27.1741015419506;
        Mon, 03 Mar 2025 07:23:39 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5f::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c4fsm14905417f8f.52.2025.03.03.07.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:38 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 23/25] bpf: Implement verifier support for rqspinlock
Date: Mon,  3 Mar 2025 07:23:03 -0800
Message-ID: <20250303152305.3195648-24-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28432; h=from:subject; bh=MO7GJTSenU9MV6IQtiRHmjgSgn53O+a0eeEhZHGj470=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWZN6Fo9q/LgMjUiSwqqQrTQMGCUIN7wbtUmcfA +jv1xeaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmQAKCRBM4MiGSL8Ryk4iD/ 965nxBXYR4dDVLmBm4StFtOJqi96rYjPW14Nx0sXbgZqtredefGx6C9t3nso+ga5OFs6Yx+xMoDQRg YWbhYxO3Ah7+hOpG/d6L0s+xnArh3d/iZccG+ZZBrwtDmkTir95j6qzGzg5Yih5QvE+voTDuUY53Em Ksftg/Dy4mTbp9WeCZgzvl9cgXSCuOmkDBPQVStIqV0sD7Cc2djPPY5bziy8LAbFRzIg9fLWLDQsOP i/7Edl/jMnt26/1s8G2GQHZmONpUOMz1+EbKo5yUnb2FDMLMN3cWT77SMGKxAf3WGBuM8dh7aETlfc Qwa3IlRRmJlIT2V7aaq5wpCTglKdk7GcrwmBLAZwPa9E2OdnrsE0xbfgKwyadRTkKi/g+YDjuX62oK bxvAMKv1+mMNQ2R2NWpZSi77gVZSJN8/IMzAifanV8irD72FhR30XzZ6eKed/e6z7Q2b4Vh9CK6/X+ 5cTtfh+RGvbKXZ2/rpoirQMG6Mn8kwxoChEbw8Qg1FSoZt6b1R81aAfJyxksexQhZaz0g9/KRtau4E isCtpZec3tmqmAfuHSAs7azUWnmw/YBFVByhGB8eK5zHHNdoDBerhK5Et15S+Ds3zyUv2wL9MxvyPs McFMK4xYH+u7FbG+hORXqQ2cp/vKO8Oaanj5qSwrZI4qmZ63JRCdJp0VULrQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce verifier-side support for rqspinlock kfuncs. The first step is
allowing bpf_res_spin_lock type to be defined in map values and
allocated objects, so BTF-side is updated with a new BPF_RES_SPIN_LOCK
field to recognize and validate.

Any object cannot have both bpf_spin_lock and bpf_res_spin_lock, only
one of them (and at most one of them per-object, like before) must be
present. The bpf_res_spin_lock can also be used to protect objects that
require lock protection for their kfuncs, like BPF rbtree and linked
list.

The verifier plumbing to simulate success and failure cases when calling
the kfuncs is done by pushing a new verifier state to the verifier state
stack which will verify the failure case upon calling the kfunc. The
path where success is indicated creates all lock reference state and IRQ
state (if necessary for irqsave variants). In the case of failure, the
state clears the registers r0-r5, sets the return value, and skips kfunc
processing, proceeding to the next instruction.

When marking the return value for success case, the value is marked as
0, and for the failure case as [-MAX_ERRNO, -1]. Then, in the program,
whenever user checks the return value as 'if (ret)' or 'if (ret < 0)'
the verifier never traverses such branches for success cases, and would
be aware that the lock is not held in such cases.

We push the kfunc state in check_kfunc_call whenever rqspinlock kfuncs
are invoked. We introduce a kfunc_class state to avoid mixing lock
irqrestore kfuncs with IRQ state created by bpf_local_irq_save.

With all this infrastructure, these kfuncs become usable in programs
while satisfying all safety properties required by the kernel.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |   9 ++
 include/linux/bpf_verifier.h |  16 ++-
 kernel/bpf/btf.c             |  26 ++++-
 kernel/bpf/syscall.c         |   6 +-
 kernel/bpf/verifier.c        | 219 ++++++++++++++++++++++++++++-------
 5 files changed, 231 insertions(+), 45 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aa47e11371b3..ad4468422770 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -205,6 +205,7 @@ enum btf_field_type {
 	BPF_REFCOUNT   = (1 << 9),
 	BPF_WORKQUEUE  = (1 << 10),
 	BPF_UPTR       = (1 << 11),
+	BPF_RES_SPIN_LOCK = (1 << 12),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -240,6 +241,7 @@ struct btf_record {
 	u32 cnt;
 	u32 field_mask;
 	int spin_lock_off;
+	int res_spin_lock_off;
 	int timer_off;
 	int wq_off;
 	int refcount_off;
@@ -315,6 +317,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 	switch (type) {
 	case BPF_SPIN_LOCK:
 		return "bpf_spin_lock";
+	case BPF_RES_SPIN_LOCK:
+		return "bpf_res_spin_lock";
 	case BPF_TIMER:
 		return "bpf_timer";
 	case BPF_WORKQUEUE:
@@ -347,6 +351,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	switch (type) {
 	case BPF_SPIN_LOCK:
 		return sizeof(struct bpf_spin_lock);
+	case BPF_RES_SPIN_LOCK:
+		return sizeof(struct bpf_res_spin_lock);
 	case BPF_TIMER:
 		return sizeof(struct bpf_timer);
 	case BPF_WORKQUEUE:
@@ -377,6 +383,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	switch (type) {
 	case BPF_SPIN_LOCK:
 		return __alignof__(struct bpf_spin_lock);
+	case BPF_RES_SPIN_LOCK:
+		return __alignof__(struct bpf_res_spin_lock);
 	case BPF_TIMER:
 		return __alignof__(struct bpf_timer);
 	case BPF_WORKQUEUE:
@@ -420,6 +428,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_RB_ROOT:
 		/* RB_ROOT_CACHED 0-inits, no need to do anything after memset */
 	case BPF_SPIN_LOCK:
+	case BPF_RES_SPIN_LOCK:
 	case BPF_TIMER:
 	case BPF_WORKQUEUE:
 	case BPF_KPTR_UNREF:
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d338f2a96bba..269449363f78 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -115,6 +115,14 @@ struct bpf_reg_state {
 			int depth:30;
 		} iter;
 
+		/* For irq stack slots */
+		struct {
+			enum {
+				IRQ_NATIVE_KFUNC,
+				IRQ_LOCK_KFUNC,
+			} kfunc_class;
+		} irq;
+
 		/* Max size from any of the above. */
 		struct {
 			unsigned long raw1;
@@ -255,9 +263,11 @@ struct bpf_reference_state {
 	 * default to pointer reference on zero initialization of a state.
 	 */
 	enum ref_state_type {
-		REF_TYPE_PTR	= 1,
-		REF_TYPE_IRQ	= 2,
-		REF_TYPE_LOCK	= 3,
+		REF_TYPE_PTR		= (1 << 1),
+		REF_TYPE_IRQ		= (1 << 2),
+		REF_TYPE_LOCK		= (1 << 3),
+		REF_TYPE_RES_LOCK 	= (1 << 4),
+		REF_TYPE_RES_LOCK_IRQ	= (1 << 5),
 	} type;
 	/* Track each reference created with a unique id, even if the same
 	 * instruction creates the reference multiple times (eg, via CALL).
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 519e3f5e9c10..f7a2bfb0c11a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3481,6 +3481,15 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 			goto end;
 		}
 	}
+	if (field_mask & BPF_RES_SPIN_LOCK) {
+		if (!strcmp(name, "bpf_res_spin_lock")) {
+			if (*seen_mask & BPF_RES_SPIN_LOCK)
+				return -E2BIG;
+			*seen_mask |= BPF_RES_SPIN_LOCK;
+			type = BPF_RES_SPIN_LOCK;
+			goto end;
+		}
+	}
 	if (field_mask & BPF_TIMER) {
 		if (!strcmp(name, "bpf_timer")) {
 			if (*seen_mask & BPF_TIMER)
@@ -3659,6 +3668,7 @@ static int btf_find_field_one(const struct btf *btf,
 
 	switch (field_type) {
 	case BPF_SPIN_LOCK:
+	case BPF_RES_SPIN_LOCK:
 	case BPF_TIMER:
 	case BPF_WORKQUEUE:
 	case BPF_LIST_NODE:
@@ -3952,6 +3962,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		return ERR_PTR(-ENOMEM);
 
 	rec->spin_lock_off = -EINVAL;
+	rec->res_spin_lock_off = -EINVAL;
 	rec->timer_off = -EINVAL;
 	rec->wq_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
@@ -3979,6 +3990,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			/* Cache offset for faster lookup at runtime */
 			rec->spin_lock_off = rec->fields[i].offset;
 			break;
+		case BPF_RES_SPIN_LOCK:
+			WARN_ON_ONCE(rec->spin_lock_off >= 0);
+			/* Cache offset for faster lookup at runtime */
+			rec->res_spin_lock_off = rec->fields[i].offset;
+			break;
 		case BPF_TIMER:
 			WARN_ON_ONCE(rec->timer_off >= 0);
 			/* Cache offset for faster lookup at runtime */
@@ -4022,9 +4038,15 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		rec->cnt++;
 	}
 
+	if (rec->spin_lock_off >= 0 && rec->res_spin_lock_off >= 0) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	/* bpf_{list_head, rb_node} require bpf_spin_lock */
 	if ((btf_record_has_field(rec, BPF_LIST_HEAD) ||
-	     btf_record_has_field(rec, BPF_RB_ROOT)) && rec->spin_lock_off < 0) {
+	     btf_record_has_field(rec, BPF_RB_ROOT)) &&
+		 (rec->spin_lock_off < 0 && rec->res_spin_lock_off < 0)) {
 		ret = -EINVAL;
 		goto end;
 	}
@@ -5637,7 +5659,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 
 		type = &tab->types[tab->cnt];
 		type->btf_id = i;
-		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
+		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
 						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
 						  BPF_KPTR, t->size);
 		/* The record cannot be unset, treat it as an error if so */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 57a438706215..5cf017e37d7d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -665,6 +665,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_RB_ROOT:
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
+		case BPF_RES_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
@@ -717,6 +718,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_RB_ROOT:
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
+		case BPF_RES_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
@@ -794,6 +796,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 
 		switch (fields[i].type) {
 		case BPF_SPIN_LOCK:
+		case BPF_RES_SPIN_LOCK:
 			break;
 		case BPF_TIMER:
 			bpf_timer_cancel_and_free(field_ptr);
@@ -1229,7 +1232,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 		return -EINVAL;
 
 	map->record = btf_parse_fields(btf, value_type,
-				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
+				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
@@ -1248,6 +1251,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case 0:
 				continue;
 			case BPF_SPIN_LOCK:
+			case BPF_RES_SPIN_LOCK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
 				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb1624f6e743..6c8ef72ee6bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -456,7 +456,7 @@ static bool subprog_is_exc_cb(struct bpf_verifier_env *env, int subprog)
 
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK);
+	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -1148,7 +1148,8 @@ static int release_irq_state(struct bpf_verifier_state *state, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_kfunc_call_arg_meta *meta,
-				     struct bpf_reg_state *reg, int insn_idx)
+				     struct bpf_reg_state *reg, int insn_idx,
+				     int kfunc_class)
 {
 	struct bpf_func_state *state = func(env, reg);
 	struct bpf_stack_state *slot;
@@ -1170,6 +1171,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
 	st->live |= REG_LIVE_WRITTEN;
 	st->ref_obj_id = id;
+	st->irq.kfunc_class = kfunc_class;
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
 		slot->slot_type[i] = STACK_IRQ_FLAG;
@@ -1178,7 +1180,8 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				      int kfunc_class)
 {
 	struct bpf_func_state *state = func(env, reg);
 	struct bpf_stack_state *slot;
@@ -1192,6 +1195,15 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 	slot = &state->stack[spi];
 	st = &slot->spilled_ptr;
 
+	if (st->irq.kfunc_class != kfunc_class) {
+		const char *flag_kfunc = st->irq.kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
+		const char *used_kfunc = kfunc_class == IRQ_NATIVE_KFUNC ? "native" : "lock";
+
+		verbose(env, "irq flag acquired by %s kfuncs cannot be restored with %s kfuncs\n",
+			flag_kfunc, used_kfunc);
+		return -EINVAL;
+	}
+
 	err = release_irq_state(env->cur_state, st->ref_obj_id);
 	WARN_ON_ONCE(err && err != -EACCES);
 	if (err) {
@@ -1602,7 +1614,7 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	for (i = 0; i < state->acquired_refs; i++) {
 		struct bpf_reference_state *s = &state->refs[i];
 
-		if (s->type != type)
+		if (!(s->type & type))
 			continue;
 
 		if (s->id == id && s->ptr == ptr)
@@ -8063,6 +8075,12 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
 	return err;
 }
 
+enum {
+	PROCESS_SPIN_LOCK = (1 << 0),
+	PROCESS_RES_LOCK  = (1 << 1),
+	PROCESS_LOCK_IRQ  = (1 << 2),
+};
+
 /* Implementation details:
  * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL.
  * bpf_obj_new returns PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL.
@@ -8085,30 +8103,33 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
  * env->cur_state->active_locks remembers which map value element or allocated
  * object got locked and clears it after bpf_spin_unlock.
  */
-static int process_spin_lock(struct bpf_verifier_env *env, int regno,
-			     bool is_lock)
+static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 {
+	bool is_lock = flags & PROCESS_SPIN_LOCK, is_res_lock = flags & PROCESS_RES_LOCK;
+	const char *lock_str = is_res_lock ? "bpf_res_spin" : "bpf_spin";
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
+	bool is_irq = flags & PROCESS_LOCK_IRQ;
 	u64 val = reg->var_off.value;
 	struct bpf_map *map = NULL;
 	struct btf *btf = NULL;
 	struct btf_record *rec;
+	u32 spin_lock_off;
 	int err;
 
 	if (!is_const) {
 		verbose(env,
-			"R%d doesn't have constant offset. bpf_spin_lock has to be at the constant offset\n",
-			regno);
+			"R%d doesn't have constant offset. %s_lock has to be at the constant offset\n",
+			regno, lock_str);
 		return -EINVAL;
 	}
 	if (reg->type == PTR_TO_MAP_VALUE) {
 		map = reg->map_ptr;
 		if (!map->btf) {
 			verbose(env,
-				"map '%s' has to have BTF in order to use bpf_spin_lock\n",
-				map->name);
+				"map '%s' has to have BTF in order to use %s_lock\n",
+				map->name, lock_str);
 			return -EINVAL;
 		}
 	} else {
@@ -8116,36 +8137,53 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	}
 
 	rec = reg_btf_record(reg);
-	if (!btf_record_has_field(rec, BPF_SPIN_LOCK)) {
-		verbose(env, "%s '%s' has no valid bpf_spin_lock\n", map ? "map" : "local",
-			map ? map->name : "kptr");
+	if (!btf_record_has_field(rec, is_res_lock ? BPF_RES_SPIN_LOCK : BPF_SPIN_LOCK)) {
+		verbose(env, "%s '%s' has no valid %s_lock\n", map ? "map" : "local",
+			map ? map->name : "kptr", lock_str);
 		return -EINVAL;
 	}
-	if (rec->spin_lock_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
-			val + reg->off, rec->spin_lock_off);
+	spin_lock_off = is_res_lock ? rec->res_spin_lock_off : rec->spin_lock_off;
+	if (spin_lock_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct %s_lock' that is at %d\n",
+			val + reg->off, lock_str, spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
 		void *ptr;
+		int type;
 
 		if (map)
 			ptr = map;
 		else
 			ptr = btf;
 
-		if (cur->active_locks) {
-			verbose(env,
-				"Locking two bpf_spin_locks are not allowed\n");
-			return -EINVAL;
+		if (!is_res_lock && cur->active_locks) {
+			if (find_lock_state(env->cur_state, REF_TYPE_LOCK, 0, NULL)) {
+				verbose(env,
+					"Locking two bpf_spin_locks are not allowed\n");
+				return -EINVAL;
+			}
+		} else if (is_res_lock && cur->active_locks) {
+			if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ, reg->id, ptr)) {
+				verbose(env, "Acquiring the same lock again, AA deadlock detected\n");
+				return -EINVAL;
+			}
 		}
-		err = acquire_lock_state(env, env->insn_idx, REF_TYPE_LOCK, reg->id, ptr);
+
+		if (is_res_lock && is_irq)
+			type = REF_TYPE_RES_LOCK_IRQ;
+		else if (is_res_lock)
+			type = REF_TYPE_RES_LOCK;
+		else
+			type = REF_TYPE_LOCK;
+		err = acquire_lock_state(env, env->insn_idx, type, reg->id, ptr);
 		if (err < 0) {
 			verbose(env, "Failed to acquire lock state\n");
 			return err;
 		}
 	} else {
 		void *ptr;
+		int type;
 
 		if (map)
 			ptr = map;
@@ -8153,12 +8191,18 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			ptr = btf;
 
 		if (!cur->active_locks) {
-			verbose(env, "bpf_spin_unlock without taking a lock\n");
+			verbose(env, "%s_unlock without taking a lock\n", lock_str);
 			return -EINVAL;
 		}
 
-		if (release_lock_state(env->cur_state, REF_TYPE_LOCK, reg->id, ptr)) {
-			verbose(env, "bpf_spin_unlock of different lock\n");
+		if (is_res_lock && is_irq)
+			type = REF_TYPE_RES_LOCK_IRQ;
+		else if (is_res_lock)
+			type = REF_TYPE_RES_LOCK;
+		else
+			type = REF_TYPE_LOCK;
+		if (release_lock_state(cur, type, reg->id, ptr)) {
+			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
 
@@ -9484,11 +9528,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		if (meta->func_id == BPF_FUNC_spin_lock) {
-			err = process_spin_lock(env, regno, true);
+			err = process_spin_lock(env, regno, PROCESS_SPIN_LOCK);
 			if (err)
 				return err;
 		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			err = process_spin_lock(env, regno, false);
+			err = process_spin_lock(env, regno, 0);
 			if (err)
 				return err;
 		} else {
@@ -11370,7 +11414,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].map_uid = meta.map_uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
 		if (!type_may_be_null(ret_flag) &&
-		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK)) {
+		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 		break;
@@ -11542,10 +11586,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 /* mark_btf_func_reg_size() is used when the reg size is determined by
  * the BTF func_proto's return value size and argument.
  */
-static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
-				   size_t reg_size)
+static void __mark_btf_func_reg_size(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
+				     u32 regno, size_t reg_size)
 {
-	struct bpf_reg_state *reg = &cur_regs(env)[regno];
+	struct bpf_reg_state *reg = &regs[regno];
 
 	if (regno == BPF_REG_0) {
 		/* Function return value */
@@ -11563,6 +11607,12 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
 	}
 }
 
+static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
+				   size_t reg_size)
+{
+	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
+}
+
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ACQUIRE;
@@ -11700,6 +11750,7 @@ enum {
 	KF_ARG_RB_ROOT_ID,
 	KF_ARG_RB_NODE_ID,
 	KF_ARG_WORKQUEUE_ID,
+	KF_ARG_RES_SPIN_LOCK_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -11709,6 +11760,7 @@ BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
+BTF_ID(struct, bpf_res_spin_lock)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -11757,6 +11809,11 @@ static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_WORKQUEUE_ID);
 }
 
+static bool is_kfunc_arg_res_spin_lock(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RES_SPIN_LOCK_ID);
+}
+
 static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
 				  const struct btf_param *arg)
 {
@@ -11828,6 +11885,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_MAP,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
+	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 };
 
 enum special_kfunc_type {
@@ -11866,6 +11924,10 @@ enum special_kfunc_type {
 	KF_bpf_iter_num_destroy,
 	KF_bpf_set_dentry_xattr,
 	KF_bpf_remove_dentry_xattr,
+	KF_bpf_res_spin_lock,
+	KF_bpf_res_spin_unlock,
+	KF_bpf_res_spin_lock_irqsave,
+	KF_bpf_res_spin_unlock_irqrestore,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11955,6 +12017,10 @@ BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_res_spin_lock)
+BTF_ID(func, bpf_res_spin_unlock)
+BTF_ID(func, bpf_res_spin_lock_irqsave)
+BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12048,6 +12114,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_IRQ_FLAG;
 
+	if (is_kfunc_arg_res_spin_lock(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_RES_SPIN_LOCK;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -12155,13 +12224,19 @@ static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int err, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
-	int err;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save]) {
+	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]) {
 		irq_save = true;
-	} else if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_restore]) {
+		if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])
+			kfunc_class = IRQ_LOCK_KFUNC;
+	} else if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_restore] ||
+		   meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore]) {
 		irq_save = false;
+		if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore])
+			kfunc_class = IRQ_LOCK_KFUNC;
 	} else {
 		verbose(env, "verifier internal error: unknown irq flags kfunc\n");
 		return -EFAULT;
@@ -12177,7 +12252,7 @@ static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 		if (err)
 			return err;
 
-		err = mark_stack_slot_irq_flag(env, meta, reg, env->insn_idx);
+		err = mark_stack_slot_irq_flag(env, meta, reg, env->insn_idx, kfunc_class);
 		if (err)
 			return err;
 	} else {
@@ -12191,7 +12266,7 @@ static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 		if (err)
 			return err;
 
-		err = unmark_stack_slot_irq_flag(env, reg);
+		err = unmark_stack_slot_irq_flag(env, reg, kfunc_class);
 		if (err)
 			return err;
 	}
@@ -12318,7 +12393,8 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 	if (!env->cur_state->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env->cur_state, REF_TYPE_LOCK, id, ptr);
+	s = find_lock_state(env->cur_state, REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
+			    id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
@@ -12354,9 +12430,18 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 	       btf_id == special_kfunc_list[KF_bpf_refcount_acquire_impl];
 }
 
+static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
+	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
+	       btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
+	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
+}
+
 static bool kfunc_spin_allowed(u32 btf_id)
 {
-	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id);
+	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
+	       is_bpf_res_spin_lock_kfunc(btf_id);
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
@@ -12788,6 +12873,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
+		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -13086,6 +13172,28 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
+		{
+			int flags = PROCESS_RES_LOCK;
+
+			if (reg->type != PTR_TO_MAP_VALUE && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+				verbose(env, "arg#%d doesn't point to map value or allocated object\n", i);
+				return -EINVAL;
+			}
+
+			if (!is_bpf_res_spin_lock_kfunc(meta->func_id))
+				return -EFAULT;
+			if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])
+				flags |= PROCESS_SPIN_LOCK;
+			if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
+			    meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore])
+				flags |= PROCESS_LOCK_IRQ;
+			ret = process_spin_lock(env, regno, flags);
+			if (ret < 0)
+				return ret;
+			break;
+		}
 		}
 	}
 
@@ -13171,6 +13279,33 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
 
+	if (!insn->off &&
+	    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
+	     insn->imm == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
+		struct bpf_verifier_state *branch;
+		struct bpf_reg_state *regs;
+
+		branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
+		if (!branch) {
+			verbose(env, "failed to push state for failed lock acquisition\n");
+			return -ENOMEM;
+		}
+
+		regs = branch->frame[branch->curframe]->regs;
+
+		/* Clear r0-r5 registers in forked state */
+		for (i = 0; i < CALLER_SAVED_REGS; i++)
+			mark_reg_not_init(env, regs, caller_saved[i]);
+
+		mark_reg_unknown(env, regs, BPF_REG_0);
+		err = __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_ERRNO, -1);
+		if (err) {
+			verbose(env, "failed to mark s32 range for retval in forked state for lock\n");
+			return err;
+		}
+		__mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32));
+	}
+
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
 		return -EACCES;
@@ -13341,6 +13476,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (btf_type_is_scalar(t)) {
 		mark_reg_unknown(env, regs, BPF_REG_0);
+		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
+		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
+			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
@@ -18275,7 +18413,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		case STACK_IRQ_FLAG:
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
-			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
+			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
 				return false;
 			break;
 		case STACK_MISC:
@@ -18319,6 +18458,8 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
+		case REF_TYPE_RES_LOCK:
+		case REF_TYPE_RES_LOCK_IRQ:
 			if (old->refs[i].ptr != cur->refs[i].ptr)
 				return false;
 			break;
@@ -19641,7 +19782,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
-	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
+	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
-- 
2.43.5


