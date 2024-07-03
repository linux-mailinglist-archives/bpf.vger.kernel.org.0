Return-Path: <bpf+bounces-33721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D679E924D17
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 03:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BBD1C22260
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766521373;
	Wed,  3 Jul 2024 01:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG2DpPBQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932061FAA
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969162; cv=none; b=cACyO55E+dz8uLV4XbvipinCXmGohY/JiUZLpxEH1PlUg72cvAERoqb/F1uvsN7bIrjXlBZ1LA2bIk2ucAzEYqtbOnffumMzdr/Wb4jPU7HbcOtrbAqVW5iRqxXf2YEN0sqEoNZxQj3wax7gjxByrVdLLqQE2w5j6suAH7r+JlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969162; c=relaxed/simple;
	bh=s3aSXm/vvSjNjIeyLNtufvHNpdbg8dNExPbjDRr3b54=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YLbO/chEMGZ6BE+cxvdAaNmnh/3HVgIwCMlVgVvZAFrB9Slf/4n1irln3iRAfmanly1tLiTswZym9LHvoFP3n/J9Rp27a7/uyNel0lEiqJldzBlZPgGaaHSlhLjUJ0j1ZRgk99U689FSOTxUvpM8RIKunvzrWtArliBgdV4dK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG2DpPBQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso2912855a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 18:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719969160; x=1720573960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY8gZ9OiQtg/5OgmG6e+8EOUOjU0mi8ZInMXFqRZRXI=;
        b=DG2DpPBQ1r37PzFh2VsoOIsfCT8Pshqjb+bo7pGvUdh5kKM0bwSL4hv4a8NEHKQvep
         gJZ/V29W2V8rB+iyVpyPGUHq0GQo8m87izv6F7lIDDAkn5G0AinhlHyv9tskOY2EmwuG
         TdFKXudg5JBvrW4MOO2e2p0VhkfSHP+00JAtDh7UOcC19Pg3vsfC13CWqP2PMHLCghgN
         ErEy08ZxCwu/FZRkSiZTZI4Zqb6blvz+f+l/3G40YDnneLmmprIIvWrEfTV2Ro91hvoa
         7vhJYXlgY4XUDF61+OskzUJcmkiIhmk60lMZU0J1g8n/h56JMVa0X+iXl9CMulLMbmts
         fRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719969160; x=1720573960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XY8gZ9OiQtg/5OgmG6e+8EOUOjU0mi8ZInMXFqRZRXI=;
        b=ummjRIvuHLgDspazfZfCDZDgQZg32RzEksAlxnD4rvRhotm82B4nk921yga5iopaVj
         7KyXh5wh/KIWlY9YOhpaw3OXti5B5sn7HpVvQcW5OHJ/HpNXyY6kQDTB/sJNSUV+AMDN
         RRDk7ZAOxRsjCRgKvp5nIMy3OgWRgNtKl19Ejrn6KvnSrrZ3FOc7dVaptof6ZtQf2BQV
         C7kjfuPEz4MC8tKOdUUR5IZ7R/xLML69MsMGQf1kGKlgcjo0G+CQgmNjhfBRnUBpWiMZ
         F0nxmZBD9Q7LaTTcr3AvFEKafG3FSKtNuJt6lw9/Gv2E5NIM/qfk0RZiV6jFOe+N5wYK
         TG9g==
X-Gm-Message-State: AOJu0YxeYSHx5l8zJW9+8IWXUeO9ULhgPhxdh0Xhb4L4NW/0xhklY3hU
	dOMVsFvZ7dqYNPfS2f03tpvHQsYIwx5lMvNJWj2DklsfFgw0rf1v
X-Google-Smtp-Source: AGHT+IEFEqtumyYo1OaZ54XRTzR9bQVHhuGCV2OvPRMPJwwGCqHOG+UNPHjiO/q1Cq5xuresf2CW4A==
X-Received: by 2002:a05:6a20:9f8f:b0:1be:d04e:3815 with SMTP id adf61e73a8af0-1bef6224cf9mr8876916637.56.1719969159694;
        Tue, 02 Jul 2024 18:12:39 -0700 (PDT)
