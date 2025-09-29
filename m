Return-Path: <bpf+bounces-69967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D4BA9FFB
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E033C68DB
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F92930B508;
	Mon, 29 Sep 2025 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1weMz+X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7A309F11
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162644; cv=none; b=MCAbSMENz8I7X8hrwQBegob2xe4Wb/VyhxlgB7tRPon+G9oqWvBVoRuLfDbZkYrOLFw0wXfeBQJV3M5NOKr+neYZ4u1zELZ6X7qsEr/KbSMkUcF6D561sPpBiX/w+lyIErsOGL8aqEltwF/ynxHOjOLLl2pL19urTHqcLPf8LAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162644; c=relaxed/simple;
	bh=8o2s1tF4eaZwpeZFW06G2tuYw74hhrixUG98PqTe0gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmX4UYpkcsGFOoW2PuQpttA1CIxdExNIjKtkWMgRCvR/l9eL/BDPy24lytbwDZ8PNr2QofVIYIuwL4EchMiXMYzH1OkZV2p6HCowEhivt/8S6G98wiZgoNW2+WtfAFeNzsQa8JYYfBLA4a6x3f7gGdOJFfv8ro1dZ/F2V8SMJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1weMz+X; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so2976360a91.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759162641; x=1759767441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B2o+rXDQaT/xS8xobKGHrDnzOe/RiiKRhwSstM/iCU=;
        b=c1weMz+X8Dzc1J+ejaUrFlr/xqA62TiDH4GdE8IXoOmQHPr6yXL1QVRs2YorTMFGc6
         XxBlhNqXAlj1HUE28u1gqrrcNcH9rVRgo1cURzyBLwbLtAbiIzTXYEOETvepj5v7gVwB
         5DvUOV7Jx6BUFs8MLkZq7gzc6N7CTVc6z8D+vh1rRfeW62ilrm4KhdNtp5fISJfftQhP
         QQbPu5oj6CtWKRTc5EQr2q2IgvOBcUXDbTKhgeUIx6+jdv1OolWRcsoA/xAkg1LZFs7g
         NAxebSVSbDqaDHub3rIl0r4tMUguZRK2TemHY073oSTXe2g2YUKqXtckHRfcU7fcOsvT
         9twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162641; x=1759767441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B2o+rXDQaT/xS8xobKGHrDnzOe/RiiKRhwSstM/iCU=;
        b=YMEMQQIygg0Ah0GmB0QuYl6OkgiAerRoZC4DVqqjg0PRdEYUKikpUPXpkdOwewRLiP
         s+stXAjX4VhOQqrGyRduLuQiAVWkfeM+RTHtsN5JWQZWGrGFWY/cjZihjQCjwSgCICH5
         hxKZ11NwM71xF3aXVXrqrn5oM5jRZTa8uWud2ShR5u57SO5blafnvh9SjZaOfJpGbCZH
         SCIJX7X5pbnaMWA0QzTlP5JuRkyszDHQBApvwcLgKcjwbagNoSZv6PC0B6XPm/74ne9U
         6OvVYYx2h8FgpAK11Lgcol4uDcOAEDPRlaGky/g/q/pdKz0Xuw7WPv7wnW+hunAzgD2g
         mMGQ==
X-Gm-Message-State: AOJu0Yz3zbQ/rEjx37qkb0CL399iYpXYOwxEkEvUIcIi4o1i/7CdBXpQ
	deWti7dDVWNjcsAN0I2uGdAYohyodrk8NxJo8UU4TNgN/Pa9BPiGFyEm6KF+FztAzp9ZWV6+23r
	ZWQYyhSuCt1hPiRpEtoHKgHwQ7CFMdCI=
X-Gm-Gg: ASbGncskyV5aPV8p/KRLOkbt1FHO8uqNYQFoiKE6DTzgBgDFM8ZPti37S8RuNkpUayt
	fPlfhSq0/TX/09kQtHwUZd2Jd/9gQEem12Q7KpiKzkGDFTRsRlJ9rOivTuaN7N9TVQTgMIZkch/
	UZEl1IVrBEc/U5NcYQZkushhjYh1yHud3CnXsg1lKMdO7dcME2qQUY1PPO6u764HPQ7RcPFzLDI
	8W1QszHbz01XtoLd8yNBif/iqDrygb1fA==
X-Google-Smtp-Source: AGHT+IFgdWOMh4DmcKRzA2FDQjzJw2H17sYEudBXenHuiSFHaPV3EZDmU0DN5nNaFUUpFp+uZpv4UYS5ySAH87sBJIY=
X-Received: by 2002:a17:90b:17d0:b0:32b:96fa:5f46 with SMTP id
 98e67ed59e1d1-3342a22be59mr18834574a91.5.1759162641108; Mon, 29 Sep 2025
 09:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925153746.96154-1-leon.hwang@linux.dev> <20250925153746.96154-6-leon.hwang@linux.dev>
 <CAEf4Bzacd768RGKyujM7TTWa-JeNnZntJbJoZr2FetCR4X-soQ@mail.gmail.com> <b3eb97bb-ba9e-4f1c-96e6-8fab12efab2d@linux.dev>
