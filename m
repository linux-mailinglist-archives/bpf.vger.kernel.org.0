Return-Path: <bpf+bounces-48882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B93A115EF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE3A188B25D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2286AA1;
	Wed, 15 Jan 2025 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYrxGETK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300473C0B;
	Wed, 15 Jan 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899822; cv=none; b=SPLfqGI7UayLgIxDkAGV3tVt6Z5R+KOyN83qbkoc84g1gO9wsn8jFwytmIAHsuMjdsJmN06rtLsGWQkcH8hh9dUJLkwE8GkRJ4Nk5m8hSAQ/Ljg4Nj95AcxcXYqchFN5xr2xSqoPC72CcSOhhiesYusmJ91q1lFzp3GEkPDts0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899822; c=relaxed/simple;
	bh=lE1KwuDePLZVKDgzZ+fLRrndQsvCUCVTMdZhwvKLz7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYE1nd1m4T5sLJ82B7Ngjf94yq9kSINoNqqQX6P88GnfcJ3naYMIAENA7d1chGbvHcPmHfeHiQaU+VnY6NrVcV9dSenVoQNgQI/++m4f2IOqTzQXK/KOmQstCNuvk1VlLdMOW6zqPkkpepuWMIb5338X1UXPOCis46KRU+iSmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYrxGETK; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso491460739f.3;
        Tue, 14 Jan 2025 16:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736899820; x=1737504620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xitBzScUg6K7D96JvxPq7TBfu/HvZJElknDnLqjuP2U=;
        b=YYrxGETKbSmOONPGApObf+E8IY2G8EJiAoWAuAUr+uja5+OwL9R2XRXUb+ycDEs234
         azkdGK26dU2z5+ApcRk78o3LFBgixP8IK4bxKMuxDs+6S+9xeBbW5DKPwCLPOJJb0q3C
         5HjKgAJY5wfIvpxs3Tc7c3Kd0getgeKHL49mjRRUYxP6vGfeKIca0xnQL0YPKu0K2P0L
         VwpdKjhh/nVVkmNhQnYPQp1ZA5YrcxH/CeUbMQrV+JalyBPl5dTfaP4xMB6f1HawBbz/
         nLDh7qbKFeBlQ00ElaLhgiDbCZ1z9TJuwwNcclPViCNE1Ds/Y6/PhPlmF3f1srj98WjW
         5miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736899820; x=1737504620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xitBzScUg6K7D96JvxPq7TBfu/HvZJElknDnLqjuP2U=;
        b=rrymC/FJsIUpRvlVPlm6S8aNsK4H/ZWEF62FriFf0OPec+hBGiK4FTyOCt4EUQhxtF
         5mK181lCSUgJuNxVxI9icBOpnxlr2lRLBSIqaUhjuc5Hc4+OCT1b0dsp58QOHRDsvPKH
         39tjJd8o09zHtqitdmzH8oEZte9DaEGScLAGybpKGCoWF7u3w04ZTraPPjBrGMVoqXOO
         IYV/cLmilKEuXYLAPIto4iy9kBdJArFGxj9q5ImVxAH6tMHbOmsN/eHqH+qFi0ElKqjv
         nHQY/svF5Z7nuA5sH1FigDmgHfhLitVo56nFASS64S557fBtv+Mm3sTRxPFFfQgQjHW9
         N/dg==
X-Forwarded-Encrypted: i=1; AJvYcCWq4a5ClEIeUDV2EM8AoHPuOA8AHUZtks1KAM2fEeyk2FN8zuQFSvk50k7s/C+1PJBUNJk=@vger.kernel.org, AJvYcCXOGKQ299IRJGqWDaaQKlBqYSyl49OAWlJ1TK0D2oi5fStGEcMAMbPX4pq7Auu69px7UtL/pSIQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2U6hJPNzWddHq5dwyXpdcjZcVJvU3YUd0jtbuWlcTpBGugDKg
	775XJMmWAypIBSwBZouivzWtMv0vfwY1B2d92pMyoJYAny4sq+hWgL0TjIUaSeFl4aoSzUu+AHu
	MrpI90eJWAzCn9GU2Ar0ZJQEIwPs=
