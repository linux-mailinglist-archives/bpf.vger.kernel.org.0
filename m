Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45ED60BD58
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 00:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJXW2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 18:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJXW2C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 18:28:02 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FE32B76A0
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 13:49:37 -0700 (PDT)
Message-ID: <48042f36-792d-e8c9-3a9d-feb267a6f74d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666643673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybXKM2XSHiIE7smG7ydZhN0QuNBAdewbwuyAYigIqkU=;
        b=jwSzzLKW69tZEcHlUEL0khYChx96Za8u70DikuK+NRntGsCCWbgOScbUnQSiDiAy7T8sss
        jkEVNOjjzR+I4xmv7l69QdYBlGyjzfQBYOnmKywxMYDu65siorkIr1JcktFcq7sDo3+DR4
        fvz0F2Q6Ypw0jhB3KJ6ZXz4Zr6bSBNk=
Date:   Mon, 24 Oct 2022 13:34:21 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Refactor inode/task/sk storage
 map_{alloc,free}() for reuse
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        bpf@vger.kernel.org
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180524.2859994-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221023180524.2859994-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/23/22 11:05 AM, Yonghong Song wrote
> -void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
> -				int __percpu *busy_counter)
> +static void __bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
> +					 int __percpu *busy_counter)

nit.

This map_free does not look like it requires a separate "__" version since it is 
not reused.  probably just put everything into the bpf_local_storage_map_free() 
instead?

>   {
>   	struct bpf_local_storage_elem *selem;
>   	struct bpf_local_storage_map_bucket *b;
> @@ -613,7 +613,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
>   	return 0;
>   }
>   
> -struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
> +static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_attr *attr)
>   {
>   	struct bpf_local_storage_map *smap;
>   	unsigned int i;
> @@ -663,3 +663,28 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
>   
>   	return 0;
>   }

[ ... ]

> +void bpf_local_storage_map_free(struct bpf_map *map,
> +				struct bpf_local_storage_cache *cache,
> +				int __percpu *busy_counter)
> +{
> +	struct bpf_local_storage_map *smap;
> +
> +	smap = (struct bpf_local_storage_map *)map;
> +	bpf_local_storage_cache_idx_free(cache, smap->cache_idx);
> +	__bpf_local_storage_map_free(smap, busy_counter);
> +}

