Return-Path: <bpf+bounces-71888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8CC006E4
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67EF13528AF
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22E2F616A;
	Thu, 23 Oct 2025 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="crxMOesu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B322FD1B5
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214727; cv=none; b=ExuuPK7konHUX256CCpxitk0VlheB0DjCS0ctVwC0RQken1dzadfvy84yUQpC0MAowyowcWwJcVZihpozn23YDSLuzxYViSHZiV3tyBnEYBbtz9SVKwQs4mzAbneHKOZvD7UDIxgdz8chnOXp2s/35B1bEaEtBVm6761Vt7TH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214727; c=relaxed/simple;
	bh=VSlWVnkKS6AqcpROj4gNhqpk+RjaI5RZYdNcj5kPyX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DXxcN3ruLJ1XWPxpM/87kD34Noy0aBbS73ngs2j7X1QL+LM4Pld9GUV7FtyZDFYAh/GPS+kIc0JjBer1MJAtBjuZ/QDQF272KB7Kn2IaoOuzkUHWxSRxgTAAHB6gS1PNesy28S0v30HKIE0DVSj9imqa0lQBY6CESg7nS0xyUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=crxMOesu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b50645ecfbbso131751966b.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761214724; x=1761819524; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yg7N1eLYpXeNqlITcuenmZuFMj2qpjsYfuE4Coq/2M=;
        b=crxMOesubNHIS2qMr7gH2LCutYqiEwl3CUoZ4x54fdLaGa9hx8dKuLUmIeEVGw0hhf
         vh7F2+YRYev1WKO3JRnp2ofXPGRUbJM2BGvq5nLvUCoTFLcMskrdAk0E37CmqeSn5RmC
         zDoA7izey9iZDK69MJ2fo1j87KFxFGvBXi08qV83cqcvhDPCotR5dA3Fa0f5UWRdQ25o
         LAC3/vm6t3ooxwAQZS+dnVt/xFonGkpYnafj0Hgys7SX4r1B+vddKDl4SuRXydr14pP2
         lWHPY98j9VuZlDwMgjHN9YFNg6x9ELOs3/jaC9ueMSEzurkkdl8E2qf8lEFPhmYdpA6o
         HZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214724; x=1761819524;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yg7N1eLYpXeNqlITcuenmZuFMj2qpjsYfuE4Coq/2M=;
        b=d2r232ykORm2wdG+61ussPILSKzctg0ILnqAeFp6t++Ml+NQ7BGAGsEuaij6XSDSL5
         Dj65VvQYy7wdt5iHzj7BcU9IpAE0PHCh5uq6O3BZ9rQgHkIZkB4hiXe1mDymIntOpfmC
         di2I4EjgxBcfnS+zgS9VlflK9lmWKEYXvbh+Z5lq4wE5Ndb4UAahUtBy/R0m5IV8fwcN
         +JTaxGHe6wc0mLNntINM/BewVz+3MWjRncd9VQelPQcp+sx7qo/DD72xwY3aho0FaPki
         J7xrnPdAbJVGdRtjo4mjvRPw1BtAEWC16+nqtwr8Wdr+xxchUGFHCJ+3bktifo/sY+p1
         dd9A==
X-Forwarded-Encrypted: i=1; AJvYcCXLbqCgTqf9NyVAHf54LenUGA4OD6bKH8IolQZUf0dICnOjodOnr+pDWG1IIVYWdAETHuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FVacgBPmJ5FusTQ0qx5xwDScf+fXOhO/7Qw3LQW/FPLVB9b/
	BEESKU2Kt79wbLtg0U9isO035v9KosPTJkI4oMAdd3C24bbxg1f5PBr34dAuaTAFX3o=
X-Gm-Gg: ASbGncvPQt5btOlKaur+vrVrYvFkP2fugZK2oFPlROWW4UJuQr1lnWsZsCpHuXOl+Ml
	TUJVQeyymGUurmVzt6LkrKK4X1az8XjdXnspJVIk/M2GjgcAaRAPYTvPfxeYzEkwzn6orbIi9xG
	JwzEk2OuSY3ozixwTfHWXL7Jqa/aW9uk/dDGv9Yx0CEGQ8HIfLdzfvKn7Jhee1MzyLjEapX2W7k
	Fs2HVa3EQzOJGQEYIPqU5lhx+5S/xU3S4jqExQSPNIX/tIuP4CjvghJF5jsKKSO1X/9mh9OS6m+
	o+MpggSf1ecypUNadEP5bqDmD0IxU7ST17OEdeztzw/lC/d4QU1l72cW4wNPXsahhxSUuY6q/AV
	7JtAMdltjUdVSo5jnuSwWeVjEdAeSfJdpQAcYj9cb7YY+Nzu/RV2rvKLaapU3SR7xrraoFur7D2
	4hIqT24F7zxW71KA==
