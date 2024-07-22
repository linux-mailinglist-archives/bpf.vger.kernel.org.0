Return-Path: <bpf+bounces-35205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18D093876A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 03:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852B928111B
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD838F70;
	Mon, 22 Jul 2024 01:55:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A383232;
	Mon, 22 Jul 2024 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721613319; cv=none; b=J+0ZzTfrScDkHUZ/GUEkbS6qOj1VJw80xBLHtlD5arfTbbsr9pBCwQUF7xWnpNLDRgK3X5HNsO/tDTC+D3Hb+wJvEVeN0ozXl7qosmZPfKqhYDLbdWz1O1Ztt8TeOeibScSPjuLuqZsoKpAHYP9Ta6Xa2X/BF1JYp70W77pdZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721613319; c=relaxed/simple;
	bh=Y9MNL0qAliz7qWJwGy7gY8YYjqtvvGqbP0jX8rCmrOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSBWHC14J7Cqq42zCmHtSyuUo9Kcpw3nsliJaDKvm7XGcLHIasaBepNIDj7J6rBYM4pHLm0oCBiUeAtBHvt3UGes1rRw+ZBTNX7CZ1fZopBjBHGV01RiJwGZyBkgfdmJfNAqI8h4JuOiEiuYm4TjN0v3wjEE55uwgPO2rMOlc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from [10.8.148.37] (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltADHeHHeu51md2nYAA--.29882S2;
	Mon, 22 Jul 2024 09:54:40 +0800 (CST)
Message-ID: <6a8b1a57-c7b6-81c6-5e77-759cb041a77b@wangsu.com>
Date: Mon, 22 Jul 2024 09:54:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bpf: fix excessively checking for elem_flags in batch
 update mode
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yonghong.song@linux.dev, Hou Tao <houtao1@huawei.com>,
 Brian Vazquez <brianvv@google.com>
References: <cde62a6c-384a-5bdd-fe64-3f3d999c3825@wangsu.com>
 <7d351341-fefe-a40f-f62a-d9505432d056@iogearbox.net>
From: Lin Feng <linf@wangsu.com>
In-Reply-To: <7d351341-fefe-a40f-f62a-d9505432d056@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:SyJltADHeHHeu51md2nYAA--.29882S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DKFyxGrykJFyDuF13XFb_yoW8AryUpF
	Z5JFW3Kay0gF1Uuw47Ww1Igr40yw4rtr15KF93tryYqr17GryFkr10qF13ZF13Kr1rtryj
	vFW2qFWFqa4xZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_
	Jr0_Gr1lYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAF
	wVWkMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr4l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x07UJGYLUUUUU=
X-CM-SenderInfo: holqwq5zdqw23xof0z/

Hi Daniel,

Thanks for your reply! Without basic knowledge of rules of thumb for patch in
bpf, I didn't expect a single line change need that many more considerations,
and will do some more work on it following your sugguestion!

Thanks,
linfeng

On 7/20/24 00:22, Daniel Borkmann wrote:
> On 7/17/24 1:15 PM, Lin Feng wrote:
>> Currently generic_map_update_batch will reject all valid command flags for
>> BPF_MAP_UPDATE_ELEM other than BPF_F_LOCK, which is overkill, map updating
>> semantic does allow specify BPF_NOEXIST or BPF_EXIST even for batching
>> update.
>>
>> Signed-off-by: Lin Feng <linf@wangsu.com>
> 
> [ +Hou/Brian ]
> 
> Please also add a BPF selftest along with this extension which exercises the
> batch update and validates the behavior for the various flags which are now enabled.
> 
> Also, please discuss the semantics in the commit msg.. errors due to BPF_EXIST and
> BPF_NOEXIST will cause bpf_map_update_value() to fail and then break the loop. It's
> probably fine given batch.count (cp) will be propagated back to user space to tell
> how many elements could actually get updated.
> 
>> ---
>>   kernel/bpf/syscall.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 869265852d51..d85361f9a9b8 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1852,7 +1852,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>>   	void *key, *value;
>>   	int err = 0;
>>   
>> -	if (attr->batch.elem_flags & ~BPF_F_LOCK)
>> +	if ((attr->batch.elem_flags & ~BPF_F_LOCK) > BPF_EXIST)
>>   		return -EINVAL;
>>   
>>   	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>>
> 


