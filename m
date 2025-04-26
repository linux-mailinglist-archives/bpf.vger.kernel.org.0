Return-Path: <bpf+bounces-56785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18ABA9DB7D
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 16:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149E54A397B
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930181991CF;
	Sat, 26 Apr 2025 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhduZwDN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16905A920
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745678776; cv=none; b=AcwH9bEaYGstBmz4t1ShSwKJP/qTsjU+G9IwDRr7nrev+Y7DkwZRAZ7ffEYT4ZJ1M7AbUoPF/HOcDuZrXFVvPJyjh5w3MT+z6+7u/0D1vv4wTxbo222i8FKncJvNxlfYRrs9YyA2cfgEANAUHSCrjGe21uUbzEKp7A/ZRA3d0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745678776; c=relaxed/simple;
	bh=u0XFOZCbUxLTirzcU7SQgvvFhR5eGp7vYanqCWvs+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1QPMYdGQtgmG6jjd6F6mF43n7noCKktnzd1HP4jg/gkh73L/raO+pBvxqN2ie4rBR83Mk24DRGKBG3NKKx0WD7QJhi0mcpl4aeqKUCuj99A7MB6/9kiK/4Y3e9NvKLFhHPT77Xcsdcs/YfdUsLiZbh5QhRvX0NDJqBJeTePbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhduZwDN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745678774; x=1777214774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0XFOZCbUxLTirzcU7SQgvvFhR5eGp7vYanqCWvs+nE=;
  b=HhduZwDNWJudeQ2jVWaC9Bu4t7LUIEHfYxq1uteJS4O3yC3QDLSRRQRs
   QAzh2pVBRvx/2dbc83UNdKc7fGlxx65KNLLWmrsEbqg9ewEKWhFdhL2Y9
   oObXbMZvM/VmhvvBsVQvcl6P7XJual8myg0TEDxEWx7C5HOUaEg+4Wrmk
   g6ngdahm6YclMPaMUiar6L51arP7iZSWa7piW4zdW+jDPf9iBOFs7bEfb
   jdPwmDaQ8eEPie5enzFwhIbryagrN8UsDDv9h+2CYm+lgTBxpleN3q4gj
   PbAAdAuqJw6l28mrI1aR+HnBJo+sEi4n02BK6sKPydcSQl9WE5La+a8Ys
   Q==;
X-CSE-ConnectionGUID: 9wUx2SA5SD+NksYntpH2VQ==
X-CSE-MsgGUID: 5s3P4xTwR9+eJsL+ZU8m/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47484012"
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="47484012"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 07:46:13 -0700
X-CSE-ConnectionGUID: biQ15ZZpRM2+1uiOdM08FQ==
X-CSE-MsgGUID: 7YM1dqMrSuGytIYV+a9d8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="156365063"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Apr 2025 07:46:11 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8gnA-0005rp-2i;
	Sat, 26 Apr 2025 14:46:08 +0000
