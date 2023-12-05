Return-Path: <bpf+bounces-16721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD180501A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 11:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77C91F21528
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9951023;
	Tue,  5 Dec 2023 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR4kL9WI"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24BFA0
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701771715; x=1733307715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eI5vtNusfqSvE9X2q9nEEXNFmJVKkAWPAIy6Y7CBWaA=;
  b=RR4kL9WITGilvbCwKXt1VbCEBwOynfumrS2EbyoNkfnuKcTOfrFdrj0a
   FjUboN8MbBuEZtLmU+CL8AN5V4zNmDBB4Q1kAEzgiaZSz5ux9/N+tebtQ
   Z5EdwHpetcDrEcSZ4eLNZotZQMwISBvnw8Yx3CuqRuI3xmUkuyPvIcxLF
   skzPq+Baq2Mj56Yean8oYPwbEEq+LOyOhOKuP6+cuqxKe/odPTi6OYg7e
   mLZrQvCnmnmILh5YiVKHkHmnSgkMDJOAut0BSKBs4pkj6Ed4qTMzfNCjT
   a/xqACWnqsBKytPMJmqsiM0mdezoH2YTDe7P6cToXDq4gvpOX9qiG/7z3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="716134"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="716134"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 02:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018174044"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1018174044"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 02:21:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rASYo-0008kN-37;
	Tue, 05 Dec 2023 10:21:51 +0000
Date: Tue, 5 Dec 2023 18:21:09 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 09/13] bpf: reuse subprog argument parsing logic
 for subprog call checks
Message-ID: <202312051858.R1gH7aIp-lkp@intel.com>
References: <20231204233931.49758-10-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204233931.49758-10-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bpf-log-PTR_TO_MEM-memory-size-in-verifier-log/20231205-074451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231204233931.49758-10-andrii%40kernel.org
patch subject: [PATCH bpf-next 09/13] bpf: reuse subprog argument parsing logic for subprog call checks
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231205/202312051858.R1gH7aIp-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051858.R1gH7aIp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051858.R1gH7aIp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c:5083:5: warning: no previous prototype for 'check_ptr_off_reg' [-Wmissing-prototypes]
    5083 | int check_ptr_off_reg(struct bpf_verifier_env *env,
         |     ^~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c:7268:5: warning: no previous prototype for 'check_mem_reg' [-Wmissing-prototypes]
    7268 | int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
         |     ^~~~~~~~~~~~~
   kernel/bpf/verifier.c:8254:5: warning: no previous prototype for 'check_func_arg_reg_off' [-Wmissing-prototypes]
    8254 | int check_func_arg_reg_off(struct bpf_verifier_env *env,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/verifier.c: In function 'btf_check_func_arg_match':
>> kernel/bpf/verifier.c:9223:21: warning: variable 'func_name' set but not used [-Wunused-but-set-variable]
    9223 |         const char *func_name;
         |                     ^~~~~~~~~
   kernel/bpf/verifier.c: At top level:
>> kernel/bpf/verifier.c:9291:5: warning: no previous prototype for 'btf_check_subprog_call' [-Wmissing-prototypes]
    9291 | int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +/func_name +9223 kernel/bpf/verifier.c

  9216	
  9217	static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
  9218					    const struct btf *btf, u32 func_id,
  9219					    struct bpf_reg_state *regs)
  9220	{
  9221		struct bpf_subprog_info *sub = subprog_info(env, subprog);
  9222		struct bpf_verifier_log *log = &env->log;
> 9223		const char *func_name;
  9224		const struct btf_type *fn_t;
  9225		u32 i;
  9226		int ret;
  9227	
  9228		ret = btf_prepare_func_args(env, subprog);
  9229		if (ret)
  9230			return ret;
  9231	
  9232		fn_t = btf_type_by_id(btf, func_id);
  9233		if (!fn_t || !btf_type_is_func(fn_t)) {
  9234			/* These checks were already done by the verifier while loading
  9235			 * struct bpf_func_info or in add_kfunc_call().
  9236			 */
  9237			bpf_log(log, "BTF of func_id %u doesn't point to KIND_FUNC\n",
  9238				func_id);
  9239			return -EFAULT;
  9240		}
  9241		func_name = btf_name_by_offset(btf, fn_t->name_off);
  9242	
  9243		/* check that BTF function arguments match actual types that the
  9244		 * verifier sees.
  9245		 */
  9246		for (i = 0; i < sub->arg_cnt; i++) {
  9247			u32 regno = i + 1;
  9248			struct bpf_reg_state *reg = &regs[regno];
  9249			struct bpf_subprog_arg_info *arg = &sub->args[i];
  9250	
  9251			if (arg->arg_type == ARG_SCALAR) {
  9252				if (reg->type != SCALAR_VALUE) {
  9253					bpf_log(log, "R%d is not a scalar\n", regno);
  9254					return -EINVAL;
  9255				}
  9256			} else if (arg->arg_type == ARG_PTR_TO_CTX) {
  9257				ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
  9258				if (ret < 0)
  9259					return ret;
  9260				/* If function expects ctx type in BTF check that caller
  9261				 * is passing PTR_TO_CTX.
  9262				 */
  9263				if (reg->type != PTR_TO_CTX) {
  9264					bpf_log(log, "arg#%d expects pointer to ctx\n", i);
  9265					return -EINVAL;
  9266				}
  9267			} else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
  9268				ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
  9269				if (ret < 0)
  9270					return ret;
  9271	
  9272				if (check_mem_reg(env, reg, regno, arg->mem_size))
  9273					return -EINVAL;
  9274			} else {
  9275				bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
  9276					i, arg->arg_type);
  9277				return -EFAULT;
  9278			}
  9279		}
  9280	
  9281		return 0;
  9282	}
  9283	
  9284	/* Compare BTF of a function call with given bpf_reg_state.
  9285	 * Returns:
  9286	 * EFAULT - there is a verifier bug. Abort verification.
  9287	 * EINVAL - there is a type mismatch or BTF is not available.
  9288	 * 0 - BTF matches with what bpf_reg_state expects.
  9289	 * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
  9290	 */
> 9291	int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
  9292				   struct bpf_reg_state *regs)
  9293	{
  9294		struct bpf_prog *prog = env->prog;
  9295		struct btf *btf = prog->aux->btf;
  9296		u32 btf_id;
  9297		int err;
  9298	
  9299		if (!prog->aux->func_info)
  9300			return -EINVAL;
  9301	
  9302		btf_id = prog->aux->func_info[subprog].type_id;
  9303		if (!btf_id)
  9304			return -EFAULT;
  9305	
  9306		if (prog->aux->func_info_aux[subprog].unreliable)
  9307			return -EINVAL;
  9308	
  9309		err = btf_check_func_arg_match(env, subprog, btf, btf_id, regs);
  9310		/* Compiler optimizations can remove arguments from static functions
  9311		 * or mismatched type can be passed into a global function.
  9312		 * In such cases mark the function as unreliable from BTF point of view.
  9313		 */
  9314		if (err)
  9315			prog->aux->func_info_aux[subprog].unreliable = true;
  9316		return err;
  9317	}
  9318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

