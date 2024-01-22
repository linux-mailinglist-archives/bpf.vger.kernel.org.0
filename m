Return-Path: <bpf+bounces-20033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF4837320
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF011C29A04
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE01C47A4C;
	Mon, 22 Jan 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DRK6xwEH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DB14644D
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952904; cv=none; b=d709vyTSp4feWTFGC9Mpym0JpJkcQPJxRJy/e/CQ8wI8co/8B0qFMdfm4Hy3dYuLnM3sYlxJclFMGtz6XTObLVzLwY+ndzLQrEEGL4u/0Re5cAVHaLBF/n2LFI1Ci5m//ZnpgVeN5NgpZ7iRpwTOptWsv/w7iD1wDiljhOjMJIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952904; c=relaxed/simple;
	bh=P4zvWsa1DYZ2NXbHIy6mZ2lnqhxyIz9MKoG7Y5YVw7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCuk+Vzx6nAvzgPH7QnsoxH3xMjZe0NP3iZal1LZm6nYTy2P7eAcPZ1rC6Tkd6xdwEMtUVgzHNGaY+Hl+bOFEh0YX8saHuCxTQdvFXvyMt3tGFRKBf/6Kr1s+n8regr4DedA6Pm+nBKYYocpE07v5o5R0UzoJSdrvuk/SVhJwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=DRK6xwEH; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso3867518276.3
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952900; x=1706557700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWYNGXT557DCA48H2MbqjGqqyR0fXIciroN3GfUr4OI=;
        b=DRK6xwEHwYeqradqtyix6mlO8RomEVpM/TFECIE/VhwIpR0LFSq4zQswWTENXUPMFY
         iOJ/0U3T+TCJZ3atbkSkHpAPu4EmsQqgKmUOMxn7B3HJKw+oyVGkGtblk1PimMyijTAU
         8PZ9Ql+b+ZR7z25sODWQWIE31mo0SzjOv4ogUVGVMvVsgdUwOD0XkqsBvkMEZCd9FUeU
         fKSReeGSOMu1IN8v6HFkaVD8GjHs0KOJxMRcQWxqpStxi13AFCgwJEqy7gxjtX3Awxvf
         FJgERdXhgzR6OtFQKNfsOkTSnqLbFfC8a4WPoqaFgcQlf0tmMbVikDkkfiZXNMnqjpEJ
         YR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952900; x=1706557700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWYNGXT557DCA48H2MbqjGqqyR0fXIciroN3GfUr4OI=;
        b=HjByGLdEBk/UQKILGw/2fH0eOpdrOd23nFDAb5+OZ81+cio5bA7wqv5zy5+ETXnRIz
         p5vWZYKXtXfEm8nCthcpa16IopjMC0Czjf8bK4lyJ/wE4ndzGW9uLEH/NIhLc4MpEIgJ
         LzhnwUmRFyMfJacL3eTRBgSu5AoC8Rs07BO3eEwlQZYWyTrCgdf4xIbdSM4cx/DXYtNH
         StBsH1qXZkXtOXG0rPc8TgTkWouZeqyz52AYmsRe9rzEUx2AKAH2B6wxqOzJG35kbAHQ
         L2YHPG+q2v6S3lmwaRvojN9r9Mjh6xcqIqFnLvCOg5674NYTqiwgma4zWHadQM2ToLwM
         aj4Q==
X-Gm-Message-State: AOJu0Yy6mGfRox5KAahRJslM5o1B1ZqfhUy/+7R7OBW2J5/cvMQ6vcjB
	/YWL69Kv5xbsoUzqEFJoob01e8x/w3iham+TJ/TRYKh8gKlhjFy3o0c2R/feTw==
X-Google-Smtp-Source: AGHT+IEvi81qnVriJpt0CV56XQfWN9W62Y2vHlEQvReGaHsyANDgalXmm6xNCIUR9oCJ4QWxaCPr4A==
X-Received: by 2002:a25:8887:0:b0:dc2:41de:b744 with SMTP id d7-20020a258887000000b00dc241deb744mr2456854ybl.32.1705952900280;
        Mon, 22 Jan 2024 11:48:20 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:19 -0800 (PST)
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
Subject: [PATCH v10 net-next 09/15] p4tc: add template action create, update, delete, get, flush and dump
Date: Mon, 22 Jan 2024 14:47:55 -0500
Message-Id: <20240122194801.152658-10-jhs@mojatatu.com>
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

This commit allows the control plane to create, update, delete, get, flush
and dump action templates based on P4 action definitions.

Visualize the following action in a P4 program named aP4Proggie:

