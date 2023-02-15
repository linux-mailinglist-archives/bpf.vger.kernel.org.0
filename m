Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D469748F
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 03:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBOCx3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 21:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOCx2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 21:53:28 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5C42CFD0
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:53:27 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id oo13-20020a17090b1c8d00b0022936a63a22so370452pjb.8
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 18:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676429606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbRHD0sVyVdXV5ufNa7oF/JZ0SsbkJyrGi+8gYLaYJk=;
        b=MIgFl+OC6XbB3Kd4Tew/6bkOzmkTTf/DlWWVwzEOGDlw+2A2wX5dJi+N4xtyNTKEAL
         hh/0prfYnIXtPSgwo5bLG/9nRbwSrOEoxEAFzLEaqQwby1loPZ336E58Si/0XFZ/FtXd
         uNduS0XtaXrZL/+FDhcvgzxeFsKIcPdFej1vYqy/XN/bkkRx0G7blvBBJBoF//krljPH
         ZgF6yVZGx9XAjk2KastahcJD4o8ijyT1xfQEfuIOlRFCqCWGo5L8qocPzXEkcSDqwc7J
         fs/dZ+SpoyWHQ6oMDY2THD6Aiosmox1plJYJfbKfQ/DLYdNBRyVC/ZvTYaPiR4+d4zaF
         iSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676429606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbRHD0sVyVdXV5ufNa7oF/JZ0SsbkJyrGi+8gYLaYJk=;
        b=z7WmHPgYujeOpMT0bXwDUV3ATbVZR08cK99TkXZtoyVnI/6As4kx8a8o9Als3Wn1cF
         g06TwCCHzS5+4ntHR3keYrVtijRpuICQqqsW4Pd98l4UUYZk8q+QgQfhiQ4UnpZoCY92
         WrmJMFr2I8GRC48no2iHq/zdkWzV6O1FE5WUGLA3KQUfFDnPtbo4GBqAFNB/YOdDL9H6
         N20VG10eQPf/n4IEkKFjhMumGXobbxEM96WTOwIP1n5j8+i3OBI4xwvXuzSBb8/13BAg
         SjTQyxtPiCv6Xe6Ci4MT5T5aPdPQUg0s/TJQGM2/ukFgckxp/6lk4alm2OQ7dVdwuKZu
         gT3g==
X-Gm-Message-State: AO0yUKV49C7HxXtxjOlfXcRLYJbFiBZtnsqHXi/rGbL7W40Aj0kbAGaA
        Cx4ZSKw8kF1ZqzF13b2oJaHPwbk=
X-Google-Smtp-Source: AK7set9HzDLpg34wEdhUgpYDhuWn1h4jF8BS/Pft8cU+fIcASATplnszD0hAK00tjufIuivKPFvoCi4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:9f9b:0:b0:5a8:4eef:4db9 with SMTP id
 z27-20020aa79f9b000000b005a84eef4db9mr64540pfr.22.1676429606546; Tue, 14 Feb
 2023 18:53:26 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:53:24 -0800
In-Reply-To: <20230214221718.503964-4-kuifeng@meta.com>
Mime-Version: 1.0
References: <20230214221718.503964-1-kuifeng@meta.com> <20230214221718.503964-4-kuifeng@meta.com>
Message-ID: <Y+xJJLAhPBzboOvo@google.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: Register and unregister a struct_ops by
 their bpf_links.
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

On 02/14, Kui-Feng Lee wrote:
> Registration via bpf_links ensures a uniform behavior, just like other
> BPF programs.  BPF struct_ops were registered/unregistered when
> updating/deleting their values.  Only the maps of struct_ops having
> the BPF_F_LINK flag are allowed to back a bpf_link.

> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   include/uapi/linux/bpf.h       |  3 ++
>   kernel/bpf/bpf_struct_ops.c    | 59 +++++++++++++++++++++++++++++++---
>   tools/include/uapi/linux/bpf.h |  3 ++
>   3 files changed, 61 insertions(+), 4 deletions(-)

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1e6cdd0f355d..48d8b3058aa1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1267,6 +1267,9 @@ enum {

>   /* Create a map that is suitable to be an inner map with dynamic max  
> entries */
>   	BPF_F_INNER_MAP		= (1U << 12),
> +
> +/* Create a map that will be registered/unregesitered by the backed  
> bpf_link */
> +	BPF_F_LINK		= (1U << 13),
>   };

>   /* Flags for BPF_PROG_QUERY. */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 621c8e24481a..d16ca06cf09a 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -390,7 +390,7 @@ static int bpf_struct_ops_map_update_elem(struct  
> bpf_map *map, void *key,

>   	mutex_lock(&st_map->lock);

> -	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
> +	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT ||  
> refcount_read(&kvalue->refcnt)) {
>   		err = -EBUSY;
>   		goto unlock;
>   	}
> @@ -491,6 +491,12 @@ static int bpf_struct_ops_map_update_elem(struct  
> bpf_map *map, void *key,
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
>   	}

