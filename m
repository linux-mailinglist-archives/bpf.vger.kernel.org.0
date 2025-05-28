Return-Path: <bpf+bounces-59189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE93AC6F8B
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C96817635C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00928DF29;
	Wed, 28 May 2025 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K9/eP3rj"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267301F582E
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454119; cv=none; b=clfpZiQ/U18460fAYkpGfpmmgFc9WcC5MlxxUbGuOVxy8N1WGnImOBjxs4XERKzse1RfidtDJhJG3mN/qQYB2aXSsKQiDSDQU8ZMvW3IRZkISP3h7R6kJnhkIYyPO6axil0pgqVGZPxiY3CJ3HivBQGRxkBSf6/euAhBzd+lpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454119; c=relaxed/simple;
	bh=WzzDro7hTdVQ7YhfQQ5LSKK3q0j3y/7qsf/ExlcQXY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsxJtiPTuG4/GHI53cKWBwpPgBl9wjlpI6EUCz1gXBbEqXRg18Vz9PNGa398UTnlORAiZ5UVIP1QF9WL7DKTjldEqHt5pkPME0kas1JcBSgdXQ5L2+BpjQPaeagPuaTV6vKrWuhgecg1P+4XtU8ID6BrjcdvWwmqW9bhNA2UT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K9/eP3rj; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c58af8e-1e00-4630-b19b-368a02e60ce1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748454114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmqSOQCMBY4ozVv3CQobOof7gKSpxbDPaQReB6RUiCE=;
	b=K9/eP3rjU88X18AW/Rs+vTUFDfT1iOM5uf8SqEkzRfKbUlL0X+5HYvC+5HmgMQcUj64++q
	BLO5X5+1cCu305Hn2wHe76SMFGCnw3CgLZkMPOFdfu58tfBbtSvy0kATWElNgwlznvwVMA
	Cpzx8KLZIDL7QVLn+QYhPyZdmCkUKQs=
Date: Wed, 28 May 2025 10:41:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Specify access type of bpf_sysctl_get_name args
Content-Language: en-GB
To: Jerome Marchand <jmarchan@redhat.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>
References: <20250527165412.533335-1-jmarchan@redhat.com>
 <7aed6949-1076-4c8f-8939-35b47072d431@linux.dev>
 <c8bb97cc-68b6-44f1-a4f4-b0ebc42a7f92@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c8bb97cc-68b6-44f1-a4f4-b0ebc42a7f92@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/28/25 2:09 AM, Jerome Marchand wrote:
