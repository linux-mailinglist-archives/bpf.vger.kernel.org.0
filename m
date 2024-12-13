Return-Path: <bpf+bounces-46952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F2A9F1A03
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7382C7A03CB
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD81F427D;
	Fri, 13 Dec 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bLfAAbsa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976D1F2C2D
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132611; cv=none; b=h892NI5SkGLqgaD4ONDQ1jbuKEpdjfJHvXuJcC78s7yc6P3fRZgD08lnr+EAucnYa3TSpRg/xPo2hfE/iHED0sONpMjKHBpOinyw4WS6CWY6B4Zu4QI7QvYzbCfbV3V1uYsLCqNLfbwTpB5ZnvAyv4hl+3OoFypzS/VrBBeszcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132611; c=relaxed/simple;
	bh=2foTH+iUj94CLPM3igD82fuEWdY0C9Zj11bfis2nK+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svMfMQMxGhtR2wSlikLGmllhsdFy7yXc4KjLlHbHRQp7SI+PqGPfiLob2gHc5CYEwRL28aiOC2NbnE5oxTso6ngpuJb85gDDRe0tGZ0tI/QFLfL87OsA4eE5YbZPMPbMOV4toEQh4jhVR+DiSN7R/bOPE2o6SFl2EmNqB3alfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bLfAAbsa; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467838e75ffso27725861cf.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132608; x=1734737408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2OXYqrE0972zwioEMfpSl1a3S0EO1eGNBM1E6eSNMg=;
        b=bLfAAbsa/01McOgcHhKbcPSb01sZLGtYC1Xwofi+pXLt5HhmDROAakBJTb+2fRG6+v
         IAOpnMkOnEfNa8/0tCjJhnjqHJX2Kdyj0+qRnqSPI5gKnq0Us/xtjlmrZk41N+yOuiPF
         g1qm+dgcVWbkbpW6QiWFgrSndi15/zVqlpJZ+TWyB0y4591yBz+wc+Rw9QDRtpLr/sFi
         R+fmw7876Z4PDKVwFOM3lJgpQ6EbCw/r0T0dHk6kFN4WJ+kGlU1HfaHocewsmGJwr10A
         a1A/uCsR42vDF82H8rpsM1rmD/GoAJ3cDVOkLeDY03tGjiVDOC698nLP88lIVygXvc0X
         QTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132608; x=1734737408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2OXYqrE0972zwioEMfpSl1a3S0EO1eGNBM1E6eSNMg=;
        b=sWuIe7eWdtxWZSF+XGlE8lnkk+UO03cEczsKsuE58SSwoS7gFFwpqAELhF/j9fKMK/
         2SYVc1gGsgCfeIeOmAPI+4tDrrwo8WhrkwpAOfshsbcDXhKqMGT3IncGBmwyXG87Tz5R
         VBQlrZxR3kD03v9MmL0JA8hjZOnvhwcTyXrIOAw+gvZAADNuuAOFV6eXz7GqBwy8DIkT
         LgOwtUirGCbpyR01KO7k/n2StNjUjaCXyX/nKd4oNviBRpA3y5nRzKXSmiZMwdh9CgFR
         izmUnQd/ztEd2nZd6x5G/23NQS/AmY6CmTdhbt1QyxxA7rCOkvwvqCUSu03K8P3oHPC/
         5/gA==
X-Gm-Message-State: AOJu0YwSx6UkY5lBkpEPBXZgzdHtu+dCZ/fJLVF4e/ZUp8qClU4FjSZ/
	iZfJGp9hRVG8vbJS+wKTKhqtajOH25fE33IH4An1WRFsPrxAKZBCTlMjcnApkgg=
X-Gm-Gg: ASbGnculM8tVt1E9Kmzw4j7QGXIUi9cqtpe9Dnw6SDKd+ll2G7G0MYQUK8EfbD0gqsb
	IWDFySS2Ep0y/q4jPI9o0ghZ/yWxb0EKXeh0RbF6KHHda2HxV3akdmUJo9uNXWcRdIae3J+xphg
	yEl/CYT2CYYYxwG/wAUTRtpMQoX4bqtpwFe/llVi3OqOwuNIO93uyKw7AFDPlemswXl+Q3HfCPR
	lU/lsIrT19NG+ZsVy2HKqjHdFTbtH6/Ftm0A5xJ++jKr+KUKCsyXEHojUbNNaDvHtyT7Q8cqLGH
