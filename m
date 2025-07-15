Return-Path: <bpf+bounces-63278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7861B04CC6
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E1C1A67FEF
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D915624D;
	Tue, 15 Jul 2025 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAzUUi8D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5733F6;
	Tue, 15 Jul 2025 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538971; cv=none; b=QpHmTT7NOfRQcNnzFtFM5g1dGROXSkfgnWOZyRCbfLRY0EiaM5BCS1a0z4OPnZYbNtmAFr1ZUbVp9j54hJ3pjaqJEfR3g2yJvNMiCENAa22euVfIUWmQ76Obl5k1u7jr9T20kKfe/yVRtpHo4e/Ln3pSskslMwz5vFwxnmu3twE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538971; c=relaxed/simple;
	bh=eCmJOToBbUNkzzH7UoSQNgS/ofqXZX1DoVA8ZBxoLhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELRpQSLK11jUqTK1MWpLOOOazd6ZDvbpfwaWkfq+gnSYvdyX4JqxLSqM2/dwQ9eo63Tqb0ecvX8BcCVSmSA1EDzBJ2fxvIVlZz5/BUV65SJljvHShmyAxTo8/ZdlKb3TpY3jf6w1ENaScg7syGh26+sYorJIhHW5sxKREF193pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAzUUi8D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752538968; x=1784074968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eCmJOToBbUNkzzH7UoSQNgS/ofqXZX1DoVA8ZBxoLhU=;
  b=AAzUUi8D4fpmDzv/MKpBIQXrzx6XkVryM8Bf4wV2nYu7T/qIywqmvPkf
   w4fV7//5fxU38gBk8SMaJlQsPCChNFtjF4f56QE97RxxzUJGqkGa6TA+j
   S7VSk6JPhtsQptmrnu2IRQMCU7scAnqOXjCfZNJ2kHcTn6qOhftjySfkN
   sbUofIX/DILVqjvXlMQRDX2Wbm+JAwle1p9Q1ZqvMYItXRHLKWmKUBcKQ
   j2kdOCmKMKq7Y4+j4NJfyirLMwCLu1CPWS19qYe/ZUogAi4QEQqmXiwE8
   VZVSF99afVcRXMpbmY+RmS4SqqFObMl0v4umsmlLvlV5oD+1PBPpsEl00
   w==;
X-CSE-ConnectionGUID: DF6RFoUHQFafTZfBz49qYQ==
X-CSE-MsgGUID: 8+spjHI2QwCEZyykBT9REg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65004926"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="65004926"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 17:22:47 -0700
X-CSE-ConnectionGUID: kRCvcFopTcKF5xvCHT8KCw==
X-CSE-MsgGUID: K/ijNkWDQXWMVDSUlv4+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157174679"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Jul 2025 17:22:41 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubTRO-0009Tb-18;
	Tue, 15 Jul 2025 00:22:38 +0000
Date: Tue, 15 Jul 2025 08:21:57 +0800
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
Subject: Re: [PATCH net-next v10 12/12] libeth: xdp: access ->pp through
 netmem_desc instead of page
Message-ID: <202507150748.9sVeInO8-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on c65d34296b2252897e37835d6007bbd01b255742]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/netmem-introduce-struct-netmem_desc-mirroring-struct-page/20250714-200214
base:   c65d34296b2252897e37835d6007bbd01b255742
patch link:    https://lore.kernel.org/r/20250714120047.35901-13-byungchul%40sk.com
patch subject: [PATCH net-next v10 12/12] libeth: xdp: access ->pp through netmem_desc instead of page
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250715/202507150748.9sVeInO8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507150748.9sVeInO8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150748.9sVeInO8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/libeth/tx.c:6:
   include/net/libeth/xdp.h: In function 'libeth_xdp_prepare_buff':
>> include/net/libeth/xdp.h:1295:44: warning: passing argument 1 of 'pp_page_to_nmdesc' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1295 |                          pp_page_to_nmdesc(page)->pp->p.offset, len, true);
         |                                            ^~~~
   In file included from include/linux/skbuff.h:41,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from include/trace/events/xdp.h:8,
                    from include/linux/bpf_trace.h:5,
                    from include/net/libeth/xdp.h:7:
   include/net/netmem.h:270:66: note: expected 'struct page *' but argument is of type 'const struct page *'
     270 | static inline struct netmem_desc *pp_page_to_nmdesc(struct page *page)
         |                                                     ~~~~~~~~~~~~~^~~~


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

