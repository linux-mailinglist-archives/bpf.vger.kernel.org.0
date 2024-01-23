Return-Path: <bpf+bounces-20062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C69D68383FB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 03:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3489DB2B96F
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6064A92;
	Tue, 23 Jan 2024 01:57:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6275634F8;
	Tue, 23 Jan 2024 01:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975038; cv=none; b=IPVYpi5gIIFsYQ6UAZ36Bjea0Z5Kc3mkr9Cslex9WcALLxsz7+0fbR0RA0ELoBLjejvucqL9Cq9347Ovnjdy/L71013AscgS03p4BHxL9cmH+ZsrUWRiyVkY1PWZFQdVolftd1Lz/Mw0+CIhjDGGKhlSjIc7oGGJpK3QyNTOrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975038; c=relaxed/simple;
	bh=oTBYcPw4Bi5zhPawRG+3t5oFeX2z+94XRzWapGIQrWg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pbjZ6exaQw9OswiyPWvzMdZsC/t1Lt9M7/bTzK4PpMF2CaqJQzkxuexkHmC0XHwZkZYaSszrn+fobccUxvbv+Mlxi0DBSgOU8uFDGvh2ArI8eRfhMrUDw9l7YxLAWSmAcncx4aBa2vX1UYYGyxgbCsxJTPgZaxR/DvOGXJxD1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TJqvy58hYz4f3jY9;
	Tue, 23 Jan 2024 09:57:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9B89F1A038B;
	Tue, 23 Jan 2024 09:57:06 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgAn9w_xHK9lMo29Bg--.34883S2;
	Tue, 23 Jan 2024 09:57:06 +0800 (CST)
Message-ID: <ee922f6a-4bd0-48e7-bb9a-373b41e6a5d4@huaweicloud.com>
Date: Tue, 23 Jan 2024 09:57:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code
 simplification for RV64 JIT
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240115131235.2914289-1-pulehui@huaweicloud.com>
 <87il3lqvye.fsf@all.your.base.are.belong.to.us>
 <baffbab8-721f-462a-8b58-64972f5eae70@huaweicloud.com>
 <878r4hqvgq.fsf@all.your.base.are.belong.to.us>
 <874jf5qudx.fsf@all.your.base.are.belong.to.us>
 <f73cdabe-eba3-4842-8da2-a6316590eb1e@huaweicloud.com>
 <87zfwxpbzp.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
In-Reply-To: <87zfwxpbzp.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9w_xHK9lMo29Bg--.34883S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyftFy5tFyxtFyxWFWktFb_yoW8ZrW8pF
	y8K3Z0k3W8Jr1fJw10yFyjgFWUKw4Yqr13Wr18XrWUur1qqry5KF4UuF15Cw1kCrnFgrya
	y3yYv347A34UAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/1/23 0:30, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> On 2024/1/22 23:07, Björn Töpel wrote:
>>> Björn Töpel <bjorn@kernel.org> writes:
>>>
>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>
>>>>> On 2024/1/22 22:33, Björn Töpel wrote:
>>>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>>>
>>>>>>> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
>>>>>>> Meanwhile, adjust the code for unification and simplification. Tests
>>>>>>> test_bpf.ko and test_verifier have passed, as well as the relative
>>>>>>> testcases of test_progs*.
>>>>>>>
>>>>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>>>>>
>>>>>>> v3 resend:
>>>>>>> - resend for mail be treated as spam.
>>>>>>>
>>>>>>> v3:
>>>>>>> - Change to early-exit code style and make code more explicit.
>>>>>>
>>>>>> Lehui,
>>>>>>
>>>>>> Sorry for the delay. I'm chasing a struct_ops RISC-V BPF regression in
>>>>>> 6.8-rc1, I will need to wrap my head around that prior reviewing
>>>>>> properly.
>>>>>>
>>>>>
>>>>> Oh, I also found the problem with struct ops and fixed it
>>>
>>> Pu, with your patch bpf_iter_setsockopt, bpf_tcp_ca, and dummy_st_ops
>>> passes!
>>>
>>> Please spin a proper fixes patch, and feel free to add:
>>>
>>> Tested-by: Björn Töpel <bjorn@rivosinc.com>
>>> Acked-by: Björn Töpel <bjorn@kernel.org>
>>>
>>
>> Is that in a hurry? If not, I would like to send it with the upcoming
>> patchset.
> 
> This is a separate fix, right? What patchset are you referring to where
> the fix would be in?
> 

Yes, you are right! I'll send a bug fix patch as soon as possible. 
Coming soon is the bpf_prog_pack for RV64 Trampoline, which currently 
does not seem to be related to the bugfix, will populate the commit 
message and send it later.😁

> As of now 6.8-rc1 is broken! It would be a great with a fix asap...
> 
> 
> Cheers,
> Björn


