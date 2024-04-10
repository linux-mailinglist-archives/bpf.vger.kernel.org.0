Return-Path: <bpf+bounces-26432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C83D689F966
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64EF0B2A025
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099EF16E882;
	Wed, 10 Apr 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="V1eceetY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF116DEC5
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757719; cv=none; b=HgdB2Qvc5q+wADj7Xuans5OTJFm0MCsWj6CPWhMDcxjnpKEkeTfc2PU4rbBgeB3iFMEU9uIvDQcVPn0gIthWHaYKmArRcsiRJLBeo8sDKaXsAl+HHsPt1v8ZGvToJoABuHth3S8unFjorIL/avr+65GcFeVRAzkigzf9Zh6/Kug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757719; c=relaxed/simple;
	bh=pwhQ0v+eA5rgTfMrzY92OAcXP+brf3+zGwuXPJy0tOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVQuHtZpFO9+kJlJ9gzFVtblEycN56mnNzMlmcqMfaYqGldbMk7ZHj+1sC5C/CcAdIAwVuQuqdO6dtDEd077NecngqsVYR5NNWQy09ugWwDNe//kg5l+70Lfs6/ehhhtwiwJlZY3D4qnQpyip4f1DUK2QyUdEoM47EFAwpv7ZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=V1eceetY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78a3bccc41dso281419385a.0
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757716; x=1713362516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cL0be+wrEMx1vqnHtB/dPWZAn2/lpQsFCsWMpg3YKM=;
        b=V1eceetY9KM6pyuXcgmoMldI2ldjxyPGB9TehiaZxyKKDaFwAktqvD5ONKkFWUSGAd
         Tyu5TNG6Nv5pvbxx7k/EK3oKLo7gu+iRRtRwfV3cadOqCxFuY99OoJhxJTr0e83Zuj/s
         5Blme9vSEGs+KXhG2r3zMZovUISlQXXKl7WCMxCi7zmvMkFC8/3P0rgnDm4kGOqrTWHk
         FOYXsdrbjgORFtsihy2eP46l+yyWke/Y44h4IzHh3254bdxcf7oAJhMqVm9rcVFzUB2J
         SC026VgNtAvuXloDOTqEupaXYKItKmfb1YLKwoaCmYd/GS6XOn14ll6O3G5i0p7mm3B6
         MVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757716; x=1713362516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cL0be+wrEMx1vqnHtB/dPWZAn2/lpQsFCsWMpg3YKM=;
        b=RyU+3iRF/5fn+DPiSxLBPhpA4a/whEGG82Kc4UT/C/RhxQQIlb09RR1nKFR+0MXK5+
         o7vssWnZnaoQgNIft5RMh2a4CQy+bkQC08DF00Bx0cJBxa78cBarck5vaHazz0tWYmBA
         PNsQPTgyvH0RCuAVecE3vBG+E9Gx80ORiRRSCMlZj2rxDx1Nzp6EYt82PyfJYvlR4PVr
         vxe9ipWyQ9SexSPgvMwpY2W9kbd6Ou1peJkiLf8x9cKDDoINT5Jnl3xlEQRSP7OkV+4Y
         tAiq9ebDnzfe4xcDkRrFJMYH/4sFaeDR7p9E2RY4vnrx/hmF15jIdMyMEXMkh6VOhc4x
         OnIA==
X-Forwarded-Encrypted: i=1; AJvYcCUe8HqhGcPO2F0POy5OW35DSwnYZ3c92i/lCt9gzhq7Nsd6BomkKPdilHG7++53pWhLjKS+bLtHzApWxsFySbZmUYpO
X-Gm-Message-State: AOJu0Yy5gKioljGQQVL0zX0mEhiLqe3VSSOQ7QJz4F12arG92SNbwiiL
	S8ZjyQ1DdMVUFtAHnRePZGENQtPhhQbR7Gqfz8FsPGCiRYYg2cDmpmnpXnBXFcmk4U3knIuHK6c
	=
