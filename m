Return-Path: <bpf+bounces-23051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF186CC54
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51881F23713
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605531384A8;
	Thu, 29 Feb 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmW++lch"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C8137C21
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219149; cv=none; b=HGUkPoraCNkuani2vhen8fMlramDKFQw5TT09OmKKLYu6imCxxaLcAelrIYdsVXfaj2lMyjEYAxeYZ5bQYVRCPJ4FBvCNihVHt0C7HWyUfw/G6qgr/f3eXie0Ho6HjHzARqfBW0XlNAd4PMOz96kW41xBeRMSM6T3bpVYFuS2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219149; c=relaxed/simple;
	bh=o25BGruuHI0rCuP4K5qNcx3lECL21+k6ClvvJssuwlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ns5uNNO/q9GxREnKHYmdxIYx4U3cFXKDzJIHdwipFKC0HPzLxjYJbhkBeBYP2srLQlt7TnKjX/eNze0M12l4WYf0zRR8g3UmyvNEr3YQXxx5dVCkyDn0p0xm2IVUpMJH5dRlKvAa93yWGxib0993nrh0Z4nLclnIjnfDUioGgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmW++lch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709219145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jm3oKQlVmiLpDxJ0G+7CCUUZ8dwL8ik8BHrZf6eZ5k8=;
	b=AmW++lchFMU7i7ZOnYRhg5ycUTs4h5VXJIkJS8ryzTvZsbdI2A9emqWKQ4Nn7yUYZ79Xwl
	wAerAX9P0uhnQQ7FCzFcEafd1ya3eBxLYiAMopYwgeCkNqDGNNDUiB5cAiKKh3Miffcuoz
	Q12+q8z+/3sx84/C5ibfgq3Wl8oOywQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-29wXivn8P8y9L_DP9fxWDw-1; Thu, 29 Feb 2024 10:05:43 -0500
X-MC-Unique: 29wXivn8P8y9L_DP9fxWDw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412b30be675so1554555e9.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 07:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219139; x=1709823939;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jm3oKQlVmiLpDxJ0G+7CCUUZ8dwL8ik8BHrZf6eZ5k8=;
        b=EqqQkRik6+CRTiBm6XrMKkBLeAo4626hD0d088lDnNZGevVOagWPmZJsXt420/bPJB
         V6si/EVW+iVwPjo5EFoP1Se3KzFb0H5bnDKACvx8h+JcyzOHpV6ezzxY4U/StS76dRcg
         ZS+JmbMYgXlcTvnGyfZc0eMoj3JZPLMfUfZI24aw7CpxN9Nv+gKyJdo94I4+Id7rUp01
         +MEzgnbSzUFtYAU1/xv78HWjq2QcIPkdPfiXp1ArqL3GM8pzFDr7qeYgpnFvExIcH87D
         ETh1ZyLxRE6kksjZkn53CrQulycUFxDRfe988qfSOLGYm6yVCtbyRXbiS3bq46MLzkkI
         LGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyfAeECXutRWzTXVsqZtkMnwlB33vQLAek840qvK5b1/uIQdO0Z713bjdZ2B17cHgd8npgou8P0Wz2Nd2p4lR6M4iX
X-Gm-Message-State: AOJu0Yyd/DaRYMVyLfCbEbNqzSwAN04/wodSxy+px8kcVSmATiJ7HGsC
	5Aa8oWzH5+LDIJOpCyq/jktsjN2wnpOfb3zL8APkHH/mgyO+18s4fYeZBrREd6mK6BLkzQr8x67
	c7Ca9oG37Xhi9fvH0Qgiv2c39txIqjLNq6Y1Gxij07o2m4Cryag==
X-Received: by 2002:a05:6000:400c:b0:33d:9d49:754d with SMTP id cp12-20020a056000400c00b0033d9d49754dmr1918829wrb.4.1709219139425;
        Thu, 29 Feb 2024 07:05:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDPFioCPsIKHytmDUDVoJpZjmJ8vw6UCBITZrR//bhcrPyAL9DXDxWO2tN1fv8tdhsDsX9eA==
