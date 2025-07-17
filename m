Return-Path: <bpf+bounces-63649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05934B09384
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591B51896E74
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16C2FEE22;
	Thu, 17 Jul 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4QdZOkS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2D2FEE09;
	Thu, 17 Jul 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752774202; cv=none; b=WmEoOYsdW1ZBreSa+jAx608uQeVU4AzaioCmxFNrr7CnHoWjGBXX6NbTGCqPgp2zxKavUkKn/GSzKBiHMkA9Gei/XXaNMHrrqqoRbOMivivETDSPruEsFZZoVqTI9cI7d+fJOhBswkTjRcgTYL8AnAYJBl5aQ4EpWHBUTAOmRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752774202; c=relaxed/simple;
	bh=CJiMS990dGVpX818rZi5HfVEMHg4R/B441K8j05I2uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVO4qxpvnYuoGrz/zSyGahvPSixMdFYWCTPtEI/rlWqHbwLnLLln9obTa9aMnNHs70NGNZh/mBDOMpWKbc+e/ns1vgbJiLi6Qqg85jK/bsQFQ7Keaadi1fBmfFHCyK+vJrVtzzOPY/16ZTJNjrjArtfoI+I7ocLUBhuBeDK1fcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4QdZOkS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752774201; x=1784310201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CJiMS990dGVpX818rZi5HfVEMHg4R/B441K8j05I2uk=;
  b=a4QdZOkS+r5MId+JfAukTz8vm2KwtPgHMVPHvUqCQKepmeq5tqmGgsIi
   H97e8uiauc2FRn5P5GBaa5/fqOtg9plg+1AofIN+wZWxmfspo/DDc9dPH
   ar+JwW4MSFh7j6Pv5X7+qVA3AJKsY6/rZjNAfuwz2gGUNAnuZgNe2eeTa
   rhadbFDYTzB9skrJKWOiO5e0OaNhG1Udbmpbj7bYtS0qJjA8siapKpSOQ
   93p88lEj6/BdevZ7GAO1uHwvhn0QddCok7ikkiJNVoCHz4jc7bfYCHB+N
   MJRkrYoHn1DjmE99W3dtWIDJmclo3mXH8WJgMdDN+bXNbp2yN4zgIbMmb
   w==;
X-CSE-ConnectionGUID: oQNDc6WfShyZOeqdb8cHeA==
X-CSE-MsgGUID: 0nLAgdLYS/6R6aFu2N4Gww==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="57676277"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="57676277"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 10:43:19 -0700
X-CSE-ConnectionGUID: /ir0co3QQLuVbQ5KkAzEKg==
X-CSE-MsgGUID: kG+rBdFJQlKxmeQa6nHgEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="162391839"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Jul 2025 10:43:12 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucSdR-000DtP-2v;
	Thu, 17 Jul 2025 17:43:09 +0000
Date: Fri, 18 Jul 2025 01:42:38 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
	akpm@linux-foundation.org, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, david@redhat.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
	ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com,
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access
 ->pp through netmem_desc instead of page
Message-ID: <202507180111.jygqJHzk-lkp@intel.com>
References: <20250717070052.6358-13-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717070052.6358-13-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c65d34296b2252897e37835d6007bbd01b255742]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/netmem-introduce-struct-netmem_desc-mirroring-struct-page/20250717-150253
base:   c65d34296b2252897e37835d6007bbd01b255742
patch link:    https://lore.kernel.org/r/20250717070052.6358-13-byungchul%40sk.com
patch subject: [Intel-wired-lan] [PATCH net-next v11 12/12] libeth: xdp: access ->pp through netmem_desc instead of page
config: arm-randconfig-r072-20250717 (https://download.01.org/0day-ci/archive/20250718/202507180111.jygqJHzk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250718/202507180111.jygqJHzk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507180111.jygqJHzk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/netdevice.h:24,
                    from include/trace/events/xdp.h:8,
                    from include/linux/bpf_trace.h:5,
                    from include/net/libeth/xdp.h:7,
                    from drivers/net/ethernet/intel/libeth/tx.c:6:
   include/net/libeth/xdp.h: In function 'libeth_xdp_prepare_buff':
>> include/net/libeth/xdp.h:1295:23: warning: passing argument 1 of 'page_pool_page_is_pp' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
        pp_page_to_nmdesc(page)->pp->p.offset, len, true);
                          ^~~~
   include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
    #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
                                                                  ^
   include/net/netmem.h:301:2: note: in expansion of macro 'DEBUG_NET_WARN_ON_ONCE'
     DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));  \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/xdp.h:1295:5: note: in expansion of macro 'pp_page_to_nmdesc'
        pp_page_to_nmdesc(page)->pp->p.offset, len, true);
        ^~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/cacheflush.h:10,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from include/trace/events/xdp.h:8,
                    from include/linux/bpf_trace.h:5,
                    from include/net/libeth/xdp.h:7,
                    from drivers/net/ethernet/intel/libeth/tx.c:6:
   include/linux/mm.h:4176:54: note: expected 'struct page *' but argument is of type 'const struct page *'
    static inline bool page_pool_page_is_pp(struct page *page)
                                            ~~~~~~~~~~~~~^~~~


vim +1295 include/net/libeth/xdp.h

  1263	
  1264	bool libeth_xdp_buff_add_frag(struct libeth_xdp_buff *xdp,
  1265				      const struct libeth_fqe *fqe,
  1266				      u32 len);
  1267	
  1268	/**
  1269	 * libeth_xdp_prepare_buff - fill &libeth_xdp_buff with head FQE data
  1270	 * @xdp: XDP buffer to attach the head to
  1271	 * @fqe: FQE containing the head buffer
  1272	 * @len: buffer len passed from HW
  1273	 *
  1274	 * Internal, use libeth_xdp_process_buff() instead. Initializes XDP buffer
  1275	 * head with the Rx buffer data: data pointer, length, headroom, and
  1276	 * truesize/tailroom. Zeroes the flags.
  1277	 * Uses faster single u64 write instead of per-field access.
  1278	 */
  1279	static inline void libeth_xdp_prepare_buff(struct libeth_xdp_buff *xdp,
  1280						   const struct libeth_fqe *fqe,
  1281						   u32 len)
  1282	{
  1283		const struct page *page = __netmem_to_page(fqe->netmem);
  1284	
  1285	#ifdef __LIBETH_WORD_ACCESS
  1286		static_assert(offsetofend(typeof(xdp->base), flags) -
  1287			      offsetof(typeof(xdp->base), frame_sz) ==
  1288			      sizeof(u64));
  1289	
  1290		*(u64 *)&xdp->base.frame_sz = fqe->truesize;
  1291	#else
  1292		xdp_init_buff(&xdp->base, fqe->truesize, xdp->base.rxq);
  1293	#endif
  1294		xdp_prepare_buff(&xdp->base, page_address(page) + fqe->offset,
> 1295				 pp_page_to_nmdesc(page)->pp->p.offset, len, true);
  1296	}
  1297	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

