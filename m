Return-Path: <bpf+bounces-47690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE009FE3B3
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 09:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16CCA160E47
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 08:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A61A08A0;
	Mon, 30 Dec 2024 08:27:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F225948E;
	Mon, 30 Dec 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547258; cv=none; b=na0puu51ThZ2KWv/NYEDuVF/VOVmPO/irDYJb3GsWsbQ2vd9WrzUljZGg7k3DECVDOa0rFUCPDJDm7Y/LsGeUe+44O1y7Enzz0hnUbNdEmxG0s6ojNeA7WEBznUBsx7t0Pe2dKA19wCy9uuaCOEK4zU3GyOx+icx1u+wm9flhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547258; c=relaxed/simple;
	bh=JDmSOmsusRA1zycK0KHEboMhnQiX/c88B9nekJ96g/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aA5Qr97CBFSRihJmxh2RlTuNo7y9nmrJUh44+mryj8u9j8vBLHLAATfnmjUg33QIaRVLWBw0r2/qylla7H0EjHJfYSenfGuveNp5A1t3zM62OT23o/uXrTnw/Kdkyn0tRLmn+KRo1Vdv4F5aT3A7zTGsSS1BDEqqDY4UuIVB98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YM8NG4GYTz4f3jss;
	Mon, 30 Dec 2024 16:27:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 58F1A1A18B0;
	Mon, 30 Dec 2024 16:27:25 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBnjoJpWXJn_q4uGA--.58298S2;
	Mon, 30 Dec 2024 16:27:23 +0800 (CST)
Message-ID: <4e6641ce-3f1e-4251-8daf-4dd4b77d08c4@huaweicloud.com>
Date: Mon, 30 Dec 2024 16:27:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
Content-Language: en-US
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
 Benjamin Segall <bsegall@google.com>, David Vernet <dvernet@meta.com>,
 Dave Marchevsky <davemarchevsky@meta.com>, linux-kernel@vger.kernel.org
References: <cover.1734742802.git.yepeilin@google.com>
 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
 <f704019d-a8fa-4cf5-a606-9d8328360a3e@huaweicloud.com>
 <Z23hntYzWuZOnScP@google.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <Z23hntYzWuZOnScP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnjoJpWXJn_q4uGA--.58298S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1kGr1rKr15WryUWFy3Jwb_yoWrKrWkp3
	97Aa1FkF4kAF4kCFyv9w1kZ39Yqr4SyrZxGryUGrWSk3yDGF17tr10gr4a9FWUCr4jg3WY
	qryj9r1fWFW5CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIF
	4iUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/27/2024 7:07 AM, Peilin Ye wrote:
> Hi Xu,
> 
> Thanks for reviewing this!
> 
> On Tue, Dec 24, 2024 at 06:07:14PM +0800, Xu Kuohai wrote:
>> On 12/21/2024 9:25 AM, Peilin Ye wrote:
>>> +__AARCH64_INSN_FUNCS(load_acq,  0x3FC08000, 0x08C08000)
>>> +__AARCH64_INSN_FUNCS(store_rel, 0x3FC08000, 0x08808000)
>>
>> I checked Arm Architecture Reference Manual [1].
>>
>> Section C6.2.{168,169,170,371,372,373} state that field Rt2 (bits 10-14) and
>> Rs (bits 16-20) for LDARB/LDARH/LDAR/STLRB/STLRH and no offset type STLR
>> instructions are fixed to (1).
>>
>> Section C2.2.2 explains that (1) means a Should-Be-One (SBO) bit.
>>
>> And the Glossary section says "Arm strongly recommends that software writes
>> the field as all 1s. If software writes a value that is not all 1s, it must
>> expect an UNPREDICTABLE or CONSTRAINED UNPREDICTABLE result."
>>
>> Although the pre-index type of STLR is an excetpion, it is not used in this
>> series. Therefore, both bits 10-14 and 16-20 in mask and value should be set
>> to 1s.
>>
>> [1] https://developer.arm.com/documentation/ddi0487/latest/
> 
> <...>
> 
>>> +	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT2, insn,
>>> +					    AARCH64_INSN_REG_ZR);
>>> +
>>> +	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
>>> +					    AARCH64_INSN_REG_ZR);
>>
>> As explained above, RS and RT2 fields should be fixed to 1s.
> 
> I'm already setting Rs and Rt2 to all 1's here, as AARCH64_INSN_REG_ZR
> is defined as 31 (0b11111):
> 
> 	AARCH64_INSN_REG_ZR = 31,
> 

