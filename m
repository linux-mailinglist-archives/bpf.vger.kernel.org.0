Return-Path: <bpf+bounces-46678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7D9EDC39
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 00:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218A718890C2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D411F238D;
	Wed, 11 Dec 2024 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMTKd8Zj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84717838C
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960919; cv=none; b=AWT7D7UZ1nXsS7PZIoDCW3GegeOaWY0jQwsBL3dh6BDs5LU3/PylVM9bpsCocTta1gOqkKA1vrNUWbyqNbdLPf3DCWuAY/Nov3lwpcqqRwBayTL2kunfgbcJX3BwASaY51aNeIX/lDfcjL7JEHb9c7I5AWKQJeOQ+nnl/PSV/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960919; c=relaxed/simple;
	bh=HT9vWnuJvMkKoH6OJBts+t/Nw8Pw/TFcNjyZbryYkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOzUaHHrpgSV3PltspPG+bLQ7GKYpHjomn1WpVBDTAy/0HrDSbWJPC0k+ESCihgtbwHIYpvx9Bk+A7ZMQ3QcKA1dsw7WX0NtFtgNSaeaALL9IGOzgSMPtRi0dAa2OwajlrfljufnYYbzkRQ07AuQpsK+z8YsD/zUL0z+wZmr5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMTKd8Zj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733960917; x=1765496917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HT9vWnuJvMkKoH6OJBts+t/Nw8Pw/TFcNjyZbryYkBA=;
  b=hMTKd8ZjAF8WS1u4wB8C10XfRQQ1/DCDvTP6/UGc4mHV+DszRKCNqd82
   zXREhwGUv3pPSm/8xkR///9doD6gPsrOmhW2LbhXh3AAUlOtKs+uZNu2f
   sgQzULbMMG5uIu7TI0JdpbWggDDoJ3aOTHupTZtM6wGeAOE8J3LUcTQlU
   laAhVC89PRKP5jyoo6jN/nPux/d+Ks0QGP61mv/2DMFk4Nkx5CgFD3KrH
   oQAiXs5kJZi3HbCSXvHCdWeXHWsMi3ksXVcS68qyw7rSDJ98JDthX3pop
   jvPVlUrDPH4UqMtt8sE4mv6KIFbqs3B+C2Ye2AW8Id0SbZt1nR8vruJta
   A==;
X-CSE-ConnectionGUID: 4u82s2b7R46z7IzPZtWPeA==
X-CSE-MsgGUID: +bjEIwzVQH6Q4er4tfyIsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="33691235"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="33691235"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 15:48:36 -0800
X-CSE-ConnectionGUID: bq3i4svtSZSf5WOqLcGDeQ==
X-CSE-MsgGUID: DQbRrX2SRLOXrlcvAGAUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133384402"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2024 15:48:32 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLWRQ-0007DZ-2m;
	Wed, 11 Dec 2024 23:48:28 +0000
Date: Thu, 12 Dec 2024 07:47:41 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, memxor@gmail.com,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, houtao1@huawei.com,
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@suse.com,
	willy@infradead.org, tglx@linutronix.de, tj@kernel.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 4/6] memcg: Add __GFP_TRYLOCK support.
Message-ID: <202412120745.nnianRgw-lkp@intel.com>
References: <20241210023936.46871-5-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210023936.46871-5-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/mm-bpf-Introduce-__GFP_TRYLOCK-for-opportunistic-page-allocation/20241210-104250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241210023936.46871-5-alexei.starovoitov%40gmail.com
patch subject: [PATCH bpf-next v2 4/6] memcg: Add __GFP_TRYLOCK support.
config: x86_64-buildonly-randconfig-001-20241210 (https://download.01.org/0day-ci/archive/20241212/202412120745.nnianRgw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120745.nnianRgw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120745.nnianRgw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/memcontrol.c:1761: warning: Function parameter or struct member 'gfp_mask' not described in 'consume_stock'


vim +1761 mm/memcontrol.c

cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15  1743  
56751146238723 Sebastian Andrzej Siewior 2022-03-22  1744  static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
bf4f059954dcb2 Roman Gushchin            2020-08-06  1745  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
bf4f059954dcb2 Roman Gushchin            2020-08-06  1746  				     struct mem_cgroup *root_memcg);
bf4f059954dcb2 Roman Gushchin            2020-08-06  1747  
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1748  /**
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1749   * consume_stock: Try to consume stocked charge on this cpu.
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1750   * @memcg: memcg to consume from.
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1751   * @nr_pages: how many pages to charge.
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1752   *
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1753   * The charges will only happen if @memcg matches the current cpu's memcg
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1754   * stock, and at least @nr_pages are available in that stock.  Failure to
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1755   * service an allocation will refill the stock.
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1756   *
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1757   * returns true if successful, false otherwise.
cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15  1758   */
c889f3c0bc9a18 Alexei Starovoitov        2024-12-09  1759  static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
c889f3c0bc9a18 Alexei Starovoitov        2024-12-09  1760  			  gfp_t gfp_mask)
cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15 @1761  {
cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15  1762  	struct memcg_stock_pcp *stock;
1872b3bcd5874b Breno Leitao              2024-05-01  1763  	unsigned int stock_pages;
db2ba40c277dc5 Johannes Weiner           2016-09-19  1764  	unsigned long flags;
3e32cb2e0a12b6 Johannes Weiner           2014-12-10  1765  	bool ret = false;
cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15  1766  
a983b5ebee5720 Johannes Weiner           2018-01-31  1767  	if (nr_pages > MEMCG_CHARGE_BATCH)
3e32cb2e0a12b6 Johannes Weiner           2014-12-10  1768  		return ret;
a0956d54492eb7 Suleiman Souhlal          2012-12-18  1769  
c889f3c0bc9a18 Alexei Starovoitov        2024-12-09  1770  	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
c889f3c0bc9a18 Alexei Starovoitov        2024-12-09  1771  		if (gfp_mask & __GFP_TRYLOCK)
c889f3c0bc9a18 Alexei Starovoitov        2024-12-09  1772  			return ret;
56751146238723 Sebastian Andrzej Siewior 2022-03-22  1773  		local_lock_irqsave(&memcg_stock.stock_lock, flags);
c889f3c0bc9a18 Alexei Starovoitov        2024-12-09  1774  	}
db2ba40c277dc5 Johannes Weiner           2016-09-19  1775  
db2ba40c277dc5 Johannes Weiner           2016-09-19  1776  	stock = this_cpu_ptr(&memcg_stock);
1872b3bcd5874b Breno Leitao              2024-05-01  1777  	stock_pages = READ_ONCE(stock->nr_pages);
1872b3bcd5874b Breno Leitao              2024-05-01  1778  	if (memcg == READ_ONCE(stock->cached) && stock_pages >= nr_pages) {
1872b3bcd5874b Breno Leitao              2024-05-01  1779  		WRITE_ONCE(stock->nr_pages, stock_pages - nr_pages);
3e32cb2e0a12b6 Johannes Weiner           2014-12-10  1780  		ret = true;
3e32cb2e0a12b6 Johannes Weiner           2014-12-10  1781  	}
db2ba40c277dc5 Johannes Weiner           2016-09-19  1782  
56751146238723 Sebastian Andrzej Siewior 2022-03-22  1783  	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
db2ba40c277dc5 Johannes Weiner           2016-09-19  1784  
cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15  1785  	return ret;
cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15  1786  }
cdec2e4265dfa0 KAMEZAWA Hiroyuki         2009-12-15  1787  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

