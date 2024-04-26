Return-Path: <bpf+bounces-27872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F08B2DE7
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 02:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7091C218BB
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F67FB;
	Fri, 26 Apr 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="befZIWjK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A33364
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090589; cv=none; b=H+wLb8CnDZOxqtD6Nglp5fBNLSsCddybfYMI8veFtbKsBMf4Ii8yvGRrk7azqq7iDJpf2TbbTRJZ/NwzlgMN5N/fQptvOKBUfGAGpgZ+jlXtNzv2DvEMDHjTc8xq+KEfZ56FnTgT3gvX3YX/rsOxPkcsirKfbCh0kAXWcKg+zgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090589; c=relaxed/simple;
	bh=t8FY9Kmq7Rt7p6yaY71p9hZvXEQh+ib7wRfsYLEpy6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeyOi09ug6UWVM8IjZWoYY1u9DebBYVNSVz3ISHDEuiGO0wZNMFBFu+vJ+EQi0OQj/yz+ofHrdkurolzSAPn4kX5erV7eFdxpnoNCboy1fTbtAcyQwlTwfKK21byzWXXFWBc0x6mJDcVcf4/TbOP2lL2mQB+WAlDgM366uuML10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=befZIWjK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso2721a12.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 17:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714090586; x=1714695386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP+e8G/Rry91TMiL3AEua7gS93ylF2WQ2Cbp+DTXBOY=;
        b=befZIWjKAIgrTL5MKO7qPXhDVjKYSz7ndwztGjDRmrT7Vmu7QuLyD5YAvL6mq+RZN3
         AlRjHFRHC7/9gT2j6sjif6wBRU7ReuaVkABG7xzU/XcrupMqjQG2Z7CqAQq+MC6eg856
         wpzj7Pt3FPi/IRi/7kweVkjKxs/ra32Jtrf+s55YRQreaFhuQ/f44gCiVECG3EHSlD/s
         0nkH8DUqP/fE2/CdFC8OP9tBLnyINShpr2U6eCImjaQAwWH8V6StCXbSJ39T4EjYhET0
         f3WaHOKaoPW/G4WJtxA7ZqotPETTwGTi2/kqKmOncedN5VOmHpn2kvpMDqy8hZ43GWcc
         YoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714090586; x=1714695386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wP+e8G/Rry91TMiL3AEua7gS93ylF2WQ2Cbp+DTXBOY=;
        b=vYSQUdPlV+cAF6EhFqF4PVGVYqgKXqnS41KEReZeOzHZPkPExoL5qQkJG6m2a+uFl5
         lvQB135k+AG34oeO3ZyuyltH0YvlLVTT7gK0weY2ASI9OIsbJZL2P6UT333hBqXOrQc2
         yNIjRZK5pd1eIqX1bESdOzuET9PeLwvZmffVkQTkEcoKu8Gap2oPRcaQU22Q6fDNevqN
         EEVQ+8QqfSGXtYGjSYzDSPTwEdC651joOrv4q6PzyyiZ9JgftaAP6Yt1qk4JM+VtidEJ
         cP5i8CaENzUimo5m/NfCxP3yzC6MQaTgF9wewZPPRYytH00FOheOHtvwSl9DqlHGWkHO
         xCVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxs2e6pOtMoQ8ToD1+FS5Jcm1ue6iWIpGueyUHjF/r9ibOYSMAbahFiwxv222/N6PWmkfnZWUqNVy4RW3DdExOtihb
X-Gm-Message-State: AOJu0Yyd0Au2h068C4udDPCbMDeF2rtnBIo/9YACRu36KD29L1vGpP+5
	zNu4KZXLXS0DpKI429N9DwwMZE98b1GVOGx6u3cwI9u3ySELy6ok8BiwIy4vA5Nsh6NizOy4skl
	rKGSXUYKolpGtK7uWr8uoEWRRxkk6JWEApJS3
