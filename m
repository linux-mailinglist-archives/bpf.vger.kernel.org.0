Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCAF3947A2
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhE1UC0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhE1UC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 16:02:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B6C061574;
        Fri, 28 May 2021 13:00:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lr4-20020a17090b4b84b02901600455effdso4018410pjb.5;
        Fri, 28 May 2021 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0U/ZJ0xSvGtMGJ4RLAKeRmK1jqfvVBh59zvctqyYItU=;
        b=fGV04RFSMcOkvCOSfwu8KbpPzrsoRZssINN2ks+qlSr3W2Q4L/UCcjxteBMeZWmaN4
         CD7VED7V5cL//KQuztO1LMxCfUs0PunO3qeE+ucm8kna2S5abdkER8XSE6rCKwB/apaQ
         EkEMUttM80r1SdfnwDllunOHIcrSGtkyL9z2hVwWDmKzVhX0fQPgshl4reIbCzGvTxpB
         QnbLfQYFfUfzVx1RMDqM8OIMs9/NEhUGY0EJjvYDyRL3DV4CD7yMdQR9P9i2t2iCwNEx
         Cdmsx7q61ZSuE4sBIcV9p1y2Kv7p1KP0HU5Cowl2LSzoVFAsyyNAudMB1ORuzbqomrWU
         Skig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0U/ZJ0xSvGtMGJ4RLAKeRmK1jqfvVBh59zvctqyYItU=;
        b=MfiHyHQK5DU1F52ktSJA2mMhsfUX/FwLkXnLhwACqVLliKG50NJC9Bj8uMjINeXZOi
         7P6MK/lvHNrpb0/5WBzeKGaGXmwY1qMtAZwOLVBPHN/Y6X47o472Pe4b9zDxaSdDC4Hk
         EoKlgXnQmQqkR3SQJ24Rx5nNfm13fwyLLE8fKcWInlWmDVsrJmsEhikqssuX80IEuKQ8
         1fW6Ag50TvBsj/8bDS9WIBbinex/1gxla4AxcsPoruoshB+/xnf0muSLL2NgGwLMWiIy
         LUjk1VoU4dKTatGNqOhUfvinEhYHyDKaWxTg8C/ENOWDE2BvGhcOFmkoS4VHrdpC5g3R
         18sA==
X-Gm-Message-State: AOAM531Xm9q0ZzaYjI53ybbSifLxcSJ2EkO07bpkcbxtDHddZBTdObsI
        2YypWTK/ht1vnrJzU6o2OcRbC2vy73o=
X-Google-Smtp-Source: ABdhPJwJb671sLW9B/je+axLXkFjBSXv/DewnY26O+97ghhfFejCSl5ntbZryUMrMS5p0Jjl7upL2w==
X-Received: by 2002:a17:902:b412:b029:ef:1737:ed with SMTP id x18-20020a170902b412b02900ef173700edmr9829299plr.43.1622232050240;
        Fri, 28 May 2021 13:00:50 -0700 (PDT)
Received: from localhost ([2402:3a80:11db:3aa9:ad24:a4a2:844f:6a0a])
        by smtp.gmail.com with ESMTPSA id v18sm5225791pff.90.2021.05.28.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:00:49 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Joe Stringer <joe@cilium.io>,
        Quentin Monnet <quentin@isovalent.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH RFC bpf-next 3/7] net: sched: add bpf_link API for bpf classifier
Date:   Sat, 29 May 2021 01:29:42 +0530
Message-Id: <20210528195946.2375109-4-memxor@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528195946.2375109-1-memxor@gmail.com>
References: <20210528195946.2375109-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit introduces a bpf_link based kernel API for creating tc
filters and using the cls_bpf classifier. Only a subset of what netlink
API offers is supported, things like TCA_BPF_POLICE, TCA_RATE and
embedded actions are unsupported.

The kernel API and the libbpf wrapper added in a subsequent patch are
more opinionated and mirror the semantics of low level netlink based
TC-BPF API, i.e. always setting direct action mode, always setting
protocol to ETH_P_ALL, and only exposing handle and priority as the
variables the user can control. We add an additional gen_flags parameter
though to allow for offloading use cases. It would be trivial to extend
the current API to support specifying other attributes in the future,
but for now I'm sticking how we want to push usage.

The semantics around bpf_link support are as follows:

