Return-Path: <bpf+bounces-47474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80A9F9ACE
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534FE1898073
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FBE227B92;
	Fri, 20 Dec 2024 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfgX/pNc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65379226888;
	Fri, 20 Dec 2024 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724597; cv=none; b=QbfEbpzNsKG+vOFGtyMX+WCyBEwV9iJmbDXq9REa8gkI6W8cWRpxPJEBbPEAurVpXNZ32dynn7siobIj8vRe6RqyBCx/hKm8BJj11bCit+9PdEUtqGGdkC1G2Dqik+N1dVU0+f3+go6NYAjvp9oPq+W80IHv0yNnVTez/qY3ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724597; c=relaxed/simple;
	bh=oTrWwuAlVXAkJcNs71LYPamD2VKPjLQ4QAnfcLW8TC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqCocIlDDDUHQpPHaYw8yPcWJlaFQiPNA3s/fAiD330dq07CC5vAYB1bLQcXba/4xBMQQIHNxocxhI3lv02kwzBbA/scqy0eIROqrSONdE6ow2gVBSw+85UShLDYilr/wxQBrPZcUYnLaAQgM3JF6BEfW3aSxC5CBxmP8gyo/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfgX/pNc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7273967f2f0so2873288b3a.1;
        Fri, 20 Dec 2024 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724594; x=1735329394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSuCNtOVV+R11g8QPC6TJRQ60HKfpVL/OeZ5X11d4SE=;
        b=QfgX/pNcKqbvsdqvBHoQjglToDtSaG1/QhBL5Wp8Ad5pvxjBhwqmKhYgHgVK84m9c6
         ljs3pSpZOfEZShtyq9ovcSsEH4knbeTwKKNYTMofltb4V4nxPEFzkxKN2LhrRUdbobio
         6elR5vwBfO0ieSlD92PfGHQSgSIxENDXALeThQWrtq1odxd3srlun/JcYJwtmsqz8mDJ
         8Mc3f3A4NAmW9mmDkij/IZXPBcTF2Fi89dYO/yApmFeHGtb8XnJhgOZj3+ZOBd5bgDKh
         Jk0hsJxdli3pDWwciHGw76ps6lr90/8sgsPo0zN8JXcEJpQIrciWTfNUDgt1xN2opGR1
         PYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724594; x=1735329394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSuCNtOVV+R11g8QPC6TJRQ60HKfpVL/OeZ5X11d4SE=;
        b=G4jTDxXSUwOOp7z6yVHrXOH1sQqYUvfSE6aCFEmIEH2LaMgltAiujzdaut8JAOi4wL
         t38e+NLGL7qsbdSjxl0hDFaKg+8GImJ/3+l3bIrHNWN606gwCflZBrGCu1x3mFcz39kn
         gXn6Uf4Kb8nDD38fBWpfaKw9CvXsv0764rQ2b7dH7RzvzsYDlqml7vT8iY4b7e7J7UzM
         Vg5mSYlwRU5CA+MKcML6ZxQ3Yvgow+EO/Pn9zbdtQ1cpF8XDQm4UmZJ//gOpHh2FbsNa
         DT2S4pVcz25PhP8unI5bVsU1LU79eRwjnMo7MC3JMjOpxL89AxoPNeaPo826xA99wqut
         QLmw==
X-Gm-Message-State: AOJu0Yzjr1jNl7w4WqzJlUZjO26RvDHaAu6JZHu6qgivV1b2JxKWXNfp
	F+DM4BEJKNsjW3qPusYnoDRIPMbtFu5bduKOpUztKR35R2Z/9dfP+N5uMg==
X-Gm-Gg: ASbGncs0dBZnM7sLWg7R11ZSG9G3Oi/4zM5S/9pgPLI967ai5T03sl54wEysizWfmRD
	pnqW+dtd1Nwbdm7hvy/uZd+IUt3cZN46RUGdGSMO/cWyey1hOtvsJ6PJfO1o7xiOTUuxDtRUu4Z
	XEUzgmBRi75aqanfmUsVUkLJ9s+s9w+eVMQN+AoBf56mmLDn+eqVmKeptJhV+CrlLOdHrPfmCzB
	YdBbZTFwsGkC+zNlCPkXsFtv9BgfNZInNo7XDKu7l4YPO8ZepPkGdlAWwIF+/oR6oSGMqLtDOuC
	drMb8qH2cTkSXQRrmVkyV9O1Jaus4aVF
