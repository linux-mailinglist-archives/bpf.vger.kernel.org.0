Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722D7495FB0
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 14:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350722AbiAUNUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 08:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380682AbiAUNUG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 08:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642771205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LJGqmdjTpB0rnqiYfIJVO5Za8NUvvkBp7Ym5tK7oWw=;
        b=B+Q2Bs4e50IsNG2aLB8ezKiKh/TbaqzpH0vyTdPcUl1bQXMZ6HuslazJWcB1piIsD2S9zf
        SHBxszZh11jNyyUY+wsFu+m2GLz75cKiuFuYrUAzmJ5j63oqGUPrsrRzgWnW6eHlCKYvYU
        bSta6wIqsk/5UydoFfzFX0Rb3FdXEfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-pGQJ4CjuNx68OJmO_xgO7w-1; Fri, 21 Jan 2022 08:20:03 -0500
X-MC-Unique: pGQJ4CjuNx68OJmO_xgO7w-1
Received: by mail-wm1-f69.google.com with SMTP id b134-20020a1c1b8c000000b0034e0874e828so2904916wmb.4
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 05:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7LJGqmdjTpB0rnqiYfIJVO5Za8NUvvkBp7Ym5tK7oWw=;
        b=4+24EFWWHbspgg8xpYr/OHfaKMmlOCofivbcPW4Lu7i03cvNGSGsxEVNKsyAlMWiC0
         97Yk9pbnnVR59CXzz35VQUrCxC6pKZ4hMjhXlJIN/5IV7BuNXqyWxNIkDVJE1aj9SCWj
         FuFZLFQpuobeVfk2al8URoh2QiQ+q7tTwVlJ8qTxUZVoSLvJvwbiQTk/Gdo/ehJ7oV/F
         m8EYsCR3s/PrhN0pWtgzrimrCQRRKjMBgYjNwA6hBl0CN55CiIxyv1c8FxRzbR8Dwii9
         Hv2Dgy/raPC8gjC6mbS+cTrqWgeBRGFWd3boQ3zsdAKxsOOaOzxq0Ukce5OAc9UXJvaV
         M5Gw==
X-Gm-Message-State: AOAM530RajcTbgwwywXPENxu7zX/K/2HynZmQ1SD7s1kQYMecUSySLaI
        tee9ZjVlASOg/QXLL+vTaWInj/qzGMktXXZbiVfqpE5AC8waxzwK/JBfh2vob7DH/uyW5z53Jj9
        xuwRcJ0dA8Ehy
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr4030541wri.695.1642771202403;
        Fri, 21 Jan 2022 05:20:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBPQYiwtMgPEjjuHk8bLiSfx4eJYFREo9YiWJaLoDNlo93tlfPx2PYmc9ZQYHVzZikhKDlPg==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr4030523wri.695.1642771202080;
        Fri, 21 Jan 2022 05:20:02 -0800 (PST)
Received: from redhat.com ([181.214.206.211])
        by smtp.gmail.com with ESMTPSA id w8sm5438081wre.83.2022.01.21.05.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 05:20:00 -0800 (PST)
Date:   Fri, 21 Jan 2022 08:19:55 -0500
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
Message-ID: <20220121081931-mutt-send-email-mst@kernel.org>
References: <20220121052241-mutt-send-email-mst@kernel.org>
 <1642760793.1188169-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642760793.1188169-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 06:26:33PM +0800, Xuan Zhuo wrote:
