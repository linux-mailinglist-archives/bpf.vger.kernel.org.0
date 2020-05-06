Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476FA1C6D7F
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgEFJrJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 05:47:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29588 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729187AbgEFJrI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 05:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588758426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9sS983PmfppClLAD95W4RbZvvHCy4pYMhZVa7NWgzU=;
        b=Dwb+436WtNWdZC4+3SwsuooyGuda1f+qdXyvuFrFI5EoPmVooHjyrnR0PCpef9ICkaXZHz
        5pFtLHkc8zt61iOuQXpxZbjVcxz6h+GXnuBRtJEmgEPeJheV5eDgIxFrx9pE2DNuMlDy6S
        SADkvrN8V+Jdjh0y06gw+uZoZfYaD3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-3ZmAWICoMpa39lCnZjkVhw-1; Wed, 06 May 2020 05:47:03 -0400
X-MC-Unique: 3ZmAWICoMpa39lCnZjkVhw-1
Received: by mail-wm1-f72.google.com with SMTP id j5so925092wmi.4
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 02:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w9sS983PmfppClLAD95W4RbZvvHCy4pYMhZVa7NWgzU=;
        b=oRiw0xGBIHsX+lxL4GO5PBTG2jmaYooiVgik55lRquaGFyZOQID8iiyy02XD/8t7bA
         w7NkqduN04eem1WZPuLQXp7MXzXaTbkOdEKCZjDasosFeYjkSayjukfqY7Oeu0wCWK1w
         2YGIcla3qrNKLJCviJPcYtC7o6Z/E8oHbH2oHUx4XgPMWc1Zjqm2H0nySpiHI3I/ZkqI
         9iBmhWAFPyuMJexB0hA7v/i3DStrrToywXnd5xPIyO8TuhMsqX47qocDDRiExcK9nEtw
         YH6RKfKlsEnx4mGJtapA6FPrbADF2shi1wBi+YFz3YtLqhiwrQSJ+SPmDE1aGjIbX1CW
         JA1g==
X-Gm-Message-State: AGi0PuYF6It6QloAUPtuQmk/ZR0jUVvXr+P5D9pgXzLhtPkj9naCHnUx
        zk6yaxqz6onad0M/gKdhP7+nyQP9gOVPKmzsPs+CnAfKpxmSKgRCFkKVSKyPQ9j4haVjd3d92oG
        ogA6zAPkWYXXk
X-Received: by 2002:a1c:6402:: with SMTP id y2mr3483284wmb.116.1588758422664;
        Wed, 06 May 2020 02:47:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLFM/iL7UVJP6AWuYr6XnmG4Y7mYLYvXVuwtw2JDBHwlkMdlwBhYhsts9edtJoB4WeNEhqOg==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr3483265wmb.116.1588758422450;
        Wed, 06 May 2020 02:47:02 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id a139sm491033wme.18.2020.05.06.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 02:47:01 -0700 (PDT)
Date:   Wed, 6 May 2020 05:46:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Jubran, Samih" <sameehj@amazon.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Message-ID: <20200506054619-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506102123.739f1233@carbon>
 <3ecb558b-5281-2497-db3c-6aae7d7f882b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ecb558b-5281-2497-db3c-6aae7d7f882b@redhat.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 06, 2020 at 04:34:36PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午4:21, Jesper Dangaard Brouer wrote:
> > On Wed,  6 May 2020 14:16:32 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> > 
> > > We tried to reserve space for vnet header before
> > > xdp.data_hard_start. But this is useless since the packet could be
> > > modified by XDP which may invalidate the information stored in the
> > > header and
> > IMHO above statements are wrong. XDP cannot access memory before
> > xdp.data_hard_start. Thus, it is safe to store a vnet headers before
> > xdp.data_hard_start. (The sfc driver also use this "before" area).
> 
> 
> The problem is if we place vnet header before data_hard_start, virtio-net
> will fail any header adjustment.
> 
> Or do you mean to copy vnet header before data_hard_start before processing
> XDP?
> 
> 
> > 
> > > there's no way for XDP to know the existence of the vnet header currently.
> > It is true that XDP is unaware of this area, which is the way it
> > should be.  Currently the area will survive after calling BPF/XDP.
> > After your change it will be overwritten in xdp_frame cases.
> > 
> > 
> > > So let's just not reserve space for vnet header in this case.
> > I think this is a wrong approach!
> > 
> > We are working on supporting GRO multi-buffer for XDP.  The vnet header
> > contains GRO information (see pahole below sign).
> 
> 
> Another note is that since we need reserve room for skb_shared_info, GRO for
> XDP may probably lead more frag list.
> 
> 
> >   It is currently not
> > used in the XDP case, but we will be working towards using it.
> 
> 
> Good to know that, but I think it can only work when the packet is not
> modified by XDP?
> 
> 
> > There
> > are a lot of unanswered questions on how this will be implemented.
> > Thus, I cannot layout how we are going to leverage this info yet, but
> > your patch are killing this info, which IHMO is going in the wrong
> > direction.
> 
> 
> I can copy vnet header ahead of data_hard_start, does it work for you?
> 
> Thanks

That's likely to be somewhat expensive.


> 
> > 
> > 
> > > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >   drivers/net/virtio_net.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 11f722460513..98dd75b665a5 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -684,8 +684,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
> > >   			page = xdp_page;
> > >   		}
> > > -		xdp.data_hard_start = buf + VIRTNET_RX_PAD + vi->hdr_len;
> > > -		xdp.data = xdp.data_hard_start + xdp_headroom;
> > > +		xdp.data_hard_start = buf + VIRTNET_RX_PAD;
> > > +		xdp.data = xdp.data_hard_start + xdp_headroom + vi->hdr_len;
> > >   		xdp.data_end = xdp.data + len;
> > >   		xdp.data_meta = xdp.data;
> > >   		xdp.rxq = &rq->xdp_rxq;
> > > @@ -845,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > >   		 * the descriptor on if we get an XDP_TX return code.
> > >   		 */
> > >   		data = page_address(xdp_page) + offset;
> > > -		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
> > > +		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM;
> > >   		xdp.data = data + vi->hdr_len;
> > >   		xdp.data_end = xdp.data + (len - vi->hdr_len);
> > >   		xdp.data_meta = xdp.data;
> > 
> > 

