Return-Path: <bpf+bounces-18747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00A820332
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 02:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E429E1F23233
	for <lists+bpf@lfdr.de>; Sat, 30 Dec 2023 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2F410E9;
	Sat, 30 Dec 2023 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmqBYPe6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8379865A;
	Sat, 30 Dec 2023 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703898123; x=1735434123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fl2/SuRgzVqZlBIChP27OFh3BMH212QemBexgIGaErM=;
  b=PmqBYPe6zE3NoAz+7aC3BOH7xuc2i7sIR4/fOB24HDBT8lVR5nQwoiZJ
   U3+HK4RWmu1iUEND0otRvB1uW71Icw4tIff78UIiV2p2NRGlFxwi3QU6Q
   CquoLaZpZPjzLpoq10L06kz8gV/ged4AEl7+YMJimsavfXr5oD86qkw2i
   l916IzcNW4NfCnPETjQQmSwTZiNqbJi2OdTmj/kI+2EfIdz0EmWxQeFct
   SILkbDn1bRauXozrwjvwRBhJ8mEkoVHfl0uSUkRYg4Z4mBEw1gXN40ayi
   mT8b5MaYtmrHSHuPI6H6ReSGhI7v+Wu1W6Goxk5OaQfKSs7io64ENrpLG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="482869966"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="482869966"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 17:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="772072408"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="772072408"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Dec 2023 17:01:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJNjc-000Hwb-2U;
	Sat, 30 Dec 2023 01:01:52 +0000
Date: Sat, 30 Dec 2023 09:01:04 +0800
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
Subject: Re: [PATCH net-next v3 23/27] virtio_net: xsk: rx: support recv
 merge mode
Message-ID: <202312300808.efv5HGcd-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231230/202312300808.efv5HGcd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300808.efv5HGcd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300808.efv5HGcd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio/main.c: In function 'virtnet_receive':
>> drivers/net/virtio/main.c:1895:27: warning: variable 'pctx' set but not used [-Wunused-but-set-variable]
    1895 |         void *buf, *ctx, *pctx = NULL;
         |                           ^~~~


vim +/pctx +1895 drivers/net/virtio/main.c

  1889	
  1890	static int virtnet_receive(struct virtnet_rq *rq, int budget,
  1891				   unsigned int *xdp_xmit)
  1892	{
  1893		struct virtnet_info *vi = rq->vq->vdev->priv;
  1894		struct virtnet_rq_stats stats = {};
> 1895		void *buf, *ctx, *pctx = NULL;
  1896		unsigned int len;
  1897		int packets = 0;
  1898		int i;
  1899	
  1900		if (rq->xsk.pool) {
  1901			struct sk_buff *skb;
  1902	
  1903			while (packets < budget) {
  1904				buf = virtqueue_get_buf(rq->vq, &len);
  1905				if (!buf)
  1906					break;
  1907	
  1908				skb = virtnet_receive_xsk_buf(vi, rq, buf, len, xdp_xmit, &stats);
  1909				if (skb)
  1910					virtnet_receive_done(vi, rq, skb);
  1911	
  1912				packets++;
  1913			}
  1914		} else {
  1915			if (!vi->big_packets || vi->mergeable_rx_bufs)
  1916				pctx = &ctx;
  1917			else
  1918				ctx = NULL;
  1919	
  1920			while (packets < budget) {
  1921				buf = virtnet_rq_get_buf(rq, &len, &ctx);
  1922				if (!buf)
  1923					break;
  1924	
  1925				receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
  1926				packets++;
  1927			}
  1928		}
  1929	
  1930		if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
  1931			if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
  1932				spin_lock(&vi->refill_lock);
  1933				if (vi->refill_enabled)
  1934					schedule_delayed_work(&vi->refill, 0);
  1935				spin_unlock(&vi->refill_lock);
  1936			}
  1937		}
  1938	
  1939		u64_stats_set(&stats.packets, packets);
  1940		u64_stats_update_begin(&rq->stats.syncp);
  1941		for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
  1942			size_t offset = virtnet_rq_stats_desc[i].offset;
  1943			u64_stats_t *item, *src;
  1944	
  1945			item = (u64_stats_t *)((u8 *)&rq->stats + offset);
  1946			src = (u64_stats_t *)((u8 *)&stats + offset);
  1947			u64_stats_add(item, u64_stats_read(src));
  1948		}
  1949		u64_stats_update_end(&rq->stats.syncp);
  1950	
  1951		return packets;
  1952	}
  1953	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