Received: from localhost ([98.97.33.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb111382f5sm4429085ad.175.2024.07.02.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 18:12:39 -0700 (PDT)
Date: Tue, 02 Jul 2024 18:12:38 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 vincent.whitchurch@datadoghq.com, 
 daniel@iogearbox.net
Message-ID: <6684a5864ec86_403d20898@john.notmuch>
In-Reply-To: <874j9bg3ua.fsf@cloudflare.com>
References: <20240625201632.49024-1-john.fastabend@gmail.com>
 <20240625201632.49024-2-john.fastabend@gmail.com>
 <874j9bg3ua.fsf@cloudflare.com>
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, fix introduced strparser recursive
 lock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Sitnicki wrote:
> On Tue, Jun 25, 2024 at 01:16 PM -07, John Fastabend wrote:
> > Originally there was a race where removing a psock from the sock map =
while
> > it was also receiving an skb and calling sk_psock_data_ready(). It wa=
s
> > possible the removal code would NULL/set the data_ready callback whil=
e
> > concurrently calling the hook from receive path. The fix was to wrap =
the
> > access in sk_callback_lock to ensure the saved_data_ready pointer did=
n't
> > change under us. There was some discussion around doing a larger chan=
ge
> > to ensure we could use READ_ONCE/WRITE_ONCE over the callback, but th=
at
> > was for *next kernels not stable fixes.
> >
> > But, we unfortunately introduced a regression with the fix because th=
ere
> > is another path into this code (that didn't have a test case) through=

> > the stream parser. The stream parser runs with the lower lock which m=
eans
> > we get the following splat and lock up.
> >
> >
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  WARNING: possible recursive locking detected
> >  6.10.0-rc2 #59 Not tainted
> >  --------------------------------------------
> >  test_sockmap/342 is trying to acquire lock:
> >  ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
> >  sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
> >  net/core/skmsg.c:555)
> >
> >  but task is already holding lock:
> >  ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
> >  sk_psock_strp_data_ready (net/core/skmsg.c:1120)
> >
> > To fix ensure we do not grap lock when we reach this code through the=

> > strparser.
> >
> > Fixes: 6648e613226e1 ("bpf, skmsg: Fix NULL pointer dereference in sk=
_psock_skb_ingress_enqueue")
> > Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  include/linux/skmsg.h | 9 +++++++--
> >  net/core/skmsg.c      | 5 ++++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> > index c9efda9df285..3659e9b514d0 100644
> > --- a/include/linux/skmsg.h
> > +++ b/include/linux/skmsg.h
> > @@ -461,13 +461,18 @@ static inline void sk_psock_put(struct sock *sk=
, struct sk_psock *psock)
> >  		sk_psock_drop(sk, psock);
> >  }
> >  =

> > -static inline void sk_psock_data_ready(struct sock *sk, struct sk_ps=
ock *psock)
> > +static inline void __sk_psock_data_ready(struct sock *sk, struct sk_=
psock *psock)
> >  {
> > -	read_lock_bh(&sk->sk_callback_lock);
> >  	if (psock->saved_data_ready)
> >  		psock->saved_data_ready(sk);
> >  	else
> >  		sk->sk_data_ready(sk);
> > +}
> > +
> > +static inline void sk_psock_data_ready(struct sock *sk, struct sk_ps=
ock *psock)
> > +{
> > +	read_lock_bh(&sk->sk_callback_lock);
> > +	__sk_psock_data_ready(sk, psock);
> >  	read_unlock_bh(&sk->sk_callback_lock);
> >  }
> >  =

> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index fd20aae30be2..8429daecbbb6 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -552,7 +552,10 @@ static int sk_psock_skb_ingress_enqueue(struct s=
k_buff *skb,
> >  	msg->skb =3D skb;
> >  =

> >  	sk_psock_queue_msg(psock, msg);
> > -	sk_psock_data_ready(sk, psock);
> > +	if (skb_bpf_strparser(skb))
> > +		__sk_psock_data_ready(sk, psock);
> > +	else
> > +		sk_psock_data_ready(sk, psock);
> >  	return copied;
> >  }
> =

> If I follow, this is the call chain that leads to the recursive lock:
> =

> sock::sk_data_ready =E2=86=92 sk_psock_strp_data_ready
>     write_lock_bh(&sk->sk_callback_lock)
>     strp_data_ready
>       strp_read_sock
>         proto_ops::read_sock =E2=86=92 tcp_read_sock
>           strp_recv
>             __strp_recv
>               strp_callbacks::rcv_msg =E2=86=92 sk_psock_strp_read
>                   sk_psock_verdict_apply(verdict=3D__SK_PASS)
>                     sk_psock_skb_ingress_self
>                       sk_psock_skb_ingress_enqueue
>                         sk_psock_data_ready
>                           read_lock_bh(&sk->sk_callback_lock) !!!
> =

> What I don't get, though, is why strp_data_ready has to be called with =
a
> _writer_ lock? Maybe that should just be a reader lock, and then it can=

> be recursive.

Agree read lock should be fine we just want to ensure the strp
is not changing during the callchain there. Let me do that
fix instead.=

