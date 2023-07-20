Return-Path: <bpf+bounces-5407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A275A449
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 04:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA1E281BD4
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B009EA3B;
	Thu, 20 Jul 2023 02:14:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A564C;
	Thu, 20 Jul 2023 02:14:21 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DBE1FFE;
	Wed, 19 Jul 2023 19:14:14 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-635e3ceb152so1958806d6.2;
        Wed, 19 Jul 2023 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689819253; x=1690424053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxrGqzJ3M91G6h5DoWB1FQ5sniPLuowznLPAphnwY0M=;
        b=QnrYYQ+HUqXmsdAq3tzBe1Preba+qSrsIodi9oNytvnZnUhDv5QFueDwWUL3XezpI9
         gQKUgGWJdISDD4cBPmY84+fELf6OG6r1Thutq8CuuSW/wmvXoJ5hQcNxhzERFu6B1QCR
         3EfoRzIUK5dzEhzuuWg7zxgKSxPKHzr17iNsebIfP43k4oqjb+YD2SSrNya+90q+SDlW
         Ks40FqFbfr1vEgY2Z4cQlWMBeepRCyiLn6k+MBvtyF8nTpZaM3eKHFVMqy78B6rCd6YF
         Z3Cw2PPNxekd82i12V4AY3CSLVBRwi/TlpHAQ/5MeeuD8MUF+0lj3d2KJX+M6zC915Dt
         8+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689819253; x=1690424053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxrGqzJ3M91G6h5DoWB1FQ5sniPLuowznLPAphnwY0M=;
        b=Le3Fuz3UnYl0MXOC2wK/trewV/GOBM5spqXwlTsBo4SLCFM/tg8BiiqlW4XkUkBzR6
         ORMX977Tn2t/+JzlUC/jYvLfuZfMh4pK1cdVWPPwFP5SrY1fGiUlINV9EYnb36GU9aYd
         PqxJQp3QLVMeOdPoQdqWEeIE/1gJnZo7IEUTwHOJnR/uEACURn1XTcQahNomqQW/UriN
         B2ak0+khgfxQh2DdcBXvTDqlIcu8GOw7LuKIIlOkrZPhWCzA8nbxJvt6RCPjzyajyDVk
         jxvMmqxbWRRZYKy8MdUVSc5T/7kyYYrZf4PKsvneEr/JMnQ/jZPA1+yvGC6DvxLP5mxR
         D0ag==
X-Gm-Message-State: ABy/qLbFVw+9f3+IXF3R4/WiLQq+TbryIRIhvoCc5R/rerOOJ9O3Vjg6
	yt0xH8L7ScYM96xCLqw3B0nuTHs5OgSWz8RxgxY=
X-Google-Smtp-Source: APBJJlFcd8jU89GrWMB6dYnuJB3edIAh3Ukwzez9hhY+EC7BLhlyy7VXvE8hW4r5PJQQGBieuMS0nbtArzBeua9sNd8=
X-Received: by 2002:a0c:ca0b:0:b0:63c:6bcc:5a2b with SMTP id
 c11-20020a0cca0b000000b0063c6bcc5a2bmr4202177qvk.46.1689819252972; Wed, 19
 Jul 2023 19:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719140858.13224-1-daniel@iogearbox.net> <20230719140858.13224-3-daniel@iogearbox.net>
In-Reply-To: <20230719140858.13224-3-daniel@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 20 Jul 2023 10:13:35 +0800
Message-ID: <CALOAHbAWXNRW4oz+AfUE7h5KJ_6DkRyYn5RWWSvjC5=oNm87QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, 
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:11=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> This work refactors and adds a lightweight extension ("tcx") to the tc BP=
F
> ingress and egress data path side for allowing BPF program management bas=
ed
> on fds via bpf() syscall through the newly added generic multi-prog API.
> The main goal behind this work which we also presented at LPC [0] last ye=
ar
> and a recent update at LSF/MM/BPF this year [3] is to support long-awaite=
d
> BPF link functionality for tc BPF programs, which allows for a model of s=
afe
> ownership and program detachment.
>
> Given the rise in tc BPF users in cloud native environments, this becomes
> necessary to avoid hard to debug incidents either through stale leftover
> programs or 3rd party applications accidentally stepping on each others t=
oes.
> As a recap, a BPF link represents the attachment of a BPF program to a BP=
F
> hook point. The BPF link holds a single reference to keep BPF program ali=
ve.
> Moreover, hook points do not reference a BPF link, only the application's
> fd or pinning does. A BPF link holds meta-data specific to attachment and
> implements operations for link creation, (atomic) BPF program update,
> detachment and introspection. The motivation for BPF links for tc BPF pro=
grams
> is multi-fold, for example:
>
>   - From Meta: "It's especially important for applications that are deplo=
yed
>     fleet-wide and that don't "control" hosts they are deployed to. If su=
ch
>     application crashes and no one notices and does anything about that, =
BPF
>     program will keep running draining resources or even just, say, dropp=
ing
>     packets. We at FB had outages due to such permanent BPF attachment
>     semantics. With fd-based BPF link we are getting a framework, which a=
llows
>     safe, auto-detachable behavior by default, unless application explici=
tly
>     opts in by pinning the BPF link." [1]
>
>   - From Cilium-side the tc BPF programs we attach to host-facing veth de=
vices
>     and phys devices build the core datapath for Kubernetes Pods, and the=
y
>     implement forwarding, load-balancing, policy, EDT-management, etc, wi=
thin
>     BPF. Currently there is no concept of 'safe' ownership, e.g. we've re=
cently
>     experienced hard-to-debug issues in a user's staging environment wher=
e
>     another Kubernetes application using tc BPF attached to the same prio=
/handle
>     of cls_bpf, accidentally wiping all Cilium-based BPF programs from un=
derneath
>     it. The goal is to establish a clear/safe ownership model via links w=
hich
>     cannot accidentally be overridden. [0,2]
>
> BPF links for tc can co-exist with non-link attachments, and the semantic=
s are
> in line also with XDP links: BPF links cannot replace other BPF links, BP=
F
> links cannot replace non-BPF links, non-BPF links cannot replace BPF link=
s and
> lastly only non-BPF links can replace non-BPF links. In case of Cilium, t=
his
> would solve mentioned issue of safe ownership model as 3rd party applicat=
ions
> would not be able to accidentally wipe Cilium programs, even if they are =
not
> BPF link aware.
>
> Earlier attempts [4] have tried to integrate BPF links into core tc machi=
nery
> to solve cls_bpf, which has been intrusive to the generic tc kernel API w=
ith
> extensions only specific to cls_bpf and suboptimal/complex since cls_bpf =
could
> be wiped from the qdisc also. Locking a tc BPF program in place this way,=
 is
> getting into layering hacks given the two object models are vastly differ=
ent.
>
> We instead implemented the tcx (tc 'express') layer which is an fd-based =
tc BPF
> attach API, so that the BPF link implementation blends in naturally simil=
ar to
> other link types which are fd-based and without the need for changing cor=
e tc
> internal APIs. BPF programs for tc can then be successively migrated from=
 classic
> cls_bpf to the new tc BPF link without needing to change the program's so=
urce
> code, just the BPF loader mechanics for attaching is sufficient.
>
> For the current tc framework, there is no change in behavior with this ch=
ange
> and neither does this change touch on tc core kernel APIs. The gist of th=
is
> patch is that the ingress and egress hook have a lightweight, qdisc-less
> extension for BPF to attach its tc BPF programs, in other words, a minima=
l
> entry point for tc BPF. The name tcx has been suggested from discussion o=
f
> earlier revisions of this work as a good fit, and to more easily differ b=
etween
> the classic cls_bpf attachment and the fd-based one.
>
> For the ingress and egress tcx points, the device holds a cache-friendly =
array
> with program pointers which is separated from control plane (slow-path) d=
ata.
> Earlier versions of this work used priority to determine ordering and exp=
ression
> of dependencies similar as with classic tc, but it was challenged that fo=
r
> something more future-proof a better user experience is required. Hence t=
his
> resulted in the design and development of the generic attach/detach/query=
 API
> for multi-progs. See prior patch with its discussion on the API design. t=
cx is
> the first user and later we plan to integrate also others, for example, o=
ne
> candidate is multi-prog support for XDP which would benefit and have the =
same
> 'look and feel' from API perspective.
>
> The goal with tcx is to have maximum compatibility to existing tc BPF pro=
grams,
> so they don't need to be rewritten specifically. Compatibility to call in=
to
> classic tcf_classify() is also provided in order to allow successive migr=
ation
> or both to cleanly co-exist where needed given its all one logical tc lay=
er and
> the tcx plus classic tc cls/act build one logical overall processing pipe=
line.
>
> tcx supports the simplified return codes TCX_NEXT which is non-terminatin=
g (go
> to next program) and terminating ones with TCX_PASS, TCX_DROP, TCX_REDIRE=
CT.
> The fd-based API is behind a static key, so that when unused the code is =
also
> not entered. The struct tcx_entry's program array is currently static, bu=
t
> could be made dynamic if necessary at a point in future. The a/b pair swa=
p
> design has been chosen so that for detachment there are no allocations wh=
ich
> otherwise could fail.
>
> The work has been tested with tc-testing selftest suite which all passes,=
 as
