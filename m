Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9E318297
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 01:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBKAZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 19:25:46 -0500
Received: from www62.your-server.de ([213.133.104.62]:35130 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBKAZo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 19:25:44 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l9zn4-0004cp-6j; Thu, 11 Feb 2021 01:25:02 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l9zn4-000Xn3-0p; Thu, 11 Feb 2021 01:25:02 +0100
Subject: Re: [PATCH bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>
Cc:     bpf@vger.kernel.org, luka.perkov@sartura.hr,
        luka.oreskovic@sartura.hr, juraj.vijtiuk@sartura.hr,
        andrii.nakryiko@gmail.com
References: <YBGe5WFzSc3Z8Oh5@gmail.com>
 <74e61161-3330-88b8-aa18-84d7357cd945@iogearbox.net>
 <YCQeYte5OB0PNUE9@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2cd4c65f-e985-7eb7-4c00-eaa643f6486f@iogearbox.net>
Date:   Thu, 11 Feb 2021 01:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YCQeYte5OB0PNUE9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26076/Wed Feb 10 13:25:58 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/10/21 6:56 PM, Denis Salopek wrote:
> On Fri, Jan 29, 2021 at 04:58:12PM +0100, Daniel Borkmann wrote:
>> On 1/27/21 6:12 PM, Denis Salopek wrote:
>>> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
>>> hashtab maps, in addition to stacks and queues.
>>> Create a new hashtab bpf_map_ops function that does lookup and deletion
>>> of the element under the same bucket lock and add the created map_ops to
>>> bpf.h.
>>> Add the appropriate test case to 'maps' selftests.
>>>
>>> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
>>> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
>>> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
>>> Cc: Luka Perkov <luka.perkov@sartura.hr>
>>
>> This is already possible in a more generic form, that is, via bpf(2) cmd
>> BPF_MAP_LOOKUP_AND_DELETE_BATCH which is implemented by the different htab
>> map flavors which also take the bucket lock. Did you have a try at that?
>>
>>> ---
>>>    include/linux/bpf.h                     |  1 +
>>>    kernel/bpf/hashtab.c                    | 38 +++++++++++++++++++++++++
>>>    kernel/bpf/syscall.c                    |  9 ++++++
>>>    tools/testing/selftests/bpf/test_maps.c |  7 +++++
>>>    4 files changed, 55 insertions(+)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 1aac2af12fed..003c1505f0e3 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -77,6 +77,7 @@ struct bpf_map_ops {
>>>    	/* funcs callable from userspace and from eBPF programs */
>>>    	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
>>> +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key, void *value);
>>>    	int (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
>>>    	int (*map_delete_elem)(struct bpf_map *map, void *key);
>>>    	int (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index c1ac7f964bc9..8d8463e0ea34 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -973,6 +973,43 @@ static int check_flags(struct bpf_htab *htab, struct htab_elem *l_old,
>>>    	return 0;
>>>    }
>>> +/* Called from syscall or from eBPF program */
>>> +static int htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value)
>>> +{
>>> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>> +	struct hlist_nulls_head *head;
>>> +	struct bucket *b;
>>> +	struct htab_elem *l;
>>> +	unsigned long flags;
>>> +	u32 hash, key_size;
>>> +	int ret;
>>> +
>>> +	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
>>> +
>>> +	key_size = map->key_size;
>>> +
>>> +	hash = htab_map_hash(key, key_size, htab->hashrnd);
>>> +	b = __select_bucket(htab, hash);
>>> +	head = &b->head;
>>> +
>>> +	ret = htab_lock_bucket(htab, b, hash, &flags);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	l = lookup_elem_raw(head, hash, key, key_size);
>>> +
>>> +	if (l) {
>>> +		copy_map_value(map, value, l->key + round_up(key_size, 8));
>>> +		hlist_nulls_del_rcu(&l->hash_node);
>>> +		free_htab_elem(htab, l);
>>> +	} else {
>>> +		ret = -ENOENT;
>>> +	}
>>> +
>>> +	htab_unlock_bucket(htab, b, hash, flags);
>>> +	return ret;
>>> +}
>>> +
>>>    /* Called from syscall or from eBPF program */
>>>    static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>>>    				u64 map_flags)
>>> @@ -1877,6 +1914,7 @@ const struct bpf_map_ops htab_map_ops = {
>>>    	.map_free = htab_map_free,
>>>    	.map_get_next_key = htab_map_get_next_key,
>>>    	.map_lookup_elem = htab_map_lookup_elem,
>>> +	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
>>>    	.map_update_elem = htab_map_update_elem,
>>>    	.map_delete_elem = htab_map_delete_elem,
>>>    	.map_gen_lookup = htab_map_gen_lookup,
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index e5999d86c76e..4ff45c8d1077 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -1505,6 +1505,15 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>>>    	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>>>    	    map->map_type == BPF_MAP_TYPE_STACK) {
>>>    		err = map->ops->map_pop_elem(map, value);
>>> +	} else if (map->map_type == BPF_MAP_TYPE_HASH) {
>>> +		if (!bpf_map_is_dev_bound(map)) {
>>> +			bpf_disable_instrumentation();
>>> +			rcu_read_lock();
>>> +			err = map->ops->map_lookup_and_delete_elem(map, key, value);
>>> +			rcu_read_unlock();
>>> +			bpf_enable_instrumentation();
>>> +			maybe_wait_bpf_programs(map);
>>> +		}
>>>    	} else {
>>>    		err = -ENOTSUPP;
>>>    	}
> 
> Hi,
> 
> Is there something wrong with adding hashmap functionality to the
> map_lookup_and_delete_elem() function? As per commit
> bd513cd08f10cbe28856f99ae951e86e86803861, adding this functionality for
> other map types was the plan at the time this function was implemented,
> so wouldn't this addition be useful? Otherwise, this function would only
> be used for stack/queue popping. So why does it even exist in the first
> place, if the _batch function can be used instead?
> 
> I understand the _batch function can do the same job, but is there a
> reason why using it would be a better option? There is also a
> performance impact in the _batch function when compared to my function -
> not too big, but still worth the mention. In my benchmarks, the _batch
> function takes 15% longer for lookup and deletion of one element.

Thanks for the benchmark, out of curiosity do you happen to have numbers
at what point it pays off (2/3/more elems)? I don't think anything speaks
against single lookup + delete functionality given the cmd API is already
set in stone and it might be easier to use (though libbpf could also hide
this behind api), but it would be nice if we could ideally reuse the batch
lookup + delete code (e.g. bpf_map_do_batch()) in order to get this
transparently for free for the various other map types as well.

Thanks,
Daniel
