Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9DB6EA090
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjDUATE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 20:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbjDUATD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 20:19:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9944A2;
        Thu, 20 Apr 2023 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682036342; x=1713572342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3qHxUc9HOWZHKy95SzEwsOW2kpInRlzU36T0KytsOo=;
  b=nvpGP3tacK1RLwMwMdH3MurkL/irTGZ9CT+WtEX9VUd5RktDeQk1vDLd
   o9Uy2Gpcx8i3pg5b+5vbPWTNnrv4l4Wn0TMddFTnujigf2qgXLHxC3+u3
   t/j2yTA4f0ME3r+xxPQ2d23q6SHJv/CkVm6p2681K3c0rc+SVUszxzsMa
   x7IssGkHUGXbdh8OWRZFWyWbAh3rim4G72WIEiYlut6tRAje1IItpBtvG
   GQXyQ5jX1t7cETKXot9ovMuHl0afbXaa2PXKnD+CDpfeEnjHTm2p2qQFA
   lvy/YbagCgKiTfXRuHedYuwfst0n/mNseJz+Mottj23DTES1gJ40W4iV9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="326210231"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="326210231"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 17:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="816232452"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="816232452"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2023 17:18:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppeUM-000gBw-0T;
        Fri, 21 Apr 2023 00:18:58 +0000
Date:   Fri, 21 Apr 2023 08:18:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH v5 4/9] tracing/probes: Add tracepoint support on
 fprobe_event
Message-ID: <202304210803.19mc32SM-lkp@intel.com>
References: <168198997089.1795549.1009510263722958117.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168198997089.1795549.1009510263722958117.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230419]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes bpf-next/master bpf/master linus/master rostedt-trace/for-next rostedt-trace/for-next-urgent v6.3-rc7 v6.3-rc6 v6.3-rc5 v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/fprobe-Pass-return-address-to-the-handlers/20230420-192935
patch link:    https://lore.kernel.org/r/168198997089.1795549.1009510263722958117.stgit%40mhiramat.roam.corp.google.com
patch subject: [PATCH v5 4/9] tracing/probes: Add tracepoint support on fprobe_event
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230421/202304210803.19mc32SM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ecaf9aff228ea0fe18d72079792f4ff6a95263b7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masami-Hiramatsu-Google/fprobe-Pass-return-address-to-the-handlers/20230420-192935
        git checkout ecaf9aff228ea0fe18d72079792f4ff6a95263b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304210803.19mc32SM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_fprobe.c:907:20: warning: no previous prototype for 'find_tracepoint' [-Wmissing-prototypes]
     907 | struct tracepoint *find_tracepoint(const char *tp_name)
         |                    ^~~~~~~~~~~~~~~


vim +/find_tracepoint +907 kernel/trace/trace_fprobe.c

   906	
 > 907	struct tracepoint *find_tracepoint(const char *tp_name)
   908	{
   909		struct __find_tracepoint_cb_data data = {
   910			.tp_name = tp_name,
   911		};
   912	
   913		for_each_kernel_tracepoint(__find_tracepoint_cb, &data);
   914	
   915		return data.tpoint;
   916	}
   917	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
