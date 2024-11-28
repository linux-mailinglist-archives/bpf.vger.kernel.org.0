Return-Path: <bpf+bounces-45791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD99DB14C
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6A116465E
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC23E49D;
	Thu, 28 Nov 2024 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3FOV4HN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867038FA6
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759065; cv=none; b=aU6dMC0LdetYvkzLsQhJh4JBgSI2sGooq3myAW0OErPkxnxCaY2w8oEKqmfTGxw9Mqj3oLmmS+lhLupcbQwrvi/gRCPukzeN8bZtE50aFPcLrFBeAb5KRuCO31X4mvBcviBN1Ftbcy5qdL5GvYGIf03rBnrIHWYh5nQti7bV6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759065; c=relaxed/simple;
	bh=ZJ13Ir/HLauAPrvF3j/FSk/nyzBiPPBB2+hPU6J6SZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slH6jXwLy4s6tEa9Tb6/38XNI0ASOXFjLFtB84DrQldbBW/71msyyBo60NIUfOIUyWJDK34lt5xX/yUcMnu8O5sZ0x1LcpOxEUxYkEJWdhcOQAri7QDw8JV60QM6SfVHY4wnYJzxVN0YL/1wASLG0tAz0at6hqDZ5PER54jbPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3FOV4HN; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so366181a12.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 17:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732759061; x=1733363861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qbQXoauQqzug6KZwPKmhvt1YwKeNA6Oq5Bvkk1aitnQ=;
        b=h3FOV4HNlgRJJ0ujgvTZIhJyjf4V1esoMkRy3HaFtaS+UWJ4mzXQ/oAFF5TOTQDK2j
         TeFfoDoHJaB1W0lnsmreXRrf9OTdj095uljJh0dk8wD0Ue8DuNTDIxS7lWQhxSVp/VyN
         W2hDnV4jZyx+rFx62uLjtH9c4P20Ut5hlfXI8ATwkxuGuWI+pkrk0uS/GGJ19LEmknqH
         Vfx19//NYIVXrYWyDpCBPmnF09ddHVKLoSSb8CR5xz4GhWka42thudEg2kKn1gpVpCK9
         dBhlQaWlXMan/anzESM7Z1+S+vRkNfa/nXasawdkdb2Inm0M5fZ71Jea3N/tsKS63Rry
         wB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732759061; x=1733363861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbQXoauQqzug6KZwPKmhvt1YwKeNA6Oq5Bvkk1aitnQ=;
        b=du8ctPEMlgSW5evsmIiOQAJaMewqP2s3I0X+b8FzQYRNGxL8CE2tK7QvasI5sl4u+1
         v46BOSJ+jzLkzC27j76mvAYKjNYJvpPG3YcUZ9aVDlPTNBzjJ16nCkiSlKkHnqppZtgh
         bT0ISfAZPHLCnq7v+NnUwjucBbBqMekb/4vne6vHY9Qnl902NlzgKsqKajrdOaXTjgEQ
         GnjkCElQ2veca7LmYbfz0AX0OiVb5QXGmrCrtNrM7NZEaUIyFOwjbexe2qjcmMIfAGD/
         3UMXi25lDIh5sKeYSHQe0GBwgoOvgJou5jedmSQ7Wf+hPCIyzuMioA0sWBYXMVlvzCzL
         HFwQ==
X-Gm-Message-State: AOJu0YwiLqa/urXYc5HnCbSaJUrtivZaglekv7e5IckFhp5Dc4bSV1Qi
	1zwMh30UjA7DxeFzGNzcSkphNr0wiT380xcs64Zh5my3diYZULuYXrda6owkveH0L7YU7K1cb0l
	WP8j2eWd9zp3NOE8iVWkG42L5zXw=
X-Gm-Gg: ASbGncvj+aP3xcZpcdNy81U9xAeP/4ikwXZGjSJDbgNfkdrLFSD3kW75atYewgoLB2Q
	SzAONibPSAa3k9S84o1oRJR3mwhbLHgb4
X-Google-Smtp-Source: AGHT+IEcSdfwGkma68DHOSo/SDi+gqFYCLk9tRAjx/Ee+MF2ZKIADfz/pM6pmQKu6ynUGINu8kgEUWsBPaFPaM2w8JQ=
X-Received: by 2002:a05:6402:42c7:b0:5d0:225b:f44d with SMTP id
 4fb4d7f45d1cf-5d080ca538dmr4342533a12.33.1732759061389; Wed, 27 Nov 2024
 17:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212026.3580542-1-memxor@gmail.com> <20241127212026.3580542-4-memxor@gmail.com>
 <f0fbf1268f34b3eb7b74359dc11ec4299f5d77ad.camel@gmail.com>
In-Reply-To: <f0fbf1268f34b3eb7b74359dc11ec4299f5d77ad.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 28 Nov 2024 02:57:04 +0100
Message-ID: <CAP01T76567Rf4iou=9CF+iWOVQp0VHwvEcUyaeS_2kx9hZBgWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for reading from
 STACK_INVALID slots
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 02:50, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-27 at 13:20 -0800, Kumar Kartikeya Dwivedi wrote:
> > Ensure that when CAP_PERFMON is dropped, and the verifier sees
> > allow_ptr_leaks as false, we are not permitted to read from a
> > STACK_INVALID slot. Without the fix, the test will report unexpected
> > success in loading.
> >
> > Since we need to control the capabilities when loading this test to only
> > retain CAP_BPF, refactor support added to do the same for
> > test_verifier_mtu and reuse it for this selftest to avoid copy-paste.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       | 41 ++++++++++++++++---
> >  .../bpf/progs/verifier_stack_noperfmon.c      | 21 ++++++++++
> >  2 files changed, 56 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > index d9f65adb456b..aaf4324e8ef0 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -63,6 +63,7 @@
> >  #include "verifier_prevent_map_lookup.skel.h"
> >  #include "verifier_private_stack.skel.h"
> >  #include "verifier_raw_stack.skel.h"
> > +#include "verifier_stack_noperfmon.skel.h"
> >  #include "verifier_raw_tp_writable.skel.h"
> >  #include "verifier_reg_equal.skel.h"
> >  #include "verifier_ref_tracking.skel.h"
> > @@ -226,22 +227,50 @@ void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_pack
> >  void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> >  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
> >
> > -void test_verifier_mtu(void)
> > +static int test_verifier_disable_caps(__u64 *caps)
>
> The original thread [0] discusses __caps_unpriv macro.
> I'd prefer such macro over these changes to prog_tests/verifier.c,
> were there any technical problems with code suggested in [0]?
>
> [0] https://lore.kernel.org/bpf/a1e48f5d9ae133e19adc6adf27e19d585e06bab4.camel@gmail.com/#t
>

I think that patch worked as well, but I got to look at this now after
all these months, and concluded that
what Daniel did in
https://lore.kernel.org/bpf/20241021152809.33343-5-daniel@iogearbox.net
was also
acceptable and preferred.

I can add your patch to this set and respin, or post a follow-up converting
test_verifier_mtu to it as well. Whatever is preferred.


> >  {
> > -     __u64 caps = 0;
> >       int ret;
> >
> >       /* In case CAP_BPF and CAP_PERFMON is not set */
> > -     ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, &caps);
> > +     ret = cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_ADMIN, caps);
> >       if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
> > -             return;
> > +             return -EINVAL;
> >       ret = cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP_PERFMON, NULL);
> >       if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
> > +             return -EINVAL;
> > +     return 0;
> > +}
>
> [...]
>

