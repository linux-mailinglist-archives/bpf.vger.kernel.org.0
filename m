Return-Path: <bpf+bounces-26429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E989F950
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF11F2C937
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B716D9CD;
	Wed, 10 Apr 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VRFMBati"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03C1649DA
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757714; cv=none; b=Na2tQ4bbafS9d3HTZxSBuAVib7ne6cocN3MaTHigKZY8KsMlK2zdKMtxBOqn3zIEpfAu0Pmhzd9fDoDhS8jYiAp7lLh8n7m3rCFYH5oQExd4DTRzb5l7WACyO3TRo1HRZqYRuE+gUhHDm73KeU7XJwBqWqEeTNkScLq/cNW6ubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757714; c=relaxed/simple;
	bh=af3rfLHjcWN/iojvAMqBdN0X9jDI6rb83dJX/FYA7hI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfbZnYAivLz8sagOqjGXQQLPJtC17kj9zWcujy2clhtf4Ks6X1NyWINBU6UwgNsrN17RnLXSGzGUasbn6SNQmZ46zH+znCVUnnnI+OGNj7Fle+ZxqowN5GHtqhvxytDn3DlAfe3KtoclT17+UTAhrNWh6BglPzwCk9EF51kFYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VRFMBati; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a3bccc41dso281413585a.0
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757711; x=1713362511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPsfLnnDu4YSlm/NvLD72y8+xCmfE9cXU04bzseND1s=;
        b=VRFMBati3QYHPCRcPhIXMVc4Q/4fSUfjwIGIIr1IPRnJEGzu+16HrSuQSNfdKUJF/f
         NQnEolgBUQcvJlAujEkd4iqpCCZH1XJMR48R+JnqQxEzZ1eg3SDtvtdQsBUrMVmed1gb
         bMQNmDlgdAnminm2tAYAV+f8YrgJgeupX9IYH6248v1aKVHr6gh5keRxaFO35fmOPu6D
         C/hC1KYZlfXDfYq6RO6NVXjZ1P45EalB2dSBB+bq0NympyGOQukr9DRqMQhoypNnS1ax
         0+dnBuZjo0xIz4Q7LfgJwRcZsQybMTYBDnHv0np5fYEa6cDlzLDZvnGkRNXkN4ENz7n5
         KIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757711; x=1713362511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPsfLnnDu4YSlm/NvLD72y8+xCmfE9cXU04bzseND1s=;
        b=o9uZ1MWrTYVcqze530voiEniKE8UCALfMD6+Mxlr5X7d5AYnskDfH+bKvaj0YQ7YmA
         8Kwe/Zh1ejYPZFPBGE72zJ2MBuPOyTC2EYJnDD4+6UeQqQLji6eXLA4JsCsdz2mI8P5y
         0CQj19J/ndznZdVK//KuBJpFj+3amLFllGrIe9NJzWrjSAX8kCxFPRcSwkFsCQECQt4s
         DEw3Uck6TVChEhkADelCGzc1TCJ76yOSkaJzBmso/pwOj7MA5zSWwsidfbhJcPKiW3Ek
         y5T4NZJF12c0OmI4GlgL53GZ6tyxQ/2UrmNPko60RVRCrY625f02EJks7lXJ00Y6Vd0w
         RyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU9+dSsEnCBG42lX6UtHbRNngTVkeRR/714lu5Xp7i7APAzkbIR6aJ8CcVXaX6iAICvudLNOt8bDeVfedWW4RN9Xrt
X-Gm-Message-State: AOJu0Yxf1rNPawyC9R+tr0tOE2HBw/k6C7Fmg49AMEDebDXRwYveLtes
	z9qGoTIwSSEO8c5/vV76OIPXtqIVJcyq0L1DzuC3sz9QgYbulaOxmsJJVjJ+iQ==
X-Google-Smtp-Source: AGHT+IHKzsCOzKf85qRqskIQj5veVzZY2CmyGL80pFkbYoOsuxCdkTBHelNgt4zgFTEPmwxDmkNh6g==
X-Received: by 2002:a37:e119:0:b0:78b:c9f0:9c26 with SMTP id c25-20020a37e119000000b0078bc9f09c26mr3002777qkm.50.1712757710682;
        Wed, 10 Apr 2024 07:01:50 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:01:50 -0700 (PDT)
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
Subject: [PATCH net-next v16  05/15] net: sched: act_api: Add support for preallocated P4 action instances
Date: Wed, 10 Apr 2024 10:01:31 -0400
Message-Id: <20240410140141.495384-6-jhs@mojatatu.com>
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

In P4, actions are assumed to pre exist and have an upper bound number of
instances. Typically if you a table defined with 1M table entries you want
to allocate enough action instances to cover the 1M entries. However, this
is a big waste of memory if the action instances are not in use. So for
our case, we allow the user to specify a minimal amount of actions in the
template and then if more P4 action instances are needed then they will be
added on demand as in the current approach with tc filter-action
relationship.

Add the necessary code to preallocate actions instances for P4
actions.

We add 2 new actions flags:
- TCA_ACT_FLAGS_PREALLOC: Indicates the action instance is a P4 action
  and was preallocated for future use the templating phase of P4TC
- TCA_ACT_FLAGS_UNREFERENCED: Indicates the action instance was
  preallocated and is currently not being referenced by any other object.
  Which means it won't show up in an action instance dump.

