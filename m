Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C77A6D8651
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 20:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjDESya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDESy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 14:54:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AA3A9E
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680720866; x=1712256866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ySDpSlY61EmOZUDP9ab+Mrr9+JW/wcfMmHmCCzcMfg=;
  b=M4a8MZ4KRK5qDbtjBqfOXpIjigmhLKDk5xgmPhxCxDuIljH2/hnI+JVp
   dxiafg4V366aKPy5AxDhwHFWpDmgvWaVAkBEMTDfX9e1+NjNmLkMyYZ4T
   d+KuYRyJtA9TYHWVGYD98XSCDzBLwqHpT1RFVK05G4ze370JKe0jqO/HR
   +ZVtK8bz15nytz8R3l0p/9edX2gN49RifFL/o92EG8LsKtLhA9lXfSBcy
   zv1ecYiT3nTYkQSkCIqIh9puTi+JwrSWeT52q8OZ3cGrGE5tMQitDEzuK
   nQlln1ZtzY1eBQ+nA1R20+PQmWneZWYGf9EYLuaHBX/9zHHnWJh7rndlL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370370271"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="370370271"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 11:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="861099879"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="861099879"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Apr 2023 11:54:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pk8Gz-000QiU-04;
        Wed, 05 Apr 2023 18:54:21 +0000
Date:   Thu, 6 Apr 2023 02:54:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next v5] bpf: Support 64-bit pointers to kfuncs
Message-ID: <202304060240.OeUgnjzZ-lkp@intel.com>
References: <20230405141407.172357-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405141407.172357-1-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ilya,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilya-Leoshkevich/bpf-Support-64-bit-pointers-to-kfuncs/20230405-221738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230405141407.172357-1-iii%40linux.ibm.com
patch subject: [PATCH bpf-next v5] bpf: Support 64-bit pointers to kfuncs
config: i386-randconfig-r022-20230403 (https://download.01.org/0day-ci/archive/20230406/202304060240.OeUgnjzZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/43119fecff7ac0771f037a6dc128ceb791917466
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ilya-Leoshkevich/bpf-Support-64-bit-pointers-to-kfuncs/20230405-221738
        git checkout 43119fecff7ac0771f037a6dc128ceb791917466
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304060240.OeUgnjzZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/bpf/core.c: In function 'bpf_jit_get_func_addr':
>> kernel/bpf/core.c:1207:23: error: implicit declaration of function 'bpf_get_kfunc_addr'; did you mean 'bpf_jit_get_func_addr'? [-Werror=implicit-function-declaration]
    1207 |                 err = bpf_get_kfunc_addr(prog, insn->imm, insn->off, &addr);
         |                       ^~~~~~~~~~~~~~~~~~
         |                       bpf_jit_get_func_addr
   kernel/bpf/core.c: At top level:
   kernel/bpf/core.c:1638:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1638 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/core.c:2075:6: warning: no previous prototype for 'bpf_patch_call_args' [-Wmissing-prototypes]
    2075 | void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1207 kernel/bpf/core.c

  1182	
  1183	int bpf_jit_get_func_addr(const struct bpf_prog *prog,
  1184				  const struct bpf_insn *insn, bool extra_pass,
  1185				  u64 *func_addr, bool *func_addr_fixed)
  1186	{
  1187		s16 off = insn->off;
  1188		s32 imm = insn->imm;
  1189		u8 *addr;
  1190		int err;
  1191	
  1192		*func_addr_fixed = insn->src_reg != BPF_PSEUDO_CALL;
  1193		if (!*func_addr_fixed) {
  1194			/* Place-holder address till the last pass has collected
  1195			 * all addresses for JITed subprograms in which case we
  1196			 * can pick them up from prog->aux.
  1197			 */
  1198			if (!extra_pass)
  1199				addr = NULL;
  1200			else if (prog->aux->func &&
  1201				 off >= 0 && off < prog->aux->func_cnt)
  1202				addr = (u8 *)prog->aux->func[off]->bpf_func;
  1203			else
  1204				return -EINVAL;
  1205		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
  1206			   bpf_jit_supports_far_kfunc_call()) {
> 1207			err = bpf_get_kfunc_addr(prog, insn->imm, insn->off, &addr);
  1208			if (err)
  1209				return err;
  1210		} else {
  1211			/* Address of a BPF helper call. Since part of the core
  1212			 * kernel, it's always at a fixed location. __bpf_call_base
  1213			 * and the helper with imm relative to it are both in core
  1214			 * kernel.
  1215			 */
  1216			addr = (u8 *)__bpf_call_base + imm;
  1217		}
  1218	
  1219		*func_addr = (unsigned long)addr;
  1220		return 0;
  1221	}
  1222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
