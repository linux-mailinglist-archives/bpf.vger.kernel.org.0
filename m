Return-Path: <bpf+bounces-51327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FCA333CE
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 01:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567B4166E50
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077252F44;
	Thu, 13 Feb 2025 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxriRjKa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DB1372;
	Thu, 13 Feb 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405278; cv=none; b=BCbWHREBKH9mv07sZkGNuLItgge6VAFzN8g7JbDawiNBxJNZoy1IMWLGIMcMnd0qAgJ90fEO2xmZTJdmXOsIolCTBxAHgpnY2kBtUo1bUEw0YL/4tL8xFBgt4QQxBDEQwoFJvX3rXQ0X0DAbyWEiNdI+pt6Rito9Tnj1zv8jhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405278; c=relaxed/simple;
	bh=NMznk1UMIYoDm+rJ4hNUbPeS0XxK2OH3LPJoLq98XJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDoCoJ3vFyolzHiA9UuXLf5aQX1eb9wC1X7fsvTPHaeUdV6nrICZ/LfaUEq4J9BQ/Kf9QMJKA0UplvfzsxBOlGJRkdywSwq+Pmo0288O+o0h9SuS5lERDh8O4UhdZ/AwBuP1jxJyx/sM56bJT+Wj9/iNqIHohgDO/89CD6DKtsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxriRjKa; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso767365ab.1;
        Wed, 12 Feb 2025 16:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739405276; x=1740010076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPtlUBpGwdFfdn1u7pzV8qzAKEZ9WNRoW9pxUkJsTYo=;
        b=TxriRjKacsgCIfuR21YYMxKyEAUP95RDVsr8/SDauXLhXbRMtsvVcOhdodZR8QrnaI
         zniUmAnM4hF4xuYYLt/1BWQo+gMLu6qe7FaBwMWPk3FkeLivsiO9wMS8HDrh52x9YwXg
         BtVcBDYe7S3Vv7M+iSTVBb/93CT4Sd0YcXupcGiai9tBg5RNnxITHF4vcDH2/KfKd0K/
         VbpNhg8BJp5ePxi6kDybs+cagpb2cB1dkiIBkTlnkF7eU/meFD9xCsA/cAAyxfwl4PJy
         B3bOm+Tc5AxcGNYrsmbsGOc0TyIqwRrxyeuK5vroCbyvu/xeLmIm3yLguob9yDmY3qqN
         TgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739405276; x=1740010076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPtlUBpGwdFfdn1u7pzV8qzAKEZ9WNRoW9pxUkJsTYo=;
        b=isdZ+Nj4I9Aop/BnodJUSIDo+q/tlUCiO4fOvZ385R/K+nzLQ8QQKhQnxU5YOGqWlT
         BhZKTAG2vqSFsZKW7K57kzV6TGa9EWmEcqRp6RGfvxGBx1OK4O8nMGIawvvdQ8zapMfd
         eBgMvvItLWenV+VQ4MqzdU1LMTVWQPbwZ2JJ8v97f1zUGLU3BO7fXmC5T12/nbt8iCXD
         Oh+DnAKF3N5IO5B7oYesSnNNVtTJiYjNYN0+8Ybn13NaENlATtegYS08sEMVYVxPOUuJ
         JFGYUA8KvZHLzeSSevbCPP5jAOdCRCq/lyzb2KZLfw8dfSUZQZtUL/HmjQyjPUUnFWo5
         ts6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJloNfDMhdYTbsZ0tE8TiFA/qyp4dUH97QY9gNz2EjfOsqFIj5SrF/7Cc60PJa7HI6NCg=@vger.kernel.org, AJvYcCWLYw1314OdlK82QBDhnj5n0UO5KT8uE548PVxct2tlNmC61NS8SBp/2rPOMvz8+OZnPjXj9JSa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LW0qcl55bGWy9P/vgQdf7E+BEr3oY0kyeKIxNZNhUgQ6d5kt
	nQ+G4GQz96Gbdg++DXa9lP7AvAQYhNfu9/H/HXFDbT6vR21EtQ3ROayVqVEBXdFOOrbVhkBFDbI
	ah5Ebzf7XEuWpvlx8wRMtcYRvxAA=
X-Gm-Gg: ASbGnctp0NCEHN77S/IPnLWAwo20gTSC9NBl2dHevbKLbkkN7ZrW1HcvfbvmZ6E0uNd
	PxKuZ9ifmDaBTIEVPx/s0aq9aVZGiV4xhvVNO/Upc+D1hAt3sQiLEsjrq+MHf9xltSW8mgoQz
X-Google-Smtp-Source: AGHT+IHne9nz+OCdlWoZXbFkEtWu2p2Eal1UmAvAlfjwRnsUHHvMH3ndvO+Mgvv98hoMOIK3hhKovKvjxAKrVLSatwg=
X-Received: by 2002:a92:ca48:0:b0:3d1:883c:6e84 with SMTP id
 e9e14a558f8ab-3d18c22f15bmr10433845ab.8.1739405276074; Wed, 12 Feb 2025
 16:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-10-kerneljasonxing@gmail.com> <67acbdb3be6b5_1bcd3029470@willemb.c.googlers.com.notmuch>
In-Reply-To: <67acbdb3be6b5_1bcd3029470@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 08:07:19 +0800
X-Gm-Features: AWEUYZlspLNXaO0uwKv0r8brZNX60ofeF66Vz1uXYdOosE6utUXFgpmJXSy5A74
Message-ID: <CAL+tcoA-5noB0rfHwU=FxANd9yifADFoq-vGkkzW=ZJ=BOnGUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:26=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Support the ACK case for bpf timestamping.
> >
> > Add a new sock_ops callback, BPF_SOCK_OPS_TS_ACK_OPT_CB. This
> > callback will occur at the same timestamping point as the user
> > space's SCM_TSTAMP_ACK. The BPF program can use it to get the
> > same SCM_TSTAMP_ACK timestamp without modifying the user-space
> > application.
> >
> > This patch extends txstamp_ack to two bits: 1 stands for
> > SO_TIMESTAMPING mode, 2 bpf extension.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/net/tcp.h              | 6 ++++--
> >  include/uapi/linux/bpf.h       | 5 +++++
> >  net/core/skbuff.c              | 5 ++++-
> >  net/dsa/user.c                 | 2 +-
> >  net/ipv4/tcp.c                 | 2 +-
> >  net/socket.c                   | 2 +-
> >  tools/include/uapi/linux/bpf.h | 5 +++++
> >  7 files changed, 21 insertions(+), 6 deletions(-)
>
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 0d704bda6c41..aa080f7ccea4 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -488,7 +488,7 @@ static void tcp_tx_timestamp(struct sock *sk, struc=
t sockcm_cookie *sockc)
> >
> >               sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
> >               if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> > -                     tcb->txstamp_ack =3D 1;
> > +                     tcb->txstamp_ack =3D TSTAMP_ACK_SK;
>
> Similar to the BPF code, should this by |=3D TSTAMP_ACK_SK?
>
> Does not matter in practice if the BPF setter can never precede this.

I gave the same thought on this too. We've already fixed the position
and order (of using socket timestamping and bpf timestamping).

I have no strong preference. If you insist, I can surely adjust it.

Thanks,
Jason