X-Google-Smtp-Source: AGHT+IFCusDecH4yIRZwm0xxLpsVRbK1e6n77SI6B/QSlaNb0cIV/f+VLBbtRlpPQ6q/L7PgaCBa7w==
X-Received: by 2002:a37:e30c:0:b0:78d:47bc:3129 with SMTP id y12-20020a37e30c000000b0078d47bc3129mr2642255qki.39.1712757715690;
        Wed, 10 Apr 2024 07:01:55 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:01:55 -0700 (PDT)
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
Subject: [PATCH net-next v16  08/15] p4tc: add template pipeline create, get, update, delete
Date: Wed, 10 Apr 2024 10:01:34 -0400
Message-Id: <20240410140141.495384-9-jhs@mojatatu.com>
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

__Introducing P4 TC Pipeline__

This commit introduces P4 TC pipelines, which emulate the semantics of a
P4 program/pipeline using the TC infrastructure.

This patch relies on the previous one to be functional. They were split
to ease review.

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

Note: if no pipeid is specified, the kernel will issue one. To see what
pipeline ID is issued, one would add -echo option and the response back
from the kernel will contain the details:

tc -echo p4template create pipeline/aP4proggie numtables 1

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

After _Create_ is issued, one can Read/get, Update and Delete pipeline
objects; however the pipeline can only be put to use after it is "sealed".
To seal a pipeline, one would issue the following command:

tc p4template update pipeline/aP4proggie state ready

After a pipeline is sealed it can be instantiated via the TC P4 classifier.
For example:

tc filter add $DEV ingress protocol any prio 6 p4 pname aP4proggie \
    action bpf obj $PARSER.o section p4tc/parse
    action bpf obj $PROGNAME.o section p4tc/main

Instantiates aP4proggie in the ingress of $DEV. One could also attach it to
a block of ports (example tc block 22) as such:

tc filter add block 22 ingress protocol all prio 6 p4 pname aP4proggie \
    action bpf obj $PARSER.o section p4tc/parse
    action bpf obj $PROGNAME.o section p4tc/main

We can, add a table entry after the pipeline is sealed
(even before instantiating). Like, for example:

tc p4ctrl create aP4proggie/table/cb/aP4table \
      dstAddr 10.10.10.0/24 srcAddr 192.168.0.0/16 prio 16 \
      action drop

Once the pipeline is instantiated on a device or block it cannot be
deleted. It becomes Read-only from the control plane/user space.
The pipeline can be deleted when there are no longer any users left by
destroying all instances (i.e all instantiated filters are deleted).

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/p4tc.h             |  66 +++-
 include/uapi/linux/p4tc.h      |  24 ++
 net/sched/p4tc/Makefile        |   2 +-
 net/sched/p4tc/p4tc_pipeline.c | 634 +++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c | 101 +++++-
 5 files changed, 807 insertions(+), 20 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_pipeline.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index e55d7b0b67cb..79e64859fe57 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -10,27 +10,43 @@
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
 	u32 obj_id;
@@ -39,6 +55,25 @@ struct p4tc_template_ops {
 struct p4tc_template_common {
 	char                     name[P4TC_TMPL_NAMSZ];
 	struct p4tc_template_ops *ops;
+	u32                      p_id;
+	u32                      __pad0;
+};
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
@@ -46,8 +81,33 @@ static inline bool p4tc_tmpl_msg_is_update(struct nlmsghdr *n)
 	return n->nlmsg_type == RTM_UPDATEP4TEMPLATE;
 }
 
