Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1143647F0DB
	for <lists+bpf@lfdr.de>; Fri, 24 Dec 2021 21:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353492AbhLXUBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Dec 2021 15:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353499AbhLXUBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Dec 2021 15:01:37 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6755CC061401;
        Fri, 24 Dec 2021 12:01:37 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id j3-20020a056830014300b0058f4f1ef3c2so8210900otp.13;
        Fri, 24 Dec 2021 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKvf8TqIXczPw06+Hrep+vbaMpLElQiNDk1CG5Kkxkg=;
        b=S7Q+T635EkiEQ44z3CHDjUpv2MfGCiFiyi1dfONXa15DRXBcE3ZNaXX3MAruN3AWOi
         8mkdpedMjo9ZJJb2pg1B8r8p4KoiV5C49JKlc5Jhz8aRHJFLwmjm4CZVNjRybshmLC+Z
         A1t1P+NwJ+Im0xk3OxkPe1LsmTGvhFiQeiyjHk6dcz34/27cPhenOM/RsARGRsb26RCM
         tpEEWiFuOGZxJ2Sr53gSsYyGzcndCc3KRctNHlFJfxpdxkhcfBD86JAB5sZUdt7bXfNs
         f5PSW7U4vm2yEHyIzygyTeDjahYcahED6xLLI3S7zRim9zIqFmDXkKwj5IieNiYPCoEB
         OkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKvf8TqIXczPw06+Hrep+vbaMpLElQiNDk1CG5Kkxkg=;
        b=Edu21gVCayAwuE+JNbGCFRJPmsLlFK85gAf1u8TvNEG6pAma577y3o33pGI0IJJDvG
         o0iNVLP30Ze6cOcvLAE3jAjWxYOzuUz3VoNKFdghgdINijrIY71gUI8LBKU1NLXN5UhZ
         iV8ok9mgAEFXJ24KjirEzbOW2ap+oZyZQ2/JNHVreVsukqyW/JjkLP9jxrmGPJmQ2gcA
         liNRsd2G6ZWRPwA4VkCO39gc6KRuXhumApGxTfi7UShx/Gj0RjBhgpaIekJXXY1RvwTz
         dkB81o6vkTCQZ3XcOPQU+HIrU5d45mZ+uOmtzmiqbAfYwLH2+NCJwOTb2AjEdeOB1c+U
         FLMw==
X-Gm-Message-State: AOAM531JPLio6oUvDFyFkd/Hn/DpyACZJx59H8Z+aHhOAoc1VSS4Q1TA
        nClsUDk+HH1wTGYLaXhbtXs4vtPz7OU=
X-Google-Smtp-Source: ABdhPJzlwaanEFDgvVvvKKBW/GrtwF8r5YSQATAGlO8w2LP6oBe7y2fWIxlrfVYBGXzuql7ExROUqg==
X-Received: by 2002:a9d:70cc:: with SMTP id w12mr5603024otj.30.1640376096524;
        Fri, 24 Dec 2021 12:01:36 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:65a0:ab60:b326:fb0b:9894:47a6])
        by smtp.gmail.com with ESMTPSA id o2sm1865506oik.11.2021.12.24.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 12:01:36 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>
Subject: [RFC Patch v3 3/3] net_sched: introduce eBPF based Qdisc
Date:   Fri, 24 Dec 2021 12:00:59 -0800
Message-Id: <20211224200059.161979-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211224200059.161979-1-xiyou.wangcong@gmail.com>
References: <20211224200059.161979-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/bpf_types.h      |   2 +
 include/uapi/linux/bpf.h       |  15 +
 include/uapi/linux/pkt_sched.h |  17 ++
 net/sched/Kconfig              |  15 +
 net/sched/Makefile             |   1 +
 net/sched/sch_bpf.c            | 521 +++++++++++++++++++++++++++++++++
 6 files changed, 571 insertions(+)
 create mode 100644 net/sched/sch_bpf.c

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 48a91c51c015..25a758723c2f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -8,6 +8,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_SCHED_CLS, tc_cls_act,
 	      struct __sk_buff, struct sk_buff)
 BPF_PROG_TYPE(BPF_PROG_TYPE_SCHED_ACT, tc_cls_act,
 	      struct __sk_buff, struct sk_buff)
