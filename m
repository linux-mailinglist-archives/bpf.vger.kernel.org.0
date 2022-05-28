Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BA536A7C
	for <lists+bpf@lfdr.de>; Sat, 28 May 2022 05:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353559AbiE1D6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 May 2022 23:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiE1D6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 May 2022 23:58:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648655EBCD
        for <bpf@vger.kernel.org>; Fri, 27 May 2022 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653710318; x=1685246318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ilybc3HInNxoW9v9y4QpNgM3s38lZeWVNtlPNButV5A=;
  b=PcYE1xK/qIxD4tnmCc1n6QsGTsRY07NLkc5vX5qzzhMKnKrpjlfv90p0
   kQHUKQofLokxriUtaKjxoP+pwggEJRimwO1OO6onHbADJLrjqVcUwH/Xk
   jXK9EAkrIf8siK2Sbb1rQxyIwtm7YS9vUtlxHEVWCVO9X0ITgxchL3Zhi
   HtTUrM3LkTiFCEK+CR1XT/ZST1P0pdTiUym+Ya7LAXGA0eUbmaDYW8y5Q
   xLiOnAddDRFEGnc8bxAQ6IbayaNjmAID2ntqk3sujjtS/DnIYuuF2YSW8
   6nPjF/V+6VigeUNSQm9lVcNecQRYE+pHlL8X+/9haXzZh6AVl9CatfaAN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274350847"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="274350847"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 20:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; 
   d="scan'208";a="705421970"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 20:58:36 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nunb1-0005QL-FY;
        Sat, 28 May 2022 03:58:35 +0000
Date:   Sat, 28 May 2022 11:58:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Cc:     kbuild-all@lists.01.org, eddyz87@gmail.com
Subject: Re: [PATCH bpf-next 3/3] bpf: Inline calls to bpf_loop when callback
 is known
Message-ID: <202205281148.rY3lJqB4-lkp@intel.com>
References: <20220527235228.224879-3-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527235228.224879-3-eddyz87@gmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Eduard,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf_loop-inlining/20220528-075454
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220528/202205281148.rY3lJqB4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/05c5a11449d4e5c75ada599a71d8290bef8a5d1a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eduard-Zingerman/bpf_loop-inlining/20220528-075454
        git checkout 05c5a11449d4e5c75ada599a71d8290bef8a5d1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'adjust_stack_depth_for_loop_inlining':
>> kernel/bpf/verifier.c:7127:16: warning: variable 'subprog_start' set but not used [-Wunused-but-set-variable]
    7127 |         int i, subprog_start, subprog_end, cur_subprog = 0;
         |                ^~~~~~~~~~~~~


vim +/subprog_start +7127 kernel/bpf/verifier.c

  7117	
  7118	/* For all sub-programs in the program (including main) checks
  7119	 * insn_aux_data to see if there are bpf_loop calls that require
  7120	 * inlining. If such calls are found subprog stack_depth is increased
  7121	 * by the size of 3 registers. Reserved space would be used in the
  7122	 * do_misc_fixups to spill values of the R6, R7, R8 to use these
  7123	 * registers for loop iteration.
  7124	 */
  7125	static void adjust_stack_depth_for_loop_inlining(struct bpf_verifier_env *env)
  7126	{
> 7127		int i, subprog_start, subprog_end, cur_subprog = 0;
  7128		struct bpf_subprog_info *subprog = env->subprog_info;
  7129		int insn_cnt = env->prog->len;
  7130	
  7131		subprog_start = subprog[cur_subprog].start;
  7132		subprog_end = env->subprog_cnt > 1
  7133			? subprog[cur_subprog + 1].start
  7134			: insn_cnt;
  7135		for (i = 0; i < insn_cnt; i++) {
  7136			if (fit_for_bpf_loop_inline(&env->insn_aux_data[i])) {
  7137				/* reserve space for 3 registers  */
  7138				subprog->stack_depth += BPF_REG_SIZE * 3;
  7139				/* skip to the next subprog */
  7140				i = subprog_end - 1;
  7141			}
  7142			if (i == subprog_end - 1) {
  7143				subprog_start = subprog_end;
  7144				cur_subprog++;
  7145				if (cur_subprog < env->subprog_cnt)
  7146					subprog_end = subprog[cur_subprog + 1].start;
  7147			}
  7148		}
  7149	
  7150		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
  7151	}
  7152	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
