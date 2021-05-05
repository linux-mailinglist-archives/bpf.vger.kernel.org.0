Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8719374712
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhEERnF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbhEERlD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 13:41:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80C6C061260
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 10:14:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x5so2646710wrv.13
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=1lz9G0fat8v7fxuPl5XJxBj6PYvQw7R7TVkQuwMcYKk=;
        b=O1oYab4uSWeF+UBj62kKyA/0KHUMMO0pprTdGMTBXnB/Y8JRCZPV4O9SDfvygljUjs
         NrEEHgz2a/83/FFPL9A73YbErzKityvYYmMQVaPndFiuQaUlKaQlu2pCPc0THfI+J3Ko
         h4Kn+U2hjn8m2xXWg1Q4O9VdkAdT7/MwYRlRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=1lz9G0fat8v7fxuPl5XJxBj6PYvQw7R7TVkQuwMcYKk=;
        b=ebODev50hyd7qNKZTW1ZUGFzFifTIM1ds5R8hzotK2SxSOeFOI/V5gJnk60msOzXhU
         10GyutJs1DbJEUFCRO4XHZetMiS48IwIETFJ395ttyEU4gacvKNhpdDLAtgz2MRmap4l
         Uh1QlWI/lH8l4btQ8JgCQqKfduLHfysh9fSTXoPwewQEgecYBLNa6FBV5eja9VYWInA3
         Rc8PHVTMkQjwHCANkKx98LeaMRSp5PKA2n9dfKT4QYW1NE7eMf1sy/qvmVCgpJ4uxVu4
         uNpJOV2sAWB6Agkz6NUrhIBSferitg7ikeCC9QCh9fFt9NNqQd0X988OLU7z2aSyUaUS
         +dnw==
X-Gm-Message-State: AOAM532A/TVg/ILhoVn3vxUV47gAvfY+E6cJd/XevXN+MtN3O6vQ+R0W
        jM3fzd0syyOFsADKKAxgwduifg==
X-Google-Smtp-Source: ABdhPJwGyyhGwULxQhCFpC+UDgsTbWEgaJuojBmfGu1ve7YoZyxqzOG3wmWB8puqHuy8WXOautFHSg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr105069wrt.220.1620234848397;
        Wed, 05 May 2021 10:14:08 -0700 (PDT)
Received: from cloudflare.com (83.31.64.64.ipv4.supernova.orange.pl. [83.31.64.64])
        by smtp.gmail.com with ESMTPSA id m16sm10482036wru.68.2021.05.05.10.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:14:07 -0700 (PDT)
References: <20210426025001.7899-1-xiyou.wangcong@gmail.com>
 <20210426025001.7899-3-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        jiang.wang@bytedance.com, duanxiongchun@bytedance.com,
        wangdongdong.6@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next v3 02/10] af_unix: implement ->read_sock() for
 sockmap
In-reply-to: <20210426025001.7899-3-xiyou.wangcong@gmail.com>
Date:   Wed, 05 May 2021 19:14:06 +0200
Message-ID: <87pmy5umqp.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 26, 2021 at 04:49 AM CEST, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> Implement ->read_sock() for AF_UNIX datagram socket, it is
> pretty much similar to udp_read_sock().
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  net/unix/af_unix.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 5a31307ceb76..f4dc22db371d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -661,6 +661,8 @@ static ssize_t unix_stream_splice_read(struct socket *,  loff_t *ppos,
>  				       unsigned int flags);
>  static int unix_dgram_sendmsg(struct socket *, struct msghdr *, size_t);
>  static int unix_dgram_recvmsg(struct socket *, struct msghdr *, size_t, int);
> +static int unix_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			  sk_read_actor_t recv_actor);
>  static int unix_dgram_connect(struct socket *, struct sockaddr *,
>  			      int, int);
>  static int unix_seqpacket_sendmsg(struct socket *, struct msghdr *, size_t);
> @@ -738,6 +740,7 @@ static const struct proto_ops unix_dgram_ops = {
>  	.listen =	sock_no_listen,
>  	.shutdown =	unix_shutdown,
>  	.sendmsg =	unix_dgram_sendmsg,
> +	.read_sock =	unix_read_sock,
>  	.recvmsg =	unix_dgram_recvmsg,
>  	.mmap =		sock_no_mmap,
>  	.sendpage =	sock_no_sendpage,
> @@ -2183,6 +2186,41 @@ static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  	return err;
>  }
>
> +static int unix_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			  sk_read_actor_t recv_actor)
> +{
> +	int copied = 0;
> +
> +	while (1) {
> +		struct unix_sock *u = unix_sk(sk);
> +		struct sk_buff *skb;
> +		int used, err;
> +
> +		mutex_lock(&u->iolock);
> +		skb = skb_recv_datagram(sk, 0, 1, &err);
> +		if (!skb) {
> +			mutex_unlock(&u->iolock);
> +			return err;
> +		}
> +
> +		used = recv_actor(desc, skb, 0, skb->len);
> +		if (used <= 0) {
> +			if (!copied)
> +				copied = used;
> +			mutex_unlock(&u->iolock);
> +			break;
> +		} else if (used <= skb->len) {
> +			copied += used;
> +		}
> +		mutex_unlock(&u->iolock);

Do we need hold the mutex for recv_actor to process the skb?

> +
> +		if (!desc->count)
> +			break;
> +	}
> +
> +	return copied;
> +}
> +
>  /*
>   *	Sleep until more data has arrived. But check for races..
>   */
