Return-Path: <bpf+bounces-44119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67469BE334
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 10:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010721C22C63
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986B1DB94F;
	Wed,  6 Nov 2024 09:53:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0301DB520
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886796; cv=none; b=nR9jl9k5tp4lfQz5P/5lypv1+Wnk17CmkzsK0XpnzlpmZ/zYgM27rj/k0jCNVkno6hBBbofAH8HgPV1DtT0a/DQ5J6UbK/8Kbb3xjLsR6Ls1NVb8Az1OrZuXXgnsaXzsy2mGFyAIAvq2SmW0pdSBAsXbNIFSsQm8doJde3hM6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886796; c=relaxed/simple;
	bh=3PBbC7j16Y4r+gYCmPbdh9sQRnqElSTpiayvGLM5zxc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PVdZunlsGEbSaaAYw7fwMBbtYpGSUoYSna454WIcpIWx24GOBFlm5inwxg05FPW2virapczHgSBdxY98v4up/73KJAL7TxmgOm/NuB5u+vctfKM9nejiIG8i9xNYk350NKKDPAV+yEE7r9ucG6X4WQv3bIo+hPI1n9E9LljKWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xk0r847pCz4f3l8V
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 17:52:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 710D91A0196
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 17:53:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAXDK6CPCtnkQDsAw--.35992S2;
	Wed, 06 Nov 2024 17:53:09 +0800 (CST)
Subject: Re: [PATCH bpf-next 1/3] bpf: Call free_htab_elem() after
 htab_unlock_bucket()
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, xukuohai@huawei.com,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20241106063542.357743-1-houtao@huaweicloud.com>
 <20241106063542.357743-2-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <102c9956-6e85-36c8-68f5-32115a2744a1@huaweicloud.com>
Date: Wed, 6 Nov 2024 17:53:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241106063542.357743-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAXDK6CPCtnkQDsAw--.35992S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1xXF45Gry8ArW8Aw15twb_yoWfZw1UpF
	WrWr47Kw1kZr9F9w4Yqa1jgrWUZr4DJ34UCrykGry8Jrn8ur9agw4xAFZ2kryrCr97AFs3
	XrZFqw1rKay5CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 11/6/2024 2:35 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> For htab of maps, when the map is removed from the htab, it may hold the
> last reference of the map. bpf_map_fd_put_ptr() will invoke
> bpf_map_free_id() to free the id of the removed map element. However,
> bpf_map_fd_put_ptr() is invoked while holding a bucket lock
> (raw_spin_lock_t), and bpf_map_free_id() attempts to acquire map_idr_lock
> (spinlock_t), triggering the following lockdep warning:
>
>   =============================
>   [ BUG: Invalid wait context ]
>   6.11.0-rc4+ #49 Not tainted
>   -----------------------------
>   test_maps/4881 is trying to lock:
>   ffffffff84884578 (map_idr_lock){+...}-{3:3}, at: bpf_map_free_id.part.0+0x21/0x70
>   other info that might help us debug this:
>   context-{5:5}
>   2 locks held by test_maps/4881:
>    #0: ffffffff846caf60 (rcu_read_lock){....}-{1:3}, at: bpf_fd_htab_map_update_elem+0xf9/0x270
>    #1: ffff888149ced148 (&htab->lockdep_key#2){....}-{2:2}, at: htab_map_update_elem+0x178/0xa80
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 4881 Comm: test_maps Not tainted 6.11.0-rc4+ #49
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x6e/0xb0
>    dump_stack+0x10/0x20
>    __lock_acquire+0x73e/0x36c0
>    lock_acquire+0x182/0x450
>    _raw_spin_lock_irqsave+0x43/0x70
>    bpf_map_free_id.part.0+0x21/0x70
>    bpf_map_put+0xcf/0x110
>    bpf_map_fd_put_ptr+0x9a/0xb0
>    free_htab_elem+0x69/0xe0
>    htab_map_update_elem+0x50f/0xa80
>    bpf_fd_htab_map_update_elem+0x131/0x270
>    htab_map_update_elem+0x50f/0xa80
>    bpf_fd_htab_map_update_elem+0x131/0x270
>    bpf_map_update_value+0x266/0x380
>    __sys_bpf+0x21bb/0x36b0
>    __x64_sys_bpf+0x45/0x60
>    x64_sys_call+0x1b2a/0x20d0
>    do_syscall_64+0x5d/0x100
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> One way to fix the lockdep warning is using raw_spinlock_t for
> map_idr_lock as well. However, bpf_map_alloc_id() invokes
> idr_alloc_cyclic() after acquiring map_idr_lock, it will trigger a
> similar lockdep warning because the slab's lock (s->cpu_slab->lock) is
> still a spinlock.

