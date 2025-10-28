Return-Path: <bpf+bounces-72487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 095B7C12CD6
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 04:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62871354572
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 03:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B198283FE5;
	Tue, 28 Oct 2025 03:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Veshu2V1"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B0273D81
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623151; cv=none; b=fzkrondxAWyPQEimbaL6v+7Y5INAHqZU1Oh1Xz2Ff61p4rA22Gy/nOUnbmz+VfK1cVc0ATA0Y6yDxYaCgKp5M1XxPLfLVc3r/QsyGzS64KbaRuh6GX2MkhFxTI5zboEemyi92fOwDHaQsViiQgH7FxO5HjrMsJ30A5mG+vA5PIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623151; c=relaxed/simple;
	bh=8X7+djckz8qvZbXGeuo8MkGK5Q5O+A+menBRyrcAjwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVber9DgFvM3FxXKsyJTyHI2amX/agZ2FRzgwoFYMgO8+fYBbIcrTgj8jugf0SfW72q52LB1VjUI23UVk34A3/O1mXH4XV5aiy+EZv5mwarEsH9tzlEBg+MLibnR2IXQQJiDl0wBUJKyl5t3/3jZBugbqF+x25ACfx4vw1T4JVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Veshu2V1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95e1fd95-896f-4d33-956f-a0ef0e0f152c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761623134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5Pi/MoPJGYSa9PpvlvLW9NetB22nOP2t8J0Mto24cA=;
	b=Veshu2V13TCLK5s+B3ZXjCM8uceV/g1f/j+0l+NnK5T9gkf0TDbWnmudXhc3DuQgMNS35F
	DsmDAqzvIDt/1WNgT0qytf/+/DneTnS2hywHWwnrGkgfREqpfRg3hHLKlPgesCbKGvlYlJ
	iodJ8n/iByyGx3TY6FfVB4SOV2zlzNg=
Date: Mon, 27 Oct 2025 20:45:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
Content-Language: en-GB
To: Sahil Chandna <chandna.sahil@gmail.com>
Cc: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 listout@listout.xyz, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 linux-rt-devel@lists.linux.dev, bigeasy@linutronix.de
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
 <aPklOxw0W-xUbMEI@chandna.localdomain>
 <8dd359dd-b42f-4676-bb94-07288b38fac1@linux.dev>
 <aP5_JbddrpnDs-WN@chandna.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aP5_JbddrpnDs-WN@chandna.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/26/25 1:05 PM, Sahil Chandna wrote:
