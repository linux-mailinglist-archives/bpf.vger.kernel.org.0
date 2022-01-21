Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B45496213
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381532AbiAUP3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 10:29:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381578AbiAUP2y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 10:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642778934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15RUfqjRD2R8NWyJZ8VSKXnNDHDUojA956rC+L5Rd4s=;
        b=DomBYd3NxrCacEGCxUkTxQvNTjkGBN9lbGgKNZ0IPeVX0P59BqxG/8oZHcEj2cR9ACqNF3
        wQb53kSnmjAnwp4+gWx3DWV3wtQFf3OZKZWNA3Xvd4xoPOAYtFj3KbKum+gmCWcs7QpV2E
        aD1yJeUU37ovL8Hm8NrjdmrLXdRomMU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-G2HQ6o2FPTOl0XV4s4CS1w-1; Fri, 21 Jan 2022 10:28:50 -0500
X-MC-Unique: G2HQ6o2FPTOl0XV4s4CS1w-1
Received: by mail-ed1-f72.google.com with SMTP id p17-20020aa7c891000000b004052d1936a5so4883700eds.7
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 07:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=15RUfqjRD2R8NWyJZ8VSKXnNDHDUojA956rC+L5Rd4s=;
        b=wqBrqimUpZYbSssFIe39A5pY/hXjprq7pUVZxetxTA51RJwc8jsw52ojJoNIi+B3jj
         g2tJxdeg/pziX3oX9xT8wokzxGhFychJFFPPVRfVkJChil5803kn6vwAtigpmMZUsVPX
         MnHXhOY+WTboFs9HXZu/oGx3RuWNhNd1I9l0l+HLA1Gp5XwXoV0KSIVaoaEnbYH5vQFD
         Az4I6mg2AuNQ4aLGr0DGtUktdMeU9nLzPJO8iXR249olJl6gQL3gWSRbvXtBKm3Nji/X
         BjLZLQ58ESBDb4HpRf2CLj124BFGXFiFsW7hvabYj+/Gx6LD5bA/cXH84RKchIDzsgh0
         6w0w==
X-Gm-Message-State: AOAM533DP9c36ETrfFq6P2Az1Kgw0MiA3WS4a+8/bZyF9qxKwJ6OT+b2
        m83kQMjNQWdKB8vFlFDZ9ZZ86XTnIp9wQO5CDQ38IrL6LPIiR21mQkIKoqHKKdqf1lGOqVATY8U
        NN4N+Cyn/LVxl
X-Received: by 2002:a05:6402:2756:: with SMTP id z22mr4764430edd.255.1642778929480;
        Fri, 21 Jan 2022 07:28:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwr1C8b+c/EuGUW5CvBN8QuzZLs7kWF6QJoULeaVCDBP+E3OgRrq0UBObN3n5qQhARjIStTBw==
X-Received: by 2002:a05:6402:2756:: with SMTP id z22mr4764413edd.255.1642778929173;
        Fri, 21 Jan 2022 07:28:49 -0800 (PST)
Received: from redhat.com ([181.214.206.211])
        by smtp.gmail.com with ESMTPSA id hg12sm2105259ejc.66.2022.01.21.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 07:28:48 -0800 (PST)
Date:   Fri, 21 Jan 2022 10:28:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 07/12] virtio: queue_reset: pci: support
 VIRTIO_F_RING_RESET
Message-ID: <20220121102715-mutt-send-email-mst@kernel.org>
References: <20220121081931-mutt-send-email-mst@kernel.org>
 <1642774171.933696-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642774171.933696-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 10:09:31PM +0800, Xuan Zhuo wrote:
