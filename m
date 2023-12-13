Return-Path: <bpf+bounces-17642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F64810863
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 03:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A406281ECE
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 02:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8B186E;
	Wed, 13 Dec 2023 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThFrLbeZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47398
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:48:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6d099d316a8so2453292b3a.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 18:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702435719; x=1703040519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYRCV64iy9XJE2e3ynTXjv5DGhjFQJtrVNNmOkZfXu0=;
        b=ThFrLbeZgHOk40vbYAvObTdLZZwazn81XbFSrUNaxKLnT2KyuYuslh+XmAcYGF8yeb
         QhETR3ue/qrdLAiyrNfT2i5bFhcfDc/pUzKHUqiNzUxJsElj81NoPFtvmUbtUkmDmiGF
         FmvodNpkA8oRceygs9mN8RmNO06Y0v5P9G5PIpagadF+EX0U1lsltrDgByxDTuTqsAKm
         dwMaVpW8cnWIMeKIV3vpno1SC26z+YkhODHreBJqrYqIoL0JQv1IFyyNDvKGMzCqBqYM
         hfzRL4ioTGgg89S3DUv6jwFBTK+fhHJNTbaQOakVn5tHr7qF9QyYrwblVivIZ/Ode+fB
         dx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702435719; x=1703040519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYRCV64iy9XJE2e3ynTXjv5DGhjFQJtrVNNmOkZfXu0=;
        b=NAo/X6L0dkX61XJCTO8Zmk2S0kEwu2I2nkhQfubWYf7up1SNpEFopzl5fUeol5eTts
         58BitNrf3n8AsiDwPifz4vyrDTbYyPa+5gFUA8zwhWOA0e2Ne0ZyURzbg/v/i85PK1Mk
         OEVHQ2aGF2b96Z24MJBJ9r0ztx4AENehlzRefnlCwZS9295HiY4xVuecCs7Yd1wBKdoF
         nSSB9M83IN2ieepr55mXcY1crRUZ2fzvpGsm/TcUgx+YfiDXAEnwS92f4ouUG4N1B3NT
         pfXPLwKQ/x1OZ1IP/Zm8AwW9RMbN6bcG3wOofMOI81Tnzo3WWQ67g7MfmIjKAT0nRyTm
         TA1g==
X-Gm-Message-State: AOJu0YyRu3T+bfJ2LCP2TC/EaTFcuMcRQI+0Qm5+IDefbNCqBnXHVraU
	ntSk3+iqJBNk2pA7C6NlXyk=
X-Google-Smtp-Source: AGHT+IHWoqV2VWIqqM6wVOG+CyhJivB76AYwZzLmquCiymn05AxsNKQxIsDaJYpAwal6826h9y80sA==
X-Received: by 2002:a05:6a00:1d86:b0:6ce:448b:b8 with SMTP id z6-20020a056a001d8600b006ce448b00b8mr7161697pfw.65.1702435718731;
        Tue, 12 Dec 2023 18:48:38 -0800 (PST)
Received: from [10.22.68.68] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm8946554pgg.50.2023.12.12.18.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 18:48:38 -0800 (PST)
Message-ID: <14edca04-a991-4e78-9861-7ee205220429@gmail.com>
Date: Wed, 13 Dec 2023 10:48:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2 2/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jakub@cloudflare.com, iii@linux.ibm.com,
 hengqi.chen@gmail.com
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-3-hffilwlqm@gmail.com> <ZW+sNudwg5Bc0Gbl@boxer>
 <d144dda7-a90c-4a40-9caa-a48c0e7e7fae@gmail.com> <ZXdOnO8I2a8yvO2B@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZXdOnO8I2a8yvO2B@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/23 02:02, Maciej Fijalkowski wrote:
