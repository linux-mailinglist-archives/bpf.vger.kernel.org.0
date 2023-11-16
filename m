Return-Path: <bpf+bounces-15188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338F87EE3AF
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533771C20BC9
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9D534CF7;
	Thu, 16 Nov 2023 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="URg2+H1F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368C9D7E
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:23 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778a47bc09aso50783485a.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146822; x=1700751622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNuATpB16O32WXzRbyA2nheIPE2EOSgCEQWjjE2B+ZI=;
        b=URg2+H1Fq9I5HK3fjQc0PKF3yy6RDNqAAAZNFoRSB9vX3q+7njSDWSjWbZ1VZecusa
         Wf4mgeHhEPp0RuPVG7nW5moixM8XlzU5AEwPS69NsRa6fBj2WM1NaAVx/vDa1pyrxJZi
         21Y3yKsnwf2c7Ate1RtUHqBuSEokodqIBjuczPmNlaf2vsQLQ/5j1O+BDHWHNymTMnh/
         Ls8nSjfltKtaq4Vn1JZenCLPWJYU6K5CARiaUD6kWJTp75ceZLogoB5+OftK/FupYNWf
         Q29/TCQBCyYeVNz2bj5PZiF79R6PH9l7b/cjR79IXq4j3aK5zPuMRqlgTcwpUYlGFZtv
         z+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146822; x=1700751622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNuATpB16O32WXzRbyA2nheIPE2EOSgCEQWjjE2B+ZI=;
        b=WpIDAB875Oa3eknnDkpsQphdCkVHr31VwrV44tJF+ewff3a7p0lezvbwzyPcucsRxE
         /rZSrBPzd/vCL3TrNj3FVdn1U9G9z/dklFODo6OjNFe6XjGg6ke/U8CZaM2k4Ejk+Gw0
         Gt1QYlE4s/Hie64v68IAxZK2ACHRtIsOqvk1hrXLUdYBwWU99gZzSECHkm1gsWHlmYJJ
         1tkx9OIGBJXYJgdzbisbbUL1TatogIOYTQwPc1YRPN4U2VVRIhJAAWOp8+g+Qt0/kzYl
         U1hObuw5arPkGdC/DAp5PEXRMhpZAvrRKkO7pi9sjq7lM57DOrHs2ePXO7AHZ6oVIK0g
         edMw==
X-Gm-Message-State: AOJu0Yxs+m6jhqFxTJM19zXbVkOFHRs3S5fJ9nWaOxaKh0U+662hidxZ
	4Ah/48SO6AMudP1ghIsxWo1meaokAMUcEcmGpnM=
X-Google-Smtp-Source: AGHT+IELEP1yUojF5f0rjMi6o61ma1zpEsH43lqr8YUmUHBxyWn6u2qPoQ+xTEWAmZJoIlGZ/4bmEQ==
X-Received: by 2002:a05:620a:44d4:b0:774:32a7:fe91 with SMTP id y20-20020a05620a44d400b0077432a7fe91mr10246822qkp.48.1700146821714;
        Thu, 16 Nov 2023 07:00:21 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 07:00:20 -0800 (PST)
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
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH net-next v8 14/15] p4tc: add P4 classifier
Date: Thu, 16 Nov 2023 09:59:47 -0500
Message-Id: <20231116145948.203001-15-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116145948.203001-1-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce P4 tc classifier. A tc filter instantiated on this classifier
is used to bind a P4 pipeline to one or more netdev ports. To use P4
classifier you must specify a pipeline name that will be associated to
this filter, a s/w parser and datapath ebpf program. The pipeline must have
already been created via a template.
For example, if we were to add a filter to ingress of network interface
device $P0 and associate it to P4 pipeline simple_l3 we'd issue the
following command:

tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
    action bpf obj $PARSER.o section prog/tc-parser \
    action bpf obj $PROGNAME.o section prog/tc-ingress

$PROGNAME.o and $PARSER.o is a compilation of the eBPF programs generated
by the P4 compiler and will be the representation of the P4 program.
Note that filter understands that $PARSER.o is a parser to be loaded
at the tc level. The datapath program is merely an eBPF action.

