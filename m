Return-Path: <bpf+bounces-4145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC39749368
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 04:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A071C20C84
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 02:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4041A46;
	Thu,  6 Jul 2023 02:01:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D467F
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 02:01:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8923B1996
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 19:01:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QxKWs1htgz4f3pHY
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:01:29 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgB3CDN2IKZkNTZcMg--.55347S2;
	Thu, 06 Jul 2023 10:01:29 +0800 (CST)
Subject: Re: [v3 PATCH bpf-next 3/6] bpf: populate the per-cpu
 insertions/deletions counters for hashmaps
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-4-aspsk@isovalent.com>
 <05a3c521-3c6f-79c2-a5a8-1f8ab35eb759@huaweicloud.com>
 <ZKQt84Qz0A0ZkgN1@zh-lab-node-5>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b1b9e2b8-f31e-abf5-8853-cb64bb0232a6@huaweicloud.com>
Date: Thu, 6 Jul 2023 10:01:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKQt84Qz0A0ZkgN1@zh-lab-node-5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgB3CDN2IKZkNTZcMg--.55347S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF15Cr47Jw43XFy8GF4rXwb_yoW8urWDpr
	WkKF15KF4vqr93G3sxtw48Kry5Cws5Ca15Ww12kryFvw1vgrnaka1UKF4Y9FyDAry8AF10
	vFyY9ryF93W5Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/4/2023 10:34 PM, Anton Protopopov wrote:
> On Tue, Jul 04, 2023 at 09:56:36PM +0800, Hou Tao wrote:
>> Hi,
>>
>> On 6/30/2023 4:25 PM, Anton Protopopov wrote:
>>> Initialize and utilize the per-cpu insertions/deletions counters for hash-based
>>> maps. Non-trivial changes only apply to the preallocated maps for which the
>>> {inc,dec}_elem_count functions are not called, as there's no need in counting
>>> elements to sustain proper map operations.
>>>
>>> To increase/decrease percpu counters for preallocated maps we add raw calls to
>>> the bpf_map_{inc,dec}_elem_count functions so that the impact is minimal. For
>>> dynamically allocated maps we add corresponding calls to the existing
>>> {inc,dec}_elem_count functions.
>>>
>>> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
>>> ---
>>>  kernel/bpf/hashtab.c | 23 ++++++++++++++++++++---
>>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 56d3da7d0bc6..faaef4fd3df0 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -581,8 +581,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>>  		}
>>>  	}
>>>  
>>> +	err = bpf_map_init_elem_count(&htab->map);
>>> +	if (err)
>>> +		goto free_extra_elements;
>> Considering the per-cpu counter is not always needed, is it a good idea
>> to make the elem_count being optional by introducing a new map flag ?
> Per-map-flag or a static key? For me it looked like just doing an unconditional
> `inc` for a per-cpu variable is better vs. doing a check then `inc` or an
> unconditional jump.

Sorry I didn't make it clear that I was worried about the allocated
per-cpu memory. Previous I thought the per-cpu memory is limited, but
after did some experiments I found it was almost the same as kmalloc()
which could use all available memory to fulfill the allocation request.
For a host with 72-cpus, the memory overhead for 10k hash map is about
~6MB. The overhead is tiny compared with the total available memory, but
it is avoidable.


