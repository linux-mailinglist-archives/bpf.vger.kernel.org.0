Return-Path: <bpf+bounces-5271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808E5759216
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3622D2816B8
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184A125DB;
	Wed, 19 Jul 2023 09:52:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD078125A3
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:52:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE641FC8
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689760320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXN9LaD3rbur1DTqm3b/CbguYy4o0OqNvKWaFC3GLPM=;
	b=gO/f/v+E+HTdEOosFTCVw/RT2KFsYXPKr/evAbxZTSglNvBnT5XVYwu7kMkXJFig1JWFRU
	8/w65VUkP0M/bk4GqVXr2vFy+DPqO5gb+uTR8WD5gUWDMV5AmAAk5UBZnGZnr7UssNmFvq
	tcWVbvBCgWwk5LZZc9bk1kAqg1ctnt0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-4OPZtOUSPeG5gcuITrSfhg-1; Wed, 19 Jul 2023 05:51:57 -0400
X-MC-Unique: 4OPZtOUSPeG5gcuITrSfhg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314326f6e23so3729978f8f.2
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689760316; x=1692352316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXN9LaD3rbur1DTqm3b/CbguYy4o0OqNvKWaFC3GLPM=;
        b=I7MuSTJ1/VIx2Bgwzhjqk3HAJinpjDl0cjBf2mjPJnYLpGa9pDJO5/yAz1oyvfXPuH
         lAAzJCAzIyiKv7vXwI123KsWLThmgYVyA9biaEiD3RHt4RWV9B1alUk0IVb+KnGLHBxN
         3EWfSNHl3s/RSP5qQlCgTxachtcE6k80I9/abpP8sVxr/9iUUdhgBZvC0q+H83S+D/lQ
         LdHj3GzFooxj+2Mc/1dJPMi2+2c7kqtttd0/EDTOn2RAMjLBgW/0ZHH8vwdqaccVEj6c
         hnDk8VgvEJCB6YVYIF2TmmJDAkPQoIUI1Eiyl5KgMKgf1UAgdhJvS2oYtOAnsQjwlUeP
         Em0A==
X-Gm-Message-State: ABy/qLbkE/T9or709CO3dHL2XIhfqCU5GV0S7bBd9AmBFf2YkPQ+guia
	VzW5kaQ0PnncmSuzqEsRa7EO0POEYkYXdsd/pq2M7+kp/j5lp8sk31RcNOUwrPiNoTIuI93dkCI
	cyR94Jw+jt3Qe
X-Received: by 2002:adf:ec11:0:b0:311:180d:cf38 with SMTP id x17-20020adfec11000000b00311180dcf38mr12341644wrn.24.1689760316189;
        Wed, 19 Jul 2023 02:51:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJQ6AU2UNQnXCLuIv4s4CFici5VZT3z5TZg0V8Yhd1HBsG3QzAfPi8LNpSoBlUFSMookNX6A==
X-Received: by 2002:adf:ec11:0:b0:311:180d:cf38 with SMTP id x17-20020adfec11000000b00311180dcf38mr12341622wrn.24.1689760315656;
        Wed, 19 Jul 2023 02:51:55 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id t7-20020a5d6a47000000b00316fc844be7sm4846093wrw.36.2023.07.19.02.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:51:54 -0700 (PDT)
Date: Wed, 19 Jul 2023 05:51:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one
 page
Message-ID: <20230719054630-mutt-send-email-mst@kernel.org>
References: <1689043238.4362252-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvT+o4kHSMY5_8PXFMGP3YEJkmLe3fuZ2GuektTmtLE5A@mail.gmail.com>
 <1689148498.6023948-1-xuanzhuo@linux.alibaba.com>
 <1689150730.075546-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEu3MmM7uVToP5+gUtCKHhyn8kkSLeM-k8Fo7hLQESn8hw@mail.gmail.com>
 <1689151104.6567523-5-xuanzhuo@linux.alibaba.com>
 <20230714063606-mutt-send-email-mst@kernel.org>
 <1689736867.7075129-1-xuanzhuo@linux.alibaba.com>
 <20230719045251-mutt-send-email-mst@kernel.org>
 <CACGkMEtyXni=Kvk_AW+iwReAnxLjxiQexaT9AGL1fgb24SmTtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtyXni=Kvk_AW+iwReAnxLjxiQexaT9AGL1fgb24SmTtg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:38:56PM +0800, Jason Wang wrote:
