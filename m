Return-Path: <bpf+bounces-44682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A079C6526
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE511F21445
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4AB21CFA1;
	Tue, 12 Nov 2024 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIFZlYOh"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38821A710
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454016; cv=none; b=elU8iXklL9/9RgrnauIumhggkBzImHmSv8jOX1vW4AaWknvVQM24nnO6KtGoJFmVp/Vam3eWVNOt5g8C+IwW/jG+EzctAFgoQqBo0O2ub8M8hyP7FlrGSwDeGQB8bTszfG4b7E8ZMtFll6XwnW6vWzX5aFlCXqZz3szED7NlNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454016; c=relaxed/simple;
	bh=8kMaQixG7RxCy4KI4oHAOvzbh9jRezSBR49xHjKZYbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCv7GmKh7lTZ8XKEYP2SJA1IfwpJ2Lg2TwtbpJbnVDhYNJ5AT1LMix2gzNZDrKauBGwn+qFM8Mzn/KP+0CWAscnsHre+p1ywkdI+cZDXB2iNdnthtvPoY4OeGxTlRZyapCXKmYbSGC6p9f1RE5xCMH+o+6568soko5yrd4l/CFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIFZlYOh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2239508-6d00-4176-b0d6-3e07e06a367f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731454012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2S8Z8cF1RQIyQ6StHC2v3AQfecASJCXdndvixzbj32M=;
	b=fIFZlYOhSL9R8UhiJvythCYpiTEQLGqSsgbJ39dznH74qaXM4yVllETK51FLpKWYHnnhlA
	kH3pJTP7wTAwJ41LHtYdD/O2W7OdtkslYnXaUXALZ+o+0J171G+UebRSjg+0Xm2R/IK/wT
	OEjAg+OnhMderQoxShHiJRuGqpuBoAM=
Date: Tue, 12 Nov 2024 15:26:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Add recursion prevention logic for
 inode storage
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
 josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
References: <20241112083700.356299-1-song@kernel.org>
 <20241112083700.356299-4-song@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241112083700.356299-4-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/12/24 12:36 AM, Song Liu wrote:
> +static void *__bpf_inode_storage_get(struct bpf_map *map, struct inode *inode,
> +				     void *value, u64 flags, gfp_t gfp_flags, bool nobusy)
>   {
>   	struct bpf_local_storage_data *sdata;
>   
> -	WARN_ON_ONCE(!bpf_rcu_lock_held());
> -	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
> -		return (unsigned long)NULL;
> -
> +	/* explicitly check that the inode not NULL */
>   	if (!inode)
> -		return (unsigned long)NULL;
> +		return NULL;
>   
>   	sdata = inode_storage_lookup(inode, map, true);

s/true/nobusy/

>   	if (sdata)
> -		return (unsigned long)sdata->data;
> +		return sdata->data;
>   
> -	/* This helper must only called from where the inode is guaranteed
> -	 * to have a refcount and cannot be freed.
> -	 */
> -	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
> +	/* only allocate new storage, when the inode is refcounted */
> +	if (atomic_read(&inode->i_count) &&
> +	    flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {

	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {

>   		sdata = bpf_local_storage_update(
>   			inode, (struct bpf_local_storage_map *)map, value,
>   			BPF_NOEXIST, false, gfp_flags);
> -		return IS_ERR(sdata) ? (unsigned long)NULL :
> -					     (unsigned long)sdata->data;
> +		return IS_ERR(sdata) ? NULL : sdata->data;
>   	}
>   
> -	return (unsigned long)NULL;
> +	return NULL;
> +}

