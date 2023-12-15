Return-Path: <bpf+bounces-17952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948B8140B6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 04:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65464B2226F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994353A7;
	Fri, 15 Dec 2023 03:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7B5382
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Srw2c0Tqkz4f3jZ4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 11:39:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54CDD1A017F
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 11:39:53 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAXckKGyntlfxUmDw--.38830S2;
	Fri, 15 Dec 2023 11:39:53 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 xingwei lee <xrivendell7@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231214043010.3458072-1-houtao@huaweicloud.com>
 <20231214043010.3458072-2-houtao@huaweicloud.com>
 <657a9f1ea1ff4_48672208f0@john.notmuch>
 <ba0e18ba-f6be-ceb9-412e-48e8e41cb5b6@huaweicloud.com>
 <CAADnVQK+C+9BVowRxESJhuH7BM+SWn2u_fTU2wjH0YuA-N9egw@mail.gmail.com>
 <657b545493a0b_511332086@john.notmuch>
 <CAADnVQJ6EmsOPqCtP2zJVNFDONhXx+KOnO=Pt6ho01vP_7ws0A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <86ef0506-07ff-b4d0-fcdc-07e71f979c13@huaweicloud.com>
Date: Fri, 15 Dec 2023 11:39:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ6EmsOPqCtP2zJVNFDONhXx+KOnO=Pt6ho01vP_7ws0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAXckKGyntlfxUmDw--.38830S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW3Aw13Gr48GF47Cr4rKrg_yoW5Jw1fpr
	WkK3WUtr1vkrn7ZwnFqa1xKrW7KayUGr17XrWUXrW5JF1DKr1xWr1UJF4S9F1rtrnrCr4r
	Zay2qa4Sk34rArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/15/2023 11:23 AM, Alexei Starovoitov wrote:
> On Thu, Dec 14, 2023 at 11:15 AM John Fastabend
> <john.fastabend@gmail.com> wrote:
>> Alexei Starovoitov wrote:
>>> On Wed, Dec 13, 2023 at 11:31 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> Hi,
>>>>
>>>> On 12/14/2023 2:22 PM, John Fastabend wrote:
>>>>> Hou Tao wrote:
>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>
>>>>>> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
>>>>>> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
>>>>>> callbacks.
>>>>>>
>>>>>> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
>>>>>> rcu-read-lock because array->ptrs must still be allocated. For
>>>>>> bpf_fd_htab_map_update_elem(), htab_map_update_elem() only requires
>>>>>> rcu-read-lock to be held to avoid the WARN_ON_ONCE(), so only use
>>>>>> rcu_read_lock() during the invocation of htab_map_update_elem().
>>>>>>
>>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>>>> ---
>>>>>>  kernel/bpf/hashtab.c | 6 ++++++
>>>>>>  kernel/bpf/syscall.c | 4 ----
>>>>>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>>> index 5b9146fa825f..ec3bdcc6a3cf 100644
>>>>>> --- a/kernel/bpf/hashtab.c
>>>>>> +++ b/kernel/bpf/hashtab.c
>>>>>> @@ -2523,7 +2523,13 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
>>>>>>      if (IS_ERR(ptr))
>>>>>>              return PTR_ERR(ptr);
>>>>>>
>>>>>> +    /* The htab bucket lock is always held during update operations in fd
>>>>>> +     * htab map, and the following rcu_read_lock() is only used to avoid
>>>>>> +     * the WARN_ON_ONCE in htab_map_update_elem().
>>>>>> +     */
>> Ah ok but isn't this comment wrong because you do need rcu read lock to do
>> the walk with lookup_nulls_elem_raw where there is no lock being held? And
>> then the subsequent copy in place is fine because you do have a lock.
> Ohh. You're correct.
> Not sure what I was thinking.
>
> Hou,
> could you please send a follow up to undo my braino.
Er, I didn't follow. There is no spin-lock support in fd htab map, so
htab_map_update_elem() won't call lookup_nulls_elem_raw(), instead it
will lock the bucket and invoke lookup_elem_raw(), so I don't think
rcu_read_lock() is indeed needed for the invocation of
htab_map_update_elem(), except to make WARN_ON_ONC() happy.


