Return-Path: <bpf+bounces-17352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FD80BEAD
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 02:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185CC1F20F69
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 01:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306DD749E;
	Mon, 11 Dec 2023 01:11:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BAAA9
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 17:11:40 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpNxN1Kjcz4f3jJ2
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:11:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5BC1E1A0193
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:11:37 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCH303GYXZlzvWnDQ--.23144S2;
	Mon, 11 Dec 2023 09:11:37 +0800 (CST)
Subject: Re: [PATCH bpf-next 6/7] bpf: Only call maybe_wait_bpf_programs()
 when at least one map operation succeeds
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Hou Tao <houtao1@huawei.com>
References: <20231208102355.2628918-1-houtao@huaweicloud.com>
 <20231208102355.2628918-7-houtao@huaweicloud.com>
 <35510021-8c55-455b-894f-6b7656f8b8d4@linux.dev>
 <CAADnVQJXn2SezUefQQ_k=HLg2ZS7_G_q1sicXJvQxYG-BNa_zQ@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f199c058-3fd3-4f9b-fc0e-b7875e2d36c3@huaweicloud.com>
Date: Mon, 11 Dec 2023 09:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJXn2SezUefQQ_k=HLg2ZS7_G_q1sicXJvQxYG-BNa_zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCH303GYXZlzvWnDQ--.23144S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4UCFyftF13Kr45WF1rJFb_yoW8ZrWxpa
	48GayjkF4jgr47JwsIva1jq3ZFvrsrKr4fJ3y8Ga45CF4DXrn7CrW0gF4j9ryF9r10yr40
	qw17ta4fWw1SyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi

On 12/10/2023 10:11 AM, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 2:55 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 12/8/23 2:23 AM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> There is no need to call maybe_wait_bpf_programs() if all operations in
>>> batched update, deletion, or lookup_and_deletion fail. So only call
>>> maybe_wait_bpf_programs() if at least one map operation succeeds.
>>>

SNIP
>>> +     attr->batch.count = 0;
>>>       if (put_user(0, &uattr->batch.count))
>>>               return -EFAULT;
>>>
>>> @@ -1903,6 +1908,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>>>       if (err == -EFAULT)
>>>               goto free_buf;
>>>
>>> +     attr->batch.count = cp;
>> You don't need to change generic_map_lookup_batch() here. It won't trigger
>> maybe_wait_bpf_programs().
>>
>>>       if ((copy_to_user(&uattr->batch.count, &cp, sizeof(cp)) ||
>>>                   (cp && copy_to_user(uobatch, prev_key, map->key_size))))
>>>               err = -EFAULT;
>>> @@ -4926,7 +4932,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>>>               err = fn(__VA_ARGS__);          \
>>>       } while (0)
>>>
>>> -static int bpf_map_do_batch(const union bpf_attr *attr,
>>> +static int bpf_map_do_batch(union bpf_attr *attr,
>>>                           union bpf_attr __user *uattr,
>>>                           int cmd)
>>>   {
>>> @@ -4966,7 +4972,8 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
>>>               BPF_DO_BATCH(map->ops->map_delete_batch, map, attr, uattr);
>>>   err_put:
>>>       if (has_write) {
>>> -             maybe_wait_bpf_programs(map);
>>> +             if (attr->batch.count)
>>> +                     maybe_wait_bpf_programs(map);
>> Your code logic sounds correct but I feel you are optimizing for extreme
>> corner cases. In really esp production environment, a fault with something
>> like copy_to_user() should be extremely rare. So in my opinion, this optimization
>> is not needed.
> +1
> the code is fine as-is.

Thanks for suggestions. It is indeed an over-optimization for a rare
scenario. Will drop it.


