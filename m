Return-Path: <bpf+bounces-26440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A7C89F96D
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025CB1C2536E
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C616EC0D;
	Wed, 10 Apr 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KYpjuWIR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C891791F3
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757733; cv=none; b=c6KawOvgDkF4D5e/alc5NOKBxzmaN7vrXBJk0OixdDWpnUwRmZRJhZ9//wlT6BShzcBAI2EJ9yh9neP2VHhPOWzP53ac/bSjTFaATNcFPR37aa59pAgePDhOuqz8C6f0PCHsIbp/HQFouY1BytHTbpuE6BSl7aZEacxlpM7nXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757733; c=relaxed/simple;
	bh=J/01KOvPbSQZ7+iQZQfKzNawJwXPmBZrDFifMh6ZeME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptS6BYwFaGvCjxDFmRv2M0Mbn1hGYYnVS8Q9lUsFkirwIb7ftaKfuUH/AeubTJHSHIDju1pDAqmehqGanP6J4fqWjfBtm3aNgfCJuZB56q1VypKddQm0QIFtkgjsuSTpCzP3doOtN7su4mHWIMf0U1rl7tl1XjsI5LGemrhgsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KYpjuWIR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78d5e80bc42so320393585a.0
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757729; x=1713362529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTQzjgj5nFoy3aE0L3fLeRsDEegSxtmQN293bIqEsZo=;
        b=KYpjuWIRGD1bnnFmYX6YGxUPT0hzyLoh5yQ5dO9nLdaTTTRCm+lNczhTB/GIbhRY3g
         sI6Wizjxd13Wzj95/p9HtVWEgrQwqYbWYVzyMCztPFYqgWx1lu1gW7PvT4h5A9bXJptE
         4rqHZ6WdBYMw5R4OSjYprfK+JSIUug78vHBgxxtT8+nCVPKPVp4RTT0ycT2CGVou+QnC
         yam63LbuWfyjbbNxqw7be+sAqfdIhgXPLEQp0tuLRbS0YgEnNcrfJ1RTwkADrPFqfa3D
         TK+Qs0qiX/12JblnESIu1O0LjPLHmapew2W/+Hv9l9ApRAitSZu513UEt8arkptPP02b
         Wmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757729; x=1713362529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTQzjgj5nFoy3aE0L3fLeRsDEegSxtmQN293bIqEsZo=;
        b=N+bTrw68pop9wuLZLCdkcl6Ko2btcOsiiuWpcRzJo95/SWW8agZrkVnYz5CEpF3tmx
         waf1FIhFsd75icW8qnPdGqUrIRtXtd30ggzsTytkgOi0vELCbWXKQXNDz5PDxeVGD62Z
         B57udGthzL5i4cmo+IQh0/S4iB6g6TackiQugXR9ymPgSgmlXrLAQ/JGozbmnxikLRiS
         sAxq/ZHXQNis3lA05U4xMiSV5KN6uubqYqoDfQ3yFIHTdFbmI+/EKMmyQ59rYxdevjQ1
         FDpvt7FJvzShe80gFjpPZf4wWrl1SEcq6wkK1xQJz6sJX8i80LaIWkjBaEO76FU7Xy18
         qd+w==
X-Forwarded-Encrypted: i=1; AJvYcCWbscUNuR5NzQ+xqRcUU4xCY5A4271Q4Bs9BKljcv12itK41S9ALJteUNwgnVHCglkDVne+o6ND3HqkuaLqxxm/G6kK
X-Gm-Message-State: AOJu0YxbWcIsHMLneq2KX9yjy+u+LqwO1K5kClK0Icw3QU0zBrYpWD07
	7YF9jtDEl8B3ypVkbhM2KPIPOYXSASTJMZ+U7ZYhXVTG7a4bHntgBfJJhPuhoQ==
X-Google-Smtp-Source: AGHT+IHzOBjW3TyC8CLEuFEUln8ZK0a988fBM2o/5ikaHw+2ITPpmoYqkCqEBYuoYXO5FWEwVELQag==
X-Received: by 2002:a05:620a:46a3:b0:78e:baa6:b158 with SMTP id bq35-20020a05620a46a300b0078ebaa6b158mr1157191qkb.39.1712757728912;
        Wed, 10 Apr 2024 07:02:08 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:02:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v16  15/15] p4tc: add P4 classifier
Date: Wed, 10 Apr 2024 10:01:41 -0400
Message-Id: <20240410140141.495384-16-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410140141.495384-1-jhs@mojatatu.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce P4 tc classifier. The main task of this classifier is to manage
the lifetime of pipeline instances across one or more netdev ports.
Note: a defined pipeline may be instantiated multiple times across one or
more tc chains and different priorities.

