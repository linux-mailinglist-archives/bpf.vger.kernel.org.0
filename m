Return-Path: <bpf+bounces-29531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F6C8C2A92
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E77B28237A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024153E35;
	Fri, 10 May 2024 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcasTyOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF447481CD;
	Fri, 10 May 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369065; cv=none; b=VzFRIYF4jP8V+A7sd4jO6k4xQSkedQxPpEuCWmHi8+jNS8LNe4WSehbTVvYQAQu9dSarLFMqxzBidWGlIY3HT+iozJGsUb1zONZNilH2rlcJMJnjkpMkgTjv4omBEK14oibc6NV4Km+AtTD+V0R7+3vCKJU+Y+gJT9pI8f4zCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369065; c=relaxed/simple;
	bh=LY1V7Kf2blJsc6F2WFAacV0Wv+CpTA4aPumqXFb7W64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WV1cyVo4jUjg87xNz6aDOuV3ycV6vpajOqJsyQ40rUdNg+Ycv+8J2wM8pTr5aFTB8xv0FlZEgl45FI7gzkyLai5H4MXNWEnn3cbvmcry374mEe1Xqw2+mRSI6oP7O/nrf8c1Pp6NwTUr5+6Ju5A69WNr/buhoaRwBsTth53qKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcasTyOC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43df2c8eeb1so12264101cf.3;
        Fri, 10 May 2024 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369062; x=1715973862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKOlmTw+sd2NVyMctGsaaUsDDNJLitT8EajX7p1i1os=;
        b=XcasTyOCKZf+R636OKZhuhvB1NkD9GkLeHQeORcEoC1UCY2EVgXBtbubcg3wy1FDvC
         SDxfQyp93qd0b462dG1Wtg/mD+v5JhfG9dttjLfj6ZZuYemw/E8hHbdfNJxI+6iPouVz
         pyBFYGc+vqCHWmBCJcR5lfeV1luPtPQehJ3FW8zTL5Gk7M0W2lfvotFKZB3b85XGCvv/
         as9ARkDAxE4UYpzNomaKv9Vv//5WVhY2hfH6LTcTOA55iBBZRzrSEra79p3OrLx2OKpB
         mUQvjqBV7LGx8h1zaBif1Dn/a74V1JGON2R6Lz1/f482KsaMzpPlQXSsc4DUzyV/rxYV
         eLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369062; x=1715973862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKOlmTw+sd2NVyMctGsaaUsDDNJLitT8EajX7p1i1os=;
        b=jyZUBtW+Gqb0NSTXAC1+9coxFHQRnZcWu/2OqlWbpGHZA+RIMI4emNuxkIZ4mJuhRV
         6BwL51W4viUYk33/t0amhC0Bna8zZtoda80HHD8kU0et6M8KDJFPz0qZHXJfuBdWSUwG
         tEswAdoLVnrtj81av7TqY7hRNC18bbHhNVtOd96eRnhp8Q1VDQ3+tj3hYLrHV1fanoJ8
         tN4uEQJJ6TCgRFRLrEMP05PEgK/pYDFCIUjQlcHp/C+PFNxsX/Xw5qBdmiq7kHdNGgNP
         uSnTEZVaxycTDcUp9b+CCcJ0E1C6nOavSy58DoBGCTgUfTThEHSxOuKwjw51CBeG5yHl
         uj/A==
X-Gm-Message-State: AOJu0YzOVQE+6VyyEH4TEpfWNzWWI5nggvVD0K0nKjgJ+6B4VC2YaPP6
	thakhvS2+74PyKrUsoOH8G+CPA/KQWxSE+TY1OCkXrJafn26S+NF3eIPDg==
X-Google-Smtp-Source: AGHT+IHB2xYdVTlU/wbS5FaQ3yjXwz2Urpm6eofRY6HgxVKZL6Qa9C2cpbXO4gJevnHVV4AF7+U7cg==
X-Received: by 2002:a05:622a:8b:b0:43a:d430:b678 with SMTP id d75a77b69052e-43dfdb170a3mr34517901cf.32.1715369061626;
        Fri, 10 May 2024 12:24:21 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:21 -0700 (PDT)
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
Subject: [RFC PATCH v8 13/20] bpf: net_sched: Support implementation of Qdisc_ops in bpf
Date: Fri, 10 May 2024 19:24:05 +0000
Message-Id: <20240510192412.3297104-14-amery.hung@bytedance.com>
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

