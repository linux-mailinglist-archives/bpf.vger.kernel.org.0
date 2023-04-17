Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6C6E506F
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjDQSyH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDQSyG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 14:54:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B11B8F
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681757645; x=1713293645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M69RrZcvdueoFuT2kpAZU2B366vMBCc0JV5qRiQowmI=;
  b=lyRjE0WckvJARQBsOL2B5CrDx72SI2svumsuss+P0KoQPkUOmKinTrwo
   64CjgD3pCcWCXiZHy9DIJaBp/Gql3T26WRZLBgvXJtLN/+Plkva3b3oil
   hwqErHUZl7QMBM5ccZQtcm0Ukpm99/2qsXnrohHKAzvOShpua5su/Xxzc
   muQ8j0bORjUezhEYf+XSfZLoza27Bk8U+7TLIwecjJbqRvfCp8KBfSUvn
   USIssUn9Fw/C/KZisLVBMXtOpa8lN/PKvVGLDU4nlvq9svDkWuDNU/KGa
   Yf+xfvV8lJttWtK1EMmNEdGT+ZTI8h6v5B0Uwc5R8SCo8NHlJKsrTPOaO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="344979778"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="344979778"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 11:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="668199152"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="668199152"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Apr 2023 11:54:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poTzF-000cdD-2a;
        Mon, 17 Apr 2023 18:54:01 +0000
Date:   Tue, 18 Apr 2023 02:53:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] bpf: Add bpf_dynptr_clone
Message-ID: <202304180233.Hk6WZE5M-lkp@intel.com>
References: <20230409033431.3992432-5-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409033431.3992432-5-joannelkoong@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/bpf-Add-bpf_dynptr_trim-and-bpf_dynptr_advance/20230409-113652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230409033431.3992432-5-joannelkoong%40gmail.com
patch subject: [PATCH v1 bpf-next 4/5] bpf: Add bpf_dynptr_clone
config: m68k-randconfig-s032-20230416 (https://download.01.org/0day-ci/archive/20230418/202304180233.Hk6WZE5M-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d7830addcc26375f56b68655ddbfb44116b3e7f6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joanne-Koong/bpf-Add-bpf_dynptr_trim-and-bpf_dynptr_advance/20230409-113652
        git checkout d7830addcc26375f56b68655ddbfb44116b3e7f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304180233.Hk6WZE5M-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/verifier.c:7020:41: sparse: sparse: mixing different enum types:
>> kernel/bpf/verifier.c:7020:41: sparse:    unsigned int enum bpf_arg_type
>> kernel/bpf/verifier.c:7020:41: sparse:    unsigned int enum bpf_type_flag
   kernel/bpf/verifier.c:18042:38: sparse: sparse: subtraction of functions? Share your drugs
   kernel/bpf/verifier.c: note: in included file (through include/linux/bpf.h, include/linux/bpf-cgroup.h):
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast to non-scalar
   include/linux/bpfptr.h:65:40: sparse: sparse: cast from non-scalar

vim +7020 kernel/bpf/verifier.c

  7006	
  7007	static int handle_dynptr_clone(struct bpf_verifier_env *env, enum bpf_arg_type arg_type,
  7008				       int regno, int insn_idx, struct bpf_kfunc_call_arg_meta *meta)
  7009	{
  7010		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
  7011		struct bpf_reg_state *first_reg_state, *second_reg_state;
  7012		struct bpf_func_state *state = func(env, reg);
  7013		enum bpf_dynptr_type dynptr_type = meta->initialized_dynptr.type;
  7014		int err, spi, ref_obj_id;
  7015	
  7016		if (!dynptr_type) {
  7017			verbose(env, "verifier internal error: no dynptr type for bpf_dynptr_clone\n");
  7018			return -EFAULT;
  7019		}
> 7020		arg_type |= get_dynptr_type_flag(dynptr_type);
  7021	
  7022		err = process_dynptr_func(env, regno, insn_idx, arg_type);
  7023		if (err < 0)
  7024			return err;
  7025	
  7026		spi = dynptr_get_spi(env, reg);
  7027		if (spi < 0)
  7028			return spi;
  7029	
  7030		first_reg_state = &state->stack[spi].spilled_ptr;
  7031		second_reg_state = &state->stack[spi - 1].spilled_ptr;
  7032		ref_obj_id = first_reg_state->ref_obj_id;
  7033	
  7034		/* reassign the clone the same dynptr id as the original */
  7035		__mark_dynptr_reg(first_reg_state, dynptr_type, true, meta->initialized_dynptr.id);
  7036		__mark_dynptr_reg(second_reg_state, dynptr_type, false, meta->initialized_dynptr.id);
  7037	
  7038		if (meta->initialized_dynptr.ref_obj_id) {
  7039			/* release the new ref obj id assigned during process_dynptr_func */
  7040			err = release_reference_state(cur_func(env), ref_obj_id);
  7041			if (err)
  7042				return err;
  7043			/* reassign the clone the same ref obj id as the original */
  7044			first_reg_state->ref_obj_id = meta->initialized_dynptr.ref_obj_id;
  7045			second_reg_state->ref_obj_id = meta->initialized_dynptr.ref_obj_id;
  7046		}
  7047	
  7048		return 0;
  7049	}
  7050	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
