Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2240D6B14FF
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 23:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCHWWU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 17:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCHWWJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 17:22:09 -0500
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E979BE32
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 14:21:38 -0800 (PST)
Message-ID: <5b760fdc-a3c2-f416-4729-c17e67f6b2d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678314096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRO0FxBiOKulItnxcpwkYDg/R1sRbceQjZAUG0FCWQw=;
        b=GjgREY08a+rpoHW0mLXROZvyl9yuqSnRY3koMfvCBZ+MtvrUZUEkArXhudBDisEhyWYCZB
        kw5T4cSZdtW6mr+Sp6pARvTEqg2HazFfupHqBWLXiqOquwRnyE6FPYRhI0uwEQwaF1jjh7
        x8SSC+17fA8HCBgNCRPZyFSWrNV5TpQ=
Date:   Wed, 8 Mar 2023 14:21:33 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 5/8] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
 <20230308005050.255859-6-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230308005050.255859-6-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/7/23 4:50 PM, Kui-Feng Lee wrote:
> By improving the BPF_LINK_UPDATE command of bpf(), it should allow you
> to conveniently switch between different struct_ops on a single
> bpf_link. This would enable smoother transitions from one struct_ops
> to another.
> 
> The struct_ops maps passing along with BPF_LINK_UPDATE should have the
> BPF_F_LINK flag.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   include/linux/bpf.h            |  1 +
>   include/uapi/linux/bpf.h       |  8 ++++--
>   kernel/bpf/bpf_struct_ops.c    | 46 ++++++++++++++++++++++++++++++++++
>   kernel/bpf/syscall.c           | 43 ++++++++++++++++++++++++++++---
>   tools/include/uapi/linux/bpf.h |  7 +++++-
>   5 files changed, 98 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index afca6c526fe4..29d555a82bad 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1470,6 +1470,7 @@ struct bpf_link_ops {
>   	void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
>   	int (*fill_link_info)(const struct bpf_link *link,
>   			      struct bpf_link_info *info);
> +	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map);
>   };
>   
>   struct bpf_tramp_link {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f9fc7b8af3c4..edef9cf7d596 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1555,8 +1555,12 @@ union bpf_attr {
>   
>   	struct { /* struct used by BPF_LINK_UPDATE command */
>   		__u32		link_fd;	/* link fd */
> -		/* new program fd to update link with */
> -		__u32		new_prog_fd;
> +		union {
> +			/* new program fd to update link with */
> +			__u32		new_prog_fd;
> +			/* new struct_ops map fd to update link with */
> +			__u32           new_map_fd;
> +		};
>   		__u32		flags;		/* extra flags */
>   		/* expected link's program fd; is specified only if
>   		 * BPF_F_REPLACE flag is set in flags */
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 5a7e86cf67b5..79e663869e51 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -775,10 +775,56 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>   	return 0;
>   }
>   
> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map)
> +{
> +	struct bpf_struct_ops_value *kvalue;
> +	struct bpf_struct_ops_map *st_map, *old_st_map;
> +	struct bpf_struct_ops_link *st_link;
> +	struct bpf_map *old_map;
> +	int err = 0;
> +
> +	if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
> +	    !(new_map->map_flags & BPF_F_LINK))
> +		return -EINVAL;
> +
> +	mutex_lock(&update_mutex);
> +
> +	st_link = container_of(link, struct bpf_struct_ops_link, link);
> +
> +	/* The new and old struct_ops must be the same type. */
> +	st_map = container_of(new_map, struct bpf_struct_ops_map, map);

nit. move the st_link and st_map init out of the lock.

> +
> +	old_map = st_link->map;

rcu_dereference_protected(...)

> +	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
> +	if (st_map->st_ops != old_st_map->st_ops ||
> +	    /* Pair with smp_store_release() during map_update */
> +	    smp_load_acquire(&st_map->kvalue.state) != BPF_STRUCT_OPS_STATE_READY) {

nit. test the smp_load_acquire(&st_map...) outside of the lock.
Do it together with the new_map checking at the beginning of the func.

> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	kvalue = &st_map->kvalue;
> +
> +	err = st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
> +	if (err)
> +		goto err_out;
> +
> +	bpf_map_inc(new_map);
> +	rcu_assign_pointer(st_link->map, new_map);
> +
> +	bpf_map_put(old_map);
> +
> +err_out:
> +	mutex_unlock(&update_mutex);
> +
> +	return err;
> +}
> +
>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>   	.dealloc = bpf_struct_ops_map_link_dealloc,
>   	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>   	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
> +	.update_map = bpf_struct_ops_map_link_update,
>   };
>   
>   int bpf_struct_ops_link_create(union bpf_attr *attr)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3a4503987a48..c087dd2e2c08 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4658,6 +4658,30 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   	return ret;
>   }
>   
> +static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
> +{
> +	struct bpf_map *new_map;
> +	int ret = 0;
> +
> +	new_map = bpf_map_get(attr->link_update.new_map_fd);
> +	if (IS_ERR(new_map))
> +		return -EINVAL;
> +
> +	if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS) {

This is unnecessary test. The individual '.update_map()' should test for its own 
map_type and the new bpf_struct_ops_map_link_update() does test it.

> +		ret = -EINVAL;
> +		goto out_put_map;
> +	}
> +
> +	if (link->ops->update_map)

This has just been tested in link_update() before calling link_update_map().

> +		ret = link->ops->update_map(link, new_map);
> +	else
> +		ret = -EINVAL;
> +
> +out_put_map:
> +	bpf_map_put(new_map);
> +	return ret;
> +}
> +
>   #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>   
>   static int link_update(union bpf_attr *attr)
> @@ -4670,14 +4694,25 @@ static int link_update(union bpf_attr *attr)
>   	if (CHECK_ATTR(BPF_LINK_UPDATE))
>   		return -EINVAL;
>   
> -	flags = attr->link_update.flags;
> -	if (flags & ~BPF_F_REPLACE)
> -		return -EINVAL;
> -
>   	link = bpf_link_get_from_fd(attr->link_update.link_fd);
>   	if (IS_ERR(link))
>   		return PTR_ERR(link);
>   
> +	flags = attr->link_update.flags;
> +
> +	if (link->ops->update_map) {
> +		if (flags)	/* always replace the existing one */
> +			ret = -EINVAL;
> +		else
> +			ret = link_update_map(link, attr);
> +		goto out_put_link;
> +	}
> +
> +	if (flags & ~BPF_F_REPLACE) {
> +		ret = -EINVAL;
> +		goto out_put_link;
> +	}
> +
>   	new_prog = bpf_prog_get(attr->link_update.new_prog_fd);
>   	if (IS_ERR(new_prog)) {
>   		ret = PTR_ERR(new_prog);