X-Google-Smtp-Source: AGHT+IH0L9jh+hfs+3LzLnyzUs4dnFLtf7/ED1k4Oc55emX6aPRrk1FnRljVMfMq3BvZw/0zm0SuBw==
X-Received: by 2002:a05:6a21:680b:b0:1e1:ae9a:6311 with SMTP id adf61e73a8af0-1e5e0458dcamr6655696637.4.1734724594499;
        Fri, 20 Dec 2024 11:56:34 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:34 -0800 (PST)
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
Subject: [PATCH bpf-next v2 06/14] bpf: net_sched: Add basic bpf qdisc kfuncs
Date: Fri, 20 Dec 2024 11:55:32 -0800
Message-ID: <20241220195619.2022866-7-amery.hung@gmail.com>
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

Add basic kfuncs for working on skb in qdisc.

Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
in .enqueue where a to_free skb list is available from kernel to defer
the release. bpf_kfree_skb() should be used elsewhere. It is also used
in bpf_obj_free_fields() when cleaning up skb in maps and collections.

bpf_skb_get_hash() returns the flow hash of an skb, which can be used
to build flow-based queueing algorithms.

Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb().

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c |  2 +
 net/sched/bpf_qdisc.c       | 92 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2556f8043276..87ecee12af21 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1809,6 +1809,7 @@ struct bpf_struct_ops {
 	void *cfi_stubs;
 	struct module *owner;
 	const char *name;
+	const struct btf_type *type;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 27d4a170df84..65542d8f064c 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -442,6 +442,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		goto errout;
 	}
 
+	st_ops->type = t;
+
 	return 0;
 
 errout:
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 4b7d013f4f5c..1c92bfcc3847 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -108,6 +108,79 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+__bpf_kfunc_start_defs();
+
+/* bpf_skb_get_hash - Get the flow hash of an skb.
+ * @skb: The skb to get the flow hash from.
+ */
+__bpf_kfunc u32 bpf_skb_get_hash(struct sk_buff *skb)
+{
+	return skb_get_hash(skb);
+}
+
+/* bpf_kfree_skb - Release an skb's reference and drop it immediately.
+ * @skb: The skb whose reference to be released and dropped.
+ */
+__bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
+{
+	kfree_skb(skb);
+}
+
+/* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
+ * @skb: The skb whose reference to be released and dropped.
+ * @to_free_list: The list of skbs to be dropped.
+ */
+__bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
+				    struct bpf_sk_buff_ptr *to_free_list)
+{
+	__qdisc_drop(skb, (struct sk_buff **)to_free_list);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(qdisc_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(qdisc_kfunc_ids)
+
+BTF_SET_START(qdisc_common_kfunc_set)
+BTF_ID(func, bpf_skb_get_hash)
+BTF_ID(func, bpf_kfree_skb)
+BTF_SET_END(qdisc_common_kfunc_set)
+
+BTF_SET_START(qdisc_enqueue_kfunc_set)
+BTF_ID(func, bpf_qdisc_skb_drop)
+BTF_SET_END(qdisc_enqueue_kfunc_set)
+
+static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (bpf_Qdisc_ops.type != btf_type_by_id(prog->aux->attach_btf,
+						 prog->aux->attach_btf_id))
+		return 0;
+
+	/* Skip the check when prog->attach_func_name is not yet available
+	 * during check_cfg().
+	 */
+	if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id) ||
+	    !prog->aux->attach_func_name)
+		return 0;
+
+	if (!strcmp(prog->aux->attach_func_name, "enqueue")) {
+		if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_id))
+		       return 0;
+	}
+
+	return btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id) ? 0 : -EACCES;
+}
+
+static const struct btf_kfunc_id_set bpf_qdisc_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &qdisc_kfunc_ids,
+	.filter = bpf_qdisc_kfunc_filter,
+};
+
 static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
 	.get_func_proto		= bpf_qdisc_get_func_proto,
 	.is_valid_access	= bpf_qdisc_is_valid_access,
@@ -200,8 +273,25 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
+BTF_ID_LIST(bpf_sk_buff_dtor_ids)
+BTF_ID(func, bpf_kfree_skb)
+
 static int __init bpf_qdisc_kfunc_init(void)
 {
-	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+	int ret;
+	const struct btf_id_dtor_kfunc skb_kfunc_dtors[] = {
+		{
+			.btf_id       = bpf_sk_buff_ids[0],
+			.kfunc_btf_id = bpf_sk_buff_dtor_ids[0]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_qdisc_kfunc_set);
+	ret = ret ?: register_btf_id_dtor_kfuncs(skb_kfunc_dtors,
+						 ARRAY_SIZE(skb_kfunc_dtors),
+						 THIS_MODULE);
+	ret = ret ?: register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+
+	return ret;
 }
 late_initcall(bpf_qdisc_kfunc_init);
-- 
2.47.0


