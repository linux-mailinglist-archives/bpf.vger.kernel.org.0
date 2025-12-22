Return-Path: <bpf+bounces-77327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA0CD768E
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 00:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE54D3017EF6
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36530100D;
	Mon, 22 Dec 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMD2HgiA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E04281341
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444427; cv=pass; b=qll282K0wr7xLW/kFfNJhvlF3cVrb/5wE+TIIefTiDoxS30U2ci1LOeI4cVdTzv8omjOYUXb5qZ5kPOnbYcQqDthPNLYlXNeBQKjkX7E0jJLJf/gmO7LyU75kiF1+F5JSq2lpA5IoOEWduDbAOvwhH3VfTDtHOV0UAKmoVUEsiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444427; c=relaxed/simple;
	bh=NNVVY4Keo0ZlYz/N9p6/UToaHmJPGciEr6zVPCPklgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgN5vxb948Im3P9c4SLcrddQ9leME27RkAt+8GIQDYfNAjc0pbufD3vKnUgAQcXQt71uymFxNQTNAugqMD0Z/hq8CwCPpXH9pvUbqBur6Ywo2asjbUK9z3LNSC7Bveq0tWtLTE39RSm8FpW76oHVIX0609upsRqvWuM+BRaKJ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMD2HgiA; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957eeb9d8aso26110e87.1
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 15:00:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766444424; cv=none;
        d=google.com; s=arc-20240605;
        b=hE+FDKYxWRY5Uo8s7hRnLxG8IYM6cG58bCJMr9uDskTAQJVabniptEMWhZpfT9fOOQ
         tL/E82yNFIXfGbYDyqxYzS9g6WBHL+8ehL/h7tcHIF8Ys+11/p3OWWO24ZTQP+mfj3AD
         9rzB+q0H+JT8zzBoPb8KypVt8rWVnM+NbLzKnDRjm7yvqXA8dLWHkRAEs00SKuq57Djt
         tSrCzy39HFln1QuHSIwSSLSPHR9uuNdMIQPkSb2r7+x0YqjJrEmW6U3UQ2kOUKomK7Dg
         +nuXiyc/z59BQzBiWytB2f4un4XrGNhmKE3tp0dugAQp3iD48PHgSrZwwgPeGPQZPuX6
         4Peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GiffbNV/tBskPZdgVWnbq8D6KwPgfDWsmkGacg7NIk=;
        fh=6AgMR4IXvMP/FEg18pW7RnmWAPfqLWgEvDnNKNE+Oq0=;
        b=leVeypKu6CjpMK4MN9AQL0A1IngLZSWGZ6zA5soXxAgJFI+Cq60lRqE55ukS2OWunM
         Fl26wNb0nUnQqebDn4IvfNPuF5rBHX9tMNoBiUIh85YM7nE2ROmS5LMIcdiso20rZCFF
         9gRkJpVjGuZIkD+O5QFqRocBGtKIvL4t+db8Q/lYdem8Ra2ne88thdl4BBB+cgX23VjK
         wdDzg9r8sCl3jR/36Yjc9i1av+lAJGMyQtrUaq77g0IjRK+6ncrgxa4ZUcdplUKE3F+T
         NVeEii3hnjpJVc9iPfDs1npKE5DBP3GpH7CXKwRDrBuRFHymRQVpDlj/FJnAINPYcMXd
         Gevg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766444424; x=1767049224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GiffbNV/tBskPZdgVWnbq8D6KwPgfDWsmkGacg7NIk=;
        b=lMD2HgiAlhgl5O8Lt8co9ufkZSMXN4lov1zZ2yOBbJ6e32iH1UAI/bALUl4pab0rPF
         0tn0W/WoZcTRy2CHYHRG156i9kMipIbiiQ6Pmkmi620Hiq1lwfrk+7ZAWHldTLUR7tRz
         zb4VSLNU42gCC8b+246Zx0h2LKJyQBzNE2z+vl4j9mm3mK9M/2hoWRGgsgaeBebPAUcQ
         YmovxaRS0OXv2pP6WVXd0WV5cPlNMDR0S7G3ol6cyiIIjaAICXSAUnN+4ZOeqGDKb6E5
         pfk2SfXpyIJ4a2KtvmUiZUjBiUkZ00pri9kOkiO+jFaHDrn294aygbSGZ7KXI98Xm6zy
         6/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766444424; x=1767049224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GiffbNV/tBskPZdgVWnbq8D6KwPgfDWsmkGacg7NIk=;
        b=kVlPzo7Lkhdm77S/XjmPyGUxjek8cC9l/+HEJsNn6aM07D6ER4zaBw+WnMPFrgS2T4
         7LzjMKcwn5Wl0GyZtCcRIsOY69yk86UBzJOyk3VjN8CbJPWXnnFIeIqG7S24KkKlIBo/
         gdADxIIrBqz/7IKNhhVpIvwGH4193Ye71GOxsXxw750HXMaxYHwhGYYYRjjj7mXBg1iJ
         L+vxsctz1c0+O89uBvRrmAELoyU3QFYElYaQVW0nRh30FlsJ+j93iioAxo0+3viimU1e
         +dwqDpAjPx2tB+APikQQdh6ha3vfzp4/ppz9L7GrRUXjvnVRf1s5/WKji+J4rYKshlhj
         yj3g==
