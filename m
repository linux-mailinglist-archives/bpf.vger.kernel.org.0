Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D599A6A11D4
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 22:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBWVTP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 16:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBWVTN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 16:19:13 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214771D92A
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:19:06 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e127-20020a636985000000b004bbc748ca63so4652464pgc.3
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 13:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1G1TZ8IkIHC1IxGV9C0ksM7IrJChJSJfxLhIjrXj0s=;
        b=I2KVWxEzuHxR7F6DGaQ9rh5xaCK6DvPdv66uS+rFS3JLs6/wWI9C4VHr7/5malx6oc
         xwA4x5rE133wgKFi2tZ6RaF3dBlhUmMdWQ6ME5d/e4I0NYjak6adwg1srjtY71gwcwT5
         dMKRfyO5ySw/fRhyHzBC3aWS5J7etelkE24a/yWxqmzaTcefn0yiBaE+gqTqCT67G669
         0dC8xUyUWgtN+TCFVKFU+NOE1ZgB+NQjiYUbmvjUdVDBaCZPKWQc4Kbsa/O4DuofZwqS
         RcELmP28OZ3CJ8XxIxo6VltJqc0gbZo/7X433x+mYE1lfYWgGIm5VXX4AWGYowsh5Oqa
         8Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1G1TZ8IkIHC1IxGV9C0ksM7IrJChJSJfxLhIjrXj0s=;
        b=Vwcig+SKFXkcIgKuG1eXOMpUe9eMFlAJAo1Pwe7Bj6IjXO2LR+x0rA+oUt3rVcOPWi
         M3w1aUMQGOb41DAurayJYmpReME0oGhdmOc9uYIN6kUnkkoWnI3ls1F4/BErgddLEqmE
         D4lPSJUHqxLnB4WUP332ZZ/302lEcj3lHio+xac2+4r8TIzJ/cw9jMyqivVl0ULztm6N
         hTAbDhEWyOUHJd4LWynzrWw2ln6mzSTeyiwfLypwKsQktoM5B3+qkNhb15iqPvU6ziFa
         gXfQwlqH1YNYXnouLGer1219SdzLy5MY4SHa1kek7vE4ERTEOM6MxNGfSzHAj/HuuHtg
         PKYg==
X-Gm-Message-State: AO0yUKU8mVwMojeLFuglmPYm8Bj8tSDG/6AHt7qFSWR/XseWTiPoc8jR
        W1JVQwFC/TRcZr/wYcUJVLAxUG4=
X-Google-Smtp-Source: AK7set+8tXhbDgfKwlwtwRy1QqAg5dmF0joZrCXRPMg+a7aEKSFq5cGZJcr4yr+04/bwmXwOQnN3ij4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:7643:b0:233:eccf:ea10 with SMTP id
 s3-20020a17090a764300b00233eccfea10mr892404pjl.1.1677187145445; Thu, 23 Feb
 2023 13:19:05 -0800 (PST)
Date:   Thu, 23 Feb 2023 13:19:03 -0800
In-Reply-To: <20230223011238.12313-2-kuifeng@meta.com>
Mime-Version: 1.0
References: <20230223011238.12313-1-kuifeng@meta.com> <20230223011238.12313-2-kuifeng@meta.com>
Message-ID: <Y/fYR3I312LP5xBG@google.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Create links for BPF struct_ops maps.
From:   Stanislav Fomichev <sdf@google.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/22, Kui-Feng Lee wrote:
> BPF struct_ops maps are employed directly to register TCP Congestion
> Control algorithms. Unlike other BPF programs that terminate when
> their links gone, the struct_ops program reduces its refcount solely
> upon death of its FD. The link of a BPF struct_ops map provides a
> uniform experience akin to other types of BPF programs.

> bpf_links are responsible for registering their associated
> struct_ops. You can only use a struct_ops that has the BPF_F_LINK flag
> set to create a bpf_link, while a structs without this flag behaves in
> the same manner as before and is registered upon updating its value.

> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   include/linux/bpf.h            |  11 +
>   include/uapi/linux/bpf.h       |  12 +-
>   kernel/bpf/bpf_struct_ops.c    | 376 ++++++++++++++++++++++++++++++---
>   kernel/bpf/syscall.c           |  26 ++-
>   tools/include/uapi/linux/bpf.h |  12 +-
>   5 files changed, 402 insertions(+), 35 deletions(-)

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8b5d0b4c4ada..9d6fd874e5ee 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1395,6 +1395,11 @@ struct bpf_link {
>   	struct work_struct work;
>   };

> +struct bpf_struct_ops_link {
> +	struct bpf_link link;
> +	struct bpf_map __rcu *map;
> +};
> +
>   struct bpf_link_ops {
>   	void (*release)(struct bpf_link *link);
>   	void (*dealloc)(struct bpf_link *link);
> @@ -1961,6 +1966,7 @@ int bpf_link_new_fd(struct bpf_link *link);
>   struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>   struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>   struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
> +int bpf_struct_ops_link_create(union bpf_attr *attr);

>   int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>   int bpf_obj_get_user(const char __user *pathname, int flags);
> @@ -2305,6 +2311,11 @@ static inline void bpf_link_put(struct bpf_link  
> *link)
>   {
>   }

> +static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int bpf_obj_get_user(const char __user *pathname, int  
> flags)
>   {
>   	return -EOPNOTSUPP;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 17afd2b35ee5..cd0ff39981e8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>   	BPF_PERF_EVENT,
>   	BPF_TRACE_KPROBE_MULTI,
>   	BPF_LSM_CGROUP,
> +	BPF_STRUCT_OPS,
>   	__MAX_BPF_ATTACH_TYPE
>   };

> @@ -1266,6 +1267,9 @@ enum {

>   /* Create a map that is suitable to be an inner map with dynamic max  
> entries */
>   	BPF_F_INNER_MAP		= (1U << 12),
> +
> +/* Create a map that will be registered/unregesitered by the backed  
> bpf_link */
> +	BPF_F_LINK		= (1U << 13),
>   };

>   /* Flags for BPF_PROG_QUERY. */
> @@ -1507,7 +1511,10 @@ union bpf_attr {
>   	} task_fd_query;

>   	struct { /* struct used by BPF_LINK_CREATE command */
> -		__u32		prog_fd;	/* eBPF program to attach */
> +		union {
> +			__u32		prog_fd;	/* eBPF program to attach */
> +			__u32		map_fd;		/* eBPF struct_ops to attach */
> +		};
>   		union {
>   			__u32		target_fd;	/* object to attach to */
>   			__u32		target_ifindex; /* target ifindex */
> @@ -6354,6 +6361,9 @@ struct bpf_link_info {
>   		struct {
>   			__u32 ifindex;
>   		} xdp;
> +		struct {
> +			__u32 map_id;
> +		} struct_ops;
>   	};
>   } __attribute__((aligned(8)));

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index ece9870cab68..cfc69033c1b8 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -14,8 +14,10 @@

>   enum bpf_struct_ops_state {
>   	BPF_STRUCT_OPS_STATE_INIT,
> +	BPF_STRUCT_OPS_STATE_UNREG,
>   	BPF_STRUCT_OPS_STATE_INUSE,
>   	BPF_STRUCT_OPS_STATE_TOBEFREE,
> +	BPF_STRUCT_OPS_STATE_TOBEUNREG,
>   };

>   #define BPF_STRUCT_OPS_COMMON_VALUE			\
> @@ -58,6 +60,8 @@ struct bpf_struct_ops_map {
>   	struct bpf_struct_ops_value kvalue;
>   };

> +static DEFINE_MUTEX(update_mutex);
> +
>   #define VALUE_PREFIX "bpf_struct_ops_"
>   #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)

> @@ -253,22 +257,23 @@ int bpf_struct_ops_map_sys_lookup_elem(struct  
> bpf_map *map, void *key,
>   	if (unlikely(*(u32 *)key != 0))
>   		return -ENOENT;

> +	mutex_lock(&st_map->lock);
> +
>   	kvalue = &st_map->kvalue;
> -	/* Pair with smp_store_release() during map_update */
>   	state = smp_load_acquire(&kvalue->state);
>   	if (state == BPF_STRUCT_OPS_STATE_INIT) {
>   		memset(value, 0, map->value_size);
> +		mutex_unlock(&st_map->lock);
>   		return 0;
>   	}

> -	/* No lock is needed.  state and refcnt do not need
> -	 * to be updated together under atomic context.
> -	 */
>   	uvalue = value;
>   	memcpy(uvalue, st_map->uvalue, map->value_size);
>   	uvalue->state = state;
>   	refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));

> +	mutex_unlock(&st_map->lock);
> +
>   	return 0;
>   }

