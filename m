Return-Path: <bpf+bounces-41306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9AB995B80
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF9E1C2163A
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABA217913;
	Tue,  8 Oct 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn2Ym7el"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756C2178FE;
	Tue,  8 Oct 2024 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429549; cv=none; b=QITNUPjoRy6Te9KDKFvvIO+UbxtVkoQfo/gtVOJjehDbC43iiRqqu+1pCATxYlUwfk1iwnXw3IXngYfy7YSYUBFjLNGGW1iADaZrqWUwcBoyNukXD3LZWRKinP4GbPgy223KCTvmgngcqDRDIuhV8CVi4vg4t0rVhQ5MW67ZtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429549; c=relaxed/simple;
	bh=UWx7R+D4wTTqvKoZ9J90B2LDFN/v+psmFlgqBnJJ5ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX+iU0tvdZebcOm1lICkMbjqB9dYWuvMBg5MjQyh1eR1sIOTT6JsYxif0ghuDF0rTAQS8bVWPnlkXwSAM/FLVTo97AZd50NKyLZqx7j0+ncNC/4pDuUVWvD90GuNMWvmY1XAdOxIUo9IDbe0YM0vIhhNLOopYwkGribpjmmTdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn2Ym7el; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-835393b3c05so13802539f.2;
        Tue, 08 Oct 2024 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728429547; x=1729034347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8V3pavK9gEFR3Y/ZpTYwjDhBxTLh7nk+LEHCLIgYUk=;
        b=Mn2Ym7el8VWsz9tV4pp3DTv9JxKgLsIfwp8q/7E8NJbQO9t7tLlZexuEv1sGI0xQYH
         owNoGzBwj6XgQz+5xRA14Qls26nyA7Iws35b2QHF+sT/NQ9RTLkqAX4WgWm8dlZ7wssY
         v4KGax992BwjXe9F/N6soki0e7wCk+5GDjJgP+vpEQavzRiQz/BQx+qQB8FhAD++DLsI
         d6BYp1R0pCYuznQE3FvZEtN/Op5s3y7UjNSLMg1Z8k1eKkme9xzndV18IwFh2U5TgdFi
         i9rauqB8tt9uOiQsNsXKFLzhm3kH9skSLp2usihP2ekSC0NzP6lOd9FQ9ctQjl4QWecR
         M6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728429547; x=1729034347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8V3pavK9gEFR3Y/ZpTYwjDhBxTLh7nk+LEHCLIgYUk=;
        b=muWoIbDD7mBxCzqEkgptKMH63xVyaBu3jAK1tTh+hGoJJHzUppM3OliUx6Wfx4+5LB
         5KKivrGOwtPg1n2/fQP8n1/DhW+vHcqhmU3vUowsi1Qqm46/ebQKIjeJcyxLIf3Mtuz0
         p6emTR+MglOe18kYK8npqPTGXfmW+KfzqCEJsaLmrpQAed/iWTvs9ROY3RYM23Cq9fGO
         OvfxnstbYlYZq1JrQe3PrZjCNTUJKIoi+fzfjMbVDP6t32FLu6Nf51jyIaDR2BhY5uu+
         fi2a/yyDvBqxZiilioOAT7qzB5GvLmnyU6zucBkbTKH31NfdTDa8P3dVhjehYOjaJsHE
         wblg==
X-Forwarded-Encrypted: i=1; AJvYcCVn7qLMWmGO1OsnkUxscaHdm+DyZzWKB6aC0IoD+Of/d0+klVZ51Ozvx+Ox14zUIaq6vhCgrk0Z@vger.kernel.org, AJvYcCWqc3WS+4E1x7xmjjRyzDN83sATxOPQomGQzxlca6xuvF69F4bb55lLh2jnhtJOgWtGAUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0g4YKxdFGoKegKi4ncJCDYsjgh3DrYq/pLGHi0wQQJMjhs6RE
	3OYBrUCLgi7ix7+Jzailxc8yivRxZDRGNAvj+u7m4ke8Ea5gGbZEDv7GVCE3hz/G5P+Z19sidvu
	miowHH0YzLS4AxMW2znn+cLYsVspJIVTU
X-Google-Smtp-Source: AGHT+IEF1bl05RbryFjU1WHWXSQpyLnCbbHGfsuMLSddfL6821lwuyuTa70yEFqo4fRGVKMV9ZzaQyo3yFB1Cn2jQJk=
X-Received: by 2002:a05:6e02:1d82:b0:3a0:8e92:ecd1 with SMTP id
 e9e14a558f8ab-3a397ce886cmr4883685ab.2.1728429546782; Tue, 08 Oct 2024
 16:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-7-kerneljasonxing@gmail.com> <6705804318fa1_1a41992941a@willemb.c.googlers.com.notmuch>
In-Reply-To: <6705804318fa1_1a41992941a@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 07:18:30 +0800
Message-ID: <CAL+tcoA_HwCYG+_DtdRHNL-L07RYqQfxY+pmT2fUvs-N1HYV9g@mail.gmail.com>
Subject: Re: [PATCH net-next 6/9] net-timestamp: add tx OPT_ID_TCP support for
 bpf case
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> > from each sendmsg. We only set the socket once like how we use
> > setsockopt() with OPT_ID|OPT_ID_TCP flags.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/core/skbuff.c | 16 +++++++++++++---
> >  net/ipv4/tcp.c    | 19 +++++++++++++++----
> >  2 files changed, 28 insertions(+), 7 deletions(-)
> >
>
> > @@ -491,10 +491,21 @@ static u32 bpf_tcp_tx_timestamp(struct sock *sk)
> >       if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
> >               return 0;
> >
> > +     /* We require users to set both OPT_ID and OPT_ID_TCP flags
> > +      * together here, or else the key might be inaccurate.
> > +      */
> > +     if (flags & SOF_TIMESTAMPING_OPT_ID &&
> > +         flags & SOF_TIMESTAMPING_OPT_ID_TCP &&
> > +         !(sk->sk_tsflags & (SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPIN=
G_OPT_ID_TCP))) {
> > +             atomic_set(&sk->sk_tskey, (tcp_sk(sk)->write_seq - copied=
));
> > +             sk->sk_tsflags |=3D (SOF_TIMESTAMPING_OPT_ID | SOF_TIMEST=
AMPING_OPT_ID_TCP);
>
> So user and BPF admin conflict on both sk_tsflags and sktskey?
>
> I think BPF resetting this key, or incrementing it, may break user
> expectations.

Yes, when it comes to OPT_ID and OPT_ID_TCP, conflict could happen.
The reason why I don't use it like BPF_SOCK_OPS_TS_SCHED_OPT_CB flags
(which is set along with each last skb) is that OPT_ID logic is a
little bit complex. If we want to avoid touching sk_tsflags field in
struct sock, we have to re-implement a similiar logic as you've
already done in these years.

Now, this patch is easier but as you said it may "break" users... But
I wonder if we can give the bpf program the first priority like what
TCP_BPF_RTO_MIN does. TCP_BPF_RTO_MIN can override icsk_rto_min field
in struct inet_connection_sock.

Thanks,
Jason

