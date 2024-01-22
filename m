Return-Path: <bpf+bounces-20024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D449583730E
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 20:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6CA1F2A877
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A87E3FE58;
	Mon, 22 Jan 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PQh7ZDs7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3823EA97
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952892; cv=none; b=u6cha18+fNpSod7fAkKKRWVekaqLt0gAq45WTLVi+zkZRTicpWyVY6AIgixK0nk1ayk5intC0ebR7eSQ7vRkXyIo7cUKLvLfIRImyaL4mO454ZVAF0lcnzkhKwVIGwn2xH5xALJOz0mPQY6XCqTXo76GOnXhseCzLtDM1LGlRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952892; c=relaxed/simple;
	bh=2Qt66q2DT5ucOMCGGvMhFPg6AE++5Wtrkr/YrHJ5RPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N070PGX4o3yLVoFb2e0KLLsE6JQAtBIZ5GVKo42D7RIxVi/rn5hWQiEG082g4sgl15tR1HGuj8WjpHwSq1fozhrEwY3hfinrlBTBG32XmTyO/enEEjeuUE+lzxxsKZ2X55znYal7CVf4YMLumsopnhav+upM3dBL7R1MK0tTdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PQh7ZDs7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffe7e7b7b3so12345967b3.3
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952889; x=1706557689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcX5ZQ/V+VduL8+DvTKA2d0fAAmy1OxUOiqfEce3kXA=;
        b=PQh7ZDs73KnuuWCJ66U5YGyUyHFrzeDfRDXhMgMpzcOJ7EdHr4mrgcwCDb7F4PKKBj
         SARnK2Rqq7Qiyuh9pjn6v+iPy3pjeZcxVsEEcB9kZmSz2wiCLYXXPhQKM5/hBZI+8z3s
         oAkya3b4QFcR1MhLJ6Aar1RfLSEhhLrZ/8vTrE4eoEIC+YOFg+C3MnTima2hBzunuqCL
         97qRmVMflSg8vdvdN8GyByurv5m7bxOJhdvueji+BOh6KL5kddTgEJ5vGVtGIlDUQZU3
         xjnDgbnrOFE23D2Za/ufaFqGRgwdMy41Qold1XKisQBFim+JA+/v95WIHRqghSYoytpX
         zYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952889; x=1706557689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcX5ZQ/V+VduL8+DvTKA2d0fAAmy1OxUOiqfEce3kXA=;
        b=jboxKzTMMHht6xVgmkCPQeDMgt+IPauGMdvG6OKdbfssdfI5Ib1utxiA9E30zBVHxY
         CdLIlSmJFzRxVXI+kx3Hy37Ghnff6X+b6bnyDpgYtFSlNnzH/l2Au8n+kgFLaH3eu4hc
         1U2VOtlTh9/GErashbuTtV6DLAu3NO6h5mr/ZzQvQ6QPOXv/Ji00kvX9hl0oTtIatvDR
         Y8xzsutev0buWG4Ttm6eAE5xa8H1yxcdm2MWYiiQ9wNw1b1Nluh6sj0bWmqYty2XTYVO
         nQ0N/m2ZAhs7AK9hWho0a5Oeu8E71j2JSYc5rR19zWb+Qv1Ubbw5Ss4GvbpimiW2kxv1
         G/rg==
X-Gm-Message-State: AOJu0Yxx+pTt8ETY3WN0DSEsjSru8gXf3Qr6Otbnm63uhUnSK9iIRCL7
	TApf4yFXcy4b1SrY4WF2P+/qXm9DYkpQRQulO/vI1F7RQciVHElVWPW9y8y7vA==
X-Google-Smtp-Source: AGHT+IHVy2++ozN927I/K8wRXjNymmDRsSTe/sAi1Ramqj8CPMi2l77SrTjA9SSmaB9EgSvoHjqTJw==
X-Received: by 2002:a81:4f02:0:b0:5ff:ac46:211a with SMTP id d2-20020a814f02000000b005ffac46211amr2836324ywb.59.1705952888775;
        Mon, 22 Jan 2024 11:48:08 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:08 -0800 (PST)
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
Subject: [PATCH v10 net-next 01/15] net: sched: act_api: Introduce P4 actions list
Date: Mon, 22 Jan 2024 14:47:47 -0500
Message-Id: <20240122194801.152658-2-jhs@mojatatu.com>
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

