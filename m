Return-Path: <bpf+bounces-29534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D3B8C2A97
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81BF1C21BCC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EF5F876;
	Fri, 10 May 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVsN2QKj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8177537F8;
	Fri, 10 May 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369066; cv=none; b=WtVXJsX0WmwhxvPABPr4bi4IIR2bfPb9dmTGnhIqXjyj2Q7tnBHan7Os1IhhvXzv4ufSSUH3LaHe0jpvNeMLr+SRz4QROgXZKkJcm0c9X9motgCa71mWLGHqWM+Zfj9p19A531zAWiO9UuAzLxZw9AoXSK6oOwZIDnvYxwk/hbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369066; c=relaxed/simple;
	bh=hIbTqEglQ2bFYGbS4V0MMiMJKsrpxxyTN/D2mrW0T+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sy1OAZAU7Ne5pZSqdNHJFh5UaiDjX4kVzIqHyUFys2m8teroQrnZMEBS4RpXf3XuT+vga9ebFyFFKz6Ay6+Y6LbjshJ7IOLEmG/1Umv2xc1TrpPvwkPLCegztJuji7EklTqI9BN+JkQkxg5i4epQn5sugl6LDabpMTWMcqyJbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVsN2QKj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43692353718so15545881cf.0;
        Fri, 10 May 2024 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369064; x=1715973864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8AFTlewnSL+/ijdYwMN1SOSwKFzSFH7C8XrS2MV76M=;
        b=YVsN2QKjCzk3g0Fcc8TdvjWuvr6+84XX0MeCABs/Nx42G6M50FjOruTe1dKmiwZlWf
         JaLlNypKMNkw0azH5RtOdGslWhTlBzZu/k4W8JOhbcM12xpm/zv4nq0ssR/MCvSxQLVY
         ukHj1cTMvUpJov36+7nuQjqVAEFJ4wjH/pO1CJbP4fd6i3t/8fY+z4/Dw6s5LCmKoAu6
         eJDlrwWGYGuE5bNIlx72ePIQ1m6d/M8z3upr+a2nei2H2ln3D3s+IXmRrtdSODBjIBD2
         eDyY6KLJNNog8zZoqBfvA0BDCIM01BdNPodiESlO13RNRx4VycZYq1pUn10F8qSzwduP
         CgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369064; x=1715973864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8AFTlewnSL+/ijdYwMN1SOSwKFzSFH7C8XrS2MV76M=;
        b=YLyTX2sBADivy/cGsWZ4Ld7Xc7FHwLSykYj/BrmWcqh3KrCnAlR2PK7AbuXHj+YOoY
         whApwv8y3VLzuIBhwIkzYbUm0+OPRP+ZKAS0UOg8E3PQrvVSK0dnC2gq1E7uIBjnKd0F
         hxK2oYuBCKfavRk5G/HjzT5Ad/D/m4bdHmrdymr1mvvgTQ4F8LHsfkJdfVgA599P08kb
         EnnmuhAkxXyv9ANcDez22VhIDz6XRZSClUnwkH9l2PYm7HU2pC+c3l6Pxp98VjBCD4Tl
         t1FX2y+l+wArOf52JkPCoIwr4l4e5GYTL5CHFC8SxJDB5sfOeS5IY6oazMP6x1ISmzZL
         AZfQ==
X-Gm-Message-State: AOJu0YwqEOpKFDC/kByxEaFFlqpS15lC7JmACzrKPlpte3LD8/1E1nU4
	cc8kw+FQ8KFQ7ajcPmujNFW15Qzs4DhmuCFRWPrn0uXv4knBZJDrgVvt2Q==
X-Google-Smtp-Source: AGHT+IF+O6VF5tdmHwzi0WGAbkDJZMXnnacXVWCOiStepB72RMHkoQiIhUERVPn6rXAvtIDvPwnsNg==
X-Received: by 2002:ac8:58c9:0:b0:43a:cfd9:355a with SMTP id d75a77b69052e-43dfdaada9bmr51070901cf.23.1715369063820;
        Fri, 10 May 2024 12:24:23 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 15/20] bpf: net_sched: Allow more optional methods in Qdisc_ops
