Return-Path: <bpf+bounces-14770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C07E7D7D
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8161F20E2A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7A21DA45;
	Fri, 10 Nov 2023 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpMCsFkr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07831CA89;
	Fri, 10 Nov 2023 15:42:45 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE53B30E;
	Fri, 10 Nov 2023 07:42:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32f78dcf036so2044833f8f.0;
        Fri, 10 Nov 2023 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699630962; x=1700235762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJfu4EuR1P0NY7PPdaFdwn09q5xxmywPpE4sr+rGJF8=;
        b=dpMCsFkr7KqlMv2F8TWff6nx1slu5Ucz4B1KDOSM8cAnNZVX05nUe7utT94vJuw3CF
         9uYj/0cmwbv7DdD549+4fjFdWhZoMC2rE6aX4HGzxSBeNZ+vN7q/1q13qfQilb0WhW1e
         yl+3TK1PO92UuVjAcs3AWbx+fONkcugyiXFzKMqyYdiHNYp3Vu3MzIu55Q7hXlpuVsoj
         frEACoQeSq/6d4GzVy008IROBD4rhDWA7awY0KmhsvJ5vf+KPErmlTKFZf4wusWDjXVR
         JLBmNezPKPKO7M1NP+axGqNGBSWZzvfcSTvzKaEnprwzuprT9qyDOC7tzlc0YeLVIRjr
         tHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699630962; x=1700235762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJfu4EuR1P0NY7PPdaFdwn09q5xxmywPpE4sr+rGJF8=;
        b=kxZxh6IWAA8ld+hF+HVvWkOyo7W9vCCDmanKdZbg+OQ1gG3hhfi7bnf5gqYxqgsWWK
         EKOqtyey7t4udkgmTdTQ8sz0yX/fCcYMMzAigZbGqBqtNzuQAjXGAemzV5HIiqSzCi2n
         FcO/FXPos+Fb6LDCBaIw7FpTZv6WNN8Y3apfkkkeuurmhnT/daaycEPksZC4JYHL6kCY
         +58bwqbb/tcfSA/SemAjmo73TTFINU3iCxlbikvKF7/jN5lDO1KuQ4AUJ6B/haz3JMnx
         Nllq13S8RHo3WZpGE7fTYHJiKdaPvjCEPap/GPM9Z0MQHaNwFZiLgqn6qwTgbCyuj5hF
         biVA==
X-Gm-Message-State: AOJu0Yw+na5wMUsEk00R/D+1oHQ0KJL5GtO2vK+2Jr+NkuM/YO8qkZ6F
	nM1OARvifyvbRpwj08Y3e+X0Uik7npH8txOUlPk=
X-Google-Smtp-Source: AGHT+IHdiDRthT9zPEJ/pFC73tZcrvH+XW9DKwaPydDCy5hA45KwFQZL06We6QzO0MG7LTPU+MUQeFSZuuqjsoT4pVw=
X-Received: by 2002:a05:6000:682:b0:32f:86e7:9bef with SMTP id
 bo2-20020a056000068200b0032f86e79befmr3859409wrb.8.1699630961884; Fri, 10 Nov
 2023 07:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1699609302-8605-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1699609302-8605-1-git-send-email-yangpc@wangsu.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Nov 2023 07:42:30 -0800
Message-ID: <CAADnVQL=8-ViD7vPy4tQ1Ek6TzC24aMVFwt4_k0Jc7igz-5Jkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, sockmap: Bundle psock->sk_redir and
 redir_ingress into a tagged pointer
To: Pengcheng Yang <yangpc@wangsu.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 1:44=E2=80=AFAM Pengcheng Yang <yangpc@wangsu.com> =
wrote:
>
> Like skb->_sk_redir, we bundle the sock redirect pointer and
> the ingress bit to manage them together.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Link: https://lore.kernel.org/bpf/87cz97cnz8.fsf@cloudflare.com
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  include/linux/skmsg.h | 30 ++++++++++++++++++++++++++++--
>  net/core/skmsg.c      | 18 ++++++++++--------
>  net/ipv4/tcp_bpf.c    | 13 +++++++------
>  net/tls/tls_sw.c      | 11 ++++++-----
>  4 files changed, 51 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index c1637515a8a4..ae021f511f46 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -78,11 +78,10 @@ struct sk_psock_work_state {
>
>  struct sk_psock {
>         struct sock                     *sk;
> -       struct sock                     *sk_redir;
> +       unsigned long                   _sk_redir;

Please don't.
There is no need to bundle them together.

