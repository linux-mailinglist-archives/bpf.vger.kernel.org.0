Return-Path: <bpf+bounces-67742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E427B496E5
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE048164BB2
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49E31283A;
	Mon,  8 Sep 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2vV+QMV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B41E1DE7;
	Mon,  8 Sep 2025 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352242; cv=none; b=dwqTRsWf0M6zh9+twdlmh8zon3Vgk7sJAUp4feyCG3qUdBD4cT4xoEB4azEz0FWVvU2ppI2iAqacXpiIJT50e+fj1jZ3MBs6VdjwDanUVf2IpeZkeEoDeZP4SEyzODAJLrlKvW1B7B4opBNi2gIv0uSWWaYpwuu1l70WMcbt7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352242; c=relaxed/simple;
	bh=qneFfOqnL/55hc/APD1To1k5e3b7xuMXLn1DjS+W9Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UT9gIoModkffWt8I4IckHFRuKPVbvL5KmcqrqEKsbPDcSMbaKQtJat3YYfE0/NQfXwuiRI6xinLCnlcfqEjpC7qS+HO61hAmRqTFD/1NytbrNcn29R7u75tDDuqfWLFSokEiICbmMG1ZxTs20OhrA1gJjy7XTagkWeQaH8Va//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2vV+QMV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6059f490so40334467b3.3;
        Mon, 08 Sep 2025 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757352240; x=1757957040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuKkpzYEiCvO71Ei8abl0SPWjd7LNSODsnz5Kg8MlhA=;
        b=C2vV+QMVJFDfR8jehzlTm5HJbwVXpDKegkYWvu9e1mKM7Q/VKBMONgRrYUD4vze+je
         w3S/scGhQcI8TDxSt37Mq8rK2epOK8JNh30Se0eixan5bXfwKmCczcRvTJBZ1lpSL6fJ
         rNXDgX2jjD3u2j95EbOEIJGBqi5HhC6vA9GswNZwsG4Y1AOVjJXldjC4/E+jftOciRZv
         Z4dV3SvORoqVE/Y6VrPmS1UxDUEhQk9WC+uOOk339p5NdwHYG3G09Jkswwck0TJmYlRW
         jSO3rV9a7AlecJRSCm3n4ZHPcfD43ZNQuwLXzV4R6qCr3VWyvXEJWZfBeKP8IcJwswCt
         fIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352240; x=1757957040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuKkpzYEiCvO71Ei8abl0SPWjd7LNSODsnz5Kg8MlhA=;
        b=iiBSGKlt+fzG3p+dsL/mAeQ/Y5s5pbg3AXDMZ02Rihgu252I3vZpmTxLCDESXsRrJy
         tD3gVtiwjWaH/LUNJwzWWr0OPt2tonfD/zr8Rw1J3p8Cv7K86eKXTkNyTMp5+Ow6a9BO
         0Fc8k3dYwTVumVuzQ4Tvvx1CCtZtEbV2Rgrv2IpNW1JJtKnEjlYJmfUEgb7CbM0IpRSC
         puhIpi3ooBfv9PSLvSwE0zRT3nIlUzl9dB8o8zQRqsekxLhFV3yau86wh/RTWE9bz92Q
         o1TQnK08I8KYo5jZjl5Vhw8H/MjlezqIVFc85+y4bZG6dKZwC9FMMpYMMbCKnYOFgaRH
         exlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Xyuobl35QzRB7c/c8X+eAHlEceC5anqA4VUH1I62EdDz8CrB4mzsfXrIJ5yMaau25OFuoa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+XBUcjRXfQhm0ZWEO+CeZLX9ZBra3tWiQBbdtbX0+WW59zxb
	o5vQC1I1LLZAeojltEgBMbyhaj+J0WYeEd6o37hsJb8L1dg4GnOI2wxImerTnmHB/9d6XNhN4tl
	/emxZZTOatEkEKRN0JbVcLHOVrNFyuJNFKHEL
X-Gm-Gg: ASbGncvPQzZc5REC8vw85wBKCD0qFk7+lH4Eu5k/VQWm5NLinvYiQ2dwDnLzDtq1HNX
	ccMnIFZqiHj5l0hn4fCZBRJ/9QLhu1NbxXyLI3VEahb+tG5xSPgNYi2T6JF48F2qtlrI72cxtN9
	ssCtGPLWgbDI4KmZ8j7AX7kerFE33NSkKXJhxDNrm4+1V+lVB2Op1U10QpQFzzqTHVFQ2fQsGQa
	STWMjs=
X-Google-Smtp-Source: AGHT+IFmcR6kIZTfFFH38Mv50nfyJ8VTSCs13f+os33Iq32qw8+PAHy+dsPhdR+ID+BxjLqjAnctIj1Ev7XrqZSudYk=
X-Received: by 2002:a05:690c:4444:b0:721:3bd0:d5b4 with SMTP id
 00721157ae682-727f652a236mr79006277b3.33.1757352239722; Mon, 08 Sep 2025
 10:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905173352.3759457-1-ameryhung@gmail.com> <20250905173352.3759457-2-ameryhung@gmail.com>
 <4hgasq7ibnulieu77b4bryhouggobgousci7z2i3pefv7ofysh@j3qeucyw5wv5>
