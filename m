Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7309F6936FB
	for <lists+bpf@lfdr.de>; Sun, 12 Feb 2023 12:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBLLVt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Feb 2023 06:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Feb 2023 06:21:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A3A10E1
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 03:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676200906; x=1707736906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qQSEKdWRqbNwIDTI51H+v57hSueFBPNvFYej1ulraSo=;
  b=Eb0IybHb0hP67T1MXwRb1sEUJ5/gVZ26QgggLLEucO/uoSywSrRH6vT1
   4XUBp6Nm6TNLahpr+aF5ryndmXOD3JObn0CKzSAh5OaTrXQYW1cO7xEtr
   f2Op7gVthYyxo0a9p+vpl5b0X/HO1FkrkrMyi5UhgXXlkADOljvh7u6GY
   Df9JhI0RdhIEUHd4NmSwsEyFlmBZt2+UjdZobFlxlhihZNPjj6bP5jcKo
   P19PqqsXPbI4USadCqQpAEq8tvP6yOEDQ9mb78lC80KaZfQTKiG6EyBrl
   ZwITsc1nyx9uv5WKBg7EoAPJDwj5yZe5WdT211Ohs68P6XB2DEwggYEgy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="328407438"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="328407438"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 03:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="737196087"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="737196087"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Feb 2023 03:21:43 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRAQQ-0007CL-2y;
        Sun, 12 Feb 2023 11:21:42 +0000
Date:   Sun, 12 Feb 2023 19:21:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first}
 kfuncs
Message-ID: <202302121936.t36vlAFG-lkp@intel.com>
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212092715.1422619-4-davemarchevsky@fb.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Dave,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Marchevsky/bpf-Migrate-release_on_unlock-logic-to-non-owning-ref-semantics/20230212-172813
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230212092715.1422619-4-davemarchevsky%40fb.com
patch subject: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
config: hexagon-randconfig-r045-20230212 (https://download.01.org/0day-ci/archive/20230212/202302121936.t36vlAFG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/39ccb1ecaa4f95d55dfd9ba495ecefe3fe1f6982
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dave-Marchevsky/bpf-Migrate-release_on_unlock-logic-to-non-owning-ref-semantics/20230212-172813
        git checkout 39ccb1ecaa4f95d55dfd9ba495ecefe3fe1f6982
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302121936.t36vlAFG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/bpf/helpers.c:4:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/bpf/helpers.c:4:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/bpf/helpers.c:4:
   In file included from include/linux/bpf.h:31:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> kernel/bpf/helpers.c:1901:9: warning: cast from 'bool (*)(struct bpf_rb_node *, const struct bpf_rb_node *)' (aka '_Bool (*)(struct bpf_rb_node *, const struct bpf_rb_node *)') to 'bool (*)(struct rb_node *, const struct rb_node *)' (aka '_Bool (*)(struct rb_node *, const struct rb_node *)') converts to incompatible function type [-Wcast-function-type-strict]
                         (bool (*)(struct rb_node *, const struct rb_node *))less);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7 warnings generated.


vim +1901 kernel/bpf/helpers.c

  1896	
  1897	void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
  1898			    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
  1899	{
  1900		rb_add_cached((struct rb_node *)node, (struct rb_root_cached *)root,
> 1901			      (bool (*)(struct rb_node *, const struct rb_node *))less);
  1902	}
  1903	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
