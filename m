Return-Path: <bpf+bounces-42755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3B9A9AF3
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053D81F21720
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB90A14D708;
	Tue, 22 Oct 2024 07:25:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372D14A4F0
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729581952; cv=none; b=BLOsVSbWRhQYVKx3EqU1DvqPMquox6t2ku07UjoSmE8aWGwO2itdetZSe5jM8eB0UP9yvC7QaSjcKUXV/tLfwszlLSpk1bo5VTiWbBeXvFN4kPdAF2QeZKdzkmN39PDra1JH+1ATTyGc/trsPot9xzWVBEZ3EGYgdyxNU86vKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729581952; c=relaxed/simple;
	bh=RT9HLF50sd59TbkU4TdX0OO7sglzIiN0qscDxtpil7I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D/KU8lgWvNsQ0/bfZfyXNLVhCKEHLiZi1W8BtpWKBeqivkegvV/J9JmGiMHNfYQ18z4iOsv6PZj6LQ71DZLHpiJC881V36OR/SMZbTL1ywXuPjQFq359JTEVUGSM0x7f0c4aq+nQJKBmgMgGnG7dqVGRn7SNkEexADOyq6Ir6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXkGt1nj4z4f3lfZ
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:25:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6DC611A07B6
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:25:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgC3Nlx1UxdnaJkXEw--.64471S2;
	Tue, 22 Oct 2024 15:25:44 +0800 (CST)
Subject: Re: [PATCH bpf v2 4/7] bpf: Free dynamically allocated bits in
 bpf_iter_bits_destroy()
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
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-5-houtao@huaweicloud.com>
 <91affb00-82af-49ad-69bd-9c9ad57c9a9b@huaweicloud.com>
 <CAEf4BzY=q3tk3FPkcwwY5Ax7VQqEwphQ2RX64VXXAxLO=_D_Ag@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ac2c24ea-ced7-d632-a268-e00810aa481d@huaweicloud.com>
Date: Tue, 22 Oct 2024 15:25:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY=q3tk3FPkcwwY5Ax7VQqEwphQ2RX64VXXAxLO=_D_Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgC3Nlx1UxdnaJkXEw--.64471S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryfuFWDCr45JF1xKr4rZrb_yoW5tF1rpr
	4fJa1jkr4vqF9rAw17t3Wqga4Utr4jka4UWFs5tr15ZF1qgFyDWFyUGr43Was8Kr4FyF4S
	vrnY934Sy3yUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/22/2024 7:07 AM, Andrii Nakryiko wrote:
> On Sun, Oct 20, 2024 at 7:45 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 10/21/2024 9:40 AM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> bpf_iter_bits_destroy() uses "kit->nr_bits <= 64" to check whether the
>>> bits are dynamically allocated. However, the check is incorrect and may
>>> cause a kmemleak as shown below:
>>>
>>> unreferenced object 0xffff88812628c8c0 (size 32):
>>>   comm "swapper/0", pid 1, jiffies 4294727320
>>>   hex dump (first 32 bytes):
>>>       b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
>>>       f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
>>>   backtrace (crc 781e32cc):
>>>       [<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
>>>       [<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
>>>       [<00000000597124d6>] __alloc.isra.0+0x89/0xb0
>>>       [<000000004ebfffcd>] alloc_bulk+0x2af/0x720
>>>       [<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
>>>       [<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
>>>       [<000000008b616eac>] bpf_global_ma_init+0x19/0x30
>>>       [<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
>>>       [<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
>>>       [<00000000b119f72f>] kernel_init+0x20/0x160
>>>       [<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
>>>       [<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
>>>
>>> That is because nr_bits will be set as zero in bpf_iter_bits_next()
>>> after all bits have been iterated.
>>>
>>> Fix the problem by not setting nr_bits to zero in bpf_iter_bits_next().
>>> Instead, use "bits >= nr_bits" to indicate when iteration is completed
>>> and still use "nr_bits > 64" to indicate when bits are dynamically
>>> allocated.
>>>
>>> Fixes: 4665415975b0 ("bpf: Add bits iterator")
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>> ---
>>>  kernel/bpf/helpers.c | 8 +++-----
>>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 1a43d06eab28..62349e206a29 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2888,7 +2888,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>>>
>>>       kit->nr_bits = 0;
>>>       kit->bits_copy = 0;
>>> -     kit->bit = -1;
>>> +     kit->bit = 0;
>> Sent the patch out in a hurry and didn't run the related test.
>>
>> The change above will break "fewer words" test in verifier_bits_iter,
>> because it will skip bit 0 in the bit. The correct fix should be as below:
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 1a43d06eab28..190b730e0f86 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct
>> bpf_iter_bits *it)
>>         const unsigned long *bits;
>>         int bit;
>>
>> -       if (nr_bits == 0)
>> +       if (kit->bit >= 0 && kit->bit >= nr_bits)
> this looks quite weird. Maybe instead of this seemingly unnecessary
> `kit->bit >= 0` check, either add (int)nr_bits cast or just switch
> nr_bits from u32 to int?

OK. Will change nr_bits to int in the next revision.


>
>
> BTW,
>
> u32 nr_bytes = nr_words * sizeof(u64);
>
> seems like a problem, no? nr_words is u32, so this can overflow,
> please check and fix as well, while you are at it?

Will move it after the checking of nr_words in the following patch.


