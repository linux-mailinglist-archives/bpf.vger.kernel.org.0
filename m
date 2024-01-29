Return-Path: <bpf+bounces-20547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CF83FE9B
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 07:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE991F21439
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDD34C628;
	Mon, 29 Jan 2024 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYmBfSMJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2914C3CD;
	Mon, 29 Jan 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706510294; cv=none; b=ZljNmRjs3tvDArMZL2okg6ndROpjJM99enDlylPSlurCn3YSze8QUVc0YlEPUp/DxIrZIQC65EXYn9ZMSIJumBd4mLPKi4Q8GQZi0xzi+A/CXj4D/DkbYFfmXxkH0UGNhFMi2a7mNORE7XsUADUD3K3O7A53RiSCnVN1gfKruX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706510294; c=relaxed/simple;
	bh=5NOkCraDNoMKMR4c/+VXwE1pA/Y6gIItH6opGSXHh8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwNppTNWmnTPs7mmdpEJAOYZheO2blFCEfLVXvgYM4yr8HlR1hSKrUu7iVc05pGLJiB7bqcXxmRBkgknBW3SA89DUkNp1nib5FeKxAdp8Yb0VcfIR5slFu3fUv2wjodM5cdNn8E1ueWPHdtWYgHeOJoOOU/HeDw4VxARHqFqw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYmBfSMJ; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706510291; x=1738046291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NOkCraDNoMKMR4c/+VXwE1pA/Y6gIItH6opGSXHh8w=;
  b=lYmBfSMJvrMN2coHnti/rWdDPXmq5wjptuXk63lwwY1EH3TITe4a0cnM
   1CpBZbj+aO0CfRzxaNt4rImWhuu982hzruzZFxnkc9VW2a7DQe0VLPhAp
   ZPBHdDo1JmdJnwFU3wjW8W0cQx0qbZJVMWctjg5eK4HWay0olowBVVcZa
   ojFJX48vnLhT6RE9IlCgm420tNXRUZOWj3s6NkuPaPFc5mGc5i9W+FBaN
   +fg9Ps2haJcY1Ed4HhajJicVbKxMmu/t0xn4TNfSbWlY3nInf8sp5ictE
   iE+08U2Mgri0CvJFytHN2rp7Uzl567hmDZH/nFb+jch02TyavNpLIPo5a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="393299524"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="393299524"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:38:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="22003027"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jan 2024 22:38:07 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rULHR-00046S-0g;
	Mon, 29 Jan 2024 06:38:05 +0000
Date: Mon, 29 Jan 2024 14:37:40 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	sdf@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool
 allocator
Message-ID: <202401291436.jz59b9EZ-lkp@intel.com>
References: <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/net-add-generic-per-cpu-page_pool-allocator/20240128-222506
base:   net-next/main
patch link:    https://lore.kernel.org/r/5b0222d3df382c22fe0fa96154ae7b27189f7ecd.1706451150.git.lorenzo%40kernel.org
patch subject: [PATCH v6 net-next 1/5] net: add generic per-cpu page_pool allocator
config: sparc-randconfig-r123-20240129 (https://download.01.org/0day-ci/archive/20240129/202401291436.jz59b9EZ-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240129/202401291436.jz59b9EZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401291436.jz59b9EZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/dev.c:447:1: sparse: sparse: symbol '__pcpu_scope_page_pool' was not declared. Should it be static?
   net/core/dev.c:3352:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3352:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3352:23: sparse:     got unsigned int
   net/core/dev.c:3352:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3352:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3352:23: sparse:     got unsigned int
   net/core/dev.c:3352:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __wsum @@
   net/core/dev.c:3352:23: sparse:     expected unsigned int [usertype] val
   net/core/dev.c:3352:23: sparse:     got restricted __wsum
   net/core/dev.c:3352:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3352:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3352:23: sparse:     got unsigned int
   net/core/dev.c:3352:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:3352:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3352:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3352:23: sparse:     got unsigned int
   net/core/dev.c:3352:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:3352:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3352:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3352:23: sparse:     got unsigned int
   net/core/dev.c:3352:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:3352:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3352:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3352:23: sparse:     got unsigned int
   net/core/dev.c:3352:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
   net/core/dev.c:205:9: sparse: sparse: context imbalance in 'unlist_netdevice' - different lock contexts for basic block
   net/core/dev.c:3792:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:5172:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
   net/core/dev.c:8833:38: sparse: sparse: self-comparison always evaluates to false

vim +/__pcpu_scope_page_pool +447 net/core/dev.c

   446	
 > 447	DEFINE_PER_CPU_ALIGNED(struct page_pool *, page_pool);
   448	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

