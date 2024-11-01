Return-Path: <bpf+bounces-43736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D757B9B92BF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 15:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ABA284212
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BDE1A4F12;
	Fri,  1 Nov 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFKblxF1"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66B19D8A9;
	Fri,  1 Nov 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469770; cv=none; b=rzaHJx6bLhEHrZ3OtzsjHWYK26o7l1pgvmeiD+5PtJobfn3XWJ5iHqwxNwC3tcRhwMj5NlYD4VbQkd4kv67jGItrSQD92c+zGJrVDnIOmkRBn+1Wa7tus8U/rSTzlJjT7V1HwMu/3aDjoSxrQ010dSj9kNVkpHWcCtHsa0L1YkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469770; c=relaxed/simple;
	bh=o/BerWlG15TZeIiVvxiFPW0yeKnoj9S/2SLCMGpF7es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNjdbY/5qgh8WbfZ+3oCEsKK4SiZt1cMaZtbk2NYPgaJ5ts9856ONKia95wwKmYHdNGBp5TrwlwQkm+YIoEy2ya1GK8oSkian20We5CB+olcvFbUB6E8Uvjjyt0Bx4KMU8ceeCkVftmvOcGJSmdNuZs94ZVfb1iINtUIHI7D3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFKblxF1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730469768; x=1762005768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o/BerWlG15TZeIiVvxiFPW0yeKnoj9S/2SLCMGpF7es=;
  b=GFKblxF18TozMDu+Q6daK4Im/NuCiefMJoofcUeoKut3iZABmcz48M9y
   tgiqgKEP/VLlbnMsPiXyEg5vb3hkLNJVPLWyyvRAO7JSmyKQHf9vxYEj8
   /plBZwVQVfXh/LzYZK53ZG/6MgY3sU87aTyoJPhMJ5JpYo6vvnZQMcstY
   AFeZOLs7REeQbrPkt/NFh6sNOpb4K08p4tU5Wc23kG9nDpVKxUMHhzTY4
   QQIEdhVyoPxNIoIBEbffcUt6DvCZIp3atdzWMbZKnOSa0+hq5IS5CI5bt
   H2tA5iazTaTZQ3PFAYJ4vHy7EiHvH5bqwFSCeUQx/blUvvLAgYKYTDWx4
   Q==;
X-CSE-ConnectionGUID: wCOjVoiiT724Yf3/0B2B6A==
X-CSE-MsgGUID: HqqDdtbrTcWum6MwB5SBpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="29654136"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="29654136"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 07:02:44 -0700
X-CSE-ConnectionGUID: rAjQ2NzoRoOWf8nQDxqZLg==
X-CSE-MsgGUID: +vYyrcdsRN6cV+5MXDr6SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87767853"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2024 07:02:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6sEX-000hcJ-2m;
	Fri, 01 Nov 2024 14:02:37 +0000
Date: Fri, 1 Nov 2024 22:02:01 +0800
From: kernel test robot <lkp@intel.com>
To: mrpre <mrpre@163.com>, yonghong.song@linux.dev,
	john.fastabend@gmail.com, martin.lau@kernel.org,
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mrpre <mrpre@163.com>
Subject: Re: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
Message-ID: <202411012135.447KNHZK-lkp@intel.com>
References: <20241101023832.32404-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101023832.32404-1-mrpre@163.com>

Hi mrpre,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master net-next/main net/main linus/master v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mrpre/bpf-implement-libbpf-sockmap-cpu-affinity/20241101-104144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241101023832.32404-1-mrpre%40163.com
patch subject: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
config: arc-randconfig-001-20241101 (https://download.01.org/0day-ci/archive/20241101/202411012135.447KNHZK-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411012135.447KNHZK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411012135.447KNHZK-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c: In function 'bpf_map_update_value':
>> kernel/bpf/syscall.c:254:24: error: too many arguments to function 'sock_map_update_elem_sys'
     254 |                 return sock_map_update_elem_sys(map, key, value, flags, target_cpu);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/bpf/syscall.c:4:
   include/linux/bpf.h:3175:19: note: declared here
    3175 | static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/sock_map_update_elem_sys +254 kernel/bpf/syscall.c

   240	
   241	static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
   242					void *key, void *value, __u64 flags, s32 target_cpu)
   243	{
   244		int err;
   245		/* Need to create a kthread, thus must support schedule */
   246		if (bpf_map_is_offloaded(map)) {
   247			return bpf_map_offload_update_elem(map, key, value, flags);
   248		} else if (map->map_type == BPF_MAP_TYPE_CPUMAP ||
   249			   map->map_type == BPF_MAP_TYPE_ARENA ||
   250			   map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
   251			return map->ops->map_update_elem(map, key, value, flags);
   252		} else if (map->map_type == BPF_MAP_TYPE_SOCKHASH ||
   253			   map->map_type == BPF_MAP_TYPE_SOCKMAP) {
 > 254			return sock_map_update_elem_sys(map, key, value, flags, target_cpu);
   255		} else if (IS_FD_PROG_ARRAY(map)) {
   256			return bpf_fd_array_map_update_elem(map, map_file, key, value,
   257							    flags);
   258		}
   259	
   260		bpf_disable_instrumentation();
   261		if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
   262		    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
   263			err = bpf_percpu_hash_update(map, key, value, flags);
   264		} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
   265			err = bpf_percpu_array_update(map, key, value, flags);
   266		} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
   267			err = bpf_percpu_cgroup_storage_update(map, key, value,
   268							       flags);
   269		} else if (IS_FD_ARRAY(map)) {
   270			err = bpf_fd_array_map_update_elem(map, map_file, key, value,
   271							   flags);
   272		} else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
   273			err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
   274							  flags);
   275		} else if (map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY) {
   276			/* rcu_read_lock() is not needed */
   277			err = bpf_fd_reuseport_array_update_elem(map, key, value,
   278								 flags);
   279		} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
   280			   map->map_type == BPF_MAP_TYPE_STACK ||
   281			   map->map_type == BPF_MAP_TYPE_BLOOM_FILTER) {
   282			err = map->ops->map_push_elem(map, value, flags);
   283		} else {
   284			err = bpf_obj_pin_uptrs(map->record, value);
   285			if (!err) {
   286				rcu_read_lock();
   287				err = map->ops->map_update_elem(map, key, value, flags);
   288				rcu_read_unlock();
   289				if (err)
   290					bpf_obj_unpin_uptrs(map->record, value);
   291			}
   292		}
   293		bpf_enable_instrumentation();
   294	
   295		return err;
   296	}
   297	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

