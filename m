Return-Path: <bpf+bounces-71844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC27BFE1AF
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA53A86BA
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA123956E;
	Wed, 22 Oct 2025 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NoLmdSrz"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890A2F6196
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162998; cv=none; b=tvJ7z0lkYfgZn94w9cfmW3qV+pdVTExPVO7mhdiIbaHWNmQaVBr+DGlDoUI4dVrrdBhk6FRsQmQb3z0RoTl5pSXj2YZlRaxKtZLglu9GbtDzvrSlv+BPZBeO6JSJpqGq1+KYWBNJbxh04AQ6UVMEzup3ea8Gz393fj8k2IGFZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162998; c=relaxed/simple;
	bh=1GuJypFY3U8HZFc+Y/aGefdRN+ep6nTV9BdU34r4IXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/w30jjfp5a6y8Sw0Rt5mAurxg9HktvnEXUNzHW0Iwx9B1Ff5J46tR0ZUZw7CL2TuxV/TcIYWA6rwgnYQS7DTvhLzI6khKcp5Np4JaovjtVEoDp4wn5j1ARX8WZNsLuP/lIWefRb2uwc5DKrB620JjBUx9CPmojxOirYdQECpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NoLmdSrz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8dd359dd-b42f-4676-bb94-07288b38fac1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761162992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqMrf9bWK7TefNRahQICEamcely7O6Du2BG+tENIHMk=;
	b=NoLmdSrzB5YviWqUWK2GpNeHv7p5bMl2HGH4nksVEQCViScKD9mrli2Fdt5+t/ssxesYLW
	CCKj6dGKio70VkHdIJ0+mid5MxavO6Vh4s7csCDrO6KqaaaBmt2kvSL/MVqLOOSIrlRKqV
	JdtAyoMv1eLsz+izRuM0K8W7vhd3KTA=
Date: Wed, 22 Oct 2025 12:56:25 -0700
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
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com
References: <68f6a4c8.050a0220.1be48.0011.GAE@google.com>
 <14371cf8-e49a-4c68-b763-fa7563a9c764@linux.dev>
 <aPklOxw0W-xUbMEI@chandna.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aPklOxw0W-xUbMEI@chandna.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/22/25 11:40 AM, Sahil Chandna wrote:
