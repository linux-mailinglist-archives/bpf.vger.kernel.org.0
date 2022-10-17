Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF89601611
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 20:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJQSQ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQSQ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 14:16:28 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6E74B95
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 11:16:26 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id w3so8229241qtv.9
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 11:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh9n5yAEpFMS6zNWXtHIxuQUITvetSCXpzT5ZpNKL5E=;
        b=SoD2yL73sKDDoTPHGFxDWwfl42RtUlc+7OUhJ8Jcm+GlCSR5TbW4rqIQc2eRpciRbo
         /qVRyu/d5wSmdJ4yJYTx62Cd2e9zvSOJ9xrIPaJmS+cpQKyQYGroVX3RIb1c4ShIJ8fw
         OWMe27Nqxml8YN2KMTzYvb7C2b+OGxdbw0gR+kPctOQAMz+tznSnJrW+Frolz/iazm9h
         lJCQG+PRa0k6lk6dJ/tuEQ5yYpR97W2NaTlt8QPmvZ3EGPua2MeTjUtW5B0cNS92NJin
         jd4Re9O3iJcdvY81AhA0eCe7xBfqbzLAkDzAoiUb+8+dY9fRtRLgKfH5NucvCgATQ0eB
         gaQA==
X-Gm-Message-State: ACrzQf2x44AF5H95XeqedJXs5soL6HTr4h6onyk+NpmSESH/UZjV9Eex
        S6MAw6y4D24PjLOcyOPecIA=
X-Google-Smtp-Source: AMsMyM5eeb1Zd/TohX0/cH4w4mmrap+UVsXTurMLizPON8RunjQNC6AE7MDBZTXxzqScfKVdOG/NqA==
X-Received: by 2002:ac8:5908:0:b0:39c:d7dd:14e9 with SMTP id 8-20020ac85908000000b0039cd7dd14e9mr9952555qty.623.1666030585339;
        Mon, 17 Oct 2022 11:16:25 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::d067])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05620a319a00b006ce7bb8518bsm408066qkb.5.2022.10.17.11.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:16:24 -0700 (PDT)
Date:   Mon, 17 Oct 2022 13:16:25 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Message-ID: <Y02b+ZSW6NcI2dDV@maniforge.dhcp.thefacebook.com>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014045630.3311951-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 09:56:30PM -0700, Yonghong Song wrote:
> Similar to sk/inode/task storage, implement similar cgroup local storage.
> 
> There already exists a local storage implementation for cgroup-attached
> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> bpf_get_local_storage(). But there are use cases such that non-cgroup
> attached bpf progs wants to access cgroup local storage data. For example,
> tc egress prog has access to sk and cgroup. It is possible to use
> sk local storage to emulate cgroup local storage by storing data in socket.
> But this is a waste as it could be lots of sockets belonging to a particular
> cgroup. Alternatively, a separate map can be created with cgroup id as the key.
> But this will introduce additional overhead to manipulate the new map.
> A cgroup local storage, similar to existing sk/inode/task storage,
> should help for this use case.
> 
> The life-cycle of storage is managed with the life-cycle of the
> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> with a callback to the bpf_cgroup_storage_free when cgroup itself
> is deleted.
> 
> The userspace map operations can be done by using a cgroup fd as a key
> passed to the lookup, update and delete operations.
> 
> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup local
> storage support, the new map name BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is used
> for cgroup storage available to non-cgroup-attached bpf programs. The two
> helpers are named as bpf_cgroup_local_storage_get() and
> bpf_cgroup_local_storage_delete().
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h             |   3 +
>  include/linux/bpf_types.h       |   1 +
>  include/linux/cgroup-defs.h     |   4 +
>  include/uapi/linux/bpf.h        |  39 +++++
>  kernel/bpf/Makefile             |   2 +-
>  kernel/bpf/bpf_cgroup_storage.c | 280 ++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c            |   6 +
>  kernel/bpf/syscall.c            |   3 +-
>  kernel/bpf/verifier.c           |  14 +-
>  kernel/cgroup/cgroup.c          |   4 +
>  kernel/trace/bpf_trace.c        |   4 +
>  scripts/bpf_doc.py              |   2 +
>  tools/include/uapi/linux/bpf.h  |  39 +++++
>  13 files changed, 398 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/bpf/bpf_cgroup_storage.c
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9e7d46d16032..1395a01c7f18 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2045,6 +2045,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
>  
>  const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
>  void bpf_task_storage_free(struct task_struct *task);
> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup);
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>  const struct btf_func_model *
>  bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
> @@ -2537,6 +2538,8 @@ extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>  extern const struct bpf_func_proto bpf_set_retval_proto;
>  extern const struct bpf_func_proto bpf_get_retval_proto;
>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
> +extern const struct bpf_func_proto bpf_cgroup_storage_get_proto;
> +extern const struct bpf_func_proto bpf_cgroup_storage_delete_proto;
>  
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 2c6a4f2562a7..7a0362d7a0aa 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -90,6 +90,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
>  #ifdef CONFIG_CGROUP_BPF
>  BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE, cgroup_local_storage_map_ops)