In-Reply-To: <b3eb97bb-ba9e-4f1c-96e6-8fab12efab2d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Sep 2025 09:17:09 -0700
X-Gm-Features: AS18NWAfLik0w1d1I9NfBbiCWxoeq7iNKLHjT9p3dQ5vEK8dUwZSAd1IcjpLE8I
Message-ID: <CAEf4BzbKpsCee5k03XgSzLNNGxXjK5jyx6Yk=2mQxAzSetgwMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_cgroup_storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 8:06=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/9/28 10:42, Andrii Nakryiko wrote:
> > On Thu, Sep 25, 2025 at 8:38=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps t=
o
> >> allow updating values for all CPUs with a single value for update_elem
> >> API.
> >>
> >> Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
> >> allow:
> >>
> >> * update value for specified CPU for update_elem API.
> >> * lookup value for specified CPU for lookup_elem API.
> >>
> >> The BPF_F_CPU flag is passed via map_flags along with embedded cpu inf=
o.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf-cgroup.h |  4 ++--
> >>  include/linux/bpf.h        |  1 +
> >>  kernel/bpf/local_storage.c | 22 +++++++++++++++++++---
> >>  kernel/bpf/syscall.c       |  2 +-
> >>  4 files changed, 23 insertions(+), 6 deletions(-)
> >>
> >
> > [...]
> >
> >>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
> >> -                                  void *value)
> >> +                                  void *value, u64 map_flags)
> >>  {
> >>         struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
> >>         struct bpf_cgroup_storage *storage;
> >> @@ -199,11 +199,17 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_ma=
p *_map, void *key,
> >>          * will not leak any kernel data
> >>          */
> >>         size =3D round_up(_map->value_size, 8);
> >
> > um... same issue with rounding up value_size when BPF_F_CPU is set, no?
> >
> >> +       if (map_flags & BPF_F_CPU) {
> >> +               cpu =3D map_flags >> 32;
> >> +               bpf_long_memcpy(value, per_cpu_ptr(storage->percpu_buf=
, cpu), size);
> >> +               goto unlock;
> >> +       }
> >>         for_each_possible_cpu(cpu) {
> >>                 bpf_long_memcpy(value + off,
> >>                                 per_cpu_ptr(storage->percpu_buf, cpu),=
 size);
> >>                 off +=3D size;
> >>         }
> >> +unlock:
> >>         rcu_read_unlock();
> >>         return 0;
> >>  }
> >> @@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_ma=
p *_map, void *key,
> >>         int cpu, off =3D 0;
> >>         u32 size;
> >>
> >> -       if (map_flags !=3D BPF_ANY && map_flags !=3D BPF_EXIST)
> >> +       if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F=
_ALL_CPUS))
> >>                 return -EINVAL;
> >>
> >>         rcu_read_lock();
> >> @@ -233,11 +239,21 @@ int bpf_percpu_cgroup_storage_update(struct bpf_=
map *_map, void *key,
> >>          * so no kernel data leaks possible
> >>          */
> >>         size =3D round_up(_map->value_size, 8);
> >> +       if (map_flags & BPF_F_CPU) {
> >> +               cpu =3D map_flags >> 32;
> >> +               bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),=
 value, size);
> >
> > ditto
> >
> >> +               goto unlock;
> >> +       }
> >>         for_each_possible_cpu(cpu) {
> >>                 bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
> >>                                 value + off, size);
> >> -               off +=3D size;
> >> +               /* same user-provided value is used if BPF_F_ALL_CPUS =
is
> >> +                * specified, otherwise value is an array of per-CPU v=
alues.
> >> +                */
> >> +               if (!(map_flags & BPF_F_ALL_CPUS))
> >> +                       off +=3D size;
> >
> > btw, given we'll need another revision to fix up all those round_up()
> > issues, what do you think about make this offset logic completely
> > stateless (and, in my opinion, more obvious):
> >
> > for_each_possible_cpu(cpu) {
> >     p =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
> >     memcpy(per_cpu_ptr(storage->percpu_buf, cpu), p, size);
> > }
> >
> > seems more straightforward to me
>
> lgtm.
>
> But I think the correct memcpy() should look like this:
>
> memcpy(per_cpu_ptr(storage->percpu_buf, cpu), p,
>        (map_flags & BPF_F_ALL_CPUS) ? _map->value_size : size);
>
> because 'size' is 8-byte aligned and can=E2=80=99t be used directly when
> 'map_flags & BPF_F_ALL_CPUS' is set.
>
> So the more accurate version would be:
>
> for_each_possible_cpu(cpu) {
>     p =3D (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
>     s =3D (map_flags & BPF_F_ALL_CPUS) ? _map->value_size : size;
>     memcpy(per_cpu_ptr(storage->percpu_buf, cpu), p, s);
> }
>
> Isn=E2=80=99t this the correct approach?
>

Yes, but I think it would be better to update:

size =3D round_up(_map->value_size, 8);

to take into account BPF_F_ALL_CPUS instead and do it once outside of
the loop. But same idea, of course, yes.

> Thanks,
> Leon
>
> [...]

