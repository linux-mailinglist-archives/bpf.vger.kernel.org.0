Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447821C6DB2
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgEFJyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 05:54:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729040AbgEFJyy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 05:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588758892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQgpC6M6Fr0QXYCApTnYcfdrhwDOylYbkH9y+/KvXfc=;
        b=hmbXPHaj7wcMFWHWhLB+KyzYOJ3kYIra2QN6R7vzel9ao4Jb9DjGLwKBctklHGViF46tRu
        ogsW7rM0r9JtpjXQbu4xikgRiPr3vbWMvVgiL3dtEluRbYwuqjrsP2Wv8+hBTMsju3fF+r
        uGjV5GiG7YYSlxezm4JItFopsjPenmM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-Y0iZR4qDOwalqDOnrJcF7A-1; Wed, 06 May 2020 05:54:50 -0400
X-MC-Unique: Y0iZR4qDOwalqDOnrJcF7A-1
Received: by mail-wm1-f69.google.com with SMTP id 71so516812wmb.8
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 02:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IQgpC6M6Fr0QXYCApTnYcfdrhwDOylYbkH9y+/KvXfc=;
        b=T0E9vkxsgPc+QqRQcqUN0TZ1kXDDawAHpMP426BVYYbVuF4Mh7PNU+DK/iAtLqbUBB
         FdpvzIe4zQB0VoV6niR2RuNVOK/2LwChRkgUUi6Q0VIDzHkluJeMp8J/935wlwuqvDfr
         +9TfKdNfhBH4MbHQ4IZ6iwqEoSY4EWJIECo2ZxiU6zYtxv54d6vIHJ/tfi1Q00+DOO+R
         568D9GsoU7SfFGlHCtwX1dhnzxesOqn9aZr+VkJsJFLABqR4krhDCzSD6LgFaB0IXBXF
         XRBtnSE1U1Vd5FeCueSN5zFvutVEIB3GBz62niXo55bPc58eybCwiYVvg29qjqDx+sV1
         qjCg==
X-Gm-Message-State: AGi0Pua9UsRnlLIso+gJ8r5kePTgNRUfd5QB57q4cewu6PfIeKVyxwj5
        BDPngqnwOwG3qvpWdGGvqEMkGc1EMagqalV2jyVAW4RC+7+pB6FOibpECMANkd5dGG60RCV3y/n
        nCp258KDJHXtY
X-Received: by 2002:a1c:2383:: with SMTP id j125mr3560323wmj.6.1588758889754;
        Wed, 06 May 2020 02:54:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypKtmLaaSMrbt2AgLvxUJBNSQPFDRBWOY4wRUCKhGIWK+KiuCn92js4GGRYIiEgbL9ZdbdY9GA==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr3560305wmj.6.1588758889563;
        Wed, 06 May 2020 02:54:49 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id r3sm1922605wrx.72.2020.05.06.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 02:54:49 -0700 (PDT)
Date:   Wed, 6 May 2020 05:54:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Message-ID: <20200506055436-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506033834-mutt-send-email-mst@kernel.org>
 <7a169b06-b6b9-eac1-f03a-39dd1cfcce57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a169b06-b6b9-eac1-f03a-39dd1cfcce57@redhat.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 06, 2020 at 04:19:40PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午3:53, Michael S. Tsirkin wrote:
> > On Wed, May 06, 2020 at 02:16:32PM +0800, Jason Wang wrote:
> > > We tried to reserve space for vnet header before
> > > xdp.data_hard_start. But this is useless since the packet could be
> > > modified by XDP which may invalidate the information stored in the
> > > header and there's no way for XDP to know the existence of the vnet
> > > header currently.
> > What do you mean? Doesn't XDP_PASS use the header in the buffer?
> 
> 
> We don't, see 436c9453a1ac0 ("virtio-net: keep vnet header zeroed after
> processing XDP")
> 
> If there's other place, it should be a bug.
> 
> 
> > 
> > > So let's just not reserve space for vnet header in this case.
> > In any case, we can find out XDP does head adjustments
> > if we need to.
> 
> 
> But XDP program can modify the packets without adjusting headers.
> 
> Thanks

Then what's the problem?

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
> > > -- 
> > > 2.20.1

