Return-Path: <bpf+bounces-44664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13EC9C63BB
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB10BA421A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB304218D7D;
	Tue, 12 Nov 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUxitoFb"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1427218585
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437537; cv=none; b=YiyTiiYK8SZxHjWchV2afvI1mVIMXP/O+OBl6EgZBXiWlu/oZ34cUS5z4FHW+C4kX1biIe4U6Lo0BQ8CCmVnqiV+OzOLLDfOZIhKHQuRIK81r0fUXtqNS9RS45X1Ip9/86PtDV95bBWvHVZVPI5qrnJBpZeZW2XpkX4jF/A2QOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437537; c=relaxed/simple;
	bh=lCEQKR60Bsa3SQgodMwvRmipUI7I7QWFEfM01u25UI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYwgVbwlgicHBicS/HzG8mY1mqvMRXsbLsH0dVR3PO2Vl/FdXuwIhWpYF2CLi8k03RiESkgl6f/aZVQ9wIo0zhAkg27l/WgtVEQ9j23bQs5Z6RTuWixQjMe6nbi8ANBMeTXw36Tdh2sxYuOccsK3eHh823G/luRbw5QCaUUaU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUxitoFb; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6aa0c9e-822e-4c51-8dbe-ba6efe520b43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731437527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=011fdQUfDmHel6TI7FoeXcU2yO/c5hZ+EDUVjewC9N0=;
	b=qUxitoFbZXanduXUCMX7fHTIvrty3hpgyb2PMQo295PKlXL/8wFUgObNsBRts/38RUB5tS
	JkUdB5OLA/VVbRpPvqrBiZcRJTYzUC0RzGjWvQVsGR7t5xA06NnOLG/JNG0vu+QQGYGRYH
	E+r/68+9kXde28jOkM/JYOGzLEBYo58=
Date: Tue, 12 Nov 2024 10:51:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <b32b2892-31b1-4dc0-8398-d8fadfaafcc6@oracle.com>
 <5be88704-1bb0-4332-8626-26e7c908184c@linux.dev>
 <e311899e-5502-4d46-b9ee-edc0ee9dd023@oracle.com>
 <48a2d5a2-38e0-4c36-90cc-122602ff6386@linux.dev>
 <5e640168-7753-413a-ab00-f297948e84ef@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5e640168-7753-413a-ab00-f297948e84ef@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/12/24 10:33 AM, Alan Maguire wrote:
> On 12/11/2024 17:07, Yonghong Song wrote:
>>
>>
>> On 11/12/24 8:56 AM, Alan Maguire wrote:
>>> On 12/11/2024 01:51, Yonghong Song wrote:
>>>>
>>>> On 11/11/24 7:39 AM, Alan Maguire wrote:
>>>>> On 08/11/2024 18:05, Yonghong Song wrote:
>>>>>> Song Liu reported that a kernel func (perf_event_read()) cannot be
>>>>>> traced
>>>>>> in certain situations since the func is not in vmlinux bTF. This
>>>>>> happens
>>>>>> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
>>>>>>
>>>>>> The perf_event_read() signature in kernel (kernel/events/core.c):
>>>>>>       static int perf_event_read(struct perf_event *event, bool group)
>>>>>>
>>>>>> Adding '-V' to pahole command line, and the following error msg can
>>>>>> be found:
>>>>>>       skipping addition of 'perf_event_read'(perf_event_read) due to
>>>>>> unexpected register used for parameter
>>>>>>
>>>>>> Eventually the error message is attributed to the setting
>>>>>> (parm->unexpected_reg = 1) in parameter__new() function.
>>>>>>
>>>>>> The following is the dwarf representation for perf_event_read():
>>>>>>        0x0334c034:   DW_TAG_subprogram
>>>>>>                    DW_AT_low_pc    (0xffffffff812c6110)
>>>>>>                    DW_AT_high_pc   (0xffffffff812c640a)
>>>>>>                    DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>>>>                    DW_AT_GNU_all_call_sites        (true)
>>>>>>                    DW_AT_name      ("perf_event_read")
>>>>>>                    DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>>>>>>                    DW_AT_decl_line (4641)
>>>>>>                    DW_AT_prototyped        (true)
>>>>>>                    DW_AT_type      (0x03324f6a "int")
>>>>>>        0x0334c04e:     DW_TAG_formal_parameter
>>>>>>                      DW_AT_location        (0x007de9fd:
>>>>>>                         [0xffffffff812c6115, 0xffffffff812c6141):
>>>>>> DW_OP_reg5 RDI
>>>>>>                         [0xffffffff812c6141, 0xffffffff812c6323):
>>>>>> DW_OP_reg14 R14
>>>>>>                         [0xffffffff812c6323, 0xffffffff812c63fe):
>>>>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>>>                         [0xffffffff812c63fe, 0xffffffff812c6405):
>>>>>> DW_OP_reg14 R14
>>>>>>                         [0xffffffff812c6405, 0xffffffff812c640a):
>>>>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>>>>>                      DW_AT_name    ("event")
>>>>>>                      DW_AT_decl_file       ("/rw/compile/kernel/events/
>>>>>> core.c")
>>>>>>                      DW_AT_decl_line       (4641)
>>>>>>                      DW_AT_type    (0x0333aac2 "perf_event *")
>>>>>>        0x0334c05e:     DW_TAG_formal_parameter
>>>>>>                      DW_AT_location        (0x007dea82:
>>>>>>                         [0xffffffff812c6137, 0xffffffff812c63f2):
>>>>>> DW_OP_reg12 R12
>>>>>>                         [0xffffffff812c63f2, 0xffffffff812c63fe):
>>>>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>>>                         [0xffffffff812c63fe, 0xffffffff812c640a):
>>>>>> DW_OP_reg12 R12)
>>>>>>                      DW_AT_name    ("group")
>>>>>>                      DW_AT_decl_file       ("/rw/compile/kernel/events/
>>>>>> core.c")
>>>>>>                      DW_AT_decl_line       (4641)
>>>>>>                      DW_AT_type    (0x03327059 "bool")
>>>>>>
>>>>>> By inspecting the binary, the second argument ("bool group") is used
>>>>>> in the function. The following are the disasm code:
>>>>>>        ffffffff812c6110 <perf_event_read>:
>>>>>>        ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>>>>>        ffffffff812c6115: 55                    pushq   %rbp
>>>>>>        ffffffff812c6116: 41 57                 pushq   %r15
>>>>>>        ffffffff812c6118: 41 56                 pushq   %r14
>>>>>>        ffffffff812c611a: 41 55                 pushq   %r13
>>>>>>        ffffffff812c611c: 41 54                 pushq   %r12
>>>>>>        ffffffff812c611e: 53                    pushq   %rbx
>>>>>>        ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
>>>>>>        ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
>>>>>>        <=========== NOTE that here '%esi' is used and moved to '%r12d'.
>>>>>>        ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
>>>>>>        ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40,
>>>>>> %rax
>>>>>>        ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
>>>>>>        ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
>>>>>>        ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
>>>>>>        ffffffff812c613f: 75 3f                 jne
>>>>>> 0xffffffff812c6180 <perf_event_read+0x70>
>>>>>>        ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:
>>>>>> (%rax,%rax)
>>>>>>        ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
>>>>>>        ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
>>>>>>        ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
>>>>>>        ffffffff812c615a: e8 c1 a0 d7 00        callq
>>>>>> 0xffffffff82040220 <_raw_spin_lock_irqsave>
>>>>>>        ffffffff812c615f: 49 89 c7              movq    %rax, %r15
>>>>>>        ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
>>>>>>        ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
>>>>>>        ffffffff812c616b: 0f 84 9a 00 00 00     je
>>>>>> 0xffffffff812c620b <perf_event_read+0xfb>
>>>>>>        ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
>>>>>>        ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
>>>>>>        <=========== NOTE: %rsi is overwritten
>>>>>>        ......
>>>>>>        ffffffff812c63f0: 41 5c                 popq    %r12
>>>>>>        <============ POP r12
>>>>>>        ffffffff812c63f2: 41 5d                 popq    %r13
>>>>>>        ffffffff812c63f4: 41 5e                 popq    %r14
>>>>>>        ffffffff812c63f6: 41 5f                 popq    %r15
>>>>>>        ffffffff812c63f8: 5d                    popq    %rbp
>>>>>>        ffffffff812c63f9: e9 e2 a8 d7 00        jmp
>>>>>> 0xffffffff82040ce0 <__x86_return_thunk>
>>>>>>        ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
>>>>>>        ffffffff812c6400: e9 be fe ff ff        jmp
>>>>>> 0xffffffff812c62c3 <perf_event_read+0x1b3>
>>>>>>
>>>>>> It is not clear why dwarf didn't encode %rsi in locations. But
>>>>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
>>>>>> the entry of perf_event_read(). So this patch tries to search
>>>>>> DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
>>>>>> the expected parameter register matchs the register in
>>>>>> DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
>>>>>> is not optimized.
>>>>>>
>>>>>> For one of internal 6.11 kernel, there are 62498 functions in BTF and
>>>>>> perf_event_read() is not there. With this patch, there are 61552
>>>>>> functions
>>>>>> in BTF and perf_event_read() is included.
>>>>>>
>>>>> hi Yonghong,
>>>>>
>>>>> I'm confused by these numbers. I would have thought your changes would
>>>>> have led to a net increase of functions encoded in vmlinux BTF since we
>>>>> are now likely catching more cases where registers are expected.
>>>>> When I
>>>>> ran your patches against an LLVM-built kernel, that's what I saw; 70
>>>>> additional functions were recognized as having expected parameters, and
>>>>> thus were encoded in BTF. In your case it looks like we lost nearly
>>>>> 1000
>>>>> functions. Any idea what's going on there? If you can share your
>>>>> config,
>>>>> LLVM version I can dig into this from my side too. Thanks!
>>>> Attached is my config (based on one of meta internal configs). I tried
>>>> with master branch with head:
>>>>
>>>> 7b6e5bfa2541380b478ea1532880210ea3e39e11 (HEAD -> master, origin/master,
>>>> origin/HEAD) Merge branch 'refactor-lock-management'
>>>> ae6e3a273f590a2b64f14a9fab3546c3a8f44ed4 bpf: Drop special callback
>>>> reference handling
>>>> f6b9a69a9e56b2083aca8a925fc1a28eb698e3ed bpf: Refactor active lock
>>>> management
>>>>
>>>> I am using pahole v1.27.
>>>>
>>>> I am using an llvm built from upstream. The following is llvm-project
>>>> head:
>>>> beb12f92c71981670e07e47275efc6b5647011c1 (HEAD -> main) [RISCV] Add
>>>> +optimized-nfN-segment-load-store (#114414)
>>>> 6bad4514c938b3b48c0c719b8dd98b3906f2c290 [AArch64] Extend vector mull
>>>> test coverage. NFC
>>>> 915b910d800d7fab6a692294ff1d7075d8cba824 [libc] Fix typos in proxy type
>>>> headers (#114717)
>>>> 98ea1a81a28a6dd36941456c8ab4ce46f665f57a [IPO] Remove unused includes
>>>> (NFC) (#114716)
>>>>
>>>> With the above setup, when to do
>>>>
>>>> pahole -JV --
>>>> btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs vmlinux >& log.pahole
>>>>
>>>> You will find the below info in the log:
>>>>     skipping addition of 'perf_event_read'(perf_event_read) due to
>>>> unexpected register used for paramet
>>>>
>>>> In the dwarf:
>>>>
>>>> 0x02122746:   DW_TAG_subprogram
>>>>                   DW_AT_low_pc    (0xffffffff81299740)
>>>>                   DW_AT_high_pc   (0xffffffff812999f7)
>>>>                   DW_AT_frame_base        (DW_OP_reg7 RSP)
>>>>                   DW_AT_GNU_all_call_sites        (true)
>>>>                   DW_AT_name      ("perf_event_read")
>>>>                   DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/
>>>> events/
>>>> core.c")
>>>>                   DW_AT_decl_line (4746)
>>>>                   DW_AT_prototyped        (true)
>>>>                   DW_AT_type      (0x020f95f5 "int")
>>>>
>>>> 0x02122760:     DW_TAG_formal_parameter
>>>>                     DW_AT_location        (0x00769b72:
>>>>                        [0xffffffff81299745, 0xffffffff81299764):
>>>> DW_OP_reg5 RDI
>>>>                        [0xffffffff81299764, 0xffffffff81299937):
>>>> DW_OP_reg3 RBX
>>>>                        [0xffffffff81299937, 0xffffffff812999f0):
>>>> DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>>>>                        [0xffffffff812999f0, 0xffffffff812999f7):
>>>> DW_OP_reg3 RBX)
>>>>                     DW_AT_name    ("event")
>>>>                     DW_AT_decl_file       ("/home/yhs/work/bpf-next/
>>>> kernel/events/core.c")
>>>>                     DW_AT_decl_line       (4746)
>>>>                     DW_AT_type    (0x0210f654 "perf_event *")
>>>>                       0x02122770:     DW_TAG_formal_parameter
>>>>                     DW_AT_location        (0x00769c61:
>>>>                        [0xffffffff81299758, 0xffffffff81299926):
>>>> DW_OP_reg6 RBP
>>>>                        [0xffffffff81299926, 0xffffffff812999f0):
>>>> DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>>>>                        [0xffffffff812999f0, 0xffffffff812999f7):
>>>> DW_OP_reg6 RBP)
>>>>                     DW_AT_name    ("group")
>>>>                     DW_AT_decl_file       ("/home/yhs/work/bpf-next/
>>>> kernel/events/core.c")
>>>>
>>>> The above is slightly different from our production kernel where Song
>>>> reported. But essence is the same.
>>>> The second parameter needs to check DW_OP_GNU_entry_value(DW_OP_reg4
>>>> RSI) to ensure the second
>>>> argument is available.
>>>>
>>>> My patch is supposed to only make improvement. I am curiously why you
>>>> get less functions encoded in BTF.
>>>>
>>> Thanks for the config etc! When I build bpf-next using master branch
>>> llvm and this config, I see
>>>
>>> with baseline (master branch pahole): 62371 functions, no perf_event_read
>>> your series on top of master branch pahole: 62433 functions,
>>> perf_event_read present
>>>
>>> So that's consistent with what I've seen with other configs; more
>>> functions are present in vmlinux BTF since we are now seeing more cases
>>> where parameters are in fact consistent.  The part that confuses me
>>> though is the numbers you initially reported above
>>>
>>> "for one of internal 6.11 kernel, there are 62498 functions in BTF and
>>> perf_event_read() is not there. With this patch, there are 61552
>>> functions in BTF and perf_event_read() is included."
>>>
>>> These numbers suggest you lost nearly 1000 functions when building
>>> vmlinux BTF with pahole using this series. That's the part I don't
>>> understand - we should just see a gain in numbers of functions in
>>> vmlinux BTF, right? Did you mean 62552 functions rather than 61552
>>> perhaps?
>> Sorry, really embarrassing. it is typo. Indeed it should be 62552 functions
>> in BTF instead.
>>
> No problem, makes perfect sense now, thanks! I'm trying to reproduce the
> core dumps Eduard saw now with this setup; I'll report back if I manage
> to do so and see if locks as Jiri and Arnaldo suggested help. If so a v2
> along the lines of Eduard's suggested change plus locking might be the
> best approach, what do you think? Thanks!

Thanks Alan. I will wait for your patch to fix locking issue and then
submitting v2 with your patch.

I am just starting to reproduce the issue as well with Eduard's original
script (running pahole in a loop with -j). Currently it run to iteratio 28
and not failure yet.

>
> Alan


