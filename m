Return-Path: <bpf+bounces-19754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2D830EE4
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2851C2218C
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B5C28DC1;
	Wed, 17 Jan 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYo5f4vt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347925639;
	Wed, 17 Jan 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528591; cv=none; b=tKzKv44l9wDGp054W+Vb35xRvTnn9zv02oI96JkpXHR7AOKEMjNZ7EE7yaaKXyMYN4i0e7er6zeshmpubDoMLFJJnpfMQEzjj2ZBmKyO4S/U0s8dtQA7Nt4HVYWq2PcgykkADeYeool6AhKOlDOonbIApW7tokWglmw31k5nl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528591; c=relaxed/simple;
	bh=z7Mg94SJvR2xmHWS+cKogaYuWpxt7kMQXygY+jCPFAs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=a/yLY7KSKlnQA5LBoBgHw+HxCROLBwshrZKAO/Q/aU46VE+6tuVht1QTIqcwRUFrzozrrDdewGgXU2OEEDZkH7W0+C18rBaaftVujpe/jsJumx5YibWlCuAI13p/EmMPbpCKR/f4lSFXl5Ew13ZLESIi/PY3BpfS/I4TyYZhf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYo5f4vt; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dde5d308c6so4752059a34.0;
        Wed, 17 Jan 2024 13:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528589; x=1706133389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO5BrodvLix8xDPnoK1LMM/6W0M4iKIvZWEV6IRwDR0=;
        b=fYo5f4vtXZT2sp+QkjjSQjFtZxuyoKB0ygoc2iwKSlymR9sjZf9odQQDBIu8lLie6+
         J520SYBcaKt/effmimhb2sgV3/9rlk69h9SIa8QzosHm2wNCUJQaMleZ9z+CZtImNcxL
         PpEWucafP8U7nDM6PzyDPkIduMwmfXpdT08ePp2/bInELjFbGI7ccNA95Gz8m2xykYnS
         tfIXYHM9qLJTG9Yun7aZxEPpS/wfW12RFNUrHTyDtEBqqd55Sfm4KJnfdngvQ+vqzRdn
         ftjk/NTGCzHQ9iiWzeQLMkXZofIc8xZ/fOsLPiTSs18cjxD4OWty73yaBVLtDX3HN9L2
         1V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528589; x=1706133389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO5BrodvLix8xDPnoK1LMM/6W0M4iKIvZWEV6IRwDR0=;
        b=I4tfWbXt9/W5dKfak+/aMNC6AytiQUWJArzaR3L66dgFLH2+/z7gpAEFxjEHTthhGA
         rPv4bhmfFHBtcCEX9/rsqyWLbxJJPePYi5LDhyJfTk3VsXFOdTHTxM79gpdXUPj1Fro4
         37Q+kIMr6/jNCqioRUPFuTrmQ/OjGsnjvF5SSq9MsAm6wpXFsW2lR53vI+m5Ce0tXvU3
         TuO8Jx5Ncr1l0GHEW38XiTHewwbckqmx8f0EVCN16tKh7M56UQPl81tHj6WEo15feRgV
         R2qHu2JLZThxdJE8+ad7XBu0sfZ32qkhHx5Bqvmofbq9ML1QGqVtBaayHft/G9907bCg
         mBEA==
X-Gm-Message-State: AOJu0YxCqUBQz4EIDDyqLiOaQ1AZJI4d63TXRpF0L7McP1ft8zTt6MmV
	1x+pXylmS9r1FL06wlFRmKI/TQ9Etys=
X-Google-Smtp-Source: AGHT+IGJwxV24t8odLHznbs2q1z69j9rmJ+Ts5huLAGmT3fDCHzL/hSVV4oyA2lIPqbuxaWxoiXMiA==
X-Received: by 2002:a05:6830:60c:b0:6dd:dd3a:a8a with SMTP id w12-20020a056830060c00b006dddd3a0a8amr6586257oti.58.1705528589139;
        Wed, 17 Jan 2024 13:56:29 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:28 -0800 (PST)
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
Subject: [RFC PATCH v7 4/8] net_sched: Add reset program
Date: Wed, 17 Jan 2024 21:56:20 +0000
Message-Id: <a45e9b29b616fdfb71cb6920aaecc6d22b1540b4.1705432850.git.amery.hung@bytedance.com>
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