> @@ -349,6 +354,150 @@ int bpf_struct_ops_prepare_trampoline(struct  
> bpf_tramp_links *tlinks,
>   					   model, flags, tlinks, NULL);
>   }

> +/*
> + * Maintain the state of kvalue.
> + *
> + * For a struct_ops that has no link, its state diagram is
> + *
> + *   INIT ----> INUSE --> TOBEFREE
> + *     ^                     |
> + *     |     (refcnt == 0)   |
> + *     +---------------------+
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
> +static int bpf_struct_ops_transit_state(struct bpf_struct_ops_map  
> *st_map,
> +					enum bpf_struct_ops_state src,
> +					enum bpf_struct_ops_state dst)
> +{
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
> +static int bpf_struct_ops_transit_state_check(struct bpf_struct_ops_map  
> *st_map,
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
> +static void bpf_struct_ops_restore_unreg(struct bpf_struct_ops_map  
> *st_map)
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
> @@ -390,7 +539,11 @@ static int bpf_struct_ops_map_update_elem(struct  
> bpf_map *map, void *key,

>   	mutex_lock(&st_map->lock);

> -	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {

[..]


> +	/* Make sure that all following changes are seen after the
> +	 * state value here.
> +	 */
> +	if (smp_load_acquire(&kvalue->state) >= BPF_STRUCT_OPS_STATE_INUSE ||
> +	    refcount_read(&kvalue->refcnt)) {
>   		err = -EBUSY;
>   		goto unlock;
>   	}

I've been starting at this for too long, might as well just ask.
Why are we caring about the ordering here? I understand why we used
to when bpf_struct_ops_map_sys_lookup_elem was lockless, but since
you're grabbing the lock in bpf_struct_ops_map_sys_lookup_elem now,
I don't see why we need acquire/store semantics.

I'm also in general a bit confused about
lock+kvalue_refcnt+uvalue_refcnt. I'll try to dig more, but I'm assuming
Martin will probably beat me to it and explain :-)


> @@ -491,17 +644,21 @@ static int bpf_struct_ops_map_update_elem(struct  
> bpf_map *map, void *key,
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
>   	}

> -	refcount_set(&kvalue->refcnt, 1);
> +	if (st_map->map.map_flags & BPF_F_LINK) {
> +		/* Let bpf_link handle registration & unregistration. */
> +		err = bpf_struct_ops_transit_state_check(st_map,  
> BPF_STRUCT_OPS_STATE_INIT,
> +							 BPF_STRUCT_OPS_STATE_UNREG);
> +		goto unlock;
> +	}
> +
>   	bpf_map_inc(map);

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