Is it OK to move the calling of bpf_map_free_id() from bpf_map_put() to
bpf_map_free_deferred() ? It could fix the lockdep warning for htab of
maps. Its downside is that the free of map id will be delayed, but I
think it will not make a visible effect to the user, because the refcnt
is already 0, trying to get the map fd through map id will return -ENOENT.
> Instead of changing map_idr_lock's type, fix the issue by invoking
> htab_put_fd_value() after htab_unlock_bucket(). However, only deferring
> the invocation of htab_put_fd_value() is not enough, because the old map
> pointers in htab of maps can not be saved during batched deletion.
> Therefore, also defer the invocation of free_htab_elem(), so these
> to-be-freed elements could be linked together similar to lru map.
>
> There are four callers for ->map_fd_put_ptr:
>
> (1) alloc_htab_elem() (through htab_put_fd_value())
> It invokes ->map_fd_put_ptr() under a raw_spinlock_t. The invocation of
> htab_put_fd_value() can not simply move after htab_unlock_bucket(),
> because the old element has already been stashed in htab->extra_elems.
> It may be reused immediately after htab_unlock_bucket() and the
> invocation of htab_put_fd_value() after htab_unlock_bucket() may release
> the newly-added element incorrectly. Therefore, saving the map pointer
> of the old element for htab of maps before unlocking the bucket and
> releasing the map_ptr after unlock. Beside the map pointer in the old
> element, should do the same thing for the special fields in the old
> element as well.
>
> (2) free_htab_elem() (through htab_put_fd_value())
> Its caller includes __htab_map_lookup_and_delete_elem(),
> htab_map_delete_elem() and __htab_map_lookup_and_delete_batch().
>
> For htab_map_delete_elem(), simply invoke free_htab_elem() after
> htab_unlock_bucket(). For __htab_map_lookup_and_delete_batch(), just
> like lru map, linking the to-be-freed element into node_to_free list
> and invoking free_htab_elem() for these element after unlock. It is safe
> to reuse batch_flink as the link for node_to_free, because these
> elements have been removed from the hash llist.
>
> Because htab of maps doesn't support lookup_and_delete operation,
> __htab_map_lookup_and_delete_elem() doesn't have the problem, so kept
> it as is.
>
> (3) fd_htab_map_free()
> It invokes ->map_fd_put_ptr without raw_spinlock_t.
>
> (4) bpf_fd_htab_map_update_elem()
> It invokes ->map_fd_put_ptr without raw_spinlock_t.
>
> After moving free_htab_elem() outside htab bucket lock scope, using
> pcpu_freelist_push() instead of __pcpu_freelist_push() to disable
> the irq before freeing elements, and protecting the invocations of
> bpf_mem_cache_free() with migrate_{disable|enable} pair.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 56 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b14b87463ee0..3ec941a0ea41 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -896,9 +896,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
>  {
>  	check_and_free_fields(htab, l);
> +
> +	migrate_disable();
>  	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
>  		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
>  	bpf_mem_cache_free(&htab->ma, l);
> +	migrate_enable();
>  }
>  
>  static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
> @@ -948,7 +951,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
>  	if (htab_is_prealloc(htab)) {
>  		bpf_map_dec_elem_count(&htab->map);
>  		check_and_free_fields(htab, l);
> -		__pcpu_freelist_push(&htab->freelist, &l->fnode);
> +		pcpu_freelist_push(&htab->freelist, &l->fnode);
>  	} else {
>  		dec_elem_count(htab);
>  		htab_elem_free(htab, l);
> @@ -1018,7 +1021,6 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  			 */
>  			pl_new = this_cpu_ptr(htab->extra_elems);
>  			l_new = *pl_new;
> -			htab_put_fd_value(htab, old_elem);
>  			*pl_new = old_elem;
>  		} else {
>  			struct pcpu_freelist_node *l;
> @@ -1105,6 +1107,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	struct htab_elem *l_new = NULL, *l_old;
>  	struct hlist_nulls_head *head;
>  	unsigned long flags;
> +	void *old_map_ptr;
>  	struct bucket *b;
>  	u32 key_size, hash;
>  	int ret;
> @@ -1183,12 +1186,27 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
>  	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>  	if (l_old) {
>  		hlist_nulls_del_rcu(&l_old->hash_node);
> +
> +		/* l_old has already been stashed in htab->extra_elems, free
> +		 * its special fields before it is available for reuse. Also
> +		 * save the old map pointer in htab of maps before unlock
> +		 * and release it after unlock.
> +		 */
> +		old_map_ptr = NULL;
> +		if (htab_is_prealloc(htab)) {
> +			if (map->ops->map_fd_put_ptr)
> +				old_map_ptr = fd_htab_map_get_ptr(map, l_old);
> +			check_and_free_fields(htab, l_old);
> +		}
> +	}
> +	htab_unlock_bucket(htab, b, hash, flags);
> +	if (l_old) {
> +		if (old_map_ptr)
> +			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
>  		if (!htab_is_prealloc(htab))
>  			free_htab_elem(htab, l_old);
> -		else
> -			check_and_free_fields(htab, l_old);
>  	}
> -	ret = 0;
> +	return 0;
>  err:
>  	htab_unlock_bucket(htab, b, hash, flags);
>  	return ret;
> @@ -1432,15 +1450,15 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
>  		return ret;
>  
>  	l = lookup_elem_raw(head, hash, key, key_size);
> -
> -	if (l) {
> +	if (l)
>  		hlist_nulls_del_rcu(&l->hash_node);
> -		free_htab_elem(htab, l);
> -	} else {
> +	else
>  		ret = -ENOENT;
> -	}
>  
>  	htab_unlock_bucket(htab, b, hash, flags);
> +
> +	if (l)
> +		free_htab_elem(htab, l);
>  	return ret;
>  }
>  
> @@ -1853,13 +1871,14 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  			 * may cause deadlock. See comments in function
>  			 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
>  			 * after releasing the bucket lock.
> +			 *
> +			 * For htab of maps, htab_put_fd_value() in
> +			 * free_htab_elem() may acquire a spinlock with bucket
> +			 * lock being held and it violates the lock rule, so
> +			 * invoke free_htab_elem() after unlock as well.
>  			 */
> -			if (is_lru_map) {
> -				l->batch_flink = node_to_free;
> -				node_to_free = l;
> -			} else {
> -				free_htab_elem(htab, l);
> -			}
> +			l->batch_flink = node_to_free;
> +			node_to_free = l;
>  		}
>  		dst_key += key_size;
>  		dst_val += value_size;
> @@ -1871,7 +1890,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>  	while (node_to_free) {
>  		l = node_to_free;
>  		node_to_free = node_to_free->batch_flink;
> -		htab_lru_push_free(htab, l);
> +		if (is_lru_map)
> +			htab_lru_push_free(htab, l);
> +		else
> +			free_htab_elem(htab, l);
>  	}
>  
>  next_batch:


