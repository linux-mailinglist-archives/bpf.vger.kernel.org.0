Return-Path: <bpf+bounces-27683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE378B0C7D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 16:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB51C228C1
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14215ECD4;
	Wed, 24 Apr 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCXx7KF/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9515E5DC;
	Wed, 24 Apr 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968922; cv=none; b=crzdTvqW2QY7dkNNYsznUNP+kpOXc/3Jo2x+SFXkygE99eOx/q+VcVu1roGmE0lKkgVu3CCqnqNrcmKlFvuptuEbgC4P9Vpwf9EufW9j33LPgd6MoaPc+XOZYfjCCmyNVIFgUVjT16J+BaVewkYVC4+/bXwN00hQpVCsrAfjwUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968922; c=relaxed/simple;
	bh=fWNCwTBeHnWPsJO2PuXUx7j03eivAZQK+G64LXNipyw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ex7vaNPArZu+kS6YICg7bP2vWZ/HTcOT36DLmlcF793OcSDiU/prRkra1JiIFme8Un5qZVRc1B/LW3LiWUeWK51xVKi56PbxvAeztjelK5ZDTtIQ7nG8eYV4Ul4iDJBfCwDLR/cmGkqyZhhg50frdW8XH/itT+Y8jz67JFP9XI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCXx7KF/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f056f0a53so444624785a.1;
        Wed, 24 Apr 2024 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713968919; x=1714573719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/creugiZa1xrY7IRUlJHZS/NY0GGYk5C6VbMfHG46s=;
        b=GCXx7KF/ofjCN66B2Rumgc5Nj2Y1ZnjB1VvRpzF10TK5OAdkCmP2rsRxq//ce4XYzw
         iU+2VxBlWVgP1r3UBUTaeIVhcrR42KPeEg2KzeES7tDvxmKAaHFnW0ElPsCR8V0vg1ZB
         VEtHCot6SM6LhRt8xyjtEx7zwgy21i3Pb7egOHfDt4BIteQRnRRbswrV+BEtL7qbVbyn
         4YLOHn94g7M1hV342tXGH+yp/rxWSkZy3FAy/3Vxtja4QSGkJHD+6L2adq3jDrWLR7Y0
         aOn6mdWXDd9sUemjzgc/HCQNZGZnL8DXJjbAu+F2lKJs1JU5WoHVcbxUGyG820Wm25K4
         wN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968919; x=1714573719;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/creugiZa1xrY7IRUlJHZS/NY0GGYk5C6VbMfHG46s=;
        b=kGJeZns7YXTaLiVQgXMYWYt3h7T0OowsGMpwxKaMf+LMxZD3cA90kI0HWoEm9HKL4u
         LDCw60ep73d4ac2aetUxtTq4QZmAIEVujgQGRKvJF4PbXf5w7FHYRmwZTANxKUZWLEEB
         0Nceep54jsfzNuRvBQJahH2NL9PVJ55FpJbO8Y+NS14D7sX9P5ZiP7Siz1lawACSViko
         q2PHjxSeSrCOO7p3Vs/x2AT5CzEbflOSwSSQLF0ZBiqJT7vlj+AYDdt29gYEcuPpnca2
         p/ma1pqSNb5cSTAHwvVzfikWQbe32fq8GImOC83+xQwJEHoICSCh9nYqOZtxyg8DvvbU
         fo2w==
X-Forwarded-Encrypted: i=1; AJvYcCWkNz7SVdDiItUauw4V7m1rpbnlXFrghFjtPkioAwfcLZKFgiyHKlpR5a9LIPgKG/qMLZxkcXdNOiX8nLj3EOJVz/z+Es5E+6npyQFw3jzhf/FwedqrmOQt+6QQ
X-Gm-Message-State: AOJu0YykCvyXRQlJ9yw0YkIzQ4dJp8knbKclTJlTJS5Oj1ZwAgmrTc0J
	4HPIDkzi/9ZepGkxWu6o3+u1anE6GX+vYTWBzo3+MMGLnop64oI9