Note we do support a distinct way of loading the parser as opposed to
making it be an action, the above example would be:

tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
    prog type tc obj $PARSER.o ... \
    action bpf obj $PROGNAME.o section prog/tc-ingress

We support two types of loadings of these initial programs in the pipeline
and differentiate between what gets loaded at tc vs xdp by using syntax of

either "prog type tc obj" or "prog type xdp obj"

For XDP:

tc filter add dev $P0 ingress protocol all prio 1 p4 pname simple_l3 \
    prog type xdp obj $PARSER.o section parser/xdp \
    pinned_link /sys/fs/bpf/mylink \
    action bpf obj $PROGNAME.o section prog/tc-ingress

The theory of operations is as follows:

================================1. PARSING================================

The packet first encounters the parser.
The parser is implemented in ebpf residing either at the TC or XDP
level. The parsed header values are stored in a shared eBPF map.
When the parser runs at XDP level, we load it into XDP using tc filter
command and pin it to a file.

=============================2. ACTIONS=============================

In the above example, the P4 program (minus the parser) is encoded in an
action($PROGNAME.o). It should be noted that classical tc actions
continue to work:
IOW, someone could decide to add a mirred action to mirror all packets
after or before the ebpf action.

tc filter add dev $P0 parent ffff: protocol all prio 6 p4 pname simple_l3 \
    prog type tc obj $PARSER.o section parser/tc-ingress \
    action bpf obj $PROGNAME.o section prog/tc-ingress \
    action mirred egress mirror index 1 dev $P1 \
    action bpf obj $ANOTHERPROG.o section mysect/section-1

