Return-Path: <bpf+bounces-15186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6AA7EE3AC
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF5F2818CF
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24136B0D;
	Thu, 16 Nov 2023 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="U79XK3cq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166AD5A
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:07 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1ef36a04931so426874fac.2
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146807; x=1700751607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvzcJde4NiGT+5QUx71mU6Oc8/i0sb4jeDuxVFNj/Ew=;
        b=U79XK3cqehb8yYRRtEKEaahh1osTXoErDVab8E1uJr5myU76oqK3GM3CreCrSYgCuA
         ukxHY4DzVFo0C1Wz35GKbveiC3+li0ft/4LRpVEOgSJgQ9Jt9EMRCdQ/UThZJVcr/W8e
         KcyiDS/d5yQCPNaUMP9o7l3qgkeh9MR23TeGkaCI6hu5P9voArS9CewJuMVJt8xdKs4N
         IHjYW5GtHxdfrv9Jhcv0KhVyOf3/LI/YifM2SO9eGjamnQ7ebRMjg8R4BdzCnKiqRptL
         SPGFbGx1/4Y4UX3A2lCvu+2FympfrFJzp+QfMEyYFeWWV+EwoXVbibUHghOkGVKHsGez
         Mclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146807; x=1700751607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvzcJde4NiGT+5QUx71mU6Oc8/i0sb4jeDuxVFNj/Ew=;
        b=SBdr3aBt0Ixpb0NKGqANlMwD0nFa460xrwhHHtiy7wK4rUWZ8+fDUged06Jm9ahB3z
         hydoNf8wPK5qQGOx2xtmFUMOl4WqQV2X/d3Pev/E1PX36Nxfw+CNQO5YVXVcrDvV0w6G
         Xfz/sC29FSbYiMbkNk52YPdQ1GfP4uiZW9pUL7GxmoTj3coOPsIbHVONaBTdoWyfqgFd
         UO7c3wtrARyUr1LzCPdUfHWxwhjrxB4v1Hy+kKl5nKJTMXdgDNcGR/Y4oWvIKiOiI+8A
         egxDBXBgK0FC8TwCIGdVg26pQhi+FOhU6ozhq8GxkWlGOLjnW/KIh81mKg4YQTNNe7XE
         pjUg==
X-Gm-Message-State: AOJu0Yzkp8lSFt+K1H9/S4vQ5En8WkYbexSXwCrCIM2EgM4hu+6xom9W
	tfaOhlZ7smVuqqcpaCm/YBRkWQ==
X-Google-Smtp-Source: AGHT+IFOub9clcJDb0aiSf0tATizpgDshU7CRvw8TJgX40EIOn07THEjsBKml8DbsM4EWw2d71leaQ==
X-Received: by 2002:a05:6871:6516:b0:1d5:f070:d518 with SMTP id rl22-20020a056871651600b001d5f070d518mr17362216oab.52.1700146805416;
        Thu, 16 Nov 2023 07:00:05 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 07:00:04 -0800 (PST)
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
Subject: [PATCH net-next v8 09/15] p4tc: add template pipeline create, get, update, delete
Date: Thu, 16 Nov 2023 09:59:42 -0500
Message-Id: <20231116145948.203001-10-jhs@mojatatu.com>
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

__Introducing P4 TC Pipeline__

This commit introduces P4 TC pipelines, which emulate the semantics of a
P4 program/pipeline using the TC infrastructure.

One can refer to P4 programs/pipelines using their names or their
specific pipeline ids (pipeid)

P4 template CRUD (Create, Read/get, Update and Delete) commands apply on a
pipeline.

As an example, to create a P4 program/pipeline named aP4proggie with a
single table in its pipeline, one would use the following command from user
space tc (as generated by the compiler):

tc p4template create pipeline/aP4proggie numtables 1 pipeid 1

Note that, in the above command, the numtables is set as 1; the default
is 0 because it is feasible to have a P4 program with no tables at all.

The P4 compiler will generate the pipeid, however if none is specified,
the kernel will issue one. Like the following example:

tc p4template create pipeline/aP4proggie numtables 1

To Read pipeline aP4proggie attributes, one would retrieve those details as
follows:

tc p4template get pipeline/[aP4proggie] [pipeid 1]

Note that in the above command one may specify pipeline ID, name or
both.

To Update aP4proggie pipeline from 1 to 10 tables, one would use the
following command:

tc p4template update pipeline/[aP4proggie] [pipeid 1] numtables 10

Note that, in the above command, one could use the P4 program/pipeline
name, id or both to specify which P4 program/pipeline to update.

To Delete a P4 program/pipeline named aP4proggie
with a pipeid of 1, one would use the following command:

tc p4template del pipeline/[aP4proggie] [pipeid 1]

Note that, in the above command, one could use the P4 program/pipeline
name, id or both to specify which P4 program/pipeline to delete

If one wished to dump all the created P4 programs/pipelines, one would
use the following command:

tc p4template get pipeline/

__Pipeline Lifetime__

After Create is issued, one can Read/get, Update and Delete; however
the pipeline can only be put to use after it is "sealed".
To seal a pipeline, one would issue the following command:

tc p4template update pipeline/aP4proggie state ready

After a pipeline is sealed it can be put to use via the TC P4 classifier.
For example:

tc filter add dev $DEV ingress protocol any prio 6 p4 pname aP4proggie \
    action bpf obj $PARSER.o section prog/tc-parser
    action bpf obj $PROGNAME.o section prog/tc-ingress

Instantiates aP4proggie in the ingress of $DEV. One could also attach it to
a block of ports (example tc block 22) as such:

tc filter add block 22 ingress protocol all prio 6 p4 pname aP4proggie \
    action bpf obj $PARSER.o section prog/tc-parser
    action bpf obj $PROGNAME.o section prog/tc-ingress

We can, after that, add a table entry.
Like, for example:

tc p4ctrl create aP4proggie/table/cb/aP4table \
      dstAddr 10.10.10.0/24 srcAddr 192.168.0.0/16 prio 16 \
      action drop

