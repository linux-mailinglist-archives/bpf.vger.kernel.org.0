Return-Path: <bpf+bounces-39190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6767970086
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9405F2814E6
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079645979;
	Sat,  7 Sep 2024 07:03:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605818030
	for <bpf@vger.kernel.org>; Sat,  7 Sep 2024 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725692620; cv=none; b=Q2zWtWRc+M3bSGCruXMENSENvwVsdumcaKXTX449PX/7XkOZQlHvpWNPKomHXY9XpNRjtRR162ersAWM2zNbzSePZOc3yQSxlB7X1eaP6DnzRUdoUhHFo3l4uxiWrmjCZV3pK68AFK6Nqhzh1Wtmxti0fpH04RbEv263oxNKnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725692620; c=relaxed/simple;
	bh=8abuypkhjh8PEkT2kR1o3zPeeG26kVYdJxJSq1loRLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCC9SsXIjsNPAqX+KysEWMhvuQjPYMB1uUYfI2FWXJB81Mo/TJEypomkA4bt5388oY5hIAgHK5HhGcXMNQqHy79r1Jw2jaZtSFo7Am9+KKCRJy6ISriiHcsZrPMc8KHxJqXx7WqKRb/dbjNEf0DICTldMjuozJ9iFYP7GGWyisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X13w52pFrz4f3jsf
	for <bpf@vger.kernel.org>; Sat,  7 Sep 2024 15:03:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8E9451A1305
	for <bpf@vger.kernel.org>; Sat,  7 Sep 2024 15:03:32 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgAHMy_B+ttmAEF1Ag--.15767S2;
	Sat, 07 Sep 2024 15:03:30 +0800 (CST)
Message-ID: <c8fc7c23-443a-4a6a-b06e-ce7f8f3de748@huaweicloud.com>
Date: Sat, 7 Sep 2024 15:03:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
References: <20240825130943.7738-1-leon.hwang@linux.dev>
 <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com>
 <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
 <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com>
 <mb61ped5ysbso.fsf@kernel.org>
 <007b71a8-ccaa-43f4-a24e-903d3ee9cbec@linux.dev>
 <CAADnVQJcxX=X=MRqg9ToharLAfvMWLVptTU2x9YW6cNt5BsWdw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQJcxX=X=MRqg9ToharLAfvMWLVptTU2x9YW6cNt5BsWdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHMy_B+ttmAEF1Ag--.15767S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr48CrW8KFyUXF1DJFy8AFb_yoW5Jr47pF
	y8Xay3Ka1UJr1UAr1Iyw1xXa43t34UXry5Wrn8Kr18Gr90vF1rJF4rKr45uF9xWr4IkF42
	qr47Wa9xua4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 9/6/2024 11:24 PM, Alexei Starovoitov wrote:
> On Fri, Sep 6, 2024 at 7:32 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 2024/9/5 17:13, Puranjay Mohan wrote:
>>> Xu Kuohai <xukuohai@huaweicloud.com> writes:
>>>
>>>> On 8/27/2024 10:23 AM, Leon Hwang wrote:
>>>>>
>>>>>
>>>>> On 26/8/24 22:32, Xu Kuohai wrote:
>>>>>> On 8/25/2024 9:09 PM, Leon Hwang wrote:
>>>>>>> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
>>>>>>> issue happens on arm64, too.
>>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>> This patch makes arm64 jited prologue even more complex. I've posted a
>>>>>> series [1]
>>>>>> to simplify the arm64 jited prologue/epilogue. I think we can fix this
>>>>>> issue based
>>>>>> on [1]. I'll give it a try.
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/bpf/20240826071624.350108-1-xukuohai@huaweicloud.com/
>>>>>>
>>>>>
>>>>> Your patch series seems great. We can fix it based on it.
>>>>>
>>>>> Please notify me if you have a successful try.
>>>>>
>>>>
>>>> I think the complexity arises from having to decide whether
>>>> to initialize or keep the tail counter value in the prologue.
>>>>
>>>> To get rid of this complexity, a straightforward idea is to
>>>> move the tail call counter initialization to the entry of
>>>> bpf world, and in the bpf world, we only increase and check
>>>> the tail call counter, never save/restore or set it. The
>>>> "entry of the bpf world" here refers to mechanisms like
>>>> bpf_prog_run, bpf dispatcher, or bpf trampoline that
>>>> allows bpf prog to be invoked from C function.
>>>>
>>>> Below is a rough POC diff for arm64 that could pass all
>>>> of your tests. The tail call counter is held in callee-saved
>>>> register x26, and is set to 0 by arch_run_bpf.
>>>
>>> I like this approach as it removes all the complexity of handling tcc in
>>
>> I like this approach, too.
>>
>>> different cases. Can we go ahead with this for arm64 and make
>>> arch_run_bpf a weak function and let other architectures override this
>>> if they want to use a similar approach to this and if other archs want to
>>> do something else they can skip implementing arch_run_bpf.
>>>
>>
>> Hi Alexei,
>>
>> What do you think about this idea?
> 
> This was discussed before and no, we're not going to add an extra tcc init
> to bpf_prog_run and penalize everybody for this niche case.

+1, we should avoid hacking jit and adding complexity just for a niche case.


