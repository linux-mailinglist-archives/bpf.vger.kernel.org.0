Return-Path: <bpf+bounces-34786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00133930B1C
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC9CB20DE2
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7233D143878;
	Sun, 14 Jul 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awipAlky"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F713D8AC;
	Sun, 14 Jul 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979500; cv=none; b=lVKxrr0UmqXgc8swEsaMXfkHoebuyZXBiaUVtpJKFHI5KmOCr2iftFniIxDqj7rdF3utgW3puRZKMN/ZVXzuxUn5Y6a7ZIq5cjfI7TH06/hVl1SDoPcAXuY0tGjk+LYgeBljpjwArD0hUUK9q/+gLIshdsys2jWsLR/GhcDaRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979500; c=relaxed/simple;
	bh=4tgm0rtgiKrQ13phg5UrlEtwRzDVm6eBfOhkY0pSGQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbHd34Bmnk9vbIkRVuNtKykc6GH4xelLKzcx+S/DLPp8DG5sJfMyW1EJsX0jWK/Y0vy04jEiRWPdllsXNdA6tuK5TuDWnQi+1t+YNZsq5wUPdeVWK0oVXo9JPHVYeJefdKB9oyZLUgd4NIuqFnXAL1ZFcNJhLGczVgD3YgY0xQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awipAlky; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447f25e65f9so18995391cf.3;
        Sun, 14 Jul 2024 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979496; x=1721584296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06Iby+UsipdZWrLAzwBk+vvxyWam8V7Dc6hfSUjvbd0=;
        b=awipAlky3okjI0FDp+sM5igNbyWh3/KNhPsDq3cK09kzuS7hUPCUetQHujicGLsn7R
         TMJKnv7T4AcBNFWqF6Wg6QbV5JxdhSm+pWVllXCTuvs1g4nmbjHPWzqZ4Aow7pdeBagY
         exdCqa5FPS+CE3/h0uNYfVAI0mjzRVXQ1G64MQkzt8afiA/C6nY9YxmXEU9+X0Xl5+hq
         QnES/Uaans1b9Pmjw5/mSAQCf/klvG6mlrtmJq1+YyuKwEaj/GtfRIbCzKTL4QIszLpq
         FCrfWncBLPfcK6WMfSVWSy/lWvyi+CeoTVIsnK813nM21GnbhwCuYE1s2yIEy+tefNr/
         R5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979496; x=1721584296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06Iby+UsipdZWrLAzwBk+vvxyWam8V7Dc6hfSUjvbd0=;
        b=WGD1kSXvcNUuS6GY/eHdjpssv5XjR896rf028GmYwyxjptVGi0mPsPESMRpdh7A4HR
         yvEuh2lh2Il4/zBVolVSEB+7hdMtIuc+GS3OQ28TmzOfUps2ZlZVB8FS2AILADZcWsdB
         7O0HcWJFncwtZINJAF8GMMs2ht38EGzy/cOLo1fVYPenqpcPE16Whc5M/C/kwwbVptQr
         A8GOBcHtre3jv+x+XWVYc+pi5fGgTFV49yZ3kLd2lAEJjs4wO7mlMnLMz/J7ZWHXfzLn
         0HFM7GXVKiSVEh9eofwSDByC4XEGpxSx5HoE76QLd6+L2Yjzcxa22Kjh1XQajJ/pGTeC
         yuRQ==
X-Gm-Message-State: AOJu0Ywx0OmwWL1i72jxy7X2WQnL6OYIzuQBQXPPJz10jSEAVpX7RMd7
	1jX85hp8hJDYZxYA7GGQqHizaYlh6m1AQEuSUhmcW3/M282afdNIoRmC7Q==
X-Google-Smtp-Source: AGHT+IFvLseeStupIH4TfxY6Pd1XHMrFFiMNDvsq6dYZM7539fFBr0mIiC3+0gLunRc5y9Fh3WLmMQ==
X-Received: by 2002:a05:622a:2ca:b0:444:e9b9:709f with SMTP id d75a77b69052e-447fa85c5bdmr207099731cf.19.1720979496185;
        Sun, 14 Jul 2024 10:51:36 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 07/11] bpf: net_sched: Allow more optional operators in Qdisc_ops
Date: Sun, 14 Jul 2024 17:51:26 +0000
Message-Id: <20240714175130.4051012-8-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, init, reset, and destroy are implemented by bpf qdisc infra as
fixed operators that manipulate the watchdog according to the occasion.
This patch allows users to implement these three operators to perform
desired work alongside the predefined ones.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/net/sch_generic.h |  6 ++++++
 net/sched/bpf_qdisc.c     | 20 ++++----------------
 net/sched/sch_api.c       | 11 +++++++++++
 net/sched/sch_generic.c   |  8 ++++++++
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 214ed2e34faa..3041782b7527 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1359,4 +1359,10 @@ static inline void qdisc_synchronize(const struct Qdisc *q)
 		msleep(1);
 }
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt, struct netlink_ext_ack *extack);
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch);
+void bpf_qdisc_reset_post_op(struct Qdisc *sch);
+#endif
+
 #endif
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index eff7559aa346..903b4eb54510 100644
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
@@ -36,8 +33,8 @@ static int bpf_qdisc_init(struct btf *btf)
 	return 0;
 }
 
-static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
-			     struct netlink_ext_ack *extack)
+int bpf_qdisc_init_pre_op(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 
@@ -45,14 +42,14 @@ static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
 	return 0;
 }
 
-static void bpf_qdisc_reset_op(struct Qdisc *sch)
+void bpf_qdisc_reset_post_op(struct Qdisc *sch)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 
 	qdisc_watchdog_cancel(&q->watchdog);
 }
 
-static void bpf_qdisc_destroy_op(struct Qdisc *sch)
+void bpf_qdisc_destroy_post_op(struct Qdisc *sch)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
 
@@ -235,15 +232,6 @@ static int bpf_qdisc_init_member(const struct btf_type *t,
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
index 5064b6d2d1ec..9fb9375e2793 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1352,6 +1352,13 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		rcu_assign_pointer(sch->stab, stab);
 	}
 
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
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
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+	if (sch->flags & TCQ_F_BPF)
+		bpf_qdisc_destroy_post_op(sch);
+#endif
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
 	lockdep_unregister_key(&sch->root_lock_key);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 76e4a6efd17c..0ac05665c69f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1033,6 +1033,10 @@ void qdisc_reset(struct Qdisc *qdisc)
 
 	if (ops->reset)
 		ops->reset(qdisc);
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+	if (qdisc->flags & TCQ_F_BPF)
+		bpf_qdisc_reset_post_op(qdisc);
+#endif
 
 	__skb_queue_purge(&qdisc->gso_skb);
 	__skb_queue_purge(&qdisc->skb_bad_txq);
@@ -1076,6 +1080,10 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 
 	if (ops->destroy)
 		ops->destroy(qdisc);
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_BPF_JIT)
+	if (qdisc->flags & TCQ_F_BPF)
+		bpf_qdisc_destroy_post_op(qdisc);
+#endif
 
 	lockdep_unregister_key(&qdisc->root_lock_key);
 	bpf_module_put(ops, ops->owner);
-- 
2.20.1


