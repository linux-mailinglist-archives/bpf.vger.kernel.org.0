Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA90F5B2E18
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 07:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIIF1l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 01:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIIF1k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 01:27:40 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A595125B0A
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 22:27:39 -0700 (PDT)
Message-ID: <5f4423cb-76f9-4e30-695d-22b7e8ab6422@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662701257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ovj8m7U5tuU4CWVbHILWFU5IJpkPgCzXKxAqQ6nFVcU=;
        b=sBm9X5sJdnnZeB9CRJvpTh+3Ds0TDFvh1JeH61KUQAKLXdR3toM0o93r9LJu8Wj2bkWlPe
        06/Tx17UQNP+1ynJtZDa7z3jTBLtJgzq7JMLgyqoiV2C0fpisvLh8+gNQS1oX2KTSbFaYM
        pqMVIYFixc7rRKpDgKuGeP7Rc1ebmJc=
Date:   Thu, 8 Sep 2022 22:27:32 -0700
MIME-Version: 1.0
Subject: Re: [PATCH RFC bpf-next v1 05/32] bpf: Support kptrs in local storage
 maps
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-6-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220904204145.3089-6-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/4/22 1:41 PM, Kumar Kartikeya Dwivedi wrote:
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 7ea18d4da84b..6786d00f004e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -74,7 +74,7 @@ struct bpf_local_storage_elem {
>   	struct hlist_node snode;	/* Linked to bpf_local_storage */
>   	struct bpf_local_storage __rcu *local_storage;
>   	struct rcu_head rcu;
> -	/* 8 bytes hole */
> +	struct bpf_map *map;		/* Only set for bpf_selem_free_rcu */

Instead of adding another map ptr and using the last 8 bytes hole,

>   	/* The data is stored in another cacheline to minimize
>   	 * the number of cachelines access during a cache hit.
>   	 */
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 802fc15b0d73..4a725379d761 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -74,7 +74,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>   				gfp_flags | __GFP_NOWARN);
>   	if (selem) {
>   		if (value)
> -			memcpy(SDATA(selem)->data, value, smap->map.value_size);
> +			copy_map_value(&smap->map, SDATA(selem)->data, value);
> +		/* No call to check_and_init_map_value as memory is zero init */
>   		return selem;
>   	}
>   
> @@ -92,12 +93,27 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
>   	kfree_rcu(local_storage, rcu);
>   }
>   
> +static void check_and_free_fields(struct bpf_local_storage_elem *selem)
> +{
> +	if (map_value_has_kptrs(selem->map))

could SDATA(selem)->smap->map be used here ?

> +		bpf_map_free_kptrs(selem->map, SDATA(selem));
> +}
> +
>   static void bpf_selem_free_rcu(struct rcu_head *rcu)
>   {
>   	struct bpf_local_storage_elem *selem;
>   
>   	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> -	kfree_rcu(selem, rcu);
> +	check_and_free_fields(selem);
> +	kfree(selem);
> +}
> +
> +static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_local_storage_elem *selem;
> +
> +	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
> +	call_rcu(&selem->rcu, bpf_selem_free_rcu);
>   }
>   
>   /* local_storage->lock must be held and selem->local_storage == local_storage.
> @@ -150,10 +166,11 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
>   	    SDATA(selem))
>   		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
>   
> +	selem->map = &smap->map;
>   	if (use_trace_rcu)
> -		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> +		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
>   	else
> -		kfree_rcu(selem, rcu);
> +		call_rcu(&selem->rcu, bpf_selem_free_rcu);
>   

