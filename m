Return-Path: <bpf+bounces-68902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD0B87BD4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFAA3B2CF7
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670A2586FE;
	Fri, 19 Sep 2025 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKBdAU1o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B3221294
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249829; cv=none; b=HsllNQ684R5txKUkdUU+JzAQAucdfOnj9Buo+g7wuBZ+wxFh5hDp5jgZ9fc1WM8tayEBdva3puRKMe9DWB8Y5cOt5k5e9zkKcn8RQY1P3aB6kv30SR2yDpbWt2NMq58z7B7k8NucivzOOhyrzeEUdWpha4lXVEeV/PfVj8svg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249829; c=relaxed/simple;
	bh=GDZO4fpRU9wSaTK0EdkpfoIEuo0Xs0ua7agbpazvbFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMnhxL3AvgiyvHO4jDqqNa1IL5I1gLurto8sCaoEpt+3tTaSJ7nU9zExjOlcBxZb906xi4WFi05ROx2PcTdJcstf05KQ/xcEo4jdaqVxmkb3doMEpWFFCf6AwzKpVzF+sI/KLRDqmFWimayztPQ8DHmeuOFdttZdRzRJnpkTIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKBdAU1o; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so1242756a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758249826; x=1758854626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Soz4JX15SRGUkBtt0ayqGs44vNxXP9Mldj6k8YW6gYM=;
        b=MKBdAU1o8V/HlUv12rYImmkZGiVlXrk71TVSO3aMVK/sR/W0+OQAafk8NU4BJwQXnd
         BX5U9TS4/peyIh5UuLRfZhgYXjvBZdxUXO8ASeepthYrAsLLqzmsvAfXBq1APIWBplPt
         WeIGQWZZr3uKXH03cfdfr3ctzepHDT4kEfC7tbSZYeWbXy1kSmsYnfGdw8sONCTYb7Nh
         UpmXQtFowyvCL/mhl+9DEDRXpMciLoNxtL0mSF770Az2/3Cuhctxgd3vddCHelsRLP+b
         C59mxk5bnhfGlNqNsuXKTz9+hqP4IGc6zrGxfjC9ZJL/1yHCd67gB/A6+TWp0RA5Pa+b
         sZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758249826; x=1758854626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Soz4JX15SRGUkBtt0ayqGs44vNxXP9Mldj6k8YW6gYM=;
        b=LcAKx2VR+7Z9iSFD9pJBgllZA8NPlnJ+i91kRrKVXmiUDpJbVUKAE1MVS00uXdgQMX
         DT0n5aZ9WLkecz8iZKBws84jq0w3++DiNI6IB/Dg0vYyHQB0RzWVWlEFdydJ98s82I+r
         iZkgGk47aahlpWAJnHFz/8p8LhakfZdVogq/tEy45xBeeSU+izeb8vOV2mGlp8h3XNxx
         AHn6TICjRbaxxqEZ/Z0Z8F0VG8B2p+SdrnUz/o6XGTBlpXXCDOmAxc6s9lJQVS4elo24
         lkfaYyMTUBwb8LJKXVE1JDJ/fabSTgUgdJ3iHXDNSLO5sil6DjtxaBF+SfbUKk4lxfQS
         5PEg==
X-Forwarded-Encrypted: i=1; AJvYcCV2LW3wJ6b/YUX729jHgezLcHfzOvb3+mpIKnDAe29d1HiP+AGc9Tg4KxjfPVClY2domS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5yINrE0WUaQUqlTxOr8VWOymb0NPMlMcuLtjTbvnvCrceEvv
	dlsCfx8nargXR/wJSSIfZI7WCArmq81Irf7Az1kwi17WsCm2+T0hJMrECYCdqU5uxJKl5XDlwoG
	30kmw6ZyN6ZS6RcCYPoF4h2HQimtUzWqrbzujtoW7
