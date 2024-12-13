Return-Path: <bpf+bounces-46807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431AB9F0286
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D90B16A28D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D94502BE;
	Fri, 13 Dec 2024 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEIRdvzD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB784A33;
	Fri, 13 Dec 2024 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734056387; cv=none; b=MchZeYTa4hDKbh+9fPjyZkppmoodb2QyHdN2qjVgYGRZwFKiw9qlNMh9OOwK3+4XgpCoyIZ5MsGVkrdSZO4HAD+WfQW1C7H4LBOJNxaNfCs3rTe0LmtQhQsxv4Vkb3Cv0ACNzBjdMDnm/WJGNnxDt6vjcU8gDcL7d5gQyqHHJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734056387; c=relaxed/simple;
	bh=xrfpFYZm+mLnYcd6QMdi7Dj0f41oVmdK3ikweHc2BAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMaAiT9ZtVXgowdRSjmEFl/dsIGlURAgkradbOHW8HuBrzHoQcsTCpgAXIBr3ujSIfUXj4W3yHKvezjtw+JK4vXLZKYd77vpyqEmdCMOxDRd7gBnvNWvdtTlbGQBrw3QChhlM63gJ71fnpCWd5l8Ks86EvJUHZV4jlzhVQwZt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEIRdvzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6B0C4CECE;
	Fri, 13 Dec 2024 02:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734056386;
	bh=xrfpFYZm+mLnYcd6QMdi7Dj0f41oVmdK3ikweHc2BAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eEIRdvzDhspLDkCkKmQCo1iI33NGwdbx4GiScMF5raIHLrqQJ3aSLUKcddOjNkQxj
	 sdcDuHbQRvbB+Vj+uqdmdWGIWwqU/aOpa1t4TA8yuigCHfdZTY9HV59ab/hXeOZjwD
	 j57w9nlmf/yQkTD9HegUw1jyOcY7LAMW58w4AwL4SNmB+VjeBBKE9VokmkDhbFCGih
	 27cQkEwfCFkZniyrgWC6J1Ksb2ZBV2uSEDvfiJQ1qxPOx4rQ8LtT31qjXvVm6y9Yx+
	 KqoQtD7n1cE/1mKDbt3xQ6flj3J6lb9QdAdxC6vXOt2UStB9Z2JnGXpjzogf/M4lUI
	 qEftfMGwOMhng==
Date: Thu, 12 Dec 2024 18:19:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, Casey
 Schaufler <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] xsk: add generic XSk &xdp_buff -> skb
 conversion
Message-ID: <20241212181944.37ca3888@kernel.org>
In-Reply-To: <20241211172649.761483-8-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
	<20241211172649.761483-8-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 18:26:44 +0100 Alexander Lobakin wrote:
> +#else /* !CONFIG_PAGE_POOL */
> +	struct napi_struct *napi;
> +
> +	pp = NULL;
> +	napi = napi_by_id(rxq->napi_id);
> +	if (likely(napi))
> +		skb = napi_alloc_skb(napi, len);
> +	else
> +		skb = __netdev_alloc_skb_ip_align(rxq->dev, len,
> +						  GFP_ATOMIC | __GFP_NOWARN);
> +	if (unlikely(!skb))
> +		return NULL;
> +#endif /* !CONFIG_PAGE_POOL */

What are the chances of having a driver with AF_XDP support 
and without page pool support? I think it's zero :S
Can we kill all the if !CONFIG_PAGE_POOL sections and hide
the entire helper under if CONFIG_PAGE_POLL ?

