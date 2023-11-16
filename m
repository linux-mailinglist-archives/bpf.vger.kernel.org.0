Return-Path: <bpf+bounces-15200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A877EE527
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F511F24BD7
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BAA3C476;
	Thu, 16 Nov 2023 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GQMShvCs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF10189
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 08:28:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-408382da7f0so8379605e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700152097; x=1700756897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol6eqfBKOZrg8tKYE2D/BDLP0DNWs6djb6ZS0SBSblc=;
        b=GQMShvCsDy4ZCFZcvTmTuPgMURvwEI7BqCm5uaWg1RB19NYsUoGg2rtqsBdwmZi7ol
         ruorHiYiFoN9Pag8MkudZPqC0uPud9mY++JaSKvGbesvuei+5XIypI/3TJVmNhwymajo
         i/a3xkgsAg2Bk/7biSoNInT8WgI/W8pXUUrrAK3n2n2iEYLMJ6PxNFc+L98KhQQce+Wn
         HeRJGeFuyZKhuJQ90crorNnwUi+SiFGhd3tr4SsiueByiJYDj9mSuyli5y9L3UZ17NVq
         3ogEbmQu9+MWHp+xscfWIMSDJG9vyVV0pIF6duzNANzQ4dfsWszEw49B4K463MR19Q0p
         XlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700152097; x=1700756897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol6eqfBKOZrg8tKYE2D/BDLP0DNWs6djb6ZS0SBSblc=;
        b=aXuobuh7T14YVklFvQ3GbURIhh8qdnJVNaGUJC6GP8Wcz/2oj6ht/mXcE0sKpagvnE
         DmTFtwgZDxbNoQ5f4aCShxZmaQfUkiASyqBmjrqT3XrW9qIsiaGre1eQQrPFYsmv6fzl
         OmWassnIS5LFzO2vE2NJiDOPIqPTd9xvAnnHAbXYZnosFWqVyWPsbzJsPTXa7civ6/Vv
         WbbrR/m5PBJdK0m0jisP0t/jrR459l4EHeRxcvRtlUin7cVcLxq2DtFhH/Sf3Cu0feQg
         I5mgwJPVQV33AIpc7v7o/sZ/V2EheIPJc9N3/c1uHey+B2wRyU9qm91YNdxWqD5gnH1n
         fNeg==
X-Gm-Message-State: AOJu0Yw/5Xcl1qzK43sz6Dz+bVoMO+bAKdxHHrFVxkVqFuAv1D+7t2GS
	1y3WlLtpl1DPb0/b6FUy7h2twA==
X-Google-Smtp-Source: AGHT+IEPFvrq316d++E7nFGvPzu8yjAAKj6JJxnPMIMxTAT5cnlB5DCEv9wjxRdkH3jhThLQV8ZAIQ==
X-Received: by 2002:a05:600c:d8:b0:405:4a78:a890 with SMTP id u24-20020a05600c00d800b004054a78a890mr2377022wmm.8.1700152097003;
        Thu, 16 Nov 2023 08:28:17 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003fbe4cecc3bsm4092593wmk.16.2023.11.16.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:28:16 -0800 (PST)
Date: Thu, 16 Nov 2023 17:28:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
	toke@redhat.com, mattyk@nvidia.com
Subject: Re: [PATCH net-next v8 10/15] p4tc: add action template create,
 update, delete, get, flush and dump
Message-ID: <ZVZDH9OzqFvc3VSS@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-11-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116145948.203001-11-jhs@mojatatu.com>

Thu, Nov 16, 2023 at 03:59:43PM CET, jhs@mojatatu.com wrote:

[...]


