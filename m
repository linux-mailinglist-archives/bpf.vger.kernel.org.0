Return-Path: <bpf+bounces-41406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F738996BC0
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFBF1F26CF6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054A197A8F;
	Wed,  9 Oct 2024 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzvRmXox"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476E193417;
	Wed,  9 Oct 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480153; cv=none; b=aYbu5GhvXHePQGEPstTwIpVrwK8RP1C+qFTFK5eptqw6fZiNFnsWTaqzLUiwbIrc57LeV6Rj4senk4rGMNGFHkj02ACfHWPIDXfsIUT/dg6Edmws22DMQWXjDdc+65vwZNNpXC78SJQjoF4KI0GMgnWCsAJTEfxrvTvrifH+Cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480153; c=relaxed/simple;
	bh=c/Ke8cDlAz88Ko+wNmc1PhKLHi97ZVMKhNUuuDBCu/A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=H1YZFpPjfq0CHbSAxyuzW0osnpD+A78a47zsY3OyHl1Bu+Blk2Y9CWbNiSJN4RSpRDbF2KPJbNYSv3FhRhlj1p6to2DAqb+/vwV9ibaRlisfuXqos7M4qYeWR4Fw2Ts5HOcIF4tx52gGYKhmqwhrWhT31cAjdC/6mNvgvLcUcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzvRmXox; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45d8f76eca7so69046441cf.2;
        Wed, 09 Oct 2024 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728480151; x=1729084951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNn4132JGdlb6IgsmTiaZ35isnkVMyU3YX8J61T2h5o=;
        b=WzvRmXoxfUbemhHTRFlC0w1zbhkzYT+An2I9JO4gimOk0k44t39hRIl57PR3xhygwz
         DPGcpZ5qAMs0/XTy6g0dbsHOnVaGAWThL5nCfPHqJ4PT5wn7sZf4w+sFpdNvUbd6aNJc
         jOoIV6gRWzG95T8KbSfd0j1toyQTSG0+1RSQqMV8dhZnUAWaMqR+hWA+3QtOSuNT+Vfz
         8XD4c99UfYMaFlQOXCp8ArjM5UonKRgzgtvKpbSrzL4ORRSCts4ZUZ1HSC1qHsKSi2Js
         HDnx2AzH5wzlDPeNgk5tBq7bMswPb2mlRAvWMUUcmxvklNFnYAU2zLVi6syfsu0k3hqW
         uJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728480151; x=1729084951;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNn4132JGdlb6IgsmTiaZ35isnkVMyU3YX8J61T2h5o=;
        b=HMC6Vg5rNuFd/CrKDpPY5DKmeVfcHVtV9yKZAYdfRCi7CWdt1a5RJA/o1hJVLRuB2V
         xCNLt14Su9LTuErAxi9DMXcJ89DJFxjFUhDC0wE7pKc1KcUbo9P7Q+KtwFDRuea9/EPd
         yB0KcBQW1ljHTco8TPuBYcNMtVCOX36O7lvG/nComSwJySywN8X7lUfAZhjQXzJLJPOI
         bcrBLktOU+JobP8l6H9cvhgkdL7iwJJFhwJ9tXev6Rhogm+24JoZrwzgooc2d5rAmdKf
         1R6F3setlzo+RdMweD3a7BtJmOetwO5YSIWvokHJzqfRPe3QroWYeg6LwGmTbsDfMGwU
         rocQ==
X-Forwarded-Encrypted: i=1; AJvYcCVESbcW/4stvW4PmI+smbGZ0A7spALL6CjelAeE14amiaI+tDQxZAuNim2FSrkDARZTY5+JLsL/@vger.kernel.org, AJvYcCVwhlvSEyonQDE3IPUdYHslhg6h3ROgjuZR8J+sdOd+DMOETvJq5KJbuqCPdxkijrdzp/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+d3PEE/KXMUi9+VYsdx/JBEWmApNaneFb8Yc4b46Q1CeY9Ppz
	xLugGi/ROFcP4riixvfQ5E/I6x0iAU3+n1a5rOe4CKp0KRkqZpu0
X-Google-Smtp-Source: AGHT+IH6VWWMV9xFZXmvX2a2OpfO4zxXiGGzkkRr4dAiQufxsF3RN315juaHLNyr6oR4VCnOzQm0AQ==
X-Received: by 2002:a05:622a:138c:b0:458:2230:a478 with SMTP id d75a77b69052e-45fb0e893fbmr39832141cf.50.1728480150940;
        Wed, 09 Oct 2024 06:22:30 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74b52bdsm46293841cf.18.2024.10.09.06.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:22:30 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:22:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6706839620038_1cca31294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoALeCguB0+HpTq+MHitHZft3drF5OunPh1Qme8XGifiNw@mail.gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-2-kerneljasonxing@gmail.com>
 <67057db07a8c6_1a4199294b6@willemb.c.googlers.com.notmuch>
 <CAL+tcoALeCguB0+HpTq+MHitHZft3drF5OunPh1Qme8XGifiNw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net-timestamp: add bpf infrastructure to
 allow exposing more information later
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Oct 9, 2024 at 2:45=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Implement basic codes so that we later can easily add each tx point=
s.
> > > Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can =
help use
> > > control whether to output or not.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/uapi/linux/bpf.h       |  5 ++++-
> > >  net/core/skbuff.c              | 18 ++++++++++++++++++
> > >  tools/include/uapi/linux/bpf.h |  5 ++++-
> > >  3 files changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index c6cd7c7aeeee..157e139ed6fc 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6900,8 +6900,11 @@ enum {
> > >        * options first before the BPF program does.
> > >        */
> > >       BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> > > +     /* Call bpf when the kernel is generating tx timestamps.
> > > +      */
> > > +     BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG =3D (1<<7),
> > >  /* Mask of all currently supported cb flags */
> > > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
> > >  };
> > >
> > >  /* List of known BPF sock_ops operators.
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 74149dc4ee31..5ff1a91c1204 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -5539,6 +5539,21 @@ void skb_complete_tx_timestamp(struct sk_buf=
f *skb,
> > >  }
> > >  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> > >
> > > +static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
> > > +                           struct skb_shared_hwtstamps *hwtstamps)=

> > > +{
> > > +     struct tcp_sock *tp;
> > > +
> > > +     if (!sk_is_tcp(sk))
> > > +             return false;
> > > +
> > > +     tp =3D tcp_sk(sk);
> > > +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_O=
PT_CB_FLAG))
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > >  void __skb_tstamp_tx(struct sk_buff *orig_skb,
> > >                    const struct sk_buff *ack_skb,
> > >                    struct skb_shared_hwtstamps *hwtstamps,
> > > @@ -5551,6 +5566,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb=
,
> > >       if (!sk)
> > >               return;
> > >
> > > +     if (bpf_skb_tstamp_tx(sk, tstype, hwtstamps))
> > > +             return;
> > > +
> >
> > Eventually, this whole feature could probably be behind a
> > static_branch.
> =

> You want to implement another toggle to control it? But for tx path
> "BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)"
> works as a per-netns toggle. I would like to know what you exactly
> want to do in the next move?

Not another toggle. A static branch that enables the datapath logic
when a BPF program becomes active. See also for instance ipv4_min_ttl.


