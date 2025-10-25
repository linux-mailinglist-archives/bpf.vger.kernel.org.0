Return-Path: <bpf+bounces-72185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A979C08E49
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 11:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F1A1B23739
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89B2D8387;
	Sat, 25 Oct 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhHlV+3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFA20C029
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383521; cv=none; b=EyqyW12s4iHXuN2G08iU74gTXkfviMZ0/F6pR0IIahkG69Zn4d/eWc6+2oAuQ36fUdvByRIJP//o5mGcVB8uzGNSBCCmP8ND7LDKSVjO77wxZUEsH3fI9FLPajJXZuGZMyZ8uMeq7CrbNBtxXMjphm+Zaaw0Uxwa350cCkogE5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383521; c=relaxed/simple;
	bh=Lhq+NsnLG98t+AfKEhq0wOsx3dpzPR9hM91kFPXBgcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNXVcfaLrqoNosxABJKAoWMcywuVwqqP3/EBAYzpBykcyHZayGn83AtXHWYIsH67fTWabRUXkVNUYKaUhz36cvEgibAmGK78ct6kag4bbwtuwZEAQd9jTQd2+Ol117CExJ/4s5/3aAAPf8bx74CfYhtTaEEzyb00Nvim0esRNPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhHlV+3j; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430b621ec08so30919225ab.0
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761383519; x=1761988319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om2YzHu3nCOqPwoqC+II/RAS9gh5R+taAfLDoGS7cb4=;
        b=EhHlV+3jShaiHB6FFqX4P/xiZH6/CQid43iVolGTF9bGMfLMXHIceeKcH46AeqcA6I
         iJ5Apucre51SsRZv2slxPUZQPuk1NV/OTUVgvusUth5W8FiOJd/8bZ1Zq+4w+/Bqzby8
         oWt9g8ILJmiFC3OiA/MBiUsq9NMFh3bXU2AQFSD+yYkgoFEnXtMLO66BqM8TUghr2RT6
         EbBUnkUC9hPlllt47z1HboRsc1Tw6dZl+DuEvEP/3LBI88WV4y1j53Vzq8SWThxKz9Kn
         b3SX8zIoSmUfOhs10pDcO0qyxDqZ+GtOEi1CAPRyM43CsthBe9tPhGHdf7ib6Q36doF2
         X3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761383519; x=1761988319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om2YzHu3nCOqPwoqC+II/RAS9gh5R+taAfLDoGS7cb4=;
        b=D1tuYx+iTqLvB8chNy6mHedi+cPJWx8HEgn36eqzu09owC1kaW7J+3i9ihczmXVIVc
         Mobd8Gs/c5PqewZlYWFOVpxil4hoCkMRtT+uSC4tDsk9Q56vr0KOGzMm6oU9ahotKynX
         FyC1o/2oht4Hre2OPQJOhz3BKFaTzIhwhcjxppDBt3t+4QqhEsYJECtpa+RMnlDEHT25
         aZESPS7/9ICEkcvKsna9nY8JDJHghVzFiyEWx2hezoJObs/7vUh3ZCWSjV1xbTuSi12O
         II07rnuV2ObMJnllH/osI8LfJolutVKszD6mp+NZBykAkHxWdYEEAwDEFCzWvwDvMvsd
         BkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk1kvjfFFGftQbHN01ecPNKFXP03+PNqwXguBgNIU54C6T9+TZEPArV6c2hF7B9/cOLZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwF7zMziPZRuVSkJp1fO9TPn2hWQJ1buplRFmi/iZfsrMm+GRQ
	Hytk/GaMymP2BHENkcQNM+Wxo78DWasaD5EsbjNBPZLfe5/aCYpKA3T2aRHCnPxv9JAhpb1wIfO
	fOL6ekuNyuJjIbKgImQAewR1mh30lb+U=
X-Gm-Gg: ASbGnctYfT1sY6E2aVS1+yZQ4q6Nifsi+Eo2Lw7oUAQYlGeBaAGUYEIM6FjQTSwDlg3
	ygDgb2GND2Sv2Eul3AzKca0+Y4Bf5WjQ6JCmucTflPnpmu5iQpYNXfToB9vMVMbrAny46f9VuJT
	yERdG953OHni9OPTXtTweDXmZxsx0jsHrXLnN8PlPpwSKQbnfAzGMb3/Ih8TRhr2QZrPy3QNVJN
	ihbQtsAt+jxaM8IxDqCs0SPs7ZIdJe0fzxd83e0SRYBceOH5kSRaaq4gamsNBv7gm7RaQ==
