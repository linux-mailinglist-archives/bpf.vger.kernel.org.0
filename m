Return-Path: <bpf+bounces-23193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DC486EAFE
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797DD1C22B9A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9C57323;
	Fri,  1 Mar 2024 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv26pQpJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3B3D546
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327812; cv=none; b=NCLZrdys8EsCzIixtnpfi1fj91nAfr4oWvFOL8sOHb4pIcdhoJ4GcLLHCzBxTdk/JraKi4ef5gjHCTFrCp85nBK3QUIF4tDJY6WhdUTfBzbmsafCJ370Ic5PmbXyp1b6XHBByNuEZ2kQwRQffwzxNiLmLG9/f2Y4uFYDLu5u0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327812; c=relaxed/simple;
	bh=hByGuXSbMm0etBhv8CuvjvURdGCzZ3ecmH6Tr5c6i/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4zahiumyKyhwYciPJhiZYafCruq5LRDx2f/B76ie8nh0/UnGbwKsUu1s0vgwFYbuZX2KSKLRmp5mgUgwiq3qrCQYLMS4kzRrkiqMJDnHUj7LjQXMsXikAnUoTTj3/uM+YlXtY2E508lRSpMlqiSAoT4eqINJw+y/NYO9ZmCbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv26pQpJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412ce4f62f8so3003635e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 13:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709327808; x=1709932608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zG6v+/TtLhyVmZn8LqdwA+2N2n3NKG9AGPzrrWfbrw=;
        b=Dv26pQpJjYiytrzetV5G6y0XIXUy9sk1rh4h/gHPuuyhpZRfSXxQA3fcyzDus76MMs
         DyVoKt9DbY/IKu85Qi/eNXU/R+Kycwst5chrCZ2TGaIwIrJPd9tTfp5+dRNxhuvXTaNJ
         OCq6Vbz+J9bjDihneL3ReHsTeiSb8f+zya9S9ZwlSiHdoNehttBhn5EYHd2sgW4Y6A5D
         rwIM1BPLRg1jGCQARTCIQt/bRnISz9zuAExlmLdKxz+vWexjLB+cZmVy0X1M0ASviB4N
         K3c/xE97QEf6grtp8hwUl0azWY1StA4aQ9tVGpJ64h9szQDQn5+Ld/lCqe3FBiud72lz
         n3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327808; x=1709932608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zG6v+/TtLhyVmZn8LqdwA+2N2n3NKG9AGPzrrWfbrw=;
        b=pK2ZotbCFgDirK5enxdAbiFGi6zGdTNaWngkUWpRlTaLVh5SJ2IegL6R2pzybhKvZR
         uW0C/nHnde1DcJF0OC/AkWl8cUAYChtTo1DhDUTWaTODmkPkhtg1v91aATijos6IbE+9
         dOmxi+lRaFDEQUHW2ImJVwiZQAY6QKALwkHE0E65lQIDoDHsCU021xUvCULyi4N30SYl
         JilckhQAPn+O9ukMq82bIS8JSxI/PQCYkzSm9n1icUfIRRC7QcS5ZSSksxha7UXsU8ci
         7djqz86O9G5GwCOhUARDiDu505IczufKPHJPFC7hmym1hGPNyIrjju9Z7fosee4oYYTY
         Wmjg==
X-Gm-Message-State: AOJu0YwTaMbMy0wjNlXQBvIhotNZyNJZSj/xN7yqMrwFBEhlnuIDimTx
	3aoMh2q1zoPHzAfRAHGtRcF+yzFZrxi2fy8DgY2r5J8ujhX9I87KVzDoRPViso+SWF7W7x+hUgY
	w1PAGJk+cyel/1DNbTpKAsHKEBzw=
X-Google-Smtp-Source: AGHT+IGruIupzvmfVi4Mvl49kI+k7JIEAk0ilqYFKzN4JmcWBZW9Q12EhuPrcPaHjPyRRZ+iMPFUEf4Wx1GX2EYVG24=
X-Received: by 2002:a05:600c:4748:b0:412:817c:364e with SMTP id
 w8-20020a05600c474800b00412817c364emr2456816wmo.36.1709327808320; Fri, 01 Mar
 2024 13:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
 <20240301033734.95939-5-alexei.starovoitov@gmail.com> <65e230d4670d9_5dcfe20885@john.notmuch>
