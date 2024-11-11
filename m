Return-Path: <bpf+bounces-44496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A829C3731
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 04:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0C7B20D1F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 03:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DF013B7A3;
	Mon, 11 Nov 2024 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UAJPcwyt"
X-Original-To: bpf@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F71184F;
	Mon, 11 Nov 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297206; cv=none; b=gzI1Wcy2QcVyJ2HDz8tTHnd51QnLAts7heg8hA/vDEoslEw4RypgK60dlpwFW7ObxdVuaDrCYsiU60Zr+sxBNJnuBg4r9EkPSqqpqoaMcSpLJ9+3KLtdy5R5q+MmMurKqiKmWLhh5J6yK/AZBUZL30TKjlz4upfg5m0KOEtvJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297206; c=relaxed/simple;
	bh=MXP4MxR6uhD+Ii9oT9Dgn40/1r74AbUSf+e55oRH7Z4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=PbcQcaT4150TEGzBiZOp//yiBwyzwNIzvT8kBTlUHa1gxqQ3Ug4RxtzgkIKipguXe2x1GLYaA9Cn+FxeDKPZDlxU/Bz0PaGSv6MTYBuoYr3+fG/F0gWII9jvLv5z3yWUF3mK1uV7BbkiD4GOgtGA1wmmFnJoPIeE74YwB8W7wLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UAJPcwyt; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731297193; h=Message-ID:Subject:Date:From:To;
	bh=Zru2MKPBj3bdPD1mWHlnrAibhlLUG/ytSzXYA4plMeM=;
	b=UAJPcwytyz/HahmZ3qveEIgTNedt6SUEn8qG7sQXGmgERooWErsGLXNqKuAazueyXH1CCPXGCsO/SmskS2Fbvq1tnY+4Z0jaGMPw8RiS+goQHPPVt246IlQWMhscxpQZAP3JrJXe+/ZGsn7IEUVJpuZCxWD2eCqin2Xf0vi/O6Y=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WJ4PoeW_1731297191 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 11:53:12 +0800
Message-ID: <1731293994.9676225-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 03/13] virtio_ring: packed: record extras for indirect buffers
Date: Mon, 11 Nov 2024 10:59:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
 <20241107085504.63131-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu,  7 Nov 2024 16:54:54 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> The subsequent commit needs to know whether every indirect buffer is
> premapped or not. So we need to introduce an extra struct for every
> indirect buffer to record this info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Hi, Jason

This also needs a review.

Thanks.


> ---
>  drivers/virtio/virtio_ring.c | 60 +++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 405d5a348795..cfe70c40f630 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -78,7 +78,11 @@ struct vring_desc_state_split {
>
>  struct vring_desc_state_packed {
>  	void *data;			/* Data for callback. */
> -	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +
> +	/* Indirect desc table and extra table, if any. These two will be
> +	 * allocated together. So we won't stress more to the memory allocator.
> +	 */
> +	struct vring_packed_desc *indir_desc;
>  	u16 num;			/* Descriptor list length. */
>  	u16 last;			/* The last desc state in a list. */
>  };
> @@ -1238,27 +1242,12 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  	}
>  }
>
> -static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -				    const struct vring_packed_desc *desc)
> -{
> -	u16 flags;
> -
> -	if (!vring_need_unmap_buffer(vq))
> -		return;
> -
> -	flags = le16_to_cpu(desc->flags);
> -
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       le64_to_cpu(desc->addr),
> -		       le32_to_cpu(desc->len),
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -}
> -
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
>  						       gfp_t gfp)
>  {
> +	struct vring_desc_extra *extra;
>  	struct vring_packed_desc *desc;
> +	int i, size;
>
>  	/*
>  	 * We require lowmem mappings for the descriptors because
> @@ -1267,7 +1256,16 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
>  	 */
>  	gfp &= ~__GFP_HIGHMEM;
>
> -	desc = kmalloc_array(total_sg, sizeof(struct vring_packed_desc), gfp);
> +	size = (sizeof(*desc) + sizeof(*extra)) * total_sg;
> +
> +	desc = kmalloc(size, gfp);
> +	if (!desc)
> +		return NULL;
> +
> +	extra = (struct vring_desc_extra *)&desc[total_sg];
> +
> +	for (i = 0; i < total_sg; i++)
> +		extra[i].next = i + 1;
>
>  	return desc;
>  }
> @@ -1280,6 +1278,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  					 void *data,
>  					 gfp_t gfp)
>  {
> +	struct vring_desc_extra *extra;
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, err_idx;
> @@ -1291,6 +1290,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	if (!desc)
>  		return -ENOMEM;
>
> +	extra = (struct vring_desc_extra *)&desc[total_sg];
> +
>  	if (unlikely(vq->vq.num_free < 1)) {
>  		pr_debug("Can't add buf len 1 - avail = 0\n");
>  		kfree(desc);
> @@ -1312,6 +1313,13 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  						0 : VRING_DESC_F_WRITE);
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
> +
> +			if (unlikely(vq->use_dma_api)) {
> +				extra[i].addr = addr;
> +				extra[i].len = sg->length;
> +				extra[i].flags = n < out_sgs ?  0 : VRING_DESC_F_WRITE;
> +			}
> +
>  			i++;
>  		}
>  	}
> @@ -1381,7 +1389,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	err_idx = i;
>
>  	for (i = 0; i < err_idx; i++)
> -		vring_unmap_desc_packed(vq, &desc[i]);
> +		vring_unmap_extra_packed(vq, &extra[i]);
>
>  free_desc:
>  	kfree(desc);
> @@ -1617,7 +1625,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	}
>
>  	if (vq->indirect) {
> -		u32 len;
> +		struct vring_desc_extra *extra;
> +		u32 len, num;
>
>  		/* Free the indirect table, if any, now that it's unmapped. */
>  		desc = state->indir_desc;
> @@ -1626,9 +1635,12 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>
>  		if (vring_need_unmap_buffer(vq)) {
>  			len = vq->packed.desc_extra[id].len;
> -			for (i = 0; i < len / sizeof(struct vring_packed_desc);
> -					i++)
> -				vring_unmap_desc_packed(vq, &desc[i]);
> +			num = len / sizeof(struct vring_packed_desc);
> +
> +			extra = (struct vring_desc_extra *)&desc[num];
> +
> +			for (i = 0; i < num; i++)
> +				vring_unmap_extra_packed(vq, &extra[i]);
>  		}
>  		kfree(desc);
>  		state->indir_desc = NULL;
> --
> 2.32.0.3.g01195cf9f
>