Date: Fri, 10 May 2024 19:24:07 +0000
Message-Id: <20240510192412.3297104-16-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, init, reset, and destroy are implemented by bpf qdisc infra as
fixed methods that manipulate the watchdog and the class hash table
according to the occasion. This patch allows users to supply these
three ops to perform the desired work alongside the predefined methods.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/net/sch_generic.h |  8 ++++++++
 net/sched/bpf_qdisc.c     | 22 +++++-----------------
 net/sched/sch_api.c       | 12 +++++++++++-
 net/sched/sch_generic.c   |  8 ++++++++
 4 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 76db6be16083..71e54cfa0d41 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1356,4 +1356,12 @@ static inline void qdisc_synchronize(const struct Qdisc *q)
 		msleep(1);
 }
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+extern const struct Qdisc_class_ops sch_bpf_class_ops;
+
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack);
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
+void bpf_qdisc_reset_post_op(struct Qdisc *sch);
+#endif
+
 #endif
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 2a40452c2c9a..cb9088d0571a 100644
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
@@ -191,8 +188,8 @@ static void sch_bpf_walk(struct Qdisc *sch, struct qdisc_walker *arg)
 	}
 }
 
-static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
-			struct netlink_ext_ack *extack)
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 	int err;
@@ -210,7 +207,7 @@ static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
 	return 0;
 }
 
-static void bpf_qdisc_reset_op(struct Qdisc *sch)
+void bpf_qdisc_reset_post_op(struct Qdisc *sch)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 	struct sch_bpf_class *cl;
@@ -233,7 +230,7 @@ static void bpf_qdisc_destroy_class(struct Qdisc *sch, struct sch_bpf_class *cl)
 	kfree(cl);
 }
 
-static void bpf_qdisc_destroy_op(struct Qdisc *sch)
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 	struct sch_bpf_class *cl;
@@ -255,7 +252,7 @@ static void bpf_qdisc_destroy_op(struct Qdisc *sch)
 	qdisc_class_hash_destroy(&q->clhash);
 }
 
-static const struct Qdisc_class_ops sch_bpf_class_ops = {
+const struct Qdisc_class_ops sch_bpf_class_ops = {
 	.graft		=	sch_bpf_graft,
 	.leaf		=	sch_bpf_leaf,
 	.find		=	sch_bpf_search,
@@ -611,15 +608,6 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
 			return -EINVAL;
 		qdisc_ops->priv_size = sizeof(struct bpf_sched_data);
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
index 3b5ada5830cd..a81ceee55755 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1249,7 +1249,6 @@ static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
 
    Parameters are passed via opt.
  */
-
 static struct Qdisc *qdisc_create(struct net_device *dev,
 				  struct netdev_queue *dev_queue,
 				  u32 parent, u32 handle,
@@ -1352,6 +1351,13 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		rcu_assign_pointer(sch->stab, stab);
 	}
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+	if (ops->cl_ops == &sch_bpf_class_ops) {
+		err = bpf_qdisc_init_pre_op(sch, tca[TCA_OPTIONS], extack);
+		if (err != 0)
+			goto err_out4;
+	}
+#endif
 	if (ops->init) {
 		err = ops->init(sch, tca[TCA_OPTIONS], extack);
 		if (err != 0)
@@ -1388,6 +1394,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	 */
 	if (ops->destroy)
 		ops->destroy(sch);
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+	if (ops->cl_ops == &sch_bpf_class_ops)
+		bpf_qdisc_destroy_post_op(sch);
+#endif
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
 	netdev_put(dev, &sch->dev_tracker);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index f4343653db0f..385ae2974f00 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1024,6 +1024,10 @@ void qdisc_reset(struct Qdisc *qdisc)
 
 	if (ops->reset)
 		ops->reset(qdisc);
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+	if (ops->cl_ops == &sch_bpf_class_ops)
+		bpf_qdisc_reset_post_op(qdisc);
+#endif
 
 	__skb_queue_purge(&qdisc->gso_skb);
 	__skb_queue_purge(&qdisc->skb_bad_txq);
@@ -1067,6 +1071,10 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	if (ops->destroy)
 		ops->destroy(qdisc);
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+	if (ops->cl_ops == &sch_bpf_class_ops)
+		bpf_qdisc_destroy_post_op(qdisc);
+#endif
 
 	bpf_module_put(ops, ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
-- 
2.20.1


