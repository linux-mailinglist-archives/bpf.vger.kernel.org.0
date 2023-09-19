Return-Path: <bpf+bounces-10416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4847A6F5E
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 01:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8726281AF7
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 23:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659938BBE;
	Tue, 19 Sep 2023 23:21:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6336B10
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 23:21:13 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662DC6
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:21:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c2ca01f27so38482617b3.2
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695165669; x=1695770469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvRY6GIRuNpH85uEp8BO43W0zUABYZOdiEC6/P/5XEg=;
        b=CkjGUfZM59vh3SBfJaadDcJC5lwmHjxRFDoFMYYNazR2RW5lu2wK+yM9PCfQrsDS/P
         LntTLdBf4A9dfIPY2dqVt7wdBCrkmAl4yzHRtusfyakjL8VBeLZMngvmrSdqRltFL+Yl
         NK1Y3onwv7kQVrcgf/taCo6dvEfYz/LoOhcM5MkRT8rZPV7LrQi1tVnR+l8mvPUCZSu6
         IkeTLDQ4tUEIbJ+i7v2Pk6vtE7G+Wrk42zrmjk538CIyGcxvAcedcjsZBRfFWDSw0a91
         gefhS+WNBLBM4MQJrV1Erk7JbAZlAacoot5J4NkCyk2uZPTC6DJ7d08AbUtk4fiSUKxD
         u8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695165669; x=1695770469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvRY6GIRuNpH85uEp8BO43W0zUABYZOdiEC6/P/5XEg=;
        b=SyyLYmVvVrIbezLSz5Mh+NytrCYZkQMmNM7FhkKy8MKaFl2wLnDLscg92dxYnKLlew
         pI8M/f0X4IsmoWX/A03uyi7YjGGEj1IljuPDRs7J3leXjFlIojdz3KbXNKnCrCfHvpyE
         4bm+QIk0hHpSU7WUrq34pFjQVxicQlac4/qiwPiaaI+SZOsf2Nh2ORYJdDnOAA2w75zQ
         dvH5F6GN+aAo6mY17wNozZIPTmSH3cFADNFsNddXTKQGUUt9KZbjJ4QlgUF9LFeYFf45
         c9W9MhQPBNQ9nfhbCBLRQ1qvy2U40B7plwnAsJzx+KpZ68YLyovVcW1HIMzIRNw/1UIm
         JwKQ==
X-Gm-Message-State: AOJu0YxJYtktoDAPUV/DEpB+NNXPi+zpdzVS+h3Y0859tdSlQC9iLFYX
	aFkKgEEIQAXhGEDaJM8rWLJ6yt32cUk4ur0bh8+T7w==
X-Google-Smtp-Source: AGHT+IHBx08fNle7EE6arVskw/j97O30UacFFRWRbyI7Ho37qGwqM9ifgU8GHQ5Wd/JUtRDAAPc4nqCfyWw+g1kaFlE=
X-Received: by 2002:a0d:dd13:0:b0:595:e1b:b978 with SMTP id
 g19-20020a0ddd13000000b005950e1bb978mr940317ywe.21.1695165669425; Tue, 19 Sep
 2023 16:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919145951.352548-1-victor@mojatatu.com> <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
