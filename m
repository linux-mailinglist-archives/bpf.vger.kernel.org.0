Return-Path: <bpf+bounces-23137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA386E12D
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 13:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C01AB22528
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDCD20300;
	Fri,  1 Mar 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MjR9JM5N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6CC138E
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296777; cv=none; b=GwshOvAZ9og0dR2yg3xJPiG0jWYKkFKgZq5v1w8Zitz9acVLsifaUWEPJr7jRx4XujR8BgDgMwvlu2jeOcnwL14TO+o7+D3sXLkXihylvdbeqNXBVQjoRY6MR1wvB8DLrrSn/qOBJLzcXKOetqUTrEq9v8+3wUIbKs+mVvycak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296777; c=relaxed/simple;
	bh=dNSD9QK1bvtQLgHc88xc2/f2r4NnHI7y5nn5gXliDjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS/eP9CgASLL/eL0BrWtC08jqkIhn+jAHc+Ic+blubI4mExu4E8rlkYcjO20x9i1P+LBysCdirBvGb3W5Arfc5uuDgUwuIcoc5/SXUza3a+mTeZivwwn+oI3xmqtzTmKiylTvodmwNukSsKfXkBUFN/5fqNCXi7iqdE/CZChjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=MjR9JM5N; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607eefeea90so19046577b3.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 04:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709296775; x=1709901575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qXHErHZfMUXuGPvko97lD41XD8KkrxtxV708dC7EtI=;
        b=MjR9JM5NkgAEIPHTZ9O29uUjgwDOOOORUXiPF6UdVO/ZT2GYr2UWqmuIAhmtN2K18m
         N+FBQL1oo81UdmLNGty54m6fhNKv7pRkRM0fLKQ2luIB2iRKDE4G2xig+XZVe9TD3RHa
         dYizSp0Js1JR+2J83Oe5+0wcFJNA4QzZpqIgysGpmqBq23gOlw5bjtHigPbQnJMUZUdj
         Yw4WW72Rmk1mI6dT7g5utKnPbSHt7XJ7iNWbajr4yfFz68f/i+yczFQD7u9U1pulmJ8c
         vH7hs+FyAQx+hlTCI+motQFdw57akOsIEcOWtdaeh6hARC2TYBjszQsJPhoqaLhJJia1
         iZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709296775; x=1709901575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qXHErHZfMUXuGPvko97lD41XD8KkrxtxV708dC7EtI=;
        b=SveivZ4+mUYvm3+gr55lPhc3zh+Xa3bb+OYzCAScoPLhXsE/93d5VasAzUEoFZQh4G
         1tAHTWOYIHvl3rPODYR9TpXsvsh4QpNli8D9XV3yUvqDRQCsJ7VEmp5xX6r+Tc6mjo0f
         JmoXujC8Dbx3vqPH9B8r0PAcJQtCVJCJm3Yxp0uz6WoR3jGeX1SXJ1ekpKYjlzwxMS4u
         sRKHP6un1jdFZBm2ct49Y39P4oqtsU/MwI5T+Ri9XL9oJP29QIGl7CcvPJpIoki1O1YU
         MqCw9GI3YisocJYw1+JjgiUwmTDVWUWIepzYv7pzkWUWWFF7YvCrZv9vOSAtQctp7xkT
         kJCw==
X-Forwarded-Encrypted: i=1; AJvYcCXUkIP1P/P+2TKfeBlpp7zQ8mQ0A8Yme9v3RtAsPIScj3walctJepvDMrRtoUtLlaAYFNgRBckN5Wt4Itpi3NQOfhSx
X-Gm-Message-State: AOJu0YwweIhP5/Msq+sTZVX1vCGVXtCq+tiV/CN5NzRH37ezDS4CVLtE
	pp3hXZ/ADaLvnLMEC0e5vMKpPnEp7xfBIpL68Rjwzyy0ErItCRCjrqKT0b+4lIUub4PSE9RNVdW
	ui1MMzqaykii1V/rm5mhRaYV+GFYvqDuTCslt
X-Google-Smtp-Source: AGHT+IEgLXP9sL8n6K4ZcYsZ3CCmmhG7Bx+Mv5Ac+5Nl3JQLVZJHIQOPFS1w0wkyh0UBl0SX5Bhk2HfqdUSBYDTyG20=
X-Received: by 2002:a81:5288:0:b0:608:e551:d9e9 with SMTP id
 g130-20020a815288000000b00608e551d9e9mr1375983ywb.16.1709296775308; Fri, 01
 Mar 2024 04:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-2-jhs@mojatatu.com>
 <c771211a5e62dcaf2e2b7525788958036a4280fa.camel@redhat.com>
 <CAM0EoM=t6gaY6d0EOtmMGwb=GtLjcuBqS3qjupeb_hi0HuODQA@mail.gmail.com> <0e2f24d44a565114f06c5015680b482ecc34d0e9.camel@redhat.com>
