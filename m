Return-Path: <bpf+bounces-55589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC22A83399
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 23:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADC91B639A9
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7265521A92F;
	Wed,  9 Apr 2025 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlHj6kiO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45156216E05;
	Wed,  9 Apr 2025 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235174; cv=none; b=RVkuM3dcpQ+NydZK3NhPRCK8Js6qE+LX98WHbPN5wOiEfPy5C2MyGV+tDe8lUTDAhlejKYKz4N3R1siZrhP5dze0bPUeMovbaBmI1v7zElSy+LfMsvwyPrwKwnsoAg47ZiGbxeKllYCMrz116Ro3NqadJUM2bPJqRAhf6w4BC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235174; c=relaxed/simple;
	bh=hqkMtaM6h0BEAvJjRYSvCiTD50IQx6rMQ8IEJmqUUR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvr/A2gXJXKPlTuz714UFhESNoARViLP7GWw/q4ZKi/lpSKQU3Ev2aF6cLyIBcDpOX++iV/xBtHf1ayxGXzZEXKbx88pYv3WGxlOZiwYIiBRwtMzv4wE3LmDpUTto/FaGAvp9xthZdDL3aGpOvm4ft5rMWZVELzLy5yqmTTCppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlHj6kiO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224171d6826so1699345ad.3;
        Wed, 09 Apr 2025 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744235170; x=1744839970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3DXsd6gOC/HwBOK+s2nx2AZPlMfXFsGffOmKDvBQL0=;
        b=GlHj6kiO5zDX04OI5R/Z+I+IuMgcSoEqR2ViJiVB9Qd8fGKVDUoUi7fELZSNRojPy4
         ffey3Q1G/u4twFPpQtRmHkTWjMIeBkhMgkt/i1VT0Bhm3GAasoVP3rsDjjPLlg4pio2W
         sOPpDeeDLGnfBv1cJCrHx6nUbT1RMRaGXNlcbGmFWymSRv8OuhLVKXDJCMQ+3B79W5MW
         Rs8ZaxuI4J4gDXZrJ5Q2Vt9i2zPFzmHSFEmbap2fiDlaRPB++DxsbtvlpWj5XvnRRlzP
         ZF6ulNqayJ1iP386+xNXFBVd+Se2E1J7D60pI05PqmJSzXKzm+7yE6twP0pSQdN+RYws
         X2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235170; x=1744839970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3DXsd6gOC/HwBOK+s2nx2AZPlMfXFsGffOmKDvBQL0=;
        b=fC++SxeSuHtr5s2bsYKBPiX2AnlqWGN5yybSfLYVrZrIfGHGZU2bwiTl9naDgzkh6R
         C/lwY1D/4sUmPVDTZv3o59P63XFGvDOPFRSBe/yLFiac7ime3Sc+RgUk0iLRja4Dt/QW
         2jB6YpBVZ4Nd8/7Rk0CS7lt8f4yNpWxI7LQek+hZ0JvaBp8lah9YPNercvaWeU0Kaglj
         hQTkN7u0E5QX/do3lH6Xsnk6SxBM0HezV3Fc3kOBHHTf/AcLMmO4dNqBT0jKH7w32eZf
         0S0f5ryGh/bn/Cbn8eoaCl31APU2GBvbukAPdOYNhD+/IzwbY3SW/DJ9ioY4xismj7/O
         N9IA==
X-Gm-Message-State: AOJu0YwHw9ag3BVt5/56urOnaKKUd/ePpyv7lqcz7ZKkS9FJWJKN3LpD
	acLe+O0r0JoZ2xdyW7EGDnnF2ocT+7ZHKQxzAW8UXpMYEVjhstQ9SxgfAm8n
