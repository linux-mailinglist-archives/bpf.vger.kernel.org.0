Return-Path: <bpf+bounces-68901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA2B87B92
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD08625A53
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B03D25784A;
	Fri, 19 Sep 2025 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLIUDsZt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552092475C8
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248903; cv=none; b=iMwvJLMimS5EpLoF/Ze7Ejm8QHAwSre550NJAuxKTmt5M3cfdYDD7eBWM80skfjMxiBDn6clbpZavQJfAJ8leSiujF95BswFJZ/n90r0edqYusQV44Eoxz0Z2dpCe5+TvA+QyQBByBpvxRrRXV3G34l0KHJojPn7iRGiHaCCa1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248903; c=relaxed/simple;
	bh=IAWzq8wgztEQOpbHtt1PpnYZzxoeakPxyForBjTUOq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XE/CrfURb5+C6iwJfq1omCJqaPFmZK0M+N++BX35qD5EOiRsMVffGUV1kbM17OoPCvEaeCe7VWqW85B190vJ6yIn6baURGmO1WHJh+Hhc4m70hEKqZG2kU4J2r3Jm2Ie21UxGiYgUzU7tINgg+7fD21KwEhN8kF4X0uabkgTUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLIUDsZt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33082aed31dso1020814a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758248902; x=1758853702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz29qgUIuz9+hHBOcST4ZFw43ZTaMWItWLb+qR7GC2k=;
        b=lLIUDsZtZGHW9FFBPl9GimoVx1JgA4MapbWINxvAGxAXNsG2EJQXlbLPXuobAZJdVB
         CQfoXQ3iOWsApW0aj6KAHh46PqCdxxc05dHJYtgVKpPrik9UdbedFq3dq8JMvaBn03KT
         EixHSG07hh6JGLljHIyFn2XrOSgy2qoKGxUYOfGpQcG1Kma/Mzcq4Ml737qhcUFBYs/j
         EjABLmJTyOUWyk6qarSfqPBkujdH9pgfvTnsSO9co2xUjuSfXCJiKokETpMxQSK6sGNq
         Dl0DcKmkrc6SrwAZb27qFQM6uR/nZxaqkJl2IovKy+NyM4Y3R76f24thJRX2yP7KeWIZ
         XGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248902; x=1758853702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz29qgUIuz9+hHBOcST4ZFw43ZTaMWItWLb+qR7GC2k=;
        b=GLyHUluRbMo4FQzCn3RKFNZbfahBtSAAc/AAJouaW2fBxnudvE7kdH0ISyJXYPizeJ
         PudCxDw5kax26ov9Hr+zuvuesTy1eKWSNKx4sH5xYuPwwRy9NeLDp0Vf3Tzo9gtt+yD8
         cH+1oj/KwacpTHZtRJExCxSaMIsvmhcuEg0sYArgQifqu8NqRUHfD4/naqMXJf1CCa3n
         zGoYPJhtSbgWDh0zgThDHULzGMTUVRFf0vL9CUG3f2n+QOYmRnyNoxLGkDORPIEKicE0
         nWUj7LQTX3wHimKlx9Wrr2gy1mf7+xKz/fxka/s0zICAKJ7JSbAEOgeHib4ZeJuXTs7b
         4Inw==
X-Forwarded-Encrypted: i=1; AJvYcCWsNKyZiRl8D4FyX7RXBwXBd1CP9cS3rEN+nyXeu4LeyxZ+5GHbSbwHlibXSey7LNVzxDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdc/wo9fyysSXkJonculyvkI1OBn1cRkPxR7ogehLcUEzjNDCk
	jk2ZJp4EjjGEeSLSbRWAQVc2JxbkIe2lxrY5IqNokK1TxVUAqbGYaIu1WdBCzvkgngvTFHLXxRC
	VTlOonCPL6RBFVYuEu4zXai38F0u9vpkiUDaVyk+W
X-Gm-Gg: ASbGncsU2rMOLTeV0ETYELICjE9Lw9dq+liqupJ7Yy98QRnF57aDoXQGFSXut7htP5Z
	wqJJ6mQs5kZEBbTbmO6XvLPn0080EiDHwIlKGO3oClMjwq2MXKtl6bBxrMQ3KfEnV1AATqXoXBV
	LJe3W6J306C7coGRXE2Yn67//Fb2S5skZHxxVPSyt0jL8upUGoNCGkZlx/QGDKvpmfC089HGaM5
	H00VBniBOMZPJszxZBnviLG9cMbDIRfIf17ZUMUG+0e1BViSYqfQtqUXQ==
X-Google-Smtp-Source: AGHT+IFeJy1Ue2kDzcZqKJGgrXMi7WDoq9/lFU+pCUu2btx1Ww9dM4IvC8+tlWlmYYLF0bVLogw/J+3jaK9P12vRuh0=
X-Received: by 2002:a17:90b:2886:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-330983966f1mr2171493a91.35.1758248901349; Thu, 18 Sep 2025
 19:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917191417.1056739-1-kuniyu@google.com> <20250917191417.1056739-7-kuniyu@google.com>
 <a706bb87-46e1-4524-8d35-8f22569a73e7@linux.dev> <CAAVpQUCoMkkGrPfqiL4C_3i5EG_THaYb0gT+qF7jyxreBJTSZw@mail.gmail.com>
 <eacd9a90-8c80-4e23-a193-f09d96fe24ee@linux.dev>
