Return-Path: <bpf+bounces-33433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B6691CDEB
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AF61F22021
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B484D14;
	Sat, 29 Jun 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xh/OWi+x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E941DFE8
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675283; cv=none; b=shUH5psZSMlCLYm/0EmASHgP06f7qANsKjN372YjlspWNuLJ3u7ttUEuM/3+VyRdQtjzWJTnyzZxI5I/ZSB+06jWFA6FFvt5u8P77YPyhpscWhQNERpIAQz7AJeksP1fWRFGtP3JPiPPYjdONHyrSu226ZXJ7EnH4TcmZVsYUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675283; c=relaxed/simple;
	bh=zawYaNC/G8zg04Ha0oi9Kn4r1LpQbTQtc/dk5je4SWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NcKFAVEDl4EuLppf9yj5Cw4pgyepVlVFJ4hUSoVVDhTF8Y/N2n6TGhYsLPfITXS+G+B35t7Syqy7KB+7wLUe8B+IJOKa0NHeXbHJYRBUMONOoiu8U0P+T8QF4HjOZghVy5tuCxCd/fyqkGshgwYwH5noOxhMlUerQMaCq6rKFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xh/OWi+x; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-585e6ad9dbcso1803294a12.3
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719675279; x=1720280079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjIx9A33XTLOFhxcb6wJi7tv425vJeyENpfi7x1b9uI=;
        b=Xh/OWi+xwFBcV0Qq9R88kniGyBbYn96s3el9u5YJMq1PJKurXkrk3DnmTz4jmtIU8E
         H6/w1dAu8GoWpbOn9Ouvw6t+aJbANBA4TA/vWc6FMCjaOLlW4VMuCqOxdKjVBc6vgTCf
         8vxB/QH3787wEHyjec/IEzFSVEw+VSUqkAT1eH4t5pKAgNdqGRJkTwJ1Y/xB1LdrX9UD
         4H6fgoPqjZPFJQIwWTgAV+c9FHajiV7Z2wR7XSh0KedvtGD7hsted3YsRVdcCzDFIIVT
         /R3MuviYjCReWX5y2cxWceQm50mxDh7UMltJM/pvvJH/VoixvenLGEpgWahndQmLrv2J
         4d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719675279; x=1720280079;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hjIx9A33XTLOFhxcb6wJi7tv425vJeyENpfi7x1b9uI=;
        b=LYex0NMNhfBKA8uPwteNeKX8KHN/Is/AGyIAN5ItxxKOY4zAjNGCbnu4ySJkXB8oC4
         f8i/hBWH+MCuUtGIGqc57ISG20jRerdeAoUWAKLEgOHTCSfqhQr+/LEkxF4qfIttZQHm
         4AF1GUk7x7OpQt+b9ZfxY0PFEgpEUNNhtldH7114084Wq3EA5f4I9qofnBNz8HOQnscb
         3aP+HH9/2LcFD2W0Mg7CBHxk6AhtWqF2Q5q1cu4kVOqF6orZwLLcjxE7ZXnd5DywXspe
         26RRp2FxPEpYDPQsy2tZChQhh+xsCqY9pRkqVXtPHmM2FRbJTWIIr4T5VSWjYyePII9M
         XiSQ==
X-Gm-Message-State: AOJu0YxePePqgZBTQNAu/CdbTZrScWFkmWLveymgDtYL7Pakyw9Ai7Ov
	BGyk8BKfcPPVbJNhxr/LRgRYnX/hV427+Sid6jFQ8ORfrreOJdmTkXu1IfdyzH/frDw4Ax5MyYw
	ruWE=
X-Google-Smtp-Source: AGHT+IE36ZioRCmBicVgmZ5r8/69xl8mMSJUn9btSNBar2yFG1kUAmWbyD/t8Er5qPqsJ11EPCP5sQ==
X-Received: by 2002:a17:907:724d:b0:a6f:b84e:8454 with SMTP id a640c23a62f3a-a751443c63emr92363366b.11.1719675279453;
        Sat, 29 Jun 2024 08:34:39 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:df])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b315fsm170388666b.188.2024.06.29.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 08:34:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org,  vincent.whitchurch@datadoghq.com,
  daniel@iogearbox.net
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, fix introduced strparser
 recursive lock
