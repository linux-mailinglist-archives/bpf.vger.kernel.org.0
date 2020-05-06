Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E303B1C6FBC
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgEFL50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 07:57:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726924AbgEFL5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 07:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588766241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sOis2/3Mg9JApCu6b61p44e2yvITngtwxXPAS7QTXw=;
        b=N5+/zihvqMQ6NiWzDxaJbfRL4ks/IBOYYWx49kY3qhYTAIhmlSWCk/euoJKeuFk8W9O22S
        le1DaAZPVO926aVDOwxCVPIaqH5pxeJ5UZnsG5ouqf/0qLg8Ix8VbbVe8uFBdTshXMfz1g
        jYvBTOaOW9lmzbOrUoBfJjkRtZ404Is=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-UNLII3EmPXCpjuXtE800wQ-1; Wed, 06 May 2020 07:57:15 -0400
X-MC-Unique: UNLII3EmPXCpjuXtE800wQ-1
Received: by mail-wr1-f72.google.com with SMTP id y4so1198913wrt.4
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 04:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sOis2/3Mg9JApCu6b61p44e2yvITngtwxXPAS7QTXw=;
        b=VddGRHnn60OHohL28LuZApVdMz3SG1pYqjg6Nw314cSoeBpHiL6ooolggfZ6x9ITIi
         AZd6i0LqOKChLwf5llbQBwGd6HEUDwhf/2/VH0mN2E2/1oOECrXHWfqy/qRHsh/Y/GTh
         YFrqRmtWtlDTlTxvVUXQyny2cLsKQIJkvzdnW1srKMQAAgSzP2S6+7/XCNeKe/tWgMp6
         S4lYmcBlUO07mVg6d7Pi0U+u4YgD6Bx05fE+1Qv++c2fhj3dxwGs57Bhulc3zEGUlDHO
         JqOuxARv1O5Wb6xOvEJ9d72kxlk31+lU90h0NXyv9U9iB3EcGmgEXhcX1j3gToy2kwBH
         pdmA==
X-Gm-Message-State: AGi0PubhbLBtR9fRs6zigwo97ymyxatydZTnJIrw5Q9ET1TsgIhkDkmx
        dtarfMXVlrlz28MQXWxJhYlk4ROByWvCDS5X0XfDtnQ04kvy8TtbR75aoT38jFc/q3nVL1FVJw2
        qp/6JvVM56+b9
X-Received: by 2002:adf:8162:: with SMTP id 89mr8736334wrm.387.1588766233798;
        Wed, 06 May 2020 04:57:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKH40QoEgrQmuxv8rKi91gxvjeAgTSB72BOZzkNW3MxEIsk2JLG9yyMv1mIo8Hc/alFqaSzSg==
X-Received: by 2002:adf:8162:: with SMTP id 89mr8736315wrm.387.1588766233499;
        Wed, 06 May 2020 04:57:13 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id w4sm2398660wro.28.2020.05.06.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 04:57:12 -0700 (PDT)
Date:   Wed, 6 May 2020 07:57:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: performance bug in virtio net xdp
Message-ID: <20200506075226-mutt-send-email-mst@kernel.org>
References: <20200506035704-mutt-send-email-mst@kernel.org>
 <20200506103757.4bc78b3a@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506103757.4bc78b3a@carbon>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 06, 2020 at 10:37:57AM +0200, Jesper Dangaard Brouer wrote:
> On Wed, 6 May 2020 04:08:27 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > So for mergeable bufs, we use ewma machinery to guess the correct buffer
> > size. If we don't guess correctly, XDP has to do aggressive copies.
> > 
> > Problem is, xdp paths do not update the ewma at all, except
> > sometimes with XDP_PASS. So whatever we happen to have
> > before we attach XDP, will mostly stay around.
> > 
> > The fix is probably to update ewma unconditionally.
> 
> I personally find the code hard to follow, and (I admit) that it took
> me some time to understand this code path (so I might still be wrong).
> 
> In patch[1] I tried to explain (my understanding):
> 
>   In receive_mergeable() the frame size is more dynamic. There are two
>   basic cases: (1) buffer size is based on a exponentially weighted
>   moving average (see DECLARE_EWMA) of packet length. Or (2) in case
>   virtnet_get_headroom() have any headroom then buffer size is
>   PAGE_SIZE. The ctx pointer is this time used for encoding two values;
>   the buffer len "truesize" and headroom. In case (1) if the rx buffer
>   size is underestimated, the packet will have been split over more
>   buffers (num_buf info in virtio_net_hdr_mrg_rxbuf placed in top of
>   buffer area). If that happens the XDP path does a xdp_linearize_page
>   operation.
> 
> 
> The EWMA code is not used when headroom is defined, which e.g. gets
> enabled when running XDP.
> 
> 
> [1] https://lore.kernel.org/netdev/158824572816.2172139.1358700000273697123.stgit@firesoul/

You are right.
So I guess the problem is just inconsistency?

When XDP program returns XDP_PASS, and it all fits in one page,
then we trigger
	        ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);

if it does not trigger XDP_PASS, or does not fit in one page,
then we don't.

Given XDP does not use ewma for sizing, let's not update the average
either.


> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer

