Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85B267FA58
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 20:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjA1TJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 14:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1TI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 14:08:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B924C99;
        Sat, 28 Jan 2023 11:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674932937; x=1706468937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhxyAYLelEfckoe/PbY7Ef4L4nCPXQSheZkRYAjHAEs=;
  b=fBBiGRmQ9qgkac44fSToAJtLT194iO/nbI3GxgDf+7zmMcoDCqraGGuS
   Ps+fvfY1tgTso6dneYwUbVSXfCs11wMEXHxqUxojGFME5qK4gpDekredh
   Uq4xOg4UY9Xnwro7SJNk224eMgGub/w72hj+pklKuF4ckHJkGZD5egG2a
   Q234igauJ8tEd7izSSq+QFehmyApanOk0Z1F1Tl1Zzf2UhQ1aduh6827N
   6xEPgkwY8LSo5ZNL0vFST39gAHn0lweU5R47/7x5DdcQX82o9cBvdZhs6
   Ow5bAgGVTHQBbnMsKSK0jSUk+YsQ7K4xVGe+MVVlu36ucPBktKPQV/Lar
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="354634200"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="354634200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 11:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="613562517"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="613562517"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jan 2023 11:08:48 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLqZD-00010e-11;
        Sat, 28 Jan 2023 19:08:47 +0000
Date:   Sun, 29 Jan 2023 03:07:54 +0800
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
Subject: Re: [PATCH 27/30] sched_ext: Implement core-sched support
Message-ID: <202301290223.0qWZoY9T-lkp@intel.com>
References: <20230128001639.3510083-28-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128001639.3510083-28-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tejun,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on linus/master v6.2-rc5]
[cannot apply to tip/sched/core tj-cgroup/for-next next-20230127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tejun-Heo/sched-Encapsulate-task-attribute-change-sequence-into-a-helper-macro/20230128-123001
patch link:    https://lore.kernel.org/r/20230128001639.3510083-28-tj%40kernel.org
patch subject: [PATCH 27/30] sched_ext: Implement core-sched support
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230129/202301290223.0qWZoY9T-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/750f973dd349cc5c3df29319b0ffae740738a9d2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tejun-Heo/sched-Encapsulate-task-attribute-change-sequence-into-a-helper-macro/20230128-123001
        git checkout 750f973dd349cc5c3df29319b0ffae740738a9d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:58:
>> kernel/sched/ext.c:3349:25: error: initialization of 'int (*)(const struct btf_type *, const struct btf_member *)' from incompatible pointer type 'int (*)(const struct btf_type *, const struct btf_member *, const struct bpf_prog *)' [-Werror=incompatible-pointer-types]
    3349 |         .check_member = bpf_scx_check_member,
         |                         ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/ext.c:3349:25: note: (near initialization for 'bpf_sched_ext_ops.check_member')
   kernel/sched/ext.c: In function 'scx_bpf_error_bstr':
>> kernel/sched/ext.c:3906:16: error: variable 'bprintf_data' has initializer but incomplete type
    3906 |         struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
         |                ^~~~~~~~~~~~~~~~
>> kernel/sched/ext.c:3906:51: error: 'struct bpf_bprintf_data' has no member named 'get_bin_args'
    3906 |         struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
         |                                                   ^~~~~~~~~~~~
>> kernel/sched/ext.c:3906:66: warning: excess elements in struct initializer
    3906 |         struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
         |                                                                  ^~~~
   kernel/sched/ext.c:3906:66: note: (near initialization for 'bprintf_data')
>> kernel/sched/ext.c:3906:33: error: storage size of 'bprintf_data' isn't known
    3906 |         struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
         |                                 ^~~~~~~~~~~~
>> kernel/sched/ext.c:3927:71: warning: passing argument 4 of 'bpf_bprintf_prepare' makes pointer from integer without a cast [-Wint-conversion]
    3927 |         ret = bpf_bprintf_prepare(fmt, UINT_MAX, bufs->data, data__sz / 8,
         |                                                              ~~~~~~~~~^~~
         |                                                                       |
         |                                                                       u32 {aka unsigned int}
   In file included from include/linux/bpf_verifier.h:7,
                    from kernel/sched/ext.c:3193:
   include/linux/bpf.h:2800:31: note: expected 'u32 **' {aka 'unsigned int **'} but argument is of type 'u32' {aka 'unsigned int'}
    2800 |                         u32 **bin_buf, u32 num_args);
         |                         ~~~~~~^~~~~~~
>> kernel/sched/ext.c:3936:9: error: too many arguments to function 'bpf_bprintf_cleanup'
    3936 |         bpf_bprintf_cleanup(&bprintf_data);
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/bpf.h:2801:6: note: declared here
    2801 | void bpf_bprintf_cleanup(void);
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/ext.c:3906:33: warning: unused variable 'bprintf_data' [-Wunused-variable]
    3906 |         struct bpf_bprintf_data bprintf_data = { .get_bin_args = true };
         |                                 ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +3349 kernel/sched/ext.c

4c016c2bafb66b Tejun Heo 2023-01-27  3344  
4c016c2bafb66b Tejun Heo 2023-01-27  3345  struct bpf_struct_ops bpf_sched_ext_ops = {
4c016c2bafb66b Tejun Heo 2023-01-27  3346  	.verifier_ops = &bpf_scx_verifier_ops,
4c016c2bafb66b Tejun Heo 2023-01-27  3347  	.reg = bpf_scx_reg,
4c016c2bafb66b Tejun Heo 2023-01-27  3348  	.unreg = bpf_scx_unreg,
4c016c2bafb66b Tejun Heo 2023-01-27 @3349  	.check_member = bpf_scx_check_member,
4c016c2bafb66b Tejun Heo 2023-01-27  3350  	.init_member = bpf_scx_init_member,
4c016c2bafb66b Tejun Heo 2023-01-27  3351  	.init = bpf_scx_init,
4c016c2bafb66b Tejun Heo 2023-01-27  3352  	.name = "sched_ext_ops",
4c016c2bafb66b Tejun Heo 2023-01-27  3353  };
4c016c2bafb66b Tejun Heo 2023-01-27  3354  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
