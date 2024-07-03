Return-Path: <bpf+bounces-33817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E45926ACC
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72599283DB0
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53C1946AC;
	Wed,  3 Jul 2024 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kdp7hLqN"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C61946AB
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043296; cv=none; b=O13qu/V2KAYaVO0ixY8zGZ2rXR8X7fwfDV58LQ53qdMNoMtacZe5X9A/Lnvw6DU3fiJNPTVdUMTyxvYgG7iuABfbgO1he7EIulGnnDlP33t6vt95JGRFeESpwbbKtb01LxmN6u0KtQEcjzm8faAeBhO8xRNyR1iSNxhpPM1EqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043296; c=relaxed/simple;
	bh=aGqY2f9w8k6TMDeD80hbbCNcujbWoq3ezHj/oYCB7HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHLUQMM7csXnESifkrtuiAi+1BTwdk0nKSxMQN3s5yzGL2cVu1EY+/H9U0jEcIoS6Ny7WXIo1wBqiPDDK15bLXqTDQs4SkpTdgjuaxiY3jD1DDT7CGSzlZzNPVK4HIplra/zs5zhTnx8/eij9df8WVtaInPOhBervV/Di/Dw6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kdp7hLqN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: geliang@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720043291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr5gYmUQFKlrGY9DoONKtRg3thxQwpfyij0ObcbpoVw=;
	b=Kdp7hLqNEqw2be0I9ULWlMUtDhMDi7gmtIBGX8oOZisar315zx9SGaeJ1ZOhM3YDrlKeUU
	vkplzWoWvUpP4cIlIqjv8WXCmenDNA6QJxD/pYhAev1VhlxPgBLRynK4ALNfb78EGpRQl8
	/xJYA30w0hpUlTQjF1gFGurgZRH2eSo=
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
Message-ID: <2a28f341-a9a5-4162-8ff0-aad315a74c4f@linux.dev>
Date: Wed, 3 Jul 2024 14:47:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/9] selftests/bpf: Use connect_to_fd in
 sockmap_ktls
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
 <98ed2cd91b180e637c8011b8d035b4d8bf57abc3.1719623708.git.tanggeliang@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <98ed2cd91b180e637c8011b8d035b4d8bf57abc3.1719623708.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/28/24 6:20 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Use public network helper connect_to_fd() instead of open-coding it in
> prog_tests/sockmap_ktls.c. This can avoid duplicate code.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   .../selftests/bpf/prog_tests/sockmap_ktls.c        | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> index 4dc7933bb556..a6b0ed633505 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> @@ -24,26 +24,16 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
>   	struct network_helper_opts opts = {
>   		.backlog = SOMAXCONN,
>   	};
> -	struct sockaddr_storage addr = {0};
> -	socklen_t len = sizeof(addr);
>   	int err, cli, srv, zero = 0;
>   
>   	srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
>   	if (srv == -1)
>   		return;
>   
> -	err = getsockname(srv, (struct sockaddr *)&addr, &len);
> -	if (!ASSERT_OK(err, "getsockopt"))
> -		goto close_srv;
> -
> -	cli = socket(family, SOCK_STREAM, 0);
> -	if (!ASSERT_GE(cli, 0, "socket"))
> +	cli = connect_to_fd(srv, 0);

This patch looks good.

I would go for the newer connect_to_fd_opts() and stop using the older 
connect_to_fd() in the new code. I just notice there is a newly added "int type" 
argument in the connect_to_fd_opts(). I don't see the "int type" argument is 
useful after removing the connect_to_fd_opts() usage from ip_check_defrag.c. 
This cleanup can be left to a separate patch set. The current patch can stay 
with the older connect_to_fd() for now.

> +	if (!ASSERT_GE(cli, 0, "connect_to_fd"))
>   		goto close_srv;
>   
> -	err = connect(cli, (struct sockaddr *)&addr, len);
> -	if (!ASSERT_OK(err, "connect"))
> -		goto close_cli;
> -
>   	err = bpf_map_update_elem(map, &zero, &cli, 0);
>   	if (!ASSERT_OK(err, "bpf_map_update_elem"))
>   		goto close_cli;