It should also be noted that it is feasible to split some of the ingress
datapath into XDP first and more into TC later (as was shown above for
example where the parser runs at XDP level). YMMV.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/uapi/linux/pkt_cls.h |  18 ++
 net/sched/Kconfig            |  12 +
 net/sched/Makefile           |   1 +
 net/sched/cls_p4.c           | 447 +++++++++++++++++++++++++++++++++++
 net/sched/p4tc/Makefile      |   4 +-
 net/sched/p4tc/trace.c       |  10 +
 net/sched/p4tc/trace.h       |  44 ++++
 7 files changed, 535 insertions(+), 1 deletion(-)
 create mode 100644 net/sched/cls_p4.c
 create mode 100644 net/sched/p4tc/trace.c
 create mode 100644 net/sched/p4tc/trace.h

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 75bf73742..b70ba4647 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -739,6 +739,24 @@ enum {
 
 #define TCA_MATCHALL_MAX (__TCA_MATCHALL_MAX - 1)
 
+/* P4 classifier */
+
+enum {
+	TCA_P4_UNSPEC,
+	TCA_P4_CLASSID,
+	TCA_P4_ACT,
+	TCA_P4_PNAME,
+	TCA_P4_PIPEID,
+	TCA_P4_PROG_FD,
+	TCA_P4_PROG_NAME,
+	TCA_P4_PROG_TYPE,
+	TCA_P4_PROG_ID,
+	TCA_P4_PAD,
+	__TCA_P4_MAX,
+};
+
+#define TCA_P4_MAX (__TCA_P4_MAX - 1)
+
 /* Extended Matches */
 
 struct tcf_ematch_tree_hdr {
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index df6d5e15f..dbfe5ceef 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -565,6 +565,18 @@ config NET_CLS_MATCHALL
 	  To compile this code as a module, choose M here: the module will
 	  be called cls_matchall.
 
+config NET_CLS_P4
+	tristate "P4 classifier"
+	select NET_CLS
+	select NET_P4_TC
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
index 937b8f8a9..15bd59ae3 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_NET_CLS_CGROUP)	+= cls_cgroup.o
 obj-$(CONFIG_NET_CLS_BPF)	+= cls_bpf.o
 obj-$(CONFIG_NET_CLS_FLOWER)	+= cls_flower.o
 obj-$(CONFIG_NET_CLS_MATCHALL)	+= cls_matchall.o
+obj-$(CONFIG_NET_CLS_P4)	+= cls_p4.o
 obj-$(CONFIG_NET_EMATCH)	+= ematch.o
 obj-$(CONFIG_NET_EMATCH_CMP)	+= em_cmp.o
 obj-$(CONFIG_NET_EMATCH_NBYTE)	+= em_nbyte.o
diff --git a/net/sched/cls_p4.c b/net/sched/cls_p4.c
new file mode 100644
index 000000000..67991c74d
--- /dev/null
+++ b/net/sched/cls_p4.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/cls_p4.c - P4 Classifier
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
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
+#define CLS_P4_PROG_NAME_LEN	256
+
+struct p4tc_bpf_prog {
+	struct bpf_prog *p4_prog;
+	const char *p4_prog_name;
+};
+
+struct cls_p4_head {
+	struct tcf_exts exts;
+	struct tcf_result res;
+	struct rcu_work rwork;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_bpf_prog *prog;
+	u32 handle;
+};
+
+static int p4_classify(struct sk_buff *skb, const struct tcf_proto *tp,
+		       struct tcf_result *res)
+{
+	struct cls_p4_head *head = rcu_dereference_bh(tp->root);
+	bool at_ingress = skb_at_tc_ingress(skb);
+
+	if (unlikely(!head)) {
+		pr_err("P4 classifier not found\n");
+		return -1;
+	}
+
+	/* head->prog represents the eBPF program that will be first executed by
+	 * the data plane. It may or may not exist. In addition to head->prog,
+	 * we'll have another eBPF program that will execute after this one in
+	 * the form of a filter action (head->exts).
+	 * head->prog->p4_prog_type == BPf_PROG_TYPE_SCHED_ACT means this
+	 * program executes in TC P4 filter.
+	 * head->prog->p4_prog_type == BPf_PROG_TYPE_SCHED_XDP means this
+	 * program was loaded in XDP.
+	 */
+	if (head->prog) {
+		int rc = TC_ACT_PIPE;
+
+		/* If eBPF program is loaded into TC */
+		if (head->prog->p4_prog->type == BPF_PROG_TYPE_SCHED_ACT) {
+			if (at_ingress) {
+				/* It is safe to push/pull even if skb_shared() */
+				__skb_push(skb, skb->mac_len);
+				bpf_compute_data_pointers(skb);
+				rc = bpf_prog_run(head->prog->p4_prog,
+						  skb);
+				__skb_pull(skb, skb->mac_len);
+			} else {
+				bpf_compute_data_pointers(skb);
+				rc = bpf_prog_run(head->prog->p4_prog,
+						  skb);
+			}
+		}
+
+		if (rc != TC_ACT_PIPE)
+			return rc;
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
+static void p4_bpf_prog_destroy(struct p4tc_bpf_prog *prog)
+{
+	bpf_prog_put(prog->p4_prog);
+	kfree(prog->p4_prog_name);
+	kfree(prog);
+}
+
+static void __p4_destroy(struct cls_p4_head *head)
+{
+	tcf_exts_destroy(&head->exts);
+	tcf_exts_put_net(&head->exts);
+	if (head->prog)
+		p4_bpf_prog_destroy(head->prog);
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
+	[TCA_P4_PNAME] = { .type = NLA_STRING, .len = PIPELINENAMSIZ },
+	[TCA_P4_PIPEID] = { .type = NLA_U32 },
+	[TCA_P4_PROG_FD] = { .type = NLA_U32 },
+	[TCA_P4_PROG_NAME] = { .type = NLA_STRING,
+			       .len = CLS_P4_PROG_NAME_LEN },
+	[TCA_P4_PROG_TYPE] = { .type = NLA_U32 },
+};
+
+static int cls_p4_prog_from_efd(struct nlattr **tb,
+				struct p4tc_bpf_prog *prog, u32 flags,
+				struct netlink_ext_ack *extack)
+{
+	struct bpf_prog *fp;
+	u32 prog_type;
+	char *name;
+	u32 bpf_fd;
+
+	bpf_fd = nla_get_u32(tb[TCA_P4_PROG_FD]);
+	prog_type = nla_get_u32(tb[TCA_P4_PROG_TYPE]);
+
+	if (prog_type != BPF_PROG_TYPE_XDP &&
+	    prog_type != BPF_PROG_TYPE_SCHED_ACT) {
+		NL_SET_ERR_MSG(extack,
+			       "BPF prog type must be BPF_PROG_TYPE_SCHED_ACT or BPF_PROG_TYPE_XDP");
+		return -EINVAL;
+	}
+
+	fp = bpf_prog_get_type_dev(bpf_fd, prog_type, false);
+	if (IS_ERR(fp))
+		return PTR_ERR(fp);
+
+	name = nla_memdup(tb[TCA_P4_PROG_NAME], GFP_KERNEL);
+	if (!name) {
+		bpf_prog_put(fp);
+		return -ENOMEM;
+	}
+
+	prog->p4_prog_name = name;
+	prog->p4_prog = fp;
+
+	return 0;
+}
+
+static int p4_set_parms(struct net *net, struct tcf_proto *tp,
+			struct cls_p4_head *head, unsigned long base,
+			struct nlattr **tb, struct nlattr *est, u32 flags,
+			struct netlink_ext_ack *extack)
+{
+	bool load_bpf_prog = tb[TCA_P4_PROG_NAME] && tb[TCA_P4_PROG_FD] &&
+			     tb[TCA_P4_PROG_TYPE];
+	struct p4tc_bpf_prog *prog = NULL;
+	int err;
+
+	err = tcf_exts_validate_ex(net, tp, tb, est, &head->exts, flags, 0,
+				   extack);
+	if (err < 0)
+		return err;
+
+	if (load_bpf_prog) {
+		prog = kzalloc(sizeof(*prog), GFP_KERNEL);
+		if (!prog) {
+			err = -ENOMEM;
+			goto exts_destroy;
+		}
+
+		err = cls_p4_prog_from_efd(tb, prog, flags, extack);
+		if (err < 0) {
+			kfree(prog);
+			goto exts_destroy;
+		}
+	}
+
+	if (tb[TCA_P4_CLASSID]) {
+		head->res.classid = nla_get_u32(tb[TCA_P4_CLASSID]);
+		tcf_bind_filter(tp, &head->res, base);
+	}
+
+	if (load_bpf_prog) {
+		if (head->prog) {
+			pr_notice("cls_p4: Substituting old BPF program with id %u with new one with id %u\n",
+				  head->prog->p4_prog->aux->id, prog->p4_prog->aux->id);
+			p4_bpf_prog_destroy(head->prog);
+		}
+		head->prog = prog;
+	}
+
+	return 0;
+
+exts_destroy:
+	tcf_exts_destroy(&head->exts);
+	return err;
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
+	if (!pipeline_sealed(pipeline)) {
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
+static int p4_prog_dump(struct sk_buff *skb, struct p4tc_bpf_prog *prog)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+
+	if (nla_put_u32(skb, TCA_P4_PROG_ID, prog->p4_prog->aux->id))
+		goto nla_put_failure;
+
+	if (nla_put_string(skb, TCA_P4_PROG_NAME, prog->p4_prog_name))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, TCA_P4_PROG_TYPE, prog->p4_prog->type))
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	nlmsg_trim(skb, b);
+	return -1;
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
+	if (head->prog && p4_prog_dump(skb, head->prog))
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
index 3fed9a853..726902f10 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_trace.o := -I$(src)
+
 obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
 	p4tc_action.o p4tc_table.o p4tc_tbl_entry.o \
-	p4tc_runtime_api.o
+	p4tc_runtime_api.o trace.o
 obj-$(CONFIG_DEBUG_INFO_BTF) += p4tc_bpf.o
diff --git a/net/sched/p4tc/trace.c b/net/sched/p4tc/trace.c
new file mode 100644
index 000000000..683313407
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
index 000000000..80abec13b
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


