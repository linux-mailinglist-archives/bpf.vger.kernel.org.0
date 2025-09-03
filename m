Return-Path: <bpf+bounces-67320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E79B42798
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539BA1B21573
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94731DDAF;
	Wed,  3 Sep 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AaPitmfR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489430DED9
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919295; cv=none; b=r8Rg+2FVHXetovLLlIDzMU9uJ0PsusD7Db1QMvII+q0X1rq8lQlgTaknAegKSalNFca6q2feuuO4Rf+8JNOgxdQtZIWUk0XmGrT4/P3aBTgWZZj/ClNFBDQHP4fKBAOwCUAD+ziSyeOfNmEqKn7xMK47qf2wHJ7o4EWEkFk8voE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919295; c=relaxed/simple;
	bh=WpUygWTDXRLuaPUqHiheWrK6o7CCFVMEczat74c5I0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uv3gGT3S39MjntChsSavx/HtOzF+SZ3FCPX4ZCDcQUymKVKoNtL7HhKwseWFFHSzBEKcg4rtvS9izxof4HNVABRgWv9AfnQ2pE41k8jNcN56sfRKVFXg/b2fJ1YArbvO9EHJXVXI+YbC3e3UWOfwyug81Y/x9ENzu73V76Yv1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AaPitmfR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77281ea2dc7so128847b3a.2
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756919293; x=1757524093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIAuEdLRPN1A/j3QXgZnGYzvS6zR/mfBqmIlSnWVeV0=;
        b=AaPitmfREmPE8nYhEvZ8q8u9k0dU+28w3TJvhiK5D0XHXIEmiwY2QM2mJ81S6Z/cT/
         Pn0j9y5aYWTRSE4pVdiRCY7MeHapv2yI72eio4ZEGZQEqn4rj0j8FHa1uU/tPmYywK9W
         hyKsZrdGo203IvQQFMro0LlQl41d/hUoH55wxsRU1xu5MzkMt4VQmCIUjVhPY8eFEDsW
         d8EC8nNrL+3ZPewjJIZESuHOHyUq7CYwr0POqEMGlnoQ01lR0EgAgajImBGr906o1zlA
         XaHu2CyXN11mOjwkdo+P7rKwh5R72GNbkjcmR6b4hAZOG+qf20C1RDdzYGlcyWOKLFhW
         F36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919293; x=1757524093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIAuEdLRPN1A/j3QXgZnGYzvS6zR/mfBqmIlSnWVeV0=;
        b=cR8pMz467a4lh81+dTzkrHuqUN7jsLDxBUXGTMqwwN3XpmMC/mGSo+lweGj0dDhkjL
         ghQ9BnirFHgMEj7YkXoZ8RQP1VVN11A9Bf/ZeRZDZuMC1wMkWf3vOjpvkYnOxZX0BnkV
         l53M9TMIf4T8gMcK9YiCM5FE9GqGRfIOX3iLo4Hd/iOzKJNWR3pSU0uRk7I0MhfQdHcy
         77QPKVxd4WUQktVMhX39oMybc6wWquw38pJQ8yC+OKgwE1Pd+IpUAYpa9Svs7cA+ieST
         rboAA+/b23nXX0fl7RKDgcGEDnR3I2Lz1NhaXv60t30UhaxvH56CrS56h6w1zOoeLeaI
         o2IA==
X-Forwarded-Encrypted: i=1; AJvYcCWuT4NLPW/lRea6zRl5Hdk+BuPgqah/1aMi+zFaA48/Kb3AkP3JlOfgt8ep0iHMfcLdZ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORm9sZjcUKFfGk8hR3J1WFIQ387pXmgFdIQy5ulaI3fER7O+J
	wD46NP1l9r9LvKlMNwnZgYJcKaa965yBywyCiyalviHBWhRPX40gEL8Zpc1hPaNxfziCIYcFw3d
	jO9FyIgK3jM0R5mdnkkZ6NQ4NfcrlJ5WLzMHEsAPI
X-Gm-Gg: ASbGncuJ89kCr+LDlLnNjfF9zxWFNwWNsd9njkpalXY0wll2EyYh4rERxvG+y9NXw8D
	4ksiL799gGSbzwY9TJ7Oq5dknChdeAyfRoeo/Lw5JNkLrLs/nvUYNP9sJ/dHrr73KWoOvlPCuHO
	HnsY5Pf9lsGaSXnpQBPdJzTaVQRCETB38v1mKJqaICVxqjp36QaDx6VRtg7b0MClBmgYd8IVfyq
	GUVFvx7zTIFT26TCEHkQEuqFUMkxhaXU1dYxNCBwgIJ
