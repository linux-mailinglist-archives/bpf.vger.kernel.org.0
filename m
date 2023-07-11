Return-Path: <bpf+bounces-4705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4224F74E467
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646721C20D18
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE72320FF;
	Tue, 11 Jul 2023 02:42:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6A7F;
	Tue, 11 Jul 2023 02:42:26 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938B188;
	Mon, 10 Jul 2023 19:42:22 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vn6iL5A_1689043338;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vn6iL5A_1689043338)
          by smtp.aliyun-inc.com;
          Tue, 11 Jul 2023 10:42:19 +0800
Message-ID: <1689043238.4362252-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one page
Date: Tue, 11 Jul 2023 10:40:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com>
 <20230710051818-mutt-send-email-mst@kernel.org>
 <1688984310.480753-2-xuanzhuo@linux.alibaba.com>
 <20230710075534-mutt-send-email-mst@kernel.org>
 <1688992712.1534917-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsp0S2APzXENcK-SY8KZwu-1=w3xXNxh5kXT36EsiwaNQ@mail.gmail.com>
In-Reply-To: <CACGkMEsp0S2APzXENcK-SY8KZwu-1=w3xXNxh5kXT36EsiwaNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 11 Jul 2023 10:36:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jul 10, 2023 at 8:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Mon, 10 Jul 2023 07:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> > > On Mon, Jul 10, 2023 at 06:18:30PM +0800, Xuan Zhuo wrote:
> > > > On Mon, 10 Jul 2023 05:40:21 -0400, "Michael S. Tsirkin" <mst@redha=
t.com> wrote:
> > > > > On Mon, Jul 10, 2023 at 11:42:37AM +0800, Xuan Zhuo wrote:
> > > > > > Currently, the virtio core will perform a dma operation for each
> > > > > > operation. Although, the same page may be operated multiple tim=
es.
> > > > > >
> > > > > > The driver does the dma operation and manages the dma address b=
ased the
> > > > > > feature premapped of virtio core.
> > > > > >
> > > > > > This way, we can perform only one dma operation for the same pa=
ge. In
> > > > > > the case of mtu 1500, this can reduce a lot of dma operations.
> > > > > >
> > > > > > Tested on Aliyun g7.4large machine, in the case of a cpu 100%, =
pps
> > > > > > increased from 1893766 to 1901105. An increase of 0.4%.
> > > > >
> > > > > what kind of dma was there? an IOMMU? which vendors? in which mode
> > > > > of operation?
> > > >
> > > >
> > > > Do you mean this:
> > > >
> > > > [    0.470816] iommu: Default domain type: Passthrough
> > > >
> > >
> > > With passthrough, dma API is just some indirect function calls, they =
do
> > > not affect the performance a lot.
> >
> >
> > Yes, this benefit is worthless. I seem to have done a meaningless thing=
. The
> > overhead of DMA I observed is indeed not too high.
>
> Have you measured with iommu=3Dstrict?

