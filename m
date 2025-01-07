Return-Path: <bpf+bounces-48119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A8A04193
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82718166D58
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9631F2C3D;
	Tue,  7 Jan 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ9cJyCn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32B1F4273;
	Tue,  7 Jan 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258452; cv=none; b=UDRIPnnRx6fT+GUMGPzbcWhbLx6v3R4fZBq7U4jSxOjK8pN3z46bET7yaupDjO338713xvVtXLzsSMQ26zEUmOp4qtAF0z/1pMJu+zaWCqADAHz2WDA/s4uUtbGTwlJC0uUS8J2YcNt2GT4NsDz/pZEl9g2+D4na5Pqfj9EQ0Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258452; c=relaxed/simple;
	bh=YumETHfw6wrlh+Bk4qX4yE5a5GND4mH/NOVkSjmOCBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBuujcC9gi7PTWf9G0JS6tjbmS0prfYBEeVcEdeHycGSYFjE21q12+nZyNMErCfHep6UIAcAGyKdUeMMmfmoFXzAd1mKRxdcXcFxs9sZZYetRG3X8o23PVKFSWIRsH54A72HuYSUlARHODGFrXRTtrXGM3gN+udk1nk08w3pcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ9cJyCn; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so26118735e9.1;
        Tue, 07 Jan 2025 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258442; x=1736863242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asqlADWnEA+4wqCgWZ57L1bfGFaYkno6Qz2eZ/6rUpc=;
        b=YQ9cJyCnQbhAPg+UG8sNlrmhCMovxOYpTGRBGTer7IGDzZkT25vO/Nc9Gp1a8I5bkV
         MZgej9CBet0wJONboqhQdWjcqJa9xS+JcxpCRV/RPjK/fx36nQ9T/0SIjSOLL/gBTE4c
         Cj1dTJBNvnx7Rl13L/DvoioZnc8nhC7pyEayRnAYCiJdItWV1MC9S1ZSKc9KT9Gt7ppm
         e+4D7N8XQr6TSvSkTOy2ao76gQrAhyWe9bcU04La5ECL+gOzfr8VjX+6+KHndXmtdiSg
         +yUwJP2tAwkunzXkcMPkZAfmWrct+71HoorGJdsEuymt6b3fmQyuaxdqqvgYLfYp3yda
         JL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258442; x=1736863242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asqlADWnEA+4wqCgWZ57L1bfGFaYkno6Qz2eZ/6rUpc=;
        b=K+AQBl4fU0PixIs6PLczsn6wbA5lRj5mvf/R3UhKJyzxYl3NXawkeQMhjoG1PV8Sjf
         Kg1pH56LT9HipUs6yQnsAp3knld3d0xVrtOvcWzcveOfTv7F+scwPEJOb0+hKfYu3ynG
         PVR4auJ/L/RrX8dZdAFrKzqBHp3MJ8Jh0h31CaHSwljJX+C3jkXQW+E/490L6lav0pHo
         w31u7Jkq685GZrPnNJBG7SDwM0zooFcL0uaAVuy6iWKbBTC+jKZYYrw82N1C/dP4Wosh
         bKNRUDDgh08qxOGA4YwC6avtxQaL7K61DIoMXNmyjQawxYyh2h2qkF/kU5nAMpYRfSOZ
         Zj/A==
X-Forwarded-Encrypted: i=1; AJvYcCUmjJi9PGRDnrjhEX09PLR4buLkk1UUv8RsgYScZhZB+VdOF0EFPiKDLdCIvpV04d9Adm7K2SK9f8wcMz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDkyo3w7uiAmM3hw4NDJXhsgUuzw4NxemVDMJL7ffnrBZANENO
	cX7VfFGyx/U3XTkOUj6JmsUDx3rve+kpA3N8aFM2diwdm8SHDuCQrqMjTRLFsORbxA==
X-Gm-Gg: ASbGnctvFDPdS9AyxdnA+7qFVAbMTb+gkLYnPHUHhlnu2K4p2Tx2r3u92YPRh00yoRM
	O2Moa1jP/U4xnoxxa8UrK8IMJwMe5ea2rjkWDWfKrfS169AuLtDU2zqicpuegSEGizjwq2XE2n0
	AuNHifRM+BcEZSoLv8Z8gGrmV8w6AB/ipIlqp2p92Loc8XE4SCxMHmk6IGjTo03NmRzJkGsxroX
	9MD9lwSPCTOHAOwZsMK3Ol92kSRG0wsT6VH9brimG66/w==