> On Fri, 21 Jan 2022 08:19:55 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Jan 21, 2022 at 06:26:33PM +0800, Xuan Zhuo wrote:
> > > On Fri, 21 Jan 2022 05:22:59 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Fri, Jan 21, 2022 at 05:22:29AM -0500, Michael S. Tsirkin wrote:
> > > > > On Fri, Jan 21, 2022 at 10:22:59AM +0800, Xuan Zhuo wrote:
> > > > > > On Thu, 20 Jan 2022 10:03:45 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > On Thu, Jan 20, 2022 at 07:46:20PM +0800, Xuan Zhuo wrote:
> > > > > > > > On Thu, 20 Jan 2022 05:55:14 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > On Thu, Jan 20, 2022 at 02:42:58PM +0800, Xuan Zhuo wrote:
> > > > > > > > > > This patch implements virtio pci support for QUEUE RESET.
> > > > > > > > > >
> > > > > > > > > > Performing reset on a queue is divided into two steps:
> > > > > > > > > >
> > > > > > > > > > 1. reset_vq: reset one vq
> > > > > > > > > > 2. enable_reset_vq: re-enable the reset queue
> > > > > > > > > >
> > > > > > > > > > In the first step, these tasks will be completed:
> > > > > > > > > >    1. notify the hardware queue to reset
> > > > > > > > > >    2. recycle the buffer from vq
> > > > > > > > > >    3. delete the vq
> > > > > > > > > >
> > > > > > > > > > When deleting a vq, vp_del_vq() will be called to release all the memory
> > > > > > > > > > of the vq. But this does not affect the process of deleting vqs, because
> > > > > > > > > > that is based on the queue to release all the vqs. During this process,
> > > > > > > > > > the vq has been removed from the queue.
> > > > > > > > > >
> > > > > > > > > > When deleting vq, info and vq will be released, and I save msix_vec in
> > > > > > > > > > vp_dev->vqs[queue_index]. When re-enable, the current msix_vec can be
> > > > > > > > > > reused. And based on intx_enabled to determine which method to use to
> > > > > > > > > > enable this queue.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > >
> > > > > > > > > There's something I don't understand here. It looks like
> > > > > > > > > you assume that when you reset a queue, you also
> > > > > > > > > reset the mapping from queue to event vector.
> > > > > > > > > The spec does not say it should, and I don't think it's
> > > > > > > > > useful to extend spec to do it - we already have a simple
> > > > > > > > > way to tweak the mapping.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Sorry, what is the already existing method you are referring to, I didn't find
> > > > > > > > it.
> > > > > > >
> > > > > > >
> > > > > > > Write 0xffff into vector number.
> > > > > >
> > > > > > I wonder if there is some misunderstanding here.
> > > > > >
> > > > > > My purpose is to release vq, then for the vector used by vq, I hope that it can
> > > > > > be reused when re-enable.
> > > > > >
> > > > > > But the vector number is not in a fixed order. When I re-enable it, I don't know
> > > > > > what the original vector number is. So I found a place to save this number.
> > > > > >
> > > > > > The queue reset I implemented is divided into the following steps:
> > > > > > 	1. notify the driver to queue reset
> > > > > > 	2. disable_irq()
> > > > > > 	3. free unused bufs
> > > > > > 	4. free irq, free vq, free info
> > > >
> > > > step 4 here seems pointless.
> > >
> > >
> > > The core operation is to release the vq. The release of the irq is indeed by the
> > > way. We can leave the irq untouched.
> > >
> > > 	1. notify the driver to queue reset
> > > 	2. disable_irq()
> > > 	3. free unused bufs
> > > 	4. free vq, free info
> > >
> > > Thanks.
> >
> > OK. why free the vq and info though?
> 
> 
> I guess what you mean may be that we do not release the memory of vq, but
> reinitialize it and map it to the backend. In this way, the ring size of vq is
> also unchanged.
> 
> +After the queue has been successfully reset, the driver MAY release any
> +resource associated with that virtqueue.
> 
> [...]
> 
> +
> +\devicenormative{\paragraph}{Virtqueue Re-enable}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
> +
> +The device MUST observe any queue configuration that may have been
> +changed by the driver, like the maximum queue size.
> +
> +\drivernormative{\paragraph}{Virtqueue Re-enable}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
> +
> +When re-enabling a queue, the driver MUST configure the queue resources
> +as during initial virtqueue discovery, but optionally with different
> +parameters.
> +
> 
> Based on the above spec definition, reset can modify, for example, the length of
> the queue.  So I chose to release memory here. Of course, I have not yet
> supported the modification of ring size.
> 
> I wonder if we can provide two methods when implementing queue reset:
> 
> 	1. Lightweight reset, do not release vq memory, re-initialize vq. Then
>        	map to the backend (virtio-net supports AF_XDP, this can be satisfied)
> 	2. Release vq to support modification of ring size. (virtio-net can
> 	modify ring size based on this)
> 
> Thanks.

I'm not sure I understand completely. I guess the simpler the
reset code the better so ... 1 is simpler I guess?

