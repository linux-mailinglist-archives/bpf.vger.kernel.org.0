Return-Path: <bpf+bounces-5410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6146575A469
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 04:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB951C212DF
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97DEC1;
	Thu, 20 Jul 2023 02:32:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2FE389;
	Thu, 20 Jul 2023 02:32:57 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB41BF7;
	Wed, 19 Jul 2023 19:32:55 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vno54XS_1689820369;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vno54XS_1689820369)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 10:32:50 +0800
Message-ID: <1689820301.2489104-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v12 10/10] virtio_net: merge dma operations when filling mergeable buffers
Date: Thu, 20 Jul 2023 10:31:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 oe-kbuild-all@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 kernel test robot <lkp@intel.com>
References: <20230719040422.126357-1-xuanzhuo@linux.alibaba.com>
 <20230719040422.126357-11-xuanzhuo@linux.alibaba.com>
 <202307191819.0tatknWa-lkp@intel.com>
 <20230719070450-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230719070450-mutt-send-email-mst@kernel.org>
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

On Wed, 19 Jul 2023 07:05:50 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Jul 19, 2023 at 06:33:05PM +0800, kernel test robot wrote:
> > Hi Xuan,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on v6.4]
> > [cannot apply to mst-vhost/linux-next linus/master v6.5-rc2 v6.5-rc1 next-20230719]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-check-use_dma_api-before-unmap-desc-for-indirect/20230719-121424
> > base:   v6.4
> > patch link:    https://lore.kernel.org/r/20230719040422.126357-11-xuanzhuo%40linux.alibaba.com
> > patch subject: [PATCH vhost v12 10/10] virtio_net: merge dma operations when filling mergeable buffers
> > config: i386-randconfig-i006-20230718 (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307191819.0tatknWa-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/net/virtio_net.c: In function 'virtnet_rq_init_one_sg':
> > >> drivers/net/virtio_net.c:624:41: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> >      624 |                 rq->sg[0].dma_address = (dma_addr_t)addr;
> >          |                                         ^
> >    drivers/net/virtio_net.c: In function 'virtnet_rq_alloc':
> > >> drivers/net/virtio_net.c:682:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >      682 |                 *sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
> >          |                            ^
>
>
> yea these casts are pretty creepy. I think it's possible dma_addr_t won't fit in a pointer
> or a pointer won't fit in dma_addr_t.


Yes.

I will fix this.

I hope this will not affect the review.

Thanks.


>
> >
> > vim +624 drivers/net/virtio_net.c
> >
> >    619
> >    620	static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *addr, u32 len)
> >    621	{
> >    622		if (rq->do_dma) {
> >    623			sg_init_table(rq->sg, 1);
> >  > 624			rq->sg[0].dma_address = (dma_addr_t)addr;
> >    625			rq->sg[0].length = len;
> >    626		} else {
> >    627			sg_init_one(rq->sg, addr, len);
> >    628		}
> >    629	}
> >    630
> >    631	static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size,
> >    632				      void **sg_addr, gfp_t gfp)
> >    633	{
> >    634		struct page_frag *alloc_frag = &rq->alloc_frag;
> >    635		struct virtnet_rq_dma *dma;
> >    636		struct device *dev;
> >    637		void *buf, *head;
> >    638		dma_addr_t addr;
> >    639
> >    640		if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> >    641			return NULL;
> >    642
> >    643		head = (char *)page_address(alloc_frag->page);
> >    644
> >    645		if (rq->do_dma) {
> >    646			dma = head;
> >    647
> >    648			/* new pages */
> >    649			if (!alloc_frag->offset) {
> >    650				if (rq->last_dma) {
> >    651					/* Now, the new page is allocated, the last dma
> >    652					 * will not be used. So the dma can be unmapped
> >    653					 * if the ref is 0.
> >    654					 */
> >    655					virtnet_rq_unmap(rq, rq->last_dma, 0);
> >    656					rq->last_dma = NULL;
> >    657				}
> >    658
> >    659				dev = virtqueue_dma_dev(rq->vq);
> >    660
> >    661				dma->len = alloc_frag->size - sizeof(*dma);
> >    662
> >    663				addr = dma_map_single_attrs(dev, dma + 1, dma->len, DMA_FROM_DEVICE, 0);
> >    664				if (addr == DMA_MAPPING_ERROR)
> >    665					return NULL;
> >    666
> >    667				dma->addr = addr;
> >    668				dma->need_sync = dma_need_sync(dev, addr);
> >    669
> >    670				/* Add a reference to dma to prevent the entire dma from
> >    671				 * being released during error handling. This reference
> >    672				 * will be freed after the pages are no longer used.
> >    673				 */
> >    674				get_page(alloc_frag->page);
> >    675				dma->ref = 1;
> >    676				alloc_frag->offset = sizeof(*dma);
> >    677
> >    678				rq->last_dma = dma;
> >    679			}
> >    680
> >    681			++dma->ref;
> >  > 682			*sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
> >    683		} else {
> >    684			*sg_addr = head + alloc_frag->offset;
> >    685		}
> >    686
> >    687		buf = head + alloc_frag->offset;
> >    688
> >    689		get_page(alloc_frag->page);
> >    690		alloc_frag->offset += size;
> >    691
> >    692		return buf;
> >    693	}
> >    694
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>

