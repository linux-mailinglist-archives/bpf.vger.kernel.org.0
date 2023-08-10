Return-Path: <bpf+bounces-7424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6695777093
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81AA1C2141F
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E591520E4;
	Thu, 10 Aug 2023 06:39:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48861FCB
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 06:39:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F756E4D
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691649596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22HFwMNskHBOB8y/dJtS9BqnPtSGN8PjvKQGJBr0IAM=;
	b=BGkwBCqELHlekjZz02fl/wuyuc8IEainPUTDP0T6YWtmDvpmOvuoZc6mr14C2oZP/ENjuo
	DgnsxUDPAgRTleRNVVepmEvpGotLDyWvVHmPb5qPvBE/H5o1eFygiHhG79nzXXHZ6/R3r6
	jSY8QrTQaikceMvuIow5x8EV0XkjbzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-88IaMGFMNWmspMG_kse0LQ-1; Thu, 10 Aug 2023 02:39:53 -0400
X-MC-Unique: 88IaMGFMNWmspMG_kse0LQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe57d0e11eso3517635e9.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 23:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649592; x=1692254392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22HFwMNskHBOB8y/dJtS9BqnPtSGN8PjvKQGJBr0IAM=;
        b=NtCMpuzZ7iuiFUWx6jXUrmae14zItE5IvGEx58vwtD/ycnjAvKb1pHFr6xps1rLOwA
         gAyS3zSFD1zloO4e2SIChnZXMOxFsEqHlIB1gnsFkc0+7BCwKx/n/xGO72AoPLcaEFSM
         6o0Fq5Id82PL+vmmgtnHZYe8Q79z95A4R5dgX1CFvbtx99NR5oGunMpeXvyinPR8BJ4G
         fCSHI1sEesG3BGsHbv8DPIm02XaH7Blg99ayeyHH5BfSTxfNe1M22a4czMHC2pu5UL6w
         4d+gzM/y7m/5+YFMtt5nIYqEjhR6wY0XnO4mwG5vmxkvz1wGK7yaXDXaA6e729jEJCfQ
         3VWQ==
X-Gm-Message-State: AOJu0YzAe6bQnyF8qdipOw/8wgwnnck5jsUKqBlqUItWv/EHM9Xe0zAV
	qFRh7v0yfGodKknMz7kioz/VaLktWbCyJ8X7yjSVYAACOstmazqttBmnW5vlvmKQFgjf30YgmlD
	fs89nEKkWkFU+
X-Received: by 2002:a05:600c:c3:b0:3fc:a49:4c05 with SMTP id u3-20020a05600c00c300b003fc0a494c05mr936415wmm.40.1691649591836;
        Wed, 09 Aug 2023 23:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEybtnYNEhFJRufjXc6/kaGifm/ioS0+TszaHtLZfnLCZBBs3ACOUB1YaEr18zALjPpkTUGJg==
X-Received: by 2002:a05:600c:c3:b0:3fc:a49:4c05 with SMTP id u3-20020a05600c00c300b003fc0a494c05mr936399wmm.40.1691649591550;
        Wed, 09 Aug 2023 23:39:51 -0700 (PDT)
Received: from redhat.com ([2.52.137.93])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003fbc30825fbsm1078877wml.39.2023.08.09.23.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:39:50 -0700 (PDT)
Date: Thu, 10 Aug 2023 02:39:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
Message-ID: <20230810023253-mutt-send-email-mst@kernel.org>
References: <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
 <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691632614.950658-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 09:56:54AM +0800, Xuan Zhuo wrote:
> 
> Ping!!
> 
> Could we push this to the next linux version?
> 
> Thanks.

You sent v12, so not this one for sure.
v12 triggered kbuild warnings, you need to fix them and repost.
Note that I'm on vacation from monday, so if you want this
merged this needs to be addressed ASAP.

-- 
MST


