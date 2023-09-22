Return-Path: <bpf+bounces-10625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08757AAFB3
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D821028293C
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3917748;
	Fri, 22 Sep 2023 10:40:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0939CA78
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 10:39:58 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646099
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 03:39:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bffdf50212so32172021fa.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1695379195; x=1695983995; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=bd3Lp+mNhz8XYxLGBCuWdPha+I4ZIt6td6DPuyV79r0=;
        b=A3q62NGJPfqXYvMV9zhjJ7/N3nORSHbaBT7eL+A2Gn1FSIAIMXrdtj+GJb5VWS32Dg
         CmtXTstXDx8SIx5Z+zsAB3usJzJlGm86lRMKe2W5HYoSGgtPf+dZ7br4m32HG8PXR+rc
         kGBrFphCJ24Dma2JkEP0S9+Lc6BiYNvgcs24gxc9enrqgjigOFR6o9ndgRT7zoa6pswO
         xKOkS2fsrflpxA1r3EHufaMRSFrLeXIDEJQ4h2GMxEDIB6ampa5abzZAaLu2mmqVAFCZ
         Pz0qi3jqaP8jEgM8W9kH+MXdNcX6Ihw9gVEknlGr+zS0uufabSuojhJYhPJIB+6PspUr
         rkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379195; x=1695983995;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd3Lp+mNhz8XYxLGBCuWdPha+I4ZIt6td6DPuyV79r0=;
        b=b3mUA0oJD27h4iA+3oc2c8U6Yy4q7MSB+IEx4h0v2YYNomDwebZKVNYkdo1v9VxAoa
         Um5uStmFJn1Gqw4+ApNI21mzAeHzAobZ/OPLAED4hOKNCq7P4oVNBUl3by8VbpuEmXYu
         nuaDQVRQjJ9PkoF5avvpvYGUvxLKvyE1MoMAGEiYX/MnP4rRx1LsRDWaqW4NHzEMKM8Q
         euspLxJ79gxQ4SGyDfO4mga3Q5IarIeJrcC2FD5NKh0QngUCXxSRpf0kqo7+7CZGTpzW
         KZtWxawjhsuDFQpe+lUYulSiO7FbnTsbFuIQknG5V2nWG5Yx3cfaUvqCyt0ujztd0DLo
         xH4g==
X-Gm-Message-State: AOJu0Yyn7S1aoIlQc3GwUYlD/8fVI8Dx1u0+NEhjn5wPR0mZyiiUzK/+
	VF0hwCYZqHsOQXtmnUaTbfyQJA==
X-Google-Smtp-Source: AGHT+IGc3YC+ytaWH2/Gm8wMswgofRd1VqvQcNJGwGldp04+48Gqb0Aue9oZWdQ+j14DrysmX1AUIw==
X-Received: by 2002:a2e:910f:0:b0:2bc:b70d:9cb5 with SMTP id m15-20020a2e910f000000b002bcb70d9cb5mr7121103ljg.33.1695379194634;
        Fri, 22 Sep 2023 03:39:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:63])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709064f9800b0099cce6f7d50sm2528990eju.64.2023.09.22.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:39:53 -0700 (PDT)
References: <20230920232706.498747-1-john.fastabend@gmail.com>
 <20230920232706.498747-3-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/3] bpf: sockmap, do not inc copied_seq when PEEK
 flag set
Date: Fri, 22 Sep 2023 12:23:53 +0200
In-reply-to: <20230920232706.498747-3-john.fastabend@gmail.com>
Message-ID: <87a5tesd8n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 04:27 PM -07, John Fastabend wrote:
> When data is peek'd off the receive queue we shouldn't considered it
> copied from tcp_sock side. When we increment copied_seq this will confuse
> tcp_data_ready() because copied_seq can be arbitrarily increased. From]
> application side it results in poll() operations not waking up when
> expected.
>
> Notice tcp stack without BPF recvmsg programs also does not increment
> copied_seq.
>
> We broke this when we moved copied_seq into recvmsg to only update when
> actual copy was happening. But, it wasn't working correctly either before
> because the tcp_data_ready() tried to use the copied_seq value to see
> if data was read by user yet. See fixes tags.
>
> Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
> Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/ipv4/tcp_bpf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 81f0dff69e0b..327268203001 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -222,6 +222,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  				  int *addr_len)
>  {
>  	struct tcp_sock *tcp = tcp_sk(sk);
> +	int peek = flags & MSG_PEEK;
>  	u32 seq = tcp->copied_seq;
>  	struct sk_psock *psock;
>  	int copied = 0;
> @@ -311,7 +312,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  		copied = -EAGAIN;
>  	}
>  out:
> -	WRITE_ONCE(tcp->copied_seq, seq);
> +	if (!peek)
> +		WRITE_ONCE(tcp->copied_seq, seq);
>  	tcp_rcv_space_adjust(sk);
>  	if (copied > 0)
>  		__tcp_cleanup_rbuf(sk, copied);

I was surprised to see that we recalculate TCP buffer space and ACK
frames when peeking at the receive queue. But tcp_recvmsg seems to do
the same.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

