Return-Path: <bpf+bounces-30634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E058CFA0E
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C971C20E27
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7411B963;
	Mon, 27 May 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqOGKubm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6920326
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794782; cv=none; b=NCL3iiTDkfUBztYOlnJlW3s9PedinKoOkr6yMoWOU3KSC0pOVd2akyxmHSaZ2mobcjTehvlmO1wpl7e11BQdhxPoyw6VmmRI99SHMFBIG2qrZzfQfPqBU9vuQHrJ0gnwBuZIkSj5pMSbQ8p1Nez7q0K9eV7JOBEhQbCViQcWQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794782; c=relaxed/simple;
	bh=8916VmssQGHKQshF2zn6ew7yqQmlXvWJ3MglMuteg7o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TlGJQ/VfXIJGgBu+BdkcALkjprHZi2ss88f9YUJPMPHfKXnuzQuap97hfhxSnRc02jeHQ3SF58I4XvzZjwAkJFHMeiFcPQrQ8HeD+wkN4Q3lfwAEJ82LggIfHCrwyHjXyZFt1YjMzfK18M1VN8BOWB3FtV4obsvRLhzp4/iDcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eqOGKubm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-529661f2552so2696285e87.2
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716794776; x=1717399576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmrsWZg+Yotg0WP36pE1NqEk0vnknAfbxNJ31heypG8=;
        b=eqOGKubmFjg9V3Evby9zXwcaHeMF7A9QI5H58r9BsVis6+l2MVhY87266FT2HKzB86
         BL2jFLv24J5E5OHVcfaELJ4o0uEcNmKTVjv5SYH7evUra6Y++FCC0Vkn/5cWepzSG/2W
         l/49WcHRhajjTQ7i60iY/9yxZtRtmDVMVA4G6esq9JeduVlrjWLVLy/0HkUHCb1rtRUP
         c4PehqRP8/W69PrfnwxvkvVq3FZ4203z3tgb752boRAXNLsRvZsjh6qsUiMHsFW0VnwG
         n1AjKQuzhoL2RladiAfBB3opIZfs7WlkAMJOBVfF/3BIkSZEz5GkqUbozp2FXERkRZrZ
         /2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794776; x=1717399576;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmrsWZg+Yotg0WP36pE1NqEk0vnknAfbxNJ31heypG8=;
        b=l/lNbaXYy8E4Jf/vSU3DM2d6hWtQPnC7aB1AZEk27WJ5OXzQLVaCUt0AvS9I7DZbtW
         EOJc5txY01lWxp2ls9839YDouhjY98lWvPPUyWPw10ti53ZjTdROkerm90JAafZtAWCy
         b2TPY9ASb2VH11TIxTw4+0Z4oKgLZb+BDIQIYzAXpe/gCvwponwaIuf/cTcXueOZjDQy
         ImjSiZKw5cCU8HxOUburQpRpDPU7EIf9/7gdPrSu3TIrneht0wKb1Elj5TbziT3tcNEv
         3aFU/TruvurYDkWhF4J5l0vMOKYlkdEr7oQ3ffRkUbqgTnwq+ybokpQlA79AXA/qwCu+
         gHvA==
X-Forwarded-Encrypted: i=1; AJvYcCU6kkUe8KSpF9bVso9b7cz1VSoHFTJbd6ePaRJH5L8Abi2acPoBcAbUzLlNyDFgCNZPyT8cLUv8SVAVttie0vxdSacg
X-Gm-Message-State: AOJu0Yx6PlDsV6fvMcOVMQDVDxZ9jKlCyp7cdk1ApiDmoFtL+zR5LBuQ
	7NeaF/uqXlZI1YL+Afr3av2m5dbWlnn3ydC81kbsjqA6ZclRwz9r9Gzrx8gI3hc=
X-Google-Smtp-Source: AGHT+IHeSS7LcNl5KXYJiWDLtwb5jtbsR++iKOhh1ZE4rB2LgNw3qajBZuOsFlNEFQ+uYaEQ3uruFg==
X-Received: by 2002:a19:6407:0:b0:51d:a78e:9036 with SMTP id 2adb3069b0e04-52966f8f8acmr4807141e87.69.1716794776182;
        Mon, 27 May 2024 00:26:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c81734csm457664966b.45.2024.05.27.00.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:26:15 -0700 (PDT)
