Return-Path: <bpf+bounces-39427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C775972E94
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290541F21FA8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28819006F;
	Tue, 10 Sep 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZCB+NE4p"
X-Original-To: bpf@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56C183CB0;
	Tue, 10 Sep 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961407; cv=none; b=WfGW1yN/CgekIHcHIyNLsW0B7g5FOyD3DAaeFV7vrfuOHwKM2UKczb6/8HyheFd1zptBkwe4Lr0uKTM9Q7JvBaN6PW3dIslQ/Gar1e+EGIfVXEm81SoKS2FDfp3eTYgz1+RJ9Zbd+NZm+3E9/FLghYvzTYw7oT35HqRjNQuK/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961407; c=relaxed/simple;
	bh=/23hy7Mk04sacJQrQYloYrb0pp+6CKVixUjvk6VV7vM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr1FObcvoNLkb58Su3+7ZVIjD3vVCgBwfvQfzUXxLxsFelSN9RbEKB5DHw2oMVTHUttZnJrlg2Sv0M+g75yy4DZLWnFo5iRHQS0SmXsPmXhdfWZTHeFJacXQgFz75jSNve1yr0scfb0amB89ozKi5QVizHybzUpD0Ef0mncdTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZCB+NE4p; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725961405; x=1757497405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/23hy7Mk04sacJQrQYloYrb0pp+6CKVixUjvk6VV7vM=;
  b=ZCB+NE4pPDCYxHN5VPccWeyfei2xGTzMHnAhaXvCV/wPhNhfQ8Sev0pT
   ZqR5aCV+m46opZsZ3WDMczO5U/s8KFk6l9hc+Ze3jQjeWeL84wtXudT8A
   hll47TS4AG3V/SvFLoKFQQusL2sLHyKSRU1C7uEpODQegGBA3brPFRRMQ
   OlVQ3vIhJzbVHZ8XKdhT7/sYDomJef6C/cXr3XN7Y9cZlufeirt0FZTht
   Az646NRDW4c6CEp6MpYmxBX20ET0PPFmhf26OPu7V7umdxe3+6LWjb1Dw
   8biVCZbaxnhEaKfk/ZIUTAkIc9OInh01dZgnXWSd1dnf+bLVX/U+RMmQl
   g==;
X-CSE-ConnectionGUID: B+zr+AzST0asdRwPHFVR3w==
X-CSE-MsgGUID: CKJnfMvNSFaHgD3TNp8zJw==
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="198998003"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2024 02:43:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 10 Sep 2024 02:42:43 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 10 Sep 2024 02:42:41 -0700
Date: Tue, 10 Sep 2024 09:42:40 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 04/12] net: lan966x: use the FDMA library for
 allocation of rx buffers
Message-ID: <20240910094240.ileosxxgujfolkza@DEN-DL-M70577>
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
 <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
 <f8b58d30-cd45-4cb6-b6ca-ac076f072688@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8b58d30-cd45-4cb6-b6ca-ac076f072688@redhat.com>

> Use the two functions: fdma_alloc_phys() and fdma_dcb_init() for rx
> > buffer allocation and use the new buffers throughout.
> > 
> > In order to replace the old buffers with the new ones, we have to do the
> > following refactoring:
> > 
> >      - use fdma_alloc_phys() and fdma_dcb_init()
> > 
> >      - replace the variables: rx->dma, rx->dcbs and rx->last_entry
> >        with the equivalents from the FDMA struct.
> > 
> >      - make use of fdma->db_size for rx buffer size.
> > 
> >      - add lan966x_fdma_rx_dataptr_cb callback for obtaining the dataptr.
> > 
> >      - Initialize FDMA struct values.
> > 
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >   .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 116 ++++++++++-----------
> >   .../net/ethernet/microchip/lan966x/lan966x_main.h  |  15 ---
> >   2 files changed, 55 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > index b64f04ff99a8..99d09c97737e 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > @@ -6,13 +6,30 @@
> > 
> >   #include "lan966x_main.h"
> > 
> > +static int lan966x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
> > +                                   u64 *dataptr)
> > +{
> > +     struct lan966x *lan966x = (struct lan966x *)fdma->priv;
> > +     struct lan966x_rx *rx = &lan966x->rx;
> > +     struct page *page;
> > +
> > +     page = page_pool_dev_alloc_pages(rx->page_pool);
> > +     if (unlikely(!page))
> > +             return -ENOMEM;
> > +
> > +     rx->page[dcb][db] = page;
> > +     *dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
> > +
> > +     return 0;
> > +}
> 
> Very nice cleanup indeed!
> 
> Out of ENOMEM I can't recall if the following was already discussed, but
> looking at this cb, I'm wondering if a possible follow-up could replace
> the dataptr_cb() and nextptr_cb() with lib functions i.e. operating on
> page pool or doing netdev allocations according to some fdma lib flags.
> 
> Cheers,
> 
> Paolo
>

Hi Paolo,

Something like this could definitely be added down the road. I initially
left this out to reduce library complexity.

Thanks for reviewing!

/Daniel

