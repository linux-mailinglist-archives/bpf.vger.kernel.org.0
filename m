Return-Path: <bpf+bounces-51609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02AA3675E
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A041897013
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002981DACA1;
	Fri, 14 Feb 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihm9rd3q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49D1C861D;
	Fri, 14 Feb 2025 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567694; cv=none; b=DBmOALBz2aLXRzSN7XwhHWFcD3Bd1e0XE33PhY4fGLC+cwEuoIOGcKvrWf9CCcAhhMaBcFCXh3udk1VJ+7H+MvQ2X9hvuN0AOZWqfJG7+XZWLDIc7AB/nCrlI2EHQgaBmi9OIU+rLt6A2lPsXKSBxz88SbiwkEeEckFFU13qYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567694; c=relaxed/simple;
	bh=M4I/lVoL2eoEx86tYBWI0HuYLbF+4WaYKyL8MybyfUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u64Sy5TCZIHmEmsCZHcrTd+euQTpweHuIZ6oampPSOMjzeXJ+myPifhKMFNMysIUKKcCZp4/kj21a8O/1TVME3dR7eyfq56vuXnwg2O3NZPDTveBKKLw/SCp6IsRDDKRrRnoisfbR7iMt1xPAGXA1SjuVIbnw1bO4p5sjrpEa1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihm9rd3q; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e53a91756e5so2079257276.1;
        Fri, 14 Feb 2025 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739567692; x=1740172492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNkF78o53Rf+t1jN2LaXRMV13iaPzPVoeIghT/2tY5o=;
        b=ihm9rd3q62RuZo5QptI1CCwLuUxhYmLGI/Vc8lTBgUrx75axUa3HTM7/b+ARLiwHLr
         tffo5xsOkDHKW4i77MjlT+oTlozavJ94D1VcqOc4EolU2XvqWpYd0Hn5kQXRlCv4utul
         3MI14cWpRvg7LygTtLKLhUYf21QOZxeMaZJ4/OdF/AyLyFUsDQA03j+dslt/GeX4mssb
         jPWzcTEvrafDQUwWUkLE8Z9cdI+1CMcNq25umHMnsaIlyS/62wQo4eX8vqbNEHPQ518M
         vh2gnjVOPmOM7Rb1ULbuV65P/1/ijZ0sDa8Y13ypysaqps0fPBt+G6NxJF9hlVmc3Jh0
         /TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739567692; x=1740172492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNkF78o53Rf+t1jN2LaXRMV13iaPzPVoeIghT/2tY5o=;
        b=G7+/ihiqIZB0i+hWav8hUbHIW/Avtamb3ei2z4E9B6HDaRm7ZinXc1DG2Fci/pB4zz
         ql4GoJ7SlGBSoqnuT4aI81mK6QoATBcdDb8pswhTGuPaAOaklJrg77OsbC3ihRjruITu
         cYTeACcAWvU339E1M37nIY+LLq9mJ5MytVITTbgqzkn+fedAc/VLOY+yUxlWOoP/NfGG
         NeuTpIBEpQQJ0fXAnxpeyoUg+JyjinnR0fztcsPlqLaTCStYJjifhY90OsqrkrBR+oLq
         V3ppPsLMRH2KLlZVBECNj15H9KggzCOCXA8fYh90LhLcbqWJNbgJfSLbAmVdCabpHrED
         P7kw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHPEB2g42JaTQK28s8SYDYoUbRdSSrxhn31l6L+rIncx5jrHUO5EjRl1QxnHAowxhHlM=@vger.kernel.org, AJvYcCXgljtrwAzZTq3InCXJCDl/Ljsn/OELoKJi9VwzzZD8Ht+Nx8v0MWTp37dMy0dfP1TGu1nd4NwE5OPLLJxR@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8zG3vTgC713dyd0xn0hZxQ2a44NXgWQfY/PgH+/SvIZX/j7C
	btA4SM+VixxAFnXcI217AzGdQqLHLF63fiJiOvwfXuISaow8gKYN
X-Gm-Gg: ASbGncuQpEdnTCXT+eYYCcSwFtK/3mxmcpd3I2Xp85vdpg1Am57fJDv3+7cNlYB9+YX
	tQX0kdi3voabP6sjkVdv1EZPEIjFBY7M1kxKwXZCRjsA4AziAxwr0dT1jFimbg3rG3TP9V9fbIK
	/4u8TotAvsuC4l73ZiJQnrzsgjCmx2vJgqXld+DZYiVR21ykJhMYJxU29RQDimjdqLacJcfF1G/
	KqRdDM3DU42pp0GTL9aKVFoyJgJL6X1CuZ8wTp7SdaDx9LjTHg9xRhFQ649w90e3KjPupry5iAT
	2F91S4Ss1lcGNi9cMe24DVEZxCCbIxAwqJMhTpasb1ExEBDmJTE=
X-Google-Smtp-Source: AGHT+IHMvCvabfR3FD3eCjD9f/3m5EJVslz8OaZYJZDPQv5zcb5zDlnx+fqTiQggr3kQh3rsAgFyLQ==
X-Received: by 2002:a05:6902:330e:b0:e58:3b:7ee8 with SMTP id 3f1490d57ef6-e5dc91f557emr720004276.35.1739567691749;
        Fri, 14 Feb 2025 13:14:51 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae0da261sm1237795276.37.2025.02.14.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:14:50 -0800 (PST)
Date: Fri, 14 Feb 2025 16:14:49 -0500
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
Subject: Re: [PATCH 3/8] mm/numa: Introduce nearest_node_nodemask()
Message-ID: <Z6-ySS7go_dXl5gM@thinkpad>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214194134.658939-4-arighi@nvidia.com>

On Fri, Feb 14, 2025 at 08:40:02PM +0100, Andrea Righi wrote:
> Introduce the new helper nearest_node_nodemask() to find the closest
> node in a specified nodemask from a given starting node.
> 
> Returns MAX_NUMNODES if no node is found.
> 
> Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>

> ---
>  include/linux/numa.h |  7 +++++++
>  mm/mempolicy.c       | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
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
> index 162407fbf2bc7..488cad280efb3 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -196,6 +196,37 @@ int numa_nearest_node(int node, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(numa_nearest_node);
>  
> +/**
> + * nearest_node_nodemask - Find the node in @mask at the nearest distance
> + *			   from @node.
> + *
> + * @node: a valid node ID to start the search from.
> + * @mask: a pointer to a nodemask representing the allowed nodes.
> + *
> + * This function iterates over all nodes in @mask and calculates the
> + * distance from the starting @node, then it returns the node ID that is
> + * the closest to @node, or MAX_NUMNODES if no node is found.
> + *
> + * Note that @node must be a valid node ID usable with node_distance(),
> + * providing an invalid node ID (e.g., NUMA_NO_NODE) may result in crashes
> + * or unexpected behavior.
> + */
> +int nearest_node_nodemask(int node, nodemask_t *mask)
> +{
> +	int dist, n, min_dist = INT_MAX, min_node = MAX_NUMNODES;
> +
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