I see, but the setting of fixed bits is smomewhat of a waste of jit time.

> Similar to how load- and store-exclusive instructions are handled
> currently:
> 
>>>    __AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
>>>    __AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
> 
> For example, in the manual, Rs is all (1)'s for LDXR{,B,H}, and Rt2 is
> all (1)'s for both LDXR{,B,H} and STXR{,B,H}.  However, neither Rs nor
> Rt2 bits are in the mask, and (1) bits are set manually, see
> aarch64_insn_gen_load_store_ex():
> 
>    insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT2, insn,
>                                        AARCH64_INSN_REG_ZR);
> 
>    return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
>                                        state);
> 
> (For LDXR{,B,H}, 'state' is A64_ZR, which is just an alias to
> AARCH64_INSN_REG_ZR (0b11111).)
>
> - - -
> 
> On a related note, I simply grabbed {load,store}_ex's MASK and VALUE,
> then set their 15th and 23rd bits to make them load-acquire and
> store-release:
> 
>    +__AARCH64_INSN_FUNCS(load_acq,  0x3FC08000, 0x08C08000)
>    +__AARCH64_INSN_FUNCS(store_rel, 0x3FC08000, 0x08808000)
>     __AARCH64_INSN_FUNCS(load_ex,   0x3F400000, 0x08400000)
>     __AARCH64_INSN_FUNCS(store_ex,  0x3F400000, 0x08000000)
> 
> My question is, should we extend {load,store}_ex's MASK to make them
> contain BIT(15) and BIT(23) as well?  As-is, aarch64_insn_is_load_ex()
> would return true for a load-acquire.
> 
> The only user of aarch64_insn_is_load_ex() seems to be this
> arm64-specific kprobe code in arch/arm64/kernel/probes/decode-insn.c:
> 
>    #ifdef CONFIG_KPROBES
>    static bool __kprobes
>    is_probed_address_atomic(kprobe_opcode_t *scan_start, kprobe_opcode_t *scan_end)
>    {
>            while (scan_start >= scan_end) {
>                    /*
>                     * atomic region starts from exclusive load and ends with
>                     * exclusive store.
>                     */
>                    if (aarch64_insn_is_store_ex(le32_to_cpu(*scan_start)))
>                            return false;
>                    else if (aarch64_insn_is_load_ex(le32_to_cpu(*scan_start)))
>                            return true;
> 
> But I'm not sure yet if changing {load,store}_ex's MASK would affect the
> above code.  Do you happen to know the context?
> 

IIUC, this code prevents kprobe from interrupting the LL-SC loop constructed
by LDXR/STXR pair, as the kprobe trap causes unexpected memory access that
prevents the exclusive memory access loop from exiting.

Since load-acquire/store-release instructions are not used to construct LL-SC
loop, I think it is safe to exclude them from {load,store}_ex.

>>> +	if (BPF_ATOMIC_TYPE(insn->imm) == BPF_ATOMIC_LOAD)
>>> +		ptr = src;
>>> +	else
>>> +		ptr = dst;
>>> +
>>> +	if (off) {
>>> +		emit_a64_mov_i(true, tmp, off, ctx);
>>> +		emit(A64_ADD(true, tmp, tmp, ptr), ctx);
>>
>> The mov and add instructions can be optimized to a single A64_ADD_I
>> if is_addsub_imm(off) is true.
> 
> Thanks!  I'll try this.
> 
>> I think it's better to split the arm64 related changes into two separate
>> patches: one for adding the arm64 LDAR/STLR instruction encodings, and
>> the other for adding jit support.
> 
> Got it, in the next version I'll split this patch into (a) core/verifier
> changes, (b) arm64 insn.{h,c} changes, and (c) arm64 JIT compiler
> support.
>
> Thanks,
> Peilin Ye


