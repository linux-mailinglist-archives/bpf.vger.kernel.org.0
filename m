Return-Path: <bpf+bounces-32122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93EA907C0D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 21:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B01F23042
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8797314AD22;
	Thu, 13 Jun 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/OgW1TN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E12F34;
	Thu, 13 Jun 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305710; cv=none; b=MLJpfM1pLMfkMvWCC0NhIVtw1d9kOaQTnvqe0HBKdB+hQi/kiJzLvuI8A4E+LNlEvJ/okt0smHYCbJP5TXNG0T84CfhNT4rc293Z82eaqS0+ieVKAv4f+q4pSqesZar7xxP3W+aARrJWb+k81Lo4MlrQK+FkwgRXf3ahKmmnPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305710; c=relaxed/simple;
	bh=cYseNcA3M4djViEMjxFYSrTh62bXTcMO7SKq9yDjoh4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AwUoZT0BUH0oWgzQ4XDzvfQ0bfqZGL5NLejV4D1Ii/9gN7a/oOmqP6wfRX2gg0tZVAx6L3YRa/WiI7KJqDbp0iO0RhInksoWY5fAO803kxrTWwz6kEX2at9COFCNbC1DiyUZX9axraH+fNLPKQkgNDfb4fk444ADyqYbQvxuL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/OgW1TN; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7ebe508fa34so34220139f.2;
        Thu, 13 Jun 2024 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718305708; x=1718910508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnk9iBqEEAIbCVvLBkqGKk6jeLA+BOD35Txz9Eq0i4s=;
        b=S/OgW1TN+qw0Q68hX70GkUKTd0wdUpH9AkvUrb709vHuMUABMbtRmMucFVGrHO/QUY
         JlA7H7RR0AMA0pqvBCKP00l+dpnSLlSLidyoC8M/345sxLJ4c7AGz6j2WZ5sMpu18kbv
         HdT3r+2DgmbymhMA/HNuDb7nFQTTgb1NEk592CVZJGgrWKp6hl0bykG62d6Gr0+VDsnC
         j55lIPjeKgVEdBnWqzWtYRiAZBuZf7ppgyoLOZ43Q3ZwHpzW0ZkTQjO6AEVTYgZ0Aw84
         F4kqwtcC62ZANVSUtnGJ/BtgJGYx/Z0KaVMG2DMb4zGSQXkqiN/i+Y+6/iCd+icWijBm
         HJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305708; x=1718910508;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rnk9iBqEEAIbCVvLBkqGKk6jeLA+BOD35Txz9Eq0i4s=;
        b=YO5LbmDcyT1mh2Gkp+09nS8sX7W3MKqWG5B/FhcrSQMsr1IXgNrOSK23W8H/L/rZ9A
         QXbprbhjMLF8h5Oxd7wEdqiE72DXpoPylqI54w2ARjULXPpsjZbm7DTapNN236d0n//B
         eQBwzf3QwR88Dqhccm67RvU/B2Nr/znwbw6f2ggCLHgl6bujYlahzzKrjd4VPDz0FwXV
         tz2M2CtSMdxFlYIq8VH3DjrPPUoKLB5wvC4aLEln22uOAKt6f7gKcfqvlbYhExG8+4me
         bCmW7/PRLmihsxECYcbDXVnl+2Cm75+9mKLN5siKFWdqNK8XjZEPLBgodmVQBds/WdOe
         /ObQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQLinYeKuR26gxlqcTRzrjTvxnYpm7RDgDq4CqCUj4i3GhDC60+l2P7vOZOvtnnpROovtnDIeYktnolP3sRqV3m1Ww4KVkYSlnuhtQuu0POSXLERdUR/7u2bsg
X-Gm-Message-State: AOJu0YzR81F7xjF1ZQCwf/sXnOEuae8MBoaLcWWnRRz9uL4hl5ke29W2
	G+6shVcgSSXf3/AkTvV7kCHyTxuuHE8+ihHe6Lg4joL1JuTCFb7i
X-Google-Smtp-Source: AGHT+IH8047mAA1ms5CmYJsxslwpykadtp45vg4juKMxWmmeek1TIE1eYrM7KMWE57d1AzT7cy6zKg==
X-Received: by 2002:a5d:85d7:0:b0:7eb:8d08:e9de with SMTP id ca18e2360f4ac-7ebeb631d68mr41522239f.14.1718305707553;
        Thu, 13 Jun 2024 12:08:27 -0700 (PDT)
Received: from localhost ([2603:300b:50c:2000::13a5])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a21890sm513504173.129.2024.06.13.12.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:08:27 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:08:25 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, 
 Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jason Xing <kernelxing@tencent.com>, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <666b43a9b2b4a_1995c208f@john.notmuch>
In-Reply-To: <ZmMuh5mkK7w7s/3L@pop-os.localdomain>
References: <CALye=_-HrFUF_Eq7SfpWZQUvBOVHx0rmsT2-O6TWgyMF-GFQ8w@mail.gmail.com>
 <CAL+tcoBByAuBj-3XK2QL5Hir_xyfKt5AFzYkjb41mreVdS2=7Q@mail.gmail.com>
 <CALye=_-oqMO-LRWd7pvMUnOxDCNVg0v=Wgmg8Qggg1Q3yL-jmQ@mail.gmail.com>
 <ZmMuh5mkK7w7s/3L@pop-os.localdomain>