In-Reply-To: <0e2f24d44a565114f06c5015680b482ecc34d0e9.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 1 Mar 2024 07:39:24 -0500
Message-ID: <CAM0EoMkE7GQiYsEyLVkMavtKSa86u4h6xT7oYDQRULKBid530w@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/15] net: sched: act_api: Introduce P4
 actions list
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:30=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2024-02-29 at 13:21 -0500, Jamal Hadi Salim wrote:
> > On Thu, Feb 29, 2024 at 10:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > >
> > > On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> > > > In P4 we require to generate new actions "on the fly" based on the
> > > > specified P4 action definition. P4 action kinds, like the pipeline
> > > > they are attached to, must be per net namespace, as opposed to nati=
ve
> > > > action kinds which are global. For that reason, we chose to create =
a
> > > > separate structure to store P4 actions.
> > > >
> > > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > > > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> > > > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > > ---
> > > >  include/net/act_api.h |   8 ++-
> > > >  net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-=
----
> > > >  net/sched/cls_api.c   |   2 +-
> > > >  3 files changed, 116 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/include/net/act_api.h b/include/net/act_api.h
> > > > index 77ee0c657..f22be14bb 100644
> > > > --- a/include/net/act_api.h
> > > > +++ b/include/net/act_api.h
> > > > @@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void =
*priv);
> > > >
> > > >  struct tc_action_ops {
> > > >       struct list_head head;
> > > > +     struct list_head p4_head;
> > > >       char    kind[IFNAMSIZ];
> > > >       enum tca_id  id; /* identifier should match kind */
> > > >       unsigned int    net_id;
> > > > @@ -199,10 +200,12 @@ int tcf_idr_check_alloc(struct tc_action_net =
*tn, u32 *index,
> > > >  int tcf_idr_release(struct tc_action *a, bool bind);
> > > >
> > > >  int tcf_register_action(struct tc_action_ops *a, struct pernet_ope=
rations *ops);
> > > > +int tcf_register_p4_action(struct net *net, struct tc_action_ops *=
act);
> > > >  int tcf_unregister_action(struct tc_action_ops *a,
> > > >                         struct pernet_operations *ops);
> > > >  #define NET_ACT_ALIAS_PREFIX "net-act-"
> > > >  #define MODULE_ALIAS_NET_ACT(kind)   MODULE_ALIAS(NET_ACT_ALIAS_PR=
EFIX kind)
> > > > +void tcf_unregister_p4_action(struct net *net, struct tc_action_op=
s *act);
> > > >  int tcf_action_destroy(struct tc_action *actions[], int bind);
> > > >  int tcf_action_exec(struct sk_buff *skb, struct tc_action **action=
s,
> > > >                   int nr_actions, struct tcf_result *res);
> > > > @@ -210,8 +213,9 @@ int tcf_action_init(struct net *net, struct tcf=
_proto *tp, struct nlattr *nla,
> > > >                   struct nlattr *est,
> > > >                   struct tc_action *actions[], int init_res[], size=
_t *attr_size,
> > > >                   u32 flags, u32 fl_flags, struct netlink_ext_ack *=
extack);
> > > > -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 f=
lags,
> > > > -                                      struct netlink_ext_ack *exta=
ck);
> > > > +struct tc_action_ops *
> > > > +tc_action_load_ops(struct net *net, struct nlattr *nla,
> > > > +                u32 flags, struct netlink_ext_ack *extack);
> > > >  struct tc_action *tcf_action_init_1(struct net *net, struct tcf_pr=
oto *tp,
> > > >                                   struct nlattr *nla, struct nlattr=
 *est,
> > > >                                   struct tc_action_ops *a_o, int *i=
nit_res,
> > > > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > > > index 9ee622fb1..23ef394f2 100644
> > > > --- a/net/sched/act_api.c
> > > > +++ b/net/sched/act_api.c
> > > > @@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head =
*p)
> > > >       kfree(cookie);
> > > >  }
> > > >
> > > > +static unsigned int p4_act_net_id;
> > > > +
> > > > +struct tcf_p4_act_net {
> > > > +     struct list_head act_base;
> > > > +     rwlock_t act_mod_lock;
> > >
> > > Note that rwlock in networking code is discouraged, as they have to b=
e
> > > unfair, see commit 0daf07e527095e64ee8927ce297ab626643e9f51.
> > >
> > > In this specific case I think there should be no problems, as is
> > > extremely hard/impossible to have serious contention on the write
> > > side,. Also there is already an existing rwlock nearby, no not a
> > > blocker but IMHO worthy to be noted.
> > >
> >
> > Sure - we can replace it. What's the preference? Spinlock?
>
> Plain spinlock will work. Using spinlock + RCU should be quite straight
> forward and will provide faster lookup.
>

rcu + spinlock sounds like a bit of overkill but we'll look into it.

cheers,
jamal

> Cheers,
>
> Paolo
>

