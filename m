Return-Path: <bpf+bounces-39699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E99976337
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F0928383E
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3318C92D;
	Thu, 12 Sep 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mtATTw89"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38215C3;
	Thu, 12 Sep 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127162; cv=none; b=P8uLr44PjEK1tTA5w5x68Gk0zaqnIy6QcpdQaz5hU7LnLvUntBbP6AH2w8S19uzqNHeWxj5U8GemHv0uCj+X0rYq7KH/E3SRA1kxyZhHJGTj2r5ZB8VNuIZDuLniqppTP4YJZ+tGefgYL+76VfZ7u2JmZd5oz+i6cZPAnpa7Vas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127162; c=relaxed/simple;
	bh=gxixtiXWhXKrK6lRYUR6BtWH4pwbLNWKx4gI8/Q6X/w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Ov7B5E8SVgvIaUGzN1s/qKBXDISEfN1whWT4J91BVc84gy5Nrrs3WluvHIjluP51yGsex1yDLf8wXwMZCAZ41YqrhJ2m9YV5ya4etXDMpvBDCNMSlJcb805mj9C9hDTz0RLlR8c62l33OrWuY8bCclp9HXxjZwWZ4Kc9w79o/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mtATTw89; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726127157; h=Message-ID:Subject:Date:From:To;
	bh=t48v7BDcLuiIfdxjk6XqmMjp9eUrfEzCF1KkgXR9eUA=;
	b=mtATTw89vMmSK6W5KgjhxoKTfsXJuGDwPpcpS3g9ibJeTIPM34+HgYQ75ByLfKY/nhgIc/xc/GOL/Gfa8JHeNoTtY3sU10istMRd/DvgY7oQzb8eB38/Vz9F//8/ajxIz0pXX0oEH+gM7BjPqINA5arh2LBERffunMB52sxryAQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqckP1_1726127156)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:45:57 +0800
Message-ID: <1726126994.8755774-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 03/13] virtio_ring: packed: harden dma unmap for indirect
Date: Thu, 12 Sep 2024 15:43:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
 <20240911072537-mutt-send-email-mst@kernel.org>
 <1726124138.2346847-1-xuanzhuo@linux.alibaba.com>
 <20240912030013-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240912030013-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 12 Sep 2024 03:38:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Sep 12, 2024 at 02:55:38PM +0800, Xuan Zhuo wrote:
> > On Wed, 11 Sep 2024 07:28:36 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > As gcc luckily noted:
> > >
> > > On Tue, Aug 20, 2024 at 03:33:20PM +0800, Xuan Zhuo wrote:
> > > > @@ -1617,23 +1617,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> > > >  	}
> > > >
> > > >  	if (vq->indirect) {
> > > > +		struct vring_desc_extra *extra;
> > > >  		u32 len;
> > > >
> > > >  		/* Free the indirect table, if any, now that it's unmapped. */
> > > > -		desc = state->indir_desc;
> > > > -		if (!desc)
> > >
> > > desc is no longer initialized here
> >
> >
> > Will fix.
> >
> >
> > >
> > > > +		extra = state->indir;
> > > > +		if (!extra)
> > > >  			return;
> > > >
> > > >  		if (vring_need_unmap_buffer(vq)) {
> > > >  			len = vq->packed.desc_extra[id].len;
> > > >  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
> > > >  					i++)
> > > > -				vring_unmap_desc_packed(vq, &desc[i]);
> > > > +				vring_unmap_extra_packed(vq, &extra[i]);
> > > >  		}
> > > >  		kfree(desc);
> > >
> > >
> > > but freed here
> > >
> > > > -		state->indir_desc = NULL;
> > > > +		state->indir = NULL;
> > > >  	} else if (ctx) {
> > > > -		*ctx = state->indir_desc;
> > > > +		*ctx = state->indir;
> > > >  	}
> > > >  }
> > >
> > >
> > > It seems unlikely this was always 0 on all paths with even
> > > a small amount of stress, so now I question how this was tested.
> > > Besides, do not ignore compiler warnings, and do not tweak code
> > > to just make compiler shut up - they are your friend.
> >
> > I agree.
> >
> > Normally I do this by make W=12, but we have too many message,
> > so I missed this.
> >
> > 	make W=12 drivers/net/virtio_net.o drivers/virtio/virtio_ring.o
> >
> > If not W=12, then I did not get any warning message.
> > How do you get the message quickly?
> >
> > Thanks.
>
>
> If you stress test this for a long enough time, and with
> debug enabled, you will see a crash.

I only stress tested the split ring. For the packed ring, I
just performed a simple verification.

I will street test for two mode in next version.

Thanks.



>
>
> > >
> > > >
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
>

