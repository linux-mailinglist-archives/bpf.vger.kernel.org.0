Return-Path: <bpf+bounces-68135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79CB53516
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794695A3E4D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B71335BD5;
	Thu, 11 Sep 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fg2kGHfK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3462367A0
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600430; cv=none; b=XDlugUeLWGWXo839KzVU45RjMFjNRKaSXXqLEmPkq8fuf4/wBukVTO2i8aa3MB7sxGwd+znhz74MY1Hub/CwpppIGk6J0t9+teuoji3qcDpQ50h1WKEjAKpMUsjIiwKs/eFEVpXIASVKTFzWrOLFq4G7E4gZiczIICAta9KWXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600430; c=relaxed/simple;
	bh=vac7JopB32jNxxOUKZl1xSRxKWAOsYq9kKyKh/NSETc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FseRFER9JdjUcT9m9w5zq8fgwZjSzH/l7mF+QUYbBIQ/e23HPEWyrHPVcyvf9lsPQcwRioDeQ043jfBcAxN7rX1uM76POHHs4lV+uTqIB4ifTXhJ4p6w8pXXdxj76j8JeVMl+Bczwalipltq4Kwfk7yDNx+iEt8dM4U45Ux4TYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fg2kGHfK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757600428; x=1789136428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vac7JopB32jNxxOUKZl1xSRxKWAOsYq9kKyKh/NSETc=;
  b=Fg2kGHfK3Ax0KXxCD985Nx27wRWQjlK4YQOGAC2eh2OwYrIlYodMeMGa
   Gj0RJBB+am4VYtMcVlAAe0Xvwjme/LyJQny9Bm/vfjIWFRM+qp8d9ooV5
   JJiG56oQgnthMBTUb+Ppmt4pnRN6NB5sKp9bHTfo7VBzz/QbYGe8ISmJz
   gPF8GbWJVhl/6cXb6b2h/F/Z0BfAsqzIzWb3XcSzDt1kMtW91YXUwg7W8
   e8U5FP7xuMAZ6CXPBAfxpRdxCSLLcMdGx/E6fCfZy/u5zz7ansn6JJqjU
   8+PBAAbpdqWRQfKc0MkfMH4w8uzeZlH+7cDg/NhsVBHeGfE8mUsI4EB0Y
   Q==;
X-CSE-ConnectionGUID: kgd1uC7cQrGVIQsjpjOMgw==
X-CSE-MsgGUID: ILjhGhKPSeSVg+eIZRE2ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71311421"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="71311421"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 07:20:25 -0700
X-CSE-ConnectionGUID: GThO3rr0THWwJ3oWO15t+w==
X-CSE-MsgGUID: XYVHr/z3Skifm/JJ8qpsQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="204465230"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Sep 2025 07:20:23 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwi9r-0000Ne-2g;
	Thu, 11 Sep 2025 14:20:19 +0000
Date: Thu, 11 Sep 2025 22:19:19 +0800
From: kernel test robot <lkp@intel.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, eddyz87@gmail.com
Subject: Re: [PATCH bpf-next v1 09/10] bpf: disable and remove registers
 chain based liveness
Message-ID: <202509112112.wkWw6wJW-lkp@intel.com>
References: <20250911010437.2779173-10-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911010437.2779173-10-eddyz87@gmail.com>

