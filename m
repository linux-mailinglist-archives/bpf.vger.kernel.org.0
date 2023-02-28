Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381446A62E2
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 23:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjB1Wz1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 17:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB1Wz0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 17:55:26 -0500
Received: from out-24.mta0.migadu.com (out-24.mta0.migadu.com [IPv6:2001:41d0:1004:224b::18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BFD3644A
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 14:55:25 -0800 (PST)
Message-ID: <b28af125-f6dc-d5af-8c07-10aaababb465@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677624922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jh7jqc8fRqnOTgn7MRfKC99KTUGH+iq7U1mHJxA0jok=;
        b=P+8Cp4YKVthl2gnvzxyc0/00zqpzI1Nu3jLmt8pbO+wDbo+mY52UjrKyGBTQAeiVFCD3h8
        AD/c5bNj0k4d2ZDrA/T7k8pLcMopbpUoUlAqAx3Uzys7sRs66HTdocTViETvXgzARqMvsT
        sVgJ5Tizw+3wob0Ctj5l5rpdLZ8N6/o=
Date:   Tue, 28 Feb 2023 14:55:19 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/3] bpf: Add bpf_sock_destroy kfunc
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        bpf@vger.kernel.org
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-3-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230223215311.926899-3-aditi.ghag@isovalent.com>
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

On 2/23/23 1:53 PM, Aditi Ghag wrote:
> +/* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
> + *
> + * The helper expects a non-NULL pointer to a full socket. It invokes
> + * the protocol specific socket destroy handlers.
> + *
> + * The helper can only be called from BPF contexts that have acquired the socket
> + * locks.
> + *
> + * Parameters:
> + * @sock: Pointer to socket to be destroyed
> + *
> + * Return:
> + * On error, may return EPROTONOSUPPORT, EINVAL.
> + * EPROTONOSUPPORT if protocol specific destroy handler is not implemented.
> + * 0 otherwise
> + */
> +int bpf_sock_destroy(struct sock_common *sock)
> +{
> +	/* Validates the socket can be type casted to a full socket. */
> +	struct sock *sk = sk_to_full_sk((struct sock *)sock);

If sk != sock, sk is not locked.

Does it have to do sk_to_full_sk()? From looking at tcp_abort(), it can handle 
TCP_NEW_SYN_RECV and TCP_TIME_WAIT. The bpf-tcp-iter is iterating the hashtables 
that may have sk in different states. Ideally, bpf-tcp-iter should be able to 
use bpf_sock_destroy() to abort the sk in different states also.

Otherwise, the bpf_sock_destroy kfunc is aborting the listener while the bpf 
prog expects to abort a req_sk.

> +
> +	if (!sk)
> +		return -EINVAL;
> +
> +	/* The locking semantics that allow for synchronous execution of the
> +	 * destroy handlers are only supported for TCP and UDP.
> +	 */
> +	if (!sk->sk_prot->diag_destroy || sk->sk_protocol == IPPROTO_RAW)
> +		return -EOPNOTSUPP;
> +
> +	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +}
> +
> +__diag_pop()

