Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD11678D0C
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjAXA4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 19:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjAXA4C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 19:56:02 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F5836FE0
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 16:56:01 -0800 (PST)
Message-ID: <4f1ecb2a-e6bc-028b-8e77-bd45160fddc3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674521759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBNyGOGfpeLK7AySusV5jYE5zTBfpYTWcExrQjbNcv8=;
        b=u2kiazXsMIL0n6ThHohp27yb+cobBszCPOftWb9x1Jek8THv5hWdacyINXwmGjiKZQMv6S
        NuHHfB9150zqKkiVL3SR2twtG0f6oQC8WM57ToXi7MZEjTqezXkrQl5OZuNPrCR8tzls/v
        ZTtd9bnfPhO2hKrlk7oUCYc0Bgz/684=
Date:   Mon, 23 Jan 2023 16:55:52 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Check the protocol of a sock to agree
 the calls to bpf_setsockopt().
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230121025716.3039933-1-kuifeng@meta.com>
 <20230121025716.3039933-2-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230121025716.3039933-2-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/20/23 6:57 PM, Kui-Feng Lee wrote:
> Resolve an issue when calling sol_tcp_sockopt() on a socket with ktls
> enabled. Prior to this patch, sol_tcp_sockopt() would only allow calls
> if the function pointer of setsockopt of the socket was set to
> tcp_setsockopt(). However, any socket with ktls enabled would have its
> function pointer set to tls_setsockopt(). To resolve this issue, the
> patch adds a check of the protocol of the linux socket and allows
> bpf_setsockopt() to be called if ktls is initialized on the linux
> socket. This ensures that calls to sol_tcp_sockopt() will succeed on
> sockets with ktls enabled.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>   net/core/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index b4547a2c02f4..890384cbdeb2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5204,7 +5204,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>   			   char *optval, int *optlen,
>   			   bool getopt)
>   {
> -	if (sk->sk_prot->setsockopt != tcp_setsockopt)
> +	if (sk->sk_protocol != IPPROTO_TCP)

It is a pretty broad test but I don't see particular issue also. Let see how it 
goes.

