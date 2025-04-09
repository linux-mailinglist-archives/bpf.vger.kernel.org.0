Return-Path: <bpf+bounces-55591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E9A833A1
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD2A189197E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332921B8F5;
	Wed,  9 Apr 2025 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhxPZfYq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68F215770;
	Wed,  9 Apr 2025 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235175; cv=none; b=VvUxKsxDso/0fXquWqbskEpWCygf5lnGMSdHH2TqYDxfdrT2uLgTcp3qyiigkesLPg/KgDdBiDqnmvIld+LEn14l5KinWGfAaeWHzImPuCEF0aoD7O2qBXItDJ7/H9njh9ZP1ig//7PD6wDwbJygge9B5KTrK8aekQBlHURg7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235175; c=relaxed/simple;
	bh=uap6ui5lIiEAhHFejCXpS20PeCAU94lncSy4ptxcXlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWwSvOJKBbIer7WW8O8ew0YRXG4HM2XJCwo8btcBq4ewZ1aMrc3dthNGwarMPgbV1X/NCHuNmd31hxgcFTdDtPsedlsSTTcvD3DwQERyWNXphJKsIH+NHn8TMSC7SbrpMArIrTxYJzmSlb43ddAEwoVft4WVkkTaNPd+3wRymV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhxPZfYq; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af9a6b3da82so133066a12.0;
        Wed, 09 Apr 2025 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235173; x=1744839973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cs84tRrnFA4DuDv2H6jTSlOH1U7N2PREqr2phBkCU8=;
        b=LhxPZfYq0AlF7wzuBa0v54XZjeMpQMAXGpUHu5x9jj+fYN7wJ+Nay6xu2eowPzbvwX
         N3uSTM5ErudCc+1sH79Vg7vSL96Ear74RaKC1b1tXGPwx/TnHqN2o44LTtkbfjToBy1V
         Q6FvxdN75+xdNoJTRTpwCoYnqkzVAs5KguNlRl+AEr9JuPhlGsA5NPjHcAlCD2v9jAHd
         hMtp/yKPiQZvYPVJcLmC5d3tYubnZX8bLJ/FTEU8H+zHhpbnlSUZfFtpd1tv0ss+dRYk
         UY/w7FuYTkbBdB6AxehpFaBh4F9ovzAI+RgVXaTzNA7D3g3snbvymOD22EhJImA2r1tA
         nScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235173; x=1744839973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cs84tRrnFA4DuDv2H6jTSlOH1U7N2PREqr2phBkCU8=;
        b=C9QIH5W4em6SkbDUwVPvKzi21SRHJv50tQwWcs7ddUeKqVvPvYYoS3mUNW3bT3ZE4M
         67Nm/Mu5bZTFq3UBpNmIu2VrNYJb/+0qw9gVZ4/ZHQxfw9YYF3gVQa95kxAGMWHKCn7n
         /vFhQy2h1WfsN2HbiEZDgAUdFk3nyKRoOj19LNTs3+1iaO5+OacoNRgfOsOvfqSigeUI
         gFkUntRHEUzndI+jas5lUXZuwO9FR0RxnaN4YYYP7B7dD4R/q+ev3NiZGoPoJIiHRFxk
         Xp+NScviugXx15kDGfPqBA82gmMAdHTSXOd3cCQonUdmUANXLmywjYuRduWPjsUmgNSR
         wLDQ==
X-Gm-Message-State: AOJu0YyL2K2BWhO3x/su7FjUeM/W/BDdM6dUh/F0t8S9hxmDAw3Jedei
	4PQyjWvwMXDd3uTcnnfYg2wHqWX40uL7Z4izYaRsbJYMyybQg/BRvJznVhS6
X-Gm-Gg: ASbGncsj4yqE0qrPtrIN6ASpUKf9hiSn07zd69Ar4ZkyAl/B2FciV2M7+r5Mpl9WyAr
	s08EgBLdJJ3VlAy+ABxd9hrMDy8yuJPvmUChWm/qcR415t+J4a/jHBsBPsa7OEIONO/gsnfgRCY
	1hr/QYt4V1P2bcEc5+XpVzFbloIB4LIvhiQxLumTYtR3iyga0MPdw6y78mu/K15pooKZsI1c/zX
	XWjmHws2b0tnWhxlRk1u/bJQIgMg6/WLr29ZRjYaqiU7rPtoOMgwJ8xSyNX+zV3DxVGJkX1LGzF
	A4o1ewAvhQKCY2NiVSbuRBOUT2qZazc+LBrylDw=
