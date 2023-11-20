Return-Path: <bpf+bounces-15359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364957F1494
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 14:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA5B2192B
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6C1B284;
	Mon, 20 Nov 2023 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Rc8lC6aM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF3116
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 05:45:37 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5caa401f151so7361097b3.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700487936; x=1701092736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UdxwSH2pr0LxBVMvpPG4tS6EZvsd9DC2/01GfC1RPM=;
        b=Rc8lC6aMfdSRUgoGMnoPhZvKymjjM68W2mKIeaBLRjbik1btEEjqvIo0BhWvM5kDEi
         HrThgRCK5taXMbyrU8wCv49jFRETXF5/8KgKmJO31TXGyUEuYzalKP8xHDlOtvm+irIX
         bK7potAy++QR7IQmbWuV3KqkKLTtLpIAeLf01OcXIBhywZeqhQL3vHO4q4p+RgAJeIEt
         QipVgNmzkJDWU8+PD5fIFf8G8RQ8d8dnrS+26Ov5xgeNKjCmHmLTulVxK9133UVTSizO
         Pb6KX3sA3z99aUunKFWnmE6uZQGCTJCxFWk5Qb2GLPi0XzK+pNzxQRU2qADtpLeNmvFc
         6fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700487936; x=1701092736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UdxwSH2pr0LxBVMvpPG4tS6EZvsd9DC2/01GfC1RPM=;
        b=h6qehKkZ5sfICuDFOS8EbYijjWQMEXg2roGppJqJ3BYxmQrQbBlnSL28wr7kPr2WOp
         WvaHd/yvyMLSUg7+sdKlMRPka8NhIUpBM+bhyRyM0yFGMNJzy2izlFI4b7wxWuM6PbgJ
         u5v37vgk556veEllnIsNN7pg5xgJOGZ19ZtAk5sDytcWWYRBBaI8Hj5c/MoJkqkCcSn9
         oqZOh5yMRp+l/YK2/G2ohmG7DhmmXV+i0EaZr1uwkjG6kaHjMdagDem8K7Qg3u3jNIDf
         uCT6mrv5rMbFRiF6bwA0ifmwwotO4ELcZlW1nw6MNPgDEP6bB9o/5gF//J0g3UNVjcVw
         Kwsw==
X-Gm-Message-State: AOJu0YyX5JRWrsYvLJWDfpgdPg5k+ygzGX/zdElrEjpCkI7hl6CO24Of
	BQj4jWNKEfnlXmAgrFhRVsjx+JuKHsYE+Nyui/G2TA==
X-Google-Smtp-Source: AGHT+IHX4f1fSYRnY/sVM8KptmuTyQZLOoNVM1vAprFpJS7ZQXkacdH6Gze0jtF4rD6SWspopO/fDqgEp0K7i6O1d3g=
X-Received: by 2002:a05:690c:34c6:b0:5c9:eaf7:2005 with SMTP id
 fp6-20020a05690c34c600b005c9eaf72005mr3618945ywb.12.1700487936352; Mon, 20
 Nov 2023 05:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-11-jhs@mojatatu.com>
 <ZVZDH9OzqFvc3VSS@nanopsycho> <CAM0EoM=KrC5dD=cC1H7+LsSXfxj386AD=Xpy3sG19QWaiFipCg@mail.gmail.com>
 <ZVsWnWAWvzbgn2p4@nanopsycho>
