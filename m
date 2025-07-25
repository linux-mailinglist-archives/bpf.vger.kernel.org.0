Return-Path: <bpf+bounces-64373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C5B11E3F
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18BC582360
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE262451C3;
	Fri, 25 Jul 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5tuqyHO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C417F4F6;
	Fri, 25 Jul 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445517; cv=none; b=f+/GN3hjL9DIBU27FJyF0nAvri+9qDZ3tA+LXYsc1CeSxow/gL21EX4aqZrO3/6orlWjS+VfThLBPohrTSviGQjhw39A3pwAAtTq415TGcxQx3s6vZ6WslJfwpQ9YeImAP07/dz5HkWCPvu+WR36majmc4IjRKZxhiZ5w76X0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445517; c=relaxed/simple;
	bh=L6Dp4eG4XOsApUqsR23qNCVNnSI643wQeIp826UReSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dc+LOzzcLs1qw4R060EJ08TM0HMR1J5dwD2/n6VCzc3TXY0WMjLZiCak5IefP3PE5a7p+Cvaj7+8rHn4ZJ5MDRHyK6HCH0TjEv86gTfVSVErcJVSQNsqGgliWdszQinaYzVG7rQscFEhookyOqW3WwGdCVTy9+7HE0Vwb9SaaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5tuqyHO; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86efcef9194so80387839f.0;
        Fri, 25 Jul 2025 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753445514; x=1754050314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CPgnpxfmPhs+gnt6ZDYO4+q1U78COBGpsuFjQMxKjo=;
        b=M5tuqyHOoaDCxbaF/rWNjaWC46FpL8K29fmLNf9QXuTWr6rvb8tMUapGKx/jC0UnUR
         f1ekbvuoeaE09rTn9SxJsCP70mTvHhmQnKL59MghH47Y7rIZ8UGnVUriKc2qlTHHaj1G
         bc35rjnWvvADqqLVXJkDauCaNONWnv03qmojkxbtGp9v58nag76Ur6B6oZU++VSEX53t
         C4++yuvG3U3iPkemxZwvsfq1f7unSAHERwAJpCIOeNGOEoVY8Ad60IPrEKlW1PHYnoCk
         /gL/j5oO6Gj+Qxeupehy2qr97pzDZ0vuluukSDMxk4lj7UN+PIVIu1JNLvlqbB1i9aZS
         yPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445514; x=1754050314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CPgnpxfmPhs+gnt6ZDYO4+q1U78COBGpsuFjQMxKjo=;
        b=gUHQJfU3fbV4nzgAoZSVdWsvdsv1TlhBU3mTEZ0LNZnKK0mm0sCB0wtzUw5D3U6LDA
         VMIqOrE3yPvAWC+KxYCC9guYfWvVeRRGrGQ2LiCBdM7LnIqz3uGaxiKUArE3M9F0C7r4
         5dO482edE4fZmLygFRQA3OFTdBjurFquhsLuNiOB9sQ7RfN8UzAJq/erCSDZTAFjy4zB
         ZU0DDXMihUB6OpnzI4TGHkV4+iyjRsMxTl8muU4CfiJRnD7WkudW8aLXpFfjmqeJvrZp
         LwpvnLOmYl+KxJRe8SGnIqcvdUwep0pXkiEtKU4sk3pIUG12eV38pcjuy4Lxtk7Gbv8C
         c+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6E8uN5ZkO1qSVkkD4jDf1sf/Bd64loTHgAwTPgyVW15VeYNeowHqC66FRHMXV8uL0zGc7bSY@vger.kernel.org, AJvYcCWgOxU/RVTDqO6MXUSGJB+tyDJup0MZEhL13g87TSX41tCsnazjp4ETZCArsNSmtJrVDWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTYDKFHoHoy/7TeFvS6PLM16cKqrmGeyz1MksH09qKaC1W+Fp
	cNGdlgFA2uNaUaFn14FRFrTpQaMFQwbhGM9bALRugaC9SWKxMzaOeSi0FLgy/PdnkJiFbyFsLlM
	iRyuhI5t+6GgQxNmMIXeB/VZM8teveDs=
X-Gm-Gg: ASbGncuujh3C5bXsNYjYBvC+/Mgn9t00oSgj4Q8ptjKwGEPVV9hJM/dBETKdN1/bPTl
	Tx5StZsq+nkSXge0ins34ppvhzobSHhYQc39+JYMBU1LWmUHBOIaF/WkSyw00pahtz0gKRhAKxP
	VrVJUuROczv7QW5+ZUfJp56yQ9WJ3Nf6BZvrXchEJ6D2HybEz7FtT1MDF6m7/dDSpBGYJe1CxOf
	6Htvw==
