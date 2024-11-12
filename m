Return-Path: <bpf+bounces-44554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BDB9C4AAF
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D245828847B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 00:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745EA1F4FD0;
	Tue, 12 Nov 2024 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kO+Lnfri"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6401CEEB3
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371177; cv=none; b=QSA4Rtqbn2S23eJhPU3SBPCw9GaslTCIntGyYljTEAuPDS/tQ+Xw6tOH21lJuzUXj/llH2AV0sS6X9huO+d/uWbhn+C610fAm134DxoTDxpKe9dDVzfVJCq+Hj8qt+Iywc39wWVUBixlNJQoez4Gnzdlji5avdIT0snlKIh8mM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371177; c=relaxed/simple;
	bh=Kcit5CA4vTs4RMwxjpt8VPjivGf4nauNqiLQ3xNz1dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faJ1EiLyoZrK3BXILw4LmZh69PFnU4WB1d/Urc7e0OmcQIs1/qI/HhUCQjnmj2gVge20P6B/UTI8EJxi/Sb9fHp84mwH83hvEh5aTQeves9h6mcbhPSiykawM37iQR6hIcCB0MR68+iyjROx6leF+mHeB1OdaxAt+edSbwQoei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kO+Lnfri; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fe7a61b3-627f-4e60-9bba-28a4d40d1ec8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731371167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPcxxtMej3Q9CrLa0p7MBeuTQqkwQgbrelNqYAfqzhE=;
	b=kO+LnfriD7MOhewKFJpty3IQAqd0dlGZ+c7DOynj4za0S9K9ZS9SETPO/8NRvjGAerVzvJ
	Q0jIfU5gyX6JGdptORBpAnVmzpRrvLyZVY5VNVdw0fYfpRl60xvFxEZoL/DFU8lHQVNHq8
	fOFrEnQrB+XfHDY836G2Zx//9t3WznE=
Date: Mon, 11 Nov 2024 16:25:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net 1/5] bpf: Register mptcp common kfunc set
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-0-cf16953035c1@kernel.org>
 <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-1-cf16953035c1@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241108-bpf-next-net-mptcp-bpf_iter-subflows-v1-1-cf16953035c1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/8/24 7:52 AM, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> MPTCP helper mptcp_sk() is used to convert struct sock to mptcp_sock.
> Helpers mptcp_subflow_ctx() and mptcp_subflow_tcp_sock() are used to
> convert between struct mptcp_subflow_context and sock. They all will
> be used in MPTCP BPF programs too.
> 
> This patch defines corresponding wrappers of them, and put the
> wrappers into mptcp common kfunc set and register the set with the
> flag BPF_PROG_TYPE_UNSPEC to let them accessible to all types of BPF
> programs.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>   net/mptcp/bpf.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 8a16672b94e2384f5263e1432296cbca1236bb30..6f96a5927fd371f8ea92cbf96c875edef9272b98 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -29,8 +29,46 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
>   	.set   = &bpf_mptcp_fmodret_ids,
>   };
>   
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
> +{
> +	return mptcp_sk(sk);
> +}
> +
> +__bpf_kfunc static struct mptcp_subflow_context *
> +bpf_mptcp_subflow_ctx(const struct sock *sk)
> +{
> +	return mptcp_subflow_ctx(sk);

This returns "struct mptcp_subflow_context *" without checking the sk is a mptcp 
subflow or not...

> +}
> +
> +__bpf_kfunc static struct sock *
> +bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> +{
> +	return mptcp_subflow_tcp_sock(subflow);

...and then the "struct mptcp_subflow_context *" can be used by this kfunc here. 
Is it really safe?

> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(bpf_mptcp_common_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_mptcp_sk)
> +BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx)
> +BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock)

All of them has no KF_TRUSTED_ARGS or KF_RCU, so the returned ptr is supposed to 
be read-only? Why are they needed and why bpf_rdonly_cast (aka the bpf_core_cast 
in libbpf) cannot be used?

pw-bot: cr

> +BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
> +	.owner	= THIS_MODULE,
> +	.set	= &bpf_mptcp_common_kfunc_ids,
> +};
> +
>   static int __init bpf_mptcp_kfunc_init(void)
>   {
> -	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +	int ret;
> +
> +	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
> +					       &bpf_mptcp_common_kfunc_set);
> +
> +	return ret;
>   }
>   late_initcall(bpf_mptcp_kfunc_init);
> 


