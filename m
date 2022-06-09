Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C187544FFA
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbiFIO4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241672AbiFIO4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 10:56:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BEC39BDB9
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654786601; x=1686322601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMlf7JU/ZvyPXyCSqmvxhcZQGfHSrOT8Ep9dWoQobNA=;
  b=AtW2ykVDKTzoYMSFp5HwvY3fs9/rflYTIrBgS0D2NfTIAIIOudLAxwvS
   II6Ay6wHY6Kw3G2n/ZiwICWeIXOmQ9Mkk0niRo2ZBJPg+4hD53gZUAZSp
   +23gPGETyTsHFWIekmKzFkYgkdfaxVgTgH3eD3lqvP4UZPCU45Yaxz/RQ
   RqbcTZsTn2PWCKEtCt6dSRf961jjMsN76glOQfQFhUMLO8wu5Df1VJ896
   0sx73Wp6odii9wQNGgGSYq4S6HOi3//v0qHGpfO51hEjPURY4CA+qGrAo
   U/LF/2W7RwBbsLs+kZxmZgBq+azZDFrjxGAF9IuZxXV0uajxDWBj5Qm1i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339067933"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="339067933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 07:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="671349491"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2022 07:56:36 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzJaO-000G53-2T;
        Thu, 09 Jun 2022 14:56:36 +0000
Date:   Thu, 9 Jun 2022 22:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, song@kernel.org, joannelkoong@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, eddyz87@gmail.com
Subject: Re: [PATCH bpf-next v4 3/5] bpf: Inline calls to bpf_loop when
 callback is known
Message-ID: <202206092228.SWNGbTFO-lkp@intel.com>
References: <20220608192630.3710333-4-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608192630.3710333-4-eddyz87@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Eduard,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf_loop-inlining/20220609-033007
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: arm-randconfig-r014-20220608 (https://download.01.org/0day-ci/archive/20220609/202206092228.SWNGbTFO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/10671a6a0479bb7ee4d437c4ce7307f198cb96fd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eduard-Zingerman/bpf_loop-inlining/20220609-033007
        git checkout 10671a6a0479bb7ee4d437c4ce7307f198cb96fd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:7111:6: warning: no previous prototype for function 'update_loop_inline_state' [-Wmissing-prototypes]
   void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
        ^
   kernel/bpf/verifier.c:7111:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
   ^
   static 
>> kernel/bpf/verifier.c:14318:18: warning: no previous prototype for function 'inline_bpf_loop' [-Wmissing-prototypes]
   struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
                    ^
   kernel/bpf/verifier.c:14318:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
   ^
   static 
   2 warnings generated.


vim +/update_loop_inline_state +7111 kernel/bpf/verifier.c

  7110	
> 7111	void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno)
  7112	{
  7113		struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
  7114		struct bpf_reg_state *regs = cur_regs(env);
  7115		struct bpf_reg_state *flags_reg = &regs[BPF_REG_4];
  7116	
  7117		int flags_is_zero =
  7118			register_is_const(flags_reg) && flags_reg->var_off.value == 0;
  7119	
  7120		if (state->initialized) {
  7121			state->fit_for_inline &=
  7122				flags_is_zero &&
  7123				state->callback_subprogno == subprogno;
  7124		} else {
  7125			state->initialized = 1;
  7126			state->fit_for_inline = flags_is_zero;
  7127			state->callback_subprogno = subprogno;
  7128		}
  7129	}
  7130	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