In-Reply-To: <65e230d4670d9_5dcfe20885@john.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 13:16:36 -0800
Message-ID: <CAADnVQKKFxioLAqLPNq7mvt4GOHpC0j80-SUYzYQkpno3d+49Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftests/bpf: Test may_goto
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:47=E2=80=AFAM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Add tests for may_goto instruction via cond_break macro.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> >  .../bpf/progs/verifier_iterating_callbacks.c  | 72 ++++++++++++++++++-
> >  2 files changed, 70 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing=
/selftests/bpf/DENYLIST.s390x
> > index 1a63996c0304..c6c31b960810 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > @@ -3,3 +3,4 @@
> >  exceptions                            # JIT does not support calling k=
func bpf_throw                                (exceptions)
> >  get_stack_raw_tp                         # user_stack corrupted user s=
tack                                             (no backchain userspace)
> >  stacktrace_build_id                      # compare_map_keys stackid_hm=
ap vs. stackmap err -2 errno 2                   (?)
> > +verifier_iter/cond_break
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callb=
acks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> > index 5905e036e0ea..8476dc47623f 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
> > @@ -1,8 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -
> > -#include <linux/bpf.h>
> > -#include <bpf/bpf_helpers.h>
> >  #include "bpf_misc.h"
> > +#include "bpf_experimental.h"
> >
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_ARRAY);
> > @@ -239,4 +237,72 @@ int bpf_loop_iter_limit_nested(void *unused)
> >       return 1000 * a + b + c;
> >  }
> >
> > +#define ARR_SZ 1000000
> > +int zero;
> > +char arr[ARR_SZ];
> > +
> > +SEC("socket")
> > +__success __retval(0xd495cdc0)
> > +int cond_break1(const void *ctx)
> > +{
> > +     unsigned int i;
> > +     unsigned int sum =3D 0;
> > +
> > +     for (i =3D zero; i < ARR_SZ; cond_break, i++)
> > +             sum +=3D i;
> > +     for (i =3D zero; i < ARR_SZ; i++) {
> > +             barrier_var(i);
> > +             sum +=3D i + arr[i];
> > +             cond_break;
> > +     }
> > +
> > +     return sum;
> > +}
> > +
> > +SEC("socket")
> > +__success __retval(999000000)
> > +int cond_break2(const void *ctx)
> > +{
> > +     int i, j;
> > +     int sum =3D 0;
> > +
> > +     for (i =3D zero; i < 1000; cond_break, i++)
> > +             for (j =3D zero; j < 1000; j++) {
> > +                     sum +=3D i + j;
> > +                     cond_break;
> > +             }
> > +
> > +     return sum;
> > +}
> > +
> > +static __noinline int loop(void)
> > +{
> > +     int i, sum =3D 0;
> > +
> > +     for (i =3D zero; i <=3D 1000000; i++, cond_break)
> > +             sum +=3D i;
> > +
> > +     return sum;
> > +}
> > +
> > +SEC("socket")
> > +__success __retval(0x6a5a2920)
> > +int cond_break3(const void *ctx)
> > +{
> > +     return loop();
> > +}
> > +
> > +SEC("socket")
> > +__success __retval(0x800000) /* BPF_MAX_LOOPS */
> > +int cond_break4(const void *ctx)
> > +{
> > +     int cnt =3D 0;
> > +
> > +     for (;;) {
> > +             cond_break;
> > +             cnt++;
> > +     }
> > +     return cnt;
> > +}
>
> I found this test illustrative to show how the cond_break which

ohh. I shouldn't have exposed this implementation detail
in the test. I'll adjust it in the next revision.

> is to me "feels" like a global hidden iterator appears to not
> be reinitialized across calls?
...
> I guess this is by design but I sort of expected each
> call to have its own context. It does make some sense to
> limit main and all calls to a max loop count so not
> complaining. Maybe consider adding the test? I at least
> thought it helped.

At the moment each subprog has its own hidden counter,
but we might have different limits per program type.
Like sleepable might be allowed to loop longer.
The actual limit of BPF_MAX_LOOPS is a random number.
The bpf prog shouldn't rely on any particular loop count.
Most likely we'll add a watchdog soon and will start cancelling
bpf progs that were on cpu for more than a second
regardless of number of iterations.
Arena faults will be causing loops to terminate too.
And so on.
In other words "cond_break" is a contract between
the verifier and the program. The verifier allows the
program to loop assuming it's behaving well,
but reserves the right to terminate it.
So bpf author can assume that cond_break is a nop
if their program is well formed.
The loops with discoverable iteration count like
for (i =3D 0; i < 1000; i++)
are not really a target use case for cond_break.
It's mainly for loops that may have unbounded looping,
but should terminate quickly when code is correct.
Like walking a link list or strlen().

