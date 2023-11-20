Return-Path: <bpf+bounces-15379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9627F189A
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 17:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0299128245F
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78031E539;
	Mon, 20 Nov 2023 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PbY13Y3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CAE94
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 08:25:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9fd0059a967so264447866b.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700497555; x=1701102355; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wzoI5PxhuyyKAWRdaF5+eamccCx+ueRfU5atI6NnTc4=;
        b=PbY13Y3cqyfj84cmgHLZUIr4JoeRVmRVgBp+/3f5Zs07QzHPqoQjXi5xMcaTK/BxlI
         IN6Vn0kEury9L8KG1+49NX7MTU1nY7dTMZw0LCeC6tGo0E4EUdWfoqgQihAIZBTBErS2
         x4BRPjdYCt2Hrt8tzPTb+stKYbC55z1SS78TSEdB8gRMIyPN+kgTvRNvwCoBVKAOm/A/
         tuXMdKkVPP9i59Op3JUFutXOlXztfCQLfK7revQIAvaehmFkSf3P1yenlDSfXEoCEl2m
         SCJ2bn1AzAHJmZ5c/tNGsggtRpZlzqr7BHYiPPSkKq7BXs8F+xAW9bZbOQ6F0Ckbt1Jf
         ecGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700497555; x=1701102355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzoI5PxhuyyKAWRdaF5+eamccCx+ueRfU5atI6NnTc4=;
        b=tcqs56rS8e70Mys5ycqMkY+g+Qxd7qhXi7z8NvMEhK3OGUpLxqdLddtytBRrPqYv2b
         X1ayyLUEBqjRYT1nnA5KYnyyAeWrGMs3rzkoaTAZFFiqTin75HHYOApLN8zeXMMyM1dW
         0STQS9T7uEA5/gUFXifeRSlmDkjf1WuhRxfrxMpqwIjhEkPRJULa07K/gfQJ0zfPP1bH
         ERwWZbJ1C/BTUg/kbF4l6YSBz4nD3VRyEjsa/wAyHsNAKCsdpjC8lh8Kx0zH9sL86xyF
         +jM5CRZQVTyG3oz2p2mgeO6yaTvBrl27Smi9NpyDC/ac6FXWgLPe2sx+p2zjhQ3W8eof
         zVnw==
X-Gm-Message-State: AOJu0Yz/BJ36gypWjfo6Rbd0HIjFu5zd7aDEYrkrNhtIXuggx1TY45BR
	objcnk24gmfoXpZ9iBUcmtvgcA==
X-Google-Smtp-Source: AGHT+IG1IQ1dV5bTZnX5USWO3JtSwAsJN63idOcZXYFDu3PMtESdF6uOm5QM8rJrH78/GoqzepY/Tg==
X-Received: by 2002:a17:906:1ca:b0:a00:76b1:7d9a with SMTP id 10-20020a17090601ca00b00a0076b17d9amr957337ejj.38.1700497555327;
        Mon, 20 Nov 2023 08:25:55 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i25-20020a05640200d900b0054026e95beesm3724369edu.76.2023.11.20.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 08:25:54 -0800 (PST)
Date: Mon, 20 Nov 2023 17:25:53 +0100
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
Message-ID: <ZVuIkbI3QKGGeQnj@nanopsycho>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-11-jhs@mojatatu.com>
 <ZVZDH9OzqFvc3VSS@nanopsycho>
 <CAM0EoM=KrC5dD=cC1H7+LsSXfxj386AD=Xpy3sG19QWaiFipCg@mail.gmail.com>
 <ZVsWnWAWvzbgn2p4@nanopsycho>
 <CAM0EoMn0v2_7w2ZXnBn4w1AyEE=-sWMvcUdiNPf-ifYSfx6o3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMn0v2_7w2ZXnBn4w1AyEE=-sWMvcUdiNPf-ifYSfx6o3A@mail.gmail.com>

