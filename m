Return-Path: <bpf+bounces-60930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CEADEE59
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D68F1BC20A0
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F6E2EA485;
	Wed, 18 Jun 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAIQJun/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50B2857C4;
	Wed, 18 Jun 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254652; cv=none; b=ahbZuILNNZM0JYPGWPKdx/JIOjA7hDu8vY9u0cyusGo/hSuFu/Oio/h6BH0pAIuXmByt29K6EWXOe41IafPV+JtAW5Z3fIBpwG7Vdf1AhbGgiZWkNQFeVWcrFhXnGbWn3s3ri591QaLLpI2MS9TKdJDEdWdF/2sz22ezYcy8MY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254652; c=relaxed/simple;
	bh=bukcGgXTSDO/e8rPHVLKtt6g7mYtQduIVpUDlFNCEj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU/RFVf0HmFyxKXLrvpZHWblIq5/jAKKe0RrMlu2roYGdG6R5DVsk/T/Sie1j3ZGqIx9keqy2RJUkQOTqbs3Dk3DvNF9m6PgY1GWozAvvIj/I/xdpz2XFTqRTP9qgM5RAp4VgCa38DD/t1e6+OMJnKQe+lIV+qN8DkzRMDFqXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAIQJun/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cfb79177so42758055e9.0;
        Wed, 18 Jun 2025 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750254649; x=1750859449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr8WmSd9sUfiUxB1POv/LkCbyv3gD/cR48sUAkAhzc0=;
        b=gAIQJun/CshJJCPk5OXFyf5PGoVooyZdXEccrt8nRDe5FwrqppvV4Id/2uH5GlnUrv
         NV8mAeCMKCUg3RlsyoXcJ6hrsxyKy+flCjdxF8fCce5RLL0ksw4cBkeKa3nV5aIEcrbg
         43GEc6UkhBgnpa0Yr/N2ZfGJqJVRCGl5rb6LWszEymivRV7gksNhXpCGVdsbk0mBYOLV
         12L++6glEqUCarpD4Mq4DXnGc9+2ygtf4lrXUVNfJiWxUz5cfmXZsapqoyD3WFINwPQT
         Yf5bR4Chfo0FgtoHS8PLkj+dj1xSxdFvSgsnA6Ufpusgow5qK2eAvLGg7BOGiWrv3KFe
         NCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254649; x=1750859449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr8WmSd9sUfiUxB1POv/LkCbyv3gD/cR48sUAkAhzc0=;
        b=aOhidM41u4GEC5eDXX62J463Ac6RdRNBn4VBx8ncy1ksBtKLrSCzcpr5/0r7wxsnOS
         OcA3evK4RGeX7Cyb/gLqQ6IdecR66+HiWAaxg55bEob+slu3zj5hOIu+2v6lyqZVVdWU
         bd40sNb1K/hPN4Nn+heSyk8T1NW1qioTqkfKrbKcxZ/BmOt5MA7dpKw/IcRVehLjJLTy
         yNtAIX2/fMb3+DQG+iZudrPoToU3TEH3PfmGOkaTLmUvzVH3LVm5jVrYn8RoXKDt5sru
         THZYh20PNhKsRYii9gKlgz5Hzyq06G7grmuZoX5wLEmosvHrJYojQ6gCZXgd/piGkYnV
         x/ew==
X-Forwarded-Encrypted: i=1; AJvYcCUOC40IxZEsKz7PZXUSrm3y6uvRCpPPJWt2zB/uIqAggYDRGeltVjuHtoksFaRnGS/NAsB/+3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt4emkWQh6PfR0COC4P+EpK5YByC2nr6dhoMvrX6jTRT8hlXUI
	rtaBn0cSnDRM5pCFjrvZ7ftl7vtBjbCyT3GjPO5e4cxB1/imSToEZPaw
X-Gm-Gg: ASbGncuudPUwPHNBiXw+5dOFWVMvomrJwKpFyh4a0ilXxYstelQBCqh6XM6d+NkTo76
	bL7SrEkVSKXbAgkTsmPbL1jUQ0ixhh1IB091k71Wewx8KNGMTfmLyJdPR106+s/4X7crIoKPdjG
	U+OajcihfYZUpQj+iOwW11Ewzi6MSuQkdPJGAB0EwBRDb+uGEs7/La99+AbtRs4dKbrr+ltAMlT
	YFOfNAfDMGUQ6Bwnzf0I/zU6awIPg/UILTQQniGpf8DGfWK41GShIxSXrYw0GT6vdi10yFQfyYg
	bHO+T28IoEhDjiTrRJb/egpQ3C+ayuOZkKCUXDjUF9CAcnfSDqwoNfklWdZ+7+Dow2lg4+VFUgR
	ssDhHaFZB