X-Google-Smtp-Source: AGHT+IH+QjMwOjg4gNFZDwJyTUOtFhKnkbWxOK1k+HPDITRbGv+joYzZONrTczYVCrJOvFdjVzMFrBmDxK76nn7t5qE=
X-Received: by 2002:a05:6e02:156c:b0:430:acb1:e785 with SMTP id
 e9e14a558f8ab-430c5208dacmr442399545ab.6.1761383519507; Sat, 25 Oct 2025
 02:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-4-kerneljasonxing@gmail.com> <aPvKNAZP8kKolwIm@mini-arch>
In-Reply-To: <aPvKNAZP8kKolwIm@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Oct 2025 17:11:23 +0800
X-Gm-Features: AWmQ_blde_31pqxo3Xh3exy7vgnbP-UcSbo33ZrvghygqceyyIUPT-jSUjSpLp0
Message-ID: <CAL+tcoBNeghhUv=EG=NwGP+dYtXv-Ms489YBFh3rctxfRagUAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:49=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/21, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Support allocating and building skbs in batch.
> >
> > This patch uses kmem_cache_alloc_bulk() to complete the batch allocatio=
n
> > which relies on the global common cache 'net_hotdata.skbuff_cache'. Use
> > a xsk standalone skb cache (namely, xs->skb_cache) to store allocated
> > skbs instead of resorting to napi_alloc_cache that was designed for
> > softirq condition.
> >
> > After allocating memory for each of skbs, in a 'for' loop, the patch
> > borrows part of __allocate_skb() to initialize skb and then calls
> > xsk_build_skb() to complete the rest of initialization process, like
> > copying data and stuff.
> >
> > Add batch.send_queue and use the skb->list to make skbs into one chain
> > so that they can be easily sent which is shown in the subsequent patche=
s.
> >
> > In terms of freeing skbs process, napi_consume_skb() in the tx completi=
on
> > would put the skb into global cache 'net_hotdata.skbuff_cache' that
> > implements the deferred freeing skb feature to avoid freeing skb one
> > by one to improve the performance.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xdp_sock.h |   3 ++
> >  net/core/skbuff.c      | 101 +++++++++++++++++++++++++++++++++++++++++
> >  net/xdp/xsk.c          |   1 +
> >  3 files changed, 105 insertions(+)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 8944f4782eb6..cb5aa8a314fe 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -47,8 +47,10 @@ struct xsk_map {
> >
> >  struct xsk_batch {
> >       u32 generic_xmit_batch;
> > +     unsigned int skb_count;
> >       struct sk_buff **skb_cache;
> >       struct xdp_desc *desc_cache;
> > +     struct sk_buff_head send_queue;
> >  };
> >
> >  struct xdp_sock {
> > @@ -130,6 +132,7 @@ struct xsk_tx_metadata_ops {
> >  struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >                             struct sk_buff *allocated_skb,
> >                             struct xdp_desc *desc);
> > +int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs=
, int *err);
> >  #ifdef CONFIG_XDP_SOCKETS
> >
> >  int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index bc12790017b0..5b6d3b4fa895 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -81,6 +81,8 @@
> >  #include <net/page_pool/helpers.h>
> >  #include <net/psp/types.h>
> >  #include <net/dropreason.h>
> > +#include <net/xdp_sock.h>
> > +#include <net/xsk_buff_pool.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <trace/events/skb.h>
> > @@ -615,6 +617,105 @@ static void *kmalloc_reserve(unsigned int *size, =
gfp_t flags, int node,
> >       return obj;
> >  }
> >
> > +int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs=
, int *err)
> > +{
> > +     struct xsk_batch *batch =3D &xs->batch;
> > +     struct xdp_desc *descs =3D batch->desc_cache;
> > +     struct sk_buff **skbs =3D batch->skb_cache;
> > +     gfp_t gfp_mask =3D xs->sk.sk_allocation;
> > +     struct net_device *dev =3D xs->dev;
> > +     int node =3D NUMA_NO_NODE;
> > +     struct sk_buff *skb;
> > +     u32 i =3D 0, j =3D 0;
> > +     bool pfmemalloc;
> > +     u32 base_len;
> > +     u8 *data;
> > +
> > +     base_len =3D max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom=
));
> > +     if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> > +             base_len +=3D dev->needed_tailroom;
> > +
> > +     if (batch->skb_count >=3D nb_pkts)
> > +             goto build;
> > +
> > +     if (xs->skb) {
> > +             i =3D 1;
>
> What is the point of setting i to 1 here? You always start the loop from
> i=3D0.

Oh, right, I should've removed it!

Thanks,
Jason

