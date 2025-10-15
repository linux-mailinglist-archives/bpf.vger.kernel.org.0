Return-Path: <bpf+bounces-71037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3314BE049C
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FBAA4EE120
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E061FDE14;
	Wed, 15 Oct 2025 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T2gFrar5"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7D1ADFE4
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554829; cv=none; b=gaIQFrsqe9+zhdR+lXEbrpGAG53qEiEPFqzord43XEIWzDbz6A910wrf555H9Xj/D0Hh14QysJeT2f07mHFL9Q8QGmT/qJMSydNYpDDEFK6vtrPpn0gIL4QezJJiBtcyIRXaI0dh+9vLUSJ58HHasA75isyXggmPODKjqWfoFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554829; c=relaxed/simple;
	bh=FgyJRLpm6GvA8r1CRZcDFbvJgDwQ911aKdVKpy4Rd5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAzbk7Uj9zUi2BFVsDzhG8viBe4DKLfks1rDIwBtQQKmsXX9oQdT9OXEC07YehRYxB3au2fMSfaXRIAQAzaongVJi+na1x77Ppi5nnuqq38INhkugIrd2n4J38rJuKjDNDs5/nkGz7OQe04KqIicpyENAa1uwuAhwZlypByA8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T2gFrar5; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e8aeb1b8-06f0-4eb3-a1ef-26b943d1c6b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760554824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ViHS6o7TjQ1SExpzKDwFLJCmbItkiEqx2/j5dGG/ukQ=;
	b=T2gFrar5CIyG+IQEbo3W6MQ8gPxv7Xz0mhPtS3mh+9fEnd5MeDp9NzZN7kUSmQy4uRU4y3
	fsZRl52NYp7FOi8pqoNKTd8sxehhOGZ11yWw/LY+yUwAO8s1TqNXTgWQ36tbOvZ5ghjKKz
	sedlnUNciiaFAt/OPKcsblPl+sSaZ/k=
Date: Wed, 15 Oct 2025 12:00:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next/net 5/6] bpf: Introduce
 SK_BPF_BYPASS_PROT_MEM.
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
 Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20251014235604.3057003-1-kuniyu@google.com>
 <20251014235604.3057003-6-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251014235604.3057003-6-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/14/25 4:54 PM, Kuniyuki Iwashima wrote:
>   BPF_CALL_5(bpf_sock_create_getsockopt, struct sock *, sk, int, level,
>   	   int, optname, char *, optval, int, optlen)
>   {
> +	if (level == SOL_SOCKET && optname == SK_BPF_BYPASS_PROT_MEM)
> +		return sk_bpf_set_get_bypass_prot_mem(sk, optval, optlen, true);

The optval (ARG_PTR_TO_UNINIT_MEM) needs to be initialized for error case.
The __bpf_getsockopt below does that but it returns early here.
I changed to this:

	if (level == SOL_SOCKET && optname == SK_BPF_BYPASS_PROT_MEM) {
		int err = sk_bpf_set_get_bypass_prot_mem(sk, optval, optlen, true);

		if (err)
			memset(optval, 0, optlen);

		return err;
	}

> +
>   	return __bpf_getsockopt(sk, level, optname, optval, optlen);
>   }
>   
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 6829936d33f58..9b17d937edf73 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7200,6 +7200,7 @@ enum {
>   	TCP_BPF_SYN_MAC         = 1007, /* Copy the MAC, IP[46], and TCP header */
>   	TCP_BPF_SOCK_OPS_CB_FLAGS = 1008, /* Get or Set TCP sock ops flags */
>   	SK_BPF_CB_FLAGS		= 1009, /* Get or set sock ops flags in socket */
> +	SK_BPF_BYPASS_PROT_MEM	= 1010, /* Get or Set sk->sk_bypass_prot_mem */
>   };
>   
>   enum {


