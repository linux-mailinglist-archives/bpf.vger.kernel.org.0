Return-Path: <bpf+bounces-69512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232FB988BE
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AF1188BC35
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2827B4EE;
	Wed, 24 Sep 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGiVML9Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E094F27A45C;
	Wed, 24 Sep 2025 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699111; cv=none; b=ep7nof7ewGMOCXYxoDQuC/TPCBSBAKxPNCZmD+JO5s15hZTIB0L2Rq1DkQi0bEw5Z0dW5gabT6NnbbVoffZJ9WSWGBPR9DANBfkxiFtiDhr6oG/c7SSqDy1izfqbf+j1waSUZ4XAn6IBfALxQNDmyIjwgX6c7qyxXZPh6BIK5is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699111; c=relaxed/simple;
	bh=6nLTiBX+i6oDy3bJ9KcSTG8qddcnQz069pUKyFpruNE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N+8pAfdPnCo1xP4Yh6qjPnMb1iuvkscLhCTxKaCwVhozUVYsSLgCBOlOms9V273pZtwfwghK+TzMn/qri89uEZmytzbjRGnb478vpMty6A9CtrW53BWEy72W6oXGCyE0Fvqi5cxuw00rYUsFz/+adQ01QFIySoSRzYnb7XJf18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGiVML9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F35C4CEE7;
	Wed, 24 Sep 2025 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758699110;
	bh=6nLTiBX+i6oDy3bJ9KcSTG8qddcnQz069pUKyFpruNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rGiVML9QjFVU43RaOxBF69imHHooIM4DLJkySilzAJfgBpyYFSFUloJyzxepb6hJC
	 xpYEu1x/zpqc4zC7uD4ZqHD1MB2NIMVRYiQSeMUFbelkZV4xBsG7+25IdXB+mb/X+P
	 fXp69t5/LE4dDxDZm4as66ZLfLkVRl2rQ77n4aUw9HuYAIVys3ouShZfmzUz82jD8n
	 fTYuL1YizKu3kWTbMOJZU7oX1K6tGd5l37xiWvmi4fC6hqBJtdIiKRlnSRL4Rijd54
	 kKBHZmsfsWkzZvLy6JO3ByPgVoKmi5UT7jidK9Ki8oMA6jVw54yVgeThYJLquJWd6A
	 HHKSwUIKoED/w==
Date: Wed, 24 Sep 2025 16:31:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Feng Yang <yangfeng59949@163.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-Id: <20250924163146.28530774c4a16656d814c8ff@kernel.org>
In-Reply-To: <20250924062536.471231-1-yangfeng59949@163.com>
References: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
	<20250924062536.471231-1-yangfeng59949@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 14:25:36 +0800
Feng Yang <yangfeng59949@163.com> wrote:

