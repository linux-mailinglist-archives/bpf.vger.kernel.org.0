Return-Path: <bpf+bounces-23278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D877886F661
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063E11C20939
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C276419;
	Sun,  3 Mar 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3LjEZsVF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940E762EC
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486470; cv=none; b=YlfbEytEEsV6DBd6WSeqAGGPB1I/9BDyFddFnvcPcVuFypmbjivTkc1U6/kj0uYISjBRShumTjJ8LL0L4J51T8uC1PD9+gYMYGmmndnq3AK6/GF7EK18xDJB+IlBfBsBXUKDLT+HuY5/4yXHLaTkjM5D8mNrLQSzHDmYLWuyuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486470; c=relaxed/simple;
	bh=3I5eHzNvs4mp3G5PvpZWA4dPskcB1XImYHUKR6coKcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZyEQpPLPGq/szkm008U6Ux8NWhHgytbORexUnorrd9ey/3qUH38d9wCv8TXi3ryyTNalp7JLV8RkV17iPwCGdL6I7zVMrt3ZRtL6EzESLBr1T7IFNxky+o+5pyvCebdKlN6vZhLb188ah47rw+Mcxz5JRSTUyMphBbEHV37XGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3LjEZsVF; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc745927098so3196609276.3
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709486467; x=1710091267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGwyFCcgFqUluy+v1CeMldZr8oP4azn0JVySazjdIXo=;
        b=3LjEZsVFwgZXPj9EPi3SmH2HHDALjJNmVuNA9yW66aVSE6Lvar1kAzltVZfzgNYG2a
         sZXjTGUU/w7crgI8xI8Pya4qQXyneHQ71JfawziBZt/SsF8ijccM2WpHVZ62cTyjxFER
         dmyiY225NdYDX/h0xljWbkwkW6NPN1g+IdQJVxpkIMDrExs9SV/T4kKm1L4VzPd4RvoZ
         mCn0SW/Ta5EYN6cTXgJQddtigasPjCDxuywlxH0DsoiCo0rRA+owWfQiiSeqJaKENp0r
         rEZpE9ZHccpDG6UwAAuUe1dguFUJZK/itSYAL3oU7uhbhQWPGLWGCUrzoX1j6ShdDE7V
         hdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709486467; x=1710091267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGwyFCcgFqUluy+v1CeMldZr8oP4azn0JVySazjdIXo=;
        b=FZHiZzCOf7yRkLTUZ2eNat71bq7chm3wC3/eXu2M0O4jml55G3I9SzHfUYw4HD7FYf
         36tuh/nTjy60XY8LdQR+gq6L4rG9RXJBcSLWAhkCog/8p2VcLXx+eojJOCjfE7M3946T
         K5IKr/J5+5wEDrUXOjHnAeuiEcWb5aKAt1W8Zs66d2CyvT7uxXksuGwYXyXzx5mBsfTZ
         69h1HR5uHaB6UHZuIXn8qC/dY2quKyGmQreLYoIPShNAmcUcHnZ60E+v4K2zSo91nSvQ
         XUx5LLQjPr1pLKtXst6mcxdcGxNd9hQ1TzUPIX6LAiWZfewFFORCAoQHkp9VpehnTntW
         LOqw==
X-Forwarded-Encrypted: i=1; AJvYcCXOqrJILj4Nj6LTOML8/qHMeal8mQrIb7J7Zp7NpwnWjR/Ci5bVL/bCrcebgUTl3vecA/qY8Chu3XsEPD67DIgZlheM
X-Gm-Message-State: AOJu0Yw5pOniI++w2O3VeggzIEQgrcJZt2LH1i9xBu1japb3+GLAAVpQ
	ft85vIv/NU7n0uMJAUaqiSkKUzMMOc/hn9eQU+/Smj/Z4WDpPdWleShQQGlxoMvu4FJr8heaAW2
	KnTBLm9sybI85KrB8CjQvOltk0k/cbCn3Oqdh
X-Google-Smtp-Source: AGHT+IFrJbKi3wbybsPj9iV9rVozN47QBHzP+s1a3tSSpObkqdCAqEO8WvmOkw1Mr0SF+UzrftVaM06VDi4hLkmHxBk=
X-Received: by 2002:a05:6902:2201:b0:dcb:fb49:cb96 with SMTP id
 dm1-20020a056902220100b00dcbfb49cb96mr6195435ybb.31.1709486466754; Sun, 03
 Mar 2024 09:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-15-jhs@mojatatu.com>
 <9eff9a51-a945-48f6-9d14-a484b7c0d04c@linux.dev> <CAM0EoMniOaKn4W_WN9rmQZ1JY3qCugn34mmqCy9UdCTAj_tuTQ@mail.gmail.com>
 <f88b5f65-957e-4b5d-8959-d16e79372658@linux.dev>
