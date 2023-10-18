Return-Path: <bpf+bounces-12499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3ED7CD27A
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 04:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C73281B3B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF14436;
	Wed, 18 Oct 2023 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78517D1;
	Wed, 18 Oct 2023 02:58:07 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40D610A;
	Tue, 17 Oct 2023 19:58:01 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuP8dr6_1697597878;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuP8dr6_1697597878)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 10:57:59 +0800
Message-ID: <1697597798.3310452-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
Date: Wed, 18 Oct 2023 10:56:38 +0800
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
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
 <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtppjoX_WAM+vjzkMKaMQQ0iZL=C_xS4RObuoLbm0udUw@mail.gmail.com>
 <CACGkMEvWAhH3uj2DEo=m7qWg3-pQjE-EtEBvTT8JXzqZ+RYEXQ@mail.gmail.com>
 <1697522771.0390663-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEu4tSHd4RVo0zEp1A6uM-6h42y+yAB2xzHTv8SzYdZPXQ@mail.gmail.com>
 <1697525013.7650406-3-xuanzhuo@linux.alibaba.com>
 <1697541581.967358-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuXJaGEyAtdz1d3ajwx9jBqkWUyoUrg8DZ6dCXLPJxiOw@mail.gmail.com>
In-Reply-To: <CACGkMEuXJaGEyAtdz1d3ajwx9jBqkWUyoUrg8DZ6dCXLPJxiOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 18 Oct 2023 10:46:38 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Oct 17, 2023 at 7:28=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 17 Oct 2023 14:43:33 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
> > > On Tue, 17 Oct 2023 14:26:01 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Oct 17, 2023 at 2:17=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Tue, 17 Oct 2023 13:27:47 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Tue, Oct 17, 2023 at 11:28=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 17, 2023 at 11:26=E2=80=AFAM Xuan Zhuo <xuanzhuo@=
linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, 17 Oct 2023 11:20:41 +0800, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > On Tue, Oct 17, 2023 at 11:11=E2=80=AFAM Xuan Zhuo <xuanz=
huo@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, 17 Oct 2023 10:53:44 +0800, Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > > > > On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xu=
anzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > ## AF_XDP
> > > > > > > > > > > >
> > > > > > > > > > > > XDP socket(AF_XDP) is an excellent bypass kernel ne=
twork framework. The zero
> > > > > > > > > > > > copy feature of xsk (XDP socket) needs to be suppor=
ted by the driver. The
> > > > > > > > > > > > performance of zero copy is very good. mlx5 and int=
el ixgbe already support
> > > > > > > > > > > > this feature, This patch set allows virtio-net to s=
upport xsk's zerocopy xmit
> > > > > > > > > > > > feature.
> > > > > > > > > > > >
> > > > > > > > > > > > At present, we have completed some preparation:
> > > > > > > > > > > >
> > > > > > > > > > > > 1. vq-reset (virtio spec and kernel code)
> > > > > > > > > > > > 2. virtio-core premapped dma
> > > > > > > > > > > > 3. virtio-net xdp refactor
> > > > > > > > > > > >
> > > > > > > > > > > > So it is time for Virtio-Net to complete the suppor=
t for the XDP Socket
> > > > > > > > > > > > Zerocopy.
> > > > > > > > > > > >
> > > > > > > > > > > > Virtio-net can not increase the queue num at will, =
so xsk shares the queue with
> > > > > > > > > > > > kernel.
> > > > > > > > > > > >
> > > > > > > > > > > > On the other hand, Virtio-Net does not support gene=
rate interrupt from driver
> > > > > > > > > > > > manually, so when we wakeup tx xmit, we used some t=
ips. If the CPU run by TX
> > > > > > > > > > > > NAPI last time is other CPUs, use IPI to wake up NA=
PI on the remote CPU. If it
> > > > > > > > > > > > is also the local CPU, then we wake up napi directl=
y.
> > > > > > > > > > > >
> > > > > > > > > > > > This patch set includes some refactor to the virtio=
-net to let that to support
> > > > > > > > > > > > AF_XDP.
> > > > > > > > > > > >
> > > > > > > > > > > > ## performance
> > > > > > > > > > > >
> > > > > > > > > > > > ENV: Qemu with vhost-user(polling mode).
> > > > > > > > > > > >
> > > > > > > > > > > > Sockperf: https://github.com/Mellanox/sockperf
> > > > > > > > > > > > I use this tool to send udp packet by kernel syscal=
l.
> > > > > > > > > > > >
> > > > > > > > > > > > xmit command: sockperf tp -i 10.0.3.1 -t 1000
> > > > > > > > > > > >
> > > > > > > > > > > > I write a tool that sends udp packets or recvs udp =
packets by AF_XDP.
> > > > > > > > > > > >
> > > > > > > > > > > >                   | Guest APP CPU |Guest Softirq CP=
U | UDP PPS
> > > > > > > > > > > > ------------------|---------------|----------------=
--|------------
> > > > > > > > > > > > xmit by syscall   |   100%        |                =
  |   676,915
