Return-Path: <bpf+bounces-20032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333E83731F
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0911F2B85C
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA2E4779D;
	Mon, 22 Jan 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="p33mA0kv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2244177A
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952903; cv=none; b=LcpNQHpm9r5KJHgKEgCjeofIXbr1gj9YsL1UmXGjJUZWcEP7UBx+8N0ZTMnU9heqrimCllF6WfNp9bPaKJ+2HbCOcQc7KiOdbp32qaZMHJtjsjLK5sI0dwScvC0nYoxCf08rT/cgTe+ymcl7znOxzz/TARk+mEC7UqVycqtFMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952903; c=relaxed/simple;
	bh=429Nc/0D1vw/zAXsBKXzyfCLH1Vbh06vXUVE9IgHDdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ff+5hCbpZcl0Gviw5IgWYUMd1Jg5ohoDiybXYQSgf7BK47lIa/gmAkuKXMVu4j5KnBpDq2RwW5hUA+WS9eUM8tobyxfn59gbkaZYilWM+2FRndsWNCdL0tQ1+tP+JfoAQODkoZVC8193nTfsd10dTvQaFNje/lR+df8y3SN7LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=p33mA0kv; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6818a9fe380so22785956d6.2
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952899; x=1706557699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eEnE2NDWf5yARjlkulJZGLyd8j/9kFVJRP4cnrFp90=;
        b=p33mA0kvQ6pMzEaUxSu3dh+dGqlEoknLvFLwmqiXAQYbtBdv6vrbdGgBUJgq7upOua
         MqcRy7z+5kjA4j164QnJhHXJkJE5ZeT44L8S/z8wZh+K0pL4mBYnLUcVTN9jGuYZNoL8
         ZWqajU/3AD8q0DPGz2eVw0UuV0wlu4PErOs3m1+GcIszegH+MGSmU52tLAFZI3Byajbg
         cL/9t8hSOtdYfcGDa2fvDho2nIcvbeI3ShadLIjRC5faTw8G9xMMqB8BrSsFYMZjXuvr
         QdCr/anUOW3/CdHOLSAjYewTjlvwLcvdTUc8J7yihiL+tKFQwRRPc/5r4ago0vBLOFZ+
         DnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952899; x=1706557699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eEnE2NDWf5yARjlkulJZGLyd8j/9kFVJRP4cnrFp90=;
        b=w0M9eDK/DoMwjozQhPOzUlS0QKIUIrN0M7gdzPyZyIeeDMhYQYYkqE7nFxy6/W87cU
         cg9/IgsMn8ZtNGqeQoC70xZQuvaYrWjQrITdxHMpcDLZyIyFikf4MU1UxCivW7LTVmh+
         8/EM0L/omFk5slUD1fWTOHASd8xSp1OF2LasvHuoq9QAh1JxyLlXIsyH0J8QzEz8M17H
         W044zTp1qIuGeSzgh1Tcfpk0BZ+mkChxMl8eDzaQbL3F0Okm8tofoBKMrLJTqWCwtOdM
         QdxKRAAmvVTsrxerfgzwmZTgi2xQKfF2QhxrpifT4yCxHyE2zPN2mnc4uvpCdIWDvXIB
         b1FA==
X-Gm-Message-State: AOJu0Yx/qQNTFLNWDW0bU7cVANs7QVYA4yFv6UXZVJgytG70f7QoEHg+
	mVre8UqqrJxYjgdXc2djkvhSsoSNOBtaN1XA4KOmegGyG/0knd4xTtMAM7uG6A==
X-Google-Smtp-Source: AGHT+IEROrIUTUuAkiWvaWsxsMOV2jRv3xze1UHwmYa0uHI1hYS+lkWicGOPiq/7KPq8uPlZkUwVTw==
X-Received: by 2002:a05:6214:ca2:b0:682:60be:8247 with SMTP id s2-20020a0562140ca200b0068260be8247mr7011856qvs.113.1705952898708;
        Mon, 22 Jan 2024 11:48:18 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:17 -0800 (PST)
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
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH v10 net-next 08/15] p4tc: add template pipeline create, get, update, delete
Date: Mon, 22 Jan 2024 14:47:54 -0500
Message-Id: <20240122194801.152658-9-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122194801.152658-1-jhs@mojatatu.com>
References: <20240122194801.152658-1-jhs@mojatatu.com>
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

