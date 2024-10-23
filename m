Return-Path: <bpf+bounces-42849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E79ABA5A
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BC31C22D84
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FAC2914;
	Wed, 23 Oct 2024 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWxC+8Aa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F2196;
	Wed, 23 Oct 2024 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641975; cv=none; b=cQHTQ3YFQWIOQYucQ6I1QmP6l7oYPpQk9KqGLceOH6mBaKIOvwf20uOTUcLLDEANCmTZQtUPfkNwP8ZjKwjWEXX7IRe6d95ycX5Iex9etwHST/78Kc2AK5JBt9t/Bc9Hna7/oXRMLmugFJV88FsZMyxfSn8tEikcRAmvKEHa5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641975; c=relaxed/simple;
	bh=ZV86+OPN4zJI02u88jEs4H/PJ4cF9CFOZqdC6JlySjw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=m7CGqdxAsDXpzYgi8s2vbw9DPROAWagE5hF9q/V/EypC4DSQn/xkuqr9YT8LPhB6JvqQ5C8rrfPCe3S0+ysywKXi+qeBbX0k2RPpgghidfYWRrFxXGgoYQxgc2NfeQAogYpq/GLdh4qS4Ql2F0Q3oLEvu/as6akkrRBgy69IlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWxC+8Aa; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b149ef910eso498395985a.3;
        Tue, 22 Oct 2024 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729641973; x=1730246773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E1y0zXz0FAjgbstvMGXHQS2tqPf8pF30lCKWcGHyaw=;
        b=hWxC+8AaDzCoke3xemoXZi5qIQ/SLyaiMeZA+awSIZLgUgW7AnIy3c4zpXf3GbKhLb
         xzrRjK9FWKa524GnVRAj1KBtXKIq49oxd91BZNQpFKM0Yu31dWZt1BHIB5nddSrZCTAL
         CLtN7ahjt7e0wD2m08B9qyD6kL0JMzUekqRpDUogNm3k6wHqqGDJO+xB88sulFX4f7dN
         Y62kiWU6CkgTkqMQ5NGmOWZz0/J4BcfH2WEvyQCKJjYO8iO6m1yHAaX9ENf6EgH0pqlA
         3+m0m5uyRCyxivAYF4GgDnERrsoRl+KIT0WwxbpWN7tZC3lYRk3y1rONPpwprAF0PrCZ
         N/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729641973; x=1730246773;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2E1y0zXz0FAjgbstvMGXHQS2tqPf8pF30lCKWcGHyaw=;
        b=kxInik9uUzMNYtvmRjceaLidwIOECUOKr6WZ/E7pFjrZ6pNw9n9BKL9SqamOdiVvZA
         ZZjKQLgFDaYjb1LCpcT33ljc0LntBxnLbmsXXAuxlmAeMb1nYhEZVtmLXBPgA/RViB+y
         V1Od0G+TG4CkYcstBAxdQNN+qjSFQ5BtMDOvgdJbo6i0LieZO4oqQA4h0KwHhrOb/fD8
         Ixj9A9tLRdT9YmY5ZRyrmGUytVlPRpxWVyoYgdiaOz/j6tk6ebyduP4HXKAeMFxpU4uk
         GRZDgwmEmeIS2X6P8GKg+ZCF0EQ7GYJ7rw6hdEiceK+/9UqoNACsghJG9xBRfnYkRGzB
         IaRw==
X-Forwarded-Encrypted: i=1; AJvYcCVXy/MZYtSudtXJgZ1da5KJdSlMqFA6i+KiZFBR65o5VgLkK+CX+RJVmc8UOSKvkCYHFy4=@vger.kernel.org, AJvYcCXTkMx3Bzp3HKP0er+3SVH58u//DkfPqLk5WvcDV8+c0h93jvwZLhUuYlOVK2kQvDsR5rMhzSSM@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdndL/pKtBL485/TSn3VKWayZLW4Pp6bZhgHkkgKlAxB3n1lN
	FvbYBlZdpgjUDhJe2296dh9HG19x9TFjVJP9c2gBVXaloD8nQppC
X-Google-Smtp-Source: AGHT+IHfptJqp/QF/XIdias5Hsqh4fJZTPF+NRTGdR3IVT0BYEJk0V11bp4jlqsTUCSieYrnn4sQgA==
X-Received: by 2002:a05:620a:24d3:b0:7b1:4f21:39de with SMTP id af79cd13be357-7b17e4afbcfmr115973785a.0.1729641973039;
        Tue, 22 Oct 2024 17:06:13 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a89c96sm330948185a.131.2024.10.22.17.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 17:06:11 -0700 (PDT)
Date: Tue, 22 Oct 2024 20:06:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67183df34e8e3_1420e5294a2@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCBONnrP_YyE_0n_o4zQUNJfE8DY61f6XRQeeBdGNZMgQ@mail.gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com>
 <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
 <670ee4efea023_322ac329445@willemb.c.googlers.com.notmuch>
 <CAL+tcoCBONnrP_YyE_0n_o4zQUNJfE8DY61f6XRQeeBdGNZMgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for
 bpf_setsockopt
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
> On Wed, Oct 16, 2024 at 5:56=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Martin KaFai Lau wrote:
> > > On 10/11/24 9:06 PM, Jason Xing wrote:
> > > >   static int sol_socket_sockopt(struct sock *sk, int optname,
> > > >                           char *optval, int *optlen,
> > > >                           bool getopt)
> > > >   {
> > > > +   struct so_timestamping ts;
> > > > +   int ret =3D 0;
> > > > +
> > > >     switch (optname) {
> > > >     case SO_REUSEADDR:
> > > >     case SO_SNDBUF:
> > > > @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock =
*sk, int optname,
> > > >             break;
> > > >     case SO_BINDTODEVICE:
> > > >             break;
> > > > +   case SO_TIMESTAMPING_NEW:
> > > > +   case SO_TIMESTAMPING_OLD:
> > >
> > > How about remove the "_OLD" support ?
> >
> > +1 I forgot to mention that yesterday.
> =

> Hello Willem, Martin,
> =

> I did a test on this and found that if we only use
> SO_TIMESTAMPING_NEW, we will never enter the real set sk_tsflags_bpf
> logic, unless there is "case SO_TIMESTAMPING_OLD".
> =

> And I checked SO_TIMESTAMPING in include/uapi/asm-generic/socket.h:
> #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP3=
2__))
> /* on 64-bit and x32, avoid the ?: operator */
> ...
> #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> ...
> #else
> ...
> #define SO_TIMESTAMPING (sizeof(time_t) =3D=3D sizeof(__kernel_long_t) =
?
> SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
> ...
> #endif
> =

> The SO_TIMESTAMPING is defined as SO_TIMESTAMPING_OLD. I wonder if I
> missed something? Thanks in advance.

The _NEW vs _OLD aim to deal with y2038 issues on 32-bit platforms.

For new APIs, like BPF timestamping, we should always use the safe
structs, such as timespec64.

Then we can just use SO_TIMESTAMPING without the NEW or OLD suffix.=

