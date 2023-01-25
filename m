Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB6967C0B0
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 00:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjAYXRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 18:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAYXRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 18:17:10 -0500
Received: from out-129.mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50253B67A
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 15:17:07 -0800 (PST)
Message-ID: <638f080b-ee7d-2cd6-07e1-dbbc2dcded0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674688625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krOxZTsfEIoI7PdILhN/JuCbQkJGxUeTBPwnjJWJoIk=;
        b=UEhclUqnarJRCC4huOrOGnKUM6QUXDlrwtNMT5LgWZFdG0w6QkSuKi8ZOefzhTqg0cgtcl
        OuGy4yUwutzeXqDPhXmI9zAJ8pla5iVYslMCvGtepaMoWmidhJkUgmRTtoip126CZsW+XN
        C0cxKfTpwqSsy/WDak0TYnYrUoBY/js=
Date:   Wed, 25 Jan 2023 15:17:00 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Calls bpf_setsockopt() on
 a ktls enabled socket.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230125201608.908230-1-kuifeng@meta.com>
 <20230125201608.908230-3-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230125201608.908230-3-kuifeng@meta.com>
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

On 1/25/23 12:16 PM, Kui-Feng Lee wrote:
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
> +	char buf[1];

This checkpatch warning is reasonable:

https://patchwork.kernel.org/project/netdevbpf/patch/20230125201608.908230-3-kuifeng@meta.com/

WARNING: Missing a blank line after declarations
#88: FILE: tools/testing/selftests/bpf/prog_tests/setget_sockopt.c:138:
+	char buf[1];
+	ret = read(cfd, buf, 1);

I fixed it up and take this chance to move it to the beginning of the function. 
Applied. Thanks.


> +	ret = read(cfd, buf, 1);
> +	ASSERT_EQ(ret, 0, "read");
> +	close(cfd);

