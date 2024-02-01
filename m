Return-Path: <bpf+bounces-20980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D1846086
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 20:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8508F2898BA
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F81784FD4;
	Thu,  1 Feb 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LL1VmD2v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152584FD5
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814036; cv=none; b=JBq7tyNyqMCiFZTGPHtlqGZ8AIMucvSEAD0TeB3rnjaIA8tD/xlVN1bWrb91YdUtAb6GlfM9SHUJcjXBBHPEfpRrRN2ds3ZGg4hH2pdp8BfYoiZFLfNDLPmB21J+BAhKxjLC4hHYmFxqQeWsRaWcqAzSlsYVnPACpBWDR0ONH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814036; c=relaxed/simple;
	bh=r9GAjnTvy1SIRls04p7XYXp+mU/J+UYn1yR6k3M3/7I=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3gJRUenlefBtvY65nQOB6r5+/viCj18xCdyEI6HFUSaW5B3RTa0bac19WgiL41bPRYb516BfawdIs9Q7c2TAD+fsVrza20qaBtAWiJHbgG2txO7ZGGW0rryGPj+mFbMdtDPwRgM15cuvWsiF4cG220vm5mo0vFN/4HVUBbE80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LL1VmD2v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRKR1h0PZnSsIUaQCl19SM8Yn3K4k9ZBF+b53dwy1ek=;
	b=LL1VmD2vyaTtayvWS3AR4XTlvGUME3oyS1FqsO0fjvaLpZ3FinsOii3DY/p99QM0m1XYu4
	YAXnONN7nPLAk1dBvtOM0KqEGUlhqpzY78vZaT7RSNvNqtbExrT3gUTQuw6byjU0Gmk3+P
	nnTRCgOAfLrduHoOzbsUA0USQAMxhGw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-OK3vigJWPJqx9ZV7Fchm4A-1; Thu, 01 Feb 2024 14:00:17 -0500
X-MC-Unique: OK3vigJWPJqx9ZV7Fchm4A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55f922036dbso655908a12.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 11:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814016; x=1707418816;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRKR1h0PZnSsIUaQCl19SM8Yn3K4k9ZBF+b53dwy1ek=;
        b=w5rxPsczf26F5s6EGBigcC9qA4Ar31c55yEzon/wiTe0ijVbJsZinBGjt+mQQZt35U
         +CxsGXMySYFGXHh8WJutEvyomlaNmHSZcMw6aI/xuNuKlMiuVlhLuqW0btg1/5ppZari
         +l+mlumffEgNv2uASuJWimCzcUWjyGIch9btg8Lnn7yt/gnL759d6+lJE7JIsEWauKoB
         zAQuBdyZzW1ly9iH71bi3tX6ryZVeKpLV5PPmLQitBUhk6+aswXJPQf3vuIAmAbXu4sy
         aaLDSRgLhA15k3G0cQDVg9HvCwrdzrFWiodjxxUGBHVqTUThvK7iepogzSCATexsbvz5
         VO1w==
X-Gm-Message-State: AOJu0YwwXKsCtJR5vNfHMPWOSRYK0zAMJ3kpAXQgDiidJU40w/hIgoMV
	wysQ61kbzBeh7OREMbItoszLgAORS0c+YSvkhxwAfj8rH/+3LcHoBj0dTwYCELNgm64S9w5jeLu
	NMDFZh4d04A3NhXdgHTeq3rHZU3XEQ2/Q6OxNy2Yl1Yu30fQ7Jd5U1qPKn8xJOI4znScz0x26Az
	7gb1UOKlaiouFnmFt2U2gF/LtS
X-Received: by 2002:aa7:c1d9:0:b0:55f:1ef6:48d6 with SMTP id d25-20020aa7c1d9000000b0055f1ef648d6mr2324296edp.35.1706814016540;
        Thu, 01 Feb 2024 11:00:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5aIySRM7JKihk1YL+nfmrN0MInvb99Qlsm5Rsn1wixR+fYu5keNYInj+igejLtF/08KX6OWrwyeCtoBBPiek=
X-Received: by 2002:aa7:c1d9:0:b0:55f:1ef6:48d6 with SMTP id
 d25-20020aa7c1d9000000b0055f1ef648d6mr2324266edp.35.1706814016179; Thu, 01
 Feb 2024 11:00:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:00:15 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-2-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-2-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 11:00:15 -0800
Message-ID: <CALnP8ZbTPN2nGVTF12ONZQxvmRR_wT4kch2z1TP_u-BJf730Kg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 01/15] net: sched: act_api: Introduce P4
 actions list
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:47PM -0500, Jamal Hadi Salim wrote:
> In P4 we require to generate new actions "on the fly" based on the
> specified P4 action definition. P4 action kinds, like the pipeline
> they are attached to, must be per net namespace, as opposed to native
> action kinds which are global. For that reason, we chose to create a
> separate structure to store P4 actions.
>
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

