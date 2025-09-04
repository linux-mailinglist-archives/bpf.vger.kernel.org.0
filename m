Return-Path: <bpf+bounces-67477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDF0B44388
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB57A1CC3B53
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E552530AADB;
	Thu,  4 Sep 2025 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8ygBD9G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0133002C4
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004331; cv=none; b=n8giaQAMfYGtLWtsFN9KnnSxTgp5/UoKnYKpE8g4PrMv7PL/aGpwUzACm01Ef7UwCz5Wt1zUhLWkLTgwFt3nHvCPClVP2Pp61Mqm+DhmCZPB1JULalzb+CGpM5WmC7WQDtnhF1+P7Q1NoSG+KtEmSGCReoYFJ+O/MbqF3vo4EMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004331; c=relaxed/simple;
	bh=SQDrMayr1AWqpZVUuBZ9FOwAV+8K0klK2S+TY5d1mek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRMSjGd6zPtaR8iYzzz9aO6QQUJhBQRBX87TcSuYLCYqBqYLdgL9Xl7n4tbF66Gu9r7owK5OKibffII59QpyeXm0n/m7+10wj+mx57+XGwU2HAxlKziMx2/uwH9WFXZSxmckr2P8igBCUkCUlZ5MxzfpmlUPRluY2uN6MYULo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8ygBD9G; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24a9cc916b3so13439475ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757004329; x=1757609129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ch50u6Yaq/xChZx3lv4sKlr/R2yilDyd08P7zvEQFM=;
        b=y8ygBD9GiSwWkrJ6GQjxAFozZ0AhAtCjxcr/RhQa9Wfz01dyQ88W2uOBGKHXMLttqI
         fbfIbH6N7nIaD64mpXMISFL1HR+itIn2e3t6zhXF+1N4AGTvfGt83l7tXjg++nU+S/iK
         0Pr9yBIkRSSdp1Dnp11/1n44rRIMNL74RLW9qg2VgHQ1bkWdNyQEANN6K9byXdy82uk8
         N/7ztekJvnmfZ2Rmt+ux+2xVspTlZOwNmOuxII1U57ilHV//uFxVsetUpwFuC5WIOJvY
         6KwwQ3pS7lkzxuc3bTHqdpC11qEWp4iuENeQ1wBXXjlh1HtU335JAenr71uu0wCqEJxq
         nh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004329; x=1757609129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ch50u6Yaq/xChZx3lv4sKlr/R2yilDyd08P7zvEQFM=;
        b=m/yKCMKIwG/UbyTLSMU/nhmY+MZ1dPuAOzgjE8MpJilyyxqajSSX7xPP1x58xBDb02
         6yKD9DRJyE3uWDPalTtzt66fTBmDalo7HTX6d84HGTLSEXflAYIC7qhdPGmzs2QoswY9
         VxaFSbqPtI9+zIlhP2NerNoFmmP1g/phCxyr8ot8QjxJ77dAkUWpPLgfjxtBvPwuC43Y
         wpnVwyeUw5RidFIfLO75Hi3mCZxbKUJOXU1ZnUFgpA4QZW6EWN76kttYbnzwbC70hOkU
         0epT5/QvRjdLyxjzzjcwFpo/PUBQyphd/vuDdjPWfaxX+0CoPS0PiMGanph8aOZUuRsd
         IlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB70MiZQ2p8OS7zCvacFhlggTEBuE04ZrLH8IjyaIMl5UiAoCcm0+WV7kKwqG0aWjd8aU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+c4BGrfqh3Y+e+gbdW9S/V8WvT2mmUVR5F5dic4HmvNWD6ipy
	j5F/zeUhzG5saDoMDyP+L+i+qrw0vK+XIMYIKCmi850B3vu1pc46363sb1rRFWhZ3azJMyj0q+d
	n3j0A89OcU8/sUFiGGRupoDxH/wPLfvG9Kg8DNfss
