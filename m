Return-Path: <bpf+bounces-41735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C265199A2A2
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 13:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C752B1C229D8
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0513B216449;
	Fri, 11 Oct 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gd7Cgkv5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E287215F78
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645725; cv=none; b=kGbD5AGyaNvFWU8CaDrjxaAML2NyBBpwgQ0Zu/6AZZR+QFVoRNOjk7mJ25PZSVnt5seutImvnH78+tGgOMxBhU3Hrtk8ECZaXB9SwjZWw5Z4lElF/MkonjozdMwu6UqUhqjE+AeeUJJ8qOs9Z3grW6+2GPpsfCEtqTlLBkyAOgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645725; c=relaxed/simple;
	bh=V45rzpsGTA9eHbV3LCV3/C1FC/N9IgmTho1xah1POtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI9BwZRzcoBkdtXA45RfJ/wiDvmM4dWvFVEI8YC4xA0YWD+Ax/US4cQ3S3hadyLe6f06OoHGtm2NINx7wUE4Fjb46Y9kflMUhMWW8WO6E/OTpfnZDH5gfK97pI72HQVW8YECxb5V9+jdqhSwEAwLZYcgRqIu+xh42lav6XHY0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gd7Cgkv5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43058268d91so17193555e9.0
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728645720; x=1729250520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TC0eCy66WVYHmCUE7Pa9O2g6Dm7ZbmBg1UnWKt/lClo=;
        b=Gd7Cgkv5qXjChwhU5cyYM1RVbN0HhmtuJ8/fSI+HGgUbVsEYQQhs3XKbc6ElfP9SGy
         lgW0NQ4L3z8LXZIIgpeblQUYjFb395uun8GCV4fP16pfcIq+MLZP0kSkB7MY8JbN6q4w
         V0HTatMN+vUeh144w5pzW+wsjyov94UODH0Bw4/w4pnsJRbt7iigxuJWci2R9TuGo9rd
         W10Mz9sDVx2bAtnUW4pIfqE733eoh9Z62kpzQ47iJw68jqVeHp8HhxyFoo9UlaKk/hVD
         r8CtquLKCwRbd25Bi06pK+60Xwve1UBIOSWdX5/q/h9fDv5cn3dVh86JZVHKCLD1V6JW
         lTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728645720; x=1729250520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC0eCy66WVYHmCUE7Pa9O2g6Dm7ZbmBg1UnWKt/lClo=;
        b=Dc22AAPd2CAZViW8mYe1p4wZSynG0s3XYsnkX7m7CLJRl5+3X62Epm8UnF8XbYNy0G
         X5Y6OKqCoayu9uKsoinDXjnMrWXPy3uKX+8/04v6ktnKqTzLtDsTeZL4UApfW0ZhNCad
         EcgcuvRWVT9aEr5H4HJgIOnSFgfxCrRmYcU55u1Er8RkvBjzCfUVgMeBc0+XZbu/gURk
         8CSQ1/1HaJ2Yf68spl+U5FEq8Rr1nGmzuhmJChzkVI3CicbiFjCVYhfxU6YSTzL4Bi1A
         TD36WBh0zavfPpQAQtVpqw1gfIZ36bxN4vCkXrdd0SIL7rIZk7ijbJAwPs/UoFuT26+h
         Wq+A==
X-Forwarded-Encrypted: i=1; AJvYcCUcrArRjwSGeWh4D424eKC/h3WoBolxedAKNIhZdWqxRUbQ3QJyMdYvAto8YCa9MXUP50U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5K1KwAjOVei6TUXU893bm2cSkjFDqHOM3aOBSizWKe845V/Q
	B1wyd+NO733uvUDrG6MIhMy8lPJO4EXitYMTu/yNnxy/p7LGYeZAy1tAk3KdiBo=
X-Google-Smtp-Source: AGHT+IHe/2C00Yyf4tq9hx4W59wKITX/FNedGd2qWnQF3QJIxXO0x3L5/Z88igAuTwdOWUK9NS6K6A==
X-Received: by 2002:a05:600c:3b0d:b0:428:10d7:a4b1 with SMTP id 5b1f17b1804b1-4311df56e7bmr18603095e9.25.1728645720554;
        Fri, 11 Oct 2024 04:22:00 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:37aa:1cdc::2e0:86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4331sm72995255e9.36.2024.10.11.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:22:00 -0700 (PDT)
