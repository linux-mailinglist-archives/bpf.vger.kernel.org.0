Return-Path: <bpf+bounces-22728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE6867479
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 13:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5442285384
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD1604D1;
	Mon, 26 Feb 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvVL7FDX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2360274
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949535; cv=none; b=oB83CnjUA0hW9wMrNYTO/Zz8dQAZp0ssUdG2odbVWb5tXwz5cbrSeXBvRzjBQXkh95n+zJZNUCFGpEfcCJ0xY/ffmf6dvaVW/Zxl+ngZhbt1148J8R07kr445Ph4QtQSKr1Twz6llAaqVJCEi234LfwGNbzOHf+GYFJ2u9gVjTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949535; c=relaxed/simple;
	bh=e0N6/2zQUM1QOqkgabnyahS6/9h1qmMEkf5qlHoAwkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8zZ3JNftL3ki0A2+0UysHzUcy9tN4Doqib9BI3Q2w3wK63uyp+1azy4bN9dTnxVUXhfotE/6AvoQG/IBAGj77ubfqWEehYz0IxIJD/KamQx7bxXMYFAgZrmbq5iByXuxgeg9n5n+ntz4rOO+p4H3uRrU56aWiE4T82J46Ch/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvVL7FDX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708949531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVX2aIqulG7pb2ZKAY6wEN/hr8j5RuJ02O3KYwJHnAk=;
	b=CvVL7FDXkKfEg8tZhAHlNenPRx0PMP1hfHRMZyjjlWJU76Cx8RjlYGHRFkT1Zjk+bqF/36
	eavpHvGenCgY66X3eNN3VX9+y6PpLVVIsPe7DuKMVTfHa3C/hqqS9CPpvhBJcZhsmGQWNV
	PjYm/lJLfBh3/ORDcrYgFOX5eWxLr3E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-GahC5pKoNwOPeO6rLKFAqA-1; Mon, 26 Feb 2024 07:12:10 -0500
X-MC-Unique: GahC5pKoNwOPeO6rLKFAqA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33dc175ff8fso1225324f8f.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 04:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708949529; x=1709554329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVX2aIqulG7pb2ZKAY6wEN/hr8j5RuJ02O3KYwJHnAk=;
        b=N3cgwd48Bwi7gqFRNCdCQIAiShbydzk9Pd+7BHBcyMWZwM1Q+jTnEyFK/wqv53Fjb8
         lOLYR49JaB8q/TnuFWCzk166U6EkgEjzP8F8RKkIIHEBnk1TannvYFymuMY6V5ft3mqF
         BUXi0VE7lRgcBK7FXsblOrpuP8630gpMrWzACYyghzthnEpxQDikcehANJHBBFM/Agjh
         jljZMUy+6d5H9WUrZDu1vPQKGvDCV/gxFYMLJRb+403PsE4imLRT1whDuqzFZ0eLAG+G
         b8FDtpWzTLKaNYZAv9CVG5YsY9Dht585afBJr+1LDVhTil4m6U/zWQzdq1vGkZu+Iyxg
         iHDA==
X-Forwarded-Encrypted: i=1; AJvYcCVRd7H4wNOF/jZBSCroYntqvk05jh1tEmg6i8FYju7e7+BGJKKCEeFOG0DkxReppeQwd8BPIw/yC6CqRxsnbmdEaerp
X-Gm-Message-State: AOJu0YyQo45ipkkDf5y6ei7t88HsxoSBmi5bPmOqdtN9NH++WcoQnfqn
	/0rLfobjDEvW3mC/NviLTZhvZUJ9pTSc0Gilgf2ElqGi5c2kC81QXIlckrq7D0QS0yCKawz9T+U
	ykWBYlsmlQfGzijWRIMeGZvCcI0wkFgoSqgKIa0lAr+CW2kJqwA==
X-Received: by 2002:a05:6000:1961:b0:33d:7ea3:5b90 with SMTP id da1-20020a056000196100b0033d7ea35b90mr5099366wrb.65.1708949529663;
        Mon, 26 Feb 2024 04:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf07k3zYsXuRGP5oY8KvF8nVh4PymH1C6S7+HQTQO4YjooNJ90xav4OKE27dfDSxc5oKl0bw==
X-Received: by 2002:a05:6000:1961:b0:33d:7ea3:5b90 with SMTP id da1-20020a056000196100b0033d7ea35b90mr5099329wrb.65.1708949529347;
        Mon, 26 Feb 2024 04:12:09 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id t20-20020adfa2d4000000b0033de1e1bddcsm1414633wra.26.2024.02.26.04.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:12:08 -0800 (PST)
Date: Mon, 26 Feb 2024 07:12:01 -0500
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
Message-ID: <20240226071010-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708946440.799724-1-xuanzhuo@linux.alibaba.com>
 <20240226063120-mutt-send-email-mst@kernel.org>
 <1708947209.1148863-1-xuanzhuo@linux.alibaba.com>
 <20240226063532-mutt-send-email-mst@kernel.org>
 <1708947549.7906592-2-xuanzhuo@linux.alibaba.com>
 <20240226065709-mutt-send-email-mst@kernel.org>
 <1708949183.5224328-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708949183.5224328-4-xuanzhuo@linux.alibaba.com>

On Mon, Feb 26, 2024 at 08:06:23PM +0800, Xuan Zhuo wrote:
> On Mon, 26 Feb 2024 06:57:17 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Feb 26, 2024 at 07:39:09PM +0800, Xuan Zhuo wrote:
> > > On Mon, 26 Feb 2024 06:36:53 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Mon, Feb 26, 2024 at 07:33:29PM +0800, Xuan Zhuo wrote:
> > > > > > what is dma_map_direct? can't find it in the tree.
> > > > >
> > > > > YES.
> > > > >
> > > > >
> > > > > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > > > > index 58db8fd70471..5a8f7a927aa1 100644
> > > > > --- a/kernel/dma/mapping.c
> > > > > +++ b/kernel/dma/mapping.c
> > > > > @@ -144,6 +144,18 @@ static inline bool dma_map_direct(struct device *dev,
> > > > >         return dma_go_direct(dev, *dev->dma_mask, ops);
> > > > >  }
> > > > >
> > > > > +bool dma_is_direct(struct device *dev)
> > > > > +{
> > > > > +       if (!dma_map_direct(dev, ops))
> > > > > +               return false;
> > > > > +
> > > > > +       if (is_swiotlb_force_bounce(dev))
> > > > > +               return false;
> > > > > +
> > > > > +       return true;
> > > > > +}
> > > > > +EXPORT_SYMBOL(dma_unmap_page_attrs);
> > > > > +
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > where is it? linux-next?
> > >
> > >
> > > I see it in the vhost branch kernel/dma/mapping.c.
> > >
> > > Maybe you miss it.
> > >
> > > Thanks.
> > >
> >
> > which hash?
> 
> fd0b29af02bb75acc94eb08c06e2c10cbce2ea67


Thanks. Now I see it donnu what was wrong with me.


> >
> > > >
> > > > --
> > > > MST
> > > >
> >


