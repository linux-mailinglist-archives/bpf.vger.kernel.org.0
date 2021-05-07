Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09D637662B
	for <lists+bpf@lfdr.de>; Fri,  7 May 2021 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhEGNar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 09:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhEGNar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 09:30:47 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3BAC061761
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 06:29:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c11so12742577lfi.9
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=oiGRomdXyAyLnDStIv6nJ+7p0wfVS+USRZDAubzLhPs=;
        b=AJxD8LVjZKL0QCu/MFxLSB0AOHsJN4Wxk3jHOuin9tGgIvw5iokwQ2RKF/Ov4vptl1
         Z1oO6iVoL0qdywfzFdf9dxiSwnBgm5lPozWDJer/oLTP7gIDNLfytG6BDPTV9Q7V82W/
         +q9KIVPOt67Hxlg1Wnwtr9joLQWo6G70th/ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=oiGRomdXyAyLnDStIv6nJ+7p0wfVS+USRZDAubzLhPs=;
        b=H+0qjLXK6BPXmKKxQqUoFIyxLUBKHwcm0sCH2tGVpMPzgUj9wxYdiWbZkJxHIaAnmw
         28iX1YwzcRwHlW6RRpGV+B4KjpQvx21oIAgsk4/2f8wtWFjffTdxLGV24/WA5pjToIqh
         M7RepW32CqeQYJcjybUrmlvoJUNFFSooqQffkUFxxyEBc1Wu6qiGuPw28fJciBR4ppBm
         qJYkmmJtnAMXOXLMoNKW6t5SiIXYeex/G0J2MeLGnqtJBdur3AsLpOITdMVyBg8nfSjz
         E8Xn4fcsR2lcXGRfZL7sD6iK0zPHx9ftLtmcU/hGw2/SzBqOmMEGc085RWYwV+v9i7j0
         rXKw==
X-Gm-Message-State: AOAM532GiB6D6PhwxFQLkSa7Bbi1PoqRcLHjwO35N9R1FRJD52JbqRS0
        c1QaDv6++VThxvvH5VIYyxzIyA==
X-Google-Smtp-Source: ABdhPJxbszf8YkS6e1D6r4abNBbOzr5xjEuZYqK29u39aXgWaE/+X06riJSO/EuLb5K2aRN9OCLXHA==
X-Received: by 2002:a19:c317:: with SMTP id t23mr6630909lff.5.1620394185722;
        Fri, 07 May 2021 06:29:45 -0700 (PDT)
Received: from cloudflare.com (83.31.64.64.ipv4.supernova.orange.pl. [83.31.64.64])
        by smtp.gmail.com with ESMTPSA id e11sm1897855ljk.128.2021.05.07.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 06:29:45 -0700 (PDT)
References: <20210426025001.7899-1-xiyou.wangcong@gmail.com>
 <20210426025001.7899-6-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        jiang.wang@bytedance.com, duanxiongchun@bytedance.com,
        wangdongdong.6@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next v3 05/10] af_unix: implement
 unix_dgram_bpf_recvmsg()
In-reply-to: <20210426025001.7899-6-xiyou.wangcong@gmail.com>
Date:   Fri, 07 May 2021 15:29:43 +0200
Message-ID: <87lf8qvfi0.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 26, 2021 at 04:49 AM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> We have to implement unix_dgram_bpf_recvmsg() to replace the
> original ->recvmsg() to retrieve skmsg from ingress_msg.
>
> AF_UNIX is again special here because the lack of
> sk_prot->recvmsg(). I simply add a special case inside
> unix_dgram_recvmsg() to call sk->sk_prot->recvmsg() directly.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  include/net/af_unix.h |  3 +++
>  net/unix/af_unix.c    | 21 ++++++++++++++++---
>  net/unix/unix_bpf.c   | 49 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index cca645846af1..e524c82794c9 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -82,6 +82,9 @@ static inline struct unix_sock *unix_sk(const struct sock *sk)
>  long unix_inq_len(struct sock *sk);
>  long unix_outq_len(struct sock *sk);
>  
> +int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
> +			 int nonblock, int flags, int *addr_len);
> +
>  #ifdef CONFIG_SYSCTL
>  int unix_sysctl_register(struct net *net);
>  void unix_sysctl_unregister(struct net *net);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index c4afc5fbe137..08458fa9f48b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2088,11 +2088,11 @@ static void unix_copy_addr(struct msghdr *msg, struct sock *sk)
>  	}
>  }
>  
> -static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> -			      size_t size, int flags)
> +int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
> +			 int nonblock, int flags, int *addr_len)
>  {
>  	struct scm_cookie scm;
> -	struct sock *sk = sock->sk;
> +	struct socket *sock = sk->sk_socket;
>  	struct unix_sock *u = unix_sk(sk);
>  	struct sk_buff *skb, *last;
>  	long timeo;
> @@ -2195,6 +2195,21 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  	return err;
>  }
>  
> +static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
> +			      int flags)
> +{
> +	struct sock *sk = sock->sk;
> +	int addr_len = 0;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +	if (sk->sk_prot != &unix_proto)
> +		return sk->sk_prot->recvmsg(sk, msg, size, flags & MSG_DONTWAIT,
> +					    flags & ~MSG_DONTWAIT, &addr_len);
> +#endif
> +	return __unix_dgram_recvmsg(sk, msg, size, flags & MSG_DONTWAIT,
> +				    flags, &addr_len);
> +}
> +

Nit: We can just pass NULL instead of &addr_len here it seems.

[...]
