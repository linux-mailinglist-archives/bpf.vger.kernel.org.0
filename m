Return-Path: <bpf+bounces-19755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A07A8830EE7
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F175EB22C7A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739728E02;
	Wed, 17 Jan 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy5iLNhq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BD28DB4;
	Wed, 17 Jan 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528592; cv=none; b=TsIYpMclDvMAWEXA2+cBjzmvwOe0KWQe7jY43sLgYMTWSn4vBcu/SH+QjnCklAyRP1YHI86znzdmgpXwHIQfNJxaaKAepGPtoreru51fER9Ck7Gy8sjj9U2xG8ML0GdAS4BOIFei5M7J+IIup4uqUXZJYMH9qO+3+0KmNnrZLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528592; c=relaxed/simple;
	bh=1mboDMZbXhjjGyMIZ10jie1E1Pz+G7KhgTRa+lPl1Ok=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=SpkBZ6rHFFpsZnGBc8XJJXa9KZSv0ks6jj7Ym5mgErTlElGGoz8Z9/ObQPiHQFdG+jXvwki0g0CA2r1+YImRnxFtuHVA6g4HaFT28QGb1YU/M+nUuT5w9SK4nn6FPe+IylJoHdu6zmFVf4lTxUrJoSxgALzDV5uOmV+4/h2rx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy5iLNhq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-429f53f0b0bso15746611cf.2;
        Wed, 17 Jan 2024 13:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528590; x=1706133390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmSbpF5HJNRokADpjS/NeLmhwvKGKlpdziz8GFiM6W8=;
        b=Oy5iLNhqGoltgBhYZHJkEHNMJWjpsCY6QNGMA/+WfMOs2LhHfPFu+AS7x7Z49B/7Qe
         h09Ki/Z+AI2PihGxsKqxqphnKNuBOVJwgz3AUPcpMtgE0ekaRQlv43ZAwxstJmrxcWre
         3Vi3fmelp9m6Ct2OdMjjtR9CP5KePSrRyohyiYXevrCKi2jlHQ6iUFIKLEBalA1Rxv2A
         1jtKnT2Qc//1oBJCEIeEQJJe0a1crNWXtrieUkNmv5P3lNJ0KG24+p0DZzlPTgYPvcNL
         G64z/1SeHxWKblxZUP6S7WIlLoeN3YClgRDHPrS42mSIiWgfRJArzLSzupairUKydkWO
         BUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528590; x=1706133390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmSbpF5HJNRokADpjS/NeLmhwvKGKlpdziz8GFiM6W8=;
        b=ONBJyrv/9SO8Rf6S1j0RZzQb5+zATdaj77PqPmK2BUOqNMs4J3UAu20TWDUuyXOQCt
         lPkt7ynak6c6g2KMeC5Y8lkkkj81Wabwya1SwAg+JqWiPfCPuHesG26/7UOHMJNJeXv1
         STsIO+RKH9YUjNL/9N67VlDtaYszJ4lu0rWJAh1214ncUuPhGaN+cjRaLF6OmvgrPtqn
         uFCsC54airPTK3pmZn178D50Iu1TqlDqO/d511OcZXIt2+7RQHhg47C8U0DyVk7s/++2
         1Fg+hvHNEAomullaItbAqd9YUnR1ycVpn/aC2Z4ekA/n1CFVhWcsGXXU8Km052JfUTI8
         sg6A==
X-Gm-Message-State: AOJu0YxkIy2UVkgOw0ZlW06KnFfiB2L4lTkfUT3D2f6Ha+3k23ham/8h
	n/067ERhYHRmW5ZNmzzX6NwoTiIEOF0=
X-Google-Smtp-Source: AGHT+IEgfeoXyRC3XW1dp7hql3R63zkkvDoF83z3VsGpjmGg3G8d6h29e5GL4dVhujHvkH2dskuwgg==
X-Received: by 2002:a05:622a:189:b0:429:c957:708c with SMTP id s9-20020a05622a018900b00429c957708cmr12220811qtw.130.1705528590029;
        Wed, 17 Jan 2024 13:56:30 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:29 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com