A user can create a classifier attached to a filter using the bpf_link
API, after which changing it and deleting it only happens through the
bpf_link API. It is not possible to bind the bpf_link to existing
filter, and any such attempt will fail with EEXIST. Hence EEXIST can be
returned in two cases, when existing bpf_link owned filter exists, or
existing netlink owned filter exists.

Removing bpf_link owned filter from netlink returns EPERM, denoting that
netlink is locked out from filter manipulation when bpf_link is
involved.

Whenever a filter is detached due to chain removal, or qdisc tear down,
or net_device shutdown, the bpf_link becomes automatically detached.

In this way, the netlink API and bpf_link creation path are exclusive
and don't stomp over one another. Filters created using bpf_link API
cannot be replaced by netlink API, and filters created by netlink API are
never replaced by bpf_link. Netfilter also cannot detach bpf_link filters.

We serialize all changes dover rtnl_lock as cls_bpf API doesn't support the
unlocked classifier API.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_types.h |   3 +
 include/net/pkt_cls.h     |  13 ++
 include/net/sch_generic.h |   6 +-
 include/uapi/linux/bpf.h  |  15 +++
 kernel/bpf/syscall.c      |  10 +-
 net/sched/cls_api.c       | 138 ++++++++++++++++++++-
 net/sched/cls_bpf.c       | 247 +++++++++++++++++++++++++++++++++++++-
 7 files changed, 426 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index a9db1eae6796..b1aaf7680917 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -135,3 +135,6 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
 #ifdef CONFIG_NET
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
 #endif
+#if IS_ENABLED(CONFIG_NET_CLS_BPF)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TC, tc)
+#endif
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 255e4f4b521f..c36c5d79db6b 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -2,6 +2,7 @@
 #ifndef __NET_PKT_CLS_H
 #define __NET_PKT_CLS_H
 
+#include <linux/bpf.h>
 #include <linux/pkt_cls.h>
 #include <linux/workqueue.h>
 #include <net/sch_generic.h>
@@ -45,6 +46,9 @@ bool tcf_queue_work(struct rcu_work *rwork, work_func_t func);
 struct tcf_chain *tcf_chain_get_by_act(struct tcf_block *block,
 				       u32 chain_index);
 void tcf_chain_put_by_act(struct tcf_chain *chain);
+void tcf_chain_tp_delete_empty(struct tcf_chain *chain,
+			       struct tcf_proto *tp, bool rtnl_held,
+			       struct netlink_ext_ack *extack);
 struct tcf_chain *tcf_get_next_chain(struct tcf_block *block,
 				     struct tcf_chain *chain);
 struct tcf_proto *tcf_get_next_proto(struct tcf_chain *chain,
@@ -1004,4 +1008,13 @@ struct tc_fifo_qopt_offload {
 	};
 };
 
