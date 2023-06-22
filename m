Return-Path: <bpf+bounces-3186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B601073A90C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92701C21031
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156321083;
	Thu, 22 Jun 2023 19:38:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6D1E536
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 19:38:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEFF1A4
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687462700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uf7v6utVhvB9SDThVRGOmHwhlWU7bpbJmJ9KRenSJLo=;
	b=O02tEC+Wn9li4fFD+mCZgVbJyCQccCflu8ZCHxPwykvYyFv8XVK1ncZ8Kyfqdepg+fBRjt
	ysco3WFKSTIesRUtCBW8cnoqz+LkfooL3G+X4s3pBpJcQfrFlkM7zKTGDTp/qgKeGtPkoA
	nZnk7UU8eicuTtGStS4ngzTQXp2eQHg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-N_vQYC3sN8WR8RCXPGMs7w-1; Thu, 22 Jun 2023 15:38:19 -0400
X-MC-Unique: N_vQYC3sN8WR8RCXPGMs7w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso521929366b.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687462696; x=1690054696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf7v6utVhvB9SDThVRGOmHwhlWU7bpbJmJ9KRenSJLo=;
        b=Iu/xEHCfAJRmZ2MLBBz7gbfzvYtSNw/c+lg3n00ZefRv+j+UN65knpFtY2sN7/QeME
         E7JfVFmj/gpe6DRfXXIbVaMlbe2tQL+vrGLHVsey6SkWrRrpe6U6XjevyPONKuF9hV0/
         RTZieBtd7eVpx0UbI/ylKGlYsQUSZTxzD8m3LXgqc3IqbXARezmU4RDCYhtJMnmjxFkf
         qn6zf/dq5Dz+IIkeReHr8fO8cChDW13KVwdnRnhZ9hIp0SdTua3okkrv/AsOp8UrZqrN
         GTsFhPflvAqsROjkltVraNd9JtWD7vKsKNMI9kpPsad7+bZFdIN1m2W0nUGiIv19RtKE
         k4Fw==
X-Gm-Message-State: AC+VfDyXgnK+1p71FYluokoYN47BeyXr0Cx94fI/c/jOSbQ/aJ+H2QVI
	3hGrsHe/ZJ+GXN3VprlvTDvJbYxZjeb7+w9Gk1212hQ6KobuKviPCYzT6/QN8Ii7I7UCCAE8Cxo
	+7UDHcEAAm8sv
X-Received: by 2002:a17:907:e87:b0:989:1cc5:24c with SMTP id ho7-20020a1709070e8700b009891cc5024cmr8386388ejc.16.1687462695937;
        Thu, 22 Jun 2023 12:38:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Tcekwjt1TlaynLe0SBmlVyxRwtPA1ExOLueATh4jy/8kBynHnMzbZSusq5Pw1XgWlW0F1Vw==
X-Received: by 2002:a17:907:e87:b0:989:1cc5:24c with SMTP id ho7-20020a1709070e8700b009891cc5024cmr8386370ejc.16.1687462695588;
        Thu, 22 Jun 2023 12:38:15 -0700 (PDT)
Received: from redhat.com ([2.52.149.110])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906368e00b009829dc0f2a0sm5040174ejc.111.2023.06.22.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:38:15 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:38:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
Message-ID: <20230622153730-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 02, 2023 at 05:21:56PM +0800, Xuan Zhuo wrote:
> ## About DMA APIs
> 
> Now, virtio may can not work with DMA APIs when virtio features do not have
> VIRTIO_F_ACCESS_PLATFORM.
> 
> 1. I tried to let DMA APIs return phy address by virtio-device. But DMA APIs just
>    work with the "real" devices.
> 2. I tried to let xsk support callballs to get phy address from virtio-net
>    driver as the dma address. But the maintainers of xsk may want to use dma-buf
>    to replace the DMA APIs. I think that may be a larger effort. We will wait
>    too long.
> 
> So rethinking this, firstly, we can support premapped-dma only for devices with
> VIRTIO_F_ACCESS_PLATFORM. In the case of af-xdp, if the users want to use it,
> they have to update the device to support VIRTIO_F_RING_RESET, and they can also
> enable the device's VIRTIO_F_ACCESS_PLATFORM feature.
> 
> Thanks for the help from Christoph.
> 
> =================
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good.
> 
> ENV: Qemu with vhost.
> 
>                    vhost cpu | Guest APP CPU |Guest Softirq CPU | PPS
> -----------------------------|---------------|------------------|------------
> xmit by sockperf:     90%    |   100%        |                  |  318967
> xmit by xsk:          100%   |   30%         |   33%            | 1192064
> recv by sockperf:     100%   |   68%         |   100%           |  692288
> recv by xsk:          100%   |   33%         |   43%            |  771670
> 
> Before achieving the function of Virtio-Net, we also have to let virtio core
> support these features:

So by itself, this doesn't do this. But what effect does all this
overhead have on performance?

> 1. virtio core support premapped
> 2. virtio core support reset per-queue
> 3. introduce DMA APIs to virtio core
> 
> Please review.
> 
> Thanks.
> 
> v10:
>  1. support to set vq to premapped mode, then the vq just handles the premapped request.
>  2. virtio-net support to do dma mapping in advance
> 
> v9:
>  1. use flag to distinguish the premapped operations. no do judgment by sg.
> 
> v8:
>  1. vring_sg_address: check by sg_page(sg) not dma_address. Because 0 is a valid dma address
>  2. remove unused code from vring_map_one_sg()
> 
> v7:
>  1. virtqueue_dma_dev() return NULL when virtio is without DMA API.
> 
> v6:
>  1. change the size of the flags to u32.
> 
> v5:
>  1. fix for error handler
>  2. add flags to record internal dma mapping
> 
> v4:
>  1. rename map_inter to dma_map_internal
>  2. fix: Excess function parameter 'vq' description in 'virtqueue_dma_dev'
> 
> v3:
>  1. add map_inter to struct desc state to reocrd whether virtio core do dma map
> 
> v2:
>  1. based on sgs[0]->dma_address to judgment is premapped
>  2. based on extra.addr to judgment to do unmap for no-indirect desc
>  3. based on indir_desc to judgment to do unmap for indirect desc
>  4. rename virtqueue_get_dma_dev to virtqueue_dma_dev
> 
> v1:
>  1. expose dma device. NO introduce the api for dma and sync
>  2. split some commit for review.
> 
> 
> 
> 
> Xuan Zhuo (10):
>   virtio_ring: put mapping error check in vring_map_one_sg
>   virtio_ring: introduce virtqueue_set_premapped()
>   virtio_ring: split: support add premapped buf
>   virtio_ring: packed: support add premapped buf
>   virtio_ring: split-detach: support return dma info to driver
>   virtio_ring: packed-detach: support return dma info to driver
>   virtio_ring: introduce helpers for premapped
>   virtio_ring: introduce virtqueue_dma_dev()
>   virtio_ring: introduce virtqueue_add_sg()
>   virtio_net: support dma premapped
> 
>  drivers/net/virtio_net.c     | 163 ++++++++++--
>  drivers/virtio/virtio_ring.c | 493 +++++++++++++++++++++++++++++++----
>  include/linux/virtio.h       |  34 +++
>  3 files changed, 612 insertions(+), 78 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


