Return-Path: <bpf+bounces-17351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8180BEAA
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 02:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF434280ABC
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D97495;
	Mon, 11 Dec 2023 01:08:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E5AE7
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 17:08:52 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpNt74Jfdz4f3jJ2
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:08:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C23DA1A0897
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 09:08:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgD3UUIcYXZleI+gDQ--.22278S2;
	Mon, 11 Dec 2023 09:08:48 +0800 (CST)
Subject: Re: [PATCH RESEND bpf-next 1/2] bpf: Reduce the scope of
 rcu_read_lock when updating fd map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
References: <20231208103357.2637299-1-houtao@huaweicloud.com>
 <20231208103357.2637299-2-houtao@huaweicloud.com>
 <CAADnVQJ0TxpDPYij-rHgcEb2J=r_RmnPgDe=VVJPan1ieT5dng@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b99f7dd9-c666-cfde-38f3-319c9847f182@huaweicloud.com>
Date: Mon, 11 Dec 2023 09:08:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ0TxpDPYij-rHgcEb2J=r_RmnPgDe=VVJPan1ieT5dng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgD3UUIcYXZleI+gDQ--.22278S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyfJrWktry5CryUuF1fCrg_yoW5Jr43p3
	95Ga47Ka10qFnru34Sva1IgrWUJw15Xws7tF4ktrWFyr1UWrna9r18Ga93XF1YyrnrAr40
	qa4avF9ak3yUZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 12/10/2023 1:36 PM, Alexei Starovoitov wrote:
> On Fri, Dec 8, 2023 at 2:32 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
>> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
>> callbacks.
>>
>> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
>> rcu-read-lock because array->ptrs will not be freed until the map-in-map
>> is released. For bpf_fd_htab_map_update_elem(), htab_map_update_elem()
>> requires rcu-read-lock to be held, so only use rcu_read_lock() during
>> the invocation of htab_map_update_elem().
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  kernel/bpf/hashtab.c | 2 ++
>>  kernel/bpf/syscall.c | 4 ----
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index b777bd8d4f8d..50b539c11b29 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -2525,7 +2525,9 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
>>         if (IS_ERR(ptr))
>>                 return PTR_ERR(ptr);
>>
>> +       rcu_read_lock();
>>         ret = htab_map_update_elem(map, key, &ptr, map_flags);
>> +       rcu_read_unlock();
>>         if (ret)
>>                 map->ops->map_fd_put_ptr(map, ptr, false);
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 6b9d7990d95f..fd9b73e02c7a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -190,15 +190,11 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>>                 err = bpf_percpu_cgroup_storage_update(map, key, value,
>>                                                        flags);
>>         } else if (IS_FD_ARRAY(map)) {
>> -               rcu_read_lock();
>>                 err = bpf_fd_array_map_update_elem(map, map_file, key, value,
>>                                                    flags);
>> -               rcu_read_unlock();
>>         } else if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
>> -               rcu_read_lock();
>>                 err = bpf_fd_htab_map_update_elem(map, map_file, key, value,
>>                                                   flags);
>> -               rcu_read_unlock();
> I feel it's inconsistent to treat an array of FDs differently than
> hashmap of FDs.
> The patch is correct, but the users shouldn't be exposed
> to array vs hashtab implementation details.
I see. Will add rcu_read_lock/rcu_read_unlock() in
bpf_fd_array_map_update_elem() as well, so fd array will be consistent
with fd htab.


