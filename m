Return-Path: <bpf+bounces-42872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49E9AC113
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26FB1C2110B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341A15746B;
	Wed, 23 Oct 2024 08:09:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED1156F41
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670976; cv=none; b=Nq+Z/JR3I37SqqBHrKi7xyJOaVhsxD7qkrUCor/yYoclbxujw0BgifgBc1ek9lVOKRpIx4g0qOI3qI+rgrX0xAdlH/cARQlBX937Eb0Tap5kID/gIkRu3hcIg0BoK89jVcxjHC/8RY7LziP6NoQY7PyBlRgT4aNPqW28KOAOgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670976; c=relaxed/simple;
	bh=3AO+VQhkC9onNc1IZZqOe2ox2AcFz2Yp9jrlUmcT+uQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ruvk6cBQunNbfVXhLA6QTI6oeDJPEzyeFvqRPvlNDQuSBBtI1kWbb/LNPOdwoR49x2YRHNqlsoeSGjxYAW10cORL25E7EMkeI7j2S4Ft/iyJ8ft4KZeCIUr5YZvHhIi+nOkmC/u+2D6E2IgnaT87IWAa0DL3GFMkyGA4+1fVVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYMBt4NSLz4f3nJq
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:09:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D1A311A0568
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:09:28 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgA3t8M0rxhnDLyHEw--.15392S2;
	Wed, 23 Oct 2024 16:09:28 +0800 (CST)
Subject: Re: [PATCH bpf v2 6/7] bpf: Use __u64 to save the bits in bits
 iterator
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
 <20241021014004.1647816-7-houtao@huaweicloud.com>
 <CALOAHbB-asooCmJSq7wFeXo2VV++WKeU2BMfgcAFRNoAy2OTGg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c25f7f73-a666-3eae-bbaa-824cbdd722d6@huaweicloud.com>
Date: Wed, 23 Oct 2024 16:09:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbB-asooCmJSq7wFeXo2VV++WKeU2BMfgcAFRNoAy2OTGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgA3t8M0rxhnDLyHEw--.15392S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15uF15Kw4kWrWxuF43trb_yoW5WF1UpF
	WxCw1qkrWkKrW2kwnFyF48ZFy5Arn3Z34UGrWfGrWrA3W5WryrWrykKay5X3WUCFy8Z3ZF
	vryY93srC3yDJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 10/23/2024 11:10 AM, Yafang Shao wrote:
> On Mon, Oct 21, 2024 at 9:28 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> On 32-bit hosts (e.g., arm32), when a bpf program passes a u64 to
>> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to store the
>> content of the u64. However, bits_copy is only 4 bytes, leading to stack
>> corruption.
>>
>> The straightforward solution would be to replace u64 with unsigned long
>> in bpf_iter_bits_new(). However, this introduces confusion and problems
>> for 32-bit hosts because the size of ulong in bpf program is 8 bytes,
>> but it is treated as 4-bytes after passed to bpf_iter_bits_new().
>>
>> Fix it by changing the type of both bits and bit_count from unsigned
>> long to u64.
> Thank you for the fix. This change is necessary.
>
>>  However, the change is not enough. The main reason is that
>> bpf_iter_bits_next() uses find_next_bit() to find the next bit and the
>> pointer passed to find_next_bit() is an unsigned long pointer instead
>> of a u64 pointer. For 32-bit little-endian host, it is fine but it is
>> not the case for 32-bit big-endian host. Because under 32-bit big-endian
>> host, the first iterated unsigned long will be the bits 32-63 of the u64
>> instead of the expected bits 0-31. Therefore, in addition to changing
>> the type, swap the two unsigned longs within the u64 for 32-bit
>> big-endian host.
> The API uses a u64 data type, and the nr_words parameter represents
> the number of 8-byte units. On a 32-bit system, if you want to call
> this API, you would define an array like `u32 data[2]` and invoke the
> function as `bpf_for_each(bits, bit, &data[0], 1)`. However, since the
> API expects a u64, you'll need to merge the two u32 values into a
> single u64 value.

It is a bit weird to pass a u32 pointer to bpf_for_each, because it
expects a u64 pointer. I think the bpf program should pass a u64 pointer
instead.
>
> Given this, it might be more appropriate to ask users to handle the
> u32 to u64 merge on their side when preparing the data, rather than
> performing the swap within the kernel itself.

However, the swap implemented in the patch has nothing to do whether the
user passes pointer to u32 array or not. It is necessary due to the
mismatched between the pointer type used by find_next_bit and the
pointer used by bpf_iter_bits_new(). The latter uses u64 pointer, but
find_next_bit() uses unsigned long pointer and iterates a long each
time. So just like the comment in the patch said:

    under 32-bit big-endian host, the first iterated unsigned long will
be the bits 32-63 of the u64 instead of the expected bits 0-31.

The swap in the patch will swap the two long values in the u64 and make
the first iterated unsigned long will be the bits 0-31 of the u64 value.
>
> --
> Regards
>
> Yafang