> On Wed, Oct 22, 2025 at 12:56:25PM -0700, Yonghong Song wrote:
>>
>>
>> On 10/22/25 11:40 AM, Sahil Chandna wrote:
>>> On Wed, Oct 22, 2025 at 09:57:22AM -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 10/20/25 2:08 PM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 
>>>>> 'off' as d..
>>>>> git tree:       bpf
>>>>> console output: 
>>>>> https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
>>>>> kernel config: 
>>>>> https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
>>>>> dashboard link: 
>>>>> https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
>>>>> compiler:       Debian clang version 20.1.8 
>>>>> (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian 
>>>>> LLD 20.1.8
>>>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
>>>>> C reproducer: 
>>>>> https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000
>>>>>
>>>>> Downloadable assets:
>>>>> disk image: 
>>>>> https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
>>>>> vmlinux: 
>>>>> https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
>>>>> kernel image: 
>>>>> https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz
>>>>>
>>>>> The issue was bisected to:
>>>>>
>>>>> commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
>>>>> Author: Sahil Chandna <chandna.sahil@gmail.com>
>>>>> Date:   Tue Oct 14 18:56:35 2025 +0000
>>>>>
>>>>>     bpf: Do not disable preemption in bpf_test_run().
>>>>>
>>>>> bisection log: 
>>>>> https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
>>>>> final oops: 
>>>>> https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
>>>>> console output: 
>>>>> https://syzkaller.appspot.com/x/log.txt?x=10afe492580000
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to 
>>>>> the commit:
>>>>> Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
>>>>> Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in 
>>>>> bpf_test_run().")
>>>>>
>>>>> ------------[ cut here ]------------
>>>>> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>>>> bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>>>> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>>>> bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>>>>
>>>> Okay, the warning is due to the following WARN_ON_ONCE:
>>>>
>>>> static DEFINE_PER_CPU(struct 
>>>> bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
>>>> static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>>>>
>>>> int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>>>> {
>>>>        int nest_level;
>>>>
>>>>        nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>>>>        if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>>>>                this_cpu_dec(bpf_bprintf_nest_level);
>>>>                return -EBUSY;
>>>>        }
>>>>        *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>>>>
>>>>        return 0;
>>>> }
>>>>
>>>> Basically without preempt disable, at process level, it is possible
>>>> more than one process may trying to take bpf_bprintf_buffers.
>>>> Adding softirq and nmi, it is totally likely to have more than 3
>>>> level for buffers. Also, more than one process with 
>>>> bpf_bprintf_buffers
>>>> will cause problem in releasing buffers, so we need to have
>>>> preempt_disable surrounding bpf_try_get_buffers() and
>>>> bpf_put_buffers().
>>> Right, but using preempt_disable() may impact builds with
>>> CONFIG_PREEMPT_RT=y, similar to bug[1]? Do you think local_lock() 
>>> could be used here
>>
>> We should be okay. for all the kfuncs/helpers I mentioned below,
>> with the help of AI, I didn't find any spin_lock in the code path
>> and all these helpers although they try to *print* some contents,
>> but the kfuncs/helpers itself is only to deal with buffers and
>> actual print will happen asynchronously.
>>
>>> as nest level is per cpu variable and local lock semantics can work
>>> for both RT and non rt builds ?
>>
>> I am not sure about local_lock() in RT as for RT, local_lock() could
>> be nested and the release may not in proper order. See
>>  https://www.kernel.org/doc/html/v5.8/locking/locktypes.html
>>
>>  local_lock is not suitable to protect against preemption or 
>> interrupts on a
>>  PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
>>
>> So I suggest to stick to preempt_disable/enable approach.
>>
>>>>
>>>> There are some kfuncs/helpers need such preempt_disable
>>>> protection, e.g. bpf_stream_printk, bpf_snprintf,
>>>> bpf_trace_printk, bpf_trace_vprintk, bpf_seq_printf.
>>>> But please double check.
>>>>
>>> Sure, thanks!
>
> Since these helpers eventually call bpf_bprintf_prepare(),
> I figured adding protection around bpf_try_get_buffers(),
> which triggers the original warning, should be sufficient.
> I tried a few approaches to address the warning as below :
>
> 1. preempt_disable() / preempt_enable() around bpf_prog_run_pin_on_cpu()
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 1b61bb25ba0e..6a128179a26f 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1021,7 +1021,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, 
> struct bpf_flow_dissector *ctx,
>                (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
>       flow_keys->flags = flags;
>
> +    preempt_disable();
>       result = bpf_prog_run_pin_on_cpu(prog, ctx);
> +    preempt_enable();
>
>       flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
>       flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
> This fixes the original WARN_ON in both PREEMPT_FULL and RT builds.
> However, when tested with the syz reproducer of the original bug [1], it
> still triggers the expected 
> DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt)) warning from 
> __local_bh_disable_ip(), due to the preempt_disable() interacting with 
> RT spinlock semantics.
> [1] 
> [https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8](https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8)
> So this approach avoids the buffer nesting issue, but re-introduces 
> the following issue:
> [  363.968103][T21257] 
> DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
> [  363.968922][T21257] WARNING: CPU: 0 PID: 21257 at 
> kernel/softirq.c:176 __local_bh_disable_ip+0x3d9/0x540
> [  363.969046][T21257] Modules linked in:
> [  363.969176][T21257] Call Trace:
> [  363.969181][T21257]  <TASK>
> [  363.969186][T21257]  ? __local_bh_disable_ip+0xa1/0x540
> [  363.969197][T21257]  ? sock_map_delete_elem+0xa2/0x170
> [  363.969209][T21257]  ? preempt_schedule_common+0x83/0xd0
> [  363.969252][T21257]  ? rt_spin_unlock+0x161/0x200
> [  363.969269][T21257]  sock_map_delete_elem+0xaf/0x170
> [  363.969280][T21257]  bpf_prog_464bc2be3fc7c272+0x43/0x47
> [  363.969289][T21257]  bpf_flow_dissect+0x22b/0x750
> [  363.969299][T21257] bpf_prog_test_run_flow_dissector+0x37c/0x5c0
>
> 2. preempt_disable() inside bpf_try_get_buffers() and bpf_put_buffers()
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8eb117c52817..bc8630833a94 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -777,12 +777,14 @@ int bpf_try_get_buffers(struct 
> bpf_bprintf_buffers **bufs)
>  {
>         int nest_level;
>
> +       preempt_disable();
>         nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>         if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>                 this_cpu_dec(bpf_bprintf_nest_level);
>                 return -EBUSY;
>         }
>         *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
> +       preempt_enable();
>
>         return 0;
>  }
> @@ -791,7 +793,10 @@ void bpf_put_buffers(void)
>  {
>         if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
>                 return;
> +
> +       preempt_disable();
>         this_cpu_dec(bpf_bprintf_nest_level);
> +       preempt_enable();
>  }
> This *still* reproduces the original syz issue, so the protection 
> needs to be placed around the entire program run, not inside the 
> helper itself as
> in above experiment.