X-Gm-Gg: ASbGnctArl6pT7A4mXYRhGf7iip+Lr8tAG0Aynw59PEWXo9yUQ2JOJa5Pq8ic9GBTAX
	+X0n3du1wje4MaU024in9w69A7Ws4IpTVKTyq
X-Google-Smtp-Source: AGHT+IHoOWQbnUKZnlJCmxC6LXwHbos3UgbusPuscy6t7QbRNxhOMhLnxtB5DWYmGIDjUH9HGjej8Cxfzx50Gl90yK4=
X-Received: by 2002:a05:6e02:1807:b0:3ce:8031:3e with SMTP id
 e9e14a558f8ab-3ce803103f8mr22938155ab.16.1736899820139; Tue, 14 Jan 2025
 16:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-3-kerneljasonxing@gmail.com> <5480eedb-ceb0-402e-883b-da4207dcc43d@linux.dev>
In-Reply-To: <5480eedb-ceb0-402e-883b-da4207dcc43d@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jan 2025 08:09:43 +0800
X-Gm-Features: AbW1kvZkuL0_oZpVIcReJk5oU-k5K-a3rQCyhNWMEWwAjZUSVasdF7Ssdjv2dbs
Message-ID: <CAL+tcoCn_u_tgYuGbKqp9n1fqao_Yi0ogO8HFcA2TcQcHJOa2w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/15] net-timestamp: prepare for bpf prog use
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

On Wed, Jan 15, 2025 at 7:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > Later, I would introduce three points to report some information
> > to user space based on this.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/net/sock.h |  7 +++++++
> >   net/core/sock.c    | 14 ++++++++++++++
> >   2 files changed, 21 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index f5447b4b78fd..dd874e8337c0 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2930,6 +2930,13 @@ int sock_set_timestamping(struct sock *sk, int o=
ptname,
> >                         struct so_timestamping timestamping);
> >
> >   void sock_enable_timestamps(struct sock *sk);
> > +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op);
> > +#else
> > +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct s=
k_buff *skb, int op)
> > +{
> > +}
> > +#endif
> >   void sock_no_linger(struct sock *sk);
> >   void sock_set_keepalive(struct sock *sk);
> >   void sock_set_priority(struct sock *sk, u32 priority);
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index eae2ae70a2e0..e06bcafb1b2d 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int opt=
name,
> >       return 0;
> >   }
> >
> > +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, i=
nt op)
> > +{
> > +     struct bpf_sock_ops_kern sock_ops;
> > +
> > +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > +     sock_ops.op =3D op;
> > +     if (sk_is_tcp(sk) && sk_fullsock(sk))
> > +             sock_ops.is_fullsock =3D 1;
> > +     sock_ops.sk =3D sk;
> > +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
>
> hmm... I think I have already mentioned it in the earlier revision
> (https://lore.kernel.org/bpf/f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux.d=
ev/).

Right, sorry, but I deleted it intentionally.

>
> __cgroup_bpf_run_filter_sock_ops(sk, ...) requires sk to be fullsock.

Well, I don't understand it, BPF_CGROUP_RUN_PROG_SOCK_OPS_SK() don't
need to check whether it is fullsock or not.

> Take a look at how BPF_CGROUP_RUN_PROG_SOCK_OPS does it.
> sk_to_full_sk() is used to get back the listener. For other mini socks,
> it needs to skip calling the cgroup bpf prog. I still don't understand
> why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot be used here because of udp.

Sorry, I got lost here. BPF_CGROUP_RUN_PROG_SOCK_OPS cannot support
udp, right? And I think we've discussed that we have to get rid of the
limitation of fullsock.

Thanks,
Jason

