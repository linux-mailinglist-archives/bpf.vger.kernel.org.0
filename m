Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981996BC357
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjCPBc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCPBcX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:32:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3E788D80
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678930342; x=1710466342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hgNs+2LCIw1VdcWJgnaEyGtYI9oIxF1N3ox9qlRdiJ4=;
  b=A/gEWbPnacX6kvm2qsLidpyin7vhPjtLLWwPNzNiVmEG9om6StRfIgPw
   mo8ae6mgQxeG3CeWcBF8We6c3Vm1DXdyo/rLHFVvL7zJGZagHVQeYK1gZ
   8Xhua5VVky+ZPO0/M9xVgmq0sANknWYqujVmPdlejyymuGFGQCZ2fa9xl
   Qm8/NlwgktBZHl8l6DTqjTIFPLyZpgT7kiTmzxek0901ou5yXWwRW7eri
   Sm/4fKjXCFs/1+50+DUe/T/E9UyG84h+naF3Unj0GNWzXC5kAf7n16WwU
   G2VLf8kuN2+tb1GPodzVgv6B1S1b9Np/EGsTnrYHegS2rkXa9DDILXvWW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="336552647"
X-IronPort-AV: E=Sophos;i="5.98,264,1673942400"; 
   d="scan'208";a="336552647"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 18:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672954468"
X-IronPort-AV: E=Sophos;i="5.98,264,1673942400"; 
   d="scan'208";a="672954468"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2023 18:32:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pccTX-0008Ct-0x;
        Thu, 16 Mar 2023 01:32:15 +0000
Date:   Thu, 16 Mar 2023 09:32:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH bpf-next v10 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <202303160919.SGyfD0uE-lkp@intel.com>
References: <3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Viktor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230310-154848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/3f6a9d8ae850532b5ef864ef16327b0f7a669063.1678432753.git.vmalik%40redhat.com
patch subject: [PATCH bpf-next v10 1/2] bpf: Fix attaching fentry/fexit/fmod_ret/lsm to modules
config: arm-buildonly-randconfig-r005-20230312 (https://download.01.org/0day-ci/archive/20230316/202303160919.SGyfD0uE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/a6713fb8bbf7954ee98fec48f2a1f1e33814d92a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Viktor-Malik/bpf-Fix-attaching-fentry-fexit-fmod_ret-lsm-to-modules/20230310-154848
        git checkout a6713fb8bbf7954ee98fec48f2a1f1e33814d92a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160919.SGyfD0uE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/verifier.c:27:
>> kernel/bpf/../module/internal.h:260:14: error: expected ')'
                                                          const char *name)
                                                          ^
   kernel/bpf/../module/internal.h:259:55: note: to match this '('
   static inline unsigned long find_kallsyms_symbol_value(struct module *mod
                                                         ^
>> kernel/bpf/verifier.c:18440:45: error: too many arguments to function call, expected single argument 'mod', have 2 arguments
                                           addr = find_kallsyms_symbol_value(mod, tname);
                                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~      ^~~~~
   kernel/bpf/../module/internal.h:259:29: note: 'find_kallsyms_symbol_value' declared here
   static inline unsigned long find_kallsyms_symbol_value(struct module *mod
                               ^
   2 errors generated.


vim +260 kernel/bpf/../module/internal.h

   250	
   251	static inline bool sect_empty(const Elf_Shdr *sect)
   252	{
   253		return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
   254	}
   255	#else /* !CONFIG_KALLSYMS */
   256	static inline void init_build_id(struct module *mod, const struct load_info *info) { }
   257	static inline void layout_symtab(struct module *mod, struct load_info *info) { }
   258	static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
   259	static inline unsigned long find_kallsyms_symbol_value(struct module *mod
 > 260							       const char *name)
   261	{
   262		return 0;
   263	}
   264	#endif /* CONFIG_KALLSYMS */
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
