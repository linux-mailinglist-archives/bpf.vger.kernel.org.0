Return-Path: <bpf+bounces-35318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4839397D7
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B70F1C219FD
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D47130AC8;
	Tue, 23 Jul 2024 01:21:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86126AE6;
	Tue, 23 Jul 2024 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697709; cv=none; b=oNbmFSShfNUVOfWsns9jkfWsoIxBgxoskoKL1YPCWk3yFZz132zo57ujF5nGc4BXoHa/Yuuc2K06uxZFMb8qgxuWnSB5P1hx2S7YabeK/vhVHNY9WnDFgh0yN0dkMcnBu+SZGllEEx6QDErhgGnBaQf+4S2upEu287FKAbdjCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697709; c=relaxed/simple;
	bh=tltkUCqeUYOfAfQoR4j7NiTDBSjIyeD2zBpbDmMXRAk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o54WG91zfXJDRbH2X3Y/3o0ITdYq5NI+yYRokXdnm1pXgycMl5FqAw2Qzi0DM/l2XnGFcZea3ev0QkD943FOs9Ff21OrwFWbtWo6PKJ2aJ7OUineg12gTx70gVJ7uOr4kbxWvElWHty0Kp/OE3DdUQI1I3i7dyoxfg+va5YuZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WSfVq2Tphz4f3kw1;
	Tue, 23 Jul 2024 09:21:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D349B1A0572;
	Tue, 23 Jul 2024 09:21:36 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCnRniJBZ9m3+p8Aw--.16725S2;
	Tue, 23 Jul 2024 09:21:36 +0800 (CST)
Subject: Re: [PATCH] bpf: fix excessively checking for elem_flags in batch
 update mode
To: Lin Feng <linf@wangsu.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yonghong.song@linux.dev, Brian Vazquez <brianvv@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
References: <cde62a6c-384a-5bdd-fe64-3f3d999c3825@wangsu.com>
 <7d351341-fefe-a40f-f62a-d9505432d056@iogearbox.net>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c26a1373-c206-51b3-406a-83f3adddbdd5@huaweicloud.com>
Date: Tue, 23 Jul 2024 09:21:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7d351341-fefe-a40f-f62a-d9505432d056@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCnRniJBZ9m3+p8Aw--.16725S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWfZrW5Cr4kCF1DurWUtwb_yoW8tF45pF
	Z5Jay7G3yqgw18Zw42q347GFW0yr45tw15JFn5tFy5Xry7GryFgF10qF4a9F1agF4fJrWj
	vay2vFySvw1xZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 7/20/2024 12:22 AM, Daniel Borkmann wrote:
> On 7/17/24 1:15 PM, Lin Feng wrote:
>> Currently generic_map_update_batch will reject all valid command
>> flags for
>> BPF_MAP_UPDATE_ELEM other than BPF_F_LOCK, which is overkill, map
>> updating
>> semantic does allow specify BPF_NOEXIST or BPF_EXIST even for batching
>> update.
>>
>> Signed-off-by: Lin Feng <linf@wangsu.com>
>
> [ +Hou/Brian ]
>
> Please also add a BPF selftest along with this extension which
> exercises the
> batch update and validates the behavior for the various flags which
> are now enabled.

Agreed. There are already some batched map operation tests in
tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c, I think
extending the test cases in the file will be fine.
> Also, please discuss the semantics in the commit msg.. errors due to
> BPF_EXIST and
> BPF_NOEXIST will cause bpf_map_update_value() to fail and then break
> the loop. It's
> probably fine given batch.count (cp) will be propagated back to user
> space to tell
> how many elements could actually get updated.

It seems that the initial commit aa2e93b8e58e ("bpf: Add generic support
for update and delete batch ops") only enabled BPF_F_LOCK for
BPF_MAP_UPDATE_BATCH, but the document commit 0cb804547927 ("bpf:
Document BPF_MAP_*_BATCH syscall commands for BPF_MAP_UPDATE_BATCH
considered both BPF_NOEXIST and BPF_EXIST are valid. The
bpf_map_update_batch() API in libbpf also considered both BPF_NOEXIST
and BPF_EXIST are valid, but we just never test it before.
>
>> ---
>>   kernel/bpf/syscall.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 869265852d51..d85361f9a9b8 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1852,7 +1852,7 @@ int generic_map_update_batch(struct bpf_map
>> *map, struct file *map_file,
>>       void *key, *value;
>>       int err = 0;
>>   -    if (attr->batch.elem_flags & ~BPF_F_LOCK)
>> +    if ((attr->batch.elem_flags & ~BPF_F_LOCK) > BPF_EXIST)
>>           return -EINVAL;
>>         if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>>
>
> .


