Return-Path: <bpf+bounces-77571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A9CEB663
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 07:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF956303D894
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1B2F7AB8;
	Wed, 31 Dec 2025 06:47:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F69242D78;
	Wed, 31 Dec 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767163623; cv=none; b=WW3k7G0X6Z4tcu/YW6EbII8oE4QReZ2PnH8f0QAll/6bvj6nRsCetIfVAht1Ko923H7Tr+eWAJLgQMag2Ee1EPWReHQoe3seNdLP7KEnbi5CchuM5n91YQPyDG1ZFppvXaA/NRALTd0EqalRHoccXa8Y5BWheOGnxc/3rhqFt5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767163623; c=relaxed/simple;
	bh=LhPlAfohzKfAxiUT0ua7kgoP3zQla1FTN4HKy8DK7OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBiI2GXExQ9OKvUD4jEa4QJbQTXHZ5r0i+qIdJJhzClQITKKHVX67yevA0MJm3FB+Fm7T/57kkOFKB4hxRbFk4LDt9LsqsAMPPwHxE3yZEC5R21lHKVF4/6TfS5tJP6ts4KXdpJimrkA3Wk/nkFYI2eIZ4+Md7QpnmhwYKeDwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dh0pk6q9hzYQtmd;
	Wed, 31 Dec 2025 14:46:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F18A340578;
	Wed, 31 Dec 2025 14:46:56 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgA35vbdxlRpDyVwCA--.3689S2;
	Wed, 31 Dec 2025 14:46:54 +0800 (CST)
Message-ID: <50a1889b-eb5b-4a76-9dc9-b55df641170e@huaweicloud.com>
Date: Wed, 31 Dec 2025 14:46:53 +0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
 <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com>
 <0c441710-5250-4706-ba81-b6b4b1277313@huaweicloud.com>
 <CAADnVQL6PTN2PN9ngV2PSXb=csX1KX+D-BZGzDDNtvQvtGkSkA@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQL6PTN2PN9ngV2PSXb=csX1KX+D-BZGzDDNtvQvtGkSkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA35vbdxlRpDyVwCA--.3689S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4UCF15Gr45tFy8urW3KFg_yoW5ur13pF
	W8Ja4jkrW8urWUKr4kKr1UCFyftrsrA3WUXrn3JryfCrnFqr1fGF48ta1YkFn8Xr1kAr1U
	t3Wjq3s2y3WUZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/31/2025 10:16 AM, Alexei Starovoitov wrote:
> On Tue, Dec 30, 2025 at 6:05 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 12/31/2025 2:20 AM, Alexei Starovoitov wrote:
>>> On Fri, Dec 26, 2025 at 11:49 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>>
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>>>>
>>>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
>>>> ...
>>>> Call trace:
>>>>    bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>>>>    bpf_prog_run_pin_on_cpu+0x140/0x464
>>>>    bpf_prog_test_run_syscall+0x274/0x3ac
>>>>    bpf_prog_test_run+0x224/0x2b0
>>>>    __sys_bpf+0x4cc/0x5c8
>>>>    __arm64_sys_bpf+0x7c/0x94
>>>>    invoke_syscall+0x78/0x20c
>>>>    el0_svc_common+0x11c/0x1c0
>>>>    do_el0_svc+0x48/0x58
>>>>    el0_svc+0x54/0x19c
>>>>    el0t_64_sync_handler+0x84/0x12c
>>>>    el0t_64_sync+0x198/0x19c
>>>>
>>>> This happens because no BTI instruction is generated by the JIT for
>>>> indirect jump targets.
>>>>
>>>> Fix it by emitting BTI instruction for every possible indirect jump
>>>> targets when BTI is enabled. The targets are identified by traversing
>>>> all instruction arrays of jump table type used by the BPF program,
>>>> since indirect jump targets can only be read from instruction arrays
>>>> of jump table type.
>>>
>>> earlier you said:
>>>
>>>> As Anton noted, even though jump tables are currently the only type
>>>> of instruction array, users may still create insn_arrays that are not
>>>> used as jump tables. In such cases, there is no need to emit BTIs.
>>>
>>> yes, but it's not worth it to make this micro optimization in JIT.
>>> If it's in insn_array just emit BTI unconditionally.
>>> No need to do this filtering.
>>>
>>
>> Hmm, that is what the v1 version does. Please take a look. If it’s okay,
>> I’ll resend a rebased version.
>>
>> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/
> 
> I don't think you need bitmap and bpf_prog_collect_indirect_targets().
> Just look up each insn in the insn_array one at a time.
> It's slower, but array is sorted, so binary search should work.

No, an insn_array is not always sorted, as its ordering depends on how
it is initialized.

For example, with the following change to the selftest:

--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -75,7 +75,7 @@ static void check_one_to_one_mapping(void)
                 BPF_MOV64_IMM(BPF_REG_0, 0),
                 BPF_EXIT_INSN(),
         };
-       __u32 map_in[] = {0, 1, 2, 3, 4, 5};
+       __u32 map_in[] = {0, 3, 1, 2, 4, 5};
         __u32 map_out[] = {0, 1, 2, 3, 4, 5};

         __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);

the selftest will create an unsorted map, as shown below:

# bpftool m d i 74
key: 00 00 00 00  value: 00 00 00 00 00 00 00 00  24 00 00 00 00 00 00 00
key: 01 00 00 00  value: 03 00 00 00 03 00 00 00  30 00 00 00 00 00 00 00
key: 02 00 00 00  value: 01 00 00 00 01 00 00 00  28 00 00 00 00 00 00 00
key: 03 00 00 00  value: 02 00 00 00 02 00 00 00  2c 00 00 00 00 00 00 00
key: 04 00 00 00  value: 04 00 00 00 04 00 00 00  34 00 00 00 00 00 00 00
key: 05 00 00 00  value: 05 00 00 00 05 00 00 00  38 00 00 00 00 00 00 00
Found 6 elements


