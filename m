Return-Path: <bpf+bounces-61183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A8AE1F28
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F5F1893FED
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936642D4B52;
	Fri, 20 Jun 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if3MawkM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD92BFC9B;
	Fri, 20 Jun 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434161; cv=none; b=e6PhvfdXd4mKdK3nawCUB5AH4Z4v6Mt8TS0/AKPwIpGsaR5/r4TIt5P8zgs1l2L0d6vUwNCs+x0Q748GNYgdUCUtGY2aGF+4sl59q0QTutpxmS9Iv9CxzFp10RAKMIYp5Wh43JhtCUNdgnnDv7C8ZJ8TteAgo4qSmslzdTHx6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434161; c=relaxed/simple;
	bh=Tna/yHcySnbeunapxKya4OsuMG/5jiMtm268LqUXwYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYUvbxOKFsatDxg9JIv8d1yvrW9ymdNDLQ2yEQiK2MZ97H3TlzrqOMtxS57In+oSvlE9LDYG4tlGRPY1nw4PZatDoa4RLE0+ONdjUaH24cVF/d4dDL7lhexYiUv+t7MmI+IVreaZ8SIriNyrbyRnEGXOR4Yu89EQdST4rfINnto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if3MawkM; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86d0168616aso202171639f.1;
        Fri, 20 Jun 2025 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750434157; x=1751038957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7n2FVaDdWS/06FaEWTCeEC2oEqzsGOdHrIOKF7GjRM=;
        b=if3MawkMJY8SCJfGonFRKSQPj7SYbWtFfX+33pBWX7tvQiaEGjy4xsU9AzAeHYiqdV
         yubqMQ4wON2TFykqPW74hAeICSBGFpiUYq5MEL5feDp69AH88QdfxjUynlduJOrvPopF
         9lXYbBG8X+5WqzYrILS9MXSAF3YRRulTI58/35mIGrlUuY7PtSrKE5cSYLghmK4z79a+
         sKKjZBIEBbTIRDub4i4IjdIR1Jtgghl3z3g9ken/DYAZ03hdwq7DV/P0f4NasuZ+0ZdS
         5xt4obIVaDEPUyaxN4PFYSnh62DsnAo61oTnXziz5kr89eFnsy1MmcX3aCqknluKDuge
         nJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434157; x=1751038957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7n2FVaDdWS/06FaEWTCeEC2oEqzsGOdHrIOKF7GjRM=;
        b=TU4lz5ABKJHpN2O0hhZ5RsW9y1H+kZ+aFtwkQp2GdNu7yqTrwQDrfLcX/6Id5ZyC2R
         zq9s400B59wgSA3EbIO9/jHOh3uWjEkgAhF4hL9vcoFOqU+FOwFo1IdVl9k3yPwXH3F7
         HbT61hTYVzP1yqF9i5GgaFVnE/A+et0y5w4VNuam9V1wYQgjR8F9EhZkj91U9xOofsyO
         3dpMKcApzwx4LJGy/xeE8XbfB30SyX2+AsCMY3W6Z1y5EvL3yFyl2aF9kIuwGrb5OT5O
         IFjS1U+l38+S3xfVujkluE4SxdqI6dHtBj7xvriHndQyqGQpRmcbN0rvF0eE6SLOPOXa
         UY7A==
X-Forwarded-Encrypted: i=1; AJvYcCUiWWDbaciH/4vaAMX5CB3AzkJgYz9c1dSbLe7xirCw9ZdMgzu8qiIJO6saBAUpKNguS4mLIYtZ@vger.kernel.org, AJvYcCW8l+00UyM+Rzx9GRm1Lnh+Zqb4rEgH230L5InAyDVev464JpiBlbqsDdQHTFLA2HzQtfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuEmJ1RvzMwGzYwwI6ljcL6WTcp0PzI6rqIYxTbn9bFQ8tL5f
	PdccNBkZe+L5UMgoW80AiA/yGEv+2KRCh7HyKbW5MVY9LpdhqlyzUPGJzveHl8yKYljwBMZW1A9
	IaSA1j8vaW2tDAY9+zLwZoYP6lkE2i6Y=
