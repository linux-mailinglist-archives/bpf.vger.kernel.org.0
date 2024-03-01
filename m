Return-Path: <bpf+bounces-23204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949886EB95
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C651F23159
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AE59141;
	Fri,  1 Mar 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5KMYFJU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770F14295
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709330823; cv=none; b=WZQXm+Vtto7woICUGFKJmja9GOochjLfVSV8tfZMiy+H5jDfucuh5N94Bi0Xw1yZR3ASarWD1YgF6paGJEIUTWOA5MDtmxjyMJ6d0FHgISpN4wtpgfm7UoZrMO3PByeLNCzZepVsFRc9JnP4pX39xW1aBRYEWwouUJxF69Z3z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709330823; c=relaxed/simple;
	bh=rqOcfH9Xy5l7aB2wSAs/mYs6v14Oe9tgJuCVyCvr8m8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=paJYZFcfyrfDvTKFgZSzCpxLK8J/d4yfMWdrnK5x2MTz+ZLlYlFoCyYx2nV4zwodpBbngzM0vxt52Qc44uAeu57leKksmprmiCZWzkKTQSPb1IUb1+YtZeUZ+jqpaykYeEgK6udLYAz8aUK9JZqZVoY2zqJEerl4O082yTkqz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5KMYFJU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29996cc6382so2095803a91.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 14:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709330821; x=1709935621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E51ZeEbGIGMgp71rEk7y5d3jRmxkYJEQBtqqVhG5kHE=;
        b=F5KMYFJUCfJU0YLfJc8HxAhyOAeq+Z3WEb8gFS27nxYnmSa3figpvNNh8zEvLhRlMG
         BCuvFYQOSF4napko7Bg1ulW4uEDoPgcoSlFxpCIesZm0oO9tLWIr/Pwp8odlbzdvr+av
         0a2NpWEbXvElyQSjPAAbWD+LXVfI1ypGAWq12jq8yomMr4+FbSL+XlX8VsPP6ao+VI6z
         dFG7ddFGTWyN8ctYuulisAEWRMF9Rv7vj3XrW6FiS7uNcW8sY/qHfTcnUnmSPxqJNSJr
         oy7DDEJ5zj4hDORCudJGDFPZHD8sIa3V9hw33j0zDOsKHlz/kkuZN9ErDvbM7Jfg+8xZ
         lyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709330821; x=1709935621;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E51ZeEbGIGMgp71rEk7y5d3jRmxkYJEQBtqqVhG5kHE=;
        b=K+9uGsscMAut62F45UjX3mnXezmizTYjkohXWRdM02zZV3i1FDDQtmrIJsrkjqQnGL
         IXcDgKV6VP3bOMLeJ8A1T/O5WLEMTKys6Ua61K/YiVKea/i0Ysmdg6BFmw4LpxfhGkBo
         LQlSY/SlqdnSkqPBcXUq0M8Ysc9AcT/9ZhxNcQfyWUTgtqhgf2EodEeUcjBaoZ8G2Qah
         +ogv7Hl3RoGe94rknAAAb6OCnPKZFd2gKAcH0Ggo++BLT+a7mFNDcAd1NH5m7ySvCNpM
         wFiVAEkthMh4rISBE5b1c2D6faCw3XlNpOWl9fut8XTvU6vJ/xU+7lkQcfdyGzbckBkv
         i2NQ==
X-Gm-Message-State: AOJu0YxTsaxIPIeHRbsC4hHDml8Z8VpWUycujMlpvZl6FSbjQPCbRUp7
	LL7wnvUq4NphNRPaRo9yPM+XKyE8JkmjjXcX+Bb3BqGCotOIEKRL
X-Google-Smtp-Source: AGHT+IErovCG0GJtDs6yRlwk48EoZzsLCOx5QU4aarA4DIDlnnLCh/XrF7JaKDxaub0jraLeo4mUJg==
X-Received: by 2002:a17:90a:9f8b:b0:29a:7bec:32a0 with SMTP id o11-20020a17090a9f8b00b0029a7bec32a0mr2622474pjp.49.1709330820641;
        Fri, 01 Mar 2024 14:07:00 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id nd16-20020a17090b4cd000b0029b035682d7sm4318765pjb.9.2024.03.01.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:07:00 -0800 (PST)
