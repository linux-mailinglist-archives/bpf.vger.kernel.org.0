Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9A4F4D8F
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445647AbiDEXpz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452819AbiDEWc2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 18:32:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02191A3BB;
        Tue,  5 Apr 2022 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649193999; x=1680729999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+oTJs1jfnV9NW0n9SL3+E3IODEjehGaO0faXtMV5Vvo=;
  b=bggTod5tcaE8W4le11d67CSJn7zWg4hJdb1i4ZVnNMwxYMk9yNjviSIx
   Xkb70JazRAekFm3YtV3AJ1VnjRfXmPjWPHxRYYWIGQA82a15W0ZG1AB5C
   +xnNaqypsoxbvMS59UWXX9JOXwd+IM3az0HpHiXoDvp6WlAavV3z+H2oZ
   ZSFVDR7TYOfeTWoI2kANPXBbjNnJJAFaz3BAUW6dryNo3ysLQ7JuRjQSe
   7Uw9QYEQ+Wuq+I7sAP7OahdlXoUrVcDyvF0vmo41/Z9bcppoGPjXt0c35
   sIEY+I29s5pARRqSkcPtDmzH1+yDnCOyZIlIkHLo2k9gu46RVXa1nLURC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="347310054"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="347310054"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="641773595"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2022 14:26:34 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbqh8-0003ly-3e;
        Tue, 05 Apr 2022 21:26:34 +0000
Date:   Wed, 6 Apr 2022 05:25:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf 4/4] arm64: rethook: Replace kretprobe trampoline
 with rethook
Message-ID: <202204060512.Pzw5bnTd-lkp@intel.com>
References: <164915126392.982637.10302202550404803304.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164915126392.982637.10302202550404803304.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu/kprobes-rethook-ARM-arm64-Replace-kretprobe-trampoline-with-rethook/20220405-195153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
config: arm64-randconfig-r022-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060512.Pzw5bnTd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/74084aa7903f112b1c3df1f864d49b15d8aba270
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masami-Hiramatsu/kprobes-rethook-ARM-arm64-Replace-kretprobe-trampoline-with-rethook/20220405-195153
        git checkout 74084aa7903f112b1c3df1f864d49b15d8aba270
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/rethook.c:11:22: warning: no previous prototype for function 'arch_rethook_trampoline_callback' [-Wmissing-prototypes]
   unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
                        ^
   arch/arm64/kernel/rethook.c:11:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
   ^
   static 
   1 warning generated.


vim +/arch_rethook_trampoline_callback +11 arch/arm64/kernel/rethook.c

     9	
    10	/* This is called from arch_rethook_trampoline() */
  > 11	unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
    12	{
    13		return rethook_trampoline_handler(regs, regs->regs[29]);
    14	}
    15	NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
    16	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
