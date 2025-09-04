Return-Path: <bpf+bounces-67499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D3B44750
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 22:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD916CB83
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFE28031D;
	Thu,  4 Sep 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsvzQEgu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B020327FD6E
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017765; cv=none; b=cd6xP+3twyvxW8RzlAgqlW68jMlYzvrkm+OpwXrCj4ioaZVHBnhNCF+Fma1YfIpNg3KZrWEFUoDq5pPLV+RZ+yvF6dpyRfZHaUl/b246PL+IBkWCgdHyMJ/f3CZ73ubyrsy72lr5t3bdj45qIVUS0/i68KCNCyIwbJGx2gXH5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017765; c=relaxed/simple;
	bh=se8SYT0zJTJAzPl7zJgMNfbY7t89aC3dE7YmRyqLsBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BelLt6lmmomjkgOI8G8FnRAgqbZXOFUJ44XsYfFfSVX1DdUKj6f22ufNjGhwShBaeZf8ZOZNgXKtGseKfNRvTH3PG2Dk3X9IgOV3/gMYO2qEMA9C4j1uQPBjbu2HT2QemOb+ljAhqszfuOh+ggCkQGkyS7oqN3qFwuU51JfhXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YsvzQEgu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24cdbeca71eso5619695ad.2
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757017761; x=1757622561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAfDLvW/qtjfI9Qhx/Ik6vG7JX89+OS8OERkeUrIYts=;
        b=YsvzQEgukuZRYTvYKXfLV90DHCHPL3+vNmzYz9Pd2i8Hb7MMONZQjq3kcIzlmRhi5F
         eOcEUTnCGCgdbatwlQfX2+4pYxFxNSjuEiyH3E6jVGzl3A6kgnbc7vKMjvXDlkhrJ6dr
         /DmCcYnYoHHWUtP/pQTwFr7jhghKVhDel/ViiYcL3zYlbPRkVnPTkZXfiVdioKY4extr
         hPABRLkr1qXi5+rSrdriFhKuQ6bMigxwoDafcmqY/ghVeM+WiWx6eofleLh9kTEweGRW
         iTQl8w78QotrZbhMg2DcuySP1zRdvVEEozP0lYnXFveGDnIkXb6AWgiblEfZyQcgj08b
         /VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017761; x=1757622561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAfDLvW/qtjfI9Qhx/Ik6vG7JX89+OS8OERkeUrIYts=;
        b=NRpYWEQHqDyPyXp59e+NqadQsrE7UKAYL3bcb81XVVNMwo3pJcGdrdceWzvRUKDDVg
         ltGNM3npe8UAmTy6P1N+22pUzWYFlW5Y76bbhz7bjlbdenoVO4gRPrPPBITr9Dngq57T
         4tOrZjc8HdbHSmcDK7p7v1+YAeSal0Wv85DHh1A7fKCxHmaMnW0+KeIROP5xKVe4LaU1
         vXLsYg9SGn3N4u8GZOhV3u5NVYXMtd4SDIPzb5kaZlpkfsZyGz36XOuhG3zlCZiOChEg
         RdYLPrMkNYdXvpvf6K0nzBzaSrqQ5taswOWmuA6f3vbe/4lL/4EWqnu9RP7iIPrB+Pwe
         zo5w==
X-Forwarded-Encrypted: i=1; AJvYcCXt/xP/eE8HvkTDunCzHgSYrA7ZZg4DdvmFoKOgREQob3WlWf3HNavXb7RxgB4656kWsKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GNY8uOU/DUnCT8qRrNyV9d+VCx756UhXfs3QVidL9tYAHJ+1
	r6yTtCChNm9iePj1QE541jTZsRdXASl9Qtr/5T6/50zfTtze4zF+iHyzdYjK6U40/iuXNA0Wr5I
	jr/fh3vbOfB3hMRWgqsyP8sksTCAlagFYFykQEtPf
X-Gm-Gg: ASbGncvO2rebwL8h9bObQSyoFgeM4JyeueNRgOEJCJmODmKf923hszxTlvM3fOVIG1s
	560l5ls1x6iyKseReEMuukfvj+u4C5K4U99YpuLNcAyYt3UKHk7VzCSViufZguak+YrlCXB3Koa
	cLI7BYWG7VuwAm4L/oH11uqwWD3S2umuxBWAYdgCyvSx2N8c+WDTM3aiIg8rj5Mn7s4AVrwThRA
	FB4HC7kQGHy1DXeLZuQdVybYm4J1BtyxDb4CO4UagaoMRGBmrh4o5SVhsRXZB0T5Xi++OWYOQxN
	cXaxavBgJfcCEQ==
