Return-Path: <bpf+bounces-68047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B115BB520AA
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E71BC618E
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210692D542B;
	Wed, 10 Sep 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbq4VijG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C724A058
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531387; cv=none; b=LTUtmStkXtz+mOMbr72jscq+l15BsaSdrhDVXFEXBTyomj8DDuGxXL0tdg+EH2wkPhGz7Hc0UYoIDEvRwmA2NCVAT+6LPWo9I/XzH1MGzBhkSmoAS2P/0O7yWAIZLcDTlQdDqE6NeOs5nzaNHOs3hVdP2dz9XqpczoIQU6nHsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531387; c=relaxed/simple;
	bh=NWiO4/xnizeKg3+ovWD6X0B3W12DhoUmBZ4WP13THdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgJ3PO4PibZoUoN1X5BVgUq/x9+1tFQdmHUBVCRW0PlgRRJ9P0UTyEXwm/gpktWNg8r+iPCtO70wlPyMGxsHLTO2tRhoTdYQhh8Nbg9f38sC482Kv2HB7EOvq4BLvBh/h72xjgeZKwci1MrXCanqsc2mfWBU+56CTcrOqxHZOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbq4VijG; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-60f4702e399so2853776d50.3
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531383; x=1758136183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNyZ0R8GPxD4c0Sv4bK5Gv7LHCTfBChJ/34cqEEaIdE=;
        b=Hbq4VijGB9Tk/0R0KoFCf9OAbdRNkd6z/pCpBWbASXpzP3ZVb76kJcKsE0jKbwD1KQ
         xLDjVCYJyHOi92k4WFpa1Rju2r7nxU2MvlMWp9MY5Bm1DWKwMOYZ1rHHmBD94FckWVBC
         hvy0fElShpH5afz9hQMugaEvmLghp06QkRIadjGR5vgRJTMfwbY/i3rYr9lXlOYyGUUK
         SSEg0XMwHcUJV6IRJClJhzd4FI9yWx9yg5hPpDHrYe+ngKOhvQ7SwAoXonMI9ajdloMA
         uCZVX9TQVb043zqK/hvLxC6wTaOCmY8tkIKQvSihuYHSfDHDsEuEGc78wvUz5WKRwmkz
         /mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531383; x=1758136183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNyZ0R8GPxD4c0Sv4bK5Gv7LHCTfBChJ/34cqEEaIdE=;
        b=pG9tSgKKyQAWS9IFTwxCbuYE82Vvt/+epkwbUEHyaj1Pmnf1mcrS5M2DnuOVHDpUNT
         DHfOeNdTBVLyFdGaSZVXnKxeMwhzIExXRhrvnKj0I8tmFL3kNSzCwQviYhQvbyftVhAb
         UqbJ5JOqPatKI0VM5RqeVI6S1mYWXmfyKg7YifCqs8oFTzdbixu+cGnx3YuSE02TX5Me
         CboASaialpZV18XjPj4lP4Gz4382I+vsaaCi3K9pOUtfCsrq0mIMCOKAp9hvMbdG7e3p
         H+Y4/JyRKhtce00tcsRUrrAa60Uw1bq4cz6KoEdzPnobLk64Yn+/Z/7AsMbAA78Lukuh
         egKg==
X-Forwarded-Encrypted: i=1; AJvYcCWvuHEVu8Fyv6BVpvvTzmuRhSvb2928Hp7OOTI2qfKaF0U0f0mMJYEBp6w9V0tvY4mQNbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzokfrKHjMGNTO2tEwHG6jSkgJ7rWmP/gYxbR2cWNyBEHUsqolK
	ZbWhUQ6XBqKYP+r5A/u5uOEjWYSLB5J4Q0MYx4ZEFfTSLOGPNYdEeI8XORIVsseybXq3Yz+F+zN
	aJvmE5VEObvNM0WCFsq9sefFCxsGe4Fo=
X-Gm-Gg: ASbGncv/f20U5ZqBXC1aqwyafsbiX5IiB2O64d7J9+3CvXblofCpMNT/h5QMWvewmXT
	WH65IvtJHPw0DUejEjhX+4tDM8OxDt9IIW6pstYb7svkarH7NQnzFDeFgmYQrC1FNaTyMCIye2N
	ytfQX9njDRmvy1rQItOa9ZjTEFI/8YvO2CrGxq3nogoHg2FeAJjwprqMCsRT98BYxh86PEXIxn1
	v+AfDwFmW3Cj6MPiUJ4KXcdy9iukIEgag==
