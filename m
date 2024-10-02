Return-Path: <bpf+bounces-40776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7F98E16E
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A73A1C20CC8
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45B1D131B;
	Wed,  2 Oct 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nzGoO/pN"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE99F1D150D
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888499; cv=none; b=fhQLVMzp1uEI9c3QKmeiGR7iBOnrduhBuHs19ezwNLMWKmGqyL09F7zVz+cn+Q3Ec3se4/Vgkb0nuuqUVAfoKESkgYnwWDYE0g+Qtx8NzvalEjiK36177OGgNrgWoALv744Oxk2RuUrJQv6rUaxKuWe/WdF8hN0stZyhBXQfE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888499; c=relaxed/simple;
	bh=577fAuiY7k/W2o9T9JdM0OPHd/iJA/K86pGSr+nSf4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwfWdklKJmWuvEEqqlhxPIaVmDH4U//dX52bY+w5rVoqt7+Dx9OayUk/VrPgfzWDxEImSer6gJMxlqeIMAG21gMw8G2/A+h2r/aAJI2Riqesbe5IOj7l0x9zVU0VQVL8FUGb8my9dldi3E2Ww6IX1bj4AuWXPRoIPT9CX4lVIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nzGoO/pN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3zt1X3mjNNbRXgA9ovCNYcAwOmhj3f5kzmFTM14l448=; b=nzGoO/pNX99+s3tjWNFPPxgs6d
	6YBtF/GyR5VXJNsSn4vny6/OZOwbDSCb4BsDRv5lz3DZcj1UjEEUxi+muZdNtcSmgomNV1pdxwzai
	mJkIhhEWV1AOIYolypFZG7iTok/00LyfJ3GyJFqoACd6XGn8gNi66y71ru7CK4rJxR9tgpd2qSPDl
	GYqFCiB4UlPPDwwdMbvQBWo7nkoOHAIYaRtAk9IExzku6h3Bc3JGOjxCtZ6AyV1BGgoHfFjzU/8yH
	eAihTd6JPc7pUWgUcJDbVGWEjo6xs8i1g7KCWOUbNM7b1ICP4TmNQHF7Z1S3EkGj/IMK7x2XAXeC9
	LCsu/eWA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sw2QM-000EhK-CH; Wed, 02 Oct 2024 18:42:02 +0200
Received: from [178.197.249.44] (helo=[192.168.1.114])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sw2QL-000CdS-2Y;
	Wed, 02 Oct 2024 18:42:01 +0200
Message-ID: <f05e5f07-467d-441a-8113-0a7c4cb2c842@iogearbox.net>
Date: Wed, 2 Oct 2024 18:42:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add tcx netns cookie tests
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, john.fastabend@gmail.com
References: <20241002160122.148980-1-mahe.tardy@gmail.com>
 <20241002160122.148980-2-mahe.tardy@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20241002160122.148980-2-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27415/Wed Oct  2 10:52:29 2024)

On 10/2/24 6:01 PM, Mahe Tardy wrote:
> Add netns cookie test that verifies the helper is now supported and work
> in the context of tc programs.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/netns_cookie.c | 7 +++++++
>   tools/testing/selftests/bpf/progs/netns_cookie_prog.c | 9 +++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
> index 71d8f3ba7d6b..233fd66f59ee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
> @@ -12,6 +12,7 @@ static int duration;
> 
>   void test_netns_cookie(void)
>   {
> +	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
>   	int server_fd = -1, client_fd = -1, cgroup_fd = -1;
>   	int err, val, ret, map, verdict;
>   	struct netns_cookie_prog *skel;
> @@ -38,6 +39,11 @@ void test_netns_cookie(void)
>   	if (!ASSERT_OK(err, "prog_attach"))
>   		goto done;
> 
> +	verdict = bpf_program__fd(skel->progs.get_netns_cookie_tcx);
> +	err = bpf_prog_attach_opts(verdict, 1, BPF_TCX_INGRESS, &opta);
> +	if (!ASSERT_EQ(err, 0, "prog_attach"))
> +		goto done;
> +
>   	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
>   	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
>   		goto done;
> @@ -68,6 +74,7 @@ void test_netns_cookie(void)
>   		goto done;
> 
>   	ASSERT_EQ(val, cookie_expected_value, "cookie_value");
> +	ASSERT_EQ(skel->bss->tcx_netns_cookie, cookie_expected_value, "cookie_value");
> 
>   done:
>   	if (server_fd != -1)

Looks like CI fails, as this is missing a bpf_prog_detach_opts().

> diff --git a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
> index aeff3a4f9287..207f0e6c20b7 100644
> --- a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
> +++ b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
> @@ -27,6 +27,8 @@ struct {
>   	__type(value, __u64);
>   } sock_map SEC(".maps");
> 
> +int tcx_netns_cookie;
> +
>   SEC("sockops")
>   int get_netns_cookie_sockops(struct bpf_sock_ops *ctx)
>   {
> @@ -81,4 +83,11 @@ int get_netns_cookie_sk_msg(struct sk_msg_md *msg)
>   	return 1;
>   }
> 
> +SEC("tcx/ingress")
> +int get_netns_cookie_tcx(struct __sk_buff *skb)
> +{
> +	tcx_netns_cookie = bpf_get_netns_cookie(skb);
> +	return TCX_PASS;
> +}
> +
>   char _license[] SEC("license") = "GPL";
> --
> 2.34.1
> 

