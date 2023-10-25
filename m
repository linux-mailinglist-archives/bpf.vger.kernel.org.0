Return-Path: <bpf+bounces-13245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842427D6D02
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF9AB21002
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D25328681;
	Wed, 25 Oct 2023 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1fHjxx/i"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFA2D61E
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 13:21:17 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C9187
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:21:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7fb84f6ceso53181687b3.1
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698240074; x=1698844874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DcoXjq91K083akiBzKmjRJ24ZfSDZ3wB0oJDf159LU=;
        b=1fHjxx/ieevHH1Ynzz/seUo73lgx7W8NTQOwtEFWq82ZkwcCatD9wij7EF3vY8eR2R
         BWVrZjli5yerBEBWANYkEvrrIbwIZ+FuqqQWlRb/0Qp+ByWN32ewTL7kGFjzFLKhXMit
         IJZzJI7nOW+2ZKO5ErDorDM6NjgDFoXTXRJuF6p4BB+9STkvhi1HVA7FKBwQqyc5iiBh
         7rDWn54TIE/oI6FZyXpz/e7+YhErw2JOyisIDb8Altc5IqQsbqvLbNZjlxriwW2fvBCJ
         jhhhLzbEon1J6YpB31Idf6A6YHdXx65aEtoYPk5hS/vG+LMo5nNEOZzuhO+U3YwdvOug
         JtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698240074; x=1698844874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DcoXjq91K083akiBzKmjRJ24ZfSDZ3wB0oJDf159LU=;
        b=IkcOK9kX126AaCc3DdsVAx6AU6BWSN99ax3F33T/G5/GePyX/L7zJV3Snj+4tndAtu
         TkD1oci/9nyXXbHh9j/FsIeJiY5PJobiNXU4HvyGd1F4xRFMlsjjINVAK1GdOWDDF2xC
         qs7pfitBkE5JFaftLT96g9sbOS0eAxrKER2iV2YOZ29SN3Zm+zJFFc2R5SSxtl0IXl8X
         3evacdEO2frkxMIW1l1CllP98rE5MLsvp30hcoBJ0q2gI5YNz3CgSuRax5mc0dQXwlEc
         fNyGJY7FzLSM6ykT71SGGP9XnnaVmt+GVwzL2p2no7tZnXOeXGm5VbqKww98ebiPDQKJ
         l3qg==
X-Gm-Message-State: AOJu0YxVaCQX+IjeoIdDqQJMKhNik2CR4Emq4By8wuC5H27zi8WdfMfb
	Gg7z5t5EZnpXc4Cz5CLm7bDuH55h5wpXHdufhPCIecJhhblajKTg
X-Google-Smtp-Source: AGHT+IE7hMas1i/UZGRzadsVtRrNQRelJ7LcBUiw5dtJ244gU7z5/nhc38cT64UtPVPDsGyjhKP7zTvMzIrjlputtiE=
X-Received: by 2002:a0d:ea93:0:b0:5a7:ba17:7109 with SMTP id
 t141-20020a0dea93000000b005a7ba177109mr13948389ywe.1.1698240074042; Wed, 25
 Oct 2023 06:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009092655.22025-1-daniel@iogearbox.net> <ZTjY959R+AFXf3Xy@shredder>
 <726368f0-bbe9-6aeb-7007-6f974ed075f2@iogearbox.net> <CAM0EoM=L3ft1zuXhMsKq=Z+u7asbvpBL-KJBXLCmHBg=6BLHzQ@mail.gmail.com>
 <87dfbac5-695c-7582-cbb5-4d71b6698ab1@iogearbox.net>
