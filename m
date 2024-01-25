Return-Path: <bpf+bounces-20306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EB083BA31
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 07:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C07C1C25675
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438A6FAE;
	Thu, 25 Jan 2024 06:37:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695D1A71F;
	Thu, 25 Jan 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164675; cv=none; b=WI7YHHjSq5Jlf4bbNDT1YOYM5/7wGLtIfMt7KgBMgx3FogIhCg5AMWrBCVI/DOnXraYwuduZKRnSjlJV0xakEMbDW6jShBhwaTJkQ9niz+bEqB0P+BfsRq5Qc9tbjkO79PI+w4QMv43eGaeAZW5ZUkt8d2KUnBiX4DUW6KHLxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164675; c=relaxed/simple;
	bh=UvN2JNG3WB4C5D3XZIh/oWXGBGhfctOhs/FEXZHIj2w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FWBRC1Zfjrv4vFWFsGGSowgiY/zSizxFT1XX8msRkJB3XiyI9YiL1dDaIXhodbuJmozed3KiefPBIADFu/6Ia/pYAzO0EiW/jZNEJiOGWV/EReE9j/WvqheKpqpXTYIrBWBDrJX4rt78XopsITgMgQvBv7NQ8qm25j/R03a9bqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TLB2y5hS2z4f3jYM;
	Thu, 25 Jan 2024 14:37:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B9D711A017A;
	Thu, 25 Jan 2024 14:37:50 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAXOg29AbJlpavFBw--.21614S2;
	Thu, 25 Jan 2024 14:37:50 +0800 (CST)
Subject: Re: [PATCH bpf 3/3] selftest/bpf: Test the read of vsyscall page
 under x86-64
To: Yonghong Song <yonghong.song@linux.dev>, x86@kernel.org,
 bpf@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, xingwei lee <xrivendell7@gmail.com>,
 Jann Horn <jannh@google.com>, houtao1@huawei.com
References: <20240119073019.1528573-1-houtao@huaweicloud.com>
 <20240119073019.1528573-4-houtao@huaweicloud.com>
 <f227d88b-963a-4df0-a6bc-ad3b12abe6dd@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f83cd515-1492-229a-913a-aa542ecd1d74@huaweicloud.com>
Date: Thu, 25 Jan 2024 14:37:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f227d88b-963a-4df0-a6bc-ad3b12abe6dd@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAXOg29AbJlpavFBw--.21614S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47XryUCw1UCFy7CrWDtwb_yoWrCF48p3
	WkAay5KrWfJwnayr17XrZ8uFyrAF1kGa15tr1FqF15Zr47Zr9YgryagFyqgr1fJrsY9w45
	Zr10g3s3ur1UJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UQzVbUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/22/2024 2:30 PM, Yonghong Song wrote:
>
> On 1/18/24 11:30 PM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Using bpf_probe_read_kernel{_str}() or bpf_probe_read{_str}() to read
>> from vsyscall page under x86-64 will trigger oops, so add one test case
>> to ensure that the problem is fixed.
>>
>> Beside those four bpf helpers mentioned above, testing the read of
>> vsyscall page by using bpf_probe_read_user{_str} and
>> bpf_copy_from_user{_task}() as well.
>>
>> vsyscall page could be disabled by CONFIG_LEGACY_VSYSCALL_NONE or
>> vsyscall=none boot cmd-line, but it doesn't affect the reproduce of the
>> problem and the returned error codes.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>   .../selftests/bpf/prog_tests/read_vsyscall.c  | 61 +++++++++++++++++++
>>   .../selftests/bpf/progs/read_vsyscall.c       | 45 ++++++++++++++
>>   2 files changed, 106 insertions(+)
>>   create mode 100644
>> tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/read_vsyscall.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
>> b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
>> new file mode 100644
>> index 0000000000000..d9247cc89cf3e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2024. Huawei Technologies Co., Ltd */
>> +#include "test_progs.h"
>> +#include "read_vsyscall.skel.h"
>> +
>> +#if defined(__x86_64__)
>> +/* For VSYSCALL_ADDR */
>> +#include <asm/vsyscall.h>
>> +#else
>> +/* To prevent build failure on non-x86 arch */
>> +#define VSYSCALL_ADDR 0UL
>> +#endif
>> +
>> +struct read_ret_desc {
>> +    const char *name;
>> +    int ret;
>> +} all_read[] = {
>> +    { .name = "probe_read_kernel", .ret = -ERANGE },
>> +    { .name = "probe_read_kernel_str", .ret = -ERANGE },
>> +    { .name = "probe_read", .ret = -ERANGE },
>> +    { .name = "probe_read_str", .ret = -ERANGE },
>> +    /* __access_ok() will fail */
>> +    { .name = "probe_read_user", .ret = -EFAULT },
>> +    /* __access_ok() will fail */
>> +    { .name = "probe_read_user_str", .ret = -EFAULT },
>> +    /* access_ok() will fail */
>> +    { .name = "copy_from_user", .ret = -EFAULT },
>> +    /* both vma_lookup() and expand_stack() will fail */
>> +    { .name = "copy_from_user_task", .ret = -EFAULT },
>
> The above comments are not clear enough. For example,
> '__access_ok() will fail', user will need to
> check the source code where __access_ok() is and
> this could be hard e.g., for probe_read_user_str().
> Another example, 'both vma_lookup() and expand_stack() will fail',
> where is vma_lookup()/expand_stack()? User needs to further
> check to make sense.

Yes. These comment are highly coupled with the implementation.
>
> I suggest remove the above comments and add more
> detailed explanation in commit messages with callstack
> indicating where the fail/error return happens.

Will do in v2. Thanks for the suggestions.
>
>> +};
>> +
>> +void test_read_vsyscall(void)
>> +{
>> +    struct read_vsyscall *skel;
>> +    unsigned int i;
>> +    int err;
>> +
>> +#if !defined(__x86_64__)
>> +    test__skip();
>> +    return;
>> +#endif
>> +    skel = read_vsyscall__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "read_vsyscall open_load"))
>> +        return;
>> +
>> +    skel->bss->target_pid = getpid();
>> +    err = read_vsyscall__attach(skel);
>> +    if (!ASSERT_EQ(err, 0, "read_vsyscall attach"))
>> +        goto out;
>> +
>> +    /* userspace may don't have vsyscall page due to
>> LEGACY_VSYSCALL_NONE,
>> +     * but it doesn't affect the returned error codes.
>> +     */
>> +    skel->bss->user_ptr = (void *)VSYSCALL_ADDR;
>> +    usleep(1);
>> +
>> +    for (i = 0; i < ARRAY_SIZE(all_read); i++)
>> +        ASSERT_EQ(skel->bss->read_ret[i], all_read[i].ret,
>> all_read[i].name);
>> +out:
>> +    read_vsyscall__destroy(skel);
>> +}
> [...]