In-Reply-To: <20240625201632.49024-2-john.fastabend@gmail.com> (John
	Fastabend's message of "Tue, 25 Jun 2024 13:16:31 -0700")
References: <20240625201632.49024-1-john.fastabend@gmail.com>
	<20240625201632.49024-2-john.fastabend@gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Sat, 29 Jun 2024 17:34:37 +0200
Message-ID: <874j9bg3ua.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:16 PM -07, John Fastabend wrote:
> Originally there was a race where removing a psock from the sock map while
> it was also receiving an skb and calling sk_psock_data_ready(). It was
> possible the removal code would NULL/set the data_ready callback while
> concurrently calling the hook from receive path. The fix was to wrap the
> access in sk_callback_lock to ensure the saved_data_ready pointer didn't
> change under us. There was some discussion around doing a larger change
> to ensure we could use READ_ONCE/WRITE_ONCE over the callback, but that
> was for *next kernels not stable fixes.
>
> But, we unfortunately introduced a regression with the fix because there
> is another path into this code (that didn't have a test case) through
> the stream parser. The stream parser runs with the lower lock which means
> we get the following splat and lock up.
>
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  WARNING: possible recursive locking detected
>  6.10.0-rc2 #59 Not tainted
>  --------------------------------------------
>  test_sockmap/342 is trying to acquire lock:
>  ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
>  sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
>  net/core/skmsg.c:555)
>
>  but task is already holding lock:
>  ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
>  sk_psock_strp_data_ready (net/core/skmsg.c:1120)
>
> To fix ensure we do not grap lock when we reach this code through the
> strparser.
>
> Fixes: 6648e613226e1 ("bpf, skmsg: Fix NULL pointer dereference in sk_pso=
ck_skb_ingress_enqueue")
> Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  include/linux/skmsg.h | 9 +++++++--
>  net/core/skmsg.c      | 5 ++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index c9efda9df285..3659e9b514d0 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -461,13 +461,18 @@ static inline void sk_psock_put(struct sock *sk, st=
ruct sk_psock *psock)
>  		sk_psock_drop(sk, psock);
>  }
>=20=20
> -static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock =
*psock)
> +static inline void __sk_psock_data_ready(struct sock *sk, struct sk_psoc=
k *psock)
>  {
> -	read_lock_bh(&sk->sk_callback_lock);
>  	if (psock->saved_data_ready)
>  		psock->saved_data_ready(sk);
>  	else
>  		sk->sk_data_ready(sk);
> +}
> +
> +static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock =
*psock)
> +{
> +	read_lock_bh(&sk->sk_callback_lock);
> +	__sk_psock_data_ready(sk, psock);
>  	read_unlock_bh(&sk->sk_callback_lock);
>  }
>=20=20
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index fd20aae30be2..8429daecbbb6 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -552,7 +552,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_bu=
ff *skb,
>  	msg->skb =3D skb;
>=20=20
>  	sk_psock_queue_msg(psock, msg);
> -	sk_psock_data_ready(sk, psock);
> +	if (skb_bpf_strparser(skb))
> +		__sk_psock_data_ready(sk, psock);
> +	else
> +		sk_psock_data_ready(sk, psock);
>  	return copied;
>  }

If I follow, this is the call chain that leads to the recursive lock:

sock::sk_data_ready =E2=86=92 sk_psock_strp_data_ready
    write_lock_bh(&sk->sk_callback_lock)
    strp_data_ready
      strp_read_sock
        proto_ops::read_sock =E2=86=92 tcp_read_sock
          strp_recv
            __strp_recv
              strp_callbacks::rcv_msg =E2=86=92 sk_psock_strp_read
                  sk_psock_verdict_apply(verdict=3D__SK_PASS)
                    sk_psock_skb_ingress_self
                      sk_psock_skb_ingress_enqueue
                        sk_psock_data_ready
                          read_lock_bh(&sk->sk_callback_lock) !!!

What I don't get, though, is why strp_data_ready has to be called with a
_writer_ lock? Maybe that should just be a reader lock, and then it can
be recursive.

