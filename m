Return-Path: <bpf+bounces-9027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874AD78E6E6
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 08:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813581C20928
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 06:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506D5250;
	Thu, 31 Aug 2023 06:59:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C701FDC
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 06:59:07 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450CACE0
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:59:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40a47e8e38dso166661cf.1
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693465142; x=1694069942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOHsH3FuQowJe3RoNYbiGF4iqcicBzMr1cRMvpWiXTQ=;
        b=N0Kn0kBUW7GQcWOxBKp0dYup+961GEeN1OQbG++hieEcHPXePKfg5DMMJ+feZS/edj
         roCcpeonzC+PlFqvg6kRI/it4mCbd12Z+Hr5iNflkQtcnuUYmqluMlCetIT00M44goBm
         nhq6fLqhb0a6bgQseyKf+QhIDHK62USozzl+sJOp3aRE99l6nmDEaarFFm6ZjIQTkpK8
         VbcDcKda8DTqa1yZp5SLiDVlr2H6FeNx0NMolnjH7U21/aIFSM4ST5aPs41q5EZzKij9
         qjrhOP8ppjeJohHh202B6qtvtIeVpp3GiuXGFSxJ+YM8JcFz1ZZLWKbYtFdirlEUSbkK
         K8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693465142; x=1694069942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOHsH3FuQowJe3RoNYbiGF4iqcicBzMr1cRMvpWiXTQ=;
        b=Bm1D+v58lpJk5ymnn8QgAAPLJ7ijk3CTvFYhqWohX7zZ3T0M6UGpDuh2hmkAAPQ7bM
         yTPV7b1Q05rjl8oca7AKNk1mFw0mNJqQT8P1xtlV490lYWsXUgblVUoDMCzihmmT6DfG
         /UV1akIDxzl3oXr3KyiTLCJRJvr2uTpGD8066gVKBFjqvd6/wYnu50SHPdI6UADLBp0L
         b9P354rKW4eVBmyvW9d9OuRAndYNKyfz0gsgtdXy15K2yBj+21FTLCUtOA6EtNK+8sXC
         UqCpeSNxwj4IIJQniLR2IQLZqsj13K86NpEX5gjRLP3goDMr16VfWx48H9/4WenqlXNh
         bWkQ==
X-Gm-Message-State: AOJu0Yybm9bIWM9E/UtSJxQ3CU5APotKeDRezBBuhT2/fk2Uu8n5002w
	WQSjT/lAtuXP62n4TxQy2bNyIcJYVWAMe2kWrZfqUg==
X-Google-Smtp-Source: AGHT+IGBcKysU77vcTgjUTs8+44BbI/uugse6nl0ocYjxaZcPVstg2ZhvTc+/xgphGEcs8NpbooKk0RdkM8FCGYaI3g=
X-Received: by 2002:ac8:7f0c:0:b0:3f5:2006:50f1 with SMTP id
 f12-20020ac87f0c000000b003f5200650f1mr210597qtk.12.1693465142241; Wed, 30 Aug
 2023 23:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <64ed7188a2745_9cf208e1@penguin.notmuch> <20230830232811.9876-1-mkhalfella@purestorage.com>
In-Reply-To: <20230830232811.9876-1-mkhalfella@purestorage.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Aug 2023 08:58:51 +0200
Message-ID: <CANn89iJVnS_dGDtU7AVWgVrun-p68DZ0A3Pde47MHNeeQ2nwRA@mail.gmail.com>
Subject: Re: [PATCH v2] skbuff: skb_segment, Call zero copy functions before
 using skbuff frags
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: willemdebruijn.kernel@gmail.com, alexanderduyck@fb.com, 
	bpf@vger.kernel.org, brouer@redhat.com, davem@davemloft.net, 
	dhowells@redhat.com, keescook@chromium.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	willemb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 1:28=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Commit bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions
