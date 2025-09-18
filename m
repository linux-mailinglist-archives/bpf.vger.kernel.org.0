Return-Path: <bpf+bounces-68726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D609AB827B9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 03:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE0916ABB8
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 01:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7CD1F130A;
	Thu, 18 Sep 2025 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mtsx+5En"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617431A5BBC
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158248; cv=none; b=jcysxFZaBaPdDJfLTTHsNW42qVzBTWuxNr2ds+dIkJ38yNGv/lQhSBtWDaxCoo08K9MGtY/QybGeKurmANNQlVXpk2y+am/9MBkNIX53/IB1bJa7DtwFZRji/vNg2JdjSlxjPMlRxyu/YZNn5PI0THAB19aQ58tG/Bkpxpa4SSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158248; c=relaxed/simple;
	bh=/oCEoggO1dtFutY+yW+4yO9fg4wemEWgbC8S+7pfNdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZEvW4N2vu/7hICVwkmkftCn/OCLDjytZuMSRMRi3aW4XTsbKccrRsh9P+zTGe8mb+Fmx98/9yNwufHpW6kG9wtesoFEHsLjO/A9Is8FHWTCN7e4/hs7nBdeKlBXmqx+2tyyrB2dzZepwfkXT7XY7oGELzsKQ6Zbx3IseQbe48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mtsx+5En; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26983b5411aso2273415ad.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758158245; x=1758763045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g50yW/d3ElQAO/Jvye41z7gapCQUdCeAu/F790gUCRY=;
        b=Mtsx+5EnXOX6okXtlUCXTywDPKLblg4OmgRFNIwNopC8Z2o1LH5NQ0dUmLwt9gFK7k
         Q+aqG8TICr+m3T026UkwuqVgwsnEhSz/s8PeSRZ6xnA0JUCpVBJd32w7yL+DJqUGuzms
         hw/vzog6ChKruAr556LUsKnWEep5n8ekWxDE+foOlx/kGrke7zpLLn7T9fX6XGvWah/d
         3TWF+ROI8CAXXUomM8/Ud3vj1eCQTmPQ2UDg8UivaiPgd4J5zoKwlCXjdMNCzfJKbbrj
         vp0V2sK60JW0rpp3+MxML5lw9qzSowZE0OWT+LrZBwyNo7q+Um7QQLrCtZhpDMiGf+0c
         uT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758158245; x=1758763045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g50yW/d3ElQAO/Jvye41z7gapCQUdCeAu/F790gUCRY=;
        b=YcYJLnslRS5krqEpqX4z8f2IstXlgyR0tMiSCRwoT1KlBvExNzNqtmrjJ2AuX6Ekww
         LZhqoD7BRqdtVQNGCc/mDjbzXXgLEjEA/LVDfgS29HcEuHasAyPOgE3gcvc9MCt8slFG
         73YAxJcikNdo6aMjVcamedZGJcbrDOxfzRkPtrcn659YtryqHkV9cmnBq7d9Jeay+wml
         7zdHaKeUUQBC7MvU2Jn4ryxLNvCLjntoafRKU5/f2UDppqqqDqFPGjTBL25UnjMoVanS
         B61EgUBdc//6rd+nOMUrbtBkGKfMtdhO6iZX/C2yJ5FXUjxgGDKdCBz0cdXW/PIgmt+y
         k+mg==
X-Forwarded-Encrypted: i=1; AJvYcCXNhEQMj9+Gm/7d3ENrumq3Er82PCoCROsjCAWCjjHT8MpLv4S0qByPhInngKDaJXC5wiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OPI9bYGPKaVW5O3vjDZB+tOBZW9ve5Vq7o9bVevUhrK1lmUk
	OBrTY4EBRxmy52ga28A9Wx5MxL14JnrJTdhTNBAyigslhXqVuBewFyiA3vY/OyKfBbokXf0o47T
	D0BiSCaBrkY91Auo0U2kqWeQ2nThfX5T/VVlWZSET
