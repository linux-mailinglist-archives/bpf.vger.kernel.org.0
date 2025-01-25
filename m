Return-Path: <bpf+bounces-49736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09DAA1C01F
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3062B3A589A
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7131E98EA;
	Sat, 25 Jan 2025 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCtQUn2Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0BB65C;
	Sat, 25 Jan 2025 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767871; cv=none; b=Ep8wAO7TI6tZEYyBUZtkF4yxd+/zAYgkcqK7PqMWgKEeGShT8gzzsOwzLyA1pH8h5qfDlJnVwBLgT6VS0FPLk/G/UoANSwzGls1CiNKuYvg7kbu9yIi4aRMZn7ebj7ljprMBlvhZpw49yun27sOLDSqLI1+/zc7tE2m1L8oUBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767871; c=relaxed/simple;
	bh=yk4d/Jo7n4uwOq19GVUZcLr1P6ndfZj4A8IatcAKCJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLwrIQYaZqHwASaVH4ZLc/UFs9Jsbq4K9VHBKTXU5iL6WM+FNhHNUeJpsXjZYqm2HnDev39SL9b6AyMKNg1DkcVuxnsFlTiSvm5M9pggQuPZ8eyf7a/ewPa9i+FvRMdJEoWjPSQgRmitV3w6yPiAeCeu3l3+eF/KlK6sH0IFMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCtQUn2Z; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844ef6275c5so73251639f.0;
        Fri, 24 Jan 2025 17:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737767869; x=1738372669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ1iea5YhsktktX424CRmZ0XRDfORE2EoXzCszO5etM=;
        b=SCtQUn2Z88gRxRcpnj221wr2mrHnE5DSvl4O0u09Fj7XPFftvU1zeoiudFgcTTZZ6h
         xEpT7PGzCVE0WKLWW8rYsPAIDeLj8/80kCHrsB2bycgi8MCBOGrNYpTokeY1YMqoABlK
         9wBrc+eOfcfyAaJDXL6x2xNkS8+3hj5xhi7lNWOM3K+Io2Z5G30nj7DT0ADqH7b1vyRr
         QR8H37RKdnQgZrhMvmKCgMrGZm+hee580OZa/9qfIEac9FKq6FQN4fdpNQA35BsBpsQc
         EZD5F8KJJXm96D9vtTAeM5Awxx6XgwrzOwj3Kt1mYgPDUxssMkwh1X7TNUUR/NCeVVWM
         BZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737767869; x=1738372669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ1iea5YhsktktX424CRmZ0XRDfORE2EoXzCszO5etM=;
        b=S2bmdAKQADDJpZQEQfJAj/e32VIkzHavscpo2D/nug5O1OXW9Qf9jynUxpzR3wp6fQ
         i6XqFPzybt4WuULAZfmnSgID+N78vGixXEbNrJoFoA6+jr5FfMdQKzbk5na2TcDB8saz
         ib9LrmCSRPvcgavk2kVlBLxvrao3hHGXdNWEA3suDTA/Is3C5DTiQKK/Fzsh/9bUG2zW
         icFWSunqfUscnYEBNSQUB7iRwKnpdI5HgjFrLiEyd/NERvgemSxgVoCQqzR1lMS0DNrz
         vlxRxUNdXeKWIjLiCh6G0TEdRVMciUn6k/KSXl1Fk4M7n8/0DHdVC6UK5kd3dwX3UWPX
         wnZg==
X-Forwarded-Encrypted: i=1; AJvYcCWk7T9cmOH7M62E/7x1bfTdX5c1XiG0rDC4VyPz5BJOcbsmqIY+07gxIMGjzYYvaQ11Ku08XBj9@vger.kernel.org, AJvYcCXyIDdVQKpnRsJFIQmQZ6ZWACavkNXnOa23nqQUCk6CfSB0d7KYs1xc2pX0GImNVoyasqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP458gz27d0LnD/yWzzOSdzGl5URgjrbfoUmKu/MmRgxCqxiIk
	L0i9f0SQ7I0EVJcGg5y6EVcSU2A6H4CwuXmLa6ZaWkPXHy+dSZTZnVl1DNLmoO90egBnsTR4Mmd
	rPIDitjRJa2ojgFLK5gcayKUhntE=
X-Gm-Gg: ASbGncuw7dTeseqrinAoE75EyN4zgWFNNtw1y1VjNUtL6vHznHVJygCft+7SmC6WK6l
	Uu0czna2fJc6W8Z5aGpn9yzu2SkPydmVxTZRG3UBaqiBRrp++XdTY8XIraKZYSg==
X-Google-Smtp-Source: AGHT+IElya/lcXxf2Ms9ozYLM8wqCjU2fvShP5dT8mWtdRMvuNb8M6RXMNW73Ly/+whuAihuja3a682c2rarNrBaWT0=
X-Received: by 2002:a05:6e02:4810:b0:3cf:b3ab:584d with SMTP id
 e9e14a558f8ab-3cfb3ab58famr93838445ab.13.1737767868891; Fri, 24 Jan 2025
 17:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-8-kerneljasonxing@gmail.com> <46469401-173b-435f-b9d8-fc4cdb1099dc@linux.dev>
In-Reply-To: <46469401-173b-435f-b9d8-fc4cdb1099dc@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:17:12 +0800
X-Gm-Features: AWEUYZn2e86zNTURa0Ijt6hs8nQHpm98wq5XGWk60kQCkPHW9qp2LYQ5xjdpR08
Message-ID: <CAL+tcoAcN8urr4Wuis_x8qsfJ4YTxnsYqDzgER4wVfRZiAm-2A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 07/13] net-timestamp: support sw
 SCM_TSTAMP_SND for bpf extension
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

On Sat, Jan 25, 2025 at 8:41=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/20/25 5:28 PM, Jason Xing wrote:
> > Support SCM_TSTAMP_SND case. Then we will get the software
> > timestamp when the driver is about to send the skb. Later, I
> > will support the hardware timestamp.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/skbuff.h         |  2 +-
> >   include/uapi/linux/bpf.h       |  5 +++++
> >   net/core/skbuff.c              | 10 ++++++++--
> >   tools/include/uapi/linux/bpf.h |  5 +++++
> >   4 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 35c2e864dd4b..de8d3bd311f5 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4569,7 +4569,7 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
> >   static inline void skb_tx_timestamp(struct sk_buff *skb)
> >   {
> >       skb_clone_tx_timestamp(skb);
> > -     if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > +     if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
> >               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAM=
P_SND);
> >   }
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 72f93c6e45c1..a6d761f07f67 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7027,6 +7027,11 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SW_OPT_CB,      /* Called when skb is about to se=
nd
> > +                                      * to the nic when SO_TIMESTAMPIN=
G
>
> Same comment on the "SO_TIMESTAMPING".

Got it. Thanks.

Thanks,
Jason

