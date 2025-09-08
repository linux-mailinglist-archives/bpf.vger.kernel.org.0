Return-Path: <bpf+bounces-67781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFEDB499E4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385114410B6
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4027EC99;
	Mon,  8 Sep 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E6Guut2t"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BF1A2381
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359682; cv=none; b=SMB01lZg09v9b9u7tRvEbnzNZgSH4y+L94q55xHSSqeqMs/u0ZpCzZes1ASVue8eCoDX/6s6xvy0sUE1bWHsxb6gktBd+ZPw2l0jUvkCLTZMulIzns4hGW1QHphCeBBDrEcInNwd8BwBGGrWdUU8/esdrsqo++FCNyJxMxYhKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359682; c=relaxed/simple;
	bh=j6CFg6JMk/FjRGTJ06rQZUaFLUuCV1sA7BeJ+RLKj4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ldk46YUc43tfvBS7robDVfnu9BpbaRNPYUNtrQ+kquttKhg9csI3RUSoTh1Fy818cHMkpLNoweSkUuNh+nTD2qHlTASdwOeckfwU7BjQ9TYD+Xfg+edss+n3GFfJTUulo6tIyGXc/LGAMjd89Zpy6UnmMqPx5xaZeXoXZzzIiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E6Guut2t; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54cddbbd-1c0d-467a-af49-bb6484a62f26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757359677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYc7idK35SgQs+VEwnHBmuMBPBHhNNcDoxzAnRzN1B8=;
	b=E6Guut2tPB/ns7zM3S33BAXu7Ed/JuDyePtmd3LUJzTIgCp508bkQGEWbqhta56jEaEoZv
	tIWer+kva8JyqWFJYBwzc+tqMO1z+8BRFnSXIbLaTmTkXt0E3ABQZnfoFXiYU2QHjI7bCI
	lA5xA1ZVjMifWgiq4baxcYTFLm2cqM0=
Date: Mon, 8 Sep 2025 12:27:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org,
 mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250905173352.3759457-1-ameryhung@gmail.com>
 <20250905173352.3759457-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250905173352.3759457-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/5/25 10:33 AM, Amery Hung wrote:
> An unused argument, flags is reserved for future extension (e.g.,
> tossing the data instead of copying it to the linear data area).

> +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags)

I was thinking the flag may be needed to avoid copy. I think we have recently 
concluded that bpf_xdp_adjust_head can support shrink on multi buf also. If it 
is the case, it is probably better to keep a similar api as the 
bpf_skb_pull_data which does not have the flags argument.


