Return-Path: <bpf+bounces-68217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F263CB544F4
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88595463198
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913932D47EE;
	Fri, 12 Sep 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omcd1/dK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AC2D3EF6
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665033; cv=none; b=tfIptIn0iXgStS09z/Bo9wcNt8hxXj+C8olFpa+ZVctKLTQ18WzDSLVgzXUr+awskoQGgPkoCqRgaZbSjKVswLv+9WYXUyquuaY/H8SihHHkhGdjcsHhqHopjqDCItKByxbLpOv9uCqjeHDEOuIBnCJXQXoHy6Uw9gvbG9DYAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665033; c=relaxed/simple;
	bh=i9CFVWx0KuQcVLiLCs7JaLronTxZjdKNbsKFJb4KxyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TL14VuUaXOot6AVE6LH41xI1JBBDdt5eUdzpV91C68TlGz1isS/hSGai4gNJ55cTkDi2YtBZ3Jy67B1Sx57wZzVhfvOVFG2ZhpT9o6e54EU1ST/Iss0VvDOo5NhSYLmmn9z2yv4zP2nA0pheJnuP8uHIRl5jouKFdEsu5W21Ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omcd1/dK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dfb6cadf3so14538735e9.2
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757665027; x=1758269827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Etxg0IY1htc5QJcqwa87OQjVL3XIqrFRkFeKYdzH19A=;
        b=omcd1/dKsATdq2FKtt1SBwxT0mpx2BpCAIFklEQ0DUx0/Ul0d+VI7CRYiXO0xGl4do
         3TlxmevotmEXdtWJUamvKCibuYxMYBas29O0fjXVBLesJ2itsYVHdZRJIPxNQs/XYBr1
         zmF1Awi35rIRVLEMEbHNOYg8iLjiLN1/49yfETyeavB5E5eHmklZW/ZwOsSkOyaw+mX7
         YnL/xZj/9mGEsj5XfQmpLZoCq5cxQm7tP4b3eoQCVXuVu565B53LdQ00yaE4TTs2dwCa
         WTFM3Pep9yxxqN1+akhMQqjMR5YzmGJbti/iYNtJagyqbChEYiVF9sxK5W51M6y6PBpy
         OD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665027; x=1758269827;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etxg0IY1htc5QJcqwa87OQjVL3XIqrFRkFeKYdzH19A=;
        b=UmJHUlYunIuWMLw6SOn/IFg4ktHbwnCgME6ALjv+d6qj/VyADikYxwrPhVJgvuTELc
         /qnbhwbVXPmJo+z5LIyav56Ky2RjMMRHBFkVrWbxqu68EcmyXxe8S4VhE+3cpQJlTHyE
         Eg8ytgP7DV7QccsUkESlVsVtQ9RLPiE1qWyUFK8bxjkTFAix/kvy4mHKenYzt+MJl1px
         uvtxaR/qLY8OK0r10f2PRlxxrpYKeQeeRvjiJTafqcpeESDosobXFkzTh7RYvSXVmRat
         BkADLhw4jHWaa9QJC09qmGB6+PZ7kjRcB7LEkaxjXgWifgFl+YaDVE+6mijfYc0zBqFi
         zGig==
X-Forwarded-Encrypted: i=1; AJvYcCUe8NcE1/7sjfBhLWc06uUUdAK96qhGnxGe/8ziW4fX5Ml7GHVWssiXaimTuwLIdYHf/AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLxxyFEWdHXeceMkc4dUjycaB1Vk66Ea6q/wZzeOOEBy6gF1c
	P89QVE+6KFhvJDtyyI8GAGRB9Q9zUTRTEKGtpQQqPZnspsyMDt5M0xW25+9NLie98F82TF4RgaK
	xfTfz
X-Gm-Gg: ASbGncthu++cVKUOvzJg/EnUf+32QzofCOjzhuYlF2n/mK4JtEMiENBAL5MDyORzPTU
	tW97q3M/afw0OVJJeyZjOFV5KQ9KTeZFu03R44SuRhyZOBqpBYh1FzshaFTctg3XXQB0yxR/gop
	AOe1+xvuuUZNUcvVWgNHxVfnDjcSxo9CtwyL/+vH9/YmyEnZywswShjFlH2YNaU9/SyhRiFL4i5
	pQQh/zVT5tQsop3aQ70mSvHkCEGt23jX/rhl0eIx/dcM8q8ao/DxwFvEDwVBMN4LilvwroUJfV8
	o7lCROc7kwLYRA3qkYgdpJRjRHtXzswH1f/in3bXjHKDDfH0Cx9DJ4EnH3OC3O1q4571DzaayRK
	73Jn4q3Xj6FRFllHTTeAn0IKuh8s=
X-Google-Smtp-Source: AGHT+IG/0RzEIOXstnhWOvUJR4C018nzBGkctjQb2dAgAi3fPX3o+xS6Nw+E9OgCuuiHC/GyGX4w6g==
X-Received: by 2002:a05:600c:c178:b0:45d:e54b:fa29 with SMTP id 5b1f17b1804b1-45f211c8cd3mr19002855e9.14.1757665026848;
        Fri, 12 Sep 2025 01:17:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e037d638dsm51062505e9.22.2025.09.12.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:17:06 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:17:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net,
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: Re: [PATCH bpf-next v1 09/10] bpf: disable and remove registers
 chain based liveness
Message-ID: <202509120205.YfzyI2gp-lkp@intel.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/bpf-bpf_verifier_state-cleaned-flag-instead-of-REG_LIVE_DONE/20250911-090604
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20250911010437.2779173-10-eddyz87%40gmail.com
patch subject: [PATCH bpf-next v1 09/10] bpf: disable and remove registers chain based liveness
config: arm-randconfig-r071-20250911 (https://download.01.org/0day-ci/archive/20250912/202509120205.YfzyI2gp-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 21857ae337e0892a5522b6e7337899caa61de2a6)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509120205.YfzyI2gp-lkp@intel.com/

smatch warnings:
kernel/bpf/verifier.c:19305 is_state_visited() error: uninitialized symbol 'err'.

vim +/err +19305 kernel/bpf/verifier.c

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
                                                                                              ^^^
err needs to be initialized to zero at the start.  Btw, I really
encourage people to use CONFIG_INIT_STACK_ALL_PATTERN=y in their
testing.  (In production everyone should use
CONFIG_INIT_STACK_ALL_ZERO=y).


23b37d616565c8 Eduard Zingerman        2025-06-11  19306  			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  19307  			if (err)
f4d7e40a5b7157 Alexei Starovoitov      2017-12-14  19308  				return err;
c9e31900b54cad Eduard Zingerman        2025-06-11  19309  			/* When processing iterator based loops above propagate_liveness and
c9e31900b54cad Eduard Zingerman        2025-06-11  19310  			 * propagate_precision calls are not sufficient to transfer all relevant
c9e31900b54cad Eduard Zingerman        2025-06-11  19311  			 * read and precision marks. E.g. consider the following case:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


