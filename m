Return-Path: <bpf+bounces-5273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BA759323
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8451C20FBE
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D172125CA;
	Wed, 19 Jul 2023 10:33:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54BC8CC;
	Wed, 19 Jul 2023 10:33:57 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67A9D;
	Wed, 19 Jul 2023 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689762834; x=1721298834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3SNLOoqbWWFCQ8VFNEXapHXEAc1Q3bC2YRtCrjpFgLw=;
  b=Zg/aqH9iH+3hrQUcK6y8s5T8cuW1uMKNIncBP3prP+/5v2ZEKUUHxH29
   PmHBdwi7+BZmuLQV5q2RDPWtCwAgIOZ2KPIYqzAioiA8hzd+YamKhoMB3
   jvAlPlujh8VDhkdjYNznVVZ3HQ5iXQfHopoyuWZDuH+7X8/bjvqo8qnRS
   mJ9uVg6YZlW0ifo+USP6bJu4lftLb4nj76gPn1IBXjZwORMAwaHA3tPaC
   uLZFwHfB+2zspUthTW9iZD+nzYZ+uYjUzva0nasYjufu9b4wlCynw5Qon
   lWJT3BzY0B2LB3cnUIf8F0RZZ/BL1Ij+zfGvE5i9Kh/eHrLf96tllTx2N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397282772"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397282772"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 03:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="674247426"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674247426"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 03:33:51 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qM4VC-0004gD-1C;
	Wed, 19 Jul 2023 10:33:50 +0000
Date: Wed, 19 Jul 2023 18:33:05 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v12 10/10] virtio_net: merge dma operations when
 filling mergeable buffers
Message-ID: <202307191819.0tatknWa-lkp@intel.com>
References: <20230719040422.126357-11-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719040422.126357-11-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.4]
[cannot apply to mst-vhost/linux-next linus/master v6.5-rc2 v6.5-rc1 next-20230719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-check-use_dma_api-before-unmap-desc-for-indirect/20230719-121424
base:   v6.4
patch link:    https://lore.kernel.org/r/20230719040422.126357-11-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost v12 10/10] virtio_net: merge dma operations when filling mergeable buffers
config: i386-randconfig-i006-20230718 (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191819.0tatknWa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191819.0tatknWa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio_net.c: In function 'virtnet_rq_init_one_sg':
>> drivers/net/virtio_net.c:624:41: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     624 |                 rq->sg[0].dma_address = (dma_addr_t)addr;
         |                                         ^
   drivers/net/virtio_net.c: In function 'virtnet_rq_alloc':
>> drivers/net/virtio_net.c:682:28: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     682 |                 *sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
         |                            ^


vim +624 drivers/net/virtio_net.c

   619	
   620	static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *addr, u32 len)
   621	{
   622		if (rq->do_dma) {
   623			sg_init_table(rq->sg, 1);
 > 624			rq->sg[0].dma_address = (dma_addr_t)addr;
   625			rq->sg[0].length = len;
   626		} else {
   627			sg_init_one(rq->sg, addr, len);
   628		}
   629	}
   630	
   631	static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size,
   632				      void **sg_addr, gfp_t gfp)
   633	{
   634		struct page_frag *alloc_frag = &rq->alloc_frag;
   635		struct virtnet_rq_dma *dma;
   636		struct device *dev;
   637		void *buf, *head;
   638		dma_addr_t addr;
   639	
   640		if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
   641			return NULL;
   642	
   643		head = (char *)page_address(alloc_frag->page);
   644	
   645		if (rq->do_dma) {
   646			dma = head;
   647	
   648			/* new pages */
   649			if (!alloc_frag->offset) {
   650				if (rq->last_dma) {
   651					/* Now, the new page is allocated, the last dma
   652					 * will not be used. So the dma can be unmapped
   653					 * if the ref is 0.
   654					 */
   655					virtnet_rq_unmap(rq, rq->last_dma, 0);
   656					rq->last_dma = NULL;
   657				}
   658	
   659				dev = virtqueue_dma_dev(rq->vq);
   660	
   661				dma->len = alloc_frag->size - sizeof(*dma);
   662	
   663				addr = dma_map_single_attrs(dev, dma + 1, dma->len, DMA_FROM_DEVICE, 0);
   664				if (addr == DMA_MAPPING_ERROR)
   665					return NULL;
   666	
   667				dma->addr = addr;
   668				dma->need_sync = dma_need_sync(dev, addr);
   669	
   670				/* Add a reference to dma to prevent the entire dma from
   671				 * being released during error handling. This reference
   672				 * will be freed after the pages are no longer used.
   673				 */
   674				get_page(alloc_frag->page);
   675				dma->ref = 1;
   676				alloc_frag->offset = sizeof(*dma);
   677	
   678				rq->last_dma = dma;
   679			}
   680	
   681			++dma->ref;
 > 682			*sg_addr = (void *)(dma->addr + alloc_frag->offset - sizeof(*dma));
   683		} else {
   684			*sg_addr = head + alloc_frag->offset;
   685		}
   686	
   687		buf = head + alloc_frag->offset;
   688	
   689		get_page(alloc_frag->page);
   690		alloc_frag->offset += size;
   691	
   692		return buf;
   693	}
   694	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