Subject: [RFC PATCH v7 5/8] net_sched: Add init program
Date: Wed, 17 Jan 2024 21:56:21 +0000
Message-Id: <dcb5fcc21f7a905279744898415fb9942c7fd1ed.1705432850.git.amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1705432850.git.amery.hung@bytedance.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds another optional program to be called during
the creation of a qdisc for initializating data in the bpf world.
The program takes bpf_qdisc_ctx as context, but cannot not access
any field.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/uapi/linux/bpf.h       |  1 +
 include/uapi/linux/pkt_sched.h |  4 ++++
 kernel/bpf/syscall.c           |  1 +
 net/core/filter.c              |  3 ++-
 net/sched/sch_bpf.c            | 23 ++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 84669886a493..cad0788bef99 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1060,6 +1060,7 @@ enum bpf_attach_type {
 	BPF_QDISC_ENQUEUE,
 	BPF_QDISC_DEQUEUE,
 	BPF_QDISC_RESET,
+	BPF_QDISC_INIT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index e9e1a83c22f7..61f0cf4a088c 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1332,6 +1332,10 @@ enum {
 	TCA_SCH_BPF_RESET_PROG_FD,	/* u32 */
 	TCA_SCH_BPF_RESET_PROG_ID,	/* u32 */
 	TCA_SCH_BPF_RESET_PROG_TAG,	/* data */
+	TCA_SCH_BPF_INIT_PROG_NAME,	/* string */
+	TCA_SCH_BPF_INIT_PROG_FD,	/* u32 */
+	TCA_SCH_BPF_INIT_PROG_ID,	/* u32 */
+	TCA_SCH_BPF_INIT_PROG_TAG,	/* data */
 	__TCA_SCH_BPF_MAX,
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9af6fa542f2e..0959905044b9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2507,6 +2507,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		case BPF_QDISC_ENQUEUE:
 		case BPF_QDISC_DEQUEUE:
 		case BPF_QDISC_RESET:
+		case BPF_QDISC_INIT:
 			return 0;
 		default:
 			return -EINVAL;
diff --git a/net/core/filter.c b/net/core/filter.c
index f8e17465377f..5619a12c0d06 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8905,7 +8905,8 @@ static bool tc_qdisc_is_valid_access(int off, int size,
 {
 	struct btf *btf;
 
-	if (prog->expected_attach_type == BPF_QDISC_RESET)
+	if (prog->expected_attach_type == BPF_QDISC_RESET ||
+	    prog->expected_attach_type == BPF_QDISC_INIT)
 		return false;
 
 	if (off < 0 || off >= sizeof(struct bpf_qdisc_ctx))
diff --git a/net/sched/sch_bpf.c b/net/sched/sch_bpf.c
index 3f0f809dced6..925a131016f0 100644
--- a/net/sched/sch_bpf.c
+++ b/net/sched/sch_bpf.c
@@ -43,6 +43,7 @@ struct bpf_sched_data {
 	struct sch_bpf_prog __rcu enqueue_prog;
 	struct sch_bpf_prog __rcu dequeue_prog;
 	struct sch_bpf_prog __rcu reset_prog;
+	struct sch_bpf_prog __rcu init_prog;
 
 	struct qdisc_watchdog watchdog;
 };
@@ -88,6 +89,9 @@ static int sch_bpf_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (sch_bpf_dump_prog(&q->reset_prog, skb, TCA_SCH_BPF_RESET_PROG_NAME,
 			      TCA_SCH_BPF_RESET_PROG_ID, TCA_SCH_BPF_RESET_PROG_TAG))
 		goto nla_put_failure;
+	if (sch_bpf_dump_prog(&q->init_prog, skb, TCA_SCH_BPF_INIT_PROG_NAME,
+			      TCA_SCH_BPF_INIT_PROG_ID, TCA_SCH_BPF_INIT_PROG_TAG))
+		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
 
@@ -269,6 +273,9 @@ static const struct nla_policy sch_bpf_policy[TCA_SCH_BPF_MAX + 1] = {
 	[TCA_SCH_BPF_RESET_PROG_FD]	= { .type = NLA_U32 },
 	[TCA_SCH_BPF_RESET_PROG_NAME]	= { .type = NLA_NUL_STRING,
 					    .len = ACT_BPF_NAME_LEN },
+	[TCA_SCH_BPF_INIT_PROG_FD]	= { .type = NLA_U32 },
+	[TCA_SCH_BPF_INIT_PROG_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ACT_BPF_NAME_LEN },
 };
 
 static int bpf_init_prog(struct nlattr *fd, struct nlattr *name,
@@ -348,6 +355,10 @@ static int sch_bpf_change(struct Qdisc *sch, struct nlattr *opt,
 		goto failure;
 	err = bpf_init_prog(tb[TCA_SCH_BPF_RESET_PROG_FD],
 			    tb[TCA_SCH_BPF_RESET_PROG_NAME], &q->reset_prog, true);
+	if (err)
+		goto failure;
+	err = bpf_init_prog(tb[TCA_SCH_BPF_INIT_PROG_FD],
+			    tb[TCA_SCH_BPF_INIT_PROG_NAME], &q->init_prog, true);
 failure:
 	sch_tree_unlock(sch);
 	return err;
@@ -357,6 +368,8 @@ static int sch_bpf_init(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct bpf_qdisc_ctx ctx = {};
+	struct bpf_prog *init;
 	int err;
 
 	qdisc_watchdog_init(&q->watchdog, sch);
@@ -370,7 +383,14 @@ static int sch_bpf_init(struct Qdisc *sch, struct nlattr *opt,
 	if (err)
 		return err;
 
-	return qdisc_class_hash_init(&q->clhash);
+	err = qdisc_class_hash_init(&q->clhash);
+	if (err < 0)
+		return err;
+
+	init = rcu_dereference(q->init_prog.prog);
+	if (init)
+		bpf_prog_run(init, &ctx);
+	return 0;
 }
 
 static void sch_bpf_reset(struct Qdisc *sch)
@@ -420,6 +440,7 @@ static void sch_bpf_destroy(struct Qdisc *sch)
 	bpf_cleanup_prog(&q->enqueue_prog);
 	bpf_cleanup_prog(&q->dequeue_prog);
 	bpf_cleanup_prog(&q->reset_prog);
+	bpf_cleanup_prog(&q->init_prog);
 	sch_tree_unlock(sch);
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 84669886a493..cad0788bef99 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1060,6 +1060,7 @@ enum bpf_attach_type {
 	BPF_QDISC_ENQUEUE,
 	BPF_QDISC_DEQUEUE,
 	BPF_QDISC_RESET,
+	BPF_QDISC_INIT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.20.1


