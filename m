Return-Path: <bpf+bounces-22724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEEA86740B
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1131C24AA8
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8AE5B04F;
	Mon, 26 Feb 2024 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blRy128n"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF345A7BF
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948653; cv=none; b=ilhOvJN04gNNXWJBeFz1pu081hxkrTyzLwcYON88moiioPJKLiY9lx7NFISd0d59G8cawrT71eVzI0EpeFxqhKr0lHfeETM59tGZMs0Nyi5mqyvNra2CcGGUW2R4TwIjB6hmQLoVan8OX0JiK3p/629z/l/QoQL6tNELRNk4pGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948653; c=relaxed/simple;
	bh=Foucft6WlPR2KyfAnFENVyW3MER3G1QZvKQCjZkxl/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFHMvDjuCwkUBKdgI98LDbUOREDceeWhKSPsJpYooSY/7arXoo5FGQp1Nmo7680o7XoM5G7BYu0OOEWng+7NkLfJ4cV7LjykYrR07TZ/A3ZhBOVUzAJOy8PoWtpuk2s71woPQqoIlYLSLIvTmo+Cxo79TsbOHFifO3FnxN3d9z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blRy128n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708948649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
	b=blRy128nYHLdCZxG4jJoUa2ap2DEJ6w2mvf0PskQEkf6Zw2TlcFEzqM7dP9X1U5OMU7GwK
	ZJnc6kKoSMz5YJTmRmZ3XVoSiMlQyyEWh4xCEYFR1ApoxaN3LzloGzCNfnMFRgT9XXkU4i
	v/WcEsT+KkkxIxB38XQb/bDmLt6d99o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-iWv7cLwVNZu4kCj_UJ50gw-1; Mon, 26 Feb 2024 06:57:28 -0500
X-MC-Unique: iWv7cLwVNZu4kCj_UJ50gw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-512bed4e08cso2572614e87.1
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 03:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948646; x=1709553446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwTMNcm/OZxGXy6MTFKOugn5j6dLDR0+J9PuYt4fDWs=;
        b=jvwAgTsma0KrVlIfz87U+Zb0D3Ii0TO8NsVlvQs9BlZ/AzIfWf+7GSuKKujFRARWeQ
         pJxSly4IV3GO49sAIrCKpEzKmOgw2Gsgwg159IqQPaO+FqmjjDid67QWo1wHkbC4cUfk
         Wpz1lhdTMxMVYBmJg4GlgoyOhdbm5hC+5MvrsGJcEPVL5u+PGf+wqB78MVtfRmNVGUdF
         GS0EEs4WjNpXnIUzTyfldKXbEjJaHHVdSfGZvhFqLjjNN62YRtX0hZB6SX/s4aFpsOFE
         NRr3s6PvRRpvQgyCbbqRvoiY0iLXZamNkYMRokA810Q1gWAEo7ZjIpnw36fmG3+eYQTA
         Acgg==
X-Forwarded-Encrypted: i=1; AJvYcCUw74Kpe0WiAmYx7KC6PWYt4NJFgZZf7LKLqWjHB/806Pa6Q6D/4YwGex6LKpKRamEJNxnVHdrpy7kbJKpvr7tGkCSI
X-Gm-Message-State: AOJu0YzJHxV3/J4Ui132GCoBBXjDT8LEabLm5Pu8+bSDTrfjRtqSQTGp
	umuLOGBeiwyO2E9rfJv6IRyFEt2F8T5dvBmiSqeFoDFXv2vdPuxGNs8IT8vcWR2WFYM8AfeRZkE
	KZRamheKAFrjCBpLIYS3o9itzzKvbSQb9WGMbiwucbTpS1M+lwQ==
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652514lfu.17.1708948646534;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhlB+sQrxdk/wnezoDvCnQO/+FHCrT1btYEeq6+bycpFpncFqBUrdfh9u7XJ++FrnKpKlBAA==
X-Received: by 2002:a05:6512:2206:b0:512:fbb0:3c55 with SMTP id h6-20020a056512220600b00512fbb03c55mr2652497lfu.17.1708948646157;
        Mon, 26 Feb 2024 03:57:26 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004128fa77216sm11737552wmz.1.2024.02.26.03.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:57:25 -0800 (PST)
Date: Mon, 26 Feb 2024 06:57:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226065709-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
 <20240226063532-mutt-send-email-mst@kernel.org>
 <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>

On Mon, Feb 26, 2024 at 07:39:09PM +0800, Xuan Zhuo wrote:
> On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > > what is dma_map_direct? can't find it in the tree.
> > >
> > > YES.
> > >
> > >
> > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > index 58db8fd70471..5a8f7a927aa1 100644
> > > --- a/kernel/dma/mapping.c
> > > +++ b/kernel/dma/mapping.c
> > > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> > >         return dma_go_direct(dev, *dev->dma_mask, ops);
> > >  }
> > >
> > > +bool dma_is_direct(struct device *dev)
> > > +{
> > > +       if (!dma_map_direct(dev, ops))
> > > +               return false;
> > > +
> > > +       if (is_swiotlb_force_bounce(dev))
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > > +
> > >
> > > Thanks.
> >
> >
> > where is it? linux-next?
> 
> 
> I see it in the vhost branch kernel/dma/mapping.c.
> 
> Maybe you miss it.
> 
> Thanks.
> 

which hash?

> >
> > --
> > MST
> >


