Return-Path: <bpf+bounces-15086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE847EBDBB
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 08:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E4B212F2
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 07:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41B4427;
	Wed, 15 Nov 2023 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6CPalQl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB34C6E;
	Wed, 15 Nov 2023 07:20:23 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D770D1;
	Tue, 14 Nov 2023 23:20:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc938f9612so43195735ad.1;
        Tue, 14 Nov 2023 23:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700032818; x=1700637618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWur9p9WEqJynqifmDwPsUi7J1xquqc62P0x0XG0Cko=;
        b=L6CPalQlTzir+UC4iC5Bs4pGq52JeNUoguWEXIfOC06y8nsKo7bOYd+QUb/a+92vHR
         GdQ06wfZR0opxL3FecnPXbrOKAq2/4tiwO2nre2tWkwXhXhbgqk5/fhEoKI50KV37AFr
         a0/fWC4axO2QBfybrwOqnoeWdn/S2KRNjyOQQv7cUQZLPoeuTHWz32AI83rBIpaig2a+
         fgi1swxigJJN6UVaas9bIdMKz0TZIAd6n2VHrL3M2Jp5xPIrq+uQgUNT7z12ySt7Amc4
         fF6MIPE5VXusAuhFawfZEn6d6dNegL1f2c2CTX8Y+Q07nZVsws2l7ctDSGsfsma2mtd0
         ukNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700032818; x=1700637618;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWur9p9WEqJynqifmDwPsUi7J1xquqc62P0x0XG0Cko=;
        b=pR59D3Bki3LSAssiQvjUi9EiR+JT3db5vIxsj4og+ohih2bLuZy34MJwdWJ6CwOYaM
         8cpZpwUoH5dLpBDVmBZScGtthaqj8PrEiyVPnNQMtPbh7d9lOEr/uxjwjZ0tm53yC/Y9
         Lb7wnXy6rbFIDiJwS4AMDEXrHeBiwQsV1d1l1COSCGYMaVdcUN9wBk0M9eNutJxodJ2H
         qpV4NM63CB+3k+JDrRPeahkyVGP3WKw8/1LY++1SsXiMOXB5rNPVaWCiRS7LYWsbxUyC
         WTyf2t27eOS4907equ1/UzLrdGvI6rIl2257tiJXvP2zH2EPiirMvf4ygpSAEO5iU/QH
         XXIw==
X-Gm-Message-State: AOJu0YyYGvUFyYgJvjMayZ/E9zdfnigtapa2wZ3n9ffghZ2Rzczx8UVU
	2Au4E7oEKo0/Lei5mXVXPxrA4jeArNE=
X-Google-Smtp-Source: AGHT+IHe7+0wF9DGuenP0VZjXsTFgat4CfJpTYd29Atmc0g6oiqpYshcS1xnYHfETfIXJ7xdR3h8Yw==
X-Received: by 2002:a17:902:db0a:b0:1cb:dc81:379a with SMTP id m10-20020a170902db0a00b001cbdc81379amr4710116plx.53.1700032818503;
        Tue, 14 Nov 2023 23:20:18 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:17fb:8618:ef90:4679])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b001b03a1a3151sm6838382plh.70.2023.11.14.23.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 23:20:17 -0800 (PST)
Date: Tue, 14 Nov 2023 23:20:16 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Pengcheng Yang <yangpc@wangsu.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Pengcheng Yang <yangpc@wangsu.com>
Message-ID: <6554713028d5b_3733620856@john.notmuch>
In-Reply-To: <1699962120-3390-3-git-send-email-yangpc@wangsu.com>
References: <1699962120-3390-1-git-send-email-yangpc@wangsu.com>
 <1699962120-3390-3-git-send-email-yangpc@wangsu.com>
Subject: RE: [PATCH bpf-next 2/3] tcp: Add the data length in skmsg to SIOCINQ
 ioctl
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pengcheng Yang wrote:
> SIOCINQ ioctl returns the number unread bytes of the receive
> queue but does not include the ingress_msg queue. With the
> sk_msg redirect, an application may get a value 0 if it calls
> SIOCINQ ioctl before recv() to determine the readable size.
> 
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3d3a24f79573..04da0684c397 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -267,6 +267,7 @@
>  #include <linux/errqueue.h>
>  #include <linux/static_key.h>
>  #include <linux/btf.h>
> +#include <linux/skmsg.h>
>  
>  #include <net/icmp.h>
>  #include <net/inet_common.h>
> @@ -613,7 +614,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg)
>  			return -EINVAL;
>  
>  		slow = lock_sock_fast(sk);
> -		answ = tcp_inq(sk);
> +		answ = tcp_inq(sk) + sk_msg_queue_len(sk);

This will break the SK_PASS case I believe. Here we do
not update copied_seq until data is actually copied into user
space. This also ensures tcp_epollin_ready works correctly and
tcp_inq. The fix is relatively recent.

 commit e5c6de5fa025882babf89cecbed80acf49b987fa
 Author: John Fastabend <john.fastabend@gmail.com>
 Date:   Mon May 22 19:56:12 2023 -0700

    bpf, sockmap: Incorrectly handling copied_seq

The previous patch increments the msg_len for all cases even
the SK_PASS case so you will get double counting.

I was starting to poke around at how to fix the other cases e.g.
stream parser is in use and redirects but haven't got to it  yet.
By the way I think even with this patch epollin_ready is likely
not correct still. We observe this as either failing to wake up
or waking up an application to early when using stream parser.

The other thing to consider is redirected skb into another socket
and then read off the list increment the copied_seq even though
they shouldn't if they came from another sock?  The result would
be tcp_inq would be incorrect even negative perhaps?

What does your test setup look like? Simple redirect between
two TCP sockets? With or without stream parser? My guess is we
need to fix underlying copied_seq issues related to the redirect
and stream parser case. I believe the fix is, only increment
copied_seq for data that was put on the ingress_queue from SK_PASS.
Then update previous patch to only incrmeent sk_msg_queue_len()
for redirect paths. And this patch plus fix to tcp_epollin_ready
would resolve most the issues. Its a bit unfortunate to leak the
sk_sg_queue_len() into tcp_ioctl and tcp_epollin but I don't have
a cleaner idea right now.

>  		unlock_sock_fast(sk, slow);
>  		break;
>  	case SIOCATMARK:
> -- 
> 2.38.1
> 



