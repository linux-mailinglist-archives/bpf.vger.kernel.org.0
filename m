Return-Path: <bpf+bounces-23119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184C186DC18
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10FE283E6A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBE69964;
	Fri,  1 Mar 2024 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+TM/dHf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D846930A
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278215; cv=none; b=euJ2Tex9+zIMepHO2/nlQ4wiVkcJyjVaU4Tqw+QZ/H/TOyW09HbJ+dEVZtFpOOlyNXS4kWqCgD8ES4vykVUdgpr2bmw7H3leUt2m0vASUi4ibUbAWzW1Y7+j2hVXQFBfLGM+s0uiqn6q88VEUeysvDJxvT/pr0vJEz0AdIbHaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278215; c=relaxed/simple;
	bh=Ikhxf0/eHLVPqABdwtE7XMNSCYVODeCQZ59FSCqtbYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wt+jzmZEjWQpErKXuRCNgaSAJjPgYRdq1Ivo365vI9+80LrXekaQbnxPRkzFjlNzXdWLhVFIuAK6t4GUf68FfMBVTqtvwXmaYTyaDFLEUFXn8b/rHr8mVP+0mAR+rLN2zI8M/jgi2X5MRZUQ83HNUACFAvsOaZyiLr2pwo5Xgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+TM/dHf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709278211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sD7VxdaiJ+Kjq1G3tM2pMh8dxyqSV9/4iHg7NclTyNA=;
	b=K+TM/dHfOHb6OLl9F6DMAcf4CLBqGopjfh70rozoQQtheuvnnKB06mpdYn7eZ8ZL3y9JyT
	Waa/Q6dWKHmSEutBKZUwYE5ogM+Nyve3lXeZzbljfbhdJ9wCRTjrYNJcMurX/AL0CsyEAY
	s0hzRmi8ZEu24FgwGiXZsyz9ZA4rqUI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-icM3uLk3OOi963b_V_KhCw-1; Fri, 01 Mar 2024 02:30:10 -0500
X-MC-Unique: icM3uLk3OOi963b_V_KhCw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41296f8d1e6so1533245e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 23:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709278209; x=1709883009;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sD7VxdaiJ+Kjq1G3tM2pMh8dxyqSV9/4iHg7NclTyNA=;
        b=h0bwE3sL+Guc0GEs1IpReJv68RzTj7I0LGE5TSrfn9nPvnYKhSOQnvGUz7Yq9v+AoU
         QCacy9ObxlKMGH99jlv3Et56OHJUUUVsBkZqpO0Q+urP829O15bvQjTuQLRj174foC1V
         z2gkncsThP9HUgh697q74xDwasfE2j8UMSA0q96RV12a0gW/7HC1/1r6eloLOfV678P/
         TDXwt20k7Mi3uSIsJKihbA292zEaiEpXWZ6E/pCpqDyT9KF+yVe3bGOgdLHa7MzJ6cRl
         Sto1Q/pozGA1mxJX5m7/UMQzNIR/743N6akGApHpkKZR6RII1MVfVdIxvmuE/Ua044mN
         uXtA==
X-Forwarded-Encrypted: i=1; AJvYcCUaNJu7rm+HzGXx2fR5Th67GOBUz8FvrqgHWdCBPOcWsyCNI3NfaEunJc3waW8zAw74HAMEHN296PpOU0UJVgqgExzf
X-Gm-Message-State: AOJu0Yz0yTbd1Orr1KIzO+0O2IKiOKK3MMjheshTs0kStCOUDOcvx/Bg
	tLH4Yk7VB3AXpk2Ni+8oXLkoSHhxjEf6VrXl3rj4J0bA+oXbUgZEMwCPzoucNpan7nTaCzVgLRN
	59NKHGrvBkndQxMor2t3/HmBBRbwd89DDvYjTHkLu7jtmFlcDPw==
X-Received: by 2002:adf:cc14:0:b0:33d:a6f2:86f5 with SMTP id x20-20020adfcc14000000b0033da6f286f5mr514802wrh.4.1709278208862;
        Thu, 29 Feb 2024 23:30:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqKv23HgdvLIMHjppTOCD3ItVT2gg886XxFka9OeHDNWleuznYQdnSNo+6jkCuZgVUniqhhg==
X-Received: by 2002:adf:cc14:0:b0:33d:a6f2:86f5 with SMTP id x20-20020adfcc14000000b0033da6f286f5mr514775wrh.4.1709278208429;
        Thu, 29 Feb 2024 23:30:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-247-38.dyn.eolo.it. [146.241.247.38])
        by smtp.gmail.com with ESMTPSA id g25-20020adfa499000000b0033d6c928a95sm3823448wrb.63.2024.02.29.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:30:07 -0800 (PST)
Message-ID: <0e2f24d44a565114f06c5015680b482ecc34d0e9.camel@redhat.com>
Subject: Re: [PATCH net-next v12 01/15] net: sched: act_api: Introduce P4
 actions list
