Return-Path: <bpf+bounces-11741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10247BE701
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 18:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B95F281A5D
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1A1C693;
	Mon,  9 Oct 2023 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwjxZ1kz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7410A1E
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 16:51:38 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9597F92
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 09:51:36 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso3162691b3a.2
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696870296; x=1697475096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoVvS5aTpmgzM3CgSvcww3KK8a1y4W0NXCISlBNyW4M=;
        b=jwjxZ1kzdDpkMGKrHFXHM0nX2b58jWHYIDr8pqAs6IxwsX+0T01R4K/XAPFznF6F1V
         dNCz5phQsCe8IoK0au7oXhnvGkbA2nhQflP4Vw1G9RqblFWa7EmkBhOwIWWS2LY9WP1K
         UsdiR1D/gdtGt4ORsC78vzfHQT/gZMkICRGPUs/Wi9kLnng0aZEqAjPOull18bWPEWva
         ciWNlicHQ3NpW9zxK1WPgfi53lEQ8rYjiqVHSNqmhZVs+h0iDQkakrsJyRpRSjK+xTFg
         ya0lzJRmlqQkIVKfAPm59xdxM7l44hbjdrG1c3OqLFgQ0GGCbnbvYI0HmBKBtfFaFFZj
         xxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696870296; x=1697475096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoVvS5aTpmgzM3CgSvcww3KK8a1y4W0NXCISlBNyW4M=;
        b=JEsJTzr6PPeXYn+gCdQaw/EWILEPYBSZ0LX54pGPyA2BSw1xh9o17MQ5qXEpnY78X3
         JDurnh7gF5T9jwZwKdqDx5QpvlzBWfTwI/594Mk9+2sdbehq3aLG6GhVbPlosGjJWJq0
         cFM3JaYGjSY0Nea2nSvAt23Z0bYzEgDh75gz0QbOcBMnCoLY+qYnkrxVFk2i9j1P8eXt
         c2plMZK45OCfEcoBMEzTIl52GNG3zLiqMJzMekG5d0bCONVqOx0Q5Cxr6fSuSg3hQfox
         ct30ayVupJ2C6MFMv/389XzJqSGfS37IyjU6B3VINWtKN+fELqDF85jAe+a/nXdpoF53
         XF6w==
X-Gm-Message-State: AOJu0YxkDIjQ4BpTWRdgIUMu1ZqIPoZ6MwxBExQrA+0A0a7WlILDhWdM
	yz0QeRChPBMQitezqf8wL+o=
X-Google-Smtp-Source: AGHT+IFm9S+x41mCOTxe0jaj3TZGFxnBlagrj/PVjtNv0mmEckhtnIt64aTztKWitTsXQoqeTpWfhQ==
X-Received: by 2002:a05:6a00:3a1f:b0:690:d620:7804 with SMTP id fj31-20020a056a003a1f00b00690d6207804mr15428631pfb.13.1696870295704;
        Mon, 09 Oct 2023 09:51:35 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:85e9])
        by smtp.gmail.com with ESMTPSA id y3-20020a62b503000000b00692b7011349sm6642183pfe.188.2023.10.09.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:51:35 -0700 (PDT)
Date: Mon, 9 Oct 2023 09:51:31 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 2/6] bpf: Re-enable unit_size checking for
 global per-cpu allocator
Message-ID: <20231009165131.coaxglwfgrjninod@MacBook-Pro-49.local>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
 <20231007135106.3031284-3-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007135106.3031284-3-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 09:51:02PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> With alloc_size_percpu() in place, check whether or not the size of
> the dynamic per-cpu area is matched with unit_size.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/memalloc.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 6cf61ea55c27..af9ff0755959 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -497,21 +497,17 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
>  	struct llist_node *first;
>  	unsigned int obj_size;
>  
> -	/* For per-cpu allocator, the size of free objects in free list doesn't
> -	 * match with unit_size and now there is no way to get the size of
> -	 * per-cpu pointer saved in free object, so just skip the checking.
> -	 */
> -	if (c->percpu_size)
> -		return 0;
> -
>  	first = c->free_llist.first;
>  	if (!first)
>  		return 0;
>  
> -	obj_size = ksize(first);
> +	if (c->percpu_size)
> +		obj_size = alloc_size_percpu(((void **)first)[1]);
> +	else
> +		obj_size = ksize(first);
>  	if (obj_size != c->unit_size) {
> -		WARN_ONCE(1, "bpf_mem_cache[%u]: unexpected object size %u, expect %u\n",
> -			  idx, obj_size, c->unit_size);
> +		WARN_ONCE(1, "bpf_mem_cache[%u]: percpu %d, unexpected object size %u, expect %u\n",
> +			  idx, c->percpu_size, obj_size, c->unit_size);
>  		return -EINVAL;
>  	}
>  	return 0;
> @@ -979,7 +975,14 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
>  	return !ret ? NULL : ret + LLIST_NODE_SZ;
>  }
>  
> -/* Most of the logic is taken from setup_kmalloc_cache_index_table() */
> +/* The alignment of dynamic per-cpu area is 8 and c->unit_size and the
> + * actual size of dynamic per-cpu area will always be matched, so there is
> + * no need to adjust size_index for per-cpu allocation. However for the
> + * simplicity of the implementation, use an unified size_index for both
> + * kmalloc and per-cpu allocation.
> + *
> + * Most of the logic is taken from setup_kmalloc_cache_index_table().

Since this logic is removed in bpf tree you probably need to wait for
bpf tree to get merged into bpf-next before respinning to avoid conflicts.

