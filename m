Return-Path: <bpf+bounces-48883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D020A115F9
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0361696E9
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C8DF58;
	Wed, 15 Jan 2025 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jra48Jri"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8E2111;
	Wed, 15 Jan 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900184; cv=none; b=N7qOOHripfLDJdcr9C0hzZZinJtlVEvUVXkhm6VBwgiNE9ozIQVchABef574dvvZEbUCJtEbpgFzXe/yIkFumgH6eS99JIvgd+Rps5nHqiXU4lQx1uHGf8jKiu4uf753HJyPv3SsJF8LyzhIfh8YR8TfUxcLLchNiSdkbXMWahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900184; c=relaxed/simple;
	bh=mPo+/oOvlFyQuWCw3og15qRmXUxv0eKXLWVL4xbX8ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STEVPyDtTyZm5as0URiDclH0IkjRq/esq0/SR5w9VhmxB6PPgRgJJLjyH85d/qjSYmU6bmT/B36WOYgOcJeSu6mC1tzKuz1byS8s+2kb9aR3ShS3gHD3XMY5hC31YV6ZIJU8rFRtZYVm1WCyHzRH4/LO2Kb/DaGGWgUSef2IclM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jra48Jri; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so39867465ab.2;
        Tue, 14 Jan 2025 16:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736900182; x=1737504982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CehTYo/6R4eE/OJYAuUTmzM0epgCDw615CEkeOpyTM=;
        b=Jra48Jri7AKbdiwvoNLTRhxARpv5JHkoXJw8k2vZ1feojKdeeu+h+LuLaMwH8khFv6
         SC4iVkBpVJ0TGEUwR4uYHGpZvzu9M9cXp9oTShWQvUwbB29yAlOY5KEzcxudda6nbvOq
         GDjmY37GhKHsONoUFoU/5CyDz9OL21FZ3TEJEhEYYsfL8qO/dv+H+93vwle+nhw+aC8P
         sEzfuZyxI8pdMTer6C/TxVmYxossS30pu40wgsb/6Lmiyx76unaESFwfoyWBWK4LzACd
         /L+Uc3cOjLbAwVL+Vw3Ff0qJ1tcVKkWjuyVcMCK9NQPrToy2WbsftfUtJ9iUgSX+PyDy
         f0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736900182; x=1737504982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CehTYo/6R4eE/OJYAuUTmzM0epgCDw615CEkeOpyTM=;
        b=TBqqpgGFYEjscksxyf5jXq+mryvAxyfeQLxhm89QIkp8WfmEPz8Uhbt+2l6pieoymK
         oUGQ4zQWDmFolw0ShW3ICfW4p0YxUB5YyLrXTXo4hBZH63Y56MsptPPued4PdedDwBAJ
         YqhZd3Vs0YlNCV8Nw/O4Q1cVPQBBGuLx27LSfPHXUNP7XIikqUMKt7Y2HNcEWHPsSkzG
         fYtIJRmmwbxhLrbV1hDd/VXzMSKp92IU3kV9gcpKnN/rXy+9QbfiulxPUlMqoLCIvkbX
         jUg/eyBxfipDgLp1MWPQvbw8VzxOnBoM7XwJkmYFDDPsQBW6lp4HB86f6AJbDl0WDQJ/
         SMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWA00JzMBvR5uhKTLcAsOyBemkUv76EKV2HOYZBOPm/MtsgHb1dHUsTRRPneIE1aeQdlw=@vger.kernel.org, AJvYcCXvKVBedBtX5unftSAjivyS2g/LGUH2MbmkgaSB8cuf46aN1DonRh/0PERQlMYSEsBL1eWgcz6F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx40x5wr6Kk+32Np3uH0SnypJJ79duQVTREQZmcup3U8VaoawxG
	zZp4RlxyTlC9zbUOzZj0c2BQO2sFcLAhQIU45XW5rtPxIcKFj0vbzErO+c2ANSznRfWYcOAmmlh
	u8f9EWlLyWX1ThFP4KptUHKnkX3s=
X-Gm-Gg: ASbGncuD3pq+Icr4032ZggMI7LKNe4Lp9LzAKaVIlx1cMD4n4No2lnDmk2NYt2K6iIJ
	SYoBgafs2MQTDilevlenGufB5vwbNJ+Wfcnx2
