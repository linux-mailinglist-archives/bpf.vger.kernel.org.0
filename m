Return-Path: <bpf+bounces-18746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407B82032C
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 01:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C931C219B3
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 00:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9F64F;
	Sat, 30 Dec 2023 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goIuKf88"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632907F;
	Sat, 30 Dec 2023 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703896138; x=1735432138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+qStPU0nZNPUJ75qySDvHcPxamWqfgmF4KGOB/CSmI4=;
  b=goIuKf88iaRBvTmirJqjQeohyGW9p2DFpS2nqg2Jfq/u69w7QMT5Fs47
   NTzCWuvaJ9iqxmG97mSp8Aas3U+ZPUgR4O6aj4ghoQGlrEvqSbdZWPD0U
   cgZ4UH/Oio8+vsrcOlHQ/3WZdj+3yM52D0OF8E7AzWts9DKCKhnA2wMfg
   7/J0TxSk/K8FMsb99ramxC/G9rC/XnsaeFSr/zb9ExBV7P5cZ4sNZknuJ
   CQHWX4bk8lZU76YQI8kuGIdt1bA6SjGjNeKBI6BXnGvgzU2ZKM9n9fxLY
   LhEIK5UnXGyDkUyzX59jdTo0KH+CLeD2hUxFyJonI6qJntj+M3/9Yvnls
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="15326937"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="15326937"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 16:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="897649074"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="897649074"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Dec 2023 16:28:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJNDf-000Hub-2P;
	Sat, 30 Dec 2023 00:28:51 +0000
Date: Sat, 30 Dec 2023 08:28:24 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 16/27] virtio_net: xsk: tx: support xmit xsk
 buffer
Message-ID: <202312300834.bOCLH0Mi-lkp@intel.com>
References: <20231229073108.57778-17-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229073108.57778-17-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[cannot apply to net-next/main linus/master horms-ipvs/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-rename-free_old_xmit_skbs-to-free_old_xmit/20231229-155253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20231229073108.57778-17-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next v3 16/27] virtio_net: xsk: tx: support xmit xsk buffer
config: x86_64-randconfig-004-20231229 (https://download.01.org/0day-ci/archive/20231230/202312300834.bOCLH0Mi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300834.bOCLH0Mi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300834.bOCLH0Mi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'virtnet_xsk_xmit_one',
       inlined from 'virtnet_xsk_xmit_batch' at drivers/net/virtio/xsk.c:58:9,
       inlined from 'virtnet_xsk_xmit' at drivers/net/virtio/xsk.c:80:9:
>> drivers/net/virtio/xsk.c:34:16: warning: 'virtqueue_add_outbuf' accessing 32 bytes in a region of size 8 [-Wstringop-overflow=]
      34 |         return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      35 |                                     virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio/xsk.c:34:16: note: referencing argument 2 of type 'struct scatterlist[0]'
   In file included from include/linux/virtio_config.h:7,
                    from include/uapi/linux/virtio_net.h:30,
                    from include/linux/virtio_net.h:8,
                    from drivers/net/virtio/virtio_net.h:8,
                    from drivers/net/virtio/xsk.c:6:
   include/linux/virtio.h: In function 'virtnet_xsk_xmit':
   include/linux/virtio.h:42:5: note: in a call to function 'virtqueue_add_outbuf'
      42 | int virtqueue_add_outbuf(struct virtqueue *vq,
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/virtqueue_add_outbuf +34 drivers/net/virtio/xsk.c

    16	
    17	static int virtnet_xsk_xmit_one(struct virtnet_sq *sq,
    18					struct xsk_buff_pool *pool,
    19					struct xdp_desc *desc)
    20	{
    21		struct virtnet_info *vi;
    22		dma_addr_t addr;
    23	
    24		vi = sq->vq->vdev->priv;
    25	
    26		addr = xsk_buff_raw_get_dma(pool, desc->addr);
    27		xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
    28	
    29		sg_init_table(sq->sg, 2);
    30	
    31		sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
    32		sg_fill_dma(sq->sg + 1, addr, desc->len);
    33	
  > 34		return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
    35					    virtnet_xsk_to_ptr(desc->len), GFP_ATOMIC);
    36	}
    37	
    38	static int virtnet_xsk_xmit_batch(struct virtnet_sq *sq,
    39					  struct xsk_buff_pool *pool,
    40					  unsigned int budget,
    41					  u64 *kicks)
    42	{
    43		struct xdp_desc *descs = pool->tx_descs;
    44		u32 nb_pkts, max_pkts, i;
    45		bool kick = false;
    46		int err;
    47	
    48		/* Every xsk tx packet needs two desc(virtnet header and packet). So we
    49		 * use sq->vq->num_free / 2 as the limitation.
    50		 */
    51		max_pkts = min_t(u32, budget, sq->vq->num_free / 2);
    52	
    53		nb_pkts = xsk_tx_peek_release_desc_batch(pool, max_pkts);
    54		if (!nb_pkts)
    55			return 0;
    56	
    57		for (i = 0; i < nb_pkts; i++) {
  > 58			err = virtnet_xsk_xmit_one(sq, pool, &descs[i]);
    59			if (unlikely(err))
    60				break;
    61	
    62			kick = true;
    63		}
    64	
    65		if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
    66			(*kicks)++;
    67	
    68		return i;
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

