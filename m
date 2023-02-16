Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412C7698955
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 01:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBPAhj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 19:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPAhj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 19:37:39 -0500
Received: from out-81.mta0.migadu.com (out-81.mta0.migadu.com [IPv6:2001:41d0:1004:224b::51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C6942DD0
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 16:37:37 -0800 (PST)
Message-ID: <4f5012d6-e07a-2602-3526-d43244d9d978@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676507856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJLCb0RH2DlpjX7uguGp/+aAQsiUrq5bMthOGcDy+WU=;
        b=cV6Xvhpk632gtieiIQVpCEPEOs9djfDphdE6VVy/QsU9QpVZ77XIcVKormo5pP6mCbgQlo
        E1t8Z3XJhCy5cx9Yt9K0CN+b+2f2s//8aDZuaFLpAf2aLjG/wpDzkn+/i0y5At0XmG/DO7
        1N4uDPLqDSX7IIsAw7Vq2E1exRqx4Gc=
Date:   Wed, 15 Feb 2023 16:37:18 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/7] bpf: Register and unregister a struct_ops by
 their bpf_links.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-4-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230214221718.503964-4-kuifeng@meta.com>
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

On 2/14/23 2:17 PM, Kui-Feng Lee wrote:
> Registration via bpf_links ensures a uniform behavior, just like other
> BPF programs.  BPF struct_ops were registered/unregistered when
> updating/deleting their values.  Only the maps of struct_ops having
> the BPF_F_LINK flag are allowed to back a bpf_link.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   include/uapi/linux/bpf.h       |  3 ++
>   kernel/bpf/bpf_struct_ops.c    | 59 +++++++++++++++++++++++++++++++---
>   tools/include/uapi/linux/bpf.h |  3 ++
>   3 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1e6cdd0f355d..48d8b3058aa1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1267,6 +1267,9 @@ enum {
>   
>   /* Create a map that is suitable to be an inner map with dynamic max entries */
>   	BPF_F_INNER_MAP		= (1U << 12),
> +
> +/* Create a map that will be registered/unregesitered by the backed bpf_link */
> +	BPF_F_LINK		= (1U << 13),
>   };
>   
>   /* Flags for BPF_PROG_QUERY. */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 621c8e24481a..d16ca06cf09a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -390,7 +390,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   
>   	mutex_lock(&st_map->lock);
>   
> -	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
> +	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT || refcount_read(&kvalue->refcnt)) {

Why it needs a new refcount_read(&kvalue->refcnt) check?

>   		err = -EBUSY;
>   		goto unlock;
>   	}
> @@ -491,6 +491,12 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
>   	}
>   
> +	if (st_map->map.map_flags & BPF_F_LINK) {
> +		/* Let bpf_link handle registration & unregistration. */
> +		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);

INUSE is for registered struct_ops. It needs a new UNREG state to mean 
initialized but not registered. The kvalue->state is not in uapi but the user 
space can still introspect it (thanks to BTF), so having a correct semantic 
state is useful. Try 'bpftool struct_ops dump ...':

     "bpf_struct_ops_tcp_congestion_ops": {
         "refcnt": {
             "refs": {
                 "counter": 1
             }
         },
         "state": "BPF_STRUCT_OPS_STATE_INUSE",

> +		goto unlock;
> +	}
> +
>   	refcount_set(&kvalue->refcnt, 1);
>   	bpf_map_inc(map);
>   
> @@ -522,6 +528,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	kfree(tlinks);
>   	mutex_unlock(&st_map->lock);
>   	return err;
> +

Unnecessary new line.

>   }
>   
>   static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
> @@ -535,6 +542,8 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
>   			     BPF_STRUCT_OPS_STATE_TOBEFREE);
>   	switch (prev_state) {
>   	case BPF_STRUCT_OPS_STATE_INUSE:
> +		if (st_map->map.map_flags & BPF_F_LINK)
> +			return 0;

This should be a -ENOTSUPP.

>   		st_map->st_ops->unreg(&st_map->kvalue.data);
>   		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
>   			bpf_map_put(map);
> @@ -585,7 +594,7 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>   static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
>   {
>   	if (attr->key_size != sizeof(unsigned int) || attr->max_entries != 1 ||
> -	    attr->map_flags || !attr->btf_vmlinux_value_type_id)
> +	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id)
>   		return -EINVAL;
>   	return 0;
>   }
> @@ -638,6 +647,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	set_vm_flush_reset_perms(st_map->image);
>   	bpf_map_init_from_attr(map, attr);
>   
> +	map->map_flags |= attr->map_flags & BPF_F_LINK;

