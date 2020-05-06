Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E03F1C7B46
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 22:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEFUbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 16:31:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38957 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726477AbgEFUbA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 16:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588797059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mxj3BMUER/qskRTE3a7H06hV5LBr7IdHhUh5bgVa4OE=;
        b=SWIZCniKqBnPuK4hL3sY0DyRCZ4GEgUnDcQRmuUiBnbIWGVj2vV5N96YRw3CjQRWjn5E+k
        DoXh0nUk+qNPWY8nejNrbQ/oZtQFT7znSZIQXUi4VtRotEAzsm08Yc9Pj0wZBGlFGFOUiX
        sQxVyeeE6Loq+6EmM7PqwjZHTd5YtDA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-YnPHHbLXMgeeXZq2iYffng-1; Wed, 06 May 2020 16:30:56 -0400
X-MC-Unique: YnPHHbLXMgeeXZq2iYffng-1
Received: by mail-wr1-f72.google.com with SMTP id v17so1919422wrq.8
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 13:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mxj3BMUER/qskRTE3a7H06hV5LBr7IdHhUh5bgVa4OE=;
        b=e8aflO71hbs85y/yVdvabpXE+RaUlU0V36yL+H90iv/hoETPmSnc6a+EbTqqHMzJUS
         8fyahzT5x2Jsc8ITvS0s5fy01iecKgIbDVQFLVImsaf7/hC1lJtsaJbpOPpcZ9KWioNK
         o+nHTYlVYDjwwupGSZIyam57zt24OQghp4AP+xz2N1xIo+L1CNo6TGz3v/jb2icU4hUh
         SFr0YDeHlfDGmw4aWspJ7lOTRH2i5Kb4DAQi/JlrvKzJy/mcnyEYTwMubn2YXQxSI1np
         J5t3i/tCegSNrxWYAsNuYpG17anBXvQhO6MBQ+tjNgAbRHnaunOQ1U1XUwO3B8AuCDl1
         qGuA==
X-Gm-Message-State: AGi0PuZP8kKPS85DmfYiHGjM3VBDLgID4rk0Vao98VCrKBHFeoCfU/nL
        1/Uy9dDzDEBoLXwkGHALW5cXqtcc9/pHJ4Al/gYgUxGwYgVIzyzbU4vISLRl9W3uKpl/W6Ujo4h
        frWuUw7bebxfy
X-Received: by 2002:a5d:650c:: with SMTP id x12mr10917394wru.425.1588797055101;
        Wed, 06 May 2020 13:30:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJMoBt/7ReQsSc5SDcms1E5ukat//yBhg8yRBv8cixGfRK83FSjm3HKIwLitzMGU0a+XqRMlg==
X-Received: by 2002:a5d:650c:: with SMTP id x12mr10917379wru.425.1588797054926;
        Wed, 06 May 2020 13:30:54 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id 92sm4414502wrm.71.2020.05.06.13.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:30:54 -0700 (PDT)
Date:   Wed, 6 May 2020 16:30:51 -0400
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
Subject: Re: [PATCH net-next 19/33] tun: add XDP frame size
Message-ID: <20200506163031-mutt-send-email-mst@kernel.org>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul>
 <158757173758.1370371.17195673814740376146.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158757173758.1370371.17195673814740376146.stgit@firesoul>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 22, 2020 at 06:08:57PM +0200, Jesper Dangaard Brouer wrote:
> The tun driver have two code paths for running XDP (bpf_prog_run_xdp).
> In both cases 'buflen' contains enough tailroom for skb_shared_info.
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

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

