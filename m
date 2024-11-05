Return-Path: <bpf+bounces-44010-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C933E9BC4BB
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A311F22544
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 05:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792A91B654E;
	Tue,  5 Nov 2024 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWjXBoyg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B418BC06
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784833; cv=none; b=l7djO1bpbYtaoGgPtM2sJOTJcahEnpPDAv8t8epAvdp1Gk2XIPZphnuYoC7gLgs7c+ooxcOu1rjiZe5iD+XluQyBgnk9YzKZ3ml+vnGqwtY5Sgtb15DHCAgjOB4k8G7Dxy6HUs6wwXFH/b2jMYP7COfebez8jT13ezR+ov7eOB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784833; c=relaxed/simple;
	bh=gmZTemamg+uRTTCOPBTd06AyJjplmSENIS5ZeSNo/WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loxWVRtgTFzaHGRb3xN5BWDavGCYWXbDEBasTD4JVLnAapk+Iigm539qpQVQr0SME6KXPQVyErA5ZFavD+4xh/91+q10mSYahZ+Tx/n8dA3YTi1uq/ZVZodQ9MbTxrEkBpV/dADn2KhUttDOCWu4NKs2zf/280oP6SkqlPaud+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWjXBoyg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730784831; x=1762320831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gmZTemamg+uRTTCOPBTd06AyJjplmSENIS5ZeSNo/WY=;
  b=dWjXBoygBC561FuK+SwGN5cknf/iAXxZdl0s76YMbKDkr9GOdBuNhXv2
   zgxfNKMSJFQaFFZ7CuPXGLvJyXifnOsfIWY3DVWCyQXtat+1TqhMGRUE/
   ioYviDRYYNOXZh5yf6OfvjaBg5Ub+jqRVNQ7zbbgM/w5BtFVYHQZWQwMs
   lIpR5MCGOebraf7APAqjXe6iDc1cAKwrtv9JnydkZf/KMzjswImUu1qXr
   934htwQsTVwAQvF48el+EQRFqno9wEt+c1lUxBXzio7kfipK1gtUszqBF
   tnm2yd2u9xInrXa884KTK6E10TTuZPK6zCMg/G+O1etgktEw2iOBDpl+2
   A==;
X-CSE-ConnectionGUID: ZxpGiSrpRxuYGAJmGxne/g==
X-CSE-MsgGUID: ic69qYDIRai1UNrTy5+WDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30622054"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="30622054"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 21:33:50 -0800
X-CSE-ConnectionGUID: Y12mQembSlSR785+eKKPcw==
X-CSE-MsgGUID: Ib2OJmGxRgWFwHmH6AEfjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="83992278"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Nov 2024 21:33:48 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8CBd-000lfl-2K;
	Tue, 05 Nov 2024 05:33:05 +0000
Date: Tue, 5 Nov 2024 13:32:09 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	memxor@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/2] bpf: Switch bpf arena to use drm_mm instead
 of maple_tree
Message-ID: <202411051357.3XLBnPy3-lkp@intel.com>
References: <20241101235453.63380-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101235453.63380-3-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/drm-bpf-Move-drm_mm-c-to-lib-to-be-used-by-bpf-arena/20241102-075645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20241101235453.63380-3-alexei.starovoitov%40gmail.com
patch subject: [PATCH bpf-next 2/2] bpf: Switch bpf arena to use drm_mm instead of maple_tree
config: i386-randconfig-003-20241104 (https://download.01.org/0day-ci/archive/20241105/202411051357.3XLBnPy3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411051357.3XLBnPy3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411051357.3XLBnPy3-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: lib/drm_mm.o: in function `show_leaks':
>> lib/drm_mm.c:135: undefined reference to `__drm_err'
>> ld: lib/drm_mm.c:129: undefined reference to `__drm_err'


vim +135 lib/drm_mm.c

5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  117  
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  118  static void show_leaks(struct drm_mm *mm)
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  119  {
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  120  	struct drm_mm_node *node;
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  121  	char *buf;
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  122  
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  123  	buf = kmalloc(BUFSZ, GFP_KERNEL);
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  124  	if (!buf)
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  125  		return;
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  126  
2bc98c86517b08 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-12-22  127  	list_for_each_entry(node, drm_mm_nodes(mm), node_list) {
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  128  		if (!node->stack) {
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31 @129  			DRM_ERROR("node [%08llx + %08llx]: unknown owner\n",
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  130  				  node->start, node->size);
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  131  			continue;
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  132  		}
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  133  
0f68d45ef41abb drivers/gpu/drm/drm_mm.c Imran Khan   2021-11-08  134  		stack_depot_snprint(node->stack, buf, BUFSZ, 0);
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31 @135  		DRM_ERROR("node [%08llx + %08llx]: inserted at\n%s",
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  136  			  node->start, node->size, buf);
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  137  	}
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  138  
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  139  	kfree(buf);
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  140  }
5705670d046342 drivers/gpu/drm/drm_mm.c Chris Wilson 2016-10-31  141  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