> On Wed, Oct 22, 2025 at 09:57:22AM -0700, Yonghong Song wrote:
>>
>>
>> On 10/20/25 2:08 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    a1e83d4c0361 selftests/bpf: Fix redefinition of 
>>> 'off' as d..
>>> git tree:       bpf
>>> console output: 
>>> https://syzkaller.appspot.com/x/log.txt?x=12d21de2580000
>>> kernel config: 
>>> https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
>>> dashboard link: 
>>> https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
>>> compiler:       Debian clang version 20.1.8 
>>> (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian 
>>> LLD 20.1.8
>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=160cf542580000
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=128d5c58580000
>>>
>>> Downloadable assets:
>>> disk image: 
>>> https://storage.googleapis.com/syzbot-assets/2f6a7a0cd1b7/disk-a1e83d4c.raw.xz
>>> vmlinux: 
>>> https://storage.googleapis.com/syzbot-assets/873984cfc71e/vmlinux-a1e83d4c.xz
>>> kernel image: 
>>> https://storage.googleapis.com/syzbot-assets/16711d84070c/bzImage-a1e83d4c.xz
>>>
>>> The issue was bisected to:
>>>
>>> commit 7c33e97a6ef5d84e98b892c3e00c6d1678d20395
>>> Author: Sahil Chandna <chandna.sahil@gmail.com>
>>> Date:   Tue Oct 14 18:56:35 2025 +0000
>>>
>>>     bpf: Do not disable preemption in bpf_test_run().
>>>
>>> bisection log: 
>>> https://syzkaller.appspot.com/x/bisect.txt?x=172fe492580000
>>> final oops: https://syzkaller.appspot.com/x/report.txt?x=14afe492580000
>>> console output: 
>>> https://syzkaller.appspot.com/x/log.txt?x=10afe492580000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the 
>>> commit:
>>> Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
>>> Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in 
>>> bpf_test_run().")
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>> bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>> WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 
>>> bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>>
>> Okay, the warning is due to the following WARN_ON_ONCE:
>>
>> static DEFINE_PER_CPU(struct 
>> bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
>> static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
>>
>> int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>> {
>>        int nest_level;
>>
>>        nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>>        if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>>                this_cpu_dec(bpf_bprintf_nest_level);
>>                return -EBUSY;
>>        }
>>        *bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
>>
>>        return 0;
>> }
>>
>> Basically without preempt disable, at process level, it is possible
>> more than one process may trying to take bpf_bprintf_buffers.
>> Adding softirq and nmi, it is totally likely to have more than 3
>> level for buffers. Also, more than one process with bpf_bprintf_buffers
>> will cause problem in releasing buffers, so we need to have
>> preempt_disable surrounding bpf_try_get_buffers() and
>> bpf_put_buffers().
> Right, but using preempt_disable() may impact builds with
> CONFIG_PREEMPT_RT=y, similar to bug[1]? Do you think local_lock() 
> could be used here

We should be okay. for all the kfuncs/helpers I mentioned below,
with the help of AI, I didn't find any spin_lock in the code path
and all these helpers although they try to *print* some contents,
but the kfuncs/helpers itself is only to deal with buffers and
actual print will happen asynchronously.

> as nest level is per cpu variable and local lock semantics can work
> for both RT and non rt builds ?

I am not sure about local_lock() in RT as for RT, local_lock() could
be nested and the release may not in proper order. See
   https://www.kernel.org/doc/html/v5.8/locking/locktypes.html

   local_lock is not suitable to protect against preemption or interrupts on a
   PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.

So I suggest to stick to preempt_disable/enable approach.

>>
>> There are some kfuncs/helpers need such preempt_disable
>> protection, e.g. bpf_stream_printk, bpf_snprintf,
>> bpf_trace_printk, bpf_trace_vprintk, bpf_seq_printf.
>> But please double check.
>>
> Sure, thanks!
>>
> [1] https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
>>> Modules linked in:
>>> CPU: 1 UID: 0 PID: 6145 Comm: syz.4.53 Not tainted syzkaller #0 
>>> PREEMPT(full)
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, 
>>> BIOS Google 10/02/2025
>>> RIP: 0010:bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
>>> RIP: 0010:bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834
>>> Code: ff e9 ce fe ff ff e8 10 ec e0 ff e9 be fe ff ff e8 06 ec e0 ff 
>>> e9 b4 fe ff ff e8 fc eb e0 ff e9 aa fe ff ff e8 f2 eb e0 ff 90 <0f> 
>>> 0b 90 65 ff 0d 27 fd b2 10 b8 f0 ff ff ff e9 17 ff ff ff e8 d8
>>> RSP: 0018:ffffc90003797840 EFLAGS: 00010293
>>> RAX: ffffffff81df57fe RBX: ffffc90003797a10 RCX: ffff888026493c80
>>> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
>>> RBP: ffffc90003797970 R08: 0000000000585870 R09: 0000000000000005
>>> R10: dffffc0000000000 R11: fffff520006f2f20 R12: dffffc0000000000
>>> R13: 0000000000000004 R14: 0000000000000003 R15: 1ffff920006f2f42
>>> FS:  00005555805f5500(0000) GS:ffff888125e0c000(0000) 
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000000000000 CR3: 000000007c04e000 CR4: 00000000003526f0
>>> Call Trace:
>>>  <TASK>
>>>  ____bpf_trace_printk kernel/trace/bpf_trace.c:372 [inline]
>>>  bpf_trace_printk+0xdb/0x190 kernel/trace/bpf_trace.c:362
>>>  bpf_prog_bfbd7bf4bf171090+0x41/0x5a
>>>  bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
>>>  __bpf_prog_run include/linux/filter.h:721 [inline]
>>>  bpf_prog_run include/linux/filter.h:728 [inline]
>>>  bpf_prog_run_pin_on_cpu include/linux/filter.h:745 [inline]
>>>  bpf_flow_dissect+0x225/0x720 net/core/flow_dissector.c:1024
>>>  bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1414
>>>  bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4688
>>>  __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6167
>>>  __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
>>>  __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
>>>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6257
>>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f25b0f8efc9
>>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 
>>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 
>>> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007ffe036cd5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>>> RAX: ffffffffffffffda RBX: 00007f25b11e5fa0 RCX: 00007f25b0f8efc9
>>> RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
>>> RBP: 00007f25b1011f91 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 00007f25b11e5fa0 R14: 00007f25b11e5fa0 R15: 0000000000000003
>>>  </TASK>
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>> For information about bisection process see: 
>>> https://goo.gl/tpsmEJ#bisection
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want syzbot to run the reproducer, reply with:
>>> #syz test: git://repo/address.git branch-or-commit-hash
>>> If you attach or paste a git patch, syzbot will apply it before 
>>> testing.
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>
>


