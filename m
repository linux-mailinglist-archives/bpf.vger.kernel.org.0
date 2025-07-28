Return-Path: <bpf+bounces-64525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD0B13D19
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743CD18924BF
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849326E6F1;
	Mon, 28 Jul 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE0xy8ZC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9825B31D;
	Mon, 28 Jul 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712849; cv=none; b=mUItTLVw8UnU55954RSI9cpwOhnLR76CLhEQUArYFRJjk6dWSeZwSotmBW0jZqCjejGKlI4JkHx1ZTODSyhx2J/94oW0BfH2OKqU9fOs2iLPIJIV+KB9YPRYA/YD7/l9ACI41T871kvQx2TYnNTlpUaDvXpFTyDyCQezU/KyGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712849; c=relaxed/simple;
	bh=7zm2FGQ9vOOvJIm2tvtvlk80cBSBd801PEC0N1SnLDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElBHY5542/cgT2h+5Q3UBnjR6nFG9m37zzbUFGVxhyvqTRy233e6wQAY4zGAYYXiH7qloB3/Gp6Fv8kp5y14UGWrcX9LVn46/UKDFcu80GjgCST5rqRiHTwGZQnATIr1+XLgpzGdarrYfUN1zy85RWn7xXCeG7oOk9MBLSWN89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE0xy8ZC; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e8e0762f77dso1358689276.1;
        Mon, 28 Jul 2025 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753712847; x=1754317647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9KSB2FjmxT/5yB3jtGtNbbQBs9Hk1mlNkL6Fggc0dU=;
        b=BE0xy8ZCXKpFTajEO6c/x7pnlfy8pGddE0VKGHWdBGZgQ2lYe2AVhhFUAoruwktfxX
         I8ouljpHVRyE7U0dJ7jVfW+XNDzIfNkBjX3YthQkYfcj6BPTqHQnS/yIjV2HcYDPmt4q
         AjuvESkv7GRiLdqaIXhYZQZ+PWvtcrKPPtwuUoDv2HT99mq1Aiu/CPnNviEkVjXTHRZ4
         dMjdarszfQ4iNRvXpNYsGp9zs52BQkuOBWQsG2jil0gx2TgKJgRxoTPPMDl7kZOULc/1
         ogrYSEL+rx1m036up+Lh7QptkdKbFo7HVy1M54XbDJfc/+EILTEOOCB1IHAPWexNTvOu
         aRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753712847; x=1754317647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9KSB2FjmxT/5yB3jtGtNbbQBs9Hk1mlNkL6Fggc0dU=;
        b=JDtNrVJ+oCXIVBEL4b2daTlVspl7dYnImatshIndyuyzNLca8ahewlKFN26x5oCrEn
         V3SphOaGbiIvfsblz3derwd1anBGa0IAy6OHLCkUqZ2yy/DkU51ApvCaky8rcYK/9/1t
         OJQFxMYRWzLllNrwSZEnl3QjRwf+66IyyipmhAX+1s7WFxdAx4x2XrN64GxoQfHI1eOA
         IbiFdyPGYdme9J9j2xfQxPk3GkiW965XehPswTTA9pQHjztFA77PxYJN3vcIImLpYULz
         vFjkmhCdm9da7Sb6HT/RcsYA3PPfg++KV78UfOaV1S0JA8tkEXqOLIcY2om/t4gPrbHi
         7KJg==
X-Forwarded-Encrypted: i=1; AJvYcCUAF9iT82p4XIr07nn8QP3FPAvgoJBnCYnqJuv9iMIUnvUi5jwBvBf6fZc9x9QOmsKjKb2TrPhS5K+c8du2iLtwo6Bs@vger.kernel.org, AJvYcCWJNE5DsK11whJMETzQGr85Ik4VIS+oCH/C2AH2xUEQAOguk+UdXvqO9Xx+G4RbN/e22xk=@vger.kernel.org, AJvYcCXioyKngtgRuhjlbwEuGc6HQ5MjzvkPvLcxy9VRTKdUZHPdjP273SHtk1cuKN1a/S6ly1qqta/OXEs5Rwqv@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyPCTRV/KUArXfgEPvDdBNogk9sDohvmlFWhEg2suf1yqCDuF
	hk8NgDc2C+PIJxBBaKdUqLVSkfjPvT193JG7CLzbPWwPR7683J/7Oeqi83Vv29E4IgBHqPCLqCZ
	NGwok34MVHGWDjn/FRE+bJn7FLIgebiJyiaPzH2s=
X-Gm-Gg: ASbGncsRHaZ/gcxiDqrD7fbQe50WCANJ8eJc2TE5sw3DpN4Tv0NRi6v7MFX6sZflVLy
	5v6QJE3UiNuuNZZPGg4uX1WqnkTsOGhJmnG6phK4wA6YP1nLaMcr5dvIcLN2iMjwAb66MuxKsXV
	3Jah0h7QiIFt5pp9s7DMjtm/vQbQFM48GCSmMaCPJozjSphp7PbDaigWwF+1dvAWJomct6hzjQI
	0UBslQ=
