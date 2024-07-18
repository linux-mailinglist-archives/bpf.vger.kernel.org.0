Return-Path: <bpf+bounces-34975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9574F93453E
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 02:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE99282ADA
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 00:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E71110A;
	Thu, 18 Jul 2024 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df18c+Xh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40617C;
	Thu, 18 Jul 2024 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260916; cv=none; b=dbS98ikD/zmwF56jd+TQi3ZQ3QgSbjoH2QkZGcdPBXph4OUIyD8YDyIaqQjef8sbbESjjSlwPC6/7DZd/rPWXbE40T2xSSCbegBdY+qpeKhh/3YUfMULM3yMYttscp+jCrrv7/i8OxjzMM1tWu9IRRq9MmwOU5YnBfHh0eC8hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260916; c=relaxed/simple;
	bh=vHFxc2Ur597TWvHfjkWBzxs5RfAaRTot7tHcJmKtVCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBmSMh47rlZjSzRAT9It/ibe6IoZWe6HJ70lkY89jF4YqAS88KCHh6PDe0KnNckERE6ZdXwXIv9SxXYfcJTXfHK+J3JR8TDPqS0uemqC3Kza0nBrTpaeaWY5ZVkFLver5tFad5h20zqxtmy9QTnx8uDjG87JDfhfSqp3AB0OSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df18c+Xh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447d97f98d3so1030601cf.2;
        Wed, 17 Jul 2024 17:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721260913; x=1721865713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Fw85L11+MMqvq4kNEJMWzGRQo2WsO+rf8VuaAlHbgA=;
        b=Df18c+XhVI0mw0AjeBdyEje97YccVtd1iBpVt29+u0S0mQhpBqjtuVorWTO47YscQk
         QwI//Lxvp5cdUwh6i8T4/+knUVp0HWjQft/RArPXcI1RHRFlzeGbSVXE38xBhmkkf6py
         Osa2OMv+thtQTIY4u2j5CURHQNf/tvli5/isybmdtKRXVPDDaHBPQ4hym4Rppr34CDSu
         TYwDXyI8kSV/7L/BHg1tCxtz/oMElXrTKpcTMyYjzkIdcMK9VTvyBRDIkneD5khwxHiM
         qmGmh/bPZHRHiVi0Sn3rXdUQgoxUeAg0V4h0RbzMuT17jPbXgA3SS8zwZkaoiSLQh3kT
         izxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721260913; x=1721865713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Fw85L11+MMqvq4kNEJMWzGRQo2WsO+rf8VuaAlHbgA=;
        b=ptxIX/P22FbHJOfpQ6bAIhjpiKHrZTrMn7uEqkflBTSuxLUWgwJw3Enh+hGhJ4RTtS
         y3BDhjdI3dXFMqUvFTopLwxYNm/4e2g1HSJ5VIVZyd3rLHHiBUa9r1FW/YcaVVCkarTY
         OHMANTrB3/TpLrCv9dO7XO4Pgg96W1NnN+xpNeRx+ELgzaXQRgzCnAxKeTYj9+dRosiX
         QS0gYtmvYlj5MG5UpRwPiZoctBNtRw85QaOFDcd2w0wbQQXd+h97nKbu4NeJUv+9WOJE
         o7br6fCEnTPaxcIRiD6M07doTgusi5TddoNBWGWrU1pNb/3gw3fkR0gOxIdurID01Up3
         uUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZLqtcJplFOmkFZPc2XuNrl3Kw/mklND5x4s80iVaBf5+68wawgaRsw3T7qJZbYLjBTKZN9beaS+LKS8rCXvGLVEDbKqj8CC7dLH8w7LVLcjeFR4yJxm4HD9YA
X-Gm-Message-State: AOJu0YyegbMlFsSPhol2iqt7ct+dzuYw9v6PDKsC2ZmPMFpzG661cFPe
	fslHY2hJseCQt1Ar3RzEwBewysA50vzZMNWddiL0FCN/2s3AaC43
X-Google-Smtp-Source: AGHT+IGNOj3wmrBoBCEPCZISrmpDXyq0p7IgZ6RLi71Q9xuvZEqwAiBFZY3r12D8EfLNGn+ZOfERlg==
X-Received: by 2002:ac8:7f43:0:b0:446:54f5:318a with SMTP id d75a77b69052e-44f86185bf6mr34708541cf.10.1721260912863;
        Wed, 17 Jul 2024 17:01:52 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83d990sm53457361cf.80.2024.07.17.17.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:01:52 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: ameryhung@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	sdf@google.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	xiyou.wangcong@gmail.com,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	donald.hunter@gmail.com
Subject: [RFC PATCH v9 07/11] bpf: net_sched: Allow more optional operators in Qdisc_ops
Date: Thu, 18 Jul 2024 00:01:52 +0000
Message-Id: <20240718000152.2447212-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-8-amery.hung@bytedance.com>
References: <20240714175130.4051012-8-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <ameryhung@gmail.com>

