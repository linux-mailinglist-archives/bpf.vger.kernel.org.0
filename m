Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82460E8E7
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiJZTVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiJZTVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 15:21:36 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19B7B2A0
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 12:21:34 -0700 (PDT)
Message-ID: <bce0b434-5a6e-3423-4782-8ecb3f87939a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666812093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ftS9/ozKnxpmskv9WMzddUwbsjhsgDhMNfqlxWBjo0=;
        b=LxguddVKpLsaqzqHT9/QKHGSrB9h69XizqvaV2RRr8SU/p0f+fKZznzHnSkDePZ4FjurgY
        j5Vurgcv5liC/VCmyAy1/w3NvlOHascAuJZjVhY4diMJPHioxYGjGLv++gYRSATG68ejcv
        oiNmmTgZfZC6tMXZXWT6d6jpDsoOELE=
Date:   Wed, 26 Oct 2022 12:21:29 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: check max_entries before allocating memory
Content-Language: en-US
To:     Florian Lehner <dev@der-flo.net>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, song@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
References: <20221026085053.76561-1-dev@der-flo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221026085053.76561-1-dev@der-flo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/26/22 1:50 AM, Florian Lehner wrote:
> For maps of type BPF_MAP_TYPE_CPUMAP memory is allocated first before
> checking the max_entries argument. If then max_entries is greater than
> NR_CPUS additional work needs to be done to free allocated memory before
> an error is returned.
> This changes moves the check on max_entries before the allocation
> happens.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>   kernel/bpf/cpumap.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index b5ba34ddd4b6..87e9f89a8140 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -97,29 +97,26 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
>   	    attr->map_flags & ~BPF_F_NUMA_NODE)
>   		return ERR_PTR(-EINVAL);
>   
> +	/* Pre-limit array size based on NR_CPUS, not final CPU check */
> +	if (attr->max_entries > NR_CPUS)
> +		return ERR_PTR(-E2BIG);
> +
>   	cmap = bpf_map_area_alloc(sizeof(*cmap), NUMA_NO_NODE);
>   	if (!cmap)
>   		return ERR_PTR(-ENOMEM);
>   
>   	bpf_map_init_from_attr(&cmap->map, attr);
>   
> -	/* Pre-limit array size based on NR_CPUS, not final CPU check */
> -	if (cmap->map.max_entries > NR_CPUS) {
> -		err = -E2BIG;
> -		goto free_cmap;
> -	}
> -
>   	/* Alloc array for possible remote "destination" CPUs */
>   	cmap->cpu_map = bpf_map_area_alloc(cmap->map.max_entries *
>   					   sizeof(struct bpf_cpu_map_entry *),
>   					   cmap->map.numa_node);
> -	if (!cmap->cpu_map)
> -		goto free_cmap;
> +	if (!cmap->cpu_map) {
> +		bpf_map_area_free(cmap);
> +		return ERR_PTR(err);

lgtm.  May as well take this chance to remove the "err" variable and directly 
return ERR_PTR(-ENOMEM) instead.

> +	}
>   
>   	return &cmap->map;
> -free_cmap:
> -	bpf_map_area_free(cmap);
> -	return ERR_PTR(err);
>   }
>   
>   static void get_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)