In P4 we require to generate new actions "on the fly" based on the
specified P4 action definition. P4 action kinds, like the pipeline
they are attached to, must be per net namespace, as opposed to native
action kinds which are global. For that reason, we chose to create a
separate structure to store P4 actions.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h |   8 ++-
 net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
 net/sched/cls_api.c   |   2 +-
 3 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index e1e5e72b9..ab28c2254 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 
 struct tc_action_ops {
 	struct list_head head;
+	struct list_head p4_head;
 	char    kind[IFNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
@@ -199,8 +200,10 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 int tcf_idr_release(struct tc_action *a, bool bind);
 
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
+int tcf_register_p4_action(struct net *net, struct tc_action_ops *act);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act);
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
@@ -208,8 +211,9 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		    struct nlattr *est,
 		    struct tc_action *actions[], int init_res[], size_t *attr_size,
 		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
-					 struct netlink_ext_ack *extack);
+struct tc_action_ops *
+tc_action_load_ops(struct net *net, struct nlattr *nla,
+		   u32 flags, struct netlink_ext_ack *extack);
 struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 				    struct nlattr *nla, struct nlattr *est,
 				    struct tc_action_ops *a_o, int *init_res,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3e30d7260..e4a1b8f5a 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
 	kfree(cookie);
 }
 
+static unsigned int p4_act_net_id;
+
+struct tcf_p4_act_net {
+	struct list_head act_base;
+	rwlock_t act_mod_lock;
+};
+
+static __net_init int tcf_p4_act_base_init_net(struct net *net)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	INIT_LIST_HEAD(&p4_base_net->act_base);
+	rwlock_init(&p4_base_net->act_mod_lock);
+
+	return 0;
+}
+
+static void __net_exit tcf_p4_act_base_exit_net(struct net *net)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+	struct tc_action_ops *ops, *tmp;
+
+	list_for_each_entry_safe(ops, tmp, &p4_base_net->act_base, p4_head) {
+		list_del(&ops->p4_head);
+	}
+}
+
+static struct pernet_operations tcf_p4_act_base_net_ops = {
+	.init = tcf_p4_act_base_init_net,
+	.exit = tcf_p4_act_base_exit_net,
+	.id = &p4_act_net_id,
+	.size = sizeof(struct tc_action_ops),
+};
+
 static void tcf_set_action_cookie(struct tc_cookie __rcu **old_cookie,
 				  struct tc_cookie *new_cookie)
 {
@@ -962,6 +996,48 @@ static void tcf_pernet_del_id_list(unsigned int id)
 	mutex_unlock(&act_id_mutex);
 }
 
+static struct tc_action_ops *tc_lookup_p4_action(struct net *net, char *kind)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+	struct tc_action_ops *a, *res = NULL;
+
+	read_lock(&p4_base_net->act_mod_lock);
+	list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
+		if (strcmp(kind, a->kind) == 0) {
+			if (try_module_get(a->owner))
+				res = a;
+			break;
+		}
+	}
+	read_unlock(&p4_base_net->act_mod_lock);
+
+	return res;
+}
+
+void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	write_lock(&p4_base_net->act_mod_lock);
+	list_del(&act->p4_head);
+	write_unlock(&p4_base_net->act_mod_lock);
+}
+EXPORT_SYMBOL(tcf_unregister_p4_action);
+
+int tcf_register_p4_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	if (tc_lookup_p4_action(net, act->kind))
+		return -EEXIST;
+
+	write_lock(&p4_base_net->act_mod_lock);
+	list_add(&act->p4_head, &p4_base_net->act_base);
+	write_unlock(&p4_base_net->act_mod_lock);
+
+	return 0;
+}
+
 int tcf_register_action(struct tc_action_ops *act,
 			struct pernet_operations *ops)
 {
@@ -1032,7 +1108,7 @@ int tcf_unregister_action(struct tc_action_ops *act,
 EXPORT_SYMBOL(tcf_unregister_action);
 
 /* lookup by name */
-static struct tc_action_ops *tc_lookup_action_n(char *kind)
+static struct tc_action_ops *tc_lookup_action_n(struct net *net, char *kind)
 {
 	struct tc_action_ops *a, *res = NULL;
 
@@ -1040,31 +1116,48 @@ static struct tc_action_ops *tc_lookup_action_n(char *kind)
 		read_lock(&act_mod_lock);
 		list_for_each_entry(a, &act_base, head) {
 			if (strcmp(kind, a->kind) == 0) {
-				if (try_module_get(a->owner))
-					res = a;
-				break;
+				if (try_module_get(a->owner)) {
+					read_unlock(&act_mod_lock);
+					return a;
+				}
 			}
 		}
 		read_unlock(&act_mod_lock);
+
+		return tc_lookup_p4_action(net, kind);
 	}
+
 	return res;
 }
 
 /* lookup by nlattr */
-static struct tc_action_ops *tc_lookup_action(struct nlattr *kind)
+static struct tc_action_ops *tc_lookup_action(struct net *net,
+					      struct nlattr *kind)
 {
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
 	struct tc_action_ops *a, *res = NULL;
 
 	if (kind) {
 		read_lock(&act_mod_lock);
 		list_for_each_entry(a, &act_base, head) {
+			if (nla_strcmp(kind, a->kind) == 0) {
+				if (try_module_get(a->owner)) {
+					read_unlock(&act_mod_lock);
+					return a;
+				}
+			}
+		}
+		read_unlock(&act_mod_lock);
+
+		read_lock(&p4_base_net->act_mod_lock);
+		list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
 			if (nla_strcmp(kind, a->kind) == 0) {
 				if (try_module_get(a->owner))
 					res = a;
 				break;
 			}
 		}
-		read_unlock(&act_mod_lock);
+		read_unlock(&p4_base_net->act_mod_lock);
 	}
 	return res;
 }