> > > > > > > > > > > > xmit by xsk       |   59.1%       |   100%         =
  | 5,447,168
> > > > > > > > > > > > recv by syscall   |   60%         |   100%         =
  |   932,288
> > > > > > > > > > > > recv by xsk       |   35.7%       |   100%         =
  | 3,343,168
> > > > > > > > > > >
> > > > > > > > > > > Any chance we can get a testpmd result (which I guess=
 should be better
> > > > > > > > > > > than PPS above)?
> > > > > > > > > >
> > > > > > > > > > Do you mean testpmd + DPDK + AF_XDP?
> > > > > > > > >
> > > > > > > > > Yes.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Yes. This is probably better because my tool does more =
work. That is not a
> > > > > > > > > > complete testing tool used by our business.
> > > > > > > > >
> > > > > > > > > Probably, but it would be appealing for others. Especiall=
y considering
> > > > > > > > > DPDK supports AF_XDP PMD now.
> > > > > > > >
> > > > > > > > OK.
> > > > > > > >
> > > > > > > > Let me try.
> > > > > > > >
> > > > > > > > But could you start to review firstly?
> > > > > > >
> > > > > > > Yes, it's in my todo list.
> > > > > >
> > > > > > Speaking too fast, I think if it doesn't take too long time, I =
would
> > > > > > wait for the result first as netdim series. One reason is that I
> > > > > > remember claims to be only 10% to 20% loss comparing to wire sp=
eed, so
> > > > > > I'd expect it should be much faster. I vaguely remember, even a=
 vhost
