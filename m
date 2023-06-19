Return-Path: <bpf+bounces-2863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C47359A9
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 16:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CA11C20B4C
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA661095F;
	Mon, 19 Jun 2023 14:33:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD4D53B
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 14:33:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF218C
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687185233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qaR034a/uYZWArvb4NS/fyabanvCu3PnPemgTnGF4j4=;
	b=fgViziUYOfwdRCGSNw5bzffWTE8keX2l1HYqinQbkUvrvirVS81fYahLVwXw5XPItYppCF
	RDOWigBs7USoTnk2EgxJddwS3NmQ4eMvJDwqOZAUw/Q9xOZCk5COpuAfMHT5RRD/GjeG6e
	wLgOm/gT2acPBxT4b+dU8huFqTaRM1A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-guvh83HLMhO2P26JvNNeGw-1; Mon, 19 Jun 2023 10:33:50 -0400
X-MC-Unique: guvh83HLMhO2P26JvNNeGw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7ef0e0292so15799875e9.3
        for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 07:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185229; x=1689777229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaR034a/uYZWArvb4NS/fyabanvCu3PnPemgTnGF4j4=;
        b=gAxmdTqf2flHrEnScH8SUTZSAMFoMrlEmhjSaHQzS8GHEOusXEEYsXrrmXdXDge9ln
         4LkrW6ijdLKqYMJJYfQ+gnimmQy4EoiJUMQCNBbM82snioHUn8LTf0OZQhALCQ74YRmc
         rVkKJEKR5ij2/og25vXlrPpJ7f2vqpUdZdi3+a5S4WbOqOebd70h9p4hCZ3VEk+dfW2P
         TmTPxFL/zhPBZO9+4rQc1uRghySNlN0um5M3fkVPcBTgWOceny599Cy05t8PBJnIZQ5Y
         htSF4vUa7CEFYW6JXLLGJPqe9Qs0U+DPcu0dBP4VCgtvWiTtSunrccop2Vjg/t/ODWYQ
         MwiA==
X-Gm-Message-State: AC+VfDyvmBzaJGdiDvdTA5vwHCqCgCIX+oHoDAzYEKNV4eYa3M3tBX5X
	Q8w1z11JIv5MRdPmDkfMYG4v0qSzW4enhzS92Z7IEKZvHSrF+IsEYeNYRtj5TN6KW5WVaycyUo+
	DldeFdZX+v/v/
X-Received: by 2002:a05:600c:2257:b0:3f1:9b85:e305 with SMTP id a23-20020a05600c225700b003f19b85e305mr8159104wmm.34.1687185229395;
        Mon, 19 Jun 2023 07:33:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TK3G50ReBw3v7K3vUKmvd0N+5fhCX8RdNRkKpusiONzyHxuWcWKNF3b6hThRV9oZcCiFurw==
X-Received: by 2002:a05:600c:2257:b0:3f1:9b85:e305 with SMTP id a23-20020a05600c225700b003f19b85e305mr8159086wmm.34.1687185229022;
        Mon, 19 Jun 2023 07:33:49 -0700 (PDT)
Received: from redhat.com ([2.52.15.156])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003f80946116dsm10900656wmb.45.2023.06.19.07.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:33:48 -0700 (PDT)
Date: Mon, 19 Jun 2023 10:33:44 -0400
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
Subject: Re: [PATCH net-next 4/4] virtio-net: remove F_GUEST_CSUM check for
 XDP loading
Message-ID: <20230619103208-mutt-send-email-mst@kernel.org>
References: <20230619105738.117733-1-hengqi@linux.alibaba.com>
 <20230619105738.117733-5-hengqi@linux.alibaba.com>
 <20230619071347-mutt-send-email-mst@kernel.org>
 <20230619124154.GC74977@h68b04307.sqa.eu95>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619124154.GC74977@h68b04307.sqa.eu95>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 08:41:54PM +0800, Heng Qi wrote:
> On Mon, Jun 19, 2023 at 07:16:20AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 19, 2023 at 06:57:38PM +0800, Heng Qi wrote:
> > > Lay the foundation for the subsequent patch
> > 
> > which subsequent patch? this is the last one in series.
> > 
> > > to complete the coexistence
> > > of XDP and virtio-net guest csum.
> > > 
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 25b486ab74db..79471de64b56 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -60,7 +60,6 @@ static const unsigned long guest_offloads[] = {
> > >  	VIRTIO_NET_F_GUEST_TSO6,
> > >  	VIRTIO_NET_F_GUEST_ECN,
> > >  	VIRTIO_NET_F_GUEST_UFO,
> > > -	VIRTIO_NET_F_GUEST_CSUM,
> > >  	VIRTIO_NET_F_GUEST_USO4,
> > >  	VIRTIO_NET_F_GUEST_USO6,
> > >  	VIRTIO_NET_F_GUEST_HDRLEN
> > 
> > What is this doing? Drop support for VIRTIO_NET_F_GUEST_CSUM? Why?
> 
> guest_offloads[] is used by the VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET
> command to switch features when XDP is loaded/unloaded.
> 
> If the VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is negotiated:
> 1. When XDP is loaded, virtnet_xdp_set() uses virtnet_clear_guest_offloads()
> to automatically turn off the features in guest_offloads[].
> 
> 2. when XDP is unloaded, virtnet_xdp_set() uses virtnet_restore_guest_offloads()
> to automatically restore the features in guest_offloads[].
> 
> Now, this work no longer makes XDP and _F_GUEST_CSUM mutually
> exclusive, so this patch removed the _F_GUEST_CSUM from guest_offloads[].
> 
> > This will disable all of guest offloads I think ..
> 
> No. This doesn't change the dependencies of other features on
> _F_GUEST_CSUM. Removing _F_GUEST_CSUM here does not mean that other
> features that depend on it will be turned off at the same time, such as
> _F_GUEST_TSO{4,6}, F_GUEST_USO{4,6}, etc.
> 
> Thanks.

Hmm I don't get it.

static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
{               
        u64 offloads = vi->guest_offloads;
                        
        if (!vi->guest_offloads)
                return 0;
        
        return virtnet_set_guest_offloads(vi, offloads); 
}               
                        
is the bit _F_GUEST_CSUM set in vi->guest_offloads?

Because if it isn't then we'll try to set _F_GUEST_TSO
without setting _F_GUEST_CSUM and that's a spec
violation I think.


> > 
> > 
> > > @@ -3522,10 +3521,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> > >  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
> > >  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> > >  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> > > -		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
> > >  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
> > >  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6))) {
> > > -		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> > > +		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW, disable GRO_HW first");
> > >  		return -EOPNOTSUPP;
> > >  	}
> > >  
> > > -- 
> > > 2.19.1.6.gb485710b


