Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5060167F666
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 09:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjA1Ihk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 03:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjA1Ihi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 03:37:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D637265B
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 00:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674895055; x=1706431055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OlAmOu4dBIVlFMhLbTrOL6QeiPLbuNjQyOo90B3Go54=;
  b=ZMBqOVw8s5Qw7PLyUmNuB5f2SX2dgATyS5nvWaSro8w7XtIALCgZzLx5
   L0hU1KOovGhbTOVrz2RM9pzo60zBPdeHT1hpqoCJx9NAkcwP+en1dwCOa
   ENeqCWoFtYGUbJwUnh1/AOpEa93OJDDlVhk0rcvJsqe9drl5BB+PooFio
   rqfFFbsXVpR3/LsxNn3mUztN5zd7jLoSpY+Ytx+nIaMpZxizCRQ+wm99Z
   qbUeG4VL2KDc4yacqQY8n8U/qBicKDqmmT2A6ne8S5IPneZZQ5SSAweed
   vbco2ghnp59WfgT1OMzNI+IS7F3Kr6ArzHjE55Cs0gBZC7dFGPQcWxs1A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327292360"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="327292360"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="806096742"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="806096742"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2023 00:37:28 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLgiB-0000WZ-0f;
        Sat, 28 Jan 2023 08:37:23 +0000
Date:   Sat, 28 Jan 2023 16:37:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 29/31] s390/bpf: Implement
 arch_prepare_bpf_trampoline()
Message-ID: <202301281649.0881RcCr-lkp@intel.com>
References: <20230128000650.1516334-30-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128000650.1516334-30-iii@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ilya,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilya-Leoshkevich/bpf-Use-ARG_CONST_SIZE_OR_ZERO-for-3rd-argument-of-bpf_tcp_raw_gen_syncookie_ipv-4-6/20230128-143920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20230128000650.1516334-30-iii%40linux.ibm.com
patch subject: [PATCH bpf-next v2 29/31] s390/bpf: Implement arch_prepare_bpf_trampoline()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281649.0881RcCr-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/067ec74d790af1fd8c02b8d3571cf743d53e3656
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ilya-Leoshkevich/bpf-Use-ARG_CONST_SIZE_OR_ZERO-for-3rd-argument-of-bpf_tcp_raw_gen_syncookie_ipv-4-6/20230128-143920
        git checkout 067ec74d790af1fd8c02b8d3571cf743d53e3656
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/s390/net/bpf_jit_comp.c:2158:5: warning: no previous prototype for '__arch_prepare_bpf_trampoline' [-Wmissing-prototypes]
    2158 | int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__arch_prepare_bpf_trampoline +2158 arch/s390/net/bpf_jit_comp.c

  2157	