Mon, Nov 20, 2023 at 02:45:24PM CET, jhs@mojatatu.com wrote:
>On Mon, Nov 20, 2023 at 3:19 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Nov 17, 2023 at 04:11:29PM CET, jhs@mojatatu.com wrote:
>> >On Thu, Nov 16, 2023 at 11:28 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Nov 16, 2023 at 03:59:43PM CET, jhs@mojatatu.com wrote:
>> >>
>> >> [...]
>> >>
>> >>
>> >> >diff --git a/include/net/act_api.h b/include/net/act_api.h
>> >> >index cd5a8e86f..b95a9bc29 100644
>> >> >--- a/include/net/act_api.h
>> >> >+++ b/include/net/act_api.h
>> >> >@@ -70,6 +70,7 @@ struct tc_action {
>> >> > #define TCA_ACT_FLAGS_AT_INGRESS      (1U << (TCA_ACT_FLAGS_USER_BITS + 4))
>> >> > #define TCA_ACT_FLAGS_PREALLOC        (1U << (TCA_ACT_FLAGS_USER_BITS + 5))
>> >> > #define TCA_ACT_FLAGS_UNREFERENCED    (1U << (TCA_ACT_FLAGS_USER_BITS + 6))
>> >> >+#define TCA_ACT_FLAGS_FROM_P4TC       (1U << (TCA_ACT_FLAGS_USER_BITS + 7))
>> >> >
>> >> > /* Update lastuse only if needed, to avoid dirtying a cache line.
>> >> >  * We use a temp variable to avoid fetching jiffies twice.
>> >> >diff --git a/include/net/p4tc.h b/include/net/p4tc.h
>> >> >index ccb54d842..68b00fa72 100644
>> >> >--- a/include/net/p4tc.h
>> >> >+++ b/include/net/p4tc.h
>> >> >@@ -9,17 +9,23 @@
>> >> > #include <linux/refcount.h>
>> >> > #include <linux/rhashtable.h>
>> >> > #include <linux/rhashtable-types.h>
>> >> >+#include <net/tc_act/p4tc.h>
>> >> >+#include <net/p4tc_types.h>
>> >> >
>> >> > #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
>> >> > #define P4TC_DEFAULT_MAX_RULES 1
>> >> > #define P4TC_PATH_MAX 3
>> >> >+#define P4TC_MAX_TENTRIES 33554432
>> >>
>> >> Seeing define like this one always makes me happier. Where does it come
>> >> from? Why not 0x2000000 at least?
>> >
>> >I dont recall why we decided to do decimal - will change it.
>> >
>> >>
>> >> >
>> >> > #define P4TC_KERNEL_PIPEID 0
>> >> >
>> >> > #define P4TC_PID_IDX 0
>> >> >+#define P4TC_AID_IDX 1
>> >> >+#define P4TC_PARSEID_IDX 1
>> >> >
>> >> > struct p4tc_dump_ctx {
>> >> >       u32 ids[P4TC_PATH_MAX];
>> >> >+      struct rhashtable_iter *iter;
>> >> > };
>> >> >
>> >> > struct p4tc_template_common;
>> >> >@@ -63,8 +69,10 @@ extern const struct p4tc_template_ops p4tc_pipeline_ops;
>> >> >
>> >> > struct p4tc_pipeline {
>> >> >       struct p4tc_template_common common;
>> >> >+      struct idr                  p_act_idr;
>> >> >       struct rcu_head             rcu;
>> >> >       struct net                  *net;
>> >> >+      u32                         num_created_acts;
>> >> >       /* Accounts for how many entities are referencing this pipeline.
>> >> >        * As for now only P4 filters can refer to pipelines.
>> >> >        */
>> >> >@@ -109,18 +117,157 @@ p4tc_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
>> >> >                                 const u32 pipeid,
>> >> >                                 struct netlink_ext_ack *extack);
>> >> >
>> >> >+struct p4tc_act *tcf_p4_find_act(struct net *net,
>> >> >+                               const struct tc_action_ops *a_o,
>> >> >+                               struct netlink_ext_ack *extack);
>> >> >+void
>> >> >+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4_act);
>> >> >+
>> >> > static inline int p4tc_action_destroy(struct tc_action **acts)
>> >> > {
>> >> >+      struct tc_action *acts_non_prealloc[TCA_ACT_MAX_PRIO] = {NULL};
>> >> >       int ret = 0;
>> >> >
>> >> >       if (acts) {
>> >> >-              ret = tcf_action_destroy(acts, TCA_ACT_UNBIND);
>> >> >+              int j = 0;
>> >> >+              int i;
>> >>
>> >> Move declarations to the beginning of the if body.
>> >>
>> >
>> >Didnt follow - which specific declaration?
>>
>> It should look like this:
>>
>>                 int j = 0;
>>                 int i;
>>
>>                 ret = tcf_action_destroy(acts, TCA_ACT_UNBIND);
>
>Huh? It does look like that already ;-> Note there's a "-" on that line.

I'm blind. Sorry.


>
>>
>> >
>> >> [...]
>> >>
>> >>
>> >> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>> >> >index 4d33f44c1..7b89229a7 100644
>> >> >--- a/include/uapi/linux/p4tc.h
>> >> >+++ b/include/uapi/linux/p4tc.h
>> >> >@@ -4,6 +4,7 @@
>> >> >
>> >> > #include <linux/types.h>
>> >> > #include <linux/pkt_sched.h>
>> >> >+#include <linux/pkt_cls.h>
>> >> >
>> >> > /* pipeline header */
>> >> > struct p4tcmsg {
>> >> >@@ -17,9 +18,12 @@ struct p4tcmsg {
>> >> > #define P4TC_MSGBATCH_SIZE 16
>> >> >
>> >> > #define P4TC_MAX_KEYSZ 512
>> >> >+#define P4TC_DEFAULT_NUM_PREALLOC 16
>> >> >
>> >> > #define TEMPLATENAMSZ 32
>> >> > #define PIPELINENAMSIZ TEMPLATENAMSZ
>> >> >+#define ACTTMPLNAMSIZ TEMPLATENAMSZ
>> >> >+#define ACTPARAMNAMSIZ TEMPLATENAMSZ
>> >>
>> >> Prefix? This is uapi. Could you please be more careful with naming at
>> >> least in the uapi area?
>> >
>> >Good point.
>> >
>> >>
>> >> [...]
>> >>
>> >>
>> >> >diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
>> >> >new file mode 100644
>> >> >index 000000000..19db0772c
>> >> >--- /dev/null
>> >> >+++ b/net/sched/p4tc/p4tc_action.c
>> >> >@@ -0,0 +1,2242 @@
>> >> >+// SPDX-License-Identifier: GPL-2.0-or-later
>> >> >+/*
>> >> >+ * net/sched/p4tc_action.c    P4 TC ACTION TEMPLATES
>> >> >+ *
>> >> >+ * Copyright (c) 2022-2023, Mojatatu Networks
>> >> >+ * Copyright (c) 2022-2023, Intel Corporation.
>> >> >+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
>> >> >+ *              Victor Nogueira <victor@mojatatu.com>
>> >> >+ *              Pedro Tammela <pctammela@mojatatu.com>
>> >> >+ */
>> >> >+
>> >> >+#include <linux/err.h>
>> >> >+#include <linux/errno.h>
>> >> >+#include <linux/init.h>
>> >> >+#include <linux/kernel.h>
>> >> >+#include <linux/kmod.h>
>> >> >+#include <linux/list.h>
>> >> >+#include <linux/module.h>
>> >> >+#include <linux/netdevice.h>
>> >> >+#include <linux/skbuff.h>
>> >> >+#include <linux/slab.h>
>> >> >+#include <linux/string.h>
>> >> >+#include <linux/types.h>
>> >> >+#include <net/flow_offload.h>
>> >> >+#include <net/net_namespace.h>
>> >> >+#include <net/netlink.h>
>> >> >+#include <net/pkt_cls.h>
>> >> >+#include <net/p4tc.h>
>> >> >+#include <net/sch_generic.h>
>> >> >+#include <net/sock.h>
>> >> >+#include <net/tc_act/p4tc.h>
>> >> >+
>> >> >+static LIST_HEAD(dynact_list);
>> >> >+
>> >> >+#define SEPARATOR "/"
>> >>
>> >> Prefix? Btw, why exactly do you need this. It is used only once.
>> >>
>> >
>> >We'll get rid of it.
>> >
>> >> To quote a few function names in this file:
>> >>
>> >> >+static void set_param_indices(struct idr *params_idr)
>> >> >+static void generic_free_param_value(struct p4tc_act_param *param)
>> >> >+static int dev_init_param_value(struct net *net, struct p4tc_act_param_ops *op,
>> >> >+static void dev_free_param_value(struct p4tc_act_param *param)
>> >> >+static void tcf_p4_act_params_destroy_rcu(struct rcu_head *head)
>> >> >+static int __tcf_p4_dyna_init_set(struct p4tc_act *act, struct tc_action **a,
>> >> >+static int tcf_p4_dyna_template_init(struct net *net, struct tc_action **a,
>> >> >+init_prealloc_param(struct p4tc_act *act, struct idr *params_idr,
>> >> >+static void p4tc_param_put(struct p4tc_act_param *param)
>> >> >+static void free_intermediate_param(struct p4tc_act_param *param)
>> >> >+static void free_intermediate_params_list(struct list_head *params_list)
>> >> >+static int init_prealloc_params(struct p4tc_act *act,
>> >> >+struct p4tc_act *p4tc_action_find_byid(struct p4tc_pipeline *pipeline,
>> >> >+static void tcf_p4_prealloc_list_add(struct p4tc_act *act_tmpl,
>> >> >+static int tcf_p4_prealloc_acts(struct net *net, struct p4tc_act *act,
>> >> >+tcf_p4_get_next_prealloc_act(struct p4tc_act *act)
>> >> >+void tcf_p4_set_init_flags(struct tcf_p4act *p4act)
>> >> >+static void __tcf_p4_put_prealloc_act(struct p4tc_act *act,
>> >> >+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4act)
>> >> >+static int generic_dump_param_value(struct sk_buff *skb, struct p4tc_type *type,
>> >> >+static int generic_init_param_value(struct p4tc_act_param *nparam,
>> >> >+static struct p4tc_act_param *param_find_byname(struct idr *params_idr,
>> >> >+tcf_param_find_byany(struct p4tc_act *act,
>> >> >+tcf_param_find_byanyattr(struct p4tc_act *act, struct nlattr *name_attr,
>> >> >+static int __p4_init_param_type(struct p4tc_act_param *param,
>> >> >+static int tcf_p4_act_init_params(struct net *net,
>> >> >+static struct p4tc_act *p4tc_action_find_byname(const char *act_name,
>> >> >+static int tcf_p4_dyna_init(struct net *net, struct nlattr *nla,
>> >> >+static int tcf_act_fill_param_type(struct sk_buff *skb,
>> >> >+static void tcf_p4_dyna_cleanup(struct tc_action *a)
>> >> >+struct p4tc_act *p4tc_action_find_get(struct p4tc_pipeline *pipeline,
>> >> >+p4tc_action_find_byanyattr(struct nlattr *act_name_attr, const u32 a_id,
>> >> >+static void p4_put_many_params(struct idr *params_idr)
>> >> >+static int p4_init_param_type(struct p4tc_act_param *param,
>> >> >+static struct p4tc_act_param *p4_create_param(struct p4tc_act *act,
>> >> >+static struct p4tc_act_param *p4_update_param(struct p4tc_act *act,
>> >> >+static struct p4tc_act_param *p4_act_init_param(struct p4tc_act *act,
>> >> >+static void p4tc_action_net_exit(struct tc_action_net *tn)
>> >> >+static void p4_act_params_put(struct p4tc_act *act)
>> >> >+static int __tcf_act_put(struct net *net, struct p4tc_pipeline *pipeline,
>> >> >+static int _tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
>> >> >+static int tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
>> >> >+static int tcf_act_flush(struct sk_buff *skb, struct net *net,
>> >> >+static void p4tc_params_replace_many(struct p4tc_act *act,
>> >> >+                                   struct idr *params_idr)
>> >> >+static struct p4tc_act *tcf_act_create(struct net *net, struct nlattr **tb,
>> >> >+tcf_act_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
>> >>
>> >> Is there some secret key how you name the functions? To me, this looks
>> >> completely inconsistent :/
>> >
>> >What would be better? tcf_p4_xxxx?
>>
>> Idk, up to you, just please maintain some basic naming consistency and
>> prefixes.
>>
>
>We'll come up with something.
>
>cheers,
>jamal
>
>>
>> >A lot of the tcf_xxx is because that convention is used in that file
>> >but we can change it.
>> >
>> >cheers,
>> >jamal
>> >>