In-Reply-To: <eacd9a90-8c80-4e23-a193-f09d96fe24ee@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 19:28:10 -0700
X-Gm-Features: AS18NWDKMNPmXcswvtm1eocFpjYrtLGXxFIM2OCw897o_xHn9ndsJ3KY2Oz4RX4
Message-ID: <CAAVpQUBPxhBSPwW3jKVGNunmz7-MHwnRgL1RCjSA-WqvnJmGDg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next/net 6/6] selftest: bpf: Add test for SK_MEMCG_EXCLUSIVE.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:14=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/17/25 6:17 PM, Kuniyuki Iwashima wrote:
> >>> +
> >>> +close:
> >>> +     for (i =3D 0; i < ARRAY_SIZE(sk); i++)
> >>> +             close(sk[i]);
> >>> +
> >>> +     if (test_case->type =3D=3D SOCK_DGRAM) {
> >>> +             /* UDP recv queue is destroyed after RCU grace period.
> >>> +              * With one kern_sync_rcu(), memory_allocated[0] of the
> >>> +              * isoalted case often matches with memory_allocated[1]
> >>> +              * of the preceding non-exclusive case.
> >>> +              */
> >> I don't think I understand the double kern_sync_rcu() below.
> > With one kern_sync_rcu(), when I added bpf_printk() for memory_allocate=
d,
> > I sometimes saw two consecutive non-zero values, meaning memory_allocat=
ed[0]
> > still see the previous test case result (memory_allocated[1]).
> > ASSERT_LE() succeeds as expected, but somewhat unintentionally.
> >
> > bpf_trace_printk: memory_allocated: 0 <-- non exclusive case
> > bpf_trace_printk: memory_allocated: 4160
> > bpf_trace_printk: memory_allocated: 4160 <-- exclusive case's
> > memory_allocated[0]
> > bpf_trace_printk: memory_allocated: 0
> > bpf_trace_printk: memory_allocated: 0
> > bpf_trace_printk: memory_allocated: 0
> >
> > One kern_sync_rcu() is enough to kick call_rcu() + sk_destruct() but
> > does not guarantee that it completes, so if the queue length was too lo=
ng,
> > the memory_allocated does not go down fast enough.
> >
> > But now I don't see the flakiness with NR_SEND 32, and one
> > kern_sync_rcu() might be enough unless the env is too slow...?
>
> Ah, got it. I put you in the wrong path. It needs rcu_barrier() instead.
>
> Is recv() enough? May be just recv(MSG_DONTWAIT) to consume it only for U=
DP
> socket? that will slow down the udp test... only read 1 byte and the rema=
ining
> can be MSG_TRUNC?

recv() before close() seems to work with fewer sockets (with the same
bytes of send()s and without kern_sync_rcu()).

And the test time was mostly the same with "no recv() + 1 kern_sync_rcu()"
case (2~2.5s on my qemu), so draining seems better.

#define NR_PAGES        128
#define NR_SOCKETS      2
#define BUF_TOTAL       (NR_PAGES * 4096 / (NR_SOCKETS / 2))
#define BUF_SINGLE      1024
#define NR_SEND         (BUF_TOTAL / BUF_SINGLE)

NR_SOCKET=3D=3D64
      test_progs-1380    [008] ...11  2121.731176: bpf_trace_printk:
memory_allocated: 0
      test_progs-1380    [008] ...11  2121.737700: bpf_trace_printk:
memory_allocated: 576
      test_progs-1380    [008] ...11  2121.743436: bpf_trace_printk:
memory_allocated: 64
      test_progs-1380    [008] ...11  2121.749984: bpf_trace_printk:
memory_allocated: 64
      test_progs-1380    [008] ...11  2121.755763: bpf_trace_printk:
memory_allocated: 64
      test_progs-1380    [008] ...11  2121.762171: bpf_trace_printk:
memory_allocated: 64

NR_SOCKET=3D=3D2
      test_progs-1424    [009] ...11  2352.990520: bpf_trace_printk:
memory_allocated: 0
      test_progs-1424    [009] ...11  2352.997395: bpf_trace_printk:
memory_allocated: 514
      test_progs-1424    [009] ...11  2353.001910: bpf_trace_printk:
memory_allocated: 2
      test_progs-1424    [009] ...11  2353.008947: bpf_trace_printk:
memory_allocated: 2
      test_progs-1424    [009] ...11  2353.012988: bpf_trace_printk:
memory_allocated: 2
      test_progs-1424    [009] ...11  2353.019988: bpf_trace_printk:
memory_allocated: 0

While NR_PAGES sets to 128, the actual allocated page was around 300 for
TCP and 500 for UDP.  I reduced NR_PAGES to 64, then TCP consumed 160
pages, and UDP consumed 250, but test time didn't change.

>
> btw, does the test need 64 sockets? is it because of the per socket snd/r=
cvbuf
> limitation?

I chose 64 for UDP that does not tune rcvbuf automatically, but I saw an er=
ror
when I increased the number of send() bytes and set SO_RCVBUF anyway,
so any number of sockets is fine now.

I'll use 2 sockets but will keep for-loops so that we can change NR_SOCKETS
easily when the test gets flaky.


>
> Another option is to trace SEC("fexit/__sk_destruct") to ensure all the c=
leanup
> is done but seems overkill if recv() can do.

Agreed, draining before close() would be enough.