This patch relies on the previous one to be functional. They were split
to ease review. In the next release we are planning this and the previous
patch back again.

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

tc filter add $DEV ingress protocol any prio 6 p4 pname aP4proggie \
    action bpf obj $PARSER.o section prog/tc-parser
    action bpf obj $PROGNAME.o section prog/tc-ingress

Instantiates aP4proggie in the ingress of $DEV. One could also attach it to
a block of ports (example tc block 22) as such:

tc filter add block 22 ingress protocol all prio 6 p4 pname aP4proggie \
    action bpf obj $PARSER.o section prog/tc-parser
    action bpf obj $PROGNAME.o section prog/tc-ingress

We can, add a table entry after the pipeline is sealed
(even before instantiating). Like, for example:

tc p4ctrl create aP4proggie/table/cb/aP4table \
      dstAddr 10.10.10.0/24 srcAddr 192.168.0.0/16 prio 16 \
      action drop

Once the pipeline is instantiated on a device or block it cannot be deleted.
It becomes Read-only from the control plane/user space.
The pipeline can be deleted when there are no longer any users left by
destroying all instances.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h             |  78 ++++-
 include/uapi/linux/p4tc.h      |  24 ++
 net/sched/p4tc/Makefile        |   2 +-
 net/sched/p4tc/p4tc_pipeline.c | 614 +++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c | 136 ++++++--
 5 files changed, 825 insertions(+), 29 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_pipeline.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index c99862fe6..33526db51 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -10,28 +10,44 @@
 #include <linux/rhashtable.h>
 #include <linux/rhashtable-types.h>
 
+#define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
+#define P4TC_DEFAULT_MAX_RULES 1
 #define P4TC_PATH_MAX 3
 
+#define P4TC_KERNEL_PIPEID 0
+
+#define P4TC_PID_IDX 0
+
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
 };
 
 struct p4tc_template_common;
 
+struct p4tc_path_nlattrs {
+	char                     *pname;
+	u32                      *ids;
+	bool                     pname_passed;
+};
+
+struct p4tc_pipeline;
 struct p4tc_template_ops {
 	void (*init)(void);
 	struct p4tc_template_common *(*cu)(struct net *net, struct nlmsghdr *n,
 					   struct nlattr *nla,
+					   struct p4tc_path_nlattrs *nl_pname,
 					   struct netlink_ext_ack *extack);
-	int (*put)(struct p4tc_template_common *tmpl,
+	int (*put)(struct p4tc_pipeline *pipeline,
+		   struct p4tc_template_common *tmpl,
 		   struct netlink_ext_ack *extack);
 	int (*gd)(struct net *net, struct sk_buff *skb, struct nlmsghdr *n,
-		  struct nlattr *nla, struct netlink_ext_ack *extack);
+		  struct nlattr *nla, struct p4tc_path_nlattrs *nl_pname,
+		  struct netlink_ext_ack *extack);
 	int (*fill_nlmsg)(struct net *net, struct sk_buff *skb,
 			  struct p4tc_template_common *tmpl,
 			  struct netlink_ext_ack *extack);
 	int (*dump)(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
-		    struct nlattr *nla, u32 *ids,
+		    struct nlattr *nla, char **p_name, u32 *ids,
 		    struct netlink_ext_ack *extack);
 	int (*dump_1)(struct sk_buff *skb, struct p4tc_template_common *common);
 };
@@ -39,6 +55,27 @@ struct p4tc_template_ops {
 struct p4tc_template_common {
 	char                     name[P4TC_TMPL_NAMSZ];
 	struct p4tc_template_ops *ops;
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
 };
 
 static inline bool p4tc_tmpl_msg_is_update(struct nlmsghdr *n)
@@ -50,4 +87,39 @@ int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
 			   struct idr *idr, int idx,
 			   struct netlink_ext_ack *extack);
 
