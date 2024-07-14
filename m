Return-Path: <bpf+bounces-34783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC21930B16
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA482812DA
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6314036F;
	Sun, 14 Jul 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHtvwqvR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734E13CFBB;
	Sun, 14 Jul 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979497; cv=none; b=FzXHfTgX/FfIdGquj0bsl/GBHCYrtpCH2WxupGHJa65//GuAkGuRB3KyAbB7496d/+168x0iI4COdNfBwPybpk+ZXkSGAT1Dzwa7EN6NZecynyfWDmATotwtLTgOoqWbDk3VCGikUw1wxmsk6Ip8U1hSgWlccFPqEtPd0+yFtUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979497; c=relaxed/simple;
	bh=Foev1jrvQhcXwhYQQDsDvEwSA21epXIcx393T9Q42HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLKAsOgGtbOftA1e+qT8uTXoLWRR9xcvRwdP57e9C7HvnnGKsgEYYlULd/+tPEYnYEeF01l3yakGGNN5vl9pYeGovNrKOhJlrHnaOscs2ZsfLc8GZAqSGhOHQ3/VQGpuaIeKDcElPW+ILxA/jp9nQL06YT66WJuEayee121EGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHtvwqvR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44931f038f9so37784181cf.0;
        Sun, 14 Jul 2024 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979495; x=1721584295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1rlXeJD8f1Pr+M2ITregcBYcMVSqYFKhTS/oYcYvU0=;
        b=NHtvwqvRNQbTkDwBfg2rxSnQ5OBvg/L7SmUGxSMXBqJ7rZdYMxyu8NHyKytWAYqDve
         ZL9DlE4tF4ndDnXMmqNPbJ/C7BSr9gB61ePWuw8QiE8u17jBnon6qoO/5qd9vxd3v0MC
         5onNMUq6aNiELHLtVJdgPpEBaQTWGZsfxG6Dau2Giy3WF0LoL8Q0nHTKNKrH6Nm3m2Bu
         bqqoo0KkEtQj9TSA+5PpwjzIR6M9e7XhEaEW8eA3hswMI6lRL7AvMQg00SWOs8hip6Il
         gbm3z/36wvCtjJIACaL1Ak+q8CEfxPeCMl4qjXY8Z4YpyifPdmXUfgO5+H604rlUuAEl
         y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979495; x=1721584295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1rlXeJD8f1Pr+M2ITregcBYcMVSqYFKhTS/oYcYvU0=;
        b=mj4QSN9ajSIVBcx5nKcaWP4oLLSJk2Ei82A4gizeNxDrOZZukXLOJNbel5fbjQsgaF
         ErAGIwGqjPDLqbz20DWM2aQM8cECu3XudNEb/nl08R9cDdJJja/mvTskYsZIgPpCgsh8
         ZDLy5jD7iTFhhGA78loTgO+FB94al3XJlAJZNyFg69dSA9gNNgeqKbDBPazaskHqRYAo
         yeZScRtQCnJDwjDxu1cA5ZlFK/5mOR9avsaX7WUaj1+a0//Vt4LilA0v3fl+FnBlCBd4
         oV75Nl9ozoAcqDROSL1HoIOuYh3K8NR1cHWNseD5r5hRkOkHZ4BaRjqTWftlikyPSq/w
         hbWA==
X-Gm-Message-State: AOJu0Yz/qmN+nhB+D0KzXsHf/qugFDIh6qzrJ9RKvivwPUzfzYJ0E1VW
	15kIy33HOgX1b9SYaeFoI07baQZKpQtUE76uot73tfn9B5Q8wnMZsB19SQ==
