Return-Path: <bpf+bounces-71857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD17BFE951
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 01:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C0813573BE
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F47322DD4;
	Wed, 22 Oct 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LNYmkNCv"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C226ED2E
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761175823; cv=none; b=RuoBnEjtX/HoRK3cocW9C4gt79qmEgSarc+cROZDgYMzALPLs7sSx/qN6ublglhPYFFPdcl32PlspLXh8cAGbrh2XyO34zO4PCbT1reTqzkBMXE5dFF2RljDC9pf0SiqpQoJvjwoCeZKE1l4Jui7+M0IKodp3mwivnjOsiTxNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761175823; c=relaxed/simple;
	bh=LP9jECv1nZN9/lEv6/pgQwWQcXpg1pIVXaHbZLhUq2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwXKITwuOPfEn4bAWMxeA+Zz7DVv4bPtwZ/9jRseDS9Q8+fdGd+sggox5Jh+DMsgz1vp2GH6Q2f+19yIahwZaFU618VUmIBZb3c0/R9VKiCbetxmxR+xitujP4ljaP4jq8DYxZ9ekwEwX0qpTJuXRrx09NwW0B/x+Z8OFZ6n6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LNYmkNCv; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7956ac25-f0ba-4d29-a07f-d1eaafb84acc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761175817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCPGOpdo5Nmk/Kszs6n64vYNNo8tBBkaZBLbzyLFFic=;
	b=LNYmkNCvOLLw9/sHIK7spnXjs7KwO+qClOrYCTnvYJS8QA48bKZ3uzfFncriCDLHm7ztjd
	ctjFUgI5EzbHBWpx5XBQvnI8+81zfU17+CTZ5fH7SzBv8nD6p8OjVNIXFVTd9QJd1iuFe2
	BrD66XJz/1E2i3hhIP4KkOAQz7uHtCo=
Date: Wed, 22 Oct 2025 16:30:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 10/15] selftests/bpf: Dump skb metadata on
 verification failure
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
 <20251019-skb-meta-rx-path-v2-10-f9a58f3eb6d6@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251019-skb-meta-rx-path-v2-10-f9a58f3eb6d6@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/19/25 5:45 AM, Jakub Sitnicki wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 93a1fbe6a4fd..a3de37942fa4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -171,6 +171,25 @@ static int write_test_packet(int tap_fd)
>   	return 0;
>   }
>   
> +enum {
> +	BPF_STDOUT = 1,
> +	BPF_STDERR = 2,

There is BPF_STREAM_STDERR in uapi/bpf.h
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> index 11288b20f56c..33480bcb8ec1 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> @@ -18,6 +18,11 @@
>    * TC program then verifies if the passed metadata is correct.
>    */
>   
> +enum {
> +	BPF_STDOUT = 1,
> +	BPF_STDERR = 2,
> +};
> +