This does not work. See my earlier suggestions.

> Basically without preempt disable, at process level, it is possible
> more than one process may trying to take bpf_bprintf_buffers.
> Adding softirq and nmi, it is totally likely to have more than 3
> level for buffers. Also, more than one process with bpf_bprintf_buffers
> will cause problem in releasing buffers, so we need to have
> preempt_disable surrounding bpf_try_get_buffers() and
> bpf_put_buffers().

That is,
   preempt_disable();
   ...
   bpf_try_get_buffers()
   ...
   bpf_put_buffers()
   ...
   preempt_enable();

>
> 3. Using a per-CPU local_lock
> Finally, I tested with a per-CPU local_lock around 
> bpf_prog_run_pin_on_cpu():
> +struct bpf_cpu_lock {
> +    local_lock_t lock;
> +};
> +
> +static DEFINE_PER_CPU(struct bpf_cpu_lock, bpf_cpu_lock) = {
> +    .lock = INIT_LOCAL_LOCK(),
> +};
> @@ -1021,7 +1030,9 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, 
> struct bpf_flow_dissector *ctx,
>                      (int)FLOW_DISSECTOR_F_STOP_AT_ENCAP);
>         flow_keys->flags = flags;
>
> +       local_lock(&bpf_cpu_lock.lock);
>         result = bpf_prog_run_pin_on_cpu(prog, ctx);
> +       local_unlock(&bpf_cpu_lock.lock);
>
> This approach avoid the warning on both RT and non-RT builds, with 
> both the syz reproducer. The intention of introducing the per-CPU 
> local_lock is to maintain consistent per-CPU execution semantics 
> between RT and non-RT kernels.
> On non-RT builds, local_lock maps to preempt_disable()/enable(),
> which provides the same semantics as before.
> On RT builds, it maps to an RT-safe per-CPU spinlock, avoiding the
> softirq_ctrl.cnt issue.

This should work, but local lock disable interrupts which could have
negative side effects on the system. We don't want this.
That is the reason we have 3 nested level for bpf_bprintf_buffers.

Please try my above preempt_disalbe/enable() solution.

>
> Let me know if you’d like me to run some more experiments on this.


