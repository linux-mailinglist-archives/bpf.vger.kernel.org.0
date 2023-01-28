Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAC67F7AD
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 12:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjA1Lxl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 06:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjA1Lxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 06:53:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5C669B30;
        Sat, 28 Jan 2023 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674906816; x=1706442816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kSQdtklRkBESj3j3SCGcfITrf2xNF+8tppB0MBhOsbs=;
  b=nMk1A09151JnA0odp/3aPwTBambcn6NNYkrhCgtHtEgmqiXtC/WTO+xR
   bGjhBZs4iMmXS5vyAPbERpQTTxYWYoSZd/ovkMX11QpHC5lu1zyXb/Lsj
   nGvQO3JvRPrhOxLXM8Ky1pdwgBDHrD5cbvsdCifUkW2IIbRzgV7ttSeeh
   fp9Uy8FIY2Lhxr7Ak74l+TUWT1tP++ObXfDiYuKzLEgVuNdRwhsvkn/V/
   YtPGn/lRW/5512fQzrWIaFVySng1YgD2eavF8JOX+0nAxHf03ioBAaxtM
   c4h+sp3tq2OzqkF+tEc9jd7+zQOJCwIc/lbednJgffFXgy0vCsTFcEJXu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="306933946"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="306933946"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 03:53:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663583231"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="663583231"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2023 03:53:32 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLjlv-0000cR-0K;
        Sat, 28 Jan 2023 11:53:27 +0000
Date:   Sat, 28 Jan 2023 19:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, ast@kernel.org,
        netdev@vger.kernel.org, memxor@gmail.com, kernel-team@fb.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH v8 bpf-next 2/5] bpf: Allow initializing dynptrs in kfuncs
Message-ID: <202301281922.okIebogn-lkp@intel.com>
References: <20230126233439.3739120-3-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126233439.3739120-3-joannelkoong@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Joanne,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/bpf-Allow-sk_buff-and-xdp_buff-as-valid-kfunc-arg-types/20230128-170947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230126233439.3739120-3-joannelkoong%40gmail.com
patch subject: [PATCH v8 bpf-next 2/5] bpf: Allow initializing dynptrs in kfuncs
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281922.okIebogn-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7993ffba3295a3a3c01c4b62099117b5abd48242
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joanne-Koong/bpf-Allow-sk_buff-and-xdp_buff-as-valid-kfunc-arg-types/20230128-170947
        git checkout 7993ffba3295a3a3c01c4b62099117b5abd48242
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash kernel/bpf/ net/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:6150:5: warning: no previous prototype for 'process_dynptr_func' [-Wmissing-prototypes]
    6150 | int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
         |     ^~~~~~~~~~~~~~~~~~~


vim +/process_dynptr_func +6150 kernel/bpf/verifier.c

  6124	
  6125	/* There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
  6126	 * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
  6127	 *
  6128	 * In both cases we deal with the first 8 bytes, but need to mark the next 8
  6129	 * bytes as STACK_DYNPTR in case of PTR_TO_STACK. In case of
  6130	 * CONST_PTR_TO_DYNPTR, we are guaranteed to get the beginning of the object.
  6131	 *
  6132	 * Mutability of bpf_dynptr is at two levels, one is at the level of struct
  6133	 * bpf_dynptr itself, i.e. whether the helper is receiving a pointer to struct
  6134	 * bpf_dynptr or pointer to const struct bpf_dynptr. In the former case, it can
  6135	 * mutate the view of the dynptr and also possibly destroy it. In the latter
  6136	 * case, it cannot mutate the bpf_dynptr itself but it can still mutate the
  6137	 * memory that dynptr points to.
  6138	 *
  6139	 * The verifier will keep track both levels of mutation (bpf_dynptr's in
  6140	 * reg->type and the memory's in reg->dynptr.type), but there is no support for
  6141	 * readonly dynptr view yet, hence only the first case is tracked and checked.
  6142	 *
  6143	 * This is consistent with how C applies the const modifier to a struct object,
  6144	 * where the pointer itself inside bpf_dynptr becomes const but not what it
  6145	 * points to.
  6146	 *
  6147	 * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their argument
  6148	 * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
  6149	 */
