Return-Path: <bpf+bounces-2-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DA76F733E
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3681C212AF
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF2EEDA;
	Thu,  4 May 2023 19:41:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849FBA4C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:41:03 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D1761AF
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 12:41:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64384c6797eso876453b3a.2
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683229261; x=1685821261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq2RV1DzKBKdGYy/LSNXIFoXYQ4nmoz2wuSUSfZtxZU=;
        b=RPIZyNTc4syZo/ozH+PPG5iQf5PIAA0UW/TMGOFVXh9f6avdG6TAaUNhgW1Sks1uzp
         eWryRd31l2OytfF9qchWkyJpNq16YbJ+W/sLrl8XKFvv2B6RIURazZmRIBCd4kkXuSt/
         8RG4FNHFO7Moq5WVCtujUCUcdp/SrY51aOemw2+W63Omc7wQB3o/4oFSQr/keYaAU6Vm
         NV/O0nKTEgx8ym0rFW0RFJzyntdFIbkWo+dUNEusCmJC960i5WmG7wfgZNr6R71cTN4/
         8wxMVMMv4R2rxTlUYE0cvxbIyw6zcvAWgk0MjT/t4ETB0uimCVAR9p3soY1qkgkIhzSH
         QLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683229261; x=1685821261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq2RV1DzKBKdGYy/LSNXIFoXYQ4nmoz2wuSUSfZtxZU=;
        b=dT+TXIxSiUv0jthpc5k6n08njiHiUmcncXSVeUtJBgosU0QohBMSAJ9Eb/ndEjiyf/
         HZM1rSdjK73VBGyq44iLLR3v0EvP4q8VgPBAeyDdJ0vFlz6a4/qW/Hr0oQW45eOvEP5/
         vfnTIqTsfywNtO0bDY78WUJFVuLQl82cpltfBOTbje8yWUmq6qMxCi1JQpnKEvRu3sqf
         RiskRJt9BeVkG/JiOGC4OM0w2mEBTsEvvHUQc1uW8NlU7+Gc6j9vX27ASmHLYGwXc/N4
         r6yf0PpaHP8rHrXMeHUAyocvYbsiokUcUrxHFZXBbHhcThf9En6b1Q+7u0JLk9cLujvx
         vb4A==
X-Gm-Message-State: AC+VfDzKt4L850N3jrqMwOOhpX/fgwXtQBejXS/b+sATBHJR8qEmTXKa
	R4Cqy4skNSkgt/gMHX4qfdU=
X-Google-Smtp-Source: ACHHUZ7OIG+mbH8V4Ek0zS7HBI1qBLETqcM94br2VYvN5d2ZR3XoHJDkqdzC35JI05tQtfaBVCk0PA==
X-Received: by 2002:a05:6a00:99d:b0:643:64fb:3b6a with SMTP id u29-20020a056a00099d00b0064364fb3b6amr4098456pfg.13.1683229261216;
        Thu, 04 May 2023 12:41:01 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id a7-20020aa78647000000b005a8bf239f5csm46013pfo.193.2023.05.04.12.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 12:41:00 -0700 (PDT)
Date: Thu, 4 May 2023 12:40:58 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 08/10] bpf: support precision propagation in the
 presence of subprogs