X-Gm-Gg: ASbGncvGKCjj9UgKMMbgsdHJsyOnpaed9Chyhcm4EtE9OgFywf9slQQBU849KU8HWBr
	TeaR5tffqmpi20DeZVbcsAJJJGmQiNXq9z7LZVTo2KRgDFfCx45dH/HDIwKvJZWJc7v6q0pCDq6
	o94k6SS3fJkjwBa3W+sf1qnRox/locPE73B8leFvAMY9O2kRxL7WOsw73kgCPUFLEuywtR8nLx7
	Rx9GGwXQl61Mw6u2ltp52Yy0jUnolfqS/8q/ySdpzgudz3c0tG+YO7puA==
X-Google-Smtp-Source: AGHT+IE8KAeqGER8zXyWKpAah4whuUHXcS4vaVD+MjnwjHhbtVKouIyr/3rvlvLcl8Tgl8dxdzxfromlhTvKskQjJHQ=
X-Received: by 2002:a17:90a:e7d2:b0:32d:f315:7b51 with SMTP id
 98e67ed59e1d1-33093571d94mr2365970a91.12.1758249825940; Thu, 18 Sep 2025
 19:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917191417.1056739-1-kuniyu@google.com> <20250917191417.1056739-7-kuniyu@google.com>
 <a706bb87-46e1-4524-8d35-8f22569a73e7@linux.dev> <CAAVpQUCoMkkGrPfqiL4C_3i5EG_THaYb0gT+qF7jyxreBJTSZw@mail.gmail.com>
 <eacd9a90-8c80-4e23-a193-f09d96fe24ee@linux.dev> <CAAVpQUBPxhBSPwW3jKVGNunmz7-MHwnRgL1RCjSA-WqvnJmGDg@mail.gmail.com>
In-Reply-To: <CAAVpQUBPxhBSPwW3jKVGNunmz7-MHwnRgL1RCjSA-WqvnJmGDg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 19:43:34 -0700
X-Gm-Features: AS18NWBTsusIJpSJZk1FvmHCfdeBTRTop720OB2n1nE7hVTkRsKcrhb3WAlZw40
Message-ID: <CAAVpQUBmhMzESPMOBzr=e+kORPZi5XCHR7_DgqtijsyKsmPviw@mail.gmail.com>
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

