Return-Path: <bpf+bounces-10809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A37AE203
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BF3CA281695
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0CB2628A;
	Mon, 25 Sep 2023 23:01:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16152250FA
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:01:39 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C5F136
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:01:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d776e1f181bso8828585276.3
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695682896; x=1696287696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOdsZ0Wic7mT4VdLd7j0Bp6e7zYxxdZKyOdVZzzpji0=;
        b=NoAfEQPipMxTYESLbGwzM6eriCw6UM81Mqxu2dvIBtvXiYGe2rypOTlJHais1a86th
         cNCN/xEu/Gp8UQ9R4KgzJQELxZUx49OFdQDMGgz5LCrogjBeX90SVfI2RTGihX7Uy6Hf
         Gi7oGg0Ledn0wtBZYc2kV2L9vncty968m0kBqEuvMHG9V7mT3szszbhX1VTbq62MiJjQ
         okBwE5uqi7MmuUQ9P4W3SGR+4nrLippZ8E/J4xjLG+JuNx+0A7v5jZeVgBljNdIfRebT
         CsumZBEF/P+rKcMRBU7u+LKN+YhERZXtd3WKzVbgwPhwVq4MXL3MWvB+cfcz7tGEYGXM
         6Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695682896; x=1696287696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOdsZ0Wic7mT4VdLd7j0Bp6e7zYxxdZKyOdVZzzpji0=;
        b=R6jRTAuMAn/v3O9yQt268B2EGVieAtUw73jhiwcKhhBlePpgfez2LoYeGj1yHNY25x
         2Q87LYghlDICAO9MZhbf67CNiUTVdxEmyFuusJLbBb2BXXxC8zRpb/faDgmWKWFcR8oR
         lAEhAnTqkjdFr71Myoz8VXmcD29/r0Fgqfc17OHG/+uiLE0l/f622Avf9n+G1KWh8H6Q
         m5HuKJGTyUwU4DZEG2+DQ3oZGfU0IvqKABTAlS99vRHqvIzolWciEDlly3Sl5EdqOVVV
         4mBebJLY30QgEgbf/9xvAACgoNCP3H6yco7QBwo4fzth8ZL6+JMzcJCWbJC9XWJAKSg0
         mCuw==
X-Gm-Message-State: AOJu0YyeoH0YsQHof1TRxePCIJFW3+K80V6CEAtBCgmJwvgHU/74efhP
	3VcBuKiGN58q/7zDcHd0kmor7ZP+HwbPIFHIFt/VSKyIwbyf6fmA2/o=
X-Google-Smtp-Source: AGHT+IF9hvLvhL8A8U9SxTiYzp4Mcuv7rQ71NkXBstgCLzw/3auHFzsHz+VctWm5s+v81epA5krhCSnydSAjp9QY398=
X-Received: by 2002:a81:4322:0:b0:59f:64b4:9b15 with SMTP id
 q34-20020a814322000000b0059f64b49b15mr5807005ywa.41.1695682896453; Mon, 25
 Sep 2023 16:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230919145951.352548-1-victor@mojatatu.com> <beb5e6f3-e2a1-637d-e06d-247b36474e95@iogearbox.net>
 <CAM0EoMncgehpwCOxaUUKhOP7V0DyJtbDP9Q5aUkMG2h5dmfQJA@mail.gmail.com> <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