Message-ID: <20230504194058.uhnyup7xang5mq5i@MacBook-Pro-6.local>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-9-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-9-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Apr 25, 2023 at 04:49:09PM -0700, Andrii Nakryiko wrote:
>  	if (insn->code == 0)
>  		return 0;
> @@ -3424,14 +3449,72 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
>  		if (class == BPF_STX)
>  			bt_set_reg(bt, sreg);
>  	} else if (class == BPF_JMP || class == BPF_JMP32) {
> -		if (opcode == BPF_CALL) {
> -			if (insn->src_reg == BPF_PSEUDO_CALL)
> -				return -ENOTSUPP;
> -			/* BPF helpers that invoke callback subprogs are
> -			 * equivalent to BPF_PSEUDO_CALL above
> +		if (bpf_pseudo_call(insn)) {
> +			int subprog_insn_idx, subprog;
> +			bool is_global;
> +
> +			subprog_insn_idx = idx + insn->imm + 1;
> +			subprog = find_subprog(env, subprog_insn_idx);
> +			if (subprog < 0)
> +				return -EFAULT;
> +			is_global = subprog_is_global(env, subprog);
> +
> +			if (is_global) {

could you add a warn_on here that checks that jmp history doesn't have insns from subprog.

> +				/* r1-r5 are invalidated after subprog call,
> +				 * so for global func call it shouldn't be set
> +				 * anymore
> +				 */
> +				if (bt_reg_mask(bt) & BPF_REGMASK_ARGS)
> +					return -EFAULT;

This shouldn't be happening, but backtracking is delicate.
Could you add verbose("backtracking bug") here, so we know why the prog got rejected.
I'd probably do -ENOTSUPP, but EFAULT is ok too.

> +				/* global subprog always sets R0 */
> +				bt_clear_reg(bt, BPF_REG_0);
> +				return 0;
> +			} else {
> +				/* static subprog call instruction, which
> +				 * means that we are exiting current subprog,
> +				 * so only r1-r5 could be still requested as
> +				 * precise, r0 and r6-r10 or any stack slot in
> +				 * the current frame should be zero by now
> +				 */
> +				if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)
> +					return -EFAULT;

same here.

> +				/* we don't track register spills perfectly,
> +				 * so fallback to force-precise instead of failing */
> +				if (bt_stack_mask(bt) != 0)
> +					return -ENOTSUPP;
> +				/* propagate r1-r5 to the caller */
> +				for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
> +					if (bt_is_reg_set(bt, i)) {
> +						bt_clear_reg(bt, i);
> +						bt_set_frame_reg(bt, bt->frame - 1, i);
> +					}
> +				}
> +				if (bt_subprog_exit(bt))
> +					return -EFAULT;
> +				return 0;
> +			}
> +		} else if ((bpf_helper_call(insn) &&
> +			    is_callback_calling_function(insn->imm) &&
> +			    !is_async_callback_calling_function(insn->imm)) ||
> +			   (bpf_pseudo_kfunc_call(insn) && is_callback_calling_kfunc(insn->imm))) {
> +			/* callback-calling helper or kfunc call, which means
> +			 * we are exiting from subprog, but unlike the subprog
> +			 * call handling above, we shouldn't propagate
> +			 * precision of r1-r5 (if any requested), as they are
> +			 * not actually arguments passed directly to callback
> +			 * subprogs
>  			 */
> -			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
> +			if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS)
> +				return -EFAULT;
> +			if (bt_stack_mask(bt) != 0)
>  				return -ENOTSUPP;
> +			/* clear r1-r5 in callback subprog's mask */
> +			for (i = BPF_REG_1; i <= BPF_REG_5; i++)
> +				bt_clear_reg(bt, i);
> +			if (bt_subprog_exit(bt))
> +				return -EFAULT;
> +			return 0;

jmp history will include callback insn, right?
So skip of jmp history is missing here ?

> +		} else if (opcode == BPF_CALL) {
>  			/* kfunc with imm==0 is invalid and fixup_kfunc_call will
>  			 * catch this error later. Make backtracking conservative
>  			 * with ENOTSUPP.
> @@ -3449,7 +3532,39 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
>  				return -EFAULT;
>  			}
>  		} else if (opcode == BPF_EXIT) {
> -			return -ENOTSUPP;
> +			bool r0_precise;
> +
> +			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> +				/* if backtracing was looking for registers R1-R5
> +				 * they should have been found already.
> +				 */
> +				verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
> +				WARN_ONCE(1, "verifier backtracking bug");
> +				return -EFAULT;
> +			}
> +
> +			/* BPF_EXIT in subprog or callback always jump right

I'd say 'subprog always returns right after the call'. 'jump' is a bit confusing here,
since it doesn't normally used to describe function return address.

> +			 * after the call instruction, so by check whether the
> +			 * instruction at subseq_idx-1 is subprog call or not we
> +			 * can distinguish actual exit from *subprog* from
> +			 * exit from *callback*. In the former case, we need
> +			 * to propagate r0 precision, if necessary. In the
> +			 * former we never do that.
> +			 */
> +			r0_precise = subseq_idx - 1 >= 0 &&
> +				     bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) &&
> +				     bt_is_reg_set(bt, BPF_REG_0);
> +

The rest all makes sense.

