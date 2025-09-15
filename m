Return-Path: <bpf+bounces-68437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C0B5861B
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B8D483367
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154529D26E;
	Mon, 15 Sep 2025 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejgfKGeq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FE29C339
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968788; cv=none; b=T05f5PifGbhb/ahl2wyp+So6m2i33ciBs1g2MXNvfG95RfhFasCCdu0QpcC9Oo3fxsCorp9N1OdWLiwKcTbkvTIHW7USsqmYgLrJ1opbsWEXUsm9eGrPJSfoWTtw+i789iN6YbvF/Mcp2jdkzPcQDRe+fto+h6OHiwpcrei1BgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968788; c=relaxed/simple;
	bh=/krM7jSTUaDhpBTeeWFh4Jm1MfAV+Z69QkCbNBkCHM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DORykccajnDDhyJ8ZEYEXIuCwnlKrjgVndgjmrXOOm05nU2S3ija2rzmXoU4lHjYMCKW9w3lGw/uECEWAQuXfAjDf7S8dR4uTlkAOgJbT7PJDSfR+p8Afhp2OJIzHapZWW61LlJ5aG2a2rOF5/QAhQIdTLckxZYdTHC2HYSGHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejgfKGeq; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ea473582bcaso838247276.1
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968785; x=1758573585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKm3x9M6hX2KV7zH6+n0iesE4g55NKCC1k5kF2cu2go=;
        b=ejgfKGeqdpVTpVi+oUZJ1bgD+A0ny9xWZBIBz/F5FP+f6/ZTqbA9uNfvLWaF8+1Dw+
         /tQuDVfLN3CxxrkmrfxRvaixennateXyIApySen3i5pzArmMY63sub9Z/I66gDvul3Lv
         do3qXDSWO7c2B9sOlYZps8vrgtWOBKBHnNaIVamJBP9hMuMsymk3zoKiN7JWRGTrar0J
         FJ9Dyly5aQfb9YHVOjz5O1cHptLJwFDJ/GZB6NlipokzyNItLcy7ZC9GXaCRWOURvc1D
         6lJ6SF/mmiWnW+P1QKjc4Bj+VPvHtDTVaBNi1ivGYV3zgqVnFtW9mlov4uj/NRWOIVgd
         DlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968785; x=1758573585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKm3x9M6hX2KV7zH6+n0iesE4g55NKCC1k5kF2cu2go=;
        b=p8E9LWVZf+l7Lgs+Up5MLFzJa+nTK9jRvQ9rYkzCzoFmfUD63iX3a22w2sBhvHqKyu
         mGzxIzbacjipETYwVQ0rZWmmFnHorqc/ZhED2uBSKQ50CwL06LQIxPPiNyGfVmuo6dTG
         agxbrqSYR+T85ns7wdrDHGcyiIieu98q+x4QxgBVnoCDgcjc1qndrxc/JxsCgcDrCUNY
         gaMRkB1N+0E3vnfd64dZQV+nHgy+0NEL1db7u1NJ2Em629AYrnWUPJ6sWQcbNlBFLgio
         pYUoSKJEdFAoVWo/rGaXn7xEW8Wia2EE2sjvAAvvm+IqXttITCqdUdMrnrKvW1XQTzEa
         AegA==
X-Forwarded-Encrypted: i=1; AJvYcCWL2MAE1UTvOEXDjtvMF9aKxs/4YPPArelvSByUVPIfLrNnA5dFljw/W50GLeRaU71D1oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQBEWUTrkr2rBI0wEib0WJAZk3XWtyh5feeynxFmjjzoBT0h2
	bbEJEeFDX8zEysF86mIntPgpdSsdkmMaaK8Svwo3jSLgQ0oQbEciHp2H3PLmPsna6lXnYpG2YBZ
	NCjDKcdjWj7nVPBPA3vu1GTiK0O68z/s=
X-Gm-Gg: ASbGncudtYw2MDcTviVrT9P4WiIElvwUeXDmYCzb6VPIgCSjLltEqe44M8hK5gyUl7G
	nVP67SaoKg3fzdqYxurCACfnzLVsg+pzr4C6YFqK6uImNTgbLmqJLeU7k3ROdsLDaEc13LDx6+S
	1ZIdht0zKK9Bat4t3FxGY5FrjRwqTa2RrDo5yfFppkgbG+UHS7HDs+7lmfJWD7/jsy8AZmBCiqn
	iC4Ue8=
X-Google-Smtp-Source: AGHT+IGjPNtyuPsAfXq2tAeH83dvfN1sCJzwlVHg7DCjwRb4gUJvB8rFOoNCnkSRkeDFN3qaNs8/Ef0PtSDiDiuq28w=
X-Received: by 2002:a53:e801:0:b0:5ff:6c94:7f48 with SMTP id
 956f58d0204a3-6274fafa1b5mr9578822d50.16.1757968785353; Mon, 15 Sep 2025
 13:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910034103.650342-1-ameryhung@gmail.com> <20250910034103.650342-3-ameryhung@gmail.com>
 <5b41324c-34d2-4b19-9713-43e118e5629c@gmail.com>
