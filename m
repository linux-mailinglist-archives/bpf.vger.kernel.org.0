Return-Path: <bpf+bounces-73908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53ABC3DD88
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 00:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46067188739A
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04363222594;
	Thu,  6 Nov 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rL7RkmA6"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE434D3AE
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471792; cv=none; b=bvAziGQVQWjMlv1mq/kAHpMjS07NF9+ByCxiOrunKqtOa3RdJlk16jDPAaG3wsbXgKNitWZFUHfLNkzF+cMxZO5rICjMrcvpJfCfcw9VB7Tn6ohqJFGQSWrXpxwkrK2W82c2pcdfkmVY/9pHThulegZ5hFDpNPYHxw0lJ1crBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471792; c=relaxed/simple;
	bh=IZsbsvD6VdbkSJeqICAb4/zYF9wEny5Gu/vznxODllw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4xs2yjXSvaP/aVDsmZ93MxUCHDFGY71SZXA2Zhe2jwsjrAAvvLvLqgDfrDPT2VeZUDeT4v4b6tG0MJUpcsn0A0fktjZAUyVxCiaEv41brj2BzhGTIpXOrYVoB2CWJEmRZTxRGqYmiccqYiD1cqp3j1aV+Il79MMvADif+YosF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rL7RkmA6; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f7ef09d8-d48a-4df7-99b7-c5f3c422cfa3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762471778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUfRbFpMkZjHgLZGCIbIhg4jivnYxpp+H4gCu5s3EEI=;
	b=rL7RkmA6YseGsoWHt7KKIdbPnjxFzi5T/K7ev2MZ5hBT4rqgr8/C5HdsFMGyloV9LWpCxv
	0b9+5l863s6QyQNvDIOSGpb+JgNmUTe1LuGMZ+Cv5z3CM2bhudToLb3ln4spVAzfOkgzVH
	aPlT/etK4/4z88zv11NSw85PGvRfyvw=
Date: Thu, 6 Nov 2025 15:29:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: use start_server_str rather
 than start_reuseport_server in tc_tunnel
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251105-start-server-soreuseaddr-v1-0-1bbd9c1f8d65@bootlin.com>
 <20251105-start-server-soreuseaddr-v1-2-1bbd9c1f8d65@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251105-start-server-soreuseaddr-v1-2-1bbd9c1f8d65@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/5/25 12:22 AM, Alexis Lothoré (eBPF Foundation) wrote:
> Now that start_server_str enforces SO_REUSEADDR, there's no need to keep
> using start_reusport_server in tc_tunnel, especially since it only uses
> one server at a time.
> 
> Replace start_reuseport_server with start_server_str in tc_tunnel test.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>   .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 27 ++++++++++++----------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> index deea90aaefad..4d29256d8714 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
> @@ -69,7 +69,7 @@ struct subtest_cfg {
>   	int client_egress_prog_fd;
>   	int server_ingress_prog_fd;
>   	char extra_decap_mod_args[TUNNEL_ARGS_MAX_LEN];
> -	int *server_fd;
> +	int server_fd;
>   };
>   
>   struct connection {
> @@ -135,16 +135,18 @@ static int run_server(struct subtest_cfg *cfg)
>   {
>   	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
>   	struct nstoken *nstoken;
> +	struct network_helper_opts opts = {
> +		.timeout_ms = TIMEOUT_MS
> +	};
>   
>   	nstoken = open_netns(SERVER_NS);
>   	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
>   		return -1;
>   
> -	cfg->server_fd = start_reuseport_server(family, SOCK_STREAM,
> -						cfg->server_addr, TEST_PORT,
> -						TIMEOUT_MS, 1);
> +	cfg->server_fd = start_server_str(family, SOCK_STREAM, cfg->server_addr,
> +					  TEST_PORT, &opts);
>   	close_netns(nstoken);
> -	if (!ASSERT_OK_PTR(cfg->server_fd, "start server"))
> +	if (!ASSERT_OK_FD(cfg->server_fd, "start server"))
>   		return -1;
>   
>   	return 0;
> @@ -152,7 +154,7 @@ static int run_server(struct subtest_cfg *cfg)
>   
>   static void stop_server(struct subtest_cfg *cfg)
>   {
> -	free_fds(cfg->server_fd, 1);
> +	close(cfg->server_fd);
>   }
>   
>   static int check_server_rx_data(struct subtest_cfg *cfg,
> @@ -188,7 +190,7 @@ static struct connection *connect_client_to_server(struct subtest_cfg *cfg)
>   		return NULL;
>   	}
>   
> -	server_fd = accept(*cfg->server_fd, NULL, NULL);
> +	server_fd = accept(cfg->server_fd, NULL, NULL);
>   	if (server_fd < 0) {
>   		close(client_fd);
>   		free(conn);
> @@ -394,29 +396,30 @@ static void run_test(struct subtest_cfg *cfg)
>   
>   	/* Basic communication must work */
>   	if (!ASSERT_OK(send_and_test_data(cfg, true), "connect without any encap"))
> -		goto fail;
> +		goto fail_close_server;
>   
>   	/* Attach encapsulation program to client */
>   	if (!ASSERT_OK(configure_encapsulation(cfg), "configure encapsulation"))
> -		goto fail;
> +		goto fail_close_server;
>   
>   	/* If supported, insert kernel decap module, connection must succeed */
>   	if (!cfg->expect_kern_decap_failure) {
>   		if (!ASSERT_OK(configure_kernel_decapsulation(cfg),
>   					"configure kernel decapsulation"))
> -			goto fail;
> +			goto fail_close_server;
>   		if (!ASSERT_OK(send_and_test_data(cfg, true),
>   			       "connect with encap prog and kern decap"))
> -			goto fail;
> +			goto fail_close_server;
>   	}
>   
>   	/* Replace kernel decapsulation with BPF decapsulation, test must pass */
>   	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
> -		goto fail;
> +		goto fail_close_server;
>   	ASSERT_OK(send_and_test_data(cfg, true), "connect with encap and decap progs");
>   
>   fail:
>   	stop_server(cfg);
> +fail_close_server:

The "fail" and "fail_close_server" ordering is incorrect. I took this 
chance to simplify it by doing run_server() before open_netns().

Applied. Thanks.
>   	close_netns(nstoken);
>   }
>   
> 


