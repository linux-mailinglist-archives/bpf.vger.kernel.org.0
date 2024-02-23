Return-Path: <bpf+bounces-22581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A986127C
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D651C22ED2
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39087EEF6;
	Fri, 23 Feb 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NROovgdO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54A7E581
	for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694263; cv=none; b=n6dKzF7dVIE0w9GYLJEyC2j1+E6Fc5MyA901sFjD5AUvSC1OCCg1gWU5YGZk5rZFDQ25udghNDAHsXaacBUzYFCvb+XRs2QRFq5bnT6alS1grWoC2UeF9wdcFZhZsO8bm51y+/ZYPXpaJGAwEqd9n3ifxIFY9K2mLrCUU8iVJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694263; c=relaxed/simple;
	bh=DuN16/GHtiXicqQjZnAyJxVvt/HpXSnC+FHTG0u57aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thB9n1UbCZGGKE/lLUaN4nVn+tKk4eZrmsxYxLhqelebtGibxoOW/XaIQf6y1NWnhemIrA5xwKp/LAPT8yPJnecHNWKZvuwKMiNd6ytdS1AH+mx8wkRpMGXRX0XEFQCW5bxlrVsTh1LBgzbyAy0O/StO2N/fnfdTWQEAmcB3EsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NROovgdO; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-787bb0d85eeso6010985a.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 05:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708694260; x=1709299060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAHOQV4oPNy02lcG5z08rhQUzQ6DMeoFljHIxr5JlHM=;
        b=NROovgdOZOuKosdTiNHRoWBcFL721O2DUDRSbFkSbO+txfa2wz7WAlceWd/TIEX2Af
         xQjIXvGvDF67k8HWEO0E9/0EM9D6zUrNq0R28tOvDOVVLrw2FBH8tZaRhO8rP7gsLduo
         j7VpOwDIzB5Kym7FRArjAMqQ1TzmwoPS7Fy/jCjU3IJ7caJNqpI57hUI08u3xf6JtsM9
         EahHXdddxVD7yfNxzDo4bgrqNT0d1LEBhPZCUQh27tgzPL7krcLUX/eMM5sseOq/7Xor
         sP4DMsKfx99fLt4+QDJm6tWV15fnYGoMRUbiZTPxn3RxlL+aLq3lh32umPtQ9Hcx1T1w
         yOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694260; x=1709299060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAHOQV4oPNy02lcG5z08rhQUzQ6DMeoFljHIxr5JlHM=;
        b=G13qvaz25B95KeIDqSPFdLH8TxErPRYLlW9lye/ImUS+GDb8YZ8U9zXsSSShKTbDDt
         MfH5jQF6iaePrwhQ6dO02gDpK2pOl74llKVAy90pmNRJkJ6+eUGsCg1+Zp2Y57MDDLQQ
         njG/WaEG8luM4rhAqoJxRjBJil0KuLoJoitUdCrHwasOHOESTrOtbF9dmtbQa6LBBQ94
         muap0Xg8GzlkRVYSAI8hBQUiUdpJGwG4MTbLc0m6omsz3jeQEWqkOHFAFt6n7lUo+AKy
         Wyx0pywWn90MnXVcGFR+AeBFE51qFPhafuY5n8SkFz2wLCsD1/Glg3PFUmsIDMHHFBUt
         Rq3w==
X-Forwarded-Encrypted: i=1; AJvYcCVTIuKvUIVLIGv6XCoLs7ZIbAK/2pRb4+8qi41DKFZoxOpgZ3Vn5xWq2lGbZM2rL8lnE5FimqP9ojujpk9W4gBaHaxn
X-Gm-Message-State: AOJu0YwxOVF+JTtxoLzLkpmB0yCN+V1O6cUytT0nHAU8OZi5qyUbX/IT
	mud3mZn4a2LdTdydr5SbVckyS8R6pU7B+Z3gurscG4hcvcRaHcolEtVJaBHtvg==
X-Google-Smtp-Source: AGHT+IGQeZC37HePou7qZuHot10nlvPbQu3mgsTSUdaqqj8hbuYqrU3C4+j2zmCSq1RMAwm44AXDEg==
X-Received: by 2002:a05:620a:3711:b0:783:d369:6e5a with SMTP id de17-20020a05620a371100b00783d3696e5amr2683529qkb.76.1708694260010;
        Fri, 23 Feb 2024 05:17:40 -0800 (PST)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id f3-20020a05620a15a300b00787ae919d02sm844869qkk.17.2024.02.23.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:17:39 -0800 (PST)
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
Subject: [PATCH net-next v11 1/5] net: sched: act_api: Introduce P4 actions list
Date: Fri, 23 Feb 2024 08:17:24 -0500
Message-Id: <20240223131728.116717-2-jhs@mojatatu.com>
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
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h |   8 ++-
 net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
 net/sched/cls_api.c   |   2 +-
 3 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 77ee0c657..f22be14bb 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 
 struct tc_action_ops {
 	struct list_head head;
+	struct list_head p4_head;
 	char    kind[IFNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
@@ -199,10 +200,12 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 int tcf_idr_release(struct tc_action *a, bool bind);
 
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
+int tcf_register_p4_action(struct net *net, struct tc_action_ops *act);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
 #define NET_ACT_ALIAS_PREFIX "net-act-"
 #define MODULE_ALIAS_NET_ACT(kind)	MODULE_ALIAS(NET_ACT_ALIAS_PREFIX kind)
+void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act);
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
@@ -210,8 +213,9 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
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
index 9ee622fb1..23ef394f2 100644
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
index ca5676b26..142f49a2c 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3330,7 +3330,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 			struct tc_action_ops *a_o;
 
 			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
-			a_o = tc_action_load_ops(tb[exts->police], flags,
+			a_o = tc_action_load_ops(net, tb[exts->police], flags,
 						 extack);
 			if (IS_ERR(a_o))
 				return PTR_ERR(a_o);
-- 
2.34.1


