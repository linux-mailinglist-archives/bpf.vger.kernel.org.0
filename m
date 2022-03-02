Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688274CAFBA
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiCBUbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 15:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbiCBUbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 15:31:10 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4ACA70C
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 12:30:27 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2dbc48104beso32273247b3.5
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UaZjV0aO1GTKHJNv9I7dWSl7nZuVjA9vx6x1n4ijqE=;
        b=ILGUHrLh2HmR7F0Adx7BBIoB5e7CJoAf6K5BB7HTANb5w8ws+OqH37imSKfBXnGi1T
         YZJ9PCUIB/LZXjIYevsK4VRVmJ3K4hakQ1ndzcNFcEWOywXnl2btEmfLvdnVVBaN6xSN
         m4okvvfMrpyW6Mzbkn/jG8hIBP2a0WCQFO5OggEpPQvnZyehVx+tzRPbIwmUgizqvtR8
         P+tZUimyGePax5mA2BlauKGi2nupErCaqDMXAXC371jNhv2Df6QaK1FBVFndtJFcBPmD
         vt6YBHTKBNRHP8rhdQM73PhSVxA4wfSILw8/tvy6gFaO6LcbedtETGJGJtpAOBR2CgFy
         Bymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UaZjV0aO1GTKHJNv9I7dWSl7nZuVjA9vx6x1n4ijqE=;
        b=f5v2BWLx3BI7estn3B5nKzYvHRv06u35cI56sBSUuEGPShM/HBwqVpUG1zDDmjHjLC
         Op/rxoxxnS4v1RRHWPbZOy/j+4N43h7xlNmOX/I5OZy4Q3F9o6e18ufsU2kvc8UYubzo
         2iAEpH0H/sRcLWJWCHK4PWvgnnJKbAhMcUzja42e3KsRpdpCGR9cxFb3CoOVMU0KbvgV
         866Sr6xbopYlX/aDTaTapVY2KDpnEfiHltD1AJ/ipZYUjahHc15nX9I1WfWP5LGLmobu
         0zrbPtcnJb9EfiO61Zz4FDlbi6S2Hr5EPB1DtAgFynhbDtSWfBEnv6P4nvd5tYPE42+4
         K1EQ==
X-Gm-Message-State: AOAM530TxghbLmCo/FPe2GR4xR37j0lYr396WKxoQtIIH2AqfIf8Rh+C
        /lIT+KbWgTIyo3t8pLSpzzQjFuc/rH1t78cExYYfErLH1Jg+dw==
X-Google-Smtp-Source: ABdhPJyqkDgpV+IHEQLGmc5+nVOUVkKPjHWGlW/CzFyDVl5yftztKfDJWKQaRLBBXbDnGejnANXfrBWwJzAQBGU7Dfk=
X-Received: by 2002:a81:846:0:b0:2db:f920:5c62 with SMTP id
 67-20020a810846000000b002dbf9205c62mr8100092ywi.489.1646253025949; Wed, 02
 Mar 2022 12:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20220302195519.3479274-1-kafai@fb.com> <20220302195622.3483941-1-kafai@fb.com>
In-Reply-To: <20220302195622.3483941-1-kafai@fb.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 2 Mar 2022 12:30:14 -0800
Message-ID: <CANn89iKN06bKxjrEeZAmcj0x4tYMwRv-YzdZLWKbCcuTYT+SpQ@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 10/13] net: Postpone skb_clear_delivery_time()
 until knowing the skb is delivered locally
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 11:56 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> The previous patches handled the delivery_time in the ingress path
> before the routing decision is made.  This patch can postpone clearing
> delivery_time in a skb until knowing it is delivered locally and also
> set the (rcv) timestamp if needed.  This patch moves the
> skb_clear_delivery_time() from dev.c to ip_local_deliver_finish()
> and ip6_input_finish().
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  net/core/dev.c       | 8 ++------
>  net/ipv4/ip_input.c  | 1 +
>  net/ipv6/ip6_input.c | 1 +
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0fc02cf32476..3ff686cc8c84 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5193,10 +5193,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>                         goto out;
>         }
>
> -       if (skb_skip_tc_classify(skb)) {
> -               skb_clear_delivery_time(skb);
> +       if (skb_skip_tc_classify(skb))
>                 goto skip_classify;
> -       }
>
>         if (pfmemalloc)
>                 goto skip_taps;
> @@ -5225,14 +5223,12 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
>                         goto another_round;
>                 if (!skb)
>                         goto out;
> -               skb_clear_delivery_time(skb);
>
>                 nf_skip_egress(skb, false);
>                 if (nf_ingress(skb, &pt_prev, &ret, orig_dev) < 0)
>                         goto out;
> -       } else
> +       }
>  #endif
> -               skb_clear_delivery_time(skb);
>         skb_reset_redirect(skb);
>  skip_classify:
>         if (pfmemalloc && !skb_pfmemalloc_protocol(skb))
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index d94f9f7e60c3..95f7bb052784 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -226,6 +226,7 @@ void ip_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int protocol)
>
>  static int ip_local_deliver_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> +       skb_clear_delivery_time(skb);
>         __skb_pull(skb, skb_network_header_len(skb));
>
>         rcu_read_lock();
> diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
> index d4b1e2c5aa76..5b5ea35635f9 100644
> --- a/net/ipv6/ip6_input.c
> +++ b/net/ipv6/ip6_input.c
> @@ -459,6 +459,7 @@ void ip6_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int nexthdr,
>
>  static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> +       skb_clear_delivery_time(skb);
>         rcu_read_lock();
>         ip6_protocol_deliver_rcu(net, skb, 0, false);
>         rcu_read_unlock();
> --
> 2.30.2
>

It is not clear to me why we need to clear tstamp if packet is locally
delivered ?

TCP stack is using tstamp for incoming packets (look for
TCP_SKB_CB(skb)->has_rxtstamp)
