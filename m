Return-Path: <bpf+bounces-28726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271C8BD6EE
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 23:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE47283892
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5115B54C;
	Mon,  6 May 2024 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KnriCcQI"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2E1411F6
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031588; cv=none; b=MIWsJU6MYy5Als7sVai0eEVvKa9iKVd+Nl1tT2ewF/6/9xKPehr2dF4g8L7xkEuACc/QE+yrYkIM1m0yYAw+jt1+lM6fNwlHuNGh0Z4a6o7GsErg0/34qp6TabtGREwIHaEiEaBNh6gOKHCRrUO+y5E7OBAGPNQmvldY3A+NOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031588; c=relaxed/simple;
	bh=jbxe1lK1rfedeVRZiJ3I+GastkBVzxfbmR83Klx7uQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjeyHCEC8FdzUy5Ldphk9ey7mE6AMBtgX8rIby50+zA1GreayTLRDMow+o2qJOrtKtum+7DtEMJaXNgH/NPLSmFIEx55rqctY0JjL3ev8uD3AUmdVl0c2yQVvczdPx9hmXl8Lz0KM8/t/G9WfY0/IXgIrmzxDDjJJokJpYIpwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KnriCcQI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d4f681a-6636-4c98-9b1e-5c5170b79f7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715031583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfQnWoSzVwAMIFsfqkXHtFQjm5gfbIhQ9SsGNlSue1k=;
	b=KnriCcQIu+MeIxI5W0ZmBhzrGslGIrYt6LeyEz7Gk9Mghw6WZaKyZSImH2A6UlZ71veKR2
	yztyL5JwqRSX4m5CvTK5UYkuwm1VxYFQIxPtrDMGxaHmuEiqvr755LXYZQqH2extdQF+ud
	58P2LdGxf7aB8YdlrnWn5K/3cxHKnLk=
Date: Mon, 6 May 2024 14:39:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_dynptr_from_skb() for tp_btf
To: Philo Lu <lulie@linux.alibaba.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, drosen@google.com, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org
References: <20240430121805.104618-1-lulie@linux.alibaba.com>
 <20240430121805.104618-2-lulie@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240430121805.104618-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/30/24 5:18 AM, Philo Lu wrote:
> Making tp_btf able to use bpf_dynptr_from_skb(), which is useful for skb
> parsing, especially for non-linear paged skb data. This is achieved by
> adding KF_TRUSTED_ARGS flag to bpf_dynptr_from_skb and registering it
> for TRACING progs. With KF_TRUSTED_ARGS, args from fentry/fexit are
> excluded, so that unsafe progs like fexit/__kfree_skb are not allowed.
> 
> We also need the skb dynptr to be read-only in tp_btf. Because
> may_access_direct_pkt_data() returns false by default when checking
> bpf_dynptr_from_skb, there is no need to add BPF_PROG_TYPE_TRACING to it
> explicitly.
> 
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> ---
>   net/core/filter.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 786d792ac816..399492970b8c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11990,7 +11990,7 @@ int bpf_dynptr_from_skb_rdonly(struct sk_buff *skb, u64 flags,
>   }
>   
>   BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)

I can see the usefulness of having the same way parsing the header as the 
tc-bpf. However, it implicitly means the skb->data and skb_shinfo are trusted 
also. afaik, it should be as long as skb is not NULL.

 From looking at include/trace/events, there is case that skb is NULL. e.g. 
tcp_send_reset. It is not something new though, e.g. using skb->sk in the tp_btf 
could be bad already. This should be addressed before allowing more kfunc/helper.

I would like to hear how others think about it.

pw-bot: cr

>   BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
>   
>   BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
> @@ -12039,6 +12039,7 @@ static int __init bpf_kfunc_init(void)
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_XMIT, &bpf_kfunc_set_skb);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
>   					       &bpf_kfunc_set_sock_addr);


