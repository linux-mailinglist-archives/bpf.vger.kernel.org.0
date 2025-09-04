Return-Path: <bpf+bounces-67479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A53B44447
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4363A47145
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2830BF67;
	Thu,  4 Sep 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA03Ee0q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA352F5484;
	Thu,  4 Sep 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006790; cv=none; b=VwBs8969ZK2IEIJaRss6APkg9o98pCk35nVlCXehZmB3CSyu4PhuXQAu+MLiIL3dj920HBBo/0sHlRd0vqYTajDIEn4XUvIEatdw1v5twN0oFFp38PsDB9eRQ9pSAmP9XdPdOfto/QE4PXZ16WEgBs6wIKDplby8MyorA9ItIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006790; c=relaxed/simple;
	bh=EZ4Ig0++pbLqluvGrZc18Gn/h/uLnsrnUXNvG8CGVgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBLk33kPeBCAxKTk0y+mgyRWkY/S9RrEbcxz7yp2SMUWxe4gKak2845Sj6UURzObS3MPoeSQCfPduWkE6vYorwBzC37t/tPfQurG1Fj63kzo+jJxDKOwsN589vsmZ5IBJgywe6IVHk1pZDr2y9BqDvBVxDQ4D8PwtzQC3Q2J3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA03Ee0q; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d6051afbfso13934187b3.2;
        Thu, 04 Sep 2025 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757006787; x=1757611587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUseh6g4kqp9p2rXZD1SW9na3Fv96A86jzaodeUURis=;
        b=KA03Ee0qfyUqZXpD/6JyKMfdxz1taYvnfibL3xQSPnot3Os9uIH338FeA/wdnVwoLd
         HrVnKdIIPG6PiBG7G8xcP/mZnCsKRBs/L+//0qXCSwevqWff+1Y41h/UphBUnVaoxjVp
         6eEaMqivEKrw1aa/gP5wvlCKWbfbpJOW+5fCqhARmbPE3+oyU7hA1G+aRM7DGjAI95Ky
         /9rwLujrbGSrT5puiQUGppm27YOv30cxwCcmwU9JmrdyOyyzm5oFXN2XyJ/8Kaeh/Tai
         E2ZczNeVNPSgPho/1H2HcoKaD2NkcroRr11qfQA2/4PksKAVRkxisRRN5h2bXgbLCS1O
         8Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757006787; x=1757611587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUseh6g4kqp9p2rXZD1SW9na3Fv96A86jzaodeUURis=;
        b=jqvnuNfwh+5h0m+6bpoVsZPsaY+bUb57RkHV5hEflYwXO3269U9bI3QeqObC++gpAw
         8L/ARhf7vapb7GhH5cQiT+Z16cxVI5NH/mdtQ9v942OrPKxkxO3qIEvQSL37p71E2cHG
         Nf03IxM3hmqdvv7GzJ9ui7Mx1Y73a+rk0Nb3AgwljfzmEYILTpiUHSyl7V8Fuu9PoerY
         pyLe9eOwLBvLyhAnYm5lfiqhjk609NBU2eKFmTTLIx6VpufqdRND2M07nmWqBKzGBT9c
         8j+QTiuzf4QgRUYGAQE9ROwbm/ZAJRBUYGxQ9lr2oCMbr4cNq2HYDBtdc69j31rPPRDQ
         rSZw==
X-Forwarded-Encrypted: i=1; AJvYcCWrM1NBE5/e0YASUYE+SlzUCsQ/Rn3mvBdRg9cBOe97C3mzAfRCzf26Kfm8ORNBy0FnQ80SANg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCBVUy2owy2XKslRSNvEGDRl8bLP44xaaoy/ZUGeEXx0iQRmX
	+GdgMEZ608E/dthI5mGgeEhhk5lCPatAy3qdn8vqhuICT7zqooqD2dL9dUSYxvRRewyvvob2njY
	1SYfEODPwVxjoH39zMVne2jAkzRUnJGg=
X-Gm-Gg: ASbGncsT+b2NaFvqJ9gvNmGIjpxB3vh2K/CcxbuGKkR8cdfcubzNqCSDhotHJFJEFte
	T+o6SBcY+2uCaHk2BRd+LmvsEg5pMRhaN6d57ujZc5oH5mlHny2IOFsRNN657G0I15Cqsk8rnDs
	v+h3J2CNtYfnc534I1uKtEBzNCFYs8pW+3AB4sjAGT3HA9Cna7GwGw1HFF23/PEi5H15VjHuXoe
	vee+Bs=
