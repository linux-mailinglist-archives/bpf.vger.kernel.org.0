Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F063B9462
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 17:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhGAP6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhGAP6s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Jul 2021 11:58:48 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE526C061762
        for <bpf@vger.kernel.org>; Thu,  1 Jul 2021 08:56:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x20so9167252ljc.5
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=EWMfplk1+E9qv/BJMYr9wuJzgYw35Tkq30B5gBP8ayU=;
        b=KMImn+fMpu/UCH/8Y163vpsWNShJ0j+vmdUzijdVm/6HZjgAgLOj4KpdkctvAgRwSK
         8tLnOFPygqQ1kWbhW38qn7xpTKF2P5pt8NksTvBLmblfl15hJNSTwti2vy/8AfB0Kxj2
         jI4uI5aOc7o66koPJlPE60i43SUw8MSvg4ODs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=EWMfplk1+E9qv/BJMYr9wuJzgYw35Tkq30B5gBP8ayU=;
        b=I8pG8cjIIfub+UJq7ZEZ6SemQ14YtjqvQLSlyYLBC9CJuZuNVNNuTfS9P9IuAHms7n
         YX3VGb/z+RtCko2YeN0xXmLcxgs34mb/unevW/9Q6fx6tuslVL9yMn4vUAoGN1CkrhCH
         sqmLmI3A4B7V7UQ7t+m6U2XWNUNsnG1tVfXckJSKsHPcxx9XLcUCZ9dkK8/Kza6hpXt9
         2LLmYkat9/l4u3EwuREY6/hcUfqvAKkJm7oTJX4Ew3t+/Ubb156XwUMVwFElxNFO04J5
         6vktsOzaSfgCqKzhDqT0kj8aHeSiSuvCDBM74fGJepr7gWkoQ9piMEbmN+SWeREVdeDI
         RQ6Q==
X-Gm-Message-State: AOAM530H7hkcEJCw0Ka/RJnhflEpCogLEX8nma1+kt/If4XEuGpo0rnA
        ZL3xN8gS6WS4OJqbSS0J8TOcvg==
X-Google-Smtp-Source: ABdhPJxu5QBTaoNnXWim8i4I+vDDqdP6jrz4BF3wUCa4CxyVKGKO5mF+Wh4XPuYJsCJH1+EbfivxDA==
X-Received: by 2002:a05:651c:1115:: with SMTP id d21mr181091ljo.476.1625154976091;
        Thu, 01 Jul 2021 08:56:16 -0700 (PDT)
Received: from cloudflare.com (79.191.58.233.ipv4.supernova.orange.pl. [79.191.58.233])
        by smtp.gmail.com with ESMTPSA id t24sm49412ljj.97.2021.07.01.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 08:56:14 -0700 (PDT)
References: <20210701061656.34150-1-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf v2] skmsg: check sk_rcvbuf limit before queuing to
 ingress_skb
In-reply-to: <20210701061656.34150-1-xiyou.wangcong@gmail.com>
Date:   Thu, 01 Jul 2021 17:56:12 +0200
Message-ID: <877diarpsz.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 01, 2021 at 08:16 AM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Jiang observed OOM frequently when testing our AF_UNIX/UDP
> proxy. This is due to the fact that we do not actually limit
> the socket memory before queueing skb to ingress_skb. We
> charge the skb memory later when handling the psock backlog,
> but it is not limited either.
>
> This patch adds checks for sk->sk_rcvbuf right before queuing
> to ingress_skb and drops packets if this limit exceeds. This
> is very similar to UDP receive path. Ideally we should set the
> skb owner before this check too, but it is hard to make TCP
> happy about sk_forward_alloc.
>
> Reported-by: Jiang Wang <jiang.wang@bytedance.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

By saying that it is hard to make TCP happy about sk_forward_alloc, I'm
guessing you're referring to problems described in 144748eb0c44 ("bpf,
sockmap: Fix incorrect fwd_alloc accounting") [1]?

Thanks for the fix.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=144748eb0c445091466c9b741ebd0bfcc5914f3d

[...]
