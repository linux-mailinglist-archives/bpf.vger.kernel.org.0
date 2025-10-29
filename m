Return-Path: <bpf+bounces-72885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D683BC1D159
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31BF566857
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A335BDCE;
	Wed, 29 Oct 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sRKiGKE4"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356519CD03
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767801; cv=none; b=R0NY20ggT/AU3zBYOD5mBBexa8XW1+WjlQqR9wITS0ql+2LEkL2AY8rRUKUbszJrSb1VYrrli+M30enZKiHNgOyGpZaGNhzVxZMwPBEabpgqKBVairj6rClTs5fmMjYWu7Tfqou8/iSC0Zhj/yJoBw8pp+GLiKLN+r+IM/OjUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767801; c=relaxed/simple;
	bh=qSqfO4GaIrR27fhgavCPzsBAMespcHyDtewzg+16dug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhGEY1UeFfjW37XoDIJ6CuE1EsVCI0+GMyEZWZ4BfhfBI8CVDwHJhNQ1es/us6VZ2OYNzu+ydHXgDC4iAlvTXQFedmhNixFoYNFutnrCvqSz8N9m2h40uj+4/Ge/UdW8HHhLdOBKxP4DDgeetqy3fNH942D4I8BcBErEtQTwDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sRKiGKE4; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ac9d14e-4250-480c-b863-410be78ac6c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761767797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riRSf2R7xwaw3JNPyjOIY32N5sQTM0xVxav/eTpQzBA=;
	b=sRKiGKE4PQuJxGC2AJi8XPaHhTU2mGX0xKY+eLSHxCSe/WQZYH6hqCf/wAY7KnIu10ZbYg
	msvX550/fwGxa8JxO1t91w1jLjM/mysf5/i9IMwD0iOAnwE5CsOalsYN9/Jg5Xc1900cnt
	cHBhB5PR8WGWB5uZa3y+KySLeK91gwc=
Date: Wed, 29 Oct 2025 12:56:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027-tc_tunnel-v3-0-505c12019f9d@bootlin.com>
 <20251027-tc_tunnel-v3-3-505c12019f9d@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251027-tc_tunnel-v3-3-505c12019f9d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/27/25 7:51 AM, Alexis Lothoré (eBPF Foundation) wrote:
> +static int run_server(struct subtest_cfg *cfg)
> +{
> +	struct nstoken *nstoken = open_netns(SERVER_NS);

It is unlikely but still better to check for open_netns failure. Just in 
case that the network changes/traffic is accidentally done in the 
original netns. There are a few netns switching in the test. Please 
followup.

> +	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
> +
> +	cfg->server_fd = start_reuseport_server(family, SOCK_STREAM,
> +						cfg->server_addr, TEST_PORT,
> +						TIMEOUT_MS, 1);

Why reuseport is needed? Does it have issue in bind() to the same 
ip/port in the later sub-test?
> +	close_netns(nstoken);
> +	if (!ASSERT_NEQ(cfg->server_fd, NULL, "start server"))

I changed the check to ASSERT_OK_PTR. Also two other similar 
ASSERT_[N]EQ(..., NULL, ...) usages.
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void stop_server(struct subtest_cfg *cfg)
> +{
> +	close(*cfg->server_fd);

NULL check on cfg->server_fd is needed during the error path of 
run_test(). cfg->server_fd is leaked also. I changed it to 
free_fds(cfg->server_fd, 1) instead.

> +	cfg->server_fd = NULL;

I don't think cfg will be reused, so I skip this NULL assignment.

> +}
> +
> +static int check_server_rx_data(struct subtest_cfg *cfg,
> +				struct connection *conn, int len)
> +{
> +	int err;
> +
> +	memset(rx_buffer, 0, BUFFER_LEN);
> +	err = recv(conn->server_fd, rx_buffer, len, 0);
> +	if (!ASSERT_EQ(err, len, "check rx data len"))
> +		return 1;
> +	if (!ASSERT_MEMEQ(tx_buffer, rx_buffer, len, "check received data"))
> +		return 1;
> +	return 0;
> +}
> +
> +static struct connection *connect_client_to_server(struct subtest_cfg *cfg)
> +{
> +	struct network_helper_opts opts = {.timeout_ms = 500};
> +	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
> +	struct connection *conn = NULL;
> +	int client_fd, server_fd;
> +
> +	conn = malloc(sizeof(struct connection));
> +	if (!conn)
> +		return conn;
> +
> +	client_fd = connect_to_addr_str(family, SOCK_STREAM, cfg->server_addr,
> +					TEST_PORT, &opts);
> +
> +	if (client_fd < 0) {
> +		free(conn);
> +		return NULL;
> +	}
> +
> +	server_fd = accept(*cfg->server_fd, NULL, NULL);
> +	if (server_fd < 0) {

Fixed the client_fd leak.
Applied. Thanks.


