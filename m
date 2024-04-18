Return-Path: <bpf+bounces-27083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA38A8FDE
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5D81C214BB
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DFD4411;
	Thu, 18 Apr 2024 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sCJxWuUW"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65146FD5
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398904; cv=none; b=s0Og5bOR6/lG4FUWcjL3YL4TmgqyrNeKVlSSUvWSk10FLa0ZaA5kYfsKKoFHoIokWi8YP5xlkVeApRwe/mVN+E6TzuUKdJX+Yy1kUxIVTVXkpu/J4BV5nLi4kKG4rhmjzBaO2R3y9pMhRb0sAAsmJpNkl/K17SoEkillJCc5C98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398904; c=relaxed/simple;
	bh=k9c0hts+lV5JOwyfCJVo7lsVLoSNv34VOhVc26YLU5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWaK5oG2Nhe+CLI1+EPY+ie2mzTJwKl/3XrrJy1SSUT0UHrTY9bGjWdx8zCf4FoyXAR/tI5MdtZ9K7fI5eWWx6BMuJKtTj/m8f9R1PKfUhR9e5YsRwEsW9aCmJ5GVP//NBBDUzhgI9XrNHpT8Xz86yDjQYHCvuaUnHpAd4fdglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sCJxWuUW; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c64339b-70c0-40d4-94a5-75c8bdfb08ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713398899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvZxMsXfTKhjdGmOfsDIkj9MQHrTR8MCNdFlNNRoLbM=;
	b=sCJxWuUWKX8S9p2T5Jj9DKoYa0eKdIicY2unJOLfwJOvPX/Ch+YrzXB1PxR8i79WBnPzwm
	/RjbqHPjqkmU5JDx4nUxdyh3w83ZKYaSodzMJNNqBVCJlriDLG3bvFMlBiK9rXVW1feBUr
	SqdI90HRejSJzDExO9X7cOfFKib0x7w=
Date: Wed, 17 Apr 2024 17:08:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 02/14] selftests/bpf: Add start_server_addr*
 helpers
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
 <48186b788bc029cbd3a47007175c83357fa28668.1713262052.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <48186b788bc029cbd3a47007175c83357fa28668.1713262052.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/16/24 3:13 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In order to pair up with connect_to_addr(), this patch adds a new helper
> start_server_addr(), and another one start_server_addr_opts(), which is
> a wrapper of __start_server(), only added a network_helper_opts arg at
> the end.
> 
> They all accept an argument 'addr' of 'struct sockaddr_storage' type
> instead of a string type argument like start_server().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 16 ++++++++++++++++
>   tools/testing/selftests/bpf/network_helpers.h |  3 +++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index 563dde8617dd..836436688ca6 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -185,6 +185,22 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
>   	return NULL;
>   }
>   
> +int start_server_addr_opts(int type, const struct sockaddr_storage *addr, socklen_t len,
> +			   const struct network_helper_opts *opts)

I meant to only add one helper with the "opts" arg in v2 instead of adding two 
helpers. I want to minimize the number of new helpers and each just has 
different variants of args. timeout_ms usually makes sense, so opts is usually 
required.

Thinking a bit more. A small nit from my v2 comment. Name this as 
start_server_addr() without the "_opts" part. Keep it short. I want the default 
helper has the opts arg from now other than a few exceptions like close_netns(), 
get_socket_local_port()...etc. No need to change other existing helpers. Stay 
with start_server_addr() and connect_to_addr() in this set.

so,

int start_server_addr(int type, const struct sockaddr_storage *addr,
		      socklen_t len, const struct network_helper_opts *opts);

opts could be NULL.

pw-bot: cr

> +{
> +	return __start_server(type, 0, (struct sockaddr *)addr, len,
> +			      opts->timeout_ms, 0);
> +}
> +
> +int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len)
> +{
> +	struct network_helper_opts opts = {
> +		.timeout_ms = 0,
> +	};
> +
> +	return start_server_addr_opts(type, addr, len, &opts);
> +}
> +
>   void free_fds(int *fds, unsigned int nr_close_fds)
>   {
>   	if (fds) {
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index ac4da5fdcc95..9e6fcc89a8d0 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -53,6 +53,9 @@ int start_mptcp_server(int family, const char *addr, __u16 port,
>   int *start_reuseport_server(int family, int type, const char *addr_str,
>   			    __u16 port, int timeout_ms,
>   			    unsigned int nr_listens);
> +int start_server_addr_opts(int type, const struct sockaddr_storage *addr, socklen_t len,
> +			   const struct network_helper_opts *opts);
> +int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len);
>   void free_fds(int *fds, unsigned int nr_close_fds);
>   int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len);
>   int connect_to_fd(int server_fd, int timeout_ms);


