Return-Path: <bpf+bounces-63084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5ADB02427
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFCF5A6424
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FDC21C187;
	Fri, 11 Jul 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8I3mVFU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0941D54E9
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259965; cv=none; b=WZ2iBgP+NdK/V43NLWs4ybuTWLi93RBmuCETlp/ZAk9NbLWCPFHZa8pGygvqUx/3J1L68yKyS5WDWIXxUk8ozRy+yGVbtAwLVvLi7p/EEkqSB+nzFCJzb3GnZxHHBQk3ghGON4zLUPdbNz8dM18jmLf8mY+023uurWaEOzeMUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259965; c=relaxed/simple;
	bh=FgO8+6mw4LcxYU3Qq9PfCWwmVZRCZAr3R1R6+sgCpHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS7iMpREdthb0I5FnfblaRQDDpDy6SpaxYGtVVfLrKW2FhSS5LyC5ppy9O0XGz70DzxqBhypiaphmN7wnWdwQlfNHJVdooOBx+lhEDrnzUnqRbMBJqyC2WLTg8clE2MLTT7anmuX/bWoEPvVrOPxXbn5wP7P3ky5W8W3lD0DVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8I3mVFU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso2160168a91.3
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752259962; x=1752864762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP8U9mzDf4+ujsEIWssteANODLDvT07NsXTpT2EYXgQ=;
        b=A8I3mVFUPNNBi7Un0kBczeC54p2EiW7qQ/i9U248OsDLCxqcQost0Vyds/QsihZP+U
         V4i0m2ja3KpVZiDlLV1T+FWLgcSVZRb4pCjxl1F8F8spe9iB1fqE9UKbcsiE/3BoQNRJ
         +7+yrBGuqAq7XzW5H8CNYKm6PnYKQ1wsTVax57A+te/qEy5Q8MZo8ne3vp1Iz36F1iWv
         1HvRk7T6f2D7Lkz+tS4YVPqcyRG47A0T0NU0LC+9+KgeGduhXdOnlVPpt4kRgcdGCOrc
         dqqLYwRpRzflop64f1shaMZL4Llki6hmDEcHXf6Dq6xBN56ER01jB/ZPMeZPBYYUPW0Q
         dxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259962; x=1752864762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP8U9mzDf4+ujsEIWssteANODLDvT07NsXTpT2EYXgQ=;
        b=R1ozrHMBy/1g4stTaLl/QypkKiGc8g4bpTlxkZS9bv2gZqujh3g7Rh9PgXO2bwyDus
         8hEKCcNtzvPDb2HLp6K78dRVimRSR0BCxN14j+SmFqNlhcQYcSALsMSnNS73YxKxU/B+
         fMlfRb3kZdhSrsCUtVhG5V47sHS6bZQVsn67cnZtYSF2PN4bMoC2q3yGplQDKv5c2dlT
         WCcbE1FJM0nSTKIWfsWNOgIDeju3L/CFk5+/q66stMrV3NZa8BMXFrPgFRaSAaR+ip6o
         PiYuX0vLbs73E/2UHFKqvDeoLsbx7PyyR6s4y7pBd6zWTiZTBPQf4R5el5uObZoHf/XX
         S3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxA3mbcv0rBKrxUpu23IJZTmqG3E329Hqnc22O5ybUnVOuxC1G/m2dJH7gKwnCOcZ27eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSPYyHMWqiQprqhsFBHz86pjywjVOqEscYc4SJx5HsbyVDmc3
	r0hV9gjfsbhiiR961JuG9KnRyFSqrvzOFh835YhlHnE2JpXj/ihp834+2oQ/ENdfo4ZJ5QamGpT
	J3dmFatY3+ssRS/ZjwFWBrNNUyksNeXS8dQZfx8OU
X-Gm-Gg: ASbGncu0uxLkyaWQSNh86X3mPNHcIK8q9RpGmbayhLCoY79T6DfsRBrgLCCWiIgg/rG
	7kPDC1d9eaDjISrXrAEjNjn0dWiuQxCxyuAurnAW2SJHsElcXaOoJTVTFsPk+nXnzn7Gep58pb4
	/87KNFu3YIkVp2y0qjdDQ1BcGWCU9gVqmJXF+qzwq632MUYnxp18ZZbXHHUEsd8YZynoD8kSI5W
	coOCMhb1CQMVQAym/JSwrlCcH4RiDOHRW5F9Nau
