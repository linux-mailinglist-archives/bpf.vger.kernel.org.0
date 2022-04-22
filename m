Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A850B461
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446239AbiDVJvj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446235AbiDVJvi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 05:51:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B581B51E74;
        Fri, 22 Apr 2022 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650620925; x=1682156925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vma2JAAflaYLfOe4eF4oOn15MNm91+/GB/OVlVEPwLg=;
  b=e5aTgxiWv1d5liAyBirA/ouqn73RVaOaI8mr3B9dSHy98lLkKMuAC1cS
   2/rK2ZjgqKLUViK1zEncmgAp9iwJL0qqIYzZAfvJO5vYy9SdKqOVHmdjx
   o1oCumFGXCJDNmLtkyBx7V01lF5YOxkA2rB+068fOBkE5s61aA8JoWXS0
   2q/eRtpiC376VZf2+Akq/m5gSQ1Q1hhGmK3VSsxEfGZ0YqZk6VjYiY/gu
   dIW53CrSgZBKjUyAanxgrzhcQRfdCr9r5arqNqpnGUXGwDhZdWz5VOH9a
   9MFHpsecIrydCtXuAhcb3yOaCls0IBLC8UvTdlRINK9zrhgqmVV0hgCfW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246538795"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="246538795"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 02:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="562986197"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2022 02:48:42 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhpu5-0009zt-G7;
        Fri, 22 Apr 2022 09:48:41 +0000
Date:   Fri, 22 Apr 2022 17:48:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf 3/4] module: introduce module_alloc_huge
Message-ID: <202204221700.93ehQrzU-lkp@intel.com>
References: <20220422051813.1989257-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422051813.1989257-4-song@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf_prog_pack-and-vmalloc-on-huge-page-fixes/20220422-133605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220422/202204221700.93ehQrzU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8a0dfde5aef7e95487be2f6e3ff9487d79a30714
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Song-Liu/bpf_prog_pack-and-vmalloc-on-huge-page-fixes/20220422-133605
        git checkout 8a0dfde5aef7e95487be2f6e3ff9487d79a30714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/kernel/module.c: In function 'module_alloc_huge':
>> arch/x86/kernel/module.c:100:54: error: 'VM_ALLOW_HUGE_VMAP' undeclared (first use in this function); did you mean 'VM_NO_HUGE_VMAP'?
     100 |                                  VM_DEFER_KMEMLEAK | VM_ALLOW_HUGE_VMAP,
         |                                                      ^~~~~~~~~~~~~~~~~~
         |                                                      VM_NO_HUGE_VMAP
   arch/x86/kernel/module.c:100:54: note: each undeclared identifier is reported only once for each function it appears in


vim +100 arch/x86/kernel/module.c

    88	
    89	void *module_alloc_huge(unsigned long size)
    90	{
    91		gfp_t gfp_mask = GFP_KERNEL;
    92		void *p;
    93	
    94		if (PAGE_ALIGN(size) > MODULES_LEN)
    95			return NULL;
    96	
    97		p = __vmalloc_node_range(size, MODULE_ALIGN,
    98					 MODULES_VADDR + get_module_load_offset(),
    99					 MODULES_END, gfp_mask, PAGE_KERNEL,
 > 100					 VM_DEFER_KMEMLEAK | VM_ALLOW_HUGE_VMAP,
   101					 NUMA_NO_NODE, __builtin_return_address(0));
   102		if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
   103			vfree(p);
   104			return NULL;
   105		}
   106	
   107		return p;
   108	}
   109	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