Date: Sat, 26 Apr 2025 22:45:58 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
Message-ID: <202504262235.h5B7vJiB-lkp@intel.com>
References: <20250426104634.744077-4-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426104634.744077-4-eddyz87@gmail.com>

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-compute-SCCs-in-program-control-flow-graph/20250426-184824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250426104634.744077-4-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
config: riscv-randconfig-001-20250426 (https://download.01.org/0day-ci/archive/20250426/202504262235.h5B7vJiB-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250426/202504262235.h5B7vJiB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504262235.h5B7vJiB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/verifier.c: In function 'mark_all_regs_read_and_precise':
>> kernel/bpf/verifier.c:18238:13: warning: variable 'insn_idx' set but not used [-Wunused-but-set-variable]
   18238 |         u32 insn_idx;
         |             ^~~~~~~~
   At top level:
   cc1: note: unrecognized command-line option '-Wno-unterminated-string-initialization' may have been intended to silence earlier diagnostics


vim +/insn_idx +18238 kernel/bpf/verifier.c

 18154	
 18155	/* Open coded iterators introduce loops in the verifier state graph.
 18156	 * State graph loops can result in incomplete read and precision marks
 18157	 * on individual states. E.g. consider the following states graph:
 18158	 *
 18159	 *  .-> A --.  Assume the states are visited in the order A, B, C.
 18160	 *  |   |   |  Assume that state B reaches a state equivalent to state A.
 18161	 *  |   v   v  At this point, state C has not been processed yet,
 18162	 *  '-- B   C  so state A does not have any read or precision marks from C yet.
 18163	 *             As a result, these marks won't be propagated to B.
 18164	 *
 18165	 * If the marks on B are incomplete, it would be unsafe to use it in
 18166	 * states_equal() checks.
 18167	 *
 18168	 * To avoid this safety issue, and since states with incomplete read
 18169	 * marks can only occur within control flow graph loops, the verifier
 18170	 * assumes that any state with bpf_verifier_state->insn_idx residing
 18171	 * in a strongly connected component (SCC) has read and precision
 18172	 * marks for all registers. This assumption is enforced by the
 18173	 * function mark_all_regs_read_and_precise(), which assigns
 18174	 * corresponding marks.
 18175	 *
 18176	 * An intuitive point to call mark_all_regs_read_and_precise() would
 18177	 * be when a new state is created in is_state_visited().
 18178	 * However, doing so would interfere with widen_imprecise_scalars(),
 18179	 * which widens scalars in the current state after checking registers in a
 18180	 * parent state. Registers are not widened if they are marked as precise
 18181	 * in the parent state.
 18182	 *
 18183	 * To avoid interfering with widening logic,
 18184	 * a call to mark_all_regs_read_and_precise() for state is postponed
 18185	 * until no widening is possible in any descendant of state S.
 18186	 *
 18187	 * Another intuitive spot to call mark_all_regs_read_and_precise()
 18188	 * would be in update_branch_counts() when S's branches counter
 18189	 * reaches 0. However, this falls short in the following case:
 18190	 *
 18191	 *	sum = 0
 18192	 *	bpf_repeat(10) {                              // a
 18193	 *		if (unlikely(bpf_get_prandom_u32()))  // b
 18194	 *			sum += 1;
 18195	 *		if (bpf_get_prandom_u32())            // c
 18196	 *			asm volatile ("");
 18197	 *		asm volatile ("goto +0;");            // d
 18198	 *	}
 18199	 *
 18200	 * Here a checkpoint is created at (d) with {sum=0} and the branch counter
 18201	 * for (d) reaches 0, so 'sum' would be marked precise.
 18202	 * When second branch of (c) reaches (d), checkpoint would be hit,
 18203	 * and the precision mark for 'sum' propagated to (a).
 18204	 * When the second branch of (b) reaches (a), the state would be {sum=1},
 18205	 * no widening would occur, causing verification to continue forever.
 18206	 *
 18207	 * To avoid such premature precision markings, the verifier postpones
 18208	 * the call to mark_all_regs_read_and_precise() for state S even further.
 18209	 * Suppose state P is a [grand]parent of state S and is the first state
 18210	 * in the current state chain with state->insn_idx within current SCC.
 18211	 * mark_all_regs_read_and_precise() for state S is only called once P
 18212	 * is fully explored.
 18213	 *
 18214	 * The struct 'bpf_scc_info' is used to track this condition:
 18215	 * - bpf_scc_info->branches counts how many states currently
 18216	 *   in env->cur_state or env->head originate from this SCC;
 18217	 * - bpf_scc_info->scc_epoch counts how many times 'branches'
 18218	 *   has reached zero;
 18219	 * - bpf_verifier_state->scc_epoch records the epoch of the SCC
 18220	 *   corresponding to bpf_verifier_state->insn_idx at the moment
 18221	 *   of state creation.
 18222	 *
 18223	 * Functions parent_scc_enter() and parent_scc_exit() maintain the
 18224	 * bpf_scc_info->{branches,scc_epoch} counters.
 18225	 *
 18226	 * bpf_scc_info->branches reaching zero indicates that state P is
 18227	 * fully explored. Its descendants residing in the same SCC have
 18228	 * state->scc_epoch == scc_info->scc_epoch. parent_scc_exit()
 18229	 * increments scc_info->scc_epoch, allowing clean_live_states() to
 18230	 * detect these states and apply mark_all_regs_read_and_precise().
 18231	 */
 18232	static void mark_all_regs_read_and_precise(struct bpf_verifier_env *env,
 18233						   struct bpf_verifier_state *st)
 18234	{
 18235		struct bpf_func_state *func;
 18236		struct bpf_reg_state *reg;
 18237		u16 live_regs;
 18238		u32 insn_idx;
 18239		int i, j;
 18240	
 18241		for (i = 0; i <= st->curframe; i++) {
 18242			insn_idx = frame_insn_idx(st, i);
 18243			live_regs = env->insn_aux_data[st->insn_idx].live_regs_before;
 18244			func = st->frame[i];
 18245			for (j = 0; j < BPF_REG_FP; j++) {
 18246				reg = &func->regs[j];
 18247				if (!(BIT(j) & live_regs) || reg->type == NOT_INIT)
 18248					continue;
 18249				reg->live |= REG_LIVE_READ64;
 18250				if (reg->type == SCALAR_VALUE && !is_reg_unbounded(reg))
 18251					reg->precise = true;
 18252			}
 18253			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 18254				reg = &func->stack[j].spilled_ptr;
 18255				reg->live |= REG_LIVE_READ64;
 18256				if (is_spilled_reg(&func->stack[j]) &&
 18257				    reg->type == SCALAR_VALUE && !is_reg_unbounded(reg))
 18258					reg->precise = true;
 18259			}
 18260		}
 18261	}
 18262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