> well as the tc BPF tests from the BPF CI, and also with Cilium's L4LB.
>
> Thanks also to Nikolay Aleksandrov and Martin Lau for in-depth early revi=
ews
> of this work.
>
>   [0] https://lpc.events/event/16/contributions/1353/
>   [1] https://lore.kernel.org/bpf/CAEf4BzbokCJN33Nw_kg82sO=3DxppXnKWEncGT=
WCTB9vGCmLB6pw@mail.gmail.com
>   [2] https://colocatedeventseu2023.sched.com/event/1Jo6O/tales-from-an-e=
bpf-programs-murder-mystery-hemanth-malla-guillaume-fournier-datadog
>   [3] http://vger.kernel.org/bpfconf2023_material/tcx_meta_netdev_borkman=
n.pdf
>   [4] https://lore.kernel.org/bpf/20210604063116.234316-1-memxor@gmail.co=
m
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  MAINTAINERS                    |   4 +-
>  include/linux/bpf_mprog.h      |   9 +
>  include/linux/netdevice.h      |  15 +-
>  include/linux/skbuff.h         |   4 +-
>  include/net/sch_generic.h      |   2 +-
>  include/net/tcx.h              | 206 +++++++++++++++++++
>  include/uapi/linux/bpf.h       |  34 +++-
>  kernel/bpf/Kconfig             |   1 +
>  kernel/bpf/Makefile            |   1 +
>  kernel/bpf/syscall.c           |  82 ++++++--
>  kernel/bpf/tcx.c               | 348 +++++++++++++++++++++++++++++++++
>  net/Kconfig                    |   5 +
>  net/core/dev.c                 | 265 +++++++++++++++----------
>  net/core/filter.c              |   4 +-
>  net/sched/Kconfig              |   4 +-
>  net/sched/sch_ingress.c        |  61 +++++-
>  tools/include/uapi/linux/bpf.h |  34 +++-
>  17 files changed, 935 insertions(+), 144 deletions(-)
>  create mode 100644 include/net/tcx.h
>  create mode 100644 kernel/bpf/tcx.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 678bef9f60b4..990e3fce753c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3778,13 +3778,15 @@ L:      netdev@vger.kernel.org
>  S:     Maintained
>  F:     kernel/bpf/bpf_struct*
>
> -BPF [NETWORKING] (tc BPF, sock_addr)
> +BPF [NETWORKING] (tcx & tc BPF, sock_addr)
>  M:     Martin KaFai Lau <martin.lau@linux.dev>
>  M:     Daniel Borkmann <daniel@iogearbox.net>
>  R:     John Fastabend <john.fastabend@gmail.com>
>  L:     bpf@vger.kernel.org
>  L:     netdev@vger.kernel.org
>  S:     Maintained
> +F:     include/net/tcx.h
> +F:     kernel/bpf/tcx.c
>  F:     net/core/filter.c
>  F:     net/sched/act_bpf.c
>  F:     net/sched/cls_bpf.c
> diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
> index 6feefec43422..2b429488f840 100644
> --- a/include/linux/bpf_mprog.h
> +++ b/include/linux/bpf_mprog.h
> @@ -315,4 +315,13 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
>  int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *u=
attr,
>                     struct bpf_mprog_entry *entry);
>
> +static inline bool bpf_mprog_supported(enum bpf_prog_type type)
> +{
> +       switch (type) {
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
>  #endif /* __BPF_MPROG_H */
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index b828c7a75be2..024314c68bc8 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1930,8 +1930,7 @@ enum netdev_ml_priv_type {
>   *
>   *     @rx_handler:            handler for received packets
>   *     @rx_handler_data:       XXX: need comments on this one
> - *     @miniq_ingress:         ingress/clsact qdisc specific data for
> - *                             ingress processing
> + *     @tcx_ingress:           BPF & clsact qdisc specific data for ingr=
ess processing
>   *     @ingress_queue:         XXX: need comments on this one
>   *     @nf_hooks_ingress:      netfilter hooks executed for ingress pack=
ets
>   *     @broadcast:             hw bcast address
> @@ -1952,8 +1951,7 @@ enum netdev_ml_priv_type {
>   *     @xps_maps:              all CPUs/RXQs maps for XPS device
>   *
>   *     @xps_maps:      XXX: need comments on this one
> - *     @miniq_egress:          clsact qdisc specific data for
> - *                             egress processing
> + *     @tcx_egress:            BPF & clsact qdisc specific data for egre=
ss processing
>   *     @nf_hooks_egress:       netfilter hooks executed for egress packe=
ts
>   *     @qdisc_hash:            qdisc hash table
>   *     @watchdog_timeo:        Represents the timeout that is used by
> @@ -2252,9 +2250,8 @@ struct net_device {
>         unsigned int            gro_ipv4_max_size;
>         rx_handler_func_t __rcu *rx_handler;
>         void __rcu              *rx_handler_data;
> -
> -#ifdef CONFIG_NET_CLS_ACT
> -       struct mini_Qdisc __rcu *miniq_ingress;
> +#ifdef CONFIG_NET_XGRESS
> +       struct bpf_mprog_entry __rcu *tcx_ingress;
>  #endif
>         struct netdev_queue __rcu *ingress_queue;
>  #ifdef CONFIG_NETFILTER_INGRESS
> @@ -2282,8 +2279,8 @@ struct net_device {
>  #ifdef CONFIG_XPS
>         struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
>  #endif
> -#ifdef CONFIG_NET_CLS_ACT
> -       struct mini_Qdisc __rcu *miniq_egress;
> +#ifdef CONFIG_NET_XGRESS
> +       struct bpf_mprog_entry __rcu *tcx_egress;
>  #endif
>  #ifdef CONFIG_NETFILTER_EGRESS
>         struct nf_hook_entries __rcu *nf_hooks_egress;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 91ed66952580..ed83f1c5fc1f 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -944,7 +944,7 @@ struct sk_buff {
>         __u8                    __mono_tc_offset[0];
>         /* public: */
>         __u8                    mono_delivery_time:1;   /* See SKB_MONO_D=
ELIVERY_TIME_MASK */
> -#ifdef CONFIG_NET_CLS_ACT
> +#ifdef CONFIG_NET_XGRESS
>         __u8                    tc_at_ingress:1;        /* See TC_AT_INGR=
ESS_MASK */
>         __u8                    tc_skip_classify:1;
>  #endif
> @@ -993,7 +993,7 @@ struct sk_buff {
>         __u8                    csum_not_inet:1;
>  #endif
>
> -#ifdef CONFIG_NET_SCHED
> +#if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>         __u16                   tc_index;       /* traffic control index =
*/
>  #endif
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index e92f73bb3198..15be2d96b06d 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -703,7 +703,7 @@ int skb_do_redirect(struct sk_buff *);
>
>  static inline bool skb_at_tc_ingress(const struct sk_buff *skb)
>  {
> -#ifdef CONFIG_NET_CLS_ACT
> +#ifdef CONFIG_NET_XGRESS
>         return skb->tc_at_ingress;
>  #else
>         return false;
> diff --git a/include/net/tcx.h b/include/net/tcx.h
> new file mode 100644
> index 000000000000..264f147953ba
> --- /dev/null
> +++ b/include/net/tcx.h
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2023 Isovalent */
> +#ifndef __NET_TCX_H
> +#define __NET_TCX_H
> +
> +#include <linux/bpf.h>
> +#include <linux/bpf_mprog.h>
> +
> +#include <net/sch_generic.h>
> +
> +struct mini_Qdisc;
> +
> +struct tcx_entry {
> +       struct mini_Qdisc __rcu *miniq;
> +       struct bpf_mprog_bundle bundle;
> +       bool miniq_active;
> +       struct rcu_head rcu;
> +};
> +
> +struct tcx_link {
> +       struct bpf_link link;
> +       struct net_device *dev;
> +       u32 location;
> +};
> +
> +static inline void tcx_set_ingress(struct sk_buff *skb, bool ingress)
> +{
> +#ifdef CONFIG_NET_XGRESS
> +       skb->tc_at_ingress =3D ingress;
> +#endif
> +}
> +
> +#ifdef CONFIG_NET_XGRESS
> +static inline struct tcx_entry *tcx_entry(struct bpf_mprog_entry *entry)
> +{
> +       struct bpf_mprog_bundle *bundle =3D entry->parent;
> +
> +       return container_of(bundle, struct tcx_entry, bundle);
> +}
> +
> +static inline struct tcx_link *tcx_link(struct bpf_link *link)
> +{
> +       return container_of(link, struct tcx_link, link);
> +}
> +
> +static inline const struct tcx_link *tcx_link_const(const struct bpf_lin=
k *link)
> +{
> +       return tcx_link((struct bpf_link *)link);
> +}
> +
> +void tcx_inc(void);
> +void tcx_dec(void);
> +
> +static inline void tcx_entry_sync(void)
> +{
> +       /* bpf_mprog_entry got a/b swapped, therefore ensure that
> +        * there are no inflight users on the old one anymore.
> +        */
> +       synchronize_rcu();
> +}
> +
> +static inline void
> +tcx_entry_update(struct net_device *dev, struct bpf_mprog_entry *entry,
> +                bool ingress)
> +{
> +       ASSERT_RTNL();
> +       if (ingress)
> +               rcu_assign_pointer(dev->tcx_ingress, entry);
> +       else
> +               rcu_assign_pointer(dev->tcx_egress, entry);
> +}
> +
> +static inline struct bpf_mprog_entry *
> +tcx_entry_fetch(struct net_device *dev, bool ingress)
> +{
> +       ASSERT_RTNL();
> +       if (ingress)
> +               return rcu_dereference_rtnl(dev->tcx_ingress);
> +       else
> +               return rcu_dereference_rtnl(dev->tcx_egress);
> +}
> +
> +static inline struct bpf_mprog_entry *tcx_entry_create(void)
> +{
> +       struct tcx_entry *tcx =3D kzalloc(sizeof(*tcx), GFP_KERNEL);
> +
> +       if (tcx) {
> +               bpf_mprog_bundle_init(&tcx->bundle);
> +               return &tcx->bundle.a;
> +       }
> +       return NULL;
> +}
> +
> +static inline void tcx_entry_free(struct bpf_mprog_entry *entry)
> +{
> +       kfree_rcu(tcx_entry(entry), rcu);
> +}
> +
> +static inline struct bpf_mprog_entry *
> +tcx_entry_fetch_or_create(struct net_device *dev, bool ingress, bool *cr=
eated)
> +{
> +       struct bpf_mprog_entry *entry =3D tcx_entry_fetch(dev, ingress);
> +
> +       *created =3D false;
> +       if (!entry) {
> +               entry =3D tcx_entry_create();
> +               if (!entry)
> +                       return NULL;
> +               *created =3D true;
> +       }
> +       return entry;
> +}
> +
> +static inline void tcx_skeys_inc(bool ingress)
> +{
> +       tcx_inc();
> +       if (ingress)
> +               net_inc_ingress_queue();
> +       else
> +               net_inc_egress_queue();
> +}
> +
> +static inline void tcx_skeys_dec(bool ingress)
> +{
> +       if (ingress)
> +               net_dec_ingress_queue();
> +       else
> +               net_dec_egress_queue();
> +       tcx_dec();
> +}
> +
> +static inline void tcx_miniq_set_active(struct bpf_mprog_entry *entry,
> +                                       const bool active)
> +{
> +       ASSERT_RTNL();
> +       tcx_entry(entry)->miniq_active =3D active;
> +}
> +
> +static inline bool tcx_entry_is_active(struct bpf_mprog_entry *entry)
> +{
> +       ASSERT_RTNL();
> +       return bpf_mprog_total(entry) || tcx_entry(entry)->miniq_active;
> +}
> +
> +static inline enum tcx_action_base tcx_action_code(struct sk_buff *skb,
> +                                                  int code)
> +{
> +       switch (code) {
> +       case TCX_PASS:
> +               skb->tc_index =3D qdisc_skb_cb(skb)->tc_classid;
> +               fallthrough;
> +       case TCX_DROP:
> +       case TCX_REDIRECT:
> +               return code;
> +       case TCX_NEXT:
> +       default:
> +               return TCX_NEXT;
> +       }
> +}
> +#endif /* CONFIG_NET_XGRESS */
> +
> +#if defined(CONFIG_NET_XGRESS) && defined(CONFIG_BPF_SYSCALL)
> +int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> +int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
> +int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog);
> +void tcx_uninstall(struct net_device *dev, bool ingress);
> +
> +int tcx_prog_query(const union bpf_attr *attr,
> +                  union bpf_attr __user *uattr);
> +
> +static inline void dev_tcx_uninstall(struct net_device *dev)
> +{
> +       ASSERT_RTNL();
> +       tcx_uninstall(dev, true);
> +       tcx_uninstall(dev, false);
> +}
> +#else
> +static inline int tcx_prog_attach(const union bpf_attr *attr,
> +                                 struct bpf_prog *prog)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int tcx_link_attach(const union bpf_attr *attr,
> +                                 struct bpf_prog *prog)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int tcx_prog_detach(const union bpf_attr *attr,
> +                                 struct bpf_prog *prog)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int tcx_prog_query(const union bpf_attr *attr,
> +                                union bpf_attr __user *uattr)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline void dev_tcx_uninstall(struct net_device *dev)
> +{
> +}
> +#endif /* CONFIG_NET_XGRESS && CONFIG_BPF_SYSCALL */
> +#endif /* __NET_TCX_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d4c07e435336..739c15906a65 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1036,6 +1036,8 @@ enum bpf_attach_type {
>         BPF_LSM_CGROUP,
>         BPF_STRUCT_OPS,
>         BPF_NETFILTER,
> +       BPF_TCX_INGRESS,
> +       BPF_TCX_EGRESS,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> @@ -1053,7 +1055,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_KPROBE_MULTI =3D 8,
>         BPF_LINK_TYPE_STRUCT_OPS =3D 9,
>         BPF_LINK_TYPE_NETFILTER =3D 10,
> -
> +       BPF_LINK_TYPE_TCX =3D 11,
>         MAX_BPF_LINK_TYPE,
>  };
>
> @@ -1569,13 +1571,13 @@ union bpf_attr {
>                         __u32           map_fd;         /* struct_ops to =
attach */
>                 };
>                 union {
> -                       __u32           target_fd;      /* object to atta=
ch to */
> -                       __u32           target_ifindex; /* target ifindex=
 */
> +                       __u32   target_fd;      /* target object to attac=
h to or ... */
> +                       __u32   target_ifindex; /* target ifindex */
>                 };
>                 __u32           attach_type;    /* attach type */
>                 __u32           flags;          /* extra flags */
>                 union {
> -                       __u32           target_btf_id;  /* btf_id of targ=
et to attach to */
> +                       __u32   target_btf_id;  /* btf_id of target to at=
tach to */
>                         struct {
>                                 __aligned_u64   iter_info;      /* extra =
bpf_iter_link_info */
>                                 __u32           iter_info_len;  /* iter_i=
nfo length */
> @@ -1609,6 +1611,13 @@ union bpf_attr {
>                                 __s32           priority;
>                                 __u32           flags;
>                         } netfilter;
> +                       struct {
> +                               union {
> +                                       __u32   relative_fd;
> +                                       __u32   relative_id;
> +                               };
> +                               __u64           expected_revision;
> +                       } tcx;
>                 };
>         } link_create;
>
> @@ -6217,6 +6226,19 @@ struct bpf_sock_tuple {
>         };
>  };
>
> +/* (Simplified) user return codes for tcx prog type.
> + * A valid tcx program must return one of these defined values. All othe=
r
> + * return codes are reserved for future use. Must remain compatible with
> + * their TC_ACT_* counter-parts. For compatibility in behavior, unknown
> + * return codes are mapped to TCX_NEXT.
> + */
> +enum tcx_action_base {
> +       TCX_NEXT        =3D -1,
> +       TCX_PASS        =3D 0,
> +       TCX_DROP        =3D 2,
> +       TCX_REDIRECT    =3D 7,
> +};
> +
>  struct bpf_xdp_sock {
>         __u32 queue_id;
>  };
> @@ -6499,6 +6521,10 @@ struct bpf_link_info {
>                                 } event; /* BPF_PERF_EVENT_EVENT */
>                         };
>                 } perf_event;
> +               struct {
> +                       __u32 ifindex;
> +                       __u32 attach_type;
> +               } tcx;
>         };
>  } __attribute__((aligned(8)));
>
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index 2dfe1079f772..6a906ff93006 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -31,6 +31,7 @@ config BPF_SYSCALL
>         select TASKS_TRACE_RCU
>         select BINARY_PRINTF
>         select NET_SOCK_MSG if NET
> +       select NET_XGRESS if NET
>         select PAGE_POOL if NET
>         default n
>         help
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 1bea2eb912cd..f526b7573e97 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D devmap.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D cpumap.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D offload.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D net_namespace.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D tcx.o
>  endif
>  ifeq ($(CONFIG_PERF_EVENTS),y)
>  obj-$(CONFIG_BPF_SYSCALL) +=3D stackmap.o
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ee8cb1a174aa..7f4e8c357a6a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -37,6 +37,8 @@
>  #include <linux/trace_events.h>
>  #include <net/netfilter/nf_bpf_link.h>
>
> +#include <net/tcx.h>
> +
>  #define IS_FD_ARRAY(map) ((map)->map_type =3D=3D BPF_MAP_TYPE_PERF_EVENT=
_ARRAY || \
>                           (map)->map_type =3D=3D BPF_MAP_TYPE_CGROUP_ARRA=
Y || \
>                           (map)->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MA=
PS)
> @@ -3740,31 +3742,45 @@ attach_type_to_prog_type(enum bpf_attach_type att=
ach_type)
>                 return BPF_PROG_TYPE_XDP;
>         case BPF_LSM_CGROUP:
>                 return BPF_PROG_TYPE_LSM;
> +       case BPF_TCX_INGRESS:
> +       case BPF_TCX_EGRESS:
> +               return BPF_PROG_TYPE_SCHED_CLS;
>         default:
>                 return BPF_PROG_TYPE_UNSPEC;
>         }
>  }
>
> -#define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
> +#define BPF_PROG_ATTACH_LAST_FIELD expected_revision
> +
> +#define BPF_F_ATTACH_MASK_BASE \
> +       (BPF_F_ALLOW_OVERRIDE | \
> +        BPF_F_ALLOW_MULTI |    \
> +        BPF_F_REPLACE)
>
> -#define BPF_F_ATTACH_MASK \
> -       (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI | BPF_F_REPLACE)
> +#define BPF_F_ATTACH_MASK_MPROG        \
> +       (BPF_F_REPLACE |        \
> +        BPF_F_BEFORE |         \
> +        BPF_F_AFTER |          \
> +        BPF_F_ID |             \
> +        BPF_F_LINK)
>
>  static int bpf_prog_attach(const union bpf_attr *attr)
>  {
>         enum bpf_prog_type ptype;
>         struct bpf_prog *prog;
> +       u32 mask;
>         int ret;
>
>         if (CHECK_ATTR(BPF_PROG_ATTACH))
>                 return -EINVAL;
>
> -       if (attr->attach_flags & ~BPF_F_ATTACH_MASK)
> -               return -EINVAL;
> -
>         ptype =3D attach_type_to_prog_type(attr->attach_type);
>         if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC)
>                 return -EINVAL;
> +       mask =3D bpf_mprog_supported(ptype) ?
> +              BPF_F_ATTACH_MASK_MPROG : BPF_F_ATTACH_MASK_BASE;
> +       if (attr->attach_flags & ~mask)
> +               return -EINVAL;
>
>         prog =3D bpf_prog_get_type(attr->attach_bpf_fd, ptype);
>         if (IS_ERR(prog))
> @@ -3800,6 +3816,9 @@ static int bpf_prog_attach(const union bpf_attr *at=
tr)
>                 else
>                         ret =3D cgroup_bpf_prog_attach(attr, ptype, prog)=
;
>                 break;
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +               ret =3D tcx_prog_attach(attr, prog);
> +               break;
>         default:
>                 ret =3D -EINVAL;
>         }
> @@ -3809,25 +3828,41 @@ static int bpf_prog_attach(const union bpf_attr *=
attr)
>         return ret;
>  }
>
> -#define BPF_PROG_DETACH_LAST_FIELD attach_type
> +#define BPF_PROG_DETACH_LAST_FIELD expected_revision
>
>  static int bpf_prog_detach(const union bpf_attr *attr)
>  {
> +       struct bpf_prog *prog =3D NULL;
>         enum bpf_prog_type ptype;
> +       int ret;
>
>         if (CHECK_ATTR(BPF_PROG_DETACH))
>                 return -EINVAL;
>
>         ptype =3D attach_type_to_prog_type(attr->attach_type);
> +       if (bpf_mprog_supported(ptype)) {
> +               if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC)
> +                       return -EINVAL;
> +               if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
> +                       return -EINVAL;
> +               if (attr->attach_bpf_fd) {
> +                       prog =3D bpf_prog_get_type(attr->attach_bpf_fd, p=
type);
> +                       if (IS_ERR(prog))
> +                               return PTR_ERR(prog);
> +               }
> +       }
>
>         switch (ptype) {
>         case BPF_PROG_TYPE_SK_MSG:
>         case BPF_PROG_TYPE_SK_SKB:
> -               return sock_map_prog_detach(attr, ptype);
> +               ret =3D sock_map_prog_detach(attr, ptype);
> +               break;
>         case BPF_PROG_TYPE_LIRC_MODE2:
> -               return lirc_prog_detach(attr);
> +               ret =3D lirc_prog_detach(attr);
> +               break;
>         case BPF_PROG_TYPE_FLOW_DISSECTOR:
> -               return netns_bpf_prog_detach(attr, ptype);
> +               ret =3D netns_bpf_prog_detach(attr, ptype);
> +               break;
>         case BPF_PROG_TYPE_CGROUP_DEVICE:
>         case BPF_PROG_TYPE_CGROUP_SKB:
>         case BPF_PROG_TYPE_CGROUP_SOCK:
> @@ -3836,13 +3871,21 @@ static int bpf_prog_detach(const union bpf_attr *=
attr)
>         case BPF_PROG_TYPE_CGROUP_SYSCTL:
>         case BPF_PROG_TYPE_SOCK_OPS:
>         case BPF_PROG_TYPE_LSM:
> -               return cgroup_bpf_prog_detach(attr, ptype);
> +               ret =3D cgroup_bpf_prog_detach(attr, ptype);
> +               break;
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +               ret =3D tcx_prog_detach(attr, prog);
> +               break;
>         default:
> -               return -EINVAL;
> +               ret =3D -EINVAL;
>         }
> +
> +       if (prog)
> +               bpf_prog_put(prog);
> +       return ret;
>  }
>
> -#define BPF_PROG_QUERY_LAST_FIELD query.prog_attach_flags
> +#define BPF_PROG_QUERY_LAST_FIELD query.link_attach_flags
>
>  static int bpf_prog_query(const union bpf_attr *attr,
>                           union bpf_attr __user *uattr)
> @@ -3890,6 +3933,9 @@ static int bpf_prog_query(const union bpf_attr *att=
r,
>         case BPF_SK_MSG_VERDICT:
>         case BPF_SK_SKB_VERDICT:
>                 return sock_map_bpf_prog_query(attr, uattr);
> +       case BPF_TCX_INGRESS:
> +       case BPF_TCX_EGRESS:
> +               return tcx_prog_query(attr, uattr);
>         default:
>                 return -EINVAL;
>         }
> @@ -4852,6 +4898,13 @@ static int link_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>                         goto out;
>                 }
>                 break;
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +               if (attr->link_create.attach_type !=3D BPF_TCX_INGRESS &&
> +                   attr->link_create.attach_type !=3D BPF_TCX_EGRESS) {
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
> +               break;
>         default:
>                 ptype =3D attach_type_to_prog_type(attr->link_create.atta=
ch_type);
>                 if (ptype =3D=3D BPF_PROG_TYPE_UNSPEC || ptype !=3D prog-=
>type) {
> @@ -4903,6 +4956,9 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>         case BPF_PROG_TYPE_XDP:
>                 ret =3D bpf_xdp_link_attach(attr, prog);
>                 break;
> +       case BPF_PROG_TYPE_SCHED_CLS:
> +               ret =3D tcx_link_attach(attr, prog);
> +               break;
>         case BPF_PROG_TYPE_NETFILTER:
>                 ret =3D bpf_nf_link_attach(attr, prog);
>                 break;
> diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
> new file mode 100644
> index 000000000000..69a272712b29
> --- /dev/null
> +++ b/kernel/bpf/tcx.c
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Isovalent */
> +
> +#include <linux/bpf.h>
> +#include <linux/bpf_mprog.h>
> +#include <linux/netdevice.h>
> +
> +#include <net/tcx.h>
> +
> +int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +       bool created, ingress =3D attr->attach_type =3D=3D BPF_TCX_INGRES=
S;
> +       struct net *net =3D current->nsproxy->net_ns;
> +       struct bpf_mprog_entry *entry, *entry_new;
> +       struct bpf_prog *replace_prog =3D NULL;
> +       struct net_device *dev;
> +       int ret;
> +
> +       rtnl_lock();
> +       dev =3D __dev_get_by_index(net, attr->target_ifindex);
> +       if (!dev) {
> +               ret =3D -ENODEV;
> +               goto out;
> +       }
> +       if (attr->attach_flags & BPF_F_REPLACE) {
> +               replace_prog =3D bpf_prog_get_type(attr->replace_bpf_fd,
> +                                                prog->type);
> +               if (IS_ERR(replace_prog)) {
> +                       ret =3D PTR_ERR(replace_prog);
> +                       replace_prog =3D NULL;
> +                       goto out;
> +               }
> +       }
> +       entry =3D tcx_entry_fetch_or_create(dev, ingress, &created);
> +       if (!entry) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +       ret =3D bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_p=
rog,
> +                              attr->attach_flags, attr->relative_fd,
> +                              attr->expected_revision);
> +       if (!ret) {
> +               if (entry !=3D entry_new) {
> +                       tcx_entry_update(dev, entry_new, ingress);
> +                       tcx_entry_sync();
> +                       tcx_skeys_inc(ingress);
> +               }
> +               bpf_mprog_commit(entry);
> +       } else if (created) {
> +               tcx_entry_free(entry);
> +       }
> +out:
> +       if (replace_prog)
> +               bpf_prog_put(replace_prog);
> +       rtnl_unlock();
> +       return ret;
> +}
> +
> +int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +       bool ingress =3D attr->attach_type =3D=3D BPF_TCX_INGRESS;
> +       struct net *net =3D current->nsproxy->net_ns;
> +       struct bpf_mprog_entry *entry, *entry_new;
> +       struct net_device *dev;
> +       int ret;
> +
> +       rtnl_lock();
> +       dev =3D __dev_get_by_index(net, attr->target_ifindex);
> +       if (!dev) {
> +               ret =3D -ENODEV;
> +               goto out;
> +       }
> +       entry =3D tcx_entry_fetch(dev, ingress);
> +       if (!entry) {
> +               ret =3D -ENOENT;
> +               goto out;
> +       }
> +       ret =3D bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->att=
ach_flags,
> +                              attr->relative_fd, attr->expected_revision=
);
> +       if (!ret) {
> +               if (!tcx_entry_is_active(entry_new))
> +                       entry_new =3D NULL;
> +               tcx_entry_update(dev, entry_new, ingress);
> +               tcx_entry_sync();
> +               tcx_skeys_dec(ingress);
> +               bpf_mprog_commit(entry);
> +               if (!entry_new)
> +                       tcx_entry_free(entry);
> +       }
> +out:
> +       rtnl_unlock();
> +       return ret;
> +}
> +
> +void tcx_uninstall(struct net_device *dev, bool ingress)
> +{
> +       struct bpf_tuple tuple =3D {};
> +       struct bpf_mprog_entry *entry;
> +       struct bpf_mprog_fp *fp;
> +       struct bpf_mprog_cp *cp;
> +
> +       entry =3D tcx_entry_fetch(dev, ingress);
> +       if (!entry)
> +               return;
> +       tcx_entry_update(dev, NULL, ingress);
> +       tcx_entry_sync();
> +       bpf_mprog_foreach_tuple(entry, fp, cp, tuple) {
> +               if (tuple.link)
> +                       tcx_link(tuple.link)->dev =3D NULL;
> +               else
> +                       bpf_prog_put(tuple.prog);
> +               tcx_skeys_dec(ingress);
> +       }
> +       WARN_ON_ONCE(tcx_entry(entry)->miniq_active);
> +       tcx_entry_free(entry);
> +}
> +
> +int tcx_prog_query(const union bpf_attr *attr, union bpf_attr __user *ua=
ttr)
> +{
> +       bool ingress =3D attr->query.attach_type =3D=3D BPF_TCX_INGRESS;
> +       struct net *net =3D current->nsproxy->net_ns;
> +       struct bpf_mprog_entry *entry;
> +       struct net_device *dev;
> +       int ret;
> +
> +       rtnl_lock();
> +       dev =3D __dev_get_by_index(net, attr->query.target_ifindex);
> +       if (!dev) {
> +               ret =3D -ENODEV;
> +               goto out;
> +       }
> +       entry =3D tcx_entry_fetch(dev, ingress);
> +       if (!entry) {
> +               ret =3D -ENOENT;
> +               goto out;
> +       }
> +       ret =3D bpf_mprog_query(attr, uattr, entry);
> +out:
> +       rtnl_unlock();
> +       return ret;
> +}
> +
> +static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id=
_or_fd,
> +                               u64 revision)
> +{
> +       struct tcx_link *tcx =3D tcx_link(link);
> +       bool created, ingress =3D tcx->location =3D=3D BPF_TCX_INGRESS;
> +       struct bpf_mprog_entry *entry, *entry_new;
> +       struct net_device *dev =3D tcx->dev;
> +       int ret;
> +
> +       ASSERT_RTNL();
> +       entry =3D tcx_entry_fetch_or_create(dev, ingress, &created);
> +       if (!entry)
> +               return -ENOMEM;
> +       ret =3D bpf_mprog_attach(entry, &entry_new, link->prog, link, NUL=
L, flags,
> +                              id_or_fd, revision);
> +       if (!ret) {
> +               if (entry !=3D entry_new) {
> +                       tcx_entry_update(dev, entry_new, ingress);
> +                       tcx_entry_sync();
> +                       tcx_skeys_inc(ingress);
> +               }
> +               bpf_mprog_commit(entry);
> +       } else if (created) {
> +               tcx_entry_free(entry);
> +       }
> +       return ret;
> +}
> +
> +static void tcx_link_release(struct bpf_link *link)
> +{
> +       struct tcx_link *tcx =3D tcx_link(link);
> +       bool ingress =3D tcx->location =3D=3D BPF_TCX_INGRESS;
> +       struct bpf_mprog_entry *entry, *entry_new;
> +       struct net_device *dev;
> +       int ret =3D 0;
> +
> +       rtnl_lock();
> +       dev =3D tcx->dev;
> +       if (!dev)
> +               goto out;
> +       entry =3D tcx_entry_fetch(dev, ingress);
> +       if (!entry) {
> +               ret =3D -ENOENT;
> +               goto out;
> +       }
> +       ret =3D bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, =
0, 0);
> +       if (!ret) {
> +               if (!tcx_entry_is_active(entry_new))
> +                       entry_new =3D NULL;
> +               tcx_entry_update(dev, entry_new, ingress);
> +               tcx_entry_sync();
> +               tcx_skeys_dec(ingress);
> +               bpf_mprog_commit(entry);
> +               if (!entry_new)
> +                       tcx_entry_free(entry);
> +               tcx->dev =3D NULL;
> +       }
> +out:
> +       WARN_ON_ONCE(ret);
> +       rtnl_unlock();
> +}
> +
> +static int tcx_link_update(struct bpf_link *link, struct bpf_prog *nprog=
,
> +                          struct bpf_prog *oprog)
> +{
> +       struct tcx_link *tcx =3D tcx_link(link);
> +       bool ingress =3D tcx->location =3D=3D BPF_TCX_INGRESS;
> +       struct bpf_mprog_entry *entry, *entry_new;
> +       struct net_device *dev;
> +       int ret =3D 0;
> +
> +       rtnl_lock();
> +       dev =3D tcx->dev;
> +       if (!dev) {
> +               ret =3D -ENOLINK;
> +               goto out;
> +       }
> +       if (oprog && link->prog !=3D oprog) {
> +               ret =3D -EPERM;
> +               goto out;
> +       }
> +       oprog =3D link->prog;
> +       if (oprog =3D=3D nprog) {
> +               bpf_prog_put(nprog);
> +               goto out;
> +       }
> +       entry =3D tcx_entry_fetch(dev, ingress);
> +       if (!entry) {
> +               ret =3D -ENOENT;
> +               goto out;
> +       }
> +       ret =3D bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
> +                              BPF_F_REPLACE | BPF_F_ID,
> +                              link->prog->aux->id, 0);
> +       if (!ret) {
> +               WARN_ON_ONCE(entry !=3D entry_new);
> +               oprog =3D xchg(&link->prog, nprog);
> +               bpf_prog_put(oprog);
> +               bpf_mprog_commit(entry);
> +       }
> +out:
> +       rtnl_unlock();
> +       return ret;
> +}
> +
> +static void tcx_link_dealloc(struct bpf_link *link)
> +{
> +       kfree(tcx_link(link));
> +}
> +
> +static void tcx_link_fdinfo(const struct bpf_link *link, struct seq_file=
 *seq)
