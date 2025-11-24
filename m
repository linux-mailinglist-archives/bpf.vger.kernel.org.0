Return-Path: <bpf+bounces-75331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DDDC7FFF1
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 11:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92413A74F4
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B62F9DBC;
	Mon, 24 Nov 2025 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mInr/qGK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D72F60CC
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981527; cv=none; b=tupHi76VEi/Fmvsf4eT3USdE8MSmVcnEHlzwSVTYGWxs29Yr9frqvxKcLIEKPyymqGDXj4ebwHzU6H5pZsajx7nlQEHcKd4QrmIqETGibPYrp0EC4YEy3xP3BqcEHSUvkJkGX39XU/4brz1N0EltvmRyZboSjRkSLJgbN/TC5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981527; c=relaxed/simple;
	bh=Nel7FZErsVTR5AJ0l1KUl8c4jxDfHnzRgpNjWNNowDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za/6pF+1HeFvZmIugJ5wtJ/dNoUiEkpduDxEcC38rdWc/r8guy9fhyTN5P6Zmqi0Z0Mq0mJ8LEdvZoYPoysIgGJob+lXaYhlBy0hiJ0zVbMcooLcoI/zKZEJH1laFTCfACPjeoQugohMsrZV00MnYMoDXW82QVKsUBSNjp+HRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mInr/qGK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779a4fb9bfso89905e9.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 02:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763981523; x=1764586323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpxmS1rh+TvJjifFQqBSZjtvzj8hJPtK/fgbxoLiMac=;
        b=mInr/qGKi1KujnVc3EjL5KaPwmITGz6Kxzye9qHUY7iY5eruQBfY/RbNLg/Cnv47ZT
         U6H1d7iyh4qIcq8IwxE+q+fOtisAApXE/B8uXatOnKAuZ7IBSRppeMOBYkswdJ6Oz3lK
         652zG9URM71W3u+2xAnZ6OvrHWRTK6gjRB+WjyF0VKCQTObcmg7TZqmzfk2oVTiBAtm1
         16UATaXTCWbYo6+/FBDQI3ghSBt3Q8OOJXTp0c0Y9Fy8rNbf91MnQiZeKmweC7AWMtFn
         Aia+XZqrdyT4A8G1bQjy2ZUiD8TmHaEq1NQp9HKBJo3ycpI4dKD8PmZgJOIAFbXHtx03
         j1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763981523; x=1764586323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpxmS1rh+TvJjifFQqBSZjtvzj8hJPtK/fgbxoLiMac=;
        b=B2I2+wNXhSSxyzfkKO3IY8D1j9vCPaSqVYmxTaiybZcpqZSKXRbb3m41BbeUKlsMif
         5cgiLF063KMEIBTbP6LqZETn4G7wqeYTSN+msLkGvJLny57pYCAtf7VBx1FMg0P+6+tm
         M557756+rWqeyCqvgYS9+fG8ZJyDQLvDzi8P3All/v4iiFMiG+GN2dQpv4KsTEVa/kq0
         beFcng/LSKaoQK6/rw4EqrTypxWYzsxSpvFpZua0eXdAz5ceM57JcZrEaSxAFOvh0pkG
         Vsb0s73zz8iIlJHkKqSOretQn4k7WMcMrEGIZdQe9WUuraVYxmVskMI8wzoiljAn+0xu
         4/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUUblFXKBD5l5v5QSI1RJL7mQQMXKQI8jR9wl1VByOqc/uR7tMUGoomWzM/rE8saBiJKBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Sq5BZhFYfZlye7/LN2sJqO0vWH4OsdNGoDXVYP8hn+N+dFYw
	0ige7+evuF3e0/8dFysCk7DfFRYHCQPW5ifFa2jyYt1BasaP1AdXhD7H2uP8HgbhGs8BwiitI2z
	/m7YGlvEuycRhykDfvAlTE+pdA+OlJDJ2R/pMbQ8N
X-Gm-Gg: ASbGncsIOr2oE2RfcKD/00R4+Sfu7F6ssf4vDQ/HmnrMga9SkkDFgtmouWAOS5/b+k5
	Z7HsYB8792GyJSVTVtI2oc1XOL/slPhH+3vyXJJOmu/F4vmKZs+0u7FUAcbNR4lSSXb6dvt5KQZ
	sm1NixTBjhH2Xsr+/+1JhCdo4TwtVJfRwzIjP4pNR4YTdFKp60wTQPEj1o7LKBEQnbyFwFbXQKd
	Ycx5qTqvXCWHX2w40Rn1fEoEsd8Kzg/4FyJjosXF1LeQoKqzK5lDG8PrG1+V/A0hLlo2izlOgIS
	DpUIs5Q=