Date: Mon, 27 May 2024 10:26:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, memxor@gmail.com,
	eddyz87@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
Message-ID: <91453e3f-66b0-4927-a756-bd18f9e6bf05@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525031156.13545-1-alexei.starovoitov@gmail.com>

Hi Alexei,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Alexei-Starovoitov/selftests-bpf-Remove-i-zero-workaround-and-add-new-tests/20240525-111247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20240525031156.13545-1-alexei.starovoitov%40gmail.com
patch subject: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open coded iters and may_goto loop.
config: nios2-randconfig-r071-20240526 (https://download.01.org/0day-ci/archive/20240526/202405260726.0H6QiGNy-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405260726.0H6QiGNy-lkp@intel.com/

New smatch warnings:
kernel/bpf/verifier.c:15315 check_cond_jmp_op() error: uninitialized symbol 'other_dst_reg'.

Old smatch warnings:
arch/nios2/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.

vim +/other_dst_reg +15315 kernel/bpf/verifier.c

58e2af8b3a6b58 Jakub Kicinski     2016-09-21  15108  static int check_cond_jmp_op(struct bpf_verifier_env *env,
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15109  			     struct bpf_insn *insn, int *insn_idx)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15110  {
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  15111  	struct bpf_verifier_state *this_branch = env->cur_state;
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  15112  	struct bpf_verifier_state *other_branch;
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  15113  	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
fb8d251ee2a6bf Alexei Starovoitov 2019-06-15  15114  	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
689049426b9d3b Alexei Starovoitov 2024-05-24  15115  	struct bpf_reg_state *eq_branch_regs, *other_dst_reg, *other_src_reg = NULL;
c31534267c180f Andrii Nakryiko    2023-11-01  15116  	struct bpf_reg_state fake_reg = {};
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15117  	u8 opcode = BPF_OP(insn->code);
689049426b9d3b Alexei Starovoitov 2024-05-24  15118  	bool is_jmp32, ignore_pred;
689049426b9d3b Alexei Starovoitov 2024-05-24  15119  	bool has_src_reg = false;
fb8d251ee2a6bf Alexei Starovoitov 2019-06-15  15120  	int pred = -1;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15121  	int err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15122  
092ed0968bb648 Jiong Wang         2019-01-26  15123  	/* Only conditional jumps are expected to reach here. */
011832b97b311b Alexei Starovoitov 2024-03-05  15124  	if (opcode == BPF_JA || opcode > BPF_JCOND) {
092ed0968bb648 Jiong Wang         2019-01-26  15125  		verbose(env, "invalid BPF_JMP/JMP32 opcode %x\n", opcode);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15126  		return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15127  	}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15128  
011832b97b311b Alexei Starovoitov 2024-03-05  15129  	if (opcode == BPF_JCOND) {
011832b97b311b Alexei Starovoitov 2024-03-05  15130  		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
011832b97b311b Alexei Starovoitov 2024-03-05  15131  		int idx = *insn_idx;
011832b97b311b Alexei Starovoitov 2024-03-05  15132  
011832b97b311b Alexei Starovoitov 2024-03-05  15133  		if (insn->code != (BPF_JMP | BPF_JCOND) ||
011832b97b311b Alexei Starovoitov 2024-03-05  15134  		    insn->src_reg != BPF_MAY_GOTO ||
011832b97b311b Alexei Starovoitov 2024-03-05  15135  		    insn->dst_reg || insn->imm || insn->off == 0) {
011832b97b311b Alexei Starovoitov 2024-03-05  15136  			verbose(env, "invalid may_goto off %d imm %d\n",
011832b97b311b Alexei Starovoitov 2024-03-05  15137  				insn->off, insn->imm);
011832b97b311b Alexei Starovoitov 2024-03-05  15138  			return -EINVAL;
011832b97b311b Alexei Starovoitov 2024-03-05  15139  		}
011832b97b311b Alexei Starovoitov 2024-03-05  15140  		prev_st = find_prev_entry(env, cur_st->parent, idx);
011832b97b311b Alexei Starovoitov 2024-03-05  15141  
011832b97b311b Alexei Starovoitov 2024-03-05  15142  		/* branch out 'fallthrough' insn as a new state to explore */
011832b97b311b Alexei Starovoitov 2024-03-05  15143  		queued_st = push_stack(env, idx + 1, idx, false);
011832b97b311b Alexei Starovoitov 2024-03-05  15144  		if (!queued_st)
011832b97b311b Alexei Starovoitov 2024-03-05  15145  			return -ENOMEM;
011832b97b311b Alexei Starovoitov 2024-03-05  15146  
011832b97b311b Alexei Starovoitov 2024-03-05  15147  		queued_st->may_goto_depth++;
011832b97b311b Alexei Starovoitov 2024-03-05  15148  		if (prev_st)
011832b97b311b Alexei Starovoitov 2024-03-05  15149  			widen_imprecise_scalars(env, prev_st, queued_st);
011832b97b311b Alexei Starovoitov 2024-03-05  15150  		*insn_idx += insn->off;
011832b97b311b Alexei Starovoitov 2024-03-05  15151  		return 0;
011832b97b311b Alexei Starovoitov 2024-03-05  15152  	}
011832b97b311b Alexei Starovoitov 2024-03-05  15153  
d75e30dddf7344 Yafang Shao        2023-08-23  15154  	/* check src2 operand */
d75e30dddf7344 Yafang Shao        2023-08-23  15155  	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
d75e30dddf7344 Yafang Shao        2023-08-23  15156  	if (err)
d75e30dddf7344 Yafang Shao        2023-08-23  15157  		return err;
d75e30dddf7344 Yafang Shao        2023-08-23  15158  
d75e30dddf7344 Yafang Shao        2023-08-23  15159  	dst_reg = &regs[insn->dst_reg];
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15160  	if (BPF_SRC(insn->code) == BPF_X) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15161  		if (insn->imm != 0) {
092ed0968bb648 Jiong Wang         2019-01-26  15162  			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15163  			return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15164  		}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15165  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15166  		/* check src1 operand */
dc503a8ad98474 Edward Cree        2017-08-15  15167  		err = check_reg_arg(env, insn->src_reg, SRC_OP);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15168  		if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15169  			return err;
1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15170  
689049426b9d3b Alexei Starovoitov 2024-05-24  15171  		has_src_reg = true;
d75e30dddf7344 Yafang Shao        2023-08-23  15172  		src_reg = &regs[insn->src_reg];
d75e30dddf7344 Yafang Shao        2023-08-23  15173  		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
d75e30dddf7344 Yafang Shao        2023-08-23  15174  		    is_pointer_value(env, insn->src_reg)) {
61bd5218eef349 Jakub Kicinski     2017-10-09  15175  			verbose(env, "R%d pointer comparison prohibited\n",
1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15176  				insn->src_reg);
1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15177  			return -EACCES;
1be7f75d1668d6 Alexei Starovoitov 2015-10-07  15178  		}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15179  	} else {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15180  		if (insn->src_reg != BPF_REG_0) {
092ed0968bb648 Jiong Wang         2019-01-26  15181  			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15182  			return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15183  		}
c31534267c180f Andrii Nakryiko    2023-11-01  15184  		src_reg = &fake_reg;
c31534267c180f Andrii Nakryiko    2023-11-01  15185  		src_reg->type = SCALAR_VALUE;
c31534267c180f Andrii Nakryiko    2023-11-01  15186  		__mark_reg_known(src_reg, insn->imm);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15187  	}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15188  
092ed0968bb648 Jiong Wang         2019-01-26  15189  	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
689049426b9d3b Alexei Starovoitov 2024-05-24  15190  	if (dst_reg->type != SCALAR_VALUE || src_reg->type != SCALAR_VALUE)
689049426b9d3b Alexei Starovoitov 2024-05-24  15191  		ignore_pred = false;
689049426b9d3b Alexei Starovoitov 2024-05-24  15192  	/*
689049426b9d3b Alexei Starovoitov 2024-05-24  15193  	 * Compilers often optimize loop exit condition to equality, so
689049426b9d3b Alexei Starovoitov 2024-05-24  15194  	 *      for (i = 0; i < 100; i++) arr[i] = 1
689049426b9d3b Alexei Starovoitov 2024-05-24  15195  	 * becomes
689049426b9d3b Alexei Starovoitov 2024-05-24  15196  	 *      for (i = 0; i != 100; i++) arr[1] = 1
689049426b9d3b Alexei Starovoitov 2024-05-24  15197  	 * Hence treat != and == conditions specially in the verifier.
689049426b9d3b Alexei Starovoitov 2024-05-24  15198  	 * Widen only not-predicted branch and keep predict branch as is. Example:
689049426b9d3b Alexei Starovoitov 2024-05-24  15199  	 *    r1 = 0
689049426b9d3b Alexei Starovoitov 2024-05-24  15200  	 *    goto L1
689049426b9d3b Alexei Starovoitov 2024-05-24  15201  	 * L2:
689049426b9d3b Alexei Starovoitov 2024-05-24  15202  	 *    arr[r1] = 1
689049426b9d3b Alexei Starovoitov 2024-05-24  15203  	 *    r1++
689049426b9d3b Alexei Starovoitov 2024-05-24  15204  	 * L1:
689049426b9d3b Alexei Starovoitov 2024-05-24  15205  	 *    if r1 != 100 goto L2
689049426b9d3b Alexei Starovoitov 2024-05-24  15206  	 *    fallthrough: r1=100 after widening
689049426b9d3b Alexei Starovoitov 2024-05-24  15207  	 *    other_branch: r1 stays as-is (0, 1, 2, ..)
689049426b9d3b Alexei Starovoitov 2024-05-24  15208  	 *
689049426b9d3b Alexei Starovoitov 2024-05-24  15209  	 *  Also recognize the case where both LHS and RHS are constant and
689049426b9d3b Alexei Starovoitov 2024-05-24  15210  	 *  equal to each other. In this case don't widen at all and take the
689049426b9d3b Alexei Starovoitov 2024-05-24  15211  	 *  predicted path. This key heuristic allows the verifier detect loop
689049426b9d3b Alexei Starovoitov 2024-05-24  15212  	 *  end condition and 'for (i = 0; i != 100; i++)' is validated just
689049426b9d3b Alexei Starovoitov 2024-05-24  15213  	 *  like bounded loop.
689049426b9d3b Alexei Starovoitov 2024-05-24  15214  	 */
689049426b9d3b Alexei Starovoitov 2024-05-24  15215  	else if (is_reg_const(dst_reg, is_jmp32) && is_reg_const(src_reg, is_jmp32) &&
689049426b9d3b Alexei Starovoitov 2024-05-24  15216  	    reg_const_value(dst_reg, is_jmp32) == reg_const_value(src_reg, is_jmp32))
689049426b9d3b Alexei Starovoitov 2024-05-24  15217  		ignore_pred = false;
689049426b9d3b Alexei Starovoitov 2024-05-24  15218  	else
689049426b9d3b Alexei Starovoitov 2024-05-24  15219  		ignore_pred = (get_loop_entry(this_branch) ||
689049426b9d3b Alexei Starovoitov 2024-05-24  15220  			       this_branch->may_goto_depth) &&
689049426b9d3b Alexei Starovoitov 2024-05-24  15221  				/* Gate widen_reg() logic */
689049426b9d3b Alexei Starovoitov 2024-05-24  15222  				env->bpf_capable;
689049426b9d3b Alexei Starovoitov 2024-05-24  15223  
c31534267c180f Andrii Nakryiko    2023-11-01  15224  	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
689049426b9d3b Alexei Starovoitov 2024-05-24  15225  	if (pred >= 0 && !ignore_pred) {
cac616db39c207 John Fastabend     2020-05-21  15226  		/* If we get here with a dst_reg pointer type it is because
cac616db39c207 John Fastabend     2020-05-21  15227  		 * above is_branch_taken() special cased the 0 comparison.
cac616db39c207 John Fastabend     2020-05-21  15228  		 */
cac616db39c207 John Fastabend     2020-05-21  15229  		if (!__is_pointer_value(false, dst_reg))
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15230  			err = mark_chain_precision(env, insn->dst_reg);
6d94e741a8ff81 Alexei Starovoitov 2020-11-10  15231  		if (BPF_SRC(insn->code) == BPF_X && !err &&
6d94e741a8ff81 Alexei Starovoitov 2020-11-10  15232  		    !__is_pointer_value(false, src_reg))
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15233  			err = mark_chain_precision(env, insn->src_reg);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15234  		if (err)
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15235  			return err;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  15236  	}
9183671af6dbf6 Daniel Borkmann    2021-05-28  15237  
689049426b9d3b Alexei Starovoitov 2024-05-24  15238  	if (pred < 0 || ignore_pred) {
689049426b9d3b Alexei Starovoitov 2024-05-24  15239  		other_branch = push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
689049426b9d3b Alexei Starovoitov 2024-05-24  15240  					  false);
689049426b9d3b Alexei Starovoitov 2024-05-24  15241  		if (!other_branch)
689049426b9d3b Alexei Starovoitov 2024-05-24  15242  			return -EFAULT;
689049426b9d3b Alexei Starovoitov 2024-05-24  15243  		other_branch_regs = other_branch->frame[other_branch->curframe]->regs;
689049426b9d3b Alexei Starovoitov 2024-05-24  15244  		other_dst_reg = &other_branch_regs[insn->dst_reg];
689049426b9d3b Alexei Starovoitov 2024-05-24  15245  		if (has_src_reg)
689049426b9d3b Alexei Starovoitov 2024-05-24  15246  			other_src_reg = &other_branch_regs[insn->src_reg];
689049426b9d3b Alexei Starovoitov 2024-05-24  15247  	}

