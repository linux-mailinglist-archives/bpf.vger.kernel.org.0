Return-Path: <bpf+bounces-29911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 421688C80BC
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 07:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4A27B20EB7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 05:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8938612E5E;
	Fri, 17 May 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCqKECc/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B11170D;
	Fri, 17 May 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925334; cv=none; b=PB/S5e+JTQ1AK5IWrICEC6yTjsOkf0JPzf/Cd6Z0VRf1D0pnaaEbxLDNvm5DmaRbfE0Ngqm4xxmsJALSBQ76i5f0CfcIbwkNM/NxcfgfpAQesq3y1L0iy8HSAwOvcq/wN2f0mfvBxzM9TBd68Owyfia13crsRmxjbGkqAYBIYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925334; c=relaxed/simple;
	bh=YqE3BWStvb9uNIMxbcNHdjLQhxDoQuJlDFCqiJH5ZgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULK0J5ZVcA4e+4C6w781wtOfR0jqkrJLZDUTe7sQcX+CRGM2GgWgPmJV631/EwNVGAEqgJieCumHTmG/s6BY78MeOgfb8/1rItBT/OycNsfmWuj4ebBZtmNi2o4c+BPFnY25hrKkkcOw4YdYon4XwwoEtHOJmAcv2JrpRMqtqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCqKECc/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715925332; x=1747461332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YqE3BWStvb9uNIMxbcNHdjLQhxDoQuJlDFCqiJH5ZgI=;
  b=PCqKECc/agYK21CisuksiHMyrlaF6aP0ZaP5+izQwPaNLebSkKZQ3ddv
   mdAcrVd3sa7S/igk4aosSlIRrpQ4f7SWEF3Au7J/mjwmSWhbTv7jRfdXH
   vGo/WOjt9ehlrZzD1WNX0Vi5We2iRxF8OB4UhM4b8TSu8DSiEPN83Q1ML
   WoEwjDjQ/F9blz8+6Snb6EXz7LXHzNIFxgsxJuSHBPO3jCdA9fIodcnqj
   GFDzTT9YocpghTp5sVV7iNHIcWyP3e7c48C9UW3wBicdmLN9Paipzojyk
   lHJ8Qqvcj6DQHI4a1NyjSy1HbVVIXdVNtZtcKm9h0YCR0uFbeeUokDG/z
   g==;
X-CSE-ConnectionGUID: Pt41iigzRYi7pCA9U74stw==
X-CSE-MsgGUID: LntxiFcHSxSlTHp+N8Fa3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11567858"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="11567858"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 22:55:31 -0700
X-CSE-ConnectionGUID: jQD61+B+Qn6h7Oi/iQlnfg==
X-CSE-MsgGUID: OzWH72DnQJWCLQrytcA//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="36421681"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 16 May 2024 22:55:27 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7qYg-0000IZ-1t;
	Fri, 17 May 2024 05:55:15 +0000
Date: Fri, 17 May 2024 13:49:41 +0800
From: kernel test robot <lkp@intel.com>
To: Hou Tao <houtao@huaweicloud.com>, netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, houtao1@huawei.com
Subject: Re: [PATCH] net/sched: unregister root_lock_key in the error path of
 qdisc_alloc()
Message-ID: <202405171311.SyRzzQjC-lkp@intel.com>
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
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240517/202405171311.SyRzzQjC-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405171311.SyRzzQjC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405171311.SyRzzQjC-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/sched/sch_generic.c: In function 'qdisc_alloc':
>> net/sched/sch_generic.c:983:36: error: 'struct Qdisc' has no member named 'root_lock_key'
     983 |         lockdep_unregister_key(&sch->root_lock_key);
         |                                    ^~


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