In-Reply-To: <f88b5f65-957e-4b5d-8959-d16e79372658@linux.dev>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 3 Mar 2024 12:20:55 -0500
Message-ID: <CAM0EoMk=igKT5ZEwcfdQqP6O3u8tO7VOpkNsWE1b92ia2eZVpw@mail.gmail.com>
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

On Sat, Mar 2, 2024 at 8:32=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 3/1/24 4:31 AM, Jamal Hadi Salim wrote:
> > On Fri, Mar 1, 2024 at 1:53=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >>
> >> On 2/25/24 8:54 AM, Jamal Hadi Salim wrote:
> >>> +struct p4tc_table_entry_act_bpf_params {
> >>
> >> Will this struct be extended in the future?
> >>
> >>> +     u32 pipeid;
> >>> +     u32 tblid;
> >>> +};
> >>> +
> >
> > Not that i can think of. We probably want to have the option to do so
> > if needed. Do you see any harm if we were to make changes for whatever
> > reason in the future?
>
> It will be useful to add an argument named with "__sz" suffix to the kfun=
c.
> Take a look at how the kfunc in nf_conntrack_bpf.c is handling the "opts"=
 and
> "opts__sz" argument in its kfunc.
>

Ok, will look.

> >
> >>> +struct p4tc_table_entry_create_bpf_params {
> >>> +     u32 profile_id;
> >>> +     u32 pipeid;
> >>> +     u32 tblid;
> >>> +};
> >>> +
> >>
> >> [ ... ]
> >>
> >>> diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
> >>> index c5256d821..155068de0 100644
> >>> --- a/include/net/tc_act/p4tc.h
> >>> +++ b/include/net/tc_act/p4tc.h
> >>> @@ -13,10 +13,26 @@ struct tcf_p4act_params {
> >>>        u32 tot_params_sz;
> >>>    };
> >>>
> >>> +#define P4TC_MAX_PARAM_DATA_SIZE 124
> >>> +
> >>> +struct p4tc_table_entry_act_bpf {
> >>> +     u32 act_id;
> >>> +     u32 hit:1,
> >>> +         is_default_miss_act:1,
> >>> +         is_default_hit_act:1;
> >>> +     u8 params[P4TC_MAX_PARAM_DATA_SIZE];
> >>> +} __packed;
> >>> +
> >>> +struct p4tc_table_entry_act_bpf_kern {
> >>> +     struct rcu_head rcu;
> >>> +     struct p4tc_table_entry_act_bpf act_bpf;
> >>> +};
> >>> +
> >>>    struct tcf_p4act {
> >>>        struct tc_action common;
> >>>        /* Params IDR reference passed during runtime */
> >>>        struct tcf_p4act_params __rcu *params;
> >>> +     struct p4tc_table_entry_act_bpf_kern __rcu *act_bpf;
> >>>        u32 p_id;
> >>>        u32 act_id;
> >>>        struct list_head node;
> >>> @@ -24,4 +40,39 @@ struct tcf_p4act {
> >>>
> >>>    #define to_p4act(a) ((struct tcf_p4act *)a)
> >>>
> >>> +static inline struct p4tc_table_entry_act_bpf *
> >>> +p4tc_table_entry_act_bpf(struct tc_action *action)
> >>> +{
> >>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf;
> >>> +     struct tcf_p4act *p4act =3D to_p4act(action);
> >>> +
> >>> +     act_bpf =3D rcu_dereference(p4act->act_bpf);
> >>> +
> >>> +     return &act_bpf->act_bpf;
> >>> +}
> >>> +
> >>> +static inline int
> >>> +p4tc_table_entry_act_bpf_change_flags(struct tc_action *action, u32 =
hit,
> >>> +                                   u32 dflt_miss, u32 dflt_hit)
> >>> +{
> >>> +     struct p4tc_table_entry_act_bpf_kern *act_bpf, *act_bpf_old;
> >>> +     struct tcf_p4act *p4act =3D to_p4act(action);
> >>> +
> >>> +     act_bpf =3D kzalloc(sizeof(*act_bpf), GFP_KERNEL);
> >>
> >>
> >> [ ... ]
> >>
> >>> +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
> >>> +bpf_p4tc_tbl_read(struct __sk_buff *skb_ctx,
> >>
> >> The argument could be "struct sk_buff *skb" instead of __sk_buff. Take=
 a look at
> >> commit 2f4643934670.
> >
> > We'll make that change.
> >
> >>
> >>> +               struct p4tc_table_entry_act_bpf_params *params,
> >>> +               void *key, const u32 key__sz)
> >>> +{
> >>> +     struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> >>> +     struct net *caller_net;
> >>> +
> >>> +     caller_net =3D skb->dev ? dev_net(skb->dev) : sock_net(skb->sk)=
;
> >>> +
> >>> +     return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
> >>> +}
> >>> +
> >>> +__bpf_kfunc static struct p4tc_table_entry_act_bpf *
> >>> +xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
> >>> +               struct p4tc_table_entry_act_bpf_params *params,
> >>> +               void *key, const u32 key__sz)
> >>> +{
> >>> +     struct xdp_buff *ctx =3D (struct xdp_buff *)xdp_ctx;
> >>> +     struct net *caller_net;
> >>> +
> >>> +     caller_net =3D dev_net(ctx->rxq->dev);
> >>> +
> >>> +     return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
> >>> +}
> >>> +
> >>> +static int
> >>> +__bpf_p4tc_entry_create(struct net *net,
> >>> +                     struct p4tc_table_entry_create_bpf_params *para=
ms,
> >>> +                     void *key, const u32 key__sz,
> >>> +                     struct p4tc_table_entry_act_bpf *act_bpf)
> >>> +{
> >>> +     struct p4tc_table_entry_key *entry_key =3D key;
> >>> +     struct p4tc_pipeline *pipeline;
> >>> +     struct p4tc_table *table;
> >>> +
> >>> +     if (!params || !key)
> >>> +             return -EINVAL;
> >>> +     if (key__sz !=3D P4TC_ENTRY_KEY_SZ_BYTES(entry_key->keysz))
> >>> +             return -EINVAL;
> >>> +
> >>> +     pipeline =3D p4tc_pipeline_find_byid(net, params->pipeid);
> >>> +     if (!pipeline)
> >>> +             return -ENOENT;
> >>> +
> >>> +     table =3D p4tc_tbl_cache_lookup(net, params->pipeid, params->tb=
lid);
> >>> +     if (!table)
> >>> +             return -ENOENT;
> >>> +
> >>> +     if (entry_key->keysz !=3D table->tbl_keysz)
> >>> +             return -EINVAL;
> >>> +
> >>> +     return p4tc_table_entry_create_bpf(pipeline, table, entry_key, =
act_bpf,
> >>> +                                        params->profile_id);
> >>
> >> My understanding is this kfunc will allocate a "struct
> >> p4tc_table_entry_act_bpf_kern" object. If the bpf_p4tc_entry_delete() =
kfunc is
> >> never called and the bpf prog is unloaded, how the act_bpf object will=
 be
> >> cleaned up?
> >>
> >
> > The TC code takes care of this. Unloading the bpf prog does not affect
> > the deletion, it is the TC control side that will take care of it. If
> > we delete the pipeline otoh then not just this entry but all entries
> > will be flushed.
>
> It looks like the "struct p4tc_table_entry_act_bpf_kern" object is alloca=
ted by
> the bpf prog through kfunc and will only be useful for the bpf prog but n=
ot
> other parts of the kernel. However, if the bpf prog is unloaded, these bp=
f
> specific objects will be left over in the kernel until the tc pipeline (w=
here
> the act_bpf_kern object resided) is gone.
>
> It is the expectation on bpf prog (not only tc/xdp bpf prog) about resour=
ces
> clean up that these bpf objects will be gone after unloading the bpf prog=
 and
> unpinning its bpf map.
>

The table (residing on the TC side) could be shared by multiple bpf
programs. Entries are allocated on the TC side of the fence.
IOW, the memory is not owned by the bpf prog but rather by pipeline.
We do have a "whodunnit" field, i.e we keep track of which entity
added an entry and we are capable of deleting all entries when we
detect a bpf program being deleted (this would be via deleting the tc
filter). But my thinking is we should make that a policy decision as
opposed to something which is default.

> [ ... ]
>
> >>> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
> >>
> >> This soon will be broken with the latest change in bpf-next. It is rep=
laced by
> >> BTF_KFUNCS_START. commit a05e90427ef6.
>
> It has already been included in the latest bpf-next pull-request, so shou=
ld
> reach net-next soon.
>

Ok, we'll wait for it.

>> We may need some guidance. How do you see us writing a selftest for this=
?
>> We have extensive testing on the control side which is netlink (not
>> part of the current series).

>There are examples in tools/testing/selftests/bpf, e.g. the test_bpf_nf.c =
to
>test the kfuncs in nf_conntrack_bpf mentioned above. There are also selfte=
sts
>doing netlink to setup the test. The bpf/test_progs tries to avoid externa=
l
>dependency as much as possible, so linking to an extra external library an=
d
>using an extra tool/binary will be unacceptable.
>and only the bpf/test_progs binary will be run by bpf CI.
>
>The selftest does not have to be complicated. It can exercise the kfunc an=
d show
>how the new struct (e.g. struct p4tc_table_entry_bpf_*) will be used. Ther=
e is
>BPF_PROG_RUN for the tc and xdp prog, so should be quite doable.

We will look into it.

Thanks for your feedback.

cheers,
jamal

