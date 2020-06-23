Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC90204F1C
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgFWKfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgFWKfG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:35:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0337FC061755
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:35:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d21so9292929lfb.6
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x49riPm2gdjWrRq8uPjVD9NPs9kiwf+QKMpwkUFmfCY=;
        b=cdnxv2vVEmjmajJjn7WPF8mbobAWo0i9Pl7ly5Lz5Y8Tc8WXVggkEYPTYZmn8Sc4Az
         zz+nWX87FNWXEWZIOApEZn0g+2KwmyAkbQnnBsVy6wHs8+V+nHhfU+W2iU2yFWWhmOGH
         DGKnerd+5gkkbdDbng4RlvbPFZlvd/7KeMv4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x49riPm2gdjWrRq8uPjVD9NPs9kiwf+QKMpwkUFmfCY=;
        b=Y5jMs3MjK1Jgs5cRExwbylcvu7OKCePVo6EeLUSvjvMMfxBFshiuM4IF5KgDhcDfYP
         uhyHXP7DcXd8IbK6BwY7h4tVaL7cW/8iGThfLicoG7+7T0mBH4Cgw3IWM7b2E9OC/Gqt
         mH9f4nU1NRcVZMC0Uf3GC6HJwT41BUmVCyqB+gleQA6yzUoDmrIFRptVBTArdzJx0GoY
         a5yZeR6iQIyqpOp1u02QeW78ddk/PpAAYj7cMrD77EOKCd3SC7Yz4njbrulRGThZgmO3
         FqRgi11wT0JbYmZz5YWSXjYFt4+XiaPRQ5cErJhuUjU7BdcO7Un/+ZOht7aLZg/GS6c6
         XRRA==
X-Gm-Message-State: AOAM533J+ACOJtOswlOXgnD4Qlu46k0mhgZGbCf3mZ/GDDaHObLklIQI
        +CoZGyrZ0JbwLG7Jglzauv1g+2b5Sqfztw==
X-Google-Smtp-Source: ABdhPJxivLfiWDIbU5i5FknegHgPkCOLTpT69DJVJYyajSs+9EMLWZLVR4+rBRDSduNObvwOP/3rDA==
X-Received: by 2002:a05:6512:3295:: with SMTP id p21mr12248159lfe.114.1592908503864;
        Tue, 23 Jun 2020 03:35:03 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 25sm3173080ljh.139.2020.06.23.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:35:03 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v2 2/3] bpf, netns: Keep attached programs in bpf_prog_array
Date:   Tue, 23 Jun 2020 12:34:58 +0200
Message-Id: <20200623103459.697774-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200623103459.697774-1-jakub@cloudflare.com>
References: <20200623103459.697774-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prepare for having multi-prog attachments for new netns attach types by
storing programs to run in a bpf_prog_array, which is well suited for
iterating over programs and running them in sequence.

Because bpf_prog_array is dynamically resized, after this change a
potentially blocking memory allocation in bpf(PROG_QUERY) callback can
happen, in order to collect program IDs before copying the values to
user-space supplied buffer. This forces us to adapt how we protect access
to the attached program in the callback. As bpf_prog_array_copy_to_user()
helper can sleep, we switch from an RCU read lock to holding a mutex that
serializes updaters.

To handle bpf(PROG_ATTACH) scenario when we are replacing an already
attached program, we introduce a new bpf_prog_array helper called
bpf_prog_array_replace_item that will exchange the old program with a new
one. bpf-cgroup does away with such helper by computing an index into the
array from a program position in an external list of attached
programs/links. Such approach fails when a dummy prog is left in the array
after a memory allocation failure on link release, but is necessary in
bpf-cgroup case because the same BPF program can be present in the array
multiple times due to inheritance, and attachment cannot be reliably
identified by bpf_prog pointer comparison.

No functional changes intended.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf.h        |   3 +
 include/net/netns/bpf.h    |   5 +-
 kernel/bpf/core.c          |  20 ++++--
 kernel/bpf/net_namespace.c | 137 +++++++++++++++++++++++++++----------
 net/core/flow_dissector.c  |  21 +++---
 5 files changed, 132 insertions(+), 54 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1e1501ee53ce..5d0506f46f24 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -928,6 +928,9 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
 			struct bpf_prog_array **new_array);
+int bpf_prog_array_replace_item(struct bpf_prog_array *array,
+				struct bpf_prog *old_prog,
+				struct bpf_prog *new_prog);
 
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
diff --git a/include/net/netns/bpf.h b/include/net/netns/bpf.h
index a8dce2a380c8..a5015bda9979 100644
--- a/include/net/netns/bpf.h
+++ b/include/net/netns/bpf.h
@@ -9,9 +9,12 @@
 #include <linux/bpf-netns.h>
 
 struct bpf_prog;