+//BPF_PROG_TYPE(BPF_PROG_TYPE_SCHED_QDISC, tc_cls_act,
+//	      struct __sk_buff, struct sk_buff)
 BPF_PROG_TYPE(BPF_PROG_TYPE_XDP, xdp,
 	      struct xdp_md, struct xdp_buff)
 #ifdef CONFIG_CGROUP_BPF
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371b9a..7901b31d7242 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -950,6 +950,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
+	BPF_PROG_TYPE_SCHED_QDISC,
 };
 
 enum bpf_attach_type {
@@ -6489,4 +6490,18 @@ struct bpf_core_relo {
 	enum bpf_core_relo_kind kind;
 };
 
+struct sch_bpf_ctx {
+	struct __sk_buff *skb;
+	__u32 classid;
+	__u64 delay;
+};
+
+enum {
+	SCH_BPF_OK,
+	SCH_BPF_QUEUED,
+	SCH_BPF_DROP,
+	SCH_BPF_THROTTLE,
+	SCH_BPF_CONTINUE,
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index f292b467b27f..b51eb712517a 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1267,4 +1267,21 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+#define TCA_SCH_BPF_FLAG_DIRECT _BITUL(0)
+enum {
+	TCA_SCH_BPF_UNSPEC,
+	TCA_SCH_BPF_FLAGS,		/* u32 */
+	TCA_SCH_BPF_ENQUEUE_PROG_NAME,	/* string */
+	TCA_SCH_BPF_ENQUEUE_PROG_FD,	/* u32 */
+	TCA_SCH_BPF_ENQUEUE_PROG_ID,	/* u32 */
+	TCA_SCH_BPF_ENQUEUE_PROG_TAG,	/* data */
+	TCA_SCH_BPF_DEQUEUE_PROG_NAME,	/* string */
+	TCA_SCH_BPF_DEQUEUE_PROG_FD,	/* u32 */
+	TCA_SCH_BPF_DEQUEUE_PROG_ID,	/* u32 */
+	TCA_SCH_BPF_DEQUEUE_PROG_TAG,	/* data */
+	__TCA_SCH_BPF_MAX,
+};
+
+#define TCA_SCH_BPF_MAX (__TCA_SCH_BPF_MAX - 1)
+
 #endif
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 1e8ab4749c6c..19f68aac79b1 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -439,6 +439,21 @@ config NET_SCH_ETS
 
 	  If unsure, say N.
 
+config NET_SCH_BPF
+	tristate "eBPF based programmable queue discipline"
+	help
+	  This eBPF based queue discipline offers a way to program your
+	  own packet scheduling algorithm. This is a classful qdisc which
+	  also allows you to decide the hierarchy.
+
+	  Say Y here if you want to use the eBPF based programmable queue
+	  discipline.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sch_bpf.
+
+	  If unsure, say N.
+
 menuconfig NET_SCH_DEFAULT
 	bool "Allow override default queue discipline"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index dd14ef413fda..9ef0d579f5ff 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_NET_SCH_FQ_PIE)	+= sch_fq_pie.o
 obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
+obj-$(CONFIG_NET_SCH_BPF)	+= sch_bpf.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/sch_bpf.c b/net/sched/sch_bpf.c
new file mode 100644
index 000000000000..bb83b810384c
--- /dev/null
+++ b/net/sched/sch_bpf.c
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Programmable Qdisc with eBPF
+ *
+ * Copyright (C) 2021, Bytedance, Cong Wang <cong.wang@bytedance.com>
+ */
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/jiffies.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/priority_queue.h>
+#include <net/netlink.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
+
+#define ACT_BPF_NAME_LEN	256
+
+struct sch_bpf_prog {
+	struct bpf_prog *prog;
+	const char *name;
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
+struct sch_bpf_qdisc {
+	struct tcf_proto __rcu *filter_list; /* optional external classifier */
+	struct tcf_block *block;
+	struct Qdisc_class_hash clhash;
+	struct sch_bpf_prog enqueue_prog;
+	struct sch_bpf_prog dequeue_prog;
+
+	struct qdisc_watchdog watchdog;
+};
+
+static int sch_bpf_dump_prog(const struct sch_bpf_prog *prog, struct sk_buff *skb,
+			     int name, int id, int tag)
+{
+	struct nlattr *nla;
+
+	if (prog->name &&
+	    nla_put_string(skb, name, prog->name))
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, id, prog->prog->aux->id))
+		return -EMSGSIZE;
+
+	nla = nla_reserve(skb, tag, sizeof(prog->prog->tag));
+	if (!nla)
+		return -EMSGSIZE;
+
+	memcpy(nla_data(nla), prog->prog->tag, nla_len(nla));
+	return 0;
+}
+
+static int sch_bpf_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+	struct nlattr *opts;
+	u32 bpf_flags = 0;
+
+	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
+	if (!opts)
+		goto nla_put_failure;
+
+	if (bpf_flags && nla_put_u32(skb, TCA_SCH_BPF_FLAGS, bpf_flags))
+		goto nla_put_failure;
+
+	if (sch_bpf_dump_prog(&q->enqueue_prog, skb, TCA_SCH_BPF_ENQUEUE_PROG_NAME,
+			      TCA_SCH_BPF_ENQUEUE_PROG_ID, TCA_SCH_BPF_ENQUEUE_PROG_TAG))
+		goto nla_put_failure;
+	if (sch_bpf_dump_prog(&q->dequeue_prog, skb, TCA_SCH_BPF_DEQUEUE_PROG_NAME,
+			      TCA_SCH_BPF_DEQUEUE_PROG_ID, TCA_SCH_BPF_DEQUEUE_PROG_TAG))
+		goto nla_put_failure;
+
+	return nla_nest_end(skb, opts);
+
+nla_put_failure:
+	return -1;
+}
+
+static int sch_bpf_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	return 0;
+}
+
+static struct sch_bpf_class *sch_bpf_find(struct Qdisc *sch, u32 classid)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+	struct Qdisc_class_common *clc;
+
+	clc = qdisc_class_find(&q->clhash, classid);
+	if (!clc)
+		return NULL;
+	return container_of(clc, struct sch_bpf_class, common);
+}
+
+static int sch_bpf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
+			   struct sk_buff **to_free)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+	unsigned int len = qdisc_pkt_len(skb);
+	struct sch_bpf_ctx ctx = {};
+	struct sch_bpf_class *cl;
+	int res = NET_XMIT_SUCCESS;
+	struct bpf_prog *enqueue;
+
+	enqueue = rcu_dereference(q->enqueue_prog.prog);
+	bpf_compute_data_pointers(skb);
+	ctx.skb = (struct __sk_buff *)skb;
+	ctx.classid = sch->handle;
+	res = bpf_prog_run(enqueue, &ctx);
+	switch (res) {
+	case SCH_BPF_DROP:
+		__qdisc_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	case SCH_BPF_QUEUED:
+		return NET_XMIT_SUCCESS;
+	}
+
+	cl = sch_bpf_find(sch, ctx.classid);
+	if (!cl || !cl->qdisc) {
+		if (res & __NET_XMIT_BYPASS)
+			qdisc_qstats_drop(sch);
+		__qdisc_drop(skb, to_free);
+		return res;
+	}
+
+	res = qdisc_enqueue(skb, cl->qdisc, to_free);
+	if (res != NET_XMIT_SUCCESS) {
+		if (net_xmit_drop_count(res)) {
+			qdisc_qstats_drop(sch);
+			cl->drops++;
+		}
+		return res;
+	}
+
+	sch->qstats.backlog += len;
+	sch->q.qlen++;
+	return res;
+}
+
+static struct sk_buff *sch_bpf_dequeue(struct Qdisc *sch)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+	struct sk_buff *ret = NULL;
+	struct sch_bpf_ctx ctx = {};
+	struct bpf_prog *dequeue;
+	struct sch_bpf_class *cl;
+	s64 now;
+	int res;
+
+again:
+	dequeue = rcu_dereference(q->dequeue_prog.prog);
+	ctx.classid = sch->handle;
+	res = bpf_prog_run(dequeue, &ctx);
+	switch (res) {
+	case SCH_BPF_OK:
+		ret = (struct sk_buff *)ctx.skb;
+		break;
+	case SCH_BPF_THROTTLE:
+		now = ktime_get_ns();
+		qdisc_watchdog_schedule_ns(&q->watchdog, now + ctx.delay);
+		qdisc_qstats_overlimit(sch);
+		cl->overlimits++;
+		return NULL;
+	case SCH_BPF_CONTINUE:
+		goto again;
+	default:
+		kfree_skb((struct sk_buff *)ctx.skb);
+		ret = NULL;
+	}
+
+	return ret;
+}
+
+static struct Qdisc *sch_bpf_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)arg;
+
+	return cl->qdisc;
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
+static unsigned long sch_bpf_search(struct Qdisc *sch, u32 handle)
+{
+	return (unsigned long)sch_bpf_find(sch, handle);
+}
+
+static struct tcf_block *sch_bpf_tcf_block(struct Qdisc *sch, unsigned long cl,
+					   struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+	return q->block;
+}
+
+static const struct nla_policy sch_bpf_policy[TCA_SCH_BPF_MAX + 1] = {
+	[TCA_SCH_BPF_FLAGS]		= { .type = NLA_U32 },
+	[TCA_SCH_BPF_ENQUEUE_PROG_FD]	= { .type = NLA_U32 },
+	[TCA_SCH_BPF_ENQUEUE_PROG_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ACT_BPF_NAME_LEN },
+	[TCA_SCH_BPF_DEQUEUE_PROG_FD]	= { .type = NLA_U32 },
+	[TCA_SCH_BPF_DEQUEUE_PROG_NAME]	= { .type = NLA_NUL_STRING,
+					    .len = ACT_BPF_NAME_LEN },
+};
+
+static int bpf_init_prog(struct nlattr *fd, struct nlattr *name, struct sch_bpf_prog *prog)
+{
+	char *prog_name = NULL;
+	struct bpf_prog *fp;
+	u32 bpf_fd;
+
+	if (!fd)
+		return -EINVAL;
+	bpf_fd = nla_get_u32(fd);
+
+	fp = bpf_prog_get_type(bpf_fd, BPF_PROG_TYPE_SCHED_QDISC);
+	if (IS_ERR(fp))
+		return PTR_ERR(fp);
+
+	if (name) {
+		prog_name = nla_memdup(name, GFP_KERNEL);
+		if (!prog_name) {
+			bpf_prog_put(fp);
+			return -ENOMEM;
+		}
+	}
+
+	prog->name = prog_name;
+	prog->prog = fp;
+	return 0;
+}
+
+static void bpf_cleanup_prog(struct sch_bpf_prog *prog)
+{
+	if (prog->prog)
+		bpf_prog_put(prog->prog);
+	kfree(prog->name);
+}
+
+static int sch_bpf_change(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+	struct nlattr *tb[TCA_SCH_BPF_MAX + 1];
+	int err;
+
+	if (!opt)
+		return -EINVAL;
+
+	err = nla_parse_nested_deprecated(tb, TCA_SCH_BPF_MAX, opt,
+					  sch_bpf_policy, NULL);
+	if (err < 0)
+		return err;
+
+	if (tb[TCA_SCH_BPF_FLAGS]) {
+		u32 bpf_flags = nla_get_u32(tb[TCA_SCH_BPF_FLAGS]);
+
+		if (bpf_flags & ~TCA_SCH_BPF_FLAG_DIRECT)
+			return -EINVAL;
+	}
+
+	err = bpf_init_prog(tb[TCA_SCH_BPF_ENQUEUE_PROG_FD],
+			    tb[TCA_SCH_BPF_ENQUEUE_PROG_NAME], &q->enqueue_prog);
+	if (err)
+		return err;
+	err = bpf_init_prog(tb[TCA_SCH_BPF_DEQUEUE_PROG_FD],
+			    tb[TCA_SCH_BPF_DEQUEUE_PROG_NAME], &q->dequeue_prog);
+	return err;
+}
+
+static int sch_bpf_init(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+	int err;
+
+	qdisc_watchdog_init(&q->watchdog, sch);
+	if (opt) {
+		err = sch_bpf_change(sch, opt, extack);
+		if (err)
+			return err;
+	}
+
+	err = tcf_block_get(&q->block, &q->filter_list, sch, extack);
+	if (err)
+		return err;
+
+	return qdisc_class_hash_init(&q->clhash);
+}
+
+static void sch_bpf_reset(struct Qdisc *sch)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+}
+
+static void sch_bpf_destroy(struct Qdisc *sch)
+{
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+	tcf_block_put(q->block);
+	qdisc_class_hash_destroy(&q->clhash);
+	bpf_cleanup_prog(&q->enqueue_prog);
+	bpf_cleanup_prog(&q->dequeue_prog);
+}
+
+static int sch_bpf_change_class(struct Qdisc *sch, u32 classid,
+				u32 parentid, struct nlattr **tca,
+				unsigned long *arg,
+				struct netlink_ext_ack *extack)
+{
+	struct sch_bpf_class *cl = (struct sch_bpf_class *)*arg;
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+
+	if (!cl) {
+		cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+		if (!cl)
+			return -ENOBUFS;
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
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
+
+	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	if (cl->qdisc)
+		qdisc_put(cl->qdisc);
+	return 0;
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
+	struct sch_bpf_qdisc *q = qdisc_priv(sch);
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
+static struct Qdisc_ops sch_bpf_qdisc_ops __read_mostly = {
+	.cl_ops		=	&sch_bpf_class_ops,
+	.id		=	"bpf",
+	.priv_size	=	sizeof(struct sch_bpf_qdisc),
+	.enqueue	=	sch_bpf_enqueue,
+	.dequeue	=	sch_bpf_dequeue,
+	.peek		=	qdisc_peek_dequeued,
+	.init		=	sch_bpf_init,
+	.reset		=	sch_bpf_reset,
+	.destroy	=	sch_bpf_destroy,
+	.change		=	sch_bpf_change,
+	.dump		=	sch_bpf_dump,
+	.dump_stats	=	sch_bpf_dump_stats,
+	.owner		=	THIS_MODULE,
+};
+
+u32 bpf_skb_classify(struct sk_buff *skb, int ifindex, u32 handle)
+{
+	struct net *net = dev_net(skb->dev);
+	struct tcf_result res = {};
+	struct sch_bpf_qdisc *q;
+	struct net_device *dev;
+	struct tcf_proto *tcf;
+	struct Qdisc *sch;
+	int result;
+
+	rcu_read_lock();
+	dev = dev_get_by_index_rcu(net, ifindex);
+	if (!dev) {
+		rcu_read_unlock();
+		return 0;
+	}
+	sch = qdisc_lookup_rcu(dev, handle);
+	if (!sch) {
+		rcu_read_unlock();
+		return 0;
+	}
+	if (sch->ops != &sch_bpf_qdisc_ops) {
+		rcu_read_unlock();
+		return 0;
+	}
+	q = qdisc_priv(sch);
+	tcf = rcu_dereference_bh(q->filter_list);
+	if (!tcf) {
+		rcu_read_unlock();
+		return 0;
+	}
+	result = tcf_classify(skb, NULL, tcf, &res, false);
+	if (result  >= 0) {
+#ifdef CONFIG_NET_CLS_ACT
+		switch (result) {
+		case TC_ACT_QUEUED:
+		case TC_ACT_STOLEN:
+		case TC_ACT_TRAP:
+			fallthrough;
+		case TC_ACT_SHOT:
+			rcu_read_unlock();
+			return 0;
+		}
+#endif
+	}
+	rcu_read_unlock();
+	return res.class;
+}
+
+static int __init sch_bpf_mod_init(void)
+{
+	return register_qdisc(&sch_bpf_qdisc_ops);
+}
+
+static void __exit sch_bpf_mod_exit(void)
+{
+	unregister_qdisc(&sch_bpf_qdisc_ops);
+}
+
+module_init(sch_bpf_mod_init)
+module_exit(sch_bpf_mod_exit)
+MODULE_AUTHOR("Cong Wang");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("eBPF queue discipline");
-- 
2.32.0