In-Reply-To: <ZVsWnWAWvzbgn2p4@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 08:45:24 -0500
Message-ID: <CAM0EoMn0v2_7w2ZXnBn4w1AyEE=-sWMvcUdiNPf-ifYSfx6o3A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 10/15] p4tc: add action template create,
 update, delete, get, flush and dump
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 3:19=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Nov 17, 2023 at 04:11:29PM CET, jhs@mojatatu.com wrote:
> >On Thu, Nov 16, 2023 at 11:28=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> >>
> >> Thu, Nov 16, 2023 at 03:59:43PM CET, jhs@mojatatu.com wrote:
> >>
> >> [...]
> >>
> >>
> >> >diff --git a/include/net/act_api.h b/include/net/act_api.h
> >> >index cd5a8e86f..b95a9bc29 100644
> >> >--- a/include/net/act_api.h
> >> >+++ b/include/net/act_api.h
> >> >@@ -70,6 +70,7 @@ struct tc_action {
> >> > #define TCA_ACT_FLAGS_AT_INGRESS      (1U << (TCA_ACT_FLAGS_USER_BIT=
S + 4))
> >> > #define TCA_ACT_FLAGS_PREALLOC        (1U << (TCA_ACT_FLAGS_USER_BIT=
S + 5))
> >> > #define TCA_ACT_FLAGS_UNREFERENCED    (1U << (TCA_ACT_FLAGS_USER_BIT=
S + 6))
> >> >+#define TCA_ACT_FLAGS_FROM_P4TC       (1U << (TCA_ACT_FLAGS_USER_BIT=
S + 7))
> >> >
> >> > /* Update lastuse only if needed, to avoid dirtying a cache line.
> >> >  * We use a temp variable to avoid fetching jiffies twice.
> >> >diff --git a/include/net/p4tc.h b/include/net/p4tc.h
> >> >index ccb54d842..68b00fa72 100644
> >> >--- a/include/net/p4tc.h
> >> >+++ b/include/net/p4tc.h
> >> >@@ -9,17 +9,23 @@
> >> > #include <linux/refcount.h>
> >> > #include <linux/rhashtable.h>
> >> > #include <linux/rhashtable-types.h>
> >> >+#include <net/tc_act/p4tc.h>
> >> >+#include <net/p4tc_types.h>
> >> >
> >> > #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
> >> > #define P4TC_DEFAULT_MAX_RULES 1
> >> > #define P4TC_PATH_MAX 3
> >> >+#define P4TC_MAX_TENTRIES 33554432
> >>
> >> Seeing define like this one always makes me happier. Where does it com=
e
> >> from? Why not 0x2000000 at least?
> >
> >I dont recall why we decided to do decimal - will change it.
> >
> >>
> >> >
> >> > #define P4TC_KERNEL_PIPEID 0
> >> >
> >> > #define P4TC_PID_IDX 0
> >> >+#define P4TC_AID_IDX 1
> >> >+#define P4TC_PARSEID_IDX 1
> >> >
> >> > struct p4tc_dump_ctx {
> >> >       u32 ids[P4TC_PATH_MAX];
> >> >+      struct rhashtable_iter *iter;
> >> > };
> >> >
> >> > struct p4tc_template_common;
> >> >@@ -63,8 +69,10 @@ extern const struct p4tc_template_ops p4tc_pipelin=
e_ops;
> >> >
> >> > struct p4tc_pipeline {
> >> >       struct p4tc_template_common common;
> >> >+      struct idr                  p_act_idr;
> >> >       struct rcu_head             rcu;
> >> >       struct net                  *net;
> >> >+      u32                         num_created_acts;
> >> >       /* Accounts for how many entities are referencing this pipelin=
e.
> >> >        * As for now only P4 filters can refer to pipelines.
> >> >        */
> >> >@@ -109,18 +117,157 @@ p4tc_pipeline_find_byany_unsealed(struct net *=
net, const char *p_name,
> >> >                                 const u32 pipeid,
> >> >                                 struct netlink_ext_ack *extack);
> >> >
> >> >+struct p4tc_act *tcf_p4_find_act(struct net *net,
> >> >+                               const struct tc_action_ops *a_o,
> >> >+                               struct netlink_ext_ack *extack);
> >> >+void
> >> >+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4_a=
ct);
> >> >+
> >> > static inline int p4tc_action_destroy(struct tc_action **acts)
> >> > {
> >> >+      struct tc_action *acts_non_prealloc[TCA_ACT_MAX_PRIO] =3D {NUL=
L};
> >> >       int ret =3D 0;
> >> >
> >> >       if (acts) {
> >> >-              ret =3D tcf_action_destroy(acts, TCA_ACT_UNBIND);
> >> >+              int j =3D 0;
> >> >+              int i;
> >>
> >> Move declarations to the beginning of the if body.
> >>
> >
> >Didnt follow - which specific declaration?
>
> It should look like this:
>
>                 int j =3D 0;
>                 int i;
>
>                 ret =3D tcf_action_destroy(acts, TCA_ACT_UNBIND);

Huh? It does look like that already ;-> Note there's a "-" on that line.

>
> >
> >> [...]
> >>
> >>
> >> >diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
> >> >index 4d33f44c1..7b89229a7 100644
> >> >--- a/include/uapi/linux/p4tc.h
> >> >+++ b/include/uapi/linux/p4tc.h
> >> >@@ -4,6 +4,7 @@
> >> >
> >> > #include <linux/types.h>
> >> > #include <linux/pkt_sched.h>
> >> >+#include <linux/pkt_cls.h>
> >> >
> >> > /* pipeline header */
> >> > struct p4tcmsg {
> >> >@@ -17,9 +18,12 @@ struct p4tcmsg {
> >> > #define P4TC_MSGBATCH_SIZE 16
> >> >
> >> > #define P4TC_MAX_KEYSZ 512
> >> >+#define P4TC_DEFAULT_NUM_PREALLOC 16
> >> >
> >> > #define TEMPLATENAMSZ 32
> >> > #define PIPELINENAMSIZ TEMPLATENAMSZ
> >> >+#define ACTTMPLNAMSIZ TEMPLATENAMSZ
> >> >+#define ACTPARAMNAMSIZ TEMPLATENAMSZ
> >>
> >> Prefix? This is uapi. Could you please be more careful with naming at
> >> least in the uapi area?
> >
> >Good point.
> >
> >>
> >> [...]
> >>
> >>
> >> >diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_actio=
n.c
> >> >new file mode 100644
> >> >index 000000000..19db0772c
> >> >--- /dev/null
> >> >+++ b/net/sched/p4tc/p4tc_action.c
> >> >@@ -0,0 +1,2242 @@
> >> >+// SPDX-License-Identifier: GPL-2.0-or-later
> >> >+/*
> >> >+ * net/sched/p4tc_action.c    P4 TC ACTION TEMPLATES
> >> >+ *
> >> >+ * Copyright (c) 2022-2023, Mojatatu Networks
> >> >+ * Copyright (c) 2022-2023, Intel Corporation.
> >> >+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
> >> >+ *              Victor Nogueira <victor@mojatatu.com>
> >> >+ *              Pedro Tammela <pctammela@mojatatu.com>
> >> >+ */
> >> >+
> >> >+#include <linux/err.h>
> >> >+#include <linux/errno.h>
> >> >+#include <linux/init.h>
> >> >+#include <linux/kernel.h>
> >> >+#include <linux/kmod.h>
> >> >+#include <linux/list.h>
> >> >+#include <linux/module.h>
> >> >+#include <linux/netdevice.h>
> >> >+#include <linux/skbuff.h>
> >> >+#include <linux/slab.h>
> >> >+#include <linux/string.h>
> >> >+#include <linux/types.h>
> >> >+#include <net/flow_offload.h>
> >> >+#include <net/net_namespace.h>
> >> >+#include <net/netlink.h>
> >> >+#include <net/pkt_cls.h>
> >> >+#include <net/p4tc.h>
> >> >+#include <net/sch_generic.h>
> >> >+#include <net/sock.h>
> >> >+#include <net/tc_act/p4tc.h>
> >> >+
> >> >+static LIST_HEAD(dynact_list);
> >> >+
> >> >+#define SEPARATOR "/"
> >>
> >> Prefix? Btw, why exactly do you need this. It is used only once.
> >>
> >
> >We'll get rid of it.
> >
> >> To quote a few function names in this file:
> >>
> >> >+static void set_param_indices(struct idr *params_idr)
> >> >+static void generic_free_param_value(struct p4tc_act_param *param)
> >> >+static int dev_init_param_value(struct net *net, struct p4tc_act_par=
am_ops *op,
> >> >+static void dev_free_param_value(struct p4tc_act_param *param)
> >> >+static void tcf_p4_act_params_destroy_rcu(struct rcu_head *head)
> >> >+static int __tcf_p4_dyna_init_set(struct p4tc_act *act, struct tc_ac=
tion **a,
> >> >+static int tcf_p4_dyna_template_init(struct net *net, struct tc_acti=
on **a,
> >> >+init_prealloc_param(struct p4tc_act *act, struct idr *params_idr,
> >> >+static void p4tc_param_put(struct p4tc_act_param *param)
> >> >+static void free_intermediate_param(struct p4tc_act_param *param)
> >> >+static void free_intermediate_params_list(struct list_head *params_l=
ist)
> >> >+static int init_prealloc_params(struct p4tc_act *act,
> >> >+struct p4tc_act *p4tc_action_find_byid(struct p4tc_pipeline *pipelin=
e,
> >> >+static void tcf_p4_prealloc_list_add(struct p4tc_act *act_tmpl,
> >> >+static int tcf_p4_prealloc_acts(struct net *net, struct p4tc_act *ac=
t,
> >> >+tcf_p4_get_next_prealloc_act(struct p4tc_act *act)
> >> >+void tcf_p4_set_init_flags(struct tcf_p4act *p4act)
> >> >+static void __tcf_p4_put_prealloc_act(struct p4tc_act *act,
> >> >+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4ac=
t)
> >> >+static int generic_dump_param_value(struct sk_buff *skb, struct p4tc=
_type *type,
> >> >+static int generic_init_param_value(struct p4tc_act_param *nparam,
> >> >+static struct p4tc_act_param *param_find_byname(struct idr *params_i=
dr,
> >> >+tcf_param_find_byany(struct p4tc_act *act,
> >> >+tcf_param_find_byanyattr(struct p4tc_act *act, struct nlattr *name_a=
ttr,
> >> >+static int __p4_init_param_type(struct p4tc_act_param *param,
> >> >+static int tcf_p4_act_init_params(struct net *net,
> >> >+static struct p4tc_act *p4tc_action_find_byname(const char *act_name=
,
> >> >+static int tcf_p4_dyna_init(struct net *net, struct nlattr *nla,
> >> >+static int tcf_act_fill_param_type(struct sk_buff *skb,
> >> >+static void tcf_p4_dyna_cleanup(struct tc_action *a)
> >> >+struct p4tc_act *p4tc_action_find_get(struct p4tc_pipeline *pipeline=
,
> >> >+p4tc_action_find_byanyattr(struct nlattr *act_name_attr, const u32 a=
_id,
> >> >+static void p4_put_many_params(struct idr *params_idr)
> >> >+static int p4_init_param_type(struct p4tc_act_param *param,
> >> >+static struct p4tc_act_param *p4_create_param(struct p4tc_act *act,
> >> >+static struct p4tc_act_param *p4_update_param(struct p4tc_act *act,
> >> >+static struct p4tc_act_param *p4_act_init_param(struct p4tc_act *act=
,
> >> >+static void p4tc_action_net_exit(struct tc_action_net *tn)
> >> >+static void p4_act_params_put(struct p4tc_act *act)
> >> >+static int __tcf_act_put(struct net *net, struct p4tc_pipeline *pipe=
line,
> >> >+static int _tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
> >> >+static int tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
> >> >+static int tcf_act_flush(struct sk_buff *skb, struct net *net,
> >> >+static void p4tc_params_replace_many(struct p4tc_act *act,
> >> >+                                   struct idr *params_idr)
> >> >+static struct p4tc_act *tcf_act_create(struct net *net, struct nlatt=
r **tb,
> >> >+tcf_act_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
> >>
> >> Is there some secret key how you name the functions? To me, this looks
> >> completely inconsistent :/
> >
> >What would be better? tcf_p4_xxxx?
>
> Idk, up to you, just please maintain some basic naming consistency and
> prefixes.
>

We'll come up with something.

cheers,
jamal

>
> >A lot of the tcf_xxx is because that convention is used in that file
> >but we can change it.
> >
> >cheers,
> >jamal
> >>

