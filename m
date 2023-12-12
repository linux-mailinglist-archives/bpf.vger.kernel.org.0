Return-Path: <bpf+bounces-17592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E280F9B1
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E41C20DCD
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 21:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8AC64CD7;
	Tue, 12 Dec 2023 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOnfHrn4"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3EDE4;
	Tue, 12 Dec 2023 13:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702417630; x=1733953630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0mWQEe17c6d1pEUZXCBP0jonexlm/pdHfLDHkhLBifY=;
  b=lOnfHrn4HxFFIgmx9GdVcWszQ12ZywvqOO43Mnsu61xCjNiaM7A2SgCM
   pt5yAH6VWaXTyNLiaKjTkDbtUc2eCFdonJoBdGRsv2j5dVWbCjR8JzcwG
   1I0EhnqVWNA56Mzk+2RxbB0w++JzLbtouCNuePlNRFnefJl1Q09tBEg+y
   eyCUAYMISO7k3rUGTokwv9RJYrAPXSQe9uRcx92h7ucY+ZlGpibhwoH8C
   rEWJiZBfIvcu2jydEdE7GQhTxvJodPL29E8qwo3Mbf2Ps0uukOBZIvoyq
   C7Zx6CQTUQieB5SK5ei4yclGzd7pB3MaCz2ZNvGd/hSjnL0lUqSUnMpbc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481074734"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="481074734"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864375324"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864375324"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 13:47:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDAam-000JlX-18;
	Tue, 12 Dec 2023 21:47:04 +0000
Date: Wed, 13 Dec 2023 05:46:24 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org,
	hawk@kernel.org, toke@redhat.com, willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v4 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
Message-ID: <202312130546.Kst7VY7F-lkp@intel.com>
References: <2a267c8f331996de0e26568472c45fe78eb67e1d.1702375338.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a267c8f331996de0e26568472c45fe78eb67e1d.1702375338.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-introduce-page_pool-pointer-in-softnet_data-percpu-struct/20231212-181103
base:   net-next/main
patch link:    https://lore.kernel.org/r/2a267c8f331996de0e26568472c45fe78eb67e1d.1702375338.git.lorenzo%40kernel.org
patch subject: [PATCH v4 net-next 1/3] net: introduce page_pool pointer in softnet_data percpu struct
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231213/202312130546.Kst7VY7F-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130546.Kst7VY7F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130546.Kst7VY7F-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: init/main.o: warning: relocation in read-only section `.ref.text'
   /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   /usr/bin/ld: net/core/dev.o: in function `net_dev_init':
>> net/core/dev.c:11734: undefined reference to `page_pool_create'
   /usr/bin/ld: warning: creating DT_TEXTREL in a PIE
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +11734 net/core/dev.c

 11667	
 11668	/*
 11669	 *	Initialize the DEV module. At boot time this walks the device list and
 11670	 *	unhooks any devices that fail to initialise (normally hardware not
 11671	 *	present) and leaves us with a valid list of present and active devices.
 11672	 *
 11673	 */
 11674	
 11675	#define SD_PAGE_POOL_RING_SIZE	256
 11676	/*
 11677	 *       This is called single threaded during boot, so no need
 11678	 *       to take the rtnl semaphore.
 11679	 */
 11680	static int __init net_dev_init(void)
 11681	{
 11682		struct softnet_data *sd;
 11683		int i, rc = -ENOMEM;
 11684	
 11685		BUG_ON(!dev_boot_phase);
 11686	
 11687		net_dev_struct_check();
 11688	
 11689		if (dev_proc_init())
 11690			goto out;
 11691	
 11692		if (netdev_kobject_init())
 11693			goto out;
 11694	
 11695		INIT_LIST_HEAD(&ptype_all);
 11696		for (i = 0; i < PTYPE_HASH_SIZE; i++)
 11697			INIT_LIST_HEAD(&ptype_base[i]);
 11698	
 11699		if (register_pernet_subsys(&netdev_net_ops))
 11700			goto out;
 11701	
 11702		/*
 11703		 *	Initialise the packet receive queues.
 11704		 */
 11705	
 11706		for_each_possible_cpu(i) {
 11707			struct work_struct *flush = per_cpu_ptr(&flush_works, i);
 11708			struct page_pool_params page_pool_params = {
 11709				.pool_size = SD_PAGE_POOL_RING_SIZE,
 11710				.nid = NUMA_NO_NODE,
 11711			};
 11712	
 11713			INIT_WORK(flush, flush_backlog);
 11714	
 11715			sd = &per_cpu(softnet_data, i);
 11716			skb_queue_head_init(&sd->input_pkt_queue);
 11717			skb_queue_head_init(&sd->process_queue);
 11718	#ifdef CONFIG_XFRM_OFFLOAD
 11719			skb_queue_head_init(&sd->xfrm_backlog);
 11720	#endif
 11721			INIT_LIST_HEAD(&sd->poll_list);
 11722			sd->output_queue_tailp = &sd->output_queue;
 11723	#ifdef CONFIG_RPS
 11724			INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
 11725			sd->cpu = i;
 11726	#endif
 11727			INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
 11728			spin_lock_init(&sd->defer_lock);
 11729	
 11730			init_gro_hash(&sd->backlog);
 11731			sd->backlog.poll = process_backlog;
 11732			sd->backlog.weight = weight_p;
 11733	
 11734			sd->page_pool = page_pool_create(&page_pool_params);
 11735			if (IS_ERR(sd->page_pool)) {
 11736				sd->page_pool = NULL;
 11737				goto out;
 11738			}
 11739			page_pool_set_cpuid(sd->page_pool, i);
 11740		}
 11741	
 11742		dev_boot_phase = 0;
 11743	
 11744		/* The loopback device is special if any other network devices
 11745		 * is present in a network namespace the loopback device must
 11746		 * be present. Since we now dynamically allocate and free the
 11747		 * loopback device ensure this invariant is maintained by
 11748		 * keeping the loopback device as the first device on the
 11749		 * list of network devices.  Ensuring the loopback devices
 11750		 * is the first device that appears and the last network device
 11751		 * that disappears.
 11752		 */
 11753		if (register_pernet_device(&loopback_net_ops))
 11754			goto out;
 11755	
 11756		if (register_pernet_device(&default_device_ops))
 11757			goto out;
 11758	
 11759		open_softirq(NET_TX_SOFTIRQ, net_tx_action);
 11760		open_softirq(NET_RX_SOFTIRQ, net_rx_action);
 11761	
 11762		rc = cpuhp_setup_state_nocalls(CPUHP_NET_DEV_DEAD, "net/dev:dead",
 11763					       NULL, dev_cpu_dead);
 11764		WARN_ON(rc < 0);
 11765		rc = 0;
 11766	out:
 11767		if (rc < 0) {
 11768			for_each_possible_cpu(i) {
 11769				sd = &per_cpu(softnet_data, i);
 11770				if (!sd->page_pool)
 11771					continue;
 11772	
 11773				page_pool_destroy(sd->page_pool);
 11774				sd->page_pool = NULL;
 11775			}
 11776		}
 11777	
 11778		return rc;
 11779	}
 11780	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

