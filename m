Return-Path: <bpf+bounces-43478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093409B597D
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4301C209FE
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA0194094;
	Wed, 30 Oct 2024 01:45:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1A42AA2
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252715; cv=none; b=rtkYFGL7EZXEOJPZcIKJ24C4ksZqnHTUh6vG3LdVX+Jg5tFs3JzKHkIwW+Jb00Dy+efC4O9Evl70Ss0NlyUL+kI1etd2WX4l33PMUu54F5VavA7cJsYjab2pbS/6cZUH+8FTcccsGYFQaz7F9QVXXBvqmlPNJFrnZ1n5kIo4O80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252715; c=relaxed/simple;
	bh=R3l+o2edOS40obI+6wH+rbM+LAgzZoEfV5NS/95qEjM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ifiYywu1Y23jwWN8RTeFCnWVAK19sbbMRhQmt58wUS8NuYFP7a+gTxTHMXV43jsmpU/AFIBjzTjax7wxv3bmyNyHuMSuM7jgULnhjXCxOBl9MZkb59+o7GxpzAmtiE4PQ3/YRpMCaVmZLDkvE60El39abJrMU4ar6cwI+QHZ0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XdVLH29hBz4f3jqK
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:44:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CE6731A0197
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:45:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgC3GOWcjyFn4dxMAQ--.3248S2;
	Wed, 30 Oct 2024 09:45:03 +0800 (CST)
Subject: Re: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in
 bpf_iter_bits_new()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Yafang Shao
 <laoar.shao@gmail.com>, Hou Tao <houtao1@huawei.com>,
 Xu Kuohai <xukuohai@huawei.com>
References: <20241025013233.804027-1-houtao@huaweicloud.com>
 <20241025013233.804027-4-houtao@huaweicloud.com>
 <CAADnVQKvHXEv_-MZpZBMPdDtptQuTjHhMUd0j+3j2DqhMV=w_g@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <4c37f26d-8c45-56a8-e5f1-624c51c8e392@huaweicloud.com>
Date: Wed, 30 Oct 2024 09:45:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQKvHXEv_-MZpZBMPdDtptQuTjHhMUd0j+3j2DqhMV=w_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgC3GOWcjyFn4dxMAQ--.3248S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15urWkWr4kArWkJry7ZFb_yoW5ZF1fpF
	WfJ3Z8Ar1xJr47tw1Dt3ZF9a4rJa92qa9rWrWUtFs3uFZ3WrnrWr1UKw15tas5CryjkF1I
	vryvkFyfZaykJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/30/2024 4:53 AM, Alexei Starovoitov wrote:
> On Thu, Oct 24, 2024 at 6:20 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Check the validity of nr_words in bpf_iter_bits_new(). Without this
>> check, when multiplication overflow occurs for nr_bits (e.g., when
>> nr_words = 0x0400-0001, nr_bits becomes 64), stack corruption may occur
>> due to bpf_probe_read_kernel_common(..., nr_bytes = 0x2000-0008).
>>
>> Fix it by limiting the maximum value of nr_words to 511. The value is
>> derived from the current implementation of BPF memory allocator. To
>> ensure compatibility if the BPF memory allocator's size limitation
>> changes in the future, use the helper bpf_mem_alloc_check_size() to
>> check whether nr_bytes is too larger. And return -E2BIG instead of
>> -ENOMEM for oversized nr_bytes.
>>

SNIP
>>  bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_words)
>>  {
>>         struct bpf_iter_bits_kern *kit = (void *)it;
>> -       u32 nr_bytes = nr_words * sizeof(u64);
>> -       u32 nr_bits = BYTES_TO_BITS(nr_bytes);
>> +       u32 nr_bytes, nr_bits;
>>         int err;
>>
>>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
>> @@ -2892,9 +2894,14 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>>
>>         if (!unsafe_ptr__ign || !nr_words)
>>                 return -EINVAL;
>> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
>> +               return -E2BIG;
>> +
>> +       nr_bytes = nr_words * sizeof(u64);
>> +       nr_bits = BYTES_TO_BITS(nr_bytes);
> The check for nr_words is good, but moving computation after 'if'
> feels like code churn and nothing else.
> Even if nr_words is large, it's fine to do the math.

No intention for code churn. I thought the overflow during
multiplication may lead to UBSAN warning, but it seems the overflow
warning is only for signed integer. Andrii also suggested me to move the
assignment after the check [1].

[1]:
https://lore.kernel.org/bpf/CAEf4BzahtDCZDEdejm6cNMzDNTc0gXPzhc5xcWg9c8S_i6yWNA@mail.gmail.com/
>
>>         /* Optimization for u64 mask */
>> -       if (nr_bits == 64) {
>> +       if (nr_words == 1) {
> This is also unnecessary churn.
>
> Also it seems it's causing a warn on 32-bit:
> https://netdev.bots.linux.dev/static/nipa/902902/13849894/build_32bit/

It is weird that using "nr_bits = 64" doesn't reproduce the warning.
Because the warning is due to the size of bits_copy is 4 bytes under
32-bit host and the error path of bpf_probe_read_kernel_common() invokes
memset(&bits_copy, 0, 8). The warning will be fixed by the following
patch "bpf: Use __u64 to save the bits in bits iterator". Anyway, will
change it back to "nr_bits = 64".

>
> pw-bot: cr
>
>>                 err = bpf_probe_read_kernel_common(&kit->bits_copy, nr_bytes, unsafe_ptr__ign);
>>                 if (err)
>>                         return -EFAULT;
>> @@ -2903,6 +2910,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>>                 return 0;
>>         }
>>
>> +       if (bpf_mem_alloc_check_size(false, nr_bytes))
>> +               return -E2BIG;
>> +
>>         /* Fallback to memalloc */
>>         kit->bits = bpf_mem_alloc(&bpf_global_ma, nr_bytes);
>>         if (!kit->bits)
>> --
>> 2.29.2
>>