Subject: Re: Recursive locking in sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cong Wang wrote:
> On Fri, Jun 07, 2024 at 02:09:59PM +0200, Vincent Whitchurch wrote:
> > On Thu, Jun 6, 2024 at 2:47=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > On Thu, Jun 6, 2024 at 6:00=E2=80=AFPM Vincent Whitchurch
> > > <vincent.whitchurch@datadoghq.com> wrote:
> > > > With a socket in the sockmap, if there's a parser callback instal=
led
> > > > and the verdict callback returns SK_PASS, the kernel deadlocks
> > > > immediately after the verdict callback is run. This started at co=
mmit
> > > > 6648e613226e18897231ab5e42ffc29e63fa3365 ("bpf, skmsg: Fix NULL
> > > > pointer dereference in sk_psock_skb_ingress_enqueue").
> > > >
> > > > It can be reproduced by running ./test_sockmap -t ping
> > > > --txmsg_pass_skb.  The --txmsg_pass_skb command to test_sockmap i=
s
> > > > available in this series:
> > > > https://lore.kernel.org/netdev/20240606-sockmap-splice-v1-0-4820a=
2ab14b5@datadoghq.com/.
> > >
> > > I don't have time right now to look into this issue carefully until=

> > > this weekend. BTW, did you mean the patch [2/5] in the link that ca=
n
> > > solve the problem?
> > =

> > No.  That patch set addresses a different problem which occurs even i=
f
> > only a verdict callback is used. But patch 4/5 in that patch set adds=

> > the --txmsg_pass_skb option to the test_sockmap test program, and tha=
t
> > option can be used to reproduce this deadlock too.
> =

> I think we can remove that write_lock_bh(&sk->sk_callback_lock). Can yo=
u
> test the following patch?
> =

> ------------>
> =

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index fd20aae30be2..da64ded97f3a 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1116,9 +1116,7 @@ static void sk_psock_strp_data_ready(struct sock =
*sk)
>  		if (tls_sw_has_ctx_rx(sk)) {
>  			psock->saved_data_ready(sk);
>  		} else {
> -			write_lock_bh(&sk->sk_callback_lock);
>  			strp_data_ready(&psock->strp);
> -			write_unlock_bh(&sk->sk_callback_lock);
>  		}
>  	}
>  	rcu_read_unlock();

Its not obvious to me that we can run the strp parser without the
sk_callback lock here. I believe below is the correct fix. It
fixes the splat above with test.

bpf: sockmap, fix introduced strparser recursive lock

Originally there was a race where removing a psock from the sock map whil=
e
it was also receiving an skb and calling sk_psock_data_ready(). It was
possible the removal code would NULL/set the data_ready callback while
concurrently calling the hook from receive path. The fix was to wrap the
access in sk_callback_lock to ensure the saved_data_ready pointer didn't
change under us. There was some discussion around doing a larger change
to ensure we could use READ_ONCE/WRITE_ONCE over the callback, but that
was for *next kernels not stable fixes.

But, we unfortunately introduced a regression with the fix because there
is another path into this code (that didn't have a test case) through
the stream parser. The stream parser runs with the lower lock which means=

we get the following splat and lock up.


 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 WARNING: possible recursive locking detected
 6.10.0-rc2 #59 Not tainted
 --------------------------------------------
 test_sockmap/342 is trying to acquire lock:
 ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
 sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
 net/core/skmsg.c:555)

 but task is already holding lock:
 ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
 sk_psock_strp_data_ready (net/core/skmsg.c:1120)

To fix ensure we do not grap lock when we reach this code through the
strparser.

Fixes: 6648e613226e1 ("bpf, skmsg: Fix NULL pointer dereference in sk_pso=
ck_skb_ingress_enqueue")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/skmsg.h |    9 +++++++--
 net/core/skmsg.c      |    5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c9efda9df285..3659e9b514d0 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -461,13 +461,18 @@ static inline void sk_psock_put(struct sock *sk, st=
ruct sk_psock *psock)
 		sk_psock_drop(sk, psock);
 }
 =

-static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock =
*psock)
+static inline void __sk_psock_data_ready(struct sock *sk, struct sk_psoc=
k *psock)
 {
-	read_lock_bh(&sk->sk_callback_lock);
 	if (psock->saved_data_ready)
 		psock->saved_data_ready(sk);
 	else
 		sk->sk_data_ready(sk);
+}
+
+static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock =
*psock)
+{
+	read_lock_bh(&sk->sk_callback_lock);
+	__sk_psock_data_ready(sk, psock);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 =

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..8429daecbbb6 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -552,7 +552,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_bu=
ff *skb,
 	msg->skb =3D skb;
 =

 	sk_psock_queue_msg(psock, msg);
-	sk_psock_data_ready(sk, psock);
+	if (skb_bpf_strparser(skb))
+		__sk_psock_data_ready(sk, psock);
+	else
+		sk_psock_data_ready(sk, psock);
 	return copied;
 }=

