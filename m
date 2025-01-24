Return-Path: <bpf+bounces-49633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9449A1AE2E
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 02:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E7316D348
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 01:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC11D54D6;
	Fri, 24 Jan 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KtwVt2a2"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD61D514C
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737682026; cv=none; b=A51GRX2mvB4ZCCz3SHx8sAUkvuKxfZHToyAlatWuqgq4If7pU5zM1rOOXpUptV9qppL1O8fxpcMDyZcJQ2QxcptG+1qa+86kJZ9Nt3Bcp1DaQcAYhjQd+rYF4WItL8e+n5mOqIjx7L5mdSWLWUlP6FnTj6tr2/5asOMgM8rU+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737682026; c=relaxed/simple;
	bh=8A/ZQchMkhLdzbE9hCs3yuSuvlx/AxMpZLAbuffBe3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHr2g2yig+VGEC9PXKtO3ObJFTckrFq+tVZ8LbFM+qPOe0fubStNGYYeFxjH5kMgA0aj+hG2NK/3+4Nz2Hdb0B6hlRoNTj0jYeIFttZVHpvmmFRl2xqNch47XWv/GTH2CQJU58FKaEEh7vPACQVkBke6GJA2vYIzVsx0KdXwGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KtwVt2a2; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b373a23-c093-42d8-b4ae-99f2e62e7681@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737682011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Uky8htszqHFvOfwOuM0F7ppJ9mHdrq3+wWzMozWX0Y=;
	b=KtwVt2a2O6JhiDMbWg51u424uqaLIWHDVLWggTa5gNQrNKBwZ6gHuyVdxxzhv09+cXmVV2
	SpScK9FBsateFV9F20LsqpozckMmxARdZcotxDFJJXIYiXfRCxa5xM/modJFYEIX0DQgYu
	8EV7Gp7T+yRf2fEVmDgHxMWRLnQjQpw=
Date: Thu, 23 Jan 2025 17:26:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v2 5/7] bpf: Acquire and release mptcp socket
To: Geliang Tang <geliang@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Mat Martineau <martineau@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
References: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-0-ae244d3cdbbc@kernel.org>
 <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-5-ae244d3cdbbc@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241219-bpf-next-net-mptcp-bpf_iter-subflows-v2-5-ae244d3cdbbc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/19/24 7:46 AM, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The KF_TRUSTED_ARGS flag is used for bpf_iter_mptcp_subflow_new, it
> indicates that the all pointer arguments are valid. It's necessary to
> add a KF_ACQUIRE helper to get valid "msk".

This feels wrong. It forces an unnecessary acquire to get around the verifier. 
bpf_sockopt->sk should be in "trusted". From looking at patch 7, the issue 
should be the return value of bpf_skc_to_mptcp_sock().

> 
> This patch adds bpf_mptcp_sock_acquire() and bpf_mptcp_sock_release()
> helpers for this. Increase sk->sk_refcnt in _acquire() and decrease it
> in _release(). Register them with KF_ACQUIRE flag and KF_RELEASE flag.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>   net/mptcp/bpf.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index e39f0e4fb683c1aa31ee075281daee218dac5878..d50bd1ea7f6d0ff1abff32deef9a98b98ee8f42c 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -97,6 +97,23 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
>   {
>   }
>   
> +__bpf_kfunc static struct
> +mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +
> +	if (sk && refcount_inc_not_zero(&sk->sk_refcnt))
> +		return msk;
> +	return NULL;
> +}
> +
> +__bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +
> +	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
> +}
> +
>   __bpf_kfunc_end_defs();
>   
>   BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
> @@ -104,6 +121,8 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>   BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_mptcp_sock_acquire, KF_ACQUIRE | KF_RET_NULL)

It should need a KF_TRUSTED_ARGS here but then it will hit the same problem 
described in the commit message.

Instead of changing the verifier to get this work, one option is to use the 
"struct sock *sk" instead of "struct mptcp-sock *msk" as the argument in the 
bpf_iter_mptcp_subflow_new, and do the bpf_mptcp_sock_from_sock check in the 
bpf_iter_mptcp_subflow_new.

> +BTF_ID_FLAGS(func, bpf_mptcp_sock_release, KF_RELEASE)
>   BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
>   
>   static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
> 