X-Google-Smtp-Source: AGHT+IG7u/5pNUo6AGseBbewB6ZMWSPZIPLT2gzvnsWk7gjT7XkAa3BdoLd0c+79Nd24DzFn1rS0d8g5f5ufNJ8utKE=
X-Received: by 2002:a17:902:ced2:b0:248:79d4:93bb with SMTP id
 d9443c01a7336-24944b0dc40mr321307565ad.31.1757017760476; Thu, 04 Sep 2025
 13:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-6-kuniyu@google.com>
 <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev> <CAAVpQUDfQwb2nfGBV8NEONwaBAMVi_5F8+OPFX3=z+W8X9n9ZQ@mail.gmail.com>
 <CAAVpQUBWsVDu07xrQcqGMo4cHRu41zvb5CWuiUdJx9m6A+_2AQ@mail.gmail.com>
 <CAAVpQUCyPPO1dfkkU4Hxz67JFcW6dhSfYnmUp0foNMYua_doyg@mail.gmail.com>
 <40ed29b3-84d7-4812-890d-3676957d503f@linux.dev> <CAAVpQUCLpi+6w1SP=FKVaXwdDHQC_P6B1hzzDC5y4brsf3_UnQ@mail.gmail.com>
 <26939fec-b70f-4beb-8895-427db69c38a0@linux.dev>
In-Reply-To: <26939fec-b70f-4beb-8895-427db69c38a0@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 4 Sep 2025 13:29:08 -0700
X-Gm-Features: Ac12FXwyUXPN3jzgq63teCICDbAFgEj6jSPQihZ_ljUixFf9lFT57vRUe7vUKnA
Message-ID: <CAAVpQUB8DzEjfc42dMRmGA0mgsHrCtXkPnQXZpG+EQq28xOXCg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next/net 5/5] selftest: bpf: Add test for SK_BPF_MEMCG_SOCK_ISOLATED.
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

On Thu, Sep 4, 2025 at 12:48=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/4/25 9:45 AM, Kuniyuki Iwashima wrote:
> > On Wed, Sep 3, 2025 at 10:51=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 9/3/25 10:08 AM, Kuniyuki Iwashima wrote:
> >>> On Wed, Sep 3, 2025 at 9:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> >>>>
> >>>> On Tue, Sep 2, 2025 at 1:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@goo=
gle.com> wrote:
> >>>>>
> >>>>> On Tue, Sep 2, 2025 at 1:26=E2=80=AFPM Martin KaFai Lau <martin.lau=
@linux.dev> wrote:
> >>>>>>
> >>>>>> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> >>>>>>> The test does the following for IPv4/IPv6 x TCP/UDP sockets
> >>>>>>> with/without BPF prog.
> >>>>>>>
> >>>>>>>      1. Create socket pairs
> >>>>>>>      2. Send a bunch of data that requires more than 256 pages
> >>>>>>>      3. Read memory_allocated from the 3rd column in /proc/net/pr=
otocols
> >>>>>>>      4. Check if unread data is charged to memory_allocated
> >>>>>>>
> >>>>>>> If BPF prog is attached, memory_allocated should not be changed,
> >>>>>>> but we allow a small error (up to 10 pages) in case other process=
es
> >>>>>>> on the host use some amounts of TCP/UDP memory.
> >>>>>>>
> >>>>>>> At 2., the test actually sends more than 1024 pages because the s=
ysctl
> >>>>>>> net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages=
 are