X-Google-Smtp-Source: AGHT+IHaMPV75hBtQpwrvsLV1zVwaAXv4UTowkerpUQcLAoXotUqlkI3a8ZfHYgi6Mv59hbl5MTQ8g==
X-Received: by 2002:a05:622a:308:b0:467:6e25:3f30 with SMTP id d75a77b69052e-467a57562f1mr77808161cf.12.1734132608545;
        Fri, 13 Dec 2024 15:30:08 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:08 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
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
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 07/13] bpf: net_sched: Add a qdisc watchdog timer
Date: Fri, 13 Dec 2024 23:29:52 +0000
Message-Id: <20241213232958.2388301-8-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a watchdog timer to bpf qdisc. The watchdog can be used to schedule
the execution of qdisc through kfunc, bpf_qdisc_schedule(). It can be
useful for building traffic shaping scheduling algorithm, where the time
the next packet will be dequeued is known.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/net/sch_generic.h |  4 +++
 net/sched/bpf_qdisc.c     | 51 ++++++++++++++++++++++++++++++++++++++-
 net/sched/sch_api.c       | 11 +++++++++
 net/sched/sch_generic.c   |  8 ++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 5d74fa7e694c..6a252b1b0680 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1357,4 +1357,8 @@ static inline void qdisc_synchronize(const struct Qdisc *q)
 		msleep(1);
 }
 
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack);
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
+void bpf_qdisc_reset_post_op(struct Qdisc *sch);
+
 #endif
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 28959424eab0..7c155207fe1e 100644
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
@@ -17,6 +21,32 @@ static int bpf_qdisc_init(struct btf *btf)
 	return 0;
 }
 
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+	return 0;
+}
+EXPORT_SYMBOL(bpf_qdisc_init_pre_op);
+
+void bpf_qdisc_reset_post_op(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+EXPORT_SYMBOL(bpf_qdisc_reset_post_op);
+
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+EXPORT_SYMBOL(bpf_qdisc_destroy_post_op);
+
 static const struct bpf_func_proto *
 bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
 			 const struct bpf_prog *prog)
@@ -134,12 +164,25 @@ __bpf_kfunc void bpf_qdisc_skb_drop(struct sk_buff *skb,
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
 __bpf_kfunc_end_defs();
 
 #define BPF_QDISC_KFUNC_xxx \
 	BPF_QDISC_KFUNC(bpf_skb_get_hash, KF_TRUSTED_ARGS) \
 	BPF_QDISC_KFUNC(bpf_kfree_skb, KF_RELEASE) \
 	BPF_QDISC_KFUNC(bpf_qdisc_skb_drop, KF_RELEASE) \
+	BPF_QDISC_KFUNC(bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS) \
 
 BTF_KFUNCS_START(bpf_qdisc_kfunc_ids)
 #define BPF_QDISC_KFUNC(name, flag) BTF_ID_FLAGS(func, name, flag)
@@ -154,9 +197,14 @@ BPF_QDISC_KFUNC_xxx
 
 static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (kfunc_id == bpf_qdisc_skb_drop_ids[0])
+	if (kfunc_id == bpf_qdisc_skb_drop_ids[0]) {
 		if (strcmp(prog->aux->attach_func_name, "enqueue"))
 			return -EACCES;
+	} else if (kfunc_id == bpf_qdisc_watchdog_schedule_ids[0]) {
+		if (strcmp(prog->aux->attach_func_name, "enqueue") &&
+		    strcmp(prog->aux->attach_func_name, "dequeue"))
+			return -EACCES;
+	}
 
 	return 0;
 }
@@ -189,6 +237,7 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
 	case offsetof(struct Qdisc_ops, priv_size):
 		if (uqdisc_ops->priv_size)
 			return -EINVAL;
+		qdisc_ops->priv_size = sizeof(struct bpf_sched_data);
 		return 1;
 	case offsetof(struct Qdisc_ops, static_flags):
 		if (uqdisc_ops->static_flags)
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f074053c4232..507abddcdafd 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1357,6 +1357,13 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		rcu_assign_pointer(sch->stab, stab);
 	}
 
+#ifdef CONFIG_NET_SCH_BPF
+	if (ops->owner == BPF_MODULE_OWNER) {
+		err = bpf_qdisc_init_pre_op(sch, tca[TCA_OPTIONS], extack);
+		if (err != 0)
+			goto err_out4;
+	}
+#endif
 	if (ops->init) {
 		err = ops->init(sch, tca[TCA_OPTIONS], extack);
 		if (err != 0)
@@ -1393,6 +1400,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	 */
 	if (ops->destroy)
 		ops->destroy(sch);
+#ifdef CONFIG_NET_SCH_BPF
+	if (ops->owner == BPF_MODULE_OWNER)
+		bpf_qdisc_destroy_post_op(sch);
+#endif
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
 	lockdep_unregister_key(&sch->root_lock_key);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 1e770ec251a0..ea4ee7f914be 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1039,6 +1039,10 @@ void qdisc_reset(struct Qdisc *qdisc)
 
 	if (ops->reset)
 		ops->reset(qdisc);
+#ifdef CONFIG_NET_SCH_BPF
+	if (ops->owner == BPF_MODULE_OWNER)
+		bpf_qdisc_reset_post_op(qdisc);
+#endif
 
 	__skb_queue_purge(&qdisc->gso_skb);
 	__skb_queue_purge(&qdisc->skb_bad_txq);
@@ -1082,6 +1086,10 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	if (ops->destroy)
 		ops->destroy(qdisc);
+#ifdef CONFIG_NET_SCH_BPF
+	if (ops->owner == BPF_MODULE_OWNER)
+		bpf_qdisc_destroy_post_op(qdisc);
+#endif
 
 	lockdep_unregister_key(&qdisc->root_lock_key);
 	bpf_module_put(ops, ops->owner);
-- 
2.20.1