In-Reply-To: <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 19 Sep 2023 19:20:57 -0400
Message-ID: <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return code
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	martin.lau@linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 19, 2023 at 6:15=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> [ +Martin, bpf ]
>
> On 9/19/23 4:59 PM, Victor Nogueira wrote:
> > Currently there is no way to distinguish between an error and a
> > classification verdict. This patch adds the verdict field as a part of
> > struct tcf_result. That way, tcf_classify can return a proper
> > error number when it fails, and we keep the classification result
> > information encapsulated in struct tcf_result.
> >
> > Also add values SKB_DROP_REASON_TC_EGRESS_ERROR and
> > SKB_DROP_REASON_TC_INGRESS_ERROR to enum skb_drop_reason.
> > With that we can distinguish between a drop from a processing error ver=
sus
> > a drop from classification.
> >
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >   include/net/dropreason-core.h |  6 +++++
> >   include/net/sch_generic.h     |  7 ++++++
> >   net/core/dev.c                | 42 ++++++++++++++++++++++++++--------=
-
> >   net/sched/cls_api.c           | 38 ++++++++++++++++++++-----------
> >   net/sched/sch_cake.c          | 32 +++++++++++++-------------
> >   net/sched/sch_drr.c           | 33 +++++++++++++--------------
> >   net/sched/sch_ets.c           |  6 +++--
> >   net/sched/sch_fq_codel.c      | 29 ++++++++++++------------
> >   net/sched/sch_fq_pie.c        | 28 +++++++++++------------
> >   net/sched/sch_hfsc.c          |  6 +++--
> >   net/sched/sch_htb.c           |  6 +++--
> >   net/sched/sch_multiq.c        |  6 +++--
> >   net/sched/sch_prio.c          |  7 ++++--
> >   net/sched/sch_qfq.c           | 34 +++++++++++++---------------
> >   net/sched/sch_sfb.c           | 29 ++++++++++++------------
> >   net/sched/sch_sfq.c           | 28 +++++++++++------------
> >   16 files changed, 195 insertions(+), 142 deletions(-)
> >
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index a587e83fc169..b1c069c8e7f2 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -80,6 +80,8 @@
> >       FN(IPV6_NDISC_BAD_OPTIONS)      \
> >       FN(IPV6_NDISC_NS_OTHERHOST)     \
> >       FN(QUEUE_PURGE)                 \
> > +     FN(TC_EGRESS_ERROR)             \
> > +     FN(TC_INGRESS_ERROR)            \
> >       FNe(MAX)
> >
> >   /**
> > @@ -345,6 +347,10 @@ enum skb_drop_reason {
> >       SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
> >       /** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
> >       SKB_DROP_REASON_QUEUE_PURGE,
> > +     /** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOOK d=
ue to error */
> > +     SKB_DROP_REASON_TC_EGRESS_ERROR,
> > +     /** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress HOOK=
 due to error */
> > +     SKB_DROP_REASON_TC_INGRESS_ERROR,
> >       /**
> >        * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> >        * shouldn't be used as a real 'reason' - only for tracing code g=
en
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index f232512505f8..9a3f71d2545e 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -326,6 +326,7 @@ struct Qdisc_ops {
> >
> >
> >   struct tcf_result {
> > +     u32 verdict;
> >       union {
> >               struct {
> >                       unsigned long   class;
> > @@ -336,6 +337,12 @@ struct tcf_result {
> >       };
> >   };
> >
> > +static inline void tcf_result_set_verdict(struct tcf_result *res,
> > +                                       const u32 verdict)
> > +{
> > +     res->verdict =3D verdict;
> > +}
> > +
> >   struct tcf_chain;
> >
> >   struct tcf_proto_ops {
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index ccff2b6ef958..1450f4741d9b 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3910,31 +3910,39 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> >   #endif /* CONFIG_NET_EGRESS */
> >
> >   #ifdef CONFIG_NET_XGRESS
> > -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> > +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> > +               struct tcf_result *res)
> >   {
> > -     int ret =3D TC_ACT_UNSPEC;
> > +     int ret =3D 0;
> >   #ifdef CONFIG_NET_CLS_ACT
> >       struct mini_Qdisc *miniq =3D rcu_dereference_bh(entry->miniq);
> > -     struct tcf_result res;
> >
> > -     if (!miniq)
> > +     if (!miniq) {
> > +             tcf_result_set_verdict(res, TC_ACT_UNSPEC);
> >               return ret;
> > +     }
> >
> >       tc_skb_cb(skb)->mru =3D 0;
> >       tc_skb_cb(skb)->post_ct =3D false;
> >
> >       mini_qdisc_bstats_cpu_update(miniq, skb);
> > -     ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &res,=
 false);