> On Wed, Dec 06, 2023 at 02:51:28PM +0800, Leon Hwang wrote:
>>
>>
>> On 6/12/23 07:03, Maciej Fijalkowski wrote:
>>> On Wed, Oct 11, 2023 at 11:27:23PM +0800, Leon Hwang wrote:
>>>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>>>> handling in JIT"), the tailcall on x64 works better than before.
>>>>
>>>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>>>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>>>
>>>> How about:
>>>>
>>>> 1. More than 1 subprograms are called in a bpf program.
>>>> 2. The tailcalls in the subprograms call the bpf program.
>>>>
>>>> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
>>>> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
>>>>
>>>> As we know, in tail call context, the tail_call_cnt propagates by stack
>>>> and rax register between BPF subprograms. So, propagating tail_call_cnt
>>>> pointer by stack and rax register makes tail_call_cnt as like a global
>>>> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
>>>> hierarchy cases.
>>>>
>>>> Before jumping to other bpf prog, load tail_call_cnt from the pointer
>>>> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
>>>> tail_call_cnt by its pointer.
>>>>
>>>> But, where does tail_call_cnt store?
>>>>
>>>> It stores on the stack of bpf prog's caller, like
>>>>
>>>>     |  STACK  |
>>>>     |         |
>>>>     |   rip   |
>>>>  +->|   tcc   |
>>>>  |  |   rip   |
>>>>  |  |   rbp   |
>>>>  |  +---------+ RBP
>>>>  |  |         |
>>>>  |  |         |
>>>>  |  |         |
>>>>  +--| tcc_ptr |
>>>>     |   rbx   |
>>>>     +---------+ RSP
>>>>
>>>> And tcc_ptr is unnecessary to be popped from stack at the epilogue of bpf
>>>> prog, like the way of commit d207929d97ea028f ("bpf, x64: Drop "pop %rcx"
>>>> instruction on BPF JIT epilogue").
>>>>
>>>> Why not back-propagate tail_call_cnt?
>>>>
>>>> It's because it's vulnerable to back-propagate it. It's unable to work
>>>> well with the following case.
>>>>
>>>> int prog1();
>>>> int prog2();
>>>>
>>>> prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
>>>> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
>>>> same time? The answer is NO. Otherwise, there will be a register to be
>>>> polluted, which will make kernel crash.
>>>
>>> Sorry but I keep on reading this explanation and I'm lost what is being
>>> fixed here> 
>>> You want to limit the total amount of tail calls that entry prog can do to
>>> MAX_TAIL_CALL_CNT. Although I was working on that, my knowledge here is
>>> rusty, therefore my view might be distorted :) to me MAX_TAIL_CALL_CNT is
>>> to protect us from overflowing kernel stack and endless loops. As long a
>>> single call chain doesn't go over 8kB program is fine. Verifier has a
>>> limit of 256 subprogs from what I see.
>>
>> I try to resolve the following-like cases here.
>>
>>           +--------- tailcall --+
>>           |                     |
>>           V       --> subprog1 -+
>>  entry bpf prog <
>>           A       --> subprog2 -+
>>           |                     |
>>           +--------- tailcall --+
>>
>> Without this fixing, the CPU will be stalled because of too many tailcalls.
> 
> You still didn't explain why CPU might stall :/ if you stumble upon any
> kernel splats it's good habit to include them. So, for future readers of
> this thread, I reduced one of your examples down to:
> 
Thanks for your help.

Here is a GitHub CI history of this patchset:

https://github.com/kernel-patches/bpf/pull/5807/checks

In this CI results, the test_progs failed to run on aarch64 and s390x
because of "rcu: INFO: rcu_sched self-detected stall on CPU".

But why does CPU stall?

It's because there are too many tailcalls to run on the bpf prog. How many
tailcalls? Why MAX_TAIL_CALL_CNT limit does not work for those cases?

Let's have a look at a simple case:

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include "bpf_legacy.h"

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

static __noinline
int subprog_tail(struct __sk_buff *skb)
{
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 0;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
	volatile int ret = 1;

	count++;
	subprog_tail(skb); /* subprog call1 */
	subprog_tail(skb); /* subprog call2 */

	return ret;
}

char __license[] SEC("license") = "GPL";

And the entry bpf prog is populated to the 0th slot of jmp_table. Then,
what happens when entry bpf prog runs?

At the very first time when subprog_tail() is called, subprog_tail() does
tailcall the entry bpf prog. Then, subprog_taill() is called at second time
at the position subprog call1, and it tailcalls the entry bpf prog again.

Then, again and again. At the very first time when MAX_TAIL_CALL_CNT limit
works, subprog_tail() has been called for 34 times at the position subprog
call1. And at this time, the tail_call_cnt is 33 in subprog_tail().

Next, the 34th subprog_tail() returns to entry() because of
MAX_TAIL_CALL_CNT limit.

In entry(), the 34th entry(), at the time after the 34th subprog_tail() at
the position subprog call1 finishes and before the 1st subprog_tail() at
the position subprog call2 calls in entry(), what's the value of
tail_call_cnt in entry()? It's 33.