X-Google-Smtp-Source: AGHT+IGyllfF0Y50gDbbAxqMapeKd1uMt7SzeqVy8eiDP1iFMoigfrrz2FK0+MMAe1rVIDp+Fqvf4Q==
X-Received: by 2002:a05:600c:1f85:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-43668646741mr576645145e9.18.1736258441758;
        Tue, 07 Jan 2025 06:00:41 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b442dasm629967385e9.42.2025.01.07.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 21/22] bpf: Implement verifier support for rqspinlock
Date: Tue,  7 Jan 2025 06:00:03 -0800
Message-ID: <20250107140004.2732830-22-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=30683; h=from:subject; bh=YumETHfw6wrlh+Bk4qX4yE5a5GND4mH/NOVkSjmOCBw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCfBJ7SVumSPoVV68x9ZtKlPL5zj6CZBb7DL7R8 JJ1WgtOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnwAKCRBM4MiGSL8RyjcxD/ 9atY1N5ObQekBkzcdFlgVjMg5wT7+G7Q/8pwyOT1L98SLOS+FF6CDkzF/iMtZylod00QBAIyEI3RvT 9UQBg81/x9/qpocxEHJ3DWV9KOixmwVbDPw03MtvKnuree4lwgqNM0S5gGCElSo1a+5NP14l5vx6du ppAmas3NpRBvLK3c2XYi5ANWHiaZkiME0UJOiuvoopiLu+1Z5Y5pgWti38yRlRmmJMoyuQTL3bSa/n C1RDD6m4N6SthC9GAzSjplFHr7TRo2X2BspPHXG11n6N95VS5TSkkj7ofXJrLTp5F+KyF9gB5WAzs4 JDOpYimnsjiPeiGEJ7U6uxvGf6SzGdOKLJ7UU9Oe/8veV+8iYyOeNVciiytUcyI+Wy4O7aPsKbZXL4 JY14/5ofg/Rc4vtYnS/cHtVfApdbn2Pmy53+qqcclr9malkr9tGIyM3ZbdtKdnPwDBHDIGTTMj9IAX y3YiBd+Eo9AexBQ3BdNnmbNOuwCJUI9WdccrE8RxSEdvaWX+Dc+uucfziUALD47JaEsMMRLSxUAWjy ErTf0wXQYFoqzIu3CSxWoLAvfUXTybM0ArbVRDBwaYtoBSoTVeMQ40cTi0/IaqPzVyYgWHqcXhN4Q4 JH+JdfYAShFx/P2a92XwqMgYPQ1FkOj1Eq9M2kFU41UoZ/iYvt8UhJARCljA==
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
state (if necessary for irqsave variants). In the case of failure, all
state creation is skipped while verifying the kfunc. When marking the
return value for success case, the value is marked as 0, and for the
failure case as [-MAX_ERRNO, -1]. Then, in the program, whenever user
checks the return value as 'if (ret)' or 'if (ret < 0)' the verifier
never traverses such branches for success cases, and would be aware that
the lock is not held in such cases.

We push the kfunc state in do_check and then call check_kfunc_call
separately for pushed state and the current state, and operate on the
current state in case of success, and skip adding lock and IRQ state in
case of failure. Failure state is indicated using PROCESS_LOCK_FAIL
flag.

We introduce a kfunc_class state to avoid mixing lock irqrestore kfuncs
with IRQ state created by bpf_local_irq_save.

With all this infrastructure, these kfuncs become usable in programs
while satisfying all safety properties required by the kernel.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |   9 ++
 include/linux/bpf_verifier.h |  17 ++-
 kernel/bpf/btf.c             |  26 +++-
 kernel/bpf/syscall.c         |   6 +-
 kernel/bpf/verifier.c        | 233 ++++++++++++++++++++++++++++-------
 5 files changed, 238 insertions(+), 53 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f93a4f40aaaf..fd05c13590e0 100644
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
index 32c23f2a3086..ed444e44f524 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -115,6 +115,15 @@ struct bpf_reg_state {
 			int depth:30;
 		} iter;
 