I have not tested this way, our environment is pt, I wonder if strict is a
common scenario. I can test it.

Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Try e.g. bounce buffer. Which is where you will see a problem: your
> > > patches won't work.
> > >
> > >
> > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > >
> > > > > This kind of difference is likely in the noise.
> > > >
> > > > It's really not high, but this is because the proportion of DMA und=
er perf top
> > > > is not high. Probably that much.
> > >
> > > So maybe not worth the complexity.
> > >
> > > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 283 +++++++++++++++++++++++++++++++=
+++++---
> > > > > >  1 file changed, 267 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 486b5849033d..4de845d35bed 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -126,6 +126,27 @@ static const struct virtnet_stat_desc virt=
net_rq_stats_desc[] =3D {
> > > > > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_des=
c)
> > > > > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_des=
c)
> > > > > >
> > > > > > +/* The bufs on the same page may share this struct. */
> > > > > > +struct virtnet_rq_dma {
> > > > > > +       struct virtnet_rq_dma *next;
> > > > > > +
> > > > > > +       dma_addr_t addr;
> > > > > > +
> > > > > > +       void *buf;
> > > > > > +       u32 len;
> > > > > > +
> > > > > > +       u32 ref;
> > > > > > +};
> > > > > > +
> > > > > > +/* Record the dma and buf. */
> > > > >
> > > > > I guess I see that. But why?
> > > > > And these two comments are the extent of the available
> > > > > documentation, that's not enough I feel.
> > > > >
> > > > >
> > > > > > +struct virtnet_rq_data {
> > > > > > +       struct virtnet_rq_data *next;
> > > > >
> > > > > Is manually reimplementing a linked list the best
> > > > > we can do?
> > > >
> > > > Yes, we can use llist.
> > > >
> > > > >
> > > > > > +
> > > > > > +       void *buf;
> > > > > > +
> > > > > > +       struct virtnet_rq_dma *dma;
> > > > > > +};
> > > > > > +
> > > > > >  /* Internal representation of a send virtqueue */
> > > > > >  struct send_queue {
> > > > > >         /* Virtqueue associated with this send _queue */
> > > > > > @@ -175,6 +196,13 @@ struct receive_queue {
> > > > > >         char name[16];
> > > > > >
> > > > > >         struct xdp_rxq_info xdp_rxq;
> > > > > > +
> > > > > > +       struct virtnet_rq_data *data_array;
> > > > > > +       struct virtnet_rq_data *data_free;
> > > > > > +
> > > > > > +       struct virtnet_rq_dma *dma_array;
> > > > > > +       struct virtnet_rq_dma *dma_free;
> > > > > > +       struct virtnet_rq_dma *last_dma;
> > > > > >  };
> > > > > >
> > > > > >  /* This structure can contain rss message with maximum setting=
s for indirection table and keysize
> > > > > > @@ -549,6 +577,176 @@ static struct sk_buff *page_to_skb(struct=
 virtnet_info *vi,
> > > > > >         return skb;
> > > > > >  }
> > > > > >
> > > > > > +static void virtnet_rq_unmap(struct receive_queue *rq, struct =
virtnet_rq_dma *dma)
> > > > > > +{
> > > > > > +       struct device *dev;
> > > > > > +
> > > > > > +       --dma->ref;
> > > > > > +
> > > > > > +       if (dma->ref)
> > > > > > +               return;
> > > > > > +
> > > > >
> > > > > If you don't unmap there is no guarantee valid data will be
> > > > > there in the buffer.
> > > > >
> > > > > > +       dev =3D virtqueue_dma_dev(rq->vq);
> > > > > > +
> > > > > > +       dma_unmap_page(dev, dma->addr, dma->len, DMA_FROM_DEVIC=
E);
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > > +
> > > > > > +       dma->next =3D rq->dma_free;
> > > > > > +       rq->dma_free =3D dma;
> > > > > > +}
> > > > > > +
> > > > > > +static void *virtnet_rq_recycle_data(struct receive_queue *rq,
> > > > > > +                                    struct virtnet_rq_data *da=
ta)
> > > > > > +{
> > > > > > +       void *buf;
> > > > > > +
> > > > > > +       buf =3D data->buf;
> > > > > > +
> > > > > > +       data->next =3D rq->data_free;
> > > > > > +       rq->data_free =3D data;
> > > > > > +
> > > > > > +       return buf;
> > > > > > +}
> > > > > > +
> > > > > > +static struct virtnet_rq_data *virtnet_rq_get_data(struct rece=
ive_queue *rq,
> > > > > > +                                                  void *buf,
> > > > > > +                                                  struct virtn=
et_rq_dma *dma)
> > > > > > +{
> > > > > > +       struct virtnet_rq_data *data;
> > > > > > +
> > > > > > +       data =3D rq->data_free;
> > > > > > +       rq->data_free =3D data->next;
> > > > > > +
> > > > > > +       data->buf =3D buf;
> > > > > > +       data->dma =3D dma;
> > > > > > +
> > > > > > +       return data;
> > > > > > +}
> > > > > > +
> > > > > > +static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 =
*len, void **ctx)
> > > > > > +{
> > > > > > +       struct virtnet_rq_data *data;
> > > > > > +       void *buf;
> > > > > > +
> > > > > > +       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > > > +       if (!buf || !rq->data_array)
> > > > > > +               return buf;
> > > > > > +
> > > > > > +       data =3D buf;
> > > > > > +
> > > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > > +
> > > > > > +       return virtnet_rq_recycle_data(rq, data);
> > > > > > +}
> > > > > > +
> > > > > > +static void *virtnet_rq_detach_unused_buf(struct receive_queue=
 *rq)
> > > > > > +{
> > > > > > +       struct virtnet_rq_data *data;
> > > > > > +       void *buf;
> > > > > > +
> > > > > > +       buf =3D virtqueue_detach_unused_buf(rq->vq);
> > > > > > +       if (!buf || !rq->data_array)
> > > > > > +               return buf;
> > > > > > +
> > > > > > +       data =3D buf;
> > > > > > +
> > > > > > +       virtnet_rq_unmap(rq, data->dma);
> > > > > > +
> > > > > > +       return virtnet_rq_recycle_data(rq, data);
> > > > > > +}
> > > > > > +
> > > > > > +static int virtnet_rq_map_sg(struct receive_queue *rq, void *b=
uf, u32 len)
> > > > > > +{
> > > > > > +       struct virtnet_rq_dma *dma =3D rq->last_dma;
> > > > > > +       struct device *dev;
> > > > > > +       u32 off, map_len;
> > > > > > +       dma_addr_t addr;
> > > > > > +       void *end;
> > > > > > +
> > > > > > +       if (likely(dma) && buf >=3D dma->buf && (buf + len <=3D=
 dma->buf + dma->len)) {
> > > > > > +               ++dma->ref;
> > > > > > +               addr =3D dma->addr + (buf - dma->buf);
> > > > > > +               goto ok;
> > > > > > +       }
> > > > >
> > > > > So this is the meat of the proposed optimization. I guess that
> > > > > if the last buffer we allocated happens to be in the same page
> > > > > as this one then they can both be mapped for DMA together.
> > > >
> > > > Since we use page_frag, the buffers we allocated are all continuous.
> > > >
> > > > > Why last one specifically? Whether next one happens to
> > > > > be close depends on luck. If you want to try optimizing this
> > > > > the right thing to do is likely by using a page pool.
> > > > > There's actually work upstream on page pool, look it up.
> > > >
> > > > As we discussed in another thread, the page pool is first used for =
xdp. Let's
> > > > transform it step by step.
> > > >
> > > > Thanks.
> > >
> > > ok so this should wait then?
> > >
> > > > >
> > > > > > +
> > > > > > +       end =3D buf + len - 1;
> > > > > > +       off =3D offset_in_page(end);
> > > > > > +       map_len =3D len + PAGE_SIZE - off;
> > > > > > +
> > > > > > +       dev =3D virtqueue_dma_dev(rq->vq);
> > > > > > +
> > > > > > +       addr =3D dma_map_page_attrs(dev, virt_to_page(buf), off=
set_in_page(buf),
> > > > > > +                                 map_len, DMA_FROM_DEVICE, 0);
> > > > > > +       if (addr =3D=3D DMA_MAPPING_ERROR)
> > > > > > +               return -ENOMEM;
> > > > > > +
> > > > > > +       dma =3D rq->dma_free;
> > > > > > +       rq->dma_free =3D dma->next;
> > > > > > +
> > > > > > +       dma->ref =3D 1;
> > > > > > +       dma->buf =3D buf;
> > > > > > +       dma->addr =3D addr;
> > > > > > +       dma->len =3D map_len;
> > > > > > +
> > > > > > +       rq->last_dma =3D dma;
> > > > > > +
> > > > > > +ok:
> > > > > > +       sg_init_table(rq->sg, 1);
> > > > > > +       rq->sg[0].dma_address =3D addr;
> > > > > > +       rq->sg[0].length =3D len;
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int virtnet_rq_merge_map_init(struct virtnet_info *vi)
> > > > > > +{
> > > > > > +       struct receive_queue *rq;
> > > > > > +       int i, err, j, num;
> > > > > > +
> > > > > > +       /* disable for big mode */
> > > > > > +       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > > > +               return 0;
> > > > > > +
> > > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > > +               err =3D virtqueue_set_premapped(vi->rq[i].vq);
> > > > > > +               if (err)
> > > > > > +                       continue;
> > > > > > +
> > > > > > +               rq =3D &vi->rq[i];
> > > > > > +
> > > > > > +               num =3D virtqueue_get_vring_size(rq->vq);
> > > > > > +
> > > > > > +               rq->data_array =3D kmalloc_array(num, sizeof(*r=
q->data_array), GFP_KERNEL);
> > > > > > +               if (!rq->data_array)
> > > > > > +                       goto err;
> > > > > > +
> > > > > > +               rq->dma_array =3D kmalloc_array(num, sizeof(*rq=
->dma_array), GFP_KERNEL);
> > > > > > +               if (!rq->dma_array)
> > > > > > +                       goto err;
> > > > > > +
> > > > > > +               for (j =3D 0; j < num; ++j) {
> > > > > > +                       rq->data_array[j].next =3D rq->data_fre=
e;
> > > > > > +                       rq->data_free =3D &rq->data_array[j];
> > > > > > +
> > > > > > +                       rq->dma_array[j].next =3D rq->dma_free;
> > > > > > +                       rq->dma_free =3D &rq->dma_array[j];
> > > > > > +               }
> > > > > > +       }
> > > > > > +
> > > > > > +       return 0;
> > > > > > +
> > > > > > +err:
> > > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > > +               struct receive_queue *rq;
> > > > > > +
> > > > > > +               rq =3D &vi->rq[i];
> > > > > > +
> > > > > > +               kfree(rq->dma_array);
> > > > > > +               kfree(rq->data_array);
> > > > > > +       }
> > > > > > +
> > > > > > +       return -ENOMEM;
> > > > > > +}
> > > > > > +
> > > > > >  static void free_old_xmit_skbs(struct send_queue *sq, bool in_=
napi)
> > > > > >  {
> > > > > >         unsigned int len;
> > > > > > @@ -835,7 +1033,7 @@ static struct page *xdp_linearize_page(str=
uct receive_queue *rq,
> > > > > >                 void *buf;
> > > > > >                 int off;
> > > > > >
> > > > > > -               buf =3D virtqueue_get_buf(rq->vq, &buflen);
> > > > > > +               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
> > > > > >                 if (unlikely(!buf))
> > > > > >                         goto err_buf;
> > > > > >
> > > > > > @@ -1126,7 +1324,7 @@ static int virtnet_build_xdp_buff_mrg(str=
uct net_device *dev,
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > >         while (--*num_buf > 0) {
> > > > > > -               buf =3D virtqueue_get_buf_ctx(rq->vq, &len, &ct=
x);
> > > > > > +               buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
> > > > > >                 if (unlikely(!buf)) {
> > > > > >                         pr_debug("%s: rx error: %d buffers out =
of %d missing\n",
> > > > > >                                  dev->name, *num_buf,
> > > > > > @@ -1351,7 +1549,7 @@ static struct sk_buff *receive_mergeable(=
struct net_device *dev,
> > > > > >         while (--num_buf) {
> > > > > >                 int num_skb_frags;
> > > > > >
> > > > > > -               buf =3D virtqueue_get_buf_ctx(rq->vq, &len, &ct=
x);
> > > > > > +               buf =3D virtnet_rq_get_buf(rq, &len, &ctx);
> > > > > >                 if (unlikely(!buf)) {
> > > > > >                         pr_debug("%s: rx error: %d buffers out =
of %d missing\n",
> > > > > >                                  dev->name, num_buf,
> > > > > > @@ -1414,7 +1612,7 @@ static struct sk_buff *receive_mergeable(=
struct net_device *dev,
> > > > > >  err_skb:
> > > > > >         put_page(page);
> > > > > >         while (num_buf-- > 1) {
> > > > > > -               buf =3D virtqueue_get_buf(rq->vq, &len);
> > > > > > +               buf =3D virtnet_rq_get_buf(rq, &len, NULL);
> > > > > >                 if (unlikely(!buf)) {
> > > > > >                         pr_debug("%s: rx error: %d buffers miss=
ing\n",
> > > > > >                                  dev->name, num_buf);
> > > > > > @@ -1529,6 +1727,7 @@ static int add_recvbuf_small(struct virtn=
et_info *vi, struct receive_queue *rq,
> > > > > >         unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
> > > > > >         void *ctx =3D (void *)(unsigned long)xdp_headroom;
> > > > > >         int len =3D vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_=
LEN + xdp_headroom;
> > > > > > +       struct virtnet_rq_data *data;
> > > > > >         int err;
> > > > > >
> > > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > > > @@ -1539,11 +1738,34 @@ static int add_recvbuf_small(struct vir=
tnet_info *vi, struct receive_queue *rq,
> > > > > >         buf =3D (char *)page_address(alloc_frag->page) + alloc_=
frag->offset;
> > > > > >         get_page(alloc_frag->page);
> > > > > >         alloc_frag->offset +=3D len;
> > > > > > -       sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_headroom,
> > > > > > -                   vi->hdr_len + GOOD_PACKET_LEN);
> > > > > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf,=
 ctx, gfp);
> > > > > > +
> > > > > > +       if (rq->data_array) {
> > > > > > +               err =3D virtnet_rq_map_sg(rq, buf + VIRTNET_RX_=
PAD + xdp_headroom,
> > > > > > +                                       vi->hdr_len + GOOD_PACK=
ET_LEN);
> > > > > > +               if (err)
> > > > > > +                       goto map_err;
> > > > > > +
> > > > > > +               data =3D virtnet_rq_get_data(rq, buf, rq->last_=
dma);
> > > > > > +       } else {
> > > > > > +               sg_init_one(rq->sg, buf + VIRTNET_RX_PAD + xdp_=
headroom,
> > > > > > +                           vi->hdr_len + GOOD_PACKET_LEN);
> > > > > > +               data =3D (void *)buf;
> > > > > > +       }
> > > > > > +
> > > > > > +       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, data=
, ctx, gfp);
> > > > > >         if (err < 0)
> > > > > > -               put_page(virt_to_head_page(buf));
> > > > > > +               goto add_err;
> > > > > > +
> > > > > > +       return err;
> > > > > > +
> > > > > > +add_err:
> > > > > > +       if (rq->data_array) {
> > > > > > +               virtnet_rq_unmap(rq, data->dma);
> > > > > > +               virtnet_rq_recycle_data(rq, data);
> > > > > > +       }
> > > > > > +
> > > > > > +map_err:
> > > > > > +       put_page(virt_to_head_page(buf));
> > > > > >         return err;
> > > > > >  }
> > > > > >
> > > > > > @@ -1620,6 +1842,7 @@ static int add_recvbuf_mergeable(struct v=
irtnet_info *vi,
> > > > > >         unsigned int headroom =3D virtnet_get_headroom(vi);
> > > > > >         unsigned int tailroom =3D headroom ? sizeof(struct skb_=
shared_info) : 0;
> > > > > >         unsigned int room =3D SKB_DATA_ALIGN(headroom + tailroo=
m);
> > > > > > +       struct virtnet_rq_data *data;
> > > > > >         char *buf;
> > > > > >         void *ctx;
> > > > > >         int err;
> > > > > > @@ -1650,12 +1873,32 @@ static int add_recvbuf_mergeable(struct=
 virtnet_info *vi,
> > > > > >                 alloc_frag->offset +=3D hole;
> > > > > >         }
> > > > > >
> > > > > > -       sg_init_one(rq->sg, buf, len);
> > > > > > +       if (rq->data_array) {
> > > > > > +               err =3D virtnet_rq_map_sg(rq, buf, len);
> > > > > > +               if (err)
> > > > > > +                       goto map_err;
> > > > > > +
> > > > > > +               data =3D virtnet_rq_get_data(rq, buf, rq->last_=
dma);
> > > > > > +       } else {
> > > > > > +               sg_init_one(rq->sg, buf, len);
> > > > > > +               data =3D (void *)buf;
> > > > > > +       }
> > > > > > +
> > > > > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > > > > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf,=
 ctx, gfp);
> > > > > > +       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, data=
, ctx, gfp);
> > > > > >         if (err < 0)
> > > > > > -               put_page(virt_to_head_page(buf));
> > > > > > +               goto add_err;
> > > > > > +
> > > > > > +       return 0;
> > > > > > +
> > > > > > +add_err:
> > > > > > +       if (rq->data_array) {
> > > > > > +               virtnet_rq_unmap(rq, data->dma);
> > > > > > +               virtnet_rq_recycle_data(rq, data);
> > > > > > +       }
> > > > > >
> > > > > > +map_err:
> > > > > > +       put_page(virt_to_head_page(buf));
> > > > > >         return err;
> > > > > >  }
> > > > > >
> > > > > > @@ -1775,13 +2018,13 @@ static int virtnet_receive(struct recei=
ve_queue *rq, int budget,
> > > > > >                 void *ctx;
> > > > > >
> > > > > >                 while (stats.packets < budget &&
> > > > > > -                      (buf =3D virtqueue_get_buf_ctx(rq->vq, &=
len, &ctx))) {
> > > > > > +                      (buf =3D virtnet_rq_get_buf(rq, &len, &c=
tx))) {
> > > > > >                         receive_buf(vi, rq, buf, len, ctx, xdp_=
xmit, &stats);
> > > > > >                         stats.packets++;
> > > > > >                 }
> > > > > >         } else {
> > > > > >                 while (stats.packets < budget &&
> > > > > > -                      (buf =3D virtqueue_get_buf(rq->vq, &len)=
) !=3D NULL) {
> > > > > > +                      (buf =3D virtnet_rq_get_buf(rq, &len, NU=
LL)) !=3D NULL) {
> > > > > >                         receive_buf(vi, rq, buf, len, NULL, xdp=
_xmit, &stats);
> > > > > >                         stats.packets++;
> > > > > >                 }
> > > > > > @@ -3514,6 +3757,9 @@ static void virtnet_free_queues(struct vi=
rtnet_info *vi)
> > > > > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > >                 __netif_napi_del(&vi->rq[i].napi);
> > > > > >                 __netif_napi_del(&vi->sq[i].napi);
> > > > > > +
> > > > > > +               kfree(vi->rq[i].data_array);
> > > > > > +               kfree(vi->rq[i].dma_array);
> > > > > >         }
> > > > > >
> > > > > >         /* We called __netif_napi_del(),
> > > > > > @@ -3591,9 +3837,10 @@ static void free_unused_bufs(struct virt=
net_info *vi)
> > > > > >         }
> > > > > >
> > > > > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > > -               struct virtqueue *vq =3D vi->rq[i].vq;
> > > > > > -               while ((buf =3D virtqueue_detach_unused_buf(vq)=
) !=3D NULL)
> > > > > > -                       virtnet_rq_free_unused_buf(vq, buf);
> > > > > > +               struct receive_queue *rq =3D &vi->rq[i];
> > > > > > +
> > > > > > +               while ((buf =3D virtnet_rq_detach_unused_buf(rq=
)) !=3D NULL)
> > > > > > +                       virtnet_rq_free_unused_buf(rq->vq, buf);
> > > > > >                 cond_resched();
> > > > > >         }
> > > > > >  }
> > > > > > @@ -3767,6 +4014,10 @@ static int init_vqs(struct virtnet_info =
*vi)
> > > > > >         if (ret)
> > > > > >                 goto err_free;
> > > > > >
> > > > > > +       ret =3D virtnet_rq_merge_map_init(vi);
> > > > > > +       if (ret)
> > > > > > +               goto err_free;
> > > > > > +
> > > > > >         cpus_read_lock();
> > > > > >         virtnet_set_affinity(vi);
> > > > > >         cpus_read_unlock();
> > > > > > --
> > > > > > 2.32.0.3.g01195cf9f
> > > > >
> > >
> >
>