X-Google-Smtp-Source: AGHT+IGIQFolkloq9iqrz1sLSukAkkBT3KZl4sjWbKpnu1jAFZpkxqE3AokrGTu+jssKbs/SGgvBxYcD8C52sGcsOHU=
X-Received: by 2002:a05:6e02:1c8d:b0:3a7:e0c0:5f25 with SMTP id
 e9e14a558f8ab-3ce3a9a477fmr232036535ab.4.1736900181875; Tue, 14 Jan 2025
 16:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-3-kerneljasonxing@gmail.com> <5480eedb-ceb0-402e-883b-da4207dcc43d@linux.dev>
 <CAL+tcoCn_u_tgYuGbKqp9n1fqao_Yi0ogO8HFcA2TcQcHJOa2w@mail.gmail.com>
In-Reply-To: <CAL+tcoCn_u_tgYuGbKqp9n1fqao_Yi0ogO8HFcA2TcQcHJOa2w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jan 2025 08:15:45 +0800
X-Gm-Features: AbW1kvYf7gfwbtbAp-djfCrQ_fasQcCU1AkhEGcZQSEuHqRKN9S7suFJt3aGwKo
Message-ID: <CAL+tcoA2+MO4WgzHHnX1hhCaQs6afmXWoOXNKf7wrz3QZVeeyA@mail.gmail.com>
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

On Wed, Jan 15, 2025 at 8:09=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Jan 15, 2025 at 7:40=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 1/12/25 3:37 AM, Jason Xing wrote:
> > > Later, I would introduce three points to report some information
> > > to user space based on this.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >   include/net/sock.h |  7 +++++++
> > >   net/core/sock.c    | 14 ++++++++++++++
> > >   2 files changed, 21 insertions(+)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index f5447b4b78fd..dd874e8337c0 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -2930,6 +2930,13 @@ int sock_set_timestamping(struct sock *sk, int=
 optname,
> > >                         struct so_timestamping timestamping);
> > >
> > >   void sock_enable_timestamps(struct sock *sk);
> > > +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb,=
 int op);
> > > +#else
> > > +static inline void bpf_skops_tx_timestamping(struct sock *sk, struct=
 sk_buff *skb, int op)
> > > +{
> > > +}
> > > +#endif
> > >   void sock_no_linger(struct sock *sk);
> > >   void sock_set_keepalive(struct sock *sk);
> > >   void sock_set_priority(struct sock *sk, u32 priority);
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index eae2ae70a2e0..e06bcafb1b2d 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int o=
ptname,
> > >       return 0;
> > >   }
> > >
> > > +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > > +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb,=
 int op)
> > > +{
> > > +     struct bpf_sock_ops_kern sock_ops;
> > > +
> > > +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > > +     sock_ops.op =3D op;
> > > +     if (sk_is_tcp(sk) && sk_fullsock(sk))
> > > +             sock_ops.is_fullsock =3D 1;
> > > +     sock_ops.sk =3D sk;
> > > +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS=
);
> >
> > hmm... I think I have already mentioned it in the earlier revision
> > (https://lore.kernel.org/bpf/f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@linux=
.dev/).
>
> Right, sorry, but I deleted it intentionally.
>
> >
> > __cgroup_bpf_run_filter_sock_ops(sk, ...) requires sk to be fullsock.
>
> Well, I don't understand it, BPF_CGROUP_RUN_PROG_SOCK_OPS_SK() don't
> need to check whether it is fullsock or not.
>
> > Take a look at how BPF_CGROUP_RUN_PROG_SOCK_OPS does it.
> > sk_to_full_sk() is used to get back the listener. For other mini socks,
> > it needs to skip calling the cgroup bpf prog. I still don't understand
> > why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot be used here because of udp.
>
> Sorry, I got lost here. BPF_CGROUP_RUN_PROG_SOCK_OPS cannot support
> udp, right? And I think we've discussed that we have to get rid of the
> limitation of fullsock.

To support udp case, I think I can add the following check for
__cgroup_bpf_run_filter_sock_ops() instead of directly calling
BPF_CGROUP_RUN_PROG_SOCK_OPS():
1) if the socket belongs to tcp type, it should be fullsock.
2) or if it is a udp type socket. Then no need to check and use the fullsoc=
k.

Above lines/policies should be applied to the rest of the series, right?

According to the existing callbacks, the tcp socket is indeed fullsock.

Thanks,
Jason