Note that part or whole of the P4 pipeline could reside in tc, XDP or even
hardware depending on how the P4 program was compiled. This classifier only
deals with tc layer.
To use the P4 classifier you must specify a pipeline name that will be
associated to the filter instance, a s/w parser (eBPF) and datapath P4
control block program (eBPF) program. Although this patchset does not deal
with offloads, it is also possible to load the h/w part using this filter.
We will illustrate a few examples further below to clarify. Please treat
the illustrated split as an example - there are probably more pragmatic
approaches to splitting the pipeline; however, regardless of where the
different pieces of the pipeline are placed (tc, XDP, HW) and what each
layer will implement (what part of the pipeline) - these examples are
merely showing what is possible.

The pipeline is assumed to have already been created via a template.

For example, if we were to add a filter to ingress of a group of netdevs
(tc block 22) and associate it to P4 pipeline simple_l3 we could issue the
following command:

tc filter add block 22 parent ffff: protocol all prio 6 p4 pname simple_l3 \
    action bpf obj $PARSER.o ... \
    action bpf obj $PROGNAME.o section p4tc/main

The above uses the classical tc action mechanism in which the first action
runs the P4 parser and if that goes well then the P4 control block is
executed. Note, although not shown above, one could also append the command
line with other traditional tc actions.

Given one of the objectives of this classifier is to manage the lifetime
of the p4 program and said program may be split across tc:xdp:hardware we
allow specification of where the xdp (and in the future hardware) programs
can be found. For this reason when instantiating one could specify where
the associated XDP program using they syntax "prog type xdp progname",
where progname refers to the XDP ebpf program name. The control plane side
(below we show iproute2) will be responsible for loading the XDP program.
The kernel is unaware of the XDP side.
There is an ongoing discussion in the P4TC community biweekly meetings
which is likely going to have us add another location definition "prog type
hw" which will specify the hardware object file name and other related
attributes. The current discussion is that this h/w piece will go via the
p4 classifier.

An example using xdp and tc:

tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
    prog type xdp obj $PARSER.o section p4tc/parse-xdp \
    action bpf obj $PROGNAME.o section p4tc/main

In this case, the parser will be executed in the XDP layer and the rest of
P4 control block as a tc action.

For illustration sake, the hw one looks as follows (please note there's
still a lot of discussions going on in the meetings - the example is here
merely to illustrate the tc filter functionality):

tc filter add block 22 ingress protocol all prio 1 p4 pname simple_l3 \
   prog type hw filename "mypnameprog.o" ... \
   prog type xdp obj $PARSER.o section p4tc/parse-xdp \
   action bpf obj $PROGNAME.o section p4tc/main

The theory of operations is as follows:

================================1. PARSING================================

The packet first encounters the parser.
The parser is implemented in ebpf residing either at the TC or XDP
level. The parsed header values are stored in a shared per-cpu eBPF map.
When the parser runs at XDP level, we load it into XDP using the control
plane (tc filter command) and pin it to a file.

=============================2. ACTIONS=============================

In the above example, the P4 program (minus the parser) is encoded in an
action($PROGNAME.o). It should be noted that classical tc actions
continue to work:
IOW, someone could decide to add a mirred action to mirror all packets
after or before the ebpf action.

tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
    action bpf obj $PARSER.o section p4tc/parse \
    action bpf obj $PROGNAME.o section p4tc/main \
    action mirred egress mirror index 1 dev $P1 \
    action bpf obj $ANOTHERPROG.o section mysect/section-1