X-Google-Smtp-Source: AGHT+IG1WjMAZfgZbp47tNmeo6s8SJOtFZXLaCkoLkgxpsAf7QdzDndHugN35V/CTFXCskItPCK6jw==
X-Received: by 2002:a05:620a:f0b:b0:78e:c9af:931d with SMTP id v11-20020a05620a0f0b00b0078ec9af931dmr3194687qkl.5.1713968919525;
        Wed, 24 Apr 2024 07:28:39 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id qp2-20020a05620a388200b0079094645c16sm170003qkn.55.2024.04.24.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:28:39 -0700 (PDT)
Date: Wed, 24 Apr 2024 10:28:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "maze@google.com" <maze@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "yan@cloudflare.com" <yan@cloudflare.com>
Message-ID: <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
In-Reply-To: <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
 <65e3e88a53d466cf5bad04e5c7bc3f1648b82fd7.camel@mediatek.com>
 <CANP3RGdkxT4TjeSvv1ftXOdFQd5Z4qLK1DbzwATq_t_Dk+V8ig@mail.gmail.com>
 <661eb25eeb09e_6672129490@willemb.c.googlers.com.notmuch>
 <CANP3RGdrRDERiPFVQ1nZYVtopErjqOQ72qQ_+ijGQiL7bTtcLQ@mail.gmail.com>
 <CANP3RGd+Zd-bx6S-NzeGch_crRK2w0-u6xwSVn71M581uCp9cQ@mail.gmail.com>
 <661f066060ab4_7a39f2945d@willemb.c.googlers.com.notmuch>
 <77068ef60212e71b270281b2ccd86c8c28ee6be3.camel@mediatek.com>
 <662027965bdb1_c8647294b3@willemb.c.googlers.com.notmuch>
 <11395231f8be21718f89981ffe3703da3f829742.camel@mediatek.com>
 <CANP3RGdh24xyH2V7Sa2fs9Ca=tiZNBdKu1qQ8LFHS3sY41CxmA@mail.gmail.com>
 <b24bc70ae2c50dc50089c45afbed34904f3ee189.camel@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> On Tue, 2024-04-23 at 14:35 -0400, Willem de Bruijn wrote:
> >  	 =

> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  > Hi Willem,
> > > As the discussion, is it OK for the patch below?
> > =

> > Thanks for iterating on this.
> > =

> > I would like the opinion also of the fraglist and UDP GRO experts.
> >  =

> > Yes, I think both
> > =

> > - protecting skb_segment_list against clearly illegal fraglist
> > packets, and
> > - blocking BPF from constructing such packets
> > =

> > are worthwhile stable fixes. I believe they should be two separate
> > patches. Both probably with the same Fixes tag: 3a1296a38d0c
> > ("net: Support GRO/GSO fraglist chaining").
> > =

> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 3a6110ea4009..abc6029c8eef 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -1655,6 +1655,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,=