X-Gm-Gg: ASbGncvXeSIjKCHQtlcJyQhpzHu+8eGCVwHEqdQ1Ro4ksoIDX7hZY7+E/MEsV9ZGBKi
	5ktK3H64QfdIhn9Bi7iijp1Gtyl71oxLftJUziBG7LjnYzdcdn2tZrCOE/1HODF2oHiSzFLA68X
	rG89tbI3OyKTHo/1XKV5WkhXrWGHC0ne0cR9/Q1oKn6IF3FrpnDFGYDWzY70al0wziasA5JdOe0
	EG05qO1c7hS/vda1SCmNxYY0rEmIAv+5gTZG6bYpLP/ORMAApVjETuK2s7m9WR90ITktx7XJDB6
	m93TWh8tb03IFA==
X-Google-Smtp-Source: AGHT+IG1EpqG7qNKIFTbDnxU8+Ry9/enup83r2Q1vw+Nz21w6PNwZ1uc5ogF/1p+6H/PwvW5XJMRridNkl7iw5n0feQ=
X-Received: by 2002:a17:903:19eb:b0:24c:c8fe:e273 with SMTP id
 d9443c01a7336-24cc8fee5d8mr45692455ad.7.1757004328821; Thu, 04 Sep 2025
 09:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-6-kuniyu@google.com>
 <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev> <CAAVpQUDfQwb2nfGBV8NEONwaBAMVi_5F8+OPFX3=z+W8X9n9ZQ@mail.gmail.com>
 <CAAVpQUBWsVDu07xrQcqGMo4cHRu41zvb5CWuiUdJx9m6A+_2AQ@mail.gmail.com>
 <CAAVpQUCyPPO1dfkkU4Hxz67JFcW6dhSfYnmUp0foNMYua_doyg@mail.gmail.com> <40ed29b3-84d7-4812-890d-3676957d503f@linux.dev>
In-Reply-To: <40ed29b3-84d7-4812-890d-3676957d503f@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 4 Sep 2025 09:45:17 -0700
X-Gm-Features: Ac12FXwW7GeIQs-0_FH5Frr0I8tx7qgf-Ruu3chh9rMygogTnF_uFMnNp3DDz0Y
Message-ID: <CAAVpQUCLpi+6w1SP=FKVaXwdDHQC_P6B1hzzDC5y4brsf3_UnQ@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 10:51=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/3/25 10:08 AM, Kuniyuki Iwashima wrote:
> > On Wed, Sep 3, 2025 at 9:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >>
> >> On Tue, Sep 2, 2025 at 1:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> >>>
> >>> On Tue, Sep 2, 2025 at 1:26=E2=80=AFPM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>>>
> >>>> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> >>>>> The test does the following for IPv4/IPv6 x TCP/UDP sockets
> >>>>> with/without BPF prog.
> >>>>>
> >>>>>     1. Create socket pairs
> >>>>>     2. Send a bunch of data that requires more than 256 pages
> >>>>>     3. Read memory_allocated from the 3rd column in /proc/net/proto=
cols
> >>>>>     4. Check if unread data is charged to memory_allocated
> >>>>>
> >>>>> If BPF prog is attached, memory_allocated should not be changed,
> >>>>> but we allow a small error (up to 10 pages) in case other processes
> >>>>> on the host use some amounts of TCP/UDP memory.
> >>>>>
> >>>>> At 2., the test actually sends more than 1024 pages because the sys=
ctl
> >>>>> net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages a=
re
> >>>>> buffered per cpu before reporting to sk->sk_prot->memory_allocated.
> >>>>>
> >>>>>     BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
> >>>>>     =3D 1024 pages
> >>>>>
> >>>>> When I reduced it to 512 pages, the following assertion for the
> >>>>> non-isolated case got flaky.
> >>>>>
> >>>>>     ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)
> >>>>>
> >>>>> Another contributor to slowness is 150ms sleep to make sure 1 RCU
> >>>>> grace period passes because UDP recv queue is destroyed after that.
> >>>>
> >>>> There is a kern_sync_rcu() in testing_helpers.c.
> >>>
> >>> Nice helper :)  Will use it.
> >>>
> >>>>
> >>>>>
> >>>>>     # time ./test_progs -t sk_memcg
> >>>>>     #370/1   sk_memcg/TCP       :OK
> >>>>>     #370/2   sk_memcg/UDP       :OK
> >>>>>     #370/3   sk_memcg/TCPv6     :OK
> >>>>>     #370/4   sk_memcg/UDPv6     :OK
> >>>>>     #370     sk_memcg:OK
> >>>>>     Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >>>>>
> >>>>>     real       0m1.214s
> >>>>>     user       0m0.014s
> >>>>>     sys        0m0.318s
> >>>>
> >>>> Thanks. It finished much faster in my setup also comparing with the =
earlier
> >>>> revision. However, it is a bit flaky when I run it in a loop:
> >>>>
> >>>> check_isolated:FAIL:not isolated unexpected not isolated: actual 861=
 <=3D expected 861
