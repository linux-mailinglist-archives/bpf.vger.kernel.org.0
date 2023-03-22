Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1218C6C3F19
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 01:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCVA3J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 20:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCVA3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 20:29:08 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6981D442EB
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 17:29:07 -0700 (PDT)
Message-ID: <8d8f605d-f722-8a91-4dcf-2017cad40f7b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679444945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDC9Ih3WhES37UutzlIVGKMbYDWZZoHCLDYDz/6dnHw=;
        b=lTLxkvHqSyyCjBZTqmDsMVVWHkJ4bzhXa1X6YaLuYWvsKJvPp5AxHlK2AeFcgJEuFR96HK
        mEF0/Myj9b8unVI1CPX2L+MfLk/ipzhSdfZnBJ5Sh56v5k8UJUtvKVmlZBVXAILodz2/Yw
        z9LSFPgWTeFVXFCkUhXU3+Ey+v46440=
Date:   Tue, 21 Mar 2023 17:29:02 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 4/5] [RFC] udp: Fix destroying UDP listening
 sockets
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        bpf <bpf@vger.kernel.org>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
 <20230321184541.1857363-5-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230321184541.1857363-5-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/21/23 11:45 AM, Aditi Ghag wrote:
> Previously, UDP listening sockets that bind'ed to a port
> weren't getting properly destroyed via udp_abort.
> Specifically, the sockets were left in the UDP hash table with
> unset source port.
> Fix the issue by unconditionally unhashing and resetting source
> port for sockets that are getting destroyed. This would mean
> that in case of sockets listening on wildcarded address and
> on a specific address with a common port, users would have to
> explicitly select the socket(s) they intend to destroy.
> 
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/ipv4/udp.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 02d357713838..a495ac88fcee 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1965,6 +1965,25 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
>   }
>   EXPORT_SYMBOL(udp_pre_connect);
>   
> +int __udp_disconnect_with_abort(struct sock *sk)
> +{
> +	struct inet_sock *inet = inet_sk(sk);
> +
> +	sk->sk_state = TCP_CLOSE;
> +	inet->inet_daddr = 0;
> +	inet->inet_dport = 0;
> +	sock_rps_reset_rxhash(sk);
> +	sk->sk_bound_dev_if = 0;
> +	inet_reset_saddr(sk);
> +	inet->inet_sport = 0;
> +	sk_dst_reset(sk);
> +	/* (TBD) In case of sockets listening on wildcard and specific address
> +	 * with a common port, socket will be removed from {hash, hash2} table.
> +	 */
> +	sk->sk_prot->unhash(sk);

hmm... not sure if I understand the use case. The idea is to enforce the user 
space to bind() again when it gets error from read(fd) because the source 
ip/port needs to change when sending to another dst IP/port? Does it have a 
usage example in the selftests?

> +	return 0;
> +}
> +
>   int __udp_disconnect(struct sock *sk, int flags)
>   {
>   	struct inet_sock *inet = inet_sk(sk);
> @@ -2937,7 +2956,7 @@ int udp_abort(struct sock *sk, int err)
>   
>   	sk->sk_err = err;
>   	sk_error_report(sk);
> -	__udp_disconnect(sk, 0);
> +	__udp_disconnect_with_abort(sk);
>   
>   out:
>   	if (!has_current_bpf_ctx())

