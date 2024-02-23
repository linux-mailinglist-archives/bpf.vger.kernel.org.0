Return-Path: <bpf+bounces-22585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509FE861284
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 14:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BAF1C229D8
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287F7F7D0;
	Fri, 23 Feb 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="K4cLbt1f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464D7E78A
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694268; cv=none; b=qrnV3YBENIMgSyeMx0Q5fkninyJQFXAMRi/J+IXBDs/DVjF9aTSD3njwRHC+Ujgqk5BxJDMLSF+eWpg1e6bVxn17XWlOEPpVuQXAv+2nCddlrh7Ur9onSE3g0ZlJjFKKAF0B8AldAFfOw2DGuA/9Fe4hJUukR73IuY3Dc9ZIoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694268; c=relaxed/simple;
	bh=0DhGdU85buiKZ6gE/vKFkpiU6PLSJnvgVIVPpPyrqaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmewRL5eGqpb0tWZ6wumCCtfQsSVfb7g3iE/4aR38vyKxEa/W01S9jFFDa+fIDZ2xUWSarQwopNhbmZTMsC9uN8u3graMyImQmaHIp+sJLASR+H+bpmnh81JFTdauGZbwgcnamXPfHLBDc3bY9KhsfsCGvmfAsOC+L4IC4I4t+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=K4cLbt1f; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7874a96a01dso19129185a.3
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 05:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708694266; x=1709299066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9AIcnsxEM8NnMIh0oZV+QmkJ4BpMVmS49VYo2k2mSE=;
        b=K4cLbt1f4ukuuqZQXwxzGWKRiAogh7Yv7bE59mTKReCL1BLAJVCJI2s1VSQrqD6ke6
         3YI9jwH128zOSyCQ0Nbs2jEiWQLPOTPCOTiwBqgLnwDFG5RpFEuH9ct+i+qM4nOQj+Fy
         //A5sKTISS5r6pyrJy+RQgLZILEBvZxvKmuTZYL/wMuEDnCw1WzSQphbwG0xXKiyUoxu
         ZZl+9DQytizsRDNpK+KUezczK2kkUVRpUWj/JXdSdyzYdLf1fqOAkrkRRTbjqT+ndCu6
         SlF/C1rEYTiQ1f2Njlispma1yiNjV5OyOEvv8FTslRt++OugH2Q1bC95fEpHnwuReG+R
         gHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694266; x=1709299066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9AIcnsxEM8NnMIh0oZV+QmkJ4BpMVmS49VYo2k2mSE=;
        b=tcP3AdqanPrcOBDT1pn5Psvb5/FYQzzN656/+5wAfeLjoKLY/QrsjNDVVkEP8NCxTN
         Z+wxNV+1CabXmlLMLR9v+XVA5utZCKroMHlptbDtpuGB2IF6H9GG4p4PkotzZbbV5K8H
         ph5GGZJvdvSsEKYbWnxsGQeJz5BJJ5pJoP+mduv6DnqPivZlqR6WMkCmuD48wS3QyqaW
         Ctnrmmj8JfqO6YVIwoOXapNgyGG757Fwzdk7utCZaWeEoPDyzUZ03KpSBDeXzVT11EAv
         Wj4PXXDf/XejL9ECYFgLGih3w7Q1uV7w+ZOqoWvvPZ4pKqWP1jTSqOUgjmTmSF2okxim
         fjNg==
X-Forwarded-Encrypted: i=1; AJvYcCWfRZLFZDiF0cOikgb0paTB15vqlkUGHPoBUSUseoJMnBBHvtU0L7onvm+62hWdMXwfHFovJRv3r+LWgk3Uubq0VPnz
X-Gm-Message-State: AOJu0YwhyVL+PkCKQNfBKRdC5x4lizDjUDMwuYIKkTUPPR7TeweUvCPr
	a+XGFegQwAGCE8+iHt9QTWBS55UGGzMBjOBzcV58MdX0A+N+FgbrON8eC2RJYQ==
X-Google-Smtp-Source: AGHT+IEvLAlXJJPSSfmEiVPqOqWHPP+NdjSs5uwg32f4GRgDxTZ8AK//Hgrd4I6ArugOyBIKdcBBtg==
X-Received: by 2002:a05:620a:479b:b0:787:2b66:a088 with SMTP id dt27-20020a05620a479b00b007872b66a088mr1871565qkb.1.1708694265839;
        Fri, 23 Feb 2024 05:17:45 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a15a300b00787ae919d02sm844869qkk.17.2024.02.23.05.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:17:45 -0800 (PST)
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
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next v11 5/5] net: sched: act_api: Add support for preallocated P4 action instances
Date: Fri, 23 Feb 2024 08:17:28 -0500
Message-Id: <20240223131728.116717-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223131728.116717-1-jhs@mojatatu.com>
References: <20240223131728.116717-1-jhs@mojatatu.com>
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
is a big waste of memory if the action instances are not in use. So for our
case, we allow the user to specify a minimal amount of actions in the
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