> @@ -526,28 +683,49 @@ static int bpf_struct_ops_map_update_elem(struct  
> bpf_map *map, void *key,

>   static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
>   {
> -	enum bpf_struct_ops_state prev_state;
>   	struct bpf_struct_ops_map *st_map;
> +	int old_state;
> +	int err = 0;

>   	st_map = (struct bpf_struct_ops_map *)map;
> -	prev_state = cmpxchg(&st_map->kvalue.state,
> -			     BPF_STRUCT_OPS_STATE_INUSE,
> -			     BPF_STRUCT_OPS_STATE_TOBEFREE);
> -	switch (prev_state) {
> +
> +	old_state = bpf_struct_ops_transit_state(st_map,
> +						 (st_map->map.map_flags & BPF_F_LINK ?
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

>   static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void  
> *key,
> @@ -585,7 +763,7 @@ static void bpf_struct_ops_map_free(struct bpf_map  
> *map)
>   static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
>   {
>   	if (attr->key_size != sizeof(unsigned int) || attr->max_entries != 1 ||
> -	    attr->map_flags || !attr->btf_vmlinux_value_type_id)
> +	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id)
>   		return -EINVAL;
>   	return 0;
>   }
> @@ -671,6 +849,15 @@ static void bpf_struct_ops_put_rcu(struct rcu_head  
> *head)
>   	struct bpf_struct_ops_map *st_map;

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

> @@ -684,6 +871,7 @@ void bpf_struct_ops_put(const void *kdata)

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
> +
> +static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link  
> *link,
> +					    struct seq_file *seq)
> +{
> +	struct bpf_struct_ops_link *st_link;
> +	struct bpf_map *map;
> +
> +	st_link = container_of(link, struct bpf_struct_ops_link, link);
> +	rcu_read_lock_trace();
> +	map = rcu_dereference(st_link->map);
> +	if (map)
> +		seq_printf(seq, "map_id:\t%d\n", map->id);
> +	rcu_read_unlock_trace();
> +}
> +
> +static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link  
> *link,
> +					       struct bpf_link_info *info)
> +{
> +	struct bpf_struct_ops_link *st_link;
> +	struct bpf_map *map;
> +
> +	st_link = container_of(link, struct bpf_struct_ops_link, link);
> +	rcu_read_lock_trace();
> +	map = rcu_dereference(st_link->map);
> +	if (map)
> +		info->struct_ops.map_id = map->id;
> +	rcu_read_unlock_trace();
> +	return 0;
> +}
> +
> +static const struct bpf_link_ops bpf_struct_ops_map_lops = {
> +	.dealloc = bpf_struct_ops_map_link_dealloc,
> +	.detach = bpf_struct_ops_map_link_detach,
> +	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
> +	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
> +};
> +
> +int bpf_struct_ops_link_create(union bpf_attr *attr)
> +{
> +	struct bpf_struct_ops_link *link = NULL;
> +	struct bpf_link_primer link_primer;
> +	struct bpf_struct_ops_map *st_map;
> +	struct bpf_map *map;
> +	int err;
> +
> +	map = bpf_map_get(attr->link_create.map_fd);
> +	if (!map)
> +		return -EINVAL;
> +
> +	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags &  
> BPF_F_LINK)) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	link = kzalloc(sizeof(*link), GFP_USER);
> +	if (!link) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,  
> &bpf_struct_ops_map_lops, NULL);
> +	link->map = map;
> +
> +	st_map = (struct bpf_struct_ops_map *)map;
> +
> +	err = bpf_struct_ops_transit_state_check(st_map,  
> BPF_STRUCT_OPS_STATE_UNREG,
> +						 BPF_STRUCT_OPS_STATE_INUSE);
> +	if (err)
> +		goto err_out;
> +
> +	err = bpf_link_prime(&link->link, &link_primer);
> +	if (err) {
> +		bpf_struct_ops_restore_unreg(st_map);
> +		goto err_out;
> +	}
> +
> +	set_memory_rox((long)st_map->image, 1);
> +	err = st_map->st_ops->reg(st_map->kvalue.data);
> +	if (err) {
> +		bpf_struct_ops_restore_unreg(st_map);
> +		bpf_link_cleanup(&link_primer);
> +
> +		set_memory_nx((long)st_map->image, 1);
> +		set_memory_rw((long)st_map->image, 1);
> +		goto err_out;
> +	}
> +
> +
> +	return bpf_link_settle(&link_primer);
> +
> +err_out:
> +	bpf_map_put(map);
> +	kfree(link);
> +	return err;
> +}
> +
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cda8d00f3762..2670de8dd0d4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2735,10 +2735,11 @@ void bpf_link_inc(struct bpf_link *link)
>   static void bpf_link_free(struct bpf_link *link)
>   {
>   	bpf_link_free_id(link->id);
> +	/* detach BPF program, clean up used resources */
>   	if (link->prog) {
> -		/* detach BPF program, clean up used resources */
>   		link->ops->release(link);
>   		bpf_prog_put(link->prog);
> +		/* The struct_ops links clean up map by them-selves. */
>   	}
>   	/* free bpf_link and its containing memory */
>   	link->ops->dealloc(link);
> @@ -2794,16 +2795,19 @@ static void bpf_link_show_fdinfo(struct seq_file  
> *m, struct file *filp)
>   	const struct bpf_prog *prog = link->prog;
>   	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };

> -	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
>   	seq_printf(m,
>   		   "link_type:\t%s\n"
> -		   "link_id:\t%u\n"
> -		   "prog_tag:\t%s\n"
> -		   "prog_id:\t%u\n",
> +		   "link_id:\t%u\n",
>   		   bpf_link_type_strs[link->type],
> -		   link->id,
> -		   prog_tag,
> -		   prog->aux->id);
> +		   link->id);
> +	if (prog) {
> +		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> +		seq_printf(m,
> +			   "prog_tag:\t%s\n"
> +			   "prog_id:\t%u\n",
> +			   prog_tag,
> +			   prog->aux->id);
> +	}
>   	if (link->ops->show_fdinfo)
>   		link->ops->show_fdinfo(link, m);
>   }
> @@ -4278,7 +4282,8 @@ static int bpf_link_get_info_by_fd(struct file  
> *file,

>   	info.type = link->type;
>   	info.id = link->id;
> -	info.prog_id = link->prog->aux->id;
> +	if (link->prog)
> +		info.prog_id = link->prog->aux->id;

>   	if (link->ops->fill_link_info) {
>   		err = link->ops->fill_link_info(link, &info);
> @@ -4541,6 +4546,9 @@ static int link_create(union bpf_attr *attr,  
> bpfptr_t uattr)
>   	if (CHECK_ATTR(BPF_LINK_CREATE))
>   		return -EINVAL;

> +	if (attr->link_create.attach_type == BPF_STRUCT_OPS)
> +		return bpf_struct_ops_link_create(attr);
> +
>   	prog = bpf_prog_get(attr->link_create.prog_fd);
>   	if (IS_ERR(prog))
>   		return PTR_ERR(prog);
> diff --git a/tools/include/uapi/linux/bpf.h  
> b/tools/include/uapi/linux/bpf.h
> index 17afd2b35ee5..cd0ff39981e8 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>   	BPF_PERF_EVENT,
>   	BPF_TRACE_KPROBE_MULTI,
>   	BPF_LSM_CGROUP,
> +	BPF_STRUCT_OPS,
>   	__MAX_BPF_ATTACH_TYPE
>   };

> @@ -1266,6 +1267,9 @@ enum {

>   /* Create a map that is suitable to be an inner map with dynamic max  
> entries */
>   	BPF_F_INNER_MAP		= (1U << 12),
> +
> +/* Create a map that will be registered/unregesitered by the backed  
> bpf_link */
> +	BPF_F_LINK		= (1U << 13),
>   };

>   /* Flags for BPF_PROG_QUERY. */
> @@ -1507,7 +1511,10 @@ union bpf_attr {
>   	} task_fd_query;

>   	struct { /* struct used by BPF_LINK_CREATE command */
> -		__u32		prog_fd;	/* eBPF program to attach */
> +		union {
> +			__u32		prog_fd;	/* eBPF program to attach */
> +			__u32		map_fd;		/* eBPF struct_ops to attach */
> +		};
>   		union {
>   			__u32		target_fd;	/* object to attach to */
>   			__u32		target_ifindex; /* target ifindex */
> @@ -6354,6 +6361,9 @@ struct bpf_link_info {
>   		struct {
>   			__u32 ifindex;
>   		} xdp;
> +		struct {
> +			__u32 map_id;
> +		} struct_ops;
>   	};
>   } __attribute__((aligned(8)));

> --
> 2.30.2

