Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE3957592F
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 03:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiGOBqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 21:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGOBp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 21:45:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D105066B9D
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 18:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657849558; x=1689385558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jABQIOan97PuCz6TYq7UySfStAP5bn8x3sAh0Owa8aM=;
  b=Tcr1wTWozhncOn9nRZLaIJVq+sbI41QSmua8tc/s3w6JS1o/KG00sZ9i
   ZOUpUsagLIGQ/d3qH/+APqlaVxZzdYBYGE8Be1B/EqQp9eJGntQz+oMAd
   RnbdgVBY2syNRca4BU4UozkBA19uIrgYmt1+4zJ1lv5bvNFjrpMk/d5zo
   OvSgWMX/Vwdx6pNmHMz1xHsWJUX4XZ7prmGTlQMdTxwbw1dOqPDGLYzF2
   XxwCCv1jel6gkix74RJrB7gt1M2zRr5F+g3GkGo7RR+zelLEDa5+jGJzo
   rTvORFqjILXgs4ncJx+vMpO6LBBD6qa+blD9hxiH5ODntRkPFpElynfbP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="266089076"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="266089076"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="546487428"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2022 18:45:56 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCAOx-0001P9-V1;
        Fri, 15 Jul 2022 01:45:55 +0000
Date:   Fri, 15 Jul 2022 09:44:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, andrii@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/4] bpf: fix potential 32-bit overflow when
 accessing ARRAY map element
Message-ID: <202207150918.GuUgOFHd-lkp@intel.com>
References: <20220714214305.3189551-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714214305.3189551-2-andrii@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/BPF-array-map-fixes-and-improvements/20220715-054514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: hexagon-randconfig-r045-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150918.GuUgOFHd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c740c9bcbe3ab67a921ace0d988bd45214c41bef
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/BPF-array-map-fixes-and-improvements/20220715-054514
        git checkout c740c9bcbe3ab67a921ace0d988bd45214c41bef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/arraymap.c:173:75: error: expected ';' after return statement
           return array->value + (u64)array->elem_size * (index & array->index_mask)
                                                                                    ^
                                                                                    ;
   1 error generated.


vim +173 kernel/bpf/arraymap.c

   163	
   164	/* Called from syscall or from eBPF program */
   165	static void *array_map_lookup_elem(struct bpf_map *map, void *key)
   166	{
   167		struct bpf_array *array = container_of(map, struct bpf_array, map);
   168		u32 index = *(u32 *)key;
   169	
   170		if (unlikely(index >= array->map.max_entries))
   171			return NULL;
   172	
 > 173		return array->value + (u64)array->elem_size * (index & array->index_mask)
   174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