> 6150	int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
  6151				enum bpf_arg_type arg_type)
  6152	{
  6153		struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
  6154		int err;
  6155	
  6156		/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
  6157		 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
  6158		 */
  6159		if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
  6160			verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
  6161			return -EFAULT;
  6162		}
  6163	
  6164		/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
  6165		 *		 constructing a mutable bpf_dynptr object.
  6166		 *
  6167		 *		 Currently, this is only possible with PTR_TO_STACK
  6168		 *		 pointing to a region of at least 16 bytes which doesn't
  6169		 *		 contain an existing bpf_dynptr.
  6170		 *
  6171		 *  MEM_RDONLY - Points to a initialized bpf_dynptr that will not be
  6172		 *		 mutated or destroyed. However, the memory it points to
  6173		 *		 may be mutated.
  6174		 *
  6175		 *  None       - Points to a initialized dynptr that can be mutated and
  6176		 *		 destroyed, including mutation of the memory it points
  6177		 *		 to.
  6178		 */
  6179		if (arg_type & MEM_UNINIT) {
  6180			int i, spi;
  6181	
  6182			if (base_type(reg->type) == CONST_PTR_TO_DYNPTR) {
  6183				verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be initialized\n");
  6184				return -EFAULT;
  6185			}
  6186	
  6187			/* For -ERANGE (i.e. spi not falling into allocated stack slots),
  6188			 * check_mem_access will check and update stack bounds, so this
  6189			 * is okay.
  6190			 */
  6191			spi = dynptr_get_spi(env, reg);
  6192			if (spi < 0 && spi != -ERANGE)
  6193				return spi;
  6194	
  6195			/* we write BPF_DW bits (8 bytes) at a time */
  6196			for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
  6197				err = check_mem_access(env, insn_idx, regno,
  6198						       i, BPF_DW, BPF_WRITE, -1, false);
  6199				if (err)
  6200					return err;
  6201			}
  6202	
  6203			/* Please note that we allow overwriting existing unreferenced STACK_DYNPTR
  6204			 * slots (mark_stack_slots_dynptr calls destroy_if_dynptr_stack_slot
  6205			 * to ensure dynptr objects at the slots we are touching are completely
  6206			 * destructed before we reinitialize them for a new one). For referenced
  6207			 * ones, destroy_if_dynptr_stack_slot returns an error early instead of
  6208			 * delaying it until the end where the user will get "Unreleased
  6209			 * reference" error.
  6210			 */
  6211			err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx);
  6212		} else /* MEM_RDONLY and None case from above */ {
  6213			/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
  6214			if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
  6215				verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
  6216				return -EINVAL;
  6217			}
  6218	
  6219			if (!is_dynptr_reg_valid_init(env, reg)) {
  6220				verbose(env, "Expected an initialized dynptr as arg #%d\n",
  6221					regno);
  6222				return -EINVAL;
  6223			}
  6224	
  6225			/* Fold modifiers (in this case, MEM_RDONLY) when checking expected type */
  6226			if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
  6227				const char *err_extra = "";
  6228	
  6229				switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
  6230				case DYNPTR_TYPE_LOCAL:
  6231					err_extra = "local";
  6232					break;
  6233				case DYNPTR_TYPE_RINGBUF:
  6234					err_extra = "ringbuf";
  6235					break;
  6236				default:
  6237					err_extra = "<unknown>";
  6238					break;
  6239				}
  6240				verbose(env,
  6241					"Expected a dynptr of type %s as arg #%d\n",
  6242					err_extra, regno);
  6243				return -EINVAL;
  6244			}
  6245	
  6246			err = mark_dynptr_read(env, reg);
  6247		}
  6248		return err;
  6249	}
  6250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
