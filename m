Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A539508357
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 10:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiDTI1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiDTI1C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 04:27:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB66255AA
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650443057; x=1681979057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p0aVZbgReCBl1bciRGrHiRzZoPWzV4IGQUIAKX8q7Ds=;
  b=VVCcegRzebwMHrsNcEk9N51BCZqBrWFNKQR+kQolYJ9Hct+MAUa/1Tux
   +j9oGV+prap7BzsqjVX1x/tqWUzCEn9OeYB98CpSjVqcPpaGVJYi7BrvP
   owmavsz7FOuOWUU25mRvBtJrHjsyWkJdP0pO2rhcmAbB1k8enqDmDTQUH
   KxZFvL2Irl9M5eMLumEzSwbh1xKiPWIy9w04AJ3AFs0/A8VWms7f1GyFm
   uK7VKVprm7UsW7J+RiuueoHGYF+fo/FC+zDESWkMJrndvhqa9bpzjITK9
   VZ8aEfm/JsAoF1D48OSAZ/22ffibzf3xR4i7/VwGvfPlFaSacHUQepY4e
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="289077363"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="289077363"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 01:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="668087151"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 01:24:13 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh5dE-0006la-GJ;
        Wed, 20 Apr 2022 08:24:12 +0000
Date:   Wed, 20 Apr 2022 16:23:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     grantseltzer <grantseltzer@gmail.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, andrii@kernel.org,
        grantseltzer@gmail.com, song@kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] Add documentation to API functions
Message-ID: <202204201650.TNnvoXPQ-lkp@intel.com>
References: <20220419160346.35633-3-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419160346.35633-3-grantseltzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi grantseltzer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/grantseltzer/Add-error-returns-to-two-API-functions/20220420-000638
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: s390-randconfig-r023-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201650.TNnvoXPQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/55a52c4514ab205b288dce0a609d5d7bab485813
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review grantseltzer/Add-error-returns-to-two-API-functions/20220420-000638
        git checkout 55a52c4514ab205b288dce0a609d5d7bab485813
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> libbpf.c:8570:1: error: non-void function does not return a value in all control paths [-Werror,-Wreturn-type]
   }
   ^
   1 error generated.
   make[5]: *** [tools/build/Makefile.build:96: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf.o] Error 1
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile:157: tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-in.o] Error 2
   make[3]: *** [Makefile:55: tools/bpf/resolve_btfids//libbpf/libbpf.a] Error 2
   make[2]: *** [Makefile:72: bpf/resolve_btfids] Error 2
   make[1]: *** [Makefile:1337: tools/bpf/resolve_btfids] Error 2
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:41:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:41:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:41:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   12 warnings generated.
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
