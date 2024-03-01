Return-Path: <bpf+bounces-23197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C9986EB61
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED061C2150C
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553D58AA7;
	Fri,  1 Mar 2024 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL+ujLNq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621C5822E
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329667; cv=none; b=Ey5JumjsHMA2o/Si26ui+h0AFHL0pAdPtmhXBzJX0XRyrxE6BW0PqY+ygAnhKXt8oHe1zdFKB1AWIMg4wy4i68tqSUNX6OVTmqpkr0M7NbISy0cBPX8+UJLfIsHwn8pahIfcCM8mQN3rtRwiu/HCYTNYHF+i4L/Y5fm6koWkSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329667; c=relaxed/simple;
	bh=H1/rMD9UoLFRE8W08/gbOyFxgIVPeJ6xip+dziVvLdI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DxVeRso2HWGZHNWbxweq071MMGae/0/FLkA6JE7gHyz6iH8Vd3nkAKgxHQij86QMG503iAJx5UMN4fOG9PIjBEkFY197LdcgmCHGoozMt/gWYy9Bgb7ELHYEIRwdqjvk0h8zCJc/VMW2HTHP93XzNoLfqsVg3EIV491ukOHtlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL+ujLNq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d94b222a3aso27839615ad.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709329665; x=1709934465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c0ez7/Lggvjz8eiaNdAV3tP/+tR1r/XTlY8tDWuZYo=;
        b=SL+ujLNquN+e0Oh5trTXwAXqSzaYXobITra8XFTKEkvX2jnxdq6yjoxl9ByqziHNGb
         O8OTZf5fkckoUMfAe04Z6IBvUTQUNebpbk15qCijFcTXWKOaA0Na7e+TDzvxpwBa0No5
         mOPMAiDOpSsLNIW3K1R9E4ws77y175N30rLxhsbawBJcqF4ZNVnoDSi2k8rl+CZGx0b8
         AIcvpfY3VOANuOjqh4t+zZbPaO1J0IxuPtzLS6otB1QD2AMtFtgsJ/TjrnrVLYIqX+GO
         db0LMZf5bTmGu+sJnl3LfrNUgoUOIiuUrDoqL8j77vU6ATii41rH4wkqjKQSYHTwqe8K
         Vp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709329665; x=1709934465;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7c0ez7/Lggvjz8eiaNdAV3tP/+tR1r/XTlY8tDWuZYo=;
        b=tkVyl5UUVo9s52YteW4eL9dVjtB6/zky3KPS2DdQWrxweBvUzfD9K3ry/VkjzcoLgo
         cJhcI075RVS5oXP0qi//YRMbV5UmeK76ozYiAKBsncEKy8NokKOnxcGYaP0oxQhEG6JK
         AVdaKl2o9bp+dYj4WomIzNM/IH5hFjlt+0+9s/VI4IFIBnN9h9SbATBzeBn6CsQ5Cr76
         3EdLFY2JP6ZZTMCjObM8G4XjfdM1WZVlk9KB3UVjzTdhGVRGqEpFtmsC2mPhh0Hmu3fb
         P8Hd74BULG2DysHX1mrQxR3b0fVyD5V8eW+KZNRRsTclFo/i9Ef0RFssGHxBPgx5oZBQ
         uidw==
X-Gm-Message-State: AOJu0YxhSWSFD5RCfCQGagyScXZtRtl+u7rrjwf/mLdAwvwXMw7pGpMB
	7O7RDn/YU0X9HNuKSLYuELQ5IuQsCqRiwrY/de6yMVaOVYO4Wktl0P8eDTlCn8k=
X-Google-Smtp-Source: AGHT+IF8e7KWar1EvUByfe2pw1Nqgom0a2umX5WGg+m0/yGLU54CkmxW0Uk5fG/TGXiCcDv7oL4bhA==
X-Received: by 2002:a17:902:d485:b0:1db:e089:7474 with SMTP id c5-20020a170902d48500b001dbe0897474mr3656440plg.66.1709329665277;
        Fri, 01 Mar 2024 13:47:45 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001db5bdd5e3asm3940517plg.84.2024.03.01.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:47:44 -0800 (PST)
