Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7491D3564
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgENPlt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgENPls (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 11:41:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23AC061A0C
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 08:41:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o7so24928470oif.2
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krhEvs5AIC6c0blTdWgcO9e/a3Tv7GaFT6TP0m8Yvrg=;
        b=VB9/gPmHsoRpHSiZ+teQTdbR7k5Yx9LUkOOlUhj6CK9m6appdBeu58cVhfrSPmSix/
         3v3ZUdasGK8BSHClTekzcGkFePUktwlGQZ1nSVQDKo8aiBQzX6bu17upOZvBsq7RaaEI
         lNYHL+Pbu+eDytzphVZ0j4ysZcQNNyaubkxv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krhEvs5AIC6c0blTdWgcO9e/a3Tv7GaFT6TP0m8Yvrg=;
        b=a7P5BMMKwdHxKsrn+NhIfV3vYWm11uKC5mgQsxevon3rbItLZIEFqkGrUu8rgMXfWY
         HW62Qutvl5Z6AvAywx5GN3iAQlK7+jDqe3rW8tFyEUHwyVzAHKzQlOMbcf5mU9HrjRi2
         3OjOraEx7no3k5dKB5Ncra2OpDgbsxUJX6JKRxYmpdOZ7iyD5q2jQWq2xhpkXTnzy3kk
         hatbMVhxGR7y3YEott0ibjBXsTWVghQP2oKpxt98Cblcg7DlB2h8yCq38poKlVrvm60j
         hYbgw9e0CCku+pBdHGIcz8A1eYWZaqQIgYDe/KBWnAce9DYpFsqEQSBXX+wCXBcdnAgY
         iing==
X-Gm-Message-State: AGi0PuZGIGFEEKLhyVHk4aawE0zBFssitz7AcHmgLw+y15tN2xHfZ1mo
        469Xx9jwlE57d7FvL1SeUrILTvIX0B0Sw5f0v2yvuQ==
X-Google-Smtp-Source: APiQypJ31s2KLZTgcqdErYLq4+L9Mykr2/IzY3TtcqTc0aQO8sNe28o8Z8FhG5lx/JIbxY5/yN/4559ZnylTzXEpAdE=
X-Received: by 2002:a05:6808:a91:: with SMTP id q17mr29695049oij.102.1589470904531;
 Thu, 14 May 2020 08:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9_4Uzh0GqAR16BfEHQ0ZWHKGUKacOQwwhwsfhdCTMtsNQ@mail.gmail.com>
 <51358f25-72c2-278d-55aa-f80d01d682f9@gmail.com>
In-Reply-To: <51358f25-72c2-278d-55aa-f80d01d682f9@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 14 May 2020 16:41:33 +0100
Message-ID: <CACAyw9-7Ua1W6t1B8StWjUC4ui4OUpOX7XtKnzTNARVdgMFqsg@mail.gmail.com>
Subject: Re: "Forwarding" from TC classifier
To:     David Ahern <dsahern@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Martynas Pumputis <m@lambda.lt>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 13 May 2020 at 22:23, David Ahern <dsahern@gmail.com> wrote:
>
> On 5/13/20 10:40 AM, Lorenz Bauer wrote:
> > Really, I'd like to get rid of step 1, and instead rely on the network
> > stack to switch or route
> > the packet for me. The bpf_fib_lookup helper is very close to what I need. I've
> > hacked around a bit, and come up with the following replacement for step 1:
> >
> >     switch (bpf_fib_lookup(skb, &fib, sizeof(fib), 0)) {
> >     case BPF_FIB_LKUP_RET_SUCCESS:
> >         /* There is a cached neighbour, bpf_redirect without going
> > through the stack. */
> >         return bpf_redirect(...);
>
> BTW, as shown in samples/bpf/xdp_fwd_kern.c, you have a bit more work to
> do for proper L3 forwarding:
>
>         if (rc == BPF_FIB_LKUP_RET_SUCCESS) {
>                 ...
>                 if (h_proto == htons(ETH_P_IP))
>                         ip_decrease_ttl(iph);
>                 else if (h_proto == htons(ETH_P_IPV6))
>                         ip6h->hop_limit--;
>
>                 memcpy(eth->h_dest, fib_params.dmac, ETH_ALEN);
>                 memcpy(eth->h_source, fib_params.smac, ETH_ALEN);
>                 return bpf_redirect_map(&xdp_tx_ports,
> fib_params.ifindex, 0);
>
> The ttl / hoplimit decrements assumed you checked it earlier to be > 1

Thanks for the pointer :)


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
