Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 487B4155620
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGK4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 05:56:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39566 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGK4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 05:56:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so2197962wme.4
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 02:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Uixk1JfPRfZiskd4b5V0w8uIZZOxCYEiV7QUtBMbUWw=;
        b=RcYhavdZsLpqgP20VvYdLOC0mNiSX7lTL2sqhQ59iQIXWipEC6zKbuCeHoP4GY0t0B
         EZIx3Ipyt0LTHJziQIZ1vSHojZsnKA2EhadixIE+ES0+DXsiu4vG0jm9Bte5yyIaHdZk
         XYZfwMvMAtFU9q03VwDKV4aSHkIyO25r0r+mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Uixk1JfPRfZiskd4b5V0w8uIZZOxCYEiV7QUtBMbUWw=;
        b=YChoMD2rQmLLiOCAQ+y2oG+bGVnmU0h9NnVOyGVkF8lSXJQUuQoFlCSwLSc/XSnupP
         LvV6Wn3Kra+SeLpfHPeZstBH7wbCB/dRiz4F3ke9tRrmuw6Z5c25tbvA5s5L/mc/8Gl3
         Qx5nC/sXOQf/12EnOKyFyYMrdKrTeoPISv9vHfGSZX6tyst4FihE0SMg+0kL8gchsK1k
         pPjWZvoi14gtiJ1ncwEX9WvbZy03LFu26V3CFg2SV40JhI5QvXg25oGJlgpRu4ksDA8b
         YF7BVOMevZUT6snRIwPhOC34pM4Xg+zCDLxuJS8H7zbrb3xtExXcJFQOfKqwpsnhcXOw
         1cQg==
X-Gm-Message-State: APjAAAVQ/iK5IB2R3aJ1iHHzMQzWm9CZgbstxLVt4NhQRTRxprOfVbh/
        tkcg1+iWeWfhDWQaovW0BSVFAg==
X-Google-Smtp-Source: APXvYqwW8UfEVnYheCnZ/OzASRGSTOcK7iOubLtK+9VH5Wdat0CZTnVAZLLgZZludphRfIz5vL23ow==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3612169wmi.146.1581072999762;
        Fri, 07 Feb 2020 02:56:39 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id a62sm2953727wmh.33.2020.02.07.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 02:56:39 -0800 (PST)
References: <20200207103713.28175-1-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, kernel-team@cloudflare.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: sockmap: check update requirements after locking
In-reply-to: <20200207103713.28175-1-lmb@cloudflare.com>
Date:   Fri, 07 Feb 2020 11:56:38 +0100
Message-ID: <87y2temzrt.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 07, 2020 at 11:37 AM CET, Lorenz Bauer wrote:
> It's currently possible to insert sockets in unexpected states into
> a sockmap, due to a TOCTTOU when updating the map from a syscall.
> sock_map_update_elem checks that sk->sk_state == TCP_ESTABLISHED,
> locks the socket and then calls sock_map_update_common. At this
> point, the socket may have transitioned into another state, and
> the earlier assumptions don't hold anymore. Crucially, it's
> conceivable (though very unlikely) that a socket has become unhashed.
> This breaks the sockmap's assumption that it will get a callback
> via sk->sk_prot->unhash.
>
> Fix this by checking the (fixed) sk_type and sk_protocol without the
> lock, followed by a locked check of sk_state.
>
> Unfortunately it's not possible to push the check down into
> sock_(map|hash)_update_common, since BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
> run before the socket has transitioned from TCP_SYN_RECV into
> TCP_ESTABLISHED.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> ---
>  net/core/sock_map.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 8998e356f423..36a2433e183f 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -416,14 +416,16 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	if (!sock_map_sk_is_suitable(sk) ||
> -	    sk->sk_state != TCP_ESTABLISHED) {
> +	if (!sock_map_sk_is_suitable(sk)) {
>  		ret = -EOPNOTSUPP;
>  		goto out;
>  	}
>
>  	sock_map_sk_acquire(sk);
> -	ret = sock_map_update_common(map, idx, sk, flags);
> +	if (sk->sk_state != TCP_ESTABLISHED)
> +		ret = -EOPNOTSUPP;
> +	else
> +		ret = sock_map_update_common(map, idx, sk, flags);
>  	sock_map_sk_release(sk);
>  out:
>  	fput(sock->file);
> @@ -739,14 +741,16 @@ static int sock_hash_update_elem(struct bpf_map *map, void *key,
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	if (!sock_map_sk_is_suitable(sk) ||
> -	    sk->sk_state != TCP_ESTABLISHED) {
> +	if (!sock_map_sk_is_suitable(sk)) {
>  		ret = -EOPNOTSUPP;
>  		goto out;
>  	}
>
>  	sock_map_sk_acquire(sk);
> -	ret = sock_hash_update_common(map, key, sk, flags);
> +	if (sk->sk_state != TCP_ESTABLISHED)
> +		ret = -EOPNOTSUPP;
> +	else
> +		ret = sock_hash_update_common(map, key, sk, flags);
>  	sock_map_sk_release(sk);
>  out:
>  	fput(sock->file);
> --
> 2.20.1

Thanks for fixing this, Lorenz. I'll adapt socket state checks on update
in "Extend SOCKMAP to store listening sockets" series accordingly.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
