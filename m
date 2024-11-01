Return-Path: <bpf+bounces-43733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05499B91E0
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 14:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26531C24E1E
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DB19D080;
	Fri,  1 Nov 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EK25B39Y"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591B4174A;
	Fri,  1 Nov 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467246; cv=none; b=eTeccNU8VlAKbElHKAb+MpBUFiAsROhvCM8OgzAXGPbbI90v6iAUgy1gDGQALlNOnA6Hvh/BpYvMlTPaTZfRY/OUsj+le9pwEwKfwKTHwetVSAou0b9DdFwU5q4NmkbEReiR4oblXWd0l39bbHSrqn9dpeoDVlNSj3Zjzy6CNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467246; c=relaxed/simple;
	bh=b7r+EX0GsEYymviFMbe9ZL94rMKhxr0fKHNIMl7xvt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIDDXSH8WEpvcqLNmj8ERj3k3jd+KNhoPnQ/TkBr7IDVHMX25HJ7+sdIVodXqDGjdsyuR9PnmcIBG+dDQO4fu+9XRsqrawXF/EU3e1f80JizO+YZCg6buag4uDDnvTOzq/0UbfCmy4HAjxe8yZMtYPjABFemw+WaABBzFhPnamc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EK25B39Y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467244; x=1762003244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b7r+EX0GsEYymviFMbe9ZL94rMKhxr0fKHNIMl7xvt0=;
  b=EK25B39YYw9yEGWLRpxAFUHogYtjbm4FJzZV6j6+jbha6Y13uBWVipgS
   M6DqxvpA3FjvVuQgdBBW4zfiZX/0Rp8RAyedA+eMkVboJar5Yb5zmeQ2/
   ugl9EXIHX0K22+NLj00xTp6HYCfkJnRNuDqZqCNJJtzs+8CdAzwcnmIkq
   aT6kP9gtkbSyhV4fRPzHA6cZWtynnJ3iY7qTB7jV+JWk/+TVvydVCHwBR
   LyeejnMRqWm0jxc5bU1pcISserjmXTnBFHeBdWiN6pz12UI57nk8a9Aap
   D0WUiFsEUPr90x1hZMgV5RMjzVS7PG4+Kx4L18BWcaIxJo/C5FnLKaqHs
   A==;
X-CSE-ConnectionGUID: QHI1QfyDQLa4ZlDE7VH/UA==
X-CSE-MsgGUID: 0jrZwGdsRmGb7/otqaMGsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33921240"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33921240"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:20:43 -0700
X-CSE-ConnectionGUID: Z20rBfn5TBS+L23+2Ab4lA==
X-CSE-MsgGUID: d8ErgaJoT5yYpo74GT4tsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="120414829"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Nov 2024 06:20:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6rZs-000hZl-2E;
	Fri, 01 Nov 2024 13:20:36 +0000
Date: Fri, 1 Nov 2024 21:20:05 +0800
From: kernel test robot <lkp@intel.com>
To: mrpre <mrpre@163.com>, yonghong.song@linux.dev,
	john.fastabend@gmail.com, martin.lau@kernel.org,
	edumazet@google.com, jakub@cloudflare.com, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mrpre <mrpre@163.com>
Subject: Re: [PATCH 1/2] bpf: Introduce cpu affinity for sockmap
Message-ID: <202411012119.5fFOfrH9-lkp@intel.com>
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
config: i386-buildonly-randconfig-001-20241101 (https://download.01.org/0day-ci/archive/20241101/202411012119.5fFOfrH9-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411012119.5fFOfrH9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411012119.5fFOfrH9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/syscall.c:4:
   In file included from include/linux/bpf.h:21:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/bpf/syscall.c:254:59: error: too many arguments to function call, expected 4, have 5
     254 |                 return sock_map_update_elem_sys(map, key, value, flags, target_cpu);
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~                         ^~~~~~~~~~
   include/linux/bpf.h:3175:19: note: 'sock_map_update_elem_sys' declared here
    3175 | static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
         |                   ^                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    3176 |                                            u64 flags)
         |                                            ~~~~~~~~~
   kernel/bpf/syscall.c:5961:30: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    5961 |         .arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
         |                           ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   kernel/bpf/syscall.c:6011:41: warning: bitwise operation between different enumeration types ('enum bpf_arg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
    6011 |         .arg4_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_WRITE | MEM_ALIGNED,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~
   3 warnings and 1 error generated.


vim +254 kernel/bpf/syscall.c

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

