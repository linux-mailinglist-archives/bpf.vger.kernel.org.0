Return-Path: <bpf+bounces-11720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C433F7BE210
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790BF281784
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E734CC7;
	Mon,  9 Oct 2023 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dPzqCyNE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB4347C2
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 14:03:55 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB8594
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 07:03:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59c215f2f4aso55596957b3.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696860233; x=1697465033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdD5rNVHdNz46gdQ2ft/0vQLpaR1q5PhHgZq+QkooqU=;
        b=dPzqCyNEW+vv9xM9n3uLJk58E9jzdKDSs10h3ITjBBPx8fkKTgdIUucy3ETtsvMrqi
         jQVP2+8UUw8mNOQJ6YRBqMFGyAng7wVP0PCV6H/d7XeJBZqNBXJHE9ZrmxnOuk+uid5w
         vu7ByMBjwDBcHnIPHgkxiZGSg6/WFbZzfQvLRCJp3RO3RVCJO/2njBheoA8pQQJHF80X
         e1eDuExNoG9GbWHmjJIk3lmlyURgAISAJ/mdJyEpgGaKM9E9/Y5g2YxmN1Wmqnm+bRSD
         4227x3Rsb90PbJ7uZnz3xj4OCmfWjijUx/DWQdZ3RWUHDhlf216JT+6xibWy5GY3Qr5l
         f0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696860233; x=1697465033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdD5rNVHdNz46gdQ2ft/0vQLpaR1q5PhHgZq+QkooqU=;
        b=WfF1h+/rDSovnY+0NuAusG0ul1dtdIvebycrl6EFY+nBRU9uer7W8md9WMJoR76lUN
         +yoAEqoZ0SR2Zubd6Kgx+cEUSlsjh52tutQFdEnBDlV2KX0AP+IeK4eAsGuyXS5yCk8q
         LCurDzaI8URw7Rk/LA5vsJOCuBGU/YI79Bk/Bns0BdiPCiaKFCp9twF7JuiQT9f+PPwE
         x0ov7Ce6vtFZLiqhgk4zJvctUJ5wc1Z8zHBnKD0+2Oy9+VJdC9Loj8W9KJcLXs7TLTcH
         BLTJGIUsLo2uPZrmwr9DI52/x7cFa4b0oc1LYl7AarY8KLK27+HHYnQ7jCojyBy1GLxo
         nNtQ==
X-Gm-Message-State: AOJu0YyNp+hq+CZ22OnQM6OCIk69+KITutUjTdWZsIAngtMh11ZZgvg/
	PC4SlbZKT5mOtQHDnDxw7gmCd5aXw6N+a7Oo1KuNIA==
X-Google-Smtp-Source: AGHT+IEGhWYcN+6mO0MVBvWirYs7kkBs95dWAC1592thLBxpK6fGFY/rc+nvY00OwULQiUItEACPfzB5fmL7HWuTPtk=
X-Received: by 2002:a25:2395:0:b0:d7f:f5e:a2bd with SMTP id
 j143-20020a252395000000b00d7f0f5ea2bdmr14177171ybj.10.1696860233188; Mon, 09
 Oct 2023 07:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009092655.22025-1-daniel@iogearbox.net>
In-Reply-To: <20231009092655.22025-1-daniel@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Oct 2023 10:03:42 -0400
Message-ID: <CAM0EoMn9tGQ=wiwbXBQAym-D+_ABZer4NpBj3nNamFUwqJhFHw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:27=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> Currently, the kfree_skb_reason() in sch_handle_{ingress,egress}() can on=
ly
> express a basic SKB_DROP_REASON_TC_INGRESS or SKB_DROP_REASON_TC_EGRESS r=
eason.
>
> Victor kicked-off an initial proposal to make this more flexible by disam=
biguating
> verdict from return code by moving the verdict into struct tcf_result and
> letting tcf_classify() return a negative error. If hit, then two new drop
> reasons were added in the proposal, that is SKB_DROP_REASON_TC_INGRESS_ER=
ROR
> as well as SKB_DROP_REASON_TC_EGRESS_ERROR. Further analysis of the actua=
l
> error codes would have required to attach to tcf_classify via kprobe/kret=
probe
> to more deeply debug skb and the returned error.
>
> In order to make the kfree_skb_reason() in sch_handle_{ingress,egress}() =
more
> extensible, it can be addressed in a more straight forward way, that is: =
Instead
> of placing the verdict into struct tcf_result, we can just put the drop r=
eason
> in there, which does not require changes throughout various classful sche=
dulers
> given the existing verdict logic can stay as is.
>
> Then, SKB_DROP_REASON_TC_ERROR{,_*} can be added to the enum skb_drop_rea=
son
> to disambiguate between an error or an intentional drop. New drop reason =
error
> codes can be added successively to the tc code base.
>
> For internal error locations which have not yet been annotated with a
> SKB_DROP_REASON_TC_ERROR{,_*}, the fallback is SKB_DROP_REASON_TC_INGRESS=
 and
> SKB_DROP_REASON_TC_EGRESS, respectively. Generic errors could be marked w=
ith a
> SKB_DROP_REASON_TC_ERROR code until they are converted to more specific o=
nes
> if it is found that they would be useful for troubleshooting.
>
> While drop reasons have infrastructure for subsystem specific error codes=
 which
> are currently used by mac80211 and ovs, Jakub mentioned that it is prefer=
red
> for tc to use the enum skb_drop_reason core codes given it is a better fi=
t and
> currently the tooling support is better, too.


