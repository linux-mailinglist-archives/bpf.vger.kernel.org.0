Return-Path: <bpf+bounces-32584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86729101F1
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6581C21AA5
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E951AB910;
	Thu, 20 Jun 2024 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaEBwnYs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D11AAE21
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880517; cv=none; b=VeXB0NFTyR3Ksq+hR5waPwEuNXMv1jSc+WUkMxjgWSm+FVP/Zvc1voCTOf1oWSgQGSOsM4kVjxoUd4ikNfVnx8e8DmY3A4CH7mLytAb5D3c4OfU5x2cHvDbb64lvzVs7XBxdagL5QmkbSt0+L2IXxMCwHgdMYfJXvwbluFSOTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880517; c=relaxed/simple;
	bh=Esbbz8DxthG1H39auhHjtQPDB7fwYFEeOZT0QKAbq+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhmI27f9byht6d1LYSca4UJR7S+Tz8sVjo5dOjoH9xCtdYKzQT01dKHhcYusV9fUnaxnzm1OFCZgzoDzLg/b2dPeH7wl7P3C+1kn7DRRAshdC8ZK2RZr9J+SXHRwTJOEY3LqRGatwsVWrHfYcLjvBZqWJzcaIvbguLj1Vs6/iCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaEBwnYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718880515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvLoEiL6M3Ecn2PWS+83Cift4+fMJo1jASRKaS5VqNk=;
	b=VaEBwnYsRwmq/pvxWEm+oyRyQceIOJm40GYAaIxv2n1bCgibSR8u+3fpv08LnX4VacDkMM
	kJSyowD4114aiQHSF/57Xs2T2banJhLpu1WfZsQUISPabLYouJ0T1GCUwzQPSOT1dnDniZ
	jGGxu8F3eLm/K/YPM14sUlOrXNRggCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-41fPY1hvOxCpK1lG3ZiBtw-1; Thu, 20 Jun 2024 06:48:34 -0400
X-MC-Unique: 41fPY1hvOxCpK1lG3ZiBtw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6f0da6cd62so82420866b.1
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 03:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880513; x=1719485313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvLoEiL6M3Ecn2PWS+83Cift4+fMJo1jASRKaS5VqNk=;
        b=QkqHYisSP3DbEjYr+3JI+71PDFQzUZQhcWDyXPA6AK8jpLk6UD9b6FguIPJa/ATBUL
         muyLMoYMdFPRpwCJgYmncTqpkyecA2dy1b9sGc4eBESYRecMY3LOgpmTQKOO3/rToB+l
         4y6KGvFtWVrhJanDTEQDLlTJYBCk5PMmjg8pK7P/yn5Ik+mx/mZxpfcIK1Ls134/Nv+B
         loVV4TsgeZQafg9ATx0lvBGST6Iu2BoP5X1ZhEJ8E+WnsBwHsqGpeCfndEc6UtOuB49J
         ymZUuXncCmxn0+yIEaUuo/Cj8oFgYHTEBVfi0xkR0djIYIGY61pJSEAZZd1yei8ayO9I
         /bFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1UBjuISCjT0lpT21MYKEgmVrYBRTHHza+l7UPrN8FzzpD6K+U5OR6f9TFTQo11f8MrZ8YZ3rKG7GLnv+FY2bVPdi
X-Gm-Message-State: AOJu0YyUxp+2013blpKg6rNy+tGw+W/CL50l9lwh4EvHFKZjrML4q+UQ
	+VTraZWVf4ekX/x4/EQUr0UNKZKJMp+6uacUYyU1i8pqdtax+wqrjbZJ0P0IfXJCDwxpDea5VVQ
	yUUkszb0r6tCUZiOo5P6DoBC/Ac2pqJYgbwMKyK+BruTjEnRowg==
X-Received: by 2002:a17:906:b093:b0:a6f:96c9:8413 with SMTP id a640c23a62f3a-a6f96c9844bmr486207066b.1.1718880512830;
        Thu, 20 Jun 2024 03:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxm5CK1H/t+3GpM5+8lsyLlBVkMoa7cdCIk3pXWs0yqp1VCYZUDSArK0iA4te8i1gL0nB8xw==
X-Received: by 2002:a17:906:b093:b0:a6f:96c9:8413 with SMTP id a640c23a62f3a-a6f96c9844bmr486203666b.1.1718880512262;
        Thu, 20 Jun 2024 03:48:32 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f43220sm749966966b.185.2024.06.20.03.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:48:31 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:48:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused
 xsk buffer
Message-ID: <20240620064818-mutt-send-email-mst@kernel.org>
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
 <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>

On Thu, Jun 20, 2024 at 12:46:24PM +0200, Paolo Abeni wrote:
> On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> > Release the xsk buffer, when the queue is releasing or the queue is
> > resizing.
> > 
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cfa106aa8039..33695b86bd99 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> >  
> >  	rq = &vi->rq[i];
> >  
> > +	if (rq->xsk.pool) {
> > +		xsk_buff_free((struct xdp_buff *)buf);
> > +		return;
> > +	}
> > +
> >  	if (!vi->big_packets || vi->mergeable_rx_bufs)
> >  		virtnet_rq_unmap(rq, buf, 0);
> 
> 
> I'm under the impression this should be squashed in a previous patch,
> likely "virtio_net: xsk: bind/unbind xsk for rx"
> 
> Thanks,
> 
> Paolo


agreed, looks weird.