In-Reply-To: <4hgasq7ibnulieu77b4bryhouggobgousci7z2i3pefv7ofysh@j3qeucyw5wv5>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 8 Sep 2025 10:23:48 -0700
X-Gm-Features: Ac12FXxxe1yFTTrTU9YLONLqW1XUVSPH2DSVnCDNx2pozF0qEODf_ma-DU3pwss
Message-ID: <CAMB2axOoZysP2QtiLF+rYU_RebF140zPN4FjAm3AF1wW8yFLuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] net/mlx5e: Fix generating skb from
 nonlinear xdp_buff
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	stfomichev@gmail.com, martin.lau@kernel.org, mohsin.bashr@gmail.com, 
	noren@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 7:42=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:

Resending the reply to the list again as some html stuff accidentally
got mixed in

>
> On Fri, Sep 05, 2025 at 10:33:45AM -0700, Amery Hung wrote:
> > xdp programs can change the layout of an xdp_buff through
> > bpf_xdp_adjust_tail() and bpf_xdp_adjust_head(). Therefore, the driver
> > cannot assume the size of the linear data area nor fragments. Fix the
> > bug in mlx5 by generating skb according to xdp_buff after xdp programs
> > run.
> >
> Shouldn't this patch be a fix for net then?

Make sense. I will separate the mlx5 patch from this set and target net.

>
> > Currently, when handling multi-buf xdp, the mlx5 driver assumes the
> > layout of an xdp_buff to be unchanged. That is, the linear data area
> > continues to be empty and fragments remains the same. This may cause
> > the driver to generate erroneous skb or triggering a kernel
> > warning. When an xdp program added linear data through
> > bpf_xdp_adjust_head(), the linear data will be ignored as
> > mlx5e_build_linear_skb() builds an skb without linear data and then
> > pull data from fragments to fill the linear data area. When an xdp
> > program has shrunk the non-linear data through bpf_xdp_adjust_tail(),
> > the delta passed to __pskb_pull_tail() may exceed the actual nonlinear
> > data size and trigger the BUG_ON in it.
> >
> > To fix the issue, first record the original number of fragments. If the
> > number of fragments changes after the xdp program runs, rewind the end
> > fragment pointer by the difference and recalculate the truesize. Then,
> > build the skb with linear data area matching the xdp_buff. Finally, onl=
y
> > pull data in if there is non-linear data and fill the linear part up to
> > 256 bytes.
> >
> > Fixes: f52ac7028bec ("net/mlx5e: RX, Add XDP multi-buffer support in St=
riding RQ")
> Your fix covers both Legacy RQ and Striding RQ. So the tag is only 1/2
> correct. Normally we have separate patches for each mode.

Will split the patch into two.

>
>
>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 38 +++++++++++++++++--
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index b8c609d91d11..6b6bb90cf003 100644
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
> > @@ -1772,17 +1773,27 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *r=
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
> > +     if (unlikely(nr_frags_free)) {
> Even with with a branch prediction hint, is it really worth it?
>

[...]

>
> > +             wi -=3D nr_frags_free;
> > +             truesize -=3D nr_frags_free * frag_info->frag_stride;
> > +     }
> > +
> >       skb =3D mlx5e_build_linear_skb(
> >               rq, mxbuf->xdp.data_hard_start, rq->buff.frame0_sz,
> >               mxbuf->xdp.data - mxbuf->xdp.data_hard_start,
> > @@ -2004,6 +2015,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >       u32 byte_cnt       =3D cqe_bcnt;
> >       struct skb_shared_info *sinfo;
> >       unsigned int truesize =3D 0;
> > +     u32 pg_consumed_bytes;
> >       struct bpf_prog *prog;
> >       struct sk_buff *skb;
> >       u32 linear_frame_sz;
> > @@ -2057,7 +2069,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
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
> > @@ -2073,10 +2085,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
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
> > @@ -2087,9 +2104,22 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_=
rq *rq, struct mlx5e_mpw_info *w
> >                       return NULL; /* page/packet was consumed by XDP *=
/
> >               }
> >
> > +             len =3D mxbuf->xdp.data_end - mxbuf->xdp.data;
> > +
> > +             nr_frags_free =3D old_nr_frags - sinfo->nr_frags;
> > +             if (unlikely(nr_frags_free)) {
> Same question about the if.

I see. I will make the recalculation unconditional.

>
> > +                     frag_page -=3D nr_frags_free;
> > +
> > +                     /* the last frag is always freed first */
> > +                     truesize -=3D ALIGN(pg_consumed_bytes, BIT(rq->mp=
wqe.log_stride_sz));
> > +                     while (--nr_frags_free)
> > +                             truesize -=3D nr_frags_free *
> > +                                         ALIGN(PAGE_SIZE, BIT(rq->mpwq=
e.log_stride_sz));
> > +             }
> > +
> This doesn't seem correct. It seems to remove too much from truesize
> when nr_frags_free > 2. I think it should be:
>
> truesize -=3D ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) -
>             (nr_frags_free - 1) * ALIGN(PAGE_SIZE, BIT(rq->mpwqe.log_stri=
de_sz));
>
> And PAGE_SIZE is aligned to stride size so you can shorted it to:
>
> truesize -=3D ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) -
>             (nr_frags_free - 1) * PAGE_SIZE;

Sorry that I was being sloppy here. You are correct, and I think you
probably meant "+" instead of "-".

truesize -=3D ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz)) +
             (nr_frags_free - 1) * PAGE_SIZE;

>
> Thanks,
> Dragos
>

