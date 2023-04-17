Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91D16E552A
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 01:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDQXaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 19:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQXaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 19:30:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9440EF;
        Mon, 17 Apr 2023 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681774212; x=1713310212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=swT1uGbXge4kIXl8CAV6H/8po8YOO0CCTNzcDaHfgmM=;
  b=f3JilczWBEN/8sbSnU/qmb7x0TlENH5gF0vHRTtBb76ZBGhEOpYiENwI
   umCVuOaH13M+n6K+HzY+Vv70FCCHkHz+TVibZyyMzlpDX/1cC7qcMIx+s
   PIGCmeuhqoLXMbd7bbNS3QLjlAlcTvq1uuO24d8yQgB8/EmPVaWQCy9OI
   4tm6Ol8BPKnWGH9Eq8BENvM5jKccR3yIYQqVukTTsUoiMqzqPORBpvJDo
   Su3zBYs6i9bkvDtQ+Df/UyK9lQ2W0vumPyEiSSuLX0zOv2WpX3zZY/DNk
   M01A3VyrXEGjtlAO9jnhnPgmhmmzs9KiHxE1UPMrElJsavm9bkZV3fq+r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410247937"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="410247937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="814985904"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="814985904"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2023 16:30:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poYIQ-000cjz-2f;
        Mon, 17 Apr 2023 23:30:06 +0000
Date:   Tue, 18 Apr 2023 07:29:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention
 mechanism
Message-ID: <202304180736.cWjpwhs6-lkp@intel.com>
References: <20230417154737.12740-6-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417154737.12740-6-laoar.shao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yafang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/bpf-Add-__rcu_read_-lock-unlock-into-btf-id-deny-list/20230417-235009
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230417154737.12740-6-laoar.shao%40gmail.com
patch subject: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230418/202304180736.cWjpwhs6-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ac84d2623c0469a703245030f2b23612ab4505dd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yafang-Shao/bpf-Add-__rcu_read_-lock-unlock-into-btf-id-deny-list/20230417-235009
        git checkout ac84d2623c0469a703245030f2b23612ab4505dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304180736.cWjpwhs6-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function '__bpf_prog_enter_recur':
>> kernel/bpf/trampoline.c:848:15: error: implicit declaration of function 'test_recursion_try_acquire' [-Werror=implicit-function-declaration]
     848 |         bit = test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/trampoline.c: In function '__bpf_prog_exit_recur':
>> kernel/bpf/trampoline.c:896:9: error: implicit declaration of function 'test_recursion_release'; did you mean 'dev_recursion_level'? [-Werror=implicit-function-declaration]
     896 |         test_recursion_release(run_ctx->recursion_bit);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         dev_recursion_level
   cc1: some warnings being treated as errors


vim +/test_recursion_try_acquire +848 kernel/bpf/trampoline.c

   828	
   829	/* The logic is similar to bpf_prog_run(), but with an explicit
   830	 * rcu_read_lock() and migrate_disable() which are required
   831	 * for the trampoline. The macro is split into
   832	 * call __bpf_prog_enter
   833	 * call prog->bpf_func
   834	 * call __bpf_prog_exit
   835	 *
   836	 * __bpf_prog_enter returns:
   837	 * 0 - skip execution of the bpf prog
   838	 * 1 - execute bpf prog
   839	 * [2..MAX_U64] - execute bpf prog and record execution time.
   840	 *     This is start time.
   841	 */
   842	static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
   843		__acquires(RCU)
   844	{
   845		int bit;
   846	
   847		rcu_read_lock();
 > 848		bit = test_recursion_try_acquire(_THIS_IP_, _RET_IP_);
   849		run_ctx->recursion_bit = bit;
   850		if (bit < 0) {
   851			preempt_disable_notrace();
   852			bpf_prog_inc_misses_counter(prog);
   853			preempt_enable_notrace();
   854			return 0;
   855		}
   856	
   857		migrate_disable();
   858	
   859		run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
   860		return bpf_prog_start_time();
   861	}
   862	
   863	static void notrace update_prog_stats(struct bpf_prog *prog,
   864					      u64 start)
   865	{
   866		struct bpf_prog_stats *stats;
   867	
   868		if (static_branch_unlikely(&bpf_stats_enabled_key) &&
   869		    /* static_key could be enabled in __bpf_prog_enter*
   870		     * and disabled in __bpf_prog_exit*.
   871		     * And vice versa.
   872		     * Hence check that 'start' is valid.
   873		     */
   874		    start > NO_START_TIME) {
   875			unsigned long flags;
   876	
   877			stats = this_cpu_ptr(prog->stats);
   878			flags = u64_stats_update_begin_irqsave(&stats->syncp);
   879			u64_stats_inc(&stats->cnt);
   880			u64_stats_add(&stats->nsecs, sched_clock() - start);
   881			u64_stats_update_end_irqrestore(&stats->syncp, flags);
   882		}
   883	}
   884	
   885	static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
   886						  struct bpf_tramp_run_ctx *run_ctx)
   887		__releases(RCU)
   888	{
   889		if (run_ctx->recursion_bit < 0)
   890			goto out;
   891	
   892		bpf_reset_run_ctx(run_ctx->saved_run_ctx);
   893	
   894		update_prog_stats(prog, start);
   895		migrate_enable();
 > 896		test_recursion_release(run_ctx->recursion_bit);
   897	
   898	out:
   899		rcu_read_unlock();
   900	}
   901	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
