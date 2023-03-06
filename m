Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77CE6AD2BC
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 00:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFXRE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 18:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFXRD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 18:17:03 -0500
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97213D0AD
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 15:17:02 -0800 (PST)
Message-ID: <39ab0ec2-2e8a-2de9-9603-5c5468ee9a1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678144620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HeZx261zJ+KmZYozYxdZAENn5ukHnkTH5QhxqsagTk=;
        b=kw9WjTaarhpd2rfOKO/kGoUjVuzByXtyYuHpOPdLQ9NQwzpJXvdbROg0mtc7qH2DrMX9n4
        cMjcIy/2unooCbnngafPAdouz33dSM4Su7vQJHPpP/oAbyN7Y2qrUJQjdJ8WMRck6PlZDy
        btGvCr72fHqyp7tr9cLEbhgxwYsvgCI=
Date:   Mon, 6 Mar 2023 15:16:57 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Maintain the refcount of struct_ops
 maps directly.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230303012122.852654-1-kuifeng@meta.com>
 <20230303012122.852654-2-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230303012122.852654-2-kuifeng@meta.com>
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

On 3/2/23 5:21 PM, Kui-Feng Lee wrote:
> The refcount of the kvalue for struct_ops was quite intricate to keep
> track of. By no longer utilizing it and replacing it with the refcount
> from the struct_ops map, this process became more transparent and
> uncomplicated.

The patch's subject is not very clear. may be 'Retire the struct_ops map 
kvalue->refcnt' better reflect what the patch is doing?

The commit message also needs details on the major change and the reason for the 
change. eg. Why freeing the struct_ops map needs to go through the rcu grace 
period and it is the reason on the rcu related changes in this patch.
Why retiring kvalue->refcnt is needed for (or can simplify?) the later patches?

> @@ -261,13 +264,13 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
>   		return 0;
>   	}
>   
> -	/* No lock is needed.  state and refcnt do not need
> -	 * to be updated together under atomic context.
> -	 */

This comment is still valid in this patch?

>   	uvalue = value;
>   	memcpy(uvalue, st_map->uvalue, map->value_size);
>   	uvalue->state = state;
> -	refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
> +
> +	refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
> +	refcount_set(&uvalue->refcnt,
> +		     refcnt > 0 ? refcnt : 0);

nit. max_t().

It also needs comment on why it will work or at least good enough.

>   
>   	return 0;
>   }
> @@ -491,7 +494,6 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
>   	}
>   
> -	refcount_set(&kvalue->refcnt, 1);
>   	bpf_map_inc(map);
>   
>   	set_memory_rox((long)st_map->image, 1);
> @@ -536,8 +538,7 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
>   	switch (prev_state) {
>   	case BPF_STRUCT_OPS_STATE_INUSE:
>   		st_map->st_ops->unreg(&st_map->kvalue.data);
> -		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
> -			bpf_map_put(map);
> +		bpf_map_put(map);
>   		return 0;
>   	case BPF_STRUCT_OPS_STATE_TOBEFREE:
>   		return -EINPROGRESS;
> @@ -582,6 +583,38 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>   	bpf_map_area_free(st_map);
>   }
>   
> +static void bpf_struct_ops_map_free_wq(struct rcu_head *head)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map = container_of(head, struct bpf_struct_ops_map, rcu);
> +
> +	/* bpf_map_free_deferred should not be called in a RCU callback. */
> +	INIT_WORK(&st_map->map.work, bpf_map_free_deferred);
> +	queue_work(system_unbound_wq, &st_map->map.work);
> +}
> +
> +static void bpf_struct_ops_map_free_rcu(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
> +
> +	/* Wait for a grace period of RCU. Then, post the map_free
> +	 * work to the system_unbound_wq workqueue to free resources.
> +	 *
> +	 * The struct_ops's function may switch to another struct_ops.
> +	 *
> +	 * For example, bpf_tcp_cc_x->init() may switch to
> +	 * another tcp_cc_y by calling
> +	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> +	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> +	 * and its refcount may reach 0 which then free its
> +	 * trampoline image while tcp_cc_x is still running.
> +	 *
> +	 * Thus, a rcu grace period is needed here.
> +	 */
> +	call_rcu(&st_map->rcu, bpf_struct_ops_map_free_wq);
> +}
> +
>   static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
>   {
>   	if (attr->key_size != sizeof(unsigned int) || attr->max_entries != 1 ||
> @@ -646,6 +679,7 @@ const struct bpf_map_ops bpf_struct_ops_map_ops = {
>   	.map_alloc_check = bpf_struct_ops_map_alloc_check,
>   	.map_alloc = bpf_struct_ops_map_alloc,
>   	.map_free = bpf_struct_ops_map_free,
> +	.map_free_rcu = bpf_struct_ops_map_free_rcu,

just came to my mind. Instead of having a rcu callback, synchronize_rcu() can be 
called in bpf_struct_ops_map_free(). Then the '.map_free_rcu' addition and its 
related change is not needed.