@@ -1324,8 +1417,9 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 	}
 }
 
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
-					 struct netlink_ext_ack *extack)
+struct tc_action_ops *
+tc_action_load_ops(struct net *net, struct nlattr *nla,
+		   u32 flags, struct netlink_ext_ack *extack)
 {
 	bool police = flags & TCA_ACT_FLAGS_POLICE;
 	struct nlattr *tb[TCA_ACT_MAX + 1];
@@ -1356,7 +1450,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 		}
 	}
 
-	a_o = tc_lookup_action_n(act_name);
+	a_o = tc_lookup_action_n(net, act_name);
 	if (a_o == NULL) {
 #ifdef CONFIG_MODULES
 		bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
@@ -1367,7 +1461,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 		if (rtnl_held)
 			rtnl_lock();
 
-		a_o = tc_lookup_action_n(act_name);
+		a_o = tc_lookup_action_n(net, act_name);
 
 		/* We dropped the RTNL semaphore in order to
 		 * perform the module load.  So, even if we
@@ -1477,7 +1571,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-		a_o = tc_action_load_ops(tb[i], flags, extack);
+		a_o = tc_action_load_ops(net, tb[i], flags, extack);
 		if (IS_ERR(a_o)) {
 			err = PTR_ERR(a_o);
 			goto err_mod;
@@ -1683,7 +1777,7 @@ static struct tc_action *tcf_action_get_1(struct net *net, struct nlattr *nla,
 	index = nla_get_u32(tb[TCA_ACT_INDEX]);
 
 	err = -EINVAL;
-	ops = tc_lookup_action(tb[TCA_ACT_KIND]);
+	ops = tc_lookup_action(net, tb[TCA_ACT_KIND]);
 	if (!ops) { /* could happen in batch of actions */
 		NL_SET_ERR_MSG(extack, "Specified TC action kind not found");
 		goto err_out;
@@ -1731,7 +1825,7 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
 
 	err = -EINVAL;
 	kind = tb[TCA_ACT_KIND];
-	ops = tc_lookup_action(kind);
+	ops = tc_lookup_action(net, kind);
 	if (!ops) { /*some idjot trying to flush unknown action */
 		NL_SET_ERR_MSG(extack, "Cannot flush unknown TC action");
 		goto err_out;
@@ -2184,7 +2278,7 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 		return 0;
 	}
 
-	a_o = tc_lookup_action(kind);
+	a_o = tc_lookup_action(net, kind);
 	if (a_o == NULL)
 		return 0;
 
@@ -2251,6 +2345,7 @@ static int __init tc_action_init(void)
 	rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action,
 		      0);
 
+	register_pernet_subsys(&tcf_p4_act_base_net_ops);
 	return 0;
 }
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 92a12e3d0..2fec3f80b 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3323,7 +3323,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 			struct tc_action_ops *a_o;
 
 			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
-			a_o = tc_action_load_ops(tb[exts->police], flags,
+			a_o = tc_action_load_ops(net, tb[exts->police], flags,
 						 extack);
 			if (IS_ERR(a_o))
 				return PTR_ERR(a_o);
-- 
2.34.1