It should also be noted that it is feasible to split some of the ingress
datapath into XDP first and more into TC later (as was shown above for
example where the parser runs at XDP level). YMMV.
Regardless of choice of which scheme to use, none of these will affect
UAPI. It will all depend on whether you generate code to load on XDP vs
tc, etc. We expect the compiler to evolve over time (but that has
nothing to do with the kernel part).

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/pkt_cls.h |  14 ++
 net/sched/Kconfig            |  12 ++
 net/sched/Makefile           |   1 +
 net/sched/cls_p4.c           | 305 +++++++++++++++++++++++++++++++++++
 net/sched/p4tc/Makefile      |   4 +-
 net/sched/p4tc/trace.c       |  10 ++
 net/sched/p4tc/trace.h       |  44 +++++
 7 files changed, 389 insertions(+), 1 deletion(-)
 create mode 100644 net/sched/cls_p4.c
 create mode 100644 net/sched/p4tc/trace.c
 create mode 100644 net/sched/p4tc/trace.h

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 898f6a05ecf5..efc98765ad20 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -706,6 +706,20 @@ enum {
 
 #define TCA_MATCHALL_MAX (__TCA_MATCHALL_MAX - 1)
 
+/* P4 classifier */
+
+enum {
+	TCA_P4_UNSPEC,
+	TCA_P4_CLASSID,
+	TCA_P4_ACT,
+	TCA_P4_PNAME,
+	TCA_P4_PIPEID,
+	TCA_P4_PAD,
+	__TCA_P4_MAX,
+};
+
+#define TCA_P4_MAX (__TCA_P4_MAX - 1)
+
 /* Extended Matches */
 
 struct tcf_ematch_tree_hdr {
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 5dbae579bda8..66d7fed274e6 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -565,6 +565,18 @@ config NET_CLS_MATCHALL
 	  To compile this code as a module, choose M here: the module will
 	  be called cls_matchall.
 
+config NET_CLS_P4
+	tristate "P4 classifier"
+	select NET_CLS
+	select NET_P4TC
+	help
+	  If you say Y here, you will be able to bind a P4 pipeline
+	  program. You will need to install a P4 template representing the
+	  program successfully to use this feature.
+
+	  To compile this code as a module, choose M here: the module will
+	  be called cls_p4.
+
 config NET_EMATCH
 	bool "Extended Matches"
 	select NET_CLS
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 581f9dd69032..b4f9ef48dd28 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_NET_CLS_CGROUP)	+= cls_cgroup.o
 obj-$(CONFIG_NET_CLS_BPF)	+= cls_bpf.o
 obj-$(CONFIG_NET_CLS_FLOWER)	+= cls_flower.o
 obj-$(CONFIG_NET_CLS_MATCHALL)	+= cls_matchall.o
+obj-$(CONFIG_NET_CLS_P4)	+= cls_p4.o
 obj-$(CONFIG_NET_EMATCH)	+= ematch.o
 obj-$(CONFIG_NET_EMATCH_CMP)	+= em_cmp.o
 obj-$(CONFIG_NET_EMATCH_NBYTE)	+= em_nbyte.o
diff --git a/net/sched/cls_p4.c b/net/sched/cls_p4.c
new file mode 100644
index 000000000000..a266e777b899
--- /dev/null
+++ b/net/sched/cls_p4.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/cls_p4.c - P4 Classifier
+ * Copyright (c) 2022-2024, Mojatatu Networks
+ * Copyright (c) 2022-2024, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/bpf.h>
+#include <linux/filter.h>
+
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+
+#include <net/p4tc.h>
+
+#include "p4tc/trace.h"
+
+struct cls_p4_head {
+	struct tcf_exts exts;
+	struct tcf_result res;
+	struct rcu_work rwork;
+	struct p4tc_pipeline *pipeline;
+	u32 handle;
+};
+
+static int p4_classify(struct sk_buff *skb, const struct tcf_proto *tp,
+		       struct tcf_result *res)
+{
+	struct cls_p4_head *head = rcu_dereference_bh(tp->root);
+
+	if (unlikely(!head)) {
+		pr_err("P4 classifier not found\n");
+		return -1;
+	}
+
+	trace_p4_classify(skb, head->pipeline);
+
+	*res = head->res;
+
+	return tcf_exts_exec(skb, &head->exts, res);
+}
+
+static int p4_init(struct tcf_proto *tp)
+{
+	return 0;
+}
+
+static void __p4_destroy(struct cls_p4_head *head)
+{
+	tcf_exts_destroy(&head->exts);
+	tcf_exts_put_net(&head->exts);
+	p4tc_pipeline_put(head->pipeline);
+	kfree(head);
+}
+
+static void p4_destroy_work(struct work_struct *work)
+{
+	struct cls_p4_head *head =
+		container_of(to_rcu_work(work), struct cls_p4_head, rwork);
+
+	rtnl_lock();
+	__p4_destroy(head);
+	rtnl_unlock();
+}
+
+static void p4_destroy(struct tcf_proto *tp, bool rtnl_held,
+		       struct netlink_ext_ack *extack)
+{
+	struct cls_p4_head *head = rtnl_dereference(tp->root);
+
+	if (!head)
+		return;
+
+	tcf_unbind_filter(tp, &head->res);
+
+	if (tcf_exts_get_net(&head->exts))
+		tcf_queue_work(&head->rwork, p4_destroy_work);
+	else
+		__p4_destroy(head);
+}
+
+static void *p4_get(struct tcf_proto *tp, u32 handle)
+{
+	struct cls_p4_head *head = rtnl_dereference(tp->root);
+
+	if (head && head->handle == handle)
+		return head;
+
+	return NULL;
+}
+
+static const struct nla_policy p4_policy[TCA_P4_MAX + 1] = {
+	[TCA_P4_UNSPEC] = { .type = NLA_UNSPEC },
+	[TCA_P4_CLASSID] = { .type = NLA_U32 },
+	[TCA_P4_ACT] = { .type = NLA_NESTED },
+	[TCA_P4_PNAME] = { .type = NLA_STRING, .len = P4TC_PIPELINE_NAMSIZ },
+	[TCA_P4_PIPEID] = { .type = NLA_U32 },
+};
+
+static int p4_set_parms(struct net *net, struct tcf_proto *tp,
+			struct cls_p4_head *head, unsigned long base,
+			struct nlattr **tb, struct nlattr *est, u32 flags,
+			struct netlink_ext_ack *extack)
+{
+	int err;
+
+	err = tcf_exts_validate_ex(net, tp, tb, est, &head->exts, flags, 0,
+				   extack);
+	if (err < 0)
+		return err;
+
+	if (tb[TCA_P4_CLASSID]) {
+		head->res.classid = nla_get_u32(tb[TCA_P4_CLASSID]);
+		tcf_bind_filter(tp, &head->res, base);
+	}
+
+	return 0;
+}
+
+static int p4_change(struct net *net, struct sk_buff *in_skb,
+		     struct tcf_proto *tp, unsigned long base, u32 handle,
+		     struct nlattr **tca, void **arg, u32 flags,
+		     struct netlink_ext_ack *extack)
+{
+	struct cls_p4_head *head = rtnl_dereference(tp->root);
+	struct p4tc_pipeline *pipeline = NULL;
+	struct nlattr *tb[TCA_P4_MAX + 1];
+	struct cls_p4_head *new_cls;
+	char *pname = NULL;
+	u32 pipeid = 0;
+	int err;
+
+	if (!tca[TCA_OPTIONS]) {
+		NL_SET_ERR_MSG(extack, "Must provide pipeline options");
+		return -EINVAL;
+	}
+
+	if (head)
+		return -EEXIST;
+
+	err = nla_parse_nested(tb, TCA_P4_MAX, tca[TCA_OPTIONS], p4_policy,
+			       extack);
+	if (err < 0)
+		return err;
+
+	if (tb[TCA_P4_PNAME])
+		pname = nla_data(tb[TCA_P4_PNAME]);
+
+	if (tb[TCA_P4_PIPEID])
+		pipeid = nla_get_u32(tb[TCA_P4_PIPEID]);
+
+	pipeline = p4tc_pipeline_find_get(net, pname, pipeid, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!p4tc_pipeline_sealed(pipeline)) {
+		err = -EINVAL;
+		NL_SET_ERR_MSG(extack, "Pipeline must be sealed before use");
+		goto pipeline_put;
+	}
+
+	new_cls = kzalloc(sizeof(*new_cls), GFP_KERNEL);
+	if (!new_cls) {
+		err = -ENOMEM;
+		goto pipeline_put;
+	}
+
+	err = tcf_exts_init(&new_cls->exts, net, TCA_P4_ACT, 0);
+	if (err)
+		goto err_exts_init;
+
+	if (!handle)
+		handle = 1;
+
+	new_cls->handle = handle;
+
+	err = p4_set_parms(net, tp, new_cls, base, tb, tca[TCA_RATE], flags,
+			   extack);
+	if (err)
+		goto err_set_parms;
+
+	new_cls->pipeline = pipeline;
+	*arg = head;
+	rcu_assign_pointer(tp->root, new_cls);
+	return 0;
+
+err_set_parms:
+	tcf_exts_destroy(&new_cls->exts);
+err_exts_init:
+	kfree(new_cls);
+pipeline_put:
+	p4tc_pipeline_put(pipeline);
+	return err;
+}
+
+static int p4_delete(struct tcf_proto *tp, void *arg, bool *last,
+		     bool rtnl_held, struct netlink_ext_ack *extack)
+{
+	*last = true;
+	return 0;
+}
+
+static void p4_walk(struct tcf_proto *tp, struct tcf_walker *arg,
+		    bool rtnl_held)
+{
+	struct cls_p4_head *head = rtnl_dereference(tp->root);
+
+	if (arg->count < arg->skip)
+		goto skip;
+
+	if (!head)
+		return;
+	if (arg->fn(tp, head, arg) < 0)
+		arg->stop = 1;
+skip:
+	arg->count++;
+}
+
+static int p4_dump(struct net *net, struct tcf_proto *tp, void *fh,
+		   struct sk_buff *skb, struct tcmsg *t, bool rtnl_held)
+{
+	struct cls_p4_head *head = fh;
+	struct nlattr *nest;
+
+	if (!head)
+		return skb->len;
+
+	t->tcm_handle = head->handle;
+
+	nest = nla_nest_start(skb, TCA_OPTIONS);
+	if (!nest)
+		goto nla_put_failure;
+
+	if (nla_put_string(skb, TCA_P4_PNAME, head->pipeline->common.name))
+		goto nla_put_failure;
+
+	if (head->res.classid &&
+	    nla_put_u32(skb, TCA_P4_CLASSID, head->res.classid))
+		goto nla_put_failure;
+
+	if (tcf_exts_dump(skb, &head->exts))
+		goto nla_put_failure;
+
+	nla_nest_end(skb, nest);
+
+	if (tcf_exts_dump_stats(skb, &head->exts) < 0)
+		goto nla_put_failure;
+
+	return skb->len;
+
+nla_put_failure:
+	nla_nest_cancel(skb, nest);
+	return -1;
+}
+
+static void p4_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
+			  unsigned long base)
+{
+	struct cls_p4_head *head = fh;
+
+	if (head && head->res.classid == classid) {
+		if (cl)
+			__tcf_bind_filter(q, &head->res, base);
+		else
+			__tcf_unbind_filter(q, &head->res);
+	}
+}
+
+static struct tcf_proto_ops cls_p4_ops __read_mostly = {
+	.kind		= "p4",
+	.classify	= p4_classify,
+	.init		= p4_init,
+	.destroy	= p4_destroy,
+	.get		= p4_get,
+	.change		= p4_change,
+	.delete		= p4_delete,
+	.walk		= p4_walk,
+	.dump		= p4_dump,
+	.bind_class	= p4_bind_class,
+	.owner		= THIS_MODULE,
+};
+
+static int __init cls_p4_init(void)
+{
+	return register_tcf_proto_ops(&cls_p4_ops);
+}
+
+static void __exit cls_p4_exit(void)
+{
+	unregister_tcf_proto_ops(&cls_p4_ops);
+}
+
+module_init(cls_p4_init);
+module_exit(cls_p4_exit);
+
+MODULE_AUTHOR("Mojatatu Networks");
+MODULE_DESCRIPTION("P4 Classifier");
+MODULE_LICENSE("GPL");
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 73ccb53c46bc..04302a3ac0cc 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_trace.o := -I$(src)
+
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
-	p4tc_filter.o p4tc_runtime_api.o
+	p4tc_filter.o p4tc_runtime_api.o trace.o
 obj-$(CONFIG_DEBUG_INFO_BTF) += p4tc_bpf.o
