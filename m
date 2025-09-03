Return-Path: <bpf+bounces-67318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5160B42770
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9352188CE72
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216031A57A;
	Wed,  3 Sep 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5DytL1a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9431A548
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918781; cv=none; b=J06ntrCLf3234ok3TV2KI9TkFcFOxJUrPRqgCpYPzQJAS2Wtkw9ATF1sxOdviTSXymR5Z01bzy5bXSuj9qFT7N9wzFGYgveJiIxiMayF0nrHrVubxlO6d3/ZhI6M/2pY0Ceze9b7mY8ole+/mGXkR2n4Gys9+/6HjChVKZgKC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918781; c=relaxed/simple;
	bh=1lc++iiRHGhTYE4IitzDjLEwDhwei9hOjhVuBfjVsvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efZPtXopvJQbtbyg9jMks0GWXa8SF7tvNpXIPy6nY+llTR8vR3lUAAZAsTdhbE1kEPHTXgUIypsK5D/femsZ5xirrzUcK5FSbjrDtxP7RWpLOXQ/EPZKZbYvRKGUHjf7jah9OVqZMK0g5WiUICy/+ZD58AT4ff97QIV+r/wCkDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x5DytL1a; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24c8ef94e5dso656265ad.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756918779; x=1757523579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRxjauhhJE54ARaYiToRKIrcD4G+jegvAqCkkFBnO58=;
        b=x5DytL1aFTce1n5lZVTTuYkpeAZ6PfaPQDUO++gjv9uwAzU4Ncj+HRpm0+0kXqaNQm
         J1hjIiRw6eGt0vr2gN1NYhhzRGuALFtXsqBXInipb+OhNKHAMZsSoZcGBE/AE73C/DY6
         ffrKx5kLT9dGx6IOhBZu0LErPcFTJhVoU6QDnYv3J7uhDlucSVHUJa3Atif/1l4Arjnp
         ku2G5mTx/I/S9IRL2cqLyMaBAfJ1m3kNGLNocRAuq/R/5MIyxkbuQxn0ub95kQ77NsaB
         zYCCa87t21DBN9/EtKF7NBsE/8t/hOm/REc/+2w2RHNjnS4OtQtwn9mLOwcgxUjZIO/0
         v1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918779; x=1757523579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRxjauhhJE54ARaYiToRKIrcD4G+jegvAqCkkFBnO58=;
        b=HaDYsIMg/t0EdJEqs4bQZVvkEN07aM0Y53gCAsT5spASfpkwYpBYBBVejp/6CSzu7K
         2uE1wALIox5GfpMBb84fR8o/7yZyMUE/tFw8UEPaHmlLhj5JGZ3v7N6ZkPihKmohMcOI
         sejcGFG6XWrhKFwRfC4DJg2OSSgoR7fByW+j3KvNoeY1CLgaNYA/+Oxcd225DwKQCjcS
         GHsRb3ZyohmAO8aaR9gQrxM0ilqD0jwGKeay2YAye7HPqGeJdFYfZKH6X3UA7m/3hXN7
         w8kqmGoFWKMKLP7JQFVltihgGYCywBbkEVSm1lX98TmLOLfzQYGn8YB9fvoFpRswc3SW
         av4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEqwn9LzJ75rrcs7qDHpdtZFGWnPJe5vgiXvfONLOS5J61wpkx9JtbgV/TYVXjtvR03TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSo4FqIJZW1g+xNsq7obzG1RKhYCoIAp8M0baM3P+1h+ILLAt
	hbEvS9LHd+rVXsHxaPXki/jOX0YmqLVR4KJOuqNND2yn1idjfxR/3vYlaHZyyR388Tl4E9zQ+7B
	lq0SyE3NjqeJciBNeBXjDrkqEn1Nrp1GyxdwbFUi2