> ---
>  include/net/act_api.h |   8 ++-
>  net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
>  net/sched/cls_api.c   |   2 +-
>  3 files changed, 116 insertions(+), 17 deletions(-)
>
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index e1e5e72b9..ab28c2254 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
>
>  struct tc_action_ops {
>  	struct list_head head;
> +	struct list_head p4_head;
>  	char    kind[IFNAMSIZ];
>  	enum tca_id  id; /* identifier should match kind */
>  	unsigned int	net_id;
> @@ -199,8 +200,10 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
>  int tcf_idr_release(struct tc_action *a, bool bind);
>
>  int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
> +int tcf_register_p4_action(struct net *net, struct tc_action_ops *act);
>  int tcf_unregister_action(struct tc_action_ops *a,
>  			  struct pernet_operations *ops);
> +void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act);
>  int tcf_action_destroy(struct tc_action *actions[], int bind);
>  int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
>  		    int nr_actions, struct tcf_result *res);
> @@ -208,8 +211,9 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
>  		    struct nlattr *est,
>  		    struct tc_action *actions[], int init_res[], size_t *attr_size,
>  		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
> -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
> -					 struct netlink_ext_ack *extack);
> +struct tc_action_ops *
> +tc_action_load_ops(struct net *net, struct nlattr *nla,
> +		   u32 flags, struct netlink_ext_ack *extack);
>  struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
>  				    struct nlattr *nla, struct nlattr *est,
>  				    struct tc_action_ops *a_o, int *init_res,
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 3e30d7260..e4a1b8f5a 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
>  	kfree(cookie);
>  }
>
> +static unsigned int p4_act_net_id;
> +
> +struct tcf_p4_act_net {
> +	struct list_head act_base;
> +	rwlock_t act_mod_lock;
> +};
> +
> +static __net_init int tcf_p4_act_base_init_net(struct net *net)
> +{
> +	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
> +
> +	INIT_LIST_HEAD(&p4_base_net->act_base);
> +	rwlock_init(&p4_base_net->act_mod_lock);
> +
> +	return 0;
> +}
> +
> +static void __net_exit tcf_p4_act_base_exit_net(struct net *net)
> +{
> +	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
> +	struct tc_action_ops *ops, *tmp;
> +
> +	list_for_each_entry_safe(ops, tmp, &p4_base_net->act_base, p4_head) {
> +		list_del(&ops->p4_head);
> +	}
> +}
> +
> +static struct pernet_operations tcf_p4_act_base_net_ops = {
> +	.init = tcf_p4_act_base_init_net,
> +	.exit = tcf_p4_act_base_exit_net,
> +	.id = &p4_act_net_id,
> +	.size = sizeof(struct tc_action_ops),
> +};
> +
>  static void tcf_set_action_cookie(struct tc_cookie __rcu **old_cookie,
>  				  struct tc_cookie *new_cookie)
>  {
> @@ -962,6 +996,48 @@ static void tcf_pernet_del_id_list(unsigned int id)
>  	mutex_unlock(&act_id_mutex);
>  }
>
> +static struct tc_action_ops *tc_lookup_p4_action(struct net *net, char *kind)
> +{
> +	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
> +	struct tc_action_ops *a, *res = NULL;
> +
> +	read_lock(&p4_base_net->act_mod_lock);
> +	list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
> +		if (strcmp(kind, a->kind) == 0) {
> +			if (try_module_get(a->owner))
> +				res = a;
> +			break;
> +		}
> +	}
> +	read_unlock(&p4_base_net->act_mod_lock);
> +
> +	return res;
> +}
> +
> +void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act)
> +{
> +	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
> +
> +	write_lock(&p4_base_net->act_mod_lock);
> +	list_del(&act->p4_head);
> +	write_unlock(&p4_base_net->act_mod_lock);
> +}
> +EXPORT_SYMBOL(tcf_unregister_p4_action);
> +
> +int tcf_register_p4_action(struct net *net, struct tc_action_ops *act)
> +{
> +	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
> +
> +	if (tc_lookup_p4_action(net, act->kind))
> +		return -EEXIST;
> +
> +	write_lock(&p4_base_net->act_mod_lock);
> +	list_add(&act->p4_head, &p4_base_net->act_base);
> +	write_unlock(&p4_base_net->act_mod_lock);
> +
> +	return 0;
> +}
> +
>  int tcf_register_action(struct tc_action_ops *act,
>  			struct pernet_operations *ops)
>  {
> @@ -1032,7 +1108,7 @@ int tcf_unregister_action(struct tc_action_ops *act,
>  EXPORT_SYMBOL(tcf_unregister_action);
>
>  /* lookup by name */
> -static struct tc_action_ops *tc_lookup_action_n(char *kind)
> +static struct tc_action_ops *tc_lookup_action_n(struct net *net, char *kind)
>  {
>  	struct tc_action_ops *a, *res = NULL;
>
> @@ -1040,31 +1116,48 @@ static struct tc_action_ops *tc_lookup_action_n(char *kind)
>  		read_lock(&act_mod_lock);
>  		list_for_each_entry(a, &act_base, head) {
>  			if (strcmp(kind, a->kind) == 0) {
> -				if (try_module_get(a->owner))
> -					res = a;
> -				break;
> +				if (try_module_get(a->owner)) {
> +					read_unlock(&act_mod_lock);
> +					return a;
> +				}
>  			}
>  		}
>  		read_unlock(&act_mod_lock);
> +
> +		return tc_lookup_p4_action(net, kind);
>  	}
> +
>  	return res;
>  }
>
>  /* lookup by nlattr */
> -static struct tc_action_ops *tc_lookup_action(struct nlattr *kind)
> +static struct tc_action_ops *tc_lookup_action(struct net *net,
> +					      struct nlattr *kind)
>  {
> +	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
>  	struct tc_action_ops *a, *res = NULL;
>
>  	if (kind) {
>  		read_lock(&act_mod_lock);
>  		list_for_each_entry(a, &act_base, head) {
> +			if (nla_strcmp(kind, a->kind) == 0) {
> +				if (try_module_get(a->owner)) {
> +					read_unlock(&act_mod_lock);
> +					return a;
> +				}
> +			}
> +		}
> +		read_unlock(&act_mod_lock);
> +
> +		read_lock(&p4_base_net->act_mod_lock);
> +		list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
>  			if (nla_strcmp(kind, a->kind) == 0) {
>  				if (try_module_get(a->owner))
>  					res = a;
>  				break;
>  			}
>  		}
> -		read_unlock(&act_mod_lock);
> +		read_unlock(&p4_base_net->act_mod_lock);
>  	}
>  	return res;
>  }
> @@ -1324,8 +1417,9 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
>  	}
>  }
>
> -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
> -					 struct netlink_ext_ack *extack)
> +struct tc_action_ops *
> +tc_action_load_ops(struct net *net, struct nlattr *nla,
> +		   u32 flags, struct netlink_ext_ack *extack)
>  {
>  	bool police = flags & TCA_ACT_FLAGS_POLICE;
>  	struct nlattr *tb[TCA_ACT_MAX + 1];
> @@ -1356,7 +1450,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
>  		}
>  	}
>
> -	a_o = tc_lookup_action_n(act_name);
> +	a_o = tc_lookup_action_n(net, act_name);
>  	if (a_o == NULL) {
>  #ifdef CONFIG_MODULES
>  		bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
> @@ -1367,7 +1461,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
>  		if (rtnl_held)
>  			rtnl_lock();
>
> -		a_o = tc_lookup_action_n(act_name);
> +		a_o = tc_lookup_action_n(net, act_name);
>
>  		/* We dropped the RTNL semaphore in order to
>  		 * perform the module load.  So, even if we
> @@ -1477,7 +1571,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
>  	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
>  		struct tc_action_ops *a_o;
>
> -		a_o = tc_action_load_ops(tb[i], flags, extack);
> +		a_o = tc_action_load_ops(net, tb[i], flags, extack);
>  		if (IS_ERR(a_o)) {
>  			err = PTR_ERR(a_o);
>  			goto err_mod;
> @@ -1683,7 +1777,7 @@ static struct tc_action *tcf_action_get_1(struct net *net, struct nlattr *nla,
>  	index = nla_get_u32(tb[TCA_ACT_INDEX]);
>
>  	err = -EINVAL;
> -	ops = tc_lookup_action(tb[TCA_ACT_KIND]);
> +	ops = tc_lookup_action(net, tb[TCA_ACT_KIND]);
>  	if (!ops) { /* could happen in batch of actions */
>  		NL_SET_ERR_MSG(extack, "Specified TC action kind not found");
>  		goto err_out;
> @@ -1731,7 +1825,7 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
>
>  	err = -EINVAL;
>  	kind = tb[TCA_ACT_KIND];
> -	ops = tc_lookup_action(kind);
> +	ops = tc_lookup_action(net, kind);
>  	if (!ops) { /*some idjot trying to flush unknown action */
>  		NL_SET_ERR_MSG(extack, "Cannot flush unknown TC action");
>  		goto err_out;
> @@ -2184,7 +2278,7 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
>  		return 0;
>  	}
>
> -	a_o = tc_lookup_action(kind);
> +	a_o = tc_lookup_action(net, kind);
>  	if (a_o == NULL)
>  		return 0;
>
> @@ -2251,6 +2345,7 @@ static int __init tc_action_init(void)
>  	rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action,
>  		      0);
>
> +	register_pernet_subsys(&tcf_p4_act_base_net_ops);
>  	return 0;
>  }
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 92a12e3d0..2fec3f80b 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3323,7 +3323,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
>  			struct tc_action_ops *a_o;
>
>  			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
> -			a_o = tc_action_load_ops(tb[exts->police], flags,
> +			a_o = tc_action_load_ops(net, tb[exts->police], flags,
>  						 extack);
>  			if (IS_ERR(a_o))
>  				return PTR_ERR(a_o);
> --
> 2.34.1
>


