Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BFE6874B5
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 05:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBBEyX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 23:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBBEyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 23:54:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C56227B
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675313658; x=1706849658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RxuR55X3AAe0WSdLaoBJfLJjrnmzU1QVMffDdTPAznE=;
  b=X68OklCD/kntxnH99wDre/Uiax3bFaSI+glH3OMHnoOTW7CzeW5Yx2sZ
   vkrPbCPXw5oqr7Cmlmdk7q5Uv1dPCYzwNLUFm3MNvcHMmbzxBosrdtb/o
   +KKVxuvm/aX+ealVvienl0O2f0l8gNRhMPttTIPZI2dltsdmOe+elAT8E
   rDsxKPKw4vj3+N4fgtJKz3Nl56nxIuIhmH6sPpus5Y6shjg0y1XHIWzVy
   zSawECtYsPmdbg0roJlRWGzUQQ0k69WVg8hcmUHIJlJz4e5j0GINjGhoX
   EE12bJWaNZc6JcvROdWVfGNG6LEOztWAL4KfpgJ8E5mcTKMwysBqgKtDt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="390741308"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="390741308"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 20:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658584547"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="658584547"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Feb 2023 20:54:10 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNRbu-0006AE-0N;
        Thu, 02 Feb 2023 04:54:10 +0000
Date:   Thu, 2 Feb 2023 12:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, vbabka@suse.cz, urezki@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: introduce bpf_mem_alloc_size()
Message-ID: <202302021258.By6JZK71-lkp@intel.com>
References: <20230202014158.19616-7-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202014158.19616-7-laoar.shao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yafang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/mm-percpu-fix-incorrect-size-in-pcpu_obj_full_size/20230202-094352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230202014158.19616-7-laoar.shao%40gmail.com
patch subject: [PATCH bpf-next 6/7] bpf: introduce bpf_mem_alloc_size()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230202/202302021258.By6JZK71-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/996f3e2ac4dca054396d0f37ffe8ddb97fc4212f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yafang-Shao/mm-percpu-fix-incorrect-size-in-pcpu_obj_full_size/20230202-094352
        git checkout 996f3e2ac4dca054396d0f37ffe8ddb97fc4212f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/memalloc.c:227:15: warning: no previous prototype for 'bpf_mem_cache_size' [-Wmissing-prototypes]
     227 | unsigned long bpf_mem_cache_size(struct bpf_mem_cache *c, void *obj)
         |               ^~~~~~~~~~~~~~~~~~


vim +/bpf_mem_cache_size +227 kernel/bpf/memalloc.c

   226	
 > 227	unsigned long bpf_mem_cache_size(struct bpf_mem_cache *c, void *obj)
   228	{
   229		unsigned long size;
   230	
   231		if (!obj)
   232			return 0;
   233	
   234		if (c->percpu_size) {
   235			size = percpu_size(((void **)obj)[1]);
   236			size += ksize(obj);
   237			return size;
   238		}
   239	
   240		return ksize(obj);
   241	}
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
