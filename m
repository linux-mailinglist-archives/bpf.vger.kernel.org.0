Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2B698998
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 02:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBPBCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 20:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPBCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 20:02:49 -0500
Received: from out-244.mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC902D149
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 17:02:47 -0800 (PST)
Message-ID: <2651cae9-43a5-451b-b93f-874b3624e990@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676509365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQr8urEZ2l1H3V7fpN2XdDib3U5eCJK4YpglC2m2KfQ=;
        b=iaarCdaJIVLrg6FXVi27wRb4dtxx50WQPzNzLF3vicVTfBgaew7oaHqSHgEKO/v/pmHgrW
        oKjD8e84TAisQvwicKV4aV0imRwpA8TCMTMgfYL0ZGKJl2GjieBiuLAwL/1To6s2rtyQFD
        s6kYXvZoTaiTDYX1W2Eq5TWfZmHOECs=
Date:   Wed, 15 Feb 2023 17:02:34 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 5/7] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-6-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
In-Reply-To: <20230214221718.503964-6-kuifeng@meta.com>
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
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index d16ca06cf09a..d329621fc721 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -752,11 +752,66 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>   	return 0;
>   }
>   
> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map)
> +{
> +	struct bpf_struct_ops_value *kvalue;
> +	struct bpf_struct_ops_map *st_map, *old_st_map;
> +	struct bpf_map *old_map;
> +	int err;
> +
> +	if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(new_map->map_flags & BPF_F_LINK))
> +		return -EINVAL;
> +
> +	old_map = link->map;
> +
> +	/* It does nothing if the new map is the same as the old one.
> +	 * A struct_ops that backs a bpf_link can not be updated or
> +	 * its kvalue would be updated and causes inconsistencies.
> +	 */
> +	if (old_map == new_map)
> +		return 0;
> +
> +	/* The new and old struct_ops must be the same type. */
> +	st_map = (struct bpf_struct_ops_map *)new_map;
> +	old_st_map = (struct bpf_struct_ops_map *)old_map;
> +	if (st_map->st_ops != old_st_map->st_ops)
> +		return -EINVAL;
> +
> +	/* Assure the struct_ops is updated (has value) and not
> +	 * backing any other link.
> +	 */
> +	kvalue = &st_map->kvalue;
> +	if (kvalue->state != BPF_STRUCT_OPS_STATE_INUSE ||
> +	    refcount_read(&kvalue->refcnt) != 0)
> +		return -EINVAL;
> +
> +	bpf_map_inc(new_map);
> +	refcount_set(&kvalue->refcnt, 1);
> +
> +	set_memory_rox((long)st_map->image, 1);
> +	err = st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
> +	if (err) {
> +		refcount_set(&kvalue->refcnt, 0);
> +
> +		set_memory_nx((long)st_map->image, 1);
> +		set_memory_rw((long)st_map->image, 1);
> +		bpf_map_put(new_map);
> +		return err;
> +	}
> +
> +	link->map = new_map;

Similar here, does this link_update operation needs a lock?

> +
> +	bpf_struct_ops_kvalue_put(&old_st_map->kvalue);
> +
> +	return 0;
> +}
> +
>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>   	.release = bpf_struct_ops_map_link_release,
>   	.dealloc = bpf_struct_ops_map_link_dealloc,
>   	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>   	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
> +	.update_struct_ops = bpf_struct_ops_map_link_update,

This seems a little non-intuitive to add a struct_ops specific thing to the 
generic bpf_link_ops. May be avoid adding ".update_struct_ops" and directly call 
the bpf_struct_ops_map_link_update() from link_update()?


>   };
>   
>   int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 54e172d8f5d1..1341634863b5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4650,6 +4650,32 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   	return ret;
>   }
>   
> +#define BPF_LINK_UPDATE_STRUCT_OPS_LAST_FIELD link_update_struct_ops.new_map_fd

Why it is needed? Does it hit error without it?

> +
> +static int link_update_struct_ops(struct bpf_link *link, union bpf_attr *attr)
> +{
> +	struct bpf_map *new_map;
> +	int ret = 0;
> +
> +	new_map = bpf_map_get(attr->link_update.new_map_fd);
> +	if (IS_ERR(new_map))
> +		return -EINVAL;
> +
> +	if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
> +		ret = -EINVAL;
> +		goto out_put_map;
> +	}

How about BPF_F_REPLACE?

> +
> +	if (link->ops->update_struct_ops)
> +		ret = link->ops->update_struct_ops(link, new_map); > +	else
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
> @@ -4670,6 +4696,11 @@ static int link_update(union bpf_attr *attr)
>   	if (IS_ERR(link))
>   		return PTR_ERR(link);
>   
> +	if (link->type == BPF_LINK_TYPE_STRUCT_OPS) {
> +		ret = link_update_struct_ops(link, attr);
> +		goto out_put_link;
> +	}
> +
>   	new_prog = bpf_prog_get(attr->link_update.new_prog_fd);
>   	if (IS_ERR(new_prog)) {
>   		ret = PTR_ERR(new_prog);
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 66ce5fadfe42..558b01d5250f 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -239,8 +239,6 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
>   		if (bpf_obj_name_cpy(tcp_ca->name, utcp_ca->name,
>   				     sizeof(tcp_ca->name)) <= 0)
>   			return -EINVAL;
> -		if (tcp_ca_find(utcp_ca->name))
> -			return -EEXIST;

This change is not obvious. Please put some comment in the commit message about 
this change.