> once per nskb") added the call to zero copy functions in skb_segment().
> The change introduced a bug in skb_segment() because skb_orphan_frags()
> may possibly change the number of fragments or allocate new fragments
> altogether leaving nrfrags and frag to point to the old values. This can
> cause a panic with stacktrace like the one below.
>
> [  193.894380] BUG: kernel NULL pointer dereference, address: 00000000000=
000bc
> [  193.895273] CPU: 13 PID: 18164 Comm: vh-net-17428 Kdump: loaded Tainte=
d: G           O      5.15.123+ #26
> [  193.903919] RIP: 0010:skb_segment+0xb0e/0x12f0
> [  194.021892] Call Trace:
> [  194.027422]  <TASK>
> [  194.072861]  tcp_gso_segment+0x107/0x540
> [  194.082031]  inet_gso_segment+0x15c/0x3d0
> [  194.090783]  skb_mac_gso_segment+0x9f/0x110
> [  194.095016]  __skb_gso_segment+0xc1/0x190
> [  194.103131]  netem_enqueue+0x290/0xb10 [sch_netem]
> [  194.107071]  dev_qdisc_enqueue+0x16/0x70
> [  194.110884]  __dev_queue_xmit+0x63b/0xb30
> [  194.121670]  bond_start_xmit+0x159/0x380 [bonding]
> [  194.128506]  dev_hard_start_xmit+0xc3/0x1e0
> [  194.131787]  __dev_queue_xmit+0x8a0/0xb30
> [  194.138225]  macvlan_start_xmit+0x4f/0x100 [macvlan]
> [  194.141477]  dev_hard_start_xmit+0xc3/0x1e0
> [  194.144622]  sch_direct_xmit+0xe3/0x280
> [  194.147748]  __dev_queue_xmit+0x54a/0xb30
> [  194.154131]  tap_get_user+0x2a8/0x9c0 [tap]
> [  194.157358]  tap_sendmsg+0x52/0x8e0 [tap]
> [  194.167049]  handle_tx_zerocopy+0x14e/0x4c0 [vhost_net]
> [  194.173631]  handle_tx+0xcd/0xe0 [vhost_net]
> [  194.176959]  vhost_worker+0x76/0xb0 [vhost]
> [  194.183667]  kthread+0x118/0x140
> [  194.190358]  ret_from_fork+0x1f/0x30
> [  194.193670]  </TASK>
>
> In this case calling skb_orphan_frags() updated nr_frags leaving nrfrags
> local variable in skb_segment() stale. This resulted in the code hitting
> i >=3D nrfrags prematurely and trying to move to next frag_skb using
> list_skb pointer, which was NULL, and caused kernel panic. Move the call
> to zero copy functions before using frags and nr_frags.
>
> Fixes: bf5c25d60861 ("skbuff: in skb_segment, call zerocopy functions onc=
e per nskb")
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reported-by: Amit Goyal <agoyal@purestorage.com>
> Cc: stable@vger.kernel.org
> ---
>  net/core/skbuff.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a298992060e6..18a33dc2d6af 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4354,21 +4354,20 @@ struct sk_buff *skb_segment(struct sk_buff *head_=
skb,
>         struct sk_buff *segs =3D NULL;
>         struct sk_buff *tail =3D NULL;
>         struct sk_buff *list_skb =3D skb_shinfo(head_skb)->frag_list;
> -       skb_frag_t *frag =3D skb_shinfo(head_skb)->frags;
>         unsigned int mss =3D skb_shinfo(head_skb)->gso_size;
>         unsigned int doffset =3D head_skb->data - skb_mac_header(head_skb=
);
> -       struct sk_buff *frag_skb =3D head_skb;
>         unsigned int offset =3D doffset;
>         unsigned int tnl_hlen =3D skb_tnl_header_len(head_skb);
>         unsigned int partial_segs =3D 0;
>         unsigned int headroom;
>         unsigned int len =3D head_skb->len;
> +       struct sk_buff *frag_skb;
> +       skb_frag_t *frag;
>         __be16 proto;
>         bool csum, sg;
> -       int nfrags =3D skb_shinfo(head_skb)->nr_frags;
>         int err =3D -ENOMEM;
>         int i =3D 0;
> -       int pos;
> +       int nfrags, pos;
>
>         if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
>             mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(head_skb)) {
> @@ -4445,6 +4444,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_s=
kb,
>         headroom =3D skb_headroom(head_skb);
>         pos =3D skb_headlen(head_skb);
>
> +       if (skb_orphan_frags(head_skb, GFP_ATOMIC))
> +               return ERR_PTR(-ENOMEM);
> +
> +       nfrags =3D skb_shinfo(head_skb)->nr_frags;
> +       frag =3D skb_shinfo(head_skb)->frags;
> +       frag_skb =3D head_skb;
> +
>         do {
>                 struct sk_buff *nskb;
>                 skb_frag_t *nskb_frag;
> @@ -4465,6 +4471,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_s=
kb,
>                     (skb_headlen(list_skb) =3D=3D len || sg)) {
>                         BUG_ON(skb_headlen(list_skb) > len);
>
> +                       nskb =3D skb_clone(list_skb, GFP_ATOMIC);
> +                       if (unlikely(!nskb))
> +                               goto err;
> +

This patch is quite complex to review, so I am asking if this part was
really needed ?
<1>  : You moved here <2> and <3>

If this is not strictly needed, please keep the code as is to ease
code review...

>                         i =3D 0;
>                         nfrags =3D skb_shinfo(list_skb)->nr_frags;
>                         frag =3D skb_shinfo(list_skb)->frags;
> @@ -4483,12 +4493,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_s=
kb,
>                                 frag++;
>                         }
>
> -                       nskb =3D skb_clone(list_skb, GFP_ATOMIC);

<2>

>                         list_skb =3D list_skb->next;
>
> -                       if (unlikely(!nskb))
> -                               goto err;
> -

<3>

>                         if (unlikely(pskb_trim(nskb, len))) {
>                                 kfree_skb(nskb);
>                                 goto err;
> @@ -4564,12 +4570,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_=
skb,
>                 skb_shinfo(nskb)->flags |=3D skb_shinfo(head_skb)->flags =
&
>                                            SKBFL_SHARED_FRAG;
>
> -               if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
> -                   skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> +               if (skb_zerocopy_clone(nskb, list_skb, GFP_ATOMIC))

Why using list_skb here instead of frag_skb ?
Again, I have to look at the whole thing to understand why you did this.

>                         goto err;
>
>                 while (pos < offset + len) {
>                         if (i >=3D nfrags) {
> +                               if (skb_orphan_frags(list_skb, GFP_ATOMIC=
) ||
> +                                   skb_zerocopy_clone(nskb, list_skb,
> +                                                      GFP_ATOMIC))
> +                                       goto err;
> +

This part is fine.

>                                 i =3D 0;
>                                 nfrags =3D skb_shinfo(list_skb)->nr_frags=
;
>                                 frag =3D skb_shinfo(list_skb)->frags;
> @@ -4583,10 +4593,6 @@ struct sk_buff *skb_segment(struct sk_buff *head_s=
kb,
>                                         i--;
>                                         frag--;
>                                 }
> -                               if (skb_orphan_frags(frag_skb, GFP_ATOMIC=
) ||
> -                                   skb_zerocopy_clone(nskb, frag_skb,
> -                                                      GFP_ATOMIC))
> -                                       goto err;
>
>                                 list_skb =3D list_skb->next;
>                         }
> --
> 2.17.1
>

Thanks.

