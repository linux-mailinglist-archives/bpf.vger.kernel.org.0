Return-Path: <bpf+bounces-44014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F69BC55B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 07:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CCC282F4B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9503F1D172A;
	Tue,  5 Nov 2024 06:22:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5CAD5B;
	Tue,  5 Nov 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787726; cv=none; b=Z6bBLGukubPghDXBivGkTHC+iMo2MeUDNN9E5Umpm/G+92+RNyePGioHxglvpr2kmZHCHbADNKEpB7sdVBruYIurxo92czQXm4vn0zI0g5Xkul5UwqXiWprh+qfqwF9xMkL+Zk4BQx6ItMR60Sww7czFAGyppkdSyRb81iJvorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787726; c=relaxed/simple;
	bh=fUsLKpu589KieHw/CBhz56VR/qBOiQQzgesY9vaxU7A=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TTF4tCncWmmTebi2K/FyeJISe2Wzy3AkAaqmgcyaaBWo0AxapurUQEh0VzC6KzfsmRVlng2a/5yx5jA4N3dH7n33m83Pn7VNFvmCcgl2ydczYe9WhSmFhTUxt0panZmS0Sonj4noWf3yzZm2NqXcJCB095L5ISMW13gJxclIEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XjJBq1HTHz4f3jXl;
	Tue,  5 Nov 2024 14:21:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1C7A41A058E;
	Tue,  5 Nov 2024 14:21:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCHfK6BuSlndB+BAw--.16882S2;
	Tue, 05 Nov 2024 14:21:56 +0800 (CST)
Subject: Re: [PATCH bpf] selftests/bpf: Add a copyright notice to
 lpm_trie_map_get_next_key
From: Hou Tao <houtao@huaweicloud.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Byeonguk Jeong <jungbu2855@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZycSXwjH4UTvx-Cn@ub22>
 <925cb852-df24-81b6-318a-ee6a628d43c7@huaweicloud.com>
 <d5137f25846ebf585383de4d994d388eabab9d60.camel@linux.ibm.com>
 <b75e09a9-1028-28a2-f85d-5c7130a201f6@huaweicloud.com>
Message-ID: <8d61d6ab-b6c4-9e7b-45f2-f0a4972f04ce@huaweicloud.com>
Date: Tue, 5 Nov 2024 14:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b75e09a9-1028-28a2-f85d-5c7130a201f6@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCHfK6BuSlndB+BAw--.16882S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy5XrWUCFyDWw4rXr43Jrb_yoW8tw45pr
	98tFZxtr4DJr12yw4kt3WDurW0ywnxG3Wagr1DGr15u3Z093Zaqr40kw17CFnF9r48Kw4U
	Zw1UJFZ7J345Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/5/2024 10:34 AM, Hou Tao wrote:
> Hi Ilya,
>
> On 11/4/2024 6:07 PM, Ilya Leoshkevich wrote:
>> On Mon, 2024-11-04 at 09:34 +0800, Hou Tao wrote:
>>> Hi,
>>>
>>> On 11/3/2024 2:04 PM, Byeonguk Jeong wrote:
>>>> Hi,
>>>>
>>>> The selftest "verifier_bits_iter/bad words" has been failed with
>>>> retval 115, while I did not touched anything but a comment.
>>>>
>>>> Do you have any idea why it failed? I am not sure whether it
>>>> indicates
>>>> any bugs in the kernel.
>>>>
>>>> Best,
>>>> Byeonguk
>>> Sorry for the inconvenience. It seems the test case
>>> "verifier_bits_iter/bad words" is flaky. It may fail randomly, such
>>> as
>>> in [1]. I think calling bpf_probe_read_kernel_common() on 3GB addr
>>> under
>>> s390 host may succeed and the content of the memory address will
>>> decide
>>> whether the test case will succeed or not. Do not know the reason why
>>> reading 3GB address succeeds under s390. Hope to get some insight
>>> from
>>> Ilya.  I think we could fix the failure first by using NULL as the
>>> address of bad words just like null_pointer test case does. Will
>>> merge
>>> the test in bad_words into the null_pointer case.
>> Hi,
>>
>> s390 kernel runs in a completely separate address space, there is no
>> user/kernel split at TASK_SIZE. The same address may be valid in both
>> the kernel and the user address spaces, there is no way to tell by
>> looking at it. The config option related to this property is
>> ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
>>
>> Also, unfortunately, 0 is a valid address in the s390 kernel address
>> space.
> Thanks for the detailed explanation. It seems both arm and x86 have
> select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
>> I wonder if we could use -4095 as an address that cannot be
>> dereferenced on all platforms?
> I have tested it in both arm64 and x86-64 that reading from -4095 by
> using copy_from_kernel_nofault() will return -EFAULT . For s390, I hope
> the bpf CI could help to test it. Will post a fix patch later.

On s390 host, it seems that using copy_from_kernel_nofault() to read
from -4095 returns -EFAULT as well [1], so the suggestion works. Thanks
again for the suggestion.

[1]
https://github.com/kernel-patches/bpf/actions/runs/11677589805/job/32515868794
>> Best regards,
>> Ilya
>
> .


