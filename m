Return-Path: <bpf+bounces-14963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74007E9513
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 03:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0EA28121B
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 02:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889E6ABC;
	Mon, 13 Nov 2023 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RdqrXNhF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B34401
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 02:34:43 +0000 (UTC)
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF2310E
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 18:34:40 -0800 (PST)
Message-ID: <07e4414b-3347-49e4-9c19-57d101ccd009@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699842878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa6h/CUHE2/4xq/oTHsz1sOIt5eKXHfEp9nNrtey2TE=;
	b=RdqrXNhFgBOy5cP6zH3orZfAN27buRYPYXT1sRUd6+pf5FQ+PKjForO1g2YoRAdPAKxHrv
	aykoI15YtNd2SHlAxtoA0Tu4UimiQzSD6p8WH63VSTyfWF1ofLoVwQYINNQXn1jXQvb+Ki
	YYfReJHeArgkYMuauY2/5phiJ2yC0jI=
Date: Sun, 12 Nov 2023 21:34:28 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Add missed allocation hint for
 bpf_mem_cache_alloc_flags()
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231111043821.2258513-1-houtao@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231111043821.2258513-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/10/23 8:38 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> bpf_mem_cache_alloc_flags() may call __alloc() directly when there is no
> free object in free list, but it doesn't initialize the allocation hint
> for the returned pointer. It may lead to bad memory dereference when
> freeing the pointer, so fix it by initializing the allocation hint.
>
> Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

LGTM based on my reading of the code. Maybe you could explain
how you found this issue and whether a test case can be constructed
relatively easily to expose this issue?

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/memalloc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 63b909d277d47..6a51cfe4c2d63 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -978,6 +978,8 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
>   		memcg = get_memcg(c);
>   		old_memcg = set_active_memcg(memcg);
>   		ret = __alloc(c, NUMA_NO_NODE, GFP_KERNEL | __GFP_NOWARN | __GFP_ACCOUNT);
> +		if (ret)
> +			*(struct bpf_mem_cache **)ret = c;
>   		set_active_memcg(old_memcg);
>   		mem_cgroup_put(memcg);
>   	}

