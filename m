Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A02D4F4D92
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446592AbiDEXqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572996AbiDERna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 13:43:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D588CB91AE;
        Tue,  5 Apr 2022 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649180491; x=1680716491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d1uggptIEOdH6XP927KXNMIpnt0NmVSeFNANlHp6nPQ=;
  b=AAU/kxUvSzhEcigPIu96Y5JOYZY+9iUEM5gmtvyLnr/EgIUHoRqgIMVL
   BavdfY7ZpHp8edoItMSoePA6XqIbSSedbYkl2DHp6SXFh07fTp+1BeYDl
   cci9CTb7dnCJ4f3Cy8loJAhXcM3UFYGv01juWngneu93ybSolfD0/ISVH
   bjs0jCMFNY8C90VmQx6wD4CDeCk+FBgx3VRcQn4X2/c9+l5Ip+LBB8bAu
   FXwUc33/EIhiko6V2mvYdLP4GFb4v6LHTncVR4y+Fe7El3uHeTz9fJMwS
   WQDv3JTHyo+MWeNsdoW7Zw6XW08FgyfQh7hMLiSYsIpM0YJbQxX/VapKM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259651073"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="259651073"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523555238"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 10:41:25 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbnBE-0003dj-Br;
        Tue, 05 Apr 2022 17:41:24 +0000
Date:   Wed, 6 Apr 2022 01:40:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
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
Message-ID: <202204060119.lme7uoGl-lkp@intel.com>
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220406/202204060119.lme7uoGl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/74084aa7903f112b1c3df1f864d49b15d8aba270
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masami-Hiramatsu/kprobes-rethook-ARM-arm64-Replace-kretprobe-trampoline-with-rethook/20220405-195153
        git checkout 74084aa7903f112b1c3df1f864d49b15d8aba270
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/rethook.c:11:22: warning: no previous prototype for 'arch_rethook_trampoline_callback' [-Wmissing-prototypes]
      11 | unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
