Return-Path: <bpf+bounces-54408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A39A69B99
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AF219C2865
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4E21D3F5;
	Wed, 19 Mar 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIA+5c9s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6B21CC5F;
	Wed, 19 Mar 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421256; cv=none; b=BJMkqY44i/WnCRtHlv+z8H5AI+iX5QX9/GpCRU/gIW+MBZbUZEAF6IjIMb02CM2xY6lOLWeldsgdQe7A6yOlJiC0K6e07+ETY7VNGjmDcecQHfF6DKe0ddb2mrLM63DakadbJjQVmoti/wzrxE1uABMVJ0faWCh9Q+PEmgP/O0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421256; c=relaxed/simple;
	bh=uap6ui5lIiEAhHFejCXpS20PeCAU94lncSy4ptxcXlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEp67oYqznRygiT2u2p04cHh04VtCRuSxQkVaL/y77qF4oU0qCcFP1NNqtV8KX5nic8arBdt4ZY5QAFBEhFiar3T24fOs4Bt4EDs6p3bhutihUBIW91PA6wOpXSBcSzHBwKi3785IxKSa9jSI45rI4XGjwtqVwB5IrOCiBfPPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIA+5c9s; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso977915ad.2;
        Wed, 19 Mar 2025 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421254; x=1743026054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Cs84tRrnFA4DuDv2H6jTSlOH1U7N2PREqr2phBkCU8=;
        b=HIA+5c9sT0idYL2w4L5a8+egG2FB5gKM21zN3XCmSWsHljpoJO6a/LT15lDvairKJ7
         dtZwag3SfQy74aKlgCriCqJQgtofd1qB565Y18sCWrBkp/b1sQJP5o1EP+l2NmA5F6Zu
         7ZbbJ5Ouygtu/9+1ekDxcBUnTrTnnakQZ5Hal7rtk4+DcGwBzZGvpRb5ooJmingL/axv
         JoRMkQ9Htzk6ttVIrFyR5JRdPXiCMzwYG5Ik2zxOyMN1StudQ9tpa9/JWJ6AMitOxAvI
         Dq6u2WDbLKTXbZsqIRz5cnKQ2SWu0+kkZZk8WKv4Xg64JgRSOhmtP9E78AfsF36tw4UQ
         EjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421254; x=1743026054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cs84tRrnFA4DuDv2H6jTSlOH1U7N2PREqr2phBkCU8=;
        b=sRfPnWG26NTNY+t51oq2Sctn7HaZ0dK1SvY1Tu9LuLoLnKQpFobUUIVbEwrh0u7jZC
         tysRIf+qJCuCZ6loWsJmi+P4HPaX5IXeAS147x9NYqgZ05abRoZJ7M66qEeH/H9UQSHy
         XzsFrDhJdmMYkXwKinXNo8DFYRAuhTntrDE8iJLSGcdqQMSRx9SGWV5E8ZUTGynTVs9r
         kzLmeleeIG1HNah+MIOe/eSx0pEm/fNOsN/YaWXlQ2Onw1I1bOSAtNBREydU7oUy7w8E
         TlIVWJk59EHsdWJJz+ohOxn3KY5qxAHhDLCaq0pJVkn9/fDtU93ML8/NTOjSnYsiYGv1
         YnOA==
X-Gm-Message-State: AOJu0YzSrgvXxDiEny98M5Im+LtDvbr84B86U7W524rqVXeSTa/0el07
	Dzvr5GNrD2ZE0+NXhwrY1cUh2nomVtlTBTbgpOtJD+aO7f0IqsZy90kFBiE6ZRM=
X-Gm-Gg: ASbGnct/sCDJY69O+YMwaZWJLRgtTTXjgDwWa0hJV/ujWK9BrMHM45+mP1N2U87dzyF
	AfT52if+IL+aCHGgu7+iiC+lqvePK62IaeRB1cPudwiEZ8irjagHgoAzsnhtDVIkra54H4i6Jvz
	aY5LTPGWfFoJqVZhZde+w4+/cPOoRUGGD2o3Ac21g9SS+CaQkhd8o3O1dxuO/SocS9DLvKs2s4q
	2VmUFTsNYli4Yq6DC8hwp6T9FhyZSFmJsd4pvGmgd28389ntQjvELnnGru0DTMECMotQb20Ftqr
	9N5PK/D1T8eit2JicEfshIEhTyqzAQ7PO5fiyd974eNYP7k2eZe9W2IFmAcKMxOQoevuJPMwyzb
	2KlVbY1VHYUQ7VvuS7oqhF7QThSrbLA==
X-Google-Smtp-Source: AGHT+IHMF+9QrmGX/WVdzbFt8rdZXbTPFmQvGvLY/onszOBhaTKFQiHn1EiIpY5Vi2G7pRudsWL4fw==
X-Received: by 2002:a05:6a00:3cd2:b0:736:a973:748 with SMTP id d2e1a72fcca58-7376d6ff4d6mr6212323b3a.22.1742421254232;
        Wed, 19 Mar 2025 14:54:14 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:13 -0700 (PDT)
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
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 05/11] bpf: net_sched: Add a qdisc watchdog timer
Date: Wed, 19 Mar 2025 14:53:52 -0700
Message-ID: <20250319215358.2287371-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
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


