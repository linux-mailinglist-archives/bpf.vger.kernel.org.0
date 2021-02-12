Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36166319CE6
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 11:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBLK5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 05:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBLK5F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 05:57:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948FFC061786
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:56:14 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w36so12482415lfu.4
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5p98chmjZ1paANKxh0xvpJUxvwk5iTCCl2wXTp6kE4A=;
        b=ldHm6zf/knVFl/iODnIB4Z7QWak9Yq30LCVAEY0zVK3s6qwxRvu+63jMGxf2Pq6V6w
         zwmNPQXwJ58FewxLvgCDLP7EH5rCiYt7j7mn0lAOxYB6m226XFReZsK++oP8XaVh41s2
         8pdxGFr/YKU0zjcX7J0oMp+fOMAHXX94Ni7fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5p98chmjZ1paANKxh0xvpJUxvwk5iTCCl2wXTp6kE4A=;
        b=BAItv6GP9TkfRANR78XW6+10KdsNMA1CeGtmIsn0v+kQL55gukWchwmRaRA6OCaonA
         pMwOzObZf/ZhPjV8JJx62rrM88cP6MWclZNBwtNHIGyc/zlPIVT29A463a10n6+2dhv0
         vldUy5hjoa2hSKzyZT5CXu5SQL1XoeSUB3azeO2FXOqp63Nt6TUxHngE0oBsP2QLhegl
         JUdWUphvIUJqrO116DjjJwLWyFreT4h0h3xgFaYn3gOG6nQCKuTXmr3DIGtYb6/pLBbZ
         FLQ5xS9WwtU1FewU02+HuGeRJrWwctwRrXQHMDoA47RtWxeHcbW4eUNvobBrtp2TL2ZV
         CtAg==
X-Gm-Message-State: AOAM531ClXvdTpyhi/ETM6RcfZ+VHqXxkNzvfWK6UXKvx+K4ksgdajZH
        Z8P6wsQuaVd1RmbHQF/CVBv1iJ68MlHsKHzmLV0VHA==
X-Google-Smtp-Source: ABdhPJxeLOc/PP0Ezqtu2e/mPHDaLarwtif9hcBXG1ZxnHTxVhZ0Gmish5TBnvwXv7FDKBnQOgbCZb7jub3txewj1Tc=
X-Received: by 2002:ac2:52bc:: with SMTP id r28mr567890lfm.451.1613127373154;
 Fri, 12 Feb 2021 02:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20210210022136.146528-1-xiyou.wangcong@gmail.com> <20210210022136.146528-3-xiyou.wangcong@gmail.com>
In-Reply-To: <20210210022136.146528-3-xiyou.wangcong@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 12 Feb 2021 10:56:01 +0000
Message-ID: <CACAyw98HxkT99rA-PDSGqOyRgSxGoye_LQqR2FmK8M3KwgY+JQ@mail.gmail.com>
Subject: Re: [Patch bpf-next v2 2/5] skmsg: get rid of struct sk_psock_parser
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Feb 2021 at 02:21, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> struct sk_psock_parser is embedded in sk_psock, it is
> unnecessary as skb verdict also uses ->saved_data_ready.
> We can simply fold these fields into sk_psock, and get rid
> of ->enabled.

Looks nice, can you use sk_psock_strp_enabled() more? There are a
couple places in sock_map.c which test psock->saved_data_ready
directly.


--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
