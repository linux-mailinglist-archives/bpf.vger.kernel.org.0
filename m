Return-Path: <bpf+bounces-75965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78EC9ED48
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 12:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC023A58FF
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592182F3629;
	Wed,  3 Dec 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmCdHIu9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790226A08A
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760631; cv=none; b=rCEc5AuC94k9EcbUcD8RgAX+HXfX1dGz/FHtc4x9kqQJ5UJTTmk80sizUHWKEkc17RYyY5iXQFz/ok9AAhyzA2mKHL6QVJVoLo6UN14fx57maCUKLLPgP0/ujbF+bjUJ0mqG5uJUzd3UIdNdodzfA0F3PERnwZeIkC4CcwaEW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760631; c=relaxed/simple;
	bh=3OOulyox2miBYvBKYk7kmfnEhxcYQi/Idh3Y8Yh49EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFSPa7294k///h9kppDEbLyKv/beWIE55MB5sdB4o+6lJeOSZihciQ8+QUt4BegMed/HedP6fX9D8mEzUYt7vbtoz/RPA4FIYemv9sTMr2zOQnIGKGoPRKNJu9Egna2WaUR/RDo8VfCugzFIJl2CobWhqNmjB+Fe31GaRTqOY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmCdHIu9; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso5764967fac.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764760629; x=1765365429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73yPH4ljDlk1zKNdTdsFMhaDsqDXoyAfzjK6qvhy2K8=;
        b=hmCdHIu9JY1DVT58hRBDkj3uMJNLFPvg+FKhMBOTxYynMEDGWZ1wCKFeaA7ztJYpHM
         /v7O/qPFubY8o8DNvreeuLFi9xm+psKVCwez02WrpOpMOKhWIHwJLDmHeWNNjbGV01iz
         iu0buwI+QML2nLiEbebk8oAro4y+XfMQpZ+ho7MhUqiWxZEhLRjOWNt4TG8Q4kQm69oK
         V0Sj7sroK76/87f72n1pFVm6FK6pALBCMl8nyhrxuo4rGFaYAaGBr6Ki3tQlp8PG7dIB
         Cu9NVFuosczHcnU9FiurMw0mYvTwYSqffaGW/MUcUaGxErbgCDoCs9HJyda9wKrffwYm
         RsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764760629; x=1765365429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73yPH4ljDlk1zKNdTdsFMhaDsqDXoyAfzjK6qvhy2K8=;
        b=RixsThyFRRlBUopiYAN+OPlVVoIlcVdZeCE9lGHXeYUxCxUeZkTVWydyGczi0XHLYx
         0Q1zJYTYNrbMIPkMI9J/B5OAguiwxwTivPdHd91q/fT0L/np2PHlchqLkk6NDO4KyAAK
         w9SALqL15fW3KwOvTKwP0m40THmevDojuirdF94m++BJsWClpz+c/DPGRfuWNQYGQw7e
         0ga4gPfh1Hi/HT4f5vwnE7larCbV/mHNKOWlvo9kzkN1FBndfQv1sQRQgVLt/OMlAZaK
         u9nzKn1+r2o8w53N2PORXGQZPRkkLsDYuNnNHrvUKCUr5VIHxYZal+R8pCWmMIdRuQim
         Hjrw==
X-Forwarded-Encrypted: i=1; AJvYcCW9K1z+XNJqaYajNV49ZMkP00F+YIQlPQ+8jqTx9fcw9EKY3LuFeX0OxfIlsItS1iuxoQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvopZMrXxHKx+6ZKK8+4cKHrHAnhPNtg6r4YCV0MC2eR1wz+3l
	LMAXOlIrxNJxTFHECbpJ65qO7GjTYaLiPKjV4POTfHLhZjtdNmFZWOd75FyZJttL7WZ75maaMYY
	8LDO9FdNQmbgTT2kAdj2mqdPYpaZKHoo=
X-Gm-Gg: ASbGncvKqRHbm/qKyVrvRI5EZTanon5y+Uatlouxt0uDxvPNQD2G8Ufqrn8c+dKBC+R
	WVoTFsrxTIGqZMXGgnYYzC2ZLAPoXvGJiKDqerXwl5/6SftuNQC0DSx+oGkWZ7A3XQ//yGsuHsj
	5c/hC8tgCCAGlBq7MJ3+nMDGBqUTtf7zbDDZWhAcbiURnMUJ0W6OYpPZOUudPYFkND9Oyjsgitt
	qfK8i2EV8dmB3voXZ2zrfAKPKvBD+kBh0PWsSg7u3OPmdDfQlKCFpXYUISVc0S/5wksWds=
