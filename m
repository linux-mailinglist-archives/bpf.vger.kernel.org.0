Return-Path: <bpf+bounces-20012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B874836B85
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCABB2CD0E
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8D14D443;
	Mon, 22 Jan 2024 15:18:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656414D42A;
	Mon, 22 Jan 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936681; cv=none; b=bRnCCm0HtHdVRZQeKQJ5Xm5j2pxSHBAUHL55ybpy9HI6wF5uD5qMaMdQK4+2ZPOwVhpqAx1QBaqFNV4i0HyDSdpHF64EO+sggNzVIFCqvAmPvXgezrTsb9YqZW8FzmZhBkJ/J53hnXxlpKeP1xcSh5VfD7bdlXtFjPqlbpMD9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936681; c=relaxed/simple;
	bh=qu5/X1JqruAYyC5ZFQ5B1kSNBmoxwed+pV7K3PVqdUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajsY1pzH/0LsSqwzxyAZOOas8ecrEM1uAWk38boB9N+MopLfB2junSbFzASvPcNxPPkIP9T7eTFmWUelZQFgdqQ/D1KrdWte1kYuoIlJU3TgW+0JYWLY9ESeYMYcY6aIz5tMKaXk2jU2UkcpMZ60CB2sAZZ/+X+DI5hbZQ7lSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TJYkT1FwCz4f3jqZ;
	Mon, 22 Jan 2024 23:17:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 771DD1A0272;
	Mon, 22 Jan 2024 23:17:55 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgCHqg0ih65l2k2mBg--.27335S2;
	Mon, 22 Jan 2024 23:17:55 +0800 (CST)
Message-ID: <f73cdabe-eba3-4842-8da2-a6316590eb1e@huaweicloud.com>
Date: Mon, 22 Jan 2024 23:17:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v3 0/6] Zbb support and code
 simplification for RV64 JIT
Content-Language: en-US
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
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <874jf5qudx.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHqg0ih65l2k2mBg--.27335S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1DJFy3Xr4DJrW3ZryUtrb_yoW8GrWDpF
	WrG3Wqya18tr1xCw10vFy0gFWUK3yYqr17Xr10qryY9r1qgry5KF4jvF1jkw1kCr4Igrya
	y3yYy347A34UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/1/22 23:07, Björn Töpel wrote:
> Björn Töpel <bjorn@kernel.org> writes:
> 
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>
>>> On 2024/1/22 22:33, Björn Töpel wrote:
>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>
>>>>> Add Zbb support [0] to optimize code size and performance of RV64 JIT.
>>>>> Meanwhile, adjust the code for unification and simplification. Tests
>>>>> test_bpf.ko and test_verifier have passed, as well as the relative
>>>>> testcases of test_progs*.
>>>>>
>>>>> Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]
>>>>>
>>>>> v3 resend:
>>>>> - resend for mail be treated as spam.
>>>>>
>>>>> v3:
>>>>> - Change to early-exit code style and make code more explicit.
>>>>
>>>> Lehui,
>>>>
>>>> Sorry for the delay. I'm chasing a struct_ops RISC-V BPF regression in
>>>> 6.8-rc1, I will need to wrap my head around that prior reviewing
>>>> properly.
>>>>
>>>
>>> Oh, I also found the problem with struct ops and fixed it
> 
> Pu, with your patch bpf_iter_setsockopt, bpf_tcp_ca, and dummy_st_ops
> passes!
> 
> Please spin a proper fixes patch, and feel free to add:
> 
> Tested-by: Björn Töpel <bjorn@rivosinc.com>
> Acked-by: Björn Töpel <bjorn@kernel.org>
> 

Is that in a hurry? If not, I would like to send it with the upcoming 
patchset.

> 
> Björn


