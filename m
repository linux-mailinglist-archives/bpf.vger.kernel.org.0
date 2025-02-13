Return-Path: <bpf+bounces-51424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FBA348A7
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D7A7A2CE8
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB41FF7D8;
	Thu, 13 Feb 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn5UZ2HR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E481CBEAA;
	Thu, 13 Feb 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462224; cv=none; b=Dp5yxJhqwCJLq357vUBXID5/EsIOCU1aPqdQ4Q2g4Axh1uD7KEk3qn1vz2yfYbtF1xagdOtDZHYY5run0uy5nngOSZnmQOy5+FbvnLJOj/45+gO/Ra/1c+rezgIaL7jZ3l4RlwkH2s5WLjphWtpdtMOjbeAnUqzjBBm+/OukD20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462224; c=relaxed/simple;
	bh=cBm8E2914VzAHMZ8ogqZSZpZL9ZAUgPj7fnvbzRswdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwGQwbnkcMhi0xXLcl4WO/rTuCUo7pKGxd7SgGhqvs8xomZiRwGFJm9UKTPZ+PMh2UFe5/XHEaFbizcfywm7ekyDMr6RrtJ9xss5lqXHxI0MUNLPfuIqpcoM/4iNYMuKiwYBdGByc2BotCX5qrvq51pcftkZmPa5Qd9KDJuO1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn5UZ2HR; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e5b4d615267so983136276.1;
        Thu, 13 Feb 2025 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462222; x=1740067022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+dPvYM5vk28MOdXzpWuLmCNL3UisM+9AWN/i9i4bBU=;
        b=nn5UZ2HRQKANrQtbS2IW9oWwxi+2qiL6ZnCYNwQfSqPu32R4niCMm6BdDA4ytjLcJp
         3tId4L11/SKpZ4mZUvZ92owSGZknWInqpl02PMYxS+v1d77ab8iESSDXCxUP1JqR+pMj
         SiTenTbWsr4vWUlBiUzfsX3GnK3QnokIIG0+mrtetw09BPosLBpjRKSg6hIx5r1Dv4md
         uzZe2jZcpEypxFQXKMzP1bUXHbzhaHXnbp1ON/IE+fObIG1j8AxahzThi/ZdZgomdwuw
         tiGVNrpZBXIDjczvFPmrVC+CAXAwOeku5jZVJnjUniXCqL2hPIbP7Ob0Hzv4DwCAifx4
         K5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462222; x=1740067022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+dPvYM5vk28MOdXzpWuLmCNL3UisM+9AWN/i9i4bBU=;
        b=iJpyPgyCa8RJY41OUWUrXeMQdYRBLIHfCobuOqrFP7JXQ77A1ZzuvPCAkqEtYL3jkb
         o/ibmHH0UI1HfUEruyoxy1jbyr4Cc96ijsS3T0lsDcSB87HKyO3tPKiYBGSH29YRhoTn
         dUNe9m/l9LeFkZozIFLtBZ7XABI1qGz2W2mI3aVcA/dBWkfAP75lyAZr7fDAIoFZgwSL
         Bf52bAfHNZlzR97+bTBS+ksyRdOc81p13TbaVC5mG91tOXzJzej0d2fJX+wZDVdBAM+3
         F2K/411w/NwLdgo7jIJsY733mSgr1j4vkn5sSKY+YGkw0DRIbiKfxOHsc0LxdKEr/6yK
         6iOg==
X-Forwarded-Encrypted: i=1; AJvYcCVeiy06jYn+OTL+JID3rkvGNrrnugROebNVm18rYId5GaOzTPmGKBCfAB/lOtnyPK0fi0wuLGXBjoaKLLji@vger.kernel.org, AJvYcCVjapJ4739CML3nK2FRtxwb4XIlFbs4CK+kQhL6tfB8t4RCfXe8oRrzHvEBGPpziDq/0aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUqclvvByLc7rSHg0sQausMSjR7bCQiUsWPocXbx+eWd14NOEj
	M2Oh8Rg7vADCBZn+kXVSYJeJnT+TNvV/D+qHlQ4H4D3GPCHqW0mZ
X-Gm-Gg: ASbGnctFlapOlXEpmrl/h0D+iMbzgK2Aqfp4OS+VBz0hTXgDpVapDJtXM3tlOkIPhXG
	neqR6yarulz/LNC3JNODCi87i5j0lZXAZr5L0GOanXiQW1RSo2DZsv/57b21b+zgN4zGBEsafX1
	b/EC5+O6dk1jRSl3r3PgQ4okbzZMUaaW+xbxAhP5xg7VeYNQ6izsL/mCwy9Y1cycmzMhnOGc8Vw
	9OJqja8KinXsW9SOFJcuZCMkF3FkpmDJzbeC4yHeZEHYDit9SiRl1Nbj/2rcnZUH4BBYSshRGAf
	SOHVPZ7L0DxfqY05PpScHb5v3ZO9jfUrfxJY1edniDvXsG/AoaQ=
