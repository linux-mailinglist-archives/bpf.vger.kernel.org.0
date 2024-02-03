Return-Path: <bpf+bounces-21136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D038486D7
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 15:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3667D1C216AD
	for <lists+bpf@lfdr.de>; Sat,  3 Feb 2024 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884605EE96;
	Sat,  3 Feb 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmRd9iaX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370C4C7E;
	Sat,  3 Feb 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972021; cv=none; b=mNywSITzIqJpiTXkyOhzw68IMHiA6URn7gWcVQsVOqoqdnmteWo7GH4Lx+vxCRWV5CZJtLHnOcRrTqo0i8I5IdARyN7bQnyxjeWF4Q8Uj/B6cR7UI/npHAnlX2CzlRxwK0HZaI33ZStJ8LLJ2gHafIIVHmqlIAr9VIrzgQDWSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972021; c=relaxed/simple;
	bh=8T/nZ7mIhCzPXna+zFF7zHAoFcD+3KJb/lVkzv1Pst8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuxajBXPnGcPl4N4UjBdmZgOQkTXqEhBHSt5rC0OCUuvWhMcaZ6dyM6cT09km5ndYxUXNsewIqlsSEmWeQUTjijw1713Nw4jSOL9vkOtvG4HporNv0zgK+0hPOKH8MVWZOC7ZPDlrXpsz3sgyLSfkXI5edvsjTooAaB+x6fXN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmRd9iaX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706972019; x=1738508019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8T/nZ7mIhCzPXna+zFF7zHAoFcD+3KJb/lVkzv1Pst8=;
  b=SmRd9iaXKHNDdIlFU35ZFsBbTTlwprTgpPKSYQOA+Kml+aBpJnHSCjVC
   +J1GIVJIa6IgxddqRxwJJgKbyYJ6zWcaJfgE9gadom+mfjK/hi8CN91VX
   /2/Bz8UF5QRdVngyoENQKJ5ezmUDHlbmQP147BCcP9wIg9IfOooRgFIWN
   xxNJ24VGAvOK/wu0LGRMvOsCVeFNI0xt3nDeq0+g3TN1LOESBiNlLZI9X
   796yHGovUNg9xqd854QwCf+K19UPOTU/7QEXJkNrierJW/u5ySB386OpP
   K9IIq5xV3XVXh6RinbiE2wGIFYjiBCHF/b/WjIiJXn5Zu4Y9wheN7dj6X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="22796032"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="22796032"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 06:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="646853"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Feb 2024 06:53:34 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWHOd-0005CM-0f;
	Sat, 03 Feb 2024 14:53:31 +0000
Date: Sat, 3 Feb 2024 22:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: Re: [PATCH v7 net-next 1/4] net: add generic percpu page_pool
 allocator
