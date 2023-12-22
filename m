Return-Path: <bpf+bounces-18629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A6881D053
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 00:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55551F215CE
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930533CDF;
	Fri, 22 Dec 2023 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsFrVmqz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D933CD3;
	Fri, 22 Dec 2023 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703286540; x=1734822540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mE+/rA1kW3jYRzqy+tN5kOQRkiH4WOFAewKMLD7BFQ8=;
  b=ZsFrVmqzpBo1YJqMEuxPvS6dTmy+4k/8ax5ylSkWFczxKJoxBds16sO+
   j5Tjy5XQoCa3HIilufKDIzvoUoQKWbS/LgebrTqiIMTCDhnwgHWLmZU9J
   KKdoeGsZr7FdyDvpevbX6KR7g4yTndBhNLmyXym2ocqJA11Z+zcONtjrk
   Uk1T3cf2YV6j/D2+VaDZXd8io05IeWQ1D/Inf4vc0Clr2x3CV6nFrk4FR
   5udnQqxBmRy5SEt/ZQfyjX6+fJVEE7RiVHYdfamZWRaRua/6Y12KlpCe7
   /OjXI6G7jama4waVNbGreaetzgtvMfKFjcT31FpsYiagz3O2jOiPV6zvS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462605125"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="462605125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 15:08:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="895619632"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="895619632"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2023 15:08:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGocX-0009y9-11;
	Fri, 22 Dec 2023 23:08:25 +0000
Date: Sat, 23 Dec 2023 07:07:25 +0800
From: kernel test robot <lkp@intel.com>
To: Philo Lu <lulie@linux.alibaba.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com, shung-hsi.yu@suse.com
Subject: Re: [PATCH bpf-next 1/3] bpf: implement relay map basis
Message-ID: <202312230638.IYDD8JOz-lkp@intel.com>
References: <20231222122146.65519-2-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222122146.65519-2-lulie@linux.alibaba.com>

Hi Philo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Philo-Lu/bpf-implement-relay-map-basis/20231222-204545
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231222122146.65519-2-lulie%40linux.alibaba.com
patch subject: [PATCH bpf-next 1/3] bpf: implement relay map basis
config: arm-randconfig-001-20231223 (https://download.01.org/0day-ci/archive/20231223/202312230638.IYDD8JOz-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d3ef86708241a3bee902615c190dead1638c4e09)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230638.IYDD8JOz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230638.IYDD8JOz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/relaymap.c:79:13: warning: address of array 'attr->map_name' will always evaluate to 'true' [-Wpointer-bool-conversion]
      79 |         if (!attr->map_name || strlen(attr->map_name) == 0)
         |             ~~~~~~~^~~~~~~~
   1 warning generated.


vim +79 kernel/bpf/relaymap.c

    43	
    44	/* bpf_attr is used as follows:
    45	 * - key size: must be 0
    46	 * - value size: value will be used as directory name by map_update_elem
    47	 *   (to create relay files). If passed as 0, it will be set to NAME_MAX as
    48	 *   default
    49	 *
    50	 * - max_entries: subbuf size
    51	 * - map_extra: subbuf num, default as 8
    52	 *
    53	 * When alloc, we do not set up relay files considering dir_name conflicts.
    54	 * Instead we use relay_late_setup_files() in map_update_elem(), and thus the
    55	 * value is used as dir_name, and map->name is used as base_filename.
    56	 */
    57	static struct bpf_map *relay_map_alloc(union bpf_attr *attr)
    58	{
    59		struct bpf_relay_map *rmap;
    60	
    61		if (unlikely(attr->map_flags & ~RELAY_CREATE_FLAG_MASK))
    62			return ERR_PTR(-EINVAL);
    63	
    64		/* key size must be 0 in relay map */
    65		if (unlikely(attr->key_size))
    66			return ERR_PTR(-EINVAL);
    67	
    68		if (unlikely(attr->value_size > NAME_MAX)) {
    69			pr_warn("value_size should be no more than %d\n", NAME_MAX);
    70			return ERR_PTR(-EINVAL);
    71		} else if (attr->value_size == 0)
    72			attr->value_size = NAME_MAX;
    73	
    74		/* set default subbuf num */
    75		attr->map_extra = attr->map_extra & UINT_MAX;
    76		if (!attr->map_extra)
    77			attr->map_extra = 8;
    78	
  > 79		if (!attr->map_name || strlen(attr->map_name) == 0)
    80			return ERR_PTR(-EINVAL);
    81	
    82		rmap = bpf_map_area_alloc(sizeof(*rmap), NUMA_NO_NODE);
    83		if (!rmap)
    84			return ERR_PTR(-ENOMEM);
    85	
    86		bpf_map_init_from_attr(&rmap->map, attr);
    87	
    88		rmap->relay_cb.create_buf_file = create_buf_file_handler;
    89		rmap->relay_cb.remove_buf_file = remove_buf_file_handler;
    90		if (attr->map_flags & BPF_F_OVERWRITE)
    91			rmap->relay_cb.subbuf_start = subbuf_start_overwrite;
    92	
    93		rmap->relay_chan = relay_open(NULL, NULL,
    94								attr->max_entries, attr->map_extra,
    95								&rmap->relay_cb, NULL);
    96		if (!rmap->relay_chan)
    97			return ERR_PTR(-EINVAL);
    98	
    99		return &rmap->map;
   100	}
   101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

