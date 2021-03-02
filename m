Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D732B335
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352472AbhCCDtf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839536AbhCBQhX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:23 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF3C0611C1
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 08:23:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b1so21421805lfb.7
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcVHR6+gABrqPot+5DAzhb8/k5TtG4mpDhY9zzDMCc0=;
        b=Kq2QnaeT1nRM6DYPza7WQUqKQY42w28TJBUGBLao7XP2ciXqqvS8asIep60PPDPO5u
         13NFkQQBHubCv2lA0oEpBvpb7OG5O6cmQDK6xugIvxhVxuBCFZrHE2RCcfEuQQQXFOhT
         ahrsieoo1mV/PTysZOVhwIvpIDBDyzJf48qMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcVHR6+gABrqPot+5DAzhb8/k5TtG4mpDhY9zzDMCc0=;
        b=Cao604UI2k+CEG597feFaDDmdipuRByaFoGyNB6VbRfggv6idPuEtsbAfGtE4+YZ7/
         C0f8Pgo3N3gnhR2fwixdC7jDL03VhZAUgmk8P9hIxWWOFJGRkaBknLguCskLSSU9mc4A
         KbR/n/H2pufd57NALzXrH0jrVt9suIYfKDB58vvSwkizWc6WbdPDF8Iedt1LIYcxWYDo
         +7GhMyDSlODHIh4T7hUc/0elH8izfo+2FwQvvRHHS9FkglGa5G+s38CaFVdffDSJw5Mi
         tCTYHEvpzfMUnRw4TtRr7YcZHPfmutQCG392y/l+mrzdiRwxBzTjMTzcNKkpCjRNPiCv
         xtnw==
X-Gm-Message-State: AOAM5300hmMOROy6hnnnMB7kxnuBmOEI8hqsDY7oxl+KNNF3xge/w3JN
        ptyNYr5kA0dgcpCX8nU15EuAGvhU2RiRyXbank6cBg==
X-Google-Smtp-Source: ABdhPJw40UN64yFL1RnxO7mP7QwoGSxtkWRg9aDMbR4xEvelVYPQesFunWYeerPMi7Q9bZ2PgQ14Va2+VYO2KeM4Vpg=
X-Received: by 2002:a05:6512:33d1:: with SMTP id d17mr12794743lfg.13.1614702230670;
 Tue, 02 Mar 2021 08:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20210302023743.24123-1-xiyou.wangcong@gmail.com> <20210302023743.24123-6-xiyou.wangcong@gmail.com>
In-Reply-To: <20210302023743.24123-6-xiyou.wangcong@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Mar 2021 16:23:39 +0000
Message-ID: <CACAyw98C99sjOompq59Aa-uuaeyJc0pXAEBiBCVJ+1Ds4_h=jA@mail.gmail.com>
Subject: Re: [Patch bpf-next v2 5/9] udp: add ->read_sock() and
 ->sendmsg_locked() to ipv6
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

On Tue, 2 Mar 2021 at 02:38, Cong Wang <xiyou.wangcong@gmail.com> wrote:

...

> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index bd1f396cc9c7..48b6850dae85 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -1119,6 +1119,7 @@ int inet6_hash_connect(struct inet_timewait_death_row *death_row,
>  int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
>  int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>                   int flags);
> +int udpv6_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len);
>
>  /*
>   * reassembly.c
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 54f24b1d4f65..717c543aaec3 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1831,6 +1831,7 @@ int udp_read_sock(struct sock *sk, read_descriptor_t *desc,
>
>         return copied;
>  }
> +EXPORT_SYMBOL(udp_read_sock);

Should this be in the previous commit?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
