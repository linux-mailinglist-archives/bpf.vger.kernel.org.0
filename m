Return-Path: <bpf+bounces-67986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B6B50C41
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 05:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3413C1BC4B76
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 03:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6A25A2C3;
	Wed, 10 Sep 2025 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4CJbwic"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB75199BC;
	Wed, 10 Sep 2025 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474259; cv=none; b=MNybIsRcd+raWiiUfH8/y2r/YnFp6VbsyW7rfgPJT6iHC2IVfhQi+yv+g07EjyZsXEjwP7rXxWLK3J8HnGXl3ZkcuI8ohCgXsH3gJwwvS5FqxX87ybeh1eq39D5lkI6x4qwHChTYB4ugPP/5+H7cZJX+FU9OOqKprDxR9JSYoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474259; c=relaxed/simple;
	bh=MD2+xj2LptpSdVsILFkm0RQcgTGiqOOna/dN+j941Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsXlHI6UN6yaB2p/0UpuDtQ8+Z5UG/fJHRKyJN/s1l47N7W6hrm82xNkjdaiJSh1ak+9elUe5T2q1cwUva4bCAw0EtDcWm3r40dfooZCl7KPtljHwPrKMnt4lDJWz8DeJQpxJGXX/RLBSrfdoswDaVEaEu1uhiBF8aqp/mVa/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4CJbwic; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d71bcab6fso58928787b3.0;
        Tue, 09 Sep 2025 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757474256; x=1758079056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdI4wzAI+F6qqND7zFZEoC8SvB3//aPvuhJS3lQ10OM=;
        b=U4CJbwic+erYx+fSkSHwfEXeG7mguFDrDpUAZPH++ceJm7Z8SfS1oOT13ywXdn5YT5
         3UKAx0y+imvk4YIaC1MMO7D+NVgu2Vl5NHdM3+Ymuw9Dflz/FE3qfRFKiR8gYQ1v5PHD
         TmmTVRx+QFAgXAhxe9Mr4BalrK800gXJ/+g2QwTdTWHMpiE9wWGwOEvlzjp8Q0tySwYa
         zeKnj4UATElIuMdtLMKUgzOQxT5xu8nB8MHOpxjTYCfBzrtEQ8H9emU5XtQXcCTGVaIm
         aXlyh3jMdevrDC2wZF83LQb3uD8Py3Ao3NMlLb876Swg6FyqRQ/fHEDz3PsoINE5/B3P
         MCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757474256; x=1758079056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdI4wzAI+F6qqND7zFZEoC8SvB3//aPvuhJS3lQ10OM=;
        b=IviOHkOSIXgDI7hyAVBMUW7QVUzniCcus6Z6RgtdshU8u74BZZEzVWWJa6EySxbdY/
         eMJWY7hmNNLheaJE9BlnVh5CfgjqtwecrGSZuTNY/vEiNsv8AyHI/wAd65RcJMH+A2zP
         PYFuwmpefSclHZ3cvONHf2NbUlWcKGfYYajZtwJrKKs11zA2cpykAAli+Jq2E7QpiWZT
         5rrGlnOB8elhcGemtYJNeBL225Vi8Fs2A94IGUM00X0Af8CI9USEuDwVtX4VdLqBOBLa
         Wi1t/i4CdW+UAuR70kr2Lzs2ok6WXphuh8GNoqDYJhsg255edlZnxSUXCmmw4vrgVROz
         vt2w==
X-Forwarded-Encrypted: i=1; AJvYcCV+WtPW1TsfAZvR9YYVbjCNhvcABhV5SCzB0lkknVGxkLOKVuAZlkW465roh+nPu8l3unEmiaT8@vger.kernel.org, AJvYcCV9/mzCPrsSwpQIvoyafOI2rX7tcpJlBTik+gm/EyqkSy0eAVkLHIbt2kPfif8EORBnxVvpkZNt3SbUxw==@vger.kernel.org, AJvYcCXWgo5wm21339uzSk4hYPDX52leBff48SSu4c/0sP0sURxD4gPg4Ry+WIUEmtrrLoL08D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGFu0xFtDdejXStI4Jqp0Af12UyrfvIHZG0VgAxGMBlUxXm7d
	troN+KSd8C66xkNlk8ejC4H6ouKJEL+EfwerNqqBiMBupRScwUyI5leqxdw/NmLu00VLgb/0R5x
	VhdkvRilB3DPcA99kQOEmbgXAkjvSN94=