X-Google-Smtp-Source: AGHT+IHkvDgSrSxVsaaYe7jXkMrGwMFeg53FXhoU7TAFU5nMzUO9QlX144tZhknqnEG2zc+3h0RKASR/5QVcg2M58cc=
X-Received: by 2002:a05:6e02:3385:b0:3dd:d995:30ec with SMTP id
 e9e14a558f8ab-3e3c52bc2e2mr26936935ab.12.1753445514394; Fri, 25 Jul 2025
 05:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-5-kerneljasonxing@gmail.com> <aINhqcDpvw2FM9Ia@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aINhqcDpvw2FM9Ia@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 25 Jul 2025 20:11:18 +0800
X-Gm-Features: Ac12FXwy5edfAgZ8nM8Thz1nd5cFl2oaEhRyBVWnC_ZJoykfgiCMOwVvG5Oid3s
Message-ID: <CAL+tcoADu-ZZewsZzGDaL7NugxFTWO_Q+7WsLHs3Mx-XHjJnyg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] ixgbe: xsk: support batched xsk Tx
 interfaces to increase performance
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 6:52=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Sun, Jul 20, 2025 at 05:11:22PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Like what i40e driver initially did in commit 3106c580fb7cf
> > ("i40e: Use batched xsk Tx interfaces to increase performance"), use
> > the batched xsk feature to transmit packets.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 106 +++++++++++++------
> >  1 file changed, 72 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net=
/ethernet/intel/ixgbe/ixgbe_xsk.c
> > index f3d3f5c1cdc7..9fe2c4bf8bc5 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > @@ -2,12 +2,15 @@
> >  /* Copyright(c) 2018 Intel Corporation. */
> >
> >  #include <linux/bpf_trace.h>
> > +#include <linux/unroll.h>
> >  #include <net/xdp_sock_drv.h>
> >  #include <net/xdp.h>
> >
> >  #include "ixgbe.h"
> >  #include "ixgbe_txrx_common.h"
> >
> > +#define PKTS_PER_BATCH 4
> > +
> >  struct xsk_buff_pool *ixgbe_xsk_pool(struct ixgbe_adapter *adapter,
> >                                    struct ixgbe_ring *ring)
> >  {
> > @@ -388,58 +391,93 @@ void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *r=
x_ring)
> >       }
> >  }
> >
> > -static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int bu=
dget)
> > +static void ixgbe_set_rs_bit(struct ixgbe_ring *xdp_ring)
> > +{
> > +     u16 ntu =3D xdp_ring->next_to_use ? xdp_ring->next_to_use - 1 : x=
dp_ring->count - 1;
> > +     union ixgbe_adv_tx_desc *tx_desc;
> > +
> > +     tx_desc =3D IXGBE_TX_DESC(xdp_ring, ntu);
> > +     tx_desc->read.cmd_type_len |=3D cpu_to_le32(IXGBE_TXD_CMD_RS);
> > +}
> > +
> > +static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_ring, struct xdp_des=
c *desc,
> > +                        int i)
> > +
>
> `i` parameter seems redundant here, why not just pass desc + i as a param=
eter?

Let me resolve this :)

Thanks,
Jason