> On Wed, Jul 19, 2023 at 4:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jul 19, 2023 at 11:21:07AM +0800, Xuan Zhuo wrote:
> > > On Fri, 14 Jul 2023 06:37:10 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Wed, Jul 12, 2023 at 04:38:24PM +0800, Xuan Zhuo wrote:
> > > > > On Wed, 12 Jul 2023 16:37:43 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > On Wed, Jul 12, 2023 at 4:33 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Wed, 12 Jul 2023 15:54:58 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > On Tue, 11 Jul 2023 10:58:51 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > On Tue, Jul 11, 2023 at 10:42 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, 11 Jul 2023 10:36:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > > > On Mon, Jul 10, 2023 at 8:41 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, 10 Jul 2023 07:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > > > > > > On Mon, Jul 10, 2023 at 06:18:30PM +0800, Xuan Zhuo wrote:
> > > > > > > > > > > > > > On Mon, 10 Jul 2023 05:40:21 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > > > > > > > > > On Mon, Jul 10, 2023 at 11:42:37AM +0800, Xuan Zhuo wrote:
> > > > > > > > > > > > > > > > Currently, the virtio core will perform a dma operation for each
> > > > > > > > > > > > > > > > operation. Although, the same page may be operated multiple times.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The driver does the dma operation and manages the dma address based the
> > > > > > > > > > > > > > > > feature premapped of virtio core.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This way, we can perform only one dma operation for the same page. In
> > > > > > > > > > > > > > > > the case of mtu 1500, this can reduce a lot of dma operations.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Tested on Aliyun g7.4large machine, in the case of a cpu 100%, pps
> > > > > > > > > > > > > > > > increased from 1893766 to 1901105. An increase of 0.4%.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > what kind of dma was there? an IOMMU? which vendors? in which mode
> > > > > > > > > > > > > > > of operation?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Do you mean this:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > [    0.470816] iommu: Default domain type: Passthrough
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > With passthrough, dma API is just some indirect function calls, they do
> > > > > > > > > > > > > not affect the performance a lot.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, this benefit is worthless. I seem to have done a meaningless thing. The
> > > > > > > > > > > > overhead of DMA I observed is indeed not too high.
> > > > > > > > > > >
> > > > > > > > > > > Have you measured with iommu=strict?
> > > > > > > > > >
> > > > > > > > > > I have not tested this way, our environment is pt, I wonder if strict is a
> > > > > > > > > > common scenario. I can test it.
> > > > > > > > >
> > > > > > > > > It's not a common setup, but it's a way to stress DMA layer to see the overhead.
> > > > > > > >
> > > > > > > > kernel command line: intel_iommu=on iommu.strict=1 iommu.passthrough=0
> > > > > > > >
> > > > > > > > virtio-net without merge dma 428614.00 pps
> > > > > > > >
> > > > > > > > virtio-net with merge dma    742853.00 pps
> > > > > > >
> > > > > > >
> > > > > > > kernel command line: intel_iommu=on iommu.strict=0 iommu.passthrough=0
> > > > > > >
> > > > > > > virtio-net without merge dma 775496.00 pps
> > > > > > >
> > > > > > > virtio-net with merge dma    1010514.00 pps
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > Great, let's add those numbers to the changelog.
> > > > >
> > > > >
> > > > > Yes, I will do it in next version.
> > > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > You should also test without iommu but with swiotlb=force
> > >
> > >
> > > For swiotlb, merge DMA has no benefit, because we still need to copy data from
> > > swiotlb buffer to the origin buffer.
> > > The benefit of the merge DMA is to reduce the operate to the iommu device.
> > >
> > > I did some test for this. The result is same.
> > >
> > > Thanks.
> > >
> >
> > Did you actually check that it works though?
> > Looks like with swiotlb you need to synch to trigger a copy
> > before unmap, and I don't see where it's done in the current
> > patch.
> 
> And this is needed for XDP_REDIRECT as well.
> 
> Thanks