> > +     ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, res, =
false);
> > +     if (ret < 0) {
> > +             mini_qdisc_qstats_cpu_drop(miniq);
> > +             return ret;
> > +     }
> >       /* Only tcf related quirks below. */
> > -     switch (ret) {
> > +     switch (res->verdict) {
> >       case TC_ACT_SHOT:
> >               mini_qdisc_qstats_cpu_drop(miniq);
> >               break;
> >       case TC_ACT_OK:
> >       case TC_ACT_RECLASSIFY:
> > -             skb->tc_index =3D TC_H_MIN(res.classid);
> > +             skb->tc_index =3D TC_H_MIN(res->classid);
> >               break;
> >       }
> > +#else
> > +     tcf_result_set_verdict(res, TC_ACT_UNSPEC);
> >   #endif /* CONFIG_NET_CLS_ACT */
> >       return ret;
> >   }
> > @@ -3977,6 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct pa=
cket_type **pt_prev, int *ret,
> >                  struct net_device *orig_dev, bool *another)
> >   {
> >       struct bpf_mprog_entry *entry =3D rcu_dereference_bh(skb->dev->tc=
x_ingress);
> > +     struct tcf_result res =3D {0};
> >       int sch_ret;
> >
> >       if (!entry)
> > @@ -3994,9 +4003,14 @@ sch_handle_ingress(struct sk_buff *skb, struct p=
acket_type **pt_prev, int *ret,
> >               if (sch_ret !=3D TC_ACT_UNSPEC)
> >                       goto ingress_verdict;
> >       }
> > -     sch_ret =3D tc_run(tcx_entry(entry), skb);
> > +     sch_ret =3D tc_run(tcx_entry(entry), skb, &res);
> > +     if (sch_ret < 0) {
> > +             kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR);
> > +             *ret =3D NET_RX_DROP;
> > +             return NULL;
> > +     }
> >   ingress_verdict:
> > -     switch (sch_ret) {
> > +     switch (res.verdict) {
>
> This breaks tcx, please move all this logic into tc_run(). No changes to =
sch_handle_ingress()
> or sch_handle_egress should be necessary, you can then just remap the ret=
urn code to TC_ACT_SHOT
> in such case.
>

I think it is valuable to have a good reason code like
SKB_DROP_REASON_TC_XXX_ERROR to disambiguate between errors vs
verdicts in the case of tc_run() variant.
For tcx_run(), does this look ok (for consistency)?:

if (static_branch_unlikely(&tcx_needed_key)) {
                sch_ret =3D tcx_run(entry, skb, true);
                if (sch_ret !=3D TC_ACT_UNSPEC) {
                        res.verdict =3D sch_ret;
                        goto ingress_verdict;
                }
}

cheers,
jamal

> >       case TC_ACT_REDIRECT:
> >               /* skb_mac_header check was done by BPF, so we can safely
> >                * push the L2 header back before redirecting to another
> > @@ -4032,6 +4046,7 @@ static __always_inline struct sk_buff *
> >   sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *d=
ev)
> >   {
> >       struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egr=
ess);
> > +     struct tcf_result res =3D {0};
> >       int sch_ret;
> >
> >       if (!entry)
> > @@ -4045,9 +4060,14 @@ sch_handle_egress(struct sk_buff *skb, int *ret,=
 struct net_device *dev)
> >               if (sch_ret !=3D TC_ACT_UNSPEC)
> >                       goto egress_verdict;
> >       }
> > -     sch_ret =3D tc_run(tcx_entry(entry), skb);
> > +     sch_ret =3D tc_run(tcx_entry(entry), skb, &res);
> > +     if (sch_ret < 0) {
> > +             kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS_ERROR);
> > +             *ret =3D NET_XMIT_DROP;
> > +             return NULL;
> > +     }
> >   egress_verdict:
> > -     switch (sch_ret) {
> > +     switch (res.verdict) {
> >       case TC_ACT_REDIRECT:
> >               /* No need to push/pop skb's mac_header here on egress! *=
/
> >               skb_do_redirect(skb);

