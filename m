Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00D6BEECB
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 17:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCQQsP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCQQsO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 12:48:14 -0400
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [IPv6:2001:41d0:203:375::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803E95BF8
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 09:47:47 -0700 (PDT)
Message-ID: <d77e2767-f8cf-14f0-a72b-47e9343ecc75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679071665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ObfwFYCBUk7kA4D7dk5ZStLHqjY/fhWJMxQIkW5flLY=;
        b=p/tLwRJwHrvevcsPrWBKvJXdmVCjoBKIyMiF379MpRp9EyKKkOHWDIMkLcTfFadKHeXyUG
        wMJqC//knsynC2PQ6gKL1bskOf24VpQvFMnptEvrwUFxOft2pdrj4L7yNeyAwf358lyGDP
        MuvNe35ILz8JIyhb9yCst1vi1Il47LA=
Date:   Fri, 17 Mar 2023 09:47:40 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/8] bpf: Retire the struct_ops map
 kvalue->refcnt.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-2-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
In-Reply-To: <20230316023641.2092778-2-kuifeng@meta.com>
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
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1943,6 +1943,7 @@ struct bpf_map *bpf_map_get_with_uref(u32 ufd);
>   struct bpf_map *__bpf_map_get(struct fd f);
>   void bpf_map_inc(struct bpf_map *map);
>   void bpf_map_inc_with_uref(struct bpf_map *map);
> +struct bpf_map *__bpf_map_inc_not_zero(struct bpf_map *map, bool uref);
>   struct bpf_map * __must_check bpf_map_inc_not_zero(struct bpf_map *map);
>   void bpf_map_put_with_uref(struct bpf_map *map);
>   void bpf_map_put(struct bpf_map *map);
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 38903fb52f98..2a854e9cee52 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -58,6 +58,8 @@ struct bpf_struct_ops_map {
>   	struct bpf_struct_ops_value kvalue;
>   };
>   
> +static DEFINE_MUTEX(update_mutex);

There has been a comment on the unused "update_mutex" since v3 and v5:

"...This is only used in patch 5 of this set. Please move it there..."


> +
>   #define VALUE_PREFIX "bpf_struct_ops_"
>   #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
>   
> @@ -249,6 +251,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
>   	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
>   	struct bpf_struct_ops_value *uvalue, *kvalue;
>   	enum bpf_struct_ops_state state;
> +	s64 refcnt;
>   
>   	if (unlikely(*(u32 *)key != 0))
>   		return -ENOENT;
> @@ -267,7 +270,14 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
>   	uvalue = value;
>   	memcpy(uvalue, st_map->uvalue, map->value_size);
>   	uvalue->state = state;
> -	refcount_set(&uvalue->refcnt, refcount_read(&kvalue->refcnt));
> +
> +	/* This value offers the user space a general estimate of how
> +	 * many sockets are still utilizing this struct_ops for TCP
> +	 * congestion control. The number might not be exact, but it
> +	 * should sufficiently meet our present goals.
> +	 */
> +	refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
> +	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
>   
>   	return 0;
>   }
> @@ -491,7 +501,6 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		*(unsigned long *)(udata + moff) = prog->aux->id;
>   	}
>   
> -	refcount_set(&kvalue->refcnt, 1);
>   	bpf_map_inc(map);
>   
>   	set_memory_rox((long)st_map->image, 1);
> @@ -536,8 +545,7 @@ static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
>   	switch (prev_state) {
>   	case BPF_STRUCT_OPS_STATE_INUSE:
>   		st_map->st_ops->unreg(&st_map->kvalue.data);
> -		if (refcount_dec_and_test(&st_map->kvalue.refcnt))
> -			bpf_map_put(map);
> +		bpf_map_put(map);
>   		return 0;
>   	case BPF_STRUCT_OPS_STATE_TOBEFREE:
>   		return -EINPROGRESS;
> @@ -570,7 +578,7 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
>   	kfree(value);
>   }
>   
> -static void bpf_struct_ops_map_free(struct bpf_map *map)
> +static void bpf_struct_ops_map_free_nosync(struct bpf_map *map)

nit. __bpf_struct_ops_map_free() is the usual alternative name to use in this case.

>   {
>   	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
>   
> @@ -582,6 +590,25 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>   	bpf_map_area_free(st_map);
>   }
>   
> +static void bpf_struct_ops_map_free(struct bpf_map *map)
> +{
> +	/* The struct_ops's function may switch to another struct_ops.
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
> +	synchronize_rcu();
> +	synchronize_rcu_tasks();

synchronize_rcu_mult(call_rcu, call_rcu_tasks) to wait both in parallel (credit 
to Paul's tip).


