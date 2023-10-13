Return-Path: <bpf+bounces-12132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34CE7C82C5
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE49FB20AF0
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AC511CAC;
	Fri, 13 Oct 2023 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lna7iAfu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894B11C8D;
	Fri, 13 Oct 2023 10:14:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B81AD;
	Fri, 13 Oct 2023 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697192066; x=1728728066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFoqaJbduqLCyl9DPecY1ECvrkqVkONk2hKheDsUmwo=;
  b=lna7iAfuP3cluWanA94OG3qQBcTREM2x+4gawebfKypVwOA+sPgSchoB
   s7JFpUbqPCFM0nRAlDIxYDVzF8VYziq0/5A3N6t00T4lUdRY21zkhQ/IM
   R5L4vesF50vxt6ZqYBxrUVs2+8i/HmpCNykBKoP/YPBRYjSvody3Ui9up
   Tru6AnoFlzs5YGw5+iwZhIW/wlQy7u/NpD74YPSHBz6xPFhoVibqbM+L/
   iu+KB6FmBa8pS/WSkP0kJt573A292uaVkafoCzLFSP6R9MA4xuyX044KT
   HxmVuGZ82yawFwwzeNcfJLvGjZQdWsAbHRp49Kx/B2UJjQCPMMHelzx0w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416202068"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="416202068"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754653480"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="754653480"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2023 03:14:18 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qrFBQ-0004cX-1O;
	Fri, 13 Oct 2023 10:14:16 +0000
Date: Fri, 13 Oct 2023 18:13:06 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 11/22] virtio_net: sq support premapped mode
Message-ID: <202310131711.QjbkIwe0-lkp@intel.com>
References: <20231011092728.105904-12-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-12-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc5 next-20231013]
[cannot apply to mst-vhost/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-virtqueue_set_dma_premapped-support-disable/20231011-180709
base:   linus/master
patch link:    https://lore.kernel.org/r/20231011092728.105904-12-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 11/22] virtio_net: sq support premapped mode
config: parisc-randconfig-001-20231013 (https://download.01.org/0day-ci/archive/20231013/202310131711.QjbkIwe0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310131711.QjbkIwe0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310131711.QjbkIwe0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/virtio/main.c:25:
   drivers/net/virtio/virtio_net.h: In function 'virtnet_sq_unmap':
>> drivers/net/virtio/virtio_net.h:235:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     235 |         head = (void *)((u64)data & ~VIRTIO_XMIT_DATA_MASK);
         |                         ^
>> drivers/net/virtio/virtio_net.h:235:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     235 |         head = (void *)((u64)data & ~VIRTIO_XMIT_DATA_MASK);
         |                ^
   drivers/net/virtio/main.c: In function 'virtnet_sq_map_sg':
>> drivers/net/virtio/main.c:600:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     600 |         return (void *)((u64)head | ((u64)data & VIRTIO_XMIT_DATA_MASK));
         |                         ^
   drivers/net/virtio/main.c:600:38: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     600 |         return (void *)((u64)head | ((u64)data & VIRTIO_XMIT_DATA_MASK));
         |                                      ^
>> drivers/net/virtio/main.c:600:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     600 |         return (void *)((u64)head | ((u64)data & VIRTIO_XMIT_DATA_MASK));
         |                ^
   drivers/net/virtio/main.c: In function 'virtnet_find_vqs':
   drivers/net/virtio/main.c:3977:48: warning: '%d' directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
    3977 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                                                ^~
   drivers/net/virtio/main.c:3977:41: note: directive argument in the range [-2147483641, 65534]
    3977 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                                         ^~~~~~~~~~
   drivers/net/virtio/main.c:3977:17: note: 'sprintf' output between 8 and 18 bytes into a destination of size 16
    3977 |                 sprintf(vi->rq[i].name, "input.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio/main.c:3978:49: warning: '%d' directive writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
    3978 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                                 ^~
   drivers/net/virtio/main.c:3978:41: note: directive argument in the range [-2147483641, 65534]
    3978 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                                         ^~~~~~~~~~~
   drivers/net/virtio/main.c:3978:17: note: 'sprintf' output between 9 and 19 bytes into a destination of size 16
    3978 |                 sprintf(vi->sq[i].name, "output.%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +235 drivers/net/virtio/virtio_net.h

   230	
   231	static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
   232	{
   233		struct virtnet_sq_dma *next, *head;
   234	
 > 235		head = (void *)((u64)data & ~VIRTIO_XMIT_DATA_MASK);
   236	
   237		data = head->data;
   238	
   239		while (head) {
   240			virtqueue_dma_unmap_page_attrs(sq->vq, head->addr, head->len, DMA_TO_DEVICE, 0);
   241	
   242			next = head->next;
   243	
   244			head->next = sq->dmainfo.free;
   245			sq->dmainfo.free = head;
   246	
   247			head = next;
   248		}
   249	
   250		return data;
   251	}
   252	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