X-Google-Smtp-Source: AGHT+IGMEJ2WWAOV8Jxci9Mfk3A0Vg2xFzCUM7JtAJ/6n5EiB6/2omL1KiQH8FSJfDvSMaAUZCztdnMLOHMvBT1+Gk0=
X-Received: by 2002:a05:6902:2208:b0:e8e:1776:5167 with SMTP id
 3f1490d57ef6-e8e177661a1mr3523595276.7.1753712845861; Mon, 28 Jul 2025
 07:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728072637.1035818-1-dongml2@chinatelecom.cn> <aIeCXbpno1y3Aio1@krava>
In-Reply-To: <aIeCXbpno1y3Aio1@krava>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 28 Jul 2025 22:27:15 +0800
X-Gm-Features: Ac12FXzE3AQuXqXUlz6stm45SI_Q39R_hBGKLYojd2mUoDDNfo5676mrYSsqtNU
Message-ID: <CADxym3bTqABn=Q+khg6rDQEGdZxGxLZ4WjEBHc4HFbSJtPj+=A@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 0/4] fprobe: use rhashtable for fprobe_ip_table
To: Jiri Olsa <olsajiri@gmail.com>
Cc: alexei.starovoitov@gmail.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, hca@linux.ibm.com, revest@chromium.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:00=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Mon, Jul 28, 2025 at 03:22:49PM +0800, Menglong Dong wrote:
> > For now, the budget of the hash table that is used for fprobe_ip_table =
is
> > fixed, which is 256, and can cause huge overhead when the hooked functi=
ons
> > is a huge quantity.
> >
> > In this series, we use rhltable for fprobe_ip_table to reduce the
> > overhead.
> >
> > Meanwhile, we also add the benchmark testcase "kprobe-multi-all", which
> > will hook all the kernel functions during the testing. Before this seri=
es,
> > the performance is:
> >   usermode-count :  875.380 =C2=B1 0.366M/s
> >   kernel-count   :  435.924 =C2=B1 0.461M/s
> >   syscall-count  :   31.004 =C2=B1 0.017M/s
> >   fentry         :  134.076 =C2=B1 1.752M/s
> >   fexit          :   68.319 =C2=B1 0.055M/s
> >   fmodret        :   71.530 =C2=B1 0.032M/s
> >   rawtp          :  202.751 =C2=B1 0.138M/s
> >   tp             :   79.562 =C2=B1 0.084M/s
> >   kprobe         :   55.587 =C2=B1 0.028M/s
> >   kprobe-multi   :   56.481 =C2=B1 0.043M/s
> >   kprobe-multi-all:    6.283 =C2=B1 0.005M/s << look this
> >   kretprobe      :   22.378 =C2=B1 0.028M/s
> >   kretprobe-multi:   28.205 =C2=B1 0.025M/s
> >
> > With this series, the performance is:
> >   usermode-count :  902.387 =C2=B1 0.762M/s
> >   kernel-count   :  427.356 =C2=B1 0.368M/s
> >   syscall-count  :   30.830 =C2=B1 0.016M/s
> >   fentry         :  135.554 =C2=B1 0.064M/s
> >   fexit          :   68.317 =C2=B1 0.218M/s
> >   fmodret        :   70.633 =C2=B1 0.275M/s
> >   rawtp          :  193.404 =C2=B1 0.346M/s
> >   tp             :   80.236 =C2=B1 0.068M/s
> >   kprobe         :   55.200 =C2=B1 0.359M/s
> >   kprobe-multi   :   54.304 =C2=B1 0.092M/s
> >   kprobe-multi-all:   54.487 =C2=B1 0.035M/s << look this
>
> I meassured bit less speed up, but still great
>
> kprobe-multi-all:    3.565 =C2=B1 0.047M/s
> kprobe-multi-all:   11.553 =C2=B1 0.458M/s
>
> could you add kretprobe-multi-all bench as well?

OK, I'll add it.

>
> thanks,
> jirka
>
>
> >   kretprobe      :   22.381 =C2=B1 0.075M/s
> >   kretprobe-multi:   27.926 =C2=B1 0.034M/s
> >
> > The benchmark of "kprobe-multi-all" increase from 6.283M/s to 54.487M/s=
.
> >
> > The locking is not handled properly in the first patch. In the
> > fprobe_entry, we should use RCU when we access the rhlist_head. However=
,
> > we can't use RCU for __fprobe_handler, as it can sleep. In the origin
> > logic, it seems that the usage of hlist_for_each_entry_from_rcu() is no=
t
> > protected by rcu_read_lock neither, isn't it? I don't know how to handl=
e
> > this part ;(
> >
> > Menglong Dong (4):
> >   fprobe: use rhltable for fprobe_ip_table
> >   selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
> >   selftests/bpf: skip recursive functions for kprobe_multi
> >   selftests/bpf: add benchmark testing for kprobe-multi-all
> >
> >  include/linux/fprobe.h                        |   2 +-
> >  kernel/trace/fprobe.c                         | 141 ++++++-----
> >  tools/testing/selftests/bpf/bench.c           |   2 +
> >  .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
> >  .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
> >  tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
> >  tools/testing/selftests/bpf/trace_helpers.h   |   3 +
> >  8 files changed, 348 insertions(+), 282 deletions(-)
> >
> > --
> > 2.50.1
> >
> >