Did you mean to compile this out if !CONFIG_CGROUP_BPF? It looks like
we're using CONFIG_BPF_SYSCALL elsewhere, which makes sense if we're
keeping CONFIG_CGROUP_BPF for programs attaching to cgroups. Or maybe we
should put it in CONFIG_CGROUPS, which is what we use when compiling
bpf_cgroup_storage.o and the other relevant helpers?

Also, would you mind please adding comments here explaining what the
difference is between these map types? In terms of readability,
BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE and BPF_MAP_TYPE_CGROUP_STORAGE are
nearly identical, and adding to the confusion,
BPF_MAP_TYPE_CGROUP_STORAGE is itself accessed with the
bpf_get_local_storage() helper. I feel like we need to be quite verbose
about the difference here or users are going to be confused when trying
to figure out the differences between these map types.

>  #endif
>  BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
>  BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 4bcf56b3491c..c6f4590dda68 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -504,6 +504,10 @@ struct cgroup {
>  	/* Used to store internal freezer state */
>  	struct cgroup_freezer_state freezer;
>  
> +#ifdef CONFIG_BPF_SYSCALL

As alluded to above, I assume this should _not_ be:

#ifdef CONFIG_CGROUP_BPF

Just wanted to highlight it to make sure we're being consistent.

> +	struct bpf_local_storage __rcu  *bpf_cgroup_storage;
> +#endif
> +
>  	/* ids of the ancestors at each level including self */
>  	u64 ancestor_ids[];
>  };
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 17f61338f8f8..d918b4054297 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -935,6 +935,7 @@ enum bpf_map_type {
>  	BPF_MAP_TYPE_TASK_STORAGE,
>  	BPF_MAP_TYPE_BLOOM_FILTER,
>  	BPF_MAP_TYPE_USER_RINGBUF,
> +	BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE,
>  };
>  
>  /* Note that tracing related programs such as
> @@ -5435,6 +5436,42 @@ union bpf_attr {
>   *		**-E2BIG** if user-space has tried to publish a sample which is
>   *		larger than the size of the ring buffer, or which cannot fit
>   *		within a struct bpf_dynptr.
> + *
> + * void *bpf_cgroup_local_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)

I think it will be easy for users to get confused here with
bpf_get_local_storage(), which even mentions "cgroup local storage" in
the description:

3338  * void *bpf_get_local_storage(void *map, u64 flags)
3339  *      Description
3340  *              Get the pointer to the local storage area.
3341  *              The type and the size of the local storage is defined
3342  *              by the *map* argument.
3343  *              The *flags* meaning is specific for each map type,
3344  *              and has to be 0 for cgroup local storage.

It would have been nice if, instead of defining an entirely new helper,
we could update enum bpf_cgroup_storage_type to include a third type of
cgroup storage, something like:

BPF_CGROUP_STORAGE_LOCAL

That of course doesn't work for bpf_get_local_storage() though, which
doesn't take a struct cgroup * argument. So I think what you're
proposing is fine, though I would again suggest that we explicitly spell
out the difference between bpf_cgroup_local_storage_get() and
bpf_get_local_storage(). Alternatively, do we have any intention of
deprecating the older cgroup storage map types? What you're proposing
here feels like a more canonical and ergonomic API, so it'd be nice to
guide folks towards this as the proper cgroup local storage map at some
point.

Also, one more nit / thought, but should we change the name to:

void *bpf_cgroup_storage_get()

This more closely matches the equivalent for task local storage:
bpf_task_storage_get().

> + *	Description
> + *		Get a bpf_local_storage from the *cgroup*.
> + *
> + *		Logically, it could be thought of as getting the value from
> + *		a *map* with *cgroup* as the **key**.  From this
> + *		perspective,  the usage is not much different from
> + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
> + *		helper enforces the key must be a cgroup struct and the map must also
> + *		be a **BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE**.
> + *
> + *		Underneath, the value is stored locally at *cgroup* instead of
> + *		the *map*.  The *map* is used as the bpf-local-storage
> + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
> + *		searched against all bpf_local_storage residing at *cgroup*.
> + *
> + *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
> + *		used such that a new bpf_local_storage will be
> + *		created if one does not exist.  *value* can be used
> + *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
> + *		the initial value of a bpf_local_storage.  If *value* is
> + *		**NULL**, the new bpf_local_storage will be zero initialized.
> + *	Return
> + *		A bpf_local_storage pointer is returned on success.
> + *
> + *		**NULL** if not found or there was an error in adding
> + *		a new bpf_local_storage.
> + *
> + * long bpf_cgroup_local_storage_delete(struct bpf_map *map, struct cgroup *cgroup)

Same question here r.e. name. Is bpf_cgroup_storage_delete() more
consistent with local storage existing helpers such as
bpf_task_storage_delete()?

> + *	Description
> + *		Delete a bpf_local_storage from a *cgroup*.
> + *	Return
> + *		0 on success.
> + *
> + *		**-ENOENT** if the bpf_local_storage cannot be found.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -5647,6 +5684,8 @@ union bpf_attr {
>  	FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)	\
>  	FN(ktime_get_tai_ns, 208, ##ctx)		\
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
> +	FN(cgroup_local_storage_get, 210, ##ctx)	\
> +	FN(cgroup_local_storage_delete, 211, ##ctx)	\
>  	/* */
>  
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 341c94f208f4..b02693f51978 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>  obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>  endif
>  ifeq ($(CONFIG_CGROUPS),y)
> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgroup_storage.o
>  endif
>  obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>  ifeq ($(CONFIG_INET),y)
> diff --git a/kernel/bpf/bpf_cgroup_storage.c b/kernel/bpf/bpf_cgroup_storage.c
> new file mode 100644
> index 000000000000..9974784822da
> --- /dev/null
> +++ b/kernel/bpf/bpf_cgroup_storage.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/bpf.h>
> +#include <linux/bpf_local_storage.h>
> +#include <uapi/linux/btf.h>
> +#include <linux/btf_ids.h>
> +
> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
> +
> +static DEFINE_PER_CPU(int, bpf_cgroup_storage_busy);
> +
> +static void bpf_cgroup_storage_lock(void)
> +{
> +	migrate_disable();
> +	this_cpu_inc(bpf_cgroup_storage_busy);
> +}
> +
> +static void bpf_cgroup_storage_unlock(void)
> +{
> +	this_cpu_dec(bpf_cgroup_storage_busy);
> +	migrate_enable();
> +}
> +
> +static bool bpf_cgroup_storage_trylock(void)
> +{
> +	migrate_disable();
> +	if (unlikely(this_cpu_inc_return(bpf_cgroup_storage_busy) != 1)) {
> +		this_cpu_dec(bpf_cgroup_storage_busy);
> +		migrate_enable();
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
> +{
> +	struct cgroup *cg = owner;
> +
> +	return &cg->bpf_cgroup_storage;
> +}
> +
> +void bpf_local_cgroup_storage_free(struct cgroup *cgroup)
> +{
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_elem *selem;
> +	bool free_cgroup_storage = false;
> +	struct hlist_node *n;
> +	unsigned long flags;
> +
> +	rcu_read_lock();
> +	local_storage = rcu_dereference(cgroup->bpf_cgroup_storage);
> +	if (!local_storage) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	/* Neither the bpf_prog nor the bpf-map's syscall
> +	 * could be modifying the local_storage->list now.
> +	 * Thus, no elem can be added-to or deleted-from the
> +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
> +	 *
> +	 * It is racing with bpf_local_storage_map_free() alone
> +	 * when unlinking elem from the local_storage->list and
> +	 * the map's bucket->list.
> +	 */
> +	bpf_cgroup_storage_lock();
> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
> +		bpf_selem_unlink_map(selem);
> +		free_cgroup_storage =
> +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);

Could this overwrite a previously-true free_cgroup_storage if one of
these entries is false? Did you mean to do something like this?

if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
	free_cgroup_storage = true;

> +	}
> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +	bpf_cgroup_storage_unlock();
> +	rcu_read_unlock();
> +
> +	/* free_cgroup_storage should always be true as long as
> +	 * local_storage->list was non-empty.
> +	 */
> +	if (free_cgroup_storage)
> +		kfree_rcu(local_storage, rcu);
> +}
> +
> +static struct bpf_local_storage_data *
> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
> +{
> +	struct bpf_local_storage *cgroup_storage;
> +	struct bpf_local_storage_map *smap;
> +
> +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgroup_storage,
> +					       bpf_rcu_lock_held());
> +	if (!cgroup_storage)
> +		return NULL;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
> +}
> +
> +static void *bpf_cgroup_storage_lookup_elem(struct bpf_map *map, void *key)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct cgroup *cgroup;
> +	int fd;
> +
> +	fd = *(int *)key;
> +	cgroup = cgroup_get_from_fd(fd);
> +	if (IS_ERR(cgroup))
> +		return ERR_CAST(cgroup);
> +
> +	bpf_cgroup_storage_lock();
> +	sdata = cgroup_storage_lookup(cgroup, map, true);
> +	bpf_cgroup_storage_unlock();
> +	cgroup_put(cgroup);
> +	return sdata ? sdata->data : NULL;
> +}
> +
> +static int bpf_cgroup_storage_update_elem(struct bpf_map *map, void *key,
> +					  void *value, u64 map_flags)
> +{
> +	struct bpf_local_storage_data *sdata;
> +	struct cgroup *cgroup;
> +	int err, fd;
> +
> +	fd = *(int *)key;
> +	cgroup = cgroup_get_from_fd(fd);
> +	if (IS_ERR(cgroup))
> +		return PTR_ERR(cgroup);
> +
> +	bpf_cgroup_storage_lock();
> +	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
> +					 value, map_flags, GFP_ATOMIC);
> +	bpf_cgroup_storage_unlock();
> +	err = PTR_ERR_OR_ZERO(sdata);
> +	cgroup_put(cgroup);
> +	return err;

