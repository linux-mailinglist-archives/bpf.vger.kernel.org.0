Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100126A2469
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 23:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBXWkr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 17:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBXWkq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 17:40:46 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497DF1ACCF
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 14:40:45 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id cn3-20020a056a00340300b0059085684b50so219471pfb.16
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 14:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQBMjZgrBqKUlS7Vhm03Nsw3LLkgNymI9XL2ll8fHa8=;
        b=SQ16SwnRlvKY4B3y/fi/HTrdCJfb7GHr2XGdupfb1HWxh9IlEGOdI6A166NqgndvR3
         CkvF1urvlFzCQyKBJRty5po/SJ5uBA7/0AIKNc0OIDyOSj+Nv5IkwXNzkTSIgtrmKoig
         VAoCHhofQrAxgKuLG5HyoEKvLHvvChypKzWMFKS+L0FTVJRlOTeGvQCPQ+jea7NjubFa
         PP8OC3NfAkK4hJNkNDGoskMHcfFFE5eMC/J70rOMEgVVFZf+nOd7nZjDFG1N378fgurE
         2h80Ge5b5r4Anvxpgd/WwUV4Xpivn463vMl8Pn30XRILLW2//sfCGIi5xb4+kdva/ASc
         eDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQBMjZgrBqKUlS7Vhm03Nsw3LLkgNymI9XL2ll8fHa8=;
        b=paW0mjVNXG3smNl8diN8r3VoddakFY+RdXsgpQxYijRa2rGKtbCav+Y+ebEdTXBpGl
         CkSam7cer8LZcBB6KgAxKVYlyxuIghh6ezmELs7DQFibV6wt0b1toMWsvux9kv/J2Fjx
         yqNCi1tRz2dYxDAdVRUOajAmZ6FfH+lMRFoANznrU3kJzYLzSq2too0+J4Z4R8LtNu5s
         /PTwI3kZl8Bm8rmQqllyAFKzd8nASab4zUiTMqvhqlSiqnmL9hnFJ/NaScLo9GdRqGN6
         rWRixdbioJHMp1HQ2bHlwt4lKoDDSxcADOR8O+609l4629+/lk/3jE0mej5Fv/5zTSDq
         +12Q==
X-Gm-Message-State: AO0yUKWtfk7Kol5ajrsk2A+3j3Si5fiI3qNQNe0fZ4GK4cJ7mG0EJcKM
        bpGL3Hs5edi1WFzP3cQjSMd5GUk=
X-Google-Smtp-Source: AK7set8Zt5SyG+ZqpwPNDID08O4d1qtqPv/85Aff3sbGWbRylPu0rzbxFJSqFnho9nWhtvs4xssA3UI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:af56:0:b0:503:2536:9e5 with SMTP id
 s22-20020a63af56000000b00503253609e5mr73190pgo.8.1677278444725; Fri, 24 Feb
 2023 14:40:44 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:40:43 -0800
In-Reply-To: <20230223215311.926899-4-aditi.ghag@isovalent.com>
Mime-Version: 1.0
References: <20230223215311.926899-1-aditi.ghag@isovalent.com> <20230223215311.926899-4-aditi.ghag@isovalent.com>
Message-ID: <Y/k869h985cJIf4C@google.com>
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for bpf_sock_destroy
From:   Stanislav Fomichev <sdf@google.com>
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/23, Aditi Ghag wrote:
> The test cases for TCP and UDP iterators mirror the intended usages of the
> helper.

> The destroy helpers set `ECONNABORTED` error code that we can validate in  
> the
> test code with client sockets. But UDP sockets have an overriding error  
> code
> from the disconnect called during abort, so the error code the validation  
> is
> only done for TCP sockets.

> The `struct sock` is redefined as vmlinux.h forward declares the struct,  
> and the
> loader fails to load the program as it finds the BTF FWD type for the  
> struct
> incompatible with the BTF STRUCT type.

> Here are the snippets of the verifier error, and corresponding BTF output:

> ```
> verifier error: extern (func ksym) ...: func_proto ... incompatible with  
> kernel

> BTF for selftest prog binary:

> [104] FWD 'sock' fwd_kind=struct
> [70] PTR '(anon)' type_id=104
> [84] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
> 	'(anon)' type_id=70
> [85] FUNC 'bpf_sock_destroy' type_id=84 linkage=extern
> --
> [96] DATASEC '.ksyms' size=0 vlen=1
> 	type_id=85 offset=0 size=0 (FUNC 'bpf_sock_destroy')

> BTF for selftest vmlinux:

> [74923] FUNC 'bpf_sock_destroy' type_id=48965 linkage=static
> [48965] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> 	'sk' type_id=1340
> [1340] PTR '(anon)' type_id=2363
> [2363] STRUCT 'sock' size=1280 vlen=93
> ```

> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   .../selftests/bpf/prog_tests/sock_destroy.c   | 125 ++++++++++++++++++
>   .../selftests/bpf/progs/sock_destroy_prog.c   | 110 +++++++++++++++
>   2 files changed, 235 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c  
> b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> new file mode 100644
> index 000000000000..d9da9d3578e2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +
> +#include "sock_destroy_prog.skel.h"
> +#include "network_helpers.h"
> +
> +#define ECONNABORTED 103
> +
> +static int duration;
> +
> +static void start_iter_sockets(struct bpf_program *prog)
> +{
> +	struct bpf_link *link;
> +	char buf[16] = {};
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
> +	CHECK(len < 0, "read", "read failed: %s\n", strerror(errno));
> +
> +	close(iter_fd);
> +
> +free_link:
> +	bpf_link__destroy(link);
> +}
> +
> +void test_tcp(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
> +	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
> +		goto cleanup_serv;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
> +		goto cleanup_serv;
> +
> +	serv = accept(serv, NULL, NULL);
> +	if (CHECK(serv < 0, "accept", "errno %d\n", errno))
> +		goto cleanup;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
> +		goto cleanup;
> +
> +	start_iter_sockets(skel->progs.iter_tcp6);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (CHECK(n > 0, "client_send after destroy", "succeeded on destroyed  
> socket\n"))
> +		goto cleanup;
> +	CHECK(errno != ECONNABORTED, "client_send", "unexpected error code on  
> destroyed socket\n");
> +
> +
> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
> +}
> +
> +
> +void test_udp(struct sock_destroy_prog *skel)
> +{
> +	int serv = -1, clien = -1, n = 0;
> +
> +	serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
> +	if (CHECK(serv < 0, "start_server", "failed to start server\n"))
> +		goto cleanup_serv;
> +
> +	clien = connect_to_fd(serv, 0);
> +	if (CHECK(clien < 0, "connect_to_fd", "errno %d\n", errno))
> +		goto cleanup_serv;
> +
> +	n = send(clien, "t", 1, 0);
> +	if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
> +		goto cleanup;
> +
> +	start_iter_sockets(skel->progs.iter_udp6);
> +
> +	n = send(clien, "t", 1, 0);
> +	if (CHECK(n > 0, "client_send after destroy", "succeeded on destroyed  
> socket\n"))
> +		goto cleanup;
> +	// UDP sockets have an overriding error code after they are  
> disconnected.

C++-style comments.

> +
> +
> +cleanup:
> +	close(clien);
> +cleanup_serv:
> +	close(serv);
> +}
> +
> +void test_sock_destroy(void)
> +{
> +	int cgroup_fd = 0;
> +	struct sock_destroy_prog *skel;
> +
> +	skel = sock_destroy_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	cgroup_fd = test__join_cgroup("/sock_destroy");
> +	if (CHECK(cgroup_fd < 0, "join_cgroup", "cgroup creation failed\n"))
> +		goto close_cgroup_fd;
> +
> +	skel->links.sock_connect = bpf_program__attach_cgroup(
> +		skel->progs.sock_connect, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.sock_connect, "prog_attach"))
> +		goto close_cgroup_fd;
> +
> +	test_tcp(skel);
> +	test_udp(skel);
> +
> +
> +close_cgroup_fd:
> +	close(cgroup_fd);
> +	sock_destroy_prog__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog.c  
> b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> new file mode 100644
> index 000000000000..c6805a9b7594
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define sock sock___not_used
> +#include "vmlinux.h"
> +#undef sock
> +
> +#include <bpf/bpf_helpers.h>
> +
> +#define AF_INET6 10
> +
> +/* Redefine the struct: vmlinux.h forward declares it, and the loader  
> fails
> + * to load the program as it finds the BTF FWD type for the struct  
> incompatible
> + * with the BTF STRUCT type.
> + */
> +struct sock {
> +	struct sock_common	__sk_common;
> +#define sk_family		__sk_common.skc_family
> +#define sk_cookie		__sk_common.skc_cookie
> +};
> +
> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} tcp_conn_sockets SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} udp_conn_sockets SEC(".maps");
> +
> +SEC("cgroup/connect6")
> +int sock_connect(struct bpf_sock_addr *ctx)
> +{
> +	int key = 0;
> +	__u64 sock_cookie = 0;
> +	__u32 keyc = 0;
> +
> +	if (ctx->family != AF_INET6 || ctx->user_family != AF_INET6)
> +		return 1;
> +
> +	sock_cookie = bpf_get_socket_cookie(ctx);
> +	if (ctx->protocol == IPPROTO_TCP)
> +		bpf_map_update_elem(&tcp_conn_sockets, &key, &sock_cookie, 0);
> +	else if (ctx->protocol == IPPROTO_UDP)
> +		bpf_map_update_elem(&udp_conn_sockets, &keyc, &sock_cookie, 0);
> +	else
> +		return 1;
> +
> +	return 1;
> +}
> +
> +SEC("iter/tcp")
> +int iter_tcp6(struct bpf_iter__tcp *ctx)
> +{
> +	struct sock_common *sk_common = ctx->sk_common;
> +	struct seq_file *seq = ctx->meta->seq;
> +	__u64 sock_cookie = 0;
> +	__u64 *val;
> +	int key = 0;
> +
> +	if (!sk_common)
> +		return 0;
> +
> +	if (sk_common->skc_family != AF_INET6)
> +		return 0;
> +
> +	sock_cookie  = bpf_get_socket_cookie(sk_common);
> +	val = bpf_map_lookup_elem(&tcp_conn_sockets, &key);
> +
> +	if (!val)
> +		return 0;
> +
> +	if (sock_cookie == *val)
> +		bpf_sock_destroy(sk_common);
> +
> +	return 0;
> +}
> +
> +SEC("iter/udp")
> +int iter_udp6(struct bpf_iter__udp *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct udp_sock *udp_sk = ctx->udp_sk;
> +	struct sock *sk = (struct sock *) udp_sk;
> +	__u64 sock_cookie = 0;
> +	int key = 0;
> +	__u64 *val;
> +
> +	if (!sk)
> +		return 0;
> +
> +	sock_cookie  = bpf_get_socket_cookie(sk);
> +	val = bpf_map_lookup_elem(&udp_conn_sockets, &key);
> +
> +	if (!val)
> +		return 0;
> +
> +	if (sock_cookie == *val)
> +		bpf_sock_destroy((struct sock_common *)sk);
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.34.1