X-Google-Smtp-Source: AGHT+IEEnbLn+2eKKh6Y902FTL4ey2SBNlSIDjCTN3Zj9Gf3Uio4M5+2SW1w2T7NZ9AKh7kRT+EEsw3tC0n/2nykXEU=
X-Received: by 2002:a05:6808:1447:b0:450:c09:92aa with SMTP id
 5614622812f47-4536e3973femr948029b6e.12.1764760628880; Wed, 03 Dec 2025
 03:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
 <20251128134601.54678-3-kerneljasonxing@gmail.com> <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
 <CAL+tcoDk0f+p2mRV=2auuYfTLA-cPPe-1az7NfEnw+FFaPR5kA@mail.gmail.com>
 <CAL+tcoBMRdMevWCS1puVD4zEDt+69S6t2r6Ov8tw7zhgq_n=PA@mail.gmail.com>
 <92e34c61-550a-449f-b183-cd8917fc5f9b@redhat.com> <CAJ8uoz2hjzea40-H3W5VAru7S+iFeVJ-2VoaFWjVqyFm3WpUKg@mail.gmail.com>
In-Reply-To: <CAJ8uoz2hjzea40-H3W5VAru7S+iFeVJ-2VoaFWjVqyFm3WpUKg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 3 Dec 2025 19:16:30 +0800
X-Gm-Features: AWmQ_bno4Qctpn3E4ebXDonuN35Rx9sgbSUjeSFBvjOlE6e_AZZ5mgafbs2-LK4
Message-ID: <CAL+tcoBprZrKkfzCE6vdRVxMfZjN8dKNB+NRi37JjESx-dPABQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 5:40=E2=80=AFPM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Wed, 3 Dec 2025 at 10:25, Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On 12/3/25 7:56 AM, Jason Xing wrote:
> > > On Sat, Nov 29, 2025 at 8:55=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > >> On Fri, Nov 28, 2025 at 10:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.=
com> wrote:
> > >>> On 11/28/25 2:46 PM, Jason Xing wrote:
> > >>>> From: Jason Xing <kernelxing@tencent.com>
> > >>>>
> > >>>> Use atomic_try_cmpxchg operations to replace spin lock. Technicall=
y
> > >>>> CAS (Compare And Swap) is better than a coarse way like spin-lock
> > >>>> especially when we only need to perform a few simple operations.
> > >>>> Similar idea can also be found in the recent commit 100dfa74cad9
> > >>>> ("net: dev_queue_xmit() llist adoption") that implements the lockl=
ess
> > >>>> logic with the help of try_cmpxchg.
> > >>>>
> > >>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >>>> ---
> > >>>> Paolo, sorry that I didn't try to move the lock to struct xsk_queu=
e
> > >>>> because after investigation I reckon try_cmpxchg can add less over=
head
> > >>>> when multiple xsks contend at this point. So I hope this approach
> > >>>> can be adopted.
> > >>>
> > >>> I still think that moving the lock would be preferable, because it =
makes
> > >>> sense also from a maintenance perspective.
> > >>
> > >> I can see your point here. Sure, moving the lock is relatively easie=
r
> > >> to understand. But my take is that atomic changes here are not that
> > >> hard to read :) It has the same effect as spin lock because it will
> > >> atomically check, compare and set in try_cmpxchg().
> > >>
> > >>> Can you report the difference
> > >>> you measure atomics vs moving the spin lock?
> > >>
> > >> No problem, hopefully I will give a detailed report next week becaus=
e
> > >> I'm going to apply it directly in production where we have multiple
> > >> xsk sharing the same umem.
> > >
> > > I'm done with the test in production where a few applications rely on
> > > multiple xsks sharing the same pool to send UDP packets. Here are
> > > significant numbers from bcc tool that recorded the latency caused by
> > > these particular functions:
> > >
> > > 1. use spin lock
> > > $ sudo ./funclatency xsk_cq_reserve_locked
> > > Tracing 1 functions for "xsk_cq_reserve_locked"... Hit Ctrl-C to end.
> > > ^C
> > >      nsecs               : count     distribution
> > >          0 -> 1          : 0        |                                =
        |
> > >          2 -> 3          : 0        |                                =
        |
> > >          4 -> 7          : 0        |                                =
        |
> > >          8 -> 15         : 0        |                                =
        |
> > >         16 -> 31         : 0        |                                =
        |
> > >         32 -> 63         : 0        |                                =
        |
> > >         64 -> 127        : 0        |                                =
        |
> > >        128 -> 255        : 25308114 |**                              =
        |
> > >        256 -> 511        : 283924647 |**********************         =
         |
> > >        512 -> 1023       : 501589652 |*******************************=
*********|
> > >       1024 -> 2047       : 93045664 |*******                         =
        |
> > >       2048 -> 4095       : 746395   |                                =
        |
> > >       4096 -> 8191       : 424053   |                                =
        |
> > >       8192 -> 16383      : 1041     |                                =
        |
> > >      16384 -> 32767      : 0        |                                =
        |
> > >      32768 -> 65535      : 0        |                                =
        |
> > >      65536 -> 131071     : 0        |                                =
        |
> > >     131072 -> 262143     : 0        |                                =
        |
> > >     262144 -> 524287     : 0        |                                =
        |
> > >     524288 -> 1048575    : 6        |                                =
        |
> > >    1048576 -> 2097151    : 2        |                                =
        |