Date: Fri, 01 Mar 2024 13:47:43 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Eddy Z <eddyz87@gmail.com>, 
 Kernel Team <kernel-team@fb.com>
Message-ID: <65e24cff4c626_76bd22088e@john.notmuch>
In-Reply-To: <CAADnVQKKFxioLAqLPNq7mvt4GOHpC0j80-SUYzYQkpno3d+49Q@mail.gmail.com>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
 <20240301033734.95939-5-alexei.starovoitov@gmail.com>
 <65e230d4670d9_5dcfe20885@john.notmuch>
 <CAADnVQKKFxioLAqLPNq7mvt4GOHpC0j80-SUYzYQkpno3d+49Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftests/bpf: Test may_goto
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov wrote:
> On Fri, Mar 1, 2024 at 11:47=E2=80=AFAM John Fastabend <john.fastabend@=
gmail.com> wrote:
> >
> > Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Add tests for may_goto instruction via cond_break macro.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> > >  .../bpf/progs/verifier_iterating_callbacks.c  | 72 +++++++++++++++=
+++-
> > >  2 files changed, 70 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/tes=
ting/selftests/bpf/DENYLIST.s390x
> > > index 1a63996c0304..c6c31b960810 100644
> > > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > > @@ -3,3 +3,4 @@
> > >  exceptions                            # JIT does not support calli=
ng kfunc bpf_throw                                (exceptions)
> > >  get_stack_raw_tp                         # user_stack corrupted us=
er stack                                             (no backchain usersp=
ace)
> > >  stacktrace_build_id                      # compare_map_keys stacki=
d_hmap vs. stackmap err -2 errno 2                   (?)
> > > +verifier_iter/cond_break
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_c=
allbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbac=
ks.c
> > > index 5905e036e0ea..8476dc47623f 100644
> > > --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callback=
s.c
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callback=
s.c
> > > @@ -1,8 +1,6 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > > -
> > > -#include <linux/bpf.h>
> > > -#include <bpf/bpf_helpers.h>
> > >  #include "bpf_misc.h"
> > > +#include "bpf_experimental.h"
> > >
> > >  struct {
> > >       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > @@ -239,4 +237,72 @@ int bpf_loop_iter_limit_nested(void *unused)
> > >       return 1000 * a + b + c;
> > >  }
> > >
> > > +#define ARR_SZ 1000000
> > > +int zero;
> > > +char arr[ARR_SZ];
> > > +
> > > +SEC("socket")
> > > +__success __retval(0xd495cdc0)
> > > +int cond_break1(const void *ctx)
> > > +{
> > > +     unsigned int i;
> > > +     unsigned int sum =3D 0;
> > > +
> > > +     for (i =3D zero; i < ARR_SZ; cond_break, i++)
> > > +             sum +=3D i;
> > > +     for (i =3D zero; i < ARR_SZ; i++) {
> > > +             barrier_var(i);
> > > +             sum +=3D i + arr[i];
> > > +             cond_break;
> > > +     }
> > > +
> > > +     return sum;
> > > +}
> > > +
> > > +SEC("socket")
> > > +__success __retval(999000000)
> > > +int cond_break2(const void *ctx)
> > > +{
> > > +     int i, j;
> > > +     int sum =3D 0;
> > > +
> > > +     for (i =3D zero; i < 1000; cond_break, i++)
> > > +             for (j =3D zero; j < 1000; j++) {
> > > +                     sum +=3D i + j;
> > > +                     cond_break;
> > > +             }
> > > +
> > > +     return sum;
> > > +}
> > > +
> > > +static __noinline int loop(void)
> > > +{
> > > +     int i, sum =3D 0;
> > > +
> > > +     for (i =3D zero; i <=3D 1000000; i++, cond_break)
> > > +             sum +=3D i;
> > > +
> > > +     return sum;
> > > +}
> > > +
> > > +SEC("socket")
> > > +__success __retval(0x6a5a2920)
> > > +int cond_break3(const void *ctx)
> > > +{
> > > +     return loop();
> > > +}
> > > +
> > > +SEC("socket")
> > > +__success __retval(0x800000) /* BPF_MAX_LOOPS */
> > > +int cond_break4(const void *ctx)
> > > +{
> > > +     int cnt =3D 0;
> > > +
> > > +     for (;;) {
> > > +             cond_break;
> > > +             cnt++;
> > > +     }
> > > +     return cnt;
> > > +}
> >
> > I found this test illustrative to show how the cond_break which
> =

