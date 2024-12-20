Return-Path: <bpf+bounces-47477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C49F9ADA
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A618848BC
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C632288CF;
	Fri, 20 Dec 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ9EllfB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A58227B8B;
	Fri, 20 Dec 2024 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724599; cv=none; b=c6WCmTqguhjh2o+TtBVtcpb7Y1VxiHkBD3MXnFsZojj2gg0uXBuVFT75ABlMp5BsayyIQCz1hyguBVI1M/eV/aPFvSEh6mVtDaGzn+v66BAPpag4NDZUWOvF6K4bKDkH32uhxnRtMlur2hCtLeUbrCPfPp8l7LlTOo0JBxzwWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724599; c=relaxed/simple;
	bh=84pJMQgiagIW1z54qE51DOsuDzjf1/1ePpxf0Iks4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzye7stJgEd/m6SYkgBkb9qNBUvmqGPa+0FRgfUnVAldWD/ZSOwQI9DT7DQ4E3VfmjcrFEqk8StZnQAE0vRZczlRsR1LyuKrMSetyTq1CKTkqf71sX8LEP1IKq6AZOh/i7k9iiom1lYukRsmEPCmJraO5K1t4p5oUxAcunmMsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ9EllfB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so2060622b3a.3;
        Fri, 20 Dec 2024 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724596; x=1735329396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQleOtsoMTigSQpuxD19q3FCZQss7kN8SAwfnWhREag=;
        b=QQ9EllfBzdLqag/PeMM3Q2AmWK5WG9Me2EYg8xbAAC7FsWx0if6bWkq5ZfA4378Ssv
         uGFWe4UiGiHDMVDeamSMZG/GV92BdWI6leYGhoerI1aofuV/AGoXhnvwiPDd2fhGSb9R
         L5Etn/Pn95WOlcZZ0EOtkb/mmlQt8u+ruoPzFZGFXIlV4IHl1MDJJTm6NT5mrWAsZv4x
         9BrKWjUpg5RdOQkTVtyDsE6YYbQQTf9O6+TGdmc57+NcacDUtaoAkNPl3SbS3uK6bw4b
         /psUP67MG5xjP5PXg5ML0o7TiV1IsE01+9zFHSnonMO6Z58inpXFx/eiY3qviBrVCjgx
         sssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724596; x=1735329396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQleOtsoMTigSQpuxD19q3FCZQss7kN8SAwfnWhREag=;
        b=DuY/iegFgKpXT0SIZNUCcVH4Kq9cptcU+KJpm9J/zR6PJTrj/b8cPE/DDmBq4plbsl
         KnmxBNUEEqXdleSj5fQFRU5WU2/uVc1q8xSeQe688cUkuAa8ywdXQ/03i6Mx3HA/Qw7B
         Wih2BF5LcKAuGjrNjHsdqwGbFy+STfQli0zc06dwb/B7jZIP7JrAOHKnUaiVE8VcApAm
         po/SlnPxiEykewdbd4p2B8GsKvoIOoezOhYjF/i8Tl7jTdNqHws1O49nzxlHk7BL7rGW
         vrJbY90lV0Oo9NZenJMK8HSLX6HhzmXK8is3zajUd2Jk21+wOxg+/smx51xsngnzy6xF
         IQVQ==
X-Gm-Message-State: AOJu0YxVu0JNyFFeAsuyWO5V5ZTRxZ1UgtnwO/cMO/asL9EgpmyZLlNS
	Eo+R8yqqhSTjNfF2c5DXgok8l/Peb8IPXPqm1Jcd1hkXC2jYtELeu27jdA==
X-Gm-Gg: ASbGncuqFBwzE/++fJE9HwQQ34DvVI3u1stegBJ/rYcyPFSIPm7LCUWEeFyr1T9Njon
	sn5Jr6sCRREiCegoYl5HGU8Cz4DBu+dSpkTr85lJPZi48UeuLnwta2UImFIbN0phDUmpRkCpsAN
	HZJUC2qK8N+N8BurMEWj2quvTF0u3hn6Gkpf62x/oXit8UKAQvSCUaZTE79psgkSb3jCHbbL9/5
	POPyVyY7Ue7yPbJSXUxqd87rYfMeGTEfC87Q10eKChvxwNbhOE9OstjIZ4M2v2t+J0QfWq1mOw8
	43rRefl+1fbjgBq0miaytdDJLcakCsq+
X-Google-Smtp-Source: AGHT+IGKP+4ByVkH/VVGeF/pDsTx1qdhcrUWh7ix99KzyYukzDiBSSFXM+k4s62OwtcNmahc+80NWg==
X-Received: by 2002:a05:6a21:2d05:b0:1e1:ae68:d8f5 with SMTP id adf61e73a8af0-1e5e04958edmr6739364637.26.1734724596427;
        Fri, 20 Dec 2024 11:56:36 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:36 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 08/14] bpf: net_sched: Add a qdisc watchdog timer
Date: Fri, 20 Dec 2024 11:55:34 -0800
Message-ID: <20241220195619.2022866-9-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
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
index 0477254bc2d3..3bc9b741a120 100644
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
index 1c92bfcc3847..bbe7aded6f24 100644
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
@@ -108,6 +112,46 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
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
+	if (strcmp(prog->aux->attach_func_name, "init"))
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
+	if (strcmp(prog->aux->attach_func_name, "reset") &&
+	    strcmp(prog->aux->attach_func_name, "destroy"))
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
@@ -136,6 +180,36 @@ __bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
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
@@ -143,6 +217,9 @@ BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
@@ -152,8 +229,13 @@ BTF_SET_END(qdisc_common_kfunc_set)
 
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
@@ -170,6 +252,9 @@ static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (!strcmp(prog->aux->attach_func_name, "enqueue")) {
 		if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
 		       return 0;
+	} else if (!strcmp(prog->aux->attach_func_name, "dequeue")) {
+		if (btf_id_set_contains(&qdisc_dequeue_kfunc_set, kfunc_id))
+		       return 0;
 	}
 
 	return btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id) ? 0 : -EACCES;
@@ -185,6 +270,8 @@ static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_qdisc_get_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
 	.btf_struct_access	= bpf_qdisc_btf_struct_access,
+	.gen_prologue		= bpf_qdisc_gen_prologue,
+	.gen_epilogue		= bpf_qdisc_gen_epilogue,
 };
 
 static int bpf_qdisc_init_member(const struct btf_type *t,
@@ -200,6 +287,11 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
 
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
2.47.0