X-Google-Smtp-Source: AGHT+IHrEDnOffqYX8FSYBmVipsZ+V6Z707TuWhwo3myW/DtH+IVRwmy0raCym18aGi/vMFswgY2AePUfxIaYOb/RyI=
X-Received: by 2002:a17:90a:d407:b0:311:c939:c848 with SMTP id
 98e67ed59e1d1-31c4f381335mr6060252a91.0.1752259961500; Fri, 11 Jul 2025
 11:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-sockmap-splice-v3-0-b23f345a67fc@datadoghq.com>
 <20250709-sockmap-splice-v3-1-b23f345a67fc@datadoghq.com> <20250711172711.qe2tgvwckswzgedh@gmail.com>
 <CAAVpQUBjwcpDYAafhoVA9jch5M0WVu3eUudnr3w5S=bjgDaXbQ@mail.gmail.com>
In-Reply-To: <CAAVpQUBjwcpDYAafhoVA9jch5M0WVu3eUudnr3w5S=bjgDaXbQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 11 Jul 2025 11:52:30 -0700
X-Gm-Features: Ac12FXxyFc-HNk5ZolRXtLUUHEctFdoTaz9BQGsJ09fFTaB_poPwBcth3e2CvkQ
Message-ID: <CAAVpQUA7i+DWR4+We=aO5x08yDHc1he96K0MywcSXaH0_44S1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] net: Add splice_read to prot
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, vincent.whitchurch@datadoghq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Fixed up Vincent's address as John's and my reply seems not to be deliver=
ed. ]

On Fri, Jul 11, 2025 at 11:48=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Fri, Jul 11, 2025 at 10:27=E2=80=AFAM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > On 2025-07-09 14:47:57, Vincent Whitchurch via B4 Relay wrote:
> > > From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> > >
> > > The TCP BPF code will need to override splice_read(), so add it to pr=
ot.
> > >
> > > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
> > > ---
> > >  include/net/inet_common.h |  3 +++
> > >  include/net/sock.h        |  3 +++
> > >  net/ipv4/af_inet.c        | 13 ++++++++++++-
> > >  net/ipv4/tcp_ipv4.c       |  1 +
> > >  net/ipv6/af_inet6.c       |  2 +-
> > >  net/ipv6/tcp_ipv6.c       |  1 +
> > >  6 files changed, 21 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/net/inet_common.h b/include/net/inet_common.h
> > > index c17a6585d0b0..2a6480d0d575 100644
> > > --- a/include/net/inet_common.h
> > > +++ b/include/net/inet_common.h
> > > @@ -35,6 +35,9 @@ void __inet_accept(struct socket *sock, struct sock=
et *newsock,
> > >                  struct sock *newsk);
> > >  int inet_send_prepare(struct sock *sk);
> > >  int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t siz=
e);
> > > +ssize_t inet_splice_read(struct socket *sk, loff_t *ppos,
> > > +                      struct pipe_inode_info *pipe, size_t len,
> > > +                      unsigned int flags);
> > >  void inet_splice_eof(struct socket *sock);
> > >  int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t siz=
e,
> > >                int flags);
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 4c37015b7cf7..4bdebcbcca38 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -1280,6 +1280,9 @@ struct proto {
> > >                                          size_t len);
> > >       int                     (*recvmsg)(struct sock *sk, struct msgh=
dr *msg,
> > >                                          size_t len, int flags, int *=
addr_len);
> > > +     ssize_t                 (*splice_read)(struct socket *sock,  lo=
ff_t *ppos,
> > > +                                            struct pipe_inode_info *=
pipe, size_t len,
> > > +                                            unsigned int flags);
> > >       void                    (*splice_eof)(struct socket *sock);
> > >       int                     (*bind)(struct sock *sk,
> > >                                       struct sockaddr *addr, int addr=
_len);
> > > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > > index 76e38092cd8a..9c521d252f66 100644
> > > --- a/net/ipv4/af_inet.c
> > > +++ b/net/ipv4/af_inet.c
> > > @@ -868,6 +868,17 @@ void inet_splice_eof(struct socket *sock)
> > >  }
> > >  EXPORT_SYMBOL_GPL(inet_splice_eof);
> > >
> > > +ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
> > > +                      struct pipe_inode_info *pipe, size_t len,
> > > +                      unsigned int flags)
> > > +{
> > > +     struct sock *sk =3D sock->sk;
> > > +
> > > +     return INDIRECT_CALL_1(sk->sk_prot->splice_read, tcp_splice_rea=
d, sock,
> > > +                            ppos, pipe, len, flags);
> > > +}
> >
> > Could we do a indirect_call_2 here?  something like this?
> >
> >   INDIRECT_CALL_2(sk->sk_prot->splice_read, tcp_splice_read ...
> >
> > Otherwise the series looks reasonable to me.
>
> What's the second candidate ?
> I think we should specify the built-in one and cannot use bpf one.