+#if IS_ENABLED(CONFIG_NET_CLS_BPF)
+int bpf_tc_link_attach(union bpf_attr *attr, struct bpf_prog *prog);
+#else
+static inline int bpf_tc_link_attach(union bpf_attr *attr, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f7a6e14491fb..bacd70bfc5ed 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -341,7 +341,11 @@ struct tcf_proto_ops {
 	int			(*tmplt_dump)(struct sk_buff *skb,
 					      struct net *net,
 					      void *tmplt_priv);
-
+#if IS_ENABLED(CONFIG_NET_CLS_BPF)
+	int			(*bpf_link_change)(struct net *net, struct tcf_proto *tp,
+						   struct bpf_prog *filter, void **arg, u32 handle,
+						   u32 gen_flags);
+#endif
 	struct module		*owner;
 	int			flags;
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2c1ba70abbf1..a3488463d145 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -994,6 +994,7 @@ enum bpf_attach_type {
 	BPF_SK_LOOKUP,
 	BPF_XDP,
 	BPF_SK_SKB_VERDICT,
+	BPF_TC,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1007,6 +1008,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_ITER = 4,
 	BPF_LINK_TYPE_NETNS = 5,
 	BPF_LINK_TYPE_XDP = 6,
+	BPF_LINK_TYPE_TC = 7,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1447,6 +1449,12 @@ union bpf_attr {
 				__aligned_u64	iter_info;	/* extra bpf_iter_link_info */
 				__u32		iter_info_len;	/* iter_info length */
 			};
+			struct { /* used by BPF_TC */
+				__u32 parent;
+				__u32 handle;
+				__u32 gen_flags;
+				__u16 priority;
+			} tc;
 		};
 	} link_create;
 
@@ -5519,6 +5527,13 @@ struct bpf_link_info {
 		struct {
 			__u32 ifindex;
 		} xdp;
+		struct {
+			__u32 ifindex;
+			__u32 parent;
+			__u32 handle;
+			__u32 gen_flags;
+			__u16 priority;
+		} tc;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e5934b748ced..ce7c00ea135c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
+#include <net/pkt_cls.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bpf_lirc.h>
@@ -3027,6 +3028,8 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 		return BPF_PROG_TYPE_SK_LOOKUP;
 	case BPF_XDP:
 		return BPF_PROG_TYPE_XDP;
+	case BPF_TC:
+		return BPF_PROG_TYPE_SCHED_CLS;
 	default:
 		return BPF_PROG_TYPE_UNSPEC;
 	}
@@ -4085,7 +4088,7 @@ static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	return -EINVAL;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.iter_info_len
+#define BPF_LINK_CREATE_LAST_FIELD link_create.tc.priority
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type ptype;
@@ -4136,6 +4139,11 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_XDP:
 		ret = bpf_xdp_link_attach(attr, prog);
 		break;
+#endif
+#if IS_ENABLED(CONFIG_NET_CLS_BPF)
+	case BPF_PROG_TYPE_SCHED_CLS:
+		ret = bpf_tc_link_attach(attr, prog);
+		break;
 #endif
 	default:
 		ret = -EINVAL;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 75e3a288a7c8..1fd804fe55bf 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -9,6 +9,7 @@
  * Eduardo J. Blanco <ejbs@netlabs.com.uy> :990222: kmod support
  */
 
+#include <linux/bpf.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -1720,9 +1721,9 @@ static struct tcf_proto *tcf_chain_tp_insert_unique(struct tcf_chain *chain,
 	return tp_new;
 }
 