Once the pipeline is attached to a device or block it cannot be deleted.
It becomes Read-only from the control plane/user space.
The pipeline can be deleted when there are no longer any users left.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h             | 126 +++++++
 include/uapi/linux/p4tc.h      |  66 ++++
 include/uapi/linux/rtnetlink.h |   9 +
 net/sched/p4tc/Makefile        |   2 +-
 net/sched/p4tc/p4tc_pipeline.c | 611 +++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c | 585 +++++++++++++++++++++++++++++++
 security/selinux/nlmsgtab.c    |   6 +-
 7 files changed, 1403 insertions(+), 2 deletions(-)
 create mode 100644 include/net/p4tc.h
 create mode 100644 net/sched/p4tc/p4tc_pipeline.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_api.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
new file mode 100644
index 000000000..ccb54d842
--- /dev/null
+++ b/include/net/p4tc.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_P4TC_H
+#define __NET_P4TC_H
+
+#include <uapi/linux/p4tc.h>
+#include <linux/workqueue.h>
+#include <net/sch_generic.h>
+#include <net/net_namespace.h>
+#include <linux/refcount.h>
+#include <linux/rhashtable.h>
+#include <linux/rhashtable-types.h>
+
+#define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
+#define P4TC_DEFAULT_MAX_RULES 1
+#define P4TC_PATH_MAX 3
+
+#define P4TC_KERNEL_PIPEID 0
+
+#define P4TC_PID_IDX 0
+
+struct p4tc_dump_ctx {
+	u32 ids[P4TC_PATH_MAX];
+};
+
+struct p4tc_template_common;
+
+struct p4tc_path_nlattrs {
+	char                     *pname;
+	u32                      *ids;
+	bool                     pname_passed;
+};
+
+struct p4tc_pipeline;
+struct p4tc_template_ops {
+	void (*init)(void);
+	struct p4tc_template_common *(*cu)(struct net *net, struct nlmsghdr *n,
+					   struct nlattr *nla,
+					   struct p4tc_path_nlattrs *nl_pname,
+					   struct netlink_ext_ack *extack);
+	int (*put)(struct p4tc_pipeline *pipeline,
+		   struct p4tc_template_common *tmpl,
+		   struct netlink_ext_ack *extack);
+	int (*gd)(struct net *net, struct sk_buff *skb, struct nlmsghdr *n,
+		  struct nlattr *nla, struct p4tc_path_nlattrs *nl_pname,
+		  struct netlink_ext_ack *extack);
+	int (*fill_nlmsg)(struct net *net, struct sk_buff *skb,
+			  struct p4tc_template_common *tmpl,
+			  struct netlink_ext_ack *extack);
+	int (*dump)(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+		    struct nlattr *nla, char **p_name, u32 *ids,
+		    struct netlink_ext_ack *extack);
+	int (*dump_1)(struct sk_buff *skb, struct p4tc_template_common *common);
+};
+
+struct p4tc_template_common {
+	char                     name[TEMPLATENAMSZ];
+	struct p4tc_template_ops *ops;
+	u32                      p_id;
+	u32                      PAD0;
+};
+
+extern const struct p4tc_template_ops p4tc_pipeline_ops;
+
+struct p4tc_pipeline {
+	struct p4tc_template_common common;
+	struct rcu_head             rcu;
+	struct net                  *net;
+	/* Accounts for how many entities are referencing this pipeline.
+	 * As for now only P4 filters can refer to pipelines.
+	 */
+	refcount_t                  p_ctrl_ref;
+	u16                         num_tables;
+	u16                         curr_tables;
+	u8                          p_state;
+};
+
+struct p4tc_pipeline_net {
+	struct idr pipeline_idr;
+};
+
+static inline bool p4tc_tmpl_msg_is_update(struct nlmsghdr *n)
+{
+	return n->nlmsg_type == RTM_UPDATEP4TEMPLATE;
+}
+
+int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			   struct idr *idr, int idx,
+			   struct netlink_ext_ack *extack);
+
+struct p4tc_pipeline *p4tc_pipeline_find_byany(struct net *net,
+					       const char *p_name,
+					       const u32 pipeid,
+					       struct netlink_ext_ack *extack);
+struct p4tc_pipeline *p4tc_pipeline_find_byid(struct net *net,
+					      const u32 pipeid);
+struct p4tc_pipeline *p4tc_pipeline_find_get(struct net *net,
+					     const char *p_name,
+					     const u32 pipeid,
+					     struct netlink_ext_ack *extack);
+
+static inline bool p4tc_pipeline_get(struct p4tc_pipeline *pipeline)
+{
+	return refcount_inc_not_zero(&pipeline->p_ctrl_ref);
+}
+
+void p4tc_pipeline_put(struct p4tc_pipeline *pipeline);
+struct p4tc_pipeline *
+p4tc_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
+				  const u32 pipeid,
+				  struct netlink_ext_ack *extack);
+
+static inline int p4tc_action_destroy(struct tc_action **acts)
+{
+	int ret = 0;
+
+	if (acts) {
+		ret = tcf_action_destroy(acts, TCA_ACT_UNBIND);
+		kfree(acts);
+	}
+
+	return ret;
+}
+
+#define to_pipeline(t) ((struct p4tc_pipeline *)t)
+
+#endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index ba32dba66..4d33f44c1 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -2,8 +2,71 @@
 #ifndef __LINUX_P4TC_H
 #define __LINUX_P4TC_H
 
+#include <linux/types.h>
+#include <linux/pkt_sched.h>
+
+/* pipeline header */
+struct p4tcmsg {
+	__u32 pipeid;
+	__u32 obj;
+};
+
+#define P4TC_MAXPIPELINE_COUNT 32
+#define P4TC_MAXTABLES_COUNT 32
+#define P4TC_MINTABLES_COUNT 0
+#define P4TC_MSGBATCH_SIZE 16
+
 #define P4TC_MAX_KEYSZ 512
 
