Return-Path: <bpf+bounces-51015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4103A2F58F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D273A7BF6
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028222580D9;
	Mon, 10 Feb 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iev65ItV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53982580CF;
	Mon, 10 Feb 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209439; cv=none; b=EnvHhnt6f+X9IVFBb3OoidZrMZIdeykHiOj49BwV3iyp6qLTWEExfG2fp5OvS1FkVh4hoGLfM47gOZBrgpoU5fy1zc53cdjK9yo9I6zdFlPjOgiiP+bxqQXrUGeft+eW/6vgKdFTfkqtQNA2Otdt5AQBxHq68o5L9/yiw//NvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209439; c=relaxed/simple;
	bh=2/6mk8qHHpw2vFoIGo7pjNp/7fBVtYsbm2C3K0CJyEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAil4BWgnYm2K5evykrTw7vDk0kFWZSbTa6nvSN8l8ig0SID59mW+FPuqATBP7Pz2Oam+i/XXz55ZJ5dPzJq9YsdtwVH3pLFbSk08jnMdFGYapvFabnf/brHKarFHHkICWu2ni1KkO5E+SMM55M+skd8S00tiW+5xM6dihSucOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iev65ItV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f441791e40so6426793a91.3;
        Mon, 10 Feb 2025 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209437; x=1739814237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx/Qqdr7ZlpR07gYfhh2QpaDbLO/fjTlwySikXAdifs=;
        b=Iev65ItVgyo7JUoutQCWELGoYkIzt6Qrj3JlbXmADvYVmtkGIv+SpvzlxgQsx4h/yt
         3mq8ZzqOswbS7+HSIMoP+v55tmTDOtUk+PNdjgJhmBi1XZlB9i2th0v4R0gPTUz962Ug
         n9RKcDAgadL3CLTFRv2uhUGyGQbmKYL0DW6YXTeP3Mriy+WOHK/UUPys5Vx3d9SkEh2A
         qvsjZhVWlPr227E1eC8p0B31wZidW5sGCwwJkdKdkSsEdWzyalwJBNAE/gMuXX2HpJ/5
         ance2NzRyEIUlzHWFra2MP6OBH1KEbOQhoDAYjB7pUmc7gajLuFB7P6c1xc7/DuBfIiX
         jICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209437; x=1739814237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nx/Qqdr7ZlpR07gYfhh2QpaDbLO/fjTlwySikXAdifs=;
        b=dgyweW1oozDZCsa3zLoAzASwKNXcY813f5rg9KBO9KHJf1GEIsBcaTMRPZQU6+lwpF
         nZ7HC6yNEAz7X5Gy3smPt4XfWFxyDcapfe+WIK8ZR4j3hI8kR4LUZIloESKAWpIS0ddk
         4OIaE0Ggc3nYy38owgWNMjLFJETiHWV2xHRqLKIlElhFm5yg46ebe/wesaTwOl/lPlou
         fcKtjfXPS9IlVdcz50DgQPU9/6Ejw8urUHMN0Vr62k2Mb4Nq9mQxBnoRKTFI6adOGE5A
         ghA9twEV4FFxl8tGhXAwY0wytyQNTMpZveh3OIjeHsaSxnX8x+peza/eRRlIxHNqQcNh
         H7KQ==
X-Gm-Message-State: AOJu0YzNX/0bXegJCmsCjJmIBAIJvox71qUNM80P7EaARxPHx4ECK8S9
	L30HoLgUbiNTYIGhgdRbBGEhraLn6wQ6diz+H/NYPYbIxVu2SLL8Tkfz3Wqe
X-Gm-Gg: ASbGncuN7IyOtU5BqRoHLr9WIMAHrVg3OCt60k3aGJ5xwS2y0R6uAFuJK0OqDPyqfWB
	yFDlY5ttRQ0sTWNszMmzzh4Bxt28Z9Ts5DXdznqTkCqWWNpvbr6U9zjfkVEDm0TcqQVSL9nBBQX
	hMkAyVKWiZ08RX7k7w0moZkTUGkUIugFyt3g36Y6DmSNNxIiVUFzjYbDrAP7QJoegPZVi/oDyRd
	FYkeAm+Tj5cDCsRn6ZVnSTM66rriXhS84vvZWms252BdUKJqX31IxFeCgCd9Qf58m8/hUlu2EuF
	yMwfUgODWkIAAUiArxYuX93XAH0r+W8croJZdynnjsxYTcb8J5lkhu6Gx8SaBtR7eQ==
X-Google-Smtp-Source: AGHT+IH+VGdX/HQE7ZgUxZN/Z390yj3CkkVyxbmbOdQdNjGAfFZdl+NpDhm6RgYlOxeTF41KuY9a+w==
X-Received: by 2002:a17:90b:4c02:b0:2ee:a4f2:b311 with SMTP id 98e67ed59e1d1-2fa2406471emr22364237a91.8.1739209435275;
        Mon, 10 Feb 2025 09:43:55 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:54 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 08/19] bpf: net_sched: Support implementation of Qdisc_ops in bpf
Date: Mon, 10 Feb 2025 09:43:22 -0800
Message-ID: <20250210174336.2024258-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
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
 net/sched/Kconfig       |  12 +++
 net/sched/Makefile      |   1 +
 net/sched/bpf_qdisc.c   | 210 ++++++++++++++++++++++++++++++++++++++++
 net/sched/sch_api.c     |   7 +-
 net/sched/sch_generic.c |   3 +-
 5 files changed, 229 insertions(+), 4 deletions(-)
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
index 000000000000..00f3232f4a98
--- /dev/null
+++ b/net/sched/bpf_qdisc.c
@@ -0,0 +1,210 @@
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
+	/* Tail call is disabled since there is no gaurantee valid refcounted
+	 * kptrs will always be passed to another bpf program with __ref arguments.
+	 */
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
+	arg = btf_ctx_arg_idx(btf, prog->aux->attach_func_proto, off);
+	if (bpf_struct_ops_prog_moff(prog) == offsetof(struct Qdisc_ops, enqueue)) {
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
index e3e91cf867eb..1aad41b7d5a8 100644
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