Hi Eduard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-bpf_verifier_state-cleaned-flag-instead-of-REG_LIVE_DONE/20250911-090604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250911010437.2779173-10-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v1 09/10] bpf: disable and remove registers chain based liveness
config: x86_64-buildonly-randconfig-003-20250911 (https://download.01.org/0day-ci/archive/20250911/202509112112.wkWw6wJW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509112112.wkWw6wJW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509112112.wkWw6wJW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:19305:11: warning: variable 'err' is uninitialized when used here [-Wuninitialized]
    19305 |                                 err = err ? : push_jmp_history(env, cur, 0, 0);
          |                                       ^~~
   kernel/bpf/verifier.c:19140:12: note: initialize the variable 'err' to silence this warning
    19140 |         int n, err, states_cnt = 0;
          |                   ^
          |                    = 0
   1 warning generated.


vim +/err +19305 kernel/bpf/verifier.c

2589726d12a1b1 Alexei Starovoitov      2019-06-15  19133  
58e2af8b3a6b58 Jakub Kicinski          2016-09-21  19134  static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19135  {
58e2af8b3a6b58 Jakub Kicinski          2016-09-21  19136  	struct bpf_verifier_state_list *new_sl;
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19137  	struct bpf_verifier_state_list *sl;
c9e31900b54cad Eduard Zingerman        2025-06-11  19138  	struct bpf_verifier_state *cur = env->cur_state, *new;
c9e31900b54cad Eduard Zingerman        2025-06-11  19139  	bool force_new_state, add_new_state, loop;
d5c95ed86213e4 Eduard Zingerman        2025-09-10  19140  	int n, err, states_cnt = 0;
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19141  	struct list_head *pos, *tmp, *head;
aa30eb3260b2de Eduard Zingerman        2024-10-29  19142  
aa30eb3260b2de Eduard Zingerman        2024-10-29  19143  	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
aa30eb3260b2de Eduard Zingerman        2024-10-29  19144  			  /* Avoid accumulating infinitely long jmp history */
baaebe0928bf32 Eduard Zingerman        2025-06-11  19145  			  cur->jmp_history_cnt > 40;
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19146  
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19147  	/* bpf progs typically have pruning point every 4 instructions
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19148  	 * http://vger.kernel.org/bpfconf2019.html#session-1
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19149  	 * Do not add new state for future pruning if the verifier hasn't seen
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19150  	 * at least 2 jumps and at least 8 instructions.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19151  	 * This heuristics helps decrease 'total_states' and 'peak_states' metric.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19152  	 * In tests that amounts to up to 50% reduction into total verifier
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19153  	 * memory consumption and 20% verifier time speedup.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19154  	 */
aa30eb3260b2de Eduard Zingerman        2024-10-29  19155  	add_new_state = force_new_state;
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19156  	if (env->jmps_processed - env->prev_jmps_processed >= 2 &&
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19157  	    env->insn_processed - env->prev_insn_processed >= 8)
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19158  		add_new_state = true;
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19159  
9242b5f5615c82 Alexei Starovoitov      2018-12-13  19160  	clean_live_states(env, insn_idx, cur);
9242b5f5615c82 Alexei Starovoitov      2018-12-13  19161  
c9e31900b54cad Eduard Zingerman        2025-06-11  19162  	loop = false;
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19163  	head = explored_state(env, insn_idx);
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19164  	list_for_each_safe(pos, tmp, head) {
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19165  		sl = container_of(pos, struct bpf_verifier_state_list, node);
dc2a4ebc0b44a2 Alexei Starovoitov      2019-05-21  19166  		states_cnt++;
dc2a4ebc0b44a2 Alexei Starovoitov      2019-05-21  19167  		if (sl->state.insn_idx != insn_idx)
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19168  			continue;
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19169  
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19170  		if (sl->state.branches) {
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19171  			struct bpf_func_state *frame = sl->state.frame[sl->state.curframe];
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19172  
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19173  			if (frame->in_async_callback_fn &&
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19174  			    frame->async_entry_cnt != cur->frame[cur->curframe]->async_entry_cnt) {
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19175  				/* Different async_entry_cnt means that the verifier is
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19176  				 * processing another entry into async callback.
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19177  				 * Seeing the same state is not an indication of infinite
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19178  				 * loop or infinite recursion.
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19179  				 * But finding the same state doesn't mean that it's safe
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19180  				 * to stop processing the current state. The previous state
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19181  				 * hasn't yet reached bpf_exit, since state.branches > 0.
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19182  				 * Checking in_async_callback_fn alone is not enough either.
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19183  				 * Since the verifier still needs to catch infinite loops
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19184  				 * inside async callbacks.
bfc6bb74e4f16a Alexei Starovoitov      2021-07-14  19185  				 */
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19186  				goto skip_inf_loop_check;
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19187  			}
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19188  			/* BPF open-coded iterators loop detection is special.
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19189  			 * states_maybe_looping() logic is too simplistic in detecting
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19190  			 * states that *might* be equivalent, because it doesn't know
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19191  			 * about ID remapping, so don't even perform it.
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19192  			 * See process_iter_next_call() and iter_active_depths_differ()
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19193  			 * for overview of the logic. When current and one of parent
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19194  			 * states are detected as equivalent, it's a good thing: we prove
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19195  			 * convergence and can stop simulating further iterations.
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19196  			 * It's safe to assume that iterator loop will finish, taking into
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19197  			 * account iter_next() contract of eventually returning
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19198  			 * sticky NULL result.
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19199  			 *
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19200  			 * Note, that states have to be compared exactly in this case because
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19201  			 * read and precision marks might not be finalized inside the loop.
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19202  			 * E.g. as in the program below:
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19203  			 *
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19204  			 *     1. r7 = -16
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19205  			 *     2. r6 = bpf_get_prandom_u32()
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19206  			 *     3. while (bpf_iter_num_next(&fp[-8])) {
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19207  			 *     4.   if (r6 != 42) {
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19208  			 *     5.     r7 = -32
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19209  			 *     6.     r6 = bpf_get_prandom_u32()
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19210  			 *     7.     continue
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19211  			 *     8.   }
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19212  			 *     9.   r0 = r10
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19213  			 *    10.   r0 += r7
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19214  			 *    11.   r8 = *(u64 *)(r0 + 0)
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19215  			 *    12.   r6 = bpf_get_prandom_u32()
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19216  			 *    13. }
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19217  			 *
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19218  			 * Here verifier would first visit path 1-3, create a checkpoint at 3
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19219  			 * with r7=-16, continue to 4-7,3. Existing checkpoint at 3 does
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19220  			 * not have read or precision mark for r7 yet, thus inexact states
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19221  			 * comparison would discard current state with r7=-32
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19222  			 * => unsafe memory access at 11 would not be caught.
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19223  			 */
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19224  			if (is_iter_next_insn(env, insn_idx)) {
4f81c16f50baf6 Alexei Starovoitov      2024-03-05  19225  				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19226  					struct bpf_func_state *cur_frame;
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19227  					struct bpf_reg_state *iter_state, *iter_reg;
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19228  					int spi;
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19229  
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19230  					cur_frame = cur->frame[cur->curframe];
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19231  					/* btf_check_iter_kfuncs() enforces that
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19232  					 * iter state pointer is always the first arg
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19233  					 */
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19234  					iter_reg = &cur_frame->regs[BPF_REG_1];
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19235  					/* current state is valid due to states_equal(),
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19236  					 * so we can assume valid iter and reg state,
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19237  					 * no need for extra (re-)validations
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19238  					 */
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19239  					spi = __get_spi(iter_reg->off + iter_reg->var_off.value);
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19240  					iter_state = &func(env, iter_reg)->stack[spi].spilled_ptr;
2a0992829ea386 Eduard Zingerman        2023-10-24  19241  					if (iter_state->iter.state == BPF_ITER_STATE_ACTIVE) {
c9e31900b54cad Eduard Zingerman        2025-06-11  19242  						loop = true;
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19243  						goto hit;
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19244  					}
2a0992829ea386 Eduard Zingerman        2023-10-24  19245  				}
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19246  				goto skip_inf_loop_check;
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19247  			}
011832b97b311b Alexei Starovoitov      2024-03-05  19248  			if (is_may_goto_insn_at(env, insn_idx)) {
2b2efe1937ca9f Alexei Starovoitov      2024-06-19  19249  				if (sl->state.may_goto_depth != cur->may_goto_depth &&
2b2efe1937ca9f Alexei Starovoitov      2024-06-19  19250  				    states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
c9e31900b54cad Eduard Zingerman        2025-06-11  19251  					loop = true;
011832b97b311b Alexei Starovoitov      2024-03-05  19252  					goto hit;
011832b97b311b Alexei Starovoitov      2024-03-05  19253  				}
011832b97b311b Alexei Starovoitov      2024-03-05  19254  			}
588af0c506ec8e Eduard Zingerman        2025-09-10  19255  			if (bpf_calls_callback(env, insn_idx)) {
4f81c16f50baf6 Alexei Starovoitov      2024-03-05  19256  				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
ab5cfac139ab85 Eduard Zingerman        2023-11-21  19257  					goto hit;
ab5cfac139ab85 Eduard Zingerman        2023-11-21  19258  				goto skip_inf_loop_check;
ab5cfac139ab85 Eduard Zingerman        2023-11-21  19259  			}
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19260  			/* attempt to detect infinite loop to avoid unnecessary doomed work */
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19261  			if (states_maybe_looping(&sl->state, cur) &&
4f81c16f50baf6 Alexei Starovoitov      2024-03-05  19262  			    states_equal(env, &sl->state, cur, EXACT) &&
ab5cfac139ab85 Eduard Zingerman        2023-11-21  19263  			    !iter_active_depths_differ(&sl->state, cur) &&
011832b97b311b Alexei Starovoitov      2024-03-05  19264  			    sl->state.may_goto_depth == cur->may_goto_depth &&
ab5cfac139ab85 Eduard Zingerman        2023-11-21  19265  			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19266  				verbose_linfo(env, insn_idx, "; ");
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19267  				verbose(env, "infinite loop detected at insn %d\n", insn_idx);
b4d8239534fddc Eduard Zingerman        2023-10-24  19268  				verbose(env, "cur state:");
1995edc5f9089e Kumar Kartikeya Dwivedi 2024-12-03  19269  				print_verifier_state(env, cur, cur->curframe, true);
b4d8239534fddc Eduard Zingerman        2023-10-24  19270  				verbose(env, "old state:");
1995edc5f9089e Kumar Kartikeya Dwivedi 2024-12-03  19271  				print_verifier_state(env, &sl->state, cur->curframe, true);
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19272  				return -EINVAL;
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19273  			}
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19274  			/* if the verifier is processing a loop, avoid adding new state
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19275  			 * too often, since different loop iterations have distinct
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19276  			 * states and may not help future pruning.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19277  			 * This threshold shouldn't be too low to make sure that
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19278  			 * a loop with large bound will be rejected quickly.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19279  			 * The most abusive loop will be:
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19280  			 * r1 += 1
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19281  			 * if r1 < 1000000 goto pc-2
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19282  			 * 1M insn_procssed limit / 100 == 10k peak states.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19283  			 * This threshold shouldn't be too high either, since states
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19284  			 * at the end of the loop are likely to be useful in pruning.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19285  			 */
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19286  skip_inf_loop_check:
4b5ce570dbef57 Andrii Nakryiko         2023-03-09  19287  			if (!force_new_state &&
98ddcf389d1bb7 Andrii Nakryiko         2023-03-02  19288  			    env->jmps_processed - env->prev_jmps_processed < 20 &&
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19289  			    env->insn_processed - env->prev_insn_processed < 100)
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19290  				add_new_state = false;
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19291  			goto miss;
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19292  		}
c9e31900b54cad Eduard Zingerman        2025-06-11  19293  		/* See comments for mark_all_regs_read_and_precise() */
c9e31900b54cad Eduard Zingerman        2025-06-11  19294  		loop = incomplete_read_marks(env, &sl->state);
c9e31900b54cad Eduard Zingerman        2025-06-11  19295  		if (states_equal(env, &sl->state, cur, loop ? RANGE_WITHIN : NOT_EXACT)) {
06accc8779c1d5 Andrii Nakryiko         2023-03-08  19296  hit:
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19297  			sl->hit_cnt++;
a3ce685dd01a78 Alexei Starovoitov      2019-06-28  19298  
a3ce685dd01a78 Alexei Starovoitov      2019-06-28  19299  			/* if previous state reached the exit with precision and
a7de265cb2d849 Rafael Passos           2024-04-17  19300  			 * current state is equivalent to it (except precision marks)
a3ce685dd01a78 Alexei Starovoitov      2019-06-28  19301  			 * the precision needs to be propagated back in
a3ce685dd01a78 Alexei Starovoitov      2019-06-28  19302  			 * the current state.
a3ce685dd01a78 Alexei Starovoitov      2019-06-28  19303  			 */
41f6f64e6999a8 Andrii Nakryiko         2023-12-05  19304  			if (is_jmp_point(env, env->insn_idx))
baaebe0928bf32 Eduard Zingerman        2025-06-11 @19305  				err = err ? : push_jmp_history(env, cur, 0, 0);
23b37d616565c8 Eduard Zingerman        2025-06-11  19306  			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  19307  			if (err)
f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  19308  				return err;
c9e31900b54cad Eduard Zingerman        2025-06-11  19309  			/* When processing iterator based loops above propagate_liveness and
c9e31900b54cad Eduard Zingerman        2025-06-11  19310  			 * propagate_precision calls are not sufficient to transfer all relevant
c9e31900b54cad Eduard Zingerman        2025-06-11  19311  			 * read and precision marks. E.g. consider the following case:
c9e31900b54cad Eduard Zingerman        2025-06-11  19312  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19313  			 *  .-> A --.  Assume the states are visited in the order A, B, C.
c9e31900b54cad Eduard Zingerman        2025-06-11  19314  			 *  |   |   |  Assume that state B reaches a state equivalent to state A.
c9e31900b54cad Eduard Zingerman        2025-06-11  19315  			 *  |   v   v  At this point, state C is not processed yet, so state A
c9e31900b54cad Eduard Zingerman        2025-06-11  19316  			 *  '-- B   C  has not received any read or precision marks from C.
c9e31900b54cad Eduard Zingerman        2025-06-11  19317  			 *             Thus, marks propagated from A to B are incomplete.
c9e31900b54cad Eduard Zingerman        2025-06-11  19318  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19319  			 * The verifier mitigates this by performing the following steps:
c9e31900b54cad Eduard Zingerman        2025-06-11  19320  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19321  			 * - Prior to the main verification pass, strongly connected components
c9e31900b54cad Eduard Zingerman        2025-06-11  19322  			 *   (SCCs) are computed over the program's control flow graph,
c9e31900b54cad Eduard Zingerman        2025-06-11  19323  			 *   intraprocedurally.
c9e31900b54cad Eduard Zingerman        2025-06-11  19324  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19325  			 * - During the main verification pass, `maybe_enter_scc()` checks
c9e31900b54cad Eduard Zingerman        2025-06-11  19326  			 *   whether the current verifier state is entering an SCC. If so, an
c9e31900b54cad Eduard Zingerman        2025-06-11  19327  			 *   instance of a `bpf_scc_visit` object is created, and the state
c9e31900b54cad Eduard Zingerman        2025-06-11  19328  			 *   entering the SCC is recorded as the entry state.
c9e31900b54cad Eduard Zingerman        2025-06-11  19329  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19330  			 * - This instance is associated not with the SCC itself, but with a
c9e31900b54cad Eduard Zingerman        2025-06-11  19331  			 *   `bpf_scc_callchain`: a tuple consisting of the call sites leading to
c9e31900b54cad Eduard Zingerman        2025-06-11  19332  			 *   the SCC and the SCC id. See `compute_scc_callchain()`.
c9e31900b54cad Eduard Zingerman        2025-06-11  19333  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19334  			 * - When a verification path encounters a `states_equal(...,
c9e31900b54cad Eduard Zingerman        2025-06-11  19335  			 *   RANGE_WITHIN)` condition, there exists a call chain describing the
c9e31900b54cad Eduard Zingerman        2025-06-11  19336  			 *   current state and a corresponding `bpf_scc_visit` instance. A copy
c9e31900b54cad Eduard Zingerman        2025-06-11  19337  			 *   of the current state is created and added to
c9e31900b54cad Eduard Zingerman        2025-06-11  19338  			 *   `bpf_scc_visit->backedges`.
c9e31900b54cad Eduard Zingerman        2025-06-11  19339  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19340  			 * - When a verification path terminates, `maybe_exit_scc()` is called
c9e31900b54cad Eduard Zingerman        2025-06-11  19341  			 *   from `update_branch_counts()`. For states with `branches == 0`, it
c9e31900b54cad Eduard Zingerman        2025-06-11  19342  			 *   checks whether the state is the entry state of any `bpf_scc_visit`
c9e31900b54cad Eduard Zingerman        2025-06-11  19343  			 *   instance. If it is, this indicates that all paths originating from
c9e31900b54cad Eduard Zingerman        2025-06-11  19344  			 *   this SCC visit have been explored. `propagate_backedges()` is then
c9e31900b54cad Eduard Zingerman        2025-06-11  19345  			 *   called, which propagates read and precision marks through the
c9e31900b54cad Eduard Zingerman        2025-06-11  19346  			 *   backedges until a fixed point is reached.
c9e31900b54cad Eduard Zingerman        2025-06-11  19347  			 *   (In the earlier example, this would propagate marks from A to B,
c9e31900b54cad Eduard Zingerman        2025-06-11  19348  			 *    from C to A, and then again from A to B.)
c9e31900b54cad Eduard Zingerman        2025-06-11  19349  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19350  			 * A note on callchains
c9e31900b54cad Eduard Zingerman        2025-06-11  19351  			 * --------------------
c9e31900b54cad Eduard Zingerman        2025-06-11  19352  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19353  			 * Consider the following example:
c9e31900b54cad Eduard Zingerman        2025-06-11  19354  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19355  			 *     void foo() { loop { ... SCC#1 ... } }
c9e31900b54cad Eduard Zingerman        2025-06-11  19356  			 *     void main() {
c9e31900b54cad Eduard Zingerman        2025-06-11  19357  			 *       A: foo();
c9e31900b54cad Eduard Zingerman        2025-06-11  19358  			 *       B: ...
c9e31900b54cad Eduard Zingerman        2025-06-11  19359  			 *       C: foo();
c9e31900b54cad Eduard Zingerman        2025-06-11  19360  			 *     }
c9e31900b54cad Eduard Zingerman        2025-06-11  19361  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19362  			 * Here, there are two distinct callchains leading to SCC#1:
c9e31900b54cad Eduard Zingerman        2025-06-11  19363  			 * - (A, SCC#1)
c9e31900b54cad Eduard Zingerman        2025-06-11  19364  			 * - (C, SCC#1)
c9e31900b54cad Eduard Zingerman        2025-06-11  19365  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19366  			 * Each callchain identifies a separate `bpf_scc_visit` instance that
c9e31900b54cad Eduard Zingerman        2025-06-11  19367  			 * accumulates backedge states. The `propagate_{liveness,precision}()`
c9e31900b54cad Eduard Zingerman        2025-06-11  19368  			 * functions traverse the parent state of each backedge state, which
c9e31900b54cad Eduard Zingerman        2025-06-11  19369  			 * means these parent states must remain valid (i.e., not freed) while
c9e31900b54cad Eduard Zingerman        2025-06-11  19370  			 * the corresponding `bpf_scc_visit` instance exists.
c9e31900b54cad Eduard Zingerman        2025-06-11  19371  			 *
c9e31900b54cad Eduard Zingerman        2025-06-11  19372  			 * Associating `bpf_scc_visit` instances directly with SCCs instead of
c9e31900b54cad Eduard Zingerman        2025-06-11  19373  			 * callchains would break this invariant:
c9e31900b54cad Eduard Zingerman        2025-06-11  19374  			 * - States explored during `C: foo()` would contribute backedges to
c9e31900b54cad Eduard Zingerman        2025-06-11  19375  			 *   SCC#1, but SCC#1 would only be exited once the exploration of
c9e31900b54cad Eduard Zingerman        2025-06-11  19376  			 *   `A: foo()` completes.
c9e31900b54cad Eduard Zingerman        2025-06-11  19377  			 * - By that time, the states explored between `A: foo()` and `C: foo()`
c9e31900b54cad Eduard Zingerman        2025-06-11  19378  			 *   (i.e., `B: ...`) may have already been freed, causing the parent
c9e31900b54cad Eduard Zingerman        2025-06-11  19379  			 *   links for states from `C: foo()` to become invalid.
c9e31900b54cad Eduard Zingerman        2025-06-11  19380  			 */
c9e31900b54cad Eduard Zingerman        2025-06-11  19381  			if (loop) {
c9e31900b54cad Eduard Zingerman        2025-06-11  19382  				struct bpf_scc_backedge *backedge;
c9e31900b54cad Eduard Zingerman        2025-06-11  19383  
43736ec3e02789 Eduard Zingerman        2025-06-13  19384  				backedge = kzalloc(sizeof(*backedge), GFP_KERNEL_ACCOUNT);
c9e31900b54cad Eduard Zingerman        2025-06-11  19385  				if (!backedge)
c9e31900b54cad Eduard Zingerman        2025-06-11  19386  					return -ENOMEM;
c9e31900b54cad Eduard Zingerman        2025-06-11  19387  				err = copy_verifier_state(&backedge->state, cur);
c9e31900b54cad Eduard Zingerman        2025-06-11  19388  				backedge->state.equal_state = &sl->state;
c9e31900b54cad Eduard Zingerman        2025-06-11  19389  				backedge->state.insn_idx = insn_idx;
c9e31900b54cad Eduard Zingerman        2025-06-11  19390  				err = err ?: add_scc_backedge(env, &sl->state, backedge);
c9e31900b54cad Eduard Zingerman        2025-06-11  19391  				if (err) {
c9e31900b54cad Eduard Zingerman        2025-06-11  19392  					free_verifier_state(&backedge->state, false);
bf0c2a84df9fb0 Qianfeng Rong           2025-08-11  19393  					kfree(backedge);
c9e31900b54cad Eduard Zingerman        2025-06-11  19394  					return err;
c9e31900b54cad Eduard Zingerman        2025-06-11  19395  				}
c9e31900b54cad Eduard Zingerman        2025-06-11  19396  			}
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19397  			return 1;
dc503a8ad98474 Edward Cree             2017-08-15  19398  		}
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19399  miss:
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19400  		/* when new state is not going to be added do not increase miss count.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19401  		 * Otherwise several loop iterations will remove the state
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19402  		 * recorded earlier. The goal of these heuristics is to have
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19403  		 * states from some iterations of the loop (some in the beginning
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19404  		 * and some at the end) to help pruning.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19405  		 */
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19406  		if (add_new_state)
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19407  			sl->miss_cnt++;
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19408  		/* heuristic to determine whether this state is beneficial
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19409  		 * to keep checking from state equivalence point of view.
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19410  		 * Higher numbers increase max_states_per_insn and verification time,
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19411  		 * but do not meaningfully decrease insn_processed.
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19412  		 * 'n' controls how many times state could miss before eviction.
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19413  		 * Use bigger 'n' for checkpoints because evicting checkpoint states
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19414  		 * too early would hinder iterator convergence.
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19415  		 */
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19416  		n = is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19417  		if (sl->miss_cnt > sl->hit_cnt * n + n) {
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19418  			/* the state is unlikely to be useful. Remove it to
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19419  			 * speed up verification
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19420  			 */
408fcf946b2bad Eduard Zingerman        2025-02-15  19421  			sl->in_free_list = true;
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19422  			list_del(&sl->node);
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19423  			list_add(&sl->node, &env->free_list);
574078b001cdf6 Eduard Zingerman        2025-02-15  19424  			env->free_list_size++;
574078b001cdf6 Eduard Zingerman        2025-02-15  19425  			env->explored_states_size--;
408fcf946b2bad Eduard Zingerman        2025-02-15  19426  			maybe_free_verifier_state(env, sl);
9f4686c41bdff0 Alexei Starovoitov      2019-04-01  19427  		}
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19428  	}
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19429  
06ee7115b0d174 Alexei Starovoitov      2019-04-01  19430  	if (env->max_states_per_insn < states_cnt)
06ee7115b0d174 Alexei Starovoitov      2019-04-01  19431  		env->max_states_per_insn = states_cnt;
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19432  
2c78ee898d8f10 Alexei Starovoitov      2020-05-13  19433  	if (!env->bpf_capable && states_cnt > BPF_COMPLEXITY_LIMIT_STATES)
a095f421057e22 Andrii Nakryiko         2022-12-06  19434  		return 0;
ceefbc96fa5c5b Alexei Starovoitov      2018-12-03  19435  
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19436  	if (!add_new_state)
a095f421057e22 Andrii Nakryiko         2022-12-06  19437  		return 0;
ceefbc96fa5c5b Alexei Starovoitov      2018-12-03  19438  
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19439  	/* There were no equivalent states, remember the current one.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19440  	 * Technically the current state is not proven to be safe yet,
f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  19441  	 * but it will either reach outer most bpf_exit (which means it's safe)
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19442  	 * or it will be rejected. When there are no loops the verifier won't be
f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  19443  	 * seeing this tuple (frame[0].callsite, frame[1].callsite, .. insn_idx)
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19444  	 * again on the way to bpf_exit.
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19445  	 * When looping the sl->state.branches will be > 0 and this state
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19446  	 * will not be considered for equivalence until branches == 0.
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19447  	 */
43736ec3e02789 Eduard Zingerman        2025-06-13  19448  	new_sl = kzalloc(sizeof(struct bpf_verifier_state_list), GFP_KERNEL_ACCOUNT);
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19449  	if (!new_sl)
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19450  		return -ENOMEM;
06ee7115b0d174 Alexei Starovoitov      2019-04-01  19451  	env->total_states++;
574078b001cdf6 Eduard Zingerman        2025-02-15  19452  	env->explored_states_size++;
574078b001cdf6 Eduard Zingerman        2025-02-15  19453  	update_peak_states(env);
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19454  	env->prev_jmps_processed = env->jmps_processed;
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19455  	env->prev_insn_processed = env->insn_processed;
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19456  
7a830b53c17bba Andrii Nakryiko         2022-11-04  19457  	/* forget precise markings we inherited, see __mark_chain_precision */
7a830b53c17bba Andrii Nakryiko         2022-11-04  19458  	if (env->bpf_capable)
7a830b53c17bba Andrii Nakryiko         2022-11-04  19459  		mark_all_scalars_imprecise(env, cur);
7a830b53c17bba Andrii Nakryiko         2022-11-04  19460  
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19461  	/* add new state to the head of linked list */
679c782de14bd4 Edward Cree             2018-08-22  19462  	new = &new_sl->state;
679c782de14bd4 Edward Cree             2018-08-22  19463  	err = copy_verifier_state(new, cur);
1969db47f8d0e8 Alexei Starovoitov      2017-11-01  19464  	if (err) {
679c782de14bd4 Edward Cree             2018-08-22  19465  		free_verifier_state(new, false);
1969db47f8d0e8 Alexei Starovoitov      2017-11-01  19466  		kfree(new_sl);
1969db47f8d0e8 Alexei Starovoitov      2017-11-01  19467  		return err;
1969db47f8d0e8 Alexei Starovoitov      2017-11-01  19468  	}
dc2a4ebc0b44a2 Alexei Starovoitov      2019-05-21  19469  	new->insn_idx = insn_idx;
0df1a55afa832f Paul Chaignon           2025-07-01  19470  	verifier_bug_if(new->branches != 1, env,
0df1a55afa832f Paul Chaignon           2025-07-01  19471  			"%s:branches_to_explore=%d insn %d",
0df1a55afa832f Paul Chaignon           2025-07-01  19472  			__func__, new->branches, insn_idx);
c9e31900b54cad Eduard Zingerman        2025-06-11  19473  	err = maybe_enter_scc(env, new);
c9e31900b54cad Eduard Zingerman        2025-06-11  19474  	if (err) {
c9e31900b54cad Eduard Zingerman        2025-06-11  19475  		free_verifier_state(new, false);
e4980fa6463624 Feng Yang               2025-08-27  19476  		kfree(new_sl);
c9e31900b54cad Eduard Zingerman        2025-06-11  19477  		return err;
c9e31900b54cad Eduard Zingerman        2025-06-11  19478  	}
b5dc0163d8fd78 Alexei Starovoitov      2019-06-15  19479  
2589726d12a1b1 Alexei Starovoitov      2019-06-15  19480  	cur->parent = new;
b5dc0163d8fd78 Alexei Starovoitov      2019-06-15  19481  	cur->first_insn_idx = insn_idx;
2793a8b015f7f1 Eduard Zingerman        2023-10-24  19482  	cur->dfs_depth = new->dfs_depth + 1;
baaebe0928bf32 Eduard Zingerman        2025-06-11  19483  	clear_jmp_history(cur);
5564ee3abb2ebe Eduard Zingerman        2025-02-15  19484  	list_add(&new_sl->node, head);
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19485  	return 0;
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19486  }
f1bca824dabba4 Alexei Starovoitov      2014-09-29  19487  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

