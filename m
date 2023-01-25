Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17367B906
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjAYSJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAYSJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:09:58 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3693722DF1
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:09:57 -0800 (PST)
Message-ID: <41aec8de-1425-aaf7-0a2a-eac849e83eff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674670195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkE7z5m6GZEL6sGio3ZT6/yM+ss9OUSQUpeOFw1mStM=;
        b=jguyZRgxVYIQwJNGoUBtPHpnwzwQPDtT4kbTTJpe6Ax9Zoa/rm0hYEhKakuUvKS9EWwxX5
        vvU3sCQj7OjO/pZQszmlbiHrCwhR3iJoSR1uHLnjjrJp4M89RJoOORaCTKQQTc7O+lxEFd
        gNq7D5P40tJLEKQNztaXPE0q8scQBQ8=
Date:   Wed, 25 Jan 2023 10:09:45 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Calls bpf_setsockopt() on
 a ktls enabled socket.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230124181220.2871611-1-kuifeng@meta.com>
 <20230124181220.2871611-3-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com
In-Reply-To: <20230124181220.2871611-3-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/23 10:12 AM, Kui-Feng Lee wrote:
> +static void test_ktls(int family)
> +{
> +	struct tls12_crypto_info_aes_gcm_128 aes128;
> +	struct setget_sockopt__bss *bss = skel->bss;
> +	int cfd = -1, sfd = -1, fd = -1, ret;
> +
> +	memset(bss, 0, sizeof(*bss));
> +
> +	sfd = start_server(family, SOCK_STREAM,
> +			   family == AF_INET6 ? addr6_str : addr4_str, 0, 0);
> +	if (!ASSERT_GE(sfd, 0, "start_server"))
> +		return;
> +	fd = connect_to_fd(sfd, 0);
> +	if (!ASSERT_GE(fd, 0, "connect_to_fd"))
> +		goto err_out;
> +
> +	cfd = accept(sfd, NULL, 0);
> +	if (!ASSERT_GE(cfd, 0, "accept"))
> +		goto err_out;
> +
> +	close(sfd);
> +	sfd = -1;
> +
> +	/* Setup KTLS */
> +	ret = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
> +	if (!ASSERT_OK(ret, "setsockopt"))
> +		goto err_out;
> +	ret = setsockopt(cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
> +	if (!ASSERT_OK(ret, "setsockopt"))
> +		goto err_out;
> +
> +	memset(&aes128, 0, sizeof(aes128));
> +	aes128.info.version = TLS_1_2_VERSION;
> +	aes128.info.cipher_type = TLS_CIPHER_AES_GCM_128;
> +
> +	ret = setsockopt(fd, SOL_TLS, TLS_TX, &aes128, sizeof(aes128));
> +	if (!ASSERT_OK(ret, "setsockopt"))
> +		goto err_out;
> +
> +	ret = setsockopt(cfd, SOL_TLS, TLS_RX, &aes128, sizeof(aes128));
> +	if (!ASSERT_OK(ret, "setsockopt"))
> +		goto err_out;
> +
> +	/* KTLS is enabled */
> +
> +	close(fd);
> +	/* At this point, the cfd socket is at the CLOSE_WAIT state
> +	 * and still run TLS protocol.  The test for
> +	 * BPF_TCP_CLOSE_WAIT should be run at this point.
> +	 */

Just came to my mind. I think it is better to ensure the cfd got the FIN first 
to avoid potential (unlikely) flaky test:

	ret = read(cfd, ...);
	ASSERT_EQ(ret, 0, ...);


> +	close(cfd);
> +
> +	ASSERT_EQ(bss->nr_listen, 1, "nr_listen");
> +	ASSERT_EQ(bss->nr_connect, 1, "nr_connect");
> +	ASSERT_EQ(bss->nr_active, 1, "nr_active");
> +	ASSERT_EQ(bss->nr_passive, 1, "nr_passive");
> +	ASSERT_EQ(bss->nr_socket_post_create, 2, "nr_socket_post_create");
> +	ASSERT_EQ(bss->nr_binddev, 2, "nr_bind");
> +	ASSERT_EQ(bss->nr_fin_wait1, 1, "nr_fin_wait1");
> +	return;
> +
> +err_out:
> +	close(fd);
> +	close(cfd);
> +	close(sfd);
> +}
> +
>   void test_setget_sockopt(void)
>   {
>   	cg_fd = test__join_cgroup(CG_NAME);
> @@ -118,6 +186,8 @@ void test_setget_sockopt(void)
>   	test_tcp(AF_INET);
>   	test_udp(AF_INET6);
>   	test_udp(AF_INET);
> +	test_ktls(AF_INET6);
> +	test_ktls(AF_INET);
>   
>   done:
>   	setget_sockopt__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> index 9523333b8905..027d95755f9f 100644
> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> @@ -6,6 +6,8 @@
>   #include <bpf/bpf_core_read.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> +#define BPF_PROG_TEST_TCP_HDR_OPTIONS
> +#include "test_tcp_hdr_options.h"

Instead of having dependency on another test's header,

>   
>   #ifndef ARRAY_SIZE
>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> @@ -22,6 +24,7 @@ int nr_active;
>   int nr_connect;
>   int nr_binddev;
>   int nr_socket_post_create;
> +int nr_fin_wait1;
>   
>   struct sockopt_test {
>   	int opt;
> @@ -386,6 +389,11 @@ int skops_sockopt(struct bpf_sock_ops *skops)
>   		nr_passive += !(bpf_test_sockopt(skops, sk) ||
>   				test_tcp_maxseg(skops, sk) ||
>   				test_tcp_saved_syn(skops, sk));
> +		set_hdr_cb_flags(skops, BPF_SOCK_OPS_STATE_CB_FLAG);

how about directly doing this:
                 bpf_sock_ops_cb_flags_set(skops,
                                           skops->bpf_sock_ops_cb_flags |
                                           BPF_SOCK_OPS_STATE_CB_FLAG);

> +		break;
> +	case BPF_SOCK_OPS_STATE_CB:
> +		if (skops->args[1] == BPF_TCP_CLOSE_WAIT)
> +			nr_fin_wait1 += !bpf_test_sockopt(skops, sk);
>   		break;
>   	}
>   

