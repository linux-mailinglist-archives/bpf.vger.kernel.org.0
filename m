Return-Path: <bpf+bounces-68041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD65B51DF3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A22E1C27725
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B8274B2F;
	Wed, 10 Sep 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOuc/Kis"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569AB27145C;
	Wed, 10 Sep 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522362; cv=none; b=fajh1LpAwIMpdSZ7VKciBqXNj0/OBf1rr13l9aB09WCszPvcbuShnhLkR4Vs9zCvL23dFCd1LVgSNHCpUbtC4uqDbvZQVUK4lLmqqVBicqx98+sSG8R+xOtrgljVMksWXRbz/wuYiP5EVw2hoHNDwJHieEddEmNB2JWyEmgk51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522362; c=relaxed/simple;
	bh=DXaPB6O+MVeURgWOrbQJY23u3LqvdV53/UiDoA5wWxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVJnLtEnL2/FKn4hQNa+fEwlIeJfZ7FX+F5D0YJXKkB+M2orQhUEsRSmaCi0gwurrG1xWr3D7MpgyiO8TEFnI8whwPE6Op/dsvlx0NVZ+5F+gwaUnSCPGJCleuSBRMdQg9YfOd1/r1KAHJug/zh3LdKwLTKAAAemI9Bh8rjXVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOuc/Kis; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e9e137d69aaso3472317276.0;
        Wed, 10 Sep 2025 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757522360; x=1758127160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMR//KJUsKqo+LqzcLScfp4rayMNNk9xWONBV1O4fLI=;
        b=fOuc/Kis3MlPUfEkm/GgdBAK/CMUTVHc4RZk+04Ob9zSMKOVq9pE19RJfS0Es2kOfE
         qCsf9WXbvXYuK4q+K9HuAfuhMGw95tpaCaJkFBTlzBdJp0wZKEKFNI6eTwd05vVcvqH5
         35zdhY+6ILwZAjDzJnW24Q9acwUIiveg57DMv7c2f2fqtsqr/ZWd1ORiCVy5X/kGi3bG
         HPmSNiNv6gYfgZEdE1LLC1/PDrAmAXQ6QibwBlYTfMIj/g9RYYn4G7bgumjBYwT+drwJ
         EuvweOnogAxgniKHiZ2zOP55fhRIkj+Jw2Twd0byqz9mwv/YiZMQyQike7PeuH4SJaWG
         +EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522360; x=1758127160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMR//KJUsKqo+LqzcLScfp4rayMNNk9xWONBV1O4fLI=;
        b=lX9uTBKG/cNNQEWoXENl/3iRmgCOStkT6dkQw2J0hWEhLDlkmokXlfS6TJrHuePFJ7
         Agg6/uf1idBHNnasxiwnO156Gm33D2OLWFRi0iP+ddNsvRY4rEIE4qDpSBIIDq6waLHc
         BpumQA/b86j6mDsh+uNUA7m+O2tApe5zt7ASAtiqxmHnLcnJPYyTs6BJEi75Cg2XAnl+
         VB3Qa6JqF2ny0MtCw19FgK/Nt+v7YdoQIITcCWGSCEELTCNLTkoHBR8rMTn4K/ZoZ4jG
         kkgDmEElgyj3EB+ZAKW1kWTMhVlzKEIvLn2hzaJXnKl5xiBZkKQkt6HTe+tOlUErqvsd
         tIpw==
X-Forwarded-Encrypted: i=1; AJvYcCVptrGeFKyqorH15/u0Qcl/TILHhcFcYdeL+q8LlAcqiIaLFQIFKJxRSHyI08hxhf/lnlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSK7CBi9upDtiXBVSBHxSjyNk9gr1Q8nVoTZ0dLXaFFUKRUkXC
	qt1D47uiUCyMxMQv8x1eytTfIRwQl6h8P8EpWrh/AnpFaQpn9Cjl95ICCiSGSM4DYOj1ksiwdg7
	7y/uoiTWa3oPZMa1TbsCEr/ucuWhwYl0=
