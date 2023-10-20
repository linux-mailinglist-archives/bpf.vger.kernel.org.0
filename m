Return-Path: <bpf+bounces-12809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D517D0A4D
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18A31F2408E
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689910956;
	Fri, 20 Oct 2023 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A699107A9;
	Fri, 20 Oct 2023 08:13:03 +0000 (UTC)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D26115;
	Fri, 20 Oct 2023 01:13:00 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuWbcAx_1697789574;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuWbcAx_1697789574)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 16:12:55 +0800
Message-ID: <1697789368.7039382-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 12/19] virtio_net: xsk: tx: support wakeup
Date: Fri, 20 Oct 2023 16:09:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
 <CACGkMEsoA_y6FV0PzoLfO-UFhJrYRe96cDpX_hHgSo7PAwshrQ@mail.gmail.com>
In-Reply-To: <CACGkMEsoA_y6FV0PzoLfO-UFhJrYRe96cDpX_hHgSo7PAwshrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 20 Oct 2023 14:52:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
> > user.
> >
> > Virtio-Net does not support to actively generate an interruption, so it
> > tries to trigger tx NAPI on the tx interrupt cpu.
> >
> > Consider the effect of cache. When interrupt triggers, it is
> > generally fixed on a CPU. It is better to start TX Napi on the same
> > CPU.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       |  3 ++
> >  drivers/net/virtio/virtio_net.h |  8 +++++
> >  drivers/net/virtio/xsk.c        | 57 +++++++++++++++++++++++++++++++++
> >  drivers/net/virtio/xsk.h        |  1 +
> >  4 files changed, 69 insertions(+)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index a08429bef61f..1a222221352e 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -2066,6 +2066,8 @@ static int virtnet_poll_tx(struct napi_struct *na=
pi, int budget)
> >                 return 0;
> >         }
> >
> > +       sq->xsk.last_cpu =3D smp_processor_id();
> > +
> >         txq =3D netdev_get_tx_queue(vi->dev, index);
> >         __netif_tx_lock(txq, raw_smp_processor_id());
> >         virtqueue_disable_cb(sq->vq);
> > @@ -3770,6 +3772,7 @@ static const struct net_device_ops virtnet_netdev=
 =3D {
> >         .ndo_vlan_rx_kill_vid =3D virtnet_vlan_rx_kill_vid,
> >         .ndo_bpf                =3D virtnet_xdp,
> >         .ndo_xdp_xmit           =3D virtnet_xdp_xmit,
> > +       .ndo_xsk_wakeup         =3D virtnet_xsk_wakeup,
> >         .ndo_features_check     =3D passthru_features_check,
> >         .ndo_get_phys_port_name =3D virtnet_get_phys_port_name,
> >         .ndo_set_features       =3D virtnet_set_features,
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index 3bbb1f5baad5..7c72a8bb1813 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -101,6 +101,14 @@ struct virtnet_sq {
> >                 struct xsk_buff_pool __rcu *pool;
> >
> >                 dma_addr_t hdr_dma_address;
> > +
> > +               u32 last_cpu;
> > +               struct __call_single_data csd;
> > +
> > +               /* The lock to prevent the repeat of calling
> > +                * smp_call_function_single_async().
> > +                */
> > +               spinlock_t ipi_lock;
> >         } xsk;
> >  };
> >
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > index 0e775a9d270f..973e783260c3 100644
> > --- a/drivers/net/virtio/xsk.c
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -115,6 +115,60 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struc=
t xsk_buff_pool *pool,
> >         return sent =3D=3D budget;
> >  }
> >
> > +static void virtnet_remote_napi_schedule(void *info)
> > +{
> > +       struct virtnet_sq *sq =3D info;
> > +
> > +       virtnet_vq_napi_schedule(&sq->napi, sq->vq);
> > +}
> > +
> > +static void virtnet_remote_raise_napi(struct virtnet_sq *sq)
> > +{
> > +       u32 last_cpu, cur_cpu;
> > +
> > +       last_cpu =3D sq->xsk.last_cpu;
> > +       cur_cpu =3D get_cpu();
> > +
> > +       /* On remote cpu, softirq will run automatically when ipi irq e=
xit. On
> > +        * local cpu, smp_call_xxx will not trigger ipi interrupt, then=
 softirq
> > +        * cannot be triggered automatically. So Call local_bh_enable a=
fter to
> > +        * trigger softIRQ processing.
> > +        */
> > +       if (last_cpu =3D=3D cur_cpu) {
> > +               local_bh_disable();
> > +               virtnet_vq_napi_schedule(&sq->napi, sq->vq);
> > +               local_bh_enable();
> > +       } else {
> > +               if (spin_trylock(&sq->xsk.ipi_lock)) {
> > +                       smp_call_function_single_async(last_cpu, &sq->x=
sk.csd);
> > +                       spin_unlock(&sq->xsk.ipi_lock);
> > +               }
> > +       }
>
> Is there any number to show whether it's worth it for an IPI here? For
> example, GVE doesn't do this.

I just do not like the tx napi will run on difference CPUs.

Let's start with the way of GVE.

Thanks


>
> Thanks
>
>
> > +
> > +       put_cpu();
> > +}
> > +
> > +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> > +{
> > +       struct virtnet_info *vi =3D netdev_priv(dev);
> > +       struct virtnet_sq *sq;
> > +
> > +       if (!netif_running(dev))
> > +               return -ENETDOWN;
> > +
> > +       if (qid >=3D vi->curr_queue_pairs)
> > +               return -EINVAL;
> > +
> > +       sq =3D &vi->sq[qid];
> > +
> > +       if (napi_if_scheduled_mark_missed(&sq->napi))
> > +               return 0;
> > +
> > +       virtnet_remote_raise_napi(sq);
> > +
> > +       return 0;
> > +}
> > +
> >  static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct vi=
rtnet_rq *rq,
> >                                     struct xsk_buff_pool *pool)
> >  {
> > @@ -240,6 +294,9 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
> >
> >         sq->xsk.hdr_dma_address =3D hdr_dma;
> >
> > +       INIT_CSD(&sq->xsk.csd, virtnet_remote_napi_schedule, sq);
> > +       spin_lock_init(&sq->xsk.ipi_lock);
> > +
> >         return 0;
> >
> >  err_sq:
> > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > index 73ca8cd5308b..1bd19dcda649 100644
> > --- a/drivers/net/virtio/xsk.h
> > +++ b/drivers/net/virtio/xsk.h
> > @@ -17,4 +17,5 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
> >  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *=
xdp);
> >  bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *poo=
l,
> >                       int budget);
> > +int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
> >
>