X-Received: by 2002:a05:6000:400c:b0:33d:9d49:754d with SMTP id cp12-20020a056000400c00b0033d9d49754dmr1918796wrb.4.1709219138979;
        Thu, 29 Feb 2024 07:05:38 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-250-174.dyn.eolo.it. [146.241.250.174])
        by smtp.gmail.com with ESMTPSA id bp22-20020a5d5a96000000b0033d8b1ace25sm2118674wrb.2.2024.02.29.07.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:05:38 -0800 (PST)
Message-ID: <c771211a5e62dcaf2e2b7525788958036a4280fa.camel@redhat.com>
Subject: Re: [PATCH net-next v12  01/15] net: sched: act_api: Introduce P4
 actions list
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
 khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net,
 victor@mojatatu.com,  pctammela@mojatatu.com, bpf@vger.kernel.org
Date: Thu, 29 Feb 2024 16:05:36 +0100
In-Reply-To: <20240225165447.156954-2-jhs@mojatatu.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	 <20240225165447.156954-2-jhs@mojatatu.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> In P4 we require to generate new actions "on the fly" based on the
> specified P4 action definition. P4 action kinds, like the pipeline
> they are attached to, must be per net namespace, as opposed to native
> action kinds which are global. For that reason, we chose to create a
> separate structure to store P4 actions.
>=20
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> ---
>  include/net/act_api.h |   8 ++-
>  net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
>  net/sched/cls_api.c   |   2 +-
>  3 files changed, 116 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/net/act_api.h b/include/net/act_api.h
> index 77ee0c657..f22be14bb 100644
> --- a/include/net/act_api.h
> +++ b/include/net/act_api.h
> @@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv)=
;
> =20
>  struct tc_action_ops {
>  	struct list_head head;
> +	struct list_head p4_head;
>  	char    kind[IFNAMSIZ];
>  	enum tca_id  id; /* identifier should match kind */
>  	unsigned int	net_id;
> @@ -199,10 +200,12 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u=
32 *index,
>  int tcf_idr_release(struct tc_action *a, bool bind);
> =20
>  int tcf_register_action(struct tc_action_ops *a, struct pernet_operation=
s *ops);
> +int tcf_register_p4_action(struct net *net, struct tc_action_ops *act);
>  int tcf_unregister_action(struct tc_action_ops *a,
>  			  struct pernet_operations *ops);
>  #define NET_ACT_ALIAS_PREFIX "net-act-"
>  #define MODULE_ALIAS_NET_ACT(kind)	MODULE_ALIAS(NET_ACT_ALIAS_PREFIX kin=
d)
> +void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act=
);
>  int tcf_action_destroy(struct tc_action *actions[], int bind);
>  int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
>  		    int nr_actions, struct tcf_result *res);
> @@ -210,8 +213,9 @@ int tcf_action_init(struct net *net, struct tcf_proto=
 *tp, struct nlattr *nla,
>  		    struct nlattr *est,
>  		    struct tc_action *actions[], int init_res[], size_t *attr_size,
>  		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
> -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
> -					 struct netlink_ext_ack *extack);
> +struct tc_action_ops *
> +tc_action_load_ops(struct net *net, struct nlattr *nla,
> +		   u32 flags, struct netlink_ext_ack *extack);
>  struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *t=
p,
>  				    struct nlattr *nla, struct nlattr *est,
>  				    struct tc_action_ops *a_o, int *init_res,
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 9ee622fb1..23ef394f2 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
>  	kfree(cookie);
>  }
> =20
> +static unsigned int p4_act_net_id;
> +
> +struct tcf_p4_act_net {
> +	struct list_head act_base;
> +	rwlock_t act_mod_lock;

Note that rwlock in networking code is discouraged, as they have to be
unfair, see commit 0daf07e527095e64ee8927ce297ab626643e9f51.

In this specific case I think there should be no problems, as is
extremely hard/impossible to have serious contention on the write
side,. Also there is already an existing rwlock nearby, no not a
blocker but IMHO worthy to be noted.

Cheers,

Paolo


