Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E1C6B0C11
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCHPCj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 10:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCHPCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 10:02:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF88537C
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678287723; x=1709823723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l/Hfh9SziSNE/f3BA7MApQuwej0KsYKd9pA0AUKzYw0=;
  b=c+1KkjZ3jszoqqQQMznUxplu0UzvQ1Ug0gZaiQK+nB+8QgdwWIi76dQV
   4JtqzUQ7oyCn48XbpW7I1pAsLx4kUSv3T01v44b+fcFnK8T/ETrFLqFnW
   9xFXQuZW64fKrwfm7Xv23pCEPFQLGHtoSDtB0pvbMXOX6rS3AWOrykRea
   TiapvKITAppBxNPy5lrxY0+LtkZuHtcYnZPIJ+2si0GkD3Cc1rFeU1lMn
   GRox1M60HWtrAOmGeJAANZdB6ZQUJisykERVK4M1GAbOKag0nJzyF8zWa
   HIUFbMID120xvNTonfMqHamb5DX2GlbcIgrNA+2o+8CYq0c61Yy6Ppp6c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="363809247"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="363809247"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679364570"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="679364570"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2023 07:01:48 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZvIZ-0002CL-1D;
        Wed, 08 Mar 2023 15:01:47 +0000
Date:   Wed, 8 Mar 2023 23:01:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
Cc:     oe-kbuild-all@lists.linux.dev, Kui-Feng Lee <kuifeng@meta.com>
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops
 maps.
Message-ID: <202303082224.rf1Z7y3o-lkp@intel.com>
References: <20230308005050.255859-4-kuifeng@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308005050.255859-4-kuifeng@meta.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kui-Feng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kui-Feng-Lee/bpf-Retire-the-struct_ops-map-kvalue-refcnt/20230308-085434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230308005050.255859-4-kuifeng%40meta.com
patch subject: [PATCH bpf-next v5 3/8] bpf: Create links for BPF struct_ops maps.
config: microblaze-randconfig-r005-20230306 (https://download.01.org/0day-ci/archive/20230308/202303082224.rf1Z7y3o-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/de9e43a5ac82dde718d80d8347e867a8fc935e0a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kui-Feng-Lee/bpf-Retire-the-struct_ops-map-kvalue-refcnt/20230308-085434
        git checkout de9e43a5ac82dde718d80d8347e867a8fc935e0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303082224.rf1Z7y3o-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/hid_bpf.h:6,
                    from include/linux/hid.h:29,
                    from drivers/hid/hid-prodikeys.c:21:
   include/linux/bpf.h:2388:19: error: redefinition of 'bpf_struct_ops_link_create'
    2388 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:1592:19: note: previous definition of 'bpf_struct_ops_link_create' with type 'int(union bpf_attr *)'
    1592 | static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:21,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/hid/hid-prodikeys.c:17:
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:232:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     232 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:517:20: note: in expansion of macro 'ARRAY_SIZE'
     517 |         = { .max = ARRAY_SIZE(array), .num = nump,                      \
         |                    ^~~~~~~~~~
   include/linux/moduleparam.h:501:9: note: in expansion of macro 'module_param_array_named'
     501 |         module_param_array_named(name, name, type, nump, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-prodikeys.c:90:1: note: in expansion of macro 'module_param_array'
      90 | module_param_array(index, int, NULL, 0444);
         | ^~~~~~~~~~~~~~~~~~
   drivers/hid/hid-prodikeys.c:86:12: warning: 'index' defined but not used [-Wunused-variable]
      86 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
         |            ^~~~~


vim +16 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10   6  
bc6245e5efd70c Ian Abbott       2017-07-10   7  #ifdef __CHECKER__
bc6245e5efd70c Ian Abbott       2017-07-10   8  #define BUILD_BUG_ON_ZERO(e) (0)
bc6245e5efd70c Ian Abbott       2017-07-10   9  #else /* __CHECKER__ */
bc6245e5efd70c Ian Abbott       2017-07-10  10  /*
bc6245e5efd70c Ian Abbott       2017-07-10  11   * Force a compilation error if condition is true, but also produce a
8788994376d84d Rikard Falkeborn 2019-12-04  12   * result (of value 0 and type int), so the expression can be used
bc6245e5efd70c Ian Abbott       2017-07-10  13   * e.g. in a structure initializer (or where-ever else comma expressions
bc6245e5efd70c Ian Abbott       2017-07-10  14   * aren't permitted).
bc6245e5efd70c Ian Abbott       2017-07-10  15   */
8788994376d84d Rikard Falkeborn 2019-12-04 @16  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
527edbc18a70e7 Masahiro Yamada  2019-01-03  17  #endif /* __CHECKER__ */
527edbc18a70e7 Masahiro Yamada  2019-01-03  18  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