> > > > > > can gives us more than 3M PPS if we disable SMAP, so the number=
s here
> > > > > > are not as impressive as expected.
> > > > >
> > > > >
> > > > > What is SMAP? Cloud you give me more info?
> > > >
> > > > Supervisor Mode Access Prevention
> > > >
> > > > Vhost suffers from this.
> > > >
> > > > >
> > > > > So if we think the 3M as the wire speed, you expect the result
> > > > > can reach 2.8M pps/core, right?
> > > >
> > > > It's AF_XDP that claims to be 80% if my memory is correct. So a
> > > > correct AF_XDP implementation should not sit behind this too much.
> > > >
> > > > > Now the recv result is 2.5M(2463646) pps/core.
> > > > > Do you think there is a huge gap?
> > > >
> > > > You never describe your testing environment in details. For example,
> > > > is this a virtual environment? What's the CPU model and frequency e=
tc.
> > > >
> > > > Because I never see a NIC whose wire speed is 3M.
> > > >
> > > > >
> > > > > My tool makes udp packet and lookup route, so it take more much c=
pu.
> > > >
> > > > That's why I suggest you to test raw PPS.
> > >
> > > OK. Let's align some info.
> > >
> > > 1. My test env is vhost-user. Qemu + vhost-user(polling mode).
> > >    I do not use the DPDK, because that there is some trouble for me.
> > >    I use the VAPP (https://github.com/fengidri/vapp) as the vhost-use=
r device.
> > >    That has two threads all are busy mode for tx and rx.
> > >    tx thread consumes the tx ring and drop the packet.
> > >    rx thread put the packet to the rx ring.
> > >
> > > 2. My Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> > >
> > > 3. From this http://fast.dpdk.org/doc/perf/DPDK_23_03_Intel_virtio_pe=
rformance_report.pdf
> > >    I think we can align that the vhost max speed is 8.5 MPPS.
> > >    Is that ok?
> > >    And the expected AF_XDP pps is about 6 MPPS.
> > >
> > > 4. About the raw PPS, I agree that. I will test with testpmd.
> > >
> >
> > ## testpmd command
> >
> > ./build/app/dpdk-testpmd -l 1-2 --no-pci --main-lcore=3D2 \
> >         --vdev net_af_xdp0,iface=3Dens5,queue_count=3D1,busy_budget=3D0=
 \
> >         --log-level=3Dpmd.net.af_xdp:8 \
> >         -- -i -a --nb-cores=3D1 --rxq=3D1 --txq=3D1 --forward-mode=3Dma=
cswap
> >
> > ## work without the follow patch[0]
> >
> > testpmd> show port stats all
> >
> >   ######################## NIC statistics for port 0  #################=
#######
> >   RX-packets: 3615824336 RX-missed: 0          RX-bytes:  202486162816
> >   RX-errors: 0
> >   RX-nombuf:  0
> >   TX-packets: 3615795592 TX-errors: 20738      TX-bytes:  202484553152
> >
> >   Throughput (since last show)
> >   Rx-pps:      3790446          Rx-bps:   1698120056
> >   Tx-pps:      3790446          Tx-bps:   1698120056
> >   #####################################################################=
#######
> >
> >
> > ## work with the follow patch[0]
> >
> > testpmd> show port stats all
> >
> >   ######################## NIC statistics for port 0  #################=
#######
> >   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
> >   RX-errors: 0
> >   RX-nombuf:  0
> >   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
> >
> >   Throughput (since last show)
> >   Rx-pps:      6333196          Rx-bps:   2837272088
> >   Tx-pps:      6333227          Tx-bps:   2837285936
> >   #####################################################################=
#######
> >
> > I search the dpdk code that the dpdk virtio driver has the similar code.
> >
> > virtio_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb=
_pkts)
> > {
> >         [...]
> >
> >         for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
> >
> >                 [...]
> >
> >                 /* Enqueue Packet buffers */
> >                 virtqueue_enqueue_xmit(txvq, txm, slots, use_indirect,
> >                         can_push, 0);
> >         }
> >
> >         [...]
> >
> >         if (likely(nb_tx)) {
> > -->             vq_update_avail_idx(vq);
> >
> >                 if (unlikely(virtqueue_kick_prepare(vq))) {
> >                         virtqueue_notify(vq);
> >                         PMD_TX_LOG(DEBUG, "Notified backend after xmit"=
);
> >                 }
> >         }
> > }
> >
> > ## patch[0]
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 51d8f3299c10..cfe556b5d88f 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -687,12 +687,7 @@ static inline int virtqueue_add_split(struct virtq=
ueue *_vq,
> >         avail =3D vq->split.avail_idx_shadow & (vq->split.vring.num - 1=
);
> >         vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(_vq->vde=
v, head);
> >
> > -       /* Descriptors and available array need to be set before we exp=
ose the
> > -        * new available array entries. */
> > -       virtio_wmb(vq->weak_barriers);
> >         vq->split.avail_idx_shadow++;
> > -       vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> > -                                               vq->split.avail_idx_sha=
dow);
> >         vq->num_added++;
> >
> >         pr_debug("Added buffer head %i to %p\n", head, vq);
> > @@ -700,8 +695,12 @@ static inline int virtqueue_add_split(struct virtq=
ueue *_vq,
> >
> >         /* This is very unlikely, but theoretically possible.  Kick
> >          * just in case. */
> > -       if (unlikely(vq->num_added =3D=3D (1 << 16) - 1))
> > +       if (unlikely(vq->num_added =3D=3D (1 << 16) - 1)) {
> > +               virtio_wmb(vq->weak_barriers);
> > +               vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vde=
v,
> > +                                                            vq->split.=
avail_idx_shadow);
> >                 virtqueue_kick(_vq);
> > +       }
> >
> >         return 0;
> >
> > @@ -742,6 +741,9 @@ static bool virtqueue_kick_prepare_split(struct vir=
tqueue *_vq)
> >          * event. */
> >         virtio_mb(vq->weak_barriers);
> >
> > +       vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> > +                                               vq->split.avail_idx_sha=
dow);
> > +
>
> Looks like an interesting optimization.
>
> Would you mind posting this with numbers separately?

I will post this later.


>
> Btw, does the current API require virtqueue_kick_prepare() to be done
> before a virtqueue_notify(). If not, we need do something similar in
> virtqueue_notify()?

As I know, prepare is done before a notify.

I will check this doubly.

Thanks.


>
> Thanks
>
> >         old =3D vq->split.avail_idx_shadow - vq->num_added;
> >         new =3D vq->split.avail_idx_shadow;
> >         vq->num_added =3D 0;
> >
> > ---------------
> >
> > Thanks.
> >
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > I am confused.
> > > > >
> > > > >
> > > > > What is SMAP? Could you give me more information?
> > > > >
> > > > > So if we use 3M as the wire speed, you would expect the result to=
 be 2.8M
