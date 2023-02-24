Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0236A16D3
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 07:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBXG6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 01:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBXG6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 01:58:50 -0500
Received: from out-48.mta1.migadu.com (out-48.mta1.migadu.com [IPv6:2001:41d0:203:375::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA357D1D
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 22:58:41 -0800 (PST)
Message-ID: <60634c64-5e16-c3d8-3561-6b88c5b5b1fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677221919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKrJ+iTo6Msd9Q1v26Z+Uk9V/djpwGfkC2IXc6QHu7E=;
        b=MT3fpVF7rJLZUDm8gkNZ7tpdQu94JQLAx4n7kvjYoD962qgs5f9mys9uTvgTavl/Rn983c
        spifEOK+GLhDIWOg/F4BMJ7Uwuv7bGx77+lfNgjLfZa/WC0yZFPlWvjeukB26G4Zr6L9Nj
        vfbU2Wzejj/3TQcqafH4IZnYc3rZIHc=
Date:   Thu, 23 Feb 2023 22:58:33 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Create links for BPF struct_ops
 maps.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230223011238.12313-1-kuifeng@meta.com>
 <20230223011238.12313-2-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
In-Reply-To: <20230223011238.12313-2-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/22/23 5:12 PM, Kui-Feng Lee wrote:
> +/*
> + * Maintain the state of kvalue.
> + *
> + * For a struct_ops that has no link, its state diagram is
> + *
> + *   INIT ----> INUSE --> TOBEFREE
> + *     ^                     |
> + *     |     (refcnt == 0)   |
> + *     +---------------------+

For non BPF_F_LINK case, no need to transit back to INIT from TOBEFREE to 
support "re"-update or "re"-register. The userspace can create a new struct_ops 
if it needs a different set of bpf prog. The new BPF_F_LINK can be used for 
"re"-register. Keep the existing non BPF_F_LINK case as simple as is.

> + *
> + * For a struct_ops that has a link (BPF_F_LINK), its state diagram is
> + *
> + *                   (refcnt == 0)
> + *              +-----------------------+
> + *              |                       |
> + *              V                       |
> + *   INIT ---> UNREG -+--> INUSE --> TOBEUNREG
> + *     ^              |
> + *     |              V
> + *     +---------- TOBEFREE
> + *     (refcnt == 0)
> + *
> + * After transiting to the INUSE state of a struct_ops, the refcnt of
> + * its kvalue is set to 1.
> + *
> + * After transiting from the INUSE state of a struct_ops, the caller
> + * should decrease the refcnt of its kvalue by 1 by calling
> + * bpf_struct_ops_put().
> + *
> + * TOBEFREE and TOBEUNREG are in a grace period, waiting for other
> + * tasks holding references of the struct_ops.  When the refcnt drops
> + * from 1 to 0, TOBEFREE and TOBEUNREG are transited to INIT and UNREG
> + * respectively.
> + *
> + * It is safe to assume that there will be no registration race
> + * conditions after a task transits the same struct_ops to INUSE,
> + * TOBEFREE and TOBEUNREG states.  The task is able to register or
> + * unregister the struct_ops without the need for any additional
> + * synchronization.
> + */
> +static int bpf_struct_ops_transit_state(struct bpf_struct_ops_map *st_map,
> +					enum bpf_struct_ops_state src,
> +					enum bpf_struct_ops_state dst)
> +{

I think the state transition that requires a rather long switch case is a good 
signal that it needs some simplification. Lets explore how to simplify it. 
Hopefully, it could be simple enough that it does not need a dedicated function 
to transit state. In particular, for BPF_F_LINK, I think it can stay with three 
states:

INIT --> UNREG --> INUSE
            ^         |
            +---------+

TOBEUNREG is a bit confusing. Whenever '->unreg' is called, the unregistration 
is done, so it should be UNREG instead of TOBEUNREG. eg. when 
tcp_unregister_congestion_control() is called, the unreg is done. The existing 
connections may still use it but for the struct_ops concern it is unregistered. 
The user space can inspect how many connections are still using it by checking 
the kvalue->refcnt.

As long as the struct_ops is in UNREG and the userspace has a hold to the map 
fd, the userspace should be able to create a link to register the struct_ops 
(may be the very first time or may be again).

The existing TOBEFREE only makes sense to the existing non BPF_F_LINK use case. 
Whenever the struct_ops is unregistered (by delete_elem), there is no way to 
register again because the registation and update must be done together. The 
struct_ops can only wait to be freed after the very last connections finished 
using it.

Thus, there is no need to have TOBEFREE for the BPF_F_LINK case. Update and 
registration are done separately now.

To simplify it further, I would suggest not to consider the use case that a 
struct_ops can be updated (i.e. update_elem) for the second time. Thus, no need 
to transit back to INIT. The user can always create a new struct_ops with 
another set of bpf progs and do BPF_LINK_UPDATE.

WDYT?

Also, I would suggest not to mix the reg/unreg between the existing non 
BPF_F_LINK map and the new BPF_F_LINK map. The new BPF_F_LINK map should only 
reg/unreg through BPF_LINK_CREATE, BPF_LINK_DETACH, BPF_LINK_UPDATE and 
bpf_link_release(). The new BPF_F_LINK map should not be allowed to unreg 
through the old delete_elem() API.

Regarding the locks, the existing code uses the map lock (st_map->lock) to 
protect the update_elem(). smp_load_acquire/smp_store_release() and cmpxchg() to 
make the lookup_elem and delete_elem lockless. Stan also mentioned similar 
points in another thread. It seems some of the new critical sections in this 
patch now is under yet another global lock (update_mutex), so some of those 
lockless trick may not worth it anymore. However, it is a bit hard to comb 
through now. It will be easier to see through how to clean up the lock usage 
after simpifying other things first.

> +	int old_state;
> +
> +	switch (src) {
> +	case BPF_STRUCT_OPS_STATE_INIT:
> +		if (dst != BPF_STRUCT_OPS_STATE_INUSE &&
> +		    dst != BPF_STRUCT_OPS_STATE_UNREG)
> +			return -EINVAL;
> +
> +		old_state = cmpxchg(&st_map->kvalue.state, src, dst);
> +		if (old_state != src)
> +			break;
> +
> +		if (dst == BPF_STRUCT_OPS_STATE_INUSE)
> +			refcount_set(&st_map->kvalue.refcnt, 1);
> +		break;
> +
> +	case BPF_STRUCT_OPS_STATE_UNREG:
> +		if (dst != BPF_STRUCT_OPS_STATE_INUSE &&
> +		    dst != BPF_STRUCT_OPS_STATE_TOBEFREE)
> +			return -EINVAL;
> +
> +		old_state = cmpxchg(&st_map->kvalue.state, src, dst);
> +		if (old_state != src)
> +			break;
> +
> +		if (dst == BPF_STRUCT_OPS_STATE_INUSE)
> +			refcount_set(&st_map->kvalue.refcnt, 1);
> +		else if (dst == BPF_STRUCT_OPS_STATE_TOBEFREE)
> +			cmpxchg(&st_map->kvalue.state, dst, BPF_STRUCT_OPS_STATE_INIT);
> +		break;
> +
> +	case BPF_STRUCT_OPS_STATE_INUSE:
> +		if (dst != BPF_STRUCT_OPS_STATE_TOBEFREE &&
> +		    dst != BPF_STRUCT_OPS_STATE_TOBEUNREG)
> +			return -EINVAL;
> +
> +		old_state = cmpxchg(&st_map->kvalue.state, src, dst);
> +		break;
> +
> +	case BPF_STRUCT_OPS_STATE_TOBEFREE:
> +		/*
> +		 * This transition should only be performed when the
> +		 * refcnt drops to 0 from 1.
> +		 */
> +		if (dst != BPF_STRUCT_OPS_STATE_INIT)
> +			return -EINVAL;
> +		old_state = cmpxchg(&st_map->kvalue.state, src, dst);
> +		if (old_state != src)
> +			break;
> +		break;
> +
> +	case BPF_STRUCT_OPS_STATE_TOBEUNREG:
> +		/*
> +		 * This transition should only be performed when the
> +		 * refcnt drops to 0 from 1.
> +		 */
> +		if (dst != BPF_STRUCT_OPS_STATE_UNREG)
> +			return -EINVAL;
> +		old_state = cmpxchg(&st_map->kvalue.state, src, dst);
> +		if (old_state != src)
> +			return old_state;
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return old_state;
> +}
> +
> +static int bpf_struct_ops_transit_state_check(struct bpf_struct_ops_map *st_map,
> +					      enum bpf_struct_ops_state src,
> +					      enum bpf_struct_ops_state dst)
> +{
> +	int err;
> +
> +	err = bpf_struct_ops_transit_state(st_map, src, dst);
> +	if (err < 0)
> +		return err;
> +	if (err != src)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +/*
> + * Restore the state of a struct_ops to UNREG from INUSE.
> + *
> + * It handles the case which a struct_ops transited to INUSE from
> + * UNREG successfully; somehow, need to rollback the struct_ops state.
> + */
> +static void bpf_struct_ops_restore_unreg(struct bpf_struct_ops_map *st_map)
> +{
> +	struct bpf_struct_ops_value *kvalue;
> +
> +	kvalue = &st_map->kvalue;
> +	refcount_set(&kvalue->refcnt, 0);
> +	/* Make sure the above change is seen before the state change. */
> +	smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_UNREG);
> +}
> +
>   static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   					  void *value, u64 flags)
>   {
> @@ -390,7 +539,11 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   
>   	mutex_lock(&st_map->lock);
>   
> -	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
> +	/* Make sure that all following changes are seen after the
> +	 * state value here.
> +	 */
> +	if (smp_load_acquire(&kvalue->state) >= BPF_STRUCT_OPS_STATE_INUSE ||
> +	    refcount_read(&kvalue->refcnt)) {

Only allow a struct_ops map to be updated once. ie. only allow update_elem for 
struct_ops in BPF_STRUCT_OPS_STATE_INIT. The user space can create another new 
struct_ops and then use BPF_LINK_UPDATE.

>   		err = -EBUSY;
>   		goto unlock;
>   	}
> @@ -491,17 +644,21 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
>   	}
>   
> -	refcount_set(&kvalue->refcnt, 1);
> +	if (st_map->map.map_flags & BPF_F_LINK) {
> +		/* Let bpf_link handle registration & unregistration. */
> +		err = bpf_struct_ops_transit_state_check(st_map, BPF_STRUCT_OPS_STATE_INIT,
> +							 BPF_STRUCT_OPS_STATE_UNREG);
> +		goto unlock;
> +	}
> +
>   	bpf_map_inc(map);
>   
>   	set_memory_rox((long)st_map->image, 1);
>   	err = st_ops->reg(kdata);
>   	if (likely(!err)) {
> -		/* Pair with smp_load_acquire() during lookup_elem().
> -		 * It ensures the above udata updates (e.g. prog->aux->id)
> -		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
> -		 */
> -		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
> +		/* Infallible */
> +		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_INIT,
> +					     BPF_STRUCT_OPS_STATE_INUSE);
>   		goto unlock;
>   	}
>   
> @@ -526,28 +683,49 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   
>   static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
>   {
> -	enum bpf_struct_ops_state prev_state;
>   	struct bpf_struct_ops_map *st_map;
> +	int old_state;
> +	int err = 0;
>   
>   	st_map = (struct bpf_struct_ops_map *)map;
> -	prev_state = cmpxchg(&st_map->kvalue.state,
> -			     BPF_STRUCT_OPS_STATE_INUSE,
> -			     BPF_STRUCT_OPS_STATE_TOBEFREE);
> -	switch (prev_state) {
> +
> +	old_state = bpf_struct_ops_transit_state(st_map,
> +						 (st_map->map.map_flags & BPF_F_LINK ?

I may not have been clear in v1 comment by "return -ENOTSUPP". For BPF_F_LINK 
map, it should only be unreg by user space holding the link. It should not be 
unreg through delete_elem().

> +						  BPF_STRUCT_OPS_STATE_UNREG :
> +						  BPF_STRUCT_OPS_STATE_INUSE),
> +						 BPF_STRUCT_OPS_STATE_TOBEFREE);
> +
> +	if (old_state < 0)
> +		return old_state;
> +
> +	switch (old_state) {
> +	case BPF_STRUCT_OPS_STATE_UNREG:
> +		break;
>   	case BPF_STRUCT_OPS_STATE_INUSE:
> -		st_map->st_ops->unreg(&st_map->kvalue.data);
> -		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
> -			bpf_map_put(map);
> -		return 0;
> +		if (st_map->map.map_flags & BPF_F_LINK)
> +			err = -EBUSY;
> +		else {
> +			st_map->st_ops->unreg(&st_map->kvalue.data);
> +			bpf_struct_ops_put(&st_map->kvalue.data);
> +		}
> +		break;
>   	case BPF_STRUCT_OPS_STATE_TOBEFREE:
> -		return -EINPROGRESS;
> +		err = -EINPROGRESS;
> +		break;
> +	case BPF_STRUCT_OPS_STATE_TOBEUNREG:
> +		err = -EBUSY;
> +		break;
>   	case BPF_STRUCT_OPS_STATE_INIT:
> -		return -ENOENT;
> +		err = -ENOENT;
> +		break;
>   	default:
>   		WARN_ON_ONCE(1);
>   		/* Should never happen.  Treat it as not found. */
> -		return -ENOENT;
> +		err = -ENOENT;
> +		break;
>   	}
> +
> +	return err;
>   }
>   
>   static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
> @@ -585,7 +763,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>   static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
>   {
>   	if (attr->key_size != sizeof(unsigned int) || attr->max_entries != 1 ||
> -	    attr->map_flags || !attr->btf_vmlinux_value_type_id)
> +	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id)
>   		return -EINVAL;
>   	return 0;
>   }
> @@ -671,6 +849,15 @@ static void bpf_struct_ops_put_rcu(struct rcu_head *head)
>   	struct bpf_struct_ops_map *st_map;
>   
>   	st_map = container_of(head, struct bpf_struct_ops_map, rcu);
> +
> +	/* The struct_ops can be reused after a rcu grace period. */
> +	if (st_map->kvalue.state == BPF_STRUCT_OPS_STATE_TOBEFREE)
> +		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_TOBEFREE,
> +					     BPF_STRUCT_OPS_STATE_INIT);
> +	else if (st_map->kvalue.state == BPF_STRUCT_OPS_STATE_TOBEUNREG)
> +		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_TOBEUNREG,
> +					     BPF_STRUCT_OPS_STATE_UNREG);
> +
>   	bpf_map_put(&st_map->map);
>   }
>   
> @@ -684,6 +871,7 @@ void bpf_struct_ops_put(const void *kdata)
>   
>   		st_map = container_of(kvalue, struct bpf_struct_ops_map,
>   				      kvalue);
> +
>   		/* The struct_ops's function may switch to another struct_ops.
>   		 *
>   		 * For example, bpf_tcp_cc_x->init() may switch to
> @@ -698,3 +886,143 @@ void bpf_struct_ops_put(const void *kdata)
>   		call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
>   	}
>   }
> +
> +static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link;
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_link = container_of(link, struct bpf_struct_ops_link, link);
> +	if (st_link->map) {
> +		st_map = (struct bpf_struct_ops_map *)st_link->map;
> +		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_INUSE,
> +					     (st_map->map.map_flags & BPF_F_LINK ?
> +					      BPF_STRUCT_OPS_STATE_TOBEUNREG :
> +					      BPF_STRUCT_OPS_STATE_TOBEFREE));
> +		st_map->st_ops->unreg(&st_map->kvalue.data);
> +		bpf_struct_ops_put(&st_map->kvalue.data);
> +	}
> +	kfree(st_link);
> +}
> +
> +static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
> +{
> +	struct bpf_struct_ops_link *st_link;
> +	struct bpf_struct_ops_map *st_map;
> +
> +	mutex_lock(&update_mutex);
> +	st_link = container_of(link, struct bpf_struct_ops_link, link);
> +	st_map = container_of(st_link->map, struct bpf_struct_ops_map, map);
> +	if (st_map) {
> +		/*
> +		 * All chaning on st_link->map are protected by
> +		 * update_mutex.  This ensures that the struct_ops is
> +		 * INUSE, and the state transition always success.
> +		 */
> +		rcu_assign_pointer(st_link->map, NULL);

I think the map is leaked. I also think it does not need assign NULL also. 
Otherwise, the show_fdinfo and fill_link_info will become confusing.

> +		bpf_struct_ops_transit_state(st_map, BPF_STRUCT_OPS_STATE_INUSE,
> +					     (st_map->map.map_flags & BPF_F_LINK ?
> +					      BPF_STRUCT_OPS_STATE_TOBEUNREG :
> +					      BPF_STRUCT_OPS_STATE_TOBEFREE));
> +		st_map->st_ops->unreg(&st_map->kvalue.data);
> +		bpf_struct_ops_put(&st_map->kvalue.data);
> +	}
> +	mutex_unlock(&update_mutex);
> +
> +	return 0;
> +}

