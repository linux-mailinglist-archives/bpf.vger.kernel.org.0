Return-Path: <bpf+bounces-51417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2539A34683
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F943B5B00
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3A26B0BA;
	Thu, 13 Feb 2025 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTIKdcm4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754AB5684;
	Thu, 13 Feb 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459363; cv=none; b=qj9hXHqSq7kMtkhW0KPpSQPfOlB4tk03wSb05URdvLrHyYSGX9pFfg+1Y3BJ1zgjCzaLY5rfu7JButVOeMFRvPM2y5QmTYjOhjvCg8j0oOTup5J5uzTqAlYHvPJA1xnad0geVkM6E4nXKN+Od/Zw1+ENiqcEro4nug8UWcpNn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459363; c=relaxed/simple;
	bh=IdZEyjiKkZI/1pqJFXXoSC+azr1RfKtky1xv5mMmHg4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QGVl4cgZ8bP4JzXWbcAKW2RLXyegiQ9X7jTDIPQcw1crbwsY65gzTm4mAFsB0+/Zw5s9MEhQgfoqWxDNIXjEqwq3TqAWHL9MSOw6jXsHb/f/x/6Yx44Mu9ysTEYYqMV5iFGqATfc+5DjyLnNiCCMzU3LNPtFcmtH2cH8z1Gxthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTIKdcm4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so94450085a.1;
        Thu, 13 Feb 2025 07:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739459360; x=1740064160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2dha7925JQRUD+dKqDxU48OayQdmawGC+OQkEXNRWU=;
        b=gTIKdcm4ViPVXwx5o1gfuUfk+PGYBNN5MiN4t9TpGU+/Gi/js+0BQ/03O7l2MPdO7a
         SUVGWNcfQrXkq5ZwPhLPiT743KRz2NQk5cdd8C/kOAswz721fihcUZJSmjTz//VKaG/b
         kkTA/a6f1IuyWMD2BwtKYmFbYq0A464ccU1KFRBluZOSqB+cncVpBx0IQmV6YCnUaSOh
         qGQQwTC2yB4OsPaYvFa11k/Jv70vMAz2cbsS0hrjZPGA/NYY820Myp8Oddt+Eon7Jiz4
         npKPGDUwEpqfbktyHDrCTYA7pHNjvlgwjFSMCd8yQdisjwNiO4hd5A0UMAXR369ATkZ0
         TmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459360; x=1740064160;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B2dha7925JQRUD+dKqDxU48OayQdmawGC+OQkEXNRWU=;
        b=P7hBIvfilKlchLP8SKoEnpR9+OTu8ByX2dO6MsJd9xhGG+VEzCxlVZBkcpbi5StIZS
         s2u/E8iMx3wh3CsXIHU2HZEAlAFC5pm121IZdX6kc34Pr/qsMApQalfrpMgtFI5a0HK6
         nqn9gGB5kkBeTM9tPtbCVOjWufqeIFTTAj68r3GTDh1A7Yh6cn4AeWdMLqKv6/6GoAoa
         ZPSsI4vig5SpDnvtFoYP1CEp5YAS42E26KkGuEU2V0UD/tTU22RtvMpzmqQRayOw6Gh0
         H64tFlswiIUG8ktdDppCKv0Cdz3Bu6jkDQ4gYWJbUPcxAhn6eE27/DtIIorav51nuVqC
         NCxw==
X-Forwarded-Encrypted: i=1; AJvYcCV1BYli5jTsgIACTdN0oXd1L5pBtF4K7dT0dnOHj0dmz+GIWXuspB8dLa0X+Xl1W+SRByo=@vger.kernel.org, AJvYcCVIHtIy30coVPsPai28dfw88LxoTL7Z5FC5r5/YMV4H7qJ76ZBfw/sl8dZqnPhrVHvBLn46TCyY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1q5lFzxyP6BR/DZTqGqOCXm3SffGaScuA8nXnCSMh8RFNGtfG
	j+uXgjFyxI5pgCheCTiaI80BePxtjGhVCMTe2TcG3Y0KLb2iL2GL
