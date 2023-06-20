Return-Path: <bpf+bounces-2910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F817369E6
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ED828108A
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF3101FB;
	Tue, 20 Jun 2023 10:50:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E5101D7
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 10:50:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FBDE42
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687258244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0IoXa4XAHoFAruqN5daSBHWjUsBZS6Ij0Vlly8LLK8=;
	b=OtablsU62wPtEnTRmJn5QP8EVnmlccMYIQyBIXNWu2mm/pTrLeKp4AV8Exvb0VMY8xJVtV
	SeYY00ivXB9yEaCoJAuJLGo9XK/BopvVgjzzYwDXvzT+SgFtRoJrr1GOE0IcxjKSPprRtd
	CoDHM1WFP2TmNR7gwaeBxa7xYl8JDnI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-M9vE2mPPPSO40SsMb-v3dA-1; Tue, 20 Jun 2023 06:50:40 -0400
X-MC-Unique: M9vE2mPPPSO40SsMb-v3dA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3111a458cfbso1954437f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 03:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687258239; x=1689850239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0IoXa4XAHoFAruqN5daSBHWjUsBZS6Ij0Vlly8LLK8=;
        b=bfZKVv+HePco0v3yAlBNALZ+12W4Maw4bLX2vbsD3M8LLt4N1UjbwEdbromcw6HDgd
         xo6bORXhUQ8P1tcJqOOnn/d0tjSRj2xNFPJ2yH+g33ZxZh24elWXbll/yqqQzg8nGwh1
         EQe2JndoL19Oai0emqs6qfWnp3x0fG5z7WG8vB8AFJo+qy++qEE3VXjJHe9jfsc1Q7WQ
         nDhh0fW+kXlO6ZLRX+R/6u4SGNBhfcajb2Tr29TbiE73p10JlVBetCZX0nzf4O+jxDjW
         ZmALPgm0xzKInKz6aPOpFIYLTC+WToiDNAypmUhlHmtxnNnnpzcsa0GOV2R5goLRKxjr
         ++/Q==
X-Gm-Message-State: AC+VfDyKI0MmdQlLwfZlv63oCyGalOeww+7sGF9i0maqA73yvG9Cxb1D
	SEFZLuWHiQyPUFHSx+fBRoCk/4UZdRhpamuZbIM72DrWSirvFCaMqujPiTrO+DsyOfJuZ/KgTSW
	tWgvMBknT45tX
X-Received: by 2002:a05:600c:218b:b0:3f8:f3fd:ccb9 with SMTP id e11-20020a05600c218b00b003f8f3fdccb9mr9444909wme.18.1687258238702;
        Tue, 20 Jun 2023 03:50:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uBag3jmtb4HCqJRb/JnPfFAGDwhaBtlqIvqBfMAjYKXMc7iAhzA1MOqJpE8Irt7vp5R3c6A==
X-Received: by 2002:a05:600c:218b:b0:3f8:f3fd:ccb9 with SMTP id e11-20020a05600c218b00b003f8f3fdccb9mr9444900wme.18.1687258238400;
        Tue, 20 Jun 2023 03:50:38 -0700 (PDT)
Received: from redhat.com ([2.52.15.156])
        by smtp.gmail.com with ESMTPSA id c16-20020a7bc010000000b003f7f60203ffsm13170808wmb.25.2023.06.20.03.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:50:37 -0700 (PDT)
Date: Tue, 20 Jun 2023 06:50:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 3/4] virtio-net: support coexistence of XDP and
 _F_GUEST_CSUM
Message-ID: <20230620064711-mutt-send-email-mst@kernel.org>
References: <20230619105738.117733-1-hengqi@linux.alibaba.com>
 <20230619105738.117733-4-hengqi@linux.alibaba.com>
 <20230619072320-mutt-send-email-mst@kernel.org>
 <20230620032430.GE74977@h68b04307.sqa.eu95>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620032430.GE74977@h68b04307.sqa.eu95>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 11:24:30AM +0800, Heng Qi wrote:
> On Mon, Jun 19, 2023 at 07:26:44AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 19, 2023 at 06:57:37PM +0800, Heng Qi wrote:
> > > We are now re-probing the csum related fields and  trying
> > > to have XDP and RX hw checksum capabilities coexist on the
> > > XDP path. For the benefit of:
> > > 1. RX hw checksum capability can be used if XDP is loaded.
> > > 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> > > 
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 36 ++++++++++++++++++++++++------------
> > >  1 file changed, 24 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 07b4801d689c..25b486ab74db 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1709,6 +1709,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >  	struct net_device *dev = vi->dev;
> > >  	struct sk_buff *skb;
> > >  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> > > +	__u8 flags;
> > >  
> > >  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > >  		pr_debug("%s: short packet %i\n", dev->name, len);
> > > @@ -1717,6 +1718,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >  		return;
> > >  	}
> > >  
> > > +	flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
> > > +
> > >  	if (vi->mergeable_rx_bufs)
> > >  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> > >  					stats);
> > 
> > what's going on here?
> 
> Hi, Michael.
> 
> Is your question about the function of this code?
> 1. If yes,
> this sentence saves the flags value in virtio-net-hdr in advance
> before entering the XDP processing logic, so that it can be used to
> judge further logic after XDP processing.
> 
> If _NEEDS_CSUM is included in flags before XDP processing, then after
> XDP processing we need to re-probe the csum fields and calculate the
> pseudo-header checksum.

Yes but we previously used this:
-       hdr = skb_vnet_hdr(skb);
which pokes at the copy in skb cb.

Is anything wrong with this?

It seems preferable not to poke at the header an extra time.

-- 
MST


