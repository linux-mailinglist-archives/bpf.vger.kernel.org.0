Return-Path: <bpf+bounces-66777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E03B39250
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 05:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08BF18974F1
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 03:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7E25BEE8;
	Thu, 28 Aug 2025 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FctK9mPY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523C129A78;
	Thu, 28 Aug 2025 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352678; cv=none; b=A8sqzKoF6IK8Q4Z6DZgIrHKq+JbOLcjFSG9nRSgfLND/fqf5PcvWmOfCAOIZ6yC+hEaXjp1nxs9hJIhJwtQThFYZHYD8PpeXY89ltiv/CVbsp2v+ePu2Y8Kb2e7r2PWbyVPqiJV3uI80BoPplK4aB3IgACNga+nnW97TIp2EA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352678; c=relaxed/simple;
	bh=+ZGDrDsq7J95yxGycV/ZbYM6OYCQZaEW5OWKiR6uQ+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6uTpe5/mrbFQm+MgA0y7SpQMykemzxLBaGNpSI0RERnTfJYtXkd4WKVtSTaHr+enPxRk5zk9CoFVHBhqlIfW7vKBsN8c3Tlnsec4yizt5hazxBODaSz97gsATvTkYXAeAAtvk4V2NGbgmjEjBSj/Vx9tpMnyEa0FVFMHbPWNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FctK9mPY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d603b62adso3986527b3.1;
        Wed, 27 Aug 2025 20:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756352675; x=1756957475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikZcd63tO6rlghQGNjd0U3EBfokzm0Tio0645VT/9Ow=;
        b=FctK9mPYG6vDTWyehMOoAx6WtRgC9z8GHW8LRXZPJT9otfj9Lj4BB/9ZVKOk6KXuEW
         FN5zkcvLvv5lGsBHCmNRHHy52j/GT+L6TXcqLiTDHxMx10k4UBCcAHEZX2hR1Weo4gzS
         yY82QLseSVg4/NikLCRQFklvy5G90bDB8zddwJ7h8JdiPKNPHKmY6kDcEEzxpnq9LmOG
         TgCmWNXJ5DmSEloJOd+mZrs7J+Y6VGD0dslgi1+toiVCegd0EPw60PsqN/9KKbs14eIR
         Y87FtnA6xkKLd2Zse67PYW3iqAVGNg7M+LeBjRPJzPiSpmeDdBItPkQVcZ17ef6a5hI0
         lbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756352675; x=1756957475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikZcd63tO6rlghQGNjd0U3EBfokzm0Tio0645VT/9Ow=;
        b=aO9/T0H5jnVbRLH6wV54KXRa4LWI7ZSAhFSF5ef9uuy7ATb/YHS0SEsrI8ORJgbQ1x
         hfzh/5xTHgR9pV8HzNKXUblO//vWSU8wURF2tXgDoqkbwo7ux4HvGPIjnhPsFNAlFcpc
         YKJC5c+Z45fVR7JddNoxhDzDorMjIiBHPpjsSPdlHhT7YsGDBrBZJy6uUg/Z0JyglBNZ
         0szezB2v1gKL2aFDl+o/UyXr4iqYOVNxwJgxO5qMee/flZ53iOiGdxbsFYT8nk4Dyx8r
         oGWiFn4Ldd6Jfef1w9VNJ/W5sDp7tTjGZ0M7J1WGcgEx3lXnIQwkFWf4WNm4G+QZXo6a
         lWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfYdGboySQejcR/p+2/wH6qPT3KhWD2uCm/8tnM96eQZIyQKC3lBranbjKRGXMtzyFT/pNslE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4zteu+2vQPdA0Io8L6zPUsB0fq8dqI0cu8TFQElkilKBg6iq
	9zkOg9G0FtDEJEB70JSCfbtrxhSgzVdRyNEEFQjhyx7ILCPgWmsc6QWMYnNML/6sqKxWLneuoQd
	DqUvTHqqrXmaYiI9r9yIzNeeYALZIe3Y=