X-Google-Smtp-Source: AGHT+IFJYrclXgYqm60zhB28uv/s+5+k5UqHGn8RIJiOJvzezWSOKJqiT68gDpiEBQAwTYhy/xvsvKLmlZugn5oFO28=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr764edd.2.1714090585829; Thu, 25 Apr
 2024 17:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch> <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch> <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch> <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch> <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch> <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch> <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
In-Reply-To: <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 25 Apr 2024 17:16:08 -0700
Message-ID: <CANP3RGeOmrawPUmWeo5VLnzUt3cwDE6pDp3D9d8_xqwicghXpA@mail.gmail.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without fraglist
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	=?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "yan@cloudflare.com" <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:33=E2=80=AFPM Lena Wang (=E7=8E=8B=E5=A8=9C) <Len=
a.Wang@mediatek.com> wrote:
>
> On Wed, 2024-04-24 at 10:28 -0400, Willem de Bruijn wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> > Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > > On Tue, 2024-04-23 at 14:35 -0400, Willem de Bruijn wrote:
> > > >
> > > > External email : Please do not click links or open attachments
> > until
> > > > you have verified the sender or the content.
> > > >  > Hi Willem,
> > > > > As the discussion, is it OK for the patch below?
> > > >
> > > > Thanks for iterating on this.
> > > >
> > > > I would like the opinion also of the fraglist and UDP GRO
> > experts.
> > > >
> > > > Yes, I think both
> > > >
> > > > - protecting skb_segment_list against clearly illegal fraglist
> > > > packets, and
> > > > - blocking BPF from constructing such packets
> > > >
> > > > are worthwhile stable fixes. I believe they should be two
> > separate
> > > > patches. Both probably with the same Fixes tag: 3a1296a38d0c
> > > > ("net: Support GRO/GSO fraglist chaining").
> > > >
> > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > index 3a6110ea4009..abc6029c8eef 100644
> > > > > --- a/net/core/filter.c
> > > > > +++ b/net/core/filter.c
> > > > > @@ -1655,6 +1655,11 @@ static DEFINE_PER_CPU(struct
> > bpf_scratchpad,
> > > > > bpf_sp);
> > > > >  static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > > > >                                           unsigned int
> > write_len)
> > > > >  {
> > > > > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > > > +                       SKB_GSO_FRAGLIST) && (write_len >
> > > > > skb_headlen(skb))) {
> > > > > +               return -ENOMEM;
> > > > > +       }
> > > > > +
> > > >
> > > > Indentation looks off, but I agree with the logic.
> > > >
> > > >     if (skb_is_gso(skb) &&
> > > >         (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> > > >          (write_len > skb_headlen(skb)))
> > > >
> > > > >         return skb_ensure_writable(skb, write_len);
> > > > >  }
> > > > >
> > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > index 73b1e0e53534..2e90534c1a1e 100644
> > > > > --- a/net/core/skbuff.c
> > > > > +++ b/net/core/skbuff.c
> > > > > @@ -4036,9 +4036,11 @@ struct sk_buff *skb_segment_list(struct
> > > > sk_buff
> > > > > *skb,
> > > > >         unsigned int tnl_hlen =3D skb_tnl_header_len(skb);
> > > > >         unsigned int delta_truesize =3D 0;
> > > > >         unsigned int delta_len =3D 0;
> > > > > +       unsigned int mss =3D skb_shinfo(skb)->gso_size;
> > > > >         struct sk_buff *tail =3D NULL;
> > > > >         struct sk_buff *nskb, *tmp;
> > > > >         int len_diff, err;
> > > > > +       bool err_len =3D false;
> > > > >
> > > > >         skb_push(skb, -skb_network_offset(skb) + offset);
> > > > >
> > > > > @@ -4047,6 +4049,14 @@ struct sk_buff *skb_segment_list(struct
> > > > sk_buff
> > > > > *skb,
> > > > >         if (err)
> > > > >                 goto err_linearize;
> > > > >
> > > > > +       if (mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(skb)) {
> > > > > +               if (!list_skb) {
> > > > > +                       goto err_linearize;
> > > >
> > > > The label no longer truly covers the meaning.
> > > >
> > > > But that is already true since the above (second) jump was added
> > in
> > > > commit c329b261afe7 ("net: prevent skb corruption on frag list
> > > > segmentation").
> > > >
> > > > Neither needs the kfree_skb_list, as skb->next is not assigned to
> > > > until the loop. Can just return ERR_PTR(-EFAULT)?
> > > >
> > > > > +               } else {
> > > > > +                       err_len =3D true;
> > > > > +               }
> > > > > +       }
> > > > > +
> > > >
> > > > Why the branch? Might as well always fail immediately?
> > > >
> > > Hi Willem,
> > > Thanks for your guidance.
> > > You are right. There is no need for another branch as fraglist
> > > could be freeed in kfree_skb.
> > > Could I git send mail wo patches as below?
> > >
> > > From 933237400c0e2fa997470b70ff0e407996fa239c Mon Sep 17 00:00:00
> > 2001
> > > From: Shiming Cheng <shiming.cheng@mediatek.com>
> > > Date: Wed, 24 Apr 2024 13:42:35 +0800
> > > Subject: [PATCH net] net: prevent BPF pull GROed skb's fraglist
> > >
> > > A GROed skb with fraglist can't be pulled data
> >
> > Please use the specific label: SKB_GSO_FRAGLIST skb
> >
> > > from its fraglist as it may result a invalid
> > > segmentation or kernel exception.
> > >
> > > For such structured skb we limit the BPF pull
> > > data length smaller than skb_headlen() and return
> > > error if exceeding.
> > >
> > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > ---
> > >  net/core/filter.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 8adf95765cdd..8ed4d5d87167 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,
> > > bpf_sp);
> > >  static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > >    unsigned int write_len)
> > >  {
> > > +if (skb_is_gso(skb) &&
> > > +    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> > > +     write_len > skb_headlen(skb)) {
> > > +return -ENOMEM;
> > > +}
> > >  return skb_ensure_writable(skb, write_len);
> > >  }
> > >
> > > --
> > > 2.18.0
> > >
> > >
> > > From 2d0729b20cf810ba1b31e046952c1cd78f295ca3 Mon Sep 17 00:00:00
> > 2001
> > > From: Shiming Cheng <shiming.cheng@mediatek.com>
> > > Date: Wed, 24 Apr 2024 14:43:45 +0800
> > > Subject: [PATCH net] net: drop GROed skb pulled from fraglist
> > >
> > > A GROed skb with fraglist maybe pulled by BPF
> > > or other ways. It can't be trusted at all even
> > > if one byte is pulled and should be dropped
> > > on segmentation.
> >
> > This paraphrases my comment. It is better to spell it out:
> >
> > An SKB_GSO_FRAGLIST skb without GSO_BY_FRAGS is expected to have all
> > segments except the last to be gso_size long. If this does not hold,
> > the skb has been modified and the fraglist gso integrity is lost.
> > Drop
> > the packet, as it cannot be segmented correctly by skb_segment_list.
> >
> > The skb could be salvaged, though, right? By linearizing, dropping
> > the SKB_GSO_FRAGLIST bit and entering the normal skb_segment path
> > rather than the skb_segment_list path.
> >
> > That choice is currently made in the protocol caller,
> > __udp_gso_segment. It's not trivial to add such a backup path here.
> > So let's add this backstop against kernel crashes.
> >
> > >
> > > If the gso_size does not match skb_headlen(),
> > > it means to be pulled part of or the entire
> > > fraglsit. It has been messed with and we return
> >
> > fraglist
> >
> > > error to free this skb.
> > >
> > > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > > Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> > > Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> > > ---
> > >  net/core/skbuff.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index b99127712e67..750fbb51b99f 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -4493,6 +4493,7 @@ struct sk_buff *skb_segment_list(struct
> > sk_buff
> > > *skb,
> > >  unsigned int tnl_hlen =3D skb_tnl_header_len(skb);
> > >  unsigned int delta_truesize =3D 0;
> > >  unsigned int delta_len =3D 0;
> > > +unsigned int mss =3D skb_shinfo(skb)->gso_size;
> >
> > Reverse christmas tree
> >
> > >  struct sk_buff *tail =3D NULL;
> > >  struct sk_buff *nskb, *tmp;
> > >  int len_diff, err;
> > > @@ -4504,6 +4505,9 @@ struct sk_buff *skb_segment_list(struct
> > sk_buff
> > > *skb,
> > >  if (err)
> > >  goto err_linearize;
> > >
> > > +if (mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(skb))
> > > +return ERR_PTR(-EFAULT);
> > > +
> >
> > Do this precondition integrity check before the skb_unclone path?
>
> After return error, the skb will enter into kfree_skb, not consume_skb.
> It may meet same crash problem which has been resolved by skb_unclone.
>
> Or kfree_skb could well handle the cloned skb's release?
>
> Other changes are updated as below:
>
> From 301da5c9d65652bac6091d4cd64b751b3338f8bb Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Wed, 24 Apr 2024 13:42:35 +0800
> Subject: [PATCH net] net: prevent BPF pulling SKB_GSO_FRAGLIST skb
>
> A SKB_GSO_FRAGLIST skb can't be pulled data
> from its fraglist as it may result an invalid
> segmentation or kernel exception.
>
> For such structured skb we limit the BPF pulling
> data length smaller than skb_headlen() and return
> error if exceeding.
>
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  net/core/filter.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8adf95765cdd..8ed4d5d87167 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,
> bpf_sp);
>  static inline int __bpf_try_make_writable(struct sk_buff *skb,
>                                           unsigned int write_len)
>  {
> +       if (skb_is_gso(skb) &&
> +           (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> +            write_len > skb_headlen(skb)) {

at least call:
  skb_ensure_writable(skb, skb_headlen(skb));
here before you return the error to make sure the already linear
header portion is writable.
(the skb could be a clone with a r/o header afaict)

> +               return -ENOMEM;
> +       }
>         return skb_ensure_writable(skb, write_len);
>  }
>
> --
> 2.18.0
>
>
> From 64d55392debbc90ef2e9c33441024d612075bdd7 Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Wed, 24 Apr 2024 14:43:45 +0800
> Subject: [PATCH net] net: drop pulled SKB_GSO_FRAGLIST skb
>
> A SKB_GSO_FRAGLIST skb without GSO_BY_FRAGS is
> expected to have all segments except the last
> to be gso_size long. If this does not hold, the
> skb has been modified and the fraglist gso integrity
> is lost. Drop the packet, as it cannot be segmented
> correctly by skb_segment_list.
>
> The skb could be salvaged, though, right?
> By linearizing, dropping the SKB_GSO_FRAGLIST bit
> and entering the normal skb_segment path rather than
> the skb_segment_list path.
>
> That choice is currently made in the protocol caller,
> __udp_gso_segment. It's not trivial to add such a
> backup path here. So let's add this backstop against
> kernel crashes.
>
> If the gso_size does not match skb_headlen(),
> it means part of or the entire fraglist has been pulled.
> It has been messed with and we should return error to
> free this skb.
>
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  net/core/skbuff.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b99127712e67..4777f5fea6c3 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4491,6 +4491,7 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>  {
>         struct sk_buff *list_skb =3D skb_shinfo(skb)->frag_list;
>         unsigned int tnl_hlen =3D skb_tnl_header_len(skb);
> +       unsigned int mss =3D skb_shinfo(skb)->gso_size;
>         unsigned int delta_truesize =3D 0;
>         unsigned int delta_len =3D 0;
>         struct sk_buff *tail =3D NULL;
> @@ -4504,6 +4505,9 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>         if (err)
>                 goto err_linearize;
>
> +       if (mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(skb))
> +               return ERR_PTR(-EFAULT);
> +
>         skb_shinfo(skb)->frag_list =3D NULL;
>
>         while (list_skb) {
> --
> 2.18.0

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