-static void tcf_chain_tp_delete_empty(struct tcf_chain *chain,
-				      struct tcf_proto *tp, bool rtnl_held,
-				      struct netlink_ext_ack *extack)
+void tcf_chain_tp_delete_empty(struct tcf_chain *chain,
+			       struct tcf_proto *tp, bool rtnl_held,
+			       struct netlink_ext_ack *extack)
 {
 	struct tcf_chain_info chain_info;
 	struct tcf_proto *tp_iter;
@@ -1760,6 +1761,7 @@ static void tcf_chain_tp_delete_empty(struct tcf_chain *chain,
 
 	tcf_proto_put(tp, rtnl_held, extack);
 }
+EXPORT_SYMBOL_GPL(tcf_chain_tp_delete_empty);
 
 static struct tcf_proto *tcf_chain_tp_find(struct tcf_chain *chain,
 					   struct tcf_chain_info *chain_info,
@@ -3917,3 +3919,133 @@ static int __init tc_filter_init(void)
 }
 
 subsys_initcall(tc_filter_init);
+
+#if IS_ENABLED(CONFIG_NET_CLS_BPF)
+
+int bpf_tc_link_attach(union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct net *net = current->nsproxy->net_ns;
+	u32 chain_index, prio, protocol, parent;
+	struct tcf_chain_info chain_info;
+	struct tcf_block *block;
+	struct tcf_chain *chain;
+	struct tcf_proto *tp;
+	int err, tp_created;
+	unsigned long cl;
+	struct Qdisc *q;
+	void *fh;
+
+	/* Caller already checks bpf_capable */
+	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (attr->link_create.flags ||
+	    !attr->link_create.target_ifindex ||
+	    !tc_flags_valid(attr->link_create.tc.gen_flags))
+		return -EINVAL;
+
+replay:
+	parent = attr->link_create.tc.parent;
+	prio = attr->link_create.tc.priority;
+	protocol = htons(ETH_P_ALL);
+	chain_index = 0;
+	tp_created = 0;
+	prio <<= 16;
+	cl = 0;
+
+	/* Address this when cls_bpf switches to RTNL_FLAG_DOIT_UNLOCKED */
+	rtnl_lock();
+
+	block = tcf_block_find(net, &q, &parent, &cl,
+			       attr->link_create.target_ifindex, parent, NULL);
+	if (IS_ERR(block)) {
+		err = PTR_ERR(block);
+		goto out_unlock;
+	}
+	block->classid = parent;
+
+	chain = tcf_chain_get(block, chain_index, true);
+	if (!chain) {
+		err = -ENOMEM;
+		goto out_block;
+	}
+
+	mutex_lock(&chain->filter_chain_lock);
+
+	tp = tcf_chain_tp_find(chain, &chain_info, protocol,
+			       prio ?: TC_H_MAKE(0x80000000U, 0U),
+			       !prio);
+	if (IS_ERR(tp)) {
+		err = PTR_ERR(tp);
+		goto out_chain_unlock;
+	}
+
+	if (!tp) {
+		struct tcf_proto *tp_new = NULL;
+
+		if (chain->flushing) {
+			err = -EAGAIN;
+			goto out_chain_unlock;
+		}
+
+		if (!prio)
+			prio = tcf_auto_prio(tcf_chain_tp_prev(chain,
+							       &chain_info));
+
+		mutex_unlock(&chain->filter_chain_lock);
+
+		tp_new = tcf_proto_create("bpf", protocol, prio, chain, true,
+					  NULL);
+		if (IS_ERR(tp_new)) {
+			err = PTR_ERR(tp_new);
+			goto out_chain;
+		}
+
+		tp_created = 1;
+		tp = tcf_chain_tp_insert_unique(chain, tp_new, protocol, prio,
+						true);
+		if (IS_ERR(tp)) {
+			err = PTR_ERR(tp);
+			goto out_chain;
+		}
+	} else {
+		mutex_unlock(&chain->filter_chain_lock);
+	}
+
+	fh = tp->ops->get(tp, attr->link_create.tc.handle);
+
+	if (!tp->ops->bpf_link_change)
+		err = -EDEADLK;
+	else
+		err = tp->ops->bpf_link_change(net, tp, prog, &fh,
+					       attr->link_create.tc.handle,
+					       attr->link_create.tc.gen_flags);
+	if (err >= 0 && q)
+		q->flags &= ~TCQ_F_CAN_BYPASS;
+
+out:
+	if (err < 0 && tp_created)
+		tcf_chain_tp_delete_empty(chain, tp, true, NULL);
+out_chain:
+	if (chain) {
+		if (!IS_ERR_OR_NULL(tp))
+			tcf_proto_put(tp, true, NULL);
+		/* Chain reference only kept for tp creation
+		 * to pair with tcf_chain_put from tcf_proto_destroy
+		 */
+		if (!tp_created)
+			tcf_chain_put(chain);
+	}
+out_block:
+	tcf_block_release(q, block, true);
+out_unlock:
+	rtnl_unlock();
+	if (err == -EAGAIN)
+		goto replay;
+	return err;
+out_chain_unlock:
+	mutex_unlock(&chain->filter_chain_lock);
+	goto out;
+}
+
+#endif
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 360b97ab8646..57d6dedb389a 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -34,6 +34,11 @@ struct cls_bpf_head {
 	struct rcu_head rcu;
 };
 
+struct cls_bpf_link {
+	struct bpf_link link;
+	struct cls_bpf_prog *prog;
+};
+
 struct cls_bpf_prog {
 	struct bpf_prog *filter;
 	struct list_head link;
@@ -48,6 +53,7 @@ struct cls_bpf_prog {
 	const char *bpf_name;
 	struct tcf_proto *tp;
 	struct rcu_work rwork;
+	struct cls_bpf_link *bpf_link;
 };
 
 static const struct nla_policy bpf_policy[TCA_BPF_MAX + 1] = {
@@ -289,6 +295,8 @@ static void __cls_bpf_delete(struct tcf_proto *tp, struct cls_bpf_prog *prog,
 {
 	struct cls_bpf_head *head = rtnl_dereference(tp->root);
 
+	if (prog->bpf_link)
+		prog->bpf_link->prog = NULL;
 	idr_remove(&head->handle_idr, prog->handle);
 	cls_bpf_stop_offload(tp, prog, extack);
 	list_del_rcu(&prog->link);
@@ -303,8 +311,13 @@ static int cls_bpf_delete(struct tcf_proto *tp, void *arg, bool *last,
 			  bool rtnl_held, struct netlink_ext_ack *extack)
 {
 	struct cls_bpf_head *head = rtnl_dereference(tp->root);
+	struct cls_bpf_prog *prog = arg;
+
+	/* Cannot remove bpf_link owned filter using netlink */
+	if (prog->bpf_link)
+		return -EPERM;
 
-	__cls_bpf_delete(tp, arg, extack);
+	__cls_bpf_delete(tp, prog, extack);
 	*last = list_empty(&head->plist);
 	return 0;
 }
@@ -494,6 +507,11 @@ static int __cls_bpf_change(struct cls_bpf_head *head, struct tcf_proto *tp,
 		prog->gen_flags |= TCA_CLS_FLAGS_NOT_IN_HW;
 
 	if (oldprog) {
+		/* Since netfilter and bpf_link cannot replace a bpf_link
+		 * attached filter, this should never be true.
+		 */
+		WARN_ON(oldprog->bpf_link);
+
 		idr_replace(&head->handle_idr, prog, prog->handle);
 		list_replace_rcu(&oldprog->link, &prog->link);
 		tcf_unbind_filter(tp, &oldprog->res);
@@ -521,6 +539,10 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	if (tca[TCA_OPTIONS] == NULL)
 		return -EINVAL;
 
+	/* Can't touch bpf_link filter */
+	if (oldprog && oldprog->bpf_link)
+		return -EPERM;
+
 	ret = nla_parse_nested_deprecated(tb, TCA_BPF_MAX, tca[TCA_OPTIONS],
 					  bpf_policy, NULL);
 	if (ret < 0)
@@ -716,6 +738,228 @@ static int cls_bpf_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb
 	return 0;
 }
 
+static void cls_bpf_link_release(struct bpf_link *link)
+{
+	struct cls_bpf_link *cls_link;
+	struct cls_bpf_prog *prog;
+	struct cls_bpf_head *head;
+
+	rtnl_lock();
+
+	cls_link = container_of(link, struct cls_bpf_link, link);
+	prog = cls_link->prog;
+
+	if (prog) {
+		head = rtnl_dereference(prog->tp->root);
+		/* Deletion of the filter will unset cls_link->prog */
+		__cls_bpf_delete(prog->tp, prog, NULL);
+		if (list_empty(&head->plist))
+			tcf_chain_tp_delete_empty(prog->tp->chain, prog->tp,
+						  true, NULL);
+	}
+
+	rtnl_unlock();
+}
+
+static void cls_bpf_link_dealloc(struct bpf_link *link)
+{
+	struct cls_bpf_link *cls_link;
+
+	cls_link = container_of(link, struct cls_bpf_link, link);
+	kfree(cls_link);
+}
+
+static int cls_bpf_link_detach(struct bpf_link *link)
+{
+	cls_bpf_link_release(link);
+	return 0;
+}
+
+static void __bpf_fill_link_info(struct cls_bpf_link *link,
+				 struct bpf_link_info *info)
+{
+	struct tcf_block *block;
+	struct tcf_proto *tp;
+	struct Qdisc *q;
+
+	ASSERT_RTNL();
+
+	if (WARN_ON(!link->prog))
+		return;
+
+	tp = link->prog->tp;
+	block = tp->chain->block;
+	q = block->q;
+
+	info->tc.ifindex = q ? qdisc_dev(q)->ifindex : TCM_IFINDEX_MAGIC_BLOCK;
+	info->tc.parent = block->classid;
+	info->tc.handle = link->prog->handle;
+	info->tc.priority = tp->prio >> 16;
+	info->tc.gen_flags = link->prog->gen_flags;
+}
+
+#ifdef CONFIG_PROC_FS
+
+static void cls_bpf_link_show_fdinfo(const struct bpf_link *link,
+				     struct seq_file *seq)
+{
+	struct cls_bpf_link *cls_link;
+	struct bpf_link_info info = {};
+
+	rtnl_lock();
+
+	cls_link = container_of(link, struct cls_bpf_link, link);
+	if (!cls_link->prog)
+		goto out;
+
+	__bpf_fill_link_info(cls_link, &info);
+
+	seq_printf(seq,
+		   "ifindex:\t%u\n"
+		   "parent:\t%u\n"
+		   "handle:\t%u\n"
+		   "priority:\t%u\n"
+		   "gen_flags:\t%u\n",
+		   info.tc.ifindex, info.tc.parent,
+		   info.tc.handle, (u32)info.tc.priority,
+		   info.tc.gen_flags);
+
+out:
+	rtnl_unlock();
+}
+
+#endif
+
+static int cls_bpf_link_fill_link_info(const struct bpf_link *link,
+				       struct bpf_link_info *info)
+{
+	struct cls_bpf_link *cls_link;
+	int ret = 0;
+
+	rtnl_lock();
+
+	cls_link = container_of(link, struct cls_bpf_link, link);
+	if (!cls_link->prog) {
+		ret = -ENOLINK;
+		goto out;
+	}
+
+	__bpf_fill_link_info(cls_link, info);
+
+out:
+	rtnl_unlock();
+	return ret;
+}
+
+static const struct bpf_link_ops cls_bpf_link_ops = {
+	.release = cls_bpf_link_release,
+	.dealloc = cls_bpf_link_dealloc,
+	.detach = cls_bpf_link_detach,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = cls_bpf_link_show_fdinfo,
+#endif
+	.fill_link_info = cls_bpf_link_fill_link_info,
+};
+
+static inline char *cls_bpf_link_name(u32 prog_id, const char *name)
+{
+	char *str = kmalloc(CLS_BPF_NAME_LEN, GFP_KERNEL);
+
+	if (str)
+		snprintf(str, CLS_BPF_NAME_LEN, "%s:[%u]", name, prog_id);
+
+	return str;
+}
+
+static int cls_bpf_link_change(struct net *net, struct tcf_proto *tp,
+			       struct bpf_prog *filter, void **arg,
+			       u32 handle, u32 gen_flags)
+{
+	struct cls_bpf_head *head = rtnl_dereference(tp->root);
+	struct cls_bpf_prog *oldprog = *arg, *prog;
+	struct bpf_link_primer primer;
+	struct cls_bpf_link *link;
+	int ret;
+
+	if (gen_flags & ~CLS_BPF_SUPPORTED_GEN_FLAGS)
+		return -EINVAL;
+
+	if (oldprog)
+		return -EEXIST;
+
+	prog = kzalloc(sizeof(*prog), GFP_KERNEL);
+	if (!prog)
+		return -ENOMEM;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link) {
+		ret = -ENOMEM;
+		goto err_prog;
+	}
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_TC, &cls_bpf_link_ops,
+		      filter);
+
+	ret = bpf_link_prime(&link->link, &primer);
+	if (ret < 0)
+		goto err_link;
+
+	/* We don't init exts to save on memory, but we still need to store the
+	 * net_ns pointer, as during delete whether the deletion work will be
+	 * queued or executed inline depends on the refcount of net_ns. In
+	 * __cls_bpf_delete the reference is taken to keep the action IDR alive
+	 * (which we don't require), but its maybe_get_net also allows us to
+	 * detect whether we are being invoked in netns destruction path or not.
+	 * In the former case deletion will have to be done synchronously.
+	 *
+	 * Leaving it NULL would prevent us from doing deletion work
+	 * asynchronously, so set it here.
+	 *
+	 * On the tcf_classify side, exts->actions are not touched for
+	 * exts_integrated progs, so we should be good.
+	 */
+	prog->exts.net = net;
+
+	ret = __cls_bpf_alloc_idr(head, handle, prog, oldprog);
+	if (ret < 0)
+		goto err_primer;
+
+	prog->exts_integrated = true;
+	prog->bpf_link = link;
+	prog->filter = filter;
+	prog->tp = tp;
+	link->prog = prog;
+
+	prog->bpf_name = cls_bpf_link_name(filter->aux->id, filter->aux->name);
+	if (!prog->bpf_name) {
+		ret = -ENOMEM;
+		goto err_idr;
+	}
+
+	ret = __cls_bpf_change(head, tp, prog, oldprog, NULL);
+	if (ret < 0)
+		goto err_name;
+
+	bpf_prog_inc(filter);
+
+	if (filter->dst_needed)
+		tcf_block_netif_keep_dst(tp->chain->block);
+
+	return bpf_link_settle(&primer);
+
+err_name:
+	kfree(prog->bpf_name);
+err_idr:
+	idr_remove(&head->handle_idr, prog->handle);
+err_primer:
+	bpf_link_cleanup(&primer);
+err_link:
+	kfree(link);
+err_prog:
+	kfree(prog);
+	return ret;
+}
+
 static struct tcf_proto_ops cls_bpf_ops __read_mostly = {
 	.kind		=	"bpf",
 	.owner		=	THIS_MODULE,
@@ -729,6 +973,7 @@ static struct tcf_proto_ops cls_bpf_ops __read_mostly = {
 	.reoffload	=	cls_bpf_reoffload,
 	.dump		=	cls_bpf_dump,
 	.bind_class	=	cls_bpf_bind_class,
+	.bpf_link_change =	cls_bpf_link_change,
 };
 
 static int __init cls_bpf_init_mod(void)
-- 
2.31.1

