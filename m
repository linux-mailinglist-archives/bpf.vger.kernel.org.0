Return-Path: <bpf+bounces-35329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A12939805
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76E41F22438
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2AC139578;
	Tue, 23 Jul 2024 01:44:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from wangsu.com (unknown [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D01332A1;
	Tue, 23 Jul 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699079; cv=none; b=kPH+GS/dQWOh5noCeCSuboYukAcqutnIr4fxEfFCoUX9ki9Cz58hTfV3cO6kqoQmzM/e+GMU6TZRxVy5wmZHxOT68jEBkiOcXii8QwRNnz2P89VGm8YriHHq3rPkQRhBN8sO5a8wnBvgsEBBwzj7jW8FVBkISzwiQ1J2YMk1FMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699079; c=relaxed/simple;
	bh=muZ9ONjlh7hbqiCTkWd3lag6SvzxaC+A8vVThMWZ7Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKN3yUT1Z1BLoQkiibsMw6qjiqcLZ8B25KWh4UP2UxXiLEZRETfB9m+dpyeeR3SSZzTw31Qur+4IBi1rmfuujJXPZiJi1nCQsQ3rdW0jhXMHfND5r4w1znXppJPwWCCJZL347WMzBUOu8vFQjxG5+I4B5OWNCXefFiuJhIUtqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from [10.8.148.37] (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAC3d5DnCp9mSxPaAA--.36658S2;
	Tue, 23 Jul 2024 09:44:08 +0800 (CST)
Message-ID: <f5fa9571-0c9a-8466-b43b-59468b5a1a2b@wangsu.com>
Date: Tue, 23 Jul 2024 09:44:07 +0800
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
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 yonghong.song@linux.dev, Brian Vazquez <brianvv@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
References: <cde62a6c-384a-5bdd-fe64-3f3d999c3825@wangsu.com>
 <7d351341-fefe-a40f-f62a-d9505432d056@iogearbox.net>
 <c26a1373-c206-51b3-406a-83f3adddbdd5@huaweicloud.com>
From: Lin Feng <linf@wangsu.com>
In-Reply-To: <c26a1373-c206-51b3-406a-83f3adddbdd5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:SyJltAC3d5DnCp9mSxPaAA--.36658S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw15WFWkGF4DAry8Jr4xJFb_yoW5Wr1rpF
	Z5JFW7GrWjgw18Zw4Iq3s7KFy0yr45tw15ZFn5try3Ar9FkryFgF10qFya9F1aqr4fGF4j
	vay7KF9avw18ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v2
	6r1j6r4UMcIj6x8ErcxFaVAv8VW8GwAv7VCY1x0262k0Y48FwI0_GcC_XcWlOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK
	6w4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IUjfb15UUUUU==
X-CM-SenderInfo: holqwq5zdqw23xof0z/

Hi Tao,

See below please,

On 7/23/24 09:21, Hou Tao wrote:
> Hi,
> 
> On 7/20/2024 12:22 AM, Daniel Borkmann wrote:
>> On 7/17/24 1:15 PM, Lin Feng wrote:
>>> Currently generic_map_update_batch will reject all valid command
>>> flags for
>>> BPF_MAP_UPDATE_ELEM other than BPF_F_LOCK, which is overkill, map
>>> updating
>>> semantic does allow specify BPF_NOEXIST or BPF_EXIST even for batching
>>> update.
>>>
>>> Signed-off-by: Lin Feng <linf@wangsu.com>
>>
>> [ +Hou/Brian ]
>>
>> Please also add a BPF selftest along with this extension which
>> exercises the
>> batch update and validates the behavior for the various flags which
>> are now enabled.
> 
> Agreed. There are already some batched map operation tests in
> tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c, I think
> extending the test cases in the file will be fine.
>> Also, please discuss the semantics in the commit msg.. errors due to
>> BPF_EXIST and
>> BPF_NOEXIST will cause bpf_map_update_value() to fail and then break
>> the loop. It's
>> probably fine given batch.count (cp) will be propagated back to user
>> space to tell
>> how many elements could actually get updated.
> 
> It seems that the initial commit aa2e93b8e58e ("bpf: Add generic support
> for update and delete batch ops") only enabled BPF_F_LOCK for
> BPF_MAP_UPDATE_BATCH, but the document commit 0cb804547927 ("bpf:
> Document BPF_MAP_*_BATCH syscall commands for BPF_MAP_UPDATE_BATCH
> considered both BPF_NOEXIST and BPF_EXIST are valid. The
> bpf_map_update_batch() API in libbpf also considered both BPF_NOEXIST
> and BPF_EXIST are valid, but we just never test it before.

I did notice the conflict between those two commits, besides the already
supported update flags in single-update mode, the latter patch says "both
BPF_NOEXIST and BPF_EXIST are valid", so here came this patch.

And thank you again for your detailed analysis, so I need to extend the 
testsuits and confirm this one wouldn't break any exsiting ones, I will
resend them batch in next version.

Have a nice day,
linfeng

>>
>>> ---
>>>   kernel/bpf/syscall.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 869265852d51..d85361f9a9b8 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -1852,7 +1852,7 @@ int generic_map_update_batch(struct bpf_map
>>> *map, struct file *map_file,
>>>       void *key, *value;
>>>       int err = 0;
>>>   -    if (attr->batch.elem_flags & ~BPF_F_LOCK)
>>> +    if ((attr->batch.elem_flags & ~BPF_F_LOCK) > BPF_EXIST)
>>>           return -EINVAL;
>>>         if ((attr->batch.elem_flags & BPF_F_LOCK) &&
>>>
>>
>> .
> 