> > > bpf_sp);
> > >  static inline int __bpf_try_make_writable(struct sk_buff *skb,
> > >                                           unsigned int write_len)
> > >  {
> > > +       if (skb_is_gso(skb) && (skb_shinfo(skb)->gso_type &
> > > +                       SKB_GSO_FRAGLIST) && (write_len >
> > > skb_headlen(skb))) {
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > =

> > Indentation looks off, but I agree with the logic.
> > =

> >     if (skb_is_gso(skb) &&
> >         (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> >          (write_len > skb_headlen(skb)))
> > =

> > >         return skb_ensure_writable(skb, write_len);
> > >  }
> > > =

> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 73b1e0e53534..2e90534c1a1e 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -4036,9 +4036,11 @@ struct sk_buff *skb_segment_list(struct
> > sk_buff
> > > *skb,
> > >         unsigned int tnl_hlen =3D skb_tnl_header_len(skb);
> > >         unsigned int delta_truesize =3D 0;
> > >         unsigned int delta_len =3D 0;
> > > +       unsigned int mss =3D skb_shinfo(skb)->gso_size;
> > >         struct sk_buff *tail =3D NULL;
> > >         struct sk_buff *nskb, *tmp;
> > >         int len_diff, err;
> > > +       bool err_len =3D false;
> > > =

> > >         skb_push(skb, -skb_network_offset(skb) + offset);
> > > =

> > > @@ -4047,6 +4049,14 @@ struct sk_buff *skb_segment_list(struct
> > sk_buff
> > > *skb,
> > >         if (err)
> > >                 goto err_linearize;
> > > =

> > > +       if (mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(skb)) {
> > > +               if (!list_skb) {
> > > +                       goto err_linearize;
> > =

> > The label no longer truly covers the meaning.
> > =

> > But that is already true since the above (second) jump was added in
> > commit c329b261afe7 ("net: prevent skb corruption on frag list
> > segmentation").
> > =

> > Neither needs the kfree_skb_list, as skb->next is not assigned to
> > until the loop. Can just return ERR_PTR(-EFAULT)?
> > =

> > > +               } else {
> > > +                       err_len =3D true;
> > > +               }
> > > +       }
> > > +
> > =

> > Why the branch? Might as well always fail immediately?
> > =

> Hi Willem,
> Thanks for your guidance.
> You are right. There is no need for another branch as fraglist
> could be freeed in kfree_skb.
> Could I git send mail wo patches as below?
> =

> From 933237400c0e2fa997470b70ff0e407996fa239c Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Wed, 24 Apr 2024 13:42:35 +0800
> Subject: [PATCH net] net: prevent BPF pull GROed skb's fraglist
> =

> A GROed skb with fraglist can't be pulled data

Please use the specific label: SKB_GSO_FRAGLIST skb

> from its fraglist as it may result a invalid
> segmentation or kernel exception.
> =

> For such structured skb we limit the BPF pull
> data length smaller than skb_headlen() and return
> error if exceeding.
> =

> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  net/core/filter.c | 5 +++++
>  1 file changed, 5 insertions(+)
> =

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 8adf95765cdd..8ed4d5d87167 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad,
> bpf_sp);
>  static inline int __bpf_try_make_writable(struct sk_buff *skb,
>  					  unsigned int write_len)
>  {
> +	if (skb_is_gso(skb) &&
> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> +	     write_len > skb_headlen(skb)) {
> +		return -ENOMEM;
> +	}
>  	return skb_ensure_writable(skb, write_len);
>  }
>  =

> -- =

> 2.18.0
> =

> =

> From 2d0729b20cf810ba1b31e046952c1cd78f295ca3 Mon Sep 17 00:00:00 2001
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> Date: Wed, 24 Apr 2024 14:43:45 +0800
> Subject: [PATCH net] net: drop GROed skb pulled from fraglist
> =

> A GROed skb with fraglist maybe pulled by BPF
> or other ways. It can't be trusted at all even
> if one byte is pulled and should be dropped
> on segmentation.

This paraphrases my comment. It is better to spell it out:

An SKB_GSO_FRAGLIST skb without GSO_BY_FRAGS is expected to have all
segments except the last to be gso_size long. If this does not hold,
the skb has been modified and the fraglist gso integrity is lost. Drop
the packet, as it cannot be segmented correctly by skb_segment_list.

The skb could be salvaged, though, right? By linearizing, dropping
the SKB_GSO_FRAGLIST bit and entering the normal skb_segment path
rather than the skb_segment_list path.

That choice is currently made in the protocol caller,
__udp_gso_segment. It's not trivial to add such a backup path here.
So let's add this backstop against kernel crashes.

> =

> If the gso_size does not match skb_headlen(),
> it means to be pulled part of or the entire
> fraglsit. It has been messed with and we return

fraglist

> error to free this skb.
> =

> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  net/core/skbuff.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b99127712e67..750fbb51b99f 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4493,6 +4493,7 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>  	unsigned int tnl_hlen =3D skb_tnl_header_len(skb);
>  	unsigned int delta_truesize =3D 0;
>  	unsigned int delta_len =3D 0;
> +	unsigned int mss =3D skb_shinfo(skb)->gso_size;

Reverse christmas tree

>  	struct sk_buff *tail =3D NULL;
>  	struct sk_buff *nskb, *tmp;
>  	int len_diff, err;
> @@ -4504,6 +4505,9 @@ struct sk_buff *skb_segment_list(struct sk_buff
> *skb,
>  	if (err)
>  		goto err_linearize;
>  =

> +	if (mss !=3D GSO_BY_FRAGS && mss !=3D skb_headlen(skb))
> +		return ERR_PTR(-EFAULT);
> +

Do this precondition integrity check before the skb_unclone path?

>  	skb_shinfo(skb)->frag_list =3D NULL;
>  =

>  	while (list_skb) {
> -- =

> 2.18.0