> On Wed, 24 Sep 2025 00:32:15 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Mon, 22 Sep 2025 10:15:31 +0800
> > Feng Yang <yangfeng59949@163.com> wrote:
> > 
> > > On Sun, 21 Sep 2025 22:30:37 +0900 Masami Hiramatsu wrote:
> > > 
> > > > On Fri, 19 Sep 2025 19:56:20 -0700
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > > 
> > > > > On Fri, Sep 19, 2025 at 12:19 AM Feng Yang <yangfeng59949@163.com> wrote:
> > > > > >
> > > > > > When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
> > > > > > I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.
> > > > > >
> > > > > > For example:
> > > > > > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > > > index 9e1ca8e34913..844fa88cdc4c 100644
> > > > > > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > > > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > > > @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
> > > > > >  __u64 kretprobe_test7_result = 0;
> > > > > >  __u64 kretprobe_test8_result = 0;
> > > > > >
> > > > > > +typedef __u64 stack_trace_t[2];
> > > > > > +
> > > > > > +struct {
> > > > > > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > > > > +       __uint(max_entries, 1024);
> > > > > > +       __type(key, __u32);
> > > > > > +       __type(value, stack_trace_t);
> > > > > > +} stacks SEC(".maps");
> > > > > > +
> > > > > >  static void kprobe_multi_check(void *ctx, bool is_return)
> > > > > >  {
> > > > > >         if (bpf_get_current_pid_tgid() >> 32 != pid)
> > > > > > @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
> > > > > >  SEC("kprobe.multi")
> > > > > >  int test_kprobe_manual(struct pt_regs *ctx)
> > > > > >  {
> > > > > > +       int id = bpf_get_stackid(ctx, &stacks, 0);
> > > > > 
> > > > > ftrace_partial_regs() supposed to work on x86 and arm64,
> > > > > but since multi-kprobe is the only user...
> > > > 
> > > > It should be able to unwind stack. It saves sp, pc, lr, fp.
> > > > 
> > > > 	regs->sp = afregs->sp;
> > > > 	regs->pc = afregs->pc;
> > > > 	regs->regs[29] = afregs->fp;
> > > > 	regs->regs[30] = afregs->lr;
> > > > 
> > > > > I suspect the arm64 implementation wasn't really tested.
> > > > > Or maybe there is some other issue.
> > > > 
> > > > It depends on how bpf_get_stackid() works. Some registers for that
> > > > function may not be saved.
> > > > 
> > > > If it returns -EFAULT, the get_perf_callchain() returns NULL.
> > > > 
> > > 
> > > During my test, the reason for returning -EFAULT was that trace->nr was 0.
> > > 
> > > static long __bpf_get_stackid(struct bpf_map *map,
> > > 			      struct perf_callchain_entry *trace, u64 flags)
> > > {
> > > 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
> > > 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> > > 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> > > 	u32 hash, id, trace_nr, trace_len;
> > > 	bool user = flags & BPF_F_USER_STACK;
> > > 	u64 *ips;
> > > 	bool hash_matches;
> > > 
> > > 	if (trace->nr <= skip)
> > > 		/* skipping more than usable stack trace */
> > > 		return -EFAULT;
> > > 	......
> > 
> > Hmm. The "trace" is returned from get_perf_callchain()
> > 
> > get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> > 		   u32 max_stack, bool crosstask, bool add_mark)
> > {
> > ...
> > 
> > 	if (kernel && !user_mode(regs)) {
> > 		if (add_mark)
> > 			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
> > 		perf_callchain_kernel(&ctx, regs);
> > 	}
> > 
> > So this means `perf_callchain_kernel(&ctx, regs);` fails to unwind stack.
> > 
> > perf_callchain_kernel() -> arch_stack_walk() -> kunwind_stack_walk()
> > 
> > That is `kunwind_init_from_regs()` and `do_kunwind()`.
> > 
> > 	if (regs) {
> > 		if (task != current)
> > 			return -EINVAL;
> > 		kunwind_init_from_regs(&state, regs);
> > 	} else if (task == current) {
> > 		kunwind_init_from_caller(&state);
> > 	} else {
> > 		kunwind_init_from_task(&state, task);
> > 	}
> > 
> > 	return do_kunwind(&state, consume_state, cookie);
> > 
> > For initialization, it should be OK because it only refers pc and 
> > fp(regs[29]), which are recovered by ftrace_partial_regs().
> > 
> > static __always_inline void
> > kunwind_init_from_regs(struct kunwind_state *state,
> > 		       struct pt_regs *regs)
> > {
> > 	kunwind_init(state, current);
> > 
> > 	state->regs = regs;
> > 	state->common.fp = regs->regs[29];
> > 	state->common.pc = regs->pc;
> > 	state->source = KUNWIND_SOURCE_REGS_PC;
> > }
> > 
> > And do_kunwind() should work increase trace->nr before return
> > unless `kunwind_recover_return_address()` fails.
> > 
> > static __always_inline int
> > do_kunwind(struct kunwind_state *state, kunwind_consume_fn consume_state,
> > 	   void *cookie)
> > {
> > 	int ret;
> > 
> > 	ret = kunwind_recover_return_address(state);
> > 	if (ret)
> > 		return ret;
> > 
> > 	while (1) {
> > 		if (!consume_state(state, cookie)) <--- this increases trace->nr (*).
> > 			return -EINVAL;
> > 		ret = kunwind_next(state);
> > 		if (ret == -ENOENT)
> > 			return 0;
> > 		if (ret < 0)
> > 			return ret;
> > 	}
> > }
> > 
> > (*) consume_state() == arch_kunwind_consume_entry() 
> >   ->  data->consume_entry == callchain_trace() -> perf_callchain_store().
> > 
> > Hmm, can you also dump the regs and insert pr_info() to find
> > which function fails?
> > 
> > Thanks,
> > 
> 
> After testing, it was found that the stack could not be obtained because user_mode(regs) returned 1. 
> Referring to the arch_ftrace_fill_perf_regs function in your email 
> (https://lore.kernel.org/all/173518997908.391279.15910334347345106424.stgit@devnote2/), 
> I made the following modification: by setting the value of pstate, the stack can now be obtained successfully.
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 058a99aa44bd..f2814175e958 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -159,11 +159,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  {
>         struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
>  
>         memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
>         regs->sp = afregs->sp;
>         regs->pc = afregs->pc;
>         regs->regs[29] = afregs->fp;
>         regs->regs[30] = afregs->lr;
> +       regs->pstate = PSR_MODE_EL1h;

Good catch! 

>         return regs;
>  }
> However, I'm not sure if there will be any other impacts...
> 
> By the way, during my testing, I also noticed that when executing bpf_get_stackid via kprobes or tracepoints, 
> the command bpftrace -e 'kprobe:bpf_get_stackid {printf("bpf_get_stackid\n");}' produces no output. 

That is strange. since normal kprobes passes full pt_regs.

> However, it does output something when bpf_get_stackid is invoked via uprobes. 
> This phenomenon also occurs on the x86 architecture, could this be a bug as well?

Yes, it must be a bug.

Thanks!

> 
> Thanks.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