Date: Fri, 11 Oct 2024 12:21:49 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@cloudflare.com
Subject: Re: [RFC PATCH 2/3] ipv6: Run a reverse sk_lookup on sendmsg.
Message-ID: <ZwkKTTFAdP7V8HJQ@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
 <d17da5b6-6273-4c2c-abd7-99378723866e@linux.dev>
 <ZumrBKAkZX0RZrgm@GHGHG14>
 <0288caf4-3c9b-4eae-a2b4-f8934badc270@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0288caf4-3c9b-4eae-a2b4-f8934badc270@linux.dev>

On Tue, Sep 24, 2024 at 04:58:19PM -0700, Martin KaFai Lau wrote:
> On 9/17/24 6:15 PM, Tiago Lam wrote:
> > On Fri, Sep 13, 2024 at 11:24:09AM -0700, Martin KaFai Lau wrote:
> > > On 9/13/24 2:39 AM, Tiago Lam wrote:
> > > > This follows the same rationale provided for the ipv4 counterpart, where
> > > > it now runs a reverse socket lookup when source addresses and/or ports
> > > > are changed, on sendmsg, to check whether egress traffic should be
> > > > allowed to go through or not.
> > > > 
> > > > As with ipv4, the ipv6 sendmsg path is also extended here to support the
> > > > IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
> > > > address/port.
> > > > 
> > > > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > > > Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> > > > ---
> > > >    net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >    net/ipv6/udp.c      |  8 ++++--
> > > >    2 files changed, 82 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> > > > index fff78496803d..4214dda1c320 100644
> > > > --- a/net/ipv6/datagram.c
> > > > +++ b/net/ipv6/datagram.c
> > > > @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
> > > > +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> > > > +				     struct in6_addr *saddr, __be16 sport)
> > > > +{
> > > > +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> > > > +	    (saddr && sport) &&
> > > > +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
> > > > +		struct sock *sk_egress;
> > > > +
> > > > +		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr, fl6->fl6_dport,
> > > > +				     saddr, ntohs(sport), 0, &sk_egress);
> > > 
> > > iirc, in the ingress path, the sk could also be selected by a tc bpf prog
> > > doing bpf_sk_assign. Then this re-run on sk_lookup may give an incorrect
> > > result?
> > > 
> > 
> > If it does give the incorrect result, we still fallback to the normal
> > egress path.
> > 
> > > In general, is it necessary to rerun any bpf prog if the user space has
> > > specified the IP[v6]_ORIGDSTADDR.
> > > 
> > 
> > More generally, wouldn't that also be the case if someone calls
> > bpf_sk_assign() in both TC and sk_lookup on ingress? It can lead to some
> > interference between the two.
> > 
> > It seems like the interesting cases are:
> > 1. Calling bpf_sk_assign() on both TC and sk_lookup ingress: if this
> > happens sk_lookup on egress should match the correct socket when doing
> > the reverse lookup;
> > 2. Calling bpf_sk_assign() only on ingress TC: in this case it will
> > depend if an sk_lookup program is attached or not:
> >    a. If not, there's no reverse lookup on egress either;
> >    b. But if yes, although the reverse sk_lookup here won't match the
> >    initial socket assigned at ingress TC, the packets will still fallback
> >    to the normal egress path;
> > 
> > You're right in that case 2b above will continue with the same
> > restrictions as before.
> 
> imo, all these cases you described above is a good signal that neither the
> TC nor the BPF_PROG_TYPE_SK_LOOKUP program type is the right bpf prog to run
> here _if_ a bpf prog was indeed useful here.
> 
> I only followed some of the other discussion in v1 and v2. For now, I still
> don't see running a bpf prog is useful here to process the
> IP[V6]_ORIGDSTADDR. Jakub Sitnicki and I had discussed a similar point
> during the LPC.
> 
> If a bpf prog was indeed needed to process a cmsg, this should work closer
> to what Jakub Sitnicki had proposed for getting the meta data during LPC
> (but I believe the verdict there is also that a bpf prog is not needed). It
> should be a bpf prog that can work in a more generic way to process any BPF
> specific cmsg and can do other operations in the future using kfunc (e.g.
> route lookup or something). Saying yes/no to a particular local IP and port
> could be one of things that the bpf prog can do when processing the cmsg.

Thanks for the feeback here, Martin. And apologies for the delay in
respoding to this.

I think you do have a point, and after syncing up some more with Jakub
about your discussion during the LPC, the argument that applications can
already bind to a specific address + port to send their traffic from
makes sense to me. However, I think we could introduce a new cmsg in
sendmsg to allow apps to set the source port to egress from, extending
what they can already do with IP_PKTINFO, i.e. setting the source IP.
We'd need to take care with priviledged and reserved ports, but this
would avoid applications having to do an extra bind. Do you have any
thoughts on this?

Tiago.