In-Reply-To: <97f318a1-072d-80c2-7de7-6d0d71ca0b10@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 25 Sep 2023 19:01:24 -0400
Message-ID: <CAM0EoMnPVxYA=7jn6AU7D3cJJbY5eeMLOxCrj4UJcFr=pCZ+Aw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net/sched: Disambiguate verdict from return code
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	paulb@nvidia.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	martin.lau@linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 4:12=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 9/20/23 1:20 AM, Jamal Hadi Salim wrote:
> > On Tue, Sep 19, 2023 at 6:15=E2=80=AFPM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> [ +Martin, bpf ]
> >>
> >> On 9/19/23 4:59 PM, Victor Nogueira wrote:
> >>> Currently there is no way to distinguish between an error and a
> >>> classification verdict. This patch adds the verdict field as a part o=
f
> >>> struct tcf_result. That way, tcf_classify can return a proper
> >>> error number when it fails, and we keep the classification result
> >>> information encapsulated in struct tcf_result.
> >>>
> >>> Also add values SKB_DROP_REASON_TC_EGRESS_ERROR and
> >>> SKB_DROP_REASON_TC_INGRESS_ERROR to enum skb_drop_reason.
> >>> With that we can distinguish between a drop from a processing error v=
ersus
> >>> a drop from classification.
> >>>
> >>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> >>> ---
> >>>    include/net/dropreason-core.h |  6 +++++
> >>>    include/net/sch_generic.h     |  7 ++++++
> >>>    net/core/dev.c                | 42 ++++++++++++++++++++++++++-----=
----
> >>>    net/sched/cls_api.c           | 38 ++++++++++++++++++++-----------
> >>>    net/sched/sch_cake.c          | 32 +++++++++++++-------------
> >>>    net/sched/sch_drr.c           | 33 +++++++++++++--------------
> >>>    net/sched/sch_ets.c           |  6 +++--
> >>>    net/sched/sch_fq_codel.c      | 29 ++++++++++++------------
> >>>    net/sched/sch_fq_pie.c        | 28 +++++++++++------------
> >>>    net/sched/sch_hfsc.c          |  6 +++--
> >>>    net/sched/sch_htb.c           |  6 +++--
> >>>    net/sched/sch_multiq.c        |  6 +++--
> >>>    net/sched/sch_prio.c          |  7 ++++--
> >>>    net/sched/sch_qfq.c           | 34 +++++++++++++---------------
> >>>    net/sched/sch_sfb.c           | 29 ++++++++++++------------
> >>>    net/sched/sch_sfq.c           | 28 +++++++++++------------
> >>>    16 files changed, 195 insertions(+), 142 deletions(-)
> >>>
> >>> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-c=
ore.h
> >>> index a587e83fc169..b1c069c8e7f2 100644
> >>> --- a/include/net/dropreason-core.h
> >>> +++ b/include/net/dropreason-core.h
> >>> @@ -80,6 +80,8 @@
> >>>        FN(IPV6_NDISC_BAD_OPTIONS)      \
> >>>        FN(IPV6_NDISC_NS_OTHERHOST)     \
> >>>        FN(QUEUE_PURGE)                 \
> >>> +     FN(TC_EGRESS_ERROR)             \
> >>> +     FN(TC_INGRESS_ERROR)            \
> >>>        FNe(MAX)
> >>>
> >>>    /**
> >>> @@ -345,6 +347,10 @@ enum skb_drop_reason {
> >>>        SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
> >>>        /** @SKB_DROP_REASON_QUEUE_PURGE: bulk free. */
> >>>        SKB_DROP_REASON_QUEUE_PURGE,
> >>> +     /** @SKB_DROP_REASON_TC_EGRESS_ERROR: dropped in TC egress HOOK=
 due to error */
