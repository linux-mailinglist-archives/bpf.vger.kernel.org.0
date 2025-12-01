Return-Path: <bpf+bounces-75793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D68C957EE
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 02:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4BA64E0428
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 01:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C813E41A;
	Mon,  1 Dec 2025 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ryyy4KeX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF533987
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764552465; cv=none; b=GiQaqNy1wC0ayMH/6MGe524sEJas3b1pWkYzFMBpaJgQhMg0YMRtJ0c9A+6BHGS7fPgsCPywdqQc2jqKPiviD5aCPjeXIjzJJyaRDRxQ9/Z3kM0vjASs5sSnQw9DakxWzzNuTAVfpotNlb6R1HsAhstJwUNni1yMY2YWPua0R9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764552465; c=relaxed/simple;
	bh=hRqTviMO1FHidgSeW5rEOVfdL+47yZuaWT+X/2K/q7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI6dHdiEKEp4V8rDzN54QxgUKhjQwcv8gEjIEsfthfo+7ok15yJ6eQdenjTS695rF1cHM3u6C4S5xhWvbHIdluvaVdLJF/lKZLmBwxKUKwfBLvFWx3b8/xqDJkcmHLPpYH+7iOxE2ceie6mwfZYy40IRQop0meyiSLsszG47eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ryyy4KeX; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59434b28624so22297e87.1
        for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 17:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764552460; x=1765157260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehYGc97IwrLDHQvpTuRv7v/3RImO4vhIDaHvlIMcxcE=;
        b=Ryyy4KeXIVT/HzvtUjPS6FXGUxflVTNArEFZmNby8QcP/Q547xVBdlnzcI7NFVfjVJ
         yVcT1mfpWFU2/ovf8lXvR6EEnZN/VogTDHoaCmu0KxdD17xDXcoLswmqkAfHhYk0ufUQ
         FpernAN9xi+8RGw6rMD48ZvETKIbEDp3z3HUdBK3NPcDeQ5k35NFQev3ZAaa3UfofGGu
         1t3Lvx9kuolUqWPjvRLGJnHCzu7Hluft4J9WtvCzK0Sv6M4MHgCU/9CYmVVdY+S5GGFU
         OdC3rFJUF6/dJxTnRBs+j1HK/OYB6xUZKDSYwkfLnzCrta1C1GgErETJilMWuBgGZdbF
         HXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764552460; x=1765157260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ehYGc97IwrLDHQvpTuRv7v/3RImO4vhIDaHvlIMcxcE=;
        b=JoPztsGptqlFfQA2lHNHo5cBN9OI56ttyXIFhaCsHfsDkH+iL5MMkaD+X/crpTshmJ
         c8Gt1Jtc2fLltrsdpup3AbuOM6520hbN4TSz9yEAC/42Y6OqzNBV1iAq/5TVZ6ddS3H8
         ZHEvb80viWlwCRlXhcU+R2lu9yW9+DDLsTyaIcybRDp0W8rr4CL33eBIir20D0LvOi9G
         XaRwj7dI0c+zAjA1R7Txgx8Fp6ybbZRAuogMQYgD5b7log1sJE6sNOzAPuoWNP7HpieB
         P2lK3v45s5E8v+KRj4S8oHqahJxWK12AfMNMfzJDX7AfuOE62n37LRcVOdhYKD3kPy31
         wJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCWLHc2AKy9v+lxyXqZzD42buN0mMehTmrnihVY/SKlFrM024QxahAhIwH9c4lxOj/ZaY7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCJRK+GWtF5iqFClPSuP6H9llzGpW6lCrUdzRlUFs2z7MM7G1
	mm8gmN720nOiQGl8pqFdoKJguKH/q/P/gML7JuXmaNT1T0fyz1dvOlPAQSTrrd8UADKD0Acm8yi
	RmuhQ9FSBOVF72ZT//xSRNRjSvJXZUaIV6YchfWvi
X-Gm-Gg: ASbGnctxSxy1weEEpdajX3zjBwXhcwGfhTsGG3okUQwIHRpQ6/Kc8kWyyVsAOAXwE0b
	H1p0jrnQoVO6sPvegn62yY/P1oJIRhljSxQL1Y6QkyV0dGgcyi4kzB9GM2kWTkp53FvkNLCk1Il
	yCG4Tvh3D4qV8ssjgEBPsT3BDtIwB2OxbWobYCxscF3SvkXqaR5zZOACZ2syzGG2DwDZ5FqcLLV
	lbWzKlcslL6INrmi+caPud/vt0we+wRHYn+uJatac4C10gtwE24yFCdh1hF/rzEk/PIFh0=
X-Google-Smtp-Source: AGHT+IGUtxtVROoFL9XWjzu7VOF6oLjMb/cN+4biEc3EnHVPC3Y1fSDYFJip1ZsrUhL2CHurERDtTpPY0GeOtj8Rxik=
X-Received: by 2002:a05:6512:1343:b0:596:9b1c:95da with SMTP id
 2adb3069b0e04-596bdce2767mr186845e87.17.1764552460026; Sun, 30 Nov 2025
 17:27:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122140839.3922015-1-almasrymina@google.com> <DS4PPF7551E6552ECCF95AE9C177DEF07F8E5D0A@DS4PPF7551E6552.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPF7551E6552ECCF95AE9C177DEF07F8E5D0A@DS4PPF7551E6552.namprd11.prod.outlook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 30 Nov 2025 19:27:26 -0600
X-Gm-Features: AWmQ_bntuE3GnpzJMZaG9Cr3R1vpsBmf3PJosTlld9e_VcSuzfSnUowwDbN3jGY
Message-ID: <CAHS8izOjZxEgBmYEhZanp57ukCYU5i5FdWfx5HO5+Ua2V3Owsg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] idpf: export RX hardware
 timestamping information to XDP
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 2:33=E2=80=AFAM Loktionov, Aleksandr
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
>

Hey, sorry for the late reply. Initially when I read the reply, I
thought: "why not, lets add a leXX_to_cpu".

But now that I look closer to implement the change and submit v2, it
looks correct as written. ts_low is defined as a u8:

```
struct virtchnl2_rx_flex_desc_adv_nic_3 {
...
u8 ts_low;
```

So it should not be fed into any leXX_to_cpu() functions, no?

I also looked at other u8 members in this struct like `u8
status_err0_qw0` and `u8 status_err0_qw1`, and both are used in
existing code without a conversion. So it seems correct as written.
Can you reconsdirer?

If you insist some change is required, can you elaborate more on what
needs to be changed? There is no le8_to_cpu, unless a trivial one that
does nothing (one byte struct cannot be little or big endian).

