Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93952E236
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 03:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbiETB5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 21:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiETB5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 21:57:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B299EC304;
        Thu, 19 May 2022 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653011872; x=1684547872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pi588XLvq+mQ0AgwxIsoSjkMIdYQhApnFrYgEjsZBLY=;
  b=fQmj3AbMYoZh2sL971VPOJYoJr7hokQ+jzWMVO0RGrl0CvME+JxA74wW
   PPlXuO5x2VMhvdAIG43z9q1N7E0k3QoiPokoU7fGYkYl0t2HrwX2rxcFq
   NIRw2ZqlyFY/xlvBGge07HNW8ymvozP9IFNgtEwqsddX8t6Iii/309u11
   sYCO53jGLiU0Uz0H+CXJJx6rSjhiiDzj3TFGLtVkZBNLuDtB+F/xPNIM/
   FnH1attyUmwpItip1gHzXCGb2SxLRqVfDRiOW3dhtMrJSWkrMXW4b43ha
   rVvn+JRJYzwcle/SES4XpDFcicZqBynKuaafYDhdR2xolO4g99LKenvPO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272578061"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272578061"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 18:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="627908126"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 19 May 2022 18:57:49 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrrtk-00049x-MV;
        Fri, 20 May 2022 01:57:48 +0000
Date:   Fri, 20 May 2022 09:57:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, ast@kernel.org, daniel@iogearbox.net,
        mcgrof@kernel.org, torvalds@linux-foundation.org,
        rick.p.edgecombe@intel.com, kernel-team@fb.com,
        Song Liu <song@kernel.org>
Subject: Re: [PATCH v2 bpf-next 8/8] bpf: simplify select_bpf_prog_pack_size
Message-ID: <202205200913.DnvvOaAw-lkp@intel.com>
References: <20220519202037.2401584-9-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519202037.2401584-9-song@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Song,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf_prog_pack-followup/20220520-043417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220520/202205200913.DnvvOaAw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2d5d4beb45be09f3130b694f49ab1b1fd1aa4470
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Song-Liu/bpf_prog_pack-followup/20220520-043417
        git checkout 2d5d4beb45be09f3130b694f49ab1b1fd1aa4470
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/core.c: In function 'select_bpf_prog_pack_size':
>> kernel/bpf/core.c:857:15: warning: unused variable 'ptr' [-Wunused-variable]
     857 |         void *ptr;
         |               ^~~


vim +/ptr +857 kernel/bpf/core.c

e581094167beb6 Song Liu 2022-03-21  853  
ef078600eec20f Song Liu 2022-03-11  854  static size_t select_bpf_prog_pack_size(void)
ef078600eec20f Song Liu 2022-03-11  855  {
ef078600eec20f Song Liu 2022-03-11  856  	size_t size;
ef078600eec20f Song Liu 2022-03-11 @857  	void *ptr;
ef078600eec20f Song Liu 2022-03-11  858  
2d5d4beb45be09 Song Liu 2022-05-19  859  	if (huge_vmalloc_supported()) {
e581094167beb6 Song Liu 2022-03-21  860  		size = BPF_HPAGE_SIZE * num_online_nodes();
2d5d4beb45be09 Song Liu 2022-05-19  861  		bpf_prog_pack_mask = BPF_HPAGE_MASK;
2d5d4beb45be09 Song Liu 2022-05-19  862  	} else {
ef078600eec20f Song Liu 2022-03-11  863  		size = PAGE_SIZE;
96805674e5624b Song Liu 2022-03-21  864  		bpf_prog_pack_mask = PAGE_MASK;
96805674e5624b Song Liu 2022-03-21  865  	}
ef078600eec20f Song Liu 2022-03-11  866  
ef078600eec20f Song Liu 2022-03-11  867  	return size;
ef078600eec20f Song Liu 2022-03-11  868  }
ef078600eec20f Song Liu 2022-03-11  869  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
