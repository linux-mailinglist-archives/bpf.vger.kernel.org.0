Return-Path: <bpf+bounces-77672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1ACCEE0D6
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 10:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 011C83008D59
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A02D662D;
	Fri,  2 Jan 2026 09:23:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195561F3B87;
	Fri,  2 Jan 2026 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767345787; cv=none; b=OdakXk2az9Tg3XFfCxvNYhI9MGTXedACD4ZfMTOX8/YxufrnMp2BSaeohQLaTDidscz3wk3a0vkTIgIOhw1fhaEMlLi1Uw7kKpyNADiv0cM3p1qqz1IEzT3712wwthbdIxwh59Ham6TxW/PtIzKNh4lcR3eGqyCyyIgTU2sTflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767345787; c=relaxed/simple;
	bh=JRLeVjtHXrQkook4/ALUDEtQtaAz7EwiSWYvg2Y+Ifc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fh29pDSnwNuxLUuiHVwq+/J6Pso/62X/MlN6cwaOYsVkA9BHH9uZWsjbuFp8NP8GuX8qpbVbjKKkWozMeCg1jJ4R1yxqGtYWkn1femSAithFUSoUj583n5Wvo91MIHl7nlT8NOa2lseXzVCheuUzGu6I/NIPBNFkdEnrB2v52Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4djJB60lz4zKHMjF;
	Fri,  2 Jan 2026 17:22:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7F1724058A;
	Fri,  2 Jan 2026 17:22:55 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgAXeflsjldpmuBrCQ--.22085S2;
	Fri, 02 Jan 2026 17:22:53 +0800 (CST)
Message-ID: <92cc8651-e802-4e66-90ee-313e70695be3@huaweicloud.com>
Date: Fri, 2 Jan 2026 17:22:52 +0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
 <ce484a55ffa709dcfcacd631213b3b1ff1938c7a.camel@gmail.com>
 <CAADnVQJp7bqUynwYtmbuCJVbMoN++Va63OA+8NFgW4PoPKRgKQ@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQJp7bqUynwYtmbuCJVbMoN++Va63OA+8NFgW4PoPKRgKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXeflsjldpmuBrCQ--.22085S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWxKF1UWF13KF4xJF4kXrb_yoW5Jw4DpF
	WkXa4j9FWq9rWrCr4IgF4UCFy3trsxJF15Xr4kt343W3Wa9rn3tF4IgF4a9FnrWr4rC3y0
	qa1jkF9a9a4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 1/1/2026 7:42 AM, Alexei Starovoitov wrote:
> On Wed, Dec 31, 2025 at 2:35 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Sat, 2025-12-27 at 16:10 +0800, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>>>
>>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
>>> ...
>>> Call trace:
>>>   bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>>>   bpf_prog_run_pin_on_cpu+0x140/0x464
>>>   bpf_prog_test_run_syscall+0x274/0x3ac
>>>   bpf_prog_test_run+0x224/0x2b0
>>>   __sys_bpf+0x4cc/0x5c8
>>>   __arm64_sys_bpf+0x7c/0x94
>>>   invoke_syscall+0x78/0x20c
>>>   el0_svc_common+0x11c/0x1c0
>>>   do_el0_svc+0x48/0x58
>>>   el0_svc+0x54/0x19c
>>>   el0t_64_sync_handler+0x84/0x12c
>>>   el0t_64_sync+0x198/0x19c
>>>
>>> This happens because no BTI instruction is generated by the JIT for
>>> indirect jump targets.
>>>
>>> Fix it by emitting BTI instruction for every possible indirect jump
>>> targets when BTI is enabled. The targets are identified by traversing
>>> all instruction arrays of jump table type used by the BPF program,
>>> since indirect jump targets can only be read from instruction arrays
>>> of jump table type.
>>>
>>> Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>> ---
>>> v3:
>>> - Get rid of unnecessary enum definition (Yonghong Song, Anton Protopopov)
>>>
>>> v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huaweicloud.com/
>>> - Exclude instruction arrays not used for indirect jumps (Anton Protopopov)
>>>
>>> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
>>> ---
>>
>> Hi Xu, Anton, Alexei,
>>
>> Sorry, I'm a bit late to the discussion, ignored this patch-set
>> because of the "arm64" tag.
>>
>> What you are fixing here for arm64 will be an issue for x86 with CFI
>> as well, right?
>>
>> If that is the case, I think that we should fix this in a "generic"
>> way from the start. What do you think about the following:
>> - add a field 'bool indirect_jmp_target' to 'struct bpf_insn_aux_data'
> 
> makes sense to me. u8 :1 pls.
>

Got it, will do, thanks

>> - set this field to true for each jump target inspected by the
>>    verifier.c:check_indirect_jump()
>> - use this field in the jit to decide if to emit BTI instruction.
>>
>> Seems a bit simpler than what is discussed in this patch-set.
>> Wdyt?
>>
>> [...]


