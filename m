Return-Path: <bpf+bounces-33823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC833926B0F
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDFD287832
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF759191F9E;
	Wed,  3 Jul 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WENO2WB/"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2520191F80
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043946; cv=none; b=g07TphEF7DPTfuu+QSw90ZkjnkRMA7Ho0Gqgc76Jeo1uymb+EAaxfUrOx6N1wEzT5PLeIngEs+VUIuGPEJaMHl+ujzq4Fj0+J4uEu3emRKE5tqT6oMpv5bz4nuDc6+LXWROfUpy0k7bGUm1v6kddFMfTvqvgL/khCt3NGeU0AQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043946; c=relaxed/simple;
	bh=jTceZ6tcMFtSLFYUf7A45plpGk9lmqX7LBCs/KBdXMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpDVBGM8jo/xEiGQXF3IW8OCMS7jj75fSUqXskjlFPwfbz1UssCBWXdD14H6fzw5/U4q53XDGJ1sBwUPQDG7gDfg9ST43AnWqIyenbvlDHEkhFY3o2hdDuADtv4QCeC+mJJ30mrhXZUdtKCQS3FItRp8HwZeQJaC7JkVGf26n1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WENO2WB/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720043941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+fen3yivM0mQuV5qiw5nLhixaTvtW1b4Tkj9KwU5CqI=;
	b=WENO2WB/coqXpb4NZTAWc7p17euc8VAG1uOSHKlbGhmiYS5Gh9T7aUY1cxki1vVMl4DWgf
	Rd//tMySf1BczcWGn3II/wfvOc0ioMWj2JrfJCFL4KB0gi/MsLsxOGGl/KPqSklJMy5upb
	vPWEkG8E1w+xMz2FeYguZxDGMIhRuE0=
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: mykolal@fb.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: shuah@kernel.org
X-Envelope-To: tanggeliang@kylinos.cn
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kselftest@vger.kernel.org
Message-ID: <b4c79f80-577a-4372-b32d-33587077d6b5@linux.dev>
Date: Wed, 3 Jul 2024 14:58:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 8/9] selftests/bpf: Use connect_to_addr in
 sk_lookup
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
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
 <d5caa0c6f5912a67876c250214a84b0dcd4f74e0.1719623708.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <d5caa0c6f5912a67876c250214a84b0dcd4f74e0.1719623708.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/28/24 6:20 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Use public network helpers make_sockaddr() and connect_to_addr() instead
> of using the local defined function make_socket() and connect().
> 
> This make_socket() can be dropped latter.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/sk_lookup.c      | 20 +++++++------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> index 38382dffe997..005776f5964e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
> @@ -231,23 +231,17 @@ static int make_server(int sotype, const char *ip, int port,
>   
>   static int make_client(int sotype, const char *ip, int port)
>   {
> +	int family = is_ipv6(ip) ? AF_INET6 : AF_INET;
> +	struct network_helper_opts opts = {
> +		.timeout_ms = IO_TIMEOUT_SEC,
> +	};
>   	struct sockaddr_storage addr = {0};
> -	int err, fd;
> +	socklen_t len;
>   
> -	fd = make_socket(sotype, ip, port, &addr);
> -	if (fd < 0)
> +	if (make_sockaddr(family, ip, port, &addr, &len))

Depending on the callers of make_client ASSERT or not,
I suspect it is easier to ASSERT here to signal the error in make_sockaddr.

>   		return -1;
>   
> -	err = connect(fd, (void *)&addr, inetaddr_len(&addr));
> -	if (CHECK(err, "make_client", "connect")) {
> -		log_err("failed to connect client socket");
> -		goto fail;
> -	}
> -
> -	return fd;
> -fail:
> -	close(fd);
> -	return -1;
> +	return connect_to_addr(sotype, &addr, len, &opts);

same here for the connect_to_addr().

pw-bot: cr

>   }
>   
>   static __u64 socket_cookie(int fd)


