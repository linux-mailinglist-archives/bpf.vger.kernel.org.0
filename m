Return-Path: <bpf+bounces-23134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C7686E115
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 13:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E8F287D47
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582921381;
	Fri,  1 Mar 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0F1ja4SI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BE8812
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296296; cv=none; b=AGz00w1lBe2RkTbDdtOMsd54I9Qg3otdu/AqB3kGlbxswvDYHracG/RuaMQBYVEfbadQbOTBI46s27t9rdX8SZXCsugXkBlLNiLuqdSM1PqMTpEUROgE9SzAfdUKMQSFnfAguAfXXFHwCz99WHbnErSoxV/Wk0Dxkvnp/kVyGro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296296; c=relaxed/simple;
	bh=XHbrW22xZ+VED6oRbACvD1qpWSMweuDsmKqCZCB3yjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBOeJK1F67l329grU+mWGjDf1icaBnupM/rguKlXIDP50qD/tc0L5C2qplv0FNn9z+lDoT4hklGlu73/CXImR/Q6hhLVEn+hjnNqiK8zfvnJJ/fuW92+M6XW6UjpVV5xB5cioDpkMVWT81lUw8eUFcRWYx0aM9EtZXfi2XG+AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0F1ja4SI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608342633b8so20880127b3.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709296293; x=1709901093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTiCz8rMusxJ/A9dccAepJ6QtXPxSez+P2U/SaD1zIM=;
        b=0F1ja4SIYtQ27+6/3oPn/q9f8M0nHamtnrgKxxNbGA2tb/OdR8eNvQX0JVkORX/9Wf
         v0a7nlYc9MJ43fc1FS3Kc1+YyHx7Y4chWOjQ2xNTe9a5e7Ktg3uwO44P2omHM3kUlxze
         /xrMK/q3RkXGJPdQx5ttfmd1KYelG01KU2cAWUqmLdGsgYisT2VTyJjXjFRd//x3peeN
         WFgh06pSMEzMWGNT2fDVBy2PnQtDblm0vK/8j6eTgvWgeHLgpcu/8J35VFZuBC/fpN4T
         z+EpF8OO8Mv343BjjLFI4Ctb+o/GvyRmdj3TQAYL/g/q4cBX/QPXWcJjelHUIH+Mdz+1
         PujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296293; x=1709901093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTiCz8rMusxJ/A9dccAepJ6QtXPxSez+P2U/SaD1zIM=;
        b=WpEmszq/u0QD8MBN1jT0jNZEJnUomPXoOb4z9jIqnGGckaJLNR8Dz6YJJx+8OKURU+
         chIr+7Ht+MJiaoCpdYVVKun2gcy1KA2R5+KvLB1lNa9HVO7tj1meIFwX5Rh7nJc3kTH4
         3RaeM8WoPGW/mJ9XBUKVLkJg9oFVsW57DewPHKzUTH6xnLyej7CMv0EfpZfogzW4tMtZ
         c1CjC6GhSMyry/jW4b2Nh61JvpgcEikLFHfF5YFqcufh9gNhSE2net3DO9f6sQ0WiBgl
         jWTbaTW4CzK4t4H/mpjuhQnuceJ3Gp51VvOL5guIt1FOAz0kpwrvnk2C6Osjw5ygGGFk
         6Bcg==
X-Forwarded-Encrypted: i=1; AJvYcCWefPZIfh5YcaLQf1Ov+fWbRkxbpK9QZeM8ZdqtRYyoisci398TcGX00D5cbZSDu4D1A/w4v0I8GJ8NDx2k9D9Abzen
X-Gm-Message-State: AOJu0YwO5cKQuuw23YCfw+wP1l7jMbXvWlSsMgSycZXjZqCS4uuOJxt6
	Xztwhxr6Riue281jvrJ8ESivcgt7MFh7hbSf1Ri+RwmpNKXnpeOE1Ugxm/0yInmoWi47GpYj0H8
	AhyGGHMT3vbLlqXbiR8wUMnSex9Z77Pb/uOQE
X-Google-Smtp-Source: AGHT+IFfzqvIyoZOS3ugN4b6JIwFtCzuA9s+MvL0ZO2d0diPIO6GC1mLyXyzaZ4dgpmAqdbwOrOULqKOzjjiCcsLLvE=
X-Received: by 2002:a81:520e:0:b0:609:89ad:eb46 with SMTP id
 g14-20020a81520e000000b0060989adeb46mr441861ywb.14.1709296293023; Fri, 01 Mar
 2024 04:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-15-jhs@mojatatu.com>
 <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev>
In-Reply-To: <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Mar 2024 07:31:21 -0500
Message-ID: <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 14/15] p4tc: add set of P4TC table kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, 
	horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:53=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 2/25/24 8:54 AM, Jamal Hadi Salim wrote:
> > +struct p4tc_table_entry_act_bpf_params {
>
> Will this struct be extended in the future?
>
> > +     u32 pipeid;
> > +     u32 tblid;
> > +};
> > +

