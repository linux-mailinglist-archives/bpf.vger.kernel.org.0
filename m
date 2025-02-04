Return-Path: <bpf+bounces-50350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06887A26941
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802D8164FFC
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13F7DA6C;
	Tue,  4 Feb 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHs+YCwp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD025A640;
	Tue,  4 Feb 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631739; cv=none; b=jF5OCNVjCegFuWY4wpN7Q2yhNZUeacHY5yYoWG7o6AJrOqZLbGc3TEuM769L16rwe9Zy9bL/Xn3JfrRmv9C1yr8sA/Q7u6ThR3eCgKjr68pGiTz5l8WxFXf30S5dVlNRxAyZY05lFuj5FjBc4EIxUoQ6iI7aX4nHgOa7IKlSrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631739; c=relaxed/simple;
	bh=e5SBbdEoNS/t8rOGEAcHW0AHpsHuC/aRBwwq/QzSfx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWYw9upSrwtEPed9jUnLXhFsnpcd0Q2lMTDKqDlE/mSvXIVEjaZa71jxi7BRrNDXiIoiK4bOyD4NPeIDmihlkigvQeYeG7Iw2HQq9cXj0vuymmF05WLgTnTbJoAXdxnHDMSSz4qLb3RBPaeq099qnG9kUtTcL3ZEfDcDY9nROy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHs+YCwp; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-84a1ce51187so138449839f.1;
        Mon, 03 Feb 2025 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738631737; x=1739236537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqeSG+y4J5+VYStoQV3UPZZsOhszef8qpIsJfmp5vfA=;
        b=bHs+YCwpqt0fpABLQEpVYH8ZucmgINjwhatx4j6smfURJ2GPFumWOHnBeS22PYer0N
         lufUmaoymT8cJAukToMK+NEDRWPVzxnuHV/Zoe8Wh/b9oBOB4hwGtn8b1NwN4Rjlcl3w
         dfgTpoklgwyj+Fc1GteL7QeZQHg1dSu/d3lKkAmnIWKF9v9Mv19/pm2adoGcrU9wAi4f
         du0hSePCNOneA0YTUQj41tDsQPs/AkLogvHcBt8vxVJNNKf4DjxJ0OXXVFXfvtljfane
         F/b5wpi49X8wm0noOljevJjXNssaMtU7S0fiKvodptwrSVS0IkwelOgijlaAPV5+3MTu
         4rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738631737; x=1739236537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqeSG+y4J5+VYStoQV3UPZZsOhszef8qpIsJfmp5vfA=;
        b=WGmz96VqBw71w+XSmtT9I1Ba2S0iuqccJIxrRB2MP0iD1H+y63H3nJrYktGFi2+mfn
         Y7B9zzpC1KxYvi+6R5PkXEutoI+u+XBRnlw3D3vR1bXzy00y2X1QqSqc1NuC90nXa4Go
         sefh1GXf66JSH3Ec8xUfmoKwmYR5jtyo7STna9WIanYYdrZO2QTx32R1sOHMGSE6l4oq
         sx9NotklwISEibzois0mGDH+jGEwzvtEeSrgrY9r8pEoLUj+5wP7dfMmAxAWEO420tvC
         x6JBKam7iOJNLPkv0e9ltdfousvUf7BH4LTb2n/YO7jAnpXlYpRyiPyUrBZe4WMMORZV
         CX/w==
X-Forwarded-Encrypted: i=1; AJvYcCUXeHOTSssu8/dQhriD5zUJ3hhwZfHKNtsjpcum2qwL2hZHrRMT5vnAKcqU7OeHKtgM7VY=@vger.kernel.org, AJvYcCVFB4gXzZkLqQq11xDyN3NgjSiUQ0EFmeaHC28H1yFI7HBLjqxBuZHDjIosTshGpJM/cxMw4CuA@vger.kernel.org
X-Gm-Message-State: AOJu0YwIESIIKNUXpiQA/x1ax+ghxR5G5xF9PusQsUyo43RZoZLaj5aL
	sMmyzmXGUG6xt/oo/IR47fEQ9L8w0XfRNrZXS0695WHkRGjzGRwo7MJLgZog/69co+AzHxTirk6
	mOhOQuhRiYf6A8doDHSNpGqgDwEQ=
X-Gm-Gg: ASbGnctlwg+kzXrdyixQDnYECHzTbRALk95zBocLpRX0TxypUFemp/YM/jwe4g1e+Tb
	5oV1/8hAa6L5QNfw/xYrMP8wV/puKIh76Y5TcMCujzGXkBzf4c73qZW4RJtTBCte80jHPqOI=
X-Google-Smtp-Source: AGHT+IE9FOlzHQdupBFD+oWEKtCN7u8XBCLzP1qUUxPExw5uPLm6eMa7+4WQ/h86051ceiKiNgpMqBLJApsqIQFNBWE=
X-Received: by 2002:a05:6e02:1c8a:b0:3ce:7cca:db24 with SMTP id
 e9e14a558f8ab-3cffe3d8a0emr196826415ab.13.1738631736874; Mon, 03 Feb 2025
 17:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-11-kerneljasonxing@gmail.com> <e7364435-caaa-481a-9fee-83e5c915ed07@linux.dev>
In-Reply-To: <e7364435-caaa-481a-9fee-83e5c915ed07@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Feb 2025 09:15:00 +0800
X-Gm-Features: AWEUYZmyRNwDe9lk0dvg5TeKQ6SIriyZpVV99WrorLNVIl5pAOJDPPyQJcAj8t0
Message-ID: <CAL+tcoB70h4fMNy8rYmnCZuVfCi3cthoNHAtyUo7=X_Q5vq6nA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 10/13] net-timestamp: make TCP tx timestamp
 bpf extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:03=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/28/25 12:46 AM, Jason Xing wrote:
> > Make partial of the feature work finally. After this, user can
>
> If it is "partial"-ly done, what is still missing?
>
> My understanding is after this patch, the BPF program can fully support t=
he TX
> timestamping in TCP.

I'm going to make the change in the next version. My thought was a big
project supporting various protocols.

>
> > fully use the bpf prog to trace the tx path for TCP type.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/ipv4/tcp.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 0d704bda6c41..0a41006b10d1 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -492,6 +492,15 @@ static void tcp_tx_timestamp(struct sock *sk, stru=
ct sockcm_cookie *sockc)
> >               if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> >                       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len=
 - 1;
> >       }
> > +
> > +     if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
> > +             struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > +             struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
> > +
> > +             tcb->txstamp_ack_bpf =3D 1;
> > +             shinfo->tx_flags |=3D SKBTX_BPF;
> > +             shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
> > +     }
> >   }
> >
> >   static bool tcp_stream_is_readable(struct sock *sk, int target)
>

