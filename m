Return-Path: <bpf+bounces-68834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAD1B8652D
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C907AD7C9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3C28135D;
	Thu, 18 Sep 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is5zAtdV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F72749EA
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217863; cv=none; b=L3haYMNnO2LlzxrkLImThCG2d+XN6M/lwS4twjZbSnIgaHoHTNprGCxXeXL9aTqH6CcYKodH2XM8GEdxE8FKbe5MPUsYdAAChkbRc9uyaETgjynKMK0sHkAy1Obf2YwGm4wk39SCWOIeFOzqGfid5jg0BRSmLKSMIABOg7P8h6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217863; c=relaxed/simple;
	bh=LfmSKJ1grBOUO4QmOAFv0raC9UM99Rv8yuj/EawANR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRIAwKhzVlzLtO7dGzzIVBFIUGprpuwouwDH1etWl/MFEZ+6ywQKwrDBVoB218DaUR58ehZa6NXXcifUZtC4v9oqv0WEVGAzlXJGPlBKgwOfN0hlpUKwaGai302ZSPuwIjPyqrq9HX8nj3cbHvq/dDaQejnpehjHnsKmRN4/RqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is5zAtdV; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7238b5d5780so20039487b3.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758217860; x=1758822660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMh3OfTPSCcLojMWXJbdR/7V6nXSwb2UYLsAfrih/sg=;
        b=Is5zAtdVUxFkp3VO8cokXV2frBFwBYfqmdR69p6AhF3+SdPQj5r3RdwQWARoTGVAlg
         MmmNEfUkDTt2Y3RaI86vPtGfJyI5zx0RZLJA0ddqdEJXpPkMOkjSEjoqOjgyWelUi4p5
         Lqpxn27zCXDE6sZxRgkunUvsMzJOJED5V/zpu5iRNU82hZ2I40jsnqqVKa+sKMiOU2Pk
         lkQCtM6OEPniRYNdY1vrUdvHeEY/WWttjjWK1dEb24+57XOQGP9W2nMwINGRQzj4oa1I
         hiGb/Vwzai3RDPMIbuA07T+htMsTbqrJ4PPyR2I4jcjJMF3PYkbKp77nnjCLOoQtZzBQ
         I5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758217860; x=1758822660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMh3OfTPSCcLojMWXJbdR/7V6nXSwb2UYLsAfrih/sg=;
        b=qVLgyoL1gqSCp0ulj70cD2aPMwHwk1ypRW5jnxMTxyUkkg3AnfYdPe1lEL+hP8s6yZ
         k3lr29Zwqmt8KjYSmaoB4Mq1sGpZcve2JAkSGgMCWw/n5VG2z98cfkn6gex/3JxFAAQ5
         bCV9byJAFL8TtoaK22xL3ZcEpzzo2U/gmz99NDZHliEz/H1TEk4GbS2DJXI+Eq3D1ebO
         MY/+gEbFdQZeWfCWBg27oAKwDod6ApA89g0tTN38m5QRGVc3FoycC68dGvVs5pDBEeXw
         mKdhfpwodO0DWzO4s+WdtwGMC0auby4w58kVc296OLT7UV9E1enmkYZr235/bcibYyAH
         a/pw==
X-Gm-Message-State: AOJu0YwItd81BkaU/6WwCci0htc7ZSvdGWeHxFZ67ypwZk89zlRePkh6
	ztYHkp5ScflIOA/HoO2PXjTO7ugw2ahtyRbqXQZybDzBT3sWFcWjMemSP4Fjck5CQfhw1fJanFr
	IrWTcKbcaEFLy1V91uwMrw7uRuqQSaqo=
X-Gm-Gg: ASbGncuurF7gH4faQA6e51vEEG/p3NaEw5HM/AsrYdMTMsHIe0wUWGl9pKKk6suyW17
	NM3FGARcBjWFf8iG+b/qthKY73w2iFpRISWFEWltTsp745driwGSgWwNmt7OmZsRV1Z3avSi7Ws
	GoZ2/8TrplRhUzt15HQKIxq6gabJMUwUuHGMEwQmsJnWj6/LSYb2RRe7pzRYX4bUDgwsr5IadcS
	/ZJZiRbRc5OfnTzz3R/w5UVY2mEJdKH/BZzrmqqh68YBU+tI5m+
