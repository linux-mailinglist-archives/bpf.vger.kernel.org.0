Return-Path: <bpf+bounces-70945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754DBDBBD1
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F641921D09
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127FE2F9DAF;
	Tue, 14 Oct 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ol2SaDhq"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D502F5A29
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483572; cv=none; b=A8eehK9/+qmmECwlyiUsi8RJ+m1+TgrLW0PExZQsOzm7gZ0m1PqFh4ZdG1TNrMgdbTZmrDhbQ8+xzOEJvsjZyvqmvzh8lRKms9IB0jrHWOHCFpO3e6udHKJeXhbz6iqvguTYxfKNmPx2+rHoWn4Umt/NTX8Kbqd7FqpEFrzNWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483572; c=relaxed/simple;
	bh=fcwXNTeJpcjSOx+df+r3b9LV8FwrdYExzkbElvgp/UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgtB/EZeMURK29WpmOnOgPwIm59DCG4b70gMBcBisoTC4C7G7Pi/BW/36PN0hMXSc2sqYI2xjfWnFdz9MPWn5L6iRU4CR3SHdiSYr90RZVbgZ/AvjyfpN/soHIWT/nQn3BEKabRByjK9VSiXLsl3IDUYTOLE/V7mZfyFgE5dlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ol2SaDhq; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c05e9b2c-ae5f-4607-821e-37f71b1dd1bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760483568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bc7/sQWaWUUq7pOFN6egIMlyTpGH0JETI7XklDirkZo=;
	b=ol2SaDhqXt3M5A6t3+VjI9NZjG3gRuw/on/RPNn+f1CTvl7D8QyzXHHo8w5/VzPLvfEKsi
	cjXqzTK+SVGUbL8+oZHeIzQrbpJ1lB05iimKkdXDx2zrHg+scDwsjBSIM104w+M15WeefR
	jBVILfO8m3BvtnjKdzzB7SESFn7JvWU=
Date: Tue, 14 Oct 2025 16:12:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net 2/6] net: Allow opt-out from global protocol
 memory accounting.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251007001120.2661442-1-kuniyu@google.com>
 <20251007001120.2661442-3-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251007001120.2661442-3-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 5:07 PM, Kuniyuki Iwashima wrote:
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60bcb13f045c..5cf8de6b6bf2 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -118,6 +118,7 @@ typedef __u64 __bitwise __addrpair;
>    *	@skc_reuseport: %SO_REUSEPORT setting
>    *	@skc_ipv6only: socket is IPV6 only
>    *	@skc_net_refcnt: socket is using net ref counting
> + *	@skc_bypass_prot_mem:

While it needs a respin, maybe useful to add comment on "@skc_bypass_prot_mem"

>    *	@skc_bound_dev_if: bound device index if != 0
>    *	@skc_bind_node: bind hash linkage for various protocol lookup tables
>    *	@skc_portaddr_node: second hash linkage for UDP/UDP-Lite protocol
> @@ -174,6 +175,7 @@ struct sock_common {
>   	unsigned char		skc_reuseport:1;
>   	unsigned char		skc_ipv6only:1;
>   	unsigned char		skc_net_refcnt:1;
> +	unsigned char		skc_bypass_prot_mem:1;
>   	int			skc_bound_dev_if;
>   	union {
>   		struct hlist_node	skc_bind_node;



