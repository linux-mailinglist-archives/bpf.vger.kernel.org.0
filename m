Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E921F769F
	for <lists+bpf@lfdr.de>; Fri, 12 Jun 2020 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFLKR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 06:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFLKR4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 06:17:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135E3C03E96F
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 03:17:55 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so10467539ljc.8
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZlUc07Rr8ksgIjTvwWUAkRdKf7159z7g2XNRXUltyI=;
        b=Hwpa5+EBWwC9JsHgTzkp9L0UNfpjyRoItxBOXVRcDB6BTWyLsPP66VWj7jFMRA7Jfn
         S3Ta3hY844UuAJyhy91+zzoZt3JF7YCMoR0+N42NKBr7WUwnBW0QqDaHbw/OCACM3R9x
         IxLn99jsfxcVSimF8KQS7D5rCyRCEHKpf6pR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZlUc07Rr8ksgIjTvwWUAkRdKf7159z7g2XNRXUltyI=;
        b=i88/7uNwuxz2P4c5yieZOcUnYezKywYEwX5suHSHlbB8OzNV6EJeVwhfdEDkH5qTiR
         dQgU+sJkmBGwkalJlmMP7qrNvpo7jbDNbH+h2bcQRBJiqhw6cinQ0HLRzrvSFQnsaUzp
         WJngY+l85vKQLNHyfvIWnz/CGl7h+9isesKU32j1LmDgK5VdG6A+09X8uGEkA8a9MdRo
         6Rnun9WID0Id2y2NA+QBcqJM2ijKmwKE90pee4BjmsYY8s+BZVUMTjpYVQ+A2nJQmqTs
         SQ0HhAx10jxyqmTKVdXV6FG912MWRxpb7zCwXMYj/2Wf/lrUGOs6zRQF/JmUKnVcn9Y3
         rphw==
X-Gm-Message-State: AOAM531U2xinyMd9AwnSkNuKAyDwTQJa3HFb7GbDN5L+qRUqzbBu5uRh
        6DyQ929Gcp2B3OmcCneqODQ+/Q==
X-Google-Smtp-Source: ABdhPJwUV5CjBcNm4+qoH43nmTNZKJ7PSGvfl/7KprEX5/5c/ou5DN9IOooDPHtM807G80gC7++NLA==
X-Received: by 2002:a2e:8690:: with SMTP id l16mr5792715lji.462.1591957073513;
        Fri, 12 Jun 2020 03:17:53 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w15sm1655270lfl.51.2020.06.12.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 03:17:53 -0700 (PDT)
Date:   Fri, 12 Jun 2020 12:17:50 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: sockmap: don't attach programs to UDP sockets
Message-ID: <20200612121750.0004c74d@toad>
In-Reply-To: <20200611172520.327602-1-lmb@cloudflare.com>
References: <20200611172520.327602-1-lmb@cloudflare.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Jun 2020 18:25:20 +0100
Lorenz Bauer <lmb@cloudflare.com> wrote:

> The stream parser infrastructure isn't set up to deal with UDP
> sockets, so we mustn't try to attach programs to them.
> 
> I remember making this change at some point, but I must have lost
> it while rebasing or something similar.
> 
> Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  net/core/sock_map.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 00a26cf2cfe9..35cea36f3892 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -424,10 +424,7 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
>  	return 0;
>  }
>  
> -static bool sock_map_redirect_allowed(const struct sock *sk)
> -{
> -	return sk->sk_state != TCP_LISTEN;
> -}
> +static bool sock_map_redirect_allowed(const struct sock *sk);
>  
>  static int sock_map_update_common(struct bpf_map *map, u32 idx,
>  				  struct sock *sk, u64 flags)
> @@ -508,6 +505,11 @@ static bool sk_is_udp(const struct sock *sk)
>  	       sk->sk_protocol == IPPROTO_UDP;
>  }
>  
> +static bool sock_map_redirect_allowed(const struct sock *sk)
> +{
> +	return sk_is_tcp(sk) && sk->sk_state != TCP_LISTEN;
> +}
> +
>  static bool sock_map_sk_is_suitable(const struct sock *sk)
>  {
>  	return sk_is_tcp(sk) || sk_is_udp(sk);

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
