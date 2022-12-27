Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE46567B8
	for <lists+bpf@lfdr.de>; Tue, 27 Dec 2022 08:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiL0HNH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 02:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiL0HNG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 02:13:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C3639C
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 23:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672125136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xbSpmIT0V9UbrBBeK6SZDnItYFd1W/oZ/ou2OvHw7I=;
        b=L6bSmi5RVuF8tCaBMLGJc1y6nRE9s6VcztQHnPTnUa1VoToxq0dLt9rOodYjDAljwKazdG
        LJUeOyXPr+es1Pj99YfWCghaRlug2uKanG0c+8L6UBVtNECQYoFYLjjOC1+iSiexaZ7OBX
        VvAbl2paeY3oyyjAW+fV/qHBEalQdc8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-86vjBkoPOISIqnkZIm9efw-1; Tue, 27 Dec 2022 02:12:14 -0500
X-MC-Unique: 86vjBkoPOISIqnkZIm9efw-1
Received: by mail-pj1-f72.google.com with SMTP id h6-20020a17090aa88600b00223fccff2efso10563415pjq.6
        for <bpf@vger.kernel.org>; Mon, 26 Dec 2022 23:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xbSpmIT0V9UbrBBeK6SZDnItYFd1W/oZ/ou2OvHw7I=;
        b=GBVuZUMdCXGJer2x1w4TGqwn1ThfYIaBIRfqVY7H2s+z8ii7e7WzUw4LGiVdmyqrcs
         9YRUnNHfTbV1kRT2fz0dZ0RAzeBF6BiIJFJYaNFVAC7It/jAfYA9/kTXGP4oYIPIRdMu
         2zggHxWBuayb9krC6CBcdZ5rwmw29wR9IsNA7tspXs7+9KiRaWGeRTPJd0kwGwB/5Lir
         T7jJcIUqB88WpikhZxf+JFojPn4SSu7b+eaYaiQNCF0sRYXJRn7qFmYO0pd7O2jRjmhF
         WE1gvw6rGvhvJ7pIpDxLqWSI9pQooStHxEmoK11h74TO8JsKxMSZgUuplF2zBQzRlC/g
         BRlg==
X-Gm-Message-State: AFqh2kr4ayK6FHOjFZ4Qh1WDP9+gO+1tAydQMggq8lTRTxB7W1zYkJub
        8pAbrp6lAbcbu/lv8dPajVvlkFi22w5i5vOXCJ0gz25aSGgy7lugHvKeHdwQt4STUNTXagyUj2Y
        fWVQtug9HN/u9
X-Received: by 2002:a05:6a00:1da2:b0:580:f804:d704 with SMTP id z34-20020a056a001da200b00580f804d704mr9356643pfw.28.1672125133891;
        Mon, 26 Dec 2022 23:12:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsgLbeqx0NIBQBq3frQeMu1mbJ4AsJ39+9ZQ66fvH1Peg/unpM4+pVBQheDJLWWx3xNPqTTBg==
X-Received: by 2002:a05:6a00:1da2:b0:580:f804:d704 with SMTP id z34-20020a056a001da200b00580f804d704mr9356627pfw.28.1672125133633;
        Mon, 26 Dec 2022 23:12:13 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y131-20020a626489000000b00574679561b4sm7869305pfb.134.2022.12.26.23.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 23:12:12 -0800 (PST)
Message-ID: <af506b2f-698f-b3d8-8bc4-f48e2c429ce7@redhat.com>
Date:   Tue, 27 Dec 2022 15:12:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/9] virtio_net: transmit the multi-buffer xdp
Content-Language: en-US
To:     Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221220141449.115918-1-hengqi@linux.alibaba.com>
 <20221220141449.115918-7-hengqi@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221220141449.115918-7-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/12/20 22:14, Heng Qi 写道:
> This serves as the basis for XDP_TX and XDP_REDIRECT
> to send a multi-buffer xdp_frame.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 40bc58fa57f5..9f31bfa7f9a6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -563,22 +563,39 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>   				   struct xdp_frame *xdpf)
>   {
>   	struct virtio_net_hdr_mrg_rxbuf *hdr;
> -	int err;
> +	struct skb_shared_info *shinfo;
> +	u8 nr_frags = 0;
> +	int err, i;
>   
>   	if (unlikely(xdpf->headroom < vi->hdr_len))
>   		return -EOVERFLOW;
>   
> -	/* Make room for virtqueue hdr (also change xdpf->headroom?) */
> +	if (unlikely(xdp_frame_has_frags(xdpf))) {
> +		shinfo = xdp_get_shared_info_from_frame(xdpf);
> +		nr_frags = shinfo->nr_frags;
> +	}
> +
> +	/* Need to adjust this to calculate the correct postion
> +	 * for shinfo of the xdpf.
> +	 */
> +	xdpf->headroom -= vi->hdr_len;


Any reason we need to do this here? (Or if it is, is it only needed for 
multibuffer XDP?)

Other looks good.

Thanks


>   	xdpf->data -= vi->hdr_len;
>   	/* Zero header and leave csum up to XDP layers */
>   	hdr = xdpf->data;
>   	memset(hdr, 0, vi->hdr_len);
>   	xdpf->len   += vi->hdr_len;
>   
> -	sg_init_one(sq->sg, xdpf->data, xdpf->len);
> +	sg_init_table(sq->sg, nr_frags + 1);
> +	sg_set_buf(sq->sg, xdpf->data, xdpf->len);
> +	for (i = 0; i < nr_frags; i++) {
> +		skb_frag_t *frag = &shinfo->frags[i];
> +
> +		sg_set_page(&sq->sg[i + 1], skb_frag_page(frag),
> +			    skb_frag_size(frag), skb_frag_off(frag));
> +	}
>   
> -	err = virtqueue_add_outbuf(sq->vq, sq->sg, 1, xdp_to_ptr(xdpf),
> -				   GFP_ATOMIC);
> +	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> +				   xdp_to_ptr(xdpf), GFP_ATOMIC);
>   	if (unlikely(err))
>   		return -ENOSPC; /* Caller handle free/refcnt */
>   

