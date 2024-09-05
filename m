Return-Path: <bpf+bounces-39003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD596D7A4
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3211F27380
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207219ABDE;
	Thu,  5 Sep 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5EV6rM/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648441991B0;
	Thu,  5 Sep 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537187; cv=none; b=acX379hij29xnze1r7l1L5oy27sq2IvyAI2gqij9Hq55gBtAIM0a0H0z75W6ZzZkmMjvMwVwFlRgdaaAyZzn9Pqktq0ai0mGv+dj5bH2SopaZIsRpwKP7mV7CBoEkMDDv7R9pInVBdeBqkmZuEet+tYP38p6SrSbZ/agKR+GaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537187; c=relaxed/simple;
	bh=HNyMhI5hMzzHCvzOyY0LFtSR+HZOPSgH0ifVtwVScmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi1Saz+T7C3DAzRpKKOEgczeiJOn6Q6yWMjsSNQh1HSz1t+rYa2e7ekcmr15QlTBO/fEC32y6C3HeHtNqwylfOGh9ZogqjNDrxibYwuMTryEmx05P4xsMIvYMYAW0Gr7h8HjXgIX7MNG8/1qvISXJJQxbxCJx9cfzGU/wGk9hUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5EV6rM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0FFC4CEC7;
	Thu,  5 Sep 2024 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725537187;
	bh=HNyMhI5hMzzHCvzOyY0LFtSR+HZOPSgH0ifVtwVScmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W5EV6rM/u4+nbf4Kc/ZAbbnnUdUjFyS+0p9n1E6wh/CZR5a2AC4gEZt1OKrdcSCKC
	 kYvmDx80pEk81Jl45bUrtd+PE2h55lDuAoyQ4mnHehk2mutOscRKBy9AjH9jULr9hW
	 IGhPRRakmqsb+HSs0JU3B7byb4xeqjQDrKVDct/7SiO6zilGeI1pb7zu8boQaVnyP7
	 OBEAtXbqzpfC/XQvlptt3I3EAf6B82SHxShfqVnHt5BYS/ni+O9Yl73z3pHl9Cx/Co
	 GwTTjIYxkXUfWCnoGJEn+s07frzBAnJnXi9fAbgM3YqpZD2zKdAncbkDE65wc1DRTl
	 OPeezyD5VMU0A==
Message-ID: <56785387-db5b-40a7-a396-75f93e6041f8@kernel.org>
Date: Thu, 5 Sep 2024 13:53:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/9] bpf: cpumap: enable GRO for XDP_PASS frames
To: Lorenzo Bianconi <lorenzo@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830162508.1009458-1-aleksander.lobakin@intel.com>
 <20240903135158.7031a3ab@kernel.org> <ZteAuB-QjYU6PIf7@lore-desk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <ZteAuB-QjYU6PIf7@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/09/2024 23.33, Lorenzo Bianconi wrote:
>> On Fri, 30 Aug 2024 18:24:59 +0200 Alexander Lobakin wrote:
>>> * patch 4: switch cpumap from a custom kthread to a CPU-pinned
>>>    threaded NAPI;
>>
>> Could you try to use the backlog NAPI? Allocating a fake netdev and
>> using NAPI as a threading abstraction feels like an abuse. Maybe try
>> to factor out the necessary bits? What we want is using the per-cpu
>> caches, and feeding GRO. None of the IRQ related NAPI functionality
>> fits in here.
> 
> I was thinking allocating a fake netdev to use NAPI APIs is quite a common
> approach, but sure, I will looking into it.
> 

I have a use-case for cpumap where I adjust (increase) kthread priority.

Using backlog NAPI, will I still be able to change scheduling priority?

--Jesper

