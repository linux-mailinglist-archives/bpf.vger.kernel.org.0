Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA016BF72
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 12:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgBYLSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 06:18:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55342 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729708AbgBYLSR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Feb 2020 06:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582629496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcSrZJ633LnILl4hKZiWeKSTIw0SGihk9tSKZPfdWUo=;
        b=ix1cv7Bt9L8SxnwqtLJhZvF4VDy8n4gel6hazJkkY3vwBiqIIuDFe4oy0o+3g9aNnu/Scl
        v3t40v7j52F9fBVoJmDkF5pXL9HmabuS+GkVE9NjWMG2KNufPmbvUZcYf9uwO3gigkrQab
        ZMZxRGHo6gNfLZYfWPnqiEJpuFsmKbU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-HrWKADk5OD-wOWKc_PW60Q-1; Tue, 25 Feb 2020 06:18:10 -0500
X-MC-Unique: HrWKADk5OD-wOWKc_PW60Q-1
Received: by mail-qt1-f199.google.com with SMTP id o24so14455878qtr.17
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 03:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dcSrZJ633LnILl4hKZiWeKSTIw0SGihk9tSKZPfdWUo=;
        b=kt4poaEgmv9gvgFiQ6uL9W9kkts6BlcPxRFR5AMSohFa1VOx+EfTjznqM0oYNONH4c
         dkUjLAbZmQyg0qyaJnj4HsreNKiaFnbAi1na7bMp99g/6Dg3MNQkt2CjJZSTZ6BxT4qA
         RvZUIscVU1OBJhiVLLvPASvzg9h9wTKMPy9nLe+QfDuFIMjbN7itAxkPG/b6oXjdk8RO
         yC/00/YGOWkNqjpuM56oNG/GexIgarl8kcfduTKV2UZwTNbAmeLWGqjPqMjbCnBQDlDH
         wG6NCqQvtZmByh73m2qw0Ug2SVIg/ayoguOkopIZOmHXSOI7Dnn7rJbpmULDsabiH0Ad
         9qoA==
X-Gm-Message-State: APjAAAU364Tex9YnXKSDpYPJJXK8OEAK290Y/RV8Oj++G6SJMeASUTY6
        WMIkZ8d3QWzonsVVQvyYDUAGpLmlcaaN4Fgpf2b7w/FWZ6Or0pGDINiB1nZ6QBFu84vhy5qWW4N
        ogiB3MyOFmnP+
X-Received: by 2002:a37:4a46:: with SMTP id x67mr48067751qka.160.1582629490228;
        Tue, 25 Feb 2020 03:18:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhsafwxrmKzVs2GlO4jxoUvgmsXom8ElM3DBZS74WODQ6dFFsMn+QDBkv/j91R3JLvi5etkQ==
X-Received: by 2002:a37:4a46:: with SMTP id x67mr48067734qka.160.1582629489996;
        Tue, 25 Feb 2020 03:18:09 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
        by smtp.gmail.com with ESMTPSA id s19sm5973078qkj.88.2020.02.25.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 03:18:08 -0800 (PST)
Date:   Tue, 25 Feb 2020 06:18:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc:     jasowang@redhat.com, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v6 1/2] virtio_net: keep vnet header zeroed if
 XDP is loaded for small buffer
Message-ID: <20200225061501-mutt-send-email-mst@kernel.org>
References: <20200225033103.437305-1-yuya.kusakabe@gmail.com>
 <20200225033212.437563-1-yuya.kusakabe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225033212.437563-1-yuya.kusakabe@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 25, 2020 at 12:32:11PM +0900, Yuya Kusakabe wrote:
> We do not want to care about the vnet header in receive_small() if XDP
> is loaded, since we can not know whether or not the packet is modified
> by XDP.
> 
> Fixes: f6b10209b90d ("virtio-net: switch to use build_skb() for small buffer")
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2fe7a3188282..f39d0218bdaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -735,10 +735,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	}
>  	skb_reserve(skb, headroom - delta);
>  	skb_put(skb, len);
> -	if (!delta) {
> +	if (!xdp_prog) {
>  		buf += header_offset;
>  		memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> -	} /* keep zeroed vnet hdr since packet was changed by bpf */
> +	} /* keep zeroed vnet hdr since XDP is loaded */
>  
>  err:
>  	return skb;
> -- 
> 2.24.1