+struct p4tc_pipeline *p4tc_pipeline_find_byany(struct net *net,
+					       const char *p_name,
+					       const u32 pipeid,
+					       struct netlink_ext_ack *extack);
+struct p4tc_pipeline *p4tc_pipeline_find_byid(struct net *net,
+					      const u32 pipeid);
+struct p4tc_pipeline *
+p4tc_pipeline_find_get(struct net *net, const char *p_name,
+		       const u32 pipeid, struct netlink_ext_ack *extack);
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
 #endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 22ba1c05a..8d8ffcb9e 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -7,19 +7,25 @@
 
 /* pipeline header */
 struct p4tcmsg {
+	__u32 pipeid;
 	__u32 obj;
 };
 
+#define P4TC_MAXPIPELINE_COUNT 32
+#define P4TC_MAXTABLES_COUNT 32
+#define P4TC_MINTABLES_COUNT 0
 #define P4TC_MSGBATCH_SIZE 16
 
 #define P4TC_MAX_KEYSZ 512
 
 #define P4TC_TMPL_NAMSZ 32
+#define P4TC_PIPELINE_NAMSIZ P4TC_TMPL_NAMSZ
 
 /* Root attributes */
 enum {
 	P4TC_ROOT_UNSPEC,
 	P4TC_ROOT, /* nested messages */
+	P4TC_ROOT_PNAME, /* string - mandatory for pipeline create */
 	__P4TC_ROOT_MAX,
 };
 
@@ -28,6 +34,7 @@ enum {
 /* P4 Object types */
 enum {
 	P4TC_OBJ_UNSPEC,
+	P4TC_OBJ_PIPELINE,
 	__P4TC_OBJ_MAX,
 };
 
@@ -43,6 +50,23 @@ enum {
 
 #define P4TC_MAX (__P4TC_MAX - 1)
 
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
 	P4TC_T_UNSPEC,
 	P4TC_T_U8,
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index e28dfc6eb..0881a7563 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := p4tc_types.o p4tc_tmpl_api.o
+obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
new file mode 100644
index 000000000..6a4e7d5f7
--- /dev/null
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_pipeline.c	P4 TC PIPELINE
+ *
+ * Copyright (c) 2022-2024, Mojatatu Networks
+ * Copyright (c) 2022-2024, Intel Corporation.
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
+		NLA_POLICY_RANGE(NLA_U16, P4TC_MINTABLES_COUNT,
+				 P4TC_MAXTABLES_COUNT),
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
+	 * to make sure the pipeline and its components are alive while the
+	 * classifier is still visible by the datapath.
+	 * In the netns cleanup, we cannot destroy the pipeline in our netns
+	 * exit callback as the netdevs and filters are still visible in the
+	 * datapath. In such case, it's the filter's job to destroy the
+	 * pipeline.
+	 *
+	 * To accommodate such scenario, whichever put call reaches '0' first
+	 * will destroy the pipeline and its components.
+	 *
+	 * On netns cleanup we guarantee no table entries operations are in
+	 * flight.
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
+static inline bool p4tc_pipeline_sealed(struct p4tc_pipeline *pipeline)
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
+		if (strncmp(pipeline->common.name, name,
+			    P4TC_PIPELINE_NAMSIZ) == 0)
+			return pipeline;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_pipeline *
+p4tc_pipeline_create(struct net *net, struct nlmsghdr *n,
+		     struct nlattr *nla, const char *p_name,
+		     u32 pipeid, struct netlink_ext_ack *extack)
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
+	strscpy(pipeline->common.name, p_name, P4TC_PIPELINE_NAMSIZ);
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
+struct p4tc_pipeline *
+p4tc_pipeline_find_get(struct net *net, const char *p_name,
+		       const u32 pipeid, struct netlink_ext_ack *extack)
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
+	if (p4tc_pipeline_sealed(pipeline)) {
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
+			P4TC_PIPELINE_NAMSIZ);
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
+			P4TC_PIPELINE_NAMSIZ);
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
+	strscpy(root_pipeline->common.name, "kernel", P4TC_PIPELINE_NAMSIZ);
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
index 956f1ad90..1140c128a 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -29,6 +29,7 @@
 
 static const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
 	[P4TC_ROOT] = { .type = NLA_NESTED },
+	[P4TC_ROOT_PNAME] = { .type = NLA_STRING, .len = P4TC_PIPELINE_NAMSIZ },
 };
 
 static const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
