Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C62687702
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 09:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjBBIIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 03:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjBBIIs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 03:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437F55BE
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 00:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675325278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUOK4FQp2lSGCpYEOOskwI0ksmKn7u5oUNOZROs3CV4=;
        b=aS0+Gnv1s65YZIY9XxjkhGRD/wUXdqM24cgB2RnzWLWqU7aQjc7bqFH2dvmS0MC79ONvqx
        9PibpFW1J1NWlJeeuuABz/jWpD0xcG1vK1rMDD+nVQVgPGgPV3Uy1qaOc0Whrn/P6dNePa
        LlC2oDvoIYQPTKHxbeIjsNypAE8f8yA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-YrzgholoM6qBaLIcrFm0_A-1; Thu, 02 Feb 2023 03:07:57 -0500
X-MC-Unique: YrzgholoM6qBaLIcrFm0_A-1
Received: by mail-ed1-f70.google.com with SMTP id c12-20020a05640227cc00b0049e2c079aabso888326ede.1
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 00:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUOK4FQp2lSGCpYEOOskwI0ksmKn7u5oUNOZROs3CV4=;
        b=0lFuWF6lSqWnNmj7Xst1F1ispuEyqKU0wRaZSqn5bVpsPuYlNq5An1PbacGrOcxOUf
         QTRU8QD5zCWmR05FYCyakOYIOtNsTsh2vKLBfVD+fJv95kbU5WsmfC8uvH5DKrcnA7pb
         UVyMFedfNwmdG61GXMXlorqwfknN5kQ0acYYp/LoAtG1Xi5/K7u3+0CQVWtTYvImX/+x
         UpvEqwBGU1oK5kKljlvqB3E1pREqr9cuguPCuuu8ImH6yNbDUQE8Bw6m97we4XxvDu1V
         zEBGIyRG0WAa/fYVH9Uoq65vDWZWAKAekd8j+jmp2YEAJW8YHxX/4Sf73wrdSIt4B39I
         hoOw==
X-Gm-Message-State: AO0yUKULVCPupYY5j9ZXG1ibhqtXJfaeTVh3FZWlcBnK+Iwlgfpwa49W
        9Klq34NQOt3eaw0zrkuuQjQn6TVbV2sWjNp1WSa3Ro3HU/qq/HIvB7gMpPQ7ccYNKoEI5smDPr2
        Hdu77yBRZCJtX
X-Received: by 2002:a50:9b58:0:b0:4a6:8239:d6ad with SMTP id a24-20020a509b58000000b004a68239d6admr1655235edj.14.1675325275762;
        Thu, 02 Feb 2023 00:07:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9EB/Qe0qXwBa5fIX1dYI8NGUQ/qA2NHKKVzMR0gG7E5AVPVLuwYtBc2gxM83hN+NIFo0fXfQ==
X-Received: by 2002:a50:9b58:0:b0:4a6:8239:d6ad with SMTP id a24-20020a509b58000000b004a68239d6admr1655214edj.14.1675325275533;
        Thu, 02 Feb 2023 00:07:55 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7c157000000b0049e1f167956sm7172831edp.9.2023.02.02.00.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 00:07:54 -0800 (PST)
Date:   Thu, 2 Feb 2023 03:07:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Heng Qi <hengqi@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2] virtio-net: fix possible unsigned integer
 overflow
Message-ID: <20230202030550-mutt-send-email-mst@kernel.org>
References: <20230131085004.98687-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131085004.98687-1-hengqi@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 04:50:04PM +0800, Heng Qi wrote:
> When the single-buffer xdp is loaded and after xdp_linearize_page()
> is called, *num_buf becomes 0 and (*num_buf - 1) may overflow into
> a large integer in virtnet_build_xdp_buff_mrg(), resulting in
> unexpected packet dropping.
> 
> Fixes: ef75cb51f139 ("virtio-net: build xdp_buff with multi buffers")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v1->v2:
> - Change the type of num_buf from unsigned int to int. @Michael S . Tsirkin
> - Some cleaner codes. @Michael S . Tsirkin
> 
>  drivers/net/virtio_net.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index aaa6fe9b214a..8102861785a2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -716,7 +716,7 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
>   * have enough headroom.
>   */
>  static struct page *xdp_linearize_page(struct receive_queue *rq,
> -				       u16 *num_buf,
> +				       int *num_buf,
>  				       struct page *p,
>  				       int offset,
>  				       int page_off,
> @@ -816,7 +816,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  		if (unlikely(xdp_headroom < virtnet_get_headroom(vi))) {
>  			int offset = buf - page_address(page) + header_offset;
>  			unsigned int tlen = len + vi->hdr_len;
> -			u16 num_buf = 1;
> +			int num_buf = 1;
>  
>  			xdp_headroom = virtnet_get_headroom(vi);
>  			header_offset = VIRTNET_RX_PAD + xdp_headroom;
> @@ -989,7 +989,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  				      void *buf,
>  				      unsigned int len,
>  				      unsigned int frame_sz,
> -				      u16 *num_buf,
> +				      int *num_buf,
>  				      unsigned int *xdp_frags_truesize,
>  				      struct virtnet_rq_stats *stats)
>  {
> @@ -1007,6 +1007,9 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  	xdp_prepare_buff(xdp, buf - VIRTIO_XDP_HEADROOM,
>  			 VIRTIO_XDP_HEADROOM + vi->hdr_len, len - vi->hdr_len, true);
>  
> +	if (!*num_buf)
> +		return 0;
> +
>  	if (*num_buf > 1) {
>  		/* If we want to build multi-buffer xdp, we need
>  		 * to specify that the flags of xdp_buff have the

Ouch. Why is this here? Merged so pls remove by a follow up patch, the
rest of the code handles 0 fine. I'm not sure this introduces a bug by
we don't want spaghetti code.

> @@ -1020,10 +1023,10 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  		shinfo->xdp_frags_size = 0;
>  	}
>  
> -	if ((*num_buf - 1) > MAX_SKB_FRAGS)
> +	if (*num_buf > MAX_SKB_FRAGS + 1)
>  		return -EINVAL;
>  
> -	while ((--*num_buf) >= 1) {
> +	while (--*num_buf > 0) {
>  		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
>  		if (unlikely(!buf)) {
>  			pr_debug("%s: rx error: %d buffers out of %d missing\n",
> @@ -1076,7 +1079,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  					 struct virtnet_rq_stats *stats)
>  {
>  	struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> -	u16 num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> +	int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>  	struct page *page = virt_to_head_page(buf);
>  	int offset = buf - page_address(page);
>  	struct sk_buff *head_skb, *curr_skb;
> -- 
> 2.19.1.6.gb485710b