> >>> +     SKB_DROP_REASON_TC_EGRESS_ERROR,
> >>> +     /** @SKB_DROP_REASON_TC_INGRESS_ERROR: dropped in TC ingress HO=
OK due to error */
> >>> +     SKB_DROP_REASON_TC_INGRESS_ERROR,
> >>>        /**
> >>>         * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, whi=
ch
> >>>         * shouldn't be used as a real 'reason' - only for tracing cod=
e gen
> >>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> >>> index f232512505f8..9a3f71d2545e 100644
> >>> --- a/include/net/sch_generic.h
> >>> +++ b/include/net/sch_generic.h
> >>> @@ -326,6 +326,7 @@ struct Qdisc_ops {
> >>>
> >>>
> >>>    struct tcf_result {
> >>> +     u32 verdict;
> >>>        union {
> >>>                struct {
> >>>                        unsigned long   class;
> >>> @@ -336,6 +337,12 @@ struct tcf_result {
> >>>        };
> >>>    };
> >>>
> >>> +static inline void tcf_result_set_verdict(struct tcf_result *res,
> >>> +                                       const u32 verdict)
> >>> +{
> >>> +     res->verdict =3D verdict;
> >>> +}
> >>> +
> >>>    struct tcf_chain;
> >>>
> >>>    struct tcf_proto_ops {
> >>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>> index ccff2b6ef958..1450f4741d9b 100644
> >>> --- a/net/core/dev.c
> >>> +++ b/net/core/dev.c
> >>> @@ -3910,31 +3910,39 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> >>>    #endif /* CONFIG_NET_EGRESS */
> >>>
> >>>    #ifdef CONFIG_NET_XGRESS
> >>> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> >>> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> >>> +               struct tcf_result *res)
> >>>    {
> >>> -     int ret =3D TC_ACT_UNSPEC;
> >>> +     int ret =3D 0;
> >>>    #ifdef CONFIG_NET_CLS_ACT
> >>>        struct mini_Qdisc *miniq =3D rcu_dereference_bh(entry->miniq);
> >>> -     struct tcf_result res;
> >>>
> >>> -     if (!miniq)
> >>> +     if (!miniq) {
> >>> +             tcf_result_set_verdict(res, TC_ACT_UNSPEC);
> >>>                return ret;
> >>> +     }
> >>>
> >>>        tc_skb_cb(skb)->mru =3D 0;
> >>>        tc_skb_cb(skb)->post_ct =3D false;
> >>>
> >>>        mini_qdisc_bstats_cpu_update(miniq, skb);
> >>> -     ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &re=
s, false);
> >>> +     ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, res=
, false);
> >>> +     if (ret < 0) {
> >>> +             mini_qdisc_qstats_cpu_drop(miniq);
> >>> +             return ret;
> >>> +     }
> >>>        /* Only tcf related quirks below. */
> >>> -     switch (ret) {
> >>> +     switch (res->verdict) {
> >>>        case TC_ACT_SHOT:
> >>>                mini_qdisc_qstats_cpu_drop(miniq);
> >>>                break;
> >>>        case TC_ACT_OK:
> >>>        case TC_ACT_RECLASSIFY:
> >>> -             skb->tc_index =3D TC_H_MIN(res.classid);
> >>> +             skb->tc_index =3D TC_H_MIN(res->classid);
> >>>                break;
> >>>        }
> >>> +#else
> >>> +     tcf_result_set_verdict(res, TC_ACT_UNSPEC);
> >>>    #endif /* CONFIG_NET_CLS_ACT */
> >>>        return ret;
> >>>    }
> >>> @@ -3977,6 +3985,7 @@ sch_handle_ingress(struct sk_buff *skb, struct =
packet_type **pt_prev, int *ret,
> >>>                   struct net_device *orig_dev, bool *another)
> >>>    {
> >>>        struct bpf_mprog_entry *entry =3D rcu_dereference_bh(skb->dev-=
>tcx_ingress);
> >>> +     struct tcf_result res =3D {0};
> >>>        int sch_ret;
> >>>
> >>>        if (!entry)
> >>> @@ -3994,9 +4003,14 @@ sch_handle_ingress(struct sk_buff *skb, struct=
 packet_type **pt_prev, int *ret,
> >>>                if (sch_ret !=3D TC_ACT_UNSPEC)
> >>>                        goto ingress_verdict;
> >>>        }
> >>> -     sch_ret =3D tc_run(tcx_entry(entry), skb);
> >>> +     sch_ret =3D tc_run(tcx_entry(entry), skb, &res);
> >>> +     if (sch_ret < 0) {
> >>> +             kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS_ERROR)=
;
> >>> +             *ret =3D NET_RX_DROP;
> >>> +             return NULL;
> >>> +     }
> >>>    ingress_verdict:
> >>> -     switch (sch_ret) {
> >>> +     switch (res.verdict) {
> >>
> >> This breaks tcx, please move all this logic into tc_run(). No changes =
to sch_handle_ingress()
> >> or sch_handle_egress should be necessary, you can then just remap the =
return code to TC_ACT_SHOT
> >> in such case.
> >
> > I think it is valuable to have a good reason code like
> > SKB_DROP_REASON_TC_XXX_ERROR to disambiguate between errors vs
> > verdicts in the case of tc_run() variant.
> > For tcx_run(), does this look ok (for consistency)?:
> >
> > if (static_branch_unlikely(&tcx_needed_key)) {
> >                  sch_ret =3D tcx_run(entry, skb, true);
> >                  if (sch_ret !=3D TC_ACT_UNSPEC) {
> >                          res.verdict =3D sch_ret;
> >                          goto ingress_verdict;
> >                  }
> > }
>
> In the above case we don't have 'internal' errors which you want to trace=
, so I would
> also love to avoid the cost of zeroing struct tcf_result res which should=
 be 3x 8b for
> every packet.

We can move the zeroing inside tc_run() but we declare it in the same
spot as we do right now. You will still need to set res.verdict as
above.
Would that work for you?

> I was more thinking like something below could be a better choice. I pres=
ume your main
> goal is to trace where these errors originated in the first place, so it =
might even be
> useful to capture the actual return code as well.

The main motivation is a few syzkaller bugs which resulted in not
disambiguating between errors being returned and sometimes
TC_ACT_SHOT.

> Then you can use perf script, bpf and whatnot to gather further insights =
into what
> happened while being less invasive and avoiding the need to extend struct=
 tcf_result.
>

We could use trace instead - the reason we have the skb reason is
being used in the other spots (does this trace require ebpf to be
usable?).

> This would be quite similar to trace_xdp_exception() as well, and I think=
 you can guarantee
> that in fast path all errors are < TC_ACT_UNSPEC anyway.
>

I am not sure i followed. 0 means success, result codes are returned in res=
 now.

cheers,
jamal

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 85df22f05c38..4089d195144d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3925,6 +3925,10 @@ static int tc_run(struct tcx_entry *entry, struct =
sk_buff *skb)
>
>         mini_qdisc_bstats_cpu_update(miniq, skb);
>         ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &res,=
 false);
> +       if (unlikely(ret < TC_ACT_UNSPEC)) {
> +               trace_tc_exception(skb->dev, skb->tc_at_ingress, ret);
> +               ret =3D TC_ACT_SHOT;
> +       }
>         /* Only tcf related quirks below. */
>         switch (ret) {
>         case TC_ACT_SHOT:
>
> Best,
> Daniel