X-Gm-Gg: ASbGncvVkQysYYyeissuNa38JWTuXOwOm7Pj1P9LTBI0MpxriZ7msFAbxiMmi35sD/W
	Gj2Xn/iZ6CiLvU1hXxszdpHnk81Pjtft6Nw7Tz3ajQ0j+woiqg+CMgllnkVu7prUYRni9sG0sSG
	kh5FzzXZW0+R/7XBkKpMA6YmTpQglApzJtazoRF+Wl+AwDIeA0piX9iBI23B62zXUln9beMhmF3
	JEu9xps73S3m8C007hH0eE7Etl/QPbGFX1Fh8RmGD1wYNmYsFMb3Zs=
X-Google-Smtp-Source: AGHT+IE1HAIgQDlB46EvDQiYQHxghWLz0o5XCA1QjoHxO1IhPDM87VJbQyBEpdwUXwpESnw7ZG7vPct+NPNWnBOkljQ=
X-Received: by 2002:a17:903:1ac7:b0:242:5f6c:6b4e with SMTP id
 d9443c01a7336-249448ccb7bmr236660025ad.7.1756918779027; Wed, 03 Sep 2025
 09:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-6-kuniyu@google.com>
 <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev> <CAAVpQUDfQwb2nfGBV8NEONwaBAMVi_5F8+OPFX3=z+W8X9n9ZQ@mail.gmail.com>
In-Reply-To: <CAAVpQUDfQwb2nfGBV8NEONwaBAMVi_5F8+OPFX3=z+W8X9n9ZQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 09:59:27 -0700
X-Gm-Features: Ac12FXyzwcRjRTSl5scUnOPNLCu-FuPPRHNK0AO6dI3pu2bFvhqPBMeVwrwod-k
Message-ID: <CAAVpQUBWsVDu07xrQcqGMo4cHRu41zvb5CWuiUdJx9m6A+_2AQ@mail.gmail.com>
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

On Tue, Sep 2, 2025 at 1:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Tue, Sep 2, 2025 at 1:26=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
> >
> > On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> > > The test does the following for IPv4/IPv6 x TCP/UDP sockets
> > > with/without BPF prog.
> > >
> > >    1. Create socket pairs
> > >    2. Send a bunch of data that requires more than 256 pages
> > >    3. Read memory_allocated from the 3rd column in /proc/net/protocol=
s
> > >    4. Check if unread data is charged to memory_allocated
> > >
> > > If BPF prog is attached, memory_allocated should not be changed,
> > > but we allow a small error (up to 10 pages) in case other processes
> > > on the host use some amounts of TCP/UDP memory.
> > >
> > > At 2., the test actually sends more than 1024 pages because the sysct=
l
> > > net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages are
> > > buffered per cpu before reporting to sk->sk_prot->memory_allocated.
> > >
> > >    BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
> > >    =3D 1024 pages
> > >
> > > When I reduced it to 512 pages, the following assertion for the
> > > non-isolated case got flaky.
> > >
> > >    ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)
> > >
> > > Another contributor to slowness is 150ms sleep to make sure 1 RCU
> > > grace period passes because UDP recv queue is destroyed after that.
> >
> > There is a kern_sync_rcu() in testing_helpers.c.
>
> Nice helper :)  Will use it.
>
> >
> > >
> > >    # time ./test_progs -t sk_memcg
> > >    #370/1   sk_memcg/TCP       :OK
> > >    #370/2   sk_memcg/UDP       :OK
> > >    #370/3   sk_memcg/TCPv6     :OK
> > >    #370/4   sk_memcg/UDPv6     :OK
> > >    #370     sk_memcg:OK
> > >    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > >    real       0m1.214s
> > >    user       0m0.014s
> > >    sys        0m0.318s
> >
> > Thanks. It finished much faster in my setup also comparing with the ear=
lier
> > revision. However, it is a bit flaky when I run it in a loop:
> >
> > check_isolated:FAIL:not isolated unexpected not isolated: actual 861 <=
=3D expected 861
> >
> > I usually can hit this at ~40-th iteration.
>
> Oh.. I tested ~10 times manually but will try in a tight loop.

This didn't reproduce on my QEMU with/without --enable-kvm.

Changing the assert from _GT to _GE will address the very case
above, but I'm not sure if it's enough.

Does the bpf CI run tests repeatedly or is this only a manual
scenario ?