@@ -40,12 +41,15 @@ static const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
 static bool obj_is_valid(u32 obj)
 {
 	switch (obj) {
+	case P4TC_OBJ_PIPELINE:
+		return true;
 	default:
 		return false;
 	}
 }
 
 static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX + 1] = {
+	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
 };
 
 int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
@@ -100,16 +104,15 @@ int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
 
 static int tc_ctl_p4_tmpl_gd_1(struct net *net, struct sk_buff *skb,
 			       struct nlmsghdr *n, struct nlattr *arg,
+			       struct p4tc_path_nlattrs *nl_path_attrs,
 			       struct netlink_ext_ack *extack)
 {
 	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
 	struct p4tc_template_ops *obj_op;
 	struct nlattr *tb[P4TC_MAX + 1];
+	u32 ids[P4TC_PATH_MAX] = {};
 	int ret;
 
-	/* All checks will fail at this point because obj_is_valid will return
-	 * false. The next patch will make this functional
-	 */
 	if (!obj_is_valid(t->obj)) {
 		NL_SET_ERR_MSG(extack, "Invalid object type");
 		return -EINVAL;
@@ -119,26 +122,35 @@ static int tc_ctl_p4_tmpl_gd_1(struct net *net, struct sk_buff *skb,
 	if (ret < 0)
 		return ret;
 
+	ids[P4TC_PID_IDX] = t->pipeid;
+
+	nl_path_attrs->ids = ids;
+
 	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
 
-	ret = obj_op->gd(net, skb, n, tb[P4TC_PARAMS], extack);
+	ret = obj_op->gd(net, skb, n, tb[P4TC_PARAMS], nl_path_attrs, extack);
 	if (ret < 0)
 		return ret;
 
+	if (!t->pipeid)
+		t->pipeid = ids[P4TC_PID_IDX];
+
 	return ret;
 }
 
 static int tc_ctl_p4_tmpl_gd_n(struct sk_buff *skb, struct nlmsghdr *n,
-			       struct nlattr *nla, int event,
+			       char *p_name, struct nlattr *nla, int event,
 			       struct netlink_ext_ack *extack)
 {
 	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct p4tc_path_nlattrs nl_path_attrs = {0};
 	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
 	struct p4tcmsg *t_new;
 	struct sk_buff *nskb;
 	struct nlmsghdr *nlh;
+	struct nlattr *pnatt;
 	struct nlattr *root;
 	int ret = 0;
 	int i;
@@ -159,13 +171,31 @@ static int tc_ctl_p4_tmpl_gd_n(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 
 	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
 	t_new->obj = t->obj;
 
+	pnatt = nla_reserve(nskb, P4TC_ROOT_PNAME, P4TC_PIPELINE_NAMSIZ);
+	if (!pnatt) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nl_path_attrs.pname = nla_data(pnatt);
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_path_attrs.pname, 0, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = false;
+	} else {
+		strscpy(nl_path_attrs.pname, p_name, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = true;
+	}
+
 	root = nla_nest_start(nskb, P4TC_ROOT);
 	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
 		struct nlattr *nest = nla_nest_start(nskb, i);
 
-		ret = tc_ctl_p4_tmpl_gd_1(net, nskb, nlh, tb[i], extack);
+		ret = tc_ctl_p4_tmpl_gd_1(net, nskb, nlh, tb[i], &nl_path_attrs,
+					  extack);
 		if (n->nlmsg_flags & NLM_F_ROOT && event == RTM_DELP4TEMPLATE) {
 			if (ret <= 0)
 				goto out;
@@ -193,6 +223,7 @@ static int tc_ctl_p4_tmpl_get(struct sk_buff *skb, struct nlmsghdr *n,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret;
 
 	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
@@ -206,7 +237,10 @@ static int tc_ctl_p4_tmpl_get(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EINVAL;
 	}
 
-	return tc_ctl_p4_tmpl_gd_n(skb, n, tb[P4TC_ROOT],
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_gd_n(skb, n, p_name, tb[P4TC_ROOT],
 				   RTM_GETP4TEMPLATE, extack);
 }
 
@@ -214,6 +248,7 @@ static int tc_ctl_p4_tmpl_delete(struct sk_buff *skb, struct nlmsghdr *n,
 				 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret;
 
 	if (!netlink_capable(skb, CAP_NET_ADMIN))
@@ -230,7 +265,10 @@ static int tc_ctl_p4_tmpl_delete(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EINVAL;
 	}
 
-	return tc_ctl_p4_tmpl_gd_n(skb, n, tb[P4TC_ROOT],
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_gd_n(skb, n, p_name, tb[P4TC_ROOT],
 				   RTM_DELP4TEMPLATE, extack);
 }
 
@@ -239,22 +277,23 @@ static int p4tc_template_put(struct net *net,
 			     struct netlink_ext_ack *extack)
 {
 	/* Every created template is bound to a pipeline */
-	return common->ops->put(common, extack);
+	struct p4tc_pipeline *pipeline =
+		p4tc_pipeline_find_byid(net, common->p_id);
+	return common->ops->put(pipeline, common, extack);
 }
 
 static struct p4tc_template_common *
 p4tc_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
-	       struct nlattr *nla, struct netlink_ext_ack *extack)
+	       struct p4tc_path_nlattrs *nl_path_attrs, struct nlattr *nla,
+	       struct netlink_ext_ack *extack)
 {
 	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
 	struct p4tc_template_common *tmpl;
 	struct p4tc_template_ops *obj_op;
 	struct nlattr *tb[P4TC_MAX + 1];
+	u32 ids[P4TC_PATH_MAX] = {};
 	int ret;
 
-	/* All checks will fail at this point because obj_is_valid will return
-	 * false. The next patch will make this functional
-	 */
 	if (!obj_is_valid(t->obj)) {
 		NL_SET_ERR_MSG(extack, "Invalid object type");
 		ret = -EINVAL;
@@ -271,8 +310,11 @@ p4tc_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
 		goto out;
 	}
 
+	ids[P4TC_PID_IDX] = t->pipeid;
+	nl_path_attrs->ids = ids;
+
 	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
-	tmpl = obj_op->cu(net, n, tb[P4TC_PARAMS], extack);
+	tmpl = obj_op->cu(net, n, tb[P4TC_PARAMS], nl_path_attrs, extack);
 	if (IS_ERR(tmpl))
 		return tmpl;
 
@@ -280,6 +322,9 @@ p4tc_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
 	if (ret < 0)
 		goto put;
 
+	if (!t->pipeid)
+		t->pipeid = ids[P4TC_PID_IDX];
+
 	return tmpl;
 
 put:
@@ -290,17 +335,20 @@ p4tc_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
 }
 
 static int p4tc_tmpl_cu_n(struct sk_buff *skb, struct nlmsghdr *n,
-			  struct nlattr *nla, struct netlink_ext_ack *extack)
+			  struct nlattr *nla, char *p_name,
+			  struct netlink_ext_ack *extack)
 {
 	struct p4tc_template_common *tmpls[P4TC_MSGBATCH_SIZE];
 	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
 	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
 	bool update = p4tc_tmpl_msg_is_update(n);
+	struct p4tc_path_nlattrs nl_path_attrs;
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
 	struct p4tcmsg *t_new;
 	struct sk_buff *nskb;
 	struct nlmsghdr *nlh;
+	struct nlattr *pnatt;
 	struct nlattr *root;
 	int ret;
 	int i;
@@ -324,8 +372,25 @@ static int p4tc_tmpl_cu_n(struct sk_buff *skb, struct nlmsghdr *n,
 		ret = -EINVAL;
 		goto out;
 	}
+	t_new->pipeid = t->pipeid;
 	t_new->obj = t->obj;
 
+	pnatt = nla_reserve(nskb, P4TC_ROOT_PNAME, P4TC_PIPELINE_NAMSIZ);
+	if (!pnatt) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nl_path_attrs.pname = nla_data(pnatt);
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_path_attrs.pname, 0, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = false;
+	} else {
+		strscpy(nl_path_attrs.pname, p_name, P4TC_PIPELINE_NAMSIZ);
+		nl_path_attrs.pname_passed = true;
+	}
+
 	root = nla_nest_start(nskb, P4TC_ROOT);
 	if (!root) {
 		ret = -ENOMEM;
@@ -335,8 +400,8 @@ static int p4tc_tmpl_cu_n(struct sk_buff *skb, struct nlmsghdr *n,
 	for (i = 0; i < P4TC_MSGBATCH_SIZE && tb[i + 1]; i++) {
 		struct nlattr *nest = nla_nest_start(nskb, i + 1);
 
-		tmpls[i] = p4tc_tmpl_cu_1(nskb, net, nlh, tb[i + 1],
-					  extack);
+		tmpls[i] = p4tc_tmpl_cu_1(nskb, net, nlh, &nl_path_attrs,
+					  tb[i + 1], extack);
 		if (IS_ERR(tmpls[i])) {
 			ret = PTR_ERR(tmpls[i]);
 			if (i > 0 && update) {
@@ -351,6 +416,9 @@ static int p4tc_tmpl_cu_n(struct sk_buff *skb, struct nlmsghdr *n,
 nest_end_root:
 	nla_nest_end(nskb, root);
 
+	if (!t_new->pipeid)
+		t_new->pipeid = ret;
+
 	nlmsg_end(nskb, nlh);
 
 	return rtnetlink_send(nskb, net, portid, RTNLGRP_TC,
@@ -374,6 +442,7 @@ static int tc_ctl_p4_tmpl_cu(struct sk_buff *skb, struct nlmsghdr *n,
 			     struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret = 0;
 
 	if (!netlink_capable(skb, CAP_NET_ADMIN))
@@ -390,11 +459,14 @@ static int tc_ctl_p4_tmpl_cu(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EINVAL;
 	}
 
-	return p4tc_tmpl_cu_n(skb, n, tb[P4TC_ROOT], extack);
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return p4tc_tmpl_cu_n(skb, n, tb[P4TC_ROOT], p_name, extack);
 }
 
 static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
-				 struct netlink_callback *cb)
+				 char *p_name, struct netlink_callback *cb)
 {
 	struct p4tc_dump_ctx *ctx = (void *)cb->ctx;
 	struct netlink_ext_ack *extack = cb->extack;
@@ -415,9 +487,6 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
 		return ret;
 
 	t = (struct p4tcmsg *)nlmsg_data(n);
-	/* All checks will fail at this point because obj_is_valid will return
-	 * false. The next patch will make this functional
-	 */
 	if (!obj_is_valid(t->obj)) {
 		NL_SET_ERR_MSG(extack, "Invalid object type");
 		return -EINVAL;
@@ -429,16 +498,29 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
 		return -ENOSPC;
 
 	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
 	t_new->obj = t->obj;
 
 	root = nla_nest_start(skb, P4TC_ROOT);
 
+	ids[P4TC_PID_IDX] = t->pipeid;
+
 	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
-	ret = obj_op->dump(skb, ctx, tb[P4TC_PARAMS], ids, extack);
+	ret = obj_op->dump(skb, ctx, tb[P4TC_PARAMS], &p_name, ids, extack);
 	if (ret <= 0)
 		goto out;
 	nla_nest_end(skb, root);
 
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
 	nlmsg_end(skb, nlh);
 
 	return ret;
@@ -451,6 +533,7 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
 static int tc_ctl_p4_tmpl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret;
 
 	ret = nlmsg_parse(cb->nlh, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
@@ -464,7 +547,10 @@ static int tc_ctl_p4_tmpl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		return -EINVAL;
 	}
 
-	return tc_ctl_p4_tmpl_dump_1(skb, tb[P4TC_ROOT], cb);
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_dump_1(skb, tb[P4TC_ROOT], p_name, cb);
 }
 
 static int __init p4tc_template_init(void)
@@ -480,7 +566,7 @@ static int __init p4tc_template_init(void)
 	rtnl_register(PF_UNSPEC, RTM_GETP4TEMPLATE, tc_ctl_p4_tmpl_get,
 		      tc_ctl_p4_tmpl_dump, 0);
 
-	for (obj_id = 0; obj_id < P4TC_OBJ_MAX + 1; obj_id++) {
+	for (obj_id = P4TC_OBJ_PIPELINE; obj_id < P4TC_OBJ_MAX + 1; obj_id++) {
 		const struct p4tc_template_ops *op = p4tc_ops[obj_id];
 
 		if (!op)
-- 
2.34.1