X-Gm-Gg: ASbGnct4YIe69kmkeO1dykHHdNV/+YfByu0rYOra0ILDz+Ydty3T3K7VVsmYBHZhcUR
	u+8xin2M2oQUUMDj7Rv0jMLppUG5WTVxy+LmxFwwrD7QTJbKMrH3/2VPh46WM+WRDwueHzGf8Ri
	T36SU+mnLjWG0cn4wl3nab3pmF3qnJNIu6mEChI+yZtqCRHabQP3BMatUHHGzMwDoWElJxrkar6
	4R6CJuRRglGUGSWyESf
X-Google-Smtp-Source: AGHT+IEUCGKrpE7FE1JAPbWV8dpAZuhmkJbSMhAAD3bq86SM5SCNUsFLsaTmPjCRUvCHRSRV4qrDmcB2C5sWCNW2O7s=
X-Received: by 2002:a05:690c:6d0a:b0:726:9be4:97d3 with SMTP id
 00721157ae682-727f447af12mr120179977b3.24.1757474256261; Tue, 09 Sep 2025
 20:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
 <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
 <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com>
 <CADg4-L92GbxSXaqg1KuoGxt2c_yC=gbmKywVPvcAjHY_7v2H1g@mail.gmail.com> <CADg4-L8dLtzPL-x8o1HAHrbQ2fQ0MxB3Gm68HVj9Jp3-YunwrA@mail.gmail.com>
In-Reply-To: <CADg4-L8dLtzPL-x8o1HAHrbQ2fQ0MxB3Gm68HVj9Jp3-YunwrA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 9 Sep 2025 23:17:25 -0400
X-Gm-Features: AS18NWCkk4n1M_STsN_x9r8s01l9XdNlMPwVL1F5X0UzpeMOtk3OLSvTVDcHSlE
Message-ID: <CAMB2axO3d9Wr64RRxYQd8rg5QVxt5MO=ZzRtJG8njeDYNBW-tw@mail.gmail.com>
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

On Tue, Sep 9, 2025 at 11:18=E2=80=AFAM Christoph Paasch <cpaasch@openai.co=
m> wrote:
>
> On Mon, Sep 8, 2025 at 9:00=E2=80=AFPM Christoph Paasch <cpaasch@openai.c=
om> wrote:
> >
> > On Thu, Sep 4, 2025 at 4:30=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > > On Thu, Sep 4, 2025 at 3:57=E2=80=AFPM Christoph Paasch via B4 Relay
> > > <devnull+cpaasch.openai.com@kernel.org> wrote:
> > > >
> > > > From: Christoph Paasch <cpaasch@openai.com>
> > > >
> > > > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > > > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > > > include part of the payload.
> > > >
> > > > When attempting to do GRO in skb_gro_receive, if headlen > data_off=
set
> > > > (and skb->head_frag is not set), we end up aggregating packets in t=
he
> > > > frag_list.
> > > >
> > > > This is of course not good when we are CPU-limited. Also causes a w=
orse
> > > > skb->len/truesize ratio,...
> > > >
> > > > So, let's avoid copying parts of the payload to the linear part. We=
 use