As we know, tail_all_cnt is pushed on the stack of entry(), and propagates
to subprog_tail() by %rax from stack.

Then, at the time when subprog_tail() at the position subprog call2 is
called for its first time, tail_call_cnt 33 propagates to subprog_tail()
by %rax. And the tailcall in subprog_tail() is aborted because of
tail_call_cnt >= MAX_TAIL_CALL_CNT too.

Then, subprog_tail() at the position subprog call2 ends, and the 34th
entry() ends. And it returns to the 33rd subprog_tail() called from the
position subprog call1. But wait, at this time, what's the value of
tail_call_cnt under the stack of subprog_tail()? It's 33.

Then, in the 33rd entry(), at the time after the 33th subprog_tail() at
the position subprog call1 finishes and before the 2nd subprog_tail() at
the position subprog call2 calls, what's the value of tail_call_cnt
in current entry()? It's **32**. Why not 33?

Before stepping into subprog_tail() at the position subprog call2 in 33rd
entry(), like stopping the time, let's have a look at the stack memory:

  |  STACK  |
  +---------+ RBP  <-- current rbp
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  +---------+ RSP  <-- current rsp
  |   rip   | STACK of 34rd entry()
  |   rbp   | reuse the STACK of 33rd subprog_tail() at the position
  |   ret   |                                        subprog call1
  |   tcc   | its value is 33
  +---------+ rsp
  |   rip   | STACK of 1st subprog_tail() at the position subprog call2
  |   rbp   |
  |   tcc   | its value is 33
  +---------+ rsp

Why not 33? It's because tail_call_cnt does not back-propagate from
subprog_tail() to entry().

Then, while stepping into subprog_tail() at the position subprog call2 in 33rd
entry():

  |  STACK  |
  +---------+
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  |   rip   |
  |   rbp   |
  +---------+ RBP  <-- current rbp
  |   tcc   | its value is 32; STACK of subprog_tail() at the position
  +---------+ RSP  <-- current rsp                        subprog call2

Then, while pausing after tailcalling in 2nd subprog_tail() at the position
subprog call2:

  |  STACK  |
  +---------+
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  |   rip   |
  |   rbp   |
  +---------+ RBP  <-- current rbp
  |   tcc   | its value is 33; STACK of subprog_tail() at the position
  +---------+ RSP  <-- current rsp                        subprog call2

Note: what happens to tail_call_cnt:
	/*
	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
	 *	goto out;
	 */
It's to check >= MAX_TAIL_CALL_CNT first and then increment tail_call_cnt.

So, current tailcall is allowed to run.

Then, entry() is tailcalled. And the stack memory status is:

  |  STACK  |
  +---------+
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  |   rip   |
  |   rbp   |
  +---------+ RBP  <-- current rbp
  |   ret   | STACK of 35th entry(); reuse STACK of subprog_tail() at the
  |   tcc   | its value is 33                   the position subprog call2
  +---------+ RSP  <-- current rsp

So, the tailcalls in the 35th entry() will be aborted.