action send_nh(@tc_type("macaddr) bit<48> dstAddr, @tc_type("dev") bit<8> port)
{
    hdr.ethernet.dstAddr = dstMac;
    send_to_port(port);
}

The above is an action called send_nh which receives as parameters
a bit<48> dstAddr (a mac address) and a bit<8> port (something close to
ifindex).

which is applied on a P4 table match as such:

table mytable {
        key = {
            hdr.ipv4.dstAddr @tc_type("ipv4"): lpm;
        }

        actions = {
            send_nh;
            drop;
            NoAction;
        }

        size = 1024;
}

The mechanics of actions follow the CRUD semantics which are illustrated
in the text below.

___P4 ACTION KIND CREATION___

In this stage we create the p4 action kind by specifying the action name,
its ID, its parameters and the parameter types.
So for the send_nh action, the creation would look something like
this:

tc p4template create action/aP4proggie/send_nh \
  param dstAddr type macaddr id 1 param port type dev id 2

All the template commands (tc p4template) are generated by the
p4c compiler (but of course could be hand coded by humans).

Also note that an action name has to specify the program name since
P4 actions are unique to a program.  As an example, the
above command creates an action template that is bounded to
pipeline/program named "aP4proggie".

Note2: In P4, actions are assumed to pre-exist and have an upper bound
number of instances. Typically, if you have a max of 1024 "mytable" table
entries you want to allocate enough action instances to cover the 1024
entries. However, this is a big waste of memory when we have low table
occupancy. We pick a middle ground by providing pre-allocation control
via attribute "num_prealloc".
The compiler generated template does not specify it and by default we
preallocate 16 entries. The user can override this value by editing the
generated text, for example to change the number to 128 as such:

tc p4template create action/aP4proggie/send_nh num_prealloc 128 \
  param dstAddr type macaddr id 1 param port type dev id 2

When all preallocated action instances are exhausted (used in table
entries) then the behavior switches to the current tc action approach i.e
for every table entry created a new action instance is dynamically
allocated if no "index" attribute is specified. Once an instance is created it
is added to the pool and never freed.

Note, Current tc action behavior is maintained:

a) If the user wishes to preallocate more actions instance later at runtime
to take advantage of a faster table entry creation (by avoiding dynamic
allocation at table entry creation time), they will have to individually
create actions via the control plane using the classical "tc actions"
command.
For example:

tc actions add action aP4proggie/send_nh \
param dstAddr AA:BB:CC:DD:EE:DD param port eth1

The action is added to the pool of action aP4proggie/send_nh instances and
any table entry creation will grab it. The parameters specified above will
be replaced when the table entry is created.

b) Sharing of action instances works the same way (i.e you could autobind
to any action instance in a table entry creation by specifying the action
"index".

___ACTION KIND ACTIVATION___

Once we provided all the necessary information for the new p4 action,
we can go to the final stage: action activation. In this template stage,
we activate the p4 action and make it available for instantiation.
To activate the action template, we issue the following command:

tc p4template update action/aP4proggie/send_nh state active

___OTHER CONTROL COMMANDS___

The lifetime of the p4 action is tied to its pipeline
(see earlier patches). As with all pipeline components, write operations to
action templates (i.e action kinds), such as create, update and delete, can only
be executed if the pipeline is not sealed. Read/get can be issued even after the
pipeline is sealed.

If, after we are done with our action template we want to delete it, we
could issue the following command:

tc p4template del action/aP4proggie/send_nh

Note: If any instance was created for this action (as illustrated
earlier) than this action cannot be deleted, unless you delete all
instances first.

If we had created more action templates and wanted to flush all of the
action templates from pipeline aP4proggie, one would use the following
command:

tc p4template del action/aP4proggie/

After creating or updating a p4 actions, if one wishes to verify that
the p4 action was created correctly, one would use the following
command:

tc p4template get action/aP4proggie/send_nh

The above command will display the relevant data for the action,
such as parameter names, types, etc.

If one wanted to check which action templates were associated to a specific
pipeline, one could use the following command:

tc p4template get action/aP4proggie/

Note that this command will only display the name of these action
templates. To verify their specific details, one should use the get
command, which was previously described.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h             |    1 +
 include/net/p4tc.h                |   79 ++-
 include/net/tc_act/p4tc.h         |   28 +
 include/uapi/linux/p4tc.h         |   42 ++
 include/uapi/linux/tc_act/tc_p4.h |   11 +
 net/sched/p4tc/Makefile           |    3 +-
 net/sched/p4tc/p4tc_action.c      | 1080 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c    |   16 +-
 net/sched/p4tc/p4tc_tmpl_api.c    |   18 +
 9 files changed, 1267 insertions(+), 11 deletions(-)
 create mode 100644 include/net/tc_act/p4tc.h
 create mode 100644 include/uapi/linux/tc_act/tc_p4.h
 create mode 100644 net/sched/p4tc/p4tc_action.c

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4b6a5bdca..d7c01e397 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -70,6 +70,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
 #define TCA_ACT_FLAGS_PREALLOC	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
 #define TCA_ACT_FLAGS_UNREFERENCED	(1U << (TCA_ACT_FLAGS_USER_BITS + 6))
+#define TCA_ACT_FLAGS_FROM_P4TC	(1U << (TCA_ACT_FLAGS_USER_BITS + 7))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 33526db51..f77028e35 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -9,17 +9,23 @@
 #include <linux/refcount.h>
 #include <linux/rhashtable.h>
 #include <linux/rhashtable-types.h>
+#include <net/tc_act/p4tc.h>
+#include <net/p4tc_types.h>
 
 #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
 #define P4TC_DEFAULT_MAX_RULES 1
 #define P4TC_PATH_MAX 3
+#define P4TC_MAX_TENTRIES 0x2000000
 
 #define P4TC_KERNEL_PIPEID 0
 
 #define P4TC_PID_IDX 0
+#define P4TC_AID_IDX 1
+#define P4TC_PARSEID_IDX 1
 
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
+	struct rhashtable_iter *iter;
 };
 
 struct p4tc_template_common;
@@ -63,8 +69,10 @@ extern const struct p4tc_template_ops p4tc_pipeline_ops;
 
 struct p4tc_pipeline {
 	struct p4tc_template_common common;
+	struct idr                  p_act_idr;
 	struct rcu_head             rcu;
 	struct net                  *net;
+	u32                         num_created_acts;
 	/* Accounts for how many entities are referencing this pipeline.
 	 * As for now only P4 filters can refer to pipelines.
 	 */
@@ -108,18 +116,73 @@ p4tc_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
 				  const u32 pipeid,
 				  struct netlink_ext_ack *extack);
 