+struct bpf_prog_array;
 
 struct netns_bpf {
-	struct bpf_prog __rcu *progs[MAX_NETNS_BPF_ATTACH_TYPE];
+	/* Array of programs to run compiled from progs or links */
+	struct bpf_prog_array __rcu *run_array[MAX_NETNS_BPF_ATTACH_TYPE];
+	struct bpf_prog *progs[MAX_NETNS_BPF_ATTACH_TYPE];
 	struct bpf_link *links[MAX_NETNS_BPF_ATTACH_TYPE];
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9df4cc9a2907..07937ddf722f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1946,16 +1946,26 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array *array,
 	return 0;
 }
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array *array,
-				struct bpf_prog *old_prog)
+int bpf_prog_array_replace_item(struct bpf_prog_array *array,
+				struct bpf_prog *old_prog,
+				struct bpf_prog *new_prog)
 {
 	struct bpf_prog_array_item *item;
 
-	for (item = array->items; item->prog; item++)
+	for (item = array->items; item->prog; item++) {
 		if (item->prog == old_prog) {
-			WRITE_ONCE(item->prog, &dummy_bpf_prog.prog);
-			break;
+			WRITE_ONCE(item->prog, new_prog);
+			return 0;
 		}
+	}
+	return -ENOENT;
+}
+
+void bpf_prog_array_delete_safe(struct bpf_prog_array *array,
+				struct bpf_prog *old_prog)
+{
+	(void)bpf_prog_array_replace_item(array, old_prog,
+					  &dummy_bpf_prog.prog);
 }
 
 int bpf_prog_array_copy(struct bpf_prog_array *old_array,
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index b951dab2687f..593523a22168 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -38,7 +38,9 @@ static void bpf_netns_link_release(struct bpf_link *link)
 	struct bpf_netns_link *net_link =
 		container_of(link, struct bpf_netns_link, link);
 	enum netns_bpf_attach_type type = net_link->netns_type;
+	struct bpf_prog_array *old_array, *new_array;
 	struct net *net;
+	int err;
 
 	/* Link auto-detached by dying netns. */
 	if (!net_link->net)
@@ -54,8 +56,20 @@ static void bpf_netns_link_release(struct bpf_link *link)
 	if (!net)
 		goto out_unlock;
 
+	/* Rebuild run array without the prog or replace it with a
+	 * dummy one because we cannot fail during link release.
+	 */
+	old_array = rcu_dereference_protected(net->bpf.run_array[type],
+					      lockdep_is_held(&netns_bpf_mutex));
+	err = bpf_prog_array_copy(old_array, link->prog, NULL, &new_array);
+	if (err) {
+		bpf_prog_array_delete_safe(old_array, link->prog);
+	} else {
+		rcu_assign_pointer(net->bpf.run_array[type], new_array);
+		bpf_prog_array_free(old_array);
+	}
+
 	net->bpf.links[type] = NULL;
-	RCU_INIT_POINTER(net->bpf.progs[type], NULL);
 
 out_unlock:
 	mutex_unlock(&netns_bpf_mutex);
@@ -76,6 +90,7 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
 	struct bpf_netns_link *net_link =
 		container_of(link, struct bpf_netns_link, link);
 	enum netns_bpf_attach_type type = net_link->netns_type;
+	struct bpf_prog_array *run_array;
 	struct net *net;
 	int ret = 0;
 
@@ -93,8 +108,16 @@ static int bpf_netns_link_update_prog(struct bpf_link *link,
 		goto out_unlock;
 	}
 
+	run_array = rcu_dereference_protected(net->bpf.run_array[type],
+					      lockdep_is_held(&netns_bpf_mutex));
+	if (run_array)
+		ret = bpf_prog_array_replace_item(run_array, link->prog, new_prog);
+	else
+		ret = -ENOENT;
+	if (ret)
+		goto out_unlock;
+
 	old_prog = xchg(&link->prog, new_prog);
-	rcu_assign_pointer(net->bpf.progs[type], new_prog);
 	bpf_prog_put(old_prog);
 
 out_unlock:
@@ -142,14 +165,38 @@ static const struct bpf_link_ops bpf_netns_link_ops = {
 	.show_fdinfo = bpf_netns_link_show_fdinfo,
 };
 
+/* Must be called with netns_bpf_mutex held. */
+static int __netns_bpf_prog_query(const union bpf_attr *attr,
+				  union bpf_attr __user *uattr,
+				  struct net *net,
+				  enum netns_bpf_attach_type type)
+{
+	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
+	struct bpf_prog_array *run_array;
+	u32 prog_cnt = 0, flags = 0;
+
+	run_array = rcu_dereference_protected(net->bpf.run_array[type],
+					      lockdep_is_held(&netns_bpf_mutex));
+	if (run_array)
+		prog_cnt = bpf_prog_array_length(run_array);
+
+	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
+		return -EFAULT;
+	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
+		return -EFAULT;
+	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
+		return 0;
+
+	return bpf_prog_array_copy_to_user(run_array, prog_ids,
+					   attr->query.prog_cnt);
+}
+
 int netns_bpf_prog_query(const union bpf_attr *attr,
 			 union bpf_attr __user *uattr)
 {
-	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
-	u32 prog_id, prog_cnt = 0, flags = 0;
 	enum netns_bpf_attach_type type;
-	struct bpf_prog *attached;
 	struct net *net;
+	int ret;
 
 	if (attr->query.query_flags)
 		return -EINVAL;
@@ -162,32 +209,17 @@ int netns_bpf_prog_query(const union bpf_attr *attr,
 	if (IS_ERR(net))
 		return PTR_ERR(net);
 
-	rcu_read_lock();
-	attached = rcu_dereference(net->bpf.progs[type]);
-	if (attached) {
-		prog_cnt = 1;
-		prog_id = attached->aux->id;
-	}
-	rcu_read_unlock();
+	mutex_lock(&netns_bpf_mutex);
+	ret = __netns_bpf_prog_query(attr, uattr, net, type);
+	mutex_unlock(&netns_bpf_mutex);
 
 	put_net(net);
-
-	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
-		return -EFAULT;
-	if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
-		return -EFAULT;
-
-	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
-		return 0;
-
-	if (copy_to_user(prog_ids, &prog_id, sizeof(u32)))
-		return -EFAULT;
-
-	return 0;
+	return ret;
 }
 
 int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
+	struct bpf_prog_array *run_array;
 	enum netns_bpf_attach_type type;
 	struct bpf_prog *attached;
 	struct net *net;
@@ -217,14 +249,25 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (ret)
 		goto out_unlock;
 
-	attached = rcu_dereference_protected(net->bpf.progs[type],
-					     lockdep_is_held(&netns_bpf_mutex));
+	attached = net->bpf.progs[type];
 	if (attached == prog) {
 		/* The same program cannot be attached twice */
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-	rcu_assign_pointer(net->bpf.progs[type], prog);
+
+	run_array = rcu_dereference_protected(net->bpf.run_array[type],
+					      lockdep_is_held(&netns_bpf_mutex));
+	if (run_array) {
+		ret = bpf_prog_array_replace_item(run_array, attached, prog);
+	} else {
+		ret = bpf_prog_array_copy(NULL, NULL, prog, &run_array);
+		rcu_assign_pointer(net->bpf.run_array[type], run_array);
+	}
+	if (ret)
+		goto out_unlock;
+
+	net->bpf.progs[type] = prog;
 	if (attached)
 		bpf_prog_put(attached);
 
@@ -234,6 +277,18 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	return ret;
 }
 
+/* Must be called with netns_bpf_mutex held. */
+static void netns_bpf_run_array_detach(struct net *net,
+				       enum netns_bpf_attach_type type)
+{
+	struct bpf_prog_array *run_array;
+
+	run_array = rcu_dereference_protected(net->bpf.run_array[type],
+					      lockdep_is_held(&netns_bpf_mutex));
+	RCU_INIT_POINTER(net->bpf.run_array[type], NULL);
+	bpf_prog_array_free(run_array);
+}
+
 /* Must be called with netns_bpf_mutex held. */
 static int __netns_bpf_prog_detach(struct net *net,
 				   enum netns_bpf_attach_type type)
@@ -244,11 +299,11 @@ static int __netns_bpf_prog_detach(struct net *net,
 	if (net->bpf.links[type])
 		return -EINVAL;
 
-	attached = rcu_dereference_protected(net->bpf.progs[type],
-					     lockdep_is_held(&netns_bpf_mutex));
+	attached = net->bpf.progs[type];
 	if (!attached)
 		return -ENOENT;
-	RCU_INIT_POINTER(net->bpf.progs[type], NULL);
+	netns_bpf_run_array_detach(net, type);
+	net->bpf.progs[type] = NULL;
 	bpf_prog_put(attached);
 	return 0;
 }
@@ -272,7 +327,7 @@ int netns_bpf_prog_detach(const union bpf_attr *attr)
 static int netns_bpf_link_attach(struct net *net, struct bpf_link *link,
 				 enum netns_bpf_attach_type type)
 {
-	struct bpf_prog *prog;
+	struct bpf_prog_array *old_array, *new_array;
 	int err;
 
 	mutex_lock(&netns_bpf_mutex);
@@ -283,9 +338,7 @@ static int netns_bpf_link_attach(struct net *net, struct bpf_link *link,
 		goto out_unlock;
 	}
 	/* Links are not compatible with attaching prog directly */
-	prog = rcu_dereference_protected(net->bpf.progs[type],
-					 lockdep_is_held(&netns_bpf_mutex));
-	if (prog) {
+	if (net->bpf.progs[type]) {
 		err = -EEXIST;
 		goto out_unlock;
 	}
@@ -301,7 +354,14 @@ static int netns_bpf_link_attach(struct net *net, struct bpf_link *link,
 	if (err)
 		goto out_unlock;
 
-	rcu_assign_pointer(net->bpf.progs[type], link->prog);
+	old_array = rcu_dereference_protected(net->bpf.run_array[type],
+					      lockdep_is_held(&netns_bpf_mutex));
+	err = bpf_prog_array_copy(old_array, NULL, link->prog, &new_array);
+	if (err)
+		goto out_unlock;
+	rcu_assign_pointer(net->bpf.run_array[type], new_array);
+	bpf_prog_array_free(old_array);
+
 	net->bpf.links[type] = link;
 
 out_unlock:
@@ -368,11 +428,12 @@ static void __net_exit netns_bpf_pernet_pre_exit(struct net *net)
 
 	mutex_lock(&netns_bpf_mutex);
 	for (type = 0; type < MAX_NETNS_BPF_ATTACH_TYPE; type++) {
+		netns_bpf_run_array_detach(net, type);
 		link = net->bpf.links[type];
 		if (link)
 			bpf_netns_link_auto_detach(link);
-		else
-			__netns_bpf_prog_detach(net, type);
+		else if (net->bpf.progs[type])
+			bpf_prog_put(net->bpf.progs[type]);
 	}
 	mutex_unlock(&netns_bpf_mutex);
 }
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index b57fb1359395..e501aefb9a0e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -86,14 +86,14 @@ int flow_dissector_bpf_prog_attach_check(struct net *net,
 		for_each_net(ns) {
 			if (ns == &init_net)
 				continue;
-			if (rcu_access_pointer(ns->bpf.progs[type]))
+			if (rcu_access_pointer(ns->bpf.run_array[type]))
 				return -EEXIST;
 		}
 	} else {
 		/* Make sure root flow dissector is not attached
 		 * when attaching to the non-root namespace.
 		 */
-		if (rcu_access_pointer(init_net.bpf.progs[type]))
+		if (rcu_access_pointer(init_net.bpf.run_array[type]))
 			return -EEXIST;
 	}
 
@@ -894,7 +894,6 @@ bool __skb_flow_dissect(const struct net *net,
 	struct flow_dissector_key_addrs *key_addrs;
 	struct flow_dissector_key_tags *key_tags;
 	struct flow_dissector_key_vlan *key_vlan;
-	struct bpf_prog *attached = NULL;
 	enum flow_dissect_ret fdret;
 	enum flow_dissector_key_id dissector_vlan = FLOW_DISSECTOR_KEY_MAX;
 	bool mpls_el = false;
@@ -951,14 +950,14 @@ bool __skb_flow_dissect(const struct net *net,
 	WARN_ON_ONCE(!net);
 	if (net) {
 		enum netns_bpf_attach_type type = NETNS_BPF_FLOW_DISSECTOR;
+		struct bpf_prog_array *run_array;
 
 		rcu_read_lock();
-		attached = rcu_dereference(init_net.bpf.progs[type]);
+		run_array = rcu_dereference(init_net.bpf.run_array[type]);
+		if (!run_array)
+			run_array = rcu_dereference(net->bpf.run_array[type]);
 
-		if (!attached)
-			attached = rcu_dereference(net->bpf.progs[type]);
-
-		if (attached) {
+		if (run_array) {
 			struct bpf_flow_keys flow_keys;
 			struct bpf_flow_dissector ctx = {
 				.flow_keys = &flow_keys,
@@ -966,6 +965,7 @@ bool __skb_flow_dissect(const struct net *net,
 				.data_end = data + hlen,
 			};
 			__be16 n_proto = proto;
+			struct bpf_prog *prog;
 
 			if (skb) {
 				ctx.skb = skb;
@@ -976,8 +976,9 @@ bool __skb_flow_dissect(const struct net *net,
 				n_proto = skb->protocol;
 			}
 
-			ret = bpf_flow_dissect(attached, &ctx, n_proto, nhoff,
-					       hlen, flags);
+			prog = READ_ONCE(run_array->items[0].prog);
+			ret = bpf_flow_dissect(prog, &ctx, n_proto,
+					       nhoff, hlen, flags);
 			__skb_flow_bpf_to_target(&flow_keys, flow_dissector,
 						 target_container);
 			rcu_read_unlock();
-- 
2.25.4

