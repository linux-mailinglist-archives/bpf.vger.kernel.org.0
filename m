Return-Path: <bpf+bounces-14556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D797E6494
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CC31C204E8
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 07:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267FDDDE;
	Thu,  9 Nov 2023 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F5F9EE
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:44:34 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA25268D
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:44:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SQv9S3QR4z4f3mJY
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:44:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 94C211A0199
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:44:29 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3Bw7ZjUxlL5HDAQ--.2114S2;
	Thu, 09 Nov 2023 15:44:29 +0800 (CST)
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
 <94fcdeab-4095-fca9-d901-25e6dee0d832@huaweicloud.com>
 <ff0266b2-8388-9027-4e85-4fee9d83f17f@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e69083b3-f4a1-68af-8cd6-26146a1ad85b@huaweicloud.com>
Date: Thu, 9 Nov 2023 15:44:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ff0266b2-8388-9027-4e85-4fee9d83f17f@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3Bw7ZjUxlL5HDAQ--.2114S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13KF1rXrWrWrW5Jw4rAFb_yoW5Zr1fpF
	yvya45KryYgrsavw12va4IqryUKr4UKa1DJw4kXay5AF4DGrnagryxXFsIgFyYyr4rJr4U
	Xw13WwnxZry8AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/9/2023 3:02 PM, Martin KaFai Lau wrote:
> On 11/8/23 7:46 PM, Hou Tao wrote:
>> Hi,
>>
>> On 11/9/2023 7:11 AM, Martin KaFai Lau wrote:
>>> On 11/7/23 6:06 AM, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> These three bpf_map_{lookup,update,delete}_elem() helpers are also
>>>> available for sleepable bpf program, so add the corresponding lock
>>>> assertion for sleepable bpf program, otherwise the following warning
>>>> will be reported when a sleepable bpf program manipulates bpf map
>>>> under
>>>> interpreter mode (aka bpf_jit_enable=0):
>>>>
>> SNIP
>>>>    BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
>>>>    {
>>>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>>>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>>>> !rcu_read_lock_trace_held() &&
>>>> +             !rcu_read_lock_bh_held());
>>>>        return (unsigned long) map->ops->map_lookup_elem(map, key);
>>>>    }
>>>>    @@ -53,7 +54,8 @@ const struct bpf_func_proto
>>>> bpf_map_lookup_elem_proto = {
>>>>    BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
>>>>           void *, value, u64, flags)
>>>>    {
>>>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>>>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>>>> !rcu_read_lock_trace_held() &&
>>>> +             !rcu_read_lock_bh_held());
>>>>        return map->ops->map_update_elem(map, key, value, flags);
>>>>    }
>>>>    @@ -70,7 +72,8 @@ const struct bpf_func_proto
>>>> bpf_map_update_elem_proto = {
>>>>      BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *,
>>>> key)
>>>>    {
>>>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>>>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>>>> !rcu_read_lock_trace_held() &&
>>>> +             !rcu_read_lock_bh_held());
>>>
>>> Should these WARN_ON_ONCE be removed from the helpers instead?
>>>
>>> For catching error purpose, the ops->map_{lookup,update,delete}_elem
>>> are inlined  for the jitted case which I believe is the bpf-CI setting
>>> also. Meaning the above change won't help to catch error in the common
>>> normal case.
>>
>> Removing these WARN_ON_ONCE is also an option. Considering JIT is not
>> available for all architectures and there is no KASAN support in JIT,
>> could we enable BPF interpreter mode in BPF CI to find more potential
>> problems ?
>
> ah. The test in patch 11 needs jit to be off because the
> map_gen_lookup inlined the code? Would it help to use
> bpf_map_update_elem(inner_map,...) to trigger the issue instead?

Er, I didn't consider that before, but you are right.
bpf_map_lookup_elem(inner_map) is inlined by verifier. I think using
bpf_map_update_elem() may be able to reproduce the issue under JIT mode.
Will try later.
>
>>
>>>
>>>>        return map->ops->map_delete_elem(map, key);
>>>>    }
>>>>    
>>>
>>>
>>> .
>>
>
> .