In-Reply-To: <5b41324c-34d2-4b19-9713-43e118e5629c@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 15 Sep 2025 13:39:33 -0700
X-Gm-Features: Ac12FXwuaO6pqGs_ZaBNBW5--Dp1L35lcVEVLX1SluXLePEcOjNiF9Zkbj9L_zc
Message-ID: <CAMB2axOUP1q9O1ViA_kzOvHDHKOYYahH=QMOvvJfffwgoYPGyA@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] net/mlx5e: RX, Fix generating skb from
 non-linear xdp_buff for striding RQ
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, 
	martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:19=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 10/09/2025 6:41, Amery Hung wrote:
> > XDP programs can change the layout of an xdp_buff through
> > bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
> > cannot assume the size of the linear data area nor fragments. Fix the
> > bug in mlx5 by generating skb according to xdp_buff after XDP programs
> > run.
> >
> > Currently, when handling multi-buf XDP, the mlx5 driver assumes the
> > layout of an xdp_buff to be unchanged. That is, the linear data area
> > continues to be empty and fragments remain the same. This may cause
> > the driver to generate erroneous skb or triggering a kernel
> > warning. When an XDP program added linear data through
> > bpf_xdp_adjust_head(), the linear data will be ignored as
> > mlx5e_build_linear_skb() builds an skb without linear data and then
> > pull data from fragments to fill the linear data area. When an XDP
> > program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
> > the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
> > data size and trigger the BUG_ON in it.
> >
> > To fix the issue, first record the original number of fragments. If the
> > number of fragments changes after the XDP program runs, rewind the end
> > fragment pointer by the difference and recalculate the truesize. Then,
> > build the skb with the linear data area matching the xdp_buff. Finally,
> > only pull data in if there is non-linear data and fill the linear part
> > up to 256 bytes.
> >
> > Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in St=
riding RQ")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Thanks for your patch!
>
> >   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 21 ++++++++++++++++--=
-
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index 1d3eacfd0325..fc881d8d2d21 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -2013,6 +2013,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >       u32 byte_cnt       =3D cqe_bcnt;
> >       struct skb_shared_info *sinfo;
> >       unsigned int truesize =3D 0;
> > +     u32 pg_consumed_bytes;
> >       struct bpf_prog *prog;
> >       struct sk_buff *skb;
> >       u32 linear_frame_sz;
> > @@ -2066,7 +2067,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >
> >       while (byte_cnt) {
> >               /* Non-linear mode, hence non-XSK, which always uses PAGE=
_SIZE. */
> > -             u32 pg_consumed_bytes =3D min_t(u32, PAGE_SIZE - frag_off=
set, byte_cnt);
> > +             pg_consumed_bytes =3D min_t(u32, PAGE_SIZE - frag_offset,=
 byte_cnt);
> >
> >               if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
> >                       truesize +=3D pg_consumed_bytes;
> > @@ -2082,10 +2083,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> >       }
> >
> >       if (prog) {
> > +             u8 nr_frags_free, old_nr_frags =3D sinfo->nr_frags;
> > +             u32 len;
> > +
> >               if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
> >                       if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, =
rq->flags)) {
> >                               struct mlx5e_frag_page *pfp;
> >
> > +                             frag_page -=3D old_nr_frags - sinfo->nr_f=
rags;
> > +
> >                               for (pfp =3D head_page; pfp < frag_page; =
pfp++)
> >                                       pfp->frags++;
> >
> > @@ -2096,9 +2102,16 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_=
rq *rq, struct mlx5e_mpw_info *w
> >                       return NULL; /* page/packet was consumed by XDP *=
/
> >               }
> >
> > +             nr_frags_free =3D old_nr_frags - sinfo->nr_frags;
> > +             frag_page -=3D nr_frags_free;
> > +             truesize -=3D ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_=
stride_sz)) +
> > +                         (nr_frags_free - 1) * ALIGN(PAGE_SIZE, BIT(rq=
->mpwqe.log_stride_sz));
>
> This is a very complicated calculation resulting zero in the common case
> nr_frags_free =3D=3D 0.
> Maybe better do it conditionally under if (nr_frags_free), together with
> 'frag_page -=3D nr_frags_free;' ?
>

Will change the recalculation back to conditional.

> We never use stride_size > PAGE_SIZE so the second alignment here is
> redundant.

Got it. I will remove the ALIGN for the second part.

>
> Also, what about truesize changes due to adjust header, i.e. when we
> extend the header into the linear part.
> I think 'len' calculated below is missing from truesize.

The linear part will be included later in mlx5e_build_linear_skb() ->
napi_build_skb() -> ... -> __finalize_skb_around().

> > +
> > +             len =3D mxbuf->xdp.data_end - mxbuf->xdp.data;
> > +
> >               skb =3D mlx5e_build_linear_skb(
> >                       rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
> > -                     mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
> > +                     mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len=
,
> >                       mxbuf->xdp.data - mxbuf->xdp.data_meta);
> >               if (unlikely(!skb)) {
> >                       mlx5e_page_release_fragmented(rq->page_pool,
> > @@ -2123,8 +2136,10 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_=
rq *rq, struct mlx5e_mpw_info *w
> >                       do
> >                               pagep->frags++;
> >                       while (++pagep < frag_page);
> > +
> > +                     headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - len, s=
kb->data_len);
> > +                     __pskb_pull_tail(skb, headlen);
> >               }
> > -             __pskb_pull_tail(skb, headlen);
> >       } else {
> >               dma_addr_t addr;
> >
>