X-Google-Smtp-Source: AGHT+IHXM+DELG95X1mc5oOVoDTd1no4Klwtl116YC4R9lzUA+dCY/mdwHvqNqorCWKlfxQITYSxXA==
X-Received: by 2002:ac8:5f84:0:b0:446:45eb:6af6 with SMTP id d75a77b69052e-44e5bc25674mr156462261cf.1.1720979494687;
        Sun, 14 Jul 2024 10:51:34 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:34 -0700 (PDT)
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
Subject: [RFC PATCH v9 05/11] bpf: net_sched: Support implementation of Qdisc_ops in bpf
Date: Sun, 14 Jul 2024 17:51:24 +0000
Message-Id: <20240714175130.4051012-6-amery.hung@bytedance.com>
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

Enable users to implement a classless qdisc using bpf. The last few
patches in this series has prepared struct_ops to support core operators
in Qdisc_ops. The recent advancement in bpf such as allocated
objects, bpf list and bpf rbtree has also provided powerful and flexible
building blocks to realize sophisticated scheduling algorithms. Therefore,
in this patch, we start allowing qdisc to be implemented using bpf
struct_ops. Users can implement .enqueue and .dequeue in Qdisc_ops in bpf
and register the qdisc dynamically into the kernel.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Co-developed-by: Amery Hung <amery.hung@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/btf.h       |   1 +
 include/net/sch_generic.h |   1 +
 kernel/bpf/btf.c          |   2 +-
 net/sched/Makefile        |   4 +
 net/sched/bpf_qdisc.c     | 352 ++++++++++++++++++++++++++++++++++++++
 net/sched/sch_api.c       |   7 +-
 net/sched/sch_generic.c   |   3 +-
 7 files changed, 365 insertions(+), 5 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c

diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..730ec304f787 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -562,6 +562,7 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
+u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
 			       const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 79edd5b5e3c9..214ed2e34faa 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -95,6 +95,7 @@ struct Qdisc {
 #define TCQ_F_INVISIBLE		0x80 /* invisible by default in dump */
 #define TCQ_F_NOLOCK		0x100 /* qdisc does not require locking */
 #define TCQ_F_OFFLOADED		0x200 /* qdisc is offloaded to HW */
+#define TCQ_F_BPF		0x400 /* BPF qdisc */
 	u32			limit;
 	const struct Qdisc_ops	*ops;
 	struct qdisc_size_table	__rcu *stab;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 52be35b30308..059bcc365f10 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6314,7 +6314,7 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	return btf_type_is_int(t);
 }
 
