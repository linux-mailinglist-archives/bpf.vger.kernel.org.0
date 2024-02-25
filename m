Return-Path: <bpf+bounces-22694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82729862C10
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 17:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64761C2122F
	for <lists+bpf@lfdr.de>; Sun, 25 Feb 2024 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41C1BC39;
	Sun, 25 Feb 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MDYs4hic"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F31B966
	for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880107; cv=none; b=culFb7Xe3N4YIxVjWyoV+NYFd6jWrly/bIqLL/ms4wEmuG9ArUKq8vVSqkXzQVS/z3rHghZ0sKS1TPumyvV1Nn2Cf8CeePGCf99hHFHigKeI9wULqb+8LzNNyHozpkKKh5qZPMT0RbItaO/qwH8g+QqoOT5E6qeVmAd9u95S7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880107; c=relaxed/simple;
	bh=DUOvzIZvC9n71uVG5f3r1D/b2n877Q1st6UDdB1bO5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhMlfrpCH5ms+XUtb5jwC5rmHy1S5DbKXI+n2meWq/klzhbxtxAaf52M9GblDw31Vzg/Qoswd8FpxSCgyDCV7Zi3NnlvKvSOvhwWypFfUrFebjZqqFODZN+9C5m6LOyefecxennSmF65xyVKmfzmleYFo/x7iU1mJR2fVCOZBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MDYs4hic; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c19bc08f96so549348b6e.2
        for <bpf@vger.kernel.org>; Sun, 25 Feb 2024 08:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708880105; x=1709484905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAmyEkBtgX1lnD0aXkcPHpRRRu6Ij/2tPh+LfEvJYOs=;
        b=MDYs4hicc0jD3lF7gF4xBFSpbFGQ2eZZ3RjIdCxngWL2h1orq7wrl/Q3Ae3lBDKMdT
         rWun5i5XQwlDomlJYIwLvf4++PBFNtwu2Yf/vhD01Tvhzf1UCpPhlt8Vs3LH7guwIvCz
         1KNkqPYGUad36xWtMrplSFWpvZ+P2zfj9F+GCGMHnliTwmUhWFWeECcFhCBQG9JYoqMW
         Qc8YG4Qnj7L3IiNjQ/0TqD+QY9TnpwpDOCpGT8DOucWNHFGwHO7hh52KPqRxOFVGKUmO
         HT6LUD3xdQ+sK8XZFsi/OllcDb0+++pU1zQ2CMHRtynh77HNXYaXF5Jv7akYtL8jc/yK
         95yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880105; x=1709484905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAmyEkBtgX1lnD0aXkcPHpRRRu6Ij/2tPh+LfEvJYOs=;
        b=CIQJ/qzokTwoZS3hscqt2F4Qin8uJ9ENDEHVFkuPEpR4WLmsACf1AZvzuq4HIl1QHl
         /pGx/ORtO25Fl15jquUTdvOK+/ytUpo2JmD3VafZY7J9++CcoQoUhE+kxzW2agFPTawe
         bJjsesno+0UFQV3Qmdmf5IXX5gSu18K0rW9FnWnHbYui9GMduJ02Sku1YoA68/m/fgYh
         8s8lJMHSfPh0ndtdEv1Wxyl/osSwoHay8imWnEiIa1f2YkoJUGUJgeVWFixa69/roCpf
         AXMJ1jusoSuNKiA9yWcqSKFYgsxaso8My1hAOiH7P2pwJ6RSXBz4QirU3T634i89CFFN
         +uqw==
X-Forwarded-Encrypted: i=1; AJvYcCUFaaxVEx7T/eaGydtTefIL6n/2kewRiW76qCVeYeQ1A63Mjum6DCRMotCaf3BOgFmUCAYqtXgsj7uAjVKRH28QUG0l
X-Gm-Message-State: AOJu0YzYZ78RMR1I3JekE67epTPGaJutkQ/zdDeOsH21ZZhTiXUGI02r
	3Eu9Kxt0vTZ3e6PLkiTAceYPUiLLWoRaf8bRYX2DYnKSEHid3Sg2EHrp1cnHQQ==
X-Google-Smtp-Source: AGHT+IE6cboX/+47Z8F7oWlKazJAK6ZNdzWv1lBWRndFPHnRA7BD+A+lwMO7HGr4EzMD5VzA+dkAyA==
X-Received: by 2002:a05:6808:16a9:b0:3c0:3752:626f with SMTP id bb41-20020a05680816a900b003c03752626fmr5795900oib.58.1708880104779;
        Sun, 25 Feb 2024 08:55:04 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a14b500b00787ba78da02sm1620698qkj.93.2024.02.25.08.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:55:04 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
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
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v12  05/15] net: sched: act_api: Add support for preallocated P4 action instances
Date: Sun, 25 Feb 2024 11:54:36 -0500
Message-Id: <20240225165447.156954-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225165447.156954-1-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
 include/net/act_api.h |  3 +++
 net/sched/act_api.c   | 45 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 49f471c58..d35870fbf 100644
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
index 835ead746..418e44235 100644
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


