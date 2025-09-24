Return-Path: <bpf+bounces-69509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB86EB98602
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E2C7A5161
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 06:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979072405F8;
	Wed, 24 Sep 2025 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jl+RxqI2"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D31C4A17;
	Wed, 24 Sep 2025 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695202; cv=none; b=jIKQ9RGFK0goUPNneOZX8xec8JYR4mXhoExodcnovaFyTDdXrXG2nKeTFwE9LpozJ8D7mjQyBZh7PVY7IIAT7MbOLUjhS6tboDiKdBvZ/nf275S3VrT1h+y5XkPFNNpHAblGj/Bym45JsKCrT4pzH3HUrrKPSZcGYtXVAiWanks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695202; c=relaxed/simple;
	bh=oePUICDiPVKN9B/TKw8so6b3+qv38ospFzPDbOaKvsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cM4+xn5/fatX4H0wHdeijgbbiUBYS5mXuFG6BgS1Gqb4AlDy9uOyc+JkSldNtF7pngAxw8A6IC3ToP5c6kJDTnLT9iobQER87hBp30EiEMY+aZ1pTKQhNrh0KFN43fedTXP5ntaYwp636x9GbYVYv1Aosmk7ytvaLdFsgQmnHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jl+RxqI2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=oZ
	d4WpX2+1Jdxq+9g1RYCBdLuAcNtaFiBB36fTsymVk=; b=jl+RxqI2Nnd+2JBT58
	Idh2LEuqdwVrMCciEsHTAr8ic3pmlxAr62skYcqlHi5eaTDf9ukNi0/+9oRc7yZb
	jgdAUhSiQYYTgoTwEZHoch+uxwhQcTE0oqpua3nDXl4LHTbokLi2xbsAB5x1WMfa
	IC2u3ilZ9/JcghYYm7Xf42TxQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnhx_hjtNowN2fEA--.57610S2;
	Wed, 24 Sep 2025 14:25:38 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: mhiramat@kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64 architecture
Date: Wed, 24 Sep 2025 14:25:36 +0800
Message-Id: <20250924062536.471231-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
References: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnhx_hjtNowN2fEA--.57610S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArW8CF4xXr43KF13WF15Arb_yoWxAF43pF
	WDA3WakFZ0qrWjqwnFqw15XF9akws3ZryUuryrGw13CFnFvFy3Jr9rKFya9rn8Ar4qgw1a
	vF42yasxK3y5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRzWlhUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTgzReGjStyW8TwABsx