X-Gm-Gg: ASbGncsbJhUkWW8M0kUUHqEY1CtpBO1oSn4/YWSMHO+bSZWXNs3DHXEpZb41zLZQZS5
	OJwcC3SpymYzFu85FYigOQFtMT8nHdRdvqXtIVbeHn2TuxUPCscbhS4wbIkz6/DvoEd+k1fesJO
	4fwjdY89xMwtshO2m07Dj1px9DD/WzILvSsceRQaVhWJLpayj9T10juWgW7pjUYa1N71/QMzFEr
	X1x1yDXXiugChGiLA==
X-Google-Smtp-Source: AGHT+IGv3HqAnKkkRyC6E7OqTuNgWknueTBcuW440xQ0IPzU3/V/qDppaOCWX/79uw1X0W4uKqgZIuRQdigLkAC5gQk=
X-Received: by 2002:a05:690c:9a03:b0:71f:9a36:d5c2 with SMTP id
 00721157ae682-71fdc54f84emr256757107b3.48.1756352675282; Wed, 27 Aug 2025
 20:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <20250825193918.3445531-2-ameryhung@gmail.com>
 <76vmglojxf3yqysn5iwthctiacjy6xqcvrzzny74524djwhcf3@ejctdcty3cdz>
In-Reply-To: <76vmglojxf3yqysn5iwthctiacjy6xqcvrzzny74524djwhcf3@ejctdcty3cdz>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 27 Aug 2025 20:44:24 -0700
X-Gm-Features: Ac12FXx5BUHo5KbnTh12COv06Cnp9sM2VUbjG8p1h36PMe9l0zljhplz_C4qcCQ
Message-ID: <CAMB2axOLCakHEGnPcRTd1-ZdcGT6+wximWDOSMY1r9PGerfF0g@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 1/7] net/mlx5e: Fix generating skb from
 nonlinear xdp_buff
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com, noren@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:45=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Mon, Aug 25, 2025 at 12:39:12PM -0700, Amery Hung wrote:
> > xdp programs can change the layout of an xdp_buff through
> > bpf_xdp_adjust_tail(), bpf_xdp_adjust_head(). Therefore, the driver
> > cannot assume the size of the linear data area nor fragments. Fix the
> > bug in mlx5e driver by generating skb according to xdp_buff layout.
> >
> Good find! Thanks for tackling this Amery.
>
> > Currently, when handling multi-buf xdp, the mlx5e driver assumes the
> > layout of an xdp_buff to be unchanged. That is, the linear data area
> > continues to be empty and the fragments remains the same.
> This is true only for striding rq xdp. Legacy rq xdp puts the header
> in the linear part.
>
> > This may
> > cause the driver to generate erroneous skb or triggering a kernel
> > warning. When an xdp program added linear data through
> > bpf_xdp_adjust_head() the linear data will be ignored as
> > mlx5e_build_linear_skb() builds an skb with empty linear data and then
> > pull data from fragments to fill the linear data area. When an xdp
> > program has shrunk the nonlinear data through bpf_xdp_adjust_tail(),
> > the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
> > data size and trigger the BUG_ON in it.
> >
> > To fix the issue, first build the skb with linear data area matching
> > the xdp_buff. Then, call __pskb_pull_tail() to fill the linear data for
> > up to MLX5E_RX_MAX_HEAD bytes. In addition, recalculate nr_frags and
> > truesize after xdp program runs.
> >
> The ordering here seems misleading. AFAIU recalculating nr_frags happens
> first.
>
> > Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in St=
riding RQ")
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 59 ++++++++++++++-----
> >  1 file changed, 43 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index b8c609d91d11..c5173f1ccb4e 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -1725,16 +1725,17 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *r=
q, struct mlx5e_wqe_frag_info *wi
> >                            struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
> >  {
> >       struct mlx5e_rq_frag_info *frag_info =3D &rq->wqe.info.arr[0];
> > +     struct mlx5e_wqe_frag_info *pwi, *head_wi =3D wi;
> >       struct mlx5e_xdp_buff *mxbuf =3D &rq->mxbuf;
> > -     struct mlx5e_wqe_frag_info *head_wi =3D wi;
> >       u16 rx_headroom =3D rq->buff.headroom;
> >       struct mlx5e_frag_page *frag_page;
> >       struct skb_shared_info *sinfo;
> > -     u32 frag_consumed_bytes;
> > +     u32 frag_consumed_bytes, i;
> >       struct bpf_prog *prog;
> >       struct sk_buff *skb;
> >       dma_addr_t addr;
> >       u32 truesize;
> > +     u8 nr_frags;
> >       void *va;
> >
> >       frag_page =3D wi->frag_page;
> > @@ -1775,14 +1776,26 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *r=
q, struct mlx5e_wqe_frag_info *wi
> >       prog =3D rcu_dereference(rq->xdp_prog);
> >       if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
> >               if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flag=
s)) {
> > -                     struct mlx5e_wqe_frag_info *pwi;
> > +                     pwi =3D head_wi;
> > +                     while (pwi->frag_page->netmem !=3D sinfo->frags[0=
].netmem && pwi < wi)
> > +                             pwi++;
> >
> Is this trying to skip counting the frags for the linear part? If yes,
> don't understand the reasoning. If not, I don't follow the code.
>
> AFAIU frags have to be counted for the linear part + sinfo->nr_frags.
> Frags could be less after xdp program execution, but the linear part is
> still there.
>

This is to search the first frag after xdp runs because I thought it
is possible that the first frag (head_wi+1) might be released by
bpf_xdp_pull_data() and then the frag will start from head_wi+2.

After sleeping on it a bit, it seems it is not possible as there is
not enough room in the linear to completely pull PAGE_SIZE byte of
data from the first frag to the linear area. Is this correct?

> > -                     for (pwi =3D head_wi; pwi < wi; pwi++)
> > +                     for (i =3D 0; i < sinfo->nr_frags; i++, pwi++)
> >                               pwi->frag_page->frags++;
> Why not:

Will fix it as well as other similar places.

>
>         pwi =3D head_wi;
>         for (int i =3D 0; i < (sinfo->nr_frags + 1); i++, pwi++)
>                 pwi->frag_page->frags++;
>
> >               }
> >               return NULL; /* page/packet was consumed by XDP */
> >       }
> >
> > +     nr_frags =3D sinfo->nr_frags;
> This makes sense. You are using this in xdp_update_skb_shared_info()
> below.
>
> > +     pwi =3D head_wi + 1;
> > +
> > +     if (prog) {
> You could do here: if (unlikely(sinfo->nr_frags !=3D nr_frags).

Got it.

>
> > +             truesize =3D sinfo->nr_frags * frag_info->frag_stride;
> > +
> Ack. Recalculating truesize.
>
> > +             while (pwi->frag_page->netmem !=3D sinfo->frags[0].netmem=
 && pwi < wi)
> > +                     pwi++;
> Why is this needed here?
> > +     }
>
> >       skb =3D mlx5e_build_linear_skb(
> >               rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
> >               mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
> > @@ -1796,12 +1809,12 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *r=
q, struct mlx5e_wqe_frag_info *wi
> >
> >       if (xdp_buff_has_frags(&mxbuf->xdp)) {
> >               /* sinfo->nr_frags is reset by build_skb, calculate again=
. */
> > -             xdp_update_skb_shared_info(skb, wi - head_wi - 1,
> > +             xdp_update_skb_shared_info(skb, nr_frags,
> >                                          sinfo->xdp_frags_size, truesiz=
e,
> >                                          xdp_buff_is_frag_pfmemalloc(
> >                                               &mxbuf->xdp));
> >
> > -             for (struct mlx5e_wqe_frag_info *pwi =3D head_wi + 1; pwi=
 < wi; pwi++)
> > +             for (i =3D 0; i < nr_frags; i++, pwi++)
> >                       pwi->frag_page->frags++;
> Why not pull the pwi assignmet to head_wi + 1 up from the for scope and u=
se i
> with i < nr_frags condition?
>
> >       }
> >
> > @@ -2073,12 +2086,18 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> >       }
> >
> >       if (prog) {
> > +             u8 nr_frags;
> > +             u32 len, i;
> > +
> >               if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
> >                       if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, =
rq->flags)) {
> > -                             struct mlx5e_frag_page *pfp;
> > +                             struct mlx5e_frag_page *pagep =3D head_pa=
ge;
> > +
> > +                             while (pagep->netmem !=3D sinfo->frags[0]=
.netmem && pagep < frag_page)
> > +                                     pagep++;
> >
> Why do you need this?
>
> > -                             for (pfp =3D head_page; pfp < frag_page; =
pfp++)
> > -                                     pfp->frags++;
> > +                             for (i =3D 0; i < sinfo->nr_frags; i++)
> > +                                     pagep->frags++;
> This looks good here but with pfp =3D head_page. head_page should point t=
o the first
> frag. The linear part is in wi->linear_page.
>
>
> >                               wi->linear_page.frags++;
> >                       }
> > @@ -2087,9 +2106,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_=
rq *rq, struct mlx5e_mpw_info *w
> >                       return NULL; /* page/packet was consumed by XDP *=
/
> >               }
> >
> > +             len =3D mxbuf->xdp.data_end - mxbuf->xdp.data;
> > +             nr_frags =3D sinfo->nr_frags;
> > +
> >               skb =3D mlx5e_build_linear_skb(
> >                       rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
> > -                     mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
> > +                     mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len=
,
> >                       mxbuf->xdp.data - mxbuf->xdp.data_meta);
> This makes sense.
>
> >               if (unlikely(!skb)) {
> >                       mlx5e_page_release_fragmented(rq->page_pool,
> > @@ -2102,20 +2124,25 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> >               mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_=
page);
> >
> >               if (xdp_buff_has_frags(&mxbuf->xdp)) {
> > -                     struct mlx5e_frag_page *pagep;
> > +                     struct mlx5e_frag_page *pagep =3D head_page;
> > +
> > +                     truesize =3D nr_frags * PAGE_SIZE;
> I am not sure that this is accurate. The last fragment might be smaller
> than page size. It should be aligned to BIT(rq->mpwqe.log_stride_sz).
>

According to the truesize calculation in
mlx5e_skb_from_cqe_mpwrq_nonlinear() just before mlx5e_xdp_handle().
After the first frag, the frag_offset is always 0 and
pg_consumed_bytes will be PAGE_SIZE. Therefore the last page also
consumes a page, no?

If the last page has variable size, I wonder how can
bpf_xdp_adjust_tail() handle a dynamic tailroom. bpf_xdp_adjust_tail()
requires a driver to specify a static frag size (the maximum size a
frag can grow) when calling __xdp_rxq_info_reg(), which seem to be a
page in mlx5.


> >
> >                       /* sinfo->nr_frags is reset by build_skb, calcula=
te again. */
> > -                     xdp_update_skb_shared_info(skb, frag_page - head_=
page,
> > +                     xdp_update_skb_shared_info(skb, nr_frags,
> >                                                  sinfo->xdp_frags_size,=
 truesize,
> >                                                  xdp_buff_is_frag_pfmem=
alloc(
> >                                                       &mxbuf->xdp));
> >
> > -                     pagep =3D head_page;
> > -                     do
> > +                     while (pagep->netmem !=3D sinfo->frags[0].netmem =
&& pagep < frag_page)
> > +                             pagep++;
> > +
> > +                     for (i =3D 0; i < nr_frags; i++, pagep++)
> >                               pagep->frags++;
> > -                     while (++pagep < frag_page);
> > +
> > +                     headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - len, s=
info->xdp_frags_size);
> > +                     __pskb_pull_tail(skb, headlen);
> >               }
> > -             __pskb_pull_tail(skb, headlen);
> What happens when there are no more frags? (bpf_xdp_frags_shrink_tail()
> shrinked them out). Is that at all possible?

It is possible for bpf_xdp_frags_shrink_tail() to release all frags.
There is no limit of how much they can shrink. If there is linear
data, the kfunc allows shrinking data_end until ETH_HLEN. Before this
patchset, it could trigger a BUG_ON in __pskb_pull_tail(). After this
set, the driver will pass a empty skb to the upper layer.

For bpf_xdp_pull_data(), in the case of mlx5, I think it is only
possible to release all frags when the first and only frag contains
less than 256 bytes, which is the free space in the linear page.

>
> In general, I think the code would be nicer if it would do a rewind of
> the end pointer based on the diff between the old and new nr_frags.
>

Not sure if I get this. Do you mean calling __pskb_pull_tail() some
how based on the difference between sinfo->nr_frags and nr_frags?

Thanks for reviewing the patch!

> Thanks,
> Dragos

