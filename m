Return-Path: <bpf+bounces-20737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2ED8427B3
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 16:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A61A1F23A49
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52C8121A;
	Tue, 30 Jan 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVRL3xIq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A927469;
	Tue, 30 Jan 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627469; cv=none; b=sq4ra+gCT8fBJ2rYmZtFERYVDboLd7wXhcoIuqFyIoyrbVyHanlSkNvUMQFyBy+QcdxID/CjXrkuipEWjhYLSZUZO6cvtNqBVJYGsbYQItpHlkTCNNUCG3zoZMAbizZhhzhYzH1ZzWznamb1h9pHBmTzF9ahel1LDZASh2ZEiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627469; c=relaxed/simple;
	bh=ngzIrEyy12MMqC9VJn4/BnPU5yDM2XRoxFig6aOdE8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKMlwHPOaA+m6rYSJUrLOQzgleJNHxqgKCnrocrMkZcDBjG/O+Q+pMB3ycavZtUjp3lg+HVetfZ/8iIoOY821Sudo/3oBiMIlICdVi/3k6Fqr6QxbBVY4m+UDxwvunTGbRwjfl8ail675aeaUA1mLfQhS48MdhqVwMuoZ6wdIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVRL3xIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A9DC433F1;
	Tue, 30 Jan 2024 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627468;
	bh=ngzIrEyy12MMqC9VJn4/BnPU5yDM2XRoxFig6aOdE8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZVRL3xIq0yJptE72Z8YUkWyyzsrXtoGlF2+nQ/sOTLRUQfbjRmBrNvp7afchNv14I
	 nGP97c0joKhLUBF/u/wG+3ZTlzHayS9ybnfff698oBve/MW5mMT9eDiSXO1NygpjZt
	 Bw0Juaoh6x+/hzAoL6eg/PqW1h6iUDqPMw0ZC47OZIpHX2rRO/ua537O+WY979OqHI
	 W3uEQsnrRlmtV+wBCfceaPddLcS8SGwDQMYOuXj44wXRaGlWCiDfEiYfiJI6Inmi1H
	 l0+dTtUM6nkgKpiNIwIfOdab3pQK2YkCEC/XGu8l0W+8rNTOGBdnS7hGLzFrdK+UFa
	 MgXHe5LFbUzYg==
Message-ID: <fcf8678b-b373-49a8-8268-0a8b1a49f739@kernel.org>
Date: Tue, 30 Jan 2024 16:11:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 4/5] net: page_pool: make stats available just
 for global pools
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, toke@redhat.com,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com,
 ilias.apalodimas@linaro.org
References: <cover.1706451150.git.lorenzo@kernel.org>
 <9f0a571c1f322ff6c4e6facfd7d6d508e73a8f2f.1706451150.git.lorenzo@kernel.org>
 <bc5dc202-de63-4dee-5eb4-efd63dcb162b@huawei.com>
 <ZbejGhc8K4J4dLbL@lore-desk>
 <ef59f9ac-b622-315a-4892-6c7723a2986a@huawei.com>
 <Zbj_Cb9oHRseTa3u@lore-desk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <Zbj_Cb9oHRseTa3u@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/01/2024 14.52, Lorenzo Bianconi wrote:
>> On 2024/1/29 21:07, Lorenzo Bianconi wrote:
>>>> On 2024/1/28 22:20, Lorenzo Bianconi wrote:
>>>>> Move page_pool stats allocation in page_pool_create routine and get rid
>>>>> of it for percpu page_pools.
>>>>
>>>> Is there any reason why we do not need those kind stats for per cpu
>>>> page_pool?
>>>>
>>>
>>> IIRC discussing with Jakub, we decided to not support them since the pool is not
>>> associated to any net_device in this case.
>>
>> It seems what jakub suggested is to 'extend netlink to dump unbound page pools'?
> 
> I do not have a strong opinion about it (since we do not have any use-case for
> it at the moment).
> In the case we want to support stats for per-cpu page_pools, I think we should
> not create a per-cpu recycle_stats pointer and add a page_pool_recycle_stats field
> in page_pool struct since otherwise we will endup with ncpu^2 copies, right?
> Do we want to support it now?
> 
> @Jakub, Jesper: what do you guys think?
> 


I do see an need for being able to access page_pool stats for all 
page_pool's in the system.
And I do like Jakub's netlink based stats.

--Jesper
(p.s. I'm debugging some production issues with page_pool and broadcom 
bnxt_en driver).