> > > > eth_get_headlen() to parse the headers and compute the length of th=
e
> > > > protocol headers, which will be used to copy the relevant bits ot t=
he
> > > > skb's linear part.
> > > >
> > > > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the netw=
orking
> > > > stack needs to call pskb_may_pull() later on, we don't need to real=
locate
> > > > memory.
> > > >
> > > > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NI=
C and
> > > > LRO enabled):
> > > >
> > > > BEFORE:
> > > > =3D=3D=3D=3D=3D=3D=3D
> > > > (netserver pinned to core receiving interrupts)
> > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > > >  87380  16384 262144    60.01    32547.82
> > > >
> > > > (netserver pinned to adjacent core receiving interrupts)
> > > > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > > >  87380  16384 262144    60.00    52531.67
> > > >
> > > > AFTER:
> > > > =3D=3D=3D=3D=3D=3D
> > > > (netserver pinned to core receiving interrupts)
> > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > > >  87380  16384 262144    60.00    52896.06
> > > >
> > > > (netserver pinned to adjacent core receiving interrupts)
> > > >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > > >  87380  16384 262144    60.00    85094.90
> > > >
> > > > Additional tests across a larger range of parameters w/ and w/o LRO=
, w/
> > > > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), diff=
erent
> > > > TCP read/write-sizes as well as UDP benchmarks, all have shown equa=
l or
> > > > better performance with this patch.
> > > >
> > > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > > > Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> > > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > > > ---
> > > >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..0ac31c7fb64cd60720d=
390de45a5b6b453ed0a3f 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx=
5e_rq *rq, struct mlx5e_mpw_info *w
> > > >                 dma_sync_single_for_cpu(rq->pdev, addr + head_offse=
t, headlen,
> > > >                                         rq->buff.map_dir);
> > > >
> > > > +               headlen =3D eth_get_headlen(rq->netdev, head_addr, =
headlen);
> > > > +
> > > >                 frag_offset +=3D headlen;
> > > >                 byte_cnt -=3D headlen;
> > > >                 linear_hr =3D skb_headroom(skb);
> > > > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx=
5e_rq *rq, struct mlx5e_mpw_info *w
> > > >                                 pagep->frags++;
> > > >                         while (++pagep < frag_page);
> > > >                 }
> > > > +
> > > > +               headlen =3D eth_get_headlen(rq->netdev, mxbuf->xdp.=
data, headlen);
> > > > +
> > >
> > > The size of mxbuf->xdp.data is most likely not headlen here.
> > >
> > > The driver currently generates a xdp_buff with empty linear data, pas=
s
> > > it to the xdp program and assumes the layout If the xdp program does
> > > not change the layout of the xdp_buff through bpf_xdp_adjust_head() o=
r
> > > bpf_xdp_adjust_tail(). The assumption is not correct and I am working
> > > on a fix. But, if we keep that assumption for now, mxbuf->xdp.data
> > > will not contain any headers or payload. The thing that you try to do
> > > probably should be:
> > >
> > >         skb_frag_t *frag =3D &sinfo->frags[0];
> > >
> > >         headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(frag=
),
> > > skb_frag_size(frag));
>
> So, when I look at the headlen I get, it is correct (even with my old
> code using mxbuf->xdp.data).
>
> To make sure I test the right thing, which scenario would
> mxbuf->xdp.data not contain any headers or payload ? What do I need to
> do to reproduce that ?

A quick look at the code, could it be that
skb_flow_dissect_flow_keys_basic() returns false so that
eth_get_headlen() always returns sizeof(*eth)? The linear part
contains nothing meaning before __psk_pull_tail(), so it is possible
for skb_flow_dissect_flow_keys_basic() to fail.

>
> Thanks,
> Christoph
>
> >
> > Ok, I think I understand what you mean! Thanks for taking the time to e=
xplain!
> >
> > I will do some tests on my side to make sure I get it right.
> >
> > As your change goes to net and mine to netnext, I can wait until yours
> > is in the tree so that there aren't any conflicts that need to be
> > taken care of.

Will Copy you in the mlx5 non-linear xdp fixing patchset.

> >
> >
> > Christoph
> >
> > >
> > >
> > >
> > > >                 __pskb_pull_tail(skb, headlen);
> > > >         } else {
> > > >                 if (xdp_buff_has_frags(&mxbuf->xdp)) {
> > > >
> > > > --
> > > > 2.50.1
> > > >
> > > >

