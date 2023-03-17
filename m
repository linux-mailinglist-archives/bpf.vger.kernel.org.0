Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9CE6BE1B4
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 08:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCQHAJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 03:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCQHAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 03:00:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310D51C9B
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679036402; x=1710572402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=63tbON/PblLIHY7/lGHmLj1Dwq9FlkQQr4Dabyz/ktI=;
  b=BD6oKLndvryCwFTlQAs8v461189K6+2LPz/hY6DNRmdSYBlirWjqLyjA
   ujPrALPQ+ErlbVd9REdyHGxC10mqAoDIwnr4Bkmyl8EdlV8XOO3Y/FGQx
   8l9dv1aMrT4tf2u7Ena5XoKiE9Wm/n0KTfSM3LTbAqFrsU76o8VwkQR8S
   f3JjU3ivHCkq7+4m70G293bysXUOvstcp653L0Y3Bcg8xenA5GjyE3OxH
   uObmtPyoyG0iruuFRNOTP41egdw9nL/nNTUYfHd3AqQM6tcX+EFCgXWMf
   oa2oR4EDuYlLr19/Q8k+4ELtXu/nbAWXvX3sBWrOKPgvny+aYr2/7TkB2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="338215309"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="338215309"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 00:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="710403559"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="710403559"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Mar 2023 00:00:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd44F-0009AK-25;
        Fri, 17 Mar 2023 06:59:59 +0000
Date:   Fri, 17 Mar 2023 14:59:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, andrii@kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
Message-ID: <202303171434.ljQyQS6z-lkp@intel.com>
References: <20230316183013.2882810-4-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316183013.2882810-4-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-split-off-basic-BPF-verifier-log-into-separate-file/20230317-023431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230316183013.2882810-4-andrii%40kernel.org
patch subject: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a rotating log by default
config: m68k-buildonly-randconfig-r001-20230312 (https://download.01.org/0day-ci/archive/20230317/202303171434.ljQyQS6z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f2876fe2427e5bdfbbb27980025b969c93f46c4b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrii-Nakryiko/bpf-split-off-basic-BPF-verifier-log-into-separate-file/20230317-023431
        git checkout f2876fe2427e5bdfbbb27980025b969c93f46c4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303171434.ljQyQS6z-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: section .rodata VMA [0000000000001000,00000000004e5d2f] overlaps section .text VMA [0000000000000400,0000000000628bcf]
   m68k-linux-ld: m68k-linux-ld: DWARF error: could not find abbrev number 119
   kernel/bpf/log.o: in function `bpf_verifier_vlog':
>> log.c:(.text+0x2fe): undefined reference to `__umoddi3'
>> m68k-linux-ld: log.c:(.text+0x332): undefined reference to `__umoddi3'
   m68k-linux-ld: kernel/bpf/log.o: in function `bpf_vlog_finalize':
   log.c:(.text+0x570): undefined reference to `__umoddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
