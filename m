Return-Path: <bpf+bounces-53178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD7A4E036
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 15:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875383B266F
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B020459A;
	Tue,  4 Mar 2025 14:04:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669FB1FC7C9
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097087; cv=none; b=fjBntOrKZkCZScRqH6QPPSeGTYVjXfj7d2gQxeSgoxkLgKtn9MNn5tsFCTHo40wdPR0yQuljO7Ktz6+YMTVps1Yv9XctrUZ2Kn5ruRZzp+7kQ6n1OGzzvZD8sONWGnvor7Yh50QY8hxTWmj1RRwu3fvJbSvAfgQMoF+x85Ry74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097087; c=relaxed/simple;
	bh=rkt7VZy7BGfcGTwKZ7bzSxMmTIONRYTfNErmGhE2edg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l7EPsPfYHN2X4/TnmXiQI4k2O2gk7hVJYSGUrKt08cep0lmhxjF0JbICntMiqxSKpn/+oOsD4otjdXHujYryAkPFm80VNvdQQgOxQls//EeXPb5gFQkwZZkR+b0oNeQGtsWg2ykWgAB95FCgV/gFREUpdQ1JlYak/rbTskGUjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z6cqh6cBmz4f3m7P
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 22:04:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 77D921A187C
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 22:04:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAXyHh0CMdnBg3RFQ--.48593S2;
	Tue, 04 Mar 2025 22:04:40 +0800 (CST)
Subject: Re: [PATCH 1/2] bpf: add kfunc for populating cpumask bits
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.de, eddyz87@gmail.com,
 yonghong.song@linux.dev
References: <20250228003321.1409285-1-emil@etsalapatis.com>
 <20250228003321.1409285-2-emil@etsalapatis.com>
 <9c51ec81-d7e3-679e-055d-8f82a73766ef@huaweicloud.com>
 <CABFh=a7U8ut-YE1kc=P60sqrG4ySXMcXKewpoKzAvpQoQz8pgg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c6725ecc-ffb5-9626-ca4f-146ab80b2070@huaweicloud.com>
Date: Tue, 4 Mar 2025 22:04:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABFh=a7U8ut-YE1kc=P60sqrG4ySXMcXKewpoKzAvpQoQz8pgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAXyHh0CMdnBg3RFQ--.48593S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWry7Wr4xXF43uF43KFWkXrb_yoW5Jw4kpr
	1UGFWYkrW0qwn7Ww42q3WUXr15t34kKwn293ZrCry2kF9Fqwn3Jr18XF1UW345Crn7Cr1U
	Ar90qFWS9w15ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/4/2025 11:18 AM, Emil Tsalapatis wrote:
> Hi,
>
> On Fri, Feb 28, 2025 at 7:56 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 2/28/2025 8:33 AM, Emil Tsalapatis wrote:
>>> Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF
>>> memory.
>>>
>>> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
>>> ---
>>>  kernel/bpf/cpumask.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
>>> index cfa1c18e3a48..a13839b3595f 100644
>>> --- a/kernel/bpf/cpumask.c
>>> +++ b/kernel/bpf/cpumask.c
>>> @@ -420,6 +420,26 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
>>>       return cpumask_weight(cpumask);
>>>  }
>>>
>>> +/**
>>> + * bpf_cpumask_fill() - Populate the CPU mask from the contents of
>>> + * a BPF memory region.
>>> + *
>>> + * @cpumask: The cpumask being populated.
>>> + * @src: The BPF memory holding the bit pattern.
>>> + * @src__sz: Length of the BPF memory region in bytes.
>>> + *
>>> + */
>>> +__bpf_kfunc int bpf_cpumask_fill(struct cpumask *cpumask, void *src, size_t src__sz)
>>> +{
>>> +     /* The memory region must be large enough to populate the entire CPU mask. */
>>> +     if (src__sz < BITS_TO_BYTES(nr_cpu_ids))
>>> +             return -EACCES;
>>> +
>>> +     bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
>> Should we use src__sz < bitmap_size(nr_cpu_ids) instead ? Because in
>> bitmap_copy(), it assumes the size of src should be bitmap_size(nr_cpu_ids).
> This is a great catch, thank you. Comparing with
> BITS_TO_BYTES(nr_cpu_ids) allows byte-aligned
> masks through, even though bitmap_copy assumes all masks are long-aligned.

Er, the long-aligned assumption raises another problem. Do we need to
make the src pointer be long-aligned because bitmap_copy() may use "*dst
= *src" to dereference the src pointer ? Or would it be better to use
memcpy() to copy the cpumask directly ?
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  __bpf_kfunc_end_defs();
>>>
>>>  BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
>>> @@ -448,6 +468,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>>>  BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>>>  BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>>>  BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
>>> +BTF_ID_FLAGS(func, bpf_cpumask_fill, KF_RCU)
>>>  BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
>>>
>>>  static const struct btf_kfunc_id_set cpumask_kfunc_set = {


