Return-Path: <bpf+bounces-18743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3540820181
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 22:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54A11C21907
	for <lists+bpf@lfdr.de>; Fri, 29 Dec 2023 21:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2EC1429B;
	Fri, 29 Dec 2023 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bkm0a5h9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571A1428A;
	Fri, 29 Dec 2023 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703883831; x=1735419831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+izWk5xu+lIGF06WtqPEf5Zuf5OC+evaUFTMbMp8EHQ=;
  b=Bkm0a5h9IktP0vXDJ9hWky7llzF1o5W6LtTL+oLzFXjeXFusIShhSF0R
   pSNMkJyx7fCaWkUtxSae+tUHeANoo+0uC0wjUau/lQuYg7oaPoC1cmZe4
   3k7abOsJEfRZjCnvjWSqYK20nVPG2RKkpe7udSf9vjtjdo26zzqGaMnvJ
   AFEGb+5JrASAcbDxEb7hY1jWV4rgcJO48jEE69lf17pHlqWShNj5vA25Y
   S7KXGse/mtaoq2bnYqhe88KZ+UYTaAIXGIA0ju+aTk26HzeAw7yqJbB1v
   qAftBUJ8CBDbeR8RU1mpam4dHWHi8BjdAbe5s3668ddAs8ZfOIZqfzIcv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="376154929"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="376154929"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 13:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="1110251621"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="1110251621"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Dec 2023 13:03:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJK19-000Hof-2X;
	Fri, 29 Dec 2023 21:03:43 +0000
Date: Sat, 30 Dec 2023 05:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 23/27] virtio_net: xsk: rx: support recv
 merge mode
Message-ID: <202312300404.1R72Ssbh-lkp@intel.com>
References: <20231229073108.57778-24-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229073108.57778-24-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[cannot apply to net-next/main linus/master horms-ipvs/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-rename-free_old_xmit_skbs-to-free_old_xmit/20231229-155253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20231229073108.57778-24-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH net-next v3 23/27] virtio_net: xsk: rx: support recv merge mode
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231230/202312300404.1R72Ssbh-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300404.1R72Ssbh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300404.1R72Ssbh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/virtio/xsk.c:216:17: warning: variable 'xdp' is uninitialized when used here [-Wuninitialized]
     216 |                 xsk_buff_free(xdp);
         |                               ^~~
   drivers/net/virtio/xsk.c:210:22: note: initialize the variable 'xdp' to silence this warning
     210 |         struct xdp_buff *xdp;
         |                             ^
         |                              = NULL
   1 warning generated.


vim +/xdp +216 drivers/net/virtio/xsk.c

   202	
   203	struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, struct virtnet_rq *rq,
   204						void *buf, u32 len,
   205						unsigned int *xdp_xmit,
   206						struct virtnet_rq_stats *stats)
   207	{
   208		struct net_device *dev = vi->dev;
   209		struct sk_buff *skb = NULL;
   210		struct xdp_buff *xdp;
   211	
   212		if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
   213			pr_debug("%s: short packet %i\n", dev->name, len);
   214			DEV_STATS_INC(dev, rx_length_errors);
   215	
 > 216			xsk_buff_free(xdp);
   217			return NULL;
   218		}
   219	
   220		len -= vi->hdr_len;
   221	
   222		u64_stats_add(&stats->bytes, len);
   223	
   224		xdp = buf_to_xdp(vi, rq, buf, len);
   225		if (!xdp)
   226			return NULL;
   227	
   228		if (vi->mergeable_rx_bufs)
   229			skb = virtnet_receive_xsk_merge(dev, vi, rq, xdp, xdp_xmit, stats);
   230	
   231		return skb;
   232	}
   233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