And once you do, you'll do the copy twice so it will
actually be slower.

I suspect you need to sync manually then unmap with DMA_ATTR_SKIP_CPU_SYNC.

> >
> >
> > >
> > > >
> > > > But first fix the use of DMA API to actually be correct,
> > > > otherwise you are cheating by avoiding synchronization.
> > > >
> > > >
> > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Try e.g. bounce buffer. Which is where you will see a problem: your
> > > > > > > > > > > > > patches won't work.
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > This kind of difference is likely in the noise.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > It's really not high, but this is because the proportion of DMA under perf top
> > > > > > > > > > > > > > is not high. Probably that much.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So maybe not worth the complexity.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > >  drivers/net/virtio_net.c | 283 ++++++++++++++++++++++++++++++++++++---
> > > > > > > > > > > > > > > >  1 file changed, 267 insertions(+), 16 deletions(-)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > > > > > > > > > index 486b5849033d..4de845d35bed 100644
> > > > > > > > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > > > > > > > @@ -126,6 +126,27 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> > > > > > > > > > > > > > > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
> > > > > > > > > > > > > > > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +/* The bufs on the same page may share this struct. */
> > > > > > > > > > > > > > > > +struct virtnet_rq_dma {
> > > > > > > > > > > > > > > > +       struct virtnet_rq_dma *next;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       dma_addr_t addr;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > > +       u32 len;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       u32 ref;
> > > > > > > > > > > > > > > > +};
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +/* Record the dma and buf. */
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I guess I see that. But why?
> > > > > > > > > > > > > > > And these two comments are the extent of the available
> > > > > > > > > > > > > > > documentation, that's not enough I feel.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +struct virtnet_rq_data {
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *next;
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Is manually reimplementing a linked list the best
> > > > > > > > > > > > > > > we can do?
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, we can use llist.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma;
> > > > > > > > > > > > > > > > +};
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > >  /* Internal representation of a send virtqueue */
> > > > > > > > > > > > > > > >  struct send_queue {
> > > > > > > > > > > > > > > >         /* Virtqueue associated with this send _queue */
> > > > > > > > > > > > > > > > @@ -175,6 +196,13 @@ struct receive_queue {
> > > > > > > > > > > > > > > >         char name[16];
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >         struct xdp_rxq_info xdp_rxq;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *data_array;
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *data_free;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma_array;
> > > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma_free;
> > > > > > > > > > > > > > > > +       struct virtnet_rq_dma *last_dma;
> > > > > > > > > > > > > > > >  };
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >  /* This structure can contain rss message with maximum settings for indirection table and keysize
> > > > > > > > > > > > > > > > @@ -549,6 +577,176 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > > > > > > > > > > > > > > >         return skb;
> > > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +static void virtnet_rq_unmap(struct receive_queue *rq, struct virtnet_rq_dma *dma)
> > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > +       struct device *dev;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       --dma->ref;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       if (dma->ref)
> > > > > > > > > > > > > > > > +               return;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If you don't unmap there is no guarantee valid data will be
> > > > > > > > > > > > > > > there in the buffer.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +       dev = virtqueue_dma_dev(rq->vq);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       dma_unmap_page(dev, dma->addr, dma->len, DMA_FROM_DEVICE);
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       dma->next = rq->dma_free;
> > > > > > > > > > > > > > > > +       rq->dma_free = dma;
> > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static void *virtnet_rq_recycle_data(struct receive_queue *rq,
> > > > > > > > > > > > > > > > +                                    struct virtnet_rq_data *data)
> > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       buf = data->buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       data->next = rq->data_free;
> > > > > > > > > > > > > > > > +       rq->data_free = data;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return buf;
> > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static struct virtnet_rq_data *virtnet_rq_get_data(struct receive_queue *rq,
> > > > > > > > > > > > > > > > +                                                  void *buf,
> > > > > > > > > > > > > > > > +                                                  struct virtnet_rq_dma *dma)
> > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       data = rq->data_free;
> > > > > > > > > > > > > > > > +       rq->data_free = data->next;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       data->buf = buf;
> > > > > > > > > > > > > > > > +       data->dma = dma;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return data;
> > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > > > > > > > > > > > > > +       if (!buf || !rq->data_array)
> > > > > > > > > > > > > > > > +               return buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       data = buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return virtnet_rq_recycle_data(rq, data);
> > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
> > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > > +       void *buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       buf = virtqueue_detach_unused_buf(rq->vq);
> > > > > > > > > > > > > > > > +       if (!buf || !rq->data_array)
> > > > > > > > > > > > > > > > +               return buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       data = buf;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return virtnet_rq_recycle_data(rq, data);
> > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static int virtnet_rq_map_sg(struct receive_queue *rq, void *buf, u32 len)
> > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > +       struct virtnet_rq_dma *dma = rq->last_dma;
> > > > > > > > > > > > > > > > +       struct device *dev;
> > > > > > > > > > > > > > > > +       u32 off, map_len;
> > > > > > > > > > > > > > > > +       dma_addr_t addr;
> > > > > > > > > > > > > > > > +       void *end;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       if (likely(dma) && buf >= dma->buf && (buf + len <= dma->buf + dma->len)) {
> > > > > > > > > > > > > > > > +               ++dma->ref;
> > > > > > > > > > > > > > > > +               addr = dma->addr + (buf - dma->buf);
> > > > > > > > > > > > > > > > +               goto ok;
> > > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So this is the meat of the proposed optimization. I guess that
> > > > > > > > > > > > > > > if the last buffer we allocated happens to be in the same page
> > > > > > > > > > > > > > > as this one then they can both be mapped for DMA together.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Since we use page_frag, the buffers we allocated are all continuous.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Why last one specifically? Whether next one happens to
> > > > > > > > > > > > > > > be close depends on luck. If you want to try optimizing this
> > > > > > > > > > > > > > > the right thing to do is likely by using a page pool.
> > > > > > > > > > > > > > > There's actually work upstream on page pool, look it up.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > As we discussed in another thread, the page pool is first used for xdp. Let's
> > > > > > > > > > > > > > transform it step by step.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > >
> > > > > > > > > > > > > ok so this should wait then?
> > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       end = buf + len - 1;
> > > > > > > > > > > > > > > > +       off = offset_in_page(end);
> > > > > > > > > > > > > > > > +       map_len = len + PAGE_SIZE - off;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       dev = virtqueue_dma_dev(rq->vq);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       addr = dma_map_page_attrs(dev, virt_to_page(buf), offset_in_page(buf),
> > > > > > > > > > > > > > > > +                                 map_len, DMA_FROM_DEVICE, 0);
> > > > > > > > > > > > > > > > +       if (addr == DMA_MAPPING_ERROR)
> > > > > > > > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       dma = rq->dma_free;
> > > > > > > > > > > > > > > > +       rq->dma_free = dma->next;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       dma->ref = 1;
> > > > > > > > > > > > > > > > +       dma->buf = buf;
> > > > > > > > > > > > > > > > +       dma->addr = addr;
> > > > > > > > > > > > > > > > +       dma->len = map_len;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       rq->last_dma = dma;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +ok:
> > > > > > > > > > > > > > > > +       sg_init_table(rq->sg, 1);
> > > > > > > > > > > > > > > > +       rq->sg[0].dma_address = addr;
> > > > > > > > > > > > > > > > +       rq->sg[0].length = len;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +static int virtnet_rq_merge_map_init(struct virtnet_info *vi)
> > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > +       struct receive_queue *rq;
> > > > > > > > > > > > > > > > +       int i, err, j, num;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       /* disable for big mode */
> > > > > > > > > > > > > > > > +       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > > > > > > > > > > > > > +               return 0;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > > > > > > > > > > > > +               err = virtqueue_set_premapped(vi->rq[i].vq);
> > > > > > > > > > > > > > > > +               if (err)
> > > > > > > > > > > > > > > > +                       continue;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               rq = &vi->rq[i];
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               num = virtqueue_get_vring_size(rq->vq);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               rq->data_array = kmalloc_array(num, sizeof(*rq->data_array), GFP_KERNEL);
> > > > > > > > > > > > > > > > +               if (!rq->data_array)
> > > > > > > > > > > > > > > > +                       goto err;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               rq->dma_array = kmalloc_array(num, sizeof(*rq->dma_array), GFP_KERNEL);
> > > > > > > > > > > > > > > > +               if (!rq->dma_array)
> > > > > > > > > > > > > > > > +                       goto err;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               for (j = 0; j < num; ++j) {
> > > > > > > > > > > > > > > > +                       rq->data_array[j].next = rq->data_free;
> > > > > > > > > > > > > > > > +                       rq->data_free = &rq->data_array[j];
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +                       rq->dma_array[j].next = rq->dma_free;
> > > > > > > > > > > > > > > > +                       rq->dma_free = &rq->dma_array[j];
> > > > > > > > > > > > > > > > +               }
> > > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +err:
> > > > > > > > > > > > > > > > +       for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > > > > > > > > > > > > +               struct receive_queue *rq;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               rq = &vi->rq[i];
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               kfree(rq->dma_array);
> > > > > > > > > > > > > > > > +               kfree(rq->data_array);
> > > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return -ENOMEM;
> > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > >  static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> > > > > > > > > > > > > > > >  {
> > > > > > > > > > > > > > > >         unsigned int len;
> > > > > > > > > > > > > > > > @@ -835,7 +1033,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
> > > > > > > > > > > > > > > >                 void *buf;
> > > > > > > > > > > > > > > >                 int off;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -               buf = virtqueue_get_buf(rq->vq, &buflen);
> > > > > > > > > > > > > > > > +               buf = virtnet_rq_get_buf(rq, &buflen, NULL);
> > > > > > > > > > > > > > > >                 if (unlikely(!buf))
> > > > > > > > > > > > > > > >                         goto err_buf;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > @@ -1126,7 +1324,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
> > > > > > > > > > > > > > > >                 return -EINVAL;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >         while (--*num_buf > 0) {
> > > > > > > > > > > > > > > > -               buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
> > > > > > > > > > > > > > > > +               buf = virtnet_rq_get_buf(rq, &len, &ctx);
> > > > > > > > > > > > > > > >                 if (unlikely(!buf)) {
> > > > > > > > > > > > > > > >                         pr_debug("%s: rx error: %d buffers out of %d missing\n",
> > > > > > > > > > > > > > > >                                  dev->name, *num_buf,
> > > > > > > > > > > > > > > > @@ -1351,7 +1549,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > > > > > > > > > > > > > > >         while (--num_buf) {
> > > > > > > > > > > > > > > >                 int num_skb_frags;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -               buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
> > > > > > > > > > > > > > > > +               buf = virtnet_rq_get_buf(rq, &len, &ctx);
> > > > > > > > > > > > > > > >                 if (unlikely(!buf)) {
> > > > > > > > > > > > > > > >                         pr_debug("%s: rx error: %d buffers out of %d missing\n",
> > > > > > > > > > > > > > > >                                  dev->name, num_buf,
> > > > > > > > > > > > > > > > @@ -1414,7 +1612,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > > > > > > > > > > > > > > >  err_skb:
> > > > > > > > > > > > > > > >         put_page(page);
> > > > > > > > > > > > > > > >         while (num_buf-- > 1) {
> > > > > > > > > > > > > > > > -               buf = virtqueue_get_buf(rq->vq, &len);
> > > > > > > > > > > > > > > > +               buf = virtnet_rq_get_buf(rq, &len, NULL);
> > > > > > > > > > > > > > > >                 if (unlikely(!buf)) {
> > > > > > > > > > > > > > > >                         pr_debug("%s: rx error: %d buffers missing\n",
> > > > > > > > > > > > > > > >                                  dev->name, num_buf);
> > > > > > > > > > > > > > > > @@ -1529,6 +1727,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > > > > > > > > > >         unsigned int xdp_headroom = virtnet_get_headroom(vi);
> > > > > > > > > > > > > > > >         void *ctx = (void *)(unsigned long)xdp_headroom;
> > > > > > > > > > > > > > > >         int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > >         int err;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >         len = SKB_DATA_ALIGN(len) +
> > > > > > > > > > > > > > > > @@ -1539,11 +1738,34 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > > > > > > > > > >         buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
> > > > > > > > > > > > > > > >         get_page(alloc_frag->page);
> > > > > > > > > > > > > > > >         alloc_frag->offset += len;
> > > > > > > > > > > > > > > > -       sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
> > > > > > > > > > > > > > > > -                   vi->hdr_len + GOOD_PACKET_LEN);
> > > > > > > > > > > > > > > > -       err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > > +               err = virtnet_rq_map_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> > > > > > > > > > > > > > > > +                                       vi->hdr_len + GOOD_PACKET_LEN);
> > > > > > > > > > > > > > > > +               if (err)
> > > > > > > > > > > > > > > > +                       goto map_err;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               data = virtnet_rq_get_data(rq, buf, rq->last_dma);
> > > > > > > > > > > > > > > > +       } else {
> > > > > > > > > > > > > > > > +               sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
> > > > > > > > > > > > > > > > +                           vi->hdr_len + GOOD_PACKET_LEN);
> > > > > > > > > > > > > > > > +               data = (void *)buf;
> > > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, data, ctx, gfp);
> > > > > > > > > > > > > > > >         if (err < 0)
> > > > > > > > > > > > > > > > -               put_page(virt_to_head_page(buf));
> > > > > > > > > > > > > > > > +               goto add_err;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return err;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +add_err:
> > > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > > +               virtnet_rq_unmap(rq, data->dma);
> > > > > > > > > > > > > > > > +               virtnet_rq_recycle_data(rq, data);
> > > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +map_err:
> > > > > > > > > > > > > > > > +       put_page(virt_to_head_page(buf));
> > > > > > > > > > > > > > > >         return err;
> > > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > @@ -1620,6 +1842,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > > > > > > > > > > > > > > >         unsigned int headroom = virtnet_get_headroom(vi);
> > > > > > > > > > > > > > > >         unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
> > > > > > > > > > > > > > > >         unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
> > > > > > > > > > > > > > > > +       struct virtnet_rq_data *data;
> > > > > > > > > > > > > > > >         char *buf;
> > > > > > > > > > > > > > > >         void *ctx;
> > > > > > > > > > > > > > > >         int err;
> > > > > > > > > > > > > > > > @@ -1650,12 +1873,32 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > > > > > > > > > > > > > > >                 alloc_frag->offset += hole;
> > > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > -       sg_init_one(rq->sg, buf, len);
> > > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > > +               err = virtnet_rq_map_sg(rq, buf, len);
> > > > > > > > > > > > > > > > +               if (err)
> > > > > > > > > > > > > > > > +                       goto map_err;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               data = virtnet_rq_get_data(rq, buf, rq->last_dma);
> > > > > > > > > > > > > > > > +       } else {
> > > > > > > > > > > > > > > > +               sg_init_one(rq->sg, buf, len);
> > > > > > > > > > > > > > > > +               data = (void *)buf;
> > > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > >         ctx = mergeable_len_to_ctx(len + room, headroom);
> > > > > > > > > > > > > > > > -       err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> > > > > > > > > > > > > > > > +       err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, data, ctx, gfp);
> > > > > > > > > > > > > > > >         if (err < 0)
> > > > > > > > > > > > > > > > -               put_page(virt_to_head_page(buf));
> > > > > > > > > > > > > > > > +               goto add_err;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +add_err:
> > > > > > > > > > > > > > > > +       if (rq->data_array) {
> > > > > > > > > > > > > > > > +               virtnet_rq_unmap(rq, data->dma);
> > > > > > > > > > > > > > > > +               virtnet_rq_recycle_data(rq, data);
> > > > > > > > > > > > > > > > +       }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +map_err:
> > > > > > > > > > > > > > > > +       put_page(virt_to_head_page(buf));
> > > > > > > > > > > > > > > >         return err;
> > > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > @@ -1775,13 +2018,13 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > > > > > > > > > > > > > > >                 void *ctx;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >                 while (stats.packets < budget &&
> > > > > > > > > > > > > > > > -                      (buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx))) {
> > > > > > > > > > > > > > > > +                      (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
> > > > > > > > > > > > > > > >                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
> > > > > > > > > > > > > > > >                         stats.packets++;
> > > > > > > > > > > > > > > >                 }
> > > > > > > > > > > > > > > >         } else {
> > > > > > > > > > > > > > > >                 while (stats.packets < budget &&
> > > > > > > > > > > > > > > > -                      (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
> > > > > > > > > > > > > > > > +                      (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
> > > > > > > > > > > > > > > >                         receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
> > > > > > > > > > > > > > > >                         stats.packets++;
> > > > > > > > > > > > > > > >                 }
> > > > > > > > > > > > > > > > @@ -3514,6 +3757,9 @@ static void virtnet_free_queues(struct virtnet_info *vi)
> > > > > > > > > > > > > > > >         for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > > > > > > > > > > > >                 __netif_napi_del(&vi->rq[i].napi);
> > > > > > > > > > > > > > > >                 __netif_napi_del(&vi->sq[i].napi);
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               kfree(vi->rq[i].data_array);
> > > > > > > > > > > > > > > > +               kfree(vi->rq[i].dma_array);
> > > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >         /* We called __netif_napi_del(),
> > > > > > > > > > > > > > > > @@ -3591,9 +3837,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >         for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > > > > > > > > > > > > -               struct virtqueue *vq = vi->rq[i].vq;
> > > > > > > > > > > > > > > > -               while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > > > > > > > > > > > > > > -                       virtnet_rq_free_unused_buf(vq, buf);
> > > > > > > > > > > > > > > > +               struct receive_queue *rq = &vi->rq[i];
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +               while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
> > > > > > > > > > > > > > > > +                       virtnet_rq_free_unused_buf(rq->vq, buf);
> > > > > > > > > > > > > > > >                 cond_resched();
> > > > > > > > > > > > > > > >         }
> > > > > > > > > > > > > > > >  }
> > > > > > > > > > > > > > > > @@ -3767,6 +4014,10 @@ static int init_vqs(struct virtnet_info *vi)
> > > > > > > > > > > > > > > >         if (ret)
> > > > > > > > > > > > > > > >                 goto err_free;
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > +       ret = virtnet_rq_merge_map_init(vi);
> > > > > > > > > > > > > > > > +       if (ret)
> > > > > > > > > > > > > > > > +               goto err_free;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > >         cpus_read_lock();
> > > > > > > > > > > > > > > >         virtnet_set_affinity(vi);
> > > > > > > > > > > > > > > >         cpus_read_unlock();
> > > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > >
> >