X-Google-Smtp-Source: AGHT+IGWNYfPwbgcVhxRGXbnlTQ0coAMFbDI8pFnffkZMvocUYQmwn6C6MkYfjuKsIlDphLmytqmQkhjEVbtXGNCRlw=
X-Received: by 2002:a05:690c:6588:b0:734:61f:2b1b with SMTP id
 00721157ae682-7396eafa4acmr33466937b3.0.1758217860405; Thu, 18 Sep 2025
 10:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917225513.3388199-1-ameryhung@gmail.com> <20250917225513.3388199-2-ameryhung@gmail.com>
 <aMvIONMZ9CFqyNnM@boxer>
In-Reply-To: <aMvIONMZ9CFqyNnM@boxer>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 18 Sep 2025 10:50:48 -0700
X-Gm-Features: AS18NWBzu9U2t63cMgi3IouX6VaLmj79DP1OwLU9j6aQGLZNOiMzeLYPzWd9u04
Message-ID: <CAMB2axNnzkqao1+md4qN5UvodzNQeNCywa6xbtbNGm4i1HR7LA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Allow bpf_xdp_shrink_data to shrink
 a frag from head and tail
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:52=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Sep 17, 2025 at 03:55:08PM -0700, Amery Hung wrote:
> > Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
> > functionality to be able to shrink an xdp fragment from both head and
> > tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
> > xdp fragment from head.
> >
> > Additionally, in bpf_xdp_frags_shrink_tail(), breaking the loop when
> > bpf_xdp_shrink_data() returns false (i.e., not releasing the current
> > fragment) is not necessary as the loop condition, offset > 0, has the
> > same effect. Remove the else branch to simplify the code.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/net/xdp_sock_drv.h | 21 ++++++++++++++++++---
> >  net/core/filter.c          | 28 +++++++++++++++++-----------
> >  2 files changed, 35 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 513c8e9704f6..4f2d3268a676 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -160,13 +160,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(=
const struct xdp_buff *first)
> >       return ret;
> >  }
> >
> > -static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> > +static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
> >  {
> > -     struct xdp_buff_xsk *xskb =3D container_of(tail, struct xdp_buff_=
xsk, xdp);
> > +     struct xdp_buff_xsk *xskb =3D container_of(xdp, struct xdp_buff_x=
sk, xdp);
> >
> >       list_del(&xskb->list_node);
> >  }
> >
> > +static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *firs=
t)
> > +{
> > +     struct xdp_buff_xsk *xskb =3D container_of(first, struct xdp_buff=
_xsk, xdp);
> > +     struct xdp_buff_xsk *frag;
> > +
> > +     frag =3D list_first_entry(&xskb->pool->xskb_list, struct xdp_buff=
_xsk,
> > +                             list_node);
> > +     return &frag->xdp;
> > +}
> > +
> >  static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *firs=
t)
> >  {
> >       struct xdp_buff_xsk *xskb =3D container_of(first, struct xdp_buff=
_xsk, xdp);
> > @@ -389,8 +399,13 @@ static inline struct xdp_buff *xsk_buff_get_frag(c=
onst struct xdp_buff *first)
> >       return NULL;
> >  }
> >
> > -static inline void xsk_buff_del_tail(struct xdp_buff *tail)
> > +static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
> > +{
> > +}
> > +
> > +static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *firs=
t)
> >  {
> > +     return NULL;
> >  }
> >
> >  static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *firs=
t)
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 63f3baee2daf..0b82cb348ce0 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -4153,27 +4153,31 @@ static int bpf_xdp_frags_increase_tail(struct x=
dp_buff *xdp, int offset)
> >       return 0;
> >  }
> >
> > -static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
> > +static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink, b=
ool tail,
> >                                  enum xdp_mem_type mem_type, bool relea=
se)
> >  {
> > -     struct xdp_buff *zc_frag =3D xsk_buff_get_tail(xdp);
> > +     struct xdp_buff *zc_frag =3D tail ? xsk_buff_get_tail(xdp) :
> > +                                       xsk_buff_get_head(xdp);
> >
> >       if (release) {
> > -             xsk_buff_del_tail(zc_frag);
> > +             xsk_buff_del_frag(zc_frag);
> >               __xdp_return(0, mem_type, false, zc_frag);
> >       } else {
> > -             zc_frag->data_end -=3D shrink;
> > +             if (tail)
> > +                     zc_frag->data_end -=3D shrink;
> > +             else
> > +                     zc_frag->data +=3D shrink;
> >       }
> >  }
> >
> >  static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag=
,
> > -                             int shrink)
> > +                             int shrink, bool tail)
> >  {
> >       enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
> >       bool release =3D skb_frag_size(frag) =3D=3D shrink;
> >
> >       if (mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL) {
> > -             bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
> > +             bpf_xdp_shrink_data_zc(xdp, shrink, tail, mem_type, relea=
se);
> >               goto out;
> >       }
> >
> > @@ -4181,6 +4185,12 @@ static bool bpf_xdp_shrink_data(struct xdp_buff =
*xdp, skb_frag_t *frag,
> >               __xdp_return(skb_frag_netmem(frag), mem_type, false, NULL=
);
> >
> >  out:
> > +     if (!release) {
> > +             if (!tail)
> > +                     skb_frag_off_add(frag, shrink);
> > +             skb_frag_size_sub(frag, shrink);
> > +     }
>
> Hi Amery,
>
> it feels a bit off to have separate conditions around @release. How about
> something below?
>

Agree that it feels weird. It bugged me a little but when working on this s=
et...

Let me try again. I moved common things out so that
bpf_xdp_shrink_data_zc() just does adjustments specific to zerocopy.
Does it look better to you?


static struct xdp_buff *bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int sh=
rink,
                                               bool tail, bool release)
{
        struct xdp_buff *zc_frag =3D tail ? xsk_buff_get_tail(xdp) :
                                          xsk_buff_get_head(xdp);

        if (release) {
                xsk_buff_del_frag(zc_frag);
        } else {
                if (tail)
                        zc_frag->data_end -=3D shrink;
                else
                        zc_frag->data +=3D shrink;
        }

        return zc_frag;
}

static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
                                int shrink, bool tail)
{
        enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
        bool release =3D skb_frag_size(frag) =3D=3D shrink;
        netmem_ref netmem =3D skb_frag_netmem(frag);
        struct xdp_buff *zc_frag =3D NULL;

        if (mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL) {
                netmem =3D 0;
                zc_frag =3D bpf_xdp_shrink_data_zc(xdp, shrink, tail, relea=
se);
        }

        if (release) {
                __xdp_return(netmem, mem_type, false, zc_frag);
        } else {
                if (!tail)
                        skb_frag_off_add(frag, shrink);
                skb_frag_size_sub(frag, shrink);
        }

        return release;
}

