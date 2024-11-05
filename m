Return-Path: <bpf+bounces-44051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B29BD16B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDE11C20C11
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80711DE2A9;
	Tue,  5 Nov 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xne3BHfu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BD1E25FC
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822320; cv=none; b=TqqZKCLsKXfJSagWpplDswDlr8qBUkKbkr459ekdjl8Td9bdeWMfEqj5We76PUuolev/x6iA+6Rq4O59NTJkxoGwW3gIJzRcXcxFJmRiY5kYncT7JdzKEM1u/Sp5hGTytBXw9+jCTS9BwwQsUWFd2nO2D0dExQFVEVs9RXrVVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822320; c=relaxed/simple;
	bh=Q/y9vOpTykXgYrQoKuWRZ+1nv2SoQIiyeDAcyGYSW0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7YcfWccEXzcAV7pRSLPb9CizmC2j/bitzOoWP6TCn2blpKAIupdP1+R+HYCy3CR8fD9lIyfuO39h6nWCejxpy0ipzFBXXvPyBPZvaiyQNMq2lgWIJ0OIvkSu22CASuFK6R8XXzL6kqFi9VItZvdSPq931kjoED0jIzuLR2DBzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xne3BHfu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730822318; x=1762358318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q/y9vOpTykXgYrQoKuWRZ+1nv2SoQIiyeDAcyGYSW0I=;
  b=Xne3BHfukjWs18vFCcx8a2KASLoXyLGNPH9HzTRXdpo8P69vzYZePS96
   l1hiKBWGkUTmYvLZENp09wBQgdOcj15bGQVxzh9vq9RkvyJjjCiECg4Qu
   AGMHCP313uBp+SRCUJp1vbbHlgrtmxIz9JPmu9xdowMeLy99z0YzIgXno
   nPR60WWLr+igyzYIr8451YMvWujpTuxeOQiegOlfP9Y1BEeqUAUwRnDdx
   74fdNeS8xk/dV7eS8Un+OjULF8CG1Aa1VQXAgDVMjcOI7DGPqKwEEYXxP
   TLO0+T/j/jSRRK0Z49fC4MHt48vDihebxaZlHy8NB6mP++sHpu/8tOopY
   A==;
X-CSE-ConnectionGUID: XAstSMe2SSup9EYYQk2EDw==
X-CSE-MsgGUID: c/JxOl8zRxCpPcGvgZ99LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="41976446"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="41976446"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:58:38 -0800
X-CSE-ConnectionGUID: BTNINd6BQHe8MZCjfF5MUw==
X-CSE-MsgGUID: etmk2V29Rei+8saJ95Mtkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="121550940"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2024 07:58:35 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8Lwu-000mCF-1r;
	Tue, 05 Nov 2024 15:58:32 +0000
Date: Tue, 5 Nov 2024 23:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net, andrii@kernel.org,
	memxor@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/2] bpf: Switch bpf arena to use drm_mm instead
 of maple_tree
Message-ID: <202411052322.GENc72sg-lkp@intel.com>
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
config: sparc-randconfig-r061-20241105 (https://download.01.org/0day-ci/archive/20241105/202411052322.GENc72sg-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411052322.GENc72sg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411052322.GENc72sg-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: lib/drm_mm.o: in function `drm_mm_takedown':
>> lib/drm_mm.c:135:(.text+0x470): undefined reference to `__drm_err'
>> sparc64-linux-ld: lib/drm_mm.c:129:(.text+0x4ac): undefined reference to `__drm_err'


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

