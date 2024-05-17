Return-Path: <bpf+bounces-29912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2798C80E0
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 08:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B2F1C211DC
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FA413AE2;
	Fri, 17 May 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6Avk+uq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F811CB4;
	Fri, 17 May 2024 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926875; cv=none; b=h2sSRW+Vz7jO5lsaB+21alIr77HgUDzqcMMi6BRLSPoZC6WcGZNaZDI1yxSEIJWKkIHpQfuTlArwA9uWN15vERydlOCPMF1AhI2YiK+iAXD8Nbz81JM4YbD3tFmksieV6X1zDBehkZbulAI10RKZk3UkSdDVt3aEILGbUjKVoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926875; c=relaxed/simple;
	bh=t1n4nfRLfLMuCRqkcSA82+iq1e1pf7PDp9oYA+dSCZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRDIzWowdADQatxOI9S+1mLrCccDyNwrIqZidG+AYJnfPAygdqUWqJawZkR9oBtKhdwfF0QjrstFIS1NE1VjA5FwB4WI5tR+XOavB1FB2xmhoo1OSQQ4C9H3ykmmOni7NybBKkKYAv8mwC33MkcvnnocTVO4SQtgeNj3o2rESq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6Avk+uq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715926872; x=1747462872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t1n4nfRLfLMuCRqkcSA82+iq1e1pf7PDp9oYA+dSCZI=;
  b=g6Avk+uq7XLRYSsLdZYuEsfnA2nzbeeM+SkEv2T67fl0CDH4tcaeXNR6
   WtcfzTJTXwd+WoEr43WIz47WFvEI5mUyZMhCI1dXeR9cbc+ZykirMzjCP
   OhqPw0Q3OKdpncKna5nUMnLi1nTm0EFuTERV5cp+GP7PrTU3zNBYgFkIY
   EQ3/7ODsTOjgZBeCPh+EhSDdGgp4I3oY1EAxAH5GUp5dAijNGuXdo+6dY
   hfb/k70BBaWe+7AIEIyXs/xUNv3NRD11aKfpm4J0nJJ4nVdLcTkfK1OKZ
   616En9fbGVSKb9HolYV9H96mz4Hmoc/1UWa2hGW6d3DNe0ru+klVtPQ5x
   A==;
X-CSE-ConnectionGUID: BNgPWv/9QOi+1O2MilfQBg==
X-CSE-MsgGUID: fQzjpH9yQQmAq73oeO5qaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12297788"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="12297788"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 23:21:11 -0700
X-CSE-ConnectionGUID: vqarB4vDT+KlSJ+ygLeTUg==
X-CSE-MsgGUID: 87+YUjs2Rb+CPp4takqcTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="36197809"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 23:21:07 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7qxc-0000KO-0x;
	Fri, 17 May 2024 06:21:02 +0000
Date: Fri, 17 May 2024 14:20:36 +0800
From: kernel test robot <lkp@intel.com>
To: Hou Tao <houtao@huaweicloud.com>, netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bpf@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] net/sched: unregister root_lock_key in the error path of
 qdisc_alloc()
Message-ID: <202405171402.nix3cdP7-lkp@intel.com>
References: <20240516133035.1050113-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516133035.1050113-1-houtao@huaweicloud.com>

Hi Hou,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.9]
[cannot apply to net/main net-next/main linus/master next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/net-sched-unregister-root_lock_key-in-the-error-path-of-qdisc_alloc/20240516-213538
base:   v6.9
patch link:    https://lore.kernel.org/r/20240516133035.1050113-1-houtao%40huaweicloud.com
patch subject: [PATCH] net/sched: unregister root_lock_key in the error path of qdisc_alloc()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240517/202405171402.nix3cdP7-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405171402.nix3cdP7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405171402.nix3cdP7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/sched/sch_generic.c:17:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/sched/sch_generic.c:17:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/sched/sch_generic.c:17:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> net/sched/sch_generic.c:983:31: error: no member named 'root_lock_key' in 'struct Qdisc'
     983 |         lockdep_unregister_key(&sch->root_lock_key);
         |                                 ~~~  ^
   12 warnings and 1 error generated.


vim +983 net/sched/sch_generic.c

   924	
   925	struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
   926				  const struct Qdisc_ops *ops,
   927				  struct netlink_ext_ack *extack)
   928	{
   929		struct Qdisc *sch;
   930		unsigned int size = sizeof(*sch) + ops->priv_size;
   931		int err = -ENOBUFS;
   932		struct net_device *dev;
   933	
   934		if (!dev_queue) {
   935			NL_SET_ERR_MSG(extack, "No device queue given");
   936			err = -EINVAL;
   937			goto errout;
   938		}
   939	
   940		dev = dev_queue->dev;
   941		sch = kzalloc_node(size, GFP_KERNEL, netdev_queue_numa_node_read(dev_queue));
   942	
   943		if (!sch)
   944			goto errout;
   945		__skb_queue_head_init(&sch->gso_skb);
   946		__skb_queue_head_init(&sch->skb_bad_txq);
   947		gnet_stats_basic_sync_init(&sch->bstats);
   948		spin_lock_init(&sch->q.lock);
   949	
   950		if (ops->static_flags & TCQ_F_CPUSTATS) {
   951			sch->cpu_bstats =
   952				netdev_alloc_pcpu_stats(struct gnet_stats_basic_sync);
   953			if (!sch->cpu_bstats)
   954				goto errout1;
   955	
   956			sch->cpu_qstats = alloc_percpu(struct gnet_stats_queue);
   957			if (!sch->cpu_qstats) {
   958				free_percpu(sch->cpu_bstats);
   959				goto errout1;
   960			}
   961		}
   962	
   963		spin_lock_init(&sch->busylock);
   964		lockdep_set_class(&sch->busylock,
   965				  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
   966	
   967		/* seqlock has the same scope of busylock, for NOLOCK qdisc */
   968		spin_lock_init(&sch->seqlock);
   969		lockdep_set_class(&sch->seqlock,
   970				  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
   971	
   972		sch->ops = ops;
   973		sch->flags = ops->static_flags;
   974		sch->enqueue = ops->enqueue;
   975		sch->dequeue = ops->dequeue;
   976		sch->dev_queue = dev_queue;
   977		sch->owner = -1;
   978		netdev_hold(dev, &sch->dev_tracker, GFP_KERNEL);
   979		refcount_set(&sch->refcnt, 1);
   980	
   981		return sch;
   982	errout1:
 > 983		lockdep_unregister_key(&sch->root_lock_key);
   984		kfree(sch);
   985	errout:
   986		return ERR_PTR(err);
   987	}
   988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

