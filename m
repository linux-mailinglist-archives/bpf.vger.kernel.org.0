Return-Path: <bpf+bounces-46950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964D09F1A02
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D670B16B548
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011701F37C9;
	Fri, 13 Dec 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="G13//gGd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7E1F1311
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132610; cv=none; b=LGD0wOHK08XQEX+j8DXtaK12rmbhnj9tvp9Kdlwv139nzVnLElgGnt/HiOL8Kxw5h8MrJp9w13F4V22LQACN4oCI+HWx5dOZ6tfCD3B/K1Jd1MM/qKqeAFzfSL5gi5nPNWpfVnpCXNysVUOJ72ZT3cIZWPQRhHlIie20QV/ByhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132610; c=relaxed/simple;
	bh=dC8bLrw9k9YKRvGZ6gL0NtXUDBM94pcw3MkYOmD6ngs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muqLPohxMu6aejJv9v59mcVSckrsi+Sezhf6ZBozSK9FnJyTlxQwso04SwM4AE4O3stdn6lr+u4nBUbjijboNc/SH8DsSmelLP9Z4CBgmkystZrslXVTD1ASC5W6f0vQdQQB/oGrJ88hF4kbpp4ucoKh45onP8Lme+cwciWG3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=G13//gGd; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b6e9317a2aso292829285a.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132607; x=1734737407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9bC+OM/CF5dwJDo+XVgC5pDUNUdCrhJE2NWGRn108Q=;
        b=G13//gGdh2KlIpkqUDm0ghf+nOwpcev9gYYS9lo7lzjxa0H/CYj0gmGVl/DCZ5PhJn
         71yTj+wYBSN14XATXmRtN8E934dAZ3UUOWWUis4WqOvviySmMXo9SRVHIYAKK4ChUmcV
         gGCkEjcLheEDxsdeuDp17bB8/5ti3tMsgIqCNEk773bO5xyrCqJ9AHIfMGaX60IdX+Yh
         ajRn5avKystws+FmcUQbQvEaM5vr6q7EImYEOJc1ZEBPypc0TVgdfIxlb7svk/dh+R90
         K5eevR+Ps05CzZI6jK5+mnIt4qw6EvMei7I6AIsaOSENlj/1sZBEB3/511gb2pJ25mN7
         H46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132607; x=1734737407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9bC+OM/CF5dwJDo+XVgC5pDUNUdCrhJE2NWGRn108Q=;
        b=rB0+Rlrn6824UsdC9JJOQuEbeMBka7KYF12O2sdPAWed+xmvgxW5qeKXq1U8Qzlm87
         1VMnw9veEWIq9d0DeAx24j5m5HV15zC/hSqSpHqA04JikC9Ty8pUerJOPnJ3cRh1X0oh
         TxqWcanziidf9yoiGQCUA7LCmfLxU42GIkkmA2rag6PH6uXNwPsDlYLJDROjELxXdBV4
         TCuoyhrVBmrifhWw0FiYyc7KruV4ZZ89kuVdDV2whYXbEyUtrzGIl9jxCtP3Us6tMg4F
         4Yx8NkFe91JiISZXB3abuaX70y4dydADOkClIrdjU6774baYmgRVys+4ODyKQ2nlaZry
         htfg==
X-Gm-Message-State: AOJu0YwHpq0WjfcUzQJ8d5zjtnmxc1RLz3CQGZ575ek177C9VrjkVdhi
	JIz6pLCPRQGVoMDNbqQRGpiYEh+bP8zXiwGb0nQ5jdEQcXiLlDEmx/IP8cteIF0=
X-Gm-Gg: ASbGncuWNa/mqPrYB57vTP0JHPLP/6AcecK1NRC61h62j3QlkQcaJaEQdpY44RfR+Nb
	aYRjiijq1IAZTRNZ2lOZv9ob6eGZZkRxqEECzpAH7bWWngxWXcdr71q9RuaiPQpLCcpqLa24KWx
	AWaIZSMmb97TBG/s3DRKrsAHAfP0eeUeJOI9Ms1YRKpJrZkIMIldZgl1N81CCmPQK5EO7bnR/tJ
	CwszCIIy5/2ps6zhiZvmkM0tzPnrEtQ+WOeNpP7WVGwPBDS170RDHzIXwYiKviLfFBptS26D2gz
X-Google-Smtp-Source: AGHT+IGS9m2Jt7ZKxO8JJ/t+fYxdTLR9gL7HoAeBsmNZDHMBmrDWWqByd0SPRMfuHs+MymFwZ0CU1g==
X-Received: by 2002:a05:620a:2690:b0:7b6:ea67:72d0 with SMTP id af79cd13be357-7b6fbee68c5mr878370485a.4.1734132606738;
        Fri, 13 Dec 2024 15:30:06 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:05 -0800 (PST)
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
Subject: [PATCH bpf-next v1 05/13] bpf: net_sched: Support implementation of Qdisc_ops in bpf
Date: Fri, 13 Dec 2024 23:29:50 +0000
Message-Id: <20241213232958.2388301-6-amery.hung@bytedance.com>
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

Enable users to implement a classless qdisc using bpf. The last few
patches in this series has prepared struct_ops to support core operators
in Qdisc_ops. The recent advancement in bpf such as allocated
objects, bpf list and bpf rbtree has also provided powerful and flexible
building blocks to realize sophisticated scheduling algorithms. Therefore,
in this patch, we start allowing qdisc to be implemented using bpf
struct_ops. Users can implement Qdisc_ops.{enqueue, dequeue, init, reset,
and .destroy in Qdisc_ops in bpf and register the qdisc dynamically into
the kernel.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Co-developed-by: Amery Hung <amery.hung@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/btf.h     |   1 +
 kernel/bpf/btf.c        |   4 +-
 net/sched/Kconfig       |  12 +++
 net/sched/Makefile      |   1 +
 net/sched/bpf_qdisc.c   | 214 ++++++++++++++++++++++++++++++++++++++++
 net/sched/sch_api.c     |   7 +-
 net/sched/sch_generic.c |   3 +-
 7 files changed, 236 insertions(+), 6 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 4214e76c9168..eb16218fdf52 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -563,6 +563,7 @@ const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
+u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
 			       const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a05ccf9ee032..f733dbf24261 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6375,8 +6375,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	return btf_type_is_int(t);
 }
 
-static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+		    int off)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
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
index 000000000000..a2e2db29e5fc
--- /dev/null
+++ b/net/sched/bpf_qdisc.c
@@ -0,0 +1,214 @@
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
+		return 1;
+	case offsetof(struct Qdisc_ops, static_flags):
+		if (uqdisc_ops->static_flags)
+			return -EINVAL;
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
+static struct sk_buff *Qdisc_ops__peek(struct Qdisc *sch)
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
+	.peek = Qdisc_ops__peek,
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
index 2eefa4783879..f074053c4232 100644
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
@@ -1287,7 +1288,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 				/* We will try again qdisc_lookup_ops,
 				 * so don't keep a reference.
 				 */
-				module_put(ops->owner);
+				bpf_module_put(ops, ops->owner);
 				err = -EAGAIN;
 				goto err_out;
 			}
@@ -1398,7 +1399,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
 err_out2:
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 err_out:
 	*errp = err;
 	return NULL;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 38ec18f73de4..1e770ec251a0 100644
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
@@ -1083,7 +1084,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 		ops->destroy(qdisc);
 
 	lockdep_unregister_key(&qdisc->root_lock_key);
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
 
 	trace_qdisc_destroy(qdisc);
-- 
2.20.1


