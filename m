Return-Path: <bpf+bounces-40424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E37798883D
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 17:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13F6B2244C
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3371C172C;
	Fri, 27 Sep 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e/NU6Onw"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A613AD1C
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450664; cv=none; b=Uu/ng0N7tFKBot9tYcrM6pZtWn1sAAHPLuE1aiO/uBdwFBlVevxGY00STyg+l5N3tXXe4iQ0BTD5ZsK/VHajmYeLAfKb+X1t/J/Nidy95zMIHiHLoNZJr1kIG3xcprK0ugOxCHuCcaPJFavFLl1YZciF2HloNPd97HJ4uSkYW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450664; c=relaxed/simple;
	bh=ZkweLvyag97akDboOxMZOkNg64bbiHQY6aByshyepaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8IlGGLAdc6Pu3OEB06l44R/YWzocBYkx0Kd9351KiiVMJGTGik0tlaF+VGTxSUf/W+04gNtcrfiWF6OXKDx9EgrMMuUfzFi/ok0VBTkIIQvgFfphMhdMmJtS7zLXJf6EWrHEB+dFvTGNJdyM548vmfxBmiXaPc6ajDjI6GiaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e/NU6Onw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ec48e1b2-ff1d-499b-8ada-ba76a4bae9bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727450660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GN1WCbWnVujnXCJ+8hJO2y/H0/A20AHKmN4AIhZJ4Q=;
	b=e/NU6Onw1Q2VCjP298F5P3PnfX07NhK1+CkpD+j1NgmgrUR5jva4/7TwIqCA8z+yIUXx8M
	ZTIrczRx8JHNDC8X+tkC6MhJKQO695RyO9GrUEnskaDUHQq3cjkrmzTEdNef+7FumFUiB5
	oTASnL4BHKpUUpEVWIMExPV3QJLMGVE=
Date: Fri, 27 Sep 2024 08:24:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private
 stack
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev>
 <44ddec9e-cc74-4686-9228-52e4db301e8a@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <44ddec9e-cc74-4686-9228-52e4db301e8a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/26/24 9:58 PM, Leon Hwang wrote:
> Hi Yonghong,
>
> A brief review about the usage of this_cpu_off on non-SMP systems.
>
> On 27/9/24 07:45, Yonghong Song wrote:
>> Add jit support for private stack. For a particular subtree, e.g.,
>>    subtree_root <== stack depth 120
>>     subprog1    <== stack depth 80
>>      subprog2   <== stack depth 40
>>     subprog3    <== stack depth 160
>>
>> Let us say that private_stack_ptr is the memory address allocated for
>> private stack. The frame pointer for each above is calculated like below:
>>    subtree_root  <== subtree_root_fp = private_stack_ptr + 120
>>     subprog1     <== subtree_subprog1_fp = subtree_root_fp + 80
>>      subprog2    <== subtree_subprog2_fp = subtree_subprog1_fp + 40
>>     subprog3     <== subtree_subprog1_fp = subtree_root_fp + 160
>>
>> For any function call to helper/kfunc, push/pop prog frame pointer
>> is needed in order to preserve frame pointer value.
>>
>> To deal with exception handling, push/pop frame pointer is also used
>> surrounding call to subsequent subprog. For example,
>>    subtree_root
>>     subprog1
>>       ...
>>       insn: call bpf_throw
>>       ...
>>
>> After jit, we will have
>>    subtree_root
>>     insn: push r9
>>     subprog1
>>       ...
>>       insn: push r9
>>       insn: call bpf_throw
>>       insn: pop r9
>>       ...
>>     insn: pop r9
>>
>>    exception_handler
>>       pop r9
>>       ...
>> where r9 represents the fp for each subprog.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 87 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 81 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa5..c264822c926b 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -325,6 +325,22 @@ struct jit_context {
>>   /* Number of bytes that will be skipped on tailcall */
>>   #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
>>   
>> +static void push_r9(u8 **pprog)
>> +{
>> +	u8 *prog = *pprog;
>> +
>> +	EMIT2(0x41, 0x51);   /* push r9 */
>> +	*pprog = prog;
>> +}
>> +
>> +static void pop_r9(u8 **pprog)
>> +{
>> +	u8 *prog = *pprog;
>> +
>> +	EMIT2(0x41, 0x59);   /* pop r9 */
>> +	*pprog = prog;
>> +}
>> +
>>   static void push_r12(u8 **pprog)
>>   {
>>   	u8 *prog = *pprog;
>> @@ -491,7 +507,7 @@ static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
>>    */
>>   static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>   			  bool tail_call_reachable, bool is_subprog,
>> -			  bool is_exception_cb)
>> +			  bool is_exception_cb, enum bpf_pstack_state  pstack)
>>   {
>>   	u8 *prog = *pprog;
>>   
>> @@ -518,6 +534,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>   		 * first restore those callee-saved regs from stack, before
>>   		 * reusing the stack frame.
>>   		 */
>> +		if (pstack)
>> +			pop_r9(&prog);
>>   		pop_callee_regs(&prog, all_callee_regs_used);
>>   		pop_r12(&prog);
>>   		/* Reset the stack frame. */
>> @@ -1404,6 +1422,22 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>>   	*pprog = prog;
>>   }
>>   
>> +static void emit_private_frame_ptr(u8 **pprog, void *private_frame_ptr)
>> +{
>> +	u8 *prog = *pprog;
>> +
>> +	/* movabs r9, private_frame_ptr */
>> +	emit_mov_imm64(&prog, X86_REG_R9, (long) private_frame_ptr >> 32,
>> +		       (u32) (long) private_frame_ptr);
>> +
>> +	/* add <r9>, gs:[<off>] */
>> +	EMIT2(0x65, 0x4c);
>> +	EMIT3(0x03, 0x0c, 0x25);
>> +	EMIT((u32)(unsigned long)&this_cpu_off, 4);
> It should check CONFIG_SMP here like this commit:
> 1e9e0b85255e ("bpf: handle CONFIG_SMP=n configuration in x86 BPF JIT").
>
> So, it seems better to reuse the code snippet of the commit.

Thanks for pointing this out. I will make the change after waiting some
other reviews.

>
> Thanks,
> Leon
>