> 2158	int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
  2159					  struct bpf_tramp_jit *tjit,
  2160					  const struct btf_func_model *m,
  2161					  u32 flags, struct bpf_tramp_links *tlinks,
  2162					  void *func_addr)
  2163	{
  2164		struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
  2165		struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
  2166		struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
  2167		int nr_bpf_args, nr_reg_args, nr_stack_args;
  2168		struct bpf_jit *jit = &tjit->common;
  2169		int arg, bpf_arg_off;
  2170		int i, j;
  2171	
  2172		/* Support as many stack arguments as "mvc" instruction can handle. */
  2173		nr_reg_args = min_t(int, m->nr_args, MAX_NR_REG_ARGS);
  2174		nr_stack_args = m->nr_args - nr_reg_args;
  2175		if (nr_stack_args > MAX_NR_STACK_ARGS)
  2176			return -ENOTSUPP;
  2177	
  2178		/* Return to %r14, since func_addr and %r0 are not available. */
  2179		if (!func_addr && !(flags & BPF_TRAMP_F_ORIG_STACK))
  2180			flags |= BPF_TRAMP_F_SKIP_FRAME;
  2181	
  2182		/*
  2183		 * Compute how many arguments we need to pass to BPF programs.
  2184		 * BPF ABI mirrors that of x86_64: arguments that are 16 bytes or
  2185		 * smaller are packed into 1 or 2 registers; larger arguments are
  2186		 * passed via pointers.
  2187		 * In s390x ABI, arguments that are 8 bytes or smaller are packed into
  2188		 * a register; larger arguments are passed via pointers.
  2189		 * We need to deal with this difference.
  2190		 */
  2191		nr_bpf_args = 0;
  2192		for (i = 0; i < m->nr_args; i++) {
  2193			if (m->arg_size[i] <= 8)
  2194				nr_bpf_args += 1;
  2195			else if (m->arg_size[i] <= 16)
  2196				nr_bpf_args += 2;
  2197			else
  2198				return -ENOTSUPP;
  2199		}
  2200	
  2201		/*
  2202		 * Calculate the stack layout.
  2203		 */
  2204	
  2205		/* Reserve STACK_FRAME_OVERHEAD bytes for the callees. */
  2206		tjit->stack_size = STACK_FRAME_OVERHEAD;
  2207		tjit->stack_args_off = alloc_stack(tjit, nr_stack_args * sizeof(u64));
  2208		tjit->reg_args_off = alloc_stack(tjit, nr_reg_args * sizeof(u64));
  2209		tjit->ip_off = alloc_stack(tjit, sizeof(u64));
  2210		tjit->arg_cnt_off = alloc_stack(tjit, sizeof(u64));
  2211		tjit->bpf_args_off = alloc_stack(tjit, nr_bpf_args * sizeof(u64));
  2212		tjit->retval_off = alloc_stack(tjit, sizeof(u64));
  2213		tjit->r7_r8_off = alloc_stack(tjit, 2 * sizeof(u64));
  2214		tjit->r14_off = alloc_stack(tjit, sizeof(u64));
  2215		tjit->run_ctx_off = alloc_stack(tjit,
  2216						sizeof(struct bpf_tramp_run_ctx));
  2217		/* The caller has already reserved STACK_FRAME_OVERHEAD bytes. */
  2218		tjit->stack_size -= STACK_FRAME_OVERHEAD;
  2219		tjit->orig_stack_args_off = tjit->stack_size + STACK_FRAME_OVERHEAD;
  2220	
  2221		/* aghi %r15,-stack_size */
  2222		EMIT4_IMM(0xa70b0000, REG_15, -tjit->stack_size);
  2223		/* stmg %r2,%rN,fwd_reg_args_off(%r15) */
  2224		if (nr_reg_args)
  2225			EMIT6_DISP_LH(0xeb000000, 0x0024, REG_2,
  2226				      REG_2 + (nr_reg_args - 1), REG_15,
  2227				      tjit->reg_args_off);
  2228		for (i = 0, j = 0; i < m->nr_args; i++) {
  2229			if (i < MAX_NR_REG_ARGS)
  2230				arg = REG_2 + i;
  2231			else
  2232				arg = tjit->orig_stack_args_off +
  2233				      (i - MAX_NR_REG_ARGS) * sizeof(u64);
  2234			bpf_arg_off = tjit->bpf_args_off + j * sizeof(u64);
  2235			if (m->arg_size[i] <= 8) {
  2236				if (i < MAX_NR_REG_ARGS)
  2237					/* stg %arg,bpf_arg_off(%r15) */
  2238					EMIT6_DISP_LH(0xe3000000, 0x0024, arg,
  2239						      REG_0, REG_15, bpf_arg_off);
  2240				else
  2241					/* mvc bpf_arg_off(8,%r15),arg(%r15) */
  2242					_EMIT6(0xd207f000 | bpf_arg_off,
  2243					       0xf000 | arg);
  2244				j += 1;
  2245			} else {
  2246				if (i < MAX_NR_REG_ARGS) {
  2247					/* mvc bpf_arg_off(16,%r15),0(%arg) */
  2248					_EMIT6(0xd20ff000 | bpf_arg_off,
  2249					       reg2hex[arg] << 12);
  2250				} else {
  2251					/* lg %r1,arg(%r15) */
  2252					EMIT6_DISP_LH(0xe3000000, 0x0004, REG_1, REG_0,
  2253						      REG_15, arg);
  2254					/* mvc bpf_arg_off(16,%r15),0(%r1) */
  2255					_EMIT6(0xd20ff000 | bpf_arg_off, 0x1000);
  2256				}
  2257				j += 2;
  2258			}
  2259		}
  2260		/* stmg %r7,%r8,r7_r8_off(%r15) */
  2261		EMIT6_DISP_LH(0xeb000000, 0x0024, REG_7, REG_8, REG_15,
  2262			      tjit->r7_r8_off);
  2263		/* stg %r14,r14_off(%r15) */
  2264		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_14, REG_0, REG_15, tjit->r14_off);
  2265	
  2266		if (flags & BPF_TRAMP_F_ORIG_STACK) {
  2267			/*
  2268			 * The ftrace trampoline puts the return address (which is the
  2269			 * address of the original function + S390X_PATCH_SIZE) into
  2270			 * %r0; see ftrace_shared_hotpatch_trampoline_br and
  2271			 * ftrace_init_nop() for details.
  2272			 */
  2273	
  2274			/* lgr %r8,%r0 */
  2275			EMIT4(0xb9040000, REG_8, REG_0);
  2276		} else {
  2277			/* %r8 = func_addr + S390X_PATCH_SIZE */
  2278			load_imm64(jit, REG_8, (u64)func_addr + S390X_PATCH_SIZE);
  2279		}
  2280	
  2281		/*
  2282		 * ip = func_addr;
  2283		 * arg_cnt = m->nr_args;
  2284		 */
  2285	
  2286		if (flags & BPF_TRAMP_F_IP_ARG) {
  2287			/* %r0 = func_addr */
  2288			load_imm64(jit, REG_0, (u64)func_addr);
  2289			/* stg %r0,ip_off(%r15) */
  2290			EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
  2291				      tjit->ip_off);
  2292		}
  2293		/* lghi %r0,nr_bpf_args */
  2294		EMIT4_IMM(0xa7090000, REG_0, nr_bpf_args);
  2295		/* stg %r0,arg_cnt_off(%r15) */
  2296		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
  2297			      tjit->arg_cnt_off);
  2298	
  2299		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2300			/*
  2301			 * __bpf_tramp_enter(im);
  2302			 */
  2303	
  2304			/* %r1 = __bpf_tramp_enter */
  2305			load_imm64(jit, REG_1, (u64)__bpf_tramp_enter);
  2306			/* %r2 = im */
  2307			load_imm64(jit, REG_2, (u64)im);
  2308			/* %r1() */
  2309			call_r1(jit);
  2310		}
  2311	
  2312		for (i = 0; i < fentry->nr_links; i++)
  2313			if (invoke_bpf_prog(tjit, m, fentry->links[i],
  2314					    flags & BPF_TRAMP_F_RET_FENTRY_RET))
  2315				return -EINVAL;
  2316	
  2317		if (fmod_ret->nr_links) {
  2318			/*
  2319			 * retval = 0;
  2320			 */
  2321	
  2322			/* xc retval_off(8,%r15),retval_off(%r15) */
  2323			_EMIT6(0xd707f000 | tjit->retval_off,
  2324			       0xf000 | tjit->retval_off);
  2325	
  2326			for (i = 0; i < fmod_ret->nr_links; i++) {
  2327				if (invoke_bpf_prog(tjit, m, fmod_ret->links[i], true))
  2328					return -EINVAL;
  2329	
  2330				/*
  2331				 * if (retval)
  2332				 *         goto do_fexit;
  2333				 */
  2334	
  2335				/* ltg %r0,retval_off(%r15) */
  2336				EMIT6_DISP_LH(0xe3000000, 0x0002, REG_0, REG_0, REG_15,
  2337					      tjit->retval_off);
  2338				/* brcl 7,do_fexit */
  2339				EMIT6_PCREL_RILC(0xc0040000, 7, tjit->do_fexit);
  2340			}
  2341		}
  2342	
  2343		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2344			/*
  2345			 * retval = func_addr(args);
  2346			 */
  2347	
  2348			/* lmg %r2,%rN,reg_args_off(%r15) */
  2349			if (nr_reg_args)
  2350				EMIT6_DISP_LH(0xeb000000, 0x0004, REG_2,
  2351					      REG_2 + (nr_reg_args - 1), REG_15,
  2352					      tjit->reg_args_off);
  2353			/* mvc stack_args_off(N,%r15),orig_stack_args_off(%r15) */
  2354			if (nr_stack_args)
  2355				_EMIT6(0xd200f000 |
  2356					       (nr_stack_args * sizeof(u64) - 1) << 16 |
  2357					       tjit->stack_args_off,
  2358				       0xf000 | tjit->orig_stack_args_off);
  2359			/* lgr %r1,%r8 */
  2360			EMIT4(0xb9040000, REG_1, REG_8);
  2361			/* %r1() */
  2362			call_r1(jit);
  2363			/* stg %r2,retval_off(%r15) */
  2364			EMIT6_DISP_LH(0xe3000000, 0x0024, REG_2, REG_0, REG_15,
  2365				      tjit->retval_off);
  2366	
  2367			im->ip_after_call = jit->prg_buf + jit->prg;
  2368	
  2369			/*
  2370			 * The following nop will be patched by bpf_tramp_image_put().
  2371			 */
  2372	
  2373			/* brcl 0,im->ip_epilogue */
  2374			EMIT6_PCREL_RILC(0xc0040000, 0, (u64)im->ip_epilogue);
  2375		}
  2376	
  2377		/* do_fexit: */
  2378		tjit->do_fexit = jit->prg;
  2379		for (i = 0; i < fexit->nr_links; i++)
  2380			if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
  2381				return -EINVAL;
  2382	
  2383		if (flags & BPF_TRAMP_F_CALL_ORIG) {
  2384			im->ip_epilogue = jit->prg_buf + jit->prg;
  2385	
  2386			/*
  2387			 * __bpf_tramp_exit(im);
  2388			 */
  2389	
  2390			/* %r1 = __bpf_tramp_exit */
  2391			load_imm64(jit, REG_1, (u64)__bpf_tramp_exit);
  2392			/* %r2 = im */
  2393			load_imm64(jit, REG_2, (u64)im);
  2394			/* %r1() */
  2395			call_r1(jit);
  2396		}
  2397	
  2398		/* lmg %r2,%rN,reg_args_off(%r15) */
  2399		if ((flags & BPF_TRAMP_F_RESTORE_REGS) && nr_reg_args)
  2400			EMIT6_DISP_LH(0xeb000000, 0x0004, REG_2,
  2401				      REG_2 + (nr_reg_args - 1), REG_15,
  2402				      tjit->reg_args_off);
  2403		/* lgr %r1,%r8 */
  2404		if (!(flags & BPF_TRAMP_F_SKIP_FRAME))
  2405			EMIT4(0xb9040000, REG_1, REG_8);
  2406		/* lmg %r7,%r8,r7_r8_off(%r15) */
  2407		EMIT6_DISP_LH(0xeb000000, 0x0004, REG_7, REG_8, REG_15,
  2408			      tjit->r7_r8_off);
  2409		/* lg %r14,r14_off(%r15) */
  2410		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_14, REG_0, REG_15, tjit->r14_off);
  2411		/* lg %r2,retval_off(%r15) */
  2412		if (flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET))
  2413			EMIT6_DISP_LH(0xe3000000, 0x0004, REG_2, REG_0, REG_15,
  2414				      tjit->retval_off);
  2415		/* aghi %r15,stack_size */
  2416		EMIT4_IMM(0xa70b0000, REG_15, tjit->stack_size);
  2417		/* Emit an expoline for the following indirect jump. */
  2418		if (nospec_uses_trampoline())
  2419			emit_expoline(jit);
  2420		if (flags & BPF_TRAMP_F_SKIP_FRAME)
  2421			/* br %r14 */
  2422			_EMIT2(0x07fe);
  2423		else
  2424			/* br %r1 */
  2425			_EMIT2(0x07f1);
  2426	
  2427		emit_r1_thunk(jit);
  2428	
  2429		return 0;
  2430	}
  2431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
