Return-Path: <bpf+bounces-7872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4277D918
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 05:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D447C2818EA
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 03:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86F5248;
	Wed, 16 Aug 2023 03:33:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF5322A;
	Wed, 16 Aug 2023 03:33:34 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D8E5;
	Tue, 15 Aug 2023 20:33:28 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vpu9MVY_1692156804;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vpu9MVY_1692156804)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 11:33:25 +0800
Message-ID: <1692156147.7470396-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Wed, 16 Aug 2023 11:22:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
 <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
 <1692152487.9422052-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvnVy+p8+Nro6v7Yr-m_N07200skcqwz-pCr5==sn68BQ@mail.gmail.com>
In-Reply-To: <CACGkMEvnVy+p8+Nro6v7Yr-m_N07200skcqwz-pCr5==sn68BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 16 Aug 2023 10:33:34 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Aug 16, 2023 at 10:24=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Wed, 16 Aug 2023 10:19:34 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Aug 16, 2023 at 10:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > On Wed, 16 Aug 2023 09:13:48 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Aug 15, 2023 at 5:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Tue, 15 Aug 2023 15:50:23 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Tue, Aug 15, 2023 at 2:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Hi, Jason
> > > > > > > >
> > > > > > > > Could you skip this patch?
> > > > > > >
> > > > > > > I'm fine with either merging or dropping this.
> > > > > > >
> > > > > > > >
> > > > > > > > Let we review other patches firstly?
> > > > > > >
> > > > > > > I will be on vacation soon, and won't have time to do this un=
til next week.
> > > > > >
> > > > > > Have a happly vacation.
> > > > > >
> > > > > > >
> > > > > > > But I spot two possible "issues":
> > > > > > >
> > > > > > > 1) the DMA metadata were stored in the headroom of the page, =
this
> > > > > > > breaks frags coalescing, we need to benchmark it's impact
> > > > > >
> > > > > > Not every page, just the first page of the COMP pages.
> > > > > >
> > > > > > So I think there is no impact.
> > > > >
> > > > > Nope, see this:
> > > > >
> > > > >         if (SKB_FRAG_PAGE_ORDER &&
> > > > >             !static_branch_unlikely(&net_high_order_alloc_disable=
_key)) {
> > > > >                 /* Avoid direct reclaim but allow kswapd to wake =
*/
> > > > >                 pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_=
RECLAIM) |
> > > > >                                           __GFP_COMP | __GFP_NOWA=
RN |
> > > > >                                           __GFP_NORETRY,
> > > > >                                           SKB_FRAG_PAGE_ORDER);
> > > > >                 if (likely(pfrag->page)) {
> > > > >                         pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAG=
E_ORDER;
> > > > >                         return true;
> > > > >                 }
> > > > >         }
> > > > >
> > > > > The comp page might be disabled due to the SKB_FRAG_PAGE_ORDER and
> > > > > net_high_order_alloc_disable_key.
> > > >
> > > >
> > > > YES.
> > > >
> > > > But if comp page is disabled. Then we only get one page each time. =
The pages are
> > > > not contiguous, so we don't have frags coalescing.
> > > >
> > > > If you mean the two pages got from alloc_page may be contiguous. Th=
e coalescing
> > > > may then be broken. It's a possibility, but I think the impact will=
 be small.
> > >
> > > Let's have a simple benchmark and see?
> >
> >
> > That is ok.
> >
> > I think you want to know the perf num with big traffic and the comp page
> > disabled.
>
> Yes.


Hi,

Host:
	for ((i=3D0; i < 10; ++i)) do sockperf tp -i 192.168.122.100 -t 1000  -m 6=
4000& done
Guest:
	03:23:12 AM     IFACE   rxpck/s   txpck/s    rxkB/s    txkB/s   rxcmp/s   =
txcmp/s  rxmcst/s   %ifutil
	03:23:13 AM        lo      0.00      0.00      0.00      0.00      0.00   =
   0.00      0.00      0.00
	03:23:13 AM      ens4  61848.00      1.00 3868036.73      0.58      0.00  =
    0.00      0.00      0.00

	tcpdump:
		03:25:01.741563 IP 192.168.122.1.29693 > 192.168.122.100.11111: UDP, leng=
th 64000
		03:25:01.741580 IP 192.168.122.1.22239 > 192.168.122.100.11111: UDP, leng=
th 64000
		03:25:01.741623 IP 192.168.122.1.22396 > 192.168.122.100.11111: UDP, leng=
th 64000

The Guest CPU util is low, every packet is 64000. But the Host vhost proces=
s is
100%. So we can not judge by the traffic or the cpu of the Guest.

So I use the kernel without my patches 0635819decaf9d60e6cacfecfebfabe3cbdd=
dafb.

I want to count the frags coalescing num when the comp page is disabled.

	$ sh -x test.sh
	+ sysctl -w net.core.high_order_alloc_disable=3D1
	net.core.high_order_alloc_disable =3D 1
	+ sysctl net.core.high_order_alloc_disable
	net.core.high_order_alloc_disable =3D 1
	+ sleep 5
	+ timeout 5 bpftrace -e 'kprobe: skb_coalesce_rx_frag{@[nsecs/1000/1000/10=
00]=3Dcount()}'
	Attaching 1 probe...



	+ sysctl -w net.core.high_order_alloc_disable=3D0
	net.core.high_order_alloc_disable =3D 0
	+ sysctl net.core.high_order_alloc_disable
	net.core.high_order_alloc_disable =3D 0
	+ sleep 5
	+ timeout 5 bpftrace -e 'kprobe: skb_coalesce_rx_frag{@[nsecs/1000/1000/10=
00]=3Dcount()}'
	Attaching 1 probe...


	@[356]: 167020
	@[361]: 673653
	@[359]: 900844
	@[360]: 912657
	@[358]: 915853
	@[357]: 932245


We can see that the skb_coalesce_rx_frag is not called when comp page is di=
sabled.
If the comp page is enable, there will be many frags coalescing.

So I think that my change will not have impact.

Thanks.




>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > 2) pre mapped DMA addresses were not reused in the case of XD=
P_TX/XDP_REDIRECT
> > > > > >
> > > > > > Because that the tx is not the premapped mode.
> > > > >
> > > > > Yes, we can optimize this on top.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > I see Michael has merge this series so I'm fine to let it go =
first.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