On Thu, Sep 18, 2025 at 7:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Sep 18, 2025 at 6:14=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 9/17/25 6:17 PM, Kuniyuki Iwashima wrote:
> > >>> +
> > >>> +close:
> > >>> +     for (i =3D 0; i < ARRAY_SIZE(sk); i++)
> > >>> +             close(sk[i]);
> > >>> +
> > >>> +     if (test_case->type =3D=3D SOCK_DGRAM) {
> > >>> +             /* UDP recv queue is destroyed after RCU grace period=
.
> > >>> +              * With one kern_sync_rcu(), memory_allocated[0] of t=
he
> > >>> +              * isoalted case often matches with memory_allocated[=
1]
> > >>> +              * of the preceding non-exclusive case.
> > >>> +              */
> > >> I don't think I understand the double kern_sync_rcu() below.
> > > With one kern_sync_rcu(), when I added bpf_printk() for memory_alloca=
ted,
> > > I sometimes saw two consecutive non-zero values, meaning memory_alloc=
ated[0]
> > > still see the previous test case result (memory_allocated[1]).
> > > ASSERT_LE() succeeds as expected, but somewhat unintentionally.
> > >
> > > bpf_trace_printk: memory_allocated: 0 <-- non exclusive case
> > > bpf_trace_printk: memory_allocated: 4160
> > > bpf_trace_printk: memory_allocated: 4160 <-- exclusive case's
> > > memory_allocated[0]
> > > bpf_trace_printk: memory_allocated: 0
> > > bpf_trace_printk: memory_allocated: 0
> > > bpf_trace_printk: memory_allocated: 0
> > >
> > > One kern_sync_rcu() is enough to kick call_rcu() + sk_destruct() but
> > > does not guarantee that it completes, so if the queue length was too =
long,
> > > the memory_allocated does not go down fast enough.
> > >
> > > But now I don't see the flakiness with NR_SEND 32, and one
> > > kern_sync_rcu() might be enough unless the env is too slow...?
> >
> > Ah, got it. I put you in the wrong path. It needs rcu_barrier() instead=
.
> >
> > Is recv() enough? May be just recv(MSG_DONTWAIT) to consume it only for=
 UDP
> > socket? that will slow down the udp test... only read 1 byte and the re=
maining
> > can be MSG_TRUNC?
>
> recv() before close() seems to work with fewer sockets (with the same
> bytes of send()s and without kern_sync_rcu()).
>
> And the test time was mostly the same with "no recv() + 1 kern_sync_rcu()=
"
> case (2~2.5s on my qemu), so draining seems better.

Oh no, with NR_PAGES 128, "no recv() + 1kern_syn_rcu()" didn't
show the leftover at all, regardless of NR_SOCKETS=3D=3D2 or 64.
But this might be only on my setup, and recv() before close()
could be stable on any setup theoretically.

fwiw, I put the latest code here.
https://github.com/q2ven/linux/commits/514_tcp_decouple_memcg

>
> #define NR_PAGES        128
> #define NR_SOCKETS      2
> #define BUF_TOTAL       (NR_PAGES * 4096 / (NR_SOCKETS / 2))
> #define BUF_SINGLE      1024
> #define NR_SEND         (BUF_TOTAL / BUF_SINGLE)
>
> NR_SOCKET=3D=3D64
>       test_progs-1380    [008] ...11  2121.731176: bpf_trace_printk:
> memory_allocated: 0
>       test_progs-1380    [008] ...11  2121.737700: bpf_trace_printk:
> memory_allocated: 576
>       test_progs-1380    [008] ...11  2121.743436: bpf_trace_printk:
> memory_allocated: 64
>       test_progs-1380    [008] ...11  2121.749984: bpf_trace_printk:
> memory_allocated: 64
>       test_progs-1380    [008] ...11  2121.755763: bpf_trace_printk:
> memory_allocated: 64
>       test_progs-1380    [008] ...11  2121.762171: bpf_trace_printk:
> memory_allocated: 64
>
> NR_SOCKET=3D=3D2
>       test_progs-1424    [009] ...11  2352.990520: bpf_trace_printk:
> memory_allocated: 0
>       test_progs-1424    [009] ...11  2352.997395: bpf_trace_printk:
> memory_allocated: 514
>       test_progs-1424    [009] ...11  2353.001910: bpf_trace_printk:
> memory_allocated: 2
>       test_progs-1424    [009] ...11  2353.008947: bpf_trace_printk:
> memory_allocated: 2
>       test_progs-1424    [009] ...11  2353.012988: bpf_trace_printk:
> memory_allocated: 2
>       test_progs-1424    [009] ...11  2353.019988: bpf_trace_printk:
> memory_allocated: 0
>
> While NR_PAGES sets to 128, the actual allocated page was around 300 for
> TCP and 500 for UDP.  I reduced NR_PAGES to 64, then TCP consumed 160
> pages, and UDP consumed 250, but test time didn't change.
>
> >
> > btw, does the test need 64 sockets? is it because of the per socket snd=
/rcvbuf
> > limitation?
>
> I chose 64 for UDP that does not tune rcvbuf automatically, but I saw an =
error
> when I increased the number of send() bytes and set SO_RCVBUF anyway,
> so any number of sockets is fine now.
>
> I'll use 2 sockets but will keep for-loops so that we can change NR_SOCKE=
TS
> easily when the test gets flaky.
>
>
> >
> > Another option is to trace SEC("fexit/__sk_destruct") to ensure all the=
 cleanup
> > is done but seems overkill if recv() can do.
>
> Agreed, draining before close() would be enough.

