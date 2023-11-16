Return-Path: <bpf+bounces-15177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC557EE38F
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492911F2162E
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5E334565;
	Thu, 16 Nov 2023 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UmcHQ1ZL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34781AD
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:55 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7789577b53fso49219385a.3
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700146795; x=1700751595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+3Nwi8PU7UsCzzULsYQhzP0vrlUHaTxu4/KmSx/ZYM=;
        b=UmcHQ1ZLrrt+kJa7cc+6Y5n9xZOhzdvN1XrwN1VfZ1vJEsB7fOnlAMf+rCaLsIrGmL
         +UwAgGv9MTq/30Udci7sECDFvVbj8KStPSdotCOZxK5+IXOWnFoL2c164UUhi7mIgSaJ
         XKaQACNHfxHGpzgBqt2GpfklhbLtmbUJOsuI9RDo3CbQU8M+7mOExjl82VwkaiaUCq8n
         LGc3uPsEWFLmepM25JmV0YJAvUivm/Sv0WeoKHh3FJHSmF6gHgqiDjzmumNh6elnPP1M
         oeWC1id+M62SnRnw53Hunx6Jtx3kNPiLLZ6/yvyvhU8GLMjZCTMZnz09PrXUEdmeqPxi
         76jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146795; x=1700751595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+3Nwi8PU7UsCzzULsYQhzP0vrlUHaTxu4/KmSx/ZYM=;
        b=Oa0EhNUsHkryoDDn0ZwOwtsPP7+GvdzIpxXPaqSunmnSUm21oa15eMZGYEcWcls2MB
         V9K7jPG13lJ1tUHGgqy8vfBM2aVgNKSb08geFUpkaLnwh46AdOoY3heDe6C0OuUpsvVp
         mE1owuRFwZuS8yevNw6PA63/ZKi6OxugQQS08C20ufmud7ZVGpqwE0sVQqZ71BNod36b
         xountb0zEcNlL8HsZU1znlFpeseahpYF3FRkoByGNE0mtNnK3MMudqUi+ynUj5PVB/s3
         Cp+QyjJX+vdLsRtFBX6eI3G8qnbI2xTUSKqS6ME5hMjfKE/CCX5hBKNQoMwTMhNFCGcN
         Ynaw==
X-Gm-Message-State: AOJu0YyBGoZbMy+AO2cBkxWvuBSoqizZq07+8EeQTvmXGKpoHHvt77Gn
	VqvUNEGP9Hs+l8/lwpCPq2giuw==
X-Google-Smtp-Source: AGHT+IEWBQg3bKELVndKSEUk5/+/duwFonoOr6VK27xSQAbIBZN/7aXIrfyM9XOaoQOtENwrIn2haQ==
X-Received: by 2002:a05:620a:244b:b0:769:89c8:4fae with SMTP id h11-20020a05620a244b00b0076989c84faemr10003215qkn.52.1700146794945;
        Thu, 16 Nov 2023 06:59:54 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b00774376e6475sm1059688qkn.6.2023.11.16.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:59:53 -0800 (PST)
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
Subject: [PATCH net-next v8 01/15] net: sched: act_api: Introduce dynamic actions list
Date: Thu, 16 Nov 2023 09:59:34 -0500
Message-Id: <20231116145948.203001-2-jhs@mojatatu.com>
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