This patch enables users to implement a qdisc using bpf. The last few
patches in this series has prepared struct_ops to support core methods
in Qdisc_ops. The recent advancement in bpf such as local objects,
bpf list and bpf rbtree has also provided powerful and flexible building
blocks to realize sophisticated scheduling algorithms. Therefore, in this
patch, we start allowing qdisc to be implemented using bpf struct_ops.
Users can implement .enqueue and .dequeue in Qdisc_ops in bpf and register
the qdisc dynamically into the kernel.

To further make bpf qdisc easy to use, a qdisc watchdog and a class hash
table are included by default. They are taken care of by bpf qdisc infra
with predefined Qdisc_ops and Qdisc_class_ops methods. In the next few
patches, kfuncs will be introduced for users to really make use of them,
and more ops will be supported.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Co-developed-by: Amery Hung <amery.hung@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/btf.h     |   1 +
 kernel/bpf/btf.c        |   2 +-
 net/sched/Makefile      |   4 +
 net/sched/bpf_qdisc.c   | 563 ++++++++++++++++++++++++++++++++++++++++
 net/sched/sch_api.c     |   7 +-
 net/sched/sch_generic.c |   3 +-
 6 files changed, 575 insertions(+), 5 deletions(-)
 create mode 100644 net/sched/bpf_qdisc.c

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2579b8a51172..2d01a921f604 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -520,6 +520,7 @@ const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
+u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
 			       const struct bpf_prog *prog);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6a9c1671c8f4..edfaba046427 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6304,7 +6304,7 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
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
index 000000000000..53e9b0f1fbd8
--- /dev/null
+++ b/net/sched/bpf_qdisc.c
@@ -0,0 +1,563 @@
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
+struct sch_bpf_class {
+	struct Qdisc_class_common common;
+	struct Qdisc *qdisc;
+
+	unsigned int drops;
+	unsigned int overlimits;
+	struct gnet_stats_basic_sync bstats;
+};
+
+struct bpf_sched_data {
+	struct tcf_proto __rcu *filter_list; /* optional external classifier */
+	struct tcf_block *block;
+	struct Qdisc_class_hash clhash;
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
+static int sch_bpf_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
+			 struct Qdisc **old, struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+
+	if (new)
+		*old = qdisc_replace(sch, new, &cl->qdisc);
+	return 0;
+}
+
+static struct Qdisc *sch_bpf_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+
+	return cl->qdisc;
+}
+
+static struct sch_bpf_class *sch_bpf_find(struct Qdisc *sch, u32 classid)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct Qdisc_class_common *clc;
+
+	clc = qdisc_class_find(&q->clhash, classid);
+	if (!clc)
+		return NULL;
+	return container_of(clc, struct sch_bpf_class, common);
+}
+
+static unsigned long sch_bpf_search(struct Qdisc *sch, u32 handle)
+{
+	return (unsigned long)sch_bpf_find(sch, handle);
+}
+
+static int sch_bpf_change_class(struct Qdisc *sch, u32 classid,
+				u32 parentid, struct nlattr **tca,
+				unsigned long *arg,
+				struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)*arg;
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	if (!cl) {
+		if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0 ||
+		    sch_bpf_find(sch, classid))
+			return -EINVAL;
+
+		cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+		if (!cl)
+			return -ENOBUFS;
+
+		cl->common.classid = classid;
+		gnet_stats_basic_sync_init(&cl->bstats);
+		qdisc_class_hash_insert(&q->clhash, &cl->common);
+	}
+
+	qdisc_class_hash_grow(sch, &q->clhash);
+	*arg = (unsigned long)cl;
+	return 0;
+}
+
+static int sch_bpf_delete(struct Qdisc *sch, unsigned long arg,
+			  struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	if (cl->qdisc)
+		qdisc_put(cl->qdisc);
+	return 0;
+}
+
+static struct tcf_block *sch_bpf_tcf_block(struct Qdisc *sch, unsigned long cl,
+					   struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+	return q->block;
+}
+
+static unsigned long sch_bpf_bind(struct Qdisc *sch, unsigned long parent,
+				  u32 classid)
+{
+	return 0;
+}
+
+static void sch_bpf_unbind(struct Qdisc *q, unsigned long cl)
+{
+}
+
+static int sch_bpf_dump_class(struct Qdisc *sch, unsigned long arg,
+			      struct sk_buff *skb, struct tcmsg *tcm)
+{
+	return 0;
+}
+
+static int
+sch_bpf_dump_class_stats(struct Qdisc *sch, unsigned long arg, struct gnet_dump *d)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+	struct gnet_stats_queue qs = {
+		.drops = cl->drops,
+		.overlimits = cl->overlimits,
+	};
+	__u32 qlen = 0;
+
+	if (cl->qdisc)
+		qdisc_qstats_qlen_backlog(cl->qdisc, &qlen, &qs.backlog);
+	else
+		qlen = 0;
+
+	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
+	    gnet_stats_copy_queue(d, NULL, &qs, qlen) < 0)
+		return -1;
+	return 0;
+}
+
+static void sch_bpf_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct sch_bpf_class *cl;
+	unsigned int i;
+
+	if (arg->stop)
+		return;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
+			if (arg->count < arg->skip) {
+				arg->count++;
+				continue;
+			}
+			if (arg->fn(sch, (unsigned long)cl, arg) < 0) {
+				arg->stop = 1;
+				return;
+			}
+			arg->count++;
+		}
+	}
+}
+
+static int bpf_qdisc_init_op(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+
+	err = tcf_block_get(&q->block, &q->filter_list, sch, extack);
+	if (err)
+		return err;
+
+	err = qdisc_class_hash_init(&q->clhash);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static void bpf_qdisc_reset_op(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct sch_bpf_class *cl;
+	unsigned int i;
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
+			if (cl->qdisc)
+				qdisc_reset(cl->qdisc);
+		}
+	}
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+
+static void bpf_qdisc_destroy_class(struct Qdisc *sch, struct sch_bpf_class *cl)
+{
+	if (cl->qdisc)
+		qdisc_put(cl->qdisc);
+	kfree(cl);
+}
+
+static void bpf_qdisc_destroy_op(struct Qdisc *sch)
+{
+	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct sch_bpf_class *cl;
+	struct hlist_node *next;
+	unsigned int i;
+
+	qdisc_watchdog_cancel(&q->watchdog);
+	tcf_block_put(q->block);
+
+	for (i = 0; i < q->clhash.hashsize; i++) {
+		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[i],
+					  common.hnode) {
+			qdisc_class_hash_remove(&q->clhash,
+						&cl->common);
+			bpf_qdisc_destroy_class(sch, cl);
+		}
+	}
+
+	qdisc_class_hash_destroy(&q->clhash);
+}
+
+static const struct Qdisc_class_ops sch_bpf_class_ops = {
+	.graft		=	sch_bpf_graft,
+	.leaf		=	sch_bpf_leaf,
+	.find		=	sch_bpf_search,
+	.change		=	sch_bpf_change_class,
+	.delete		=	sch_bpf_delete,
+	.tcf_block	=	sch_bpf_tcf_block,
+	.bind_tcf	=	sch_bpf_bind,
+	.unbind_tcf	=	sch_bpf_unbind,
+	.dump		=	sch_bpf_dump_class,
+	.dump_stats	=	sch_bpf_dump_class_stats,
+	.walk		=	sch_bpf_walk,
+};
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
+	case offsetof(struct Qdisc_ops, cl_ops):
+		if (uqdisc_ops->cl_ops)
+			return -EINVAL;
+
+		qdisc_ops->cl_ops = &sch_bpf_class_ops;
+		return 1;
+	case offsetof(struct Qdisc_ops, priv_size):
+		if (uqdisc_ops->priv_size)
+			return -EINVAL;
+		qdisc_ops->priv_size = sizeof(struct bpf_sched_data);
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
+static int bpf_qdisc_reg(void *kdata)
+{
+	return register_qdisc(kdata);
+}
+
+static void bpf_qdisc_unreg(void *kdata)
+{
+	return unregister_qdisc(kdata);
+}
+
+static int Qdisc_ops__enqueue(struct sk_buff *skb__ref_acquired, struct Qdisc *sch,
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
index 65e05b0c98e4..3b5ada5830cd 100644
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
@@ -1392,7 +1393,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
 err_out2:
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 err_out:
 	*errp = err;
 	return NULL;
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ff5336493777..f4343653db0f 100644
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
@@ -1067,7 +1068,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 	if (ops->destroy)
 		ops->destroy(qdisc);
 
-	module_put(ops->owner);
+	bpf_module_put(ops, ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
 
 	trace_qdisc_destroy(qdisc);
-- 
2.20.1