On Wed, 24 Sep 2025 00:32:15 +0900 Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 22 Sep 2025 10:15:31 +0800
> Feng Yang <yangfeng59949@163.com> wrote:
> 
> > On Sun, 21 Sep 2025 22:30:37 +0900 Masami Hiramatsu wrote:
> > 
> > > On Fri, 19 Sep 2025 19:56:20 -0700
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > 
> > > > On Fri, Sep 19, 2025 at 12:19 AM Feng Yang <yangfeng59949@163.com> wrote:
> > > > >
> > > > > When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
> > > > > I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.
> > > > >
> > > > > For example:
> > > > > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > > index 9e1ca8e34913..844fa88cdc4c 100644
> > > > > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > > > > @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
> > > > >  __u64 kretprobe_test7_result = 0;
> > > > >  __u64 kretprobe_test8_result = 0;
> > > > >
> > > > > +typedef __u64 stack_trace_t[2];
> > > > > +
> > > > > +struct {
> > > > > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > > > +       __uint(max_entries, 1024);
> > > > > +       __type(key, __u32);
> > > > > +       __type(value, stack_trace_t);
> > > > > +} stacks SEC(".maps");
> > > > > +
> > > > >  static void kprobe_multi_check(void *ctx, bool is_return)
> > > > >  {
> > > > >         if (bpf_get_current_pid_tgid() >> 32 != pid)
> > > > > @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
> > > > >  SEC("kprobe.multi")
> > > > >  int test_kprobe_manual(struct pt_regs *ctx)
> > > > >  {
> > > > > +       int id = bpf_get_stackid(ctx, &stacks, 0);
> > > > 
> > > > ftrace_partial_regs() supposed to work on x86 and arm64,
> > > > but since multi-kprobe is the only user...
> > > 
> > > It should be able to unwind stack. It saves sp, pc, lr, fp.
> > > 
> > > 	regs->sp = afregs->sp;
> > > 	regs->pc = afregs->pc;
> > > 	regs->regs[29] = afregs->fp;
> > > 	regs->regs[30] = afregs->lr;
> > > 
> > > > I suspect the arm64 implementation wasn't really tested.
> > > > Or maybe there is some other issue.
> > > 
> > > It depends on how bpf_get_stackid() works. Some registers for that
> > > function may not be saved.
> > > 
> > > If it returns -EFAULT, the get_perf_callchain() returns NULL.
> > > 
> > 
> > During my test, the reason for returning -EFAULT was that trace->nr was 0.
> > 
> > static long __bpf_get_stackid(struct bpf_map *map,
> > 			      struct perf_callchain_entry *trace, u64 flags)
> > {
> > 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
> > 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> > 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> > 	u32 hash, id, trace_nr, trace_len;
> > 	bool user = flags & BPF_F_USER_STACK;
> > 	u64 *ips;
> > 	bool hash_matches;
> > 
> > 	if (trace->nr <= skip)
> > 		/* skipping more than usable stack trace */
> > 		return -EFAULT;
> > 	......
> 
> Hmm. The "trace" is returned from get_perf_callchain()
> 
> get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> 		   u32 max_stack, bool crosstask, bool add_mark)
> {
> ...
> 
> 	if (kernel && !user_mode(regs)) {
> 		if (add_mark)
> 			perf_callchain_store_context(&ctx, PERF_CONTEXT_KERNEL);
> 		perf_callchain_kernel(&ctx, regs);
> 	}
> 
> So this means `perf_callchain_kernel(&ctx, regs);` fails to unwind stack.
> 
> perf_callchain_kernel() -> arch_stack_walk() -> kunwind_stack_walk()
> 
> That is `kunwind_init_from_regs()` and `do_kunwind()`.
> 
> 	if (regs) {
> 		if (task != current)
> 			return -EINVAL;
> 		kunwind_init_from_regs(&state, regs);
> 	} else if (task == current) {
> 		kunwind_init_from_caller(&state);
> 	} else {
> 		kunwind_init_from_task(&state, task);
> 	}
> 
> 	return do_kunwind(&state, consume_state, cookie);
> 
> For initialization, it should be OK because it only refers pc and 
> fp(regs[29]), which are recovered by ftrace_partial_regs().
> 
> static __always_inline void
> kunwind_init_from_regs(struct kunwind_state *state,
> 		       struct pt_regs *regs)
> {
> 	kunwind_init(state, current);
> 
> 	state->regs = regs;
> 	state->common.fp = regs->regs[29];
> 	state->common.pc = regs->pc;
> 	state->source = KUNWIND_SOURCE_REGS_PC;
> }
> 
> And do_kunwind() should work increase trace->nr before return
> unless `kunwind_recover_return_address()` fails.
> 
> static __always_inline int
> do_kunwind(struct kunwind_state *state, kunwind_consume_fn consume_state,
> 	   void *cookie)
> {
> 	int ret;
> 
> 	ret = kunwind_recover_return_address(state);
> 	if (ret)
> 		return ret;
> 
> 	while (1) {
> 		if (!consume_state(state, cookie)) <--- this increases trace->nr (*).
> 			return -EINVAL;
> 		ret = kunwind_next(state);
> 		if (ret == -ENOENT)
> 			return 0;
> 		if (ret < 0)
> 			return ret;
> 	}
> }
> 
> (*) consume_state() == arch_kunwind_consume_entry() 
>   ->  data->consume_entry == callchain_trace() -> perf_callchain_store().
> 
> Hmm, can you also dump the regs and insert pr_info() to find
> which function fails?
> 
> Thanks,
> 

After testing, it was found that the stack could not be obtained because user_mode(regs) returned 1. 
Referring to the arch_ftrace_fill_perf_regs function in your email 
(https://lore.kernel.org/all/173518997908.391279.15910334347345106424.stgit@devnote2/), 
I made the following modification: by setting the value of pstate, the stack can now be obtained successfully.

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 058a99aa44bd..f2814175e958 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -159,11 +159,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 {
        struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
 
        memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
        regs->sp = afregs->sp;
        regs->pc = afregs->pc;
        regs->regs[29] = afregs->fp;
        regs->regs[30] = afregs->lr;
+       regs->pstate = PSR_MODE_EL1h;
        return regs;
 }
However, I'm not sure if there will be any other impacts...

By the way, during my testing, I also noticed that when executing bpf_get_stackid via kprobes or tracepoints, 
the command bpftrace -e 'kprobe:bpf_get_stackid {printf("bpf_get_stackid\n");}' produces no output. 
However, it does output something when bpf_get_stackid is invoked via uprobes. 
This phenomenon also occurs on the x86 architecture, could this be a bug as well?

Thanks.


