Return-Path: <bpf+bounces-40048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2897B2C0
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952D02852AB
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB043185E7B;
	Tue, 17 Sep 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PE1ylMnU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187218733B
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726589708; cv=none; b=tsD3tzPaKhV5rX+zRaK9JMMFrl4jPFXDyHtw/z0fkBP4L+JWM7rdkOaeVZoLiRYq0rr6IfX1Q5AYo7mOjgffa332IJxv8G/SmiFiAXeHPbAVPCH9KSiA3p9hUbJRxHhoK8fuPbXt78LTTB67HtpcMki1NEmH6pjuqCYcVQMBc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726589708; c=relaxed/simple;
	bh=lwnXZapTso/O0BB5NasLPLapI5PqZ2TTupYriBm2dn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZhKBPtofl25g7MT5MLWm/OOgBCRFcYHVfBY5la7/0czePKu7afMQjmvzfTo6PEnZ3CUvDv69vpMIrCINQy7D0nleIgoXZ/ulbYY3ZdYGRkcn2dB/lwt4ak/eF7Bmh/LX2AYAt7E1AgZMCYqvH+YBHcecND2AqndJEmoAciI5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=PE1ylMnU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso60786545e9.1
        for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726589705; x=1727194505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vb3ZNNoM2z4eN/JSIKdMJgAcjYjqjC/0wPV4rSBWMg=;
        b=PE1ylMnUxQfJXYtybN1/OkpaeMHZ3d27y9ibVSrmRJVjGH+pThz2CBKTGzehClMe0c
         EWeLj5XfEypfo4aBV05o7qHYfqLqrkqjTcw6WOGT+7qYKTVoPG0sQDNzf70fgibrNnDh
         G4SVZhuYWfz+f0KbziGuV++KYK6qJ5A98hBj0cnVuDcM/X5SYTNrSoWq1806xuZijaY8
         J9nDEc914hbxGxX4FXgLbn0tayg5J39UyzbzYE/cGsVzLHANdCkQ9XqCrfMYAkTgycvu
         sb/2U5xdzPUMja28ZBtTcsDKdUoI5bADl4tM8drfRvtaLXyWRaWBxodR4i+2GtxOPiQZ
         sfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726589705; x=1727194505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vb3ZNNoM2z4eN/JSIKdMJgAcjYjqjC/0wPV4rSBWMg=;
        b=PmQBbgr2G2F9Taj6+p2k226b7LN9HkWIM6yhSg98d6jvJNHCMMNjahLq6xPDf7hD4K
         NjLAashBRYAWK+5PKKoOn9eL+SVrDAlM6lrUVaVZhv242KBOBEwec/9dMP6Yf8vaqdJT
         xkJhhTL5mocs332HIGxAbTisQmszFEQaeE09YA3zhMmHgV4UJtdCtwiltRZxMPcVGIEp
         Cwcd34ALR/9NDv8BPMFIz1f81N+JrNBZ+51yXUooEu2E5xuy4fZ8/AfJgD6kxn/z7/eD
         4hjsL+4IdtABX+VYTRJxSIzMLsivjUQ+44wnfoIdCR6vwIGe7KyhFDVKQ7ibSSLaojWS
         y8AA==
X-Forwarded-Encrypted: i=1; AJvYcCU2zABv6V8NdKW17hv1wliY9IT4PleNgHJW8UBnF1raBDbl9X3aG2PWYE9I4lLGUKeE2pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhcuiSyE3Gi42HYPSJpnVJKHgAmTtmmxthkUBgWV9pcbm9EXEX
	S9mUfPCditHqFCeC6pVOuEQq0RDc9kLEpiWybmTNrkhmU41EvB1wui5LyNFZ2hM=
X-Google-Smtp-Source: AGHT+IGyYTKKVcEirSlpO0KfCBQX0iPAUMySvChTbbgc8k0xkQsZ1583R2aJKwp5Qb1gsjn326NdDA==
X-Received: by 2002:a05:600c:354a:b0:42c:c8be:4215 with SMTP id 5b1f17b1804b1-42d9070b2eamr137076455e9.4.1726589704576;
        Tue, 17 Sep 2024 09:15:04 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:50ca:432::6b:83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1947cfsm141094715e9.42.2024.09.17.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:15:04 -0700 (PDT)
Date: Tue, 17 Sep 2024 17:15:00 +0100
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
Message-ID: <ZumrBKAkZX0RZrgm@GHGHG14>
References: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
 <20240913-reverse-sk-lookup-v1-2-e721ea003d4c@cloudflare.com>
 <d17da5b6-6273-4c2c-abd7-99378723866e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17da5b6-6273-4c2c-abd7-99378723866e@linux.dev>

On Fri, Sep 13, 2024 at 11:24:09AM -0700, Martin KaFai Lau wrote:
> On 9/13/24 2:39 AM, Tiago Lam wrote:
> > This follows the same rationale provided for the ipv4 counterpart, where
> > it now runs a reverse socket lookup when source addresses and/or ports
> > are changed, on sendmsg, to check whether egress traffic should be
> > allowed to go through or not.
> > 
> > As with ipv4, the ipv6 sendmsg path is also extended here to support the
> > IPV6_ORIGDSTADDR ancilliary message to be able to specify a source
> > address/port.
> > 
> > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
> > ---
> >   net/ipv6/datagram.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   net/ipv6/udp.c      |  8 ++++--
> >   2 files changed, 82 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> > index fff78496803d..4214dda1c320 100644
> > --- a/net/ipv6/datagram.c
> > +++ b/net/ipv6/datagram.c
> > @@ -756,6 +756,27 @@ void ip6_datagram_recv_ctl(struct sock *sk, struct msghdr *msg,
> >   }
> >   EXPORT_SYMBOL_GPL(ip6_datagram_recv_ctl);
> > +static inline bool reverse_sk_lookup(struct flowi6 *fl6, struct sock *sk,
> > +				     struct in6_addr *saddr, __be16 sport)
> > +{
> > +	if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
> > +	    (saddr && sport) &&
> > +	    (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, saddr) || inet_sk(sk)->inet_sport != sport)) {
> > +		struct sock *sk_egress;
> > +
> > +		bpf_sk_lookup_run_v6(sock_net(sk), IPPROTO_UDP, &fl6->daddr, fl6->fl6_dport,
> > +				     saddr, ntohs(sport), 0, &sk_egress);
> 
> iirc, in the ingress path, the sk could also be selected by a tc bpf prog
> doing bpf_sk_assign. Then this re-run on sk_lookup may give an incorrect
> result?
> 

If it does give the incorrect result, we still fallback to the normal
egress path.

> In general, is it necessary to rerun any bpf prog if the user space has
> specified the IP[v6]_ORIGDSTADDR.
> 

More generally, wouldn't that also be the case if someone calls
bpf_sk_assign() in both TC and sk_lookup on ingress? It can lead to some
interference between the two.

It seems like the interesting cases are:
1. Calling bpf_sk_assign() on both TC and sk_lookup ingress: if this
happens sk_lookup on egress should match the correct socket when doing
the reverse lookup;
2. Calling bpf_sk_assign() only on ingress TC: in this case it will
depend if an sk_lookup program is attached or not:
  a. If not, there's no reverse lookup on egress either;
  b. But if yes, although the reverse sk_lookup here won't match the
  initial socket assigned at ingress TC, the packets will still fallback
  to the normal egress path;

You're right in that case 2b above will continue with the same
restrictions as before.

Tiago.