-static inline int p4tc_action_destroy(struct tc_action **acts)
-{
-	int ret = 0;
+struct p4tc_act_param {
+	struct list_head head;
+	struct rcu_head	rcu;
+	void            *value;
+	void            *mask;
+	struct p4tc_type *type;
+	u32             id;
+	u32             index;
+	u16             bitend;
+	u8              flags;
+	u8              PAD0;
+	char            name[P4TC_ACT_PARAM_NAMSIZ];
+};
+
+struct p4tc_act_param_ops {
+	int (*init_value)(struct net *net, struct p4tc_act_param_ops *op,
+			  struct p4tc_act_param *nparam, struct nlattr **tb,
+			  struct netlink_ext_ack *extack);
+	int (*dump_value)(struct sk_buff *skb, struct p4tc_act_param_ops *op,
+			  struct p4tc_act_param *param);
+	void (*free)(struct p4tc_act_param *param);
+	u32 len;
+	u32 alloc_len;
+};
+
+struct p4tc_act {
+	struct p4tc_template_common common;
+	struct tc_action_ops        ops;
+	struct tc_action_net        *tn;
+	struct p4tc_pipeline        *pipeline;
+	struct idr                  params_idr;
+	struct tcf_exts             exts;
+	struct list_head            head;
+	struct list_head            prealloc_list;
+	/* Locks the preallocated actions list.
+	 * The list will be used whenever a table entry with an action or a
+	 * table default action gets created, updated or deleted. Note that
+	 * table entries may be added by both control and data path, so the
+	 * list can be modified from both contexts.
+	 */
+	spinlock_t                  list_lock;
+	u32                         a_id;
+	u32                         num_params;
+	u32                         num_prealloc_acts;
+	/* Accounts for how many entities refer to this action. Usually just the
+	 * pipeline it belongs to.
+	 */
+	refcount_t                  a_ref;
+	bool                        active;
+	char                        fullname[ACTNAMSIZ];
+};
+
+extern const struct p4tc_template_ops p4tc_act_ops;
 
-	if (acts) {
-		ret = tcf_action_destroy(acts, TCA_ACT_UNBIND);
-		kfree(acts);
-	}
+struct p4tc_act *p4a_tmpl_get(struct p4tc_pipeline *pipeline,
+			      const char *act_name, const u32 a_id,
+			      struct netlink_ext_ack *extack);
+struct p4tc_act *p4a_tmpl_find_byid(struct p4tc_pipeline *pipeline,
+				    const u32 a_id);
 
-	return ret;
+static inline bool p4tc_action_put_ref(struct p4tc_act *act)
+{
+	return refcount_dec_not_one(&act->a_ref);
 }
 
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
+#define to_hdrfield(t) ((struct p4tc_hdrfield *)t)
+#define p4tc_to_act(t) ((struct p4tc_act *)t)
 
 #endif
diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
new file mode 100644
index 000000000..6447fe5ce
--- /dev/null
+++ b/include/net/tc_act/p4tc.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_TC_ACT_P4_H
+#define __NET_TC_ACT_P4_H
+
+#include <net/pkt_cls.h>
+#include <net/act_api.h>
+
+struct tcf_p4act_params {
+	struct tcf_exts exts;
+	struct idr params_idr;
+	struct p4tc_act_param **params_array;
+	struct rcu_head rcu;
+	u32 num_params;
+	u32 tot_params_sz;
+};
+
+struct tcf_p4act {
+	struct tc_action common;
+	/* Params IDR reference passed during runtime */
+	struct tcf_p4act_params __rcu *params;
+	u32 p_id;
+	u32 act_id;
+	struct list_head node;
+};
+
+#define to_p4act(a) ((struct tcf_p4act *)a)
+
+#endif /* __NET_TC_ACT_P4_H */
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 8d8ffcb9e..b565b8a9e 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -4,6 +4,9 @@
 
 #include <linux/types.h>
 #include <linux/pkt_sched.h>
+#include <linux/pkt_cls.h>
+
+#include <linux/tc_act/tc_p4.h>
 
 /* pipeline header */
 struct p4tcmsg {
@@ -17,9 +20,12 @@ struct p4tcmsg {
 #define P4TC_MSGBATCH_SIZE 16
 
 #define P4TC_MAX_KEYSZ 512
+#define P4TC_DEFAULT_NUM_PREALLOC 16
 
 #define P4TC_TMPL_NAMSZ 32
 #define P4TC_PIPELINE_NAMSIZ P4TC_TMPL_NAMSZ
+#define P4TC_ACT_TMPL_NAMSZ P4TC_TMPL_NAMSZ
+#define P4TC_ACT_PARAM_NAMSIZ P4TC_TMPL_NAMSZ
 
 /* Root attributes */
 enum {
@@ -35,6 +41,7 @@ enum {
 enum {
 	P4TC_OBJ_UNSPEC,
 	P4TC_OBJ_PIPELINE,
+	P4TC_OBJ_ACT,
 	__P4TC_OBJ_MAX,
 };
 
@@ -45,6 +52,7 @@ enum {
 	P4TC_UNSPEC,
 	P4TC_PATH,
 	P4TC_PARAMS,
+	P4TC_COUNT,
 	__P4TC_MAX,
 };
 
@@ -93,6 +101,40 @@ enum {
 
 #define P4TC_T_MAX (__P4TC_T_MAX - 1)
 
+/* Action attributes */
+enum {
+	P4TC_ACT_UNSPEC,
+	P4TC_ACT_NAME, /* string - mandatory for create */
+	P4TC_ACT_PARMS, /* nested params */
+	P4TC_ACT_OPT, /* action opt */
+	P4TC_ACT_TM, /* action tm */
+	P4TC_ACT_ACTIVE, /* u8 */
+	P4TC_ACT_NUM_PREALLOC, /* u32 num preallocated action instances */
+	P4TC_ACT_PAD,
+	__P4TC_ACT_MAX
+};
+
+#define P4TC_ACT_MAX (__P4TC_ACT_MAX - 1)
+enum {
+	P4TC_ACT_PARAMS_TYPE_UNSPEC,
+	P4TC_ACT_PARAMS_TYPE_BITEND, /* u16 */
+	P4TC_ACT_PARAMS_TYPE_CONTAINER_ID, /* u32 */
+	__P4TC_ACT_PARAMS_TYPE_MAX
+};
+
+#define P4TC_ACT_PARAMS_TYPE_MAX (__P4TC_ACT_PARAMS_TYPE_MAX - 1)
+
+/* Action params attributes */
+enum {
+	P4TC_ACT_PARAMS_UNSPEC,
+	P4TC_ACT_PARAMS_NAME, /* string - mandatory for params create */
+	P4TC_ACT_PARAMS_ID, /* u32 */
+	P4TC_ACT_PARAMS_TYPE, /* nested type - mandatory for params create */
+	__P4TC_ACT_PARAMS_MAX
+};
+
+#define P4TC_ACT_PARAMS_MAX (__P4TC_ACT_PARAMS_MAX - 1)
+
 #define P4TC_RTA(r) \
 	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
 
diff --git a/include/uapi/linux/tc_act/tc_p4.h b/include/uapi/linux/tc_act/tc_p4.h
new file mode 100644
index 000000000..874d85c9f
--- /dev/null
+++ b/include/uapi/linux/tc_act/tc_p4.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_TC_P4_H
+#define __LINUX_TC_P4_H
+
+#include <linux/pkt_cls.h>
+
+struct tc_act_p4 {
+	tc_gen;
+};
+
+#endif
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 0881a7563..7dbcf8915 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o
+obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o \
+	p4tc_action.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
new file mode 100644
index 000000000..a2df48c1c
--- /dev/null
+++ b/net/sched/p4tc/p4tc_action.c
@@ -0,0 +1,1080 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc/p4tc_action.c	P4 TC ACTION
+ *
+ * Copyright (c) 2022-2024, Mojatatu Networks
+ * Copyright (c) 2022-2024, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <net/flow_offload.h>
+#include <net/net_namespace.h>
+#include <net/netlink.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/sch_generic.h>
+#include <net/sock.h>
+#include <net/tc_act/p4tc.h>
+
+static void p4a_parm_put(struct p4tc_act_param *param)
+{
+	kfree(param);
+}
+
+static const struct nla_policy p4a_parm_policy[P4TC_ACT_PARAMS_MAX + 1] = {
+	[P4TC_ACT_PARAMS_NAME] = {
+		.type = NLA_STRING,
+		.len = P4TC_ACT_PARAM_NAMSIZ
+	},
+	[P4TC_ACT_PARAMS_ID] = { .type = NLA_U32 },
+	[P4TC_ACT_PARAMS_TYPE] = { .type = NLA_NESTED },
+};
+
+static struct p4tc_act_param *
+p4a_parm_find_byname(struct idr *params_idr, const char *param_name)
+{
+	struct p4tc_act_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		if (param == ERR_PTR(-EBUSY))
+			continue;
+		if (strncmp(param->name, param_name,
+			    P4TC_ACT_PARAM_NAMSIZ) == 0)
+			return param;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_act_param *
+p4a_parm_find_byid(struct idr *params_idr, const u32 param_id)
+{
+	return idr_find(params_idr, param_id);
+}
+
+static struct p4tc_act_param *
+p4a_parm_find_byany(struct p4tc_act *act, const char *param_name,
+		    const u32 param_id, struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *param;
+	int err;
+
+	if (param_id) {
+		param = p4a_parm_find_byid(&act->params_idr, param_id);
+		if (!param) {
+			NL_SET_ERR_MSG(extack, "Unable to find param by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (param_name) {
+			param = p4a_parm_find_byname(&act->params_idr,
+						     param_name);
+			if (!param) {
+				NL_SET_ERR_MSG(extack, "Param name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack, "Must specify param name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return param;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_act_param *
+p4a_parm_find_byanyattr(struct p4tc_act *act, struct nlattr *name_attr,
+			const u32 param_id,
+			struct netlink_ext_ack *extack)
+{
+	char *param_name = NULL;
+
+	if (name_attr)
+		param_name = nla_data(name_attr);
+
+	return p4a_parm_find_byany(act, param_name, param_id, extack);
+}
+
+static const struct nla_policy
+p4a_parm_type_policy[P4TC_ACT_PARAMS_TYPE_MAX + 1] = {
+	[P4TC_ACT_PARAMS_TYPE_BITEND] = { .type = NLA_U16 },
+	[P4TC_ACT_PARAMS_TYPE_CONTAINER_ID] = { .type = NLA_U32 },
+};
+
+static int
+__p4a_parm_init_type(struct p4tc_act_param *param, struct nlattr *nla,
+		     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ACT_PARAMS_TYPE_MAX + 1];
+	struct p4tc_type *type;
+	u32 container_id;
+	u16 bitend;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ACT_PARAMS_TYPE_MAX, nla,
+			       p4a_parm_type_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (tb[P4TC_ACT_PARAMS_TYPE_CONTAINER_ID]) {
+		container_id =
+			nla_get_u32(tb[P4TC_ACT_PARAMS_TYPE_CONTAINER_ID]);
+
+		type = p4type_find_byid(container_id);
+		if (!type) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Invalid container type id %u\n",
+					   container_id);
+			return -EINVAL;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify type container id");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ACT_PARAMS_TYPE_BITEND]) {
+		bitend = nla_get_u16(tb[P4TC_ACT_PARAMS_TYPE_BITEND]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify bitend");
+		return -EINVAL;
+	}
+
+	param->type = type;
+	param->bitend = bitend;
+
+	return 0;
+}
+
+static struct p4tc_act *
+p4a_tmpl_find_byname(const char *fullname, struct p4tc_pipeline *pipeline,
+		     struct netlink_ext_ack *extack)
+{
+	unsigned long tmp, id;
+	struct p4tc_act *act;
+
+	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, id)
+		if (strncmp(act->fullname, fullname, ACTNAMSIZ) == 0)
+			return act;
+
+	return NULL;
+}
+
+static int p4a_parm_type_fill(struct sk_buff *skb, struct p4tc_act_param *param)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+
+	if (nla_put_u16(skb, P4TC_ACT_PARAMS_TYPE_BITEND, param->bitend))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, P4TC_ACT_PARAMS_TYPE_CONTAINER_ID,
+			param->type->typeid))
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+struct p4tc_act *p4a_tmpl_find_byid(struct p4tc_pipeline *pipeline,
+				    const u32 a_id)
+{
+	return idr_find(&pipeline->p_act_idr, a_id);
+}
+
+static struct p4tc_act *
+p4a_tmpl_find_byany(struct p4tc_pipeline *pipeline,
+		    const char *act_name, const u32 a_id,
+		    struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act;
+	int err;
+
+	if (a_id) {
+		act = p4a_tmpl_find_byid(pipeline, a_id);
+		if (!act) {
+			NL_SET_ERR_MSG(extack, "Unable to find action by id");
+			err = -ENOENT;
+			goto out;
+		}
+	} else {
+		if (act_name) {
+			act = p4a_tmpl_find_byname(act_name, pipeline,
+						   extack);
+			if (!act) {
+				NL_SET_ERR_MSG(extack, "Action name not found");
+				err = -ENOENT;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify action name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return act;
+
+out:
+	return ERR_PTR(err);
+}
+
+struct p4tc_act *p4a_tmpl_get(struct p4tc_pipeline *pipeline,
+			      const char *act_name, const u32 a_id,
+			      struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act;
+
+	act = p4a_tmpl_find_byany(pipeline, act_name, a_id, extack);
+	if (IS_ERR(act))
+		return act;
+
+	if (!refcount_inc_not_zero(&act->a_ref)) {
+		NL_SET_ERR_MSG(extack, "Action is stale");
+		return ERR_PTR(-EBUSY);
+	}
+
+	return act;
+}
+
+static struct p4tc_act *
+p4a_tmpl_find_byanyattr(struct nlattr *attr, const u32 a_id,
+			struct p4tc_pipeline *pipeline,
+			struct netlink_ext_ack *extack)
+{
+	char fullname[ACTNAMSIZ] = {};
+	char *actname = NULL;
+
+	if (attr) {
+		actname = nla_data(attr);
+
+		snprintf(fullname, ACTNAMSIZ, "%s/%s", pipeline->common.name,
+			 actname);
+	}
+
+	return p4a_tmpl_find_byany(pipeline, fullname, a_id, extack);
+}
+
+static void p4a_tmpl_parms_put_many(struct idr *params_idr)
+{
+	struct p4tc_act_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id)
+		p4a_parm_put(param);
+}
+
+static int
+p4a_parm_init_type(struct p4tc_act_param *param, struct nlattr *nla,
+		   struct netlink_ext_ack *extack)
+{
+	struct p4tc_type *type;
+	int ret;
+
+	ret = __p4a_parm_init_type(param, nla, extack);
+	if (ret < 0)
+		return ret;
+
+	type = param->type;
+	ret = type->ops->validate_p4t(type, NULL, 0, param->bitend, extack);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct p4tc_act_param *
+p4a_tmpl_parm_create(struct p4tc_act *act, struct idr *params_idr,
+		     struct nlattr **tb, u32 param_id,
+		     struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *param;
+	char *name;
+	int ret;
+
+	if (tb[P4TC_ACT_PARAMS_NAME]) {
+		name = nla_data(tb[P4TC_ACT_PARAMS_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (p4a_parm_find_byid(&act->params_idr, param_id) ||
+	    p4a_parm_find_byname(&act->params_idr, name)) {
+		NL_SET_ERR_MSG(extack, "Param already exists");
+		ret = -EEXIST;
+		goto free;
+	}
+
+	if (tb[P4TC_ACT_PARAMS_TYPE]) {
+		ret = p4a_parm_init_type(param, tb[P4TC_ACT_PARAMS_TYPE],
+					 extack);
+		if (ret < 0)
+			goto free;
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (param_id) {
+		ret = idr_alloc_u32(params_idr, param, &param_id,
+				    param_id, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free;
+		}
+		param->id = param_id;
+	} else {
+		param->id = 1;
+
+		ret = idr_alloc_u32(params_idr, param, &param->id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free;
+		}
+	}
+
+	strscpy(param->name, name, P4TC_ACT_PARAM_NAMSIZ);
+
+	return param;
+
+free:
+	kfree(param);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_act_param *
+p4a_tmpl_parm_update(struct p4tc_act *act, struct nlattr **tb,
+		     struct idr *params_idr, u32 param_id,
+		     struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *param_old, *param;
+	int ret;
+
+	param_old = p4a_parm_find_byanyattr(act, tb[P4TC_ACT_PARAMS_NAME],
+					    param_id, extack);
+	if (IS_ERR(param_old))
+		return param_old;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	strscpy(param->name, param_old->name, P4TC_ACT_PARAM_NAMSIZ);
+	param->id = param_old->id;
+
+	if (tb[P4TC_ACT_PARAMS_TYPE]) {
+		ret = p4a_parm_init_type(param, tb[P4TC_ACT_PARAMS_TYPE],
+					 extack);
+		if (ret < 0)
+			goto free;
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	ret = idr_alloc_u32(params_idr, param, &param->id,
+			    param->id, GFP_KERNEL);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+		goto free;
+	}
+
+	return param;
+
+free:
+	kfree(param);
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_act_param *
+p4a_tmpl_parm_init(struct p4tc_act *act, struct nlattr *nla,
+		   struct idr *params_idr, bool update,
+		   struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ACT_PARAMS_MAX + 1];
+	u32 param_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ACT_PARAMS_MAX, nla, p4a_parm_policy,
+			       extack);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tb[P4TC_ACT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_ACT_PARAMS_ID]);
+
+	if (update)
+		return p4a_tmpl_parm_update(act, tb, params_idr, param_id,
+					    extack);
+	else
+		return p4a_tmpl_parm_create(act, params_idr, tb, param_id,
+					    extack);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static int p4a_tmpl_parms_init(struct p4tc_act *act, struct nlattr *nla,
+			       struct idr *params_idr, bool update,
+			       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	int ret;
+	int i;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (ret < 0)
+		return -EINVAL;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		struct p4tc_act_param *param;
+
+		param = p4a_tmpl_parm_init(act, tb[i], params_idr, update,
+					   extack);
+		if (IS_ERR(param)) {
+			ret = PTR_ERR(param);
+			goto params_del;
+		}
+	}
+
+	return i - 1;
+
+params_del:
+	p4a_tmpl_parms_put_many(params_idr);
+	return ret;
+}
+
+static int p4a_tmpl_init(struct p4tc_act *act, struct nlattr *nla,
+			 struct netlink_ext_ack *extack)
+{
+	int num_params = 0;
+	int ret;
+
+	idr_init(&act->params_idr);
+
+	if (nla) {
+		num_params =
+			p4a_tmpl_parms_init(act, nla, &act->params_idr, false,
+					    extack);
+		if (num_params < 0) {
+			ret = num_params;
+			goto idr_destroy;
+		}
+	}
+
+	return num_params;
+
+idr_destroy:
+	p4a_tmpl_parms_put_many(&act->params_idr);
+	idr_destroy(&act->params_idr);
+	return ret;
+}
+
+static struct netlink_range_validation prealloc_range = {
+	.min = 1,
+	.max = P4TC_MAX_TENTRIES,
+};
+
+static const struct nla_policy p4a_tmpl_policy[P4TC_ACT_MAX + 1] = {
+	[P4TC_ACT_NAME] = { .type = NLA_STRING, .len = P4TC_ACT_TMPL_NAMSZ },
+	[P4TC_ACT_PARMS] = { .type = NLA_NESTED },
+	[P4TC_ACT_OPT] = NLA_POLICY_EXACT_LEN(sizeof(struct tc_act_p4)),
+	[P4TC_ACT_NUM_PREALLOC] =
+		NLA_POLICY_FULL_RANGE(NLA_U32, &prealloc_range),
+	[P4TC_ACT_ACTIVE] = { .type = NLA_U8 },
+};
+
+static void p4a_tmpl_parms_put(struct p4tc_act *act)
+{
+	struct p4tc_act_param *act_param;
+	unsigned long param_id, tmp;
+
+	idr_for_each_entry_ul(&act->params_idr, act_param, tmp, param_id) {
+		idr_remove(&act->params_idr, param_id);
+		kfree(act_param);
+	}
+}
+
+static int __p4a_tmpl_put(struct net *net, struct p4tc_pipeline *pipeline,
+			  struct p4tc_act *act, bool teardown,
+			  struct netlink_ext_ack *extack)
+{
+	struct tcf_p4act *p4act, *tmp_act;
+
+	if (!teardown && refcount_read(&act->a_ref) > 1) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to delete referenced action template");
+		return -EBUSY;
+	}
+
+	p4a_tmpl_parms_put(act);
+
+	tcf_unregister_p4_action(net, &act->ops);
+	/* Free preallocated acts */
+	list_for_each_entry_safe(p4act, tmp_act, &act->prealloc_list, node) {
+		list_del_init(&p4act->node);
+		if (p4act->common.tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)
+			tcf_idr_release(&p4act->common, true);
+	}
+
+	idr_remove(&pipeline->p_act_idr, act->a_id);
+
+	list_del(&act->head);
+
+	kfree(act);
+
+	pipeline->num_created_acts--;
+
+	return 0;
+}
+
+static int _p4a_tmpl_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				struct p4tc_act *act)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_act_param *param;
+	struct nlattr *nest, *parms;
+	unsigned long param_id, tmp;
+	int i = 1;
+
+	if (nla_put_u32(skb, P4TC_PATH, act->a_id))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	if (nla_put_string(skb, P4TC_ACT_NAME, act->fullname))
+		goto out_nlmsg_trim;
+
+	if (nla_put_u32(skb, P4TC_ACT_NUM_PREALLOC, act->num_prealloc_acts))
+		goto out_nlmsg_trim;
+
+	parms = nla_nest_start(skb, P4TC_ACT_PARMS);
+	if (!parms)
+		goto out_nlmsg_trim;
+
+	idr_for_each_entry_ul(&act->params_idr, param, tmp, param_id) {
+		struct nlattr *nest_count;
+		struct nlattr *nest_type;
+
+		nest_count = nla_nest_start(skb, i);
+		if (!nest_count)
+			goto out_nlmsg_trim;
+
+		if (nla_put_string(skb, P4TC_ACT_PARAMS_NAME, param->name))
+			goto out_nlmsg_trim;
+
+		if (nla_put_u32(skb, P4TC_ACT_PARAMS_ID, param->id))
+			goto out_nlmsg_trim;
+
+		nest_type = nla_nest_start(skb, P4TC_ACT_PARAMS_TYPE);
+		if (!nest_type)
+			goto out_nlmsg_trim;
+
+		p4a_parm_type_fill(skb, param);
+		nla_nest_end(skb, nest_type);
+
+		nla_nest_end(skb, nest_count);
+		i++;
+	}
+	nla_nest_end(skb, parms);
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
+static int p4a_tmpl_fill_nlmsg(struct net *net, struct sk_buff *skb,
+			       struct p4tc_template_common *tmpl,
+			       struct netlink_ext_ack *extack)
+{
+	return _p4a_tmpl_fill_nlmsg(net, skb, p4tc_to_act(tmpl));
+}
+
+static int p4a_tmpl_flush(struct sk_buff *skb, struct net *net,
+			  struct p4tc_pipeline *pipeline,
+			  struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	unsigned long tmp, act_id;
+	struct p4tc_act *act;
+	int ret = 0;
+	int i = 0;
+
+	if (nla_put_u32(skb, P4TC_PATH, 0))
+		goto out_nlmsg_trim;
+
+	if (idr_is_empty(&pipeline->p_act_idr)) {
+		NL_SET_ERR_MSG(extack,
+			       "There are not action templates to flush");
+		goto out_nlmsg_trim;
+	}
+
+	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, act_id) {
+		if (__p4a_tmpl_put(net, pipeline, act, false, extack) < 0) {
+			ret = -EBUSY;
+			continue;
+		}
+		i++;
+	}
+
+	if (nla_put_u32(skb, P4TC_COUNT, i))
+		goto out_nlmsg_trim;
+
+	if (ret < 0) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush any action template");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Flushed only %u action templates",
+					   i);
+		}
+	}
+
+	return i;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static int p4a_tmpl_gd(struct net *net, struct sk_buff *skb,
+		       struct nlmsghdr *n, struct nlattr *nla,
+		       struct p4tc_path_nlattrs *nl_path_attrs,
+		       struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	const u32 pipeid = ids[P4TC_PID_IDX], a_id = ids[P4TC_AID_IDX];
+	struct nlattr *tb[P4TC_ACT_MAX + 1] = { NULL };
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_act *act;
+	int ret = 0;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE)
+		pipeline =
+			p4tc_pipeline_find_byany_unsealed(net,
+							  nl_path_attrs->pname,
+							  pipeid, extack);
+	else
+		pipeline = p4tc_pipeline_find_byany(net,
+						    nl_path_attrs->pname,
+						    pipeid, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_ACT_MAX, nla,
+				       p4a_tmpl_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			P4TC_PIPELINE_NAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && (n->nlmsg_flags & NLM_F_ROOT))
+		return p4a_tmpl_flush(skb, net, pipeline, extack);
+
+	act = p4a_tmpl_find_byanyattr(tb[P4TC_ACT_NAME], a_id, pipeline,
+				      extack);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	if (_p4a_tmpl_fill_nlmsg(net, skb, act) < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for template action");
+		return -EINVAL;
+	}
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = __p4a_tmpl_put(net, pipeline, act, false, extack);
+		if (ret < 0)
+			goto out_nlmsg_trim;
+	}
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static int p4a_tmpl_put(struct p4tc_pipeline *pipeline,
+			struct p4tc_template_common *tmpl,
+			struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act = p4tc_to_act(tmpl);
+
+	return __p4a_tmpl_put(pipeline->net, pipeline, act, true, extack);
+}
+
+static void p4a_tmpl_parm_idx_set(struct idr *params_idr)
+{
+	struct p4tc_act_param *param;
+	unsigned long tmp, id;
+	int i = 0;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		param->index = i;
+		i++;
+	}
+}
+
+static void p4a_tmpl_parms_replace_many(struct p4tc_act *act,
+					struct idr *params_idr)
+{
+	struct p4tc_act_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		idr_remove(params_idr, param->id);
+		param = idr_replace(&act->params_idr, param, param->id);
+		p4a_parm_put(param);
+	}
+}
+
+static struct p4tc_act *
+p4a_tmpl_create(struct net *net, struct nlattr **tb,
+		struct p4tc_pipeline *pipeline, u32 *ids,
+		struct netlink_ext_ack *extack)
+{
+	u32 a_id = ids[P4TC_AID_IDX];
+	char fullname[ACTNAMSIZ];
+	struct p4tc_act *act;
+	int num_params = 0;
+	size_t nbytes;
+	char *actname;
+	int ret = 0;
+
+	if (!tb[P4TC_ACT_NAME]) {
+		NL_SET_ERR_MSG(extack, "Must supply action name");
+		return ERR_PTR(-EINVAL);
+	}
+
+	actname = nla_data(tb[P4TC_ACT_NAME]);
+
+	nbytes = snprintf(fullname, ACTNAMSIZ, "%s/%s", pipeline->common.name,
+			  actname);
+	if (nbytes == ACTNAMSIZ) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Full action name should fit in %u bytes",
+				   ACTNAMSIZ);
+		return ERR_PTR(-E2BIG);
+	}
+
+	if (p4a_tmpl_find_byname(fullname, pipeline, extack)) {
+		NL_SET_ERR_MSG(extack, "Action already exists with same name");
+		return ERR_PTR(-EEXIST);
+	}
+
+	if (p4a_tmpl_find_byid(pipeline, a_id)) {
+		NL_SET_ERR_MSG(extack, "Action already exists with same id");
+		return ERR_PTR(-EEXIST);
+	}
+
+	act = kzalloc(sizeof(*act), GFP_KERNEL);
+	if (!act)
+		return ERR_PTR(-ENOMEM);
+
+	if (a_id) {
+		ret = idr_alloc_u32(&pipeline->p_act_idr, act, &a_id, a_id,
+				    GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to alloc action id");
+			goto free_act;
+		}
+
+		act->a_id = a_id;
+	} else {
+		act->a_id = 1;
+
+		ret = idr_alloc_u32(&pipeline->p_act_idr, act, &act->a_id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to alloc action id");
+			goto free_act;
+		}
+	}
+
+	/* We are only preallocating the instances once the action template is
+	 * activated during update.
+	 */
+	if (tb[P4TC_ACT_NUM_PREALLOC])
+		act->num_prealloc_acts = nla_get_u32(tb[P4TC_ACT_NUM_PREALLOC]);
+	else
+		act->num_prealloc_acts = P4TC_DEFAULT_NUM_PREALLOC;
+
+	num_params = p4a_tmpl_init(act, tb[P4TC_ACT_PARMS], extack);
+	if (num_params < 0) {
+		ret = num_params;
+		goto idr_rm;
+	}
+	act->num_params = num_params;
+
+	p4a_tmpl_parm_idx_set(&act->params_idr);
+
+	act->pipeline = pipeline;
+
+	pipeline->num_created_acts++;
+
+	act->common.p_id = pipeline->common.p_id;
+
+	strscpy(act->fullname, fullname, ACTNAMSIZ);
+	strscpy(act->common.name, actname, P4TC_ACT_TMPL_NAMSZ);
+
+	refcount_set(&act->a_ref, 1);
+
+	INIT_LIST_HEAD(&act->prealloc_list);
+	spin_lock_init(&act->list_lock);
+
+	return act;
+
+idr_rm:
+	idr_remove(&pipeline->p_act_idr, act->a_id);
+
+free_act:
+	kfree(act);
+
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_act *
+p4a_tmpl_update(struct net *net, struct nlattr **tb,
+		struct p4tc_pipeline *pipeline, u32 *ids,
+		u32 flags, struct netlink_ext_ack *extack)
+{
+	const u32 a_id = ids[P4TC_AID_IDX];
+	bool updates_params = false;
+	struct idr params_idr;
+	u32 num_prealloc_acts;
+	struct p4tc_act *act;
+	int num_params = 0;
+	s8 active = -1;
+	int ret = 0;
+
+	act = p4a_tmpl_find_byanyattr(tb[P4TC_ACT_NAME], a_id, pipeline,
+				      extack);
+	if (IS_ERR(act))
+		return act;
+
+	if (tb[P4TC_ACT_ACTIVE])
+		active = nla_get_u8(tb[P4TC_ACT_ACTIVE]);
+
+	if (act->active) {
+		if (!active) {
+			act->active = false;
+			return act;
+		}
+		NL_SET_ERR_MSG(extack, "Unable to update active action");
+
+		ret = -EINVAL;
+		goto out;
+	}
+
+	idr_init(&params_idr);
+	if (tb[P4TC_ACT_PARMS]) {
+		num_params = p4a_tmpl_parms_init(act, tb[P4TC_ACT_PARMS],
+						 &params_idr, true, extack);
+		if (num_params < 0) {
+			ret = num_params;
+			goto idr_destroy;
+		}
+		p4a_tmpl_parm_idx_set(&params_idr);
+		updates_params = true;
+	}
+
+	if (tb[P4TC_ACT_NUM_PREALLOC])
+		num_prealloc_acts = nla_get_u32(tb[P4TC_ACT_NUM_PREALLOC]);
+	else
+		num_prealloc_acts = act->num_prealloc_acts;
+
+	act->pipeline = pipeline;
+	if (active == 1) {
+		act->active = true;
+	} else if (!active) {
+		NL_SET_ERR_MSG(extack, "Action is already inactive");
+		ret = -EINVAL;
+		goto params_del;
+	}
+
+	act->num_prealloc_acts = num_prealloc_acts;
+
+	if (updates_params)
+		p4a_tmpl_parms_replace_many(act, &params_idr);
+
+	idr_destroy(&params_idr);
+
+	return act;
+
+params_del:
+	p4a_tmpl_parms_put_many(&params_idr);
+
+idr_destroy:
+	idr_destroy(&params_idr);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4a_tmpl_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+	    struct p4tc_path_nlattrs *nl_path_attrs,
+	    struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	const u32 pipeid = ids[P4TC_PID_IDX];
+	struct nlattr *tb[P4TC_ACT_MAX + 1];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_act *act;
+	int ret;
+
+	pipeline = p4tc_pipeline_find_byany_unsealed(net, nl_path_attrs->pname,
+						     pipeid, extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	ret = nla_parse_nested(tb, P4TC_ACT_MAX, nla, p4a_tmpl_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+		act = p4a_tmpl_create(net, tb, pipeline, ids, extack);
+		break;
+	case RTM_UPDATEP4TEMPLATE:
+		act = p4a_tmpl_update(net, tb, pipeline, ids,
+				      n->nlmsg_flags, extack);
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR(act))
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
+	return (struct p4tc_template_common *)act;
+}
+
+static int p4a_tmpl_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			 struct nlattr *nla, char **p_name, u32 *ids,
+			 struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+
+	if (!ctx->ids[P4TC_PID_IDX]) {
+		pipeline = p4tc_pipeline_find_byany(net, *p_name,
+						    ids[P4TC_PID_IDX], extack);
+		if (IS_ERR(pipeline))
+			return PTR_ERR(pipeline);
+		ctx->ids[P4TC_PID_IDX] = pipeline->common.p_id;
+	} else {
+		pipeline = p4tc_pipeline_find_byid(net, ctx->ids[P4TC_PID_IDX]);
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	return p4tc_tmpl_generic_dump(skb, ctx, &pipeline->p_act_idr,
+				      P4TC_AID_IDX, extack);
+}
+
+static int p4a_tmpl_dump_1(struct sk_buff *skb,
+			   struct p4tc_template_common *common)
+{
+	struct nlattr *param = nla_nest_start(skb, P4TC_PARAMS);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_act *act = p4tc_to_act(common);
+
+	if (!param)
+		goto out_nlmsg_trim;
+
+	if (nla_put_string(skb, P4TC_ACT_NAME, act->fullname))
+		goto out_nlmsg_trim;
+
+	if (nla_put_u8(skb, P4TC_ACT_ACTIVE, act->active))
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
+const struct p4tc_template_ops p4tc_act_ops = {
+	.init = NULL,
+	.cu = p4a_tmpl_cu,
+	.put = p4a_tmpl_put,
+	.gd = p4a_tmpl_gd,
+	.fill_nlmsg = p4a_tmpl_fill_nlmsg,
+	.dump = p4a_tmpl_dump,
+	.dump_1 = p4a_tmpl_dump_1,
+};
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 6a4e7d5f7..beacdb874 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -75,6 +75,8 @@ static const struct nla_policy tc_pipeline_policy[P4TC_PIPELINE_MAX + 1] = {
 
 static void p4tc_pipeline_destroy(struct p4tc_pipeline *pipeline)
 {
+	idr_destroy(&pipeline->p_act_idr);
+
 	kfree(pipeline);
 }
 
@@ -96,8 +98,12 @@ static void p4tc_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	struct net *net = pipeline->net;
 	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
 	struct net *pipeline_net = maybe_get_net(net);
+	unsigned long iter_act_id;
+	struct p4tc_act *act;
+	unsigned long tmp;
 
-	idr_remove(&pipe_net->pipeline_idr, pipeline->common.p_id);
+	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, iter_act_id)
+		act->common.ops->put(pipeline, &act->common, extack);
 
 	/* If we are on netns cleanup we can't touch the pipeline_idr.
 	 * On pre_exit we will destroy the idr but never call into teardown
@@ -154,6 +160,7 @@ static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 	}
 
 	pipeline->p_state = P4TC_STATE_READY;
+
 	return true;
 }
 
@@ -251,6 +258,10 @@ p4tc_pipeline_create(struct net *net, struct nlmsghdr *n,
 	else
 		pipeline->num_tables = P4TC_DEFAULT_NUM_TABLES;
 
+	idr_init(&pipeline->p_act_idr);
+
+	pipeline->num_created_acts = 0;
+
 	pipeline->p_state = P4TC_STATE_NOT_READY;
 
 	pipeline->net = net;
@@ -505,7 +516,8 @@ static int p4tc_pipeline_gd(struct net *net, struct sk_buff *skb,
 		return PTR_ERR(pipeline);
 
 	tmpl = (struct p4tc_template_common *)pipeline;
-	if (p4tc_pipeline_fill_nlmsg(net, skb, tmpl, extack) < 0)
+	ret = p4tc_pipeline_fill_nlmsg(net, skb, tmpl, extack);
+	if (ret < 0)
 		return -1;
 
 	if (!ids[P4TC_PID_IDX])
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 1140c128a..7126ff7cd 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -42,6 +42,7 @@ static bool obj_is_valid(u32 obj)
 {
 	switch (obj) {
 	case P4TC_OBJ_PIPELINE:
+	case P4TC_OBJ_ACT:
 		return true;
 	default:
 		return false;
@@ -50,6 +51,7 @@ static bool obj_is_valid(u32 obj)
 
 static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX + 1] = {
 	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
+	[P4TC_OBJ_ACT] = &p4tc_act_ops,
 };
 
 int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
@@ -124,6 +126,11 @@ static int tc_ctl_p4_tmpl_gd_1(struct net *net, struct sk_buff *skb,
 
 	ids[P4TC_PID_IDX] = t->pipeid;
 
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
 	nl_path_attrs->ids = ids;
 
 	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
@@ -311,6 +318,12 @@ p4tc_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
 	}
 
 	ids[P4TC_PID_IDX] = t->pipeid;
+
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
 	nl_path_attrs->ids = ids;
 
 	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
@@ -504,6 +517,11 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
 	root = nla_nest_start(skb, P4TC_ROOT);
 
 	ids[P4TC_PID_IDX] = t->pipeid;
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
 
 	obj_op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
 	ret = obj_op->dump(skb, ctx, tb[P4TC_PARAMS], &p_name, ids, extack);
-- 
2.34.1