Allow developers to implement customized reset logic through an optional
reset program. The program also takes bpf_qdisc_ctx as context, but
currently cannot access any field.

To release skbs, the program can release all references to bpf list or
rbtree serving as skb queues. The destructor kfunc bpf_skb_destroy()
will be called by bpf_map_free_deferred(). This prevents the qdisc from
holding the sch_tree_lock for too long when there are many packets in
the qdisc.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/uapi/linux/bpf.h       |  1 +
 include/uapi/linux/pkt_sched.h |  4 ++++
 kernel/bpf/syscall.c           |  1 +
 net/core/filter.c              |  3 +++
 net/sched/sch_bpf.c            | 30 ++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  1 +
 6 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index df280bbb7c0d..84669886a493 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1059,6 +1059,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_QDISC_ENQUEUE,
 	BPF_QDISC_DEQUEUE,
+	BPF_QDISC_RESET,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index d05462309f5a..e9e1a83c22f7 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1328,6 +1328,10 @@ enum {
 	TCA_SCH_BPF_DEQUEUE_PROG_FD,	/* u32 */
 	TCA_SCH_BPF_DEQUEUE_PROG_ID,	/* u32 */
 	TCA_SCH_BPF_DEQUEUE_PROG_TAG,	/* data */
+	TCA_SCH_BPF_RESET_PROG_NAME,	/* string */
+	TCA_SCH_BPF_RESET_PROG_FD,	/* u32 */
+	TCA_SCH_BPF_RESET_PROG_ID,	/* u32 */
+	TCA_SCH_BPF_RESET_PROG_TAG,	/* data */
 	__TCA_SCH_BPF_MAX,
 };
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1838bddd8526..9af6fa542f2e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2506,6 +2506,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		switch (expected_attach_type) {
 		case BPF_QDISC_ENQUEUE:
 		case BPF_QDISC_DEQUEUE:
+		case BPF_QDISC_RESET:
 			return 0;
 		default:
 			return -EINVAL;
diff --git a/net/core/filter.c b/net/core/filter.c
index f25a0b6b5d56..f8e17465377f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8905,6 +8905,9 @@ static bool tc_qdisc_is_valid_access(int off, int size,
 {
 	struct btf *btf;
 
+	if (prog->expected_attach_type == BPF_QDISC_RESET)
+		return false;
+
 	if (off < 0 || off >= sizeof(struct bpf_qdisc_ctx))
 		return false;
 
diff --git a/net/sched/sch_bpf.c b/net/sched/sch_bpf.c
index 1910a58a3352..3f0f809dced6 100644
--- a/net/sched/sch_bpf.c
+++ b/net/sched/sch_bpf.c
@@ -42,6 +42,7 @@ struct bpf_sched_data {
 	struct Qdisc_class_hash clhash;
 	struct sch_bpf_prog __rcu enqueue_prog;
 	struct sch_bpf_prog __rcu dequeue_prog;
+	struct sch_bpf_prog __rcu reset_prog;
 
 	struct qdisc_watchdog watchdog;
 };
@@ -51,6 +52,9 @@ static int sch_bpf_dump_prog(const struct sch_bpf_prog *prog, struct sk_buff *sk
 {
 	struct nlattr *nla;
 
+	if (!prog->prog)
+		return 0;
+
 	if (prog->name &&
 	    nla_put_string(skb, name, prog->name))
 		return -EMSGSIZE;
@@ -81,6 +85,9 @@ static int sch_bpf_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (sch_bpf_dump_prog(&q->dequeue_prog, skb, TCA_SCH_BPF_DEQUEUE_PROG_NAME,
 			      TCA_SCH_BPF_DEQUEUE_PROG_ID, TCA_SCH_BPF_DEQUEUE_PROG_TAG))
 		goto nla_put_failure;
+	if (sch_bpf_dump_prog(&q->reset_prog, skb, TCA_SCH_BPF_RESET_PROG_NAME,
+			      TCA_SCH_BPF_RESET_PROG_ID, TCA_SCH_BPF_RESET_PROG_TAG))
+		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
 
@@ -259,16 +266,21 @@ static const struct nla_policy sch_bpf_policy[TCA_SCH_BPF_MAX + 1] = {
 	[TCA_SCH_BPF_DEQUEUE_PROG_FD]	= { .type = NLA_U32 },
 	[TCA_SCH_BPF_DEQUEUE_PROG_NAME]	= { .type = NLA_NUL_STRING,
 					    .len = ACT_BPF_NAME_LEN },
+	[TCA_SCH_BPF_RESET_PROG_FD]	= { .type = NLA_U32 },
+	[TCA_SCH_BPF_RESET_PROG_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ACT_BPF_NAME_LEN },
 };
 
-static int bpf_init_prog(struct nlattr *fd, struct nlattr *name, struct sch_bpf_prog *prog)
+static int bpf_init_prog(struct nlattr *fd, struct nlattr *name,
+			 struct sch_bpf_prog *prog, bool optional)
 {
 	struct bpf_prog *fp, *old_fp;
 	char *prog_name = NULL;
 	u32 bpf_fd;
 
 	if (!fd)
-		return -EINVAL;
+		return optional ? 0 : -EINVAL;
+
 	bpf_fd = nla_get_u32(fd);
 
 	fp = bpf_prog_get_type(bpf_fd, BPF_PROG_TYPE_QDISC);
@@ -327,11 +339,15 @@ static int sch_bpf_change(struct Qdisc *sch, struct nlattr *opt,
 	sch_tree_lock(sch);
 
 	err = bpf_init_prog(tb[TCA_SCH_BPF_ENQUEUE_PROG_FD],
-			    tb[TCA_SCH_BPF_ENQUEUE_PROG_NAME], &q->enqueue_prog);
+			    tb[TCA_SCH_BPF_ENQUEUE_PROG_NAME], &q->enqueue_prog, false);
 	if (err)
 		goto failure;
 	err = bpf_init_prog(tb[TCA_SCH_BPF_DEQUEUE_PROG_FD],
-			    tb[TCA_SCH_BPF_DEQUEUE_PROG_NAME], &q->dequeue_prog);
+			    tb[TCA_SCH_BPF_DEQUEUE_PROG_NAME], &q->dequeue_prog, false);
+	if (err)
+		goto failure;
+	err = bpf_init_prog(tb[TCA_SCH_BPF_RESET_PROG_FD],
+			    tb[TCA_SCH_BPF_RESET_PROG_NAME], &q->reset_prog, true);
 failure:
 	sch_tree_unlock(sch);
 	return err;
@@ -360,7 +376,9 @@ static int sch_bpf_init(struct Qdisc *sch, struct nlattr *opt,
 static void sch_bpf_reset(struct Qdisc *sch)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct bpf_qdisc_ctx ctx = {};
 	struct sch_bpf_class *cl;
+	struct bpf_prog *reset;
 	unsigned int i;
 
 	for (i = 0; i < q->clhash.hashsize; i++) {
@@ -371,6 +389,9 @@ static void sch_bpf_reset(struct Qdisc *sch)
 	}
 
 	qdisc_watchdog_cancel(&q->watchdog);
+	reset = rcu_dereference(q->reset_prog.prog);
+	if (reset)
+		bpf_prog_run(reset, &ctx);
 }
 
 static void sch_bpf_destroy_class(struct Qdisc *sch, struct sch_bpf_class *cl)
@@ -398,6 +419,7 @@ static void sch_bpf_destroy(struct Qdisc *sch)
 	sch_tree_lock(sch);
 	bpf_cleanup_prog(&q->enqueue_prog);
 	bpf_cleanup_prog(&q->dequeue_prog);
+	bpf_cleanup_prog(&q->reset_prog);
 	sch_tree_unlock(sch);
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index df280bbb7c0d..84669886a493 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1059,6 +1059,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_QDISC_ENQUEUE,
 	BPF_QDISC_DEQUEUE,
+	BPF_QDISC_RESET,
 	__MAX_BPF_ATTACH_TYPE
 };
 
-- 
2.20.1


