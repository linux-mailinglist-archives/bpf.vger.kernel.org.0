Return-Path: <bpf+bounces-41445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75979970F2
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0608D1C20B57
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BF1E7C12;
	Wed,  9 Oct 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T6JoK0ZR"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19B1E5711
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489380; cv=none; b=YHOFf8U+x5nml51seXJjSmNj6NWWsvL5AvTPhvG/L7pN2vEpWWJ/7TWNMs9auu/nKo7dM16Yh6plGMfEgZqVRchZw894ptRiitSPT9cvZk3XEY6pZRaPqLvJgQtDX+TGQKM+xjfYP+FHsakG1nxFkwkW+yIOkq/dIUVKb44FUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489380; c=relaxed/simple;
	bh=qKW37Gsfxb+iFhfycqd/keeURCuGPF8bt57otFK+k3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtxdiDe3Pkn/snCfcGgrUSePxH3XOQasTzpmMts3Ck4j7xR6/oo7bktLljWpK7LXDvwkSwjX47pjEHoW36SXoQeKu1Txox4VN9oOs+kg7iNlMUvEM2VJ+i3798sKsR30eQzwaOkAt2aSZYGxuSGxq0eJ2RODouNiVQ5VXZm25yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T6JoK0ZR; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5be197d5-dec6-4d65-9908-1bfb6267d091@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728489373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFTBzMOhuqpordLv5A0TIhLhXjI6wOUPN+0j7s0Oeh0=;
	b=T6JoK0ZRs3BTBZ3X5dU7Nnc9K1OSzwSMgXM1iNXsgrJqoLvWlnY6lBlxXByyzmnZI3zFWd
	NTvAGqFzCbk6LaryCPL6L3ihqZI4cigIH2V7GPsttM6bFWZKyN9D15oI3oB1MNLybgk7tK
	cD2SjB35pRuy+8R4TKsPgjTJBpJhGK8=
Date: Wed, 9 Oct 2024 08:56:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev>
 <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
 <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev>
 <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
 <d8ff2878-c53b-48d7-b624-93aeb2087113@linux.dev>
 <a4468429-3b93-49b3-b8e4-122b903c98fb@linux.dev>
 <CAADnVQJRd-ngE8UBVUZVzwUwK6cGLMtZngwoUK+HOh2t_evcgQ@mail.gmail.com>
 <1fc78197-c266-41d2-8d8a-c9dbf2e35d8f@linux.dev>
 <CAADnVQ+tvGMFnEuZmKyXxJX25pL+G6X+9445Ct-RSU1sZ+57xw@mail.gmail.com>
 <CAADnVQLoLviDyvhae=m=LrUEPhE_UCaDGvjCREKTQBqEGduPdQ@mail.gmail.com>
 <62260dde-9e1d-430a-b350-01c28613b062@linux.dev>
 <CAADnVQ+T5AD8J_p3U5vpTs=5nqpypuQeGBE+wezB7mnh8Axo0Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+T5AD8J_p3U5vpTs=5nqpypuQeGBE+wezB7mnh8Axo0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/9/24 7:56 AM, Alexei Starovoitov wrote:
> On Tue, Oct 8, 2024 at 11:31 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 10/8/24 7:06 PM, Alexei Starovoitov wrote:
>>> On Tue, Oct 8, 2024 at 3:10 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>> We need to scrap this idea.
>>>> Let's go back to push/pop r11 around calls :(
>>> I didn't give up :)
>>>
>>> Here is a new idea that seems to work:
>>>
>>> [  131.472066]  dump_stack_lvl+0x53/0x70
>>> [  131.472066]  bpf_task_storage_get+0x3e/0x2f0
>>> [  131.472066]  ? bpf_task_storage_get+0x231/0x2f0
>>> [  131.472066]  bpf_prog_ed7a5f33cc9fefab_foo+0x30/0x32
>>> [  131.472066]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x68/0x6d
>>> ...
>>> [  131.417145]  dump_stack_lvl+0x53/0x70
>>> [  131.417145]  bpf_task_storage_get+0x3e/0x2f0
>>> [  131.417145]  ? selinux_netlbl_socket_post_create+0xab/0x150
>>> [  131.417145]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x60/0x6d
>>>
>>>
>>> The stack dump works fine out of main prog and out of subprog.
>>>
>>> The key difference it to pretend to have stack_depth=0,
>>> so there is no adjustment to %rsp,
>>> but point %rbp to per-cpu private stack and grow it _up_.
>>>
>>> For the main prog %rbp points to the bottom of priv stack
>>> plus stack_depth it needs,
>>> so all bpf insns that do r10-off access the bottom of that priv stack.
>>> When subprog is called it does 'add %rbp, its_stack_depth' and
>>> in turn it's using memory above the bottom of the priv stack.
>>>
>>> That seems to work, but exceptions and tailcalls are broken.
>>> I ran out of time today to debug.
>>> Pls see the attached patch.
>> The core part of the code is below:
>>
>> EMIT1(0x55); /* push rbp */ - EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp
>> */ + if (tail_call_reachable || !bpf_prog->aux->priv_stack_ptr) { +
>> EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */ + } else { + if
>> (!is_subprog) { + /* mov rsp, pcpu_priv_stack_bottom */ + void __percpu
>> *priv_frame_ptr = + bpf_prog->aux->priv_stack_ptr +
>> round_up(stack_depth, 8); + + /* movabs sp, priv_frame_ptr */ +
>> emit_mov_imm64(&prog, AUX_REG, (long) priv_frame_ptr >> 32, + (u32)
>> (long) priv_frame_ptr); + + /* add <aux_reg>, gs:[<off>] */ +
>> EMIT2(0x65, 0x4c); + EMIT3(0x03, 0x1c, 0x25); + EMIT((u32)(unsigned
>> long)&this_cpu_off, 4); + /* mov rbp, aux_reg */ + EMIT3(0x4c, 0x89,
>> 0xdd); + } else { + /* add rbp, stack_depth */ + EMIT3_off32(0x48, 0x81,
>> 0xC5, round_up(stack_depth, 8)); + } + }
> your mailer garbled the diff.

