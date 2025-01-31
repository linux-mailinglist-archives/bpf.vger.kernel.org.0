Return-Path: <bpf+bounces-50232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F184A24354
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457F3188ABDC
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635191F4721;
	Fri, 31 Jan 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzpryLj0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361801F4261;
	Fri, 31 Jan 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351776; cv=none; b=SzxzYFkTHa/FSOU6cV6Fo+1BUvxXOEnfJ7RSiOcN7N40S4HIC5Y6VPBLefrfwAi6HjMU8SF7C8BqBXIl0tcJ8jFZ2eF0JjoqFAhjgHOMQRKbE8zyR70Y5vrC1u1+KdwAk91SkPkV9NPtkVu8cUUOKVfvt5baF0V5ZSsoRRA6EKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351776; c=relaxed/simple;
	bh=oX7sfD2SSGnrQzUVIz968zYmlPPJL7x9U30Q9X0yB68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ft3yR7VQg2dfgN6h00YD8XKfGqjTVa7Zafs8P4C4JBD5W1qiQL7Com7U1qrheZf4VRojFw1LzS23N2CEcw2JYp0mjRNZR08t8Ns2aKmBW+axVy4jtbIc3JhPKCqJzc5/xW6v4jIKWlKyP/gz1oClkAqZEZ4w8mJJ/PCFcL7EA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzpryLj0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso3241360a91.2;
        Fri, 31 Jan 2025 11:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351774; x=1738956574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX3XRBZ19QDBVzJDe9UanSrzS5pPfBfZXfSGAVpWKCU=;
        b=UzpryLj0yhA62qfGT/9S5U/cb4mQNHoBuhjtiKRCr6NMAUvVuX9ScR/p7+WkgPIrDS
         OJONlGeCn/6ndUj0OgLeoT6ueH6NrQL92PFvnbhbIitDFVnaJEeI8L3rMkoj8j6/VoRm
         BKXvD++Bpfj2z3mybZksn5ND+OKpkI+Qdm/r6ToFyvm253+rWKumEPlSTXXQDbxgcgfB
         0InthWbLsCe+XOTH7JC+LS0c+dOeGnQhZ4nBuH1tdWeZ9/3O2cPt+vUlwqzhFhfuLvoI
         nubpY2q+jXqRWKhyGwnYqoZLi/c7aDpbyVBJWgWaEh9VDavq1wkhBx6Oskd1ZC15EfOU
         Hsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351774; x=1738956574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IX3XRBZ19QDBVzJDe9UanSrzS5pPfBfZXfSGAVpWKCU=;
        b=B1qetl2m3NF2jEUrO9Sw9TDsRqn5YOcMu3gkEs/kH5BUqePikVCEnMrIreQuH05l+i
         NLHFhrskIloulv3eMBLElJa7jg/7mYfwNwjje01ZA1b21Ou072tr+OQhsEHj8Dtgyc6w
         b8suz9gFIX1QztQUhA3ew5UEJ8eRnQda7gHjkHT2mMjq6q4XASUC34h/ae2pMHGcJ7Rb
         qlbL/wkKIpYeXb/ingdn7cUPIt9ysRF0HyigPHEA38c6SdFin2quJi3TN6xhDC9Ne7vV
         cJdGjiOyOh0gfDVOsSIWSYysdIRYbe8m97pqU1ZkOGy9mh4sRcclJiE/tesgQGF7OhVo
         ZyAw==
X-Gm-Message-State: AOJu0YywfBkZgHfJsyMm05755Rb07P8Awrc75LF+5r3Q970MAJUFBkWP
	SvM5SQOn11yFzrkMM2Tet7yZSfW5XpMudwomNTzC8DfPuYZwJVvVSODq9xda5DA=
X-Gm-Gg: ASbGncs6CvY+xn5zu/0bmCMvydKY6+zFDf3dUgmUBx9O569TLucqAsXRl0BQ97624P3
	ejz6Ifq11nWI/mIRpPtT64DLZqdCnEOGQNd/OYu6gBwCSTKH3yZ42Zpy2SiuYrJfwqUbEPUxqC4
	5IWQe8Ob9/1rqXkHddtmCDBYhHdSZP8WxGPxwPb53IijWv+G5IhDQn5Ot/sFC1qmVw667+7jtmW
	hcpfJzS2XbYMMC1iVXCle9BXS2vDwYNNhUB1yw9S7u0ym9DJg31H6Z4ct9qJMPaVbuyCH2JzJpQ
	aSYWao0artn+PEx8mnGp0lXmZZQGPb+ckEKTxaIPoCre98k003kMutrsQmI18MXTYQ==
X-Google-Smtp-Source: AGHT+IGHZvE5vtd8WKJND6Fdhu7IcyuwAHzmiULORvD049e6llceB4o5ZiiClGRmN9pYttPQQJ6z1g==
X-Received: by 2002:a17:90b:1f8b:b0:2f5:63a:449c with SMTP id 98e67ed59e1d1-2f83ac5e4bbmr17557552a91.28.1738351774377;
        Fri, 31 Jan 2025 11:29:34 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:34 -0800 (PST)
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
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 11/18] bpf: net_sched: Add a qdisc watchdog timer
Date: Fri, 31 Jan 2025 11:28:50 -0800
Message-ID: <20250131192912.133796-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
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
index e188616c86a4..5abf11aa8340 100644
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
+		       return 0;
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


