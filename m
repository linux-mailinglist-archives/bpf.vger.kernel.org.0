Return-Path: <bpf+bounces-69133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5388EB8DBD8
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAFB7ABCB4
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89A2D6E72;
	Sun, 21 Sep 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA4srYKt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1E44A1A;
	Sun, 21 Sep 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461443; cv=none; b=BOtqtFVVmyW59OZNWDB2AfWxdEN2MN0qhomf4N/e/JuTPfCeTkllrjzUaz2YlmvDYYBK5rDm7kDQJGA0Mv/F71M1SY2Pv7vz5qoYmLp0QOZfzKDexfQctgYCFN7rnjb+QzqBMR9NDxyd/2PY0VugT3wGG07Kt7TUA/UpW8xLOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461443; c=relaxed/simple;
	bh=Q5ISgQTInyGMIIkbNRX//rQ9mgpfag4Oxjgh8PZ56WA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lPcc3CyFTUenJS3yFaQGuAbCYF96LTAhPMCETLMbKAGz7997xgikhJgI3bO8XB+/dqOgsAPkm3yHH3SzuVo0UAgKb1VAfXDbmHFM6IaXXOFYkEfTcF6h6jS5NxgfsyXAvIx9kwamngF4YGkq96VXzYkQxsPoJMdEuS10dgXYjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA4srYKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27F1C4CEE7;
	Sun, 21 Sep 2025 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461443;
	bh=Q5ISgQTInyGMIIkbNRX//rQ9mgpfag4Oxjgh8PZ56WA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TA4srYKtvIC+a6CIgbscsuIbC5mhGny/BH/tghF+oXcPmxysgVLwoLJtVlQiTTbi7
	 fsVtBN+vy2wypH6i5KhSlXnjgYJaVgYylkppkz0zdwzxVnGLDub4IzS8Alp3EyiJ/b
	 bzHwb8tc+t6BcpQ1OqxhAeG8YqRPnOyqU2wAOxLyPyatG/J/+phciiEPLJl/096Rl5
	 7xrsgFXzvxU6h9sNJ8rreDtTOgNrtfjLACXAdVgph8YAXncfkr1bJlG8XZiH6q5EeP
	 mJFfsE67SvyFL8ec39WWVZaPX8EBRW8u5q8r7858LZh5MICOA6Hmrgmm3gi/ixh4O2
	 AQIeiFR+ZE5Eg==
Date: Sun, 21 Sep 2025 22:30:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-Id: <20250921223037.f8df26b59d60b8b3f7cf2d53@kernel.org>
In-Reply-To: <CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>
References: <20250919071902.554223-1-yangfeng59949@163.com>
	<CAADnVQKrnYCaUCd+BNvZQmR0-6CSu2GBa=TCCCjPLSNfb_Ddvg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 19 Sep 2025 19:56:20 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Sep 19, 2025 at 12:19 AM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
> > I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.
> >
> > For example:
> > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > index 9e1ca8e34913..844fa88cdc4c 100644
> > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > @@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
> >  __u64 kretprobe_test7_result = 0;
> >  __u64 kretprobe_test8_result = 0;
> >
> > +typedef __u64 stack_trace_t[2];
> > +
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +       __uint(max_entries, 1024);
> > +       __type(key, __u32);
> > +       __type(value, stack_trace_t);
> > +} stacks SEC(".maps");
> > +
> >  static void kprobe_multi_check(void *ctx, bool is_return)
> >  {
> >         if (bpf_get_current_pid_tgid() >> 32 != pid)
> > @@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
> >  SEC("kprobe.multi")
> >  int test_kprobe_manual(struct pt_regs *ctx)
> >  {
> > +       int id = bpf_get_stackid(ctx, &stacks, 0);
> 
> ftrace_partial_regs() supposed to work on x86 and arm64,
> but since multi-kprobe is the only user...

It should be able to unwind stack. It saves sp, pc, lr, fp.

	regs->sp = afregs->sp;
	regs->pc = afregs->pc;
	regs->regs[29] = afregs->fp;
	regs->regs[30] = afregs->lr;

> I suspect the arm64 implementation wasn't really tested.
> Or maybe there is some other issue.

It depends on how bpf_get_stackid() works. Some registers for that
function may not be saved.

If it returns -EFAULT, the get_perf_callchain() returns NULL.

struct perf_callchain_entry *
get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
		   u32 max_stack, bool crosstask, bool add_mark)
{
...
	entry = get_callchain_entry(&rctx);
	if (!entry)
		return NULL;


Thus the `get_callchain_entry(&rctx)` returns NULL. But if so,
this does not related to the ftrace_partial_regs(), because
get_callchain_entry() returns the per-cpu callchain woarking
buffer for the context, not decoding stack.

struct perf_callchain_entry *get_callchain_entry(int *rctx)
{
	int cpu;
	struct callchain_cpus_entries *entries;

	*rctx = get_recursion_context(this_cpu_ptr(callchain_recursion));
	if (*rctx == -1)
		return NULL;

	entries = rcu_dereference(callchain_cpus_entries);
	if (!entries) {
		put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
		return NULL;
	}

	cpu = smp_processor_id();

	return (((void *)entries->cpu_entries[cpu]) +
		(*rctx * perf_callchain_entry__sizeof()));
}

What context does BPF expect, and how does it detect?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

