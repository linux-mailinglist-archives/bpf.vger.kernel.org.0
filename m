Return-Path: <bpf+bounces-43354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE389B3FA3
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4824C1F22FB1
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE92AF1D;
	Tue, 29 Oct 2024 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEZ5SmSJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B428E7;
	Tue, 29 Oct 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164724; cv=none; b=Pj2IVCiIygN8IMuMTx//NsI4qyukKd53DeE9VcPdiGdaR2ZKR0Gpr+EyZY3J+i3WiU8NKBjiWwySC8ni2ZFVQZWitOenRbsu7J20Sh+P51vzCrl3iEGLAev8NK3Q5zQRkFvPVGauyjv5dLAvKyIXajnYMdgrEo6QssFvBKXF0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164724; c=relaxed/simple;
	bh=fqZ2SjmZlfs00oVh8h9uul+3bqpuWYEIawLvNYmwBrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8Bfh2d0pOphZaQ0a7lgZcRjANaONEu138XrfB0OaIr7JHpUDH/3cVZHkYN+BOs+8YqEfTH5laQosG5PxdNK5q+6HvmQhN7fDEqenQN1p/YPka2lw/K9Vg+Iogd1Hagg8o6v7PYA65oCS8abci2KR/bkA5m/HDwIS/X7PgisW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEZ5SmSJ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e30bffe3so14015855ab.3;
        Mon, 28 Oct 2024 18:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730164722; x=1730769522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SmkWiVOF8WGh+eCrw7MuFCMJ3H42oYtmYTwYmy1eOA=;
        b=WEZ5SmSJSMMdwXpOe+wOj0gQ+HSFPJe2LGPUS+bKUf0oGy++r/SeEIFp55iK085cah
         6k+J+5I0jc2KyvrZjmtedb0yduIqrgqVGrLhlfExUa5CBE4+cjMDrviZJLleMxkszd/I
         4Hpi6HdONiNnh/VfXzUUxbPMEwNf6LW6xkZU89IzHwwH4pLhOWR2s1jxo1s/B2Bz7Ucz
         vUBtr6h4RImtYIbOi5ehyqX/sptUvDO7+QTzgP4mvXtjt1c204M+RHx+tislk27e7bUN
         x6+7Fkg/tcTeAs8sVq4F+u1VFD2vUytlpLpNiFGY3NmM7JqaD3UNm5b80UrshWVCmbQE
         gMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730164722; x=1730769522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SmkWiVOF8WGh+eCrw7MuFCMJ3H42oYtmYTwYmy1eOA=;
        b=W8XwCX7QIOykUa+DuADcCTahPLnkneJA1bcLi3XH7N1ldavHwU9sGJ8PjPDNj0F5Hh
         igpzm4u8LIMyOqCG0las4+Oi/00FQUL06NTkR8X3d1jX9bBAsKBrK0HSoEtICbqmLO9d
         M/0OpWL7k2w7OhFWQ/p0KVsEnQyNHYgKvLDpxAbjDOIMRa+3FiOWOBiTwa79KVnvylhq
         /wMdrdj3cOjnxywai0SH8+y/Gp+bIp94tTwA2iI4QC46N3EdJFJ3SZfVNlMC4AtDKoi+
         Yk4vfHcLZojVx2cIG5PNczQHlO1V1Zwjp+ISsoe5f+gosCjypUkZUvdv30Npc/KhBYmr
         jUow==
X-Forwarded-Encrypted: i=1; AJvYcCULGOy2FnjMdU92c4kMKai15RAZ1nG4h8p1uJpqlt+3+uJUO6b19SLQHBguDLTIlGe7S3OAnzTb@vger.kernel.org, AJvYcCWJnzpMIQ9vGQ/ROlJJPIljgoWacY4uSS5KSad/CmTD4/jpnf5V/IhJkEVuIPRZizgRw0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf0vWdU4HCxyQuQ8S7WrtG/YCIVE4HX3rgKmtv1/MDe74caBlv
	It6eVbqiyeI2zsNwmZMYyV5w2//WOEEhI+UVCje2YtNm2TQbLECh+JJV7lwuDO8c9UBEFQTeBQd
	eTa+Q40OctRth6q9hG5PXIftPVno=
X-Google-Smtp-Source: AGHT+IF4b52Uk8cGAi9nTW+A6hmwyD+0AXWPUcIt7EAhfETJ03Qq7i/YvrtNH+Ibyyr1gPjY/d+/BWqgfFpLn17ZJ6w=
X-Received: by 2002:a05:6e02:174f:b0:39d:4ef6:b36d with SMTP id
 e9e14a558f8ab-3a4ed27d8d3mr73960385ab.7.1730164721714; Mon, 28 Oct 2024
 18:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-4-kerneljasonxing@gmail.com> <67203358a4016_24dce62942@willemb.c.googlers.com.notmuch>