In P4 we require to generate new actions "on the fly" based on the
specified P4 action definition. Dynamic action kinds, like the pipeline
they are attached to, must be per net namespace, as opposed to native
action kinds which are global. For that reason, we chose to create a
separate structure to store dynamic actions.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h |   7 ++-
 net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
 net/sched/cls_api.c   |   2 +-
 3 files changed, 115 insertions(+), 17 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4ae0580b6..3d40adef1 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 
 struct tc_action_ops {
 	struct list_head head;
+	struct list_head dyn_head;
 	char    kind[IFNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
@@ -198,8 +199,10 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 int tcf_idr_release(struct tc_action *a, bool bind);
 
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
+int tcf_register_dyn_action(struct net *net, struct tc_action_ops *act);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+void tcf_unregister_dyn_action(struct net *net, struct tc_action_ops *act);
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
@@ -207,8 +210,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		    struct nlattr *est,
 		    struct tc_action *actions[], int init_res[], size_t *attr_size,
 		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
+					 bool police, bool rtnl_held,
 					 struct netlink_ext_ack *extack);
 struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 				    struct nlattr *nla, struct nlattr *est,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c39252d61..443c49116 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
 	kfree(cookie);
 }
 
+static unsigned int dyn_act_net_id;
+
+struct tcf_dyn_act_net {
+	struct list_head act_base;
+	rwlock_t act_mod_lock;
+};
+
+static __net_init int tcf_dyn_act_base_init_net(struct net *net)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+
+	INIT_LIST_HEAD(&dyn_base_net->act_base);
+	rwlock_init(&dyn_base_net->act_mod_lock);
+
+	return 0;
+}
+
+static void __net_exit tcf_dyn_act_base_exit_net(struct net *net)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	struct tc_action_ops *ops, *tmp;
+
+	list_for_each_entry_safe(ops, tmp, &dyn_base_net->act_base, dyn_head) {
+		list_del(&ops->dyn_head);
+	}
+}
+
+static struct pernet_operations tcf_dyn_act_base_net_ops = {
+	.init = tcf_dyn_act_base_init_net,
+	.exit = tcf_dyn_act_base_exit_net,
+	.id = &dyn_act_net_id,
+	.size = sizeof(struct tc_action_ops),
+};
+
 static void tcf_set_action_cookie(struct tc_cookie __rcu **old_cookie,
 				  struct tc_cookie *new_cookie)
 {
@@ -941,6 +975,48 @@ static void tcf_pernet_del_id_list(unsigned int id)
 	mutex_unlock(&act_id_mutex);
 }
 
+static struct tc_action_ops *tc_lookup_dyn_action(struct net *net, char *kind)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	struct tc_action_ops *a, *res = NULL;
+
+	read_lock(&dyn_base_net->act_mod_lock);
+	list_for_each_entry(a, &dyn_base_net->act_base, dyn_head) {
+		if (strcmp(kind, a->kind) == 0) {
+			if (try_module_get(a->owner))
+				res = a;
+			break;
+		}
+	}
+	read_unlock(&dyn_base_net->act_mod_lock);
+
+	return res;
+}
+
+void tcf_unregister_dyn_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+
+	write_lock(&dyn_base_net->act_mod_lock);
+	list_del(&act->dyn_head);
+	write_unlock(&dyn_base_net->act_mod_lock);
+}
+EXPORT_SYMBOL(tcf_unregister_dyn_action);
+
+int tcf_register_dyn_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+
+	if (tc_lookup_dyn_action(net, act->kind))
+		return -EEXIST;
+
+	write_lock(&dyn_base_net->act_mod_lock);
+	list_add(&act->dyn_head, &dyn_base_net->act_base);
+	write_unlock(&dyn_base_net->act_mod_lock);
+
+	return 0;
+}
+
 int tcf_register_action(struct tc_action_ops *act,
 			struct pernet_operations *ops)
 {
@@ -1011,7 +1087,7 @@ int tcf_unregister_action(struct tc_action_ops *act,
 EXPORT_SYMBOL(tcf_unregister_action);
 
 /* lookup by name */
-static struct tc_action_ops *tc_lookup_action_n(char *kind)
+static struct tc_action_ops *tc_lookup_action_n(struct net *net, char *kind)
 {
 	struct tc_action_ops *a, *res = NULL;
 
@@ -1019,31 +1095,48 @@ static struct tc_action_ops *tc_lookup_action_n(char *kind)
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
+		return tc_lookup_dyn_action(net, kind);
 	}
+
 	return res;
 }
 
 /* lookup by nlattr */
-static struct tc_action_ops *tc_lookup_action(struct nlattr *kind)
+static struct tc_action_ops *tc_lookup_action(struct net *net,
+					      struct nlattr *kind)
 {
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
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
+		read_lock(&dyn_base_net->act_mod_lock);
+		list_for_each_entry(a, &dyn_base_net->act_base, dyn_head) {
 			if (nla_strcmp(kind, a->kind) == 0) {
 				if (try_module_get(a->owner))
 					res = a;
 				break;
 			}
 		}
-		read_unlock(&act_mod_lock);
+		read_unlock(&dyn_base_net->act_mod_lock);
 	}
 	return res;
 }