> On 27/05/2025 21:56, Yonghong Song wrote:
>>
>>
>> On 5/27/25 9:54 AM, Jerome Marchand wrote:
>>> The second argument of bpf_sysctl_get_name() helper is a pointer to a
>>> buffer that is being written to. However that isn't specify in the
>>> prototype.
>>>
>>> Until commit 37cce22dbd51a ("bpf: verifier: Refactor helper access
>>> type tracking"), all helper accesses were considered as a possible
>>> write access by the verifier, so no big harm was done. However, since
>>> then, the verifier might make wrong asssumption about the content of
>>> that address which might lead it to make faulty optimizations (such as
>>> removing code that was wrongly labeled dead). This is what happens in
>>
>> Could you give more detailed example about the above statement?
>>
>>    the verifier might make wrong asssumption about the content of
>>    that address which might lead it to make faulty optimizations 
>> (such as
>>    removing code that was wrongly labeled dead)
>
> To be clear, I don't mean that the verifier does anything wrong in this
> case. It makes a wrong assumption because it was fed wrong information
> by the helper prototype. Here is the output of the verifier with commit
> 37cce22dbd51a:
>
> func#0 @0
> Live regs before insn:
>   0: .1........ (bf) r7 = r10
>   1: .1.....7.. (07) r7 += -8
>   2: .1.....7.. (b7) r0 = 0
>   3: 01.....7.. (7b) *(u64 *)(r7 +0) = r0
>   4: .1.....7.. (bf) r2 = r7
>   5: .12....7.. (b7) r3 = 8
>   6: .123...7.. (b7) r4 = 1
>   7: .1234..7.. (85) call bpf_sysctl_get_name#101
>   8: 0......7.. (55) if r0 != 0x7 goto pc+6
>   9: .......7.. (18) r8 = 0x6d656d5f706374
>  11: .......78. (79) r9 = *(u64 *)(r7 +0)
>  12: ........89 (5d) if r8 != r9 goto pc+2
>  13: .......... (b7) r0 = 1
>  14: 0......... (05) goto pc+1
>  15: .......... (b7) r0 = 0
>  16: 0......... (95) exit
> 0: R1=ctx() R10=fp0
> 0: (bf) r7 = r10                      ; R7_w=fp0 R10=fp0
> 1: (07) r7 += -8                      ; R7_w=fp-8
> 2: (b7) r0 = 0                        ; R0_w=0
> 3: (7b) *(u64 *)(r7 +0) = r0          ; R0_w=0 R7_w=fp-8 fp-8_w=0
> 4: (bf) r2 = r7                       ; R2_w=fp-8 R7_w=fp-8
> 5: (b7) r3 = 8                        ; R3_w=8
> 6: (b7) r4 = 1                        ; R4_w=1
> 7: (85) call bpf_sysctl_get_name#101
> mark_precise: frame0: last_idx 7 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r3 stack= before 6: (b7) r4 = 1
> mark_precise: frame0: regs=r3 stack= before 5: (b7) r3 = 8
> 8: R0_w=scalar()
> 8: (55) if r0 != 0x7 goto pc+6        ; R0_w=7
> 9: (18) r8 = 0x6d656d5f706374         ; R8_w=0x6d656d5f706374
> 11: (79) r9 = *(u64 *)(r7 +0)         ; R7=fp-8 R9=0 fp-8=0
> 12: (5d) if r8 != r9 goto pc+2
> mark_precise: frame0: last_idx 12 first_idx 12 subseq_idx -1
> mark_precise: frame0: parent state regs=r8 stack=:  R0_w=7 R7_w=fp-8 
> R8_rw=P0x6d656d5f706374 R9_rw=0 R10=fp0 fp-8_w=0
> mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx 12
> mark_precise: frame0: regs=r8 stack= before 11: (79) r9 = *(u64 *)(r7 +0)
> mark_precise: frame0: regs=r8 stack= before 9: (18) r8 = 0x6d656d5f706374
> mark_precise: frame0: last_idx 12 first_idx 12 subseq_idx -1
> mark_precise: frame0: parent state regs=r9 stack=:  R0_w=7 R7_w=fp-8 
> R8_rw=P0x6d656d5f706374 R9_rw=P0 R10=fp0 fp-8_w=0
> mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx 12
> mark_precise: frame0: regs=r9 stack= before 11: (79) r9 = *(u64 *)(r7 +0)
> mark_precise: frame0: regs= stack=-8 before 9: (18) r8 = 0x6d656d5f706374
> mark_precise: frame0: regs= stack=-8 before 8: (55) if r0 != 0x7 goto 
> pc+6
> mark_precise: frame0: regs= stack=-8 before 7: (85) call 
> bpf_sysctl_get_name#101
> mark_precise: frame0: regs= stack=-8 before 6: (b7) r4 = 1
> mark_precise: frame0: regs= stack=-8 before 5: (b7) r3 = 8
> mark_precise: frame0: regs= stack=-8 before 4: (bf) r2 = r7
> mark_precise: frame0: regs= stack=-8 before 3: (7b) *(u64 *)(r7 +0) = r0
> mark_precise: frame0: regs=r0 stack= before 2: (b7) r0 = 0
> 12: R8=0x6d656d5f706374 R9=0
> 15: (b7) r0 = 0                       ; R0_w=0
> 16: (95) exit
> mark_precise: frame0: last_idx 16 first_idx 12 subseq_idx -1
> mark_precise: frame0: regs=r0 stack= before 15: (b7) r0 = 0
>
> from 8 to 15: R0_w=scalar() R7_w=fp-8 R10=fp0 fp-8_w=0
> 15: R0_w=scalar() R7_w=fp-8 R10=fp0 fp-8_w=0
> 15: (b7) r0 = 0                       ; R0_w=0
> 16: (95) exit
> mark_precise: frame0: last_idx 16 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r0 stack= before 15: (b7) r0 = 0
> processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 
> 1 peak_states 1 mark_read 1
>
> At line 11, it still assume that fp-8=0, despite the call to
> bpf_sysctl_get_name. Because of that, it assumes that the first branch
> of the conditional jump at line 12 is never taken an the program always
> return 0 (access denied).
>
> For comparison, here's the verifier output when commit 37cce22dbd51a is
> reverted:
>
> func#0 @0
> Live regs before insn:
>   0: .1........ (bf) r7 = r10
>   1: .1.....7.. (07) r7 += -8
>   2: .1.....7.. (b7) r0 = 0
>   3: 01.....7.. (7b) *(u64 *)(r7 +0) = r0
>   4: .1.....7.. (bf) r2 = r7
>   5: .12....7.. (b7) r3 = 8
>   6: .123...7.. (b7) r4 = 1
>   7: .1234..7.. (85) call bpf_sysctl_get_name#101
>   8: 0......7.. (55) if r0 != 0x7 goto pc+6
>   9: .......7.. (18) r8 = 0x6d656d5f706374
>  11: .......78. (79) r9 = *(u64 *)(r7 +0)
>  12: ........89 (5d) if r8 != r9 goto pc+2
>  13: .......... (b7) r0 = 1
>  14: 0......... (05) goto pc+1
>  15: .......... (b7) r0 = 0
>  16: 0......... (95) exit
> 0: R1=ctx() R10=fp0
> 0: (bf) r7 = r10                      ; R7_w=fp0 R10=fp0
> 1: (07) r7 += -8                      ; R7_w=fp-8
> 2: (b7) r0 = 0                        ; R0_w=0
> 3: (7b) *(u64 *)(r7 +0) = r0          ; R0_w=0 R7_w=fp-8 fp-8_w=0
> 4: (bf) r2 = r7                       ; R2_w=fp-8 R7_w=fp-8
> 5: (b7) r3 = 8                        ; R3_w=8
> 6: (b7) r4 = 1                        ; R4_w=1
> 7: (85) call bpf_sysctl_get_name#101
> mark_precise: frame0: last_idx 7 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r3 stack= before 6: (b7) r4 = 1
> mark_precise: frame0: regs=r3 stack= before 5: (b7) r3 = 8
> 8: R0_w=scalar()
> 8: (55) if r0 != 0x7 goto pc+6        ; R0_w=7
> 9: (18) r8 = 0x6d656d5f706374         ; R8_w=0x6d656d5f706374
> 11: (79) r9 = *(u64 *)(r7 +0)         ; R7=fp-8 R9=scalar() fp-8=mmmmmmmm
> 12: (5d) if r8 != r9 goto pc+2        ; R8=0x6d656d5f706374 
> R9=0x6d656d5f706374
> 13: (b7) r0 = 1                       ; R0_w=1
> 14: (05) goto pc+1
> 16: (95) exit
> mark_precise: frame0: last_idx 16 first_idx 12 subseq_idx -1
> mark_precise: frame0: regs=r0 stack= before 14: (05) goto pc+1
> mark_precise: frame0: regs=r0 stack= before 13: (b7) r0 = 1
>
> from 12 to 15: R0=7 R7=fp-8 R8=0x6d656d5f706374 R9=scalar() R10=fp0 
> fp-8=mmmmmmmm
> 15: R0=7 R7=fp-8 R8=0x6d656d5f706374 R9=scalar() R10=fp0 fp-8=mmmmmmmm
> 15: (b7) r0 = 0                       ; R0_w=0
> 16: (95) exit
> mark_precise: frame0: last_idx 16 first_idx 12 subseq_idx -1
> mark_precise: frame0: regs=r0 stack= before 15: (b7) r0 = 0
>
> from 8 to 15: R0_w=scalar() R7_w=fp-8 R10=fp0 fp-8_w=mmmmmmmm
> 15: R0_w=scalar() R7_w=fp-8 R10=fp0 fp-8_w=mmmmmmmm
> 15: (b7) r0 = 0                       ; R0_w=0
> 16: (95) exit
> mark_precise: frame0: last_idx 16 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=r0 stack= before 15: (b7) r0 = 0
> processed 19 insns (limit 1000000) max_states_per_insn 0 total_states 
> 1 peak_states 1 mark_read 1
>
>>
>> This patch actually may cause a behavior change.
>>
>> Without this patch, typically the whole buffer will be initialized
>> to 0 and then the helper itself will copy bytes until seeing a '\0'.
>>
>> With this patch, bpf prog does not need to initialize the buffer.
>> Inside the helper, the copied bytes may not cover the whole buffer.
>
> If that's an issue, it could be easily fixed by replacing
> ARG_PTR_TO_UNINIT_MEM by ARG_PTR_TO_MEM | MEM_WRITE.

Thanks. I think ARG_PTR_TO_MEM | MEM_WRITE is better to express the
intention of the helper.

> I don't know what the original intention was when bpf_sysctl_get_name()
> was introduced, but almost all helpers use ARG_PTR_TO_UNINIT_MEM for
> such a case.
>
> Jerome
>
>>
>>> test_sysctl selftest to the tests related to sysctl_get_name.
>>>
>>> Correctly mark the second argument of bpf_sysctl_get_name() as
>>> ARG_PTR_TO_UNINIT_MEM.
>>>
>>> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
>>> ---
>>>   kernel/bpf/cgroup.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index 84f58f3d028a3..09c02a592d24a 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -2104,7 +2104,7 @@ static const struct bpf_func_proto 
>>> bpf_sysctl_get_name_proto = {
>>>       .gpl_only    = false,
>>>       .ret_type    = RET_INTEGER,
>>>       .arg1_type    = ARG_PTR_TO_CTX,
>>> -    .arg2_type    = ARG_PTR_TO_MEM,
>>> +    .arg2_type    = ARG_PTR_TO_UNINIT_MEM,
>>>       .arg3_type    = ARG_CONST_SIZE,
>>>       .arg4_type    = ARG_ANYTHING,
>>>   };
>>
>>
>


