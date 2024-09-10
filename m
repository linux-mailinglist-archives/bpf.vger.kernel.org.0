Return-Path: <bpf+bounces-39487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B1973E48
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 19:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77A2286280
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6121A00C5;
	Tue, 10 Sep 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFm3MatR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC44A02;
	Tue, 10 Sep 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988310; cv=none; b=sx0dJ0g7B8j+tGzfY3EiQwDSRUdnhhCUo6OBsh0oD7pOoO2ZNGMZpE3zH5Z7qOnpzkkWYrQD5GW6HlGyfSH/pJZM7JfJN5sp0rU9yINH2zmejzhLifUgNSrUYvb8BQg69ZN1/ePj/7OWv9R+vqd9Zd8AwdZgj7h5jTK1At1v8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988310; c=relaxed/simple;
	bh=OO+oa7V/UzM2Qt+eVK3DfG42+9eak+RTeZvRqm/LvbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUWsf5VEvDsfP0QdIGm3MFNfdQLJV3b1lBVG/l/ZKaOXN0YJaPm8XIrTqKTnOY6GCOQGkb+C8a6YsYHLoZq/5vYR4uPk+nTOEB/XV2q/kdnORZF3/s/ehgVGffH2woJZ3FPjnXJwi7ErUT5KsL05nME0creCigZl1AkIaAmAYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFm3MatR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36117C4CEC4;
	Tue, 10 Sep 2024 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988309;
	bh=OO+oa7V/UzM2Qt+eVK3DfG42+9eak+RTeZvRqm/LvbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uFm3MatRYlH8jFn47vuBKhWj4gI8kzPIPyzN6AaQqdePJuYOq4W905oWDpHuwlYLM
	 GCHlXolXtw0cbzPYURhmaiJzOl1i7p14g/+sbbGqSR+MCD+rLg/p3NWXnGpMPEAkB0
	 ItC1NjXBki9PfGQYOI4Eb5QhgElA8/3OB4yGxuRuTrX6AGmoBMx99B6M/rNU7fhEq4
	 SmcJzAKU91i5QwvDfPfOabt+J27Gr8iLgdqU2JcUGf1OgufN1vocBTFGXHuF6VZWRE
	 HcOTrjU8LM9YYe+/QX+yhqmR2MESV5aPQ69UMXZ1oKfL8wNW337rsQm5M6NbTFFg4r
	 dhGSt/KvLBhxQ==
Message-ID: <2ac90a64-ac14-49a8-9f60-095c474933b7@kernel.org>
Date: Tue, 10 Sep 2024 18:11:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpftool: Fix undefined behavior in qsort(NULL, 0, ...)
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 jserv@ccns.ncku.edu.tw, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240910150207.3179306-1-visitorckw@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240910150207.3179306-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2024-09-10 23:02 UTC+0800 ~ Kuan-Wei Chiu <visitorckw@gmail.com>
> When netfilter has no entry to display, qsort is called with
> qsort(NULL, 0, ...). This results in undefined behavior, as UBSan
> reports:
> 
> net.c:827:2: runtime error: null pointer passed as argument 1, which is declared to never be null
> 
> Although the C standard does not explicitly state whether calling qsort
> with a NULL pointer when the size is 0 constitutes undefined behavior,
> Section 7.1.4 of the C standard (Use of library functions) mentions:
> 
> "Each of the following statements applies unless explicitly stated
> otherwise in the detailed descriptions that follow: If an argument to a
> function has an invalid value (such as a value outside the domain of
> the function, or a pointer outside the address space of the program, or
> a null pointer, or a pointer to non-modifiable storage when the
> corresponding parameter is not const-qualified) or a type (after
> promotion) not expected by a function with variable number of
> arguments, the behavior is undefined."
> 
> To avoid this, add an early return when nf_link_info is NULL to prevent
> calling qsort with a NULL pointer.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - Change from checking nf_link_count to checking nf_link_info.
> 
>   tools/bpf/bpftool/net.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 968714b4c3d4..0ad684e810f3 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -824,6 +824,9 @@ static void show_link_netfilter(void)
>   		nf_link_count++;
>   	}
>   
> +	if (!nf_link_info)
> +		return;
> +
>   	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);
>   
>   	for (id = 0; id < nf_link_count; id++) {


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

