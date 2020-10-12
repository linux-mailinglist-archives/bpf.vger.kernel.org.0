Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E837C28B451
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 14:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbgJLMEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388281AbgJLMEW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 08:04:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA8C0613D1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 05:04:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e18so18867951wrw.9
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8vMF8lZRQsgeDB+OVpE15wXr25/uWkPUozR5wkyqRus=;
        b=IpypOWt+e7NTYuvuZsUirxmMBp02bpHU7QR+sFmnBU3Fr/3pbR8GCt+RCLWA5BNjNZ
         x/uGUozNT8ktjyxkpfCHleMuvoTKbiUQFtiG9mpIav+6yRNIIXqJS9ttrJJy0UgPbKWd
         HLjokQy3AeS73Rfq6DIR1aS7R7d6aUcRjdiNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8vMF8lZRQsgeDB+OVpE15wXr25/uWkPUozR5wkyqRus=;
        b=D1h71YJJQly7rzZnBpkpF1FuXN7yFJAaDLUsXH+GLraRc4iZXhx5HT41uUR07iQUYn
         HhqlYsXrr71UnrSdf8qRNGxcPumnBMp3HF9k6PUSQOnGvroFxkmH4/u0klYGPSuLyuX1
         Bks9Ljp4rTb65cS9H04UlL9odum98CE/H/Cce2UuHxnBsHiq1YNs28dnlT0xAsYNd3G0
         CkYBTv39cqgWOvnBvyzDJqa6654n+brJ/iTKqUH54Li5K6Uk68+bj9q9M3SaBoySOoZF
         8AiHf1FIVoUXL9x123+skO5We1cnUFlgyjDbV0eyUjSpjv/4GrqcRVoPPC/7S1zNPPEC
         SJxA==
X-Gm-Message-State: AOAM532VPUl+XXjb2AKtnfRkvbZBHAJJRT4awdEmGgH78SRCP8bJdjKI
        2NSz8QdAmpayGUugLXtPwegj2Q==
X-Google-Smtp-Source: ABdhPJygN61G/pPtEL0XYbZfLV74sPBmvxLtRPL9SyStjuicJwun+0rTKfWdXamhoMZMkMTQQ49AqA==
X-Received: by 2002:adf:e70a:: with SMTP id c10mr28946099wrm.425.1602504260962;
        Mon, 12 Oct 2020 05:04:20 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id q2sm24366964wrw.40.2020.10.12.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 05:04:20 -0700 (PDT)
References: <160226839426.5692.13107801574043388675.stgit@john-Precision-5820-Tower> <160226863689.5692.13861422742592309285.stgit@john-Precision-5820-Tower>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org, lmb@cloudflare.com
Subject: Re: [bpf-next PATCH v3 4/6] bpf, sockmap: remove dropped data on errors in redirect case
In-reply-to: <160226863689.5692.13861422742592309285.stgit@john-Precision-5820-Tower>
Date:   Mon, 12 Oct 2020 14:04:19 +0200
Message-ID: <87ft6jr6po.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 09, 2020 at 08:37 PM CEST, John Fastabend wrote:
> In the sk_skb redirect case we didn't handle the case where we overrun
> the sk_rmem_alloc entry on ingress redirect or sk_wmem_alloc on egress.
> Because we didn't have anything implemented we simply dropped the skb.
> This meant data could be dropped if socket memory accounting was in
> place.
>
> This fixes the above dropped data case by moving the memory checks
> later in the code where we actually do the send or recv. This pushes
> those checks into the workqueue and allows us to return an EAGAIN error
> which in turn allows us to try again later from the workqueue.
>
> Fixes: 51199405f9672 ("bpf: skb_verdict, support SK_PASS on RX BPF path")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/core/skmsg.c |   28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>

[...]

> @@ -709,30 +711,28 @@ static void sk_psock_skb_redirect(struct sk_buff *s=
kb)
>  {
>  	struct sk_psock *psock_other;
>  	struct sock *sk_other;
> -	bool ingress;
>
>  	sk_other =3D tcp_skb_bpf_redirect_fetch(skb);
> +	/* This error is a buggy BPF program, it returned a redirect
> +	 * return code, but then didn't set a redirect interface.
> +	 */
>  	if (unlikely(!sk_other)) {
>  		kfree_skb(skb);
>  		return;
>  	}
>  	psock_other =3D sk_psock(sk_other);
> +	/* This error indicates the socket is being torn down or had another
> +	 * error that caused the pipe to break. We can't send a packet on
> +	 * a socket that is in this state so we drop the skb.
> +	 */
>  	if (!psock_other || sock_flag(sk_other, SOCK_DEAD) ||
>  	    !sk_psock_test_state(psock_other, SK_PSOCK_TX_ENABLED)) {
>  		kfree_skb(skb);
>  		return;
>  	}
>
> -	ingress =3D tcp_skb_bpf_ingress(skb);
> -	if ((!ingress && sock_writeable(sk_other)) ||
> -	    (ingress &&
> -	     atomic_read(&sk_other->sk_rmem_alloc) <=3D
> -	     sk_other->sk_rcvbuf)) {

I'm wondering why the check for going over socket's rcvbuf was removed?

I see that we now rely exclusively on
sk_psock_skb_ingress=E2=86=92sk_rmem_schedule for sk_rmem_alloc checks, whi=
ch I
don't think applies the rcvbuf limit.

> -		skb_queue_tail(&psock_other->ingress_skb, skb);
> -		schedule_work(&psock_other->work);
> -	} else {
> -		kfree_skb(skb);
> -	}
> +	skb_queue_tail(&psock_other->ingress_skb, skb);
> +	schedule_work(&psock_other->work);
>  }
>
>  static void sk_psock_tls_verdict_apply(struct sk_buff *skb, int verdict)
