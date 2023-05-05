Return-Path: <bpf+bounces-71-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAC16F7A0D
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74A2280F12
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FD210E3;
	Fri,  5 May 2023 00:24:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F05EA1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:24:13 +0000 (UTC)
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124F1209E
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:24:11 -0700 (PDT)
Message-ID: <7a375393-ca58-6dd2-67eb-0eb77b430384@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1683246250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79ZkDu+EGAvZ1V9r+oDNBw1qgraxTd4pyTYNrnLDpNk=;
	b=YO/ywULeXzu4DGyqBC75N4YoqgBgbWgCKrWaqniSpDGbtIWlG8fNMW/hYu9YG2o+irNvdM
	AmSYdnZPBVhvxgtbGrDEnuvONaoLmpDLMXaniQjt/9sQL5HXMXpt2kgbi5GuPpfKSa8Ftd
	iPlPqCeWCwCQqg3v4Df91OglE3LPC10=
Date: Thu, 4 May 2023 17:24:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 bpf-next 08/10] selftests/bpf: Test bpf_sock_destroy
Content-Language: en-US
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: sdf@google.com, bpf@vger.kernel.org
References: <20230503225351.3700208-1-aditi.ghag@isovalent.com>
 <20230503225351.3700208-9-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230503225351.3700208-9-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/3/23 3:53 PM, Aditi Ghag wrote:
