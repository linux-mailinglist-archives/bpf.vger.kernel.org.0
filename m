Return-Path: <bpf+bounces-30873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BE8D4087
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CFAB245FA
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6821C8FD4;
	Wed, 29 May 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQ0FLH1M"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3A181BA9
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019500; cv=none; b=XeGgGslisDKE6ILp7kYzZI95iZR1DuUJkEbrF2utYS9mKWPo4eJY04+9GX3LkTDqaJvF4cplrS0Ksxbi8XGETu+605j9KnP48ou/jd+z94EsRNq4v25vveFiXwuUyaBZkYUNJMjoqqjByn9FsBNOqfaN6cN5gq7wXJ18WIQJ02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019500; c=relaxed/simple;
	bh=Rs8pRvcSN/4Zk3ZQsPpqpr0LxPLYoqi6qIVYEps1csM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKn4Mdyi8/kxKVUvOP7jQgj66Ei707PmEn4nTgBgb2lFUeowfUdU1IhtV12DjRUfXS8JMATaNl08UmLlc+kiZIA9PXChsvukNCqMmfYNo4e74+3Or/+K1ZcssANLqiX1XThSDwiWd0NHkS0sJWYOdnUqT7oehAYLXVgwN3L31TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQ0FLH1M; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: thinker.li@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717019496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgVyAjA65elYAlnjlqhx0ixHyLZPsV3rmG9OoYhqZ7Q=;
	b=LQ0FLH1M7UVOBmrmOOFP9WiQdyhhvOeBiijBJsSjSIBHYI+VF5QLfzSNIUWCU7xzdtdDPd
	ygTGyYUEqwTfI6EYneXDJyjGFdFCWUKVi92QW8niM9Nb3ReM+DsDLSu81nl+ty6Ao2XAnK
	Sse+9YnlDgJ0YX5VDqqfBH2Adny65sk=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: sinquersw@gmail.com
X-Envelope-To: kuifeng@meta.com
Message-ID: <f0b0e283-9312-4f11-9636-2ea690262180@linux.dev>
Date: Wed, 29 May 2024 14:51:27 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 6/8] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com,
 kuifeng@meta.com
References: <20240524223036.318800-1-thinker.li@gmail.com>
 <20240524223036.318800-7-thinker.li@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240524223036.318800-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
> @@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
>   	if (ops->test_2)
>   		ops->test_2(4, ops->data);
>   
> +	spin_lock(&detach_lock);
> +	if (!link_to_detach)
> +		link_to_detach = link;

bpf_testmod_ops is used in a few different tests now. Can you check if 
"./test_progs -j <num_of_parallel_workers>" will work considering link_to_detach 
here is the very first registered link.

> +	spin_unlock(&detach_lock);
> +
>   	return 0;
>   }


