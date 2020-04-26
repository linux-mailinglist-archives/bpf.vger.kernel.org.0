Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12A31B8F30
	for <lists+bpf@lfdr.de>; Sun, 26 Apr 2020 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDZLBd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Apr 2020 07:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbgDZLBc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 26 Apr 2020 07:01:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84826C061A0E
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2020 04:01:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so16971110wmg.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2020 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=RrhmdO0DLNjfBMDoqT4uy73PlihIJnZjBGcOAEACVLQ=;
        b=SOJ0e9h/vfQZL3fIsHaTnpWUyWcPJ8BtfMjph1KCE0tRbZP2i7AlCnU653nkIXiOPP
         aa5Dx1YA180Z/TBpL3G0M3ywHrcwihnMg6zk5p6RMuMq+8uQaz9BGSOfEI5kbP5NYQw4
         MOxZmXM9onjxNbW9ZgymV65EkkoAwY3XJh0t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=RrhmdO0DLNjfBMDoqT4uy73PlihIJnZjBGcOAEACVLQ=;
        b=Z6bgf7k8D82rd9T9omA9rbK51oVgIwSBjoXWaUornuChOOPycYq6Jx3QR8pebPZ1wo
         o6bzj+YZeQ2SWO6CZLF71sZui5v0MU8Y8pFoUwijWLx5G5Sa4gXxI1X7EBw4TMvKEIxL
         rVKwkRx/cuxji3OMGad4g7pIBzje5rAhYDRvRFKwKsYsuAgAbygg7i2TnTw4+ZlUE+BK
         sNGgb63WsxmGA1+yl5+b+yOaU0IOsKIhRsmiOk1nVt7LhpwtXx+oE/BU7lyLSCjqhIT+
         zKTCgy4RsVMzsTYgmr6gY00yuLU76DFL6xO1OWMhbjhcqkP9n3O3g/KvyBBbowa9clnd
         KPng==
X-Gm-Message-State: AGi0PuZ2puLz+QxmRCrLTAyP70Fgqu76rKI3ywzm/ZGPEd1PwkhCWwac
        tExBhP8Ex93OPWpcia2uWeFQSg==
X-Google-Smtp-Source: APiQypKNGHSJziLKlpT3nTU2sPDDe98lUcVdHC0Mf29p4r46R6e+U+gqONTPjIa3F/qs3ED7pv8Upw==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr21410207wmj.170.1587898891012;
        Sun, 26 Apr 2020 04:01:31 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id v7sm10002236wmg.3.2020.04.26.04.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 04:01:30 -0700 (PDT)
References: <1587872115-42805-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Lingpeng Chen <forrest0579@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v2] bpf: Fix sk_psock refcnt leak when receiving message
In-reply-to: <1587872115-42805-1-git-send-email-xiyuyang19@fudan.edu.cn>
Date:   Sun, 26 Apr 2020 13:01:29 +0200
Message-ID: <87k122v7cm.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 26, 2020 at 05:35 AM CEST, Xiyu Yang wrote:
> tcp_bpf_recvmsg() invokes sk_psock_get(), which returns a reference of
> the specified sk_psock object to "psock" with increased refcnt.
>
> When tcp_bpf_recvmsg() returns, local variable "psock" becomes invalid,
> so the refcount should be decreased to keep refcount balanced.
>
> The reference counting issue happens in several exception handling paths
> of tcp_bpf_recvmsg(). When those error scenarios occur such as "flags"
> includes MSG_ERRQUEUE, the function forgets to decrease the refcnt
> increased by sk_psock_get(), causing a refcnt leak.
>
> Fix this issue by calling sk_psock_put() or pulling up the error queue
> read handling when those error scenarios occur.
>
> Fixes: e7a5f1f1cd000 ("bpf/sockmap: Read psock ingress_msg before sk_receive_queue")
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
> Changes in v2:
> - Add Fixes tag
> - Pull up the error queue read handling
> ---
>  net/ipv4/tcp_bpf.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 5a05327f97c1..ff96466ea6da 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -262,14 +262,17 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	struct sk_psock *psock;
>  	int copied, ret;
>  
> +	if (unlikely(flags & MSG_ERRQUEUE))
> +		return inet_recv_error(sk, msg, len, addr_len);
> +
>  	psock = sk_psock_get(sk);
>  	if (unlikely(!psock))
>  		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
> -	if (unlikely(flags & MSG_ERRQUEUE))
> -		return inet_recv_error(sk, msg, len, addr_len);
>  	if (!skb_queue_empty(&sk->sk_receive_queue) &&
> -	    sk_psock_queue_empty(psock))
> +	    sk_psock_queue_empty(psock)) {
> +		sk_psock_put(sk, psock);
>  		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
> +	}
>  	lock_sock(sk);
>  msg_bytes_ready:
>  	copied = __tcp_bpf_recvmsg(sk, psock, msg, len, flags);

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
