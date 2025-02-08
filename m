Return-Path: <bpf+bounces-50877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B28A2D9B0
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 00:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF0D7A383C
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 23:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C01A3159;
	Sat,  8 Feb 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUK8UskV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2D243365;
	Sat,  8 Feb 2025 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739057310; cv=none; b=iSYrbGa+rcJFlk8PoDaeCwXtOrv69Uc7mhOXOiVEn6MuQeX5TqAn/iDInC5CmJAvN8jqhGuHH16zVCKPdK2TKxYh3b+b0xOgbeIyVqJlFzxM5bGDw+Ra6riXKxDmlJQnj0Pd5wWkd9NXE+ock/yyiZyRQpkhnEXqHa44nL8iVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739057310; c=relaxed/simple;
	bh=jWxjVV8684A2QW0epS4hGyRFevaq1yyTQiCg8Isxtrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beudgHhmftRn0I1T0kPvPpgP7Dw/QJnJUaQJNvxUK+aOeS3D4onJr4HOsHhx06L179xLm2Q80Paewt0coNwNWFAEH62dcv5btN2Me3wjOrW+EzCy2fpVIpfIcRgiq44ruH71kpbBRQ9uOuHygtf2QTpFyj6U767yuQSKukifmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUK8UskV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce915a8a25so10939145ab.1;
        Sat, 08 Feb 2025 15:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739057308; x=1739662108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3fgYtTvxcfYk42Zu7/TXX0/KspnUP/i3SaimDsT1Ow=;
        b=WUK8UskVbC1G3qPikZqFJul5QcJqY67kpw8wzDWtdIc6LB+LBYVj9tPc7JqqNh4rdc
         re07bL2XHwWdakGWbJzdTQ2uchJBzkbFHxwrHbHDG6M8zBWpUyMZX4Y20AD0W6JXxMxq
         71X/noIOp6wbeg2HNtHQvPJuCJ6q92CEiQTO/nsHV/9WnGalNv7h9IouS+7VqXPWdZQk
         9m6jncQaAmzR0Z7J0Fw7MuB+RsQAztFxcELb7rrVS/JMsu7Lfn9xwWwvAXrIZC5EcZyp
         xV5Ulc2gQFQcjxXZEgs/bAre53P+2RseQVO8UIIiLRZrldzb4IUcUJv4AX9WVNCw2h2k
         eNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739057308; x=1739662108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3fgYtTvxcfYk42Zu7/TXX0/KspnUP/i3SaimDsT1Ow=;
        b=RNWbZyCb6oLQeIPVIuDg8mFAGq2XLfA8lbqkAJV5UpCWd4TxdMUf04Pu0sbLIyuI9i
         +yX8tvtyhPch3BDQ8BdbHtA3eiQRfBFLq0Kz/djUAwXmOYSdJS6i2a9h/DyOJ9mmT+Bs
         lwjPFfEwOX2NdwodVjYKk3YoptBcreouIU4DAyo3DOSnsI0pTAm3vvfvmB3nn2/MV+sv
         voePEaGmbLf6lMigQQ4C0AlKhfPGZR5XMYYqUL+joIt7mPfU0GAtIDK2htmEzPwOnqLr
         fRwtQV8ispaWCpDQtFg3mairrhfGY+wP2v4mf6ca2f9GAgwM5ucr2cBXzyCSQIOT+6Qn
         KREA==
X-Forwarded-Encrypted: i=1; AJvYcCUlqb1r8IlSKdN9GCePBDB3E8+nahOCngSZYPKmy9sWojhiCGvFD2Ksas77zZeZp06P/jovPRq4@vger.kernel.org, AJvYcCXm9nrkoWuBH8ZQUZ+MIlmQ7j6IDRlQFgCFIaT9YIJ29gts1TI6/CWsDrdrbqawEW8keJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvgmOV+XBHYL04bFCq/lJ2Q4KiG47ZmI/FAKhABIk0ytWBXfIO
	qtXtSEHaJIvJkeO/Hfd6CRZAsrsut4YL//UzJRrqiQC76EQyeTpRvmM6coPA4FS3U14c6lSMQFo
	BXR10D5MVOijxeO0ysb3WOXxtMWE=
