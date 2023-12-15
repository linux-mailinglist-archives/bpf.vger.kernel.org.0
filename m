Return-Path: <bpf+bounces-17971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B481436F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CDA1C22606
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D211CBC;
	Fri, 15 Dec 2023 08:18:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FFE11C8D
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ss2D539BXz4f3k6d
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:18:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B3BCD1A0C8C
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 16:18:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3EULSC3xlsmM4Dw--.23978S2;
	Fri, 15 Dec 2023 16:18:30 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reduce the scope of rcu_read_lock
 when updating fd map
To: John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <441aaa49-b7ab-9694-d4c7-f9659cc23780@huaweicloud.com>
Date: Fri, 15 Dec 2023 16:18:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <657b545493a0b_511332086@john.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3EULSC3xlsmM4Dw--.23978S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW7CFy3Aw4xKF1kZry7Wrg_yoWxXr1UpF
	ykCFWUKr18XFsIgw4ava93WryUtw45WF47Xws5J3y5Arn8KF1fWr1xtFs3uFn0kr17JF48
	X347W3sxA348A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 12/15/2023 3:15 AM, John Fastabend wrote:
> Alexei Starovoitov wrote:
>> On Wed, Dec 13, 2023 at 11:31 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>> Hi,
>>>
>>> On 12/14/2023 2:22 PM, John Fastabend wrote:
>>>> Hou Tao wrote:
>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>
>>>>> There is no rcu-read-lock requirement for ops->map_fd_get_ptr() or
>>>>> ops->map_fd_put_ptr(), so doesn't use rcu-read-lock for these two
>>>>> callbacks.
>>>>>
>>>>> For bpf_fd_array_map_update_elem(), accessing array->ptrs doesn't need
>>>>> rcu-read-lock because array->ptrs must still be allocated. For
>>>>> bpf_fd_htab_map_update_elem(), htab_map_update_elem() only requires
>>>>> rcu-read-lock to be held to avoid the WARN_ON_ONCE(), so only use
>>>>> rcu_read_lock() during the invocation of htab_map_update_elem().
>>>>>
>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>>>>> ---
>>>>>  kernel/bpf/hashtab.c | 6 ++++++
>>>>>  kernel/bpf/syscall.c | 4 ----
>>>>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>> index 5b9146fa825f..ec3bdcc6a3cf 100644
>>>>> --- a/kernel/bpf/hashtab.c
>>>>> +++ b/kernel/bpf/hashtab.c
>>>>> @@ -2523,7 +2523,13 @@ int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
>>>>>      if (IS_ERR(ptr))
>>>>>              return PTR_ERR(ptr);
>>>>>
>>>>> +    /* The htab bucket lock is always held during update operations in fd
>>>>> +     * htab map, and the following rcu_read_lock() is only used to avoid
>>>>> +     * the WARN_ON_ONCE in htab_map_update_elem().
>>>>> +     */
> Ah ok but isn't this comment wrong because you do need rcu read lock to do
> the walk with lookup_nulls_elem_raw where there is no lock being held? And
> then the subsequent copy in place is fine because you do have a lock.
>
> So its not just to appease the WARN_ON_ONCE here it has an actual real
> need?
>
>>>>> +    rcu_read_lock();
>>>>>      ret = htab_map_update_elem(map, key, &ptr, map_flags);
>>>>> +    rcu_read_unlock();
>>>> Did we consider dropping the WARN_ON_ONCE in htab_map_update_elem()? It
>>>> looks like there are two ways to get to htab_map_update_elem() either
>>>> through a syscall and the path here (bpf_fd_htab_map_update_elem) or
>>>> through a BPF program calling, bpf_update_elem()? In the BPF_CALL
>>>> case bpf_map_update_elem() already has,
>>>>
>>>>    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held())
>>>>
>>>> The htab_map_update_elem() has an additional check for
>>>> rcu_read_lock_trace_held(), but not sure where this is coming from
>>>> at the moment. Can that be added to the BPF caller side if needed?
>>>>
>>>> Did I miss some caller path?
>>> No. But I think the main reason for the extra WARN in
>>> bpf_map_update_elem() is that bpf_map_update_elem() may be inlined by
>>> verifier in do_misc_fixups(), so the WARN_ON_ONCE in
>>> bpf_map_update_elem() will not be invoked ever. For
>>> rcu_read_lock_trace_held(), I have added the assertion in
>>> bpf_map_delete_elem() recently in commit 169410eba271 ("bpf: Check
>>> rcu_read_lock_trace_held() before calling bpf map helpers").
>> Yep.
>> We should probably remove WARN_ONs from
>> bpf_map_update_elem() and others in kernel/bpf/helpers.c
>> since they are inlined by the verifier with 99% probability
>> and the WARNs are never called even in DEBUG kernels.
>> And confusing developers. As this thread shows.
> Agree. The rcu_read needs to be close as possible to where its actually
> needed and the WARN_ON_ONCE should be dropped if its going to be
> inlined.

I did some investigation on these bpf map helpers and the
implementations of these helpers in various kinds of bpf map. It seems
most implementations (besides dev_map_hash_ops) already have added
proper RCU lock assertions, so I think it is indeed OK to remove
WARN_ON_ONCE() on these bpf map helpers after fixing the assertion in
dev_map_hash_ops. The following is the details:

1. bpf_map_lookup_elem helper
(a) hash/lru_hash/percpu_hash/lru_percpu_hash
with !rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
!rcu_read_lock_bh_held() in __htab_map_lookup_elem()

(b) array/percpu_array
no deletion, so no RCU

(c) lpm_trie
with rcu_read_lock_bh_held() in trie_lookup_elem()

(d) htab_of_maps
with !rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
!rcu_read_lock_bh_held() in __htab_map_lookup_elem()

(e) array_of_maps
no deletion, so no RCU

(f) sockmap
rcu_read_lock_held() in __sock_map_lookup_elem()

(g) sockhash
rcu_read_lock_held() in__sock_hash_lookup_elem()

(h) devmap
rcu_read_lock_bh_held() in __dev_map_lookup_elem()

(i) devmap_hash (incorrect assertion)
No rcu_read_lock_bh_held() in __dev_map_hash_lookup_elem()

(j) xskmap
rcu_read_lock_bh_held() in __xsk_map_lookup_elem()

2. bpf_map_update_elem helper
(a) hash/lru_hash/percpu_hash/lru_percpu_hash
with !rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
!rcu_read_lock_bh_held() in
htab_map_update_elem()/htab_lru_map_update_elem()/__htab_percpu_map_update_elem()/__htab_lru_percpu_map_update_elem()

(b) array/percpu_array
no RCU

(c) lpm_trie
use spin-lock, and no RCU

(d) sockmap
use spin-lock & with rcu_read_lock_held() in sock_map_update_common()

(e) sockhash
use spin-lock & with rcu_read_lock_held() in sock_hash_update_common()

3.bpf_map_delete_elem helper
(a) hash/lru_hash/percpu_hash/lru_percpu_hash
with !rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
!rcu_read_lock_bh_held() () in htab_map_delete_elem/htab_lru_map_delete_elem

(b) array/percpu_array
no support

(c) lpm_trie
use spin-lock, no rcu

(d) sockmap
use spin-lock

(e) sockhash
use spin-lock

4. bpf_map_lookup_percpu_elem
(a) percpu_hash/lru_percpu_hash
with !rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
!rcu_read_lock_bh_held() in __htab_map_lookup_elem()

(b) percpu_array
no deletion, no RCU

>> We can replace them with a comment that explains this inlining logic
>> and where the real WARNs are..


