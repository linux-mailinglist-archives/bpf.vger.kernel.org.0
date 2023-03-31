Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499836D2925
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjCaUJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaUJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 16:09:43 -0400
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [IPv6:2001:41d0:203:375::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F0F21ABF
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 13:09:38 -0700 (PDT)
Message-ID: <42a8dceb-2551-715b-b871-db55eb43bd0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680293375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OufdOS4G9J3DMoqbUSiPajPAQDupZ6+j+fN0P6RN9Ps=;
        b=tuXwNGEE12iX1n2ddfRHTCJzGuUvlLWaY1oLDGx7MESkVI5+ONHNh74eDCp9AwNATchJTA
        5e8tXVw52CVvFF0qV5DsbQGJTDGGa3Fk1mjMQlS0KDCOAoyapUnYBMqmvN4FfbES0FNXE8
        DQ1iu7xlyOwKp7nOT/JJf0chbsbuAus=
Date:   Fri, 31 Mar 2023 13:09:30 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 3/7] udp: seq_file: Helper function to match
 socket attributes
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        bpf@vger.kernel.org
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-4-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230330151758.531170-4-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/23 8:17 AM, Aditi Ghag wrote:
> This is a preparatory commit to refactor code that matches socket
> attributes in iterators to a helper function, and use it in the
> proc fs iterator.
> 
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>   net/ipv4/udp.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c574c8c17ec9..cead4acb64c6 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2983,6 +2983,8 @@ EXPORT_SYMBOL(udp_prot);
>   /* ------------------------------------------------------------------------ */
>   #ifdef CONFIG_PROC_FS
>   
> +static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk);
> +
>   static struct udp_table *udp_get_table_afinfo(struct udp_seq_afinfo *afinfo,
>   					      struct net *net)
>   {
> @@ -3010,10 +3012,7 @@ static struct sock *udp_get_first(struct seq_file *seq, int start)
>   
>   		spin_lock_bh(&hslot->lock);
>   		sk_for_each(sk, &hslot->head) {
> -			if (!net_eq(sock_net(sk), net))
> -				continue;
> -			if (afinfo->family == AF_UNSPEC ||
> -			    sk->sk_family == afinfo->family)
> +			if (seq_sk_match(seq, sk))
>   				goto found;
>   		}
>   		spin_unlock_bh(&hslot->lock);
> @@ -3034,9 +3033,7 @@ static struct sock *udp_get_next(struct seq_file *seq, struct sock *sk)
>   
>   	do {
>   		sk = sk_next(sk);
> -	} while (sk && (!net_eq(sock_net(sk), net) ||
> -			(afinfo->family != AF_UNSPEC &&
> -			 sk->sk_family != afinfo->family)));
> +	} while (sk && !seq_sk_match(seq, sk));
>   
>   	if (!sk) {
>   		udptable = udp_get_table_afinfo(afinfo, net);
> @@ -3143,6 +3140,17 @@ struct bpf_iter__udp {
>   	int bucket __aligned(8);
>   };
>   
> +static unsigned short seq_file_family(const struct seq_file *seq);
> +
> +static inline bool seq_sk_match(struct seq_file *seq, const struct sock *sk)

This won't work under CONFIG_BPF_SYSCALL. The bot also complained.
It has to be under CONFIG_PROG_FS.

No need to use inline and leave it to compiler.

The earlier forward declaration is unnecessary. Define the function earlier instead.

> +{
> +	unsigned short family = seq_file_family(seq);
> +
> +	/* AF_UNSPEC is used as a match all */
> +	return ((family == AF_UNSPEC || family == sk->sk_family) &&
> +		net_eq(sock_net(sk), seq_file_net(seq)));
> +}
> +
>   static int udp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
>   			     struct udp_sock *udp_sk, uid_t uid, int bucket)
>   {
> @@ -3194,6 +3202,19 @@ static const struct seq_operations bpf_iter_udp_seq_ops = {
>   	.stop		= bpf_iter_udp_seq_stop,
>   	.show		= bpf_iter_udp_seq_show,
>   };
> +
> +static unsigned short seq_file_family(const struct seq_file *seq)

The same here because seq_sk_match() uses seq_file_family().

> +{
> +	const struct udp_seq_afinfo *afinfo;
> +
> +	/* BPF iterator: bpf programs to filter sockets. */
> +	if (seq->op == &bpf_iter_udp_seq_ops)

Note that bpf_iter_udp_seq_ops is only defined under CONFIG_BPF_SYSCALL though.
See how the seq_file_family() is handling it in tcp_ipv4.c.

> +		return AF_UNSPEC;
> +
> +	/* Proc fs iterator */
> +	afinfo = pde_data(file_inode(seq->file));
> +	return afinfo->family;
> +}
>   #endif
>   
>   const struct seq_operations udp_seq_ops = {