Daniel - one of us will get to this sometime this week (kind of loaded
on some other stuff atm).

cheers,
jamal

> With regards to the latter:
>
>   [...] I think Alastair (bpftrace) is working on auto-prettifying enums =
when
>   bpftrace outputs maps. So we can do something like:
>
>   $ bpftrace -e 'tracepoint:skb:kfree_skb { @[args->reason] =3D count(); =
}'
>   Attaching 1 probe...
>   ^C
>
>   @[SKB_DROP_REASON_TC_INGRESS]: 2
>   @[SKB_CONSUMED]: 34
>
>   ^^^^^^^^^^^^ names!!
>
>   Auto-magically. [...]
>
> Add a small helper tcf_set_drop_reason() which can be used to set the dro=
p reason
> into the tcf_result.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Victor Nogueira <victor@mojatatu.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20231006063233.74345d36@kernel.org
> ---
>  v1 -> v2:
>    - Renamed tc_set_drop_reason -> tcf_set_drop_reason
>    - Moved tcf_set_drop_reason into pkt_cls.h (Cong)
>
>  include/net/pkt_cls.h     |  6 ++++++
>  include/net/sch_generic.h |  3 +--
>  net/core/dev.c            | 15 ++++++++++-----
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index f308e8268651..a76c9171db0e 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -154,6 +154,12 @@ __cls_set_class(unsigned long *clp, unsigned long cl=
)
>         return xchg(clp, cl);
>  }
>
> +static inline void tcf_set_drop_reason(struct tcf_result *res,
> +                                      enum skb_drop_reason reason)
> +{
> +       res->drop_reason =3D reason;
> +}
> +
>  static inline void
>  __tcf_bind_filter(struct Qdisc *q, struct tcf_result *r, unsigned long b=
ase)
>  {
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index c7318c73cfd6..dcb9160e6467 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -324,7 +324,6 @@ struct Qdisc_ops {
>         struct module           *owner;
>  };
>
> -
>  struct tcf_result {
>         union {
>                 struct {
> @@ -332,8 +331,8 @@ struct tcf_result {
>                         u32             classid;
>                 };
>                 const struct tcf_proto *goto_tp;
> -
>         };
> +       enum skb_drop_reason            drop_reason;
>  };
>
>  struct tcf_chain;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 606a366cc209..664426285fa3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
>  #endif /* CONFIG_NET_EGRESS */
>
>  #ifdef CONFIG_NET_XGRESS
> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> +                 enum skb_drop_reason *drop_reason)
>  {
>         int ret =3D TC_ACT_UNSPEC;
>  #ifdef CONFIG_NET_CLS_ACT
> @@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entry, struct=
 sk_buff *skb)
>
>         tc_skb_cb(skb)->mru =3D 0;
>         tc_skb_cb(skb)->post_ct =3D false;
> +       res.drop_reason =3D *drop_reason;
>
>         mini_qdisc_bstats_cpu_update(miniq, skb);
>         ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &res,=
 false);
>         /* Only tcf related quirks below. */
>         switch (ret) {
>         case TC_ACT_SHOT:
> +               *drop_reason =3D res.drop_reason;
>                 mini_qdisc_qstats_cpu_drop(miniq);
>                 break;
>         case TC_ACT_OK:
> @@ -3977,6 +3980,7 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
>                    struct net_device *orig_dev, bool *another)
>  {
>         struct bpf_mprog_entry *entry =3D rcu_dereference_bh(skb->dev->tc=
x_ingress);
> +       enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_INGRESS;
>         int sch_ret;
>
>         if (!entry)
> @@ -3994,7 +3998,7 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
>                 if (sch_ret !=3D TC_ACT_UNSPEC)
>                         goto ingress_verdict;
>         }
> -       sch_ret =3D tc_run(tcx_entry(entry), skb);
> +       sch_ret =3D tc_run(tcx_entry(entry), skb, &drop_reason);
>  ingress_verdict:
>         switch (sch_ret) {
>         case TC_ACT_REDIRECT:
> @@ -4011,7 +4015,7 @@ sch_handle_ingress(struct sk_buff *skb, struct pack=
et_type **pt_prev, int *ret,
>                 *ret =3D NET_RX_SUCCESS;
>                 return NULL;
>         case TC_ACT_SHOT:
> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
> +               kfree_skb_reason(skb, drop_reason);
>                 *ret =3D NET_RX_DROP;
>                 return NULL;
>         /* used by tc_run */
> @@ -4032,6 +4036,7 @@ static __always_inline struct sk_buff *
>  sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
>  {
>         struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egr=
ess);
> +       enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_EGRESS;
>         int sch_ret;
>
>         if (!entry)
> @@ -4045,7 +4050,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, st=
ruct net_device *dev)
>                 if (sch_ret !=3D TC_ACT_UNSPEC)
>                         goto egress_verdict;
>         }
> -       sch_ret =3D tc_run(tcx_entry(entry), skb);
> +       sch_ret =3D tc_run(tcx_entry(entry), skb, &drop_reason);
>  egress_verdict:
>         switch (sch_ret) {
>         case TC_ACT_REDIRECT:
> @@ -4054,7 +4059,7 @@ sch_handle_egress(struct sk_buff *skb, int *ret, st=
ruct net_device *dev)
>                 *ret =3D NET_XMIT_SUCCESS;
>                 return NULL;
>         case TC_ACT_SHOT:
> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
> +               kfree_skb_reason(skb, drop_reason);
>                 *ret =3D NET_XMIT_DROP;
>                 return NULL;
>         /* used by tc_run */
> --
> 2.34.1
>

