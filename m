Return-Path: <bpf+bounces-11918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C2E7C5679
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81BD1C20F6F
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC220327;
	Wed, 11 Oct 2023 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1dNhFwo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0D200BC;
	Wed, 11 Oct 2023 14:15:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E827192;
	Wed, 11 Oct 2023 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697033743; x=1728569743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DuNvaLmuSBpRQ/OE9jIM2FpK9gH/+55vqfRXvHb1aOE=;
  b=g1dNhFwoFIs7RHU5h3KQ44AATkF0kyJGjDd9GPYUt2OR6fuzOB5WKkLX
   dTPCFUnxbbQsuPklDSpv72fMf6Nqg90N3PHJ3k0g02/2qiGcuxRdNoBL2
   SQ9oc/P9a9/SjshxzAdCGAKfByuDXprxUXtjk/WtduvZ4+TTbKYWYJ9xo
   t9aTi5dx3wZh+iY+AsmyW79QS1j3i0rAX2Dyo2FUg0SzgrJCT5RzuawCX
   j1yAT7oST57bf6/FGl1uNhqnU/xQ80Omf0077GY2kPjSGpaXJ1cBz/Q4/
   Pj9aElb9PpS1XnWRCuu2L8l+GbpDCy9/9JbSATn2mts4LXXVfaamx2/gN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="364036253"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="364036253"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 07:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="877693397"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="877693397"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2023 07:15:37 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qqZzF-0002ID-2k;
	Wed, 11 Oct 2023 14:15:15 +0000
Date: Wed, 11 Oct 2023 22:13:17 +0800
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
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped
 support disable
Message-ID: <202310112204.h03TUDpH-lkp@intel.com>
References: <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc5 next-20231011]
[cannot apply to mst-vhost/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-virtqueue_set_dma_premapped-support-disable/20231011-180709
base:   linus/master
patch link:    https://lore.kernel.org/r/20231011092728.105904-2-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped support disable
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231011/202310112204.h03TUDpH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310112204.h03TUDpH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310112204.h03TUDpH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virtio/virtio_ring.c:2788: warning: Function parameter or member 'mode' not described in 'virtqueue_set_dma_premapped'


vim +2788 drivers/virtio/virtio_ring.c

c790e8e1817f1a Xuan Zhuo 2022-08-01  2765  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2766  /**
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2767   * virtqueue_set_dma_premapped - set the vring premapped mode
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2768   * @_vq: the struct virtqueue we're talking about.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2769   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2770   * Enable the premapped mode of the vq.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2771   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2772   * The vring in premapped mode does not do dma internally, so the driver must
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2773   * do dma mapping in advance. The driver must pass the dma_address through
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2774   * dma_address of scatterlist. When the driver got a used buffer from
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2775   * the vring, it has to unmap the dma address.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2776   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2777   * This function must be called immediately after creating the vq, or after vq
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2778   * reset, and before adding any buffers to it.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2779   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2780   * Caller must ensure we don't call this with other virtqueue operations
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2781   * at the same time (except where noted).
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2782   *
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2783   * Returns zero or a negative error.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2784   * 0: success.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2785   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2786   */
f8d1a236ad114f Xuan Zhuo 2023-10-11  2787  int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
8daafe9ebbd21a Xuan Zhuo 2023-08-10 @2788  {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2789  	struct vring_virtqueue *vq = to_vvq(_vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2790  	u32 num;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2791  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2792  	START_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2793  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2794  	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2795  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2796  	if (num != vq->vq.num_free) {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2797  		END_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2798  		return -EINVAL;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2799  	}
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2800  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2801  	if (!vq->use_dma_api) {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2802  		END_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2803  		return -EINVAL;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2804  	}
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2805  
f8d1a236ad114f Xuan Zhuo 2023-10-11  2806  	if (mode) {
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2807  		vq->premapped = true;
b319940f83c21b Xuan Zhuo 2023-08-10  2808  		vq->do_unmap = false;
f8d1a236ad114f Xuan Zhuo 2023-10-11  2809  	} else {
f8d1a236ad114f Xuan Zhuo 2023-10-11  2810  		vq->premapped = false;
f8d1a236ad114f Xuan Zhuo 2023-10-11  2811  		vq->do_unmap = vq->use_dma_api;
f8d1a236ad114f Xuan Zhuo 2023-10-11  2812  	}
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2813  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2814  	END_USE(vq);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2815  
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2816  	return 0;
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2817  }
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2818  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
8daafe9ebbd21a Xuan Zhuo 2023-08-10  2819  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