X-Google-Smtp-Source: AGHT+IHx8sHdY127xlk2pl7NjC2AywpnMcHzjS3RL7k975UqA+BEKOkn+TyohOiep3DcJqg7VrIDRQ==
X-Received: by 2002:a05:600c:1c12:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-4533ca8b101mr170359095e9.11.1750254648765;
        Wed, 18 Jun 2025 06:50:48 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a800d9sm16809708f8f.45.2025.06.18.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 06:50:48 -0700 (PDT)
Date: Wed, 18 Jun 2025 13:56:32 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	martin.lau@linux.dev, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH bpf-next] bpf: lru: adjust free target to avoid global
 table starvation
Message-ID: <aFLFkFpQP789M1Tx@mail.gmail.com>
References: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>

On 25/06/16 10:38AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
> map is full, due to percpu reservations and force shrink before
> neighbor stealing. Once a CPU is unable to borrow from the global map,
> it will once steal one elem from a neighbor and after that each time
> flush this one element to the global list and immediately recycle it.
> 
> Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
> with 79 CPUs. CPU 79 will observe this behavior even while its
> neighbors hold 78 * 127 + 1 * 15 == 9921 free elements (99%).
> 
> CPUs need not be active concurrently. The issue can appear with
> affinity migration, e.g., irqbalance. Each CPU can reserve and then
> hold onto its 128 elements indefinitely.
> 
> Avoid global list exhaustion by limiting aggregate percpu caches to
> half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count.
> This change has no effect on sufficiently large tables.
> 
> Similar to LOCAL_NR_SCANS and lru->nr_scans, introduce a map variable
> lru->free_target. The extra field fits in a hole in struct bpf_lru.
> The cacheline is already warm where read in the hot path. The field is
> only accessed with the lru lock held.

Hi Willem! The patch looks very reasonable. I've bumbed into this
issue before (see https://lore.kernel.org/bpf/ZJwy478jHkxYNVMc@zh-lab-node-5/)
but didn't follow up, as we typically have large enough LRU maps.

I've tested your patch (with a patched map_tests/map_percpu_stats.c
selftest), works as expected for small maps. E.g., before your patch
map of size 4096 after being updated 2176 times from 32 threads on 32
CPUS contains around 150 elements, after your patch around (expected)
2100 elements.

Tested-by: Anton Protopopov <a.s.protopopov@gmail.com>

