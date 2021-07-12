Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156313C50D4
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbhGLHfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbhGLHah (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 03:30:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F514C0613B6
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 00:22:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t5so10294190wrw.12
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 00:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=niwmpdXM7KNF8H22pgiZfYJ+IlDDLwhRRK2oXaaMW4E=;
        b=qyu6923oWTx22Y3o7XlmFZRrj7RSxhvfvsgDUXYwFNiUTfFSJOXsQbOB3h3kNuNvbZ
         CAOrdsKLvBHe+sJ9mvBFmAZPssedGWGohAgzx4PxyGY0wOaCkHOFwswCACDEn+RxD5KV
         CtINmoZpNf7KWyResRodm8b3hlXUzstTUgLtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=niwmpdXM7KNF8H22pgiZfYJ+IlDDLwhRRK2oXaaMW4E=;
        b=siqhH5TdnZ4hbuTVxevZq2lmGQ+f6juYQPfSrr0iwMur3G6NSqQltITCofU+o5rWO/
         n6W/F6EkeNdGWOUYhr1BVIxiCxGFRnipFFmK6B75QRjn9U3ZzBdgFkWDHBiJXJ+a2nLy
         EO2UxyS+gFaOVILNT0t6jhwRzYz1SWG/1ax/ycR7cXZ5AhXmBDPQaP9exEdj+lqqEdxe
         wuvpMxBkEwyhDtp1FR5vK2EXs4qyu5w54o+pYXNadlBE2HIIOxhWeV+Q4u6dekk+0XvT
         IJse4TimPlvd9i7GbuTYuQg0i35XgI2UpiX1mxh8Z76h1bm7xphZJkONmNZz4kwxdvnv
         xS6Q==
X-Gm-Message-State: AOAM532Wv9yRPKS9uAqB0SdYj8dqo9eM0qKDl4iBVsg/U8dIZFysGfnI
        mXrL/cyEhvuZry/0RtZ8wj6mDg==
X-Google-Smtp-Source: ABdhPJybNjNqpSgQrmm+7FaSDAoMjZx3kDV/tnkTyVmyqxK/iRjJ5kI+axLn43wnLXVgZG4vjYpkPQ==
X-Received: by 2002:adf:fac7:: with SMTP id a7mr56782701wrs.384.1626074562688;
        Mon, 12 Jul 2021 00:22:42 -0700 (PDT)
Received: from cloudflare.com (79.191.183.149.ipv4.supernova.orange.pl. [79.191.183.149])
        by smtp.gmail.com with ESMTPSA id n23sm4457918wmc.38.2021.07.12.00.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 00:22:41 -0700 (PDT)
References: <20210706163150.112591-1-john.fastabend@gmail.com>
 <20210706163150.112591-3-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com,
        xiyou.wangcong@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] bpf, sockmap: sk_prot needs inuse_idx set
 for proc stats
In-reply-to: <20210706163150.112591-3-john.fastabend@gmail.com>
Date:   Mon, 12 Jul 2021 09:22:40 +0200
Message-ID: <871r84ro73.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 06, 2021 at 06:31 PM CEST, John Fastabend wrote:
> Proc socket stats use sk_prot->inuse_idx value to record inuse sock stats.
> We currently do not set this correctly from sockmap side. The result is
> reading sock stats '/proc/net/sockstat' gives incorrect values. The
> socket counter is incremented correctly, but because we don't set the
> counter correctly when we replace sk_prot we may omit the decrement.
>
> Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/core/sock_map.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 60decd6420ca..27bdf768aa8c 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -185,10 +185,19 @@ static void sock_map_unref(struct sock *sk, void *link_raw)
>
>  static int sock_map_init_proto(struct sock *sk, struct sk_psock *psock)
>  {
> +	int err;
> +#ifdef CONFIG_PROC_FS
> +	int idx = sk->sk_prot->inuse_idx;
> +#endif
>  	if (!sk->sk_prot->psock_update_sk_prot)
>  		return -EINVAL;
>  	psock->psock_update_sk_prot = sk->sk_prot->psock_update_sk_prot;
> -	return sk->sk_prot->psock_update_sk_prot(sk, psock, false);
> +	err = sk->sk_prot->psock_update_sk_prot(sk, psock, false);
> +#ifdef CONFIG_PROC_FS
> +	if (!err)
> +		sk->sk_prot->inuse_idx = idx;
> +#endif
> +	return err;
>  }
>
>  static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)

We could initialize inuse_idx just once in {tcp,udp}_bpf_rebuild_protos,
if we changed {tcp,udp}_bpf_v4_build_proto to be a late_initcall, so
that it runs after inet_init when {tcp,udp}_prot and udp_prot are
already registered and have inuse_idx assigned.