X-Gm-Gg: ASbGnctZDpPt2Yi3Csx9wI+yvAQXYUXu0thio6z4fo+8ovgtBWEopFzesr7f8bB5ZEY
	t2Lq/njwK04+i5CKH+kVJoceFUYifu/VMbzgMVL5Hw1sBZtbUBO2cVzdw1XOwCO4lgddqE+idrL
	S4mLg391guaOHi9MNriXWvtTVLnmi+WxAeD1N7X24mYE+cJG7nzGqpUSK8VQMzFPXw456FjHbD+
	e4D3cPzI9c2n+CTNHVR
X-Google-Smtp-Source: AGHT+IF0OCe3TTI7tEajUuAo/UE9GLq//PAYAMIeiVBcCF0WYiNZGdSd489Cr5MKvf0tWhyJdEeOSVytA1wNkt8HGQ8=
X-Received: by 2002:a05:6902:2b0a:b0:ea3:c0f8:99c4 with SMTP id
 3f1490d57ef6-ea3c0f89bcfmr2445705276.13.1757522359600; Wed, 10 Sep 2025
 09:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910034103.650342-1-ameryhung@gmail.com> <20250910034103.650342-2-ameryhung@gmail.com>
 <x4b26sfgbwuxodwbkk5gl5ohczmalycr3qxo2xwctiygzvvydh@fu26veserybx>
In-Reply-To: <x4b26sfgbwuxodwbkk5gl5ohczmalycr3qxo2xwctiygzvvydh@fu26veserybx>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 10 Sep 2025 12:39:07 -0400
X-Gm-Features: AS18NWDLF7H93l9nGXTXsP90-kXw9gkY55g31JI9JQPD-5DIg_KFduJJqpyXQgg
Message-ID: <CAMB2axO1oKWCq8X+XKdC0BOw5AvwpWbJYWJ2A4bo_cgRmvzEVw@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] net/mlx5e: RX, Fix generating skb from
 non-linear xdp_buff for legacy RQ
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, 
	martin.lau@kernel.org, noren@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, cpaasch@openai.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:24=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Tue, Sep 09, 2025 at 08:41:02PM -0700, Amery Hung wrote:
> > XDP programs can release xdp_buff fragments when calling
> > bpf_xdp_adjust_tail(). The driver currently assumes the number of
> > fragments to be unchanged and may generate skb with wrong truesize or
> > containing invalid frags. Fix the bug by generating skb according to
> > xdp_buff after the XDP program runs.
> >
> > Fixes: ea5d49bdae8b ("net/mlx5e: Add XDP multi buffer support to the no=
n-linear legacy RQ")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index b8c609d91d11..1d3eacfd0325 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -1729,6 +1729,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq,=
 struct mlx5e_wqe_frag_info *wi
> >       struct mlx5e_wqe_frag_info *head_wi =3D wi;
> >       u16 rx_headroom =3D rq->buff.headroom;
> >       struct mlx5e_frag_page *frag_page;
> > +     u8 nr_frags_free, old_nr_frags;
> >       struct skb_shared_info *sinfo;
> >       u32 frag_consumed_bytes;
> >       struct bpf_prog *prog;
> > @@ -1772,17 +1773,25 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *r=
q, struct mlx5e_wqe_frag_info *wi
> >               wi++;
> >       }
> >
> > +     old_nr_frags =3D sinfo->nr_frags;
> > +
> >       prog =3D rcu_dereference(rq->xdp_prog);
> >       if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
> >               if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flag=
s)) {
> >                       struct mlx5e_wqe_frag_info *pwi;
> >
> > +                     wi -=3D old_nr_frags - sinfo->nr_frags;
> > +
> >                       for (pwi =3D head_wi; pwi < wi; pwi++)
> >                               pwi->frag_page->frags++;
> >               }
> >               return NULL; /* page/packet was consumed by XDP */
> >       }
> >
> > +     nr_frags_free =3D old_nr_frags - sinfo->nr_frags;
> Just double checking that my understanding is correct:
> bpf_xdp_adjust_tail() can increase the tail only up to fragment limit,
> right? So this operation can always be >=3D 0.
>

Right, AFAIK bpf programs cannot add fragments to xdp_buff.

> If yes:
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>
> Thanks,
> Dragos

