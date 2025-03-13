Return-Path: <bpf+bounces-53988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC479A60062
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF45D880D3D
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81C1F2BAD;
	Thu, 13 Mar 2025 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFrDNE9o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BC1F30CC;
	Thu, 13 Mar 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892606; cv=none; b=siS62E/JKyRINBk9lEqGOhOKh5VaKOFv9ndm+w6aXjUrA77E0H5z8GfVE6jXW6v2rGzv4kBSphJyWKpwv+euy3wjltnzojKHBGEjCti/tdJpqngFo2RCVuMGNLoO9nKIhSGPd5e3dE2xVstv7u97AiUfDkbQrb6xhgOzKRd/14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892606; c=relaxed/simple;
	bh=FPWorS7Tpe+rlq5Kgn0H3infC/85vxSx4GnppcecyGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGVC6bnNnm49+PrvGLMVPBgjp1ZWclobTqeFHpT80xMmbEbHYNIn7ggC4MMUj9KDyfdC4mm2XPCefwM/EAah1QSRipJcMZc/R3H+zK7PINQ24kYCam7v4XyTETh+RZe1d9eorov2VOOOY3ZycO6E61vh67FKUtqKnPit20qex18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFrDNE9o; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22398e09e39so29038325ad.3;
        Thu, 13 Mar 2025 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892604; x=1742497404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTVqWaxfYmIPAROSK14+DooDc9QJZRU2IS03bSh04Dg=;
        b=bFrDNE9o9+KrIMVEqFZOQsJ/m4PLbPgoQOUAk81Hwb9UTzjLuJJGNMhhwgxYvl3Z1i
         H1IgEj9tWxR6mQRPtPnyRrtRBsyzq6YrfU7JEN8aHmit2FnNrgz5vh8SuuM//HMusavP
         Sr/TgQnQvtIk/kGegJ/L+3ioEIQZHvUQhqbQ4E3Ulo/UJmZeFhZcE5VTaXO342KZN6je
         4/E2xL35F+kM4x9eJDz5D6XNUh5uuUGZEceHcFcPik/m9nd/CRimVajwsjCFwvRU1mr4
         MoS+JRHHBtNNhADvFuzeh6zSoK+SKmPpufQN3JXa+oLg5/0RcKeJjF0YTlBkDry3Kiju
         Q9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892604; x=1742497404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTVqWaxfYmIPAROSK14+DooDc9QJZRU2IS03bSh04Dg=;
        b=cKGPpluPAz2o67EkbGkRrn330qDUulHg2GoznJywNL3UwRUjTCii+Nbi2XUef4bXIy
         vunCdhyz0lllPDqeQ9Hh3GuxaOByuzQW6qberc9Ez2h6Veq0OMs74A2XEGje7Xe5OMit
         dtUl53SerXQ1RKL4rUjBbd/ePZSJ/sYXjyEWNwA2BNk/cZCZb7pB5m5b1AqcZ266KbzM
         h9A2ErZ4DVV5/pZCarpQOIZf1Zg+UCImNk1qLxF9itY0gfVvYOwNetmmJN9GWSjc2MlP
         GlwZZ5pJCwPoZVRnkt6pZI/+eYNCL7P99byjo741aY63DtSD7Z9BpGHXQgypMsXDYAcb
         Mc6A==
X-Gm-Message-State: AOJu0YyHMLdKB/WkZkjMfeaN0OK/ndzTJFmygipFZ6wOgIpWjoKzHOOb
	XujRk5XussiRI35qhipRdR0pZAisiTjyx1R52WBS5gZonunGV272Pu9OlPV/vMJH5Q==
X-Gm-Gg: ASbGnctAUZnwvaGotC2HebQytF+ShSdhUD+H1saypB7LjX+6hgNq1o1Ax/rgkAA0/uU
	61nb+3T7U6C7emy56jPvzIjkpsmYVK49k+hkK9UB+XzoTszsqDS1RSgL8IQ0rTLmgnqLOMoAvBS
	h5NP0BxWQPxWzdoixW3nKtuC50NJ9XKd+oVMxT8ZA5EawTkC53eVaf/bgHFKHG9hmEKQeJJvj8x
	CAXt42cnHCOg986DtUXiFtt+NCthY7CG6ixRSUCukQvykN/PUayYHQl/Qoa3Xtv3H8FDic6sIf3
	xPctvK0RleAe4rtx2IOLZXDRUvTwZAUNGPCzN/NPnwPGm3KjslfBzdgkkmT04rJYXt1jTTMW5yL
	Y7FsRZDrnU6sFCXeiVKI=
X-Google-Smtp-Source: AGHT+IFoo06WkEZkehbe7StgtsbUpGMyjZ66qV0a20AMAWVukO8e2ilYxrUeJCSXJYVsBv/2B6+ZkA==
X-Received: by 2002:a05:6a21:a43:b0:1f5:8072:d7f3 with SMTP id adf61e73a8af0-1f5bd95271bmr1376646637.30.1741892603769;
        Thu, 13 Mar 2025 12:03:23 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:23 -0700 (PDT)
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
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 05/13] bpf: net_sched: Add a qdisc watchdog timer
Date: Thu, 13 Mar 2025 12:02:59 -0700
Message-ID: <20250313190309.2545711-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
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
 net/sched/bpf_qdisc.c | 92 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

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