Date: Fri, 01 Mar 2024 14:06:59 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Eddy Z <eddyz87@gmail.com>, 
 Kernel Team <kernel-team@fb.com>
Message-ID: <65e251831582f_8e09c208a@john.notmuch>
In-Reply-To: <65e24cff4c626_76bd22088e@john.notmuch>
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com>
 <20240301033734.95939-5-alexei.starovoitov@gmail.com>
 <65e230d4670d9_5dcfe20885@john.notmuch>
 <CAADnVQKKFxioLAqLPNq7mvt4GOHpC0j80-SUYzYQkpno3d+49Q@mail.gmail.com>
 <65e24cff4c626_76bd22088e@john.notmuch>
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

John Fastabend wrote:
> Alexei Starovoitov wrote:
> > On Fri, Mar 1, 2024 at 11:47=E2=80=AFAM John Fastabend <john.fastaben=
d@gmail.com> wrote:
> > >
> > > Alexei Starovoitov wrote:
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Add tests for may_goto instruction via cond_break macro.
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > > >  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> > > >  .../bpf/progs/verifier_iterating_callbacks.c  | 72 +++++++++++++=
+++++-
> > > >  2 files changed, 70 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/t=
esting/selftests/bpf/DENYLIST.s390x
> > > > index 1a63996c0304..c6c31b960810 100644
> > > > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > > > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > > > @@ -3,3 +3,4 @@
> > > >  exceptions                            # JIT does not support cal=
ling kfunc bpf_throw                                (exceptions)
> > > >  get_stack_raw_tp                         # user_stack corrupted =
user stack                                             (no backchain user=
space)
> > > >  stacktrace_build_id                      # compare_map_keys stac=
kid_hmap vs. stackmap err -2 errno 2                   (?)
> > > > +verifier_iter/cond_break
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating=
_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callb=
acks.c
> > > > index 5905e036e0ea..8476dc47623f 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_iterating_callba=
cks.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callba=
cks.c
> > > > @@ -1,8 +1,6 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > > -
> > > > -#include <linux/bpf.h>
> > > > -#include <bpf/bpf_helpers.h>
> > > >  #include "bpf_misc.h"
> > > > +#include "bpf_experimental.h"
> > > >
> > > >  struct {
> > > >       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > @@ -239,4 +237,72 @@ int bpf_loop_iter_limit_nested(void *unused)=

> > > >       return 1000 * a + b + c;
> > > >  }
> > > >
> > > > +#define ARR_SZ 1000000
> > > > +int zero;
> > > > +char arr[ARR_SZ];
> > > > +
> > > > +SEC("socket")
> > > > +__success __retval(0xd495cdc0)
> > > > +int cond_break1(const void *ctx)
> > > > +{
> > > > +     unsigned int i;
> > > > +     unsigned int sum =3D 0;
> > > > +
> > > > +     for (i =3D zero; i < ARR_SZ; cond_break, i++)
> > > > +             sum +=3D i;
> > > > +     for (i =3D zero; i < ARR_SZ; i++) {
> > > > +             barrier_var(i);
> > > > +             sum +=3D i + arr[i];
> > > > +             cond_break;
> > > > +     }
> > > > +
> > > > +     return sum;
> > > > +}
> > > > +
> > > > +SEC("socket")
> > > > +__success __retval(999000000)
> > > > +int cond_break2(const void *ctx)
> > > > +{
> > > > +     int i, j;
> > > > +     int sum =3D 0;
> > > > +
> > > > +     for (i =3D zero; i < 1000; cond_break, i++)
> > > > +             for (j =3D zero; j < 1000; j++) {
> > > > +                     sum +=3D i + j;
> > > > +                     cond_break;
> > > > +             }
> > > > +
> > > > +     return sum;
> > > > +}
> > > > +
> > > > +static __noinline int loop(void)
> > > > +{
> > > > +     int i, sum =3D 0;
> > > > +
> > > > +     for (i =3D zero; i <=3D 1000000; i++, cond_break)
> > > > +             sum +=3D i;
> > > > +
> > > > +     return sum;
> > > > +}
> > > > +
> > > > +SEC("socket")
> > > > +__success __retval(0x6a5a2920)
> > > > +int cond_break3(const void *ctx)
> > > > +{
> > > > +     return loop();
> > > > +}
> > > > +
> > > > +SEC("socket")
> > > > +__success __retval(0x800000) /* BPF_MAX_LOOPS */
> > > > +int cond_break4(const void *ctx)
> > > > +{
> > > > +     int cnt =3D 0;
> > > > +
> > > > +     for (;;) {
> > > > +             cond_break;
> > > > +             cnt++;
> > > > +     }
> > > > +     return cnt;
> > > > +}
> > >
> > > I found this test illustrative to show how the cond_break which
> > =