X-Gm-Gg: ASbGncsOb1IyCtI9dyS/+9DeBz3Yf+b49r5JjWqqAhe1K60cDsIa54zcIWTyrOdQo/o
	TZo/B/LEDHNInSPVt8URkeULynDwY4AdVx+EjfUPSyR/xpFTW4KfPAvMUHsIFj0FAVjzbN6nHWm
	Cm1JdKLWY9c3ZZaGJbqNHgUYtXbk1hFN5cusWf62cC+dckURAtEFh27wu4izkxideEufN1xAjkb
	qEeOdN/dEpJuRJiZ/52Ci/SoGDN9kbt3KLsavYzX7UtLHQ/cOHOzlJVKxxksz0hyBSiJcnaYK7r
	OmuV2whZ18ChYjDmvZQQxZVfKizYR08=
X-Google-Smtp-Source: AGHT+IF8sPXXIj6z2HIu8UZc8/tfM1pYPZCne8zTao/prRBRzsAqY5EqUy60SFIRP7rNshAYSy8yCw==
X-Received: by 2002:a17:902:cccc:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22b2eded32emr9194935ad.28.1744235170160;
        Wed, 09 Apr 2025 14:46:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b029sm17243245ad.80.2025.04.09.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 14:46:09 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	kuba@kernel.org,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	martin.lau@kernel.org,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	toke@redhat.com,
	sinquersw@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 02/10] bpf: net_sched: Support implementation of Qdisc_ops in bpf
Date: Wed,  9 Apr 2025 14:45:58 -0700
Message-ID: <20250409214606.2000194-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250409214606.2000194-1-ameryhung@gmail.com>
References: <20250409214606.2000194-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

The recent advancement in bpf such as allocated objects, bpf list and bpf
rbtree has provided powerful and flexible building blocks to realize
sophisticated packet scheduling algorithms. As struct_ops now supports
core operators in Qdisc_ops, start allowing qdisc to be implemented using
bpf struct_ops with this patch. Users can implement Qdisc_ops.{enqueue,
dequeue, init, reset, destroy} in bpf and register the qdisc dynamically
into the kernel.

Co-developed-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/Kconfig       |  12 +++
 net/sched/Makefile      |   1 +
 net/sched/bpf_qdisc.c   | 232 ++++++++++++++++++++++++++++++++++++++++
 net/sched/sch_api.c     |   7 +-
 net/sched/sch_generic.c |   3 +-
 5 files changed, 251 insertions(+), 4 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c

diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 8180d0c12fce..ccd0255da5a5 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -403,6 +403,18 @@ config NET_SCH_ETS
 
 	  If unsure, say N.
 
+config NET_SCH_BPF
+	bool "BPF-based Qdisc"
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	help
+	  This option allows BPF-based queueing disiplines. With BPF struct_ops,
+	  users can implement supported operators in Qdisc_ops using BPF programs.
+	  The queue holding skb can be built with BPF maps or graphs.
+
+	  Say Y here if you want to use BPF-based Qdisc.
+
+	  If unsure, say N.
+
 menuconfig NET_SCH_DEFAULT
 	bool "Allow override default queue discipline"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 82c3f78ca486..904d784902d1 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_NET_SCH_FQ_PIE)	+= sch_fq_pie.o
 obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
