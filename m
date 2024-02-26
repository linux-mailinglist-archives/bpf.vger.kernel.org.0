Return-Path: <bpf+bounces-22719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A73867356
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 12:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACEB28A476
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF53A8E4;
	Mon, 26 Feb 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoAx/rLR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653C200BD
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947428; cv=none; b=rgGtKNwTT9uY1tR3N7F8b1dlgHMPGkdc9jHBaiYqbxmSCVe5y13KF4/SkMehI5tJr2z7k1954nW343g6cPSGXSOxKectcN1PrzYHj6PdkabJ9omwGzrt0DnVxy32ubqw1rubcrW0fLksa9Zl3MPjlah1q1kqM4ucVcAscXxTNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947428; c=relaxed/simple;
	bh=cdvsXEAAdJFQk8TvtsGZXJF3H+eh0FsJmmxlLLI+i6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2mwaC75vQSxcBV0YBobwOdaAIZLkihFkVxEnB5eYeij3i6gVGmwg2+1dZtyOQwcJYV2pvPHdrOu1RlwMRx9jeTHny34qvhUCunw9ZmoNGP/2nHfRHrFQcIel4CDvDgF5WGqEfM3eQSOt9WC4L+Ol2ewwbTlYv4kG3X22mWyO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoAx/rLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708947426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAlQVG6KdPaJyAOPbLA/63jFXJlJW1va0BU08U9am/8=;
	b=RoAx/rLRCreDW27L2NDJvmMlAkcrT5eR4hZ668uFv6h5g9U87oNTL9nmgxOn8fjRbjuRT+
	Z1bGiRnxlkQSLep/qiVVtgNyKvy0WUv5M9UJpi0DeqDCjLvwMrtlezN3aIpkNJUnuACGc4
	07O4GAEWWE4DXrjPLEtg6sHiBcwz2Ds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-9IboFsqHPW-P3Hi5eTMHRw-1; Mon, 26 Feb 2024 06:37:04 -0500
X-MC-Unique: 9IboFsqHPW-P3Hi5eTMHRw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-411ac839dc5so14743905e9.2
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 03:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947424; x=1709552224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAlQVG6KdPaJyAOPbLA/63jFXJlJW1va0BU08U9am/8=;
        b=CphRd+hDFAiHnPtHtEU4wVeqQMYqoPCi8nd0Q0Zl7ba39qoOR5abrxQxPVG936HWLR
         t5dnuab2YR4YMBDYD48wmG6vqbJsS6oxE2nVmbIISabWt7BS/Om2wYLEsUbvfr5sAUdf
         zksDKAdFGa2T+9g4sicPR8Hm35pn+c1dWsusOeO0aFSG0idRybbYR0Ii8LaHHaPWqqjY
         i6eHGFMH6FOiOZIfa/gmSXoNvkKqdpv46iyJ0dzYjBDS34/qCBVmDMtxAzgxBpIjkMNI
         ugSNo4PsJZx3ck/ZLB/WnIoTNFUfQuoOjAk5HeR849A4kSYXi6Nhg158GExfSXnnZ6lG
         Welg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Ae4iwNDA6TGnBgH8yNj9I5aotcxb2r00K5vaWKGu4ZDc4goJeIFFKosWxy9OhdtXfOGpPnV18YyjLNMtkNcLoqmf
X-Gm-Message-State: AOJu0YyIvpncsdYUOuA0v1L6+77Fqm+DA4kS/EQOesShm/scwzEwW+EO
	pcNfsDEcKLA0YmKWjmc6GTyp+aC7cR3Ttek71mybREiPYSZw3xxMWnTxh8zcJC3PYfXVxE8g5EW
	utLsFuri0G4mIjoBKXPOWZw99tXZuNUCgGUH/BQ9A1549tUtj7w==
X-Received: by 2002:a05:600c:1d82:b0:412:a8d1:d3b6 with SMTP id p2-20020a05600c1d8200b00412a8d1d3b6mr379093wms.8.1708947423790;
        Mon, 26 Feb 2024 03:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvXe87LdVjv57x0ixL/iOJ9+IQcZQwZBW2BhhDacRcGH/iDCk0HMP0COfYaRJOaDiHQGYMqw==
X-Received: by 2002:a05:600c:1d82:b0:412:a8d1:d3b6 with SMTP id p2-20020a05600c1d8200b00412a8d1d3b6mr379072wms.8.1708947423449;
        Mon, 26 Feb 2024 03:37:03 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id t20-20020adfa2d4000000b0033de1e1bddcsm1319266wra.26.2024.02.26.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:37:02 -0800 (PST)
Date: Mon, 26 Feb 2024 06:36:53 -0500
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
Message-ID: <20240226063532-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>

On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > what is dma_map_direct? can't find it in the tree.
> 
> YES.
> 
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 58db8fd70471..5a8f7a927aa1 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
>         return dma_go_direct(dev, *dev->dma_mask, ops);
>  }
> 
> +bool dma_is_direct(struct device *dev)
> +{
> +       if (!dma_map_direct(dev, ops))
> +               return false;
> +
> +       if (is_swiotlb_force_bounce(dev))
> +               return false;
> +
> +       return true;
> +}
> +EXPORT_SYMBOL(dma_unmap_page_attrs);
> +
> 
> Thanks.


where is it? linux-next?

-- 
MST