X-Gm-Gg: ASbGncscYlXxL4D7DcjhCncIKDZ+T2uhXV6v33E1hJw/5IKa49XCzCR/6WyRTYTa7jg
	GH/AU7qw5WtcV/FpPtgVIUPUT9VYYG0sZdC44tA+Rnu4ahynRH9RGcftGgrEmQWA6tuwfLVKQpq
	O9fhP7JTyHWY5LcKAgoSpz2oTj8Dyd0/4Pw3DdyXdkmNoqeaXecAkgILcmjvU1TEbgKmqweOpI6
	ghvl7iY1EuMezwpxoqiAdHEcQ7tC4la1A==
X-Google-Smtp-Source: AGHT+IEKHGW5Iqzj67tupP3oSdsmnZf4kgJEAfamEYnWofjqIwReaHQ/eNIT2+IbXEvfw6oOFbgStp8Tbg3I49ZxXxc=
X-Received: by 2002:a17:902:d591:b0:25b:dcbf:43a2 with SMTP id
 d9443c01a7336-26813bf1de5mr54699095ad.52.1758158245220; Wed, 17 Sep 2025
 18:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917191417.1056739-1-kuniyu@google.com> <20250917191417.1056739-7-kuniyu@google.com>
 <a706bb87-46e1-4524-8d35-8f22569a73e7@linux.dev>
In-Reply-To: <a706bb87-46e1-4524-8d35-8f22569a73e7@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 18:17:13 -0700
X-Gm-Features: AS18NWDuXlRa-0koED8uOUG3BNI8OyfZcez25qqzgzks6eAVV4nGsEppYNAIjIo
Message-ID: <CAAVpQUCoMkkGrPfqiL4C_3i5EG_THaYb0gT+qF7jyxreBJTSZw@mail.gmail.com>
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

