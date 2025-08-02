Return-Path: <bpf+bounces-64950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDC7B18A11
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 03:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D191C83D2A
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 01:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586117996;
	Sat,  2 Aug 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V2BoBhr0"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CD8F58
	for <bpf@vger.kernel.org>; Sat,  2 Aug 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754097344; cv=none; b=ZMDrsSc+sohsDV2jZlT5URHSKBuNWJ47Qi4oevOFQHGU74IpoXjn1Nm1DFxFfwIbJ8iGotdzeEjD12M7oKO+hAI2P0bVwQ1QcflvPoK5mdLOsljCE7sYnJcd4gB51NeXePehhQSMjiFqlorMInlcL3Hi8EB+rTf2SuEiLG2Lnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754097344; c=relaxed/simple;
	bh=XllRi140UHP6kKSjRLg3kalHxYoebPJmhBubnvfMgmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLT/8HNMYc8YBf1/zwYxslfQAoNxsMqtRQ6e6gIl4AjlAYIsg74qKKuJ5kODrU6pNqdhFoxtz5TEuHwYGoLNA4OmIBuNwAvupjvKwHYYsxauC/OK7R3SEu3uq9TQpCYX7Az7HPX3ptB/Xrp2FXhs1HBOD5BobKxs27DBRoUVc5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V2BoBhr0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f58385a3-866f-424b-b6ad-ee04edf9aeb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754097339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7CqocdHB+Gme9uAgqSHloH/JWnrTybWn9Kc2ZVppWY=;
	b=V2BoBhr0bDjX3UhVPD0ee7jfTMD7I5eJeoj3CFruCNHS8m6+AmapdGmQ6PkG3+8ot/V/9O
	er+CbXSLhRdnxng8At09ixvIweCDxSuFzj+M7kGmi51SG5Z4mMUOlvbXvJka6ar9acK4MJ
	qps9orS6tOoy8FKw3O8JiI+fMFKwbnY=
Date: Fri, 1 Aug 2025 18:15:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v1 06/11] bpf: Remove task local storage
 percpu counter
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, kpsingh@kernel.org,
 martin.lau@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, kernel-team@meta.com, bpf@vger.kernel.org
References: <20250729182550.185356-1-ameryhung@gmail.com>
 <20250729182550.185356-7-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250729182550.185356-7-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 11:25 AM, Amery Hung wrote:
>   kernel/bpf/bpf_task_storage.c | 149 ++++------------------------------

nice.

> +BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
> +	   task, void *, value, u64, flags, gfp_t, gfp_flags)
>   {
>   	struct bpf_local_storage_data *sdata;
>   
> -	sdata = task_storage_lookup(task, map, nobusy);
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
> +	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
> +		return (unsigned long)NULL;
> +
> +	sdata = task_storage_lookup(task, map, true);
>   	if (sdata)
> -		return sdata->data;
> +		return (unsigned long)sdata->data;
>   
>   	/* only allocate new storage, when the task is refcounted */
>   	if (refcount_read(&task->usage) &&
> -	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
> +	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
>   		sdata = bpf_local_storage_update(
>   			task, (struct bpf_local_storage_map *)map, value,
>   			BPF_NOEXIST, false, gfp_flags);
> -		return IS_ERR(sdata) ? NULL : sdata->data;
> +		WARN_ON(IS_ERR(sdata));

A nit for now. ok during development/RFC. This will eventually need to be 
removed. e.g. it should not WARN_ON ENOMEM.

