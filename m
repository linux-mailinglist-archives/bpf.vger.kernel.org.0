Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FADB6893C0
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjBCJaq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 04:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjBCJab (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 04:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8719810AAD
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 01:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675416589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bNds1HI1I/0dpuSXz+oY0DFaA+4gCa4y5cBoLVvC84g=;
        b=cuAtLAewThZyS81gZkEZ7iH3uOnsYf2loYctixZd+wum6bLISpsWiiwaf8S9HDsEJvb01o
        UkAyiTwAkTZquysaoslWSMTX4GqjGuoJE+NSZKXUs+UuXZ++luALkweOHaqmCd8b6ZG1+L
        VevIf5a247nEgcg34yo9ix4pYuzPNz0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-O9_u4-IsO7OSy-ohSa_ldA-1; Fri, 03 Feb 2023 04:29:48 -0500
X-MC-Unique: O9_u4-IsO7OSy-ohSa_ldA-1
Received: by mail-ej1-f69.google.com with SMTP id he34-20020a1709073da200b00887ced84328so3555786ejc.10
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 01:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNds1HI1I/0dpuSXz+oY0DFaA+4gCa4y5cBoLVvC84g=;
        b=ulHzZS5/Jf5kn6p47guWkK+fDlq5R8GMmdcRVZEzRqe1QcggnCfuU89fQeynTBaIBe
         AceJv3+SF/vLP/KgIGrEsFOdBZlDJ/19MXzthjYsXzJU2Ntiwkb9Z7CYGjuk2DjBkLV3
         m+GyqPKLTJmUrloaQN+Rjk7QtoPz+GzuQQYj72ilqg964sCz9HqmeJ7ogJ7F+BiBqJ+3
         wspP0+K0vWBOLEXn8fEUD6t4ujmvnrBUgbmpy6SjpcdUb/gDpX/JKgy/Ltl8odA4Zl+/
         zHsLiZd8eXfhEwQERYo5tGcy5VUhbGAhvip+vUA3xCk4gLlvC60qMKWMT+udmsjZK360
         iF5g==
X-Gm-Message-State: AO0yUKWz+vINRBKzeQld/wvBTIViVrSCays3T6UwCHTv8yuYIbOVsAqp
        XWOgA2WIqNA/gshzU2jvpyU3z+1wpU/zSARI7z+pW5ExajPDjuRz7w+pIrUn3X4YLHBtgDlk2Hx
        tOz+r1Hd9imyv
X-Received: by 2002:a17:907:3e82:b0:878:6755:9089 with SMTP id hs2-20020a1709073e8200b0087867559089mr12602396ejc.39.1675416587253;
        Fri, 03 Feb 2023 01:29:47 -0800 (PST)
X-Google-Smtp-Source: AK7set/jWXVc31NjbbKgYo8E+Q5ARi8JpVQ4Jp8pluUOVMkbKQPKWx5Bd61WD+5ofhOfbTrQifSc5w==
X-Received: by 2002:a17:907:3e82:b0:878:6755:9089 with SMTP id hs2-20020a1709073e8200b0087867559089mr12602375ejc.39.1675416587074;
        Fri, 03 Feb 2023 01:29:47 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906340f00b008778f177fbesm1140263ejb.11.2023.02.03.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:29:46 -0800 (PST)
Date:   Fri, 3 Feb 2023 04:29:41 -0500
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
Message-ID: <20230203042821-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
 <20230202122445-mutt-send-email-mst@kernel.org>
 <1675394682.9569418-1-xuanzhuo@linux.alibaba.com>
 <20230203032945-mutt-send-email-mst@kernel.org>
 <1675414156.9460502-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675414156.9460502-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 04:49:16PM +0800, Xuan Zhuo wrote:
> On Fri, 3 Feb 2023 03:33:41 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Feb 03, 2023 at 11:24:42AM +0800, Xuan Zhuo wrote:
> > > On Thu, 2 Feb 2023 12:25:59 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Feb 02, 2023 at 07:00:49PM +0800, Xuan Zhuo wrote:
> > > > > Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> > > > > we must stop tx napi from being disabled.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/main.c | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > > index ed79e750bc6c..232cf151abff 100644
> > > > > --- a/drivers/net/virtio/main.c
> > > > > +++ b/drivers/net/virtio/main.c
> > > > > @@ -2728,8 +2728,15 @@ static int virtnet_set_coalesce(struct net_device *dev,
> > > > >  		return ret;
> > > > >
> > > > >  	if (update_napi) {
> > > > > -		for (i = 0; i < vi->max_queue_pairs; i++)
> > > > > +		for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > +			/* xsk xmit depend on the tx napi. So if xsk is active,
> > > >
> > > > depends.
> > > >
> > > > > +			 * prevent modifications to tx napi.
> > > > > +			 */
> > > > > +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> > > > > +				continue;
> > > > > +
> > > > >  			vi->sq[i].napi.weight = napi_weight;
> > > >
> > > > I don't get it.
> > > > changing napi weight does not work then.
> > > > why is this ok?
> > >
> > >
> > > static void skb_xmit_done(struct virtqueue *vq)
> > > {
> > > 	struct virtnet_info *vi = vq->vdev->priv;
> > > 	struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> > >
> > > 	/* Suppress further interrupts. */
> > > 	virtqueue_disable_cb(vq);
> > >
> > > 	if (napi->weight)
> > > 		virtqueue_napi_schedule(napi, vq);
> > > 	else
> > > 		/* We were probably waiting for more output buffers. */
> > > 		netif_wake_subqueue(vi->dev, vq2txq(vq));
> > > }
> > >
> > >
> > > If the weight is 0, tx napi will not be triggered again.
> > >
> > > Thanks.
> >
> > This needs more thought then. First ignoring what user is requesting is
> > not nice.
> 
> Maybe we should return an error.

maybe


> >Second what if napi is first disabled and then xsk enabled?
> 
> 
> static int virtnet_xsk_pool_enable(struct net_device *dev,
> 				   struct xsk_buff_pool *pool,
> 				   u16 qid)
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
> 	struct receive_queue *rq;
> 	struct send_queue *sq;
> 	int err;
> 
> 	if (qid >= vi->curr_queue_pairs)
> 		return -EINVAL;
> 
> 	sq = &vi->sq[qid];
> 	rq = &vi->rq[qid];
> 
> 	/* xsk zerocopy depend on the tx napi.
> 	 *
> 	 * All xsk packets are actually consumed and sent out from the xsk tx
> 	 * queue under the tx napi mechanism.
> 	 */
> ->	if (!sq->napi.weight)
> 		return -EPERM;
> 
> Thanks.
> 
> 
> >
> >
> > > >
> > > >
> > > > > +		}
> > > > >  	}
> > > > >
> > > > >  	return ret;
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> >