Not that i can think of. We probably want to have the option to do so
if needed. Do you see any harm if we were to make changes for whatever
reason in the future?

> > +struct p4tc_table_entry_create_bpf_params {
> > +     u32 profile_id;
> > +     u32 pipeid;
> > +     u32 tblid;
> > +};
> > +
>
> [ ... ]
>
> > diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
> > index c5256d821..155068de0 100644
> > --- a/include/net/tc_act/p4tc.h
> > +++ b/include/net/tc_act/p4tc.h
> > @@ -13,10 +13,26 @@ struct tcf_p4act_params {
> >       u32 tot_params_sz;
> >   };
> >
> > +#define P4TC_MAX_PARAM_DATA_SIZE 124
> > +
> > +struct p4tc_table_entry_act_bpf {
> > +     u32 act_id;
> > +     u32 hit:1,
> > +         is_default_miss_act:1,
> > +         is_default_hit_act:1;
> > +     u8 params[P4TC_MAX_PARAM_DATA_SIZE];
> > +} __packed;
> > +
> > +struct p4tc_table_entry_act_bpf_kern {
> > +     struct rcu_head rcu;
> > +     struct p4tc_table_entry_act_bpf act_bpf;
> > +};
> > +
> >   struct tcf_p4act {
> >       struct tc_action common;
> >       /* Params IDR reference passed during runtime */
> >       struct tcf_p4act_params __rcu *params;
> > +     struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
> >       u32 p_id;
> >       u32 act_id;
> >       struct list_head node;
> > @@ -24,4 +40,39 @@ struct tcf_p4act {
> >
> >   #define to_p4act(a) ((struct tcf_p4act *)a)
> >
> > +static inline struct p4tc_table_entry_act_bpf *
> > +p4tc_table_entry_act_bpf(struct tc_action *action)
> > +{
> > +     struct p4tc_table_entry_act_bpf_kern *act_bpf;
> > +     struct tcf_p4act *p4act =3D to_p4act(action);
> > +
> > +     act_bpf =3D rcu_dereference(p4act->act_bpf);
> > +
> > +     return &act_bpf->act_bpf;
> > +}
> > +
> > +static inline int
> > +p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, u32 hi=
t,
> > +                                   u32 dflt_miss, u32 dflt_hit)
> > +{
> > +     struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old;
> > +     struct tcf_p4act *p4act =3D to_p4act(action);
> > +
> > +     act_bpf =3D kzalloc(sizeof(*act_bpf), GFP_KERNEL);
>
>
> [ ... ]
>
> > +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
> > +bpf_p4tc_tbl_read(struct __sk_buff *skb_ctx,
>
> The argument could be "struct sk_buff *skb" instead of __sk_buff. Take a =
look at
> commit 2f4643934670.

We'll make that change.

>
> > +               struct p4tc_table_entry_act_bpf_params *params,
> > +               void *key, const u32 key__sz)
> > +{
> > +     struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> > +     struct net *caller_net;
> > +
> > +     caller_net =3D skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> > +
> > +     return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
> > +}
> > +
> > +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
> > +xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
> > +               struct p4tc_table_entry_act_bpf_params *params,
> > +               void *key, const u32 key__sz)
> > +{
> > +     struct xdp_buff *ctx =3D (struct xdp_buff *)xdp_ctx;
> > +     struct net *caller_net;
> > +
> > +     caller_net =3D dev_net(ctx->rxq->dev);
> > +
> > +     return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
> > +}
> > +
> > +static int
> > +__bpf_p4tc_entry_create(struct net *net,
> > +                     struct p4tc_table_entry_create_bpf_params *params=
,
> > +                     void *key, const u32 key__sz,
> > +                     struct p4tc_table_entry_act_bpf *act_bpf)
> > +{
> > +     struct p4tc_table_entry_key *entry_key =3D key;
> > +     struct p4tc_pipeline *pipeline;
> > +     struct p4tc_table *table;
> > +
> > +     if (!params || !key)
> > +             return -EINVAL;
> > +     if (key__sz !=3D P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
> > +             return -EINVAL;
> > +
> > +     pipeline =3D p4tc_pipeline_find_byid(net, params->pipeid);
> > +     if (!pipeline)
> > +             return -ENOENT;
> > +
> > +     table =3D p4tc_tbl_cache_lookup(net, params->pipeid, params->tbli=
d);
> > +     if (!table)
> > +             return -ENOENT;
> > +
> > +     if (entry_key->keysz !=3D table->tbl_keysz)
> > +             return -EINVAL;
> > +
> > +     return p4tc_table_entry_create_bpf(pipeline, table, entry_key, ac=
t_bpf,
> > +                                        params->profile_id);
>
> My understanding is this kfunc will allocate a "struct
> p4tc_table_entry_act_bpf_kern" object. If the bpf_p4tc_entry_delete() kfu=
nc is
> never called and the bpf prog is unloaded, how the act_bpf object will be
> cleaned up?
>

The TC code takes care of this. Unloading the bpf prog does not affect
the deletion, it is the TC control side that will take care of it. If
we delete the pipeline otoh then not just this entry but all entries
will be flushed.

> > +}
> > +
> > +__bpf_kfunc static int
> > +bpf_p4tc_entry_create(struct __sk_buff *skb_ctx,
> > +                   struct p4tc_table_entry_create_bpf_params *params,
> > +                   void *key, const u32 key__sz,
> > +                   struct p4tc_table_entry_act_bpf *act_bpf)
> > +{
> > +     struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> > +     struct net *net;
> > +
> > +     net =3D skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> > +
> > +     return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf=
);
> > +}
> > +
> > +__bpf_kfunc static int
> > +xdp_p4tc_entry_create(struct xdp_md *xdp_ctx,
> > +                   struct p4tc_table_entry_create_bpf_params *params,
> > +                   void *key, const u32 key__sz,
> > +                   struct p4tc_table_entry_act_bpf *act_bpf)
> > +{
> > +     struct xdp_buff *ctx =3D (struct xdp_buff *)xdp_ctx;
> > +     struct net *net;
> > +
> > +     net =3D dev_net(ctx->rxq->dev);
> > +
> > +     return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf=
);
> > +}
> > +
> > +__bpf_kfunc static int
> > +bpf_p4tc_entry_create_on_miss(struct __sk_buff *skb_ctx,
> > +                           struct p4tc_table_entry_create_bpf_params *=
params,
> > +                           void *key, const u32 key__sz,
> > +                           struct p4tc_table_entry_act_bpf *act_bpf)
> > +{
> > +     struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> > +     struct net *net;
> > +
> > +     net =3D skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> > +
> > +     return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf=
);
> > +}
> > +
> > +__bpf_kfunc static int
> > +xdp_p4tc_entry_create_on_miss(struct xdp_md *xdp_ctx,
>
> Same here. "struct xdp_buff *xdp".
>

ACK

> > +                           struct p4tc_table_entry_create_bpf_params *=
params,
> > +                           void *key, const u32 key__sz,
> > +                           struct p4tc_table_entry_act_bpf *act_bpf)
> > +{
> > +     struct xdp_buff *ctx =3D (struct xdp_buff *)xdp_ctx;
> > +     struct net *net;
> > +
> > +     net =3D dev_net(ctx->rxq->dev);
> > +
> > +     return __bpf_p4tc_entry_create(net, params, key, key__sz, act_bpf=
);
> > +}
> > +
>
> [ ... ]
>
> > +__bpf_kfunc static int
> > +bpf_p4tc_entry_delete(struct __sk_buff *skb_ctx,
> > +                   struct p4tc_table_entry_create_bpf_params *params,
> > +                   void *key, const u32 key__sz)
> > +{
> > +     struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> > +     struct net *net;
> > +
> > +     net =3D skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> > +
> > +     return __bpf_p4tc_entry_delete(net, params, key, key__sz);
> > +}
> > +
> > +__bpf_kfunc static int
> > +xdp_p4tc_entry_delete(struct xdp_md *xdp_ctx,
> > +                   struct p4tc_table_entry_create_bpf_params *params,
> > +                   void *key, const u32 key__sz)
> > +{
> > +     struct xdp_buff *ctx =3D (struct xdp_buff *)xdp_ctx;
> > +     struct net *net;
> > +
> > +     net =3D dev_net(ctx->rxq->dev);
> > +
> > +     return __bpf_p4tc_entry_delete(net, params, key, key__sz);
> > +}
> > +
> > +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
>
> This soon will be broken with the latest change in bpf-next. It is replac=
ed by
> BTF_KFUNCS_START. commit a05e90427ef6.
>

Ok, this wasnt in net-next when we pushed. We base our changes on
net-next. When do you plan to merge that into net-next?

> What is the plan on the selftest ?
>

We may need some guidance. How do you see us writing a selftest for this?
We have extensive testing on the control side which is netlink (not
part of the current series).

Overall: I thank you for taking time to review  - it is the kind of
feedback we were hoping for from the ebpf side.

cheers,
jamal

> > +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
> > +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
> > +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
> > +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
> > +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
> > +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
> > +
> > +static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_skb =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set =3D &p4tc_kfunc_check_tbl_set_skb,
> > +};
> > +
> > +BTF_SET8_START(p4tc_kfunc_check_tbl_set_xdp)
> > +BTF_ID_FLAGS(func, xdp_p4tc_tbl_read, KF_RET_NULL);
> > +BTF_ID_FLAGS(func, xdp_p4tc_entry_create);
> > +BTF_ID_FLAGS(func, xdp_p4tc_entry_create_on_miss);
> > +BTF_ID_FLAGS(func, xdp_p4tc_entry_update);
> > +BTF_ID_FLAGS(func, xdp_p4tc_entry_delete);
> > +BTF_SET8_END(p4tc_kfunc_check_tbl_set_xdp)
>

