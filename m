Return-Path: <bpf+bounces-63283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF4B04D8A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 03:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548584A8124
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EC2BF013;
	Tue, 15 Jul 2025 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaYijqUi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848052BEC42;
	Tue, 15 Jul 2025 01:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543958; cv=none; b=Ug2nkGCpwio0z+snvO6DiPHtB16kkfSO065iy9zUGScL7s6XYHPo0lyvIipI87eLitsot4CyuiOxlWGOFpOHNSooNahUM0tNCx+s+AZIPnQsqQfQe6J/MdxViuKg9bVIG/wVwV2Xd4ulwpag5Wp8yVnR6i2ty6sz/oWQF9/9U7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543958; c=relaxed/simple;
	bh=/swcXr2ss79nJxFip+SNNqYNuVuEmY4AkU1neU+GXDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/cHBex2ImmzWcbIaXzm6H4UpvJOLJIvgLGTvqTTnJkM1b0M7vhJWFwUH0Obx3uGAxkLF98rLiGuKvhZy7WsBVIZmO3rMyo2OuptSvZIBo6R/4KpxGTwJnmthEMAd6LPOXE/ZGZtz2lv5kkMA4jNuoroyOnxEOzwCt8lwgJUcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaYijqUi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752543956; x=1784079956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/swcXr2ss79nJxFip+SNNqYNuVuEmY4AkU1neU+GXDQ=;
  b=VaYijqUi0xfEBYEfYfCe0jZMGPeCNnnSUAdY3gFX7lRTGO/QWmV4/5V9
   EgwYbwoF9o0cVORYDFFc6oSkpfN2j1PWnZqe6HOlQRkhvLyMF40xEjz+r
   CzES+N+eVCAzDuELcrvigNym6v5yRydGoPWdUOjaPRwdjQm19U55Kp87o
   kjKzqH8da61s0LlR/1raEhvOPjkyJh9+RgS+OX31kNC+mxcEiyol1yk3t
   NeTOK6mC1l8KKK4q51vX2A2GCJwVv45iJOCf7c3CszJPj5PMSRBgshcN0
   0jUJeSeL99AgyzhGVMuiste+SyZjUZ6O+XTXGiaF6TCbB+0aYGyv0IBB9
   A==;
X-CSE-ConnectionGUID: DB6WahnkRSCAxxlDMBSjwg==
X-CSE-MsgGUID: 9ObbP/PBTLGIt6HxOGZaWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57360546"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="57360546"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 18:45:55 -0700
X-CSE-ConnectionGUID: yu+/zp4GTtKNOp/AuwsKwA==
X-CSE-MsgGUID: J3Rvn9+kRXemF9VDSSLEcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="162633732"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jul 2025 18:45:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubUjr-0009Wt-01;
	Tue, 15 Jul 2025 01:45:47 +0000
Date: Tue, 15 Jul 2025 09:45:38 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
	akpm@linux-foundation.org, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, david@redhat.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org,
	ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com,
	shenwei.wang@nxp.com, xiaoning.wang@nxp.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v10 12/12] libeth: xdp: access ->pp through
 netmem_desc instead of page
Message-ID: <202507150904.kGZOOZns-lkp@intel.com>
References: <20250714120047.35901-13-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714120047.35901-13-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on c65d34296b2252897e37835d6007bbd01b255742]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/netmem-introduce-struct-netmem_desc-mirroring-struct-page/20250714-200214
base:   c65d34296b2252897e37835d6007bbd01b255742
patch link:    https://lore.kernel.org/r/20250714120047.35901-13-byungchul%40sk.com
patch subject: [PATCH net-next v10 12/12] libeth: xdp: access ->pp through netmem_desc instead of page
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250715/202507150904.kGZOOZns-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507150904.kGZOOZns-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150904.kGZOOZns-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/libeth/tx.c:6:
>> include/net/libeth/xdp.h:1295:23: error: passing 'const struct page *' to parameter of type 'struct page *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    1295 |                          pp_page_to_nmdesc(page)->pp->p.offset, len, true);
         |                                            ^~~~
   include/net/netmem.h:270:66: note: passing argument to parameter 'page' here
     270 | static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
         |                                                                  ^
   1 error generated.


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