So far, init, reset, and destroy are implemented by bpf qdisc infra as
fixed operators that manipulate the watchdog according to the occasion.
This patch allows users to implement these three operators to perform
desired work alongside the predefined ones.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/net/sch_generic.h |  4 ++++
 net/sched/bpf_qdisc.c     | 23 +++++++----------------
 net/sched/sch_api.c       | 11 +++++++++++
 net/sched/sch_generic.c   |  8 ++++++++
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 214ed2e34faa..1ab9e91281c0 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1359,4 +1359,8 @@ static inline void qdisc_synchronize(const struct Qdisc *q)
 		msleep(1);
 }
 
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack);
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
+void bpf_qdisc_reset_post_op(struct Qdisc *sch);
+
 #endif
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index eff7559aa346..0273b3f8f230 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -9,9 +9,6 @@
 static struct bpf_struct_ops bpf_Qdisc_ops;
 
 static u32 unsupported_ops[] = {
-	offsetof(struct Qdisc_ops, init),
-	offsetof(struct Qdisc_ops, reset),
-	offsetof(struct Qdisc_ops, destroy),
 	offsetof(struct Qdisc_ops, change),
 	offsetof(struct Qdisc_ops, attach),
 	offsetof(struct Qdisc_ops, change_real_num_tx),
@@ -36,28 +33,31 @@ static int bpf_qdisc_init(struct btf *btf)
 	return 0;
 }
 
-static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
-			     struct netlink_ext_ack *extack)
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 
 	qdisc_watchdog_init(&q->watchdog, sch);
 	return 0;
 }
+EXPORT_SYMBOL(bpf_qdisc_init_pre_op);
 
-static void bpf_qdisc_reset_op(struct Qdisc *sch)
+void bpf_qdisc_reset_post_op(struct Qdisc *sch)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 
 	qdisc_watchdog_cancel(&q->watchdog);
 }
+EXPORT_SYMBOL(bpf_qdisc_reset_post_op);
 
-static void bpf_qdisc_destroy_op(struct Qdisc *sch)
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 
 	qdisc_watchdog_cancel(&q->watchdog);
 }
+EXPORT_SYMBOL(bpf_qdisc_destroy_post_op);
 
 static const struct bpf_func_proto *
 bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
@@ -235,15 +235,6 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
 			return -EINVAL;
 		qdisc_ops->static_flags = TCQ_F_BPF;
 		return 1;
-	case offsetof(struct Qdisc_ops, init):
-		qdisc_ops->init = bpf_qdisc_init_op;
-		return 1;
-	case offsetof(struct Qdisc_ops, reset):
-		qdisc_ops->reset = bpf_qdisc_reset_op;
-		return 1;
-	case offsetof(struct Qdisc_ops, destroy):
-		qdisc_ops->destroy = bpf_qdisc_destroy_op;
-		return 1;
 	case offsetof(struct Qdisc_ops, peek):
 		if (!uqdisc_ops->peek)
 			qdisc_ops->peek = qdisc_peek_dequeued;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 5064b6d2d1ec..6379edf94f69 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1352,6 +1352,13 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		rcu_assign_pointer(sch->stab, stab);
 	}
 
+#ifdef CONFIG_NET_SCH_BPF
+	if (sch->flags & TCQ_F_BPF) {
+		err = bpf_qdisc_init_pre_op(sch, tca[TCA_OPTIONS], extack);
+		if (err != 0)
+			goto err_out4;
+	}
+#endif
 	if (ops->init) {
 		err = ops->init(sch, tca[TCA_OPTIONS], extack);
 		if (err != 0)
@@ -1388,6 +1395,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	 */
 	if (ops->destroy)
 		ops->destroy(sch);
+#ifdef CONFIG_NET_SCH_BPF
+	if (sch->flags & TCQ_F_BPF)
+		bpf_qdisc_destroy_post_op(sch);
+#endif
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
 	lockdep_unregister_key(&sch->root_lock_key);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 76e4a6efd17c..0906d8a9f35d 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1033,6 +1033,10 @@ void qdisc_reset(struct Qdisc *qdisc)
 
 	if (ops->reset)
 		ops->reset(qdisc);
+#ifdef CONFIG_NET_SCH_BPF
+	if (qdisc->flags & TCQ_F_BPF)
+		bpf_qdisc_reset_post_op(qdisc);
+#endif
 
 	__skb_queue_purge(&qdisc->gso_skb);
 	__skb_queue_purge(&qdisc->skb_bad_txq);
@@ -1076,6 +1080,10 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	if (ops->destroy)
 		ops->destroy(qdisc);
+#ifdef CONFIG_NET_SCH_BPF
+	if (qdisc->flags & TCQ_F_BPF)
+		bpf_qdisc_destroy_post_op(qdisc);
+#endif
 
 	lockdep_unregister_key(&qdisc->root_lock_key);
 	bpf_module_put(ops, ops->owner);
-- 
2.20.1


