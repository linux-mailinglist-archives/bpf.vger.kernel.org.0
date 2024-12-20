Return-Path: <bpf+bounces-47473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35DB9F9AD1
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9C87A499F
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD6227585;
	Fri, 20 Dec 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWPa9i+Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B9222565;
	Fri, 20 Dec 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724596; cv=none; b=ORQ9w9YlIKdB+TsCHRD9ocJ3318fiheTAM35HcgnB5rGunJTojsa/NB8GearXrskgyrUXbUpnccDqRZ9MGdEW68tM9gk4WelPA2NkD8P/BOWfg9OVObzCU6qg34kCndpnvhZ5tdD+boF9BlaNqANJ6ISxbrP8/j/PXA/anvD0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724596; c=relaxed/simple;
	bh=Dgs9P/JLEy2ZTvn1E7VqQyDuZMHik+0vWvpBnlOarJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klvj37iXLjdcaFJQEUBmUe+Rqsjy7rHM16PPGlhLQWvSKd/E4QGTaR8kXH/vvJCinp3wb4945RSS9zUXHhlhDlHlkz7DKVl71x/aHf5tvSgMyg/ltjIyJo6i3DgydJiUlfAs3Lq4PkNzFNnhIXgRBvLe9KpVAyGTx4pPdrMPUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWPa9i+Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-725d9f57d90so1805482b3a.1;
        Fri, 20 Dec 2024 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724593; x=1735329393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzEMwE7P5SeUCPP2ZtV5l+tofBVvoh8yKJDgFDQD9Uk=;
        b=mWPa9i+YCbRdLjxWd1mGZ/8CBpjGqN35y+QdpTDQipa58db+vDrz6zm73QyUh7x8AY
         xhxNF1K8odTu6Wo9ba0ScMubr7vzv9iF03NMizsFMXTeq0cEOqsDlOmyyf7FWheSp7mW
         gYjucx1frU1pKm+NtAr7+/BA0A7iOQ00BwVNOh5oUi/SRuuyUPnYx/f2IQuvteidPbUs
         8Cd2+dwJFlFqvP0YI+qeF7ogCwzOl3MG/v6OtjEuAfmvbMVqjWeEB1NiqQZFvd1jSd3o
         El6aJdf4xK0YHYJKjMSukAxFP+derXrLD16+HagZKkiusgRzjHIY5edQTMzafja2Ena4
         RMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724593; x=1735329393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzEMwE7P5SeUCPP2ZtV5l+tofBVvoh8yKJDgFDQD9Uk=;
        b=d1FsaRFtOsnzZL5HdU7skQrcP3L0lw4xMVRFbzEXB77rDCfkXQCv31OCN/8YMob89p
         VceLUemDlOuQ0SMwumQ0a4ujtVDw5J2r4abOmF9R4Giu3S64w/e31uW1OK/klFoqI0Fj
         a0svnxaPYkNaiMefBGkcABlxXrLF7Xszt7xp27rHe6fTKKoUulRt1/TB9yoReyzXx0rL
         BJoJDSHBD/95NlHt2rcb3DOiEP8PqvrKC41cxqD4qHwqd2plKANwrsIfcBP55xaaKP0c
         bEhov7yBNyxUpJxqCoEpF5MZRZz8Y/Xjm5wCawV8ao0sikjEFzRL3KZhv6Vr3tqaPPp4
         WTlQ==
X-Gm-Message-State: AOJu0YwPRyLdQMeq8tdUdB5WWL1VygCRbB3jz/eDuOf6+vEA02SysGzc
	Q66ETEITlWqnS4QeCQMt7D5knlaSAzTtD8HKDqVctF5GaB+mYT7Tyc+srQ==
X-Gm-Gg: ASbGncuLG3/ManyZeM51V8PSdxWZTTGJyfSIqbsfIdWdfqv56unqRV2VLhlpUyKS9w1
	ox+l6IUOduAGlYc5R90MTC6NmjNRFlWTf8Dv2Y/bh6Tn6r6jcmnn5mzqOYfmcLlFEr0kuKzznvr
	w7wCItqQ9Dq+Zkt0bC3zkDqkC+8o8cV14QKNyBpjGE5nO9TvkNi4e3fwdYOxGLMRV5Is2ydVoeK
	zZGqLxYIvTi5pGqBoLXlXK2nTF0sLgTp4awYL5j4RRmgbouoYpUlMyCukoLEwSnXzeVPskW38E1
	Fl58QT8nJvl3X8jcEchGRM1gn2wEU/Qq
X-Google-Smtp-Source: AGHT+IGNdVB0KABJWJyGlmIKg8EjwPpnwfm7M8AyxbjJXEO6QjkHDLYIb4wFLWxzSsE0WKqnPVQ9ng==
X-Received: by 2002:a05:6a21:6da3:b0:1e1:a68b:104a with SMTP id adf61e73a8af0-1e5e083f026mr6224476637.42.1734724593460;
        Fri, 20 Dec 2024 11:56:33 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:33 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
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
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 05/14] bpf: net_sched: Support implementation of Qdisc_ops in bpf
Date: Fri, 20 Dec 2024 11:55:31 -0800
Message-ID: <20241220195619.2022866-6-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Enable users to implement a classless qdisc using bpf. The last few
patches in this series has prepared struct_ops to support core operators
in Qdisc_ops. The recent advancement in bpf such as allocated
objects, bpf list and bpf rbtree has also provided powerful and flexible
building blocks to realize sophisticated scheduling algorithms. Therefore,
in this patch, we start allowing qdisc to be implemented using bpf
struct_ops. Users can implement Qdisc_ops.{enqueue, dequeue, init, reset,
and .destroy in Qdisc_ops in bpf and register the qdisc dynamically into
the kernel.

Co-developed-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/btf.h     |   1 +
 kernel/bpf/btf.c        |   4 +-
 net/sched/Kconfig       |  12 +++
 net/sched/Makefile      |   1 +
 net/sched/bpf_qdisc.c   | 207 ++++++++++++++++++++++++++++++++++++++++
 net/sched/sch_api.c     |   7 +-
 net/sched/sch_generic.c |   3 +-
 7 files changed, 229 insertions(+), 6 deletions(-)
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
index c2f4f84e539d..78476cebefe3 100644
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
index 000000000000..4b7d013f4f5c
--- /dev/null
+++ b/net/sched/bpf_qdisc.c
@@ -0,0 +1,207 @@
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
+	case BPF_FUNC_tail_call:
+		return NULL;
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
index 300430b8c4d2..b35c73c82342 100644
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
2.47.0