X-Gm-Gg: ASbGncvn5NU4oJlDOn8mP0TQ6SIAvlBmw5cT24Dn3zaDaU22zAjXwJV9ttvqqlPEOI/
	dxcR+QGaOxbuqfGk7H/lAoeUXgjIdNaCo/RITDhX7+A3ec0Tt/JyNTPchT4a2xZjD3nW7rI5vEu
	Xph5SOsgCUB9Ugu8Qf2xMhq7TdXejQWaaqwS5/kxR8D1yHvjLQZlScxQq0cyjCP9Tjvxw9/qDOt
	YW4XeHsqfu+QEvxVDdRn4LqatSQmd3x26Lw3x7A153T8k3NmXUsvJpeIkzeXLLdvKAhremOUTeh
	OrwccdZDS8i78v49z1xVhq1mCF46Fg0PXPFMISoDKMBPgns59eZyDSw/1uKKwSU=
X-Google-Smtp-Source: AGHT+IHjOXMgBbY6J+GWiif+HmFmwCJy+rZEzcZlh7LI9fV/MGv+P68o9eEMOZgrM6bupXCReyhRFg==
X-Received: by 2002:a05:620a:4089:b0:7b6:6642:b5f0 with SMTP id af79cd13be357-7c06fc57c9bmr1114129985a.11.1739459359842;
        Thu, 13 Feb 2025 07:09:19 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c6081aasm99412385a.27.2025.02.13.07.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:09:19 -0800 (PST)
Date: Thu, 13 Feb 2025 10:09:18 -0500
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
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67ae0b1ed4a6f_24be4529484@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoA9mi7yfHKf+PGhgjWE0NSrZp44ok+u5v4kOUycSnnbfw@mail.gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-10-kerneljasonxing@gmail.com>
 <67acbdb3be6b5_1bcd3029470@willemb.c.googlers.com.notmuch>
 <CAL+tcoA-5noB0rfHwU=FxANd9yifADFoq-vGkkzW=ZJ=BOnGUA@mail.gmail.com>
 <CAL+tcoA9mi7yfHKf+PGhgjWE0NSrZp44ok+u5v4kOUycSnnbfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB
 callback
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
> On Thu, Feb 13, 2025 at 8:07=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >
> > On Wed, Feb 12, 2025 at 11:26=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > Support the ACK case for bpf timestamping.
> > > >
> > > > Add a new sock_ops callback, BPF_SOCK_OPS_TS_ACK_OPT_CB. This
> > > > callback will occur at the same timestamping point as the user
> > > > space's SCM_TSTAMP_ACK. The BPF program can use it to get the
> > > > same SCM_TSTAMP_ACK timestamp without modifying the user-space
> > > > application.
> > > >
> > > > This patch extends txstamp_ack to two bits: 1 stands for
> > > > SO_TIMESTAMPING mode, 2 bpf extension.
> > > >
> > > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > > ---
> > > >  include/net/tcp.h              | 6 ++++--
> > > >  include/uapi/linux/bpf.h       | 5 +++++
> > > >  net/core/skbuff.c              | 5 ++++-
> > > >  net/dsa/user.c                 | 2 +-
> > > >  net/ipv4/tcp.c                 | 2 +-
> > > >  net/socket.c                   | 2 +-
> > > >  tools/include/uapi/linux/bpf.h | 5 +++++
> > > >  7 files changed, 21 insertions(+), 6 deletions(-)
> > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 0d704bda6c41..aa080f7ccea4 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -488,7 +488,7 @@ static void tcp_tx_timestamp(struct sock *sk,=
 struct sockcm_cookie *sockc)
> > > >
> > > >               sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
> > > >               if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> > > > -                     tcb->txstamp_ack =3D 1;
> > > > +                     tcb->txstamp_ack =3D TSTAMP_ACK_SK;
> > >
> > > Similar to the BPF code, should this by |=3D TSTAMP_ACK_SK?
> > >
> > > Does not matter in practice if the BPF setter can never precede thi=
s.
> >
> > I gave the same thought on this too. We've already fixed the position=

> > and order (of using socket timestamping and bpf timestamping).
> >
> > I have no strong preference. If you insist, I can surely adjust it.
> =

> I updated it in the next version locally :)

Great. I was going to say that I do prefer this.=