+		/* For irq stack slots */
+		struct {
+			enum {
+				IRQ_KFUNC_IGNORE,
+				IRQ_NATIVE_KFUNC,
+				IRQ_LOCK_KFUNC,
+			} kfunc_class;
+		} irq;
+
 		/* Max size from any of the above. */
 		struct {
 			unsigned long raw1;
@@ -255,9 +264,11 @@ struct bpf_reference_state {
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
index 8396ce1d0fba..99c9fdbdd31c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3477,6 +3477,15 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
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
@@ -3655,6 +3664,7 @@ static int btf_find_field_one(const struct btf *btf,
 
 	switch (field_type) {
 	case BPF_SPIN_LOCK:
+	case BPF_RES_SPIN_LOCK:
 	case BPF_TIMER:
 	case BPF_WORKQUEUE:
 	case BPF_LIST_NODE:
@@ -3948,6 +3958,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		return ERR_PTR(-ENOMEM);
 
 	rec->spin_lock_off = -EINVAL;
+	rec->res_spin_lock_off = -EINVAL;
 	rec->timer_off = -EINVAL;
 	rec->wq_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
@@ -3975,6 +3986,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
@@ -4018,9 +4034,15 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
@@ -5638,7 +5660,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 
 		type = &tab->types[tab->cnt];
 		type->btf_id = i;
-		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
+		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
 						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
 						  BPF_KPTR, t->size);
 		/* The record cannot be unset, treat it as an error if so */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e88797fdbeb..9701212aa2ed 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -648,6 +648,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_RB_ROOT:
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
+		case BPF_RES_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
@@ -700,6 +701,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_RB_ROOT:
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
+		case BPF_RES_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
@@ -777,6 +779,7 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 
 		switch (fields[i].type) {
 		case BPF_SPIN_LOCK:
+		case BPF_RES_SPIN_LOCK:
 			break;
 		case BPF_TIMER:
 			bpf_timer_cancel_and_free(field_ptr);
@@ -1199,7 +1202,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 		return -EINVAL;
 
 	map->record = btf_parse_fields(btf, value_type,
-				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
+				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
@@ -1218,6 +1221,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 			case 0:
 				continue;
 			case BPF_SPIN_LOCK:
+			case BPF_RES_SPIN_LOCK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY &&
 				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8ca227c78af..bf230599d6f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -455,7 +455,7 @@ static bool subprog_is_exc_cb(struct bpf_verifier_env *env, int subprog)
 
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK);
+	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -1147,7 +1147,8 @@ static int release_irq_state(struct bpf_verifier_state *state, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 				     struct bpf_kfunc_call_arg_meta *meta,
-				     struct bpf_reg_state *reg, int insn_idx)
+				     struct bpf_reg_state *reg, int insn_idx,
+				     int kfunc_class)
 {
 	struct bpf_func_state *state = func(env, reg);
 	struct bpf_stack_state *slot;
@@ -1169,6 +1170,7 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	st->type = PTR_TO_STACK; /* we don't have dedicated reg type */
 	st->live |= REG_LIVE_WRITTEN;
 	st->ref_obj_id = id;
+	st->irq.kfunc_class = kfunc_class;
 
 	for (i = 0; i < BPF_REG_SIZE; i++)
 		slot->slot_type[i] = STACK_IRQ_FLAG;
@@ -1177,7 +1179,8 @@ static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				      int kfunc_class)
 {
 	struct bpf_func_state *state = func(env, reg);
 	struct bpf_stack_state *slot;
@@ -1191,6 +1194,15 @@ static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, struct bpf_r
 	slot = &state->stack[spi];
 	st = &slot->spilled_ptr;
 
+	if (kfunc_class != IRQ_KFUNC_IGNORE && st->irq.kfunc_class != kfunc_class) {
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
@@ -1588,7 +1600,7 @@ static struct bpf_reference_state *find_lock_state(struct bpf_verifier_state *st
 	for (i = 0; i < state->acquired_refs; i++) {
 		struct bpf_reference_state *s = &state->refs[i];
 
-		if (s->type != type)
+		if (!(s->type & type))
 			continue;
 
 		if (s->id == id && s->ptr == ptr)
@@ -7995,6 +8007,13 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
 	return err;
 }
 
+enum {
+	PROCESS_SPIN_LOCK = (1 << 0),
+	PROCESS_RES_LOCK  = (1 << 1),
+	PROCESS_LOCK_IRQ  = (1 << 2),
+	PROCESS_LOCK_FAIL = (1 << 3),
+};
+
 /* Implementation details:
  * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL.
  * bpf_obj_new returns PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL.
@@ -8017,30 +8036,38 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
  * env->cur_state->active_locks remembers which map value element or allocated
  * object got locked and clears it after bpf_spin_unlock.
  */
-static int process_spin_lock(struct bpf_verifier_env *env, int regno,
-			     bool is_lock)
+static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_verifier_state *cur, int regno, int flags)
 {
+	bool is_lock = flags & PROCESS_SPIN_LOCK, is_res_lock = flags & PROCESS_RES_LOCK;
+	const char *lock_str = is_res_lock ? "bpf_res_spin" : "bpf_spin";
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
+	bool is_irq = flags & PROCESS_LOCK_IRQ;
 	u64 val = reg->var_off.value;
 	struct bpf_map *map = NULL;
 	struct btf *btf = NULL;
 	struct btf_record *rec;
+	u32 spin_lock_off;
 	int err;
 
+	/* If the spin lock acquisition failed, we don't process the argument. */
+	if (flags & PROCESS_LOCK_FAIL)
+		return 0;
+	/* Success case always operates on current state only. */
+	WARN_ON_ONCE(cur != env->cur_state);
+
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
@@ -8048,36 +8075,53 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
+		} else if (is_res_lock) {
+			if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK, reg->id, ptr)) {
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
@@ -8085,12 +8129,18 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
+		if (release_lock_state(env->cur_state, type, reg->id, ptr)) {
+			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
 
@@ -9338,11 +9388,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		if (meta->func_id == BPF_FUNC_spin_lock) {
-			err = process_spin_lock(env, regno, true);
+			err = process_spin_lock(env, env->cur_state, regno, PROCESS_SPIN_LOCK);
 			if (err)
 				return err;
 		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			err = process_spin_lock(env, regno, false);
+			err = process_spin_lock(env, env->cur_state, regno, 0);
 			if (err)
 				return err;
 		} else {
@@ -11529,6 +11579,7 @@ enum {
 	KF_ARG_RB_ROOT_ID,
 	KF_ARG_RB_NODE_ID,
 	KF_ARG_WORKQUEUE_ID,
+	KF_ARG_RES_SPIN_LOCK_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -11538,6 +11589,7 @@ BTF_ID(struct, bpf_list_node)
 BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
+BTF_ID(struct, bpf_res_spin_lock)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -11586,6 +11638,11 @@ static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
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
@@ -11657,6 +11714,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_MAP,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
+	KF_ARG_PTR_TO_RES_SPIN_LOCK,
 };
 
 enum special_kfunc_type {
@@ -11693,6 +11751,10 @@ enum special_kfunc_type {
 	KF_bpf_iter_num_new,
 	KF_bpf_iter_num_next,
 	KF_bpf_iter_num_destroy,
+	KF_bpf_res_spin_lock,
+	KF_bpf_res_spin_unlock,
+	KF_bpf_res_spin_lock_irqsave,
+	KF_bpf_res_spin_unlock_irqrestore,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11771,6 +11833,10 @@ BTF_ID(func, bpf_local_irq_restore)
 BTF_ID(func, bpf_iter_num_new)
 BTF_ID(func, bpf_iter_num_next)
 BTF_ID(func, bpf_iter_num_destroy)
+BTF_ID(func, bpf_res_spin_lock)
+BTF_ID(func, bpf_res_spin_unlock)
+BTF_ID(func, bpf_res_spin_lock_irqsave)
+BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11864,6 +11930,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_IRQ_FLAG;
 
+	if (is_kfunc_arg_res_spin_lock(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_RES_SPIN_LOCK;
+
 	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 		if (!btf_type_is_struct(ref_t)) {
 			verbose(env, "kernel function %s args#%d pointer type %s %s is not supported\n",
@@ -11967,22 +12036,34 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int process_irq_flag(struct bpf_verifier_env *env, int regno,
-			     struct bpf_kfunc_call_arg_meta *meta)
+static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate, int regno,
+			    struct bpf_kfunc_call_arg_meta *meta, int flags)
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
 	}
 
+	/* If the spin lock acquisition failed, we don't process the argument. */
+	if (kfunc_class == IRQ_LOCK_KFUNC && (flags & PROCESS_LOCK_FAIL))
+		return 0;
+	/* Success case always operates on current state only. */
+	WARN_ON_ONCE(vstate != env->cur_state);
+
 	if (irq_save) {
 		if (!is_irq_flag_reg_valid_uninit(env, reg)) {
 			verbose(env, "expected uninitialized irq flag as arg#%d\n", regno - 1);
@@ -11993,7 +12074,7 @@ static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 		if (err)
 			return err;
 
-		err = mark_stack_slot_irq_flag(env, meta, reg, env->insn_idx);
+		err = mark_stack_slot_irq_flag(env, meta, reg, env->insn_idx, kfunc_class);
 		if (err)
 			return err;
 	} else {
@@ -12007,7 +12088,7 @@ static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 		if (err)
 			return err;
 
-		err = unmark_stack_slot_irq_flag(env, reg);
+		err = unmark_stack_slot_irq_flag(env, reg, kfunc_class);
 		if (err)
 			return err;
 	}
@@ -12134,7 +12215,8 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 
 	if (!env->cur_state->active_locks)
 		return -EINVAL;
-	s = find_lock_state(env->cur_state, REF_TYPE_LOCK, id, ptr);
+	s = find_lock_state(env->cur_state, REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
+			    id, ptr);
 	if (!s) {
 		verbose(env, "held lock and object are not in the same allocation\n");
 		return -EINVAL;
@@ -12170,9 +12252,18 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
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
@@ -12431,8 +12522,9 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 	}
 }
 
-static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
-			    int insn_idx)
+static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
+			    struct bpf_kfunc_call_arg_meta *meta,
+			    int insn_idx, int arg_flags)
 {
 	const char *func_name = meta->func_name, *ref_tname;
 	const struct btf *btf = meta->btf;
@@ -12453,7 +12545,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	 * verifier sees.
 	 */
 	for (i = 0; i < nargs; i++) {
-		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[i + 1];
+		struct bpf_reg_state *regs = vstate->frame[vstate->curframe]->regs, *reg = &regs[i + 1];
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		u32 regno = i + 1, ref_id, type_size;
@@ -12604,6 +12696,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
+		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -12898,11 +12991,33 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d doesn't point to an irq flag on stack\n", i);
 				return -EINVAL;
 			}
-			ret = process_irq_flag(env, regno, meta);
+			ret = process_irq_flag(env, vstate, regno, meta, arg_flags);
+			if (ret < 0)
+				return ret;
+			break;
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
+			ret = process_spin_lock(env, vstate, regno, flags | arg_flags);
 			if (ret < 0)
 				return ret;
 			break;
 		}
+		}
 	}
 
 	if (is_kfunc_release(meta) && !meta->release_regno) {
@@ -12958,12 +13073,11 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
 
-static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			    int *insn_idx_p)
+static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_verifier_state *vstate,
+			    struct bpf_insn *insn, int *insn_idx_p, int flags)
 {
 	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
 	u32 i, nargs, ptr_type_id, release_ref_obj_id;
-	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
 	struct bpf_kfunc_call_arg_meta meta;
@@ -12971,8 +13085,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	const struct btf_type *ret_t;
+	struct bpf_reg_state *regs;
 	struct btf *desc_btf;
 
+	regs = vstate->frame[vstate->curframe]->regs;
+
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
 		return 0;
@@ -12999,7 +13116,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	/* Check the arguments */
-	err = check_kfunc_args(env, &meta, insn_idx);
+	err = check_kfunc_args(env, vstate, &meta, insn_idx, flags);
 	if (err < 0)
 		return err;
 
@@ -13157,6 +13274,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (btf_type_is_scalar(t)) {
 		mark_reg_unknown(env, regs, BPF_REG_0);
+		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
+		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
+			if (flags & PROCESS_LOCK_FAIL)
+				__mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_ERRNO, -1);
+			else
+				__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+		}
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
@@ -18040,7 +18164,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		case STACK_IRQ_FLAG:
 			old_reg = &old->stack[spi].spilled_ptr;
 			cur_reg = &cur->stack[spi].spilled_ptr;
-			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap))
+			if (!check_ids(old_reg->ref_obj_id, cur_reg->ref_obj_id, idmap) ||
+			    old_reg->irq.kfunc_class != cur_reg->irq.kfunc_class)
 				return false;
 			break;
 		case STACK_MISC:
@@ -18084,6 +18209,8 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
+		case REF_TYPE_RES_LOCK:
+		case REF_TYPE_RES_LOCK_IRQ:
 			if (old->refs[i].ptr != cur->refs[i].ptr)
 				return false;
 			break;
@@ -19074,7 +19201,19 @@ static int do_check(struct bpf_verifier_env *env)
 				if (insn->src_reg == BPF_PSEUDO_CALL) {
 					err = check_func_call(env, insn, &env->insn_idx);
 				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-					err = check_kfunc_call(env, insn, &env->insn_idx);
+					if (!insn->off &&
+					    (insn->imm == special_kfunc_list[KF_bpf_res_spin_lock] ||
+					     insn->imm == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
+						struct bpf_verifier_state *branch;
+
+						branch = push_stack(env, env->insn_idx + 1, env->prev_insn_idx, false);
+						if (!branch) {
+							verbose(env, "failed to push state for failed lock acquisition\n");
+							return -ENOMEM;
+						}
+						err = check_kfunc_call(env, branch, insn, &env->insn_idx, PROCESS_LOCK_FAIL);
+					}
+					err = err ?: check_kfunc_call(env, env->cur_state, insn, &env->insn_idx, 0);
 					if (!err && is_bpf_throw_kfunc(insn)) {
 						exception_exit = true;
 						goto process_bpf_exit_full;
@@ -19417,7 +19556,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
-	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
+	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
-- 
2.43.5