In-Reply-To: <87dfbac5-695c-7582-cbb5-4d71b6698ab1@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Oct 2023 09:21:02 -0400
Message-ID: <CAM0EoMn-BDVbOvHEd0Pww5Hx5XD3UJnyipO+9h3HKzAVAp5n0A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net, sched: Make tc-related drop reason
 more flexible
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ido Schimmel <idosch@idosch.org>, kuba@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, victor@mojatatu.com, martin.lau@linux.dev, dxu@dxuuu.xyz, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 7:52=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 10/25/23 1:05 PM, Jamal Hadi Salim wrote:
> > On Wed, Oct 25, 2023 at 6:01=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 10/25/23 10:59 AM, Ido Schimmel wrote:
> >>> On Mon, Oct 09, 2023 at 11:26:54AM +0200, Daniel Borkmann wrote:
> >>>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>>> index 606a366cc209..664426285fa3 100644
> >>>> --- a/net/core/dev.c
> >>>> +++ b/net/core/dev.c
> >>>> @@ -3910,7 +3910,8 @@ EXPORT_SYMBOL_GPL(netdev_xmit_skip_txqueue);
> >>>>    #endif /* CONFIG_NET_EGRESS */
> >>>>
> >>>>    #ifdef CONFIG_NET_XGRESS
> >>>> -static int tc_run(struct tcx_entry *entry, struct sk_buff *skb)
> >>>> +static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
> >>>> +              enum skb_drop_reason *drop_reason)
> >>>>    {
> >>>>       int ret =3D TC_ACT_UNSPEC;
> >>>>    #ifdef CONFIG_NET_CLS_ACT
> >>>> @@ -3922,12 +3923,14 @@ static int tc_run(struct tcx_entry *entry, s=
truct sk_buff *skb)
> >>>>
> >>>>       tc_skb_cb(skb)->mru =3D 0;
> >>>>       tc_skb_cb(skb)->post_ct =3D false;
> >>>> +    res.drop_reason =3D *drop_reason;
> >>>>
> >>>>       mini_qdisc_bstats_cpu_update(miniq, skb);
> >>>>       ret =3D tcf_classify(skb, miniq->block, miniq->filter_list, &r=
es, false);
> >>>>       /* Only tcf related quirks below. */
> >>>>       switch (ret) {
> >>>>       case TC_ACT_SHOT:
> >>>> +            *drop_reason =3D res.drop_reason;
> >>>
> >>> Daniel,
> >>>
> >>> Getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and this
> >>> reproducer [2]. Problem seems to be that classifiers clear 'struct
> >>> tcf_result::drop_reason', thereby triggering the warning in
> >>> __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0).
> >>>
> >>> Fixed by maintaining the original drop reason if the one returned fro=
m
> >>> tcf_classify() is 'SKB_NOT_DROPPED_YET' [3]. I can submit this fix
> >>> unless you have a better idea.
> >>
> >> Thanks for catching this, looks reasonable to me as a fix.
> >>
> >>> [1]
> >>> WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0=
x38/0x130
> >>> Modules linked in:
> >>> CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d9=
582e0 #682
> >>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.=
fc37 04/01/2014
> >>> RIP: 0010:kfree_skb_reason+0x38/0x130
> >>> [...]
> >>> Call Trace:
> >>>    <IRQ>
> >>>    __netif_receive_skb_core.constprop.0+0x837/0xdb0
> >>>    __netif_receive_skb_one_core+0x3c/0x70
> >>>    process_backlog+0x95/0x130
> >>>    __napi_poll+0x25/0x1b0
> >>>    net_rx_action+0x29b/0x310
> >>>    __do_softirq+0xc0/0x29b
> >>>    do_softirq+0x43/0x60
> >>>    </IRQ>
> >>>
> >>> [2]
> >>> #!/bin/bash
> >>>
> >>> ip link add name veth0 type veth peer name veth1
> >>> ip link set dev veth0 up
> >>> ip link set dev veth1 up
> >>> tc qdisc add dev veth1 clsact
> >>> tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11=
:22:33:44:55 action drop
> >>> mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
> >>
> >> I didn't know you're using mausezahn, nice :)
> >>
> >>> [3]
> >>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>> index a37a932a3e14..abd0b13f3f17 100644
> >>> --- a/net/core/dev.c
> >>> +++ b/net/core/dev.c
> >>> @@ -3929,7 +3929,8 @@ static int tc_run(struct tcx_entry *entry, stru=
ct sk_buff *skb,
> >>>           /* Only tcf related quirks below. */
> >>>           switch (ret) {
> >>>           case TC_ACT_SHOT:
> >>> -               *drop_reason =3D res.drop_reason;
> >>> +               if (res.drop_reason !=3D SKB_NOT_DROPPED_YET)
> >>> +                       *drop_reason =3D res.drop_reason;
> >>>                   mini_qdisc_qstats_cpu_drop(miniq);
> >>>                   break;
> >>>           case TC_ACT_OK:
> >>>
> >
> > Out of curiosity - how does the policy say "drop" but drop_reason does
> > not reflect it?
>
> Ido, Jamal, wdyt about this alternative approach - these were the locatio=
ns I could
> find from an initial glance (compile-tested) :
>
>  From a3d46a55aac484372b60b783cb6a3c98a0fef75c Mon Sep 17 00:00:00 2001
> From: Daniel Borkmann <daniel@iogearbox.net>
> Date: Wed, 25 Oct 2023 11:43:44 +0000
> Subject: [PATCH] net, sched: fix..
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   include/net/pkt_cls.h    | 12 ++++++++++++
>   net/sched/cls_basic.c    |  2 +-
>   net/sched/cls_bpf.c      |  2 +-
>   net/sched/cls_flower.c   |  2 +-
>   net/sched/cls_fw.c       |  2 +-
>   net/sched/cls_matchall.c |  2 +-
>   net/sched/cls_route.c    |  4 ++--
>   net/sched/cls_u32.c      |  2 +-
>   8 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a76c9171db0e..31d8e8587824 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct tcf_re=
sult *res,
>         res->drop_reason =3D reason;
>   }
>
> +static inline void tcf_set_result(struct tcf_result *to,
> +                                 const struct tcf_result *from)
> +{
> +       /* tcf_result's drop_reason which is the last member must be
> +        * preserved and cannot be copied from the cls'es tcf_result
> +        * template given this is carried all the way and potentially
> +        * set to a concrete tc drop reason upon error or intentional
> +        * drop. See tcf_set_drop_reason() locations.
> +        */
> +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
> +}
> +

Daniel, IMO, doing this at cls_api is best instead (like what Victors
or my original patch did). Iam ~30K feet right now with a lousy
keyboard - you can either do it, or i or Victor can send the patch by
end of day today. There are missing cases which were covered by Victor
and possibly something else will pop up next.

cheers,
jamal

>   static inline void
>   __tcf_bind_filter(struct Qdisc *q, struct tcf_result *r, unsigned long =
base)
>   {
> diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
> index 1b92c33b5f81..d7ead3fc3c45 100644
> --- a/net/sched/cls_basic.c
> +++ b/net/sched/cls_basic.c
> @@ -50,7 +50,7 @@ TC_INDIRECT_SCOPE int basic_classify(struct sk_buff *sk=
b,
>                 if (!tcf_em_tree_match(skb, &f->ematches, NULL))
>                         continue;
>                 __this_cpu_inc(f->pf->rhit);
> -               *res =3D f->res;
> +               tcf_set_result(res, &f->res);
>                 r =3D tcf_exts_exec(skb, &f->exts, res);
>                 if (r < 0)
>                         continue;
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 382c7a71f81f..e4620a462bc3 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -124,7 +124,7 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff=
 *skb,
>                         res->class   =3D 0;
>                         res->classid =3D filter_res;
>                 } else {
> -                       *res =3D prog->res;
> +                       tcf_set_result(res, &prog->res);
>                 }
>
>                 ret =3D tcf_exts_exec(skb, &prog->exts, res);
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index e5314a31f75a..eb94090fb26c 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -341,7 +341,7 @@ TC_INDIRECT_SCOPE int fl_classify(struct sk_buff *skb=
,
>
>                 f =3D fl_mask_lookup(mask, &skb_key);
>                 if (f && !tc_skip_sw(f->flags)) {
> -                       *res =3D f->res;
> +                       tcf_set_result(res, &f->res);
>                         return tcf_exts_exec(skb, &f->exts, res);
>                 }
>         }
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index c49d6af0e048..70b873f8771f 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -63,7 +63,7 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
>                 for (f =3D rcu_dereference_bh(head->ht[fw_hash(id)]); f;
>                      f =3D rcu_dereference_bh(f->next)) {
>                         if (f->id =3D=3D id) {
> -                               *res =3D f->res;
> +                               tcf_set_result(res, &f->res);
>                                 if (!tcf_match_indev(skb, f->ifindex))
>                                         continue;
>                                 r =3D tcf_exts_exec(skb, &f->exts, res);
> diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
> index c4ed11df6254..a4018db80a60 100644
> --- a/net/sched/cls_matchall.c
> +++ b/net/sched/cls_matchall.c
> @@ -37,7 +37,7 @@ TC_INDIRECT_SCOPE int mall_classify(struct sk_buff *skb=
,
>         if (tc_skip_sw(head->flags))
>                 return -1;
>
> -       *res =3D head->res;
> +       tcf_set_result(res, &head->res);
>         __this_cpu_inc(head->pf->rhit);
>         return tcf_exts_exec(skb, &head->exts, res);
>   }
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index 1424bfeaca73..cbfaa1d1820f 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -109,7 +109,7 @@ static inline int route4_hash_wild(void)
>
>   #define ROUTE4_APPLY_RESULT()                                 \
>   {                                                             \
> -       *res =3D f->res;                                          \
> +       tcf_set_result(res, &f->res);                           \
>         if (tcf_exts_has_actions(&f->exts)) {                   \
>                 int r =3D tcf_exts_exec(skb, &f->exts, res);      \
>                 if (r < 0) {                                    \
> @@ -152,7 +152,7 @@ TC_INDIRECT_SCOPE int route4_classify(struct sk_buff =
*skb,
>                         goto failure;
>                 }
>
> -               *res =3D f->res;
> +               tcf_set_result(res, &f->res);
>                 spin_unlock(&fastmap_lock);
>                 return 0;
>         }
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 6663e971a13e..f50ae40a29d5 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -172,7 +172,7 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *sk=
b,
>   check_terminal:
>                         if (n->sel.flags & TC_U32_TERMINAL) {
>
> -                               *res =3D n->res;
> +                               tcf_set_result(res, &n->res);
>                                 if (!tcf_match_indev(skb, n->ifindex)) {
>                                         n =3D rcu_dereference_bh(n->next)=
;
>                                         goto next_knode;
> --
> 2.34.1
>

