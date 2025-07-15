Return-Path: <bpf+bounces-63306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73185B05515
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0788A3BC57F
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 08:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA5275B03;
	Tue, 15 Jul 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jCdduS/7"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFB221DB6
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568682; cv=none; b=QtBUjcu4nCKjkPzGJgmWd+qix+NhBQmZ+Jw5LNOvSEjK1t+OtYt+l+94N9hA/8xJk5GdJb3nlugQUFK80gKN6Xe6H332tS1IAi2iVczeaLcneKBv12CfdVj7v94KuKVQbve9V/4Efvqeodskzb5hcn7Xn9YBFsiRuaxHXlHRaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568682; c=relaxed/simple;
	bh=mZyth0KAKTnj9bWStu7byGf00CvZnmNGrZOK9z+tomQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOc7kDtVEDcaNXZlXJM+o1J1CbBRrK+SYCEzZCe2OsTdFhzPIa02fkaQlMykTsaAzA2/fYWDupdeCh8JmuVpBt8WWC1Ty4q5nbzV1m+kl8MgbMyijPYN2OgJEpQC/byZRakUmbd46oiDCb8T5iZt06OdvA8+GbJTAJ4gngPRhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jCdduS/7; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752568678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9Lgw5Epi5q68OgMPe5vaeUcIOYa33Zgw7pDEgowN70=;
	b=jCdduS/7l5FQ3NkNe7K57fsRxYJUWB/+rdPgFX59M4ZRZv0kGyqgTy+5AM1W5usbFzHvNX
	gMUPMErWKKR+XYJnNAZ/uUlNZpUC9TFXIYdVXgtjFByZDAFSCZVy0oWyyekc1I6oaMJdCu
	JjgHNbaJmrNjE3R00htnO3a0yS7YlzM=
Date: Tue, 15 Jul 2025 16:36:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for
 global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, Menglong Dong <dongml2@chinatelecom.cn>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn>
 <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/15/25 10:25, Alexei Starovoitov wrote:
> On Thu, Jul 3, 2025 at 5:17 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>> +static __always_inline void
>> +do_origin_call(unsigned long *args, unsigned long *ip, int nr_args)
>> +{
>> +       /* Following code will be optimized by the compiler, as nr_args
>> +        * is a const, and there will be no condition here.
>> +        */
>> +       if (nr_args == 0) {
>> +               asm volatile(
>> +                       RESTORE_ORIGIN_0 CALL_NOSPEC "\n"
>> +                       "movq %%rax, %0\n"
>> +                       : "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
>> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
>> +                       :
>> +               );
>> +       } else if (nr_args == 1) {
>> +               asm volatile(
>> +                       RESTORE_ORIGIN_1 CALL_NOSPEC "\n"
>> +                       "movq %%rax, %0\n"
>> +                       : "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
>> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
>> +                       : "rdi"
>> +               );
>> +       } else if (nr_args == 2) {
>> +               asm volatile(
>> +                       RESTORE_ORIGIN_2 CALL_NOSPEC "\n"
>> +                       "movq %%rax, %0\n"
>> +                       : "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
>> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
>> +                       : "rdi", "rsi"
>> +               );
>> +       } else if (nr_args == 3) {
>> +               asm volatile(
>> +                       RESTORE_ORIGIN_3 CALL_NOSPEC "\n"
>> +                       "movq %%rax, %0\n"
>> +                       : "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
>> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
>> +                       : "rdi", "rsi", "rdx"
>> +               );
>> +       } else if (nr_args == 4) {
>> +               asm volatile(
>> +                       RESTORE_ORIGIN_4 CALL_NOSPEC "\n"
>> +                       "movq %%rax, %0\n"
>> +                       : "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
>> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
>> +                       : "rdi", "rsi", "rdx", "rcx"
>> +               );
>> +       } else if (nr_args == 5) {
>> +               asm volatile(
>> +                       RESTORE_ORIGIN_5 CALL_NOSPEC "\n"
>> +                       "movq %%rax, %0\n"
>> +                       : "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
>> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
>> +                       : "rdi", "rsi", "rdx", "rcx", "r8"
>> +               );
>> +       } else if (nr_args == 6) {
>> +               asm volatile(
>> +                       RESTORE_ORIGIN_6 CALL_NOSPEC "\n"
>> +                       "movq %%rax, %0\n"
>> +                       : "=m"(args[nr_args]), ASM_CALL_CONSTRAINT
>> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
>> +                       : "rdi", "rsi", "rdx", "rcx", "r8", "r9"
>> +               );
>> +       }
>> +}
> What is the performance difference between 0-6 variants?
> I would think save/restore of regs shouldn't be that expensive.
> bpf trampoline saves only what's necessary because it can do
> this micro optimization, but for this one, I think, doing
> _one_ global trampoline that covers all cases will simplify the code
> a lot, but please benchmark the difference to understand
> the trade-off.

