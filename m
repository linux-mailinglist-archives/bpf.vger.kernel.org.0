Return-Path: <bpf+bounces-69784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F5BBA1DBD
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4847169674
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 22:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3C9322C80;
	Thu, 25 Sep 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjsyX2k9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538B13218C5
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840064; cv=none; b=Z0Ygdk1Mmzzh8L7zz2S+IXyR/RGg/L7KQuEDalBJn9gMMPnUxRS2WNEfHn98D2DAa9YvCxOAWUt2EixwQk/IsBELrPjdSZzoYwZqZgJ0pTHVH8YswUi0+F+lAzPM3jPtxSseHf5+QQFMXlIJkFRtI2zhf+TKgO+FV95g5NGxGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840064; c=relaxed/simple;
	bh=7tMZH6BL6w19NBpb9eF+n2B8nj1FBXXU5RvXUM3XZwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1H7soQykSWm/kuWHIjnmbeHc/IBB+HmZP6b8s1GORsPawWhrUbr2UDZa9cpqFAuWGt2da0rlu9+OZRUWvXva15o5ol4VEGHJMThNfZB8JuEPpMaKckJybp+T+lWB6NSMV1oKHf7wb/6OcxhD73fN20BqsaInSVU9wW78UgEzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjsyX2k9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b57f08e88bcso176000a12.0
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758840063; x=1759444863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiRfZeXVBII9n8+rM3U1QlqGk0PSxFWiOe+LlIXh4J0=;
        b=BjsyX2k9X0i1oDXpRq2/qPJBv8ZKQttdYhhRSAYdPAtWsQDDSCtR9HHpTWY+ToO9y8
         Gw7dfWU4bigV2ndpBgxtiSzwBDNR9qvf1mRJ8d4wZCU3jkduxgdg/ZrZKEbgcee4H1u2
         ceR//3g1hXPE6levVImk/JkqG74QKJxOad5UBcf8SPIjjN8g8zO11EKWKXhwZ6TqsNxS
         TEuYJAdt6gUyONxo6toWtonL2bz60GeOqeb2FfjmzpyQQu7r4u69l92cCZ5zLQPr6Oi9
         biQ+4awLNamFEkKAhOe54LUOAFa7TmSkpfhF8+uw8NlyGXDrhOSG069hN5LvyrAAcMkr
         d46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840063; x=1759444863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiRfZeXVBII9n8+rM3U1QlqGk0PSxFWiOe+LlIXh4J0=;
        b=erFhR9bFPcFqWcOtQE+kX0WUqCWhixMQAaWDERXaCO7LFE+HD2KydXXM/hPnoXPFYa
         ri8xpO5SlLQW8a+pq0rZkD03K5N7QE5kGdvqaQ6q3JUgOkhqMmfixjDCwobX9ZGJ1CaL
         zjn2KMq2wcxYEsmbPgAkr3U8gQRE7iWxZQvBaS8JF2aocHIiqzFxhvMZitbF5TMrR9/v
         tIOHqBmZkbip9UZpoqXYx3awllzoNTxaQeVhwy69n9Shn/vnZ/kWzZGcFCfzod3zNJxo
         zVfr4pTB3Ktljr++fLU6KV9N+sD4GdTWhX9ZMxT4S16N3J1Jp1OdMHfkk1JiAcPv0jmc
         iKmA==
X-Forwarded-Encrypted: i=1; AJvYcCXoxg9NXEhm2bI9M1BEXK9qb/lusnXJpk9/G2QaiusAJTPXWQwu1uiSjHV3IEGixhvOLCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfa0UOaRLaLrVxki8o7rNiC49RU9OcmdnDDZxY6E/NQ4KyobJ5
	w1MD6PCtKLwXxtrfYLsDCQxaJ07A2p5OG8wgNm5q3WyKwTEDSCvX/2YwPylBkq30H9Ajtyf9ELV
	xMQVhNCXNKTbHTS2Pi7mMvxJUCDW9nkqDgtF5RndQ
X-Gm-Gg: ASbGncumTgcKNQYlC9C5z7J81OhIGqSwyux1zj+IERnijOhENIO2gy6SuAdgk1aWXQJ
	CinNOoU+2YU2qqlK6qiwxaEqa+6aAka4/8hH14z847N0RHbNRNxiMGToHjpba+4XKm2Eufudk2E
	MxAcc9Bl46cc38u1WOnf8tVkfKOcUFXApW7ddJe2tN6EztRc61FvtPLkB2tBicL6ZxmUumAJSQ2
	Eoym3P3CwyMyLm2hC+ktZJoaBuXCGX/1LDzUwiZ7iqEUeg=
X-Google-Smtp-Source: AGHT+IGq9FT8VYoBk6o5AsaYR/ej2qoOKf/s46aBqSFWNQRwLIuU437Iw0sLKoZEgVPtCo4NpTCCwm5XD3z4rP5rAB4=
X-Received: by 2002:a17:903:3bc4:b0:25c:abb3:9bae with SMTP id
 d9443c01a7336-27ed4a474ffmr50710545ad.48.1758840062342; Thu, 25 Sep 2025
 15:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com> <20250920000751.2091731-3-kuniyu@google.com>
 <ddrg3ex7rbogxeacbegm3e7bewb2rmnxccw4jsyhdpdksz2qng@2xbs7jvhzzhk>
In-Reply-To: <ddrg3ex7rbogxeacbegm3e7bewb2rmnxccw4jsyhdpdksz2qng@2xbs7jvhzzhk>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 25 Sep 2025 15:40:50 -0700
X-Gm-Features: AS18NWCtvFTVjm_0W4tTSE27MsheFBXZtcWItJlaOgcJpCJH0tICXxG1j5ZeUgs
Message-ID: <CAAVpQUDxSwjegw1UgieGOF+YGF=j2_FK=M1ZEKP1KGdtCdEBkw@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next/net 2/6] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 10:25=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Sat, Sep 20, 2025 at 12:07:16AM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > If a socket has sk->sk_memcg, this memory is also charged to memcg as
> > "sock" in memory.stat.
> >
> > We do not need to pay costs for two orthogonal memory accounting
> > mechanisms.  A microbenchmark result is in the subsequent bpf patch.
> >
> > Let's decouple sockets under memcg from the global per-protocol memory
> > accounting if mem_cgroup_sk_exclusive() returns true.
> >
> > Note that this does NOT disable memcg, but rather the per-protocol one.
> >
> > mem_cgroup_sk_exclusive() starts to return true in the following patche=
s,
> > and then, the per-protocol memory accounting will be skipped.
> >
> > In __inet_accept(), we need to reclaim counts that are already charged
> > for child sockets because we do not allocate sk->sk_memcg until accept(=
).
> >
> > trace_sock_exceed_buf_limit() will always show 0 as accounted for the
> > memcg-exclusive sockets, but this can be obtained in memory.stat.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > Nacked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> This looks good to me now, let's ask Johannes to take a look again and if
> he still has any concerns.
>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Hi Johannes,

It would be really appreciated if you have a look again.

Thank you.