>
> >  {
> >       struct xsk_buff_pool *pool =3D xdp_ring->xsk_pool;
> >       union ixgbe_adv_tx_desc *tx_desc =3D NULL;
> >       struct ixgbe_tx_buffer *tx_bi;
> > -     struct xdp_desc desc;
> >       dma_addr_t dma;
> >       u32 cmd_type;
> >
> > -     if (!budget)
> > -             return true;
> > +     dma =3D xsk_buff_raw_get_dma(pool, desc[i].addr);
> > +     xsk_buff_raw_dma_sync_for_device(pool, dma, desc[i].len);
> >
> > -     while (likely(budget)) {
> > -             if (!netif_carrier_ok(xdp_ring->netdev))
> > -                     break;
> > +     tx_bi =3D &xdp_ring->tx_buffer_info[xdp_ring->next_to_use];
> > +     tx_bi->bytecount =3D desc[i].len;
> > +     tx_bi->xdpf =3D NULL;
> > +     tx_bi->gso_segs =3D 1;
> >
> > -             if (!xsk_tx_peek_desc(pool, &desc))
> > -                     break;
> > +     tx_desc =3D IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
> > +     tx_desc->read.buffer_addr =3D cpu_to_le64(dma);
> >
> > -             dma =3D xsk_buff_raw_get_dma(pool, desc.addr);
> > -             xsk_buff_raw_dma_sync_for_device(pool, dma, desc.len);
> > +     cmd_type =3D IXGBE_ADVTXD_DTYP_DATA |
> > +                IXGBE_ADVTXD_DCMD_DEXT |
> > +                IXGBE_ADVTXD_DCMD_IFCS;
> > +     cmd_type |=3D desc[i].len | IXGBE_TXD_CMD_EOP;
> > +     tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
> > +     tx_desc->read.olinfo_status =3D
> > +             cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> >
> > -             tx_bi =3D &xdp_ring->tx_buffer_info[xdp_ring->next_to_use=
];
> > -             tx_bi->bytecount =3D desc.len;
> > -             tx_bi->xdpf =3D NULL;
> > -             tx_bi->gso_segs =3D 1;
> > +     xdp_ring->next_to_use++;
> > +}
> >
> > -             tx_desc =3D IXGBE_TX_DESC(xdp_ring, xdp_ring->next_to_use=
);
> > -             tx_desc->read.buffer_addr =3D cpu_to_le64(dma);
> > +static void ixgbe_xmit_pkt_batch(struct ixgbe_ring *xdp_ring, struct x=
dp_desc *desc)
> > +{
> > +     u32 i;
> >
> > -             /* put descriptor type bits */
> > -             cmd_type =3D IXGBE_ADVTXD_DTYP_DATA |
> > -                        IXGBE_ADVTXD_DCMD_DEXT |
> > -                        IXGBE_ADVTXD_DCMD_IFCS;
> > -             cmd_type |=3D desc.len | IXGBE_TXD_CMD;
> > -             tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
> > -             tx_desc->read.olinfo_status =3D
> > -                     cpu_to_le32(desc.len << IXGBE_ADVTXD_PAYLEN_SHIFT=
);
> > +     unrolled_count(PKTS_PER_BATCH)
> > +     for (i =3D 0; i < PKTS_PER_BATCH; i++)
> > +             ixgbe_xmit_pkt(xdp_ring, desc, i);
> > +}
> >
> > -             xdp_ring->next_to_use++;
> > -             if (xdp_ring->next_to_use =3D=3D xdp_ring->count)
> > -                     xdp_ring->next_to_use =3D 0;
> > +static void ixgbe_fill_tx_hw_ring(struct ixgbe_ring *xdp_ring,
> > +                               struct xdp_desc *descs, u32 nb_pkts)
> > +{
> > +     u32 batched, leftover, i;
> > +
> > +     batched =3D nb_pkts & ~(PKTS_PER_BATCH - 1);
> > +     leftover =3D nb_pkts & (PKTS_PER_BATCH - 1);
> > +     for (i =3D 0; i < batched; i +=3D PKTS_PER_BATCH)
> > +             ixgbe_xmit_pkt_batch(xdp_ring, &descs[i]);
> > +     for (i =3D batched; i < batched + leftover; i++)
> > +             ixgbe_xmit_pkt(xdp_ring, &descs[i], 0);
> > +}
> >
> > -             budget--;
> > -     }
> > +static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int bu=
dget)
> > +{
> > +     struct xdp_desc *descs =3D xdp_ring->xsk_pool->tx_descs;
> > +     u32 nb_pkts, nb_processed =3D 0;
> >
> > -     if (tx_desc) {
> > -             ixgbe_xdp_ring_update_tail(xdp_ring);
> > -             xsk_tx_release(pool);
> > +     if (!netif_carrier_ok(xdp_ring->netdev))
> > +             return true;
> > +
> > +     nb_pkts =3D xsk_tx_peek_release_desc_batch(xdp_ring->xsk_pool, bu=
dget);
> > +     if (!nb_pkts)
> > +             return true;
> > +
> > +     if (xdp_ring->next_to_use + nb_pkts >=3D xdp_ring->count) {
> > +             nb_processed =3D xdp_ring->count - xdp_ring->next_to_use;
> > +             ixgbe_fill_tx_hw_ring(xdp_ring, descs, nb_processed);
> > +             xdp_ring->next_to_use =3D 0;
> >       }
> >
> > -     return !!budget;
> > +     ixgbe_fill_tx_hw_ring(xdp_ring, &descs[nb_processed], nb_pkts - n=
b_processed);
> > +
> > +     ixgbe_set_rs_bit(xdp_ring);
> > +     ixgbe_xdp_ring_update_tail(xdp_ring);
> > +
> > +     return nb_pkts < budget;
> >  }
> >
> >  static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
> > --
> > 2.41.3
> >
> >