X-Google-Smtp-Source: AGHT+IGx3jnOzpltQpFtLJ6oiDv+D1VVFsLiOEtkFP4nBFm8p4HY0HXJ7PMWXuN/Tp73VN1nHY3liACQfvrrOOifd6s=
X-Received: by 2002:a05:690c:74c7:b0:723:bd45:4ff5 with SMTP id
 00721157ae682-723bd45544amr65039767b3.5.1757006787046; Thu, 04 Sep 2025
 10:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <20250825193918.3445531-2-ameryhung@gmail.com>
 <76vmglojxf3yqysn5iwthctiacjy6xqcvrzzny74524djwhcf3@ejctdcty3cdz>
 <CAMB2axOLCakHEGnPcRTd1-ZdcGT6+wximWDOSMY1r9PGerfF0g@mail.gmail.com> <aniua473ljbet6w6ov24z6yzwlzzsbvd2d5dud2gep6kp6j5fg@fngzextb6w46>
In-Reply-To: <aniua473ljbet6w6ov24z6yzwlzzsbvd2d5dud2gep6kp6j5fg@fngzextb6w46>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 4 Sep 2025 10:26:16 -0700
X-Gm-Features: Ac12FXx2q_q915X9Patm4wfP-feA-NH31t2kA361SMWg6vHC4odkEWwSKPceHCo
Message-ID: <CAMB2axP-T5PDZK3E5+Jmq2+_O5vAmX7yxQUQGR5c0RPhaZ0JEg@mail.gmail.com>
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