And, ..., again and again.  :(

And, I hope you have understood the reason why MAX_TAIL_CALL_CNT limit
does not work for those cases.

And, how many tailcalls are there if CPU does not stall?

Let's count it. 1+1+1+...+1=?

Let's build a math model to calculate the total tailcall count. Sorry, I'm
poor at math.

How about top-down view? Does it look like hierarchy layer and layer?

I think it is a hierarchy layer model with 2+4+8+...+2**33 tailcalls. As a
result, if CPU does not stall, there will be 2**34 - 2 = 17,179,869,182
tailcalls. That's the guy which makes CPU stalled.

What about there are N subprog_tail() in entry()? If CPU does not stall
because of too many tailcalls, there will be almost N**34 tailcalls.

> #include <linux/bpf.h>
> #include <bpf/bpf_helpers.h>
> #include "bpf_legacy.h"
> 
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
> 
> static __noinline
> int subprog_tail(struct __sk_buff *skb)
> {
>         bpf_tail_call_static(skb, &jmp_table, 0);
>         return 0;
> }
> 
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
>         subprog_tail(skb);
>         return 0;
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> and indeed CPU got stuck:
> 
> [10623.892978] RIP: 0010:bpf_prog_6abcef0aca85f2fd_subprog_tail+0x49/0x59
> [10623.899606] Code: 39 56 24 76 30 8b 85 fc ff ff ff 83 f8 21 73 25 83 c0 01 89 85 fc ff ff ff 48 8b 8c d6 10 01 00 00 48 85 c9 74 0f 41 5d 5b 58 <48> 8b 49 30 48 83 c1 0b ff e1 cc 41 5d 5b c9 c3 cc cc cc cc cc cc
> [10623.918646] RSP: 0018:ffffc900202b78e0 EFLAGS: 00000286
> [10623.923952] RAX: 0000002100000000 RBX: ffff8881088aa100 RCX: ffffc9000d319000
> [10623.931194] RDX: 0000000000000000 RSI: ffff88811e6d2e00 RDI: ffff8881088aa100
> [10623.938439] RBP: ffffc900202b78e0 R08: ffffc900202b7dd4 R09: 0000000000000000
> [10623.945686] R10: 736391e000000000 R11: 0000000000000000 R12: 0000000000000001
> [10623.952927] R13: ffffc9000d38d048 R14: ffffc900202b7dd4 R15: ffffffff81ae756f
> [10623.960174]  ? bpf_test_run+0xef/0x320
> [10623.963988]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10623.969826]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10623.975662]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10623.981500]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10623.987334]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10623.993174]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10623.999016]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.004854]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.010688]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.016529]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.022371]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.028209]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.034043]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.043211]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.052344]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.061453]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.070404]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.079200]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.087841]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.096333]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.104680]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.112886]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.121014]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.129048]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.136949]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.144716]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.152479]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.160209]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.167905]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.175565]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x6f/0x77
> [10624.183173]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.190738]  bpf_prog_6d15fffd34d84bbf_classifier_0+0x56/0x77
> [10624.198262]  bpf_test_run+0x186/0x320
> [10624.203677]  ? kmem_cache_alloc+0x14d/0x2c0
> [10624.209615]  bpf_prog_test_run_skb+0x35c/0x710
> [10624.215810]  __sys_bpf+0xf3a/0x2d80
> [10624.221068]  ? do_mmap+0x409/0x5e0
> [10624.226217]  __x64_sys_bpf+0x1a/0x30
> [10624.231693]  do_syscall_64+0x2e/0xa0
> [10624.236988]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [10624.243550] RIP: 0033:0x7fd76171e69d
> [10624.248576] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 63 a7 0f 00 f7 d8 64 89 01 48
> [10624.270613] RSP: 002b:00007ffe694f8d68 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
> [10624.279894] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd76171e69d
> [10624.288769] RDX: 0000000000000050 RSI: 00007ffe694f8db0 RDI: 000000000000000a
> [10624.297634] RBP: 00007ffe694f8d80 R08: 00007ffe694f8d37 R09: 00007ffe694f8db0
> [10624.306455] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe694f9348
> [10624.315260] R13: 000055bb8423f6d9 R14: 000055bb8496ac90 R15: 00007fd761925040
> 
> Looking at assembly code:
> 
> entry:
> ffffffffc0012c60 <load3+0x12c60>:
> ffffffffc0012c60:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> ffffffffc0012c65:       31 c0                   xor    %eax,%eax
> ffffffffc0012c67:       55                      push   %rbp
> ffffffffc0012c68:       48 89 e5                mov    %rsp,%rbp
> ffffffffc0012c6b:       50                      push   %rax
> ffffffffc0012c6c:       48 8b 85 f8 ff ff ff    mov    -0x8(%rbp),%rax
> ffffffffc0012c73:       e8 30 00 00 00          call   0xffffffffc0012ca8
> ffffffffc0012c78:       31 c0                   xor    %eax,%eax
> ffffffffc0012c7a:       c9                      leave
> ffffffffc0012c7b:       c3                      ret
> 
> subprog_tail:
> ffffffffc0012ca8 <load3+0x12ca8>:
> ffffffffc0012ca8:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> ffffffffc0012cad:       66 90                   xchg   %ax,%ax
> ffffffffc0012caf:       55                      push   %rbp
> ffffffffc0012cb0:       48 89 e5                mov    %rsp,%rbp
> ffffffffc0012cb3:       50                      push   %rax
> ffffffffc0012cb4:       53                      push   %rbx
> ffffffffc0012cb5:       41 55                   push   %r13
> ffffffffc0012cb7:       48 89 fb                mov    %rdi,%rbx
> ffffffffc0012cba:       49 bd 00 7c 73 0c 81    movabs $0xffff88810c737c00,%r13
> ffffffffc0012cc1:       88 ff ff
> ffffffffc0012cc4:       48 89 df                mov    %rbx,%rdi
> ffffffffc0012cc7:       4c 89 ee                mov    %r13,%rsi
> ffffffffc0012cca:       31 d2                   xor    %edx,%edx
> ffffffffc0012ccc:       8b 85 fc ff ff ff       mov    -0x4(%rbp),%eax
> ffffffffc0012cd2:       83 f8 21                cmp    $0x21,%eax
> ffffffffc0012cd5:       73 17                   jae    0xffffffffc0012cee
> ffffffffc0012cd7:       83 c0 01                add    $0x1,%eax
> ffffffffc0012cda:       89 85 fc ff ff ff       mov    %eax,-0x4(%rbp)
> ffffffffc0012ce0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> ffffffffc0012ce5:       41 5d                   pop    %r13
> ffffffffc0012ce7:       5b                      pop    %rbx
> ffffffffc0012ce8:       58                      pop    %rax
> ffffffffc0012ce9:       e9 7d ff ff ff          jmp    0xffffffffc0012c6b
> ffffffffc0012cee:       41 5d                   pop    %r13
> ffffffffc0012cf0:       5b                      pop    %rbx
> ffffffffc0012cf1:       c9                      leave
> ffffffffc0012cf2:       c3                      ret
> 
> I am trying to understand what are writing to %rax when entry is target of
> tailcall. rbp comes from subprog_tail and we popped all of the previously
> pushed regs. So what is exactly causing this hang?
> 

