Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC26BF19C
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 20:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQTXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCQTXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 15:23:32 -0400
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA58D298D8
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 12:23:29 -0700 (PDT)
Message-ID: <690c5fff-4828-c849-c946-1f1a29e168c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679081007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9xE7REVjzxBDGOSVqjVSc4TbSZnDaJFuq91b5ty02I=;
        b=l7qv7lqUPgcpmQRtuGgd7RSPEgZpOEVZNrybuQjWBe6G5zPozwlB3y3m4+QCD/l3L6jxly
        vBzuhhe5ysjsi2COjZIV4/mGN9Q6+iYQQHhlPWdZdyJs0VwQde4HA8fgbFqpuDiDfrZiR6
        xj5P+KFs9jhg5RPUweXA26FtdE08URs=
Date:   Fri, 17 Mar 2023 12:23:23 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 5/8] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-6-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
In-Reply-To: <20230316023641.2092778-6-kuifeng@meta.com>
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

On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map)
> +{
> +	struct bpf_struct_ops_map *st_map, *old_st_map;
> +	struct bpf_struct_ops_link *st_link;
> +	struct bpf_map *old_map;
> +	int err = 0;
> +
> +	st_link = container_of(link, struct bpf_struct_ops_link, link);
> +	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
> +
> +	if (!bpf_struct_ops_valid_to_reg(new_map))
> +		return -EINVAL;
> +
> +	mutex_lock(&update_mutex);
> +
> +	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
> +	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
> +	/* The new and old struct_ops must be the same type. */
> +	if (st_map->st_ops != old_st_map->st_ops) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);

I don't think it has completely addressed Andrii's comment in v4 regarding 
BPF_F_REPLACE: 
https://lore.kernel.org/bpf/CAEf4BzbK8s+VFG5HefydD7CRLzkRFKg-Er0PKV_-C2-yttfXzA@mail.gmail.com/

For now, tcp_update_congestion_control() enforces the same cc-name. However, it 
is still not the same as what BPF_F_REPLACE intented to do: update only when it 
is the same old-map. Same cc-name does not necessarily mean the same old-map.

> +	if (err)
> +		goto err_out;
> +
> +	bpf_map_inc(new_map);
> +	rcu_assign_pointer(st_link->map, new_map);
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
> index 5a45e3bf34e2..6fa10d108278 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4676,6 +4676,21 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>   	return ret;
>   }
>   
> +static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
> +{
> +	struct bpf_map *new_map;
> +	int ret = 0;

nit. init zero is unnecessarily.

> +
> +	new_map = bpf_map_get(attr->link_update.new_map_fd);
> +	if (IS_ERR(new_map))
> +		return -EINVAL;
> +
> +	ret = link->ops->update_map(link, new_map);
> +
> +	bpf_map_put(new_map);
> +	return ret;
> +}
> +
>   #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>   
>   static int link_update(union bpf_attr *attr)
> @@ -4696,6 +4711,11 @@ static int link_update(union bpf_attr *attr)
>   	if (IS_ERR(link))
>   		return PTR_ERR(link);
>   
> +	if (link->ops->update_map) {
> +		ret = link_update_map(link, attr);
> +		goto out_put_link;
> +	}
> +
>   	new_prog = bpf_prog_get(attr->link_update.new_prog_fd);
>   	if (IS_ERR(new_prog)) {
>   		ret = PTR_ERR(new_prog);
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index ff4f89a2b02a..158f14e240d0 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -222,12 +222,18 @@ static void bpf_dummy_unreg(void *kdata)
>   {
>   }
>   
> +static int bpf_dummy_update(void *kdata, void *old_kdata)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   struct bpf_struct_ops bpf_bpf_dummy_ops = {
>   	.verifier_ops = &bpf_dummy_verifier_ops,
>   	.init = bpf_dummy_init,
>   	.check_member = bpf_dummy_ops_check_member,
>   	.init_member = bpf_dummy_init_member,
>   	.reg = bpf_dummy_reg,
> +	.update = bpf_dummy_update,

When looking at this together in patch 5, the changes in bpf_dummy_struct_ops.c 
should not be needed.


