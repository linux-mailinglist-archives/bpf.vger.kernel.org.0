Return-Path: <bpf+bounces-34974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B3F934537
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 02:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101341C20292
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172906D1C1;
	Thu, 18 Jul 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRFt/CGc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581987470;
	Thu, 18 Jul 2024 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260812; cv=none; b=XYGjYmOl/AKlmUup8OCXoB381x6zo5KnHCVVBw89LnDDvy68DqAZg1V4yS45pJSP2GDJ2OmUp81hEtsqIGfWlzFEFN2nZqui0hP8tu4YM71n05F6GfdiG64pUpvGfCNUx/rGk9WdmWiL9lBDdJL/T4e0sBwkn5hnw0KLfLsXBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260812; c=relaxed/simple;
	bh=g7CoBzV5q3GlMywEOaqKcMsi7NtnSRQL5UHbY3Rzh9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Il8Wc/j/8zZqPRUpDg/eIrVYlv543g0RvWvk/rUZ0kCquAcoTnQVybUmOjtEVuzozMTS0iefo4kasMGQMdOYAMAcT60quA8Lu96WuSKKi6NjSARvRN9jFiutP5GBrYXgIbXXA1hqRW5qwkIYigu/C1V6ix/Z4wT2SV3mV+avxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRFt/CGc; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d9c487b2b5so164083b6e.3;
        Wed, 17 Jul 2024 17:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721260808; x=1721865608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4S2bu6DRyTCPTcTYnmglTP6ydOdUkxVFPnzOfr04l4=;
        b=XRFt/CGcJpTTeuDHqckyv/DokGDJbyrIjj1juQ/hhXML5HPXR38nRTHZwjEhnFC6J+
         JblkqsVfC8528O3x9Qb325/1Bf1N8EtvinKHxHDalpvlsPtx9N2dM3MzldYFOkJ8/thC
         t4S3S0jZvAiQmUbvXJ4gqtYYfgYqJOEpttV8kAA9tgrK3vUdcMZskV9LqN6E8gyzSVup
         ocj0X/DxTVoqoQb7brNTQiNADK3ZU+divPL4QpHFhAr4q+0Ff7/S1koqQu+ECoCpyr2e
         zXb9KJf1stdpARXyaZMLOrYyEX4dBa+ETjBxsO5oVAn7XjUPS4VXUrabQ1AT2TWOHX6T
         u2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721260808; x=1721865608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4S2bu6DRyTCPTcTYnmglTP6ydOdUkxVFPnzOfr04l4=;
        b=sMXJpCJfGk6fE80nm1F3DZa64KSPSNZaVJEL1OD5EruxLa5CGTcravROSllIvX28Iw
         tmyqPRC+rbhNWNV+0NaAf0taHodEVDFg4yNEV8YYlQcuJgoH2F523ZZfcGf++mCBna8C
         g1syb/+qKru6w4mb9gLj+ZpWqbXQtVkFpe+yj2Rck/vaOoR+G6RnIepUxAZYxWYsxSwL
         2RAasB5P1qtDUnb0FPmKOhl4I1bwdajDaPvNqp1W/CX48f9kb1Gdz6297TIjQ+JP20M/
         xZnih2AsD6oJif+JY6Ps1teODrNbsZn90wzSgleAjvW0hHWhKKBcJlDmvV2Y0lwJRi0N
         nAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV5uLsEhkNFOFeTIWr5Ijx8hiUYDlW3XcX2iaNHMc+48zFDUhoXAXA+dTUS2Ov5/Bb6l1ZzsPC99eTYDjO0RqGDhDP4OemX1Ytx0w6UcHY4ixGty+9tApHjiT9
X-Gm-Message-State: AOJu0Yx7K1uQ/gVLv3UQLQthYOGK9gKFJfQlI7j+MqqqIGj06sXd0oQc
	fJFbijFCwfzWpiNBaJ1VflC/vzgkjbIX+BVDuNRDo2gKuRg7gVv7
X-Google-Smtp-Source: AGHT+IE3NBkhbq/9IzBIXH78vsSV394LNyXwhdBiqlXiwMDguHhZxlaIvcSo7qUpuqNMOyQAqjXwMw==
X-Received: by 2002:a05:6808:1908:b0:3d9:24b1:74ae with SMTP id 5614622812f47-3dad521dbcamr2883347b6e.23.1721260808250;
        Wed, 17 Jul 2024 17:00:08 -0700 (PDT)
Received: from n36-183-057.byted.org ([139.177.233.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbea20sm457507785a.34.2024.07.17.17.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 17:00:07 -0700 (PDT)
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
Subject: [RFC PATCH v9 05/11] bpf: net_sched: Support implementation of Qdisc_ops in bpf
Date: Thu, 18 Jul 2024 00:00:06 +0000
Message-Id: <20240718000006.2442464-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-6-amery.hung@bytedance.com>
References: <20240714175130.4051012-6-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <ameryhung@gmail.com>

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
 net/sched/Kconfig         |  14 ++
 net/sched/Makefile        |   1 +
 net/sched/bpf_qdisc.c     | 352 ++++++++++++++++++++++++++++++++++++++
 net/sched/sch_api.c       |   7 +-
 net/sched/sch_generic.c   |   3 +-
 8 files changed, 376 insertions(+), 5 deletions(-)
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
index b188f51c6ce9..2e3ded4de2ea 100644
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
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 8180d0c12fce..8bfe063a851d 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -403,6 +403,20 @@ config NET_SCH_ETS
 
 	  If unsure, say N.
 
+config NET_SCH_BPF
+	tristate "BPF-based Qdisc"
+	depends on BPF_SYSCALL && BPF_JIT && DEBUG_INFO_BTF
+	help
+	  This option allows queueing disipline to be implemented using BPF
+	  struct_ops.
+
+	  Say Y here if you want to use BPF-based packet Qdisc.
+
+	  To compile this code as a module, choose M here: the module
+	  will be called sch_bpf.
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