X-Google-Smtp-Source: AGHT+IF22QHiRShwy0PNGubA4NozhAovK3+cvWApeflXs47OCki2QvEgos4UcFdY3X1d20qrAJLxvPy1WjNMWz9nz+4=
X-Received: by 2002:a05:600c:c1c8:10b0:477:76ea:ba7a with SMTP id
 5b1f17b1804b1-477c5ea4a2bmr1041565e9.3.1763981523108; Mon, 24 Nov 2025
 02:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122140839.3922015-1-almasrymina@google.com> <DS4PPF7551E6552ECCF95AE9C177DEF07F8E5D0A@DS4PPF7551E6552.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPF7551E6552ECCF95AE9C177DEF07F8E5D0A@DS4PPF7551E6552.namprd11.prod.outlook.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Mon, 24 Nov 2025 02:51:50 -0800
X-Gm-Features: AWmQ_bl2ejYEDqgSm31Iu3olmZmBqyCwAIhOCZtCkXdCQaanfp4saa25LSksAEA
Message-ID: <CAA-VZP=mvGBOhkc-hmCsmP=uN_qb5ZG1dwhbO2cOyrAYS0wPDw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Mina Almasry <almasrymina@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 12:33=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Mina Almasry
> > Sent: Saturday, November 22, 2025 3:09 PM
> > To: netdev@vger.kernel.org; bpf@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: YiFei Zhu <zhuyifei@google.com>; Alexei Starovoitov
> > <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; David S.
> > Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Jesper
> > Dangaard Brouer <hawk@kernel.org>; John Fastabend
> > <john.fastabend@gmail.com>; Stanislav Fomichev <sdf@fomichev.me>;
> > Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> > Eric Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>;
> > Lobakin, Aleksander <aleksander.lobakin@intel.com>; Richard Cochran
> > <richardcochran@gmail.com>; intel-wired-lan@lists.osuosl.org; Mina
> > Almasry <almasrymina@google.com>
> > Subject: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX
> > hardware timestamping information to XDP
> >
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > The logic is similar to idpf_rx_hwtstamp, but the data is exported as
> > a BPF kfunc instead of appended to an skb.
> >
> > A idpf_queue_has(PTP, rxq) condition is added to check the queue
> > supports PTP similar to idpf_rx_process_skb_fields.
> >
> > Cc: intel-wired-lan@lists.osuosl.org
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/xdp.c | 27
> > +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/xdp.c
> > b/drivers/net/ethernet/intel/idpf/xdp.c
> > index 21ce25b0567f..850389ca66b6 100644
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
> > @@ -369,6 +370,31 @@ int idpf_xdp_xmit(struct net_device *dev, int n,
> > struct xdp_frame **frames,
> >                                      idpf_xdp_tx_finalize);
> >  }
> >
> > +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64
> > +*timestamp) {
> > +     const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
> > +     const struct libeth_xdp_buff *xdp =3D (typeof(xdp))ctx;
> > +     const struct idpf_rx_queue *rxq;
> > +     u64 cached_time, ts_ns;
> > +     u32 ts_high;
> > +
> > +     rx_desc =3D xdp->desc;
> > +     rxq =3D libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> > +
> > +     if (!idpf_queue_has(PTP, rxq))
> > +             return -ENODATA;
> > +     if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
> > +             return -ENODATA;
> RX flex desc fields are little=E2=80=91endian.
> You already convert ts_high with le32_to_cpu(), but test ts_low directly =
against the mask.
> On big=E2=80=91endian this can misdetect the bit and spuriously return -E=
NODATA.
> Please convert ts_low to host order before the bit test.
> See existing IDPF/ICE patterns where descriptor words are leXX_to_cpu()=
=E2=80=91converted prior to FIELD_GET() / bit checks.
> Also, per the XDP RX metadata kfunc docs, -ENODATA must reflect true abse=
nce of per=E2=80=91packet metadata; endianness=E2=80=91correct testing is r=
equired to uphold the semantic.

The logic is copied as verbatim from idpf_rx_hwtstamp:

static void
idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
                 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
                 struct sk_buff *skb)
{
        u64 cached_time, ts_ns;
        u32 ts_high;

        if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
                return;

        cached_time =3D READ_ONCE(rxq->cached_phc_time);

        ts_high =3D le32_to_cpu(rx_desc->ts_high);
        ts_ns =3D idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
[...]

I assume that is incorrect and would need to be fixed too?

YiFei Zhu

> > +
> > +     cached_time =3D READ_ONCE(rxq->cached_phc_time);
> > +
> > +     ts_high =3D le32_to_cpu(rx_desc->ts_high);
> > +     ts_ns =3D idpf_ptp_tstamp_extend_32b_to_64b(cached_time,
> > ts_high);
> > +
> > +     *timestamp =3D ts_ns;
> > +     return 0;
> > +}
> > +
> >  static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
> >                             enum xdp_rss_hash_type *rss_type)  { @@ -
> > 392,6 +418,7 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md
> > *ctx, u32 *hash,  }
> >
> >  static const struct xdp_metadata_ops idpf_xdpmo =3D {
> > +     .xmo_rx_timestamp       =3D idpf_xdpmo_rx_timestamp,
> >       .xmo_rx_hash            =3D idpf_xdpmo_rx_hash,
> >  };
> >
> >
> > base-commit: e05021a829b834fecbd42b173e55382416571b2c
> > --
> > 2.52.0.rc2.455.g230fcf2819-goog
>