X-Google-Smtp-Source: AGHT+IG1/+D3ONyCqTauzjXYUt+hrd3750s9o1LSyJmp9OXz2Pcj5FzdjsDI/1JvowQWilrs6PXk5ALV/6JkvPIeq/Y=
X-Received: by 2002:a05:690e:23c8:b0:623:a710:2ebe with SMTP id
 956f58d0204a3-623a71047camr127094d50.11.1757531383285; Wed, 10 Sep 2025
 12:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
 <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
 <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com>
 <CADg4-L92GbxSXaqg1KuoGxt2c_yC=gbmKywVPvcAjHY_7v2H1g@mail.gmail.com>
 <CADg4-L8dLtzPL-x8o1HAHrbQ2fQ0MxB3Gm68HVj9Jp3-YunwrA@mail.gmail.com>
 <CAMB2axO3d9Wr64RRxYQd8rg5QVxt5MO=ZzRtJG8njeDYNBW-tw@mail.gmail.com> <CADg4-L8a-FbB4A_dttfQXYuvOdnEcrYOYi4fG_7KBBWfaLL_ag@mail.gmail.com>
In-Reply-To: <CADg4-L8a-FbB4A_dttfQXYuvOdnEcrYOYi4fG_7KBBWfaLL_ag@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 10 Sep 2025 15:09:30 -0400
X-Gm-Features: Ac12FXwLC569FZQzli7KgFkR808Uq22Jk7QK4BmeyYBih_UMnKE5RLMUNd7w_KY
Message-ID: <CAMB2axOa91igEKpt414YL7aMZ2yU_SDwVcG1xdTApfQYXzQk0g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Christoph Paasch <cpaasch@openai.com>
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:36=E2=80=AFPM Christoph Paasch <cpaasch@openai.co=
m> wrote:
>
> On Tue, Sep 9, 2025 at 8:17=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > On Tue, Sep 9, 2025 at 11:18=E2=80=AFAM Christoph Paasch <cpaasch@opena=
i.com> wrote:
> > >
> > > On Mon, Sep 8, 2025 at 9:00=E2=80=AFPM Christoph Paasch <cpaasch@open=
ai.com> wrote:
> > > >
> > > > On Thu, Sep 4, 2025 at 4:30=E2=80=AFPM Amery Hung <ameryhung@gmail.=
com> wrote:
> > > > >
> > > > > On Thu, Sep 4, 2025 at 3:57=E2=80=AFPM Christoph Paasch via B4 Re=
lay
> > > > > <devnull+cpaasch.openai.com@kernel.org> wrote:
> > > > > >
> > > > > > From: Christoph Paasch <cpaasch@openai.com>
> > > > > >
> > > > > > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (=
256)
> > > > > > bytes from the page-pool to the skb's linear part. Those 256 by=
tes
> > > > > > include part of the payload.
> > > > > >
> > > > > > When attempting to do GRO in skb_gro_receive, if headlen > data=
_offset
> > > > > > (and skb->head_frag is not set), we end up aggregating packets =
in the
> > > > > > frag_list.
> > > > > >
> > > > > > This is of course not good when we are CPU-limited. Also causes=
 a worse
> > > > > > skb->len/truesize ratio,...
> > > > > >
> > > > > > So, let's avoid copying parts of the payload to the linear part=
. We use
> > > > > > eth_get_headlen() to parse the headers and compute the length o=
f the
> > > > > > protocol headers, which will be used to copy the relevant bits =
ot the
> > > > > > skb's linear part.
> > > > > >
> > > > > > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the =
networking
> > > > > > stack needs to call pskb_may_pull() later on, we don't need to =
reallocate
> > > > > > memory.
> > > > > >
> > > > > > This gives a nice throughput increase (ARM Neoverse-V2 with CX-=
7 NIC and
> > > > > > LRO enabled):
> > > > > >
> > > > > > BEFORE:
> > > > > > =3D=3D=3D=3D=3D=3D=3D
> > > > > > (netserver pinned to core receiving interrupts)
> > > > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256=
K
> > > > > >  87380  16384 262144    60.01    32547.82
> > > > > >
> > > > > > (netserver pinned to adjacent core receiving interrupts)
> > > > > > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 25=
6K
> > > > > >  87380  16384 262144    60.00    52531.67
> > > > > >
> > > > > > AFTER:
> > > > > > =3D=3D=3D=3D=3D=3D
> > > > > > (netserver pinned to core receiving interrupts)
> > > > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256=
K
> > > > > >  87380  16384 262144    60.00    52896.06
> > > > > >
> > > > > > (netserver pinned to adjacent core receiving interrupts)
> > > > > >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 2=
56K
> > > > > >  87380  16384 262144    60.00    85094.90
> > > > > >
> > > > > > Additional tests across a larger range of parameters w/ and w/o=
 LRO, w/
> > > > > > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), =
different
> > > > > > TCP read/write-sizes as well as UDP benchmarks, all have shown =
equal or
> > > > > > better performance with this patch.
> > > > > >
> > > > > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > > > > > Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> > > > > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/=
drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > > > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..0ac31c7fb64cd60=
720d390de45a5b6b453ed0a3f 100644
> > > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > > > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct=
 mlx5e_rq *rq, struct mlx5e_mpw_info *w
> > > > > >                 dma_sync_single_for_cpu(rq->pdev, addr + head_o=
ffset, headlen,
> > > > > >                                         rq->buff.map_dir);
> > > > > >
> > > > > > +               headlen =3D eth_get_headlen(rq->netdev, head_ad=
dr, headlen);
> > > > > > +
> > > > > >                 frag_offset +=3D headlen;
> > > > > >                 byte_cnt -=3D headlen;
> > > > > >                 linear_hr =3D skb_headroom(skb);
> > > > > > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct=
 mlx5e_rq *rq, struct mlx5e_mpw_info *w
> > > > > >                                 pagep->frags++;
> > > > > >                         while (++pagep < frag_page);
> > > > > >                 }
> > > > > > +
> > > > > > +               headlen =3D eth_get_headlen(rq->netdev, mxbuf->=
xdp.data, headlen);
> > > > > > +
> > > > >
> > > > > The size of mxbuf->xdp.data is most likely not headlen here.
> > > > >
> > > > > The driver currently generates a xdp_buff with empty linear data,=
 pass
> > > > > it to the xdp program and assumes the layout If the xdp program d=
oes
> > > > > not change the layout of the xdp_buff through bpf_xdp_adjust_head=
() or
> > > > > bpf_xdp_adjust_tail(). The assumption is not correct and I am wor=
king
> > > > > on a fix. But, if we keep that assumption for now, mxbuf->xdp.dat=
a
> > > > > will not contain any headers or payload. The thing that you try t=
o do
> > > > > probably should be:
> > > > >
> > > > >         skb_frag_t *frag =3D &sinfo->frags[0];
> > > > >
> > > > >         headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(=
frag),
> > > > > skb_frag_size(frag));
> > >
> > > So, when I look at the headlen I get, it is correct (even with my old
> > > code using mxbuf->xdp.data).
> > >
> > > To make sure I test the right thing, which scenario would
> > > mxbuf->xdp.data not contain any headers or payload ? What do I need t=
o
> > > do to reproduce that ?
> >
> > A quick look at the code, could it be that
> > skb_flow_dissect_flow_keys_basic() returns false so that
> > eth_get_headlen() always returns sizeof(*eth)?
>
> No, the headlen values were correct (meaning, it was the actual length
> of the headers):
>

Another possibility is that mxbuf->xdp is reused and not zeroed
between calls to mlx5e_skb_from_cqe_mpwrq_nonlinear(). The stale
headers might have been written to mxbuf->xdp.data before the XDP is
attached.

I am not sure what exactly happens, but my main question remains. when
the XDP program is attached and does nothing, the linear data will be
empty, so what is eth_get_headlen() parsing here...?

> This is TCP-traffic with a simple print after eth_get_headlen:
> [130982.311088] mlx5e_skb_from_cqe_mpwrq_nonlinear xdp headlen is 86
>
> So, eth_get_headlen was able to correctly parse things.
>
> My xdp-program is as simple as possible:
> SEC("xdp.frags")
> int xdp_pass_prog(struct xdp_md *ctx)
> {
>     return XDP_PASS;
> }
>
>
> > The linear part
> > contains nothing meaning before __psk_pull_tail(), so it is possible
> > for skb_flow_dissect_flow_keys_basic() to fail.
> >
> > >
> > > Thanks,
> > > Christoph
> > >
> > > >
> > > > Ok, I think I understand what you mean! Thanks for taking the time =
to explain!
> > > >
> > > > I will do some tests on my side to make sure I get it right.
> > > >
> > > > As your change goes to net and mine to netnext, I can wait until yo=
urs
> > > > is in the tree so that there aren't any conflicts that need to be
> > > > taken care of.
> >
> > Will Copy you in the mlx5 non-linear xdp fixing patchset.
>
> Thx!
>
>
> Christoph