X-Google-Smtp-Source: AGHT+IEaqMoJL3wgMu6tDCAxnk/c/Wh1YZktP0vBrCDWFJlIFrzAMeYPzz996yoti7VmnoAWUvqcGLnGwyTxyU9RbP0=
X-Received: by 2002:a17:902:ecc3:b0:24b:1191:9864 with SMTP id
 d9443c01a7336-24b1191a0fcmr101355585ad.18.1756919292763; Wed, 03 Sep 2025
 10:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-6-kuniyu@google.com>
 <904c1ffb-107e-4f14-89b7-d42ac9a5aa14@linux.dev> <CAAVpQUDfQwb2nfGBV8NEONwaBAMVi_5F8+OPFX3=z+W8X9n9ZQ@mail.gmail.com>
 <CAAVpQUBWsVDu07xrQcqGMo4cHRu41zvb5CWuiUdJx9m6A+_2AQ@mail.gmail.com>
In-Reply-To: <CAAVpQUBWsVDu07xrQcqGMo4cHRu41zvb5CWuiUdJx9m6A+_2AQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 10:08:01 -0700
X-Gm-Features: Ac12FXwO5UL-VawceaE2PlnfDQoaxDABVVQsiBxWC0odvOHvVVbI6ipzY_xzE44
Message-ID: <CAAVpQUCyPPO1dfkkU4Hxz67JFcW6dhSfYnmUp0foNMYua_doyg@mail.gmail.com>
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

On Wed, Sep 3, 2025 at 9:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Tue, Sep 2, 2025 at 1:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Tue, Sep 2, 2025 at 1:26=E2=80=AFPM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> > >
> > > On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> > > > The test does the following for IPv4/IPv6 x TCP/UDP sockets
> > > > with/without BPF prog.
> > > >
> > > >    1. Create socket pairs
> > > >    2. Send a bunch of data that requires more than 256 pages
> > > >    3. Read memory_allocated from the 3rd column in /proc/net/protoc=
ols
> > > >    4. Check if unread data is charged to memory_allocated
> > > >
> > > > If BPF prog is attached, memory_allocated should not be changed,
> > > > but we allow a small error (up to 10 pages) in case other processes
> > > > on the host use some amounts of TCP/UDP memory.
> > > >
> > > > At 2., the test actually sends more than 1024 pages because the sys=
ctl
> > > > net.core.mem_pcpu_rsv is 256 is by default, which means 256 pages a=
re
> > > > buffered per cpu before reporting to sk->sk_prot->memory_allocated.
> > > >
> > > >    BUF_SINGLE (1024) * NR_SEND (64) * NR_SOCKETS (64) / 4096
> > > >    =3D 1024 pages
> > > >
> > > > When I reduced it to 512 pages, the following assertion for the
> > > > non-isolated case got flaky.
> > > >
> > > >    ASSERT_GT(memory_allocated[1], memory_allocated[0] + 256, ...)
> > > >
> > > > Another contributor to slowness is 150ms sleep to make sure 1 RCU
> > > > grace period passes because UDP recv queue is destroyed after that.
> > >
> > > There is a kern_sync_rcu() in testing_helpers.c.
> >
> > Nice helper :)  Will use it.
> >
> > >
> > > >
> > > >    # time ./test_progs -t sk_memcg
> > > >    #370/1   sk_memcg/TCP       :OK
> > > >    #370/2   sk_memcg/UDP       :OK
> > > >    #370/3   sk_memcg/TCPv6     :OK
> > > >    #370/4   sk_memcg/UDPv6     :OK
> > > >    #370     sk_memcg:OK
> > > >    Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> > > >
> > > >    real       0m1.214s
> > > >    user       0m0.014s
> > > >    sys        0m0.318s
> > >
> > > Thanks. It finished much faster in my setup also comparing with the e=
arlier
> > > revision. However, it is a bit flaky when I run it in a loop:
> > >
> > > check_isolated:FAIL:not isolated unexpected not isolated: actual 861 =
<=3D expected 861
> > >
> > > I usually can hit this at ~40-th iteration.
> >
> > Oh.. I tested ~10 times manually but will try in a tight loop.
>
> This didn't reproduce on my QEMU with/without --enable-kvm.
>
> Changing the assert from _GT to _GE will address the very case
> above, but I'm not sure if it's enough.

I doubled NR_SEND and it was still faster with kern_sync_rcu()
than usleep(), so I'll simply double NR_SEND in v5

# time ./test_progs -t sk_memcg
...
Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
real 0m0.483s
user 0m0.010s
sys 0m0.191s


>
> Does the bpf CI run tests repeatedly or is this only a manual
> scenario ?

