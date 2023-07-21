Return-Path: <bpf+bounces-5596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C375C2A4
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8A1C21607
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F714F83;
	Fri, 21 Jul 2023 09:11:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80678DDC1;
	Fri, 21 Jul 2023 09:11:40 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73251359B;
	Fri, 21 Jul 2023 02:11:17 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6kK72bNTz18MJ8;
	Fri, 21 Jul 2023 17:09:47 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 17:10:32 +0800
Message-ID: <0d5195c1-779c-ef2d-7bb9-e3ce570d4e92@huawei.com>
Date: Fri, 21 Jul 2023 17:10:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf] riscv, bpf: Adapt bpf trampoline to optimized riscv
 ftrace framework
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu Lehui
	<pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>, Song Shuai
	<suagrfillet@gmail.com>
References: <20230715090137.2141358-1-pulehui@huaweicloud.com>
 <87lefdougi.fsf@all.your.base.are.belong.to.us>
 <63986ef9-10a4-bcef-369d-0bad28b192d1@huawei.com>
 <87o7k8udzj.fsf@all.your.base.are.belong.to.us>
 <b5977c5d-c434-7b4c-89f3-d575ee5d04e8@huawei.com>
 <87o7k5fxwx.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <87o7k5fxwx.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/21 16:53, Björn Töpel wrote:
> Pu Lehui <pulehui@huawei.com> writes:
> 
>> On 2023/7/19 23:18, Björn Töpel wrote:
>>> Pu Lehui <pulehui@huawei.com> writes:
>>>
>>>> On 2023/7/19 4:06, Björn Töpel wrote:
>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>
>>>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>>>
>>>>>> Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
>>>>>> half") optimizes the detour code size of kernel functions to half with
>>>>>> T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
>>>>>> is based on this optimization, we need to adapt riscv bpf trampoline
>>>>>> based on this. One thing to do is to reduce detour code size of bpf
>>>>>> programs, and the second is to deal with the return address after the
>>>>>> execution of bpf trampoline. Meanwhile, add more comments and rename
>>>>>> some variables to make more sense. The related tests have passed.
>>>>>>
>>>>>> This adaptation needs to be merged before the upcoming
>>>>>> DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv, otherwise it will crash due
>>>>>> to a mismatch in the return address. So we target this modification to
>>>>>> bpf tree and add fixes tag for locating.
>>>>>
>>>>> Thank you for working on this!
>>>>>
>>>>>> Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half")
>>>>>
>>>>> This is not a fix. Nothing is broken. Only that this patch much come
>>>>> before or as part of the ftrace series.
>>>>
>>>> Yep, it's really not a fix. I have no idea whether this patch target to
>>>> bpf-next tree can be ahead of the ftrace series of riscv tree?
>>>
>>> For this patch, I'd say it's easier to take it via the RISC-V tree, IFF
>>> the ftrace series is in for-next.
>>>
>>
>> alright, so let's make it target to riscv-tree to avoid that cracsh.
>>
>>> [...]
>>>
>>>>>> +#define DETOUR_NINSNS	2
>>>>>
>>>>> Better name? Maybe call this patchable function entry something? Also,
>>>>
>>>> How about RV_FENTRY_NINSNS?
>>>
>>> Sure. And more importantly that it's actually used in the places where
>>> nops/skips are done.
>>
>> the new one is suited up.
>>
>>>
>>>>> to catch future breaks like this -- would it make sense to have a
>>>>> static_assert() combined with something tied to
>>>>> -fpatchable-function-entry= from arch/riscv/Makefile?
>>>>
>>>> It is very necessary, but it doesn't seem to be easy. I try to find GCC
>>>> related functions, something like __builtin_xxx, but I can't find it so
>>>> far. Also try to make it as a CONFIG_PATCHABLE_FUNCTION_ENTRY=4 in
>>>> Makefile and then static_assert, but obviously it shouldn't be done.
>>>> Maybe we can deal with this later when we have a solution?
>>>
>>> Ok!
>>>
>>> [...]
>>>
>>>>>> @@ -787,20 +762,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>>>>>     	int i, ret, offset;
>>>>>>     	int *branches_off = NULL;
>>>>>>     	int stack_size = 0, nregs = m->nr_args;
>>>>>> -	int retaddr_off, fp_off, retval_off, args_off;
>>>>>> -	int nregs_off, ip_off, run_ctx_off, sreg_off;
>>>>>> +	int fp_off, retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
>>>>>>     	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>>>>>>     	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>>>>>>     	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
>>>>>>     	void *orig_call = func_addr;
>>>>>> -	bool save_ret;
>>>>>> +	bool save_retval, traced_ret;
>>>>>>     	u32 insn;
>>>>>>     
>>>>>>     	/* Generated trampoline stack layout:
>>>>>>     	 *
>>>>>>     	 * FP - 8	    [ RA of parent func	] return address of parent
>>>>>>     	 *					  function
>>>>>> -	 * FP - retaddr_off [ RA of traced func	] return address of traced
>>>>>> +	 * FP - 16	    [ RA of traced func	] return address of
>>>>>>     	traced
>>>>>
>>>>> BPF code uses frame pointers. Shouldn't the trampoline frame look like a
>>>>> regular frame [1], i.e. start with return address followed by previous
>>>>> frame pointer?
>>>>>
>>>>
>>>> oops, will fix it. Also we need to consider two types of trampoline
>>>> stack layout, that is:
>>>>
>>>> * 1. trampoline called from function entry
>>>> * --------------------------------------
>>>> * FP + 8           [ RA of parent func ] return address of parent
>>>> *                                        function
>>>> * FP + 0           [ FP                ]
>>>> *
>>>> * FP - 8           [ RA of traced func ] return address of traced
>>>> *                                        function
>>>> * FP - 16          [ FP                ]
>>>> * --------------------------------------
>>>> *
>>>> * 2. trampoline called directly
>>>> * --------------------------------------
>>>> * FP - 8           [ RA of caller func ] return address of caller
>>>> *                                        function
>>>> * FP - 16          [ FP                ]
>>>> * --------------------------------------
>>>
>>> Hmm, could you expand a bit on this? The stack frame top 16B (8+8)
>>> should follow what the psabi suggests, regardless of the call site?
>>>
>>
>> Maybe I've missed something important! Or maybe I'm misunderstanding
>> what you mean. But anyway there is something to show. In my perspective,
>> we should construct a complete stack frame, otherwise one layer of stack
>> will be lost in calltrace when enable CONFIG_FRAME_POINTER.
>>
>> We can verify it by `echo 1 >
>> /sys/kernel/debug/tracing/options/stacktrace`, and the results as show
>> below:
>>
>> 1. complete stack frame
>> * --------------------------------------
>> * FP + 8           [ RA of parent func ] return address of parent
>> *                                        function
>> * FP + 0           [ FP                ]
>> *
>> * FP - 8           [ RA of traced func ] return address of traced
>> *                                        function
>> * FP - 16          [ FP                ]
>> * --------------------------------------
>> the stacktrace is:
>>
>>    => trace_event_raw_event_bpf_trace_printk
>>    => bpf_trace_printk
>>    => bpf_prog_ad7f62a5e7675635_bpf_prog
>>    => bpf_trampoline_6442536643
>>    => do_empty
>>    => meminfo_proc_show
>>    => seq_read_iter
>>    => proc_reg_read_iter
>>    => copy_splice_read
>>    => vfs_splice_read
>>    => splice_direct_to_actor
>>    => do_splice_direct
>>    => do_sendfile
>>    => sys_sendfile64
>>    => do_trap_ecall_u
>>    => ret_from_exception
>>
>> 2. omit one FP
>> * --------------------------------------
>> * FP + 0           [ RA of parent func ] return address of parent
>> *                                        function
>> * FP - 8           [ RA of traced func ] return address of traced
>> *                                        function
>> * FP - 16          [ FP                ]
>> * --------------------------------------
>> the stacktrace is:
>>
>>    => trace_event_raw_event_bpf_trace_printk
>>    => bpf_trace_printk
>>    => bpf_prog_ad7f62a5e7675635_bpf_prog
>>    => bpf_trampoline_6442491529
>>    => do_empty
>>    => seq_read_iter
>>    => proc_reg_read_iter
>>    => copy_splice_read
>>    => vfs_splice_read
>>    => splice_direct_to_actor
>>    => do_splice_direct
>>    => do_sendfile
>>    => sys_sendfile64
>>    => do_trap_ecall_u
>>    => ret_from_exception
>>
>> it lost the layer of 'meminfo_proc_show'.
> 
> (Lehui was friendly enough to explain the details for me offlist.)
> 
> Aha, now I get what you mean! When we're getting into the trampoline
> from the fentry-side, an additional stack frame needs to be
> created. Otherwise, the unwinding will be incorrect.
> 
> So (for the rest of the readers ;-)), the BPF trampoline can be called
> from:
> 
> A. A tracing point of view; Here, we're calling into the trampoline via
>     the fentry/patchable entry. In this scenario, an additional stack
>     frame needs to be constructed for proper unwinding.
> 
> B. For kfuncs. Here, the call into the trampoline is just a "regular
>     call", and no additional stack frame is needed.
> 
> @Guo @Song Is the RISC-V ftrace code creating an additional stack frame,
> or is the stack unwinding incorrect when the fentry is patched?
> 
> 
> Thanks for clearing it up for me, Lehui!
> 

It's my honor, will keep push riscv-bpf.

> 
> Björn

