Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223E96945A0
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 13:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBMMQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 07:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjBMMQP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 07:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BAF5B9D
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 04:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676290519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3qa0NV6SAa+DWFZkquUnp2CMq9sj1EY4L6liDe1El0=;
        b=EfsWprso+DWRmXTCxnzkr2B4/vw++mLYgpsOFt+Gt8jZ6hFqoEvDdxHxj9+5eAs2rlIMtO
        iNhKeLYrqKGUvSgCAITI6Zws3chA/6fjY/lvNxdQnxpsO980l00mI6onjyRcIemEuHn+KP
        eFP6N4YLuMynsxi3Vs9CX43O4Ll5qL8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-qiLrmdqPMnOIqaHcpV0Igw-1; Mon, 13 Feb 2023 07:15:08 -0500
X-MC-Unique: qiLrmdqPMnOIqaHcpV0Igw-1
Received: by mail-wm1-f70.google.com with SMTP id p14-20020a05600c468e00b003e0107732f4so6071949wmo.1
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 04:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3qa0NV6SAa+DWFZkquUnp2CMq9sj1EY4L6liDe1El0=;
        b=FR+gbseK2aqrNz1NWPFWPfR5zV8WOIiOuc+BL7hrT9OoTT6pFhc4WUyEIk7dA2Y4m0
         UmkuOkXSOatuW+InP6fiBaR0qk8Oiz2n3d/V+woD9Gvq9rlzm3f4JNNtwntvZfM8pN5Q
         IAVp/2mp79KYJ2u8TuGp4SVDfS/iHv84CxoJU1Mw9rBFW2LojGwRgN5lBwhfE7tTqmed
         RkpjSel8n8kTKapecNS7QBIwPX0k95j36GJKDxkicM2m+5sNFoRGXL5g6JlLQDPAgL2t
         9Omb7TzBCWIGRaY5SaGP/bM4wyoehe4w4ZziXiMEw70fa5mvINUHKtYF/GFH9cSD3Ea1
         NqEQ==
X-Gm-Message-State: AO0yUKUXiqhw5k9EtANQUc+hYlg6g9tHCDfD21uX9bKQzMFYRGtOtGHn
        YM+t1VrCs725PE2fWVptffPSBBW+BIizJ945wudgHfmymWAZTloqPz59eygqpKNWN5cZ+wsJ5/o
        dSgtYCzM++KX9
X-Received: by 2002:a05:600c:755:b0:3e0:6c4:6a3a with SMTP id j21-20020a05600c075500b003e006c46a3amr18868995wmn.22.1676290507629;
        Mon, 13 Feb 2023 04:15:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+P43vIsCcaEC0XvwsLyfTrlBYlBKdzBjIMl2f/TTw6XkbvBupTlvvrbK29o+k8EwLe9Lc8fw==
X-Received: by 2002:a05:600c:755:b0:3e0:6c4:6a3a with SMTP id j21-20020a05600c075500b003e006c46a3amr18868982wmn.22.1676290507441;
        Mon, 13 Feb 2023 04:15:07 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b003dfee43863fsm19109128wmq.26.2023.02.13.04.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:15:06 -0800 (PST)
Date:   Mon, 13 Feb 2023 07:15:02 -0500
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
Subject: Re: [PATCH 06/33] virtio_ring: introduce virtqueue_reset()
Message-ID: <20230213071430-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-7-xuanzhuo@linux.alibaba.com>
 <20230203040041-mutt-send-email-mst@kernel.org>
 <1675415352.3250086-8-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675415352.3250086-8-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 03, 2023 at 05:09:12PM +0800, Xuan Zhuo wrote:
> On Fri, 3 Feb 2023 04:05:38 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Feb 02, 2023 at 07:00:31PM +0800, Xuan Zhuo wrote:
> > > Introduce virtqueue_reset() to release all buffer inside vq.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  2 ++
> > >  2 files changed, 52 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index e32046fd15a5..7dfce7001f9f 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2735,6 +2735,56 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >
> > > +/**
> > > + * virtqueue_reset - reset the vring of vq
> >
> > ..., detach and recycle all unused buffers
> >
> > 	after all this is why we are doing this reset, right?
> >
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + * @recycle: callback for recycle the useless buffer
> >
> > not useless :) unused:
> >
> > 	callback to recycle unused buffers
> 
> 
> I agree. Will fix.
> 
> Thanks.

Probably too late for this merge cycle then. Oh well.


> >
> > I know we have the same confusion in virtqueue_resize, I will fix
> > that.
> >
> > > + *
> > > + * Caller must ensure we don't call this with other virtqueue operations
> > > + * at the same time (except where noted).
> > > + *
> > > + * Returns zero or a negative error.
> > > + * 0: success.
> > > + * -EBUSY: Failed to sync with device, vq may not work properly
> > > + * -ENOENT: Transport or device not supported
> > > + * -EPERM: Operation not permitted
> > > + */
> > > +int virtqueue_reset(struct virtqueue *_vq,
> > > +		    void (*recycle)(struct virtqueue *vq, void *buf))
> > > +{
> > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +	struct virtio_device *vdev = vq->vq.vdev;
> > > +	void *buf;
> > > +	int err;
> > > +
> > > +	if (!vq->we_own_ring)
> > > +		return -EPERM;
> > > +
> > > +	if (!vdev->config->disable_vq_and_reset)
> > > +		return -ENOENT;
> > > +
> > > +	if (!vdev->config->enable_vq_after_reset)
> > > +		return -ENOENT;
> > > +
> > > +	err = vdev->config->disable_vq_and_reset(_vq);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> > > +		recycle(_vq, buf);
> > > +
> > > +	if (vq->packed_ring)
> > > +		virtqueue_reinit_packed(vq);
> > > +	else
> > > +		virtqueue_reinit_split(vq);
> > > +
> > > +	if (vdev->config->enable_vq_after_reset(_vq))
> > > +		return -EBUSY;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_reset);
> > > +
> > >  /* Only available for split ring */
> > >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> > >  				      unsigned int num,
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 3ebb346ebb7c..3ca2edb1aef3 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -105,6 +105,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> > >
> > >  int virtqueue_resize(struct virtqueue *vq, u32 num,
> > >  		     void (*recycle)(struct virtqueue *vq, void *buf));
> > > +int virtqueue_reset(struct virtqueue *vq,
> > > +		    void (*recycle)(struct virtqueue *vq, void *buf));
> > >
> > >  /**
> > >   * struct virtio_device - representation of a device using virtio
> > > --
> > > 2.32.0.3.g01195cf9f
> >