> >>>>>>> buffered per cpu before reporting to sk->sk_prot->memory_allocate=
d.
> >>>>>>>
> >>>>>>>      BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
> >>>>>>>      =3D 1024 pages
> >>>>>>>
> >>>>>>> When I reduced it to 512 pages, the following assertion for the
> >>>>>>> non-isolated case got flaky.
> >>>>>>>
> >>>>>>>      ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ..=
.)
> >>>>>>>
> >>>>>>> Another contributor to slowness is 150ms sleep to make sure 1 RCU
> >>>>>>> grace period passes because UDP recv queue is destroyed after tha=
t.
> >>>>>>
> >>>>>> There is a kern_sync_rcu() in testing_helpers.c.
> >>>>>
> >>>>> Nice helper :)  Will use it.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>      # time ./test_progs -t sk_memcg
> >>>>>>>      #370/1   sk_memcg/TCP       :OK
> >>>>>>>      #370/2   sk_memcg/UDP       :OK
> >>>>>>>      #370/3   sk_memcg/TCPv6     :OK
> >>>>>>>      #370/4   sk_memcg/UDPv6     :OK
> >>>>>>>      #370     sk_memcg:OK
> >>>>>>>      Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >>>>>>>
> >>>>>>>      real       0m1.214s
> >>>>>>>      user       0m0.014s
> >>>>>>>      sys        0m0.318s
> >>>>>>
> >>>>>> Thanks. It finished much faster in my setup also comparing with th=
e earlier
> >>>>>> revision. However, it is a bit flaky when I run it in a loop:
> >>>>>>
> >>>>>> check_isolated:FAIL:not isolated unexpected not isolated: actual 8=
61 <=3D expected 861
> >>>>>>
> >>>>>> I usually can hit this at ~40-th iteration.
> >>>>>
> >>>>> Oh.. I tested ~10 times manually but will try in a tight loop.
> >>>>
> >>>> This didn't reproduce on my QEMU with/without --enable-kvm.
> >>>>
> >>>> Changing the assert from _GT to _GE will address the very case
> >>>> above, but I'm not sure if it's enough.
> >>>
> >>> I doubled NR_SEND and it was still faster with kern_sync_rcu()
> >>> than usleep(), so I'll simply double NR_SEND in v5
> >>>
> >>> # time ./test_progs -t sk_memcg
> >>> ...
> >>> Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >>> real 0m0.483s
> >>> user 0m0.010s
> >>> sys 0m0.191s
> >>>
> >>>
> >>>>
> >>>> Does the bpf CI run tests repeatedly or is this only a manual
> >>>> scenario ?
> >>
> >> I haven't seen bpf CI hit it yet. It is in my manual bash while loop. =
It should
> >> not be dismissed so easily. Some flaky CI tests were eventually reprod=
uced in a
> >> loop before and fixed. I kept the bash loop continue this time until g=
rep-ed a
> >> "0" from the error output:
> >>
> >> check_isolated:FAIL:not isolated unexpected not isolated: actual 0 <=
=3D expected 256
> >>
> >> The "long memory_allocated[2]" read from /proc/net/protocols are print=
ed as 0
> >> but it is probably actually negative:
> >>
> >> static inline long
> >> proto_memory_allocated(const struct proto *prot)
> >> {
> >>           return max(0L, atomic_long_read(prot->memory_allocated));
> >> }
> >>
> >> prot->memory_allocated could be negative afaict but printed as 0 in
> >> /proc/net/protocols. Even the machine is network quiet after test_prog=
s started,
> >> the "prot->memory_allocated" and the "proto->per_cpu_fw_alloc" could b=
e in some
> >> random states before the test_progs start.  When I hit "0", it will ta=
ke some
> >> efforts to send some random traffic to the machine to get the test wor=
king again. :(
> >>
> >> Also, after reading the selftest closer, I am not sure I understand wh=
y "+ 256".
> >> The "proto-> per_cpu_fw_alloc" can start with -255 or +255.
> >
> > Actually I didn't expect the random state and assumed the test's
> > local communication would complete on the same CPU thus 0~255.
> >
> > Do you see the flakiness with net.core.mem_pcpu_rsv=3D0 ?
> >
> > The per-cpu cache is just for performance and I think it's not
> > critical for testing and it's fine to set it to 0 during the test.
> >
> >
> >>
> >> I don't think changing NR_SEND help here. It needs a better way. May b=
e some
> >> functions can be traced such that prot->memory_allocated can be read d=
irectly?
> >> If fentry and fexit of that function has different memory_allocated va=
lues, then
> >> the test could also become more straight forward.
> >
> > Maybe like this ?  Not yet tested, but we could attach a prog to
> > sock_init_data() or somewhere else and trigger it by additional socket(=
2).
> >
> >          memory_allocated =3D sk->sk_prot->memory_allocated;
> >          nr_cpu =3D bpf_num_possible_cpus();
> >
> >          for (i =3D 0; i < nr_cpu; i++) {
> >                  per_cpu_fw_alloc =3D
> > bpf_per_cpu_ptr(sk->sk_prot->per_cpu_fw_alloc, i);
>
> I suspect passing per_cpu_fw_alloc to bpf_per_cpu_ptr won't work for now.=
 sk is
> trusted if it is a "tp_btf" but I don't think the verifier recognizes the
> sk->sk_prot is a trusted ptr. I haven't tested it though. If the above do=
es not
> work, try to directly use the global percpu tcp_memory_per_cpu_fw_alloc. =
Take a
> look at how "bpf_prog_active" is used in test_ksyms_btf.c.

Thanks for the pointer !
I was looking for a way to read global vars.

>
> >                  if (per_cpu_fw_alloc)
> >                          memory_allocated +=3D *per_cpu_fw_alloc;
>
> Yeah. I think figuring out the true memory_allocated value and use it as =
the
> before/after value should be good enough. Then no need to worry about the
> initial states. I wonder why proto_memory_allocated() does not do that fo=
r
> /proc/net/protocols but I guess it may not be accurate for a lot of cores=
.

Probably, and per_cpu_fw_alloc is expected to flip quickly.

>
> >          }
> >
> > per_cpu_fw_alloc might have been added to sk_prot->memory_allocated
> > during loop, so it's not 100% accurate still.
> >
> > Probably we should set net.core.mem_pcpu_rsv=3D0 and stress
> > memory_allocated before the actual test to drain per_cpu_fw_alloc
> > (at least on the testing CPU).
> I think the best is if a suitable kernel func can be traced or figure out=
 the
> true memory_allocated value. At least figuring out the true memory_alloca=
ted
> seems doable. If nothing of the above works out, mem_pcpu_rsv=3D0 and
> pre-stress/pre-flush should help by getting the per_cpu_fw_alloc and
> memory_allocated to some certain states before using it in the before/aft=
er result.
>
> [ Before re-spinning, need to conclude/resolve the on-going discussion in=
 v5 first ]

I'll wait for Shakeel's response for v5.

