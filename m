Return-Path: <bpf+bounces-51018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC24A2F594
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50014168F6B
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5A259483;
	Mon, 10 Feb 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhlqqTUe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D22586DC;
	Mon, 10 Feb 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209442; cv=none; b=ntbpxnX2Ig+bgetdjapdoosB8p80BjXwXVvC0xM3Vr5jaMd1erAZuxrW/ZlOCLZhXeQ10CTOPAWHzGGZNldWWQ9tq++0e+/UUgk5jz3DGr72L1B4iHxTyNiEkBClz8viDLNwn25nG7pH+WXt4SyfkhaejOThJaHXsYFLhf/BGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209442; c=relaxed/simple;
	bh=Q8ePHSEjKZcDqGD7K2WW4ZeTYIIw7I437z5FVcysuA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuthaeBZAxBNENmGPEXdctPytqIlJ7VXpNTZm+VgWCRmTj15zITbOy+PR8JfJKBoER5cxOA1WYcj7DvYNM2GZ6maSmsuUkkPa1tY/hJ+lXZ2OUXI4y8m/UaWELQtzbVZ5VWuwAtXFaED7qa/D5AeQzx/w2rS0Yguh4zLHtgIfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhlqqTUe; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa2c1ab145so5808627a91.3;
        Mon, 10 Feb 2025 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209440; x=1739814240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgHDOpSEEIi90UDqwqeFyvDF2tZ+G1vUb9y1obneiyQ=;
        b=IhlqqTUes3nzhbm/vcCr6Z/mVIc4KjmjaMdUf7ha74EFuY7uUBs/1mBhHyYMVSEgJL
         wEGdhc+QiTyn6s89fhRQ3Bnxi3Cu5t+FA2+bWzS4qS3uBD0YNiIYgnQH599psmezpwHx
         Z9/GSkjPYz16n0IJnU8A8ybgRgXUQJzCchCGwFR3VSd9CNpGkrgyuiymUKg3Qvud7/Rn
         OyGYlZwEcvWCGIdercSeULeNKaMY1qafOc0ROwJ3HPf+8W4Ie62Zd+CHvTmAe96+L2I6
         R8CNqoKQqbbzSqyLG6cb2OTA6rwDa2rufEwxcFlxdNjwnvmSbVDY64LUT7mBC/TKjc5H
         FpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209440; x=1739814240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgHDOpSEEIi90UDqwqeFyvDF2tZ+G1vUb9y1obneiyQ=;
        b=uDutkeaZnOm2enJMqd2SRK/LTtG03nJpljsxrDf6u3oBotsCXZZI9K+L6Lt6MhsfPJ
         tugz1vG+ZGROUTVocEiOYtiNMyVBV+vVbe0ag1JRZ1NXxJe+x2IVVbCrcWwHUg+ZffJS
         5e5YMXeGTYxlYzgcMiMYqOz27VgA7hLwOJvqQuIxkOrK36Vcu2srzntKdx1Vi+WtfpaK
         U16wGxY7Cri5/K9Qu6aoPJghaoG4pJ58/2uQagxtCYGOZS5tuYN3abKDL66JaQlPo3yJ
         b0bM2Uc9wKbW2tE5QLI4Mht3dNkVcbuDopU9L6TPOF0UVj84SkUtvbpcuB6LXln/MGkX
         rcOg==
X-Gm-Message-State: AOJu0Yzi0KtGYf8cfarJXgGVGWOY2Um17yKDrpUPi4/Oox5mNsGDuxS3
	HwP/rN5mlitnegDeLCNj6ZxRgMVio+/iOLu7mQteVkR88Q5c7khdNAyHbDxJ
X-Gm-Gg: ASbGncvFTWW/18ANaDt7g2wm4ajp91/p4u9G8aaQcGsfXP3Rlo6R/gXs0KvM7/aMr4w
	W5Xp74dzwT2hPpG/4fgg1ngxS0Zs0qI/s0qAJE1MilaJVkdkVYh6a3m8oaYFxU6if+celyT85rr
	bAjv3PQSdXTRhHgaPsdqVbKvzNzMUy1s6n3/TLT8C1GiZ/weHjQjBzb1kwDCM88NX7a6CA0F/1R
	It0KAWcdP9FbgUi7syK+pCMAAXYc8dLAyoIwM5XJnT5+SHNWNAulLKS8CRz2xErJ2L/Jn+W+BZG
	1MQUAzySUp8B7iYONb1DlfFJGoQWPZGVTTBQxtb4KpqulKHc5FtkgkSU5Utq8O0LJw==
X-Google-Smtp-Source: AGHT+IEQqnxPXS1c74ypTB+MLo81V7cJ0DBoV77yo2/D7QFCDZhEctHwmyqUyPG9lTBkqz7W8MqV6A==
X-Received: by 2002:a17:90b:3d03:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2fa24069ec6mr27233219a91.12.1739209439842;
        Mon, 10 Feb 2025 09:43:59 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:59 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 11/19] bpf: net_sched: Add a qdisc watchdog timer