> +{
> +       const struct tcx_link *tcx =3D tcx_link_const(link);
> +       u32 ifindex =3D 0;
> +
> +       rtnl_lock();
> +       if (tcx->dev)
> +               ifindex =3D tcx->dev->ifindex;
> +       rtnl_unlock();
> +
> +       seq_printf(seq, "ifindex:\t%u\n", ifindex);
> +       seq_printf(seq, "attach_type:\t%u (%s)\n",
> +                  tcx->location,
> +                  tcx->location =3D=3D BPF_TCX_INGRESS ? "ingress" : "eg=
ress");
> +}
> +
> +static int tcx_link_fill_info(const struct bpf_link *link,
> +                             struct bpf_link_info *info)
> +{
> +       const struct tcx_link *tcx =3D tcx_link_const(link);
> +       u32 ifindex =3D 0;
> +
> +       rtnl_lock();
> +       if (tcx->dev)
> +               ifindex =3D tcx->dev->ifindex;
> +       rtnl_unlock();
> +
> +       info->tcx.ifindex =3D ifindex;
> +       info->tcx.attach_type =3D tcx->location;
> +       return 0;
> +}
> +
> +static int tcx_link_detach(struct bpf_link *link)
> +{
> +       tcx_link_release(link);
> +       return 0;
> +}
> +
> +static const struct bpf_link_ops tcx_link_lops =3D {
> +       .release        =3D tcx_link_release,
> +       .detach         =3D tcx_link_detach,
> +       .dealloc        =3D tcx_link_dealloc,
> +       .update_prog    =3D tcx_link_update,
> +       .show_fdinfo    =3D tcx_link_fdinfo,
> +       .fill_link_info =3D tcx_link_fill_info,

Should we show the tc link info in `bpftool link show` as well? I
believe that `bpftool link show` is the appropriate command to display
comprehensive information about all links.

> +};
> +
> +static int tcx_link_init(struct tcx_link *tcx,
> +                        struct bpf_link_primer *link_primer,
> +                        const union bpf_attr *attr,
> +                        struct net_device *dev,
> +                        struct bpf_prog *prog)
> +{
> +       bpf_link_init(&tcx->link, BPF_LINK_TYPE_TCX, &tcx_link_lops, prog=
);
> +       tcx->location =3D attr->link_create.attach_type;
> +       tcx->dev =3D dev;
> +       return bpf_link_prime(&tcx->link, link_primer);
> +}
> +
> +int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> +{
> +       struct net *net =3D current->nsproxy->net_ns;
> +       struct bpf_link_primer link_primer;
> +       struct net_device *dev;
> +       struct tcx_link *tcx;
> +       int ret;
> +
> +       rtnl_lock();
> +       dev =3D __dev_get_by_index(net, attr->link_create.target_ifindex)=
;
> +       if (!dev) {
> +               ret =3D -ENODEV;
> +               goto out;
> +       }
> +       tcx =3D kzalloc(sizeof(*tcx), GFP_USER);
> +       if (!tcx) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +       ret =3D tcx_link_init(tcx, &link_primer, attr, dev, prog);
> +       if (ret) {
> +               kfree(tcx);
> +               goto out;
> +       }
> +       ret =3D tcx_link_prog_attach(&tcx->link, attr->link_create.flags,
> +                                  attr->link_create.tcx.relative_fd,
> +                                  attr->link_create.tcx.expected_revisio=
n);
> +       if (ret) {
> +               tcx->dev =3D NULL;
> +               bpf_link_cleanup(&link_primer);
> +               goto out;
> +       }
> +       ret =3D bpf_link_settle(&link_primer);
> +out:
> +       rtnl_unlock();
> +       return ret;
> +}
> diff --git a/net/Kconfig b/net/Kconfig
> index 2fb25b534df5..d532ec33f1fe 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -52,6 +52,11 @@ config NET_INGRESS
>  config NET_EGRESS
>         bool
>
> +config NET_XGRESS
> +       select NET_INGRESS
> +       select NET_EGRESS
> +       bool
> +
>  config NET_REDIRECT
>         bool
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d6e1b786c5c5..c4b826024978 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -107,6 +107,7 @@
>  #include <net/pkt_cls.h>
>  #include <net/checksum.h>
>  #include <net/xfrm.h>
> +#include <net/tcx.h>
>  #include <linux/highmem.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -154,7 +155,6 @@
>  #include "dev.h"
>  #include "net-sysfs.h"
>
> -
>  static DEFINE_SPINLOCK(ptype_lock);
>  struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
>  struct list_head ptype_all __read_mostly;      /* Taps */
> @@ -3882,69 +3882,198 @@ int dev_loopback_xmit(struct net *net, struct so=
ck *sk, struct sk_buff *skb)
>  EXPORT_SYMBOL(dev_loopback_xmit);
>
>  #ifdef CONFIG_NET_EGRESS
> -static struct sk_buff *
> -sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
> +static struct netdev_queue *
> +netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
> +{
> +       int qm =3D skb_get_queue_mapping(skb);
> +
> +       return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> +}
> +
> +static bool netdev_xmit_txqueue_skipped(void)
>  {
> +       return __this_cpu_read(softnet_data.xmit.skip_txqueue);
> +}
> +
> +void netdev_xmit_skip_txqueue(bool skip)
> +{
> +       __this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
> +}
> +EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> +#endif /* CONFIG_NET_EGRESS */
> +
> +#ifdef CONFIG_NET_XGRESS
> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> +{
> +       int ret =3D TC_ACT_UNSPEC;
>  #ifdef CONFIG_NET_CLS_ACT
> -       struct mini_Qdisc *miniq =3D rcu_dereference_bh(dev->miniq_egress=
);
> -       struct tcf_result cl_res;
> +       struct mini_Qdisc *miniq =3D rcu_dereference_bh(entry->miniq);
> +       struct tcf_result res;
>
>         if (!miniq)
> -               return skb;
> +               return ret;
>
> -       /* qdisc_skb_cb(skb)->pkt_len was already set by the caller. */
>         tc_skb_cb(skb)->mru =3D 0;
>         tc_skb_cb(skb)->post_ct =3D false;
> -       mini_qdisc_bstats_cpu_update(miniq, skb);
>
> -       switch (tcf_classify(skb, miniq->block, miniq->filter_list, &cl_r=
es, false)) {
> +       mini_qdisc_bstats_cpu_update(miniq, skb);
> +       ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &res,=
 false);
> +       /* Only tcf related quirks below. */
> +       switch (ret) {
> +       case TC_ACT_SHOT:
> +               mini_qdisc_qstats_cpu_drop(miniq);
> +               break;
>         case TC_ACT_OK:
>         case TC_ACT_RECLASSIFY:
> -               skb->tc_index =3D TC_H_MIN(cl_res.classid);
> +               skb->tc_index =3D TC_H_MIN(res.classid);
>                 break;
> +       }
> +#endif /* CONFIG_NET_CLS_ACT */
> +       return ret;
> +}
> +
> +static DEFINE_STATIC_KEY_FALSE(tcx_needed_key);
> +
> +void tcx_inc(void)
> +{
> +       static_branch_inc(&tcx_needed_key);
> +}
> +
> +void tcx_dec(void)
> +{
> +       static_branch_dec(&tcx_needed_key);
> +}
> +
> +static __always_inline enum tcx_action_base
> +tcx_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
> +       const bool needs_mac)
> +{
> +       const struct bpf_mprog_fp *fp;
> +       const struct bpf_prog *prog;
> +       int ret =3D TCX_NEXT;
> +
> +       if (needs_mac)
> +               __skb_push(skb, skb->mac_len);
> +       bpf_mprog_foreach_prog(entry, fp, prog) {
> +               bpf_compute_data_pointers(skb);
> +               ret =3D bpf_prog_run(prog, skb);
> +               if (ret !=3D TCX_NEXT)
> +                       break;
> +       }
> +       if (needs_mac)
> +               __skb_pull(skb, skb->mac_len);
> +       return tcx_action_code(skb, ret);
> +}
> +
> +static __always_inline struct sk_buff *
> +sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, in=
t *ret,
> +                  struct net_device *orig_dev, bool *another)
> +{
> +       struct bpf_mprog_entry *entry =3D rcu_dereference_bh(skb->dev->tc=
x_ingress);
> +       int sch_ret;
> +
> +       if (!entry)
> +               return skb;
> +       if (*pt_prev) {
> +               *ret =3D deliver_skb(skb, *pt_prev, orig_dev);
> +               *pt_prev =3D NULL;
> +       }
> +
> +       qdisc_skb_cb(skb)->pkt_len =3D skb->len;
> +       tcx_set_ingress(skb, true);
> +
> +       if (static_branch_unlikely(&tcx_needed_key)) {
> +               sch_ret =3D tcx_run(entry, skb, true);
> +               if (sch_ret !=3D TC_ACT_UNSPEC)
> +                       goto ingress_verdict;
> +       }
> +       sch_ret =3D tc_run(tcx_entry(entry), skb);
> +ingress_verdict:
> +       switch (sch_ret) {
> +       case TC_ACT_REDIRECT:
> +               /* skb_mac_header check was done by BPF, so we can safely
> +                * push the L2 header back before redirecting to another
> +                * netdev.
> +                */
> +               __skb_push(skb, skb->mac_len);
> +               if (skb_do_redirect(skb) =3D=3D -EAGAIN) {
> +                       __skb_pull(skb, skb->mac_len);
> +                       *another =3D true;
> +                       break;
> +               }
> +               *ret =3D NET_RX_SUCCESS;
> +               return NULL;
>         case TC_ACT_SHOT:
> -               mini_qdisc_qstats_cpu_drop(miniq);
> -               *ret =3D NET_XMIT_DROP;
> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
> +               kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
> +               *ret =3D NET_RX_DROP;
>                 return NULL;
> +       /* used by tc_run */
>         case TC_ACT_STOLEN:
>         case TC_ACT_QUEUED:
>         case TC_ACT_TRAP:
> -               *ret =3D NET_XMIT_SUCCESS;
>                 consume_skb(skb);
> +               fallthrough;
> +       case TC_ACT_CONSUMED:
> +               *ret =3D NET_RX_SUCCESS;
>                 return NULL;
> +       }
> +
> +       return skb;
> +}
> +
> +static __always_inline struct sk_buff *
> +sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
> +{
> +       struct bpf_mprog_entry *entry =3D rcu_dereference_bh(dev->tcx_egr=
ess);
> +       int sch_ret;
> +
> +       if (!entry)
> +               return skb;
> +
> +       /* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
> +        * already set by the caller.
> +        */
> +       if (static_branch_unlikely(&tcx_needed_key)) {
> +               sch_ret =3D tcx_run(entry, skb, false);
> +               if (sch_ret !=3D TC_ACT_UNSPEC)
> +                       goto egress_verdict;
> +       }
> +       sch_ret =3D tc_run(tcx_entry(entry), skb);
> +egress_verdict:
> +       switch (sch_ret) {
>         case TC_ACT_REDIRECT:
>                 /* No need to push/pop skb's mac_header here on egress! *=
/
>                 skb_do_redirect(skb);
>                 *ret =3D NET_XMIT_SUCCESS;
>                 return NULL;
> -       default:
> -               break;
> +       case TC_ACT_SHOT:
> +               kfree_skb_reason(skb, SKB_DROP_REASON_TC_EGRESS);
> +               *ret =3D NET_XMIT_DROP;
> +               return NULL;
> +       /* used by tc_run */
> +       case TC_ACT_STOLEN:
> +       case TC_ACT_QUEUED:
> +       case TC_ACT_TRAP:
> +               *ret =3D NET_XMIT_SUCCESS;
> +               return NULL;
>         }
> -#endif /* CONFIG_NET_CLS_ACT */
>
>         return skb;
>  }
> -
> -static struct netdev_queue *
> -netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
> -{
> -       int qm =3D skb_get_queue_mapping(skb);
> -
> -       return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> -}
> -
> -static bool netdev_xmit_txqueue_skipped(void)
> +#else
> +static __always_inline struct sk_buff *
> +sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, in=
t *ret,
> +                  struct net_device *orig_dev, bool *another)
>  {
> -       return __this_cpu_read(softnet_data.xmit.skip_txqueue);
> +       return skb;
>  }
>
> -void netdev_xmit_skip_txqueue(bool skip)
> +static __always_inline struct sk_buff *
> +sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
>  {
> -       __this_cpu_write(softnet_data.xmit.skip_txqueue, skip);
> +       return skb;
>  }
> -EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> -#endif /* CONFIG_NET_EGRESS */
> +#endif /* CONFIG_NET_XGRESS */
>
>  #ifdef CONFIG_XPS
>  static int __get_xps_queue_idx(struct net_device *dev, struct sk_buff *s=
kb,
> @@ -4128,9 +4257,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct ne=
t_device *sb_dev)
>         skb_update_prio(skb);
>
>         qdisc_pkt_len_init(skb);
> -#ifdef CONFIG_NET_CLS_ACT
> -       skb->tc_at_ingress =3D 0;
> -#endif
> +       tcx_set_ingress(skb, false);
>  #ifdef CONFIG_NET_EGRESS
>         if (static_branch_unlikely(&egress_needed_key)) {
>                 if (nf_hook_egress_active()) {
> @@ -5064,72 +5191,6 @@ int (*br_fdb_test_addr_hook)(struct net_device *de=
v,
>  EXPORT_SYMBOL_GPL(br_fdb_test_addr_hook);
>  #endif
>
> -static inline struct sk_buff *
> -sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, in=
t *ret,
> -                  struct net_device *orig_dev, bool *another)
> -{
> -#ifdef CONFIG_NET_CLS_ACT
> -       struct mini_Qdisc *miniq =3D rcu_dereference_bh(skb->dev->miniq_i=
ngress);
> -       struct tcf_result cl_res;
> -
> -       /* If there's at least one ingress present somewhere (so
> -        * we get here via enabled static key), remaining devices
> -        * that are not configured with an ingress qdisc will bail
> -        * out here.
> -        */
> -       if (!miniq)
> -               return skb;
> -
> -       if (*pt_prev) {
> -               *ret =3D deliver_skb(skb, *pt_prev, orig_dev);
> -               *pt_prev =3D NULL;
> -       }
> -
> -       qdisc_skb_cb(skb)->pkt_len =3D skb->len;
> -       tc_skb_cb(skb)->mru =3D 0;
> -       tc_skb_cb(skb)->post_ct =3D false;
> -       skb->tc_at_ingress =3D 1;
> -       mini_qdisc_bstats_cpu_update(miniq, skb);
> -
> -       switch (tcf_classify(skb, miniq->block, miniq->filter_list, &cl_r=
es, false)) {
> -       case TC_ACT_OK:
> -       case TC_ACT_RECLASSIFY:
> -               skb->tc_index =3D TC_H_MIN(cl_res.classid);
> -               break;
> -       case TC_ACT_SHOT:
> -               mini_qdisc_qstats_cpu_drop(miniq);
> -               kfree_skb_reason(skb, SKB_DROP_REASON_TC_INGRESS);
> -               *ret =3D NET_RX_DROP;
> -               return NULL;
> -       case TC_ACT_STOLEN:
> -       case TC_ACT_QUEUED:
> -       case TC_ACT_TRAP:
> -               consume_skb(skb);
> -               *ret =3D NET_RX_SUCCESS;
> -               return NULL;
> -       case TC_ACT_REDIRECT:
> -               /* skb_mac_header check was done by cls/act_bpf, so
> -                * we can safely push the L2 header back before
> -                * redirecting to another netdev
> -                */
> -               __skb_push(skb, skb->mac_len);
> -               if (skb_do_redirect(skb) =3D=3D -EAGAIN) {
> -                       __skb_pull(skb, skb->mac_len);
> -                       *another =3D true;
> -                       break;
> -               }
> -               *ret =3D NET_RX_SUCCESS;
> -               return NULL;
> -       case TC_ACT_CONSUMED:
> -               *ret =3D NET_RX_SUCCESS;
> -               return NULL;
> -       default:
> -               break;
> -       }
> -#endif /* CONFIG_NET_CLS_ACT */
> -       return skb;
> -}
> -
>  /**
>   *     netdev_is_rx_handler_busy - check if receive handler is registere=
d
>   *     @dev: device to check
> @@ -10834,7 +10895,7 @@ void unregister_netdevice_many_notify(struct list=
_head *head,
>
>                 /* Shutdown queueing discipline. */
>                 dev_shutdown(dev);
> -
> +               dev_tcx_uninstall(dev);
>                 dev_xdp_uninstall(dev);
>                 bpf_dev_bound_netdev_unregister(dev);
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 06ba0e56e369..e39a8a20dd10 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9312,7 +9312,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(con=
st struct bpf_prog *prog,
>         __u8 value_reg =3D si->dst_reg;
>         __u8 skb_reg =3D si->src_reg;
>
> -#ifdef CONFIG_NET_CLS_ACT
> +#ifdef CONFIG_NET_XGRESS
>         /* If the tstamp_type is read,
>          * the bpf prog is aware the tstamp could have delivery time.
>          * Thus, read skb->tstamp as is if tstamp_type_access is true.
> @@ -9346,7 +9346,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(co=
nst struct bpf_prog *prog,
>         __u8 value_reg =3D si->src_reg;
>         __u8 skb_reg =3D si->dst_reg;
>
> -#ifdef CONFIG_NET_CLS_ACT
> +#ifdef CONFIG_NET_XGRESS
>         /* If the tstamp_type is read,
>          * the bpf prog is aware the tstamp could have delivery time.
>          * Thus, write skb->tstamp as is if tstamp_type_access is true.
> diff --git a/net/sched/Kconfig b/net/sched/Kconfig
> index 4b95cb1ac435..470c70deffe2 100644
> --- a/net/sched/Kconfig
> +++ b/net/sched/Kconfig
> @@ -347,8 +347,7 @@ config NET_SCH_FQ_PIE
>  config NET_SCH_INGRESS
>         tristate "Ingress/classifier-action Qdisc"
>         depends on NET_CLS_ACT
> -       select NET_INGRESS
> -       select NET_EGRESS
> +       select NET_XGRESS
>         help
>           Say Y here if you want to use classifiers for incoming and/or o=
utgoing
>           packets. This qdisc doesn't do anything else besides running cl=
assifiers,
> @@ -679,6 +678,7 @@ config NET_EMATCH_IPT
>  config NET_CLS_ACT
>         bool "Actions"
>         select NET_CLS
> +       select NET_XGRESS
>         help
>           Say Y here if you want to use traffic control actions. Actions
>           get attached to classifiers and are invoked after a successful
> diff --git a/net/sched/sch_ingress.c b/net/sched/sch_ingress.c
> index e43a45499372..04e886f6cee4 100644
> --- a/net/sched/sch_ingress.c
> +++ b/net/sched/sch_ingress.c
> @@ -13,6 +13,7 @@
>  #include <net/netlink.h>
>  #include <net/pkt_sched.h>
>  #include <net/pkt_cls.h>
> +#include <net/tcx.h>
>
>  struct ingress_sched_data {
>         struct tcf_block *block;
> @@ -78,6 +79,8 @@ static int ingress_init(struct Qdisc *sch, struct nlatt=
r *opt,
>  {
>         struct ingress_sched_data *q =3D qdisc_priv(sch);
>         struct net_device *dev =3D qdisc_dev(sch);
> +       struct bpf_mprog_entry *entry;
> +       bool created;
>         int err;
>
>         if (sch->parent !=3D TC_H_INGRESS)
> @@ -85,7 +88,13 @@ static int ingress_init(struct Qdisc *sch, struct nlat=
tr *opt,
>
>         net_inc_ingress_queue();
>
> -       mini_qdisc_pair_init(&q->miniqp, sch, &dev->miniq_ingress);
> +       entry =3D tcx_entry_fetch_or_create(dev, true, &created);
> +       if (!entry)
> +               return -ENOMEM;
> +       tcx_miniq_set_active(entry, true);
> +       mini_qdisc_pair_init(&q->miniqp, sch, &tcx_entry(entry)->miniq);
> +       if (created)
> +               tcx_entry_update(dev, entry, true);
>
>         q->block_info.binder_type =3D FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRE=
SS;
>         q->block_info.chain_head_change =3D clsact_chain_head_change;
> @@ -103,11 +112,22 @@ static int ingress_init(struct Qdisc *sch, struct n=
lattr *opt,
>  static void ingress_destroy(struct Qdisc *sch)
>  {
>         struct ingress_sched_data *q =3D qdisc_priv(sch);
> +       struct net_device *dev =3D qdisc_dev(sch);
> +       struct bpf_mprog_entry *entry =3D rtnl_dereference(dev->tcx_ingre=
ss);
>
>         if (sch->parent !=3D TC_H_INGRESS)
>                 return;
>
>         tcf_block_put_ext(q->block, sch, &q->block_info);
> +
> +       if (entry) {
> +               tcx_miniq_set_active(entry, false);
> +               if (!tcx_entry_is_active(entry)) {
> +                       tcx_entry_update(dev, NULL, false);
> +                       tcx_entry_free(entry);
> +               }
> +       }
> +
>         net_dec_ingress_queue();
>  }
>
> @@ -223,6 +243,8 @@ static int clsact_init(struct Qdisc *sch, struct nlat=
tr *opt,
>  {
>         struct clsact_sched_data *q =3D qdisc_priv(sch);
>         struct net_device *dev =3D qdisc_dev(sch);
> +       struct bpf_mprog_entry *entry;
> +       bool created;
>         int err;
>
>         if (sch->parent !=3D TC_H_CLSACT)
> @@ -231,7 +253,13 @@ static int clsact_init(struct Qdisc *sch, struct nla=
ttr *opt,
>         net_inc_ingress_queue();
>         net_inc_egress_queue();
>
> -       mini_qdisc_pair_init(&q->miniqp_ingress, sch, &dev->miniq_ingress=
);
> +       entry =3D tcx_entry_fetch_or_create(dev, true, &created);
> +       if (!entry)
> +               return -ENOMEM;
> +       tcx_miniq_set_active(entry, true);
> +       mini_qdisc_pair_init(&q->miniqp_ingress, sch, &tcx_entry(entry)->=
miniq);
> +       if (created)
> +               tcx_entry_update(dev, entry, true);
>
>         q->ingress_block_info.binder_type =3D FLOW_BLOCK_BINDER_TYPE_CLSA=
CT_INGRESS;
>         q->ingress_block_info.chain_head_change =3D clsact_chain_head_cha=
nge;
> @@ -244,7 +272,13 @@ static int clsact_init(struct Qdisc *sch, struct nla=
ttr *opt,
>
>         mini_qdisc_pair_block_init(&q->miniqp_ingress, q->ingress_block);
>
> -       mini_qdisc_pair_init(&q->miniqp_egress, sch, &dev->miniq_egress);
> +       entry =3D tcx_entry_fetch_or_create(dev, false, &created);
> +       if (!entry)
> +               return -ENOMEM;
> +       tcx_miniq_set_active(entry, true);
> +       mini_qdisc_pair_init(&q->miniqp_egress, sch, &tcx_entry(entry)->m=
iniq);
> +       if (created)
> +               tcx_entry_update(dev, entry, false);
>
>         q->egress_block_info.binder_type =3D FLOW_BLOCK_BINDER_TYPE_CLSAC=
T_EGRESS;
>         q->egress_block_info.chain_head_change =3D clsact_chain_head_chan=
ge;
> @@ -256,12 +290,31 @@ static int clsact_init(struct Qdisc *sch, struct nl=
attr *opt,
>  static void clsact_destroy(struct Qdisc *sch)
>  {
>         struct clsact_sched_data *q =3D qdisc_priv(sch);
> +       struct net_device *dev =3D qdisc_dev(sch);
> +       struct bpf_mprog_entry *ingress_entry =3D rtnl_dereference(dev->t=
cx_ingress);
> +       struct bpf_mprog_entry *egress_entry =3D rtnl_dereference(dev->tc=
x_egress);
>
>         if (sch->parent !=3D TC_H_CLSACT)
>                 return;
>
> -       tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
>         tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
> +       tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
> +
> +       if (ingress_entry) {
> +               tcx_miniq_set_active(ingress_entry, false);
> +               if (!tcx_entry_is_active(ingress_entry)) {
> +                       tcx_entry_update(dev, NULL, true);
> +                       tcx_entry_free(ingress_entry);
> +               }
> +       }
> +
> +       if (egress_entry) {
> +               tcx_miniq_set_active(egress_entry, false);
> +               if (!tcx_entry_is_active(egress_entry)) {
> +                       tcx_entry_update(dev, NULL, false);
> +                       tcx_entry_free(egress_entry);
> +               }
> +       }
>
>         net_dec_ingress_queue();
>         net_dec_egress_queue();
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 1c166870cdf3..47b76925189f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1036,6 +1036,8 @@ enum bpf_attach_type {
>         BPF_LSM_CGROUP,
>         BPF_STRUCT_OPS,
>         BPF_NETFILTER,
> +       BPF_TCX_INGRESS,
> +       BPF_TCX_EGRESS,
>         __MAX_BPF_ATTACH_TYPE
>  };
>
> @@ -1053,7 +1055,7 @@ enum bpf_link_type {
>         BPF_LINK_TYPE_KPROBE_MULTI =3D 8,
>         BPF_LINK_TYPE_STRUCT_OPS =3D 9,
>         BPF_LINK_TYPE_NETFILTER =3D 10,
> -
> +       BPF_LINK_TYPE_TCX =3D 11,
>         MAX_BPF_LINK_TYPE,
>  };
>
> @@ -1569,13 +1571,13 @@ union bpf_attr {
>                         __u32           map_fd;         /* struct_ops to =
attach */
>                 };
>                 union {
> -                       __u32           target_fd;      /* object to atta=
ch to */
> -                       __u32           target_ifindex; /* target ifindex=
 */
> +                       __u32   target_fd;      /* target object to attac=
h to or ... */
> +                       __u32   target_ifindex; /* target ifindex */
>                 };
>                 __u32           attach_type;    /* attach type */
>                 __u32           flags;          /* extra flags */
>                 union {
> -                       __u32           target_btf_id;  /* btf_id of targ=
et to attach to */
> +                       __u32   target_btf_id;  /* btf_id of target to at=
tach to */
>                         struct {
>                                 __aligned_u64   iter_info;      /* extra =
bpf_iter_link_info */
>                                 __u32           iter_info_len;  /* iter_i=
nfo length */
> @@ -1609,6 +1611,13 @@ union bpf_attr {
>                                 __s32           priority;
>                                 __u32           flags;
>                         } netfilter;
> +                       struct {
> +                               union {
> +                                       __u32   relative_fd;
> +                                       __u32   relative_id;
> +                               };
> +                               __u64           expected_revision;
> +                       } tcx;
>                 };
>         } link_create;
>
> @@ -6217,6 +6226,19 @@ struct bpf_sock_tuple {
>         };
>  };
>
> +/* (Simplified) user return codes for tcx prog type.
> + * A valid tcx program must return one of these defined values. All othe=
r
> + * return codes are reserved for future use. Must remain compatible with
> + * their TC_ACT_* counter-parts. For compatibility in behavior, unknown
> + * return codes are mapped to TCX_NEXT.
> + */
> +enum tcx_action_base {
> +       TCX_NEXT        =3D -1,
> +       TCX_PASS        =3D 0,
> +       TCX_DROP        =3D 2,
> +       TCX_REDIRECT    =3D 7,
> +};
> +
>  struct bpf_xdp_sock {
>         __u32 queue_id;
>  };
> @@ -6499,6 +6521,10 @@ struct bpf_link_info {
>                                 } event; /* BPF_PERF_EVENT_EVENT */
>                         };
>                 } perf_event;
> +               struct {
> +                       __u32 ifindex;
> +                       __u32 attach_type;
> +               } tcx;
>         };
>  } __attribute__((aligned(8)));
>
> --
> 2.34.1
>
>


--=20
Regards
Yafang