Oh, your example is wierd to make CPU stuck. I don't know why, either.

> (I thought I'd rather respond just to let you know I'm on it)
> 

Thanks for your reminding.

>>
>>>
>>> Can you elaborate a bit more about the kernel crash you mention in the
>>> last paragraph?
>>
>> We have progs, prog1, prog2, prog3 and prog4, and the scenario:
>>
>> case1: kprobe1 --> prog1 --> subprog1 --tailcall-> prog2 --> subprog2 --tailcall-> prog3
>> case2: kprobe2 --> prog2 --> subprog2 --tailcall-> prog3
>> case3: kprobe3 --> prog4 --> subprog3 --tailcall-> prog3
>>                          --> subprog4 --tailcall-> prog4
>>
>> How does prog2 back-propagate tail_call_cnt to prog1?
>>
>> Possible way 1:
>> When prog2 and prog3 are added to PROG_ARRAY, poke their epilogues to
>> back-propagate tail_call_cnt by RCX register. It seems OK because kprobes do
>> not handle the value in RCX register, like case2.
>>
>> Possible way 2:
>> Can back-propagate tail_call_cnt with RCX register by checking tail_call_cnt != 0
>> at epilogue when current prog has tailcall?
>> No. As for case1, prog2 handles the value in RCX register, which is not tail_call_cnt,
>> because prog3 has no tailcall and won't populate RCX register with tail_call_cnt.
> 
> I don't get it. Let's start with small example and do the baby steps.
> 

I lost the details of back-propagating solutions which I tried hard to
convince myself the solutions were not good enough as my expectation.

Sorry about that.

>>
>> However, I don't like the back-propagating way. Then, I "burn" my brain to figure
>> out pointer propagating ways.
> 
> I know that code can damage programmer's brain, that's why we need to
> strive for elaborative and easy to understand commit messages so that
> later on we will be able to pick up what is going on here.
> 

Yeah, it's not easy to understand the code of tailcall on arch, like x86.

I'm trying hard to explain this patch.

>>
>> RFC PATCH v1 way:
>> Propagate tail_call_cnt and its pointer together. Then, the pointer is used to
>> check MAX_TAIL_CALL_CNT and increment tail_call_cnt.
>>
>>     |  STACK  |
>>     +---------+ RBP
>>     |         |
>>     |         |
>>     |         |
>>  +--| tcc_ptr |
>>  +->|   tcc   |
>>     |   rbx   |
>>     +---------+ RSP
>>
>> RFC PATCH v2 way (current patchset):
>> Propagate tail_call_cnt pointer only. Then, the pointer is used to check
>> MAX_TAIL_CALL_CNT and increment tail_call_cnt.
>>
>>     |  STACK  |
>>     |         |
>>     |   rip   |
>>  +->|   tcc   |
>>  |  |   rip   |
>>  |  |   rbp   |
>>  |  +---------+ RBP
>>  |  |         |
>>  |  |         |
>>  |  |         |
>>  +--| tcc_ptr |
>>     |   rbx   |
>>     +---------+ RSP
>>