+int p4tc_tmpl_register_ops(const struct p4tc_template_ops *tmpl_ops);
+
 int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
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
+#define to_pipeline(t) ((struct p4tc_pipeline *)t)
+
 #endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 22ba1c05aa57..8d8ffcb9e680 100644
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
index e28dfc6eb644..0881a7563646 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := p4tc_types.o p4tc_tmpl_api.o
+obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
new file mode 100644
index 000000000000..e68f5b637aed
--- /dev/null
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -0,0 +1,634 @@
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
+static int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
+					struct netlink_ext_ack *extack)
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
+static bool p4tc_pipeline_sealed(struct p4tc_pipeline *pipeline)
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
+static const struct p4tc_template_ops p4tc_pipeline_ops;
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
+static const struct p4tc_template_ops p4tc_pipeline_ops = {
+	.cu = p4tc_pipeline_cu,
+	.fill_nlmsg = p4tc_pipeline_fill_nlmsg,
+	.gd = p4tc_pipeline_gd,
+	.put = __p4tc_pipeline_put,
+	.dump = p4tc_pipeline_dump,
+	.dump_1 = p4tc_pipeline_dump_1,
+	.obj_id = P4TC_OBJ_PIPELINE,
+};
+
+static int __p4tc_pipeline_init(void)
+{
+	int pipeid = P4TC_KERNEL_PIPEID;
+
+	root_pipeline = kzalloc(sizeof(*root_pipeline), GFP_ATOMIC);
+	if (unlikely(!root_pipeline)) {
+		pr_err("Unable to register kernel pipeline\n");
+		return -ENOMEM;
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
+
+	return 0;
+}
+
+static int __init p4tc_pipeline_init(void)
+{
+	if (register_pipeline_pernet() < 0) {
+		pr_err("Failed to register per net pipeline IDR");
+		return 0;
+	}
+
+	if (p4tc_register_types() < 0) {
+		pr_err("Failed to register P4 types");
+		goto unregister_pipeline_pernet;
+	}
+
+	if (__p4tc_pipeline_init() < 0)
+		goto unregister_types;
+
+	p4tc_tmpl_register_ops(&p4tc_pipeline_ops);
+
+	return 0;
+
+unregister_types:
+	p4tc_unregister_types();
+
+unregister_pipeline_pernet:
+	unregister_pernet_subsys(&pipeline_net_ops);
+	return 0;
+}
+
+subsys_initcall(p4tc_pipeline_init);
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index bbc0c7a058b0..bb973071a025 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -29,6 +29,7 @@
 
 static const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
 	[P4TC_ROOT] = { .type = NLA_NESTED },
+	[P4TC_ROOT_PNAME] = { .type = NLA_STRING, .len = P4TC_PIPELINE_NAMSIZ },
 };
 
 static const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
@@ -47,6 +48,16 @@ static bool obj_is_valid(u32 obj_id)
 	return !!p4tc_ops[obj_id];
 }
 
+int p4tc_tmpl_register_ops(const struct p4tc_template_ops *tmpl_ops)
+{
+	if (tmpl_ops->obj_id > P4TC_OBJ_MAX)
+		return -EINVAL;
+
+	p4tc_ops[tmpl_ops->obj_id] = tmpl_ops;
+
+	return 0;
+}
+
 int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
 			   struct idr *idr, int idx,
 			   struct netlink_ext_ack *extack)
