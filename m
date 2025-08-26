Return-Path: <bpf+bounces-66595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827ABB3743C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 23:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC268E0C2D
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292A2F7453;
	Tue, 26 Aug 2025 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7sKwsTM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927692F6170
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242553; cv=none; b=C3WVQyO/1dFmm+yaPTKmD/eAvNFUm8FEva/hIHy1Fo7G60sn2w6kf3d9pMEgbZlgED5ZLI0N0cRfNdeuAZ2b/Ji+jJv9OyulY9bem4BI/46mPDv8c2ClksuBDcq1lyEsDWJ3IX4hZWi5rVNx/IJb59cxSgqA4eixKL/X4z2YGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242553; c=relaxed/simple;
	bh=0oWgTPPPisVg9c8PmPKc3P7KIOcffkhNjYq4eUew7O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCy6mYZP4lZNenNyPlboEyUu3jd76MMcPO8CIIklWQi3TkNVy1+Z+CZWTZwePDaDc1cj2hCkz322IpN385ccsAKxC3XQsJIXAe8vgp7OLlSJU89ytVY3azzIJkRuIdBcsiLZVCdmWhhBVr/2YKQ2G389KSmwyCSb45FSzTqnyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7sKwsTM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b49dcdf018bso2059771a12.0
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756242551; x=1756847351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/Mu7Oh03Ij53/ZdNsrul9Mq2libPK+lGlyzoenSe/E=;
        b=h7sKwsTMNGQlG8Sfic+2c9tJSZHjpoOFFFYiMw7enJPf6SePx6vbl/VTzC634Wp4rm
         HFIzfImPVCPMN8IRNXr/9ABG939Grq7Ba9g37it8nnUudMK1e0a5xavREwMnz1kMzkX1
         8/rnJILjzfOC9vFdSvJbVsQb9Pyc2oWLRN3QQ+5gCTtrKO6nOzkiTCyFXVL1DWT6MPUH
         jbEQZn1zWPo5tOKVMqWOXtDNfFw/UCDv0qNtaUQP8RDsHYZcvWNPS2razxqZ2vU3mPq4
         JLPOnrpQboV4M6+EhGnd9tOi7jNZs3T4pehIeHajnRtYEVLZ9deE6MZoXQPh2jGu5xks
         Vv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756242551; x=1756847351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/Mu7Oh03Ij53/ZdNsrul9Mq2libPK+lGlyzoenSe/E=;
        b=d/ZRUYjCel4XZoLe5U5IJQ6dxHPEsTURN2pDQ92IonDeOsYR9l9wXnGaEQ82ff4Eoq
         4AKhy/CNYgm32zH4E57RPVMNbOmFMDJHbcDeNP3zbkIkBbi6noh72y3mHY8OaZgk4j4h
         m45iGNYjLqh7naZihmam59WmpZotVb2MEk1uhErBC57jS6M0ghfrjT2tHO1A/Ea+rgyy
         z2AnWiMf8SYJMfDYRg4a/RKSxm+FNNPfi0oev6hidtw8gag7k7bhwWk30IPEskdmhK9p
         +Jz1Zms2GikwBIeAo6uRUBAxAjfeMgVd89J2MEYdnOt/l+5mINyrV2ihWqQrSbh5zI/v
         EE3A==
X-Forwarded-Encrypted: i=1; AJvYcCUBcGSaYyCBrWd/xC08lP/bMY7MQOnBka9tVxRCQn7lgU9xzlMYD6p0bzAfUI3hvhQeXRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwVEgeuGOkXU6Dc2SREwddpCSJf3g+LhwrOS0+mpNfWbcohBb
	HY/LxnAPTAEbcdc3Auu2uBcwvxac51dDEr0qf6fQeD2m/YM/GQwkAvcj4GV3F5NwdKWXL8FcYmH
	WDK28Y8dGDo0I6MXPhJm0gd2JO2U4XAd9QNFuHNlu
X-Gm-Gg: ASbGncuYrLryvkhoEfQ+aPsiOORkGbHhZ+EtRogRx73jrI1d7RRrPw8yp9RbtNY30aK
	TFlLRNu69n9ORL7Vigl/OEAICpa2mxp1Yh5TKXI+Wwttt1IbwNJ8pw7yd7FNe6xr6cAQiapYGdI
	y43vz9CibI/eR/Jm/+N9w5GqquAjjV4HGt9G4Q8A4sIAG+glnpBxCZtPxV95pwboPAYqvb+vQqH
	h6ro5NJRn2tJKWv39QvWvIgTmN4R0zPjfbEMoYfMOnobHJJLlUBcjq3iCmKb000TbH8QFJLqSE=