> ohh. I shouldn't have exposed this implementation detail
> in the test. I'll adjust it in the next revision.
> =

> > is to me "feels" like a global hidden iterator appears to not
> > be reinitialized across calls?
> ...
> > I guess this is by design but I sort of expected each
> > call to have its own context. It does make some sense to
> > limit main and all calls to a max loop count so not
> > complaining. Maybe consider adding the test? I at least
> > thought it helped.
> =

> At the moment each subprog has its own hidden counter,

aha that is how I read the patch1 as well. But I'm trying to follow
why I get two different answers here.

Below passes all good the total there in break5 is 2xMAX_LOOPS which
is what I expect from above and reading patch. If I trace the code
I have two subprogs and each does fixup,

   insn_buf[j] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP,
     -subprogs[i].stack_depth + j * 8, BPF_MAX_LOOPS);

This is the good one.

 __noinline int full_loop(void)
 {
	int cnt =3D 0;

	for (;;) {
		cond_break;
		cnt++;
	}

	for (;;) {
		cond_break;
		cnt++;
	}

	bpf_printk("cnt=3D=3D%d\n", cnt);
	return cnt;
 }

 SEC("socket")
 __success __retval(16777216)
 int cond_break5(const void *ctx)
 {
	int cnt =3D 0;

	for (;;) {
		cond_break;
		cnt++;
	}

	cnt +=3D full_loop();

	for (;;) {
		cond_break;
		cnt++;
	}
	return cnt;
 }

But adding static fails :( which I didn't expect. Is it obvious
why this is the case?

static  __noinline int full_loop(void)
 {
	int cnt =3D 0;

	for (;;) {
		cond_break;
		cnt++;
	}

	for (;;) {
		cond_break;
		cnt++;
	}

	bpf_printk("cnt=3D=3D%d\n", cnt);
	return cnt;
 }

 SEC("socket")
 __success __retval(16777216)
 int cond_break5(const void *ctx)
 {
	int cnt =3D 0;

	for (;;) {
		cond_break;
		cnt++;
	}

	cnt +=3D full_loop();

	for (;;) {
		cond_break;
		cnt++;
	}
	return cnt;
 }

From verifier side story is slightly different. There are still
two subprogs, but for subprog[0] has stack_slots=3D=3D0? Debugging
now but maybe its obvious what that static is doing to you.

> but we might have different limits per program type.
> Like sleepable might be allowed to loop longer.
> The actual limit of BPF_MAX_LOOPS is a random number.
> The bpf prog shouldn't rely on any particular loop count.
> Most likely we'll add a watchdog soon and will start cancelling
> bpf progs that were on cpu for more than a second
> regardless of number of iterations.
> Arena faults will be causing loops to terminate too.
> And so on.
> In other words "cond_break" is a contract between
> the verifier and the program. The verifier allows the
> program to loop assuming it's behaving well,
> but reserves the right to terminate it.
> So bpf author can assume that cond_break is a nop
> if their program is well formed.
> The loops with discoverable iteration count like
> for (i =3D 0; i < 1000; i++)
> are not really a target use case for cond_break.
> It's mainly for loops that may have unbounded looping,
> but should terminate quickly when code is correct.
> Like walking a link list or strlen().

Yep we do this a lot and just create some artifical upper
bound so this is nicer for sure. Lots of Tetragon code reads


   for (i =3D 0; i < MAX_LOOP; i++) {
     do_stuff
     if (exit_cond)
       break;
  } =


.John=

