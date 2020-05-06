Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9ED1C6FFF
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgEFMI7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 08:08:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726516AbgEFMI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 08:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588766936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAmivG5aDvvl7e+GYdcGOegOdLibFaOeKZvY0VQjVvw=;
        b=AulECeLIXpkNoJ/mpt+EYU2BgCB6lgUuVhExax+tblkaslBDR80VJZJrWqf3AXT+Nv0dFC
        Y1tXqqpuvGBtMTMZb9BMmhknguApxV2DvE+ESFcjRDmc0Sjb1aLsSTy7Low52/l8445xZC
        3gwuXBaHpo54EJmFS8bebjsSbh6D6Wo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-ZK1QgjwlOqmsxqNFtvp2PA-1; Wed, 06 May 2020 08:08:53 -0400
X-MC-Unique: ZK1QgjwlOqmsxqNFtvp2PA-1
Received: by mail-wr1-f69.google.com with SMTP id u4so1203035wrm.13
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 05:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hAmivG5aDvvl7e+GYdcGOegOdLibFaOeKZvY0VQjVvw=;
        b=GWeiH4D4VPASO4bnus7ZJPvg7UzwR9GvbAr2+F4P/IZm+xtCRnoPGn8wxNdjJZKm6l
         C2k/PC3AWQGsylf7mdilCJILazRjufF4ORO3TRCD8IfdFpCiVEgcPBSIZOaolM37EuWC
         6wRHB1iJeQXCDHue2Jbn37vJQ81RJJ1VS/KvEw0ePOxqJup3dTYjsnJjrL3Wz4dvD06k
         RmO97mb0qGaFwsYPpmvaPZgrD/UPJolVfq1U302/VHdhx85Hec78/j268/m33nxuG6d5
         9TR2y1Zg6DrHJOx5MbKlbd40w/oAwgpqduFZvE/dKbhOIaSk82x81eqpvCjb81UgSiIo
         KaRA==
X-Gm-Message-State: AGi0PuYsva6glTe7JtzWST+DIf1+DDq+aeJJzLNULWOhrEGtZmPcmN9L
        f0yOJoaiqen115ZLVZq9p3gsm3wg7ZRiUdboiJ1X7ySmcJvA+m3iZu1804eJPpFMSqlUQJm1Au3
        bYhE7GNjjrIQy
X-Received: by 2002:a1c:f416:: with SMTP id z22mr4204003wma.32.1588766931877;
        Wed, 06 May 2020 05:08:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypJBsIQXXLBh7+polD0/FRHAo1jIr0FLeGcQ49ZR50oVFkk3bBSfh+noTe2EUmUQ7wGzC4gACg==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr4203979wma.32.1588766931683;
        Wed, 06 May 2020 05:08:51 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id s17sm2634468wmc.48.2020.05.06.05.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:08:51 -0700 (PDT)
Date:   Wed, 6 May 2020 08:08:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: fix the XDP truesize
 calculation for mergeable buffers
Message-ID: <20200506075807-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506061633.16327-2-jasowang@redhat.com>
 <20200506033259-mutt-send-email-mst@kernel.org>
 <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 06, 2020 at 04:21:15PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午3:37, Michael S. Tsirkin wrote:
> > On Wed, May 06, 2020 at 02:16:33PM +0800, Jason Wang wrote:
> > > We should not exclude headroom and tailroom when XDP is set. So this
> > > patch fixes this by initializing the truesize from PAGE_SIZE when XDP
> > > is set.
> > > 
> > > Cc: Jesper Dangaard Brouer<brouer@redhat.com>
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > Seems too aggressive, we do not use up the whole page for the size.
> > 
> > 
> > 
> 
> For XDP yes, we do:
> 
> static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>                       struct ewma_pkt_len *avg_pkt_len,
>                       unsigned int room)
> {
>     const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>     unsigned int len;
> 
>     if (room)
>         return PAGE_SIZE - room;
> 
> ...
> 
> Thanks

Hmm. But that's only for new buffers. Buffers that were outstanding
before xdp was attached don't use the whole page, do they?




Also, with TCP smallqueues blocking the queue like that might be a problem.
Could you try and check performance impact of this?
I looked at what other drivers do and I see they tend to copy the skb
in XDP_PASS case. ATM we don't normally - but should we?

-- 
MST