> > >
> > > avg =3D 664 nsecs, total: 601186432273 nsecs, count: 905039574
> > >
> > > 2. use atomic
> > > $ sudo ./funclatency xsk_cq_cached_prod_reserve
> > > Tracing 1 functions for "xsk_cq_cached_prod_reserve"... Hit Ctrl-C to=
 end.
> > > ^C
> > >      nsecs               : count     distribution
> > >          0 -> 1          : 0        |                                =
        |
> > >          2 -> 3          : 0        |                                =
        |
> > >          4 -> 7          : 0        |                                =
        |
> > >          8 -> 15         : 0        |                                =
        |
> > >         16 -> 31         : 0        |                                =
        |
> > >         32 -> 63         : 0        |                                =
        |
> > >         64 -> 127        : 0        |                                =
        |
> > >        128 -> 255        : 109815401 |*********                      =
         |
> > >        256 -> 511        : 485028947 |*******************************=
*********|
> > >        512 -> 1023       : 320121627 |**************************     =
         |
> > >       1024 -> 2047       : 38538584 |***                             =
        |
> > >       2048 -> 4095       : 377026   |                                =
        |
> > >       4096 -> 8191       : 340961   |                                =
        |
> > >       8192 -> 16383      : 549      |                                =
        |
> > >      16384 -> 32767      : 0        |                                =
        |
> > >      32768 -> 65535      : 0        |                                =
        |
> > >      65536 -> 131071     : 0        |                                =
        |
> > >     131072 -> 262143     : 0        |                                =
        |
> > >     262144 -> 524287     : 0        |                                =
        |
> > >     524288 -> 1048575    : 10       |                                =
        |
> > >
> > > avg =3D 496 nsecs, total: 473682265261 nsecs, count: 954223105
> > >
> > > And those numbers were verified over and over again which means they
> > > are quite stable.
> > >
> > > You can see that when using atomic, the avg is smaller and the count
> > > of [128 -> 255] is larger, which shows better performance.
> > >
> > > I will add the above numbers in the commit log after the merge window=
 is open.
> >
> > It's not just a matter of performance. Spinlock additionally give you
> > fairness and lockdep guarantees, beyond being easier to graps for
> > however is going to touch this code in the future, while raw atomic non=
e
> > of them.

Right.

> >
> > From a maintainability perspective spinlocks are much more preferable.
> >
> > IMHO micro-benchmarking is not a strong enough argument to counter the
> > spinlock adavantages: at very _least_ large performance gain should be
> > observed in relevant test-cases and/or real live workloads.

The problem is that I have no good benchmark to see the minor
improvement because it requires multiple xsks. Xdpsock has bugs and
doesn't allow two xsks running in parallel. Unlike one xsk scenario,
it's really difficult for me currently to measure the improvement. So
I resorted to observing latency.

With that said, I will follow your suggestion to move that lock :)

> >
> > >>> Have you tried moving cq_prod_lock, too?
> > >>
> > >> Not yet, thanks for reminding me. It should not affect the sending
> > >> rate but the tx completion time, I think.
> > >
> > > I also tried moving this lock, but sadly I noticed that in completion
> > > time the lock was set which led to invalidation of the cache line of
> > > another thread sending packets. It can be obviously proved by perf
> > > cycles:ppp:
> > > 1. before
> > > 8.70% xsk_cq_cached_prod_reserve
> > >
> > > 2. after
> > > 12.31% xsk_cq_cached_prod_reserve
> > >
> > > So I decided not to bring such a modification. Anyway, thanks for you=
r
> > > valuable suggestions and I learnt a lot from those interesting
> > > experiments.
> >
> > The goal of such change would be reducing the number of touched
> > cachelines;

Yep.

>> when I suggested the above, I did not dive into the producer
> > specifics, I assumed the relevant producer data were inside the
> > xsk_queue struct.
> >
> > It looks like the data is actually inside 'struct xdp_ring', so the
> > producer lock should be moved there, specifically:
> >
> > struct xdp_ring {
> >         u32 producer ____cacheline_aligned_in_smp;
> >         spinlock_t producer_lock;
> >         // ...
>
> This struct is reflected to user space, so we should not put the spin
> lock there.

Agree on this point.

> But you could put it in struct xsk_queue, but perhaps you

My concern is that only cq uses this lock while this structure is used
by all types of queues.

> would want to call it something more generic as there would be a lock
> present in all queues/rings, though you would only use it for the cq.
> Some of the members in xsk_queue are nearly always used when
> manipulating the ring, so the cache line should be hot.
>
> I am just thinking aloud if this would be correct. There is one pool
> per cq. When a pool is shared, the cq belonging to that pool is also
> always shared, so I think that would be correct moving the lock from
> the pool to the cq.

Exactly, that is how Paolo suggested previously.

>
> > I'm a bit lost in the structs indirection, but I think the above would
> > be beneficial even for the ZC path.

Spot on, that will be part of my future plan. Thanks!

Thanks,
Jason

