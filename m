Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387BE5B0CCE
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiIGTAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIGTAb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 15:00:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F861709
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 12:00:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j12so3101271pfi.11
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vShWjqwKKYv+Eh/uP511PnH8W308/KI8IGjvS6Qbg6M=;
        b=QhsW3BTryU8S1n0eWB4eMPx51SV1V5Bg8Hhk+8Hw816WcuzHQZ1UhcKyfLsRrnsN6F
         WaR6TFIHf8B4GU7g/2RB5Em3BB27M+UDvivNpCVIR9xMGQpMvVrQS7rbpaVc4dD+/G68
         0viLNXGtR6314TRAwoh6s71Tvan5Gm6VRidlMZb1j7Bs3i+ZoWEpCrhOEpa2oAD7d7vE
         SE05VMvXCWpWNpQa82d3JnOq/rKlT6ejvJ+b/IXDd+nww0203xjEeSR7dkotm7LiLOiP
         il02LNuPHIaZZpbdiohLpSsovk7nwW7QO0yU+BaT5wk4AXSsntBJmAXaGdAK1Pwdc47z
         xlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vShWjqwKKYv+Eh/uP511PnH8W308/KI8IGjvS6Qbg6M=;
        b=NwQkGdwlSunXVUWy4hiwEFypWVDW2rUs4IEHCNX39hZaAm446UnnLZUw50fftXzt4y
         WsdyH6tv/QJMqgRTU4vMIo+MeZouqs3idl+STaBFutSOFfEhqgxT6daNrCAbAqIeIT9T
         dAXdZI9R+yMq3vLdrnIXnWdDYMNKUuS90JqKipqCEo6MV37f7cIedGr/y7uivF/LtxIB
         9EtYRyW3HAd15wbSBngnTsHRnHL+1Elx2NYjvMb4Gv972++5KUVfjaEjaa/t/k04OHUs
         yBVrtwIGO7eV72uaB1n1rmMEOQ68g6Wv4aFgTmLxhxoUUq6YSTmYhnsqWipKl78ZpKS+
         meyA==
X-Gm-Message-State: ACgBeo2zdZB0e1CKKKgnfs0VfM4gpkIzRxE+hp2+Qa6alL1q9FNDKO/Q
        NoAUqZU1WB7hQ2gs5USAUvE=
X-Google-Smtp-Source: AA6agR4Ebt3Ikvl+qI1sZprlJC8446tT0eVcmN76SJJku2qOa/KYCzRzW35fgjN/e/aXw+L0YSuBeQ==
X-Received: by 2002:a63:1a23:0:b0:434:4395:8b5a with SMTP id a35-20020a631a23000000b0043443958b5amr4450576pga.428.1662577227253;
        Wed, 07 Sep 2022 12:00:27 -0700 (PDT)
Received: from MacBook-Pro-4.local ([2620:10d:c090:500::2:ae03])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b0016c78f9f024sm12879928plh.104.2022.09.07.12.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 12:00:26 -0700 (PDT)
Date:   Wed, 7 Sep 2022 12:00:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next v1 05/32] bpf: Support kptrs in local
 storage maps
Message-ID: <20220907190023.x6syddvu2xgxb47d@MacBook-Pro-4.local>
References: <20220904204145.3089-1-memxor@gmail.com>
 <20220904204145.3089-6-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904204145.3089-6-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 04, 2022 at 10:41:18PM +0200, Kumar Kartikeya Dwivedi wrote:
> Enable support for kptrs in local storage maps by wiring up the freeing
> of these kptrs from map value.
> 
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_local_storage.h |  2 +-
>  kernel/bpf/bpf_local_storage.c    | 33 +++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c              |  5 ++++-
>  kernel/bpf/verifier.c             |  9 ++++++---
>  4 files changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 7ea18d4da84b..6786d00f004e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -74,7 +74,7 @@ struct bpf_local_storage_elem {
>  	struct hlist_node snode;	/* Linked to bpf_local_storage */
>  	struct bpf_local_storage __rcu *local_storage;
>  	struct rcu_head rcu;
> -	/* 8 bytes hole */
> +	struct bpf_map *map;		/* Only set for bpf_selem_free_rcu */
>  	/* The data is stored in another cacheline to minimize
>  	 * the number of cachelines access during a cache hit.
>  	 */
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 802fc15b0d73..4a725379d761 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -74,7 +74,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>  				gfp_flags | __GFP_NOWARN);
>  	if (selem) {
>  		if (value)
> -			memcpy(SDATA(selem)->data, value, smap->map.value_size);
> +			copy_map_value(&smap->map, SDATA(selem)->data, value);
> +		/* No call to check_and_init_map_value as memory is zero init */
>  		return selem;
>  	}
>  
> @@ -92,12 +93,27 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
>  	kfree_rcu(local_storage, rcu);
>  }
>  
> +static void check_and_free_fields(struct bpf_local_storage_elem *selem)
> +{
> +	if (map_value_has_kptrs(selem->map))
> +		bpf_map_free_kptrs(selem->map, SDATA(selem));
> +}
> +
>  static void bpf_selem_free_rcu(struct rcu_head *rcu)
>  {
>  	struct bpf_local_storage_elem *selem;
>  
>  	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
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
>  }
>  
>  /* local_storage->lock must be held and selem->local_storage == local_storage.
> @@ -150,10 +166,11 @@ bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
>  	    SDATA(selem))
>  		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
>  
> +	selem->map = &smap->map;
>  	if (use_trace_rcu)
> -		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> +		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
>  	else
> -		kfree_rcu(selem, rcu);
> +		call_rcu(&selem->rcu, bpf_selem_free_rcu);
>  
>  	return free_local_storage;
>  }
> @@ -581,6 +598,14 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
>  	 */
>  	synchronize_rcu();
>  
> +	/* When local storage map has kptrs, the call_rcu callback accesses
> +	 * kptr_off_tab, hence we need the bpf_selem_free_rcu callbacks to
> +	 * finish before we free it.
> +	 */
> +	if (map_value_has_kptrs(&smap->map)) {
> +		rcu_barrier();
> +		bpf_map_free_kptr_off_tab(&smap->map);

probably needs conditional rcu_barrier_tasks_trace before rcu_barrier?
With or without it will be a significant delay in map freeing.
Maybe we should generalize the destroy_mem_alloc trick?

Patch 4 needs rebase. Applied patches 1-3.
The first 5 look great to me.
Pls follow up with kptr specific tests.