Once an action instance is created we don't free it when the last table
entry referring to it is deleted.
Instead we add it to the pool/cache of action instances for that specific
action kind i.e it counts as if it is preallocated.
Preallocated actions can't be deleted by the tc actions runtime commands
and a dump or a get will only show preallocated actions instances which are
being used (i.e TCA_ACT_FLAGS_UNREFERENCED == false).

The preallocated actions will be deleted once the pipeline is deleted
(which will purge the P4 action kind and its instances).

For example, if we were to create a P4 action that preallocates 128
elements and dumped:

$ tc -j p4template get action/myprog/send_nh | jq .

We'd see the following:

[
  {
    "obj": "action template",
    "pname": "myprog",
    "pipeid": 1
  },
  {
    "templates": [
      {
        "aname": "myprog/send_nh",
        "actid": 1,
        "params": [
          {
            "name": "port",
            "type": "dev",
            "id": 1
          }
        ],
        "prealloc": 128
      }
    ]
  }
]

If we try to dump the P4 action instances, we won't see any:

$ tc -j actions ls action myprog/send_nh | jq .

[]

However, if we create a table entry which references this action kind:

$ tc p4ctrl create myprog/table/cb/FDB \
   dstAddr d2:96:91:5d:02:86 action myprog/send_nh \
   param port type dev dummy0

Dumping the action instance will now show this one instance which is
associated with the table entry:

$ tc -j actions ls action myprog/send_nh | jq .

[
  {
    "total acts": 1
  },
  {
    "actions": [
      {
        "order": 0,
        "kind": "myprog/send_nh",
        "index": 1,
        "ref": 1,
        "bind": 1,
        "params": [
          {
            "name": "port",
            "type": "dev",
            "value": "dummy0",
            "id": 1
          }
        ],
        "not_in_hw": true
      }
    ]
  }
]

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h |  3 +++
 net/sched/act_api.c   | 45 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 52aab6dd8a8e..5dfb26f69276 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -68,6 +68,8 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_PREALLOC	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
+#define TCA_ACT_FLAGS_UNREFERENCED	(1U << (TCA_ACT_FLAGS_USER_BITS + 6))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
@@ -201,6 +203,7 @@ int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
 			      const struct tc_action_ops *ops, int bind,
 			      u32 flags);
 void tcf_idr_insert_many(struct tc_action *actions[], int init_res[]);
+void tcf_idr_insert_n(struct tc_action *actions[], const u32 n);
 void tcf_idr_cleanup(struct tc_action_net *tn, u32 index);
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 			struct tc_action **a, int bind);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 87b6d300778d..4ee01c76c26c 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -560,6 +560,8 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 			continue;
 		if (IS_ERR(p))
 			continue;
+		if (p->tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)
+			continue;
 
 		if (jiffy_since &&
 		    time_after(jiffy_since,
@@ -640,6 +642,9 @@ static int tcf_del_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 	idr_for_each_entry_ul(idr, p, tmp, id) {
 		if (IS_ERR(p))
 			continue;
+		if (p->tcfa_flags & TCA_ACT_FLAGS_PREALLOC)
+			continue;
+
 		ret = tcf_idr_release_unsafe(p);
 		if (ret == ACT_P_DELETED)
 			module_put(ops->owner);
@@ -1398,25 +1403,40 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
 	[TCA_ACT_HW_STATS]	= NLA_POLICY_BITFIELD32(TCA_ACT_HW_STATS_ANY),
 };
 
+static void tcf_idr_insert_1(struct tc_action *a)
+{
+	struct tcf_idrinfo *idrinfo;
+
+	idrinfo = a->idrinfo;
+	mutex_lock(&idrinfo->lock);
+	/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc if
+	 * it is just created, otherwise this is just a nop.
+	 */
+	idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
+	mutex_unlock(&idrinfo->lock);
+}
+
 void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 {
 	struct tc_action *a;
 	int i;
 
 	tcf_act_for_each_action(i, a, actions) {
-		struct tcf_idrinfo *idrinfo;
-
 		if (init_res[i] == ACT_P_BOUND)
 			continue;
 
-		idrinfo = a->idrinfo;
-		mutex_lock(&idrinfo->lock);
-		/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc */
-		idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
-		mutex_unlock(&idrinfo->lock);
+		tcf_idr_insert_1(a);
 	}
 }
 
+void tcf_idr_insert_n(struct tc_action *actions[], const u32 n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		tcf_idr_insert_1(actions[i]);
+}
+
 struct tc_action_ops *
 tc_action_load_ops(struct net *net, struct nlattr *nla,
 		   u32 flags, struct netlink_ext_ack *extack)
@@ -2092,8 +2112,17 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 			ret = PTR_ERR(act);
 			goto err;
 		}
-		attr_size += tcf_action_fill_size(act);
 		actions[i - 1] = act;
+
+		if (event == RTM_DELACTION &&
+		    act->tcfa_flags & TCA_ACT_FLAGS_PREALLOC) {
+			ret = -EINVAL;
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Unable to delete preallocated action %s",
+					   act->ops->kind);
+			goto err;
+		}
+		attr_size += tcf_action_fill_size(act);
 	}
 
 	attr_size = tcf_action_full_attrs_size(attr_size);
-- 
2.34.1


