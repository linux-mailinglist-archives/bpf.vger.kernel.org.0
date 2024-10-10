Return-Path: <bpf+bounces-41516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8B997A0B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 03:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07E81F23BB1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0722338;
	Thu, 10 Oct 2024 01:19:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D310A12
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523172; cv=none; b=I2dizNWv1UZeeaeq8U+0Bs43xDRUJKLD6aWTj/4kHgHpgSB52hwlpx669NUIE1GNLVLZG/RueNnfB/E1mWYr8dLEQ3zOjAvWE9+VF7IjoTnRmhZ+oMr72H/yeRQBRkjRUffYw+eWI5kkb4FPPfBO/KWxAIrELRu7tVYxpnoOOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523172; c=relaxed/simple;
	bh=O4h2ghWSwLcvCEtJCd7bK5SMUoodysTF/QMvA75rjWE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SQ0OsuCROWT6BvefJJhGie54ykG7+Kil1SRrxCQTBAvwQqBX3MuNmfpVYG+9RbehBLz7WPtnAA4mA21Bc34GMxpUbMaEhqBLw8wdqJvode2ZJSAeC9HFq3ppzwjaIdXerYkaQ/e/CSL47QY0Fi84C75aEK8cc36UTT+R/CmhGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XPBjh0P1pz4f3jsr
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 09:19:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E3FF91A018D
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 09:19:20 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAXa4eVKwdnCOUuDg--.63941S2;
	Thu, 10 Oct 2024 09:19:20 +0800 (CST)
Subject: Re: [PATCH bpf 5/7] bpf: Change the type of unsafe_ptr in
 bpf_iter_bits_new()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Yafang Shao
 <laoar.shao@gmail.com>, xukuohai@huawei.com,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-6-houtao@huaweicloud.com>
 <CAEf4BzZ2J+Kd3wHNUM92ro1ikD3kqMF9zXEMPbG7u=GAVev3Xw@mail.gmail.com>
 <bcb4adcf-0e02-2543-6cb4-ac237b11a061@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <7ec62167-462c-a7b8-a61e-7db6e56bed18@huaweicloud.com>
Date: Thu, 10 Oct 2024 09:19:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bcb4adcf-0e02-2543-6cb4-ac237b11a061@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAXa4eVKwdnCOUuDg--.63941S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15Xw1rWFWDArW8Zw1xGrg_yoWrCrW8pr
	4fJ3WqyrW0qrsrKw1qqa40ka4xJ3srta48WrWxJr15KFs0qrnF9r1UWryYgasakrW8Ar1I
	vryj9343ZFWDAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07j7l19UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/9/2024 10:45 AM, Hou Tao wrote:
>
> On 10/9/2024 2:30 AM, Andrii Nakryiko wrote:
>> On Tue, Oct 8, 2024 at 2:05 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Under 32-bits host (e.g, arm32) , when a bpf program passes an u64 to
>>> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to save the
>>> content of the u64, but the size of bits_copy is only 4-bytes, and there
>>> will be stack corruption.
>>>
>>> Fix it by change the type of unsafe_ptr from u64 * to unsigned long *.
>>>
>> This will be confusing as BPF-side long is always 64-bit. So why not
>> instead make sure it's u64 throughout (i.e., bits_copy is u64
>> explicitly), even on 32-bit architectures?
> Just learn about the size of BPF-side long is always 64-bits. I had
> considered to change bits_copy to u64. The main obstacle is that the
> pointer type of find_next_bit is unsigned long *, if it is used on an
> u64 under big-endian host, it may return invalid result.

I think doing the following swap for big endian and 32-bits host will
let find_next_bit return the correct result:

+static void swap_bits(u64 *bits, unsigned int nr)
+{
+#if defined(__BIG_ENDIAN) && !defined(CONFIG_64BIT)
+       unsigned int i;
+
+       for (i = 0; i < nr; i++)
+               bits[i] = (bits[i] >> 32) | ((u64)(u32)bits[i] << 32);
+#endif
+}
+

Will try to get some test environment to test it.
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  kernel/bpf/helpers.c | 18 ++++++++++--------
>>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 6c0205d5018c..dee69c3904a0 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2852,7 +2852,7 @@ struct bpf_iter_bits {
>>>  } __aligned(8);
>>>
>>>  /* nr_bits only has 31 bits */
>>> -#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(u64))
>>> +#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(unsigned long))
>>>
>>>  struct bpf_iter_bits_kern {
>>>         union {
>>> @@ -2868,8 +2868,9 @@ struct bpf_iter_bits_kern {
>>>   * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
>>>   * @it: The new bpf_iter_bits to be created
>>>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated over
>>> - * @nr_words: The size of the specified memory area, measured in 8-byte units.
>>> - * Due to the limitation of memalloc, it can't be greater than 512.
>>> + * @nr_words: The size of the specified memory area, measured in units of
>>> + * sizeof(unsigned long). Due to the limitation of memalloc, it can't be
>>> + * greater than 512.
>>>   *
>>>   * This function initializes a new bpf_iter_bits structure for iterating over
>>>   * a memory area which is specified by the @unsafe_ptr__ign and @nr_words. It
>>> @@ -2879,17 +2880,18 @@ struct bpf_iter_bits_kern {
>>>   * On success, 0 is returned. On failure, ERR is returned.
>>>   */
>>>  __bpf_kfunc int
>>> -bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_words)
>>> +bpf_iter_bits_new(struct bpf_iter_bits *it, const unsigned long *unsafe_ptr__ign, u32 nr_words)
>>>  {
>>> -       struct bpf_iter_bits_kern *kit = (void *)it;
>>> -       u32 nr_bytes = nr_words * sizeof(u64);
>>> +       u32 nr_bytes = nr_words * sizeof(*unsafe_ptr__ign);
>>>         u32 nr_bits = BYTES_TO_BITS(nr_bytes);
>>> +       struct bpf_iter_bits_kern *kit;
>>>         int err;
>>>
>>>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
>>>         BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
>>>                      __alignof__(struct bpf_iter_bits));
>>>
>>> +       kit = (void *)it;
>>>         kit->allocated = 0;
>>>         kit->nr_bits = 0;
>>>         kit->bits_copy = 0;
>>> @@ -2900,8 +2902,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>>>         if (nr_words > BITS_ITER_NR_WORDS_MAX)
>>>                 return -E2BIG;
>>>
>>> -       /* Optimization for u64 mask */
>>> -       if (nr_bits == 64) {
>>> +       /* Optimization for unsigned long mask */
>>> +       if (nr_words == 1) {
>>>                 err = bpf_probe_read_kernel_common(&kit->bits_copy, nr_bytes, unsafe_ptr__ign);
>>>                 if (err)
>>>                         return -EFAULT;
>>> --
>>> 2.29.2
>>>
>> .
> .