X-Gm-Gg: ASbGnctS1kdktTix7+4rXAYBiHIOrZCs+T7ljhY6aUcxtp7/pWG2/2PP6uZjdSjYJ2r
	64+G06+l/0gYvEO3LGSEdfLugvU5lOdrgZ3tOJd7xcRglobhKKYgP8pPqHuIOGCKat+3AHyW34q
	EjQZRt5f61PWwlZMiLaMo2XYQW/1gUlZxpo5aKY+EpCg==
X-Google-Smtp-Source: AGHT+IHApzor4QL00WM3Ubr6iQ2RSLlvCLJrBXS+EZN/eEmTmqUX6hUQMSaZZg0cV3NDEOufYaHcld7p5sn3V6pTE1A=
X-Received: by 2002:a05:6e02:258e:b0:3dd:d338:5c7a with SMTP id
 e9e14a558f8ab-3de38c1bed9mr38033255ab.4.1750434157610; Fri, 20 Jun 2025
 08:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619093641.70700-1-kerneljasonxing@gmail.com>
 <aFVr60tw3QJopcOo@mini-arch> <aFV/yG6pFEPwrwDz@boxer>
In-Reply-To: <aFV/yG6pFEPwrwDz@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 20 Jun 2025 23:42:01 +0800
X-Gm-Features: AX0GCFt_eZX4SRCXs6KvXbDauAtbPanSml9inhIJ7GST3LUOyAi7mKG3Zpjv_OQ
Message-ID: <CAL+tcoCw=N0+btRMv9R=-n6XeJGhupyOd7eOyjNwiS7+Nny9wg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: xsk: update tx queue consumer immdiately
 after transmission
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 11:35=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Jun 20, 2025 at 07:10:51AM -0700, Stanislav Fomichev wrote:
> > On 06/19, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > For afxdp, the return value of sendto() syscall doesn't reflect how m=
any
> > > descs handled in the kernel. One of use cases is that when user-space
> > > application tries to know the number of transmitted skbs and then dec=
ides
> > > if it continues to send, say, is it stopped due to max tx budget?
> > >
> > > The following formular can be used after sending to learn how many
> > > skbs/descs the kernel takes care of:
> > >
> > >   tx_queue.consumers_before - tx_queue.consumers_after
> > >
> > > Prior to the current patch, the consumer of tx queue is not immdiatel=
y
> > > updated at the end of each sendto syscall, which leads the consumer
> > > value out-of-dated from the perspective of user space. So this patch
> > > requires store operation to pass the cached value to the shared value
> > > to handle the problem.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 7c47f665e9d1..3288ab2d67b4 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -856,6 +856,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> > >     }
> > >
> > >  out:
> > > +   __xskq_cons_release(xs->tx);
> > > +
> > >     if (sent_frame)
> > >             if (xsk_tx_writeable(xs))
> > >                     sk->sk_write_space(sk);
> >
> > So for the "good" case we are going to write the cons twice? From
> > xskq_cons_peek_desc and from here? Maybe make this __xskq_cons_release
> > conditional ('if (err)')?
>
> this patch updates a global state of producer whereas generic xmit loop
> updates local value. this global state is also updated within peeking
> function.

Stanislav also pointed out the normal/majority of good cases. I will
filter out the good case then.

>
> from quick look patch seems to be correct however my mind is in vacation
> mode so i'll take a second look on monday.

Thanks. I'm very sure that the line this patch introduces can be
helpful because I manually printk the delta to verify before/after
__xskq_cons_release(xs->tx); and then spot a few numbers larger than
zero during a simple test.

Thanks,
Jason

>
> >
> > I also wonder whether we should add a test for that? Should be easy to
> > verify by sending more than 32 packets. Is there a place in
> > tools/testing/selftests/bpf/xskxceiver.c to add that?