diff --git a/net/sched/p4tc/trace.c b/net/sched/p4tc/trace.c
new file mode 100644
index 000000000000..6833134077fa
--- /dev/null
+++ b/net/sched/p4tc/trace.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <net/p4tc.h>
+
+#ifndef __CHECKER__
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+EXPORT_TRACEPOINT_SYMBOL_GPL(p4_classify);
+#endif
diff --git a/net/sched/p4tc/trace.h b/net/sched/p4tc/trace.h
new file mode 100644
index 000000000000..80abec13b1bd
--- /dev/null
+++ b/net/sched/p4tc/trace.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM p4tc
+
+#if !defined(__P4TC_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define __P4TC_TRACE_H
+
+#include <linux/tracepoint.h>
+
+struct p4tc_pipeline;
+
+TRACE_EVENT(p4_classify,
+	    TP_PROTO(struct sk_buff *skb, struct p4tc_pipeline *pipeline),
+
+	    TP_ARGS(skb, pipeline),
+
+	    TP_STRUCT__entry(__string(pname, pipeline->common.name)
+			     __field(u32,  p_id)
+			     __field(u32,  ifindex)
+			     __field(u32,  ingress)
+			    ),
+
+	    TP_fast_assign(__assign_str(pname, pipeline->common.name);
+			   __entry->p_id = pipeline->common.p_id;
+			   __entry->ifindex = skb->dev->ifindex;
+			   __entry->ingress = skb_at_tc_ingress(skb);
+			  ),
+
+	    TP_printk("dev=%u dir=%s pipeline=%s p_id=%u",
+		      __entry->ifindex,
+		      __entry->ingress ? "ingress" : "egress",
+		      __get_str(pname),
+		      __entry->p_id
+		     )
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
-- 
2.34.1


