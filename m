Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D266785B0
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 20:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjAWTCZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 14:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjAWTCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 14:02:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E51BF3;
        Mon, 23 Jan 2023 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674500542; x=1706036542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gYqROnUHb4/3n36cXY46EdTUnwW794DwUM70kXeqThQ=;
  b=Au23eQqzRTRTUYSh5wGThFmOhfaOBJAMlF7J2DUGvXBhOxvlEeSpbJvn
   8+GY0wJVMRY5Thn9NccFEIknvNHjv47CwDTk/usNsDMFtliMnRGXlKUk/
   t0m2EA//MEmZ6vmb6ZEHED6qBSRgAHZdgRA5NfRhHf6+oFtDvmEqUON9M
   JFRazXNGCtGCAOOYwKe260zWQihcrp9UsTy+YHOaFPaYuR9g8DBsJioha
   fW7Eagl0CAdi1m1KuWW7UiXr/68PXvLx32LTVVpTPreGw3aiqWC950vSe
   01RXonyICOJyieK2z8PlTqOvY2RzTbMxff9N0mqLrNHqwc433zlWPtbXu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="305784224"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="305784224"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="750544156"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="750544156"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2023 11:02:17 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pK25B-0005pn-0N;
        Mon, 23 Jan 2023 19:02:17 +0000
Date:   Tue, 24 Jan 2023 03:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@meta.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <202301240220.RKx4Wgip-lkp@intel.com>
References: <20230123171506.71995-4-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123171506.71995-4-void@manifault.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/bpf-Add-BPF_KFUNC-macro-for-defining-kfuncs/20230124-011804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230123171506.71995-4-void%40manifault.com
patch subject: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc definitions
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301240220.RKx4Wgip-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/760b15a8e5d45d6e9925d2439e0d052de969b361
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Vernet/bpf-Add-BPF_KFUNC-macro-for-defining-kfuncs/20230124-011804
        git checkout 760b15a8e5d45d6e9925d2439e0d052de969b361
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/ net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/cgroup/rstat.c:30: warning: expecting prototype for cgroup_rstat_updated(). Prototype was for BPF_KFUNC() instead
>> kernel/cgroup/rstat.c:235: warning: expecting prototype for cgroup_rstat_flush(). Prototype was for BPF_KFUNC() instead
--
>> kernel/bpf/helpers.c:1850: warning: expecting prototype for bpf_task_acquire(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:1861: warning: expecting prototype for bpf_task_acquire_not_zero(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:1913: warning: expecting prototype for bpf_task_kptr_get(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:1926: warning: expecting prototype for bpf_task_release(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:1941: warning: expecting prototype for bpf_cgroup_acquire(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:1953: warning: expecting prototype for bpf_cgroup_kptr_get(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:1985: warning: expecting prototype for bpf_cgroup_release(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:2000: warning: expecting prototype for bpf_cgroup_ancestor(). Prototype was for BPF_KFUNC() instead
>> kernel/bpf/helpers.c:2019: warning: expecting prototype for bpf_task_from_pid(). Prototype was for BPF_KFUNC() instead
--
   net/bpf/test_run.c:490:14: warning: no previous prototype for 'bpf_fentry_test2' [-Wmissing-prototypes]
     490 | int noinline bpf_fentry_test2(int a, u64 b)
         |              ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:495:14: warning: no previous prototype for 'bpf_fentry_test3' [-Wmissing-prototypes]
     495 | int noinline bpf_fentry_test3(char a, int b, u64 c)
         |              ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:500:14: warning: no previous prototype for 'bpf_fentry_test4' [-Wmissing-prototypes]
     500 | int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
         |              ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:505:14: warning: no previous prototype for 'bpf_fentry_test5' [-Wmissing-prototypes]
     505 | int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, u64 e)
         |              ^~~~~~~~~~~~~~~~
   net/bpf/test_run.c:510:14: warning: no previous prototype for 'bpf_fentry_test6' [-Wmissing-prototypes]
     510 | int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, void *e, u64 f)
         |              ^~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:519:14: warning: no previous prototype for 'bpf_fentry_test7' [-Wmissing-prototypes]
     519 | int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
         |              ^~~~~~~~~~~~~~~~
>> net/bpf/test_run.c:524:14: warning: no previous prototype for 'bpf_fentry_test8' [-Wmissing-prototypes]
     524 | int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
         |              ^~~~~~~~~~~~~~~~


vim +30 kernel/cgroup/rstat.c

041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  19  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  20  /**
6162cef0f741c7 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  21   * cgroup_rstat_updated - keep track of updated rstat_cpu
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  22   * @cgrp: target cgroup
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  23   * @cpu: cpu on which rstat_cpu was updated
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  24   *
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  25   * @cgrp's rstat_cpu on @cpu was updated.  Put it on the parent's matching
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  26   * rstat_cpu->updated_children list.  See the comment on top of
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  27   * cgroup_rstat_cpu definition for details.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  28   */
760b15a8e5d45d kernel/cgroup/rstat.c David Vernet    2023-01-23  29  BPF_KFUNC(void cgroup_rstat_updated(struct cgroup *cgrp, int cpu))
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25 @30  {
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  31  	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  32  	unsigned long flags;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  33  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  34  	/*
d8ef4b38cb69d9 kernel/cgroup/rstat.c Tejun Heo       2020-04-09  35  	 * Speculative already-on-list test. This may race leading to
d8ef4b38cb69d9 kernel/cgroup/rstat.c Tejun Heo       2020-04-09  36  	 * temporary inaccuracies, which is fine.
d8ef4b38cb69d9 kernel/cgroup/rstat.c Tejun Heo       2020-04-09  37  	 *
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  38  	 * Because @parent's updated_children is terminated with @parent
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  39  	 * instead of NULL, we can tell whether @cgrp is on the list by
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  40  	 * testing the next pointer for NULL.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  41  	 */
eda09706b240ca kernel/cgroup/rstat.c Michal Koutný   2021-11-03  42  	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  43  		return;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  44  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  45  	raw_spin_lock_irqsave(cpu_lock, flags);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  46  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  47  	/* put @cgrp and all ancestors on the corresponding updated lists */
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  48  	while (true) {
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  49  		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  50  		struct cgroup *parent = cgroup_parent(cgrp);
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  51  		struct cgroup_rstat_cpu *prstatc;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  52  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  53  		/*
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  54  		 * Both additions and removals are bottom-up.  If a cgroup
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  55  		 * is already in the tree, all ancestors are.
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  56  		 */
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  57  		if (rstatc->updated_next)
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  58  			break;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  59  
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  60  		/* Root has no parent to link it to, but mark it busy */
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  61  		if (!parent) {
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  62  			rstatc->updated_next = cgrp;
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  63  			break;
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  64  		}
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  65  
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  66  		prstatc = cgroup_rstat_cpu(parent, cpu);
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  67  		rstatc->updated_next = prstatc->updated_children;
c58632b3631cb2 kernel/cgroup/rstat.c Tejun Heo       2018-04-26  68  		prstatc->updated_children = cgrp;
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  69  
dc26532aed0ab2 kernel/cgroup/rstat.c Johannes Weiner 2021-04-29  70  		cgrp = parent;
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  71  	}
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  72  
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  73  	raw_spin_unlock_irqrestore(cpu_lock, flags);
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  74  }
041cd640b2f3c5 kernel/cgroup/stat.c  Tejun Heo       2017-09-25  75  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
