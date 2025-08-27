Return-Path: <bpf+bounces-66635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169DB37A42
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 08:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22AC2082F5
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA972D6E67;
	Wed, 27 Aug 2025 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmGeH2J8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211F27AC34;
	Wed, 27 Aug 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275772; cv=none; b=hjK22/cCc2CMNE1gjBhy3WzEgrt1vCzFo+3G727l/LU6nwyK98mckLU3eov9qfvy4SWKECtOyE4nX+qaOU8fbEpL6IaW2v5lX5alFrItBp/jRd5pAe8mehG8TlUIj1uSq45m8UoKUQKI1udt/I9xANdnnyF+DKjxO9kw9KD/l9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275772; c=relaxed/simple;
	bh=i5Z98JBL4ZRm8ZAAvzrQAdtEJNsiKalwKRWjVaREip4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTNSb0LIDZUOC4Pfw2aTyH3MpcnqeLS2aXFbiUbMQVNgc1WxMiwNCLkvwTDagqaJk/zyYLaxJTvj99IlSyGtXuVfhDAz9oefHDN9kN8ob49JYpCvR3/KltJXP5Ns15cEgudUKgsLjov3MmInBa+zaer/gJmVFAB7w3L55uLEOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmGeH2J8; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71fd55c0320so3767077b3.0;
        Tue, 26 Aug 2025 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756275770; x=1756880570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5Z98JBL4ZRm8ZAAvzrQAdtEJNsiKalwKRWjVaREip4=;
        b=SmGeH2J8uMdkR6w0ZcZbYbaYv8TWXVuFgLYeCSCfIkEEDisF2v8zV3FTWcmF/9fHjO
         D6iMJ6yOkm9EvRixqcA9U7qhUve7HR4bcZEyjZR9gLepLCwUE/xXTMqIJ4dwwW2zESUw
         Anh8rcuFUvw89bYF4JFeUXZaOexw+wrxNZUhzeAAJnbtse8ucTaj2mNyTcS1LEYsmt/k
         KfShZDKG7N1uP1sGuSNdy/lPN5fqpIXZ12tNw934c6oB6bbsRBtHsB08TcXoMiCCOEeD
         hCqOvBiPdY7H2gj6INo5yTt0fpTGmhl/4D5Nt31oI/D+0ELeREmbwthZyXuuDlAaX8Om
         vesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756275770; x=1756880570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5Z98JBL4ZRm8ZAAvzrQAdtEJNsiKalwKRWjVaREip4=;
        b=fyJ645b+nuA4D0jR9HWlWrmTWImf6fa6EkkW30Ny/Xd7rl+Dm/6CtAbaSdzSoJo/cx
         M2z9z4zLzAV8zNVtVUPm3BhaAglM71aZevb6oX8sbf+EVjsWyvR6+mZwfQ/XiRLCRFz9
         vxeMF0s8zo2jwctEanUf8CehbUEMoBLR8SS+0De1jQuT1krx43JaIu7S2B93LVM9A6a2
         pwZebjceDUSiiohPUtV1LIvCBl8xdN3fkePRQjQIAbup4gZRqJ8DLFo1OXFe5OOAYzCT
         lbrUIpG2CtVwg5pD6KmX2PvL+pZG4kMYK6rRm87zl8KLcD913Y7u38K6gFZKZsEdlA5V
         1Dug==
X-Forwarded-Encrypted: i=1; AJvYcCUURnTyDMCMElnv5zB7dl8NDoK8FEFGdel5xa+AtaSWnQDWe4GkQyKD2kQOCncQXdvDwB8NUzx0FhXc4EdZ@vger.kernel.org, AJvYcCUXHmzJcRlkQd6nbDt6lRdcwycDYFmxbpazR/ck1R4zCZ45FmeCCIYob0D8971+D3l3ANE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXO+qg74q7AP1BYf2Lfl3QDRVELYFha3w45RZaa1vGeWgnt0i
	GDbuYK6Jxw1ZPCb9L5J157apSiyKHWGKxd3W+FFqX3bPCSV2vuBmDlvJe0YntLSsI8SbamPcQ7/
	Wny80KrDl1JDJ5GLOM0x4DHILCdnOuQM=
