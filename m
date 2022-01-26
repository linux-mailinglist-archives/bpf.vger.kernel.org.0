Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0722D49C6DE
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 10:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiAZJtz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 04:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiAZJtz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 04:49:55 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A812AC06161C
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 01:49:54 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q127so5776872ljq.2
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 01:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsYmZZVmVWqgaLKAmBGCRvkPtBIIUYO7KDL76PCx8zY=;
        b=fjELwJfGvWtFkfklukvBIQ3ks4Y3vrDw0wHWgLA2ad2D9t8u16gxYhTo7fwIf8HMQv
         Z1WUIDnxts7VKzpvVkSFz5K3O9k6r128BRXxycL9ra4As8+tYjW2Qxkpvi3N3U/Q2QzC
         z5H4++UeDhnbAjqraFN2gvcI+1wp9f7NEGeoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsYmZZVmVWqgaLKAmBGCRvkPtBIIUYO7KDL76PCx8zY=;
        b=m//IqMzXdeRDa7R82grS5zbOawZ2CedznwPD/Y1g5j0KzQeCJ1xOMlo3QZNIdqjQhz
         37OIzdd6/BOPI6mShtQLxrMdTJ2/oeOwFyR1qlNqH9HVakfmilGJA6drf4P7vojfhrRi
         Z8zMtlJFXhoi7eNsTtW85nOlF8bnDbGwX41ejEkVYw+/UwKGK6Tx2V1ArOhoL/ugfzKm
         PcvRxZvwjb3opRApn7TRVMVmBj2bOoCK3mvGPMmpzihu8nBpYwYHs/iZfp2xGOzWmsN/
         ychYcYbwyr/zAcbCJnc22t5EuQLUa933/vX0Z3QJYjkE5ZQZH1Uzqf9AV9H8lvE+dv7w
         XrVg==
X-Gm-Message-State: AOAM530e6Mb+Em7ch3DE174J4kJpmfsstaElQxg73F4LhbnguNLKwUVG
        2O+PHchb3mY8Ige2gS7nhOqQPHCcLNoJN4e9Fj4mAQ==
X-Google-Smtp-Source: ABdhPJxYlr85SblyBnozf1GKr6NTo2JW/LSIixbq1P1TK1EWw8J1poyqjpZITrAU14nn+s+iNIthF8KizZRPvvdKRVI=
X-Received: by 2002:a2e:9e0a:: with SMTP id e10mr17200025ljk.121.1643190592988;
 Wed, 26 Jan 2022 01:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20220124151146.376446-1-maximmi@nvidia.com> <20220124151146.376446-3-maximmi@nvidia.com>
In-Reply-To: <20220124151146.376446-3-maximmi@nvidia.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 Jan 2022 09:49:42 +0000
Message-ID: <CACAyw9_mA-yBWbU6Sf8hq6P46PfiTpEZYTGSKmNG6ZiFWGz=ZQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/4] bpf: Support dual-stack sockets in bpf_tcp_check_syncookie
To:     Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 24 Jan 2022 at 15:13, Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
>
> bpf_tcp_gen_syncookie looks at the IP version in the IP header and
> validates the address family of the socket. It supports IPv4 packets in
> AF_INET6 dual-stack sockets.
>
> On the other hand, bpf_tcp_check_syncookie looks only at the address
> family of the socket, ignoring the real IP version in headers, and
> validates only the packet size. This implementation has some drawbacks:
>
> 1. Packets are not validated properly, allowing a BPF program to trick
>    bpf_tcp_check_syncookie into handling an IPv6 packet on an IPv4
>    socket.
>
> 2. Dual-stack sockets fail the checks on IPv4 packets. IPv4 clients end
>    up receiving a SYNACK with the cookie, but the following ACK gets
>    dropped.
>
> This patch fixes these issues by changing the checks in
> bpf_tcp_check_syncookie to match the ones in bpf_tcp_gen_syncookie. IP
> version from the header is taken into account, and it is validated
> properly with address family.
>
> Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
> Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  net/core/filter.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 05efa691b796..780e635fb52a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6774,24 +6774,33 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
>         if (!th->ack || th->rst || th->syn)
>                 return -ENOENT;
>
> +       if (unlikely(iph_len < sizeof(struct iphdr)))
> +               return -EINVAL;
> +
>         if (tcp_synq_no_recent_overflow(sk))
>                 return -ENOENT;
>
>         cookie = ntohl(th->ack_seq) - 1;
>
> -       switch (sk->sk_family) {
> -       case AF_INET:
> -               if (unlikely(iph_len < sizeof(struct iphdr)))
> +       /* Both struct iphdr and struct ipv6hdr have the version field at the
> +        * same offset so we can cast to the shorter header (struct iphdr).
> +        */
> +       switch (((struct iphdr *)iph)->version) {
> +       case 4:
> +               if (sk->sk_family == AF_INET6 && ipv6_only_sock(sk))
>                         return -EINVAL;

Wouldn't this allow an arbitrary value for sk->sk_family, since there
is no further check that sk_family is AF_INET?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