From: Paolo Abeni <pabeni@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com,  namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com,  Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com,
 tomasz.osinski@intel.com,  jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 vladbu@nvidia.com, horms@kernel.org,  khalidm@nvidia.com, toke@redhat.com,
 daniel@iogearbox.net, victor@mojatatu.com,  pctammela@mojatatu.com,
 bpf@vger.kernel.org
Date: Fri, 01 Mar 2024 08:30:05 +0100
In-Reply-To: <CAM0EoM=t6gaY6d0EOtmMGwb=GtLjcuBqS3qjupeb_hi0HuODQA@mail.gmail.com>
References: <20240225165447.156954-1-jhs@mojatatu.com>
	 <20240225165447.156954-2-jhs@mojatatu.com>
	 <c771211a5e62dcaf2e2b7525788958036a4280fa.camel@redhat.com>
	 <CAM0EoM=t6gaY6d0EOtmMGwb=GtLjcuBqS3qjupeb_hi0HuODQA@mail.gmail.com>
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

On Thu, 2024-02-29 at 13:21 -0500, Jamal Hadi Salim wrote:
> On Thu, Feb 29, 2024 at 10:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> > On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> > > In P4 we require to generate new actions "on the fly" based on the
> > > specified P4 action definition. P4 action kinds, like the pipeline
> > > they are attached to, must be per net namespace, as opposed to native
> > > action kinds which are global. For that reason, we chose to create a
> > > separate structure to store P4 actions.
> > >=20
> > > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> > > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > ---
> > >  include/net/act_api.h |   8 ++-
> > >  net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++---=
--
> > >  net/sched/cls_api.c   |   2 +-
> > >  3 files changed, 116 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/include/net/act_api.h b/include/net/act_api.h
> > > index 77ee0c657..f22be14bb 100644
> > > --- a/include/net/act_api.h
> > > +++ b/include/net/act_api.h
> > > @@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *p=
riv);
> > >=20
> > >  struct tc_action_ops {
> > >       struct list_head head;
> > > +     struct list_head p4_head;
> > >       char    kind[IFNAMSIZ];
> > >       enum tca_id  id; /* identifier should match kind */
> > >       unsigned int    net_id;
> > > @@ -199,10 +200,12 @@ int tcf_idr_check_alloc(struct tc_action_net *t=
n, u32 *index,
> > >  int tcf_idr_release(struct tc_action *a, bool bind);
> > >=20
> > >  int tcf_register_action(struct tc_action_ops *a, struct pernet_opera=
tions *ops);
> > > +int tcf_register_p4_action(struct net *net, struct tc_action_ops *ac=
t);
> > >  int tcf_unregister_action(struct tc_action_ops *a,
> > >                         struct pernet_operations *ops);
> > >  #define NET_ACT_ALIAS_PREFIX "net-act-"
> > >  #define MODULE_ALIAS_NET_ACT(kind)   MODULE_ALIAS(NET_ACT_ALIAS_PREF=
IX kind)
> > > +void tcf_unregister_p4_action(struct net *net, struct tc_action_ops =
*act);
> > >  int tcf_action_destroy(struct tc_action *actions[], int bind);
> > >  int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
> > >                   int nr_actions, struct tcf_result *res);
> > > @@ -210,8 +213,9 @@ int tcf_action_init(struct net *net, struct tcf_p=
roto *tp, struct nlattr *nla,
> > >                   struct nlattr *est,
> > >                   struct tc_action *actions[], int init_res[], size_t=
 *attr_size,
> > >                   u32 flags, u32 fl_flags, struct netlink_ext_ack *ex=
tack);
> > > -struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 fla=
gs,
> > > -                                      struct netlink_ext_ack *extack=
);
> > > +struct tc_action_ops *
> > > +tc_action_load_ops(struct net *net, struct nlattr *nla,
> > > +                u32 flags, struct netlink_ext_ack *extack);
> > >  struct tc_action *tcf_action_init_1(struct net *net, struct tcf_prot=
o *tp,
> > >                                   struct nlattr *nla, struct nlattr *=
est,
> > >                                   struct tc_action_ops *a_o, int *ini=
t_res,
> > > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > > index 9ee622fb1..23ef394f2 100644
> > > --- a/net/sched/act_api.c
> > > +++ b/net/sched/act_api.c
> > > @@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p=
)
> > >       kfree(cookie);
> > >  }
> > >=20
> > > +static unsigned int p4_act_net_id;
> > > +
> > > +struct tcf_p4_act_net {
> > > +     struct list_head act_base;
> > > +     rwlock_t act_mod_lock;
> >=20
> > Note that rwlock in networking code is discouraged, as they have to be
> > unfair, see commit 0daf07e527095e64ee8927ce297ab626643e9f51.
> >=20
> > In this specific case I think there should be no problems, as is
> > extremely hard/impossible to have serious contention on the write
> > side,. Also there is already an existing rwlock nearby, no not a
> > blocker but IMHO worthy to be noted.
> >=20
>=20
> Sure - we can replace it. What's the preference? Spinlock?

Plain spinlock will work. Using spinlock + RCU should be quite straight
forward and will provide faster lookup.

Cheers,

Paolo


