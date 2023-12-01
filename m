Return-Path: <bpf+bounces-16416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C258012AB
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1608B213E9
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7A53E3E;
	Fri,  1 Dec 2023 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fTdZ7/GC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778119F
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:29:14 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d08497aa1so1458042eaf.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455354; x=1702060154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+1B6MS9WebvTIJbkdAm0FmoVBlDA/Si6pEiGwF7JXk=;
        b=fTdZ7/GCWz9+qes5hqoCevRC5orCHLqE8TKLsmmHf088A2q2hhZjXNV8m1vARku27X
         OE37W1qP89ONqmcXuFSwzSOu8U1JjE3jhVvMZBFb3YAWMhjQyEIrZ7invuODZMBjyWy/
         X7fdF3tKAaU/YAwizoDqeYTTO9+XPP2xetCXsbAFSk1MPut4f2YL/WhBYBrBWWVokewu
         vuwTVyhpKvC4oVIJZf/MLEmmLSdd7C6gLt6o3Lh7i5dByFPmkTegEbmcKlL9HLNk+9kG
         u7wJZads5XR7+CnzvO0dUFbqBejHZf//UAjHpQlOPXGJBg6SBEOLi+PlLrx+ZeQROtc2
         KOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455354; x=1702060154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+1B6MS9WebvTIJbkdAm0FmoVBlDA/Si6pEiGwF7JXk=;
        b=Cs/QhSlUvoOxQga4MwPCfhj92EHnkF+aV4hdlUjVK/WLbK1w1HG/8+ruWk+EGTKC0w
         zh2Zycf48N7SZHE9WBWqfqIHBCn90po9j53P1/Cr29m3csX/fPvjOoCjX3VHXpy61NVe
         0oIJFDc2Pp3Ga9T8YwyJ71agugnp7YjXs/377MIYj3enfy0hxsF+t00k11ypXpOomkyP
         NTTMkXdJ95b1iAGG0uw5q8r85hQ0xXTGZxK7FbT/6+XnEM27q7XKCxJz1RIN8QavuD8p
         9OC5rCUoABDqKr5pku2VL9fqBdwIO5Q+gNpMq3tNJJkpcZaV8kQl7Vp/VsVlmNJAGyvY
         FefA==
X-Gm-Message-State: AOJu0Yy+4RlPQBOPPTHwLmfy/uZlByCltGft3VQJNt+1LKFEzl1DT77l
	6b8CFg4vvdJ7fzb4egAuicJV+Q==
X-Google-Smtp-Source: AGHT+IHJP1iKSAf41dxOeNUaFER1qHT/ZePiI0qB9R9+A4Gmvvh4LflG14Xv1E4aiNIk4oAIF45u6Q==
X-Received: by 2002:a05:6358:6f8a:b0:16e:3803:9cf8 with SMTP id s10-20020a0563586f8a00b0016e38039cf8mr22601805rwn.24.1701455353897;
        Fri, 01 Dec 2023 10:29:13 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:13 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
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
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 05/15] net: sched: act_api: Add support for preallocated P4 action instances
Date: Fri,  1 Dec 2023 13:28:54 -0500
Message-Id: <20231201182904.532825-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201182904.532825-1-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In P4, actions are assumed to pre exist and have an upper bound number of
instances. Typically if you have 1M table entries you want to allocate
enough action instances to cover the 1M entries. However, this is a big
waste of memory if the action instances are not in use. So for our case,
we allow the user to specify a minimal amount of actions in the template
and then if more P4 action instances are needed then they will be
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
Instead we add it to the pool/cache of action instances for
that specific action i.e it counts as if it is preallocated.
Preallocated actions can't be deleted by the tc actions runtime commands
and a dump or a get will only show preallocated actions
instances which are being used (TCA_ACT_FLAGS_UNREFERENCED == false).

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
---
 include/net/act_api.h |  3 +++
 net/sched/act_api.c   | 50 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index c59bc8053..4b719da7d 100644
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
@@ -200,6 +202,7 @@ int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
 			      const struct tc_action_ops *ops, int bind,
 			      u32 flags);
 void tcf_idr_insert_many(struct tc_action *actions[]);
+void tcf_idr_insert_n(struct tc_action *actions[], const u32 n);
 void tcf_idr_cleanup(struct tc_action_net *tn, u32 index);
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 			struct tc_action **a, int bind);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index ddef91233..9facdd46a 100644
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
@@ -1367,26 +1372,38 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
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
 void tcf_idr_insert_many(struct tc_action *actions[])
 {
 	int i;
 
 	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
-		struct tc_action *a = actions[i];
-		struct tcf_idrinfo *idrinfo;
-
-		if (!a)
+		if (!actions[i])
 			continue;
-		idrinfo = a->idrinfo;
-		mutex_lock(&idrinfo->lock);
-		/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc if
-		 * it is just created, otherwise this is just a nop.
-		 */
-		idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
-		mutex_unlock(&idrinfo->lock);
+		tcf_idr_insert_1(actions[i]);
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
 struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 					 bool police, bool rtnl_held,
 					 struct netlink_ext_ack *extack)
@@ -2033,8 +2050,17 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
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