>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0b82cb348ce0..b1fca279c1de 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4175,20 +4175,17 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *=
xdp, skb_frag_t *frag,
>  {
>         enum xdp_mem_type mem_type =3D xdp->rxq->mem.type;
>         bool release =3D skb_frag_size(frag) =3D=3D shrink;
> +       bool zc =3D mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL;
>
> -       if (mem_type =3D=3D MEM_TYPE_XSK_BUFF_POOL) {
> +       if (zc)
>                 bpf_xdp_shrink_data_zc(xdp, shrink, tail, mem_type, relea=
se);
> -               goto out;
> -       }
> -
> -       if (release)
> -               __xdp_return(skb_frag_netmem(frag), mem_type, false, NULL=
);
>
> -out:
>         if (!release) {
>                 if (!tail)
>                         skb_frag_off_add(frag, shrink);
>                 skb_frag_size_sub(frag, shrink);
> +       } else if (!zc) {
> +               __xdp_return(skb_frag_netmem(frag), mem_type, false, NULL=
);
>         }
>
>         return release;
>
> > +
> >       return release;
> >  }
> >
> > @@ -4198,12 +4208,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_=
buff *xdp, int offset)
> >
> >               len_free +=3D shrink;
> >               offset -=3D shrink;
> > -             if (bpf_xdp_shrink_data(xdp, frag, shrink)) {
> > +             if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
> >                       n_frags_free++;
> > -             } else {
> > -                     skb_frag_size_sub(frag, shrink);
> > -                     break;
> > -             }
> >       }
> >       sinfo->nr_frags -=3D n_frags_free;
> >       sinfo->xdp_frags_size -=3D len_free;
> > --
> > 2.47.3
> >