other_dst_reg not set on else path.

689049426b9d3b Alexei Starovoitov 2024-05-24  15248  
4f7b3e82589e0d Alexei Starovoitov 2018-12-03  15249  	if (pred == 1) {
9183671af6dbf6 Daniel Borkmann    2021-05-28  15250  		/* Only follow the goto, ignore fall-through. If needed, push
9183671af6dbf6 Daniel Borkmann    2021-05-28  15251  		 * the fall-through branch for simulation under speculative
9183671af6dbf6 Daniel Borkmann    2021-05-28  15252  		 * execution.
9183671af6dbf6 Daniel Borkmann    2021-05-28  15253  		 */
9183671af6dbf6 Daniel Borkmann    2021-05-28  15254  		if (!env->bypass_spec_v1 &&
9183671af6dbf6 Daniel Borkmann    2021-05-28  15255  		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
9183671af6dbf6 Daniel Borkmann    2021-05-28  15256  					       *insn_idx))
9183671af6dbf6 Daniel Borkmann    2021-05-28  15257  			return -EFAULT;
1a8a315f008a58 Andrii Nakryiko    2023-10-11  15258  		if (env->log.level & BPF_LOG_LEVEL)
1a8a315f008a58 Andrii Nakryiko    2023-10-11  15259  			print_insn_state(env, this_branch->frame[this_branch->curframe]);
689049426b9d3b Alexei Starovoitov 2024-05-24  15260  		if (ignore_pred) {
689049426b9d3b Alexei Starovoitov 2024-05-24  15261  			/* dst and src regs are scalars. Widen them */
689049426b9d3b Alexei Starovoitov 2024-05-24  15262  			widen_reg(dst_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15263  			if (has_src_reg)
689049426b9d3b Alexei Starovoitov 2024-05-24  15264  				widen_reg(src_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15265  			/*
689049426b9d3b Alexei Starovoitov 2024-05-24  15266  			 * Widen other branch only if not comparing for equlity.
689049426b9d3b Alexei Starovoitov 2024-05-24  15267  			 * Example:
689049426b9d3b Alexei Starovoitov 2024-05-24  15268  			 *   r1 = 1
689049426b9d3b Alexei Starovoitov 2024-05-24  15269  			 *   if (r1 < 100)
689049426b9d3b Alexei Starovoitov 2024-05-24  15270  			 * will produce
689049426b9d3b Alexei Starovoitov 2024-05-24  15271  			 *   [0, 99] and [100, UMAX] after widening and reg_set_min_max().
689049426b9d3b Alexei Starovoitov 2024-05-24  15272  			 *
689049426b9d3b Alexei Starovoitov 2024-05-24  15273  			 *   r1 = 1
689049426b9d3b Alexei Starovoitov 2024-05-24  15274  			 *   if (r1 == 100)
689049426b9d3b Alexei Starovoitov 2024-05-24  15275  			 * will produce
689049426b9d3b Alexei Starovoitov 2024-05-24  15276  			 *    [1] and [100] after widening in other_branch and reg_set_min_max().
689049426b9d3b Alexei Starovoitov 2024-05-24  15277  			 */
689049426b9d3b Alexei Starovoitov 2024-05-24  15278  			if (opcode != BPF_JEQ && opcode != BPF_JNE) {
689049426b9d3b Alexei Starovoitov 2024-05-24  15279  				widen_reg(other_dst_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15280  				if (has_src_reg)
689049426b9d3b Alexei Starovoitov 2024-05-24  15281  					widen_reg(other_src_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15282  			}
689049426b9d3b Alexei Starovoitov 2024-05-24  15283  		} else {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15284  			*insn_idx += insn->off;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15285  			return 0;
689049426b9d3b Alexei Starovoitov 2024-05-24  15286  		}
4f7b3e82589e0d Alexei Starovoitov 2018-12-03  15287  	} else if (pred == 0) {
9183671af6dbf6 Daniel Borkmann    2021-05-28  15288  		/* Only follow the fall-through branch, since that's where the
9183671af6dbf6 Daniel Borkmann    2021-05-28  15289  		 * program will go. If needed, push the goto branch for
9183671af6dbf6 Daniel Borkmann    2021-05-28  15290  		 * simulation under speculative execution.
9183671af6dbf6 Daniel Borkmann    2021-05-28  15291  		 */
9183671af6dbf6 Daniel Borkmann    2021-05-28  15292  		if (!env->bypass_spec_v1 &&
9183671af6dbf6 Daniel Borkmann    2021-05-28  15293  		    !sanitize_speculative_path(env, insn,
9183671af6dbf6 Daniel Borkmann    2021-05-28  15294  					       *insn_idx + insn->off + 1,
9183671af6dbf6 Daniel Borkmann    2021-05-28  15295  					       *insn_idx))
9183671af6dbf6 Daniel Borkmann    2021-05-28  15296  			return -EFAULT;
1a8a315f008a58 Andrii Nakryiko    2023-10-11  15297  		if (env->log.level & BPF_LOG_LEVEL)
1a8a315f008a58 Andrii Nakryiko    2023-10-11  15298  			print_insn_state(env, this_branch->frame[this_branch->curframe]);
689049426b9d3b Alexei Starovoitov 2024-05-24  15299  		if (ignore_pred) {
689049426b9d3b Alexei Starovoitov 2024-05-24  15300  			if (opcode != BPF_JEQ && opcode != BPF_JNE) {
689049426b9d3b Alexei Starovoitov 2024-05-24  15301  				widen_reg(dst_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15302  				if (has_src_reg)
689049426b9d3b Alexei Starovoitov 2024-05-24  15303  					widen_reg(src_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15304  			}
689049426b9d3b Alexei Starovoitov 2024-05-24  15305  			widen_reg(other_dst_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15306  			if (has_src_reg)
689049426b9d3b Alexei Starovoitov 2024-05-24  15307  				widen_reg(other_src_reg);
689049426b9d3b Alexei Starovoitov 2024-05-24  15308  		} else {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15309  			return 0;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15310  		}
689049426b9d3b Alexei Starovoitov 2024-05-24  15311  	}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  15312  
484611357c19f9 Josef Bacik        2016-09-28  15313  	if (BPF_SRC(insn->code) == BPF_X) {
5f99f312bd3bed Andrii Nakryiko    2023-11-11  15314  		err = reg_set_min_max(env,
689049426b9d3b Alexei Starovoitov 2024-05-24 @15315  				      other_dst_reg, other_src_reg,
                                                                                      ^^^^^^^^^^^^^

4621202adc5bc0 Andrii Nakryiko    2023-11-01  15316  				      dst_reg, src_reg, opcode, is_jmp32);
4621202adc5bc0 Andrii Nakryiko    2023-11-01  15317  	} else /* BPF_SRC(insn->code) == BPF_K */ {
5f99f312bd3bed Andrii Nakryiko    2023-11-11  15318  		err = reg_set_min_max(env,
689049426b9d3b Alexei Starovoitov 2024-05-24  15319  				      other_dst_reg,
                                                                                      ^^^^^^^^^^^^^
Passed to reg_set_min_max() without being initialized.

4621202adc5bc0 Andrii Nakryiko    2023-11-01  15320  				      src_reg /* fake one */,
4621202adc5bc0 Andrii Nakryiko    2023-11-01  15321  				      dst_reg, src_reg /* same fake one */,
3f50f132d8400e John Fastabend     2020-03-30  15322  				      opcode, is_jmp32);
484611357c19f9 Josef Bacik        2016-09-28  15323  	}
5f99f312bd3bed Andrii Nakryiko    2023-11-11  15324  	if (err)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


