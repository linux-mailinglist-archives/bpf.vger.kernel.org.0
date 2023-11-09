Return-Path: <bpf+bounces-14547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF07E62B8
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 04:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2DAB20D5D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 03:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CAD568D;
	Thu,  9 Nov 2023 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07785663
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 03:46:17 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF02426AE
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 19:46:16 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SQntW0Kcbz4f3l8y
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:46:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 648571A0182
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:46:13 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgD3BEUBVkxlfLvDAQ--.7931S2;
	Thu, 09 Nov 2023 11:46:13 +0800 (CST)
Subject: Re: [PATCH bpf 01/11] bpf: Check rcu_read_lock_trace_held() before
 calling bpf map helpers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 bpf@vger.kernel.org
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-2-houtao@huaweicloud.com>
 <fcca87f3-8a92-2220-5a4a-cfa2851eac02@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <94fcdeab-4095-fca9-d901-25e6dee0d832@huaweicloud.com>
Date: Thu, 9 Nov 2023 11:46:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fcca87f3-8a92-2220-5a4a-cfa2851eac02@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgD3BEUBVkxlfLvDAQ--.7931S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryUArWkZw4UJr1kAF1DKFg_yoW5JrW3pF
	yvya4UKryj9rs3uw1Yva9rXFyUG3yUWa1DJws7Xa1YyF4UGr1SqryxXFnIgFyYkr4xGr48
	Zw17WwnxZr18A3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/9/2023 7:11 AM, Martin KaFai Lau wrote:
> On 11/7/23 6:06 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> These three bpf_map_{lookup,update,delete}_elem() helpers are also
>> available for sleepable bpf program, so add the corresponding lock
>> assertion for sleepable bpf program, otherwise the following warning
>> will be reported when a sleepable bpf program manipulates bpf map under
>> interpreter mode (aka bpf_jit_enable=0):
>>
SNIP
>>   BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
>>   {
>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>> !rcu_read_lock_trace_held() &&
>> +             !rcu_read_lock_bh_held());
>>       return (unsigned long) map->ops->map_lookup_elem(map, key);
>>   }
>>   @@ -53,7 +54,8 @@ const struct bpf_func_proto
>> bpf_map_lookup_elem_proto = {
>>   BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
>>          void *, value, u64, flags)
>>   {
>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>> !rcu_read_lock_trace_held() &&
>> +             !rcu_read_lock_bh_held());
>>       return map->ops->map_update_elem(map, key, value, flags);
>>   }
>>   @@ -70,7 +72,8 @@ const struct bpf_func_proto
>> bpf_map_update_elem_proto = {
>>     BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
>>   {
>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>> !rcu_read_lock_trace_held() &&
>> +             !rcu_read_lock_bh_held());
>
> Should these WARN_ON_ONCE be removed from the helpers instead?
>
> For catching error purpose, the ops->map_{lookup,update,delete}_elem
> are inlined  for the jitted case which I believe is the bpf-CI setting
> also. Meaning the above change won't help to catch error in the common
> normal case.

Removing these WARN_ON_ONCE is also an option. Considering JIT is not
available for all architectures and there is no KASAN support in JIT,
could we enable BPF interpreter mode in BPF CI to find more potential
problems ?

>
>>       return map->ops->map_delete_elem(map, key);
>>   }
>>   
>
>
> .