@@ -102,7 +113,9 @@ static int p4tc_template_put(struct net *net,
 			     struct netlink_ext_ack *extack)
 {
 	/* Every created template is bound to a pipeline */
-	return common->ops->put(common, extack);
+	struct p4tc_pipeline *pipeline =
+		p4tc_pipeline_find_byid(net, common->p_id);
+	return common->ops->put(pipeline, common, extack);
 }
 
 static int tc_ctl_p4_tmpl_1_send(struct sk_buff *skb, struct net *net,
@@ -116,23 +129,24 @@ static int tc_ctl_p4_tmpl_1_send(struct sk_buff *skb, struct net *net,
 }
 
 static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
-			    struct nlattr *nla, struct netlink_ext_ack *extack)
+			    struct nlattr *nla, const char *p_name,
+			    struct netlink_ext_ack *extack)
 {
 	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	struct p4tc_path_nlattrs nl_path_attrs = {0};
 	struct net *net = sock_net(skb->sk);
 	u32 portid = NETLINK_CB(skb).portid;
 	struct p4tc_template_common *tmpl;
 	struct p4tc_template_ops *obj_op;
 	struct nlattr *tb[P4TC_MAX + 1];
+	u32 ids[P4TC_PATH_MAX] = {};
 	struct p4tcmsg *t_new;
+	struct nlattr *pnatt;
 	struct nlmsghdr *nlh;
 	struct sk_buff *nskb;
 	struct nlattr *root;
 	int ret;
 
-	/* All checks will fail at this point because obj_is_valid will return
-	 * false. The next patch will make this functional
-	 */
 	if (!obj_is_valid(t->obj)) {
 		NL_SET_ERR_MSG(extack, "Invalid object type");
 		return -EINVAL;
@@ -142,6 +156,10 @@ static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
 	if (ret < 0)
 		return ret;
 
+	ids[P4TC_PID_IDX] = t->pipeid;
+
+	nl_path_attrs.ids = ids;
+
 	nskb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!nskb)
 		return -ENOMEM;
@@ -154,8 +172,25 @@ static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 
 	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
 	t_new->obj = t->obj;
 
+	pnatt = nla_reserve(nskb, P4TC_ROOT_PNAME, P4TC_PIPELINE_NAMSIZ);
+	if (!pnatt) {
+		ret = -ENOMEM;
+		goto free_skb;
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
@@ -163,6 +198,7 @@ static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 
 	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
+
 	switch (n->nlmsg_type) {
 	case RTM_CREATEP4TEMPLATE:
 	case RTM_UPDATEP4TEMPLATE:
@@ -172,7 +208,8 @@ static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
 			ret = -EINVAL;
 			goto free_skb;
 		}
-		tmpl = obj_op->cu(net, n, tb[P4TC_PARAMS], extack);
+		tmpl = obj_op->cu(net, n, tb[P4TC_PARAMS], &nl_path_attrs,
+				  extack);
 		if (IS_ERR(tmpl)) {
 			ret = PTR_ERR(tmpl);
 			goto free_skb;
@@ -186,7 +223,8 @@ static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
 		break;
 	case RTM_DELP4TEMPLATE:
 	case RTM_GETP4TEMPLATE:
-		ret = obj_op->gd(net, nskb, n, tb[P4TC_PARAMS], extack);
+		ret = obj_op->gd(net, nskb, n, tb[P4TC_PARAMS], &nl_path_attrs,
+				 extack);
 		if (ret < 0)
 			goto free_skb;
 		break;
@@ -195,6 +233,11 @@ static int tc_ctl_p4_tmpl_1(struct sk_buff *skb, struct nlmsghdr *n,
 		goto free_skb;
 	}
 
+	if (!t->pipeid)
+		t_new->pipeid = ids[P4TC_PID_IDX];
+
+	nla_nest_end(nskb, root);
+
 	nlmsg_end(nskb, nlh);
 
 	return tc_ctl_p4_tmpl_1_send(nskb, net, nlh, portid);
@@ -209,6 +252,7 @@ static int tc_ctl_p4_tmpl_get(struct sk_buff *skb, struct nlmsghdr *n,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret;
 
 	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
@@ -222,13 +266,17 @@ static int tc_ctl_p4_tmpl_get(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EINVAL;
 	}
 
-	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], extack);
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], p_name, extack);
 }
 
 static int tc_ctl_p4_tmpl_delete(struct sk_buff *skb, struct nlmsghdr *n,
 				 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret;
 
 	if (!netlink_capable(skb, CAP_NET_ADMIN))
@@ -245,13 +293,17 @@ static int tc_ctl_p4_tmpl_delete(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EINVAL;
 	}
 
-	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], extack);
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], p_name, extack);
 }
 
 static int tc_ctl_p4_tmpl_cu(struct sk_buff *skb, struct nlmsghdr *n,
 			     struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret = 0;
 
 	if (!netlink_capable(skb, CAP_NET_ADMIN))
@@ -268,11 +320,14 @@ static int tc_ctl_p4_tmpl_cu(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EINVAL;
 	}
 
-	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], extack);
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_1(skb, n, tb[P4TC_ROOT], p_name, extack);
 }
 
 static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
-				 struct netlink_callback *cb)
+				 char *p_name, struct netlink_callback *cb)
 {
 	struct p4tc_dump_ctx *ctx = (void *)cb->ctx;
 	struct netlink_ext_ack *extack = cb->extack;
@@ -293,9 +348,6 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
 		return ret;
 
 	t = (struct p4tcmsg *)nlmsg_data(n);
-	/* All checks will fail at this point because obj_is_valid will return
-	 * false. The next patch will make this functional
-	 */
 	if (!obj_is_valid(t->obj)) {
 		NL_SET_ERR_MSG(extack, "Invalid object type");
 		return -EINVAL;
@@ -307,16 +359,29 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
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
@@ -329,6 +394,7 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
 static int tc_ctl_p4_tmpl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
 	int ret;
 
 	ret = nlmsg_parse(cb->nlh, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
@@ -342,7 +408,10 @@ static int tc_ctl_p4_tmpl_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		return -EINVAL;
 	}
 
-	return tc_ctl_p4_tmpl_dump_1(skb, tb[P4TC_ROOT], cb);
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	return tc_ctl_p4_tmpl_dump_1(skb, tb[P4TC_ROOT], p_name, cb);
 }
 
 static int __init p4tc_template_init(void)
-- 
2.34.1


