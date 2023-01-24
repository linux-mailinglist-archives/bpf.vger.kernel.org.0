Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA0678D05
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 01:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjAXAwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 19:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjAXAwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 19:52:45 -0500
Received: from out-244.mta0.migadu.com (out-244.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF99632E70
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 16:52:41 -0800 (PST)
Message-ID: <737b9af6-4e2a-9da7-3968-fcb466e1eb8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674521560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kChPADyxo68r1RyQNrrLnR/jmwH8GUoEDfzGnMC0ph4=;
        b=nc2VGisF9RWNRqskG1A+G+cqkBtLdtK31lOc/GvabvR+M+B3UcE7mo25ySzf7006BmwSh2
        pgGcv69xSkhyar1iy4vzkaJRyzC8YqJNfAH6N5SQgLuOJerzkD2fjng3FzILcZuD1Fuevr
        qpQotCZeTh65NqJJCSQujE3UYqCV37w=
Date:   Mon, 23 Jan 2023 16:52:35 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Calls bpf_setsockopt() on a
 ktls enabled socket.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230121025716.3039933-1-kuifeng@meta.com>
 <20230121025716.3039933-3-kuifeng@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, kernel-team@meta.com
In-Reply-To: <20230121025716.3039933-3-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/20/23 6:57 PM, Kui-Feng Lee wrote:
> +static void test_ktls(void)
> +{
> +	struct tls12_crypto_info_aes_gcm_128 aes128;
> +	struct setget_sockopt__bss *bss = skel->bss;
> +	int cfd = -1, sfd = -1, fd = -1, ret;
> +
> +	memset(bss, 0, sizeof(*bss));
> +
> +	sfd = start_server(AF_INET, SOCK_STREAM, addr4_str, 0, 0);
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
> +	if (ret != 0) {

nit. ASSERT_OK(ret, ...). It should print the errno also.

> +		ASSERT_EQ(errno, ENOENT, "setsockopt return ENOENT");
> +		printf("Failure setting TCP_ULP, testing without tls\n");

Then these two ASSERT_EQ and printf are not needed.

> +		goto err_out;
> +	}
> +	ret = setsockopt(cfd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
> +	if (!ASSERT_EQ(ret, 0, "setsockopt"))

nit. ASSERT_OK.

> +		goto err_out;
> +
> +	memset(&aes128, 0, sizeof(aes128));
> +	aes128.info.version = TLS_1_2_VERSION;
> +	aes128.info.cipher_type = TLS_CIPHER_AES_GCM_128;
> +
> +	ret = setsockopt(fd, SOL_TLS, TLS_TX, &aes128, sizeof(aes128));
> +	if (!ASSERT_EQ(ret, 0, "setsockopt"))
> +		goto err_out;
> +
> +	ret = setsockopt(cfd, SOL_TLS, TLS_RX, &aes128, sizeof(aes128));
> +	if (!ASSERT_EQ(ret, 0, "setsockopt"))
> +		goto err_out;
> +
> +	/* KTLS is enabled */
> +
> +	close(fd);
> +	/* At this point, the cfd socket is at the CLOSE_WAIT state
> +	 * and still run TLS protocol.  The test for
> +	 * BPF_TCP_CLOSE_WAIT should be run at this point.
> +	 */
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
> @@ -118,6 +188,7 @@ void test_setget_sockopt(void)
>   	test_tcp(AF_INET);
>   	test_udp(AF_INET6);
>   	test_udp(AF_INET);
> +	test_ktls();

Although not related to the IPPROTO_IPV6 code path, it seems pretty cheap to 
test AF_INET6 also like the above tests?