It's time to describe the details of this patch. And take a look at how it
handles the above simple case.

This patch is to keep tail_call_cnt on the stack of entry bpf prog's caller,
and then propagate tail_call_cnt pointer like the way of the previous
tail_call_cnt.

So, at the epilogue of entry bpf prog, before pushing %rbp, it has to
initialise tail_call_cnt and to push it to stack by using %rax. Then, make
%rax as the pointer that points to tail_call_cnt, by "mov rax, rsp". Then,
call the main part of the entry bpf prog by "call 2". **This is the
exceptional point.** With this "call", %rip is pushed to stack. And at the
end of the entry bpf prog runtime, the %rip is popped from stack; then, pop
tail_call_cnt from stack too; and finally "ret" again. The popping
tail_call_cnt and "ret" is the 2 in "call 2".

So, when "call 2", %rax is the tail_call_cnt pointer. And then,
tail_call_cnt pointer will be pushed to stack. This is the way to push %rax
when entry bpf prog is tailcalled, too.

So, when a subprog is called, tail_call_cnt pointer is popped from stack to
%rax.

And when a tailcall happens, load tail_call_cnt pointer from stack to %rax
by "mov rax, qword ptr [rbp - tcc_ptr_off]", and compare tail_call_cnt with
MAX_TAIL_CALL_CNT by "cmp dword ptr [rax], MAX_TAIL_CALL_CNT", and then
increment tail_call_cnt by "add dword ptr [rax], 1". Finally, when pop %rax,
it's to pop tail_call_cnt pointer from stack to %rax.

When the epilogue of entry() runs, the stack of entry() should be like:

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 0
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
    |   rbx   | saved regs
    +---------+ RSP

Then, when subprog_tail() is called for its very first time, its stack
should be like:

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 0
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 +--| tcc_ptr | STACK of subprog_tail()
    +---------+ RSP

Then, when subprog_tail() tailcalls entry():

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 1
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
    +---------+ RSP

Then, when entry() calls subprog_tail():

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 1
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 +--| tcc_ptr | STACK of subprog_tail()
    +---------+ RSP

Then, when subprog_tail() tailcalls entry():

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 2
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
    +---------+ RSP

Then, again and again. At the very first time when MAX_TAIL_CALL_CNT limit
works, subprog_tail() has been called for 34 times at the position subprog
call1. And at this time, the stack should be like:

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 33
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |    *    |
 |  |    *    |
 |  |    *    |
 |  +---------+ RBP
 +--| tcc_ptr | STACK of subprog_tail()
    +---------+ RSP

After this time, the tailcalls in the future will be aborted because
tail_call_cnt has been 33, which reaches its MAX_TAIL_CALL_CNT limit.

That's the way how this patch works.

It's really nice if you reach here. I hope you have a clear idea to
understand this patch by reading above replys.

>>>
>>> I also realized that verifier assumes MAX_TAIL_CALL_CNT as 32 which has
>>> changed in the meantime to 33 and we should adjust the max allowed stack
>>> depth of subprogs? I believe this was brought up at LPC?
>>
>> There's following code snippet in verifier.c:
>>
>> 	/* protect against potential stack overflow that might happen when
>> 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
>> 	 * depth for such case down to 256 so that the worst case scenario
>> 	 * would result in 8k stack size (32 which is tailcall limit * 256 =
>> 	 * 8k).
>>
>> But, MAX_TAIL_CALL_CNT is 33.
>>
>> This was not brought up at LPC 2022&2023. I don't know whether this was
>> brought up at previous LPCs.
> 
> Was referring to this:
> https://lpc.events/event/17/contributions/1595/attachments/1230/2506/LPC2023_slides.pdf
> 

That's interesting. I tried to overflow the stack of one bpf prog, whose
max stack size limits to 8k, with fexit. I failed because the stack size
of thread is not so that small. But, exceptionally, it was able to compose
a tailcall infinite loop with fexit, which broke the tail_call_cnt
propagating chain because it did not pass through the fexit's trampoline.

Thanks,
Leon

> but let us focus on issue you're bringing up here in this patch. I brought
> this up thinking JIT code was fine, now it's clear that things go south
> when entry prog is tailcall target, which we didn't test.
> 
>>
>> Thanks,
>> Leon
>>