X-Google-Smtp-Source: AGHT+IHrPZKregBUeIuBeRA62+6fniQ92yEI+CdI81Uc/3ho/GBMq2GbuOQ6SvO5MGiN53EUU3hsYG/mAxVF8xF7YgE=
X-Received: by 2002:a17:902:e84d:b0:246:cb50:f42e with SMTP id
 d9443c01a7336-246cb50fee1mr122628085ad.18.1756242550542; Tue, 26 Aug 2025
 14:09:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8ebb0c6-5f67-411a-8513-a82c083abd8c@linux.dev>
 <20250826002410.2608702-1-kuniyu@google.com> <2bac5d14-6927-4915-b1a8-e6301603e663@linux.dev>
In-Reply-To: <2bac5d14-6927-4915-b1a8-e6301603e663@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 14:08:59 -0700
X-Gm-Features: Ac12FXwmFgJzG0g2jTpznm2yZLSpHqcq8QTQ1uUBLgwJG9xAYzyFzupSAqDr1rw
Message-ID: <CAAVpQUC-5r+nbB=Uhio0WOEDV7dMcuUM-tF=auAV_rvAWH5s0g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: almasrymina@google.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, hannes@cmpxchg.org, john.fastabend@gmail.com, 
	kuba@kernel.org, kuni1840@gmail.com, mhocko@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, roman.gushchin@linux.dev, 
	sdf@fomichev.me, shakeel.butt@linux.dev, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:07=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/25/25 5:23 PM, Kuniyuki Iwashima wrote:
> > From: Martin KaFai Lau <martin.lau@linux.dev>
> > Date: Mon, 25 Aug 2025 16:14:35 -0700
> >> On 8/25/25 11:14 AM, Kuniyuki Iwashima wrote:
> >>> On Mon, Aug 25, 2025 at 10:57=E2=80=AFAM Martin KaFai Lau <martin.lau=
@linux.dev> wrote:
> >>>>
> >>>> On 8/22/25 3:17 PM, Kuniyuki Iwashima wrote:
> >>>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> >>>>> index ae83ecda3983..ab613abdfaa4 100644
> >>>>> --- a/net/ipv4/af_inet.c
> >>>>> +++ b/net/ipv4/af_inet.c
> >>>>> @@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct =
socket *newsock, struct sock *new
> >>>>>                 kmem_cache_charge(newsk, gfp);
> >>>>>         }
> >>>>>
> >>>>> +     BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
> >>>>> +
> >>>>>         if (mem_cgroup_sk_enabled(newsk)) {
> >>>>>                 int amt;
> >>>>>
> >>>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/li=
nux/bpf.h
> >>>>> index 233de8677382..80df246d4741 100644
> >>>>> --- a/tools/include/uapi/linux/bpf.h
> >>>>> +++ b/tools/include/uapi/linux/bpf.h
> >>>>> @@ -1133,6 +1133,7 @@ enum bpf_attach_type {
> >>>>>         BPF_NETKIT_PEER,
> >>>>>         BPF_TRACE_KPROBE_SESSION,
> >>>>>         BPF_TRACE_UPROBE_SESSION,
> >>>>> +     BPF_CGROUP_INET_SOCK_ACCEPT,
> >>>>
> >>>> Instead of adding another hook, can the SK_BPF_MEMCG_SOCK_ISOLATED b=
it be
> >>>> inherited from the listener?
> >>>
> >>> Since e876ecc67db80 and d752a4986532c , we defer memcg allocation to
> >>> accept() because the child socket could be created during irq context=
 with
> >>> unrelated cgroup.  This had another reason; if the listener was creat=
ed in the
> >>> root cgroup and passed to a process under cgroup, child sockets would=
 never
> >>> have sk_memcg if sk_memcg was inherited.
> >>>
> >>> So, the child's memcg is not always the same one with the listener's,=
 and
> >>> we cannot rely on the listener's sk_memcg.
> >>
> >> I didn't mean to inherit the entire sk_memcg pointer. I meant to only =
inherit
> >> the SK_BPF_MEMCG_SOCK_ISOLATED bit.
> >
> > I didn't want to let the flag remain alone without accept() (error-pron=
e
> > but works because we always check mem_cgroup_from_sk() before the bit)
> > and wanted to check mem_cgroup_sk_enabled() in setsockopt(), but if we
> > don't care, it will be doable with other hooks, PASSIVE_ESTABLISHED_CB
> > or bpf_iter etc.
>
> I think this could be a surprise to the user. imo, this is the implementa=
tion
> details that a bit of a pointer is used for the setsockopt purpose and a =
right
> one for perf reason. It does not necessary need to affect what the user c=
an
> expect from setsockopt in listener. From the user pov, what the user can =
usually
> expect from setsockopt in the listener and gets copied to child?

Ah, somehow I was confused with allowing flagging before sk_memcg
is set and I didn't think of inheriting a flag from the listener.

Inheriting a flag from the listener and only allowing setsockopt()
from socket() would be the simplest way.


> Beside, the
> listener and the accept-or on different processes is one of the use case =
but not
> the only use case.
>
> >
> > ---8<---
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index a78356682442..9ef458fe706e 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5269,7 +5269,7 @@ static int sk_bpf_set_get_cb_flags(struct sock *s=
k, char *optval, bool getopt)
> >
> >   static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, b=
ool getopt)
> >   {
> > -     if (!mem_cgroup_sk_enabled(sk))
> > +     if (!sk_has_account(sk))
> >               return -EOPNOTSUPP;
> >
> >       if (getopt) {
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index e92dfca0a0ff..efae15d04306 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -760,7 +760,10 @@ void __inet_accept(struct socket *sock, struct soc=
ket *newsock, struct sock *new
> >       if (mem_cgroup_sockets_enabled &&
> >           (!IS_ENABLED(CONFIG_IP_SCTP) ||
> >            sk_is_tcp(newsk) || sk_is_mptcp(newsk))) {
> > +             unsigned short flags =3D mem_cgroup_sk_get_flags(newsk);
> > +
> >               mem_cgroup_sk_alloc(newsk);
> > +             mem_cgroup_sk_set_flags(newsk, flags);
> >               kmem_cache_charge(newsk, gfp);
> >       }
> >
> > ---8<---
> >
> >
> >>
> >> If it can only be done at accept, there is already an existing
> >> SEC("lsm_cgroup/socket_accept") hook. Take a look at
> >> tools/testing/selftests/bpf/progs/lsm_cgroup.c. The lsm socket_accept =
doesn't
> >> have access to the "newsock->sk" but it should have access to the "soc=
k->sk", do
> >> bpf_setsockopt and then inherit by the newsock->sk (?)
> >>
> >> There are already quite enough cgroup-sk style hooks. I would prefer n=
ot to add
> >> another cgroup attach_type and instead see if some of the existing one=
s can be
> >> reused. There is also SEC("lsm/sock_graft").
> >
> > We need to do fixup below, so lsm_cgroup/socket_accept won't work
> > if we keep the code in __inet_accept().  We can move this after
> > lsm/sock_graft within __inet_accept().
> >
> > if (mem_cgroup_sk_isolated(newsk))
> >       sk_memory_allocated_sub(newsk, amt);
>
> If I read it correctly, lsm_cgroup/sock_graft should work but need to do =
the
> above sk_memory_allocated_sub() after the sock_graft and ...
>   >
> > But then, we cannot distinguish it with other hooks (lock_sock() &&
> > sk->sk_socket !=3D NULL), and finally the fixup must be done dynamicall=
y
> > in setsockopt().
>
> ... need a way to disallow this SK_BPF_MEMCG_SOCK_ISOLATED bit being chan=
ged
> once the socket fd is visible to the user. The current approach is to use=
 the
> observation in the owned_by_user and sk->sk_socket in the create and acce=
pt
> hook. [ unrelated, I am not sure about the owned_by_user check considerin=
g
> sol_socket_sockopt can be called from bh ].

[ my expectation was bh checks sock_owned_by_user() before
  processing packets and entering where bpf_setsockopt() can
  be called ]

>
> If it is needed, there are other ways to stop the SK_BPF_MEMCG_SOCK_ISOLA=
TED
> being changed again once the fd is visible to user. e.g. there are still =
bits
> left in the sk_memcg pointer to freeze it at runtime. If doing it statica=
lly
> (i.e. at prog load time), it can probably return a different setsockopt_p=
roto
> that can understand the SK_BPF_MEMCG_FLAGS.

I was thinking a kind of the latter, passing caller info to general
__bpf_setsockopt(), and gave up as it was ugly, but wrapping it
as different setsockopt_proto sounds good.

Then, we don't need to care about how to limit the caller context.

