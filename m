Return-Path: <bpf+bounces-77579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D75ECCEBADA
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6606430080EB
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2B304BB7;
	Wed, 31 Dec 2025 09:22:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC5315D5E;
	Wed, 31 Dec 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172942; cv=none; b=rKdJB2soW9jTrY3OTW7dzIISE8FhRuHUo+/f6PnCxbFUS0mdNvkwAtLG+XW8zZ5pIkff7GXIzTFuY9WdrYrnwBpOZLKkkucwXSwcL4Oarrc71xTRgrofM7m5xuBhKQ4VqrN0/6rSVa4euGe5XGnfRu2DutbDhm676zh5mHEirJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172942; c=relaxed/simple;
	bh=j8gfTjY6K4xeLpnqee81OiSd+6DCO3A+eF4CiKxzsjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NI/nQSORtHe1ydojzmHkAjwz2FnG62f4AIwRSufWejFHHWppabIgxbEurGsDRctM65XfzIVkU1bmUA01QmYVkZ2/83MJsUdN6hiP3/Cn20wb7jF4e7Vui5vN+wlOfXiVC3OgZuHEJMM0izrx1CqMko+OctglX6Ui3F0BJVvbxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dh4Fx2bs1zYQv4B;
	Wed, 31 Dec 2025 17:21:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8BA8540573;
	Wed, 31 Dec 2025 17:22:15 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgCn8xFC61RpPs5QCA--.61833S2;
	Wed, 31 Dec 2025 17:22:11 +0800 (CST)
Message-ID: <a51149f1-cd63-4eaf-98dc-53be880930ab@huaweicloud.com>
Date: Wed, 31 Dec 2025 17:22:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Content-Language: en-US
To: Anton Protopopov <a.s.protopopov@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
 <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com>
 <0c441710-5250-4706-ba81-b6b4b1277313@huaweicloud.com>
 <CAADnVQL6PTN2PN9ngV2PSXb=csX1KX+D-BZGzDDNtvQvtGkSkA@mail.gmail.com>
 <50a1889b-eb5b-4a76-9dc9-b55df641170e@huaweicloud.com>
 <CAGn_itzSC7K_eF7Lbm-im83VObqqoz6rvYMqVAOCXdD0pQ+M6Q@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAGn_itzSC7K_eF7Lbm-im83VObqqoz6rvYMqVAOCXdD0pQ+M6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCn8xFC61RpPs5QCA--.61833S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7CFyfurWfWw18GFyUKFg_yoWrKr4xpF
	48Ja4jkrW8WrW8tr4DKr1UCF1ftrs8AF15Wrn3J34xCrn0qrnxKF48tF4akFn8Gr1UAr1j
	qF4jqas2qF4UZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/31/2025 3:06 PM, Anton Protopopov wrote:
> On Wed, Dec 31, 2025 at 7:47 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 12/31/2025 10:16 AM, Alexei Starovoitov wrote:
>>> On Tue, Dec 30, 2025 at 6:05 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>
>>>> On 12/31/2025 2:20 AM, Alexei Starovoitov wrote:
>>>>> On Fri, Dec 26, 2025 at 11:49 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>>>
>>>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>>>
>>>>>> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>>>>>>
>>>>>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
>>>>>> ...
>>>>>> Call trace:
>>>>>>     bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>>>>>>     bpf_prog_run_pin_on_cpu+0x140/0x464
>>>>>>     bpf_prog_test_run_syscall+0x274/0x3ac
>>>>>>     bpf_prog_test_run+0x224/0x2b0
>>>>>>     __sys_bpf+0x4cc/0x5c8
>>>>>>     __arm64_sys_bpf+0x7c/0x94
>>>>>>     invoke_syscall+0x78/0x20c
>>>>>>     el0_svc_common+0x11c/0x1c0
>>>>>>     do_el0_svc+0x48/0x58
>>>>>>     el0_svc+0x54/0x19c
>>>>>>     el0t_64_sync_handler+0x84/0x12c
>>>>>>     el0t_64_sync+0x198/0x19c
>>>>>>
>>>>>> This happens because no BTI instruction is generated by the JIT for
>>>>>> indirect jump targets.
>>>>>>
>>>>>> Fix it by emitting BTI instruction for every possible indirect jump
>>>>>> targets when BTI is enabled. The targets are identified by traversing
>>>>>> all instruction arrays of jump table type used by the BPF program,
>>>>>> since indirect jump targets can only be read from instruction arrays
>>>>>> of jump table type.
>>>>>
>>>>> earlier you said:
>>>>>
>>>>>> As Anton noted, even though jump tables are currently the only type
>>>>>> of instruction array, users may still create insn_arrays that are not
>>>>>> used as jump tables. In such cases, there is no need to emit BTIs.
>>>>>
>>>>> yes, but it's not worth it to make this micro optimization in JIT.
>>>>> If it's in insn_array just emit BTI unconditionally.
>>>>> No need to do this filtering.
>>>>>
>>>>
>>>> Hmm, that is what the v1 version does. Please take a look. If it’s okay,
>>>> I’ll resend a rebased version.
>>>>
>>>> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
>>>
>>> I don't think you need bitmap and bpf_prog_collect_indirect_targets().
>>> Just look up each insn in the insn_array one at a time.
>>> It's slower, but array is sorted, so binary search should work.
>>
>> No, an insn_array is not always sorted, as its ordering depends on how
>> it is initialized.
>>
>> For example, with the following change to the selftest:
>>
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
>> @@ -75,7 +75,7 @@ static void check_one_to_one_mapping(void)
>>                   BPF_MOV64_IMM(BPF_REG_0, 0),
>>                   BPF_EXIT_INSN(),
>>           };
>> -       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
>> +       __u32 map_in[] = {0, 3, 1, 2, 4, 5};
>>           __u32 map_out[] = {0, 1, 2, 3, 4, 5};
>>
>>           __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
>>
>> the selftest will create an unsorted map, as shown below:
>>
>> # bpftool m d i 74
>> key: 00 00 00 00  value: 00 00 00 00 00 00 00 00  24 00 00 00 00 00 00 00
>> key: 01 00 00 00  value: 03 00 00 00 03 00 00 00  30 00 00 00 00 00 00 00
>> key: 02 00 00 00  value: 01 00 00 00 01 00 00 00  28 00 00 00 00 00 00 00
>> key: 03 00 00 00  value: 02 00 00 00 02 00 00 00  2c 00 00 00 00 00 00 00
>> key: 04 00 00 00  value: 04 00 00 00 04 00 00 00  34 00 00 00 00 00 00 00
>> key: 05 00 00 00  value: 05 00 00 00 05 00 00 00  38 00 00 00 00 00 00 00
>> Found 6 elements
> 
> Yes, it is not always sorted (jump tables aren't guaranteed to be
> sorted or have unique values).
> 
> To get rid of bpf_prog_collect_indirect_targets() in internal API,
> this is possible to just implement this inside arm JIT. If later it is
> needed in more cases, it can be generalized.
> 
> Also, how bad is this to generate BTI instructions not only for jump
> targets (say, for all instructions in the program)? If this is ok-ish
> (this is a really rare condition now), then `bool is_jump_table` might
> be dropped for now. (I will add similar code when add static keys and
> indirect calls such that they aren't counted for BTI.)
>

IIUC, in practice insn_array usually contains only a few elements, so using
a simple linear search should be sufficient.

In corner cases, such as when all instructions are included in an insn_array
but only a few are actually used as indirect jump targets, even is_jump_table
would not prevent BTI from being jited for non-jump-target instructions. To
completely avoid this, more precise information about which instructions are
actually used as indirect jump targets would be required.


