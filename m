Return-Path: <bpf+bounces-64862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F1B17AB3
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 03:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE65C1C27F1A
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A462AE72;
	Fri,  1 Aug 2025 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j22yoF36"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC020326
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754010368; cv=none; b=bXLDtVo7aCnR79Doo0pPwyh1zPQ6TvI6YmfbXrj9sx/mUQomvXPeN1wU1glkcK7DrI+8ePA+WpaWCCoGyGFcNMdzYwe41Au+Yak19sFnf4INeFYlayKk/hRVfgbXUfzpz43XLqr5qCRomNM2AMSOKNU3ht7EBnxNk7R5nCKRDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754010368; c=relaxed/simple;
	bh=CrqopOqnETrha7sxDqw5g7Qbwci0R9pf8ZjfuY374Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL4HT7LY+MDiEGN0v4xF+y4q991Okc+FPkFwdcYJadoIvgJEu3nqmt2xYzAbBTqQFjBtDLyNpWG3udtPtusoCoevi1bN43GFnVtdd+P0xD3iaT7lmN6y0LPY9ARH/Yka+XdPvvssW57exiqT99MjYjbxpSLxQJgyFFd2etmDw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j22yoF36; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd6155cf-f1e0-4d6b-98af-a53c4999c5a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754010351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWnfPBYlK3FgFXB+auPIsaTZOIy8G/auRktChN5Wm1g=;
	b=j22yoF36O7Wl/CWBmjIegSyfMPObwfQUWyL5Alo/iYKLFO7Kj8IDQYfA61MGWRgqI0VcMD
	/BhGqCqX0miqVasDbasMRXhQNSWG6+tu8s4fznPVgYELQYkV/yMuuJWX2OXdv0CrSANp+w
	kt18UwdyFUgHgNNnSmH2frTb37SiMfc=
Date: Thu, 31 Jul 2025 18:05:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v1 01/11] bpf: Convert bpf_selem_unlink_map
 to failable
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, kpsingh@kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, haoluo@google.com,
 kernel-team@meta.com
References: <20250729182550.185356-1-ameryhung@gmail.com>
 <20250729182550.185356-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250729182550.185356-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 11:25 AM, Amery Hung wrote:
> - bpf_local_storage_update()
> 
>    The three step update process: link_map(new_selem),
>    link_storage(new_selem), and unlink_map(old_selem) should not fail in
>    the middle. Hence, lock both b->lock before the update process starts.
> 
>    While locking two different buckets decided by the hash function
>    introduces different locking order, this will not cause ABBA deadlock
>    since this is performed under local_storage->lock.

I am not sure it is always true. e.g. two threads running in different cores can 
do bpf_local_storage_update() for two different sk, then it will be two 
different local_storage->lock.

My current thought is to change the select_bucket() to depend on the owner 
pointer (e.g. *sk, *task...) or the local_storage pointer instead. The intuitive 
thinking is the owner pointer is easier to understand than the local_storage 
pointer. Then the same owner always hash to the same bucket of a map.

I am not sure the owner pointer is always available in the current setup during 
delete. This needs to check. iirc, the current setup is that local_storage->lock 
and bucket lock are not always acquired together. It seems the patch set now 
needs to acquire both of them together if possible. With this, I suspect 
something else can be simplified here and also make the owner pointer available 
during delete (if it is indeed missing in some cases now). Not very sure yet. I 
need a bit more time to take a closer look.

Thanks for working on this! I think it can simplify the local storage.

[ ... ]

> @@ -560,8 +595,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   	struct bpf_local_storage_data *old_sdata = NULL;
>   	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
>   	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map_bucket *b, *old_b;
>   	HLIST_HEAD(old_selem_free_list);
> -	unsigned long flags;
> +	unsigned long flags, b_flags, old_b_flags;
>   	int err;
>   
>   	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
> @@ -645,20 +681,31 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		goto unlock;
>   	}
>   
> +	b = select_bucket(smap, selem);
> +	old_b = old_sdata ? select_bucket(smap, SELEM(old_sdata)) : b;
> +
> +	raw_spin_lock_irqsave(&b->lock, b_flags);
> +	if (b != old_b)
> +		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);

