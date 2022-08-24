Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAAB59F4E0
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiHXISK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiHXISJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 04:18:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F352C7FE73
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 01:18:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq23so13916293lfb.7
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=ff5Qt/j/QnVqB0IaPQ2m55f5W7yow+gsXjem5McFm4o=;
        b=MMr+JxiCWT+CYH95HVcKgSABCPpEyQhKoaEAtL4rI824M4HGHVZcAzjdzrDHEwvKOW
         sJlhKh1cLYOvDXKBcWfhxq1YqF/tGzj4VR2YrKUvWxOxoZqTkIF0lnc983bpN5rQZyHe
         9HroQrvrFoB3EnHOnp9syD/0s5leiHc73KEtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=ff5Qt/j/QnVqB0IaPQ2m55f5W7yow+gsXjem5McFm4o=;
        b=EVC3Xtgj0A6U1h4PV1TWYLMq94CpIV3ISsymdLLViUCqxvjx9ysiRDKO3pka4eaxOJ
         vcDNtYLx6Dt002F/ir/C/BslxP7aRvETomA19DyJbMb7mILyZFeSWWWVhG+uQ5PRSlW9
         OKfIolRQ1DAra1Kw9jPSHFA/bwUovNgLQ1y6wzu6/b/zYwAUQ94yVJ7k12yKYSxB5LAe
         EbeJt+sw1wPxAzXZ9UahD43gH0MKCVibuUOnFJt2HHJ9MXyoqo8lM/xDfPLwCx4U24w5
         0n+DyMmdR6ocNf4elYY7jzbjCaZGgeeDQ2fwA+G/o/jbjztCk9hszE3o5tJcFF+E/ZPC
         KJrw==
X-Gm-Message-State: ACgBeo1RnAHgDd1mJCZGijJCtuRwuhxIlRjbs6PAgdjin+WMUR1SmTlE
        RDdaCk4N0d9rQqf/DYnJeEqTrA==
X-Google-Smtp-Source: AA6agR5CcrnKST+AVVdctkZYmE1KaPNn7DI+RWa+42f7T8zLN9nKIuyYTzuRBE2QYjY8BJbaOyuDew==
X-Received: by 2002:a05:6512:6d5:b0:491:a52b:2a47 with SMTP id u21-20020a05651206d500b00491a52b2a47mr9582656lff.608.1661329086295;
        Wed, 24 Aug 2022 01:18:06 -0700 (PDT)
Received: from cloudflare.com (79.191.57.8.ipv4.supernova.orange.pl. [79.191.57.8])
        by smtp.gmail.com with ESMTPSA id du9-20020a056512298900b0048a85334a11sm616851lfb.143.2022.08.24.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 01:18:05 -0700 (PDT)
References: <20220817195445.151609-1-xiyou.wangcong@gmail.com>
 <20220817195445.151609-2-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        syzbot+a0e6f8738b58f7654417@syzkaller.appspotmail.com,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch net v3 1/4] tcp: fix sock skb accounting in tcp_read_skb()
Date:   Wed, 24 Aug 2022 10:17:33 +0200
In-reply-to: <20220817195445.151609-2-xiyou.wangcong@gmail.com>
Message-ID: <87r1169hs2.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 12:54 PM -07, Cong Wang wrote:
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
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  net/ipv4/tcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 970e9a2cca4a..05da5cac080b 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1760,6 +1760,7 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  		int used;
>  
>  		__skb_unlink(skb, &sk->sk_receive_queue);
> +		WARN_ON(!skb_set_owner_sk_safe(skb, sk));
>  		used = recv_actor(sk, skb);
>  		if (used <= 0) {
>  			if (!copied)

That is a frequent operation.

Don't we want WARN_ON_ONCE like in tcp_read_sock?