This should have already been done in bpf_map_init_from_attr().

> +
>   	return map;
>   }
>   
> @@ -699,10 +710,25 @@ void bpf_struct_ops_put(const void *kdata)
>   	}
>   }
>   
> +static void bpf_struct_ops_kvalue_put(struct bpf_struct_ops_value *kvalue)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	if (refcount_dec_and_test(&kvalue->refcnt)) {
> +		st_map = container_of(kvalue, struct bpf_struct_ops_map,
> +				      kvalue);
> +		bpf_map_put(&st_map->map);
> +	}
> +}
> +
>   static void bpf_struct_ops_map_link_release(struct bpf_link *link)
>   {
> +	struct bpf_struct_ops_map *st_map;
> +
>   	if (link->map) {
> -		bpf_map_put(link->map);
> +		st_map = (struct bpf_struct_ops_map *)link->map;
> +		st_map->st_ops->unreg(&st_map->kvalue.data);
> +		bpf_struct_ops_kvalue_put(&st_map->kvalue);
>   		link->map = NULL;

Does it need a lock or something to protect the link_release? or I am missing 
something and lock is not needed?

The kvalue->value state should become UNREG.

After UNREG, can the struct_ops map be used in creating a new link again?

>   	}
>   }
> @@ -735,13 +761,15 @@ static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>   
>   int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
>   {
> +	struct bpf_struct_ops_map *st_map;
>   	struct bpf_link_primer link_primer;
> +	struct bpf_struct_ops_value *kvalue;
>   	struct bpf_map *map;
>   	struct bpf_link *link = NULL;
>   	int err;
>   
>   	map = bpf_map_get(attr->link_create.prog_fd);
> -	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
> +	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags & BPF_F_LINK))
>   		return -EINVAL;
>   
>   	link = kzalloc(sizeof(*link), GFP_USER);
> @@ -752,6 +780,29 @@ int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
>   	bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
>   	link->map = map;
>   
> +	if (map->map_flags & BPF_F_LINK) {
> +		st_map = (struct bpf_struct_ops_map *)map;
> +		kvalue = (struct bpf_struct_ops_value *)&st_map->kvalue;
> +
> +		if (kvalue->state != BPF_STRUCT_OPS_STATE_INUSE ||
> +		    refcount_read(&kvalue->refcnt) != 0) {

The refcount_read(&kvalue->refcnt) is to ensure it is not registered?
It seems the UNREG state is useful here.

> +			err = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		refcount_set(&kvalue->refcnt, 1);

If a struct_ops map is used to create multiple links in parallel, is it safe?

> +
> +		set_memory_rox((long)st_map->image, 1);
> +		err = st_map->st_ops->reg(kvalue->data);

After successful reg, the state can be changed from UNREG to INUSE.

> +		if (err) {
> +			refcount_set(&kvalue->refcnt, 0);
> +
> +			set_memory_nx((long)st_map->image, 1);
> +			set_memory_rw((long)st_map->image, 1);
> +			goto err_out;
> +		}
> +	}

This patch should be combined with patch 1. Otherwise, patch 1 is quite hard to 
understand without link_create_struct_ops_map() doing the actual "attach".

> +
>   	err = bpf_link_prime(link, &link_primer);
>   	if (err)
>   		goto err_out;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 1e6cdd0f355d..48d8b3058aa1 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1267,6 +1267,9 @@ enum {
>   
>   /* Create a map that is suitable to be an inner map with dynamic max entries */
>   	BPF_F_INNER_MAP		= (1U << 12),
> +
> +/* Create a map that will be registered/unregesitered by the backed bpf_link */
> +	BPF_F_LINK		= (1U << 13),
>   };
>   
>   /* Flags for BPF_PROG_QUERY. */