X-Forwarded-Encrypted: i=1; AJvYcCV1KLx3kjdVJ9lkEncFNUlLY84nDyrL+ZpqQmTMQgn/waEuPXIZI6fiw61ebNdqEWXDn1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoI0buVBAMxHRfXa+s1dv2IsFl2X1tTP/nQygy9IKt88RB6tR
	jGoNbaMrQd15FysJJIrcSWBp753CZqXNLskKdeRddJC0IJy076VB9FLCtMOT8vzMZ3lMqHyD1sn
	FBAtIZAdLjSmYzLsCG2rMGS0Sg7Zt7UGkKePIntR2
X-Gm-Gg: AY/fxX7aXu/898i5nHU6H0H7MUiQK3TN69fPR0teymw5yWnS6WIkYdvD558g/xN2r2Q
	G2LchAoK+mSPcVB2cuXd1z+k75WOlBkg6kfYopy1oaEFCNHh5UAR7llVeK4lHVRU+ptIDTvR07d
	DdDjdWrWbVYwASfm+vnMt8gIBv0pY66pXKPI4opJ4uvItxbsWtwP3ASjSm2PWYiSHJpAN7Ly9+H
	BCi1KxbY9thRqysoahOgW3EEx2xioSMuLZCA9GQb9foKwoKlHjt7ACAodeocyULSqwGVE0=
X-Google-Smtp-Source: AGHT+IFolDyi0gmcjOW3uPfmwLAvnys6fHTRSXsP7uqs5Jry5LkM+oYjXghvf2oLx1lTxeVLVgcdbG0gyQNcQI3f1Yk=
X-Received: by 2002:ac2:5dc6:0:b0:597:d6db:98fa with SMTP id
 2adb3069b0e04-59a1e6108c0mr182015e87.8.1766444423439; Mon, 22 Dec 2025
 15:00:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219202957.2309698-1-almasrymina@google.com> <870f89e4-aec2-4eb2-8a93-c80484866c6d@intel.com>
