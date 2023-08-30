Return-Path: <bpf+bounces-8967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A459478D36C
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4928133F
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F531859;
	Wed, 30 Aug 2023 06:52:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16A10EE
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:52:02 +0000 (UTC)
Received: from out-250.mta1.migadu.com (out-250.mta1.migadu.com [IPv6:2001:41d0:203:375::fa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107D194
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 23:52:00 -0700 (PDT)
Message-ID: <f6c74d80-a881-888f-8f36-435c980c52ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693378319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iBDhbPNfNp/7O2SqQ3QRgeWTITHro1LxM5MvVSvKDw=;
	b=ZF7p7IQvPlqMzF6wgUpzhuOHlvhCiG29VAZQqE4rFjhlCC/jj5rFtBxBiMxJWrCRNQjwN4
	lEqsuisiKKJtH/BvcAtDUaeDOeCS9/yWuYeQVH+SoN9xOUvd7KxxMqEDUjz0UrVI1yJ+1E
	abxQ7T+gAKnYyWAFvYP0zjRvXJKt13c=
Date: Tue, 29 Aug 2023 23:51:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 9/9] selftests/bpf: Add tests for cgroup unix
 socket address hooks
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, bpf@vger.kernel.org
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
 <20230829101838.851350-10-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230829101838.851350-10-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 3:18 AM, Daan De Meyer wrote:
> +void test_bind(int cgroup_fd)
static

> +{
> +	struct bindun_prog *skel;
> +	struct sockaddr_storage expected_addr;
> +	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
> +	int serv = -1, client = -1, err;
> +
> +	skel = bindun_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->links.bindun_prog = bpf_program__attach_cgroup(
> +		skel->progs.bindun_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.bindun_prog, "prog_attach"))
> +		goto cleanup;
> +
> +	serv = start_server(AF_UNIX, SOCK_STREAM, SERVUN_ADDRESS, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup;
> +
> +	err = make_sockaddr(AF_UNIX, SERVUN_REWRITE_ADDRESS, 0, &expected_addr, &expected_addr_len);
> +	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
> +		goto cleanup;
> +
> +	err = cmp_local_addr(serv, &expected_addr, expected_addr_len);
> +	if (!ASSERT_EQ(err, 0, "cmp_local_addr"))
> +		goto cleanup;
> +
> +	/* Try to connect to server just in case */
> +	client = connect_to_addr(&expected_addr, expected_addr_len, SOCK_STREAM);
> +	if (!ASSERT_GE(client, 0, "connect_to_addr"))
> +		goto cleanup;
> +
> +cleanup:
> +	if (client != -1)
> +		close(client);
> +	if (serv != -1)
> +		close(serv);
> +	bindun_prog__destroy(skel);
> +}
> +
> +void test_connect(int cgroup_fd)
static.

> +{
> +	struct connectun_prog *skel;
> +	struct sockaddr_storage addr, expected_addr;
> +	socklen_t addr_len = sizeof(struct sockaddr_storage),
> +		  expected_addr_len = sizeof(struct sockaddr_storage);
> +	int serv = -1, client = -1, err;
> +
> +	skel = connectun_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->links.connectun_prog = bpf_program__attach_cgroup(
> +		skel->progs.connectun_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.connectun_prog, "prog_attach"))
> +		goto cleanup;
> +
> +	serv = start_server(AF_UNIX, SOCK_STREAM, SERVUN_REWRITE_ADDRESS, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup;
> +
> +	err = make_sockaddr(AF_UNIX, SERVUN_ADDRESS, 0, &addr, &addr_len);
> +	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
> +		goto cleanup;
> +
> +	client = connect_to_addr(&addr, addr_len, SOCK_STREAM);
> +	if (!ASSERT_GE(client, 0, "connect_to_addr"))
> +		goto cleanup;
> +
> +	err = make_sockaddr(AF_UNIX, SERVUN_REWRITE_ADDRESS, 0, &expected_addr, &expected_addr_len);
> +	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
> +		goto cleanup;
> +
> +	err = cmp_peer_addr(client, &expected_addr, expected_addr_len);
> +	if (!ASSERT_EQ(err, 0, "cmp_peer_addr"))
> +		goto cleanup;
> +
> +cleanup:
> +	if (client != -1)
> +		close(client);
> +	if (serv != -1)
> +		close(serv);
> +	connectun_prog__destroy(skel);
> +}
> +
> +void test_sendmsg(int cgroup_fd)
static.

> +{
> +	struct sendmsgun_prog *skel;
> +	struct sockaddr_storage addr;
> +	socklen_t addr_len = sizeof(struct sockaddr_storage);
> +	char data = 'a';
> +	int serv = -1, client = -1, err;
> +
> +	skel = sendmsgun_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->links.sendmsgun_prog = bpf_program__attach_cgroup(
> +		skel->progs.sendmsgun_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.sendmsgun_prog, "prog_attach"))
> +		goto cleanup;
> +
> +	serv = start_server(AF_UNIX, SOCK_DGRAM, SERVUN_REWRITE_ADDRESS, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup;
> +
> +	client = socket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (!ASSERT_GE(client, 0, "socket"))
> +		goto cleanup;
> +
> +	err = make_sockaddr(AF_UNIX, SERVUN_ADDRESS, 0, &addr, &addr_len);
> +	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
> +		goto cleanup;
> +
> +	err = sendto(client, &data, sizeof(data), 0, (const struct sockaddr *) &addr, addr_len);
> +	if (!ASSERT_EQ(err, sizeof(data), "sendto"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(recv(serv, &data, sizeof(data), 0), sizeof(data), "recv"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(data, 'a', "data mismatch");
> +
> +cleanup:
> +	if (client != -1)
> +		close(client);
> +	if (serv != -1)
> +		close(serv);
> +	sendmsgun_prog__destroy(skel);
> +}
> +
> +void test_recvmsg(int cgroup_fd)
static.

> +{
> +	struct recvmsgun_prog *skel;
> +	struct sockaddr_storage addr, src_addr;
> +	socklen_t addr_len = sizeof(struct sockaddr_storage),
> +		  src_addr_len = sizeof(struct sockaddr_storage);
> +	char data = 'a';
> +	int serv = -1, client = -1, err;
> +
> +	/* Unlike the other tests, here we test that we can rewrite the src addr
> +	 * with a recvmsg() hook.
> +	 */
> +
> +	skel = recvmsgun_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	skel->links.recvmsgun_prog = bpf_program__attach_cgroup(
> +		skel->progs.recvmsgun_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.recvmsgun_prog, "prog_attach"))
> +		goto cleanup;
> +
> +	serv = start_server(AF_UNIX, SOCK_DGRAM, SERVUN_ADDRESS, 0, 0);
> +	if (!ASSERT_GE(serv, 0, "start_server"))
> +		goto cleanup;
> +
> +	client = socket(AF_UNIX, SOCK_DGRAM, 0);
> +	if (!ASSERT_GE(client, 0, "socket"))
> +		goto cleanup;
> +
> +	err = make_sockaddr(AF_UNIX, SRCUN_ADDRESS, 0, &src_addr, &src_addr_len);
> +	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(bind(client, (const struct sockaddr *) &src_addr, src_addr_len), 0, "bind"))
> +		goto cleanup;
> +
> +	err = make_sockaddr(AF_UNIX, SERVUN_ADDRESS, 0, &addr, &addr_len);
> +	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
> +		goto cleanup;
> +
> +	err = sendto(client, &data, sizeof(data), 0, (const struct sockaddr *) &addr, addr_len);
> +	if (!ASSERT_EQ(err, sizeof(data), "sendto"))
> +		goto cleanup;
> +
> +	addr_len = src_addr_len = sizeof(struct sockaddr_storage);
> +
> +	err = recvfrom(serv, &data, sizeof(data), 0, (struct sockaddr *) &addr, &addr_len);
> +	if (!ASSERT_EQ(err, sizeof(data), "recvfrom"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(data, 'a', "data mismatch");
> +
> +	err = make_sockaddr(AF_UNIX, SRCUN_REWRITE_ADDRESS, 0, &src_addr, &src_addr_len);
> +	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(cmp_addr(&addr, addr_len, &src_addr, src_addr_len, 0), 0, "cmp_addr"))
> +		goto cleanup;
> +
> +cleanup:
> +	if (client != -1)
> +		close(client);
> +	if (serv != -1)
> +		close(serv);
> +	recvmsgun_prog__destroy(skel);
> +}
> +
> +void test_sock_addr(void)
> +{
> +	int cgroup_fd = -1;
> +
> +	cgroup_fd = test__join_cgroup("/sock_addr");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		goto cleanup;
> +
> +	if (test__start_subtest("bind"))
> +		test_bind(cgroup_fd);
> +	if (test__start_subtest("connect"))
> +		test_connect(cgroup_fd);
> +	if (test__start_subtest("sendmsg"))
> +		test_sendmsg(cgroup_fd);
> +	if (test__start_subtest("recvmsg"))
> +		test_recvmsg(cgroup_fd);
> +
> +cleanup:
> +	if (cgroup_fd >= 0)
> +		close(cgroup_fd);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bindun_prog.c b/tools/testing/selftests/bpf/progs/bindun_prog.c
> new file mode 100644
> index 000000000000..e5e19c41f02d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bindun_prog.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_kfuncs.h"
> +
> +__u8 SERVUN_REWRITE_ADDRESS[] = "\0bpf_cgroup_unix_test_rewrite";
> +
> +SEC("cgroup/bindun")
> +int bindun_prog(struct bpf_sock_addr *ctx)
> +{
> +	struct bpf_sock_addr_kern *sa_kern = bpf_cast_to_kern_ctx(ctx);
> +	int ret;

It will be useful as an example to show how the unix address can be read from 
sa_kern->uaddr.

> +
> +	ret = bpf_sock_addr_set_addr(sa_kern, SERVUN_REWRITE_ADDRESS,
> +				     sizeof(SERVUN_REWRITE_ADDRESS) - 1);

Other tests are needed on bpf_sock_addr_set_addr() with AF_INET and AF_INET6 sk.

Please also cc netdev in the next respin. Thanks!

