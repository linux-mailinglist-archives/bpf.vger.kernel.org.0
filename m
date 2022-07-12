Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178FB571B06
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 15:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiGLNUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 09:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLNUu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 09:20:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A41422D8
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 06:20:49 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y195so13941637yby.0
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgplIbYGZStxvy6kBPwzY7tvzlqnbWL1ukxWQkjqjxQ=;
        b=NK+19/L2duAPWC9U9IH0+V9hMN58tqGeRNlvI9XGf0ct7PySCH1WsIR3iWdlsbHY7C
         9zeLrrnEB22JarA9goFT6i9IgEmILtaA8/JWbowZisAHmztjCghFC6YyofEJbxSypP7P
         7jtn9aB7oOdnVoDTeBdvoZHHRgLqC0Aki3AS6VOlVQFjEKIL16TorY1ctcjQ5jJTBUGA
         uvXatfQRfIToebGfRmQmW6WcaCq4vZfOPBDBNSE/QLUeTl9Ow/JfktdYfPwYwoI1wGKU
         d49vp9k/FOrGZL2wqPqQ+tSNEachb5PdYQRfa2zXDbuyU/O5QmbT805n59W88rppxnMd
         wBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgplIbYGZStxvy6kBPwzY7tvzlqnbWL1ukxWQkjqjxQ=;
        b=G7CfkvjG+mzaCpWvExx4qa9p1Y3VETLYNxI78+vSnVUpQt1A1YcsBy/1DfyT1llScw
         eonJDGs9X8rshNiFR709TEQZ7mBExlFDFHSEAv27ypqoTqlqBKmf6h5LFQ5/bWpiXiO7
         nDfmjD9KihDHQKPYUP6SPtybZ3ajhYGhpEUbap0h8G9voAV/apCVnTlcfTMWZCr0ZHpx
         AOHLzL94ggS8n4uJrErOkv8InbYYl3Zotp0hFlFGM4EemjXFqEeGNkk2FEdNdlME70WK
         wCIpU7yfSPXPVDWbm5k7fYvAogokYvM2fGyHx7JmQ1+UixCOcv4YRrHhAapJ3cV4TXrI
         H4gw==
X-Gm-Message-State: AJIora+FneZTmb8iw9+28Jl0b3AaHVew69fhNY7cQqlgIHd22SFETDNN
        2TGP+60l/dQvRO9TwLTKWYwzyU5hKTHkHI2guHH+BA==
X-Google-Smtp-Source: AGRyM1vDcxq0itawvT8h/jiNruNgCov2wzidRFCPIYqfIrZeghKpIysv2bL6bLJOwbcRq1cM4C9LTyRyliKOYNTcn6o=
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr22934795ybh.36.1657632048898; Tue, 12
 Jul 2022 06:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220709222029.297471-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20220709222029.297471-1-xiyou.wangcong@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Jul 2022 15:20:37 +0200
Message-ID: <CANn89iJSQh-5DAhEL4Fh5ZDrtY47y0Mo9YJbG-rnj17pdXqoXA@mail.gmail.com>
Subject: Re: [Patch bpf-next] tcp: fix sock skb accounting in tcp_read_skb()
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        syzbot <syzbot+a0e6f8738b58f7654417@syzkaller.appspotmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jul 10, 2022 at 12:20 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> Before commit 965b57b469a5 ("net: Introduce a new proto_ops
> ->read_skb()"), skb was not dequeued from receive queue hence
> when we close TCP socket skb can be just flushed synchronously.
>
> After this commit, we have to uncharge skb immediately after being
> dequeued, otherwise it is still charged in the original sock. And we
> still need to retain skb->sk, as eBPF programs may extract sock
> information from skb->sk. Therefore, we have to call
> skb_set_owner_sk_safe() here.
>
> Fixes: 965b57b469a5 ("net: Introduce a new proto_ops ->read_skb()")
> Reported-and-tested-by: syzbot+a0e6f8738b58f7654417@syzkaller.appspotmail.com
> Tested-by: Stanislav Fomichev <sdf@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  net/ipv4/tcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 9d2fd3ced21b..c6b1effb2afd 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1749,6 +1749,7 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>                 int used;
>
>                 __skb_unlink(skb, &sk->sk_receive_queue);
> +               WARN_ON(!skb_set_owner_sk_safe(skb, sk));
>                 used = recv_actor(sk, skb);
>                 if (used <= 0) {
>                         if (!copied)
> --
> 2.34.1
>

I am reading tcp_read_skb(),it seems to have other bugs.
I wonder why syzbot has not caught up yet.

It ignores the offset value from tcp_recv_skb(), this looks wrong to me.
The reason tcp_read_sock() passes a @len parameter is that is it not
skb->len, but (skb->len - offset)

Also if recv_actor(sk, skb) returns 0, we probably still need to
advance tp->copied_seq,
for instance if skb had a pure FIN (and thus skb->len == 0), since you
removed the skb from sk_receive_queue ?