@@ -1294,8 +1387,8 @@ void tcf_idr_insert_many(struct tc_action *actions[])
 	}
 }
 
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
+					 bool police, bool rtnl_held,
 					 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[TCA_ACT_MAX + 1];
@@ -1326,7 +1419,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 		}
 	}
 
-	a_o = tc_lookup_action_n(act_name);
+	a_o = tc_lookup_action_n(net, act_name);
 	if (a_o == NULL) {
 #ifdef CONFIG_MODULES
 		if (rtnl_held)
@@ -1335,7 +1428,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 		if (rtnl_held)
 			rtnl_lock();
 
-		a_o = tc_lookup_action_n(act_name);
+		a_o = tc_lookup_action_n(net, act_name);
 
 		/* We dropped the RTNL semaphore in order to
 		 * perform the module load.  So, even if we
@@ -1445,7 +1538,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-		a_o = tc_action_load_ops(tb[i], flags & TCA_ACT_FLAGS_POLICE,
+		a_o = tc_action_load_ops(net, tb[i],
+					 flags & TCA_ACT_FLAGS_POLICE,
 					 !(flags & TCA_ACT_FLAGS_NO_RTNL),
 					 extack);
 		if (IS_ERR(a_o)) {
@@ -1655,7 +1749,7 @@ static struct tc_action *tcf_action_get_1(struct net *net, struct nlattr *nla,
 	index = nla_get_u32(tb[TCA_ACT_INDEX]);
 
 	err = -EINVAL;
-	ops = tc_lookup_action(tb[TCA_ACT_KIND]);
+	ops = tc_lookup_action(net, tb[TCA_ACT_KIND]);
 	if (!ops) { /* could happen in batch of actions */
 		NL_SET_ERR_MSG(extack, "Specified TC action kind not found");
 		goto err_out;
@@ -1703,7 +1797,7 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
 
 	err = -EINVAL;
 	kind = tb[TCA_ACT_KIND];
-	ops = tc_lookup_action(kind);
+	ops = tc_lookup_action(net, kind);
 	if (!ops) { /*some idjot trying to flush unknown action */
 		NL_SET_ERR_MSG(extack, "Cannot flush unknown TC action");
 		goto err_out;
@@ -2109,7 +2203,7 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 		return 0;
 	}
 
-	a_o = tc_lookup_action(kind);
+	a_o = tc_lookup_action(net, kind);
 	if (a_o == NULL)
 		return 0;
 
@@ -2176,6 +2270,7 @@ static int __init tc_action_init(void)
 	rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action,
 		      0);
 
+	register_pernet_subsys(&tcf_dyn_act_base_net_ops);
 	return 0;
 }
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163..2db3c13c7 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3293,7 +3293,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 		if (exts->police && tb[exts->police]) {
 			struct tc_action_ops *a_o;
 
-			a_o = tc_action_load_ops(tb[exts->police], true,
+			a_o = tc_action_load_ops(net, tb[exts->police], true,
 						 !(flags & TCA_ACT_FLAGS_NO_RTNL),
 						 extack);
 			if (IS_ERR(a_o))
-- 
2.34.1