Date: Mon, 10 Feb 2025 09:43:25 -0800
Message-ID: <20250210174336.2024258-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add a watchdog timer to bpf qdisc. The watchdog can be used to schedule
the execution of qdisc through kfunc, bpf_qdisc_schedule(). It can be
useful for building traffic shaping scheduling algorithm, where the time
the next packet will be dequeued is known.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/filter.h | 10 +++++
 net/sched/bpf_qdisc.c  | 92 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a3ea46281595..3ed6eb9e7c73 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -469,6 +469,16 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 		.off   = 0,					\
 		.imm   = BPF_CALL_IMM(FUNC) })
 
+/* Kfunc call */
+
+#define BPF_CALL_KFUNC(OFF, IMM)				\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_CALL,			\
+		.dst_reg = 0,					\
+		.src_reg = BPF_PSEUDO_KFUNC_CALL,		\
+		.off   = OFF,					\
+		.imm   = IMM })
+
 /* Raw code statement block */
 
 #define BPF_RAW_INSN(CODE, DST, SRC, OFF, IMM)			\
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 69a1d547390c..ae06637f4bab 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -8,6 +8,10 @@
 
 static struct bpf_struct_ops bpf_Qdisc_ops;
 
+struct bpf_sched_data {
+	struct qdisc_watchdog watchdog;
+};
+
 struct bpf_sk_buff_ptr {
 	struct sk_buff *skb;
 };
@@ -111,6 +115,46 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
+BTF_ID(func, bpf_qdisc_init_prologue)
+
+static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
+				  const struct bpf_prog *prog)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	if (bpf_struct_ops_prog_moff(prog) != offsetof(struct Qdisc_ops, init))
+		return 0;
+
+	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
+	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
+	*insn++ = prog->insnsi[0];
+
+	return insn - insn_buf;
+}
+
+BTF_ID_LIST(bpf_qdisc_reset_destroy_epilogue_ids)
+BTF_ID(func, bpf_qdisc_reset_destroy_epilogue)
+
+static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
+				  s16 ctx_stack_off)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	if (bpf_struct_ops_prog_moff(prog) != offsetof(struct Qdisc_ops, reset) &&
+	    bpf_struct_ops_prog_moff(prog) != offsetof(struct Qdisc_ops, destroy))
+		return 0;
+
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_FP, ctx_stack_off);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_reset_destroy_epilogue_ids[0]);
+	*insn++ = BPF_EXIT_INSN();
+
+	return insn - insn_buf;
+}
+
 __bpf_kfunc_start_defs();
 
 /* bpf_skb_get_hash - Get the flow hash of an skb.
@@ -139,6 +183,36 @@ __bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
 	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
 }
 
+/* bpf_qdisc_watchdog_schedule - Schedule a qdisc to a later time using a timer.
+ * @sch: The qdisc to be scheduled.
+ * @expire: The expiry time of the timer.
+ * @delta_ns: The slack range of the timer.
+ */
+__bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_schedule_range_ns(&q->watchdog, expire, delta_ns);
+}
+
+/* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init. */
+__bpf_kfunc void bpf_qdisc_init_prologue(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+}
+
+/* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue of .reset
+ * and .destroy
+ */
+__bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(qdisc_kfunc_ids)
@@ -146,6 +220,9 @@ BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
@@ -156,8 +233,13 @@ BTF_SET_END(qdisc_common_kfunc_set)
 
 BTF_SET_START(qdisc_enqueue_kfunc_set)
 BTF_ID(func, bpf_qdisc_skb_drop)
+BTF_ID(func, bpf_qdisc_watchdog_schedule)
 BTF_SET_END(qdisc_enqueue_kfunc_set)
 
+BTF_SET_START(qdisc_dequeue_kfunc_set)
+BTF_ID(func, bpf_qdisc_watchdog_schedule)
+BTF_SET_END(qdisc_dequeue_kfunc_set)
+
 static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (bpf_Qdisc_ops.type != btf_type_by_id(prog->aux->attach_btf,
@@ -174,6 +256,9 @@ static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (bpf_struct_ops_prog_moff(prog) == offsetof(struct Qdisc_ops, enqueue)) {
 		if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
 			return 0;
+	} else if (bpf_struct_ops_prog_moff(prog) == offsetof(struct Qdisc_ops, dequeue)) {
+		if (btf_id_set_contains(&qdisc_dequeue_kfunc_set, kfunc_id))
+			return 0;
 	}
 
 	return btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id) ? 0 : -EACCES;
@@ -189,6 +274,8 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_qdisc_get_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
 	.btf_struct_access	= bpf_qdisc_btf_struct_access,
+	.gen_prologue		= bpf_qdisc_gen_prologue,
+	.gen_epilogue		= bpf_qdisc_gen_epilogue,
 };
 
 static int bpf_qdisc_init_member(const struct btf_type *t,
@@ -204,6 +291,11 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
 
 	moff = __btf_member_bit_offset(t, member) / 8;
 	switch (moff) {
+	case offsetof(struct Qdisc_ops, priv_size):
+		if (uqdisc_ops->priv_size)
+			return -EINVAL;
+		qdisc_ops->priv_size = sizeof(struct bpf_sched_data);
+		return 1;
 	case offsetof(struct Qdisc_ops, peek):
 		qdisc_ops->peek = qdisc_peek_dequeued;
 		return 0;
-- 
2.47.1