X-Google-Smtp-Source: AGHT+IGTCdaJXN2t7bxGqHedWnyNTQALh1PRKPiLpxow6JubQi/2EcrvJoKISRcCTQnx/cA7gSok4w==
X-Received: by 2002:a05:6a21:730a:b0:1f5:59e5:8ad2 with SMTP id adf61e73a8af0-201694dec7bmr1062982637.24.1744235172843;
        Wed, 09 Apr 2025 14:46:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf38dasm1497117a12.23.2025.04.09.14.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:12 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 04/10] bpf: net_sched: Add a qdisc watchdog timer
Date: Wed,  9 Apr 2025 14:46:00 -0700
Message-ID: <20250409214606.2000194-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add a watchdog timer to bpf qdisc. The watchdog can be used to schedule
the execution of qdisc through kfunc, bpf_qdisc_schedule(). It can be
useful for building traffic shaping scheduling algorithm, where the time
the next packet will be dequeued is known.

The implementation relies on struct_ops gen_prologue/epilogue to patch bpf
programs provided by users. Operator specific prologue/epilogue kfuncs
are introduced instead of watchdog kfuncs so that it is easier to extend
prologue/epilogue in the future (writing C vs BPF bytecode).

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/bpf_qdisc.c | 106 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index d812a72ca032..5f4ab4877535 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -13,6 +13,10 @@
 
 static struct bpf_struct_ops bpf_Qdisc_ops;
 
+struct bpf_sched_data {
+	struct qdisc_watchdog watchdog;
+};
+
 struct bpf_sk_buff_ptr {
 	struct sk_buff *skb;
 };
@@ -142,6 +146,56 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
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
+	if (prog->aux->attach_st_ops_member_off != offsetof(struct Qdisc_ops, init))
+		return 0;
+
+	/* r6 = r1; // r6 will be "u64 *ctx". r1 is "u64 *ctx".
+	 * r1 = r1[0]; // r1 will be "struct Qdisc *sch"
+	 * r0 = bpf_qdisc_init_prologue(r1);
+	 * r1 = r6; // r1 will be "u64 *ctx".
+	 */
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
+	if (prog->aux->attach_st_ops_member_off != offsetof(struct Qdisc_ops, reset) &&
+	    prog->aux->attach_st_ops_member_off != offsetof(struct Qdisc_ops, destroy))
+		return 0;
+
+	/* r1 = stack[ctx_stack_off]; // r1 will be "u64 *ctx"
+	 * r1 = r1[0]; // r1 will be "struct Qdisc *sch"
+	 * r0 = bpf_qdisc_reset_destroy_epilogue(r1);
+	 * BPF_EXIT;
+	 */
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
@@ -170,6 +224,36 @@ __bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
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
@@ -177,6 +261,9 @@ BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
@@ -187,16 +274,22 @@ BTF_SET_END(qdisc_common_kfunc_set)
 
 BTF_SET_START(qdisc_enqueue_kfunc_set)
 BTF_ID(func, bpf_qdisc_skb_drop)
+BTF_ID(func, bpf_qdisc_watchdog_schedule)
 BTF_SET_END(qdisc_enqueue_kfunc_set)
 
+BTF_SET_START(qdisc_dequeue_kfunc_set)
+BTF_ID(func, bpf_qdisc_watchdog_schedule)
+BTF_SET_END(qdisc_dequeue_kfunc_set)
+
 enum qdisc_ops_kf_flags {
 	QDISC_OPS_KF_COMMON		= 0,
 	QDISC_OPS_KF_ENQUEUE		= 1 << 0,
+	QDISC_OPS_KF_DEQUEUE		= 1 << 1,
 };
 
 static const u32 qdisc_ops_context_flags[] = {
 	[QDISC_OP_IDX(enqueue)]		= QDISC_OPS_KF_ENQUEUE,
-	[QDISC_OP_IDX(dequeue)]		= QDISC_OPS_KF_COMMON,
+	[QDISC_OP_IDX(dequeue)]		= QDISC_OPS_KF_DEQUEUE,
 	[QDISC_OP_IDX(init)]		= QDISC_OPS_KF_COMMON,
 	[QDISC_OP_IDX(reset)]		= QDISC_OPS_KF_COMMON,
 	[QDISC_OP_IDX(destroy)]		= QDISC_OPS_KF_COMMON,
@@ -219,6 +312,10 @@ static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	    btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
 		return 0;
 
+	if ((flags & QDISC_OPS_KF_DEQUEUE) &&
+	    btf_id_set_contains(&qdisc_dequeue_kfunc_set, kfunc_id))
+		return 0;
+
 	if (btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id))
 		return 0;
 
@@ -235,6 +332,8 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_base_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
 	.btf_struct_access	= bpf_qdisc_btf_struct_access,
+	.gen_prologue		= bpf_qdisc_gen_prologue,
+	.gen_epilogue		= bpf_qdisc_gen_epilogue,
 };
 
 static int bpf_qdisc_init_member(const struct btf_type *t,
@@ -250,6 +349,11 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
 
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


