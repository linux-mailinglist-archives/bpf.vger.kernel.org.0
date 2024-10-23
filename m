Return-Path: <bpf+bounces-42875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A578E9AC198
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF811F24DFB
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CFA15887C;
	Wed, 23 Oct 2024 08:29:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA96157E78
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672156; cv=none; b=gm0vkun4HzjlvkjPOGl7Oefmly3wQmyOBq/URL6XeO0bVkqgYyqfJjV05nJVkPhGZjmhUqXLvCRTBLZd5t6QMKgtvfZmA0KtkBPuRHp0s5IftW+fBOkktNCSe0c2zC5OqTv/5SFg4M3USgHsvjTQUlbuIUohHqeGtsqz+Vj3jA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672156; c=relaxed/simple;
	bh=F9OfpuxUuuVAtgLobDV6pLkWR8cLRKI2LhEHNPn1HyQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G9JxuYarczLyMKraU/IR2/IX0kYyppYqSRyofkWoLHh19/aw7WCR7zl/YZhTfyEMU1pG094sbZb7K+YUU8rCGcscbxwS2pAw0zbu8XZklp2YlZKV9peuXHG8JNNNwONMcpHvVjMwIQERjXH3tltuF++jXD0YtqXxJ0FD0GTuSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYMdZ1sjmz4f3n6g
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:28:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7D1E11A018C
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:29:08 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBHfGHQsxhndF15Ew--.16350S2;
	Wed, 23 Oct 2024 16:29:08 +0800 (CST)
Subject: Re: [PATCH bpf v2 5/7] bpf: Check the validity of nr_words in
 bpf_iter_bits_new()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 xukuohai@huawei.com
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-6-houtao@huaweicloud.com>
 <CALOAHbDq4R=Exe6cUEindutk8NuLKBdiMayR3=HGL4zwYDrWQQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2368d81f-9356-b472-8a51-4fb2f88b4235@huaweicloud.com>
Date: Wed, 23 Oct 2024 16:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbDq4R=Exe6cUEindutk8NuLKBdiMayR3=HGL4zwYDrWQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBHfGHQsxhndF15Ew--.16350S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5WFy3ZFWkArWDXF1rtFb_yoW8uF4kpr
	4fJa4ay3yvqFZrCw1Dt3W7ua45Z3ykKr47KF4vqryFkFZ8WFn2gr9Fgw1YgF9ayrWUKr1I
	vr4v9FySyayDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/23/2024 11:17 AM, Yafang Shao wrote:
> On Mon, Oct 21, 2024 at 9:28 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Check the validity of nr_words in bpf_iter_bits_new(). Without this
>> check, when multiplication overflow occurs for nr_bits (e.g., when
>> nr_words = 0x0400-0001, nr_bits becomes 64), stack corruption may occur
>> due to bpf_probe_read_kernel_common(..., nr_bytes = 0x2000-0008).
>>
>> Fix it by limiting the max value of nr_words to 512.
>>
>> Fixes: 4665415975b0 ("bpf: Add bits iterator")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/helpers.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 62349e206a29..c147f75e1b48 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
>>         __u64 __opaque[2];
>>  } __aligned(8);
>>
>> +#define BITS_ITER_NR_WORDS_MAX 512
>> +
>>  struct bpf_iter_bits_kern {
>>         union {
>>                 unsigned long *bits;
>> @@ -2892,6 +2894,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>>
>>         if (!unsafe_ptr__ign || !nr_words)
>>                 return -EINVAL;
>> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
>> +               return -E2BIG;
> It is documented that nr_words cannot exceed 512, not due to overflow
> concerns, but because of memory allocation limits. It might be better
> to use 512 directly instead of BITS_ITER_NR_WORDS_MAX. Alternatively,
> if we decide to keep using the macro, the documentation should be
> updated accordingly.

Thanks for the explanation. Actually according to the limitation of bpf
memory allocator, the limitation should be (4096 - 8) / 8 = 511 due to
the overhead of llist_head in the returned pointer.

I prefer to keep the macro. How about updating the comment as follows:

 * Due to the limitation of memalloc, it can't be greater than 511.
Therefore,
 * 511 is used as the maximum value for @nr_words.
>
>>         /* Optimization for u64 mask */
>>         if (nr_bits == 64) {
>> --
>> 2.29.2
>>
>
> --
> Regards
> Yafang