On Thu, Aug 28, 2025 at 9:23=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Wed, Aug 27, 2025 at 08:44:24PM -0700, Amery Hung wrote:
> > On Wed, Aug 27, 2025 at 6:45=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > On Mon, Aug 25, 2025 at 12:39:12PM -0700, Amery Hung wrote:
> > > > [...]
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > index b8c609d91d11..c5173f1ccb4e 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > @@ -1725,16 +1725,17 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_wqe_frag_info *wi
> > > >                            struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
> > > >  {
> > > >       struct mlx5e_rq_frag_info *frag_info =3D &rq->wqe.info.arr[0]=
;
> > > > +     struct mlx5e_wqe_frag_info *pwi, *head_wi =3D wi;
> > > >       struct mlx5e_xdp_buff *mxbuf =3D &rq->mxbuf;
> > > > -     struct mlx5e_wqe_frag_info *head_wi =3D wi;
> > > >       u16 rx_headroom =3D rq->buff.headroom;
> > > >       struct mlx5e_frag_page *frag_page;
> > > >       struct skb_shared_info *sinfo;
> > > > -     u32 frag_consumed_bytes;
> > > > +     u32 frag_consumed_bytes, i;
> > > >       struct bpf_prog *prog;
> > > >       struct sk_buff *skb;
> > > >       dma_addr_t addr;
> > > >       u32 truesize;
> > > > +     u8 nr_frags;
> > > >       void *va;
> > > >
> > > >       frag_page =3D wi->frag_page;
> > > > @@ -1775,14 +1776,26 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_wqe_frag_info *wi
> > > >       prog =3D rcu_dereference(rq->xdp_prog);
> > > >       if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
> > > >               if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->=
flags)) {
> > > > -                     struct mlx5e_wqe_frag_info *pwi;
> > > > +                     pwi =3D head_wi;
> > > > +                     while (pwi->frag_page->netmem !=3D sinfo->fra=
gs[0].netmem && pwi < wi)
> > > > +                             pwi++;
> > > >
> > > Is this trying to skip counting the frags for the linear part? If yes=
,
> > > don't understand the reasoning. If not, I don't follow the code.
> > >
> > > AFAIU frags have to be counted for the linear part + sinfo->nr_frags.
> > > Frags could be less after xdp program execution, but the linear part =
is
> > > still there.
> > >
> >
> > This is to search the first frag after xdp runs because I thought it
> > is possible that the first frag (head_wi+1) might be released by
> > bpf_xdp_pull_data() and then the frag will start from head_wi+2.
> >
> > After sleeping on it a bit, it seems it is not possible as there is
> > not enough room in the linear to completely pull PAGE_SIZE byte of
> > data from the first frag to the linear area. Is this correct?
> >
> Right. AFAIU the usable linear part is smaller due to headroom and
> tailroom.
>
> [...]
> > > >               if (unlikely(!skb)) {
> > > >                       mlx5e_page_release_fragmented(rq->page_pool,
> > > > @@ -2102,20 +2124,25 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct m=
lx5e_rq *rq, struct mlx5e_mpw_info *w
> > > >               mlx5e_page_release_fragmented(rq->page_pool, &wi->lin=
ear_page);
> > > >
> > > >               if (xdp_buff_has_frags(&mxbuf->xdp)) {
> > > > -                     struct mlx5e_frag_page *pagep;
> > > > +                     struct mlx5e_frag_page *pagep =3D head_page;
> > > > +
> > > > +                     truesize =3D nr_frags * PAGE_SIZE;
> > > I am not sure that this is accurate. The last fragment might be small=
er
> > > than page size. It should be aligned to BIT(rq->mpwqe.log_stride_sz).
> > >
> >
> > According to the truesize calculation in
> > mlx5e_skb_from_cqe_mpwrq_nonlinear() just before mlx5e_xdp_handle().
> > After the first frag, the frag_offset is always 0 and
> > pg_consumed_bytes will be PAGE_SIZE. Therefore the last page also
> > consumes a page, no?
> >
> My understanding is that the last pg_consumed_bytes will be a byte_cnt
> that is smaller than PAGE_SIZE as there is a min operation.

The remaining byte_cnt will then be aligned to
BIT(rq->mpwqe.log_stride_sz), which is PAGE_SHIFT if there is xdp
program (per mlx5e_mpwqe_get_log_stride_size()). Therefore, it still
adds a page to truesize.

I will change to ALIGN(..., BIT(rq->mpwqe.log_stride_sz)) to be
consistent with existing code.

>
> > If the last page has variable size, I wonder how can
> > bpf_xdp_adjust_tail() handle a dynamic tailroom.
> That is a good point. So this can stay as is I guess.
>
> > bpf_xdp_adjust_tail()
> > requires a driver to specify a static frag size (the maximum size a
> > frag can grow) when calling __xdp_rxq_info_reg(), which seem to be a
> > page in mlx5.
> >
> This is an issue raised by Nimrod as well. Currently striding rq sets
> rxq->frag_size to 0. It is set to PAGE_SIZE only in legacy rq mode.
>

I see.

> >
> > > >
> > > >                       /* sinfo->nr_frags is reset by build_skb, cal=
culate again. */
> > > > -                     xdp_update_skb_shared_info(skb, frag_page - h=
ead_page,
> > > > +                     xdp_update_skb_shared_info(skb, nr_frags,
> > > >                                                  sinfo->xdp_frags_s=
ize, truesize,
> > > >                                                  xdp_buff_is_frag_p=
fmemalloc(
> > > >                                                       &mxbuf->xdp))=
;
> > > >
> > > > -                     pagep =3D head_page;
> > > > -                     do
> > > > +                     while (pagep->netmem !=3D sinfo->frags[0].net=
mem && pagep < frag_page)
> > > > +                             pagep++;
> > > > +
> > > > +                     for (i =3D 0; i < nr_frags; i++, pagep++)
> > > >                               pagep->frags++;
> > > > -                     while (++pagep < frag_page);
> > > > +
> > > > +                     headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - le=
n, sinfo->xdp_frags_size);
> > > > +                     __pskb_pull_tail(skb, headlen);
> > > >               }
> > > > -             __pskb_pull_tail(skb, headlen);
> > > What happens when there are no more frags? (bpf_xdp_frags_shrink_tail=
()
> > > shrinked them out). Is that at all possible?
> >
> > It is possible for bpf_xdp_frags_shrink_tail() to release all frags.
> > There is no limit of how much they can shrink. If there is linear
> > data, the kfunc allows shrinking data_end until ETH_HLEN. Before this
> > patchset, it could trigger a BUG_ON in __pskb_pull_tail(). After this
> > set, the driver will pass a empty skb to the upper layer.
> >
> I see what you mean.
>
> > For bpf_xdp_pull_data(), in the case of mlx5, I think it is only
> > possible to release all frags when the first and only frag contains
> > less than 256 bytes, which is the free space in the linear page.
> >
> Why would only 256 bytes be free in the linear area? My understanding
> is that we have PAGE_SIZE - headroom - tailroom which should be more?
>

mlx5e_skb_from_cqe_mpwrq_nonlinear() currently sets xdp->frame_sz to
be XDP_PACKET_HEADROOM (256) + MLX5E_RX_MAX_HEAD (256) + sizeof(struct
skb_shared_info), so only 256 is available to xdp programs to pull
data in.

> > >
> > > In general, I think the code would be nicer if it would do a rewind o=
f
> > > the end pointer based on the diff between the old and new nr_frags.
> > >
> >
> > Not sure if I get this. Do you mean calling __pskb_pull_tail() some
> > how based on the difference between sinfo->nr_frags and nr_frags?
> >
> > Thanks for reviewing the patch!
> >
> I was suggesting an approach for the whole patch that might be cleaner.
>
> Roll back frag_page to the last used fragment after program execution:
>
>         frag_page -=3D old_nr_frags - new_nr_frags;
>
> ... and after that you won't need to touch the frag counting loops
> and the xdp_update_skb_shared_info().
>

Got it. This makes the change quite cleaner.

> Thanks,
> Dragos

