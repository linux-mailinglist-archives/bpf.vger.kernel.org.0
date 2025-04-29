Return-Path: <bpf+bounces-56970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447DAA1628
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CDB16F9CC
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1FB2528EC;
	Tue, 29 Apr 2025 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YlIigFi5"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F35233713
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947818; cv=none; b=JY9eoHFmZ12Hzhnl+Uj0LvEq5BOFsXA8K7fD+XglgTj6EYzufQG+vK69KMF9199uYaBPBticq6U/5YHdU8ZJfUmfN8GqiiJBmoj7zdY8GEBWeS/I15WaXGbBkXdnCdKnJ8O+Avb7Uoj5GBqXh0i3h7XjKEQEmKOMmGlyLMl5toA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947818; c=relaxed/simple;
	bh=zcsVVeTA0p6UAc+EOvSEtRfxfVwh/1UWE5hbRidnBTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpFSVOgH3xwfw3QWXcQ0fCZXgc4LxoayrTPxQ+PixNkIn5uR4fD+3vWr5BHVsctDB4S3E0eK2HaKcNr0zkrVVp5q1qVRUEYW2VwMcJyjj/oKVaSPag0CKiOmPm9ysJV+LDB3duGNolcP7SXg0oG4h4XZg6kJt/T0eHdFvL7kLVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YlIigFi5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae064b92-1d9d-47a8-ac26-1172076e5bcb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745947804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATlrEW58fdp+KUFferXGbfoEARKyrYWPAY00eE8UZW4=;
	b=YlIigFi5S2mnIfIGqYTeDe5OGnSXQrd72C2kK7dAgo/qZCClJTdzvcDcgEeT7td+mv33bU
	eFRRPqVh93UqKTUVGIgjOOGhww4xs6c8YgUxg1aa93GR5zcGxPOpCC4h6j9CVytbDuF7/0
	72kMI/fxL9AAnRLjv+7HXibLk7k/xPI=
Date: Tue, 29 Apr 2025 10:29:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net] bpf: net_sched: Fix using bpf qdisc as
 default qdisc
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, xiyou.wangcong@gmail.com, kernel-team@meta.com
References: <20250422225808.3900221-1-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250422225808.3900221-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/22/25 3:58 PM, Amery Hung wrote:
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index db6330258dda..1cda7e7feb32 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -208,7 +208,7 @@ static struct Qdisc_ops *qdisc_lookup_default(const char *name)
>   
>   	for (q = qdisc_base; q; q = q->next) {
>   		if (!strcmp(name, q->id)) {
> -			if (!try_module_get(q->owner))
> +			if (!bpf_try_module_get(q, q->owner))
>   				q = NULL;
>   			break;
>   		}
> @@ -238,7 +238,7 @@ int qdisc_set_default(const char *name)
>   
>   	if (ops) {
>   		/* Set new default */
> -		module_put(default_qdisc_ops->owner);
> +		bpf_module_put(ops, default_qdisc_ops->owner);

The first arg, should it be the "default_qdisc_ops" instead?


>   		default_qdisc_ops = ops;
>   	}
>   	write_unlock(&qdisc_mod_lock);