+obj-$(CONFIG_NET_SCH_BPF)	+= bpf_qdisc.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
new file mode 100644
index 000000000000..7eca556a3782
--- /dev/null
+++ b/net/sched/bpf_qdisc.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/filter.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
+
+static struct bpf_struct_ops bpf_Qdisc_ops;
+
+struct bpf_sk_buff_ptr {
+	struct sk_buff *skb;
+};
+
+static int bpf_qdisc_init(struct btf *btf)
+{
+	return 0;
+}
+
+BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
+
+static bool bpf_qdisc_is_valid_access(int off, int size,
+				      enum bpf_access_type type,
+				      const struct bpf_prog *prog,
+				      struct bpf_insn_access_aux *info)
+{
+	struct btf *btf = prog->aux->attach_btf;
+	u32 arg;
+
+	arg = btf_ctx_arg_idx(btf, prog->aux->attach_func_proto, off);
+	if (prog->aux->attach_st_ops_member_off == offsetof(struct Qdisc_ops, enqueue)) {
+		if (arg == 2 && type == BPF_READ) {
+			info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
+			info->btf = btf;
+			info->btf_id = bpf_sk_buff_ptr_ids[0];
+			return true;
+		}
+	}
+
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
+				  const struct bpf_reg_state *reg,
+				  int off, size_t *end)
+{
+	switch (off) {
+	case offsetof(struct Qdisc, limit):
+		*end = offsetofend(struct Qdisc, limit);
+		break;
+	case offsetof(struct Qdisc, q) + offsetof(struct qdisc_skb_head, qlen):
+		*end = offsetof(struct Qdisc, q) + offsetofend(struct qdisc_skb_head, qlen);
+		break;
+	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
+		*end = offsetofend(struct Qdisc, qstats);
+		break;
+	default:
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+static int bpf_qdisc_sk_buff_access(struct bpf_verifier_log *log,
+				    const struct bpf_reg_state *reg,
+				    int off, size_t *end)
+{
+	switch (off) {
+	case offsetof(struct sk_buff, tstamp):
+		*end = offsetofend(struct sk_buff, tstamp);
+		break;
+	case offsetof(struct sk_buff, priority):
+		*end = offsetofend(struct sk_buff, priority);
+		break;
+	case offsetof(struct sk_buff, mark):
+		*end = offsetofend(struct sk_buff, mark);
+		break;
+	case offsetof(struct sk_buff, queue_mapping):
+		*end = offsetofend(struct sk_buff, queue_mapping);
+		break;
+	case offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb, tc_classid):
+		*end = offsetof(struct sk_buff, cb) +
+		       offsetofend(struct qdisc_skb_cb, tc_classid);
+		break;
+	case offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb, data[0]) ...
+	     offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb,
+						     data[QDISC_CB_PRIV_LEN - 1]):
+		*end = offsetof(struct sk_buff, cb) +
+		       offsetofend(struct qdisc_skb_cb, data[QDISC_CB_PRIV_LEN - 1]);
+		break;
+	case offsetof(struct sk_buff, tc_index):
+		*end = offsetofend(struct sk_buff, tc_index);
+		break;
+	default:
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
+				       const struct bpf_reg_state *reg,
+				       int off, int size)
+{
+	const struct btf_type *t, *skbt, *qdisct;
+	size_t end;
+	int err;
+
+	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
+	qdisct = btf_type_by_id(reg->btf, bpf_qdisc_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+
+	if (t == skbt) {
+		err = bpf_qdisc_sk_buff_access(log, reg, off, &end);
+	} else if (t == qdisct) {
+		err = bpf_qdisc_qdisc_access(log, reg, off, &end);
+	} else {
+		bpf_log(log, "only read is supported\n");
+		return -EACCES;
+	}
+
+	if (err) {
+		bpf_log(log, "no write support to %s at off %d\n",
+			btf_name_by_offset(reg->btf, t->name_off), off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log,
+			"write access at off %d with size %d beyond the member of %s ended at %zu\n",
+			off, size, btf_name_by_offset(reg->btf, t->name_off), end);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
+	.get_func_proto		= bpf_base_func_proto,
+	.is_valid_access	= bpf_qdisc_is_valid_access,
+	.btf_struct_access	= bpf_qdisc_btf_struct_access,
+};
+
+static int bpf_qdisc_init_member(const struct btf_type *t,
+				 const struct btf_member *member,
+				 void *kdata, const void *udata)
+{
+	const struct Qdisc_ops *uqdisc_ops;
+	struct Qdisc_ops *qdisc_ops;
+	u32 moff;
+
+	uqdisc_ops = (const struct Qdisc_ops *)udata;
+	qdisc_ops = (struct Qdisc_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+	switch (moff) {
+	case offsetof(struct Qdisc_ops, peek):
+		qdisc_ops->peek = qdisc_peek_dequeued;
+		return 0;
+	case offsetof(struct Qdisc_ops, id):
+		if (bpf_obj_name_cpy(qdisc_ops->id, uqdisc_ops->id,
+				     sizeof(qdisc_ops->id)) <= 0)
+			return -EINVAL;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int bpf_qdisc_reg(void *kdata, struct bpf_link *link)
+{
+	return register_qdisc(kdata);
+}
+
+static void bpf_qdisc_unreg(void *kdata, struct bpf_link *link)
+{
+	return unregister_qdisc(kdata);
+}
+
+static int Qdisc_ops__enqueue(struct sk_buff *skb__ref, struct Qdisc *sch,
+			      struct sk_buff **to_free)
+{
+	return 0;
+}
+
+static struct sk_buff *Qdisc_ops__dequeue(struct Qdisc *sch)
+{
+	return NULL;
+}
+
+static int Qdisc_ops__init(struct Qdisc *sch, struct nlattr *arg,
+			   struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void Qdisc_ops__reset(struct Qdisc *sch)
+{
+}
+
+static void Qdisc_ops__destroy(struct Qdisc *sch)
+{
+}
+
+static struct Qdisc_ops __bpf_ops_qdisc_ops = {
+	.enqueue = Qdisc_ops__enqueue,
+	.dequeue = Qdisc_ops__dequeue,
+	.init = Qdisc_ops__init,
+	.reset = Qdisc_ops__reset,
+	.destroy = Qdisc_ops__destroy,
+};
+
+static struct bpf_struct_ops bpf_Qdisc_ops = {
+	.verifier_ops = &bpf_qdisc_verifier_ops,
+	.reg = bpf_qdisc_reg,
+	.unreg = bpf_qdisc_unreg,
+	.init_member = bpf_qdisc_init_member,
+	.init = bpf_qdisc_init,
+	.name = "Qdisc_ops",
+	.cfi_stubs = &__bpf_ops_qdisc_ops,
+	.owner = THIS_MODULE,
+};
+
+static int __init bpf_qdisc_kfunc_init(void)
+{
+	return register_bpf_struct_ops(&bpf_Qdisc_ops, Qdisc_ops);
+}
+late_initcall(bpf_qdisc_kfunc_init);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f74a097f54ae..db6330258dda 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -25,6 +25,7 @@
 #include <linux/hrtimer.h>
 #include <linux/slab.h>
 #include <linux/hashtable.h>
+#include <linux/bpf.h>
 
 #include <net/netdev_lock.h>
 #include <net/net_namespace.h>
@@ -359,7 +360,7 @@ static struct Qdisc_ops *qdisc_lookup_ops(struct nlattr *kind)
 		read_lock(&qdisc_mod_lock);
 		for (q = qdisc_base; q; q = q->next) {
 			if (nla_strcmp(kind, q->id) == 0) {
-				if (!try_module_get(q->owner))
+				if (!bpf_try_module_get(q, q->owner))
 					q = NULL;
 				break;
 			}
@@ -1370,7 +1371,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
 err_out2:
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 err_out:
 	*errp = err;
 	return NULL;
@@ -1782,7 +1783,7 @@ static void request_qdisc_module(struct nlattr *kind)
 
 	ops = qdisc_lookup_ops(kind);
 	if (ops) {
-		module_put(ops->owner);
+		bpf_module_put(ops, ops->owner);
 		return;
 	}
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 14ab2f4c190a..e6fda9f20272 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -24,6 +24,7 @@
 #include <linux/if_vlan.h>
 #include <linux/skb_array.h>
 #include <linux/if_macvlan.h>
+#include <linux/bpf.h>
 #include <net/sch_generic.h>
 #include <net/pkt_sched.h>
 #include <net/dst.h>
@@ -1078,7 +1079,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 		ops->destroy(qdisc);
 
 	lockdep_unregister_key(&qdisc->root_lock_key);
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
 
 	trace_qdisc_destroy(qdisc);
-- 
2.47.1