According to my benchmark, it has ~5% overhead to save/restore
*5* variants when compared with *0* variant. The save/restore of regs
is fast, but it still need 12 insn, which can produce ~6% overhead.

I think the performance is more import and we should keep this logic.
Should we? If you think the do_origin_call() is not simple enough, we
can recover all the 6 regs from the stack directly for the origin call, 
which won't
introduce too much overhead, and keep the save/restore logic.

What do you think?


>
> The major simplification will be due to skipping nr_args.
> There won't be a need to do btf model and count the args.
> Just do one trampoline for them all.
>
> Also funcs with 7+ arguments need to be thought through
> from the start.


In the current version, the attachment will be rejected if any functions 
have
7+ arguments.


> I think it's ok trade-off if we allow global trampoline
> to be safe to attach to a function with 7+ args (and
> it will not mess with the stack), but bpf prog can only
> access up to 6 args. The kfuncs to access arg 7 might be
> more complex and slower. It's ok trade off.


It's OK for fentry-multi, but we can't allow fexit-multi and 
modify_return-multi
to be attached to the function with 7+ args, as we need to do the origin
call, and we can't recover the arguments in the stack for the origin 
call for now.

So we can allow the functions with 7+ args to be attached as long as the 
accessed
arguments are all in regs for fentry-multi. And I think we need one more 
patch to
do the "all accessed arguments are in regs" checking, so maybe we can 
put it in
the next series? As current series is a little complex :/

Anyway, I'll have a try to see if we can add this part in this series :)


>
>> +
>> +static __always_inline notrace void
>> +run_tramp_prog(struct kfunc_md_tramp_prog *tramp_prog,
>> +              struct bpf_tramp_run_ctx *run_ctx, unsigned long *args)
>> +{
>> +       struct bpf_prog *prog;
>> +       u64 start_time;
>> +
>> +       while (tramp_prog) {
>> +               prog = tramp_prog->prog;
>> +               run_ctx->bpf_cookie = tramp_prog->cookie;
>> +               start_time = bpf_gtramp_enter(prog, run_ctx);
>> +
>> +               if (likely(start_time)) {
>> +                       asm volatile(
>> +                               CALL_NOSPEC "\n"
>> +                               : : [thunk_target]"r"(prog->bpf_func), [args]"D"(args)
>> +                       );
> Why this cannot be "call *(prog->bpf_func)" ?

Do you mean "prog->bpf_func(args, NULL);"? In my previous testing, this 
cause
bad performance, and I see others do the indirect call in this way. And 
I just do
the benchmark again, it seems the performance is not affected in this 
way anymore.
So I think I can replace it with "prog->bpf_func(args, NULL);" in the 
next version.

>
>> +               }
>> +
>> +               bpf_gtramp_exit(prog, start_time, run_ctx);
>> +               tramp_prog = tramp_prog->next;
>> +       }
>> +}
>> +
>> +static __always_inline notrace int
>> +bpf_global_caller_run(unsigned long *args, unsigned long *ip, int nr_args)
> Pls share top 10 from "perf report" while running the bench.
> I'm curious about what's hot.
> Last time I benchmarked fentry/fexit migrate_disable/enable were
> one the hottest functions. I suspect it's the case here as well.


You are right, the migrate_disable/enable are the hottest functions in
both bpf trampoline and global trampoline. Following is the perf top
for fentry-multi:
36.36% bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi [k] 
bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi 20.54% [kernel] [k] 
migrate_enable 19.35% [kernel] [k] bpf_global_caller_5_run 6.52% 
[kernel] [k] bpf_global_caller_5 3.58% libc.so.6 [.] syscall 2.88% 
[kernel] [k] entry_SYSCALL_64 1.50% [kernel] [k] memchr_inv 1.39% 
[kernel] [k] fput 1.04% [kernel] [k] migrate_disable 0.91% [kernel] [k] 
_copy_to_user

And I also did the testing for fentry:

54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k] 
bpf_prog_2dcccf652aac1793_bench_trigger_fentry
10.43% [kernel] [k] migrate_enable
10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
8.06% [kernel] [k] __bpf_prog_exit_recur 4.11% libc.so.6 [.] syscall 
2.15% [kernel] [k] entry_SYSCALL_64 1.48% [kernel] [k] memchr_inv 1.32% 
[kernel] [k] fput 1.16% [kernel] [k] _copy_to_user 0.73% [kernel] [k] 
bpf_prog_test_run_raw_tp
The migrate_enable/disable are used to do the recursive checking,
and I even wanted to perform recursive checks in the same way as
ftrace to eliminate this overhead :/


>