Message-ID: <202402032223.Imbb9JgJ-lkp@intel.com>
References: <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-add-generic-percpu-page_pool-allocator/20240202-162516
base:   net-next/main
patch link:    https://lore.kernel.org/r/1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo%40kernel.org
patch subject: [PATCH v7 net-next 1/4] net: add generic percpu page_pool allocator
config: x86_64-randconfig-121-20240203 (https://download.01.org/0day-ci/archive/20240203/202402032223.Imbb9JgJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032223.Imbb9JgJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032223.Imbb9JgJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3364:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3364:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3364:23: sparse:     got unsigned int
   net/core/dev.c:3364:23: sparse: sparse: cast from restricted __wsum
>> net/core/dev.c:11809:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct page_pool * @@
   net/core/dev.c:11809:34: sparse:     expected void const [noderef] __percpu *__vpp_verify
   net/core/dev.c:11809:34: sparse:     got struct page_pool *
   net/core/dev.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/core/dev.c:205:9: sparse: sparse: context imbalance in 'unlist_netdevice' - different lock contexts for basic block
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/core/dev.c:3804:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/core/dev.c:5184:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>> net/core/dev.c:11809:34: sparse: sparse: dereference of noderef expression

vim +11809 net/core/dev.c

 11722	
 11723	/*
 11724	 *       This is called single threaded during boot, so no need
 11725	 *       to take the rtnl semaphore.
 11726	 */
 11727	static int __init net_dev_init(void)
 11728	{
 11729		int i, rc = -ENOMEM;
 11730	
 11731		BUG_ON(!dev_boot_phase);
 11732	
 11733		net_dev_struct_check();
 11734	
 11735		if (dev_proc_init())
 11736			goto out;
 11737	
 11738		if (netdev_kobject_init())
 11739			goto out;
 11740	
 11741		INIT_LIST_HEAD(&ptype_all);
 11742		for (i = 0; i < PTYPE_HASH_SIZE; i++)
 11743			INIT_LIST_HEAD(&ptype_base[i]);
 11744	
 11745		if (register_pernet_subsys(&netdev_net_ops))
 11746			goto out;
 11747	
 11748		/*
 11749		 *	Initialise the packet receive queues.
 11750		 */
 11751	
 11752		for_each_possible_cpu(i) {
 11753			struct work_struct *flush = per_cpu_ptr(&flush_works, i);
 11754			struct softnet_data *sd = &per_cpu(softnet_data, i);
 11755	
 11756			INIT_WORK(flush, flush_backlog);
 11757	
 11758			skb_queue_head_init(&sd->input_pkt_queue);
 11759			skb_queue_head_init(&sd->process_queue);
 11760	#ifdef CONFIG_XFRM_OFFLOAD
 11761			skb_queue_head_init(&sd->xfrm_backlog);
 11762	#endif
 11763			INIT_LIST_HEAD(&sd->poll_list);
 11764			sd->output_queue_tailp = &sd->output_queue;
 11765	#ifdef CONFIG_RPS
 11766			INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
 11767			sd->cpu = i;
 11768	#endif
 11769			INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
 11770			spin_lock_init(&sd->defer_lock);
 11771	
 11772			init_gro_hash(&sd->backlog);
 11773			sd->backlog.poll = process_backlog;
 11774			sd->backlog.weight = weight_p;
 11775	
 11776			if (net_page_pool_create(i))
 11777				goto out;
 11778		}
 11779	
 11780		dev_boot_phase = 0;
 11781	
 11782		/* The loopback device is special if any other network devices
 11783		 * is present in a network namespace the loopback device must
 11784		 * be present. Since we now dynamically allocate and free the
 11785		 * loopback device ensure this invariant is maintained by
 11786		 * keeping the loopback device as the first device on the
 11787		 * list of network devices.  Ensuring the loopback devices
 11788		 * is the first device that appears and the last network device
 11789		 * that disappears.
 11790		 */
 11791		if (register_pernet_device(&loopback_net_ops))
 11792			goto out;
 11793	
 11794		if (register_pernet_device(&default_device_ops))
 11795			goto out;
 11796	
 11797		open_softirq(NET_TX_SOFTIRQ, net_tx_action);
 11798		open_softirq(NET_RX_SOFTIRQ, net_rx_action);
 11799	
 11800		rc = cpuhp_setup_state_nocalls(CPUHP_NET_DEV_DEAD, "net/dev:dead",
 11801					       NULL, dev_cpu_dead);
 11802		WARN_ON(rc < 0);
 11803		rc = 0;
 11804	out:
 11805		if (rc < 0) {
 11806			for_each_possible_cpu(i) {
 11807				struct page_pool *pp_ptr;
 11808	
 11809				pp_ptr = per_cpu_ptr(system_page_pool, i);
 11810				if (!pp_ptr)
 11811					continue;
 11812	
 11813				page_pool_destroy(pp_ptr);
 11814				per_cpu(system_page_pool, i) = NULL;
 11815			}
 11816		}
 11817	
 11818		return rc;
 11819	}
 11820	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