On Wed, Sep 17, 2025 at 4:38=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/17/25 12:14 PM, Kuniyuki Iwashima wrote:
> > The test does the following for IPv4/IPv6 x TCP/UDP sockets
> > with/without SK_MEMCG_EXCLUSIVE, which can be turned on by
> > net.core.memcg_exclusive or bpf_setsockopt(SK_BPF_MEMCG_EXCLUSIVE).
> >
> >    1. Create socket pairs
> >    2. Send a bunch of data that requires more than 1024 pages
> >    3. Read memory_allocated from sk->sk_prot->memory_allocated and
> >       sk->sk_prot->memory_per_cpu_fw_alloc
> >    4. Check if unread data is charged to memory_allocated
> >
> > If SK_MEMCG_EXCLUSIVE is set, memory_allocated should not be
> > changed, but we allow a small error (up to 10 pages) in case
> > other processes on the host use some amounts of TCP/UDP memory.
> >
> > The amount of allocated pages are buffered to per-cpu variable
> > {tcp,udp}_memory_per_cpu_fw_alloc up to +/- net.core.mem_pcpu_rsv
> > before reported to {tcp,udp}_memory_allocated.
> >
> > At 3., memory_allocated is calculated from the 2 variables twice
> > at fentry and fexit of socket create function to check if the per-cpu
> > value is drained during calculation.  In that case, 3. is retried.
> >
> > We use kern_sync_rcu() for UDP because UDP recv queue is destroyed
> > after RCU grace period.
> >
> > The test takes ~2s on QEMU (64 CPUs) w/ KVM but takes 6s w/o KVM.
> >
> >    # time ./test_progs -t sk_memcg
> >    #370/1   sk_memcg/TCP  :OK
> >    #370/2   sk_memcg/UDP  :OK
> >    #370/3   sk_memcg/TCPv6:OK
> >    #370/4   sk_memcg/UDPv6:OK
> >    #370     sk_memcg:OK
> >    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >
> >    real       0m1.623s
> >    user       0m0.165s
> >    sys        0m0.366s
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v7:
> >    * Add test for sysctl
> >
> > v6:
> >    * Trace sk_prot->memory_allocated + sk_prot->memory_per_cpu_fw_alloc
> >
> > v5:
> >    * Use kern_sync_rcu()
> >    * Double NR_SEND to 128
> >
> > v4:
> >    * Only use inet_create() hook
> >    * Test bpf_getsockopt()
> >    * Add serial_ prefix
> >    * Reduce sleep() and the amount of sent data
> > ---
> >   .../selftests/bpf/prog_tests/sk_memcg.c       | 261 +++++++++++++++++=
+
> >   tools/testing/selftests/bpf/progs/sk_memcg.c  | 146 ++++++++++
> >   2 files changed, 407 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_memcg.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/sk_memcg.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sk_memcg.c b/tools/=
testing/selftests/bpf/prog_tests/sk_memcg.c
> > new file mode 100644
> > index 000000000000..777fb81e9365
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/sk_memcg.c
> > @@ -0,0 +1,261 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright 2025 Google LLC */
> > +
> > +#include <test_progs.h>
> > +#include "sk_memcg.skel.h"
> > +#include "network_helpers.h"
> > +
> > +#define NR_SOCKETS   64
> > +#define NR_SEND              128
> > +#define BUF_SINGLE   1024
> > +#define BUF_TOTAL    (BUF_SINGLE * NR_SEND)
> > +
> > +struct test_case {
> > +     char name[8];
> > +     int family;
> > +     int type;
> > +     int (*create_sockets)(struct test_case *test_case, int sk[], int =
len);
> > +     long (*get_memory_allocated)(struct test_case *test_case, struct =
sk_memcg *skel);
> > +};
> > +
> > +static int tcp_create_sockets(struct test_case *test_case, int sk[], i=
nt len)
> > +{
> > +     int server, i;
> > +
> > +     server =3D start_server(test_case->family, test_case->type, NULL,=
 0, 0);
> > +     ASSERT_GE(server, 0, "start_server_str");
> > +
> > +     for (i =3D 0; i < len / 2; i++) {
> > +             sk[i * 2] =3D connect_to_fd(server, 0);
> > +             if (!ASSERT_GE(sk[i * 2], 0, "connect_to_fd"))
> > +                     return sk[i * 2];
> > +
> > +             sk[i * 2 + 1] =3D accept(server, NULL, NULL);
> > +             if (!ASSERT_GE(sk[i * 2 + 1], 0, "accept"))
> > +                     return sk[i * 2 + 1];
> > +     }
> > +
> > +     close(server);
> > +
> > +     return 0;
> > +}
> > +
> > +static int udp_create_sockets(struct test_case *test_case, int sk[], i=
nt len)
> > +{
> > +     int i, err, rcvbuf =3D BUF_TOTAL;
> > +
> > +     for (i =3D 0; i < len / 2; i++) {
>
> nit. How about "for (i =3D 0; i < len; i +=3D 2) {" once here instead of =
"i * 2"
> below. Same for the tcp_create_sockets() above.

Will do.


>
> > +             sk[i * 2] =3D start_server(test_case->family, test_case->=
type, NULL, 0, 0);
> > +             if (!ASSERT_GE(sk[i * 2], 0, "start_server"))
> > +                     return sk[i * 2];
> > +
> > +             sk[i * 2 + 1] =3D connect_to_fd(sk[i * 2], 0);
> > +             if (!ASSERT_GE(sk[i * 2 + 1], 0, "connect_to_fd"))
> > +                     return sk[i * 2 + 1];
> > +
> > +             err =3D connect_fd_to_fd(sk[i * 2], sk[i * 2 + 1], 0);
> > +             if (!ASSERT_EQ(err, 0, "connect_fd_to_fd"))
> > +                     return err;
> > +
> > +             err =3D setsockopt(sk[i * 2], SOL_SOCKET, SO_RCVBUF, &rcv=
buf, sizeof(int));
> > +             if (!ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)"))
> > +                     return err;
> > +
> > +             err =3D setsockopt(sk[i * 2 + 1], SOL_SOCKET, SO_RCVBUF, =
&rcvbuf, sizeof(int));
> > +             if (!ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)"))
> > +                     return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static long get_memory_allocated(struct test_case *test_case,
> > +                              bool *activated, bool *stable,
> > +                              long *memory_allocated)
> > +{
> > +     *stable =3D false;
> > +
> > +     do {
> > +             *activated =3D true;
> > +
> > +             /* AF_INET and AF_INET6 share the same memory_allocated.
> > +              * tcp_init_sock() is called by AF_INET and AF_INET6,
> > +              * but udp_lib_init_sock() is inline.
> > +              */
> > +             socket(AF_INET, test_case->type, 0);
>
> fd is leaked.

Will close().


>
> > +     } while (!*stable);
>
> cannot loop forever. The test needs to assume the machine is relatively n=
etwork
> quiet anyway (so serial_). Things can still change after the stable test =
also. I
> think having a way (the fentry in the progs/sk_memcg.c) to account for th=
e
> percpu fw alloc is good enough, and this should help if there is some lig=
ht
> background traffic that suddenly flush the hidden +255 percpu counter to =
the
> global one and another percpu counter still has a -254 for example.

Okay, I'll remove fexit progs.


>
> > +
> > +     return *memory_allocated;
> > +}
> > +
> > +static long tcp_get_memory_allocated(struct test_case *test_case, stru=
ct sk_memcg *skel)
> > +{
> > +     return get_memory_allocated(test_case,
> > +                                 &skel->bss->tcp_activated,
> > +                                 &skel->bss->tcp_stable,
> > +                                 &skel->bss->tcp_memory_allocated);
> > +}
> > +
> > +static long udp_get_memory_allocated(struct test_case *test_case, stru=
ct sk_memcg *skel)
> > +{
> > +     return get_memory_allocated(test_case,
> > +                                 &skel->bss->udp_activated,
> > +                                 &skel->bss->udp_stable,
> > +                                 &skel->bss->udp_memory_allocated);
> > +}
> > +
> > +static int check_exclusive(struct test_case *test_case,
> > +                        struct sk_memcg *skel, bool exclusive)
> > +{
> > +     char buf[BUF_SINGLE] =3D {};
> > +     long memory_allocated[2];
> > +     int sk[NR_SOCKETS] =3D {};
> > +     int err, i, j;
> > +
> > +     err =3D test_case->create_sockets(test_case, sk, ARRAY_SIZE(sk));
> > +     if (err)
> > +             goto close;
> > +
> > +     memory_allocated[0] =3D test_case->get_memory_allocated(test_case=
, skel);
> > +
> > +     /* allocate pages >=3D 1024 */
> > +     for (i =3D 0; i < ARRAY_SIZE(sk); i++) {
> > +             for (j =3D 0; j < NR_SEND; j++) {
> > +                     int bytes =3D send(sk[i], buf, sizeof(buf), 0);
> > +
> > +                     /* Avoid too noisy logs when something failed. */
> > +                     if (bytes !=3D sizeof(buf)) {
> > +                             ASSERT_EQ(bytes, sizeof(buf), "send");
> > +                             if (bytes < 0) {
> > +                                     err =3D bytes;
> > +                                     goto close;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +
> > +     memory_allocated[1] =3D test_case->get_memory_allocated(test_case=
, skel);
> > +
> > +     if (exclusive)
> > +             ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, =
"exclusive");
> > +     else
> > +             ASSERT_GT(memory_allocated[1], memory_allocated[0] + 1024=
, "not exclusive");The test is taking >10s in my environemnt. Although it h=
as kasan and other dbg
> turned on, my environment is not a slow one tbh. The WATCHDOG > 10s warni=
ng is
> hit pretty often. The exclusive case is expecting +10. May be we just nee=
d to
> check +128 for non-exclusive which should be subtle enough to contrast wi=
th the
> exclusive case? With +128, NR_SEND 32 is more than enough?

I think I was too conservative, and the number should be
fine with fentry progs.


>
> > +
> > +close:
> > +     for (i =3D 0; i < ARRAY_SIZE(sk); i++)
> > +             close(sk[i]);
> > +
> > +     if (test_case->type =3D=3D SOCK_DGRAM) {
> > +             /* UDP recv queue is destroyed after RCU grace period.
> > +              * With one kern_sync_rcu(), memory_allocated[0] of the
> > +              * isoalted case often matches with memory_allocated[1]
> > +              * of the preceding non-exclusive case.
> > +              */
>
> I don't think I understand the double kern_sync_rcu() below.

With one kern_sync_rcu(), when I added bpf_printk() for memory_allocated,
I sometimes saw two consecutive non-zero values, meaning memory_allocated[0=
]
still see the previous test case result (memory_allocated[1]).
ASSERT_LE() succeeds as expected, but somewhat unintentionally.

bpf_trace_printk: memory_allocated: 0 <-- non exclusive case
bpf_trace_printk: memory_allocated: 4160
bpf_trace_printk: memory_allocated: 4160 <-- exclusive case's
memory_allocated[0]
bpf_trace_printk: memory_allocated: 0
bpf_trace_printk: memory_allocated: 0
bpf_trace_printk: memory_allocated: 0

One kern_sync_rcu() is enough to kick call_rcu() + sk_destruct() but
does not guarantee that it completes, so if the queue length was too long,
the memory_allocated does not go down fast enough.

But now I don't see the flakiness with NR_SEND 32, and one
kern_sync_rcu() might be enough unless the env is too slow...?



>
> > +             kern_sync_rcu();
> > +             kern_sync_rcu();> +     }
> > +
> > +     return err;
> > +}
> > +
> > +void run_test(struct test_case *test_case)
>
> static

Will add.


>
> > +{
> > +     struct nstoken *nstoken;
> > +     struct sk_memcg *skel;
> > +     int cgroup, err;
> > +
> > +     skel =3D sk_memcg__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +             return;
> > +
> > +     skel->bss->nr_cpus =3D libbpf_num_possible_cpus();
> > +
> > +     err =3D sk_memcg__attach(skel);
> > +     if (!ASSERT_OK(err, "attach"))
> > +             goto destroy_skel;
> > +
> > +     cgroup =3D test__join_cgroup("/sk_memcg");
> > +     if (!ASSERT_GE(cgroup, 0, "join_cgroup"))
> > +             goto destroy_skel;
> > +
> > +     err =3D make_netns("sk_memcg");
> > +     if (!ASSERT_EQ(err, 0, "make_netns"))
> > +             goto close_cgroup;
> > +
> > +     nstoken =3D open_netns("sk_memcg");
> > +     if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> > +             goto remove_netns;
> > +
> > +     err =3D check_exclusive(test_case, skel, false);
> > +     if (!ASSERT_EQ(err, 0, "test_exclusive(false)"))
> > +             goto close_netns;
> > +
> > +     err =3D write_sysctl("/proc/sys/net/core/memcg_exclusive", "1");
> > +     if (!ASSERT_EQ(err, 0, "write_sysctl(1)"))
> > +             goto close_netns;
> > +
> > +     err =3D check_exclusive(test_case, skel, true);
> > +     if (!ASSERT_EQ(err, 0, "test_exclusive(true by sysctl)"))
> > +             goto close_netns;
> > +
> > +     err =3D write_sysctl("/proc/sys/net/core/memcg_exclusive", "0");
> > +     if (!ASSERT_EQ(err, 0, "write_sysctl(0)"))
> > +             goto close_netns;
> > +
> > +     skel->links.sock_create =3D bpf_program__attach_cgroup(skel->prog=
s.sock_create, cgroup);
> > +     if (!ASSERT_OK_PTR(skel->links.sock_create, "attach_cgroup(sock_c=
reate)"))
> > +             goto close_netns;
> > +
> > +     err =3D check_exclusive(test_case, skel, true);
> > +     ASSERT_EQ(err, 0, "test_exclusive(true by bpf)");
> > +
> > +close_netns:
> > +     close_netns(nstoken);
> > +remove_netns:
> > +     remove_netns("sk_memcg");
> > +close_cgroup:
> > +     close(cgroup);
> > +destroy_skel:
> > +     sk_memcg__destroy(skel);
> > +}
> > +
> > +struct test_case test_cases[] =3D {
> > +     {
> > +             .name =3D "TCP  ",
> > +             .family =3D AF_INET,
> > +             .type =3D SOCK_STREAM,
> > +             .create_sockets =3D tcp_create_sockets,
> > +             .get_memory_allocated =3D tcp_get_memory_allocated,
> > +     },
> > +     {
> > +             .name =3D "UDP  ",
> > +             .family =3D AF_INET,
> > +             .type =3D SOCK_DGRAM,
> > +             .create_sockets =3D udp_create_sockets,
> > +             .get_memory_allocated =3D udp_get_memory_allocated,
> > +     },
> > +     {
> > +             .name =3D "TCPv6",
> > +             .family =3D AF_INET6,
> > +             .type =3D SOCK_STREAM,
> > +             .create_sockets =3D tcp_create_sockets,
> > +             .get_memory_allocated =3D tcp_get_memory_allocated,
> > +     },
> > +     {
> > +             .name =3D "UDPv6",
> > +             .family =3D AF_INET6,
> > +             .type =3D SOCK_DGRAM,
> > +             .create_sockets =3D udp_create_sockets,
> > +             .get_memory_allocated =3D udp_get_memory_allocated,
> > +     },
> > +};
> > +
> > +void serial_test_sk_memcg(void)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(test_cases); i++) {
> > +             test__start_subtest(test_cases[i].name);
>
> This is not doing anything without "if".

Ah, will move run_test() inside the if.

>
> > +             run_test(&test_cases[i]);
> > +     }
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/sk_memcg.c b/tools/testi=
ng/selftests/bpf/progs/sk_memcg.c
> > new file mode 100644
> > index 000000000000..6b1a928a0c90
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/sk_memcg.c
> > @@ -0,0 +1,146 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright 2025 Google LLC */
> > +
> > +#include "bpf_tracing_net.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <errno.h>
> > +
> > +extern int tcp_memory_per_cpu_fw_alloc __ksym;
> > +extern int udp_memory_per_cpu_fw_alloc __ksym;
> > +
> > +int nr_cpus;
> > +bool tcp_activated, tcp_stable, udp_activated, udp_stable;
> > +long tcp_memory_allocated, udp_memory_allocated;
> > +static struct sock *tcp_sk_tracing, *udp_sk_tracing;
> > +
> > +struct sk_prot {
> > +     long *memory_allocated;
> > +     int *memory_per_cpu_fw_alloc;
> > +};
> > +
> > +static int drain_memory_per_cpu_fw_alloc(__u32 i, struct sk_prot *sk_p=
rot_ctx)
> > +{
> > +     int *memory_per_cpu_fw_alloc;
> > +
> > +     memory_per_cpu_fw_alloc =3D bpf_per_cpu_ptr(sk_prot_ctx->memory_p=
er_cpu_fw_alloc, i);
> > +     if (memory_per_cpu_fw_alloc)
> > +             *sk_prot_ctx->memory_allocated +=3D *memory_per_cpu_fw_al=
loc;
> > +
> > +     return 0;
> > +}
> > +
> > +static long get_memory_allocated(struct sock *_sk, int *memory_per_cpu=
_fw_alloc)
> > +{
> > +     struct sock *sk =3D bpf_core_cast(_sk, struct sock);
> > +     struct sk_prot sk_prot_ctx;
> > +     long memory_allocated;
> > +
> > +     /* net_aligned_data.{tcp,udp}_memory_allocated was not available.=
 */
> > +     memory_allocated =3D sk->__sk_common.skc_prot->memory_allocated->=
counter;
> > +
> > +     sk_prot_ctx.memory_allocated =3D &memory_allocated;
> > +     sk_prot_ctx.memory_per_cpu_fw_alloc =3D memory_per_cpu_fw_alloc;
> > +
> > +     bpf_loop(nr_cpus, drain_memory_per_cpu_fw_alloc, &sk_prot_ctx, 0)=
;
> > +
> > +     return memory_allocated;
> > +}
> > +
> > +static void fentry_init_sock(struct sock *sk, struct sock **sk_tracing=
,
> > +                          long *memory_allocated, int *memory_per_cpu_=
fw_alloc,
> > +                          bool *activated)
> > +{
> > +     if (!*activated)
> > +             return;
> > +
> > +     if (__sync_val_compare_and_swap(sk_tracing, NULL, sk))
> > +             return;
> > +
> > +     *activated =3D false;
> > +     *memory_allocated =3D get_memory_allocated(sk, memory_per_cpu_fw_=
alloc);
> > +}
> > +
> > +static void fexit_init_sock(struct sock *sk, struct sock **sk_tracing,
> > +                         long *memory_allocated, int *memory_per_cpu_f=
w_alloc,
> > +                         bool *stable)
> > +{
> > +     long new_memory_allocated;
> > +
> > +     if (sk !=3D *sk_tracing)
> > +             return;
> > +
> > +     new_memory_allocated =3D get_memory_allocated(sk, memory_per_cpu_=
fw_alloc);
> > +     if (new_memory_allocated =3D=3D *memory_allocated)
> > +             *stable =3D true;
>
> I am not sure that help. The total memory_allocated can still change afte=
r this.
> I would just grab the total in fentry once and then move on without confi=
rming
> in fexit.

Will remove fexit stuff.

Thanks!