X-Google-Smtp-Source: AGHT+IGGrUZ+VVMpCvZMybd44OLBtACqmnVl06t9ARNOxcZxhBi1nSUsnpCbEnWD1158x71c60T+Jw==
X-Received: by 2002:a17:907:7ea6:b0:b3e:3c1c:d2f2 with SMTP id a640c23a62f3a-b6474940fc1mr3104761866b.36.1761214723959;
        Thu, 23 Oct 2025 03:18:43 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:7f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316b64sm1316953a12.22.2025.10.23.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:18:43 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  John Fastabend <john.fastabend@gmail.com>,  Eric Dumazet
 <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  "David
 S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
  Simon Horman <horms@kernel.org>,  Matthieu Baerts <matttbe@kernel.org>,
  Mat Martineau <martineau@kernel.org>,  Geliang Tang <geliang@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Florian Westphal <fw@strlen.de>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] selftests/bpf: Add mptcp test with sockmap
In-Reply-To: <20251020060503.325369-4-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 20 Oct 2025 14:04:48 +0800")
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
	<20251020060503.325369-4-jiayuan.chen@linux.dev>
Date: Thu, 23 Oct 2025 12:18:42 +0200
Message-ID: <87v7k5vs3h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
> Add test cases to verify that when MPTCP falls back to plain TCP sockets,
> they can properly work with sockmap.
>
> Additionally, add test cases to ensure that sockmap correctly rejects
> MPTCP sockets as expected.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 136 ++++++++++++++++++
>  .../selftests/bpf/progs/mptcp_sockmap.c       |  43 ++++++
>  2 files changed, 179 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index f8eb7f9d4fd2..54459b385439 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,11 +6,14 @@
>  #include <netinet/in.h>
>  #include <test_progs.h>
>  #include <unistd.h>
> +#include <error.h>
>  #include "cgroup_helpers.h"
>  #include "network_helpers.h"
> +#include "socket_helpers.h"
>  #include "mptcp_sock.skel.h"
>  #include "mptcpify.skel.h"
>  #include "mptcp_subflow.skel.h"
> +#include "mptcp_sockmap.skel.h"
>  
>  #define NS_TEST "mptcp_ns"
>  #define ADDR_1	"10.0.1.1"
> @@ -436,6 +439,137 @@ static void test_subflow(void)
>  	close(cgroup_fd);
>  }
>  
> +/* Test sockmap on MPTCP server handling non-mp-capable clients. */
> +static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
> +{
> +	int listen_fd = -1, client_fd1 = -1, client_fd2 = -1;
> +	int server_fd1 = -1, server_fd2 = -1, sent, recvd;
> +	char snd[9] = "123456789";
> +	char rcv[10];
> +
> +	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	if (!ASSERT_OK_FD(listen_fd, "redirect:start_mptcp_server"))
> +		return;
> +
> +	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
> +	skel->bss->sk_index = 0;
> +	client_fd1 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd1, "redirect:connect_to_fd"))
> +		goto end;
> +	server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	skel->bss->sk_index = 1;
> +	client_fd2 = connect_to_fd_opts(listen_fd, NULL);
> +	if (!ASSERT_OK_FD(client_fd2, "redirect:connect_to_fd"))
> +		goto end;
> +	server_fd1 = xaccept_nonblock(listen_fd, NULL, NULL);
> +	/* test normal redirect behavior: the data sent by client_fd1 can be
> +	 * received by client_fd2
> +	 */
> +	skel->bss->redirect_idx = 1;
> +	sent = xsend(client_fd1, snd, sizeof(snd), 0);
> +	if (!ASSERT_EQ(sent, sizeof(snd), "redirect:xsend(client_fd1)"))
> +		goto end;
> +
> +	/* try to recv more byte to avoid truncation check */
> +	recvd = recv_timeout(client_fd2, rcv, sizeof(rcv), MSG_DONTWAIT, 2);
> +	if (!ASSERT_EQ(recvd, sizeof(snd), "redirect:recv(client_fd2)"))
> +		goto end;
> +
> +end:
> +	if (client_fd1 > 1)
> +		close(client_fd1);
> +	if (client_fd2 > 1)
> +		close(client_fd2);
> +	if (server_fd1 > 0)
> +		close(server_fd1);
> +	if (server_fd2 > 0)
> +		close(server_fd2);
> +	close(listen_fd);
> +}
> +
> +static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
> +{
> +	int listen_fd = -1, server_fd = -1;
> +	int client_fd1 = -1, client_fd2 = -1;
> +	int err, zero = 0;
> +
> +	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> +	if (!ASSERT_OK_FD(listen_fd, "start_mptcp_server"))
> +		return;
> +
> +	skel->bss->trace_port = ntohs(get_socket_local_port(listen_fd));
> +	skel->bss->sk_index = 0;
> +	client_fd1 = connect_to_fd(listen_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
> +		goto end;
> +	/* sockmap helper called from sockops prog should reject mptcp sk */
> +	if (ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"))
> +		goto end;

I'm confused. Should we bail out (goto end) if EOPNOTSUPP is *not*
returned? That is "if (!ASSERT_EQ(...))".

> +
> +	/* skip sockops prog */
> +	skel->bss->trace_port = -1;
> +	client_fd2 = connect_to_fd(listen_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd2, "connect_to_fd client_fd2"))
> +		goto end;
> +
> +	server_fd = xaccept_nonblock(listen_fd, NULL, NULL);
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> +				  &zero, &server_fd, BPF_NOEXIST);
> +	if (ASSERT_EQ(err, -EOPNOTSUPP, "should reject"))
> +		goto end;

Same here. The check seems backward.

> +end:
> +	if (client_fd1 > 0)
> +		close(client_fd1);
> +	if (client_fd2 > 0)
> +		close(client_fd2);
> +	if (server_fd > 0)
> +		close(server_fd);
> +	close(listen_fd);
> +}
> +
> +static void test_mptcp_sockmap(void)
> +{
> +	struct mptcp_sockmap *skel;
> +	struct netns_obj *netns;
> +	int cgroup_fd, err;
> +
> +	cgroup_fd = test__join_cgroup("/mptcp_sockmap");
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_sockmap"))
> +		return;
> +
> +	skel = mptcp_sockmap__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load: mptcp_sockmap"))
> +		goto close_cgroup;
> +
> +	skel->links.mptcp_sockmap_inject =
> +		bpf_program__attach_cgroup(skel->progs.mptcp_sockmap_inject, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.mptcp_sockmap_inject, "attach sockmap"))
> +		goto skel_destroy;
> +
> +	err = bpf_prog_attach(bpf_program__fd(skel->progs.mptcp_sockmap_redirect),
> +			      bpf_map__fd(skel->maps.sock_map),
> +			      BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach stream verdict"))
> +		goto skel_destroy;
> +
> +	netns = netns_new(NS_TEST, true);
> +	if (!ASSERT_OK_PTR(netns, "netns_new: mptcp_sockmap"))
> +		goto skel_destroy;
> +
> +	if (endpoint_init("subflow") < 0)
> +		goto close_netns;
> +
> +	test_sockmap_with_mptcp_fallback(skel);
> +	test_sockmap_reject_mptcp(skel);
> +
> +close_netns:
> +	netns_free(netns);
> +skel_destroy:
> +	mptcp_sockmap__destroy(skel);
> +close_cgroup:
> +	close(cgroup_fd);
> +}
> +
>  void test_mptcp(void)
>  {
>  	if (test__start_subtest("base"))
> @@ -444,4 +578,6 @@ void test_mptcp(void)
>  		test_mptcpify();
>  	if (test__start_subtest("subflow"))
>  		test_subflow();
> +	if (test__start_subtest("sockmap"))
> +		test_mptcp_sockmap();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sockmap.c b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
> new file mode 100644
> index 000000000000..d4eef0cbadb9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_sockmap.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "bpf_tracing_net.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int sk_index;
> +int redirect_idx;
> +int trace_port;
> +int helper_ret;
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, 100);
> +} sock_map SEC(".maps");
> +
> +SEC("sockops")
> +int mptcp_sockmap_inject(struct bpf_sock_ops *skops)
> +{
> +	struct bpf_sock *sk;
> +
> +	/* only accept specified connection */
> +	if (skops->local_port != trace_port ||
> +	    skops->op != BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
> +		return 1;
> +
> +	sk = skops->sk;
> +	if (!sk)
> +		return 1;
> +
> +	/* update sk handler */
> +	helper_ret = bpf_sock_map_update(skops, &sock_map, &sk_index, BPF_NOEXIST);
> +
> +	return 1;
> +}
> +
> +SEC("sk_skb/stream_verdict")
> +int mptcp_sockmap_redirect(struct __sk_buff *skb)
> +{
> +	/* redirect skb to the sk under sock_map[redirect_idx] */
> +	return bpf_sk_redirect_map(skb, &sock_map, redirect_idx, 0);
> +}

