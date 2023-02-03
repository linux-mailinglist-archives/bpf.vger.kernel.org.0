Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24E689263
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 09:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBCIe6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 03:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjBCIen (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 03:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC2F712C6
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675413231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9gia5gCXojDKJbnjBecgsqKUe4A6lVBjKVa+Q7BTrU=;
        b=AnBshBWaENwvqAs1H1A/JCtAHe5DsiYSEsS/kZTCdKpogyTXculHtdSfGBdECRa3djetk7
        3pNZiKZ72kbWuft4VRGOvmivQrb/haLaDGyJp6JHG0NWjHTnuGQZe9T/yfXDpxMbTQvTFG
        ylulVi7VvO/an9DnV3quoiV9omm2Ey0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-UZ6vgAkXOMehGiSb0WhSxg-1; Fri, 03 Feb 2023 03:33:48 -0500
X-MC-Unique: UZ6vgAkXOMehGiSb0WhSxg-1
Received: by mail-wm1-f72.google.com with SMTP id j20-20020a05600c1c1400b003dc5dd44c0cso2281034wms.8
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 00:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9gia5gCXojDKJbnjBecgsqKUe4A6lVBjKVa+Q7BTrU=;
        b=5LMSgYukIQUPvhUKOHZpEdh9RKmYouDelD3V4Xo//q2LNuerfqWlG7nyP4nfLh9r71
         bCk0aPEdL+rNRkTmi3Qc/UX8Qx/M1WGIgS75TUalCqA4B2Y/GVizegmAHVo52pYo+s6r
         LaNhMmJfMDAQ+p41p07PJ9G42/0V342z3dRsen7m+8kknY/w2b27h6j2+JGpUu50N1NM
         NqQ0ffolIUlRTz1B8s3tHPbDnhBPolX5+M/qaZKfTKDiDbQtrlxfqVjHqXhj4r6pqooA
         uyaAuXRkFzs72PWX02gcOz7Ci6ShLcKfyPpKAkObxbTSMj1cSSuPeWDu/Jx/DR5mKBHQ
         MwWA==
X-Gm-Message-State: AO0yUKW3JD/7YT/LKdmd7PZu9LD7kix62DUpTxtgmReKOu+UuS9bhYfm
        tkgnOFF6ev6jf3cmfQBG+ZmyR8KId9ADQngVX+VD3k9M+4hFRMhoofyXReKAt7xfbSAN4A/mt67
        Z9sc9HJxJGuOO
X-Received: by 2002:a05:600c:1d03:b0:3dd:1bcc:eb17 with SMTP id l3-20020a05600c1d0300b003dd1bcceb17mr8913702wms.28.1675413226957;
        Fri, 03 Feb 2023 00:33:46 -0800 (PST)
X-Google-Smtp-Source: AK7set+Y8WwnwZ3TGibkgw7+NTRwE/wRyUdxNN+qG3QQe1IWY+jcAry8oCig/t9FCfmiWTBrHfVg6Q==
X-Received: by 2002:a05:600c:1d03:b0:3dd:1bcc:eb17 with SMTP id l3-20020a05600c1d0300b003dd1bcceb17mr8913678wms.28.1675413226764;
        Fri, 03 Feb 2023 00:33:46 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003dc51c48f0bsm7879692wms.19.2023.02.03.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:33:46 -0800 (PST)
Date:   Fri, 3 Feb 2023 03:33:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Petr Machata <petrm@nvidia.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH 24/33] virtio_net: xsk: stop disable tx napi
Message-ID: <20230203032945-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
 <20230202122445-mutt-send-email-mst@kernel.org>
 <1675394682.9569418-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675394682.9569418-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 11:24:42AM +0800, Xuan Zhuo wrote:
> On Thu, 2 Feb 2023 12:25:59 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Feb 02, 2023 at 07:00:49PM +0800, Xuan Zhuo wrote:
> > > Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> > > we must stop tx napi from being disabled.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/main.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index ed79e750bc6c..232cf151abff 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -2728,8 +2728,15 @@ static int virtnet_set_coalesce(struct net_device *dev,
> > >  		return ret;
> > >
> > >  	if (update_napi) {
> > > -		for (i = 0; i < vi->max_queue_pairs; i++)
> > > +		for (i = 0; i < vi->max_queue_pairs; i++) {
> > > +			/* xsk xmit depend on the tx napi. So if xsk is active,
> >
> > depends.
> >
> > > +			 * prevent modifications to tx napi.
> > > +			 */
> > > +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> > > +				continue;
> > > +
> > >  			vi->sq[i].napi.weight = napi_weight;
> >
> > I don't get it.
> > changing napi weight does not work then.
> > why is this ok?
> 
> 
> static void skb_xmit_done(struct virtqueue *vq)
> {
> 	struct virtnet_info *vi = vq->vdev->priv;
> 	struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> 
> 	/* Suppress further interrupts. */
> 	virtqueue_disable_cb(vq);
> 
> 	if (napi->weight)
> 		virtqueue_napi_schedule(napi, vq);
> 	else
> 		/* We were probably waiting for more output buffers. */
> 		netif_wake_subqueue(vi->dev, vq2txq(vq));
> }
> 
> 
> If the weight is 0, tx napi will not be triggered again.
> 
> Thanks.

This needs more thought then. First ignoring what user is requesting is
not nice.  Second what if napi is first disabled and then xsk enabled?


> >
> >
> > > +		}
> > >  	}
> > >
> > >  	return ret;
> > > --
> > > 2.32.0.3.g01195cf9f
> >

