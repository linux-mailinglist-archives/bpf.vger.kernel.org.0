Return-Path: <bpf+bounces-12730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F177D024A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F461C20F2E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D038DF1;
	Thu, 19 Oct 2023 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d+FTlL4N"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C12FE0F
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 19:12:14 +0000 (UTC)
Received: from out-207.mta0.migadu.com (out-207.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cf])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB0BE
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 12:12:12 -0700 (PDT)
Message-ID: <1074c1f1-e676-fbe6-04bc-783821d746a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697742730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0h5fWMyT5Vo7k2V5ZPXS3Hx5Ml7GFIc3I0D99ZWvRU=;
	b=d+FTlL4N6Sg5LI52khLUWtya9wxh3NUBk02cIuaOnCLy+SLqFNSa5lIBw8RSaHQ725A9gd
	snoj8Tm3/rt+fez+p3f/x75NDTq0AcO+LumuU/EybX4CSNIYRVU2FjzDFxUR3euju4mNcA
	oT/hqzu2F5LYIUr8MbDVOUBmmPWg1Ig=
Date: Thu, 19 Oct 2023 12:12:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 04/11] net/socket: Break down __sys_getsockopt
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 David Howells <dhowells@redhat.com>, sdf@google.com, axboe@kernel.dk,
 asml.silence@gmail.com, willemdebruijn.kernel@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, krisman@suse.de, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20231016134750.1381153-1-leitao@debian.org>
 <20231016134750.1381153-5-leitao@debian.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231016134750.1381153-5-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/23 6:47 AM, Breno Leitao wrote:
> diff --git a/net/socket.c b/net/socket.c
> index 0087f8c071e7..f4c156a1987e 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2350,6 +2350,42 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
>   INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>   							 int optname));
>   
> +int do_sock_getsockopt(struct socket *sock, bool compat, int level,
> +		       int optname, sockptr_t optval, sockptr_t optlen)
> +{
> +	int max_optlen __maybe_unused;
> +	const struct proto_ops *ops;
> +	int err;
> +
> +	err = security_socket_getsockopt(sock, level, optname);
> +	if (err)
> +		return err;
> +
> +	ops = READ_ONCE(sock->ops);
> +	if (level == SOL_SOCKET) {
> +		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
> +	} else if (unlikely(!ops->getsockopt)) {
> +		err = -EOPNOTSUPP;
> +	} else {
> +		if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
> +			      "Invalid argument type"))
> +			return -EOPNOTSUPP;
> +
> +		err = ops->getsockopt(sock, level, optname, optval.user,
> +				      optlen.user);
> +	}
> +
> +	if (!compat) {
> +		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);

The max_optlen was done before the above sk_getsockopt. The bpf CI cannot catch 
it because it cannot apply patch 5 cleanly. I ran the following out of the 
linux-block tree:

$> ./test_progs -t sockopt_sk
test_sockopt_sk:PASS:join_cgroup /sockopt_sk 0 nsec
run_test:PASS:skel_load 0 nsec
run_test:PASS:setsockopt_link 0 nsec
run_test:PASS:getsockopt_link 0 nsec
(/data/users/kafai/fb-kernel/linux/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c:111: 
errno: Operation not permitted) Failed to call getsockopt, ret=-1
run_test:FAIL:getsetsockopt unexpected error: -1 (errno 1)
#217     sockopt_sk:FAIL


> +		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
> +						     optval, optlen, max_optlen,
> +						     err);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(do_sock_getsockopt);
> +
>   /*
>    *	Get a socket option. Because we don't know the option lengths we have
>    *	to pass a user mode parameter for the protocols to sort out.
> @@ -2357,37 +2393,18 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>   int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
>   		int __user *optlen)
>   {
> -	int max_optlen __maybe_unused;
> -	const struct proto_ops *ops;
>   	int err, fput_needed;
>   	struct socket *sock;
> +	bool compat;
>   
>   	sock = sockfd_lookup_light(fd, &err, &fput_needed);
>   	if (!sock)
>   		return err;
>   
> -	err = security_socket_getsockopt(sock, level, optname);
> -	if (err)
> -		goto out_put;
> -
> -	if (!in_compat_syscall())
> -		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);

The old max_optlen was done here.

> +	compat = in_compat_syscall();
> +	err = do_sock_getsockopt(sock, compat, level, optname,
> +				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
>   
> -	ops = READ_ONCE(sock->ops);
> -	if (level == SOL_SOCKET)
> -		err = sock_getsockopt(sock, level, optname, optval, optlen);
> -	else if (unlikely(!ops->getsockopt))
> -		err = -EOPNOTSUPP;
> -	else
> -		err = ops->getsockopt(sock, level, optname, optval,
> -					    optlen);
> -
> -	if (!in_compat_syscall())
> -		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
> -						     USER_SOCKPTR(optval),
> -						     USER_SOCKPTR(optlen),
> -						     max_optlen, err);
> -out_put:
>   	fput_light(sock->file, fput_needed);
>   	return err;
>   }