> >>>>
> >>>> I usually can hit this at ~40-th iteration.
> >>>
> >>> Oh.. I tested ~10 times manually but will try in a tight loop.
> >>
> >> This didn't reproduce on my QEMU with/without --enable-kvm.
> >>
> >> Changing the assert from _GT to _GE will address the very case
> >> above, but I'm not sure if it's enough.
> >
> > I doubled NR_SEND and it was still faster with kern_sync_rcu()
> > than usleep(), so I'll simply double NR_SEND in v5
> >
> > # time ./test_progs -t sk_memcg
> > ...
> > Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> > real 0m0.483s
> > user 0m0.010s
> > sys 0m0.191s
> >
> >
> >>
> >> Does the bpf CI run tests repeatedly or is this only a manual
> >> scenario ?
>
> I haven't seen bpf CI hit it yet. It is in my manual bash while loop. It =
should
> not be dismissed so easily. Some flaky CI tests were eventually reproduce=
d in a
> loop before and fixed. I kept the bash loop continue this time until grep=
-ed a
> "0" from the error output:
>
> check_isolated:FAIL:not isolated unexpected not isolated: actual 0 <=3D e=
xpected 256
>
> The "long memory_allocated[2]" read from /proc/net/protocols are printed =
as 0
> but it is probably actually negative:
>
> static inline long
> proto_memory_allocated(const struct proto *prot)
> {
>          return max(0L, atomic_long_read(prot->memory_allocated));
> }
>
> prot->memory_allocated could be negative afaict but printed as 0 in
> /proc/net/protocols. Even the machine is network quiet after test_progs s=
tarted,
> the "prot->memory_allocated" and the "proto->per_cpu_fw_alloc" could be i=
n some
> random states before the test_progs start.  When I hit "0", it will take =
some
> efforts to send some random traffic to the machine to get the test workin=
g again. :(
>
> Also, after reading the selftest closer, I am not sure I understand why "=
+ 256".
> The "proto-> per_cpu_fw_alloc" can start with -255 or +255.

Actually I didn't expect the random state and assumed the test's
local communication would complete on the same CPU thus 0~255.

Do you see the flakiness with net.core.mem_pcpu_rsv=3D0 ?

The per-cpu cache is just for performance and I think it's not
critical for testing and it's fine to set it to 0 during the test.


>
> I don't think changing NR_SEND help here. It needs a better way. May be s=
ome
> functions can be traced such that prot->memory_allocated can be read dire=
ctly?
> If fentry and fexit of that function has different memory_allocated value=
s, then
> the test could also become more straight forward.

Maybe like this ?  Not yet tested, but we could attach a prog to
sock_init_data() or somewhere else and trigger it by additional socket(2).

        memory_allocated =3D sk->sk_prot->memory_allocated;
        nr_cpu =3D bpf_num_possible_cpus();

        for (i =3D 0; i < nr_cpu; i++) {
                per_cpu_fw_alloc =3D
bpf_per_cpu_ptr(sk->sk_prot->per_cpu_fw_alloc, i);
                if (per_cpu_fw_alloc)
                        memory_allocated +=3D *per_cpu_fw_alloc;
        }

per_cpu_fw_alloc might have been added to sk_prot->memory_allocated
during loop, so it's not 100% accurate still.

Probably we should set net.core.mem_pcpu_rsv=3D0 and stress
memory_allocated before the actual test to drain per_cpu_fw_alloc
(at least on the testing CPU).

