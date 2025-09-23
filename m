Return-Path: <bpf+bounces-69439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5537B969AB
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A63B320AC1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580432609CC;
	Tue, 23 Sep 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHSLMlvH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6982236E8;
	Tue, 23 Sep 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641542; cv=none; b=QI15NKBRIv73w0XnW/RH1Gvrp2cZvZTw498RhkxP/0VUuwpVM2F03kRq47KvIV/gT1qiKmVtPrWzn6dZ0P4QAg5HeQWI2HBxlD0M+RKqqBGNRtbsdvtV9r34gOCqj/8TQGL3AsbEdQhrrVwMFcVReNdQcBwTsXibuJAfes1jM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641542; c=relaxed/simple;
	bh=Ech0Y3Z2+FahOw7djsuUKCEMTU+S4YVglkVd+9aU4ns=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NFHQ9X9Z0dlwOaq0sgbJfoNIhAorJHFw8pzkpC5/7MDjDwL+ZPhRaJOJL7jIiC8tgH0S/vGHF/6zpmGW5tFNdwFSYJHx/t3L7LdMg0AujhOKT+IEDijgNlHrS4x/OXSBoEvtEf+13pkoOemP+Q8WP3qROqePAk3UZKuFoWfgCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHSLMlvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0292C4CEF5;
	Tue, 23 Sep 2025 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641541;
	bh=Ech0Y3Z2+FahOw7djsuUKCEMTU+S4YVglkVd+9aU4ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GHSLMlvH0uosxIJgWDv6lK+8YwlFOPA3LKVR344Wf1iAzXdw4rLp1v66Shbv41RDN
	 OI7WN+5f2R3ZlrwwVOrhKanqag20uq8KTaqscVnuaY28VMyMzkuhveQ6lg8feiLjGQ
	 N2TrsCLjiagO4vnGdZZTRHytXFXq4FSBczsIUKy1rCEk6c5W7bWt6wGtZ4/JtUtQDE
	 s8Kc+ul6rWHn/Aogd1b1IAnr8mKoGghEiuPrlZ4cTD2XJcjSbSepRWELfEf0k6hbMI
	 kQFdJhTQNaZSOMui7KCnuKHbyfrIG+h4w6egVP45tFRGwL5i3A29fezCfy0nCUD2aV
	 /Qqgv4FZk6Jzg==
Date: Wed, 24 Sep 2025 00:32:15 +0900
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
Message-Id: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
In-Reply-To: <20250922021531.105670-1-yangfeng59949@163.com>
References: <20250921223037.f8df26b59d60b8b3f7cf2d53@kernel.org>
	<20250922021531.105670-1-yangfeng59949@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 10:15:31 +0800
Feng Yang <yangfeng59949@163.com> wrote:

> On Sun, 21 Sep 2025 22:30:37 +0900 Masami Hiramatsu wrote:
> 
> > On Fri, 19 Sep 2025 19:56:20 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > > On Fri, Sep 19, 2025 at 12:19 AM Feng Yang <yangfeng59949@163.com> wrote:
> > > >
> > > > When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
> > > > I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.
> > > >
> > > > For example:
> > > > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > index 9e1ca8e34913..844fa88cdc4c 100644
> > > > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
> > > >  __u64 kretprobe_test7_result = 0;
> > > >  __u64 kretprobe_test8_result = 0;
> > > >
> > > > +typedef __u64 stack_trace_t[2];
> > > > +
> > > > +struct {
> > > > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > > +       __uint(max_entries, 1024);
> > > > +       __type(key, __u32);
> > > > +       __type(value, stack_trace_t);
> > > > +} stacks SEC(".maps");
> > > > +
> > > >  static void kprobe_multi_check(void *ctx, bool is_return)
> > > >  {
> > > >         if (bpf_get_current_pid_tgid() >> 32 != pid)
> > > > @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
> > > >  SEC("kprobe.multi")
> > > >  int test_kprobe_manual(struct pt_regs *ctx)
> > > >  {
> > > > +       int id = bpf_get_stackid(ctx, &stacks, 0);
> > > 
> > > ftrace_partial_regs() supposed to work on x86 and arm64,
> > > but since multi-kprobe is the only user...
> > 
> > It should be able to unwind stack. It saves sp, pc, lr, fp.
> > 
> > 	regs->sp = afregs->sp;
> > 	regs->pc = afregs->pc;
> > 	regs->regs[29] = afregs->fp;
> > 	regs->regs[30] = afregs->lr;
> > 
> > > I suspect the arm64 implementation wasn't really tested.
> > > Or maybe there is some other issue.
> > 
> > It depends on how bpf_get_stackid() works. Some registers for that
> > function may not be saved.
> > 
> > If it returns -EFAULT, the get_perf_callchain() returns NULL.
> > 
> 
> During my test, the reason for returning -EFAULT was that trace->nr was 0.
> 
> static long __bpf_get_stackid(struct bpf_map *map,
> 			      struct perf_callchain_entry *trace, u64 flags)
> {
> 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
> 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> 	u32 hash, id, trace_nr, trace_len;
> 	bool user = flags & BPF_F_USER_STACK;
> 	u64 *ips;
> 	bool hash_matches;
> 
> 	if (trace->nr <= skip)
> 		/* skipping more than usable stack trace */
> 		return -EFAULT;
> 	......

Hmm. The "trace" is returned from get_perf_callchain()

get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
		   u32 max_stack, bool crosstask, bool add_mark)
{
...

	if (kernel && !user_mode(regs)) {
		if (add_mark)
			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
		perf_callchain_kernel(&ctx, regs);
	}

So this means `perf_callchain_kernel(&ctx, regs);` fails to unwind stack.

perf_callchain_kernel() -> arch_stack_walk() -> kunwind_stack_walk()

That is `kunwind_init_from_regs()` and `do_kunwind()`.

	if (regs) {
		if (task != current)
			return -EINVAL;
		kunwind_init_from_regs(&state, regs);
	} else if (task == current) {
		kunwind_init_from_caller(&state);
	} else {
		kunwind_init_from_task(&state, task);
	}

	return do_kunwind(&state, consume_state, cookie);

For initialization, it should be OK because it only refers pc and 
fp(regs[29]), which are recovered by ftrace_partial_regs().

static __always_inline void
kunwind_init_from_regs(struct kunwind_state *state,
		       struct pt_regs *regs)
{
	kunwind_init(state, current);

	state->regs = regs;
	state->common.fp = regs->regs[29];
	state->common.pc = regs->pc;
	state->source = KUNWIND_SOURCE_REGS_PC;
}

And do_kunwind() should work increase trace->nr before return
unless `kunwind_recover_return_address()` fails.

static __always_inline int
do_kunwind(struct kunwind_state *state, kunwind_consume_fn consume_state,
	   void *cookie)
{
	int ret;

	ret = kunwind_recover_return_address(state);
	if (ret)
		return ret;

	while (1) {
		if (!consume_state(state, cookie)) <--- this increases trace->nr (*).
			return -EINVAL;
		ret = kunwind_next(state);
		if (ret == -ENOENT)
			return 0;
		if (ret < 0)
			return ret;
	}
}

(*) consume_state() == arch_kunwind_consume_entry() 
  ->  data->consume_entry == callchain_trace() -> perf_callchain_store().

Hmm, can you also dump the regs and insert pr_info() to find
which function fails?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