> 
> 
> >
> > > >
> > > > > > The process of enable is divided into the following steps:
> > > > > > 	1. Get the vector number used by the original vq and re-setup vq
> > > > > > 	2. enable vq
> > > > > > 	3. enable irq
> > > > > >
> > > > > > If there is anything unreasonable please let me know.
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > Why do you free irq?
> > > > >
> > > > > > >
> > > > > > > > I think you mean that we don't have to reset the event vector, I think you are
> > > > > > > > right.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > > Avoid doing that, and things will be much easier, with no need
> > > > > > > > > to interact with a transport, won't they?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  drivers/virtio/virtio_pci_common.c | 49 ++++++++++++++++++++
> > > > > > > > > >  drivers/virtio/virtio_pci_common.h |  4 ++
> > > > > > > > > >  drivers/virtio/virtio_pci_modern.c | 73 ++++++++++++++++++++++++++++++
> > > > > > > > > >  3 files changed, 126 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > > > > > index 5afe207ce28a..28b5ffde4621 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > > > > > @@ -464,6 +464,55 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > > > > > >  	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +#define VQ_IS_DELETED(vp_dev, idx) ((unsigned long)vp_dev->vqs[idx] & 1)
> > > > > > > > > > +#define VQ_RESET_MSIX_VEC(vp_dev, idx) ((unsigned long)vp_dev->vqs[idx] >> 2)
> > > > > > > > > > +#define VQ_RESET_MARK(msix_vec) ((void *)(long)((msix_vec << 2) + 1))
> > > > > > > > > > +
> > > > > > > > > > +void vp_del_reset_vq(struct virtio_device *vdev, u16 queue_index)
> > > > > > > > > > +{
> > > > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > > > +	struct virtio_pci_vq_info *info;
> > > > > > > > > > +	u16 msix_vec;
> > > > > > > > > > +
> > > > > > > > > > +	info = vp_dev->vqs[queue_index];
> > > > > > > > > > +
> > > > > > > > > > +	msix_vec = info->msix_vector;
> > > > > > > > > > +
> > > > > > > > > > +	/* delete vq */
> > > > > > > > > > +	vp_del_vq(info->vq);
> > > > > > > > > > +
> > > > > > > > > > +	/* Mark the vq has been deleted, and save the msix_vec. */
> > > > > > > > > > +	vp_dev->vqs[queue_index] = VQ_RESET_MARK(msix_vec);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +struct virtqueue *vp_enable_reset_vq(struct virtio_device *vdev,
> > > > > > > > > > +				     int queue_index,
> > > > > > > > > > +				     vq_callback_t *callback,
> > > > > > > > > > +				     const char *name,
> > > > > > > > > > +				     const bool ctx)
> > > > > > > > > > +{
> > > > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > > > +	struct virtqueue *vq;
> > > > > > > > > > +	u16 msix_vec;
> > > > > > > > > > +
> > > > > > > > > > +	if (!VQ_IS_DELETED(vp_dev, queue_index))
> > > > > > > > > > +		return ERR_PTR(-EPERM);
> > > > > > > > > > +
> > > > > > > > > > +	msix_vec = VQ_RESET_MSIX_VEC(vp_dev, queue_index);
> > > > > > > > > > +
> > > > > > > > > > +	if (vp_dev->intx_enabled)
> > > > > > > > > > +		vq = vp_setup_vq(vdev, queue_index, callback, name, ctx,
> > > > > > > > > > +				 VIRTIO_MSI_NO_VECTOR);
> > > > > > > > > > +	else
> > > > > > > > > > +		vq = vp_enable_vq_msix(vdev, queue_index, callback, name, ctx,
> > > > > > > > > > +				       msix_vec);
> > > > > > > > > > +
> > > > > > > > > > +	if (IS_ERR(vq))
> > > > > > > > > > +		vp_dev->vqs[queue_index] = VQ_RESET_MARK(msix_vec);
> > > > > > > > > > +
> > > > > > > > > > +	return vq;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  const char *vp_bus_name(struct virtio_device *vdev)
> > > > > > > > > >  {
> > > > > > > > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > > > > > index 23f6c5c678d5..96c13b1398f8 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > > > > > @@ -115,6 +115,10 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > > > > > >  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > > > > >  		const char * const names[], const bool *ctx,
> > > > > > > > > >  		struct irq_affinity *desc);
> > > > > > > > > > +void vp_del_reset_vq(struct virtio_device *vdev, u16 queue_index);
> > > > > > > > > > +struct virtqueue *vp_enable_reset_vq(struct virtio_device *vdev, int queue_index,
> > > > > > > > > > +				     vq_callback_t *callback, const char *name,
> > > > > > > > > > +				     const bool ctx);
> > > > > > > > > >  const char *vp_bus_name(struct virtio_device *vdev);
> > > > > > > > > >
> > > > > > > > > >  /* Setup the affinity for a virtqueue:
> > > > > > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > > > index 5455bc041fb6..fbf87239c920 100644
> > > > > > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > > > @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
> > > > > > > > > >  	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> > > > > > > > > >  			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
> > > > > > > > > >  		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> > > > > > > > > > +
> > > > > > > > > > +	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > > > > > > > > > +		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  /* virtio config->finalize_features() implementation */
> > > > > > > > > > @@ -176,6 +179,72 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > > > > > >  	vp_disable_cbs(vdev);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static int vp_modern_reset_vq(struct virtio_device *vdev, u16 queue_index,
> > > > > > > > > > +			      vq_reset_callback_t *callback, void *data)
> > > > > > > > > > +{
> > > > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > > > +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > > > > > > > > > +	struct virtio_pci_vq_info *info;
> > > > > > > > > > +	u16 msix_vec;
> > > > > > > > > > +	void *buf;
> > > > > > > > > > +
> > > > > > > > > > +	if (!virtio_has_feature(vdev, VIRTIO_F_RING_RESET))
> > > > > > > > > > +		return -ENOENT;
> > > > > > > > > > +
> > > > > > > > > > +	vp_modern_set_queue_reset(mdev, queue_index);
> > > > > > > > > > +
> > > > > > > > > > +	/* After write 1 to queue reset, the driver MUST wait for a read of
> > > > > > > > > > +	 * queue reset to return 1.
> > > > > > > > > > +	 */
> > > > > > > > > > +	while (vp_modern_get_queue_reset(mdev, queue_index) != 1)
> > > > > > > > > > +		msleep(1);
> > > > > > > > > > +
> > > > > > > > > > +	info = vp_dev->vqs[queue_index];
> > > > > > > > > > +	msix_vec = info->msix_vector;
> > > > > > > > > > +
> > > > > > > > > > +	/* Disable VQ callback. */
> > > > > > > > > > +	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> > > > > > > > > > +		disable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> > > > > > > > > > +
> > > > > > > > > > +	while ((buf = virtqueue_detach_unused_buf(info->vq)) != NULL)
> > > > > > > > > > +		callback(vdev, buf, data);
> > > > > > > > > > +
> > > > > > > > > > +	vp_del_reset_vq(vdev, queue_index);
> > > > > > > > > > +
> > > > > > > > > > +	return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static struct virtqueue *vp_modern_enable_reset_vq(struct virtio_device *vdev,
> > > > > > > > > > +						   u16 queue_index,
> > > > > > > > > > +						   vq_callback_t *callback,
> > > > > > > > > > +						   const char *name,
> > > > > > > > > > +						   const bool *ctx)
> > > > > > > > > > +{
> > > > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > > > +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > > > > > > > > > +	struct virtqueue *vq;
> > > > > > > > > > +	u16 msix_vec;
> > > > > > > > > > +
> > > > > > > > > > +	if (!virtio_has_feature(vdev, VIRTIO_F_RING_RESET))
> > > > > > > > > > +		return ERR_PTR(-ENOENT);
> > > > > > > > > > +
> > > > > > > > > > +	/* check queue reset status */
> > > > > > > > > > +	if (vp_modern_get_queue_reset(mdev, queue_index) != 1)
> > > > > > > > > > +		return ERR_PTR(-EBUSY);
> > > > > > > > > > +
> > > > > > > > > > +	vq = vp_enable_reset_vq(vdev, queue_index, callback, name, ctx);
> > > > > > > > > > +	if (IS_ERR(vq))
> > > > > > > > > > +		return vq;
> > > > > > > > > > +
> > > > > > > > > > +	vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> > > > > > > > > > +
> > > > > > > > > > +	msix_vec = vp_dev->vqs[queue_index]->msix_vector;
> > > > > > > > > > +	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> > > > > > > > > > +		enable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> > > > > > > > > > +
> > > > > > > > > > +	return vq;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > > > > >  {
> > > > > > > > > >  	return vp_modern_config_vector(&vp_dev->mdev, vector);
> > > > > > > > > > @@ -395,6 +464,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > > > > > >  	.set_vq_affinity = vp_set_vq_affinity,
> > > > > > > > > >  	.get_vq_affinity = vp_get_vq_affinity,
> > > > > > > > > >  	.get_shm_region  = vp_get_shm_region,
> > > > > > > > > > +	.reset_vq	 = vp_modern_reset_vq,
> > > > > > > > > > +	.enable_reset_vq = vp_modern_enable_reset_vq,
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > > > > > @@ -413,6 +484,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > > > > >  	.set_vq_affinity = vp_set_vq_affinity,
> > > > > > > > > >  	.get_vq_affinity = vp_get_vq_affinity,
> > > > > > > > > >  	.get_shm_region  = vp_get_shm_region,
> > > > > > > > > > +	.reset_vq	 = vp_modern_reset_vq,
> > > > > > > > > > +	.enable_reset_vq = vp_modern_enable_reset_vq,
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > >  /* the PCI probing function */
> > > > > > > > > > --
> > > > > > > > > > 2.31.0
> > > > > > > > >
> > > > > > >
> > > >
> >