In-Reply-To: <870f89e4-aec2-4eb2-8a93-c80484866c6d@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 22 Dec 2025 15:00:11 -0800
X-Gm-Features: AQt7F2ou44GOcMewwcH4dPpJ1kZw_YlLZCYqXqchupAuxd4xBlvlogJgJKpaZLg
Message-ID: <CAHS8izOOyGTYkMct=VJM8jHmzQgXR7y143erxfMvkPOkVJrXJg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	YiFei Zhu <zhuyifei@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:55=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Mina Almasry <almasrymina@google.com>
> Date: Fri, 19 Dec 2025 20:29:54 +0000
>
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > The logic is similar to idpf_rx_hwtstamp, but the data is exported
> > as a BPF kfunc instead of appended to an skb.
> >
> > A idpf_queue_has(PTP, rxq) condition is added to check the queue
> > supports PTP similar to idpf_rx_process_skb_fields.
> >
> > Cc: intel-wired-lan@lists.osuosl.org
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >
> > ---
> >
> > v3: https://lore.kernel.org/netdev/20251218022948.3288897-1-almasrymina=
@google.com/
> > - Do the idpf_queue_has(PTP) check before we read qw1 (lobakin)
> > - Fix _qw1 not copying over ts_low on on !__LIBETH_WORD_ACCESS systems
> >   (AI)
> >
> > v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina=
@google.com/
> > - Fixed alphabetical ordering
> > - Use the xdp desc type instead of virtchnl one (required some added
> >   helpers)
> >
> > ---
> >  drivers/net/ethernet/intel/idpf/xdp.c | 31 +++++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/idpf/xdp.h | 22 ++++++++++++++++++-
> >  2 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethern=
et/intel/idpf/xdp.c
> > index 958d16f87424..0916d201bf98 100644
> > --- a/drivers/net/ethernet/intel/idpf/xdp.c
> > +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (C) 2025 Intel Corporation */
> >
> >  #include "idpf.h"
> > +#include "idpf_ptp.h"
> >  #include "idpf_virtchnl.h"
> >  #include "xdp.h"
> >  #include "xsk.h"
> > @@ -391,8 +392,38 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md =
*ctx, u32 *hash,
> >                                   pt);
> >  }
> >
> > +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *time=
stamp)
> > +{
> > +     const struct libeth_xdp_buff *xdp =3D (typeof(xdp))ctx;
> > +     struct idpf_xdp_rx_desc desc __uninitialized;
> > +     const struct idpf_rx_queue *rxq;
> > +     u64 cached_time, ts_ns;
> > +     u32 ts_high;
> > +
> > +     rxq =3D libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> > +
> > +     if (!idpf_queue_has(PTP, rxq))
> > +             return -ENODATA;
> > +
> > +     idpf_xdp_get_qw1(&desc, xdp->desc);
> > +
> > +     if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID)=
)
> > +             return -ENODATA;
> > +
> > +     cached_time =3D READ_ONCE(rxq->cached_phc_time);
> > +
> > +     idpf_xdp_get_qw3(&desc, xdp->desc);
> > +
> > +     ts_high =3D idpf_xdp_rx_ts_high(&desc);
> > +     ts_ns =3D idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high)=
;
> > +
> > +     *timestamp =3D ts_ns;
> > +     return 0;
> > +}
> > +
> >  static const struct xdp_metadata_ops idpf_xdpmo =3D {
> >       .xmo_rx_hash            =3D idpf_xdpmo_rx_hash,
> > +     .xmo_rx_timestamp       =3D idpf_xdpmo_rx_timestamp,
> >  };
> >
> >  void idpf_xdp_set_features(const struct idpf_vport *vport)
> > diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethern=
et/intel/idpf/xdp.h
> > index 479f5ef3c604..9daae445bde4 100644
> > --- a/drivers/net/ethernet/intel/idpf/xdp.h
> > +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> > @@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
> >       aligned_u64             qw1;
> >  #define IDPF_XDP_RX_BUF              GENMASK_ULL(47, 32)
> >  #define IDPF_XDP_RX_EOP              BIT_ULL(1)
> > +#define IDPF_XDP_RX_TS_LOW   GENMASK_ULL(31, 24)
> >
> >       aligned_u64             qw2;
> >  #define IDPF_XDP_RX_HASH     GENMASK_ULL(31, 0)
> >
> >       aligned_u64             qw3;
> > +#define IDPF_XDP_RX_TS_HIGH  GENMASK_ULL(63, 32)
> >  } __aligned(4 * sizeof(u64));
> >  static_assert(sizeof(struct idpf_xdp_rx_desc) =3D=3D
> >             sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
> > @@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) =3D=
=3D
> >  #define idpf_xdp_rx_buf(desc)        FIELD_GET(IDPF_XDP_RX_BUF, (desc)=
->qw1)
> >  #define idpf_xdp_rx_eop(desc)        !!((desc)->qw1 & IDPF_XDP_RX_EOP)
> >  #define idpf_xdp_rx_hash(desc)       FIELD_GET(IDPF_XDP_RX_HASH, (desc=
)->qw2)
> > +#define idpf_xdp_rx_ts_low(desc)     FIELD_GET(IDPF_XDP_RX_TS_LOW, (de=
sc)->qw1)
> > +#define idpf_xdp_rx_ts_high(desc)    FIELD_GET(IDPF_XDP_RX_TS_HIGH, (d=
esc)->qw3)
> >
> >  static inline void
> >  idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
> > @@ -149,7 +153,10 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
> >       desc->qw1 =3D ((const typeof(desc))rxd)->qw1;
> >  #else
> >       desc->qw1 =3D ((u64)le16_to_cpu(rxd->buf_id) << 32) |
> > -                 rxd->status_err0_qw1;
> > +                     ((u64)rxd->ts_low << 24) |
> > +                     ((u64)rxd->fflags1 << 16) |
> > +                     ((u64)rxd->status_err1 << 8) |
>
> I'm not sure you need casts to u64 here. Pls rebuild without them and
> check the objdiff / compiler warnings.
> It's required for buf_id as we shift by 32.
>

The compiler does not warn if I drop the u64 casts, but are you sure
you want them dropped? You're already doing u64 casts in all the
entries that you bit-shift in qw0 and qw2. It makes the code clearer
imo. But up to you.

> > +                     rxd->status_err0_qw1;
>
> Why did you replace the proper indentation with two tabs in all 4 lines
> above?
>

Sure, will fix.

--=20
Thanks,
Mina

