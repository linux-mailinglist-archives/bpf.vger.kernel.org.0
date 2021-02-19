Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E231FEC5
	for <lists+bpf@lfdr.de>; Fri, 19 Feb 2021 19:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSS0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 13:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBSS0L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Feb 2021 13:26:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3216C061756
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 10:25:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id w4so7835077wmi.4
        for <bpf@vger.kernel.org>; Fri, 19 Feb 2021 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=m9dputnaY6uIN9cIxLYOaUamBqLC1RNqHReW4hD2H+Q=;
        b=HJlrrWGoNHbYs0WokcfvkNsrjzk7rCr0S6f05rJe2I5fH9bh1bW78oTek81VIiDEpD
         yrhzydTZpO9TDnVq5ER1dRlyDMMXtKCWMv99C/2kLZqHZA2DS6Q4ifjOHprbkOOuw3rv
         c4sFvbXLzSpI9fyRAr2lLyPgXbcB83N2SPQHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=m9dputnaY6uIN9cIxLYOaUamBqLC1RNqHReW4hD2H+Q=;
        b=ayjZV01qc6QRGnjcvUSdrsLxlqug8o6vsUG13mjRkxQwBXpLoxs0eISVUk2yPUp6UN
         KumJlBztztDUW5FumRI23JPgjZUh1qZbfatXF3LALB4Y7Jh8Dz3VFJyrLj+aApSqj4yb
         Z2+SFuKvD/mVHoafJbcPr9PuEJAHy01Sll7vZFXR2spmz6fA6TsVyBao1Yiy681/OhRk
         q75wADTRmU+ZLQ9vwi7eyWXwecJL53jIrqFuRv7NesYshkEUa9sRXy5QdN2YWwfaQe0/
         RArcjDQL2winfv79OUCgUDv60nW2TzkAzLfbEKxX6OK2/EMUsGjqJ54lvjYdWHzenvqH
         Q4oQ==
X-Gm-Message-State: AOAM532scemOz/OvuKlVmCUh9aH9o6WdR1XHASZ0Rzoh2NfXbPPLw6nJ
        jQFEqSB3gOOTjpIQSR4yxXzxvQ==
X-Google-Smtp-Source: ABdhPJx2RDsh7ogzqY2KQK5oNuqu6/VpV88FO8Am1LpCOaXehzAd14FH2ujO8vxnBv8+KuXDnFrYyA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr4073123wms.4.1613759124527;
        Fri, 19 Feb 2021 10:25:24 -0800 (PST)
Received: from cloudflare.com (83.24.165.208.ipv4.supernova.orange.pl. [83.24.165.208])
        by smtp.gmail.com with ESMTPSA id p9sm12927967wma.14.2021.02.19.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:25:23 -0800 (PST)
References: <20210216064250.38331-1-xiyou.wangcong@gmail.com>
 <20210216064250.38331-2-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf-next v4 1/5] bpf: clean up sockmap related Kconfigs
In-reply-to: <20210216064250.38331-2-xiyou.wangcong@gmail.com>
Date:   Fri, 19 Feb 2021 19:25:22 +0100
Message-ID: <87im6n52zx.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 16, 2021 at 07:42 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> As suggested by John, clean up sockmap related Kconfigs:
>
> Reduce the scope of CONFIG_BPF_STREAM_PARSER down to TCP stream
> parser, to reflect its name.
>
> Make the rest sockmap code simply depend on CONFIG_BPF_SYSCALL.
> And leave CONFIG_NET_SOCK_MSG untouched, as it is used by
> non-sockmap cases.
>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Sorry for the delay. There's a lot happening here. Took me a while to
dig through it.

I have a couple of nit-picks, which easily can be addressed as
follow-ups, and one comment.

sock_map_prog_update and sk_psock_done_strp are only used in
net/core/sock_map.c and can be static.

[...]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index bc7d2a586e18..b2c4865eb39b 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -229,7 +229,6 @@ int tcp_bpf_sendmsg_redir(struct sock *sk, struct sk_msg *msg,
>  }
>  EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
>
> -#ifdef CONFIG_BPF_STREAM_PARSER
>  static bool tcp_bpf_stream_read(const struct sock *sk)
>  {
>  	struct sk_psock *psock;
> @@ -561,8 +560,10 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
>  				   struct proto *base)
>  {
>  	prot[TCP_BPF_BASE]			= *base;
> +#if defined(CONFIG_BPF_SYSCALL)
>  	prot[TCP_BPF_BASE].unhash		= sock_map_unhash;
>  	prot[TCP_BPF_BASE].close		= sock_map_close;
> +#endif
>  	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
>  	prot[TCP_BPF_BASE].stream_memory_read	= tcp_bpf_stream_read;
>
> @@ -629,4 +630,3 @@ void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
>  	if (prot == &tcp_bpf_prots[family][TCP_BPF_BASE])
>  		newsk->sk_prot = sk->sk_prot_creator;
>  }
> -#endif /* CONFIG_BPF_STREAM_PARSER */

net/core/sock_map.o now is built only when CONFIG_BPF_SYSCALL is set.
While tcp_bpf_get_proto is only called from net/core/sock_map.o.

Seems there is no sense in compiling tcp_bpf_get_proto, and everything
it depends on which was enclosed by CONFIG_BPF_STREAM_PARSER check, when
CONFIG_BPF_SYSCALL is unset.

> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> index 7a94791efc1a..e635ccc175ca 100644
> --- a/net/ipv4/udp_bpf.c
> +++ b/net/ipv4/udp_bpf.c
> @@ -18,8 +18,10 @@ static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
>  static void udp_bpf_rebuild_protos(struct proto *prot, const struct proto *base)
>  {
>  	*prot        = *base;
> +#if defined(CONFIG_BPF_SYSCALL)
>  	prot->unhash = sock_map_unhash;
>  	prot->close  = sock_map_close;
> +#endif
>  }
>
>  static void udp_bpf_check_v6_needs_rebuild(struct proto *ops)

Same situation here but for udp_bpf_get_proto.