> > ohh. I shouldn't have exposed this implementation detail
> > in the test. I'll adjust it in the next revision.
> > =

> > > is to me "feels" like a global hidden iterator appears to not
> > > be reinitialized across calls?
> > ...
> > > I guess this is by design but I sort of expected each
> > > call to have its own context. It does make some sense to
> > > limit main and all calls to a max loop count so not
> > > complaining. Maybe consider adding the test? I at least
> > > thought it helped.
> > =

> > At the moment each subprog has its own hidden counter,
> =

> aha that is how I read the patch1 as well. But I'm trying to follow
> why I get two different answers here.
> =

> Below passes all good the total there in break5 is 2xMAX_LOOPS which
> is what I expect from above and reading patch. If I trace the code
> I have two subprogs and each does fixup,
> =

>    insn_buf[j] =3D BPF_ST_MEM(BPF_DW, BPF_REG_FP,
>      -subprogs[i].stack_depth + j * 8, BPF_MAX_LOOPS);
> =

> This is the good one.
> =

>  __noinline int full_loop(void)
>  {
> 	int cnt =3D 0;
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> =

> 	bpf_printk("cnt=3D=3D%d\n", cnt);
> 	return cnt;
>  }
> =

>  SEC("socket")
>  __success __retval(16777216)
>  int cond_break5(const void *ctx)
>  {
> 	int cnt =3D 0;
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> =

> 	cnt +=3D full_loop();
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> 	return cnt;
>  }
> =

> But adding static fails :( which I didn't expect. Is it obvious
> why this is the case?
> =

> static  __noinline int full_loop(void)
>  {
> 	int cnt =3D 0;
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> =

> 	bpf_printk("cnt=3D=3D%d\n", cnt);
> 	return cnt;
>  }
> =

>  SEC("socket")
>  __success __retval(16777216)
>  int cond_break5(const void *ctx)
>  {
> 	int cnt =3D 0;
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> =

> 	cnt +=3D full_loop();
> =

> 	for (;;) {
> 		cond_break;
> 		cnt++;
> 	}
> 	return cnt;
>  }
> =

> From verifier side story is slightly different. There are still
> two subprogs, but for subprog[0] has stack_slots=3D=3D0? Debugging
> now but maybe its obvious what that static is doing to you.

That was a typo its subprog[1] with stack_slots =3D=3D 0. Also
tracing insn it seems in nonstatic case we hit multiple
insn->code (BPF_JMP| BPF_JMA) but in the static case only
find the first one. Object file seems to have multiples
though. I need to drop for the rest of the afternoon most
likely, but will try to see what sort of silly thing I did
later today or worse case Monday.

> k
> > but we might have different limits per program type.
> > Like sleepable might be allowed to loop longer.
> > The actual limit of BPF_MAX_LOOPS is a random number.
> > The bpf prog shouldn't rely on any particular loop count.
> > Most likely we'll add a watchdog soon and will start cancelling
> > bpf progs that were on cpu for more than a second
> > regardless of number of iterations.
> > Arena faults will be causing loops to terminate too.
> > And so on.
> > In other words "cond_break" is a contract between
> > the verifier and the program. The verifier allows the
> > program to loop assuming it's behaving well,
> > but reserves the right to terminate it.
> > So bpf author can assume that cond_break is a nop
> > if their program is well formed.
> > The loops with discoverable iteration count like
> > for (i =3D 0; i < 1000; i++)
> > are not really a target use case for cond_break.
> > It's mainly for loops that may have unbounded looping,
> > but should terminate quickly when code is correct.
> > Like walking a link list or strlen().
> =

> Yep we do this a lot and just create some artifical upper
> bound so this is nicer for sure. Lots of Tetragon code reads
> =

> =

>    for (i =3D 0; i < MAX_LOOP; i++) {
>      do_stuff
>      if (exit_cond)
>        break;
>   } =

> =

> .John



