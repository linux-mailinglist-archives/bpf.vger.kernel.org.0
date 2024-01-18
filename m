Return-Path: <bpf+bounces-19770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AAA8310E9
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE891F218C7
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A501C2F;
	Thu, 18 Jan 2024 01:33:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2369184C;
	Thu, 18 Jan 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541585; cv=none; b=qrsgxR1FUeYHpMTN99+xy3teFRIwKtBAGzVQDsmqrodQh9Ay0MTTVlatxVAsXj9X8LkZ27VDc1YMx3BSHYmR8e0eMNE3e+V+RLbsk6RbMLHGECH6XJ71nxbW4R3NOLZ6T59eW2K9yi6zmFKyhObqn999v6H3o/UIzMM0ROMGmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541585; c=relaxed/simple;
	bh=KPjwrRdZuRXJ5fn+977wPl2el6iS2vvm2GIKarAZzgo=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=dnpi0egfFXujEhVCAyQzKVuK4l4BnTdfu1RuaPeWsKx9dR6cHMf2T+e4U0Hst6E8MAvmHYg7APn97uzvFwis1HEIR/1SHdy/tlakXqHJ3Z6njqaM/aYNM1oQtIw950Y9sfj3INy4KMz4I7HjtIgixeARziI9U2CwyPwznDjmGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFlcQ5RHgz4f3m77;
	Thu, 18 Jan 2024 09:32:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB4F11A016E;
	Thu, 18 Jan 2024 09:33:00 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXKWzJf6hlkn60BA--.8078S2;
	Thu, 18 Jan 2024 09:33:00 +0800 (CST)
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Song Liu <song@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240117111000.12763-1-yangtiezhu@loongson.cn>
 <20240117111000.12763-4-yangtiezhu@loongson.cn>
 <CAPhsuW6mWoQQ1M-uPE_i+RWv=t5GaVqUDAObWgpEC-PCYSbwHQ@mail.gmail.com>
 <342f1c7f-a8d3-dbba-a45f-66fc672883be@huaweicloud.com>
 <CAPhsuW78ONz23-X_6AKt1SfVfepfNP=h=EUAjtUG+K1cKMVH2A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <eb7734bc-b516-f179-49bf-937e205f1fae@huaweicloud.com>
Date: Thu, 18 Jan 2024 09:32:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW78ONz23-X_6AKt1SfVfepfNP=h=EUAjtUG+K1cKMVH2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXKWzJf6hlkn60BA--.8078S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFykuw4kAw1rur1DuF18Grg_yoW8KF45pa
	4xJF4DKFW8tFy2vw12vw1kXFsFyr4kGr15WFs5GF17Z3s0kF13Ka95GF45WFykurnYvFy7
	Zw4j9rW3uryUta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 1/18/2024 9:27 AM, Song Liu wrote:
> Hi,
>
> On Wed, Jan 17, 2024 at 5:11 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi Song,
>>
>> On 1/18/2024 1:20 AM, Song Liu wrote:
>>> On Wed, Jan 17, 2024 at 3:10 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>> [...]
>>>> @@ -1622,6 +1624,16 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>>>>         alignment_prevented_execution = 0;
>>>>
>>>>         if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
>>>> +               if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
>>>> +                       for (i = 0; i < prog_len; i++, prog++) {
>>>> +                               if (!insn_is_pseudo_func(prog))
>>>> +                                       continue;
>>>> +                               printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
>>>> +                               skips++;
>>>> +                               goto close_fds;
>>>> +                       }
>>>> +               }
>>>> +
>>> I would put this chunk above "alignment_prevented_execution = 0;".
>>>
>>> @@ -1619,6 +1621,16 @@ static void do_test_single(struct bpf_test
>>> *test, bool unpriv,
>>>                 goto close_fds;
>>>         }
>>>
>>> +       if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
>>> +               for (i = 0; i < prog_len; i++, prog++) {
>>> +                       if (!insn_is_pseudo_func(prog))
>>> +                               continue;
>>> +                       printf("SKIP (callbacks are not allowed in
>>> non-JITed programs)\n");
>>> +                       skips++;
>>> +                       goto close_fds;
>>> +               }
>>> +       }
>>> +
>>>         alignment_prevented_execution = 0;
>>>
>>>         if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
>>>
>>> Other than this,
>> The check was placed before the checking of expected_ret in v3. However
>> I suggested Tiezhu to move it after the checking of expected_ret due to
> I missed this part while reading the history of the set.
>
>> the following two reasons:
>> 1) when the expected result is REJECT, the return value in about one
>> third of these test cases is -EINVAL. And I think we should not waste
>> the cpu to check the pseudo func and exit prematurely, instead we should
>> let test_verifier check expected_err.
> I was thinking jit_disabled is not a common use case so that it is OK for
> this path to be a little expensive.
>
>> 2) As for now all expected_ret of these failed cases are ACCEPT when jit
>> is disabled, so I think it will be enough for current situation and we
>> can revise it later if the checking of pseudo func is too later.
> That said, I won't object if we ship this version as-is.

I see and thanks for the explanation.
> Thanks,
> Song


