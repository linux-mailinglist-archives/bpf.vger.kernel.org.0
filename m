Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1381C7B50
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgEFUdB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 16:33:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41654 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727772AbgEFUdA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 16:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588797179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZFk1jBUP6x0YDNxDE3YAl8iEd93cob/siSLZhgGV9o=;
        b=BgGsusirw3mKGaDBtnERq3EyJi3RNFu4VR9GJF/lFY2MldP34e7FTourKEEqyIBYdnjsRj
        R6rSaR+2Ns4Pm7ULqlKQLfWpDI1oXhcgZ2ktQtODrYuv/h1IYi2IdZ93TDnifxO4vUVFZv
        sEEG25+ErxHKTTtN5aSIGRXKqtixKGU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-uG3lAa-KMuO8PZe5LlUkuw-1; Wed, 06 May 2020 16:32:57 -0400
X-MC-Unique: uG3lAa-KMuO8PZe5LlUkuw-1
Received: by mail-wm1-f72.google.com with SMTP id q5so1853276wmc.9
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 13:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZFk1jBUP6x0YDNxDE3YAl8iEd93cob/siSLZhgGV9o=;
        b=E9MXeJ6BUccM+dAjDxMhxU6dxCiAC1HaaoBN+8jTi6K59oUKjE8qRC61atW4nndyjJ
         NgzENhCU6a97oYvV+BI35lRcwXvd4P3Nw09JkST1SYheBOhB0Ky2TahBvx5d3f3YwL0N
         Dtsh17pkZnfbzf4fDlMzeRshBD4HQoO7nAOgvdD6oTGrRb3ytLnFtijl+t3dZsSZnPWc
         5IwwONvC+4IQMsZ0SGku6K+LWFzOjYry7gli8TPBX+KKDu8fEFV74CIATj+I5chXSPsY
         BK+ztlTH6ibRT9K0mg6bJ81ZAJaTQcTz8/QlxElRZn2baDcRujcvoQYUDkQybS6qNLw2
         deIA==
X-Gm-Message-State: AGi0PuYSP5FS+EU2IBcHLmLDPcSLY5Y0TCsoO1px1Ucd0OEYRPzf4alA
        fy7p8R2wSLYg34uma5wzgzWCTnpxfiD4WXU8lEQ1hufJ9+t3LGL3oY5Rl650jiTjdPb/nyhtIEC
        U7gKYO/qMCLtw
X-Received: by 2002:adf:fe01:: with SMTP id n1mr11128882wrr.268.1588797176513;
        Wed, 06 May 2020 13:32:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypLReZq9OJmCb+r83s/HG7eVrefUQ62FWlPQlkLKQYTb7TAId3pVJFTSqkasQ6SnOGSz7lZN3Q==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr11128869wrr.268.1588797176337;
        Wed, 06 May 2020 13:32:56 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id g15sm4608600wrp.96.2020.05.06.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:32:55 -0700 (PDT)
Date:   Wed, 6 May 2020 16:32:52 -0400
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
Subject: Re: [PATCH net-next v2 19/33] tun: add XDP frame size
Message-ID: <20200506163247-mutt-send-email-mst@kernel.org>
References: <158824557985.2172139.4173570969543904434.stgit@firesoul>
 <158824571799.2172139.18397231693481050715.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158824571799.2172139.18397231693481050715.stgit@firesoul>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 30, 2020 at 01:21:58PM +0200, Jesper Dangaard Brouer wrote:
> The tun driver have two code paths for running XDP (bpf_prog_run_xdp).
> In both cases 'buflen' contains enough tailroom for skb_shared_info.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 44889eba1dbc..c54f967e2c66 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1671,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  		xdp_set_data_meta_invalid(&xdp);
>  		xdp.data_end = xdp.data + len;
>  		xdp.rxq = &tfile->xdp_rxq;
> +		xdp.frame_sz = buflen;
>  
>  		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>  		if (act == XDP_REDIRECT || act == XDP_TX) {
> @@ -2411,6 +2412,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		}
>  		xdp_set_data_meta_invalid(xdp);
>  		xdp->rxq = &tfile->xdp_rxq;
> +		xdp->frame_sz = buflen;
>  
>  		act = bpf_prog_run_xdp(xdp_prog, xdp);
>  		err = tun_xdp_act(tun, xdp_prog, xdp, act);
> 
> 

