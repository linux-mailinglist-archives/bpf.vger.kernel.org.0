Return-Path: <bpf+bounces-49726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04613A1BFA9
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742683AC374
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 00:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3228F800;
	Sat, 25 Jan 2025 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uGEH8LX1"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFBB29A1
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737764913; cv=none; b=m5AeHgUKuMYUgmGK30XKA7AEIaVezKjLlrv2/TcRv9J4DA2b5iufCn9WbG9nwCmf8OgHK6ZQNcs8qz02DmKjlgTiI68ZJ9X3wKKL3Va3LGp4PjUwDCYCM0PT0usarWbUs2Gtgqk0U0ZWHA74B4Pg2VlSxjIL9VgkscvgK+clk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737764913; c=relaxed/simple;
	bh=TuSPT1qLVeeb7VF9+cWDVcHqdIZM7Q8Tgdks0Y7iFWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejNXi4vVd+txxE4/6+agxSjBlkgLq8eOxGDEpupiYjRrd9BSgO5Fpcl6OMqjXGFIJbeNVvaoxKnX/cZyJThVLvLC5+LFVvv1KNIMVvImNcMsGP2XDT8/NUO9N2ot4aTYh34ZfEzdi65ACgnmCQoT2FQ+PxTcAp5S+J2ylU16CyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uGEH8LX1; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737764896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPQmh569ZJMlE2Jni4mJvUt8Eavz75WSWbCuQpS2OLU=;
	b=uGEH8LX1UgYPg57C6fPUGV8KB9H4ZwJx6Ce0dsXW9CxYnoOQ37N4RD27jVAq7cZTgehCnF
	Q5lIo06Ioh7XprzcVzRq6KlDe+wxeqFXLLFiKxUmKq08ZGrQTYy5WKk65/c6JhW6EyV2wh
	n8ih3MrUiDShsxVZlkMBcJ5Nhscs5Z0=
Date: Fri, 24 Jan 2025 16:28:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP
 fields in sock_op BPF CALLs
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-5-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250121012901.87763-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/25 5:28 PM, Jason Xing wrote:
> In the next round, we will support the UDP proto for SO_TIMESTAMPING
> bpf extension, so we need to ensure there is no safety problem, which
> is ususally caused by UDP socket trying to access TCP fields.
> 
> These approaches can be categorized into two groups:
> 1. add TCP protocol check
> 2. add sock op check

Same as patch 3. The commit message needs adjustment. I would combine patch 3 
and patch 4 because ...

> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/core/filter.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index fdd305b4cfbb..934431886876 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5523,6 +5523,11 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
>   	return -EINVAL;
>   }
>   
> +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
> +{
> +	return bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB;

More bike shedding...

After sleeping on it again, I think it can just test the 
bpf_sock->allow_tcp_access instead.


> +}
> +
>   static int _bpf_setsockopt(struct sock *sk, int level, int optname,
>   			   char *optval, int optlen)
>   {
> @@ -5673,7 +5678,12 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
>   BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>   	   int, level, int, optname, char *, optval, int, optlen)
>   {
> -	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
> +	struct sock *sk = bpf_sock->sk;
> +
> +	if (is_locked_tcp_sock_ops(bpf_sock) && sk_fullsock(sk))

afaict, the new timestamping callbacks still can do setsockopt and it is 
incorrect. It should be:

	if (!bpf_sock->allow_tcp_access)
		return -EOPNOTSUPP;

I recalled I have asked in v5 but it may be buried in the long thread, so asking 
here again. Please add test(s) to check that the new timestamping callbacks 
cannot call setsockopt and read/write to some of the tcp_sock fields through the 
bpf_sock_ops.

> +		sock_owned_by_me(sk);

Not needed and instead...

> +
> +	return __bpf_setsockopt(sk, level, optname, optval, optlen);

keep the original _bpf_setsockopt().

>   }
>   
>   static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
> @@ -5759,6 +5769,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>   	   int, level, int, optname, char *, optval, int, optlen)
>   {
>   	if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
> +	    bpf_sock->sk->sk_protocol == IPPROTO_TCP &&
>   	    optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {

No need to allow getsockopt regardless what SOL_* it is asking. To keep it 
simple, I would just disable both getsockopt and setsockopt for all SOL_* for 
the new timestamping callbacks. Nothing is lost, the bpf prog can directly read 
the sk.

>   		int ret, copy_len = 0;
>   		const u8 *start;
> @@ -5800,7 +5811,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
>   	struct sock *sk = bpf_sock->sk;
>   	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
>   
> -	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> +	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk) ||
> +	    sk->sk_protocol != IPPROTO_TCP)

Same here. It should disallow this "set" helper for the timestamping callbacks 
which do not hold the lock.

>   		return -EINVAL;
>   
>   	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
> @@ -7609,6 +7621,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
>   	u8 search_kind, search_len, copy_len, magic_len;
>   	int ret;
>   
> +	if (!is_locked_tcp_sock_ops(bpf_sock))
> +		return -EOPNOTSUPP;

This is correct, just change it to "!bpf_sock->allow_tcp_access".

All the above changed helpers should use the same test and the same return handling.

> +
>   	/* 2 byte is the minimal option len except TCPOPT_NOP and
>   	 * TCPOPT_EOL which are useless for the bpf prog to learn
>   	 * and this helper disallow loading them also.