-static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
 			   int off)
 {
 	const struct btf_param *args;
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 82c3f78ca486..2094e6e74158 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -63,6 +63,10 @@ obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
 
+ifeq ($(CONFIG_BPF_JIT),y)
+obj-$(CONFIG_BPF_SYSCALL)	+= bpf_qdisc.o
+endif
+
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
 obj-$(CONFIG_NET_CLS_FW)	+= cls_fw.o
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
new file mode 100644
index 000000000000..a68fc115d8f8
--- /dev/null
+++ b/net/sched/bpf_qdisc.c
@@ -0,0 +1,352 @@
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
+static u32 unsupported_ops[] = {
+	offsetof(struct Qdisc_ops, init),
+	offsetof(struct Qdisc_ops, reset),
+	offsetof(struct Qdisc_ops, destroy),
+	offsetof(struct Qdisc_ops, change),
+	offsetof(struct Qdisc_ops, attach),
+	offsetof(struct Qdisc_ops, change_real_num_tx),
+	offsetof(struct Qdisc_ops, dump),
+	offsetof(struct Qdisc_ops, dump_stats),
+	offsetof(struct Qdisc_ops, ingress_block_set),
+	offsetof(struct Qdisc_ops, egress_block_set),
+	offsetof(struct Qdisc_ops, ingress_block_get),
+	offsetof(struct Qdisc_ops, egress_block_get),
+};
+
+struct bpf_sched_data {
+	struct qdisc_watchdog watchdog;
+};
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
+static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
+			     struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+	return 0;
+}
+
+static void bpf_qdisc_reset_op(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+
+static void bpf_qdisc_destroy_op(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+
+static const struct bpf_func_proto *
+bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
+			 const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	default:
+		return bpf_base_func_proto(func_id, prog);
+	}
+}
+
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
+	arg = get_ctx_arg_idx(btf, prog->aux->attach_func_proto, off);
+	if (!strcmp(prog->aux->attach_func_name, "enqueue")) {
+		if (arg == 2) {
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
+static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
+					const struct bpf_reg_state *reg,
+					int off, int size)
+{
+	const struct btf_type *t, *skbt;
+	size_t end;
+
+	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t != skbt) {
+		bpf_log(log, "only read is supported\n");
+		return -EACCES;
+	}
+
+	switch (off) {
+	case offsetof(struct sk_buff, tstamp):
+		end = offsetofend(struct sk_buff, tstamp);
+		break;
+	case offsetof(struct sk_buff, priority):
+		end = offsetofend(struct sk_buff, priority);
+		break;
+	case offsetof(struct sk_buff, mark):
+		end = offsetofend(struct sk_buff, mark);
+		break;
+	case offsetof(struct sk_buff, queue_mapping):
+		end = offsetofend(struct sk_buff, queue_mapping);
+		break;
+	case offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb, tc_classid):
+		end = offsetof(struct sk_buff, cb) +
+		      offsetofend(struct qdisc_skb_cb, tc_classid);
+		break;
+	case offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb, data[0]) ...
+	     offsetof(struct sk_buff, cb) + offsetof(struct qdisc_skb_cb,
+						     data[QDISC_CB_PRIV_LEN - 1]):
+		end = offsetof(struct sk_buff, cb) +
+		      offsetofend(struct qdisc_skb_cb, data[QDISC_CB_PRIV_LEN - 1]);
+		break;
+	case offsetof(struct sk_buff, tc_index):
+		end = offsetofend(struct sk_buff, tc_index);
+		break;
+	default:
+		bpf_log(log, "no write support to sk_buff at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log,
+			"write access at off %d with size %d beyond the member of sk_buff ended at %zu\n",
+			off, size, end);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+static const struct bpf_verifier_ops bpf_qdisc_verifier_ops = {
+	.get_func_proto		= bpf_qdisc_get_func_proto,
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
+	case offsetof(struct Qdisc_ops, priv_size):
+		if (uqdisc_ops->priv_size)
+			return -EINVAL;
+		qdisc_ops->priv_size = sizeof(struct bpf_sched_data);
+		return 1;
+	case offsetof(struct Qdisc_ops, static_flags):
+		if (uqdisc_ops->static_flags)
+			return -EINVAL;
+		qdisc_ops->static_flags = TCQ_F_BPF;
+		return 1;
+	case offsetof(struct Qdisc_ops, init):
+		qdisc_ops->init = bpf_qdisc_init_op;
+		return 1;
+	case offsetof(struct Qdisc_ops, reset):
+		qdisc_ops->reset = bpf_qdisc_reset_op;
+		return 1;
+	case offsetof(struct Qdisc_ops, destroy):
+		qdisc_ops->destroy = bpf_qdisc_destroy_op;
+		return 1;
+	case offsetof(struct Qdisc_ops, peek):
+		if (!uqdisc_ops->peek)
+			qdisc_ops->peek = qdisc_peek_dequeued;
+		return 1;
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
+static bool is_unsupported(u32 member_offset)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(unsupported_ops); i++) {
+		if (member_offset == unsupported_ops[i])
+			return true;
+	}
+
+	return false;
+}
+
+static int bpf_qdisc_check_member(const struct btf_type *t,
+				  const struct btf_member *member,
+				  const struct bpf_prog *prog)
+{
+	if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
+		return -ENOTSUPP;
+	return 0;
+}
+
+static int bpf_qdisc_validate(void *kdata)
+{
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
+			       struct sk_buff **to_free)
+{
+	return 0;
+}
+
+static struct sk_buff *Qdisc_ops__dequeue(struct Qdisc *sch)
+{
+	return NULL;
+}
+
+static struct sk_buff *Qdisc_ops__peek(struct Qdisc *sch)
+{
+	return NULL;
+}
+
+static int Qdisc_ops__init(struct Qdisc *sch, struct nlattr *arg,
+			    struct netlink_ext_ack *extack)
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
+static int Qdisc_ops__change(struct Qdisc *sch, struct nlattr *arg,
+			      struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static void Qdisc_ops__attach(struct Qdisc *sch)
+{
+}
+
+static int Qdisc_ops__change_tx_queue_len(struct Qdisc *sch, unsigned int new_len)
+{
+	return 0;
+}
+
+static void Qdisc_ops__change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
+{
+}
+
+static int Qdisc_ops__dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static int Qdisc_ops__dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	return 0;
+}
+
+static void Qdisc_ops__ingress_block_set(struct Qdisc *sch, u32 block_index)
+{
+}
+
+static void Qdisc_ops__egress_block_set(struct Qdisc *sch, u32 block_index)
+{
+}
+
+static u32 Qdisc_ops__ingress_block_get(struct Qdisc *sch)
+{
+	return 0;
+}
+
+static u32 Qdisc_ops__egress_block_get(struct Qdisc *sch)
+{
+	return 0;
+}
+
+static struct Qdisc_ops __bpf_ops_qdisc_ops = {
+	.enqueue = Qdisc_ops__enqueue,
+	.dequeue = Qdisc_ops__dequeue,
+	.peek = Qdisc_ops__peek,
+	.init = Qdisc_ops__init,
+	.reset = Qdisc_ops__reset,
+	.destroy = Qdisc_ops__destroy,
+	.change = Qdisc_ops__change,
+	.attach = Qdisc_ops__attach,
+	.change_tx_queue_len = Qdisc_ops__change_tx_queue_len,
+	.change_real_num_tx = Qdisc_ops__change_real_num_tx,
+	.dump = Qdisc_ops__dump,
+	.dump_stats = Qdisc_ops__dump_stats,
+	.ingress_block_set = Qdisc_ops__ingress_block_set,
+	.egress_block_set = Qdisc_ops__egress_block_set,
+	.ingress_block_get = Qdisc_ops__ingress_block_get,
+	.egress_block_get = Qdisc_ops__egress_block_get,
+};
+
+static struct bpf_struct_ops bpf_Qdisc_ops = {
+	.verifier_ops = &bpf_qdisc_verifier_ops,
+	.reg = bpf_qdisc_reg,
+	.unreg = bpf_qdisc_unreg,
+	.check_member = bpf_qdisc_check_member,
+	.init_member = bpf_qdisc_init_member,
+	.init = bpf_qdisc_init,
+	.validate = bpf_qdisc_validate,
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
index 74afc210527d..5064b6d2d1ec 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -25,6 +25,7 @@
 #include <linux/hrtimer.h>
 #include <linux/slab.h>
 #include <linux/hashtable.h>
+#include <linux/bpf.h>
 
 #include <net/net_namespace.h>
 #include <net/sock.h>
@@ -358,7 +359,7 @@ static struct Qdisc_ops *qdisc_lookup_ops(struct nlattr *kind)
 		read_lock(&qdisc_mod_lock);
 		for (q = qdisc_base; q; q = q->next) {
 			if (nla_strcmp(kind, q->id) == 0) {
-				if (!try_module_get(q->owner))
+				if (!bpf_try_module_get(q, q->owner))
 					q = NULL;
 				break;
 			}
@@ -1282,7 +1283,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 				/* We will try again qdisc_lookup_ops,
 				 * so don't keep a reference.
 				 */
-				module_put(ops->owner);
+				bpf_module_put(ops, ops->owner);
 				err = -EAGAIN;
 				goto err_out;
 			}
@@ -1393,7 +1394,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
 err_out2:
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 err_out:
 	*errp = err;
 	return NULL;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 2af24547a82c..76e4a6efd17c 100644
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
@@ -1077,7 +1078,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 		ops->destroy(qdisc);
 
 	lockdep_unregister_key(&qdisc->root_lock_key);
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
 
 	trace_qdisc_destroy(qdisc);
-- 
2.20.1