>diff --git a/include/net/act_api.h b/include/net/act_api.h
>index cd5a8e86f..b95a9bc29 100644
>--- a/include/net/act_api.h
>+++ b/include/net/act_api.h
>@@ -70,6 +70,7 @@ struct tc_action {
> #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
> #define TCA_ACT_FLAGS_PREALLOC	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
> #define TCA_ACT_FLAGS_UNREFERENCED	(1U << (TCA_ACT_FLAGS_USER_BITS + 6))
>+#define TCA_ACT_FLAGS_FROM_P4TC	(1U << (TCA_ACT_FLAGS_USER_BITS + 7))
> 
> /* Update lastuse only if needed, to avoid dirtying a cache line.
>  * We use a temp variable to avoid fetching jiffies twice.
>diff --git a/include/net/p4tc.h b/include/net/p4tc.h
>index ccb54d842..68b00fa72 100644
>--- a/include/net/p4tc.h
>+++ b/include/net/p4tc.h
>@@ -9,17 +9,23 @@
> #include <linux/refcount.h>
> #include <linux/rhashtable.h>
> #include <linux/rhashtable-types.h>
>+#include <net/tc_act/p4tc.h>
>+#include <net/p4tc_types.h>
> 
> #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
> #define P4TC_DEFAULT_MAX_RULES 1
> #define P4TC_PATH_MAX 3
>+#define P4TC_MAX_TENTRIES 33554432

Seeing define like this one always makes me happier. Where does it come
from? Why not 0x2000000 at least?


> 
> #define P4TC_KERNEL_PIPEID 0
> 
> #define P4TC_PID_IDX 0
>+#define P4TC_AID_IDX 1
>+#define P4TC_PARSEID_IDX 1
> 
> struct p4tc_dump_ctx {
> 	u32 ids[P4TC_PATH_MAX];
>+	struct rhashtable_iter *iter;
> };
> 
> struct p4tc_template_common;
>@@ -63,8 +69,10 @@ extern const struct p4tc_template_ops p4tc_pipeline_ops;
> 
> struct p4tc_pipeline {
> 	struct p4tc_template_common common;
>+	struct idr                  p_act_idr;
> 	struct rcu_head             rcu;
> 	struct net                  *net;
>+	u32                         num_created_acts;
> 	/* Accounts for how many entities are referencing this pipeline.
> 	 * As for now only P4 filters can refer to pipelines.
> 	 */
>@@ -109,18 +117,157 @@ p4tc_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
> 				  const u32 pipeid,
> 				  struct netlink_ext_ack *extack);
> 
>+struct p4tc_act *tcf_p4_find_act(struct net *net,
>+				 const struct tc_action_ops *a_o,
>+				 struct netlink_ext_ack *extack);
>+void
>+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4_act);
>+
> static inline int p4tc_action_destroy(struct tc_action **acts)
> {
>+	struct tc_action *acts_non_prealloc[TCA_ACT_MAX_PRIO] = {NULL};
> 	int ret = 0;
> 
> 	if (acts) {
>-		ret = tcf_action_destroy(acts, TCA_ACT_UNBIND);
>+		int j = 0;
>+		int i;

Move declarations to the beginning of the if body.

[...]


>diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>index 4d33f44c1..7b89229a7 100644
>--- a/include/uapi/linux/p4tc.h
>+++ b/include/uapi/linux/p4tc.h
>@@ -4,6 +4,7 @@
> 
> #include <linux/types.h>
> #include <linux/pkt_sched.h>
>+#include <linux/pkt_cls.h>
> 
> /* pipeline header */
> struct p4tcmsg {
>@@ -17,9 +18,12 @@ struct p4tcmsg {
> #define P4TC_MSGBATCH_SIZE 16
> 
> #define P4TC_MAX_KEYSZ 512
>+#define P4TC_DEFAULT_NUM_PREALLOC 16
> 
> #define TEMPLATENAMSZ 32
> #define PIPELINENAMSIZ TEMPLATENAMSZ
>+#define ACTTMPLNAMSIZ TEMPLATENAMSZ
>+#define ACTPARAMNAMSIZ TEMPLATENAMSZ

Prefix? This is uapi. Could you please be more careful with naming at
least in the uapi area?


[...]


>diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
>new file mode 100644
>index 000000000..19db0772c
>--- /dev/null
>+++ b/net/sched/p4tc/p4tc_action.c
>@@ -0,0 +1,2242 @@
>+// SPDX-License-Identifier: GPL-2.0-or-later
>+/*
>+ * net/sched/p4tc_action.c	P4 TC ACTION TEMPLATES
>+ *
>+ * Copyright (c) 2022-2023, Mojatatu Networks
>+ * Copyright (c) 2022-2023, Intel Corporation.
>+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
>+ *              Victor Nogueira <victor@mojatatu.com>
>+ *              Pedro Tammela <pctammela@mojatatu.com>
>+ */
>+
>+#include <linux/err.h>
>+#include <linux/errno.h>
>+#include <linux/init.h>
>+#include <linux/kernel.h>
>+#include <linux/kmod.h>
>+#include <linux/list.h>
>+#include <linux/module.h>
>+#include <linux/netdevice.h>
>+#include <linux/skbuff.h>
>+#include <linux/slab.h>
>+#include <linux/string.h>
>+#include <linux/types.h>
>+#include <net/flow_offload.h>
>+#include <net/net_namespace.h>
>+#include <net/netlink.h>
>+#include <net/pkt_cls.h>
>+#include <net/p4tc.h>
>+#include <net/sch_generic.h>
>+#include <net/sock.h>
>+#include <net/tc_act/p4tc.h>
>+
>+static LIST_HEAD(dynact_list);
>+
>+#define SEPARATOR "/"

Prefix? Btw, why exactly do you need this. It is used only once.

To quote a few function names in this file:

>+static void set_param_indices(struct idr *params_idr)
>+static void generic_free_param_value(struct p4tc_act_param *param)
>+static int dev_init_param_value(struct net *net, struct p4tc_act_param_ops *op,
>+static void dev_free_param_value(struct p4tc_act_param *param)
>+static void tcf_p4_act_params_destroy_rcu(struct rcu_head *head)
>+static int __tcf_p4_dyna_init_set(struct p4tc_act *act, struct tc_action **a,
>+static int tcf_p4_dyna_template_init(struct net *net, struct tc_action **a,
>+init_prealloc_param(struct p4tc_act *act, struct idr *params_idr,
>+static void p4tc_param_put(struct p4tc_act_param *param)
>+static void free_intermediate_param(struct p4tc_act_param *param)
>+static void free_intermediate_params_list(struct list_head *params_list)
>+static int init_prealloc_params(struct p4tc_act *act,
>+struct p4tc_act *p4tc_action_find_byid(struct p4tc_pipeline *pipeline,
>+static void tcf_p4_prealloc_list_add(struct p4tc_act *act_tmpl,
>+static int tcf_p4_prealloc_acts(struct net *net, struct p4tc_act *act,
>+tcf_p4_get_next_prealloc_act(struct p4tc_act *act)
>+void tcf_p4_set_init_flags(struct tcf_p4act *p4act)
>+static void __tcf_p4_put_prealloc_act(struct p4tc_act *act,
>+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4act)
>+static int generic_dump_param_value(struct sk_buff *skb, struct p4tc_type *type,
>+static int generic_init_param_value(struct p4tc_act_param *nparam,
>+static struct p4tc_act_param *param_find_byname(struct idr *params_idr,
>+tcf_param_find_byany(struct p4tc_act *act,
>+tcf_param_find_byanyattr(struct p4tc_act *act, struct nlattr *name_attr,
>+static int __p4_init_param_type(struct p4tc_act_param *param,
>+static int tcf_p4_act_init_params(struct net *net,
>+static struct p4tc_act *p4tc_action_find_byname(const char *act_name,
>+static int tcf_p4_dyna_init(struct net *net, struct nlattr *nla,
>+static int tcf_act_fill_param_type(struct sk_buff *skb,
>+static void tcf_p4_dyna_cleanup(struct tc_action *a)
>+struct p4tc_act *p4tc_action_find_get(struct p4tc_pipeline *pipeline,
>+p4tc_action_find_byanyattr(struct nlattr *act_name_attr, const u32 a_id,
>+static void p4_put_many_params(struct idr *params_idr)
>+static int p4_init_param_type(struct p4tc_act_param *param,
>+static struct p4tc_act_param *p4_create_param(struct p4tc_act *act,
>+static struct p4tc_act_param *p4_update_param(struct p4tc_act *act,
>+static struct p4tc_act_param *p4_act_init_param(struct p4tc_act *act,
>+static void p4tc_action_net_exit(struct tc_action_net *tn)
>+static void p4_act_params_put(struct p4tc_act *act)
>+static int __tcf_act_put(struct net *net, struct p4tc_pipeline *pipeline,
>+static int _tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
>+static int tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
>+static int tcf_act_flush(struct sk_buff *skb, struct net *net,
>+static void p4tc_params_replace_many(struct p4tc_act *act,
>+				     struct idr *params_idr)
>+static struct p4tc_act *tcf_act_create(struct net *net, struct nlattr **tb,
>+tcf_act_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,

Is there some secret key how you name the functions? To me, this looks
completely inconsistent :/