> +	if (st_map->map.map_flags & BPF_F_LINK) {
> +		/* Let bpf_link handle registration & unregistration. */
> +		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
> +		goto unlock;
> +	}
> +
>   	refcount_set(&kvalue->refcnt, 1);
>   	bpf_map_inc(map);


[..]

> @@ -522,6 +528,7 @@ static int bpf_struct_ops_map_update_elem(struct  
> bpf_map *map, void *key,
>   	kfree(tlinks);
>   	mutex_unlock(&st_map->lock);
>   	return err;
> +
>   }

>   static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)

Seems like a left over hunk?

> @@ -535,6 +542,8 @@ static int bpf_struct_ops_map_delete_elem(struct  
> bpf_map *map, void *key)
>   			     BPF_STRUCT_OPS_STATE_TOBEFREE);
>   	switch (prev_state) {
>   	case BPF_STRUCT_OPS_STATE_INUSE:
> +		if (st_map->map.map_flags & BPF_F_LINK)
> +			return 0;
>   		st_map->st_ops->unreg(&st_map->kvalue.data);
>   		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
>   			bpf_map_put(map);
> @@ -585,7 +594,7 @@ static void bpf_struct_ops_map_free(struct bpf_map  
> *map)
>   static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
>   {
>   	if (attr->key_size != sizeof(unsigned int) || attr->max_entries != 1 ||
> -	    attr->map_flags || !attr->btf_vmlinux_value_type_id)
> +	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id)
>   		return -EINVAL;
>   	return 0;
>   }
> @@ -638,6 +647,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union  
> bpf_attr *attr)
>   	set_vm_flush_reset_perms(st_map->image);
>   	bpf_map_init_from_attr(map, attr);


[..]

> +	map->map_flags |= attr->map_flags & BPF_F_LINK;

You seem to have the following check above:

if (.... (attr->map_flags & ~BPF_F_LINK) ...) return -EINVAL;

And here you do:

map->map_flags |= attr->map_flags & BPF_F_LINK;

So maybe we can simplify to:
map->map_flags |= attr->map_flags;

?

> +
>   	return map;
>   }

> @@ -699,10 +710,25 @@ void bpf_struct_ops_put(const void *kdata)
>   	}
>   }

> +static void bpf_struct_ops_kvalue_put(struct bpf_struct_ops_value  
> *kvalue)
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
>   	}
>   }
> @@ -735,13 +761,15 @@ static const struct bpf_link_ops  
> bpf_struct_ops_map_lops = {

>   int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
>   {
> +	struct bpf_struct_ops_map *st_map;
>   	struct bpf_link_primer link_primer;
> +	struct bpf_struct_ops_value *kvalue;
>   	struct bpf_map *map;
>   	struct bpf_link *link = NULL;
>   	int err;

>   	map = bpf_map_get(attr->link_create.prog_fd);
> -	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
> +	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags &  
> BPF_F_LINK))
>   		return -EINVAL;

>   	link = kzalloc(sizeof(*link), GFP_USER);
> @@ -752,6 +780,29 @@ int link_create_struct_ops_map(union bpf_attr *attr,  
> bpfptr_t uattr)
>   	bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops,  
> NULL);
>   	link->map = map;


[..]

> +	if (map->map_flags & BPF_F_LINK) {

We seem to bail out above when we don't have BPF_F_LINK flags above?

if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags &  
BPF_F_LINK))
	return -EINVAL;

So why check this 'if (map->map_flags & BPF_F_LINK)' condition here?


> +		st_map = (struct bpf_struct_ops_map *)map;
> +		kvalue = (struct bpf_struct_ops_value *)&st_map->kvalue;
> +
> +		if (kvalue->state != BPF_STRUCT_OPS_STATE_INUSE ||
> +		    refcount_read(&kvalue->refcnt) != 0) {
> +			err = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		refcount_set(&kvalue->refcnt, 1);
> +
> +		set_memory_rox((long)st_map->image, 1);
> +		err = st_map->st_ops->reg(kvalue->data);
> +		if (err) {
> +			refcount_set(&kvalue->refcnt, 0);
> +
> +			set_memory_nx((long)st_map->image, 1);
> +			set_memory_rw((long)st_map->image, 1);
> +			goto err_out;
> +		}
> +	}
> +
>   	err = bpf_link_prime(link, &link_primer);
>   	if (err)
>   		goto err_out;
> diff --git a/tools/include/uapi/linux/bpf.h  
> b/tools/include/uapi/linux/bpf.h
> index 1e6cdd0f355d..48d8b3058aa1 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1267,6 +1267,9 @@ enum {

>   /* Create a map that is suitable to be an inner map with dynamic max  
> entries */
>   	BPF_F_INNER_MAP		= (1U << 12),
> +
> +/* Create a map that will be registered/unregesitered by the backed  
> bpf_link */
> +	BPF_F_LINK		= (1U << 13),
>   };

>   /* Flags for BPF_PROG_QUERY. */
> --
> 2.30.2

