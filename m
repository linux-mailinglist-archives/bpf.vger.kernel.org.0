Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E5D67FA26
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 19:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjA1SGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 13:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjA1SGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 13:06:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793512943C;
        Sat, 28 Jan 2023 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674929158; x=1706465158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bAxv/HDPrQB7TY+fjZG3z8MOiTvycXwCcAJ/hwcQLo4=;
  b=hdepsNZ6k9j1r4mcOc6HVrvdDG/as+3rVhsx6kwkkS/Ajq6LuaV/17mo
   uYA2TjXGvyL9M6YGdcJ0RXSn8J8NWC6yAWltwoLC/hmZ86B+FTMvdTaRM
   a55v+Lts7EsBKV5tfxNgY/mQ1iOoqAVplicvfaFlVdZ3/aKlCf2uKpZeq
   uqn/EPg0CB4Z/W7gRgLIItrIaeniIfThkTS+yqjwk833vZ5KzmA/k+VGz
   Q4VzwxsC3hZJwYfCNGAIB2SfP9R/QnvNgVFS2ZoCcnZUofa+e8Mk/AuEZ
   zhD1vi475jaCshaECyyJGfsAF0hyZE7MgTGSzzZY7iBmITMr/uqqeXiqS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="310937455"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="310937455"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:05:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="752340114"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="752340114"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2023 10:05:50 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLpaD-0000yI-0X;
        Sat, 28 Jan 2023 18:05:45 +0000
Date:   Sun, 29 Jan 2023 02:05:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 23/30] sched_ext: Add cgroup support
Message-ID: <202301290107.J4Eavi26-lkp@intel.com>
References: <20230128001639.3510083-24-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128001639.3510083-24-tj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tejun,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v6.2-rc5]
[cannot apply to tip/sched/core tj-cgroup/for-next next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/sched-Encapsulate-task-attribute-change-sequence-into-a-helper-macro/20230128-123001
patch link:    https://lore.kernel.org/r/20230128001639.3510083-24-tj%40kernel.org
patch subject: [PATCH 23/30] sched_ext: Add cgroup support
config: arc-defconfig (https://download.01.org/0day-ci/archive/20230129/202301290107.J4Eavi26-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6f861617cb846291559a9d0bfe60a9c1ca20f406
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tejun-Heo/sched-Encapsulate-task-attribute-change-sequence-into-a-helper-macro/20230128-123001
        git checkout 6f861617cb846291559a9d0bfe60a9c1ca20f406
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/sched.h:3404,
                    from kernel/sched/core.c:85:
>> kernel/sched/ext.h:182:48: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     182 | static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
         |                                                ^~~~~~~~~~~~~~
   kernel/sched/ext.h:185:52: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     185 | static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
         |                                                    ^~~~~~~~~~~~~~
   kernel/sched/core.c:7006:6: warning: no previous prototype for '__setscheduler_prio' [-Wmissing-prototypes]
    7006 | void __setscheduler_prio(struct task_struct *p, int prio)
         |      ^~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/sched.h:3404,
                    from kernel/sched/fair.c:55:
>> kernel/sched/ext.h:182:48: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     182 | static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
         |                                                ^~~~~~~~~~~~~~
   kernel/sched/ext.h:185:52: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     185 | static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
         |                                                    ^~~~~~~~~~~~~~
   kernel/sched/fair.c:5937:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5937 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:12361:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   12361 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:12363:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   12363 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:12368:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   12368 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:12370:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   12370 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/sched.h:3404,
                    from kernel/sched/build_policy.c:36:
>> kernel/sched/ext.h:182:48: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     182 | static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
         |                                                ^~~~~~~~~~~~~~
   kernel/sched/ext.h:185:52: warning: 'struct cgroup_taskset' declared inside parameter list will not be visible outside of this definition or declaration
     185 | static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
         |                                                    ^~~~~~~~~~~~~~


vim +182 kernel/sched/ext.h

   170	
   171	#ifdef CONFIG_EXT_GROUP_SCHED
   172	int scx_tg_online(struct task_group *tg);
   173	void scx_tg_offline(struct task_group *tg);
   174	int scx_cgroup_can_attach(struct cgroup_taskset *tset);
   175	void scx_move_task(struct task_struct *p);
   176	void scx_cgroup_finish_attach(void);
   177	void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
   178	void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
   179	#else	/* CONFIG_EXT_GROUP_SCHED */
   180	static inline int scx_tg_online(struct task_group *tg) { return 0; }
   181	static inline void scx_tg_offline(struct task_group *tg) {}
 > 182	static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
