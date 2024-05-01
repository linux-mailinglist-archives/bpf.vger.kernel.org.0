Return-Path: <bpf+bounces-28313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9508B83CA
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 02:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE541C21EA7
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8419B442C;
	Wed,  1 May 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSkTurmd"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE8846F
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524052; cv=none; b=tLc8Jc+WWxTN8pFn7jR2J70pbjkgs4wfTfgdaF4qVgsHJ1kBStedREtqdvsjO90VJaxYAOQrRc1udoh9zjv/cx9xHaLemdT75cO08dfX4nw4OtmxcfAO5GBft0Qu0Q7g8qLDLXQV35rOJhx35RtelZjJ//+gTmpHuqP/6yTZsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524052; c=relaxed/simple;
	bh=DvRZn0YkYoGOFeC6Hd6FMkq8OBughIT3EN9z+cXbVyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KW/EAc5uZgYFilbU7DgtcTV6QjXrx9ogpSNx1R9jv/zLpTbE7NUgF3niu6B5BeIvEnsGvd8hC0y3d1g+6Rb9Jtu75rHThuOOQ39F/vux0U4cs4twPDSkSKltlI6thg9FhVFxVBvz8xZkkMFNiGY4Abx8PmBGi6U5cSTvmHkv5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSkTurmd; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5148f33-cb4f-4e84-8182-b68a9c038d3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714524047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsLhW8OsAHNbWQn+96nTp6LroytLS+VC0zUDcZpqbG0=;
	b=GSkTurmd2UjQEf8zH5Jm26HqtN435YPprfcoop4FO2pBweiJXm4cG4n8k42YrVbg6L837W
	p4UxJjUS3JxYLqL60X4rC2EpMsT/fN1VyByowadgL/T+LTIkkwV8odHiQBbdlyYNqjc4SQ
	8sss4JPJy8l1mF57ynqNVD/kfEVOjzM=
Date: Tue, 30 Apr 2024 17:40:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/6] selftests/bpf: Add setsockopt for
 network_helper_opts
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
References: <cover.1714014697.git.tanggeliang@kylinos.cn>
 <0f676d51126bf7c260a71cfb60df0d1acb23e552.1714014697.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0f676d51126bf7c260a71cfb60df0d1acb23e552.1714014697.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/24/24 8:23 PM, Geliang Tang wrote:
> +static int setsockopt_reuseport(int fd, const void *optval, socklen_t optlen)
> +{
> +	return setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, optval, optlen);
>   }
>   

[ ... ]

>   void free_fds(int *fds, unsigned int nr_close_fds)
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index c62b54daa914..540ecfc52bd7 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -28,6 +28,9 @@ struct network_helper_opts {
>   	bool noconnect;
>   	int type;
>   	int proto;
> +	int (*setsockopt)(int fd, const void *optval, socklen_t optlen);
> +	const void *optval;
> +	socklen_t optlen;

optval and optlen could be in the stack of the (*setsockopt) callback.
e.g. the "int on;" could be local to the setsockopt_reuseport() instead of 
adding optval/len to the network_helper_opts. Passing one optval in 
network_helper_opts could be less flexible when we want to do multiple 
setsockopt() after socket().

Another nit I would like to make, rename this from (*setsockopt) to 
(*post_socket_cb) because this callback could do more than setsockopt, e.g. 
adding a sk local storage to a socket fd before bind(). Also, add a "const 
struct post_socket_opts *opts" for future extension, Like:

struct post_socket_opts {};

int (*post_socket_cb)(int fd, const struct post_socket_opts *opts);

Patch 6 will need two setsockopt cb functions because of different optval but I 
believe the tradeoff is worth it for this callback doing more than just one 
setsockopt.

Patch 1 to 3 have been applied. Thanks.