Optional suggestion, but perhaps this is slightly more concise:

bpf_cgroup_storage_unlock();
cgroup_put(cgroup);
return PTR_ERR_OR_ZERO(sdata);

> +}
> +
> +static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
> +{
> +	struct bpf_local_storage_data *sdata;
> +
> +	sdata = cgroup_storage_lookup(cgroup, map, false);
> +	if (!sdata)
> +		return -ENOENT;
> +
> +	bpf_selem_unlink(SELEM(sdata), true);
> +	return 0;
> +}
> +
> +static int bpf_cgroup_storage_delete_elem(struct bpf_map *map, void *key)
> +{
> +	struct cgroup *cgroup;
> +	int err, fd;
> +
> +	fd = *(int *)key;
> +	cgroup = cgroup_get_from_fd(fd);
> +	if (IS_ERR(cgroup))
> +		return PTR_ERR(cgroup);
> +
> +	bpf_cgroup_storage_lock();
> +	err = cgroup_storage_delete(cgroup, map);
> +	bpf_cgroup_storage_unlock();
> +	if (err)
> +		return err;

Doesn't this error path leak the cgroup? Maybe this would be cleaner:

bpf_cgroup_storage_lock();
err = cgroup_storage_delete(cgroup, map);
bpf_cgroup_storage_unlock();
cgroup_put(cgroup);

return err;

> +
> +	cgroup_put(cgroup);
> +	return 0;
> +}
> +

[...]

Thanks,
David