X-Gm-Gg: ASbGnctfx+t+8WYtpoL+ORcsPzSbEJSqnEoZkL3b+fT6d9AYvCzulmLxBQMDkA7p6gA
	0c1SMAGpud135O5h8VIdmwmtTUTcsFJp3t/R6E5f+iX6WvKqbHQlYlDMIgu2VIIeLOkaJo+nELv
	o92YpPQ1G/LyQMBL5AmvXbhRUwi5ZYPw7GAgv8OUF3F/J1HnBjmcivskihqjDNjvMjYfojaituM
	8Qv0K43/a/7nACOXSxbTA==
X-Google-Smtp-Source: AGHT+IHg9t6VnHhdv9h9VYHLrojs1PMTbAmMK5L3FruHKEosljEdP4iFL5OoULJEdzUB2UFKSXBcIg9upiAz5I9r5uI=
X-Received: by 2002:a05:690c:9a91:b0:71c:3e81:cca2 with SMTP id
 00721157ae682-72132cd73d2mr49513067b3.1.1756275769969; Tue, 26 Aug 2025
 23:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821093807.49750-1-dongml2@chinatelecom.cn>
 <20250821093807.49750-2-dongml2@chinatelecom.cn> <CAADnVQLtvygmqCk5QHmHCURAYiLET6BpCxX7TkqmuAdXZ5trZg@mail.gmail.com>
In-Reply-To: <CAADnVQLtvygmqCk5QHmHCURAYiLET6BpCxX7TkqmuAdXZ5trZg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 27 Aug 2025 14:22:39 +0800
X-Gm-Features: Ac12FXxYc9Qsprt4i1o2DwC0ZlDsRGXsGvNWnd_bb7-88fUYOME2dQElDiGJ3X8
Message-ID: <CADxym3ZoAW6Wfn-TYBFeEPnPbb-Xqc=ZWpAmoL4Bzea83UuJnw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Aug 21, 2025 at 2:38=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The include/generated/asm-offsets.h is generated in Kbuild during
> > compiling from arch/SRCARCH/kernel/asm-offsets.c. When we want to
> > generate another similar offset header file, circular dependency can
> > happen.
>
> Is there a way to avoid all this churn?
>
> > For example, we want to generate a offset file include/generated/test.h=
,
> > which is included in include/sched/sched.h. If we generate asm-offsets.=
h
> > first, it will fail, as include/sched/sched.h is included in asm-offset=
s.c
>
> if so, may be don't add "static inline void migrate_disable()" to sched.h
> and instead add it to preempt.h and it will avoid this issue?

It's hard to avoid this churn. Take bounds.c for example, it defines
the macro __GENERATING_BOUNDS_H. For the header files that
it includes, it will exclude almost all the unnecessary code in
page-flags.h, mmzone.h if __GENERATING_BOUNDS_H is defined.
We can't use this approach, as it's hard to decide what to exclude
in sched.h.

We can't add migrate_disable or __migrate_disable to preempt.h,
as struct task is used in it, which is not available in preempt.h :/

I think this stuff can be reused in the feature if someone wants
to add such an offset.

Thanks!
Menglong Dong

>
> > and include/generated/test.h doesn't exist; If we generate test.h first=
,
> > it can't success neither, as include/generated/asm-offsets.h is include=
d
> > by it.
> >
> > In x86_64, the macro COMPILE_OFFSETS is used to avoid such circular
> > dependency. We can generate asm-offsets.h first, and if the
> > COMPILE_OFFSETS is defined, we don't include the "generated/test.h".
> >
> > And we define the macro COMPILE_OFFSETS for all the asm-offsets.c for t=
his
> > purpose.