+#define TEMPLATENAMSZ 32
+#define PIPELINENAMSIZ TEMPLATENAMSZ
+
+/* Root attributes */
+enum {
+	P4TC_ROOT_UNSPEC,
+	P4TC_ROOT, /* nested messages */
+	P4TC_ROOT_PNAME, /* string */
+	__P4TC_ROOT_MAX,
+};
+
+#define P4TC_ROOT_MAX (__P4TC_ROOT_MAX - 1)
+
+/* P4 Object types */
+enum {
+	P4TC_OBJ_UNSPEC,
+	P4TC_OBJ_PIPELINE,
+	__P4TC_OBJ_MAX,
+};
+
+#define P4TC_OBJ_MAX (__P4TC_OBJ_MAX - 1)
+
+/* P4 attributes */
+enum {
+	P4TC_UNSPEC,
+	P4TC_PATH,
+	P4TC_PARAMS,
+	__P4TC_MAX,
+};
+
+#define P4TC_MAX (__P4TC_MAX - 1)
+
+/* PIPELINE attributes */
+enum {
+	P4TC_PIPELINE_UNSPEC,
+	P4TC_PIPELINE_NUMTABLES, /* u16 */
+	P4TC_PIPELINE_STATE, /* u8 */
+	P4TC_PIPELINE_NAME, /* string only used for pipeline dump */
+	__P4TC_PIPELINE_MAX
+};
+
+#define P4TC_PIPELINE_MAX (__P4TC_PIPELINE_MAX - 1)
+
+/* PIPELINE states */
+enum {
+	P4TC_STATE_NOT_READY,
+	P4TC_STATE_READY,
+};
+
 enum {
 	P4T_UNSPEC,
 	P4T_U8,
@@ -30,4 +93,7 @@ enum {
 
 #define P4T_MAX (__P4T_MAX - 1)
 
+#define P4TC_RTA(r) \
+	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
+
 #endif
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 3b687d20c..4f9ebe3e7 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -194,6 +194,15 @@ enum {
 	RTM_GETTUNNEL,
 #define RTM_GETTUNNEL	RTM_GETTUNNEL
 
+	RTM_CREATEP4TEMPLATE = 124,
+#define RTM_CREATEP4TEMPLATE	RTM_CREATEP4TEMPLATE
+	RTM_DELP4TEMPLATE,
+#define RTM_DELP4TEMPLATE	RTM_DELP4TEMPLATE
+	RTM_GETP4TEMPLATE,
+#define RTM_GETP4TEMPLATE	RTM_GETP4TEMPLATE
+	RTM_UPDATEP4TEMPLATE,
+#define RTM_UPDATEP4TEMPLATE	RTM_UPDATEP4TEMPLATE
+
 	__RTM_MAX,
 #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
 };
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index dd1358c9e..0881a7563 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := p4tc_types.o
+obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
new file mode 100644
index 000000000..fc6e49573
--- /dev/null
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_pipeline.c	P4 TC PIPELINE
+ *
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/kmod.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+#include <net/p4tc_types.h>
+
+static unsigned int pipeline_net_id;
+static struct p4tc_pipeline *root_pipeline;
+
+static __net_init int pipeline_init_net(struct net *net)
+{
+	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
+
+	idr_init(&pipe_net->pipeline_idr);
+
+	return 0;
+}
+
+static int __p4tc_pipeline_put(struct p4tc_pipeline *pipeline,
+			       struct p4tc_template_common *template,
+			       struct netlink_ext_ack *extack);
+
+static void __net_exit pipeline_exit_net(struct net *net)
+{
+	struct p4tc_pipeline_net *pipe_net;
+	struct p4tc_pipeline *pipeline;
+	unsigned long pipeid, tmp;
+
+	rtnl_lock();
+	pipe_net = net_generic(net, pipeline_net_id);
+	idr_for_each_entry_ul(&pipe_net->pipeline_idr, pipeline, tmp, pipeid) {
+		__p4tc_pipeline_put(pipeline, &pipeline->common, NULL);
+	}
+	idr_destroy(&pipe_net->pipeline_idr);
+	rtnl_unlock();
+}
+
+static struct pernet_operations pipeline_net_ops = {
+	.init = pipeline_init_net,
+	.pre_exit = pipeline_exit_net,
+	.id = &pipeline_net_id,
+	.size = sizeof(struct p4tc_pipeline_net),
+};
+
+static const struct nla_policy tc_pipeline_policy[P4TC_PIPELINE_MAX + 1] = {
+	[P4TC_PIPELINE_NUMTABLES] =
+		NLA_POLICY_RANGE(NLA_U16, P4TC_MINTABLES_COUNT, P4TC_MAXTABLES_COUNT),
+	[P4TC_PIPELINE_STATE] = { .type = NLA_U8 },
+};
+
+static void p4tc_pipeline_destroy(struct p4tc_pipeline *pipeline)
+{
+	kfree(pipeline);
+}
+
+static void p4tc_pipeline_destroy_rcu(struct rcu_head *head)
+{
+	struct p4tc_pipeline *pipeline;
+	struct net *net;
+
+	pipeline = container_of(head, struct p4tc_pipeline, rcu);
+
+	net = pipeline->net;
+	p4tc_pipeline_destroy(pipeline);
+	put_net(net);
+}
+
+static void p4tc_pipeline_teardown(struct p4tc_pipeline *pipeline,
+				   struct netlink_ext_ack *extack)
+{
+	struct net *net = pipeline->net;
+	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
+	struct net *pipeline_net = maybe_get_net(net);
+
+	idr_remove(&pipe_net->pipeline_idr, pipeline->common.p_id);
+
+	/* If we are on netns cleanup we can't touch the pipeline_idr.
+	 * On pre_exit we will destroy the idr but never call into teardown
+	 * if filters are active which makes pipeline pointers dangle until
+	 * the filters ultimately destroy them.
+	 */
+	if (pipeline_net) {
+		idr_remove(&pipe_net->pipeline_idr, pipeline->common.p_id);
+		call_rcu(&pipeline->rcu, p4tc_pipeline_destroy_rcu);
+	} else {
+		p4tc_pipeline_destroy(pipeline);
+	}
+}
+
+static int __p4tc_pipeline_put(struct p4tc_pipeline *pipeline,
+			       struct p4tc_template_common *template,
+			       struct netlink_ext_ack *extack)
+{
+	/* The lifetime of the pipeline can be terminated in two cases:
+	 * - netns cleanup (system driven)
+	 * - pipeline delete (user driven)
+	 *
+	 * When the pipeline is referenced by one or more p4 classifiers we need
+	 * to make sure the pipeline and its components are alive while the classifier
+	 * is still visible by the datapath.
+	 * In the netns cleanup, we cannot destroy the pipeline in our netns exit callback
+	 * as the netdevs and filters are still visible in the datapath.
+	 * In such case, it's the filter's job to destroy the pipeline.
+	 *
+	 * To accommodate such scenario, whichever put call reaches '0' first will
+	 * destroy the pipeline and its components.
+	 *
+	 * On netns cleanup we guarantee no table entries operations are in flight.
+	 */
+	if (!refcount_dec_and_test(&pipeline->p_ctrl_ref)) {
+		NL_SET_ERR_MSG(extack, "Can't delete referenced pipeline");
+		return -EBUSY;
+	}
+
+	p4tc_pipeline_teardown(pipeline, extack);
+
+	return 0;
+}
+
+static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
+					       struct netlink_ext_ack *extack)
+{
+	if (pipeline->curr_tables != pipeline->num_tables) {
+		NL_SET_ERR_MSG(extack,
+			       "Must have all table defined to update state to ready");
+		return -EINVAL;
+	}
+
+	pipeline->p_state = P4TC_STATE_READY;
+	return true;
+}
+
+static inline bool pipeline_sealed(struct p4tc_pipeline *pipeline)
+{
+	return pipeline->p_state == P4TC_STATE_READY;
+}
+
+struct p4tc_pipeline *p4tc_pipeline_find_byid(struct net *net, const u32 pipeid)
+{
+	struct p4tc_pipeline_net *pipe_net;
+
+	if (pipeid == P4TC_KERNEL_PIPEID)
+		return root_pipeline;
+
+	pipe_net = net_generic(net, pipeline_net_id);
+
+	return idr_find(&pipe_net->pipeline_idr, pipeid);
+}
+EXPORT_SYMBOL_GPL(p4tc_pipeline_find_byid);
+
+static struct p4tc_pipeline *p4tc_pipeline_find_byname(struct net *net,
+						       const char *name)
+{
+	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
+	struct p4tc_pipeline *pipeline;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&pipe_net->pipeline_idr, pipeline, tmp, id) {
+		/* Don't show kernel pipeline */
+		if (id == P4TC_KERNEL_PIPEID)
+			continue;
+		if (strncmp(pipeline->common.name, name, PIPELINENAMSIZ) == 0)
+			return pipeline;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_pipeline *p4tc_pipeline_create(struct net *net,
+						  struct nlmsghdr *n,
+						  struct nlattr *nla,
+						  const char *p_name, u32 pipeid,
+						  struct netlink_ext_ack *extack)
+{
+	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
+	struct nlattr *tb[P4TC_PIPELINE_MAX + 1];
+	struct p4tc_pipeline *pipeline;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_PIPELINE_MAX, nla, tc_pipeline_policy,
+			       extack);
+
+	if (ret < 0)
+		goto out;
+
+	pipeline = p4tc_pipeline_find_byany(net, p_name, pipeid, NULL);
+	if (pipeid != P4TC_KERNEL_PIPEID && !IS_ERR(pipeline)) {
+		NL_SET_ERR_MSG(extack, "Pipeline exists");
+		ret = -EEXIST;
+		goto out;
+	}
+
+	pipeline = kzalloc(sizeof(*pipeline), GFP_KERNEL);
+	if (unlikely(!pipeline))
+		return ERR_PTR(-ENOMEM);
+
+	if (!p_name || p_name[0] == '\0') {
+		NL_SET_ERR_MSG(extack, "Must specify pipeline name");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	strscpy(pipeline->common.name, p_name, PIPELINENAMSIZ);
+
+	if (pipeid) {
+		ret = idr_alloc_u32(&pipe_net->pipeline_idr, pipeline, &pipeid,
+				    pipeid, GFP_KERNEL);
+	} else {
+		pipeid = 1;
+		ret = idr_alloc_u32(&pipe_net->pipeline_idr, pipeline, &pipeid,
+				    UINT_MAX, GFP_KERNEL);
+	}
+
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate pipeline id");
+		goto idr_rm;
+	}
+
+	pipeline->common.p_id = pipeid;
+
+	if (tb[P4TC_PIPELINE_NUMTABLES])
+		pipeline->num_tables =
+			nla_get_u16(tb[P4TC_PIPELINE_NUMTABLES]);
+	else
+		pipeline->num_tables = P4TC_DEFAULT_NUM_TABLES;
+
+	pipeline->p_state = P4TC_STATE_NOT_READY;
+
+	pipeline->net = net;
+
+	refcount_set(&pipeline->p_ctrl_ref, 1);
+
+	pipeline->common.ops = (struct p4tc_template_ops *)&p4tc_pipeline_ops;
+
+	return pipeline;
+
+idr_rm:
+	idr_remove(&pipe_net->pipeline_idr, pipeid);
+
+err:
+	kfree(pipeline);
+
+out:
+	return ERR_PTR(ret);
+}
+
+struct p4tc_pipeline *p4tc_pipeline_find_byany(struct net *net,
+					       const char *p_name,
+					       const u32 pipeid,
+					       struct netlink_ext_ack *extack)
+{
+	struct p4tc_pipeline *pipeline = NULL;
+
+	if (pipeid) {
+		pipeline = p4tc_pipeline_find_byid(net, pipeid);
+		if (!pipeline) {
+			NL_SET_ERR_MSG(extack, "Unable to find pipeline by id");
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		if (p_name) {
+			pipeline = p4tc_pipeline_find_byname(net, p_name);
+			if (!pipeline) {
+				NL_SET_ERR_MSG(extack,
+					       "Pipeline name not found");
+				return ERR_PTR(-EINVAL);
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify pipeline name or id");
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	return pipeline;
+}
+
+struct p4tc_pipeline *p4tc_pipeline_find_get(struct net *net, const char *p_name,
+					     const u32 pipeid,
+					     struct netlink_ext_ack *extack)
+{
+	struct p4tc_pipeline *pipeline =
+		p4tc_pipeline_find_byany(net, p_name, pipeid, extack);
+
+	if (IS_ERR(pipeline))
+		return pipeline;
+
+	if (!p4tc_pipeline_get(pipeline)) {
+		NL_SET_ERR_MSG(extack, "Pipeline is stale");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return pipeline;
+}
+EXPORT_SYMBOL_GPL(p4tc_pipeline_find_get);
+
+void p4tc_pipeline_put(struct p4tc_pipeline *pipeline)
+{
+	__p4tc_pipeline_put(pipeline, &pipeline->common, NULL);
+}
+EXPORT_SYMBOL_GPL(p4tc_pipeline_put);
+
+struct p4tc_pipeline *
+p4tc_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
+				  const u32 pipeid,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_pipeline *pipeline =
+		p4tc_pipeline_find_byany(net, p_name, pipeid, extack);
+	if (IS_ERR(pipeline))
+		return pipeline;
+
+	if (pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack, "Pipeline is sealed");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return pipeline;
+}
+
+static struct p4tc_pipeline *
+p4tc_pipeline_update(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		     const char *p_name, const u32 pipeid,
+		     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_PIPELINE_MAX + 1];
+	struct p4tc_pipeline *pipeline;
+	u16 num_tables = 0;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_PIPELINE_MAX, nla, tc_pipeline_policy,
+			       extack);
+
+	if (ret < 0)
+		goto out;
+
+	pipeline =
+		p4tc_pipeline_find_byany_unsealed(net, p_name, pipeid, extack);
+	if (IS_ERR(pipeline))
+		return pipeline;
+
+	if (tb[P4TC_PIPELINE_NUMTABLES])
+		num_tables = nla_get_u16(tb[P4TC_PIPELINE_NUMTABLES]);
+
+	if (tb[P4TC_PIPELINE_STATE]) {
+		ret = pipeline_try_set_state_ready(pipeline, extack);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (num_tables)
+		pipeline->num_tables = num_tables;
+
+	return pipeline;
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4tc_pipeline_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		 struct p4tc_path_nlattrs *nl_path_attrs,
+		 struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	u32 pipeid = ids[P4TC_PID_IDX];
+	struct p4tc_pipeline *pipeline;
+
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+		pipeline = p4tc_pipeline_create(net, n, nla,
+						nl_path_attrs->pname,
+						pipeid, extack);
+		break;
+	case RTM_UPDATEP4TEMPLATE:
+		pipeline = p4tc_pipeline_update(net, n, nla,
+						nl_path_attrs->pname,
+						pipeid, extack);
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR(pipeline))
+		goto out;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+out:
+	return (struct p4tc_template_common *)pipeline;
+}
+
+static int _p4tc_pipeline_fill_nlmsg(struct sk_buff *skb,
+				     const struct p4tc_pipeline *pipeline)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+	if (nla_put_u16(skb, P4TC_PIPELINE_NUMTABLES, pipeline->num_tables))
+		goto out_nlmsg_trim;
+	if (nla_put_u8(skb, P4TC_PIPELINE_STATE, pipeline->p_state))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int p4tc_pipeline_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				    struct p4tc_template_common *template,
+				    struct netlink_ext_ack *extack)
+{
+	const struct p4tc_pipeline *pipeline = to_pipeline(template);
+
+	if (_p4tc_pipeline_fill_nlmsg(skb, pipeline) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for pipeline");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4tc_pipeline_del_one(struct p4tc_pipeline *pipeline,
+				 struct netlink_ext_ack *extack)
+{
+	/* User driven pipeline put doesn't transfer the lifetime
+	 * of the pipeline to other ref holders. In case of unlocked
+	 * table entries, it shall never teardown the pipeline so
+	 * need to do an atomic transition here.
+	 *
+	 * System driven put will serialize with rtnl_lock and
+	 * table entries are guaranteed to not be in flight.
+	 */
+	if (!refcount_dec_if_one(&pipeline->p_ctrl_ref)) {
+		NL_SET_ERR_MSG(extack, "Pipeline in use");
+		return -EAGAIN;
+	}
+
+	p4tc_pipeline_teardown(pipeline, extack);
+
+	return 0;
+}
+
+static int p4tc_pipeline_gd(struct net *net, struct sk_buff *skb,
+			    struct nlmsghdr *n, struct nlattr *nla,
+			    struct p4tc_path_nlattrs *nl_path_attrs,
+			    struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_template_common *tmpl;
+	struct p4tc_pipeline *pipeline;
+	u32 *ids = nl_path_attrs->ids;
+	u32 pipeid = ids[P4TC_PID_IDX];
+	int ret = 0;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE &&
+	    (n->nlmsg_flags & NLM_F_ROOT)) {
+		NL_SET_ERR_MSG(extack, "Pipeline flush not supported");
+		return -EOPNOTSUPP;
+	}
+
+	pipeline = p4tc_pipeline_find_byany(net, nl_path_attrs->pname, pipeid,
+					    extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	tmpl = (struct p4tc_template_common *)pipeline;
+	if (p4tc_pipeline_fill_nlmsg(net, skb, tmpl, extack) < 0)
+		return -1;
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			PIPELINENAMSIZ);
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = p4tc_pipeline_del_one(pipeline, extack);
+		if (ret < 0)
+			goto out_nlmsg_trim;
+	}
+
+	return ret;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static int p4tc_pipeline_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			      struct nlattr *nla, char **p_name, u32 *ids,
+			      struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline_net *pipe_net;
+
+	pipe_net = net_generic(net, pipeline_net_id);
+
+	return p4tc_tmpl_generic_dump(skb, ctx, &pipe_net->pipeline_idr,
+				      P4TC_PID_IDX, extack);
+}
+
+static int p4tc_pipeline_dump_1(struct sk_buff *skb,
+				struct p4tc_template_common *common)
+{
+	struct p4tc_pipeline *pipeline = to_pipeline(common);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *param;
+
+	/* Don't show kernel pipeline in dump */
+	if (pipeline->common.p_id == P4TC_KERNEL_PIPEID)
+		return 1;
+
+	param = nla_nest_start(skb, P4TC_PARAMS);
+	if (!param)
+		goto out_nlmsg_trim;
+	if (nla_put_string(skb, P4TC_PIPELINE_NAME, pipeline->common.name))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, param);
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+static int register_pipeline_pernet(void)
+{
+	return register_pernet_subsys(&pipeline_net_ops);
+}
+
+static void __p4tc_pipeline_init(void)
+{
+	int pipeid = P4TC_KERNEL_PIPEID;
+
+	root_pipeline = kzalloc(sizeof(*root_pipeline), GFP_ATOMIC);
+	if (unlikely(!root_pipeline)) {
+		pr_err("Unable to register kernel pipeline\n");
+		return;
+	}
+
+	strscpy(root_pipeline->common.name, "kernel", PIPELINENAMSIZ);
+
+	root_pipeline->common.ops =
+		(struct p4tc_template_ops *)&p4tc_pipeline_ops;
+
+	root_pipeline->common.p_id = pipeid;
+
+	root_pipeline->p_state = P4TC_STATE_READY;
+}
+
+static void p4tc_pipeline_init(void)
+{
+	if (register_pipeline_pernet() < 0)
+		pr_err("Failed to register per net pipeline IDR");
+
+	if (p4tc_register_types() < 0)
+		pr_err("Failed to register P4 types");
+
+	__p4tc_pipeline_init();
+}
+
+const struct p4tc_template_ops p4tc_pipeline_ops = {
+	.init = p4tc_pipeline_init,
+	.cu = p4tc_pipeline_cu,
+	.fill_nlmsg = p4tc_pipeline_fill_nlmsg,
+	.gd = p4tc_pipeline_gd,
+	.put = __p4tc_pipeline_put,
+	.dump = p4tc_pipeline_dump,
+	.dump_1 = p4tc_pipeline_dump_1,
+};
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
new file mode 100644
index 000000000..c6eaaf47b
--- /dev/null
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_api.c	P4 TC API
+ *
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/kmod.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+
+static const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
+	[P4TC_ROOT] = { .type = NLA_NESTED },
+	[P4TC_ROOT_PNAME] = { .type = NLA_STRING, .len = PIPELINENAMSIZ },
+};
+
+static const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
+	[P4TC_PATH] = { .type = NLA_BINARY,
+			.len = P4TC_PATH_MAX * sizeof(u32) },
+	[P4TC_PARAMS] = { .type = NLA_NESTED },
+};
+
+static bool obj_is_valid(u32 obj)
+{
+	switch (obj) {
+	case P4TC_OBJ_PIPELINE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX + 1] = {
+	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
+};
+
+int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			   struct idr *idr, int idx,
+			   struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_template_common *common;
+	unsigned long id = 0;
+	unsigned long tmp;
+	int i = 0;
+
+	id = ctx->ids[idx];
+
+	idr_for_each_entry_continue_ul(idr, common, tmp, id) {
+		struct nlattr *count;
+		int ret;
+
+		if (i == P4TC_MSGBATCH_SIZE)
+			break;
+
+		count = nla_nest_start(skb, i + 1);
+		if (!count)
+			goto out_nlmsg_trim;
+		ret = common->ops->dump_1(skb, common);
+		if (ret < 0) {
+			goto out_nlmsg_trim;
+		} else if (ret) {
+			nla_nest_cancel(skb, count);
+			continue;
+		}
+		nla_nest_end(skb, count);
+
+		i++;
+	}
+
+	if (i == 0) {
+		if (!ctx->ids[idx])
+			NL_SET_ERR_MSG(extack,
+				       "There are no pipeline components");
+		return 0;
+	}
+
+	ctx->ids[idx] = id;
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+static int tc_ctl_p4_tmpl_gd_1(struct net *net, struct sk_buff *skb,
+			       struct nlmsghdr *n, struct nlattr *arg,
+			       struct p4tc_path_nlattrs *nl_path_attrs,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct nlattr *tb[P4TC_MAX + 1];
+	struct p4tc_template_ops *op;
+	u32 ids[P4TC_PATH_MAX] = {};
+	int ret;
+
+	if (!obj_is_valid(t->obj)) {
+		NL_SET_ERR_MSG(extack, "Invalid object type");
+		return -EINVAL;
+	}
+
+	ret = nla_parse_nested(tb, P4TC_MAX, arg, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	ids[P4TC_PID_IDX] = t->pipeid;
+
+	nl_path_attrs->ids = ids;
+
+	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
+
+	ret = op->gd(net, skb, n, tb[P4TC_PARAMS], nl_path_attrs, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!t->pipeid)
+		t->pipeid = ids[P4TC_PID_IDX];
+
+	return ret;
+}
+
+static int tc_ctl_p4_tmpl_gd_n(struct sk_buff *skb, struct nlmsghdr *n,
+			       char *p_name, struct nlattr *nla, int event,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct p4tc_path_nlattrs nl_path_attrs = {0};
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	struct net *net = sock_net(skb->sk);
+	u32 portid = NETLINK_CB(skb).portid;
+	struct p4tcmsg *t_new;
+	struct sk_buff *nskb;
+	struct nlmsghdr *nlh;
+	struct nlattr *pnatt;
+	struct nlattr *root;
+	int ret = 0;
+	int i;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (ret < 0)
+		return ret;
+
+	nskb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!nskb)
+		return -ENOMEM;
+
+	nlh = nlmsg_put(nskb, portid, n->nlmsg_seq, event, sizeof(*t),
+			n->nlmsg_flags);
+	if (!nlh) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
+	t_new->obj = t->obj;
+
+	pnatt = nla_reserve(nskb, P4TC_ROOT_PNAME, PIPELINENAMSIZ);
+	if (!pnatt) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nl_path_attrs.pname = nla_data(pnatt);
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_path_attrs.pname, 0, PIPELINENAMSIZ);
+		nl_path_attrs.pname_passed = false;
+	} else {
+		strscpy(nl_path_attrs.pname, p_name, PIPELINENAMSIZ);
+		nl_path_attrs.pname_passed = true;
+	}
+
+	root = nla_nest_start(nskb, P4TC_ROOT);
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		struct nlattr *nest = nla_nest_start(nskb, i);
+
+		ret = tc_ctl_p4_tmpl_gd_1(net, nskb, nlh, tb[i], &nl_path_attrs,
+					  extack);
+		if (n->nlmsg_flags & NLM_F_ROOT && event == RTM_DELP4TEMPLATE) {
+			if (ret <= 0)
+				goto out;
+		} else {
+			if (ret < 0)
+				goto out;
+		}
+		nla_nest_end(nskb, nest);
+	}
+	nla_nest_end(nskb, root);
+
+	nlmsg_end(nskb, nlh);
+
+	if (event == RTM_GETP4TEMPLATE)
+		return rtnl_unicast(nskb, net, portid);
+
+	return rtnetlink_send(nskb, net, portid, RTNLGRP_TC,
+			      n->nlmsg_flags & NLM_F_ECHO);
+out:
+	kfree_skb(nskb);
+	return ret;
+}
+
+static int tc_ctl_p4_tmpl_get(struct sk_buff *skb, struct nlmsghdr *n,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	int ret;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_gd_n(skb, n, p_name, tb[P4TC_ROOT],
+				   RTM_GETP4TEMPLATE, extack);
+}
+
+static int tc_ctl_p4_tmpl_delete(struct sk_buff *skb, struct nlmsghdr *n,
+				 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	int ret;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_gd_n(skb, n, p_name, tb[P4TC_ROOT],
+				   RTM_DELP4TEMPLATE, extack);
+}
+
+static int p4tc_template_put(struct net *net,
+			     struct p4tc_template_common *common,
+			     struct netlink_ext_ack *extack)
+{
+	/* Every created template is bound to a pipeline */
+	struct p4tc_pipeline *pipeline =
+		p4tc_pipeline_find_byid(net, common->p_id);
+	return common->ops->put(pipeline, common, extack);
+}
+
+static struct p4tc_template_common *
+p4tc_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
+	       struct p4tc_path_nlattrs *nl_path_attrs, struct nlattr *nla,
+	       struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct p4tc_template_common *tmpl;
+	struct nlattr *tb[P4TC_MAX + 1];
+	struct p4tc_template_ops *op;
+	u32 ids[P4TC_PATH_MAX] = {};
+	int ret;
+
+	if (!obj_is_valid(t->obj)) {
+		NL_SET_ERR_MSG(extack, "Invalid object type");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = nla_parse_nested(tb, P4TC_MAX, nla, p4tc_policy, extack);
+	if (ret < 0)
+		goto out;
+
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, P4TC_PARAMS)) {
+		NL_SET_ERR_MSG(extack, "Must specify object attributes");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ids[P4TC_PID_IDX] = t->pipeid;
+	nl_path_attrs->ids = ids;
+
+	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
+	tmpl = op->cu(net, n, tb[P4TC_PARAMS], nl_path_attrs, extack);
+	if (IS_ERR(tmpl))
+		return tmpl;
+
+	ret = op->fill_nlmsg(net, skb, tmpl, extack);
+	if (ret < 0)
+		goto put;
+
+	if (!t->pipeid)
+		t->pipeid = ids[P4TC_PID_IDX];
+
+	return tmpl;
+
+put:
+	p4tc_template_put(net, tmpl, extack);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static int p4tc_tmpl_cu_n(struct sk_buff *skb, struct nlmsghdr *n,
+			  struct nlattr *nla, char *p_name,
+			  struct netlink_ext_ack *extack)
+{
+	struct p4tc_template_common *tmpls[P4TC_MSGBATCH_SIZE];
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	bool update = p4tc_tmpl_msg_is_update(n);
+	struct net *net = sock_net(skb->sk);
+	u32 portid = NETLINK_CB(skb).portid;
+	struct p4tc_path_nlattrs nl_path_attrs;
+	struct p4tcmsg *t_new;
+	struct sk_buff *nskb;
+	struct nlmsghdr *nlh;
+	struct nlattr *pnatt;
+	struct nlattr *root;
+	int ret;
+	int i;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (ret < 0)
+		return ret;
+
+	nskb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!nskb)
+		return -ENOMEM;
+
+	nlh = nlmsg_put(nskb, portid, n->nlmsg_seq, n->nlmsg_type,
+			sizeof(*t), n->nlmsg_flags);
+	if (!nlh)
+		goto out;
+
+	t_new = nlmsg_data(nlh);
+	if (!t_new) {
+		NL_SET_ERR_MSG(extack, "Message header is missing");
+		ret = -EINVAL;
+		goto out;
+	}
+	t_new->pipeid = t->pipeid;
+	t_new->obj = t->obj;
+
+	pnatt = nla_reserve(nskb, P4TC_ROOT_PNAME, PIPELINENAMSIZ);
+	if (!pnatt) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nl_path_attrs.pname = nla_data(pnatt);
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_path_attrs.pname, 0, PIPELINENAMSIZ);
+		nl_path_attrs.pname_passed = false;
+	} else {
+		strscpy(nl_path_attrs.pname, p_name, PIPELINENAMSIZ);
+		nl_path_attrs.pname_passed = true;
+	}
+
+	root = nla_nest_start(nskb, P4TC_ROOT);
+	if (!root) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE && tb[i + 1]; i++) {
+		struct nlattr *nest = nla_nest_start(nskb, i + 1);
+
+		tmpls[i] = p4tc_tmpl_cu_1(nskb, net, nlh, &nl_path_attrs,
+					  tb[i + 1], extack);
+		if (IS_ERR(tmpls[i])) {
+			ret = PTR_ERR(tmpls[i]);
+			if (i > 0 && update) {
+				nla_nest_cancel(nskb, nest);
+				goto nest_end_root;
+			}
+			goto undo_prev;
+		}
+
+		nla_nest_end(nskb, nest);
+	}
+nest_end_root:
+	nla_nest_end(nskb, root);
+
+	if (!t_new->pipeid)
+		t_new->pipeid = ret;
+
+	nlmsg_end(nskb, nlh);
+
+	return rtnetlink_send(nskb, net, portid, RTNLGRP_TC,
+			      n->nlmsg_flags & NLM_F_ECHO);
+
+undo_prev:
+	if (!update) {
+		while (--i > 0) {
+			struct p4tc_template_common *tmpl = tmpls[i - 1];
+
+			p4tc_template_put(net, tmpl, extack);
+		}
+	}
+
+out:
+	kfree_skb(nskb);
+	return ret;
+}
+
+static int tc_ctl_p4_tmpl_cu(struct sk_buff *skb, struct nlmsghdr *n,
+			     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	int ret = 0;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return p4tc_tmpl_cu_n(skb, n, tb[P4TC_ROOT], p_name, extack);
+}
+
+static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
+				 char *p_name, struct netlink_callback *cb)
+{
+	struct p4tc_dump_ctx *ctx = (void *)cb->ctx;
+	struct netlink_ext_ack *extack = cb->extack;
+	u32 portid = NETLINK_CB(cb->skb).portid;
+	const struct nlmsghdr *n = cb->nlh;
+	struct nlattr *tb[P4TC_MAX + 1];
+	struct p4tc_template_ops *op;
+	u32 ids[P4TC_PATH_MAX] = {};
+	struct p4tcmsg *t_new;
+	struct nlmsghdr *nlh;
+	struct nlattr *root;
+	struct p4tcmsg *t;
+	int ret;
+
+	ret = nla_parse_nested_deprecated(tb, P4TC_MAX, arg, p4tc_policy,
+					  extack);
+	if (ret < 0)
+		return ret;
+
+	t = (struct p4tcmsg *)nlmsg_data(n);
+	if (!obj_is_valid(t->obj)) {
+		NL_SET_ERR_MSG(extack, "Invalid object type");
+		return -EINVAL;
+	}
+
+	nlh = nlmsg_put(skb, portid, n->nlmsg_seq, n->nlmsg_type,
+			sizeof(*t), n->nlmsg_flags);
+	if (!nlh)
+		return -ENOSPC;
+
+	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
+	t_new->obj = t->obj;
+
+	root = nla_nest_start(skb, P4TC_ROOT);
+
+	ids[P4TC_PID_IDX] = t->pipeid;
+
+	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
+	ret = op->dump(skb, ctx, tb[P4TC_PARAMS], &p_name, ids, extack);
+	if (ret <= 0)
+		goto out;
+	nla_nest_end(skb, root);
+
+	if (p_name) {
+		if (nla_put_string(skb, P4TC_ROOT_PNAME, p_name)) {
+			ret = -1;
+			goto out;
+		}
+	}
+
+	if (!t_new->pipeid)
+		t_new->pipeid = ids[P4TC_PID_IDX];
+
+	nlmsg_end(skb, nlh);
+
+	return ret;
+
+out:
+	nlmsg_cancel(skb, nlh);
+	return ret;
+}
+
+static int tc_ctl_p4_tmpl_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	int ret;
+
+	ret = nlmsg_parse(cb->nlh, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, cb->extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(cb->extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(cb->extack,
+			       "Netlink P4TC template attributes missing");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_dump_1(skb, tb[P4TC_ROOT], p_name, cb);
+}
+
+static int __init p4tc_template_init(void)
+{
+	u32 obj_id;
+
+	rtnl_register(PF_UNSPEC, RTM_CREATEP4TEMPLATE, tc_ctl_p4_tmpl_cu, NULL,
+		      0);
+	rtnl_register(PF_UNSPEC, RTM_UPDATEP4TEMPLATE, tc_ctl_p4_tmpl_cu, NULL,
+		      0);
+	rtnl_register(PF_UNSPEC, RTM_DELP4TEMPLATE, tc_ctl_p4_tmpl_delete, NULL,
+		      0);
+	rtnl_register(PF_UNSPEC, RTM_GETP4TEMPLATE, tc_ctl_p4_tmpl_get,
+		      tc_ctl_p4_tmpl_dump, 0);
+
+	for (obj_id = P4TC_OBJ_PIPELINE; obj_id < P4TC_OBJ_MAX + 1; obj_id++) {
+		const struct p4tc_template_ops *op = p4tc_ops[obj_id];
+
+		if (!op)
+			continue;
+
+		if (!obj_is_valid(obj_id))
+			continue;
+
+		if (op->init)
+			op->init();
+	}
+
+	return 0;
+}
+
+subsys_initcall(p4tc_template_init);
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 8ff670cf1..e50a1c1ff 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -94,6 +94,10 @@ static const struct nlmsg_perm nlmsg_route_perms[] = {
 	{ RTM_NEWTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETTUNNEL,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_CREATEP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_UPDATEP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] = {
@@ -177,7 +181,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(RTM_MAX != (RTM_NEWTUNNEL + 3));
+		BUILD_BUG_ON(RTM_MAX != (RTM_CREATEP4TEMPLATE + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
 		break;
-- 
2.34.1


