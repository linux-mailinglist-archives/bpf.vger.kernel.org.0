Return-Path: <bpf+bounces-26168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E48CA89BEBE
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 14:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC881F23C72
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AA6A8BA;
	Mon,  8 Apr 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QuW4BBab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850223032A
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578816; cv=none; b=DJ+eEFHy+lCPpAnilDb3nQhx1bQlwXB4RZez95m8nRl2g0L5nP6m8E5wrN/XNyUQqE8RY+HZzepTZ/j3isRkrleuZvQOT1OL7J5RpF9787KuB0EYI9HyxoCN9blfOs8NdBShXDvFGmCE84L45mv7hP7rC2acmH1K8u4Q1QVaN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578816; c=relaxed/simple;
	bh=vwMhx54AfmXtEHqs+XgaSmKhWZ5B3d2OOaqFtVCl2HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFvfYUwBvBaqwnFzRyGKJ/QV+FL62aEW0F2JiTkZ2KusdAR5ZUenhIDnBlHGgA3pVyFOkCR3VIEkPPrh6jD3jeDuUgYl9x7ilNEFVyhexBnF8H7veEO6G9LmY5W+YtQ/CzabXhw/4Yaz2m9k62Btv9QpjqYx/hQAxh53GugpxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QuW4BBab; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78d5751901bso125044685a.1
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578813; x=1713183613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsCeTTKwm4iAMlERv0S7r6sR5xF6ELK31gcw2MdmGCI=;
        b=QuW4BBabZaviwuS+QJe35dPJ29c08WJR6DDkmZ7fe7vWtmX7xU3oUoek5ONhVPzH1d
         rgf0SM1sk+e9lmQyruB/65zn38WVST8FYKlhQeVVfd3eGYeJaEqdXKPekBr19ZzzJg3o
         RBN5gBr/dlH4tmyoY4y7pVYeMUaYF8TsmBO+I4/Ivwq1X3Oeh1q5oI2UCZ3axZ4agYOt
         KXEZOEI1aLqCoVBSjWlU10xyhAGUGSIX6ETY+672x2q3l74ZY6Y+R3hg/vQMX+zU6rgE
         wYyg/ZbNieIZMx/rP4akTTth0JjFlktcvzg+fIxLw7h6cnlAwZ9dXmTmYvAU3wewWI3R
         gudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578813; x=1713183613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsCeTTKwm4iAMlERv0S7r6sR5xF6ELK31gcw2MdmGCI=;
        b=VDPYRbRscSWO7CjOxGbs0L4qYxiyPlL0ZP2BBxgWviyX2iS3fF1FBgqE2oSwvzFQ10
         5Q5bXbb4dPAT4E0dWTHtxXdwMHoxCzSbQD6BJGFBhxBv9HYubFjoHgLOgnV3pfpjiCEN
         xZgV8Ux2POQ4iiCRbxLNU0TMofeMAhIT9Pc00mMy2aQH0Q5zUjcLFIDZ98hTszKpr5zR
         ltx73H29MbwCqvMEx30A8OJV+d5i2Bx1jrD37+3z+kpyZjtvAzfk30H7KF6CDFwX7Sr0
         2YUEs4IV0JOD4pU8WIhw6dnedsdvKmuAKqKHiMXynJEyHVdO+NjxbiM9DHIoYtzzY5IQ
         x1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwXIoqne7+XyZZaIEHhtJJYpmWIEFSfMsSW5p4dTGZKSYSG+DZzql/b67T6WkCQ8nWCNx8R3BBBPX3fjmZizP2eCg2
X-Gm-Message-State: AOJu0Yy5vRgQ7Sw77YITLOUR8PNVtuAS1BVaAXmxVEmwfKoU/H4gdI+z
	usN01r+ZHglAsxzz1/cOyR1HejHoQQq4dyt9U11jfYZZ8X+EaU4PsSGaDT4m6w==
X-Google-Smtp-Source: AGHT+IEE2z/y47jWZOG3rxCkXFvKk3NHg6UTpuaIRDQvZyA33WwQRNRIvgHJDVPn6LuIaMikRXGJdw==
X-Received: by 2002:a05:620a:24d4:b0:78a:5a5a:f123 with SMTP id m20-20020a05620a24d400b0078a5a5af123mr10423948qkn.22.1712578813448;
        Mon, 08 Apr 2024 05:20:13 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:12 -0700 (PDT)
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
Subject: [PATCH net-next v15  01/15] net: sched: act_api: Introduce P4 actions list
Date: Mon,  8 Apr 2024 08:19:46 -0400
Message-Id: <20240408122000.449238-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408122000.449238-1-jhs@mojatatu.com>
References: <20240408122000.449238-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h |   8 ++-
 net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
 net/sched/cls_api.c   |   2 +-
 3 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 77ee0c657e..f22be14bba 100644
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
index 9ee622fb11..be78df3345 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
 	kfree(cookie);
 }
 
+static unsigned int p4_act_net_id;
+
+struct tcf_p4_act_net {
+	struct list_head act_base;
+	struct mutex act_mod_lock; /* P4 actions list mutex */
+};
+
+static __net_init int tcf_p4_act_base_init_net(struct net *net)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	INIT_LIST_HEAD(&p4_base_net->act_base);
+	mutex_init(&p4_base_net->act_mod_lock);
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
+	mutex_lock(&p4_base_net->act_mod_lock);
+	list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
+		if (strcmp(kind, a->kind) == 0) {
+			if (try_module_get(a->owner))
+				res = a;
+			break;
+		}
+	}
+	mutex_unlock(&p4_base_net->act_mod_lock);
+
+	return res;
+}
+
+void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	mutex_lock(&p4_base_net->act_mod_lock);
+	list_del(&act->p4_head);
+	mutex_unlock(&p4_base_net->act_mod_lock);
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
+	mutex_lock(&p4_base_net->act_mod_lock);
+	list_add(&act->p4_head, &p4_base_net->act_base);
+	mutex_unlock(&p4_base_net->act_mod_lock);
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
+		mutex_lock(&p4_base_net->act_mod_lock);
+		list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
 			if (nla_strcmp(kind, a->kind) == 0) {
 				if (try_module_get(a->owner))
 					res = a;
 				break;
 			}
 		}
-		read_unlock(&act_mod_lock);
+		mutex_unlock(&p4_base_net->act_mod_lock);
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
index db06539936..f5a02c9586 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3367,7 +3367,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 			struct tc_action_ops *a_o;
 
 			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
-			a_o = tc_action_load_ops(tb[exts->police], flags,
+			a_o = tc_action_load_ops(net, tb[exts->police], flags,
 						 extack);
 			if (IS_ERR(a_o))
 				return PTR_ERR(a_o);
-- 
2.34.1