X-Google-Smtp-Source: AGHT+IEeYMhP4bSR4OlKscJaH4K6RzVGBSX69AXSd0t7aKbGhaqDl/xdChOwDn25nvtNqrZ/0ikXEQ==
X-Received: by 2002:a05:6902:1508:b0:e57:caaa:fe60 with SMTP id 3f1490d57ef6-e5d9f17924emr6558672276.30.1739462221892;
        Thu, 13 Feb 2025 07:57:01 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35d586e5sm3514177b3.17.2025.02.13.07.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:57:01 -0800 (PST)
Date: Thu, 13 Feb 2025 10:57:00 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/numa: Introduce nearest_node_nodemask()
Message-ID: <Z64WTLPaSxixbE2q@thinkpad>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212165006.490130-3-arighi@nvidia.com>

On Wed, Feb 12, 2025 at 05:48:09PM +0100, Andrea Righi wrote:
> Introduce the new helper nearest_node_nodemask() to find the closest
> node in a specified nodemask from a given starting node.
> 
> Returns MAX_NUMNODES if no node is found.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  include/linux/numa.h |  7 +++++++
>  mm/mempolicy.c       | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 31d8bf8a951a7..e6baaf6051bcf 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -31,6 +31,8 @@ void __init alloc_offline_node_data(int nid);
>  /* Generic implementation available */
>  int numa_nearest_node(int node, unsigned int state);
>  
> +int nearest_node_nodemask(int node, nodemask_t *mask);
> +

See how you use it. It looks a bit inconsistent to the other functions:

  #define for_each_node_numadist(node, unvisited)                                \
         for (int start = (node),                                                \
              node = nearest_node_nodemask((start), &(unvisited));               \
              node < MAX_NUMNODES;                                               \
              node_clear(node, (unvisited)),                                     \
              node = nearest_node_nodemask((start), &(unvisited)))
  

I would suggest to make it aligned with the rest of the API:

  #define node_clear(node, dst) __node_clear((node), &(dst))
  static __always_inline void __node_clear(int node, volatile nodemask_t *dstp)
  {
          clear_bit(node, dstp->bits);
  }

>  #ifndef memory_add_physaddr_to_nid
>  int memory_add_physaddr_to_nid(u64 start);
>  #endif
> @@ -47,6 +49,11 @@ static inline int numa_nearest_node(int node, unsigned int state)
>  	return NUMA_NO_NODE;
>  }
>  
> +static inline int nearest_node_nodemask(int node, nodemask_t *mask)
> +{
> +	return NUMA_NO_NODE;
> +}
> +
>  static inline int memory_add_physaddr_to_nid(u64 start)
>  {
>  	return 0;
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 162407fbf2bc7..1e2acf187ea3a 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -196,6 +196,38 @@ int numa_nearest_node(int node, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(numa_nearest_node);
>  
> +/**
> + * nearest_node_nodemask - Find the node in @mask at the nearest distance
> + *			   from @node.
> + *
> + * @node: the node to start the search from.
> + * @mask: a pointer to a nodemask representing the allowed nodes.
> + *
> + * This function iterates over all nodes in the given state and calculates
> + * the distance to the starting node.
> + *
> + * Returns the node ID in @mask that is the closest in terms of distance
> + * from @node, or MAX_NUMNODES if no node is found.
> + */
> +int nearest_node_nodemask(int node, nodemask_t *mask)
> +{
> +	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
> +
> +	if (node == NUMA_NO_NODE)
> +		return MAX_NUMNODES;

This makes it unclear: you make it legal to pass NUMA_NO_NODE, but
your function returns something useless. I don't think it would help
users in any reasonable scenario.

So, if you don't want user to call this with node == NUMA_NO_NODE,
just describe it in comment on top of the function. Otherwise, please
do something useful like 

	if (node == NUMA_NO_NODE)
		node = current_node;

I would go with option 1. Notice, node_distance() doesn't bother to
check against NUMA_NO_NODE.

> +	for_each_node_mask(n, *mask) {
> +		dist = node_distance(node, n);
> +		if (dist < min_dist) {
> +			min_dist = dist;
> +			min_node = n;
> +		}
> +	}
> +
> +	return min_node;
> +}
> +EXPORT_SYMBOL_GPL(nearest_node_nodemask);
> +
>  struct mempolicy *get_task_policy(struct task_struct *p)
>  {
>  	struct mempolicy *pol = p->mempolicy;
> -- 
> 2.48.1