X-Gm-Gg: ASbGnctzk8Q2k5RdSvKDk1XNVHPOAna6UaKC59021BG0QnZkrQ2yVupqdARtrPCjfWM
	x4TOeYAARRCk7L5f7TTkKUzkBFdet6uWiOHsMxWSDoVkUs9yy80VGF6b7btJ8P/Dt7fL4Ijw=
X-Google-Smtp-Source: AGHT+IFnFWrdf6FSHM1hnjMLutfoeG1Sm/AaHIZAiLseIfsQzqgLZ7Tr4pgerS5CsYCN869E9NLT1ylDpRh8n34iuzA=
X-Received: by 2002:a05:6e02:20c9:b0:3d0:4700:db0b with SMTP id
 e9e14a558f8ab-3d13dcfcc49mr85186595ab.2.1739057308090; Sat, 08 Feb 2025
 15:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-10-kerneljasonxing@gmail.com> <67a79a3f9c7ed_3488ef294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a79a3f9c7ed_3488ef294cf@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 9 Feb 2025 07:27:52 +0800
X-Gm-Features: AWEUYZl9BiwH9glABE6iSctfNeulbtM0OPJZurgnxNoIiCy_1KckSMS92BudzPw
Message-ID: <CAL+tcoCdimG6A8eJgOeterDmKM6by6k8_Jro1p6t6BPtVq-psA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 09/12] bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 1:54=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Support the ACK timestamp case. Extend txstamp_ack to two bits:
> > 1 stands for SO_TIMESTAMPING mode, 2 bpf extension. The latter
> > will be used later.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/net/tcp.h              | 4 ++--
> >  include/uapi/linux/bpf.h       | 5 +++++
> >  net/core/skbuff.c              | 5 ++++-
> >  tools/include/uapi/linux/bpf.h | 5 +++++
> >  4 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4c4dca59352b..ef30f3605e04 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -958,10 +958,10 @@ struct tcp_skb_cb {
> >
> >       __u8            sacked;         /* State flags for SACK.        *=
/
> >       __u8            ip_dsfield;     /* IPv4 tos or IPv6 dsfield     *=
/
> > -     __u8            txstamp_ack:1,  /* Record TX timestamp for ack? *=
/
> > +     __u8            txstamp_ack:2,  /* Record TX timestamp for ack? *=
/
> >                       eor:1,          /* Is skb MSG_EOR marked? */
> >                       has_rxtstamp:1, /* SKB has a RX timestamp       *=
/
> > -                     unused:5;
> > +                     unused:4;
> >       __u32           ack_seq;        /* Sequence number ACK'd        *=
/
> >       union {
> >               struct {
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index e71a9b53e7bc..c04e788125a7 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7044,6 +7044,11 @@ enum {
> >                                        * SK_BPF_CB_TX_TIMESTAMPING feat=
ure
> >                                        * is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_ACK_OPT_CB,     /* Called when all the skbs in th=
e
> > +                                      * same sendmsg call are acked
> > +                                      * when SK_BPF_CB_TX_TIMESTAMPING
> > +                                      * feature is on.
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index ca1ba4252ca5..c0f4d6f6583d 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5549,7 +5549,7 @@ static bool skb_tstamp_tx_report_so_timestamping(=
struct sk_buff *skb,
> >               return skb_shinfo(skb)->tx_flags & (sw ? SKBTX_SW_TSTAMP =
:
> >                                                   SKBTX_HW_TSTAMP_NOBPF=
);
> >       case SCM_TSTAMP_ACK:
> > -             return TCP_SKB_CB(skb)->txstamp_ack;
> > +             return TCP_SKB_CB(skb)->txstamp_ack =3D=3D 1;
>
> For the two to coexist, this should be txstamp_ack & 1
>
> And in the patch that introduces the BPF bit, txstamp_ack |=3D 2, rather =
than txstamp_ack =3D 2.
>
> And let's define labels rather than use constants directly:
>
>   #define TSTAMP_ACK_SK  0x1
>   #define TSTAMP_ACK_BPF 0x2

Thanks. Will do it.