In-Reply-To: <67203358a4016_24dce62942@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 09:18:05 +0800
Message-ID: <CAL+tcoCFBPmP7oGJSoF=_Vhaw3c7zKft8ooodNgx=S7GmVjqQw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/14] net-timestamp: open gate for bpf_setsockopt/_getsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:59=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > For now, we support bpf_setsockopt to set or clear timestamps flags.
> >
> > Users can use something like this in bpf program to turn on the feature=
:
> > flags =3D SOF_TIMESTAMPING_TX_SCHED;
> > bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags=
));
> > The specific use cases can be seen in the bpf selftest in this series.
> >
> > Later, I will support each flags one by one based on this.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/sock.h              |  4 ++--
> >  include/uapi/linux/net_tstamp.h |  7 +++++++
> >  net/core/filter.c               |  7 +++++--
> >  net/core/sock.c                 | 34 ++++++++++++++++++++++++++-------
> >  net/ipv4/udp.c                  |  2 +-
> >  net/mptcp/sockopt.c             |  2 +-
> >  net/socket.c                    |  2 +-
> >  7 files changed, 44 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 5384f1e49f5c..062f405c744e 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1775,7 +1775,7 @@ static inline void skb_set_owner_edemux(struct sk=
_buff *skb, struct sock *sk)
> >  #endif
> >
> >  int sk_setsockopt(struct sock *sk, int level, int optname,
> > -               sockptr_t optval, unsigned int optlen);
> > +               sockptr_t optval, unsigned int optlen, bool bpf_timetam=
ping);
>
> timestamping, not timetamping

Oh, right...

>
> More importantly, is there perhaps a cleaner way to add a BPF
> setsockopt than to have to update the existing API and all its
> callers?

I've thought about that as well. As you may notice, this version
changes the prior implementation [1] that makes the code more clear
from my perspective.

[1]: https://lore.kernel.org/all/20241012040651.95616-3-kerneljasonxing@gma=
il.com/

The link here didn't support the bpf_setsockopt which requires more
strange modification in sol_socket_sockopt() and return earlier
compared to other uses of SO_xxx. That's why I changed here.

>
> >  int sock_setsockopt(struct socket *sock, int level, int op,
> >                   sockptr_t optval, unsigned int optlen);
> >  int do_sock_setsockopt(struct socket *sock, bool compat, int level,
> > @@ -1784,7 +1784,7 @@ int do_sock_getsockopt(struct socket *sock, bool =
compat, int level,
> >                      int optname, sockptr_t optval, sockptr_t optlen);
> >
> >  int sk_getsockopt(struct sock *sk, int level, int optname,
> > -               sockptr_t optval, sockptr_t optlen);
> > +               sockptr_t optval, sockptr_t optlen, bool bpf_timetampin=
g);
> >  int sock_gettstamp(struct socket *sock, void __user *userstamp,
> >                  bool timeval, bool time32);
> >  struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long he=
ader_len,
> > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_t=
stamp.h
> > index 858339d1c1c4..0696699cf964 100644
> > --- a/include/uapi/linux/net_tstamp.h
> > +++ b/include/uapi/linux/net_tstamp.h
> > @@ -49,6 +49,13 @@ enum {
> >                                        SOF_TIMESTAMPING_TX_SCHED | \
> >                                        SOF_TIMESTAMPING_TX_ACK)
> >
> > +#define SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK (SOF_TIMESTAMPING_SOFTWAR=
E | \
> > +                                           SOF_TIMESTAMPING_TX_SCHED |=
 \
> > +                                           SOF_TIMESTAMPING_TX_SOFTWAR=
E | \
> > +                                           SOF_TIMESTAMPING_TX_ACK | \
> > +                                           SOF_TIMESTAMPING_OPT_ID | \
> > +                                           SOF_TIMESTAMPING_OPT_ID_TCP=
)
> > +
>
> We discussed the subtle distinction between OPT_ID and OPT_ID_TCP before.
>
> Basically, OPT_ID_TCP is a fix for OPT_ID on TCP sockets, and should alwa=
ys be
> passed. On a new API like this one, we can even require this.

Good idea. Will do it. Thanks.

>
> Not super important, only if it does not make the code more complex.

I need to ponder on this point more.

Thanks,
Jason