> On Fri, 21 Jan 2022 05:22:59 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Jan 21, 2022 at 05:22:29AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Jan 21, 2022 at 10:22:59AM +0800, Xuan Zhuo wrote:
> > > > On Thu, 20 Jan 2022 10:03:45 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Thu, Jan 20, 2022 at 07:46:20PM +0800, Xuan Zhuo wrote:
> > > > > > On Thu, 20 Jan 2022 05:55:14 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > On Thu, Jan 20, 2022 at 02:42:58PM +0800, Xuan Zhuo wrote:
> > > > > > > > This patch implements virtio pci support for QUEUE RESET.
> > > > > > > >
> > > > > > > > Performing reset on a queue is divided into two steps:
> > > > > > > >
> > > > > > > > 1. reset_vq: reset one vq
> > > > > > > > 2. enable_reset_vq: re-enable the reset queue
> > > > > > > >
> > > > > > > > In the first step, these tasks will be completed:
> > > > > > > >    1. notify the hardware queue to reset
> > > > > > > >    2. recycle the buffer from vq
> > > > > > > >    3. delete the vq
> > > > > > > >
> > > > > > > > When deleting a vq, vp_del_vq() will be called to release all the memory
> > > > > > > > of the vq. But this does not affect the process of deleting vqs, because
> > > > > > > > that is based on the queue to release all the vqs. During this process,
> > > > > > > > the vq has been removed from the queue.
> > > > > > > >
> > > > > > > > When deleting vq, info and vq will be released, and I save msix_vec in
> > > > > > > > vp_dev->vqs[queue_index]. When re-enable, the current msix_vec can be
> > > > > > > > reused. And based on intx_enabled to determine which method to use to
> > > > > > > > enable this queue.
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > >
> > > > > > > There's something I don't understand here. It looks like
> > > > > > > you assume that when you reset a queue, you also
> > > > > > > reset the mapping from queue to event vector.
> > > > > > > The spec does not say it should, and I don't think it's
> > > > > > > useful to extend spec to do it - we already have a simple
> > > > > > > way to tweak the mapping.
> > > > > > >
> > > > > >
> > > > > > Sorry, what is the already existing method you are referring to, I didn't find
> > > > > > it.
> > > > >
> > > > >
> > > > > Write 0xffff into vector number.
> > > >
> > > > I wonder if there is some misunderstanding here.
> > > >
> > > > My purpose is to release vq, then for the vector used by vq, I hope that it can
> > > > be reused when re-enable.
> > > >
> > > > But the vector number is not in a fixed order. When I re-enable it, I don't know
> > > > what the original vector number is. So I found a place to save this number.
> > > >
> > > > The queue reset I implemented is divided into the following steps:
> > > > 	1. notify the driver to queue reset
> > > > 	2. disable_irq()
> > > > 	3. free unused bufs
> > > > 	4. free irq, free vq, free info
> >
> > step 4 here seems pointless.
> 
> 
> The core operation is to release the vq. The release of the irq is indeed by the
> way. We can leave the irq untouched.
> 
> 	1. notify the driver to queue reset
> 	2. disable_irq()
> 	3. free unused bufs
> 	4. free vq, free info
> 
> Thanks.

OK. why free the vq and info though?

