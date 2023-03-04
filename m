Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B03E6AA89C
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCDHxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 02:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDHxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 02:53:10 -0500
Received: from out-54.mta1.migadu.com (out-54.mta1.migadu.com [IPv6:2001:41d0:203:375::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D7113EF
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 23:53:07 -0800 (PST)
Message-ID: <2c4ba6a2-3225-9ffa-c537-f606c01b00e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677916385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfKTkgt/AP7S3gu6cD7z07ZEMXNExxFP6k3rog+PsIY=;
        b=nPdFfICSCPc6WO4rDkvg/7uipk3BS6XDWkQTsXMxKl5IEBnnCsecKcdebLSP0V12jafaYT
        hAYcqqdnDcXZzCeW2gWhsJMC7pl6Hmr1DybVfPOeTfGhUUlln6UiYawzn5+uzpzaPxDwCP
        EXjyl6AAvDA6qfvqUQCnwdrG8XsWkgs=
Date:   Fri, 3 Mar 2023 23:52:58 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Support kptrs in local storage maps
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>, bpf@vger.kernel.org
References: <20230225154010.391965-1-memxor@gmail.com>
 <20230225154010.391965-3-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230225154010.391965-3-memxor@gmail.com>
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

On 2/25/23 7:40 AM, Kumar Kartikeya Dwivedi wrote:
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 6d37a40cd90e..0fe92986412b 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -74,6 +74,12 @@ struct bpf_local_storage_elem {
>   	struct hlist_node snode;	/* Linked to bpf_local_storage */
>   	struct bpf_local_storage __rcu *local_storage;
>   	struct rcu_head rcu;
> +	bool can_use_smap; /* Is it safe to access smap in bpf_selem_free_* RCU
> +			    * callbacks? bpf_local_storage_map_free only
> +			    * executes rcu_barrier when there are special
> +			    * fields, this field remembers that to ensure we
> +			    * don't access already freed smap in sdata.
> +			    */
>   	/* 8 bytes hole */
>   	/* The data is stored in another cacheline to minimize
>   	 * the number of cachelines access during a cache hit.
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 58da17ae5124..2bdd722fe293 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -85,6 +85,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>   	if (selem) {
>   		if (value)
>   			copy_map_value(&smap->map, SDATA(selem)->data, value);
> +		/* No need to call check_and_init_map_value as memory is zero init */
>   		return selem;
>   	}
>   
> @@ -113,10 +114,25 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
>   	struct bpf_local_storage_elem *selem;
>   
>   	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> +	/* The can_use_smap bool is set whenever we need to free additional
> +	 * fields in selem data before freeing selem. bpf_local_storage_map_free
> +	 * only executes rcu_barrier to wait for RCU callbacks when it has
> +	 * special fields, hence we can only conditionally dereference smap, as
> +	 * by this time the map might have already been freed without waiting
> +	 * for our call_rcu callback if it did not have any special fields.
> +	 */
> +	if (selem->can_use_smap)
> +		bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
> +	kfree(selem);
> +}
> +
> +static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
> +{
> +	/* Free directly if Tasks Trace RCU GP also implies RCU GP */
>   	if (rcu_trace_implies_rcu_gp())
> -		kfree(selem);
> +		bpf_selem_free_rcu(rcu);
>   	else
> -		kfree_rcu(selem, rcu);
> +		call_rcu(rcu, bpf_selem_free_rcu);
>   }
>   
>   /* local_storage->lock must be held and selem->local_storage == local_storage.
> @@ -170,9 +186,9 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
>   		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
>   
>   	if (use_trace_rcu)
> -		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> +		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
>   	else
> -		kfree_rcu(selem, rcu);
> +		call_rcu(&selem->rcu, bpf_selem_free_rcu);

After another thought, bpf_obj_free_fields() does not need to go through the rcu 
gp, right?

bpf_obj_free_fields() can be done just before the call_rcu_tasks_trace() and the 
call_rcu() here. In hashtab, bpf_obj_free_fields() is also done just before 
bpf_mem_cache_free().

>   
>   	return free_local_storage;
>   }
> @@ -240,6 +256,11 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
>   	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
>   	hlist_add_head_rcu(&selem->map_node, &b->list);
>   	raw_spin_unlock_irqrestore(&b->lock, flags);
> +
> +	/* If our data will have special fields, smap will wait for us to use
> +	 * its record in bpf_selem_free_* RCU callbacks before freeing itself.
> +	 */
> +	selem->can_use_smap = !IS_ERR_OR_NULL(smap->map.record);
>   }
>   
>   void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
> @@ -723,6 +744,25 @@ void bpf_local_storage_map_free(struct bpf_map *map,
>   	 */
>   	synchronize_rcu();
>   
> +	/* Only delay freeing of smap, buckets are not needed anymore */
>   	kvfree(smap->buckets);
> +
> +	/* When local storage has special fields, callbacks for
> +	 * bpf_selem_free_rcu and bpf_selem_free_tasks_trace_rcu will keep using
> +	 * the map BTF record, we need to execute an RCU barrier to wait for
> +	 * them as the record will be freed right after our map_free callback.
> +	 */
> +	if (!IS_ERR_OR_NULL(smap->map.record)) {
> +		rcu_barrier_tasks_trace();
> +		/* We cannot skip rcu_barrier() when rcu_trace_implies_rcu_gp()
> +		 * is true, because while call_rcu invocation is skipped in that
> +		 * case in bpf_selem_free_tasks_trace_rcu (and all local storage
> +		 * maps pass use_trace_rcu = true), there can be call_rcu
> +		 * callbacks based on use_trace_rcu = false in the earlier while
> +		 * ((selem = ...)) loop or from bpf_local_storage_unlink_nolock
> +		 * called from owner's free path.
> +		 */
> +		rcu_barrier();
> +	}
>   	bpf_map_area_free(smap);
>   }

