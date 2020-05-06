Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2752E1C7B53
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgEFUdj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 16:33:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48340 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727102AbgEFUdi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 16:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588797216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKrWfoQgXcZFPy5pzZGV3ew40nkonHSC1M2c16vq6R8=;
        b=ak7T3xuPJWLg6KhLRmYgdFpIjLwyvo4mAJ8tUyb0WGXLwXDpKjDiE6+EpiVjqHmK5PKbOC
        G1ebjDUglsvlWUkrLCOTo4aDkJIp1dR90w/mUJXRA7nP67PiWLiwbv/ZHVyCq7Vduj1WJd
        P7nR1FgASlIsK9qD6znPP+WfbwxXfmg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-KC0nvd3nMmGbrXvahlUteQ-1; Wed, 06 May 2020 16:33:34 -0400
X-MC-Unique: KC0nvd3nMmGbrXvahlUteQ-1
Received: by mail-wr1-f70.google.com with SMTP id a12so1941197wrv.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 13:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKrWfoQgXcZFPy5pzZGV3ew40nkonHSC1M2c16vq6R8=;
        b=dx31acDolLmMUKbDLfvaH7lDsLQRuDjXQ9xJNCXFK0R0WXrXCkudkInM7oZniFXBMS
         DStfHoF6TArMUbgbeWQtwfgHp2lIqEc+pDrT4g1+4F4iUX+sisTqtN0XqggBKRKTuqc7
         ALDh8LyFw8YOE9fJx0kqdWlq3X11GoS1Zqwauae0E5ZsDdcD8ayX2z4hr9JKIvZaITlF
         ckJ/adT2V/HjFUA2xyLstGuRNH+LRYsBV6hNhiDgzuem5QaBGRi8G7S47JpdJlwa02zw
         YXLQR3+QZhMvAHNhJdyOYrDuxdtjDh3wu17mRnl0OfbcXRSNZwJzdVkv6EgtcMR/VYo+
         L7Dg==
X-Gm-Message-State: AGi0PuacGuEXgY3MWlzWKA89m1Xd8WrC6KBXU3UULQuvTGwxISgsmaMf
        50PWev/15LxgaZaed6WdxHabl0IHWyiHqNwCaCd6KWfiLzkqV5NA/C/LOBt/mVZZ5eAywOqza+6
        ptDggXUW1WlUJ
X-Received: by 2002:a5d:5001:: with SMTP id e1mr11919342wrt.27.1588797213511;
        Wed, 06 May 2020 13:33:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJN7Gcycn/d6Zc0I6qlNFQBgDpZNghG7fqqIn6zWJizbeAuds5qjZXlzXn7dS6crItjEZ31TA==
X-Received: by 2002:a5d:5001:: with SMTP id e1mr11919332wrt.27.1588797213298;
        Wed, 06 May 2020 13:33:33 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id w15sm4292697wrl.73.2020.05.06.13.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:33:32 -0700 (PDT)
Date:   Wed, 6 May 2020 16:33:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     sameehj@amazon.com, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        steffen.klassert@secunet.com
Subject: Re: [PATCH net-next v2 20/33] vhost_net: also populate XDP frame size
Message-ID: <20200506163322-mutt-send-email-mst@kernel.org>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
 <158824572308.2172139.1144470511173466125.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158824572308.2172139.1144470511173466125.stgit@firesoul>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 30, 2020 at 01:22:03PM +0200, Jesper Dangaard Brouer wrote:
> In vhost_net_build_xdp() the 'buf' that gets queued via an xdp_buff
> have embedded a struct tun_xdp_hdr (located at xdp->data_hard_start)
> which contains the buffer length 'buflen' (with tailroom for
> skb_shared_info). Also storing this buflen in xdp->frame_sz, does not
> obsolete struct tun_xdp_hdr, as it also contains a struct
> virtio_net_hdr with other information.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 2927f02cc7e1..516519dcc8ff 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -747,6 +747,7 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
>  	xdp->data = buf + pad;
>  	xdp->data_end = xdp->data + len;
>  	hdr->buflen = buflen;
> +	xdp->frame_sz = buflen;
>  
>  	--net->refcnt_bias;
>  	alloc_frag->offset += buflen;
> 
> 