> >
> > > > The process of enable is divided into the following steps:
> > > > 	1. Get the vector number used by the original vq and re-setup vq
> > > > 	2. enable vq
> > > > 	3. enable irq
> > > >
> > > > If there is anything unreasonable please let me know.
> > > >
> > > > Thanks.
> > >
> > > Why do you free irq?
> > >
> > > > >
> > > > > > I think you mean that we don't have to reset the event vector, I think you are
> > > > > > right.
> > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > > Avoid doing that, and things will be much easier, with no need
> > > > > > > to interact with a transport, won't they?
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  drivers/virtio/virtio_pci_common.c | 49 ++++++++++++++++++++
> > > > > > > >  drivers/virtio/virtio_pci_common.h |  4 ++
> > > > > > > >  drivers/virtio/virtio_pci_modern.c | 73 ++++++++++++++++++++++++++++++
> > > > > > > >  3 files changed, 126 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > > > > index 5afe207ce28a..28b5ffde4621 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_common.c
> > > > > > > > +++ b/drivers/virtio/virtio_pci_common.c
> > > > > > > > @@ -464,6 +464,55 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > > > >  	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +#define VQ_IS_DELETED(vp_dev, idx) ((unsigned long)vp_dev->vqs[idx] & 1)
> > > > > > > > +#define VQ_RESET_MSIX_VEC(vp_dev, idx) ((unsigned long)vp_dev->vqs[idx] >> 2)
> > > > > > > > +#define VQ_RESET_MARK(msix_vec) ((void *)(long)((msix_vec << 2) + 1))
> > > > > > > > +
> > > > > > > > +void vp_del_reset_vq(struct virtio_device *vdev, u16 queue_index)
> > > > > > > > +{
> > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > +	struct virtio_pci_vq_info *info;
> > > > > > > > +	u16 msix_vec;
> > > > > > > > +
> > > > > > > > +	info = vp_dev->vqs[queue_index];
> > > > > > > > +
> > > > > > > > +	msix_vec = info->msix_vector;
> > > > > > > > +
> > > > > > > > +	/* delete vq */
> > > > > > > > +	vp_del_vq(info->vq);
> > > > > > > > +
> > > > > > > > +	/* Mark the vq has been deleted, and save the msix_vec. */
> > > > > > > > +	vp_dev->vqs[queue_index] = VQ_RESET_MARK(msix_vec);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +struct virtqueue *vp_enable_reset_vq(struct virtio_device *vdev,
> > > > > > > > +				     int queue_index,
> > > > > > > > +				     vq_callback_t *callback,
> > > > > > > > +				     const char *name,
> > > > > > > > +				     const bool ctx)
> > > > > > > > +{
> > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > +	struct virtqueue *vq;
> > > > > > > > +	u16 msix_vec;
> > > > > > > > +
> > > > > > > > +	if (!VQ_IS_DELETED(vp_dev, queue_index))
> > > > > > > > +		return ERR_PTR(-EPERM);
> > > > > > > > +
> > > > > > > > +	msix_vec = VQ_RESET_MSIX_VEC(vp_dev, queue_index);
> > > > > > > > +
> > > > > > > > +	if (vp_dev->intx_enabled)
> > > > > > > > +		vq = vp_setup_vq(vdev, queue_index, callback, name, ctx,
> > > > > > > > +				 VIRTIO_MSI_NO_VECTOR);
> > > > > > > > +	else
> > > > > > > > +		vq = vp_enable_vq_msix(vdev, queue_index, callback, name, ctx,
> > > > > > > > +				       msix_vec);
> > > > > > > > +
> > > > > > > > +	if (IS_ERR(vq))
> > > > > > > > +		vp_dev->vqs[queue_index] = VQ_RESET_MARK(msix_vec);
> > > > > > > > +
> > > > > > > > +	return vq;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  const char *vp_bus_name(struct virtio_device *vdev)
> > > > > > > >  {
> > > > > > > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > > > > > > > index 23f6c5c678d5..96c13b1398f8 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_common.h
> > > > > > > > +++ b/drivers/virtio/virtio_pci_common.h
> > > > > > > > @@ -115,6 +115,10 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > > > > >  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > > > > >  		const char * const names[], const bool *ctx,
> > > > > > > >  		struct irq_affinity *desc);
> > > > > > > > +void vp_del_reset_vq(struct virtio_device *vdev, u16 queue_index);
> > > > > > > > +struct virtqueue *vp_enable_reset_vq(struct virtio_device *vdev, int queue_index,
> > > > > > > > +				     vq_callback_t *callback, const char *name,
> > > > > > > > +				     const bool ctx);
> > > > > > > >  const char *vp_bus_name(struct virtio_device *vdev);
> > > > > > > >
> > > > > > > >  /* Setup the affinity for a virtqueue:
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > index 5455bc041fb6..fbf87239c920 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
> > > > > > > >  	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> > > > > > > >  			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
> > > > > > > >  		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> > > > > > > > +
> > > > > > > > +	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > > > > > > > +		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  /* virtio config->finalize_features() implementation */
> > > > > > > > @@ -176,6 +179,72 @@ static void vp_reset(struct virtio_device *vdev)
> > > > > > > >  	vp_disable_cbs(vdev);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int vp_modern_reset_vq(struct virtio_device *vdev, u16 queue_index,
> > > > > > > > +			      vq_reset_callback_t *callback, void *data)
> > > > > > > > +{
> > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > > > > > > > +	struct virtio_pci_vq_info *info;
> > > > > > > > +	u16 msix_vec;
> > > > > > > > +	void *buf;
> > > > > > > > +
> > > > > > > > +	if (!virtio_has_feature(vdev, VIRTIO_F_RING_RESET))
> > > > > > > > +		return -ENOENT;
> > > > > > > > +
> > > > > > > > +	vp_modern_set_queue_reset(mdev, queue_index);
> > > > > > > > +
> > > > > > > > +	/* After write 1 to queue reset, the driver MUST wait for a read of
> > > > > > > > +	 * queue reset to return 1.
> > > > > > > > +	 */
> > > > > > > > +	while (vp_modern_get_queue_reset(mdev, queue_index) != 1)
> > > > > > > > +		msleep(1);
> > > > > > > > +
> > > > > > > > +	info = vp_dev->vqs[queue_index];
> > > > > > > > +	msix_vec = info->msix_vector;
> > > > > > > > +
> > > > > > > > +	/* Disable VQ callback. */
> > > > > > > > +	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> > > > > > > > +		disable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> > > > > > > > +
> > > > > > > > +	while ((buf = virtqueue_detach_unused_buf(info->vq)) != NULL)
> > > > > > > > +		callback(vdev, buf, data);
> > > > > > > > +
> > > > > > > > +	vp_del_reset_vq(vdev, queue_index);
> > > > > > > > +
> > > > > > > > +	return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static struct virtqueue *vp_modern_enable_reset_vq(struct virtio_device *vdev,
> > > > > > > > +						   u16 queue_index,
> > > > > > > > +						   vq_callback_t *callback,
> > > > > > > > +						   const char *name,
> > > > > > > > +						   const bool *ctx)
> > > > > > > > +{
> > > > > > > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > > > > +	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> > > > > > > > +	struct virtqueue *vq;
> > > > > > > > +	u16 msix_vec;
> > > > > > > > +
> > > > > > > > +	if (!virtio_has_feature(vdev, VIRTIO_F_RING_RESET))
> > > > > > > > +		return ERR_PTR(-ENOENT);
> > > > > > > > +
> > > > > > > > +	/* check queue reset status */
> > > > > > > > +	if (vp_modern_get_queue_reset(mdev, queue_index) != 1)
> > > > > > > > +		return ERR_PTR(-EBUSY);
> > > > > > > > +
> > > > > > > > +	vq = vp_enable_reset_vq(vdev, queue_index, callback, name, ctx);
> > > > > > > > +	if (IS_ERR(vq))
> > > > > > > > +		return vq;
> > > > > > > > +
> > > > > > > > +	vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
> > > > > > > > +
> > > > > > > > +	msix_vec = vp_dev->vqs[queue_index]->msix_vector;
> > > > > > > > +	if (vp_dev->per_vq_vectors && msix_vec != VIRTIO_MSI_NO_VECTOR)
> > > > > > > > +		enable_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec));
> > > > > > > > +
> > > > > > > > +	return vq;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> > > > > > > >  {
> > > > > > > >  	return vp_modern_config_vector(&vp_dev->mdev, vector);
> > > > > > > > @@ -395,6 +464,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > > > > > > >  	.set_vq_affinity = vp_set_vq_affinity,
> > > > > > > >  	.get_vq_affinity = vp_get_vq_affinity,
> > > > > > > >  	.get_shm_region  = vp_get_shm_region,
> > > > > > > > +	.reset_vq	 = vp_modern_reset_vq,
> > > > > > > > +	.enable_reset_vq = vp_modern_enable_reset_vq,
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > > > @@ -413,6 +484,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
> > > > > > > >  	.set_vq_affinity = vp_set_vq_affinity,
> > > > > > > >  	.get_vq_affinity = vp_get_vq_affinity,
> > > > > > > >  	.get_shm_region  = vp_get_shm_region,
> > > > > > > > +	.reset_vq	 = vp_modern_reset_vq,
> > > > > > > > +	.enable_reset_vq = vp_modern_enable_reset_vq,
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  /* the PCI probing function */
> > > > > > > > --
> > > > > > > > 2.31.0
> > > > > > >
> > > > >
> >

