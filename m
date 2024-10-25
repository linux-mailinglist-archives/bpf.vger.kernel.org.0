Return-Path: <bpf+bounces-43143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F2D9AFB8A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46390B230EB
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6C1B6D16;
	Fri, 25 Oct 2024 07:52:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F81C1738
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842765; cv=none; b=C5KvUsI1+QrmpgH8nrO/ChUgJwTbtAXHDPSB/QQcggPKIbkNYaZniP5yj/+r57Ku43o+08PSQsO/s1qqdg83+CCcm0PtzqbsQIhJj6yys4sJL9AjBoM9RFxZZzgaulUe6zVA6eCpuLF++uExeM/UNaCKLp+IRP3O4xa3n9YvG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842765; c=relaxed/simple;
	bh=c1EaZs92k6VmV7vCr0Izl2sAg2iC4XFVDS09Nv9MlH4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JSsfykTqImNwlh6BlGS+nwAK0QobaRPMHWBnb6xxySGSoNgfoRUKwkxuT5Xc6Oz7z9IRhCOVAb/9yyt8pRuY/23Qdx6zyV5D5B2iz7l1xX8gyOGIG6hkXvKtb+UXasJk7lnhaevc0nTYa8QhLhZl/hpNTUdNpgdVG/XVr3bT/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZZkY3sQhz4f3m6r
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 15:52:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D43151A018C
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 15:52:39 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBH5oJDThtnNrSgEw--.53496S2;
	Fri, 25 Oct 2024 15:52:39 +0800 (CST)
Subject: Re: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in
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
References: <20241025013233.804027-1-houtao@huaweicloud.com>
 <20241025013233.804027-4-houtao@huaweicloud.com>
 <CALOAHbDwKh3xZa1pFURSuOV=md+eAfKbrsPGyxh3xH39e50qWA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <623079fc-c66f-e597-b6b1-b810b1a717f4@huaweicloud.com>
Date: Fri, 25 Oct 2024 15:52:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbDwKh3xZa1pFURSuOV=md+eAfKbrsPGyxh3xH39e50qWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBH5oJDThtnNrSgEw--.53496S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15urWkWr4kArWDKFWDCFg_yoWrGFyDpF
	4fJ3Z0yr48tF47Jwnrt3WUCa4fX34vqa17GrW8Xr1S9Fs5WFnrWr1UKw1Yqas3Cryjkr4I
	vr1v9FyfZayDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi Yafang,

On 10/25/2024 2:04 PM, Yafang Shao wrote:
> On Fri, Oct 25, 2024 at 9:20 AM Hou Tao <houtao@huaweicloud.com> wrote:
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
>> Fixes: 4665415975b0 ("bpf: Add bits iterator")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/helpers.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 40ef6a56619f..daec74820dbe 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
>>         __u64 __opaque[2];
>>  } __aligned(8);
>>
>> +#define BITS_ITER_NR_WORDS_MAX 511
>> +
>>  struct bpf_iter_bits_kern {
>>         union {
>>                 unsigned long *bits;
>> @@ -2865,7 +2867,8 @@ struct bpf_iter_bits_kern {
>>   * @it: The new bpf_iter_bits to be created
>>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated over
>>   * @nr_words: The size of the specified memory area, measured in 8-byte units.
>> - * Due to the limitation of memalloc, it can't be greater than 512.
>> + * The maximum value of @nr_words is @BITS_ITER_NR_WORDS_MAX. This limit may be
>> + * further reduced by the BPF memory allocator implementation.
>>   *
>>   * This function initializes a new bpf_iter_bits structure for iterating over
>>   * a memory area which is specified by the @unsafe_ptr__ign and @nr_words. It
>> @@ -2878,8 +2881,7 @@ __bpf_kfunc int
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
>>
>>         /* Optimization for u64 mask */
>> -       if (nr_bits == 64) {
>> +       if (nr_words == 1) {
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
> Is this check necessary here? If `E2BIG` is a concern, perhaps it
> would be more appropriate to return it using ERR_PTR() in
> bpf_mem_alloc()?

The check is necessary to ensure a correct error code is returned.
Returning ERR_PTR() in bpf_mem_alloc() is also feasible, but the return
value of bpf_mem_alloc() and bpf_mem_cache_alloc() will be different, so
I prefer to introduce an extra helper for the size checking.
>>         /* Fallback to memalloc */
>>         kit->bits = bpf_mem_alloc(&bpf_global_ma, nr_bytes);
>>         if (!kit->bits)
>> --
>> 2.29.2
>>
>