Sorry, I just copy-paste from your attached code. It shows properly
when I send email. I guess, I need to ensure I use proper format
in my editor.

>
>> So for main program, we have
>>
>> push rbp rbp = per_cpu_ptr(priv_stack_ptr + stack_size) ... What will
>> happen we have an interrupt like below? push rbp rbp =
>> per_cpu_ptr(priv_stack_ptr + stack_size) <=== interrupt happens here ...
>> If we need to dump the stack trace at interrupt point then unwinder may
>> have difficulty to find the proper stack trace since *rbp is a arbitrary
>> value and *(rbp + 8) will not have proper func return address. Does this
>> make sense?
> Hard to read above... but I think you're saying that rbp will point

Sorry again. Formating issue again.

> to priv stack, irq happens and unwinder cannot work ?
> Yes. I was also expecting it to break, but orc unwinder
> with fallback to fp somehow did it correctly. See above stack dumps.
> For the top frame the unwinder starts from SP, so it's fine,
> but for the subprog 'foo' above the 'push rbp' pushes the
> addr of priv stack, so the chain should be broken,
> but the printed stack is correct, so I'm puzzled why it worked :)

We still have issues here. With 'rbp = ...' approach, I got
stack:

[   53.429814] Call Trace:
[   53.430177]  <TASK>
[   53.430498]  dump_stack_lvl+0x52/0x70
[   53.431067]  bpf_task_storage_get+0x41/0x120
[   53.431680]  bpf_prog_71392c3ef5437fd9_foo+0x30/0x32
[   53.432404]  bpf_prog_8c4f9bc79da6c27e_socket_post_create+0x68/0x6d
[   53.433241]  ? bpf_trampoline_6442549714+0x68/0x10d
[   53.433879]  ? bpf_lsm_socket_post_create+0x9/0x20
[   53.434512]  ? security_socket_post_create+0x6e/0xd0
[   53.435166]  ? __sock_create+0x19e/0x2d0
[   53.435686]  ? __sys_socket+0x56/0xd0
[   53.436176]  ? __x64_sys_socket+0x19/0x30
[   53.436702]  ? do_syscall_64+0x58/0xf0
[   53.437201]  ? clear_bhb_loop+0x45/0xa0
[   53.437746]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   53.438488]  </TASK>

With the original kernel plus the following hack:

--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -255,6 +255,7 @@ BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
         if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
                 return (unsigned long)NULL;
  
+       dump_stack();
         bpf_task_storage_lock();
         data = __bpf_task_storage_get(map, task, value, flags,
                                       gfp_flags, true);

I got stack trace:

[   32.146519] Call Trace:
[   32.146979]  <TASK>
[   32.147356]  dump_stack_lvl+0x52/0x70
[   32.147984]  bpf_task_storage_get+0x41/0x120
[   32.148741]  bpf_prog_3c50a12b50fe949a_socket_post_create+0x5d/0xaa
[   32.149844]  bpf_trampoline_6442512791+0x68/0x10d
[   32.150679]  bpf_lsm_socket_post_create+0x9/0x20
[   32.151451]  security_socket_post_create+0x6e/0xd0
[   32.152320]  __sock_create+0x19e/0x2d0
[   32.153059]  __sys_socket+0x56/0xd0
[   32.153779]  __x64_sys_socket+0x19/0x30
[   32.154561]  do_syscall_64+0x58/0xf0
[   32.155225]  ? clear_bhb_loop+0x45/0xa0
[   32.155970]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   32.156864] RIP: 0033:0x7f580d11385b
[   32.157554] Code: 8b 54 24 08 64 48 2b 14 25 28 00 00 00 75 05 48 83 c4 18 c3 67 e8 65 d0 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 8
[   32.160990] RSP: 002b:00007f58005ffea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
[   32.162500] RAX: ffffffffffffffda RBX: 00007f5800600cdc RCX: 00007f580d11385b
[   32.163907] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
[   32.165292] RBP: 00007f58005ffed0 R08: 0000000000000000 R09: 00007f58006006c0
[   32.166608] R10: 0000000000000008 R11: 0000000000000246 R12: ffffffffffffff80
[   32.167898] R13: 0000000000000002 R14: 00007ffc461fba30 R15: 00007f57ffe00000
[   32.169119]  </TASK>

The difference is after bpf prog, the kernel stack trace
does not have '?' while with private stack and 'rbp = priv_stack_ptr'
approach, we have '?'.

The reason is that for private stack, when unwinder find the 'rbp', it
is not able to find the previous frame return address and previous proper 'rbp'.


