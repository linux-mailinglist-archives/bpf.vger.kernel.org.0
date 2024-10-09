Return-Path: <bpf+bounces-41344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9504995DE7
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A25F284469
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45C52F9B;
	Wed,  9 Oct 2024 02:45:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C962A1CF
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728441933; cv=none; b=D8rc9Wg5poHolyRRyvDvbp1hLGiPpE2i3SMK8XZxlt60Yzd1XnLkw+8EAD2/Zncby7Bd9r/yF9LfxplfOaeZ6KvCTH6miMnrtF+mhTjVjRv+b3QQt/gj9vUscbL57U4We3BNeIlZTqm5ncx7UKjpcC4Q5TtLskTifbEGTOYsquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728441933; c=relaxed/simple;
	bh=mMnjMdthw3wG5//NdrmSmQoKIot4DUSxfgBNJFqwy8A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s2hSyXyt4EwwYt7ey81L4HqO8wNFt16Qo9ilhVRq3PhcLk8gjlRXtOGFyaL2hxSztNfb/REG+pi6pdxVq8cK7f2fz+9YMjPq2wL358iFlFfY4H2RNVBkA09ax4gEIENF2LxDlG+JSCy7JR1aWRv7Sd+hvjZ8cFpAaRE+oEc00MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNcgb1rFXz4f3jZQ
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 10:45:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 03C2F1A08DC
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 10:45:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgB3q8dC7gVnighODg--.22398S2;
	Wed, 09 Oct 2024 10:45:26 +0800 (CST)
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
 <laoar.shao@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-6-houtao@huaweicloud.com>
 <CAEf4BzZ2J+Kd3wHNUM92ro1ikD3kqMF9zXEMPbG7u=GAVev3Xw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <bcb4adcf-0e02-2543-6cb4-ac237b11a061@huaweicloud.com>
Date: Wed, 9 Oct 2024 10:45:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZ2J+Kd3wHNUM92ro1ikD3kqMF9zXEMPbG7u=GAVev3Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgB3q8dC7gVnighODg--.22398S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18Xw43tFW3AFyfGryUZFb_yoWrJF1UpF
	4fJ3ZFyr40qrZFgw1qqayjka4UJwn7ta48GrWxAr15KFs8WFnrur1UGry5Xasakry0yr1I
	vry09343ZFWDAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/9/2024 2:30 AM, Andrii Nakryiko wrote:
> On Tue, Oct 8, 2024 at 2:05 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Under 32-bits host (e.g, arm32) , when a bpf program passes an u64 to
>> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to save the
>> content of the u64, but the size of bits_copy is only 4-bytes, and there
>> will be stack corruption.
>>
>> Fix it by change the type of unsafe_ptr from u64 * to unsigned long *.
>>
> This will be confusing as BPF-side long is always 64-bit. So why not
> instead make sure it's u64 throughout (i.e., bits_copy is u64
> explicitly), even on 32-bit architectures?

Just learn about the size of BPF-side long is always 64-bits. I had
considered to change bits_copy to u64. The main obstacle is that the
pointer type of find_next_bit is unsigned long *, if it is used on an
u64 under big-endian host, it may return invalid result.
>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/helpers.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 6c0205d5018c..dee69c3904a0 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2852,7 +2852,7 @@ struct bpf_iter_bits {
>>  } __aligned(8);
>>
>>  /* nr_bits only has 31 bits */
>> -#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(u64))
>> +#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(unsigned long))
>>
>>  struct bpf_iter_bits_kern {
>>         union {
>> @@ -2868,8 +2868,9 @@ struct bpf_iter_bits_kern {
>>   * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
>>   * @it: The new bpf_iter_bits to be created
>>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated over
>> - * @nr_words: The size of the specified memory area, measured in 8-byte units.
>> - * Due to the limitation of memalloc, it can't be greater than 512.
>> + * @nr_words: The size of the specified memory area, measured in units of
>> + * sizeof(unsigned long). Due to the limitation of memalloc, it can't be
>> + * greater than 512.
>>   *
>>   * This function initializes a new bpf_iter_bits structure for iterating over
>>   * a memory area which is specified by the @unsafe_ptr__ign and @nr_words. It
>> @@ -2879,17 +2880,18 @@ struct bpf_iter_bits_kern {
>>   * On success, 0 is returned. On failure, ERR is returned.
>>   */
>>  __bpf_kfunc int
>> -bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_words)
>> +bpf_iter_bits_new(struct bpf_iter_bits *it, const unsigned long *unsafe_ptr__ign, u32 nr_words)
>>  {
>> -       struct bpf_iter_bits_kern *kit = (void *)it;
>> -       u32 nr_bytes = nr_words * sizeof(u64);
>> +       u32 nr_bytes = nr_words * sizeof(*unsafe_ptr__ign);
>>         u32 nr_bits = BYTES_TO_BITS(nr_bytes);
>> +       struct bpf_iter_bits_kern *kit;
>>         int err;
>>
>>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
>>         BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
>>                      __alignof__(struct bpf_iter_bits));
>>
>> +       kit = (void *)it;
>>         kit->allocated = 0;
>>         kit->nr_bits = 0;
>>         kit->bits_copy = 0;
>> @@ -2900,8 +2902,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>>         if (nr_words > BITS_ITER_NR_WORDS_MAX)
>>                 return -E2BIG;
>>
>> -       /* Optimization for u64 mask */
>> -       if (nr_bits == 64) {
>> +       /* Optimization for unsigned long mask */
>> +       if (nr_words == 1) {
>>                 err = bpf_probe_read_kernel_common(&kit->bits_copy, nr_bytes, unsafe_ptr__ign);
>>                 if (err)
>>                         return -EFAULT;
>> --
>> 2.29.2
>>
> .


