Return-Path: <bpf+bounces-48985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6264A12DED
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC24C1642FB
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1BE1DA61B;
	Wed, 15 Jan 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YG6Ujs69"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15D1D6DA3
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977739; cv=none; b=UQq8SAaT2b6vBbcLsU3+ATEX0fKvAjv3sFAdDQCK4ZNJzrPj8TH2cVGe2wGM7J7wFkKzhvWszTZA++cv96BWaj3pO3Oz/wROiy1f61gTSg8uw+jgrL2n1QczTZVi2mZ6QC/OuM24wS9tjnkd2P8LK/jTTA9al3Uz6k6r3N7f/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977739; c=relaxed/simple;
	bh=eNjDr+kbc/7tm2nrjTg/UAoANKa+ssxWp9ac77aL1a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdLXjC3OO/x8GLSpzx9lw0demGDQ9OPVW+fAwZnJ5AWf9D+wzs6QHW0JCVlbSZxdDPbOlLG9mHJu3CYXIh3wLeYeNxlsYPv/6JPv7sZ0Gb+7HRbAAYnOWedR4yaPZ81JK8dYub0qD9bLOR8iXBzxOhMnGz/e5TgiEHGt6LSoNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YG6Ujs69; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca852e76-2627-4e07-8005-34168271bf12@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736977725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52cb4GS2ZhRvjZmzSdZ0gUccl71Kegjj/jwbIqe2zTI=;
	b=YG6Ujs69KB38n0dMWzf+hWivnRcJm7Oc1f0FPikImV8gSO0fYhO1B2ipdTeoG/H+9RDc2c
	QblbG9Ca7lj/IcDibi8KRxyqspNqmurcvPUEX20JmhVm9eQUJeoEgeleR55zwp7KxuDGgS
	yf+l9tmr5NGO/YHbsPuY8O+Y7i20iEs=
Date: Wed, 15 Jan 2025 13:48:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 05/15] net-timestamp: add strict check in some
 BPF calls
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-6-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250112113748.73504-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/25 3:37 AM, Jason Xing wrote:
> In the next round, we will support the UDP proto for SO_TIMESTAMPING
> bpf extension, so we need to ensure there is no safety problem.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>   net/core/filter.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0e915268db5f..517f09aabc92 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5571,7 +5571,7 @@ static int __bpf_getsockopt(struct sock *sk, int level, int optname,
>   static int _bpf_getsockopt(struct sock *sk, int level, int optname,
>   			   char *optval, int optlen)
>   {
> -	if (sk_fullsock(sk))
> +	if (sk_fullsock(sk) && optname != SK_BPF_CB_FLAGS)
>   		sock_owned_by_me(sk);
>   	return __bpf_getsockopt(sk, level, optname, optval, optlen);
>   }
> @@ -5776,6 +5776,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>   	   int, level, int, optname, char *, optval, int, optlen)
>   {
>   	if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
> +	    bpf_sock->sk->sk_protocol == IPPROTO_TCP &&
>   	    optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {
>   		int ret, copy_len = 0;
>   		const u8 *start;
> @@ -5817,7 +5818,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
>   	struct sock *sk = bpf_sock->sk;
>   	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
>   
> -	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> +	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk) ||
> +	    sk->sk_protocol != IPPROTO_TCP)
>   		return -EINVAL;
>   
>   	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
> @@ -7626,6 +7628,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
>   	u8 search_kind, search_len, copy_len, magic_len;
>   	int ret;
>   
> +	if (bpf_sock->op != SK_BPF_CB_FLAGS)

SK_BPF_CB_FLAGS is not an op enum, so the check is incorrect. It does break the 
existing test.

./test_progs -t tcp_hdr_options
WARNING! Selftests relying on bpf_testmod.ko will be skipped.
#402/1   tcp_hdr_options/simple_estab:FAIL
#402/2   tcp_hdr_options/no_exprm_estab:FAIL
#402/3   tcp_hdr_options/syncookie_estab:FAIL
#402/4   tcp_hdr_options/fastopen_estab:FAIL
#402/5   tcp_hdr_options/fin:FAIL
#402/6   tcp_hdr_options/misc:FAIL
#402     tcp_hdr_options:FAIL
#402/1   tcp_hdr_options/simple_estab:FAIL
#402/2   tcp_hdr_options/no_exprm_estab:FAIL
#402/3   tcp_hdr_options/syncookie_estab:FAIL
#402/4   tcp_hdr_options/fastopen_estab:FAIL
#402/5   tcp_hdr_options/fin:FAIL
#402/6   tcp_hdr_options/misc:FAIL
#402     tcp_hdr_options:FAIL


Many changes of this set is in bpf and the newly added selftest is also a bpf 
prog, all bpf selftests should be run before posting. 
(Documentation/bpf/bpf_devel_QA.rst)

The bpf CI can automatically pick it up and get an auto email on breakage like 
this if the set is tagged to bpf-next. We can figure out where to land the set 
later (bpf-next/net or net-next/main) when it is ready.

All these changes also need a test in selftests/bpf. For example, I expect there 
is a test to ensure calling these bpf helpers from the new tstamp callback will 
get a negative errno value.

For patch 4 and patch 5, I would suggest keeping it simple to only check for 
bpf_sock->op for the helpers that make tcp_sock and/or locked sk assumption.
Something like this on top of your patch. Untested:

diff --git i/net/core/filter.c w/net/core/filter.c
index 517f09aabc92..ccb13b61c528 100644
--- i/net/core/filter.c
+++ w/net/core/filter.c
@@ -7620,6 +7620,11 @@ static const u8 *bpf_search_tcp_opt(const u8 *op, const 
u8 *opend,
  	return ERR_PTR(-ENOMSG);
  }

+static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
+{
+	return bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
+}
+
  BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
  	   void *, search_res, u32, len, u64, flags)
  {
@@ -7628,8 +7633,8 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct 
bpf_sock_ops_kern *, bpf_sock,
  	u8 search_kind, search_len, copy_len, magic_len;
  	int ret;

-	if (bpf_sock->op != SK_BPF_CB_FLAGS)
-		return -EINVAL;
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;

  	/* 2 byte is the minimal option len except TCPOPT_NOP and
  	 * TCPOPT_EOL which are useless for the bpf prog to learn


> +		return -EINVAL;
> +
>   	/* 2 byte is the minimal option len except TCPOPT_NOP and
>   	 * TCPOPT_EOL which are useless for the bpf prog to learn
>   	 * and this helper disallow loading them also.


