Return-Path: <bpf+bounces-38947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035B96CCA3
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 04:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8516B23D2E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 02:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9BE13D53F;
	Thu,  5 Sep 2024 02:26:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4113D29A;
	Thu,  5 Sep 2024 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503207; cv=none; b=c96u37rBr2VeCCPKkVXNi9fyVEpZSirpN5UjVavAQdrOloYoEFGyAaYgsX9HSAdKaEd5z7w0zpzO7EdFFLAzv7zDSQ6x3V0DOHBTk+DEBa4SGaYtUjiHgnkXrdFV6YaLy8yCIXBCb8E0PqAPppuJbbGIA3NssBDdZKp5YOU8MwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503207; c=relaxed/simple;
	bh=sEcm9DJF0gfiNypJZXiJTIyf5gfSpEnWnsRwHngrYm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1nCSXXcbKY/0zgD+w/Dx6tiw6xOtbN0JMt6mOWiB2pbsdYv7aHZbX5g5L/svOENgDPDcPbj7BEqb4OxllW2/Cukm46F2efEIsmlKX4OBUjcbVEd2nIT9xfsN9X6sD6y9kAKh9sCHz12yVMowOAlW8Z2rT08F6tfxFW2f9djtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wzjsd0DDnz4f3kK9;
	Thu,  5 Sep 2024 10:26:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5B3FA1A13BD;
	Thu,  5 Sep 2024 10:26:39 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgB3+V7bFtlm_4W0AQ--.33113S2;
	Thu, 05 Sep 2024 10:26:36 +0800 (CST)
Message-ID: <1c88c7b7-3554-4ae6-92ca-9297c38f1bd3@huaweicloud.com>
Date: Thu, 5 Sep 2024 10:26:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/4] Fix accessing first syscall argument on
 RV64
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 patchwork-bot+netdevbpf@kernel.org
Cc: bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>,
 Networking <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 john fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
 <172548183128.1158691.9881712792582282151.git-patchwork-notify@kernel.org>
 <CAEf4BzayV1ihbfSg4fv0AqSazVycXqCJp4dTq1pwRt5hmx7X4g@mail.gmail.com>
 <CAEf4Bza5i+MFqeOs8w+Zhw4e6vt7KMgVwjNaEOTz33P8T6Ldsg@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAEf4Bza5i+MFqeOs8w+Zhw4e6vt7KMgVwjNaEOTz33P8T6Ldsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3+V7bFtlm_4W0AQ--.33113S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48XF1rAr1xJw1kJw1DJrb_yoW5GFW5pa
	y8AFWYkr4UXFW8X3Z29rWj9F1ktw4Fkry5WryUJrs5uF9FgF1Ygr1I9w4Yg3ZxXr97G3ya
	vr12vasI9342vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/9/5 8:03, Andrii Nakryiko wrote:
> On Wed, Sep 4, 2024 at 3:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>>
>>
>> On Wed, Sep 4, 2024 at 1:30 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>
>>> Hello:
>>>
>>> This series was applied to bpf/bpf-next.git (master)
>>> by Andrii Nakryiko <andrii@kernel.org>:
>>>
>>> On Sat, 31 Aug 2024 04:19:30 +0000 you wrote:
>>>> On RV64, as Ilya mentioned before [0], the first syscall parameter should be
>>>> accessed through orig_a0 (see arch/riscv64/include/asm/syscall.h),
>>>> otherwise it will cause selftests like bpf_syscall_macro, vmlinux,
>>>> test_lsm, etc. to fail on RV64.
>>>>
>>>> Link: https://lore.kernel.org/bpf/20220209021745.2215452-1-iii@linux.ibm.com [0]
>>>>
>>>> [...]
>>>
>>> Here is the summary with links:
>>>    - [bpf-next,v3,1/4] libbpf: Access first syscall argument with CO-RE direct read on s390
>>>      https://git.kernel.org/bpf/bpf-next/c/65ee11d9c822
>>>    - [bpf-next,v3,2/4] libbpf: Access first syscall argument with CO-RE direct read on arm64
>>>      https://git.kernel.org/bpf/bpf-next/c/ebd8ad474888
>>>    - [bpf-next,v3,3/4] selftests/bpf: Enable test_bpf_syscall_macro:syscall_arg1 on s390 and arm64
>>>      https://git.kernel.org/bpf/bpf-next/c/3a913c4d62e1
>>>    - [bpf-next,v3,4/4] libbpf: Fix accessing first syscall argument on RV64
>>>      https://git.kernel.org/bpf/bpf-next/c/13143c5816bc
>>>
>>
>> Ok, I had to "unapply" these patches, as s390x selftest (bpf_syscall_macro) started failing (arm64 is fine, so I think it's probably due to patch #3 that changes selftests itself).
>>
>> Pu, can you please take a look at that (e.g., see [0])? It's a bit strange, as originally no error was reported, so not sure what changed. Please also see the things I was fixing up while applying, so I don't have to do it again :)
>>
>>    [0] https://github.com/kernel-patches/bpf/actions/runs/10709024755/job/29693056550#step:5:8746
> 
> Oh, I figured it out! That tmp is there for a reason! We
> bpf_probe_read_kernel() 8 bytes, but syscall's 1st argument itself is
> 4 byte long, so we need to cast u64 to u32. And s390x being the big
> endian architecture detected this problem, while for arm64 we were
> lucky.
> 
> So never mind, I'll apply your patches with fix ups in the
> bpf_tracing.h header, but I won't touch patch #3.

Sorry for couldn't reply in time due to jet lag. Glad the issue didn't 
block in the end.😄

> 
>>
>>> You are awesome, thank you!
>>> --
>>> Deet-doot-dot, I am a bot.
>>> https://korg.docs.kernel.org/patchwork/pwbot.html
>>>
>>>


