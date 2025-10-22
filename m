Return-Path: <bpf+bounces-71856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB9BFE7CE
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 01:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8D924F4C79
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8D028D829;
	Wed, 22 Oct 2025 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n0pDSE52"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE8302166
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174780; cv=none; b=KVsuE4ynfRqSFYLjvoibMErUq6QJBboPkdzkeIA+i6UOdv5rNqrP6pMARd2I/IbupSZV/8XLGVdaxuTxl5xfoDmILTVW2m+smj95KNG6flq+84O2lKMSuIEoiCxgjQPRu4NPrYdpzySO18kLeBqDByh1z9gN5ezUifqIJk2HDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174780; c=relaxed/simple;
	bh=NvBrYAYp5zpgQVkY3YYE9Fqqhz8bUc+Bun/3qLlMW5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3DAuKiWvK8RfOtDKR75UTlykPd4SsqpUUIXj/pvSgMAJ8N3NGrmF0QfdGCVbDNuoji9QfuMdKPm1cNyoIMpmCIiYcEYjPa74Nik3diCLRLYy7bHh/B7zU/Z5L95nfdrcyjrgqnRQ4xbI83e3FK4dyV++gTfKhMaHOgois//E3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n0pDSE52; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2753c96b-48f9-480e-923c-60d2c20ebb03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761174766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQR3+niA3WL1Q5qAf+tYkxJSLyabvkBcayOKnKsYXT8=;
	b=n0pDSE52OnOEthN3PSbHDCWq4EIiBdvXtsThCfAo+mTN32m/8WpJsAYts74PEcod1CQOf4
	sbaGaxFPQkAmg1+y4ERFU9k2nFgsxUS/7bR9ex6rLXSUr9z+sEpqcpoIYC5PI1QdZvZIeR
	HC51NCUrDfqX4AM+sen8mJGnL+koKnA=
Date: Wed, 22 Oct 2025 16:12:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 11/15] selftests/bpf: Expect unclone to
 preserve skb metadata
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
 <20251019-skb-meta-rx-path-v2-11-f9a58f3eb6d6@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251019-skb-meta-rx-path-v2-11-f9a58f3eb6d6@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/19/25 5:45 AM, Jakub Sitnicki wrote:
> @@ -447,12 +448,14 @@ int clone_dynptr_empty_on_meta_slice_write(struct __sk_buff *ctx)
>   
>   /*
>    * Check that skb_meta dynptr is read-only before prog writes to packet payload
> - * using dynptr_write helper. Applies only to cloned skbs.
> + * using dynptr_write helper, and becomes read-write afterwards. Applies only to
> + * cloned skbs.
>    */
>   SEC("tc")
> -int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
> +int clone_dynptr_rdonly_before_data_dynptr_write_then_rw(struct __sk_buff *ctx)
>   {
>   	struct bpf_dynptr data, meta;
> +	__u8 meta_have[META_SIZE];
>   	const struct ethhdr *eth;
>   
>   	bpf_dynptr_from_skb(ctx, 0, &data);
> @@ -465,15 +468,23 @@ int clone_dynptr_rdonly_before_data_dynptr_write(struct __sk_buff *ctx)
>   
>   	/* Expect read-only metadata before unclone */
>   	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
> -	if (!bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != META_SIZE)
> +	if (!bpf_dynptr_is_rdonly(&meta))

Can the bpf_dynptr_set_rdonly() be lifted from the 
bpf_dynptr_from_skb_meta()?

iiuc, the remaining thing left should be handling a cloned skb in 
__bpf_dynptr_write()? The __bpf_skb_store_bytes() is using 
bpf_try_make_writable, so maybe something similar can be done for the 
BPF_DYNPTR_TYPE_SKB_META?

> +		goto out;
> +
> +	bpf_dynptr_read(meta_have, META_SIZE, &meta, 0, 0);
> +	if (!check_metadata(meta_have))
>   		goto out;
>   
>   	/* Helper write to payload will unclone the packet */
>   	bpf_dynptr_write(&data, offsetof(struct ethhdr, h_proto), "x", 1, 0);
>   
> -	/* Expect no metadata after unclone */
> +	/* Expect r/w metadata after unclone */
>   	bpf_dynptr_from_skb_meta(ctx, 0, &meta);
> -	if (bpf_dynptr_is_rdonly(&meta) || bpf_dynptr_size(&meta) != 0)
> +	if (bpf_dynptr_is_rdonly(&meta))

then it does not have to rely on the bpf_dynptr_write(&data, ...) above 
to make the metadata writable.

I have a high level question about the set. I assume the skb_data_move() 
in patch 2 will be useful in the future to preserve the metadata across 
the stack. Preserving the metadata across different tc progs (which this 
set does) is nice to have but it is not the end goal. Can you shed some 
light on the plan for building on top of this set?

