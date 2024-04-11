Return-Path: <bpf+bounces-26581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFDE8A2193
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 00:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BF4B2217F
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 22:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73443BBE3;
	Thu, 11 Apr 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2hgHFzU"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B52E3EF
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873201; cv=none; b=eX4gjLw4Mzs06FAa0AUZ63fcMcbfthOltG8ZK9ND4fN9eMDHmcI/hfBu5U3RLjtjjFHqWy+s9aevFUoWUXMxaNaDuIB8wOXJcohXzKqPY4SywW3mFLLGLZfiakUUEx34Tlty0dBYQfvJRDRHRfzT8lYeCeqk5eXSqCQOX6snhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873201; c=relaxed/simple;
	bh=0Xyv19EghUifd9+9xgpuBxGMiVy/Mahmkwft001FzSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ydp7YW/JXpwnaJtN5iz64HrSD9ae5/vp2s1DSnEZ5BGWUn74SaAnzcrkfxqbBL+mvUvphsKt+Y0FuRut+zf/FQbubvnl99K8pU+6eKbhyfUXNxBR8p1xRTtr2QCts4NDR+sqbvPsZFvglWXXjnQaQE50qEa0RBKhBEwQk1bAOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2hgHFzU; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4bd4b9a-e1bb-4df3-8c25-90546983c3ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712873196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDVdF6u7LoJwrJJMazph9x80XfQux0mBz6DzY3CMbJc=;
	b=r2hgHFzUHxQtMKKL/B6AuxGaj1HNL1cwsDql3DE4FoSV/PAP1iTqp/1G12Epb9SYFhx67J
	/olMFh8J2wYNZt04+bylE9YrV1WlKpKr4ziS19CNSSq60UhVZTi1rjpVLrLPeFiXbQddxi
	cFWlZCuajf+D3kTXTkgLokWkU5uc87M=
Date: Thu, 11 Apr 2024 15:06:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 01/14] selftests/bpf: Add start_server_addr
 helper
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
 <504f2687adeeeb15eba0038be473fa98a865a6d8.1712796967.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <504f2687adeeeb15eba0038be473fa98a865a6d8.1712796967.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/10/24 6:03 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In order to pair up with connect_to addr(), this patch adds a new helper
> start_server_addr(), which is a wrapper of __start_server(), and accepts an
> argument 'addr' of 'struct sockaddr' type instead of a string type argument
> like start_server().

Thanks for the cleanup work in the set.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 5 +++++
>   tools/testing/selftests/bpf/network_helpers.h | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index ca16ef2b648e..7ddeb6698ec7 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -185,6 +185,11 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
>   	return NULL;
>   }
>   
> +int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type)

nit. Move "int type" to the first argument which is closer to how the socket 
syscall is doing it. It is unfortunate that the existing connect_to_addr() has 
it at the last arg but its usage seems to be limited to sock_addr.c, so should 
be an easy change.

Although there is an "addrlen", connect_to_addr() and some other helpers are 
using "sockaddr_storage" instead of "sockaddr", so may as well use that to have 
a consistent usage.

Also add a network_helper_opts arg at the end for the future needs (e.g. 
timeout), so something like this:

int start_server_addr_opts(int type, const struct sockaddr_storage *addr,
			   socklen_t addrlen,
			   const struct network_helper_opts *opts);

pw-bot: cr

> +{
> +	return __start_server(type, 0, addr, addrlen, 0, 0);
> +}
> +
>   void free_fds(int *fds, unsigned int nr_close_fds)
>   {
>   	if (fds) {
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 70f4e4c92733..89f59b65ce76 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -53,6 +53,7 @@ int start_mptcp_server(int family, const char *addr, __u16 port,
>   int *start_reuseport_server(int family, int type, const char *addr_str,
>   			    __u16 port, int timeout_ms,
>   			    unsigned int nr_listens);
> +int start_server_addr(const struct sockaddr *addr, socklen_t addrlen, int type);
>   void free_fds(int *fds, unsigned int nr_close_fds);
>   int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
>   int connect_to_fd(int server_fd, int timeout_ms);