> The tests are updated to pass. Test comments are extensive: updating
> those is left for a v2 if the approach is considered ok.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> This suggested approach is a small patch, easy to understand, and
> easy to verity to have no effect on sufficiently sized maps.
> 
> Global table exhaustion can be mitigated in other ways besides or
> alongside this approach:
> 
> Grow the map.
>   The most obvious approach, but increases memory use. And requires
>   users to know map implementation details to choose a right size.
> 
> Round up map size.
>   As htab_map_alloc does for the PERCPU variant of this list.
>   Increases memory use, and a conservative strategy still leaves one
>   element per CPU, and thus MRU behavior.
> 
> Steal from neighbors before force shrink.
>   May increase lock contention.
> 
> Steal more than 1 element from neighbor when stealing.
>   For instance, half its list. Requires traversing the entire list.
> 
> Steal from least recently active neighbors.
>   Needs inactive CPU tracking.
> 
> Dynamic target_free: high and low watermarks to double/halve size.
>    I also implemented this. Adjusts to the active CPU count, which may
>    be << NR_CPUS. But it is hard to reason whether or at what level
>    target_free will stabilize.
> ---
>  kernel/bpf/bpf_lru_list.c                  |  9 ++++---
>  kernel/bpf/bpf_lru_list.h                  |  1 +
>  tools/testing/selftests/bpf/test_lru_map.c | 28 ++++++++++++++--------
>  3 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index 3dabdd137d10..2d6e1c98d8ad 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c
> @@ -337,12 +337,12 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
>  				 list) {
>  		__bpf_lru_node_move_to_free(l, node, local_free_list(loc_l),
>  					    BPF_LRU_LOCAL_LIST_T_FREE);
> -		if (++nfree == LOCAL_FREE_TARGET)
> +		if (++nfree == lru->target_free)
>  			break;
>  	}
>  
> -	if (nfree < LOCAL_FREE_TARGET)
> -		__bpf_lru_list_shrink(lru, l, LOCAL_FREE_TARGET - nfree,
> +	if (nfree < lru->target_free)
> +		__bpf_lru_list_shrink(lru, l, lru->target_free - nfree,
>  				      local_free_list(loc_l),
>  				      BPF_LRU_LOCAL_LIST_T_FREE);
>  
> @@ -577,6 +577,9 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
>  		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
>  		buf += elem_size;
>  	}
> +
> +	lru->target_free = clamp((nr_elems / num_possible_cpus()) / 2,
> +				 1, LOCAL_FREE_TARGET);
>  }
>  
>  static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
> diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
> index cbd8d3720c2b..fe2661a58ea9 100644
> --- a/kernel/bpf/bpf_lru_list.h
> +++ b/kernel/bpf/bpf_lru_list.h
> @@ -58,6 +58,7 @@ struct bpf_lru {
>  	del_from_htab_func del_from_htab;
>  	void *del_arg;
>  	unsigned int hash_offset;
> +	unsigned int target_free;
>  	unsigned int nr_scans;
>  	bool percpu;
>  };
> diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
> index fda7589c5023..abb592553394 100644
> --- a/tools/testing/selftests/bpf/test_lru_map.c
> +++ b/tools/testing/selftests/bpf/test_lru_map.c
> @@ -138,6 +138,12 @@ static int sched_next_online(int pid, int *next_to_try)
>  	return ret;
>  }
>  
> +/* inverse of how bpf_common_lru_populate derives target_free from map_size. */
> +static unsigned int __map_size(unsigned int tgt_free)
> +{
> +	return tgt_free * nr_cpus * 2;
> +}
> +
>  /* Size of the LRU map is 2
>   * Add key=1 (+1 key)
>   * Add key=2 (+1 key)
> @@ -257,7 +263,7 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
>  	batch_size = tgt_free / 2;
>  	assert(batch_size * 2 == tgt_free);
>  
> -	map_size = tgt_free + batch_size;
> +	map_size = __map_size(tgt_free) + batch_size;
>  	lru_map_fd = create_map(map_type, map_flags, map_size);
>  	assert(lru_map_fd != -1);
>  
> @@ -267,7 +273,7 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
>  	value[0] = 1234;
>  
>  	/* Insert 1 to tgt_free (+tgt_free keys) */
> -	end_key = 1 + tgt_free;
> +	end_key = 1 + __map_size(tgt_free);
>  	for (key = 1; key < end_key; key++)
>  		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
>  					    BPF_NOEXIST));
> @@ -284,8 +290,8 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
>  	 * => 1+tgt_free/2 to LOCALFREE_TARGET will be
>  	 * removed by LRU
>  	 */
> -	key = 1 + tgt_free;
> -	end_key = key + tgt_free;
> +	key = 1 + __map_size(tgt_free);
> +	end_key = key + __map_size(tgt_free);
>  	for (; key < end_key; key++) {
>  		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
>  					    BPF_NOEXIST));
> @@ -334,7 +340,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
>  	batch_size = tgt_free / 2;
>  	assert(batch_size * 2 == tgt_free);
>  
> -	map_size = tgt_free + batch_size;
> +	map_size = __map_size(tgt_free) + batch_size;
>  	lru_map_fd = create_map(map_type, map_flags, map_size);
>  	assert(lru_map_fd != -1);
>  
> @@ -344,7 +350,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
>  	value[0] = 1234;
>  
>  	/* Insert 1 to tgt_free (+tgt_free keys) */
> -	end_key = 1 + tgt_free;
> +	end_key = 1 + __map_size(tgt_free);
>  	for (key = 1; key < end_key; key++)
>  		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
>  					    BPF_NOEXIST));
> @@ -388,8 +394,9 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
>  	value[0] = 1234;
>  
>  	/* Insert 1+tgt_free to tgt_free*3/2 */
> -	end_key = 1 + tgt_free + batch_size;
> -	for (key = 1 + tgt_free; key < end_key; key++)
> +	key = 1 + __map_size(tgt_free);
> +	end_key = key + batch_size;
> +	for (; key < end_key; key++)
>  		/* These newly added but not referenced keys will be
>  		 * gone during the next LRU shrink.
>  		 */
> @@ -397,7 +404,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
>  					    BPF_NOEXIST));
>  
>  	/* Insert 1+tgt_free*3/2 to  tgt_free*5/2 */
> -	end_key = key + tgt_free;
> +	end_key += __map_size(tgt_free);
>  	for (; key < end_key; key++) {
>  		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
>  					    BPF_NOEXIST));
> @@ -500,7 +507,8 @@ static void test_lru_sanity4(int map_type, int map_flags, unsigned int tgt_free)
>  		lru_map_fd = create_map(map_type, map_flags,
>  					3 * tgt_free * nr_cpus);
>  	else
> -		lru_map_fd = create_map(map_type, map_flags, 3 * tgt_free);
> +		lru_map_fd = create_map(map_type, map_flags,
> +					3 * __map_size(tgt_free));
>  	assert(lru_map_fd != -1);
>  
>  	expected_map_fd = create_map(BPF_MAP_TYPE_HASH, 0,
> -- 
> 2.50.0.rc1.591.g9c95f17f64-goog
> 

