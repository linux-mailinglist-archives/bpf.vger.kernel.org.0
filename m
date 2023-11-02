Return-Path: <bpf+bounces-13986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8587DF834
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 17:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3DB21296
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F11DA5E;
	Thu,  2 Nov 2023 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A6063AD
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 16:59:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5F3113A;
	Thu,  2 Nov 2023 09:59:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8972F4;
	Thu,  2 Nov 2023 10:00:13 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1FDF3F738;
	Thu,  2 Nov 2023 09:59:28 -0700 (PDT)
Date: Thu, 2 Nov 2023 16:59:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf, arm64: support exceptions
Message-ID: <ZUPVbrMSNNwPw_B-@FVFF77S0Q05N.cambridge.arm.com>
References: <20230917000045.56377-1-puranjay12@gmail.com>
 <20230917000045.56377-2-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917000045.56377-2-puranjay12@gmail.com>

On Sun, Sep 17, 2023 at 12:00:45AM +0000, Puranjay Mohan wrote:
> Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be used
> by bpf_throw() to unwind till the program marked as exception boundary and
> run the callback with the stack of the main program.
> 
> The prologue generation code has been modified to make the callback
> program use the stack of the program marked as exception boundary where
> callee-saved registers are already pushed.
> 
> As the bpf_throw function never returns, if it clobbers any callee-saved
> registers, they would remain clobbered. So, the prologue of the
> exception-boundary program is modified to push R23 and R24 as well,
> which the callback will then recover in its epilogue.
> 
> The Procedure Call Standard for the Arm 64-bit Architecture[1] states
> that registers r19 to r28 should be saved by the callee. BPF programs on
> ARM64 already save all callee-saved registers except r23 and r24. This
> patch adds an instruction in prologue of the  program to save these
> two registers and another instruction in the epilogue to recover them.
> 
> These extra instructions are only added if bpf_throw() used. Otherwise
> the emitted prologue/epilogue remains unchanged.
> 
> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---

[...]

> +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
> +{
> +	struct stack_info stacks[] = {
> +		stackinfo_get_task(current),
> +	};

Can bpf_throw() only be used by BPF programs that run in task context, or is it
possible e.g. for those to run within an IRQ handler (or otherwise on the IRQ
stack)?

> +
> +	struct unwind_state state = {
> +		.stacks = stacks,
> +		.nr_stacks = ARRAY_SIZE(stacks),
> +	};
> +	unwind_init_common(&state, current);
> +	state.fp = (unsigned long)__builtin_frame_address(1);
> +	state.pc = (unsigned long)__builtin_return_address(0);
> +
> +	if (unwind_next_frame_record(&state))
> +		return;
> +	while (1) {
> +		/* We only use the fp in the exception callback. Pass 0 for sp as it's unavailable*/
> +		if (!consume_fn(cookie, (u64)state.pc, 0, (u64)state.fp))
> +			break;
> +		if (unwind_next_frame_record(&state))
> +			break;
> +	}
> +}

IIUC you're not using arch_stack_walk() because you need the FP in addition to
the PC.

Is there any other reason you need to open-code this?

If not, I'd rather rework the common unwinder so that it's possible to get at
the FP. I had patches for that a while back:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/stacktrace/metadata

... and I'm happy to rebase that and pull out the minimum necessary to make
that possible.

Mark.

> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index f5065576cae9..7f768d335698 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -1,6 +1,5 @@
>  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> -exceptions					 # JIT does not support calling kfunc bpf_throw: -524
>  fexit_sleep                                      # The test never returns. The remaining tests cannot start.
>  kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>  kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> -- 
> 2.40.1
> 
> 