> > > > > pps/core, right?
> > > > >
> > > > > Now the recv result is 2.5M (2463646 =3D 3,343,168/1.357) pps/cor=
e. Do you think
> > > > > the difference is big?
> > > > >
> > > > > My tool makes udp packets and looks up routes, so it requires mor=
e CPU.
> > > > >
> > > > > I'm confused. Is there something I misunderstood?
> > > > >
> > > > > Thanks.
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > What I noticed is that the hotspot is the driver writin=
g virtio desc. Because
> > > > > > > > > > the device is in busy mode. So there is race between dr=
iver and device.
> > > > > > > > > > So I modified the virtio core and lazily updated avail =
idx. Then pps can reach
> > > > > > > > > > 10,000,000.
> > > > > > > > >
> > > > > > > > > Care to post a draft for this?
> > > > > > > >
> > > > > > > > YES, I is thinking for this.
> > > > > > > > But maybe that is just work for split. The packed mode has =
some troubles.
> > > > > > >
> > > > > > > Ok.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > ## maintain
> > > > > > > > > > > >
> > > > > > > > > > > > I am currently a reviewer for virtio-net. I commit =
to maintain AF_XDP support in
> > > > > > > > > > > > virtio-net.
> > > > > > > > > > > >
> > > > > > > > > > > > Please review.
> > > > > > > > > > > >
> > > > > > > > > > > > Thanks.
> > > > > > > > > > > >
> > > > > > > > > > > > v1:
> > > > > > > > > > > >     1. remove two virtio commits. Push this patchse=
t to net-next
> > > > > > > > > > > >     2. squash "virtio_net: virtnet_poll_tx support =
rescheduled" to xsk: support tx
> > > > > > > > > > > >     3. fix some warnings
> > > > > > > > > > > >
> > > > > > > > > > > > Xuan Zhuo (19):
> > > > > > > > > > > >   virtio_net: rename free_old_xmit_skbs to free_old=
_xmit
> > > > > > > > > > > >   virtio_net: unify the code for recycling the xmit=
 ptr
> > > > > > > > > > > >   virtio_net: independent directory
> > > > > > > > > > > >   virtio_net: move to virtio_net.h
> > > > > > > > > > > >   virtio_net: add prefix virtnet to all struct/api =
inside virtio_net.h
> > > > > > > > > > > >   virtio_net: separate virtnet_rx_resize()
> > > > > > > > > > > >   virtio_net: separate virtnet_tx_resize()
> > > > > > > > > > > >   virtio_net: sq support premapped mode
> > > > > > > > > > > >   virtio_net: xsk: bind/unbind xsk
> > > > > > > > > > > >   virtio_net: xsk: prevent disable tx napi
> > > > > > > > > > > >   virtio_net: xsk: tx: support tx
> > > > > > > > > > > >   virtio_net: xsk: tx: support wakeup
> > > > > > > > > > > >   virtio_net: xsk: tx: virtnet_free_old_xmit() dist=
inguishes xsk buffer
> > > > > > > > > > > >   virtio_net: xsk: tx: virtnet_sq_free_unused_buf()=
 check xsk buffer
> > > > > > > > > > > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > > > > > > > > > > >   virtio_net: xsk: rx: introduce receive_xsk() to r=
ecv xsk buffer
> > > > > > > > > > > >   virtio_net: xsk: rx: virtnet_rq_free_unused_buf()=
 check xsk buffer
> > > > > > > > > > > >   virtio_net: update tx timeout record
> > > > > > > > > > > >   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_Z=
EROCOPY
> > > > > > > > > > > >
> > > > > > > > > > > >  MAINTAINERS                                 |   2 =
+-
> > > > > > > > > > > >  drivers/net/Kconfig                         |   8 =
+-
> > > > > > > > > > > >  drivers/net/Makefile                        |   2 =
+-
> > > > > > > > > > > >  drivers/net/virtio/Kconfig                  |  13 +
> > > > > > > > > > > >  drivers/net/virtio/Makefile                 |   8 +
> > > > > > > > > > > >  drivers/net/{virtio_net.c =3D> virtio/main.c} | 65=
2 +++++++++-----------
> > > > > > > > > > > >  drivers/net/virtio/virtio_net.h             | 359 =
+++++++++++
> > > > > > > > > > > >  drivers/net/virtio/xsk.c                    | 545 =
++++++++++++++++
> > > > > > > > > > > >  drivers/net/virtio/xsk.h                    |  32 +
> > > > > > > > > > > >  9 files changed, 1247 insertions(+), 374 deletions=
(-)
> > > > > > > > > > > >  create mode 100644 drivers/net/virtio/Kconfig
> > > > > > > > > > > >  create mode 100644 drivers/net/virtio/Makefile
> > > > > > > > > > > >  rename drivers/net/{virtio_net.c =3D> virtio/main.=
c} (91%)
> > > > > > > > > > > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > > > > > > > > > > >  create mode 100644 drivers/net/virtio/xsk.c
> > > > > > > > > > > >  create mode 100644 drivers/net/virtio/xsk.h
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