> The test cases for destroying sockets mirror the intended usages of the
> bpf_sock_destroy kfunc using iterators.
> 
> The destroy helpers set `ECONNABORTED` error code that we can validate in
> the test code with client sockets. But UDP sockets have an overriding error
> code from the disconnect called during abort, so the error code the
> validation is only done for TCP sockets.
> 
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   .../selftests/bpf/prog_tests/sock_destroy.c   | 215 ++++++++++++++++++
>   .../selftests/bpf/progs/sock_destroy_prog.c   | 145 ++++++++++++
>   2 files changed, 360 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> new file mode 100644
> index 000000000000..d5f76731b4a3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/bpf_endian.h>
> +
> +#include "sock_destroy_prog.skel.h"
> +#include "network_helpers.h"
> +
> +#define TEST_NS "sock_destroy_netns"
> +
> +static void start_iter_sockets(struct bpf_program *prog)
> +{
> +	struct bpf_link *link;
> +	char buf[50] = {};
> +	int iter_fd, len;
> +
> +	link = bpf_program__attach_iter(prog, NULL);
> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> +		return;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> +		goto free_link;
> +
> +	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> +		;
> +	ASSERT_GE(len, 0, "read");
> +
> +	close(iter_fd);
> +
> +free_link:
> +	bpf_link__destroy(link);
> +}
> +
> +static void test_tcp_client(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n;
> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> +		goto cleanup;
> +
> +	serv = accept(serv, NULL, NULL);

The original serv fd is over-written and lost.

> +	if (!ASSERT_GE(serv, 0, "serv accept"))
> +		goto cleanup;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_EQ(n, 1, "client send"))
> +		goto cleanup;
> +
> +	/* Run iterator program that destroys connected client sockets. */
> +	start_iter_sockets(skel->progs.iter_tcp6_client);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> +		goto cleanup;
> +	ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket");
> +
> +cleanup:
> +	if (clien != -1)
> +		close(clien);
> +	if (serv != -1)
> +		close(serv);
> +}
> +
> +static void test_tcp_server(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n, serv_port;
> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup;
> +	serv_port = get_socket_local_port(serv);
> +	if (!ASSERT_GE(serv_port, 0, "get_sock_local_port"))
> +		goto cleanup;
> +	skel->bss->serv_port = (__be16) serv_port;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> +		goto cleanup;
> +
> +	serv = accept(serv, NULL, NULL);

Same here.

> +	if (!ASSERT_GE(serv, 0, "serv accept"))
> +		goto cleanup;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_EQ(n, 1, "client send"))
> +		goto cleanup;
> +
> +	/* Run iterator program that destroys server sockets. */
> +	start_iter_sockets(skel->progs.iter_tcp6_server);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> +		goto cleanup;
> +	ASSERT_EQ(errno, ECONNRESET, "error code on destroyed socket");
> +
> +cleanup:
> +	if (clien != -1)
> +		close(clien);
> +	if (serv != -1)
> +		close(serv);
> +}
> +
> +static void test_udp_client(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (!ASSERT_GE(clien, 0, "connect_to_fd"))
> +		goto cleanup;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_EQ(n, 1, "client send"))
> +		goto cleanup;
> +
> +	/* Run iterator program that destroys sockets. */
> +	start_iter_sockets(skel->progs.iter_udp6_client);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (!ASSERT_LT(n, 0, "client_send on destroyed socket"))
> +		goto cleanup;
> +	/* UDP sockets have an overriding error code after they are disconnected,
> +	 * so we don't check for ECONNABORTED error code.
> +	 */
> +
> +cleanup:
> +	if (clien != -1)
> +		close(clien);
> +	if (serv != -1)
> +		close(serv);
> +}
> +
> +static void test_udp_server(struct sock_destroy_prog *skel)
> +{
> +	int *listen_fds = NULL, n, i, serv_port;
> +	unsigned int num_listens = 5;
> +	char buf[1];
> +
> +	/* Start reuseport servers. */
> +	listen_fds = start_reuseport_server(AF_INET6, SOCK_DGRAM,
> +					    "::1", 0, 0, num_listens);
> +	if (!ASSERT_OK_PTR(listen_fds, "start_reuseport_server"))
> +		goto cleanup;
> +	serv_port = get_socket_local_port(listen_fds[0]);
> +	if (!ASSERT_GE(serv_port, 0, "get_sock_local_port"))
> +		goto cleanup;
> +	skel->bss->serv_port = (__be16) serv_port;
> +
> +	/* Run iterator program that destroys server sockets. */
> +	start_iter_sockets(skel->progs.iter_udp6_server);
> +
> +	for (i = 0; i < num_listens; ++i) {
> +		n = read(listen_fds[i], buf, sizeof(buf));
> +		if (!ASSERT_EQ(n, -1, "read") ||
> +		    !ASSERT_EQ(errno, ECONNABORTED, "error code on destroyed socket"))
> +			break;
> +	}
> +	ASSERT_EQ(i, num_listens, "server socket");
> +
> +cleanup:
> +	free_fds(listen_fds, num_listens);
> +}
> +
> +void test_sock_destroy(void)
> +{
> +	struct sock_destroy_prog *skel;
> +	struct nstoken *nstoken;

This does need a '= NULL;' now after consolidating to one "cleanup" label. Even 
the v6 patch needs a ' = NULL;' considering the SYS() below may do a goto also, 
so I was incorrect on my v6 comment and stand to be corrected by the compiler: 
https://github.com/kernel-patches/bpf/actions/runs/4877289517/jobs/8701781601

> +	int cgroup_fd;
> +
> +	skel = sock_destroy_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	cgroup_fd = test__join_cgroup("/sock_destroy");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		goto cleanup;
> +
> +	skel->links.sock_connect = bpf_program__attach_cgroup(
> +		skel->progs.sock_connect, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
> +		goto cleanup;
> +
> +	SYS(cleanup, "ip netns add %s", TEST_NS);
> +	SYS(cleanup, "ip -net %s link set dev lo up", TEST_NS);
> +
> +	nstoken = open_netns(TEST_NS);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto cleanup;
> +
> +	if (test__start_subtest("tcp_client"))
> +		test_tcp_client(skel);
> +	if (test__start_subtest("tcp_server"))
> +		test_tcp_server(skel);
> +	if (test__start_subtest("udp_client"))
> +		test_udp_client(skel);
> +	if (test__start_subtest("udp_server"))
> +		test_udp_server(skel);
> +
> +
> +cleanup:
> +	if (nstoken)
> +		close_netns(nstoken);
> +	SYS_NOFAIL("ip netns del " TEST_NS " &> /dev/null");
> +	if (cgroup_fd >= 0)
> +		close(cgroup_fd);
> +	sock_destroy_prog__destroy(skel);
> +}


