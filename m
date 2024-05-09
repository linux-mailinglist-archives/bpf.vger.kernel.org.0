Return-Path: <bpf+bounces-29317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B38C1842
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CED1F22222
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261A8615E;
	Thu,  9 May 2024 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vm/vYGNb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C985653
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289577; cv=none; b=dkK4Ci1iCZcZZ+Ei7+7Uq9ZwfGbN+WvpJh0ireZOrqh6+35mqd8YNZ1bXBtLCW6tVjN916d7ipiafK42kropoDcxaLV64xbQ7RpCcvoL3SwAkUwOqGzWTGrWEnEvsnOS46DY5C3D6eNiMPo2mmyMEPnhWR4ALad5hZauqxaeNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289577; c=relaxed/simple;
	bh=Um2iaQ7WeSFO93nhxJoPQRrULk9qwBNcQZW38ADgIuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvvOhBs2QyhVhw5QoGU/oEi2R/SheXQ4KoYmrGvaiWZIytGrKEn9wbWY/5CNxxGrb7aYjTlnGZ8O6SnlKQe5ZcHdG1PxVVH1uusjxEimRxr6w4qYSkXn4/2eT9/DN3547WJXBQncsZULjim6ZvLQGFycon4u3Dlf8bGPP+Skd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vm/vYGNb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso5068a12.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715289574; x=1715894374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj/ruisSex0Kp0dBhUAYPvC4ARDFWMxrTjQLMO36++8=;
        b=Vm/vYGNbPqPzUtipR1PVuAIwYilHEJ4OJGvfS6Ix9mCVdYvdBAgbsgDuvEwjE33jvd
         dG0J7OSQRQ+w1J9s/4wzYX1n7+aYRNIGmsEYDpaChZCAib7rixiVj0PVq+q4MH0A3iOJ
         j3gv5XsalBkxzO5EBu2WtGuDyO0VMYpej9AOdRJ6XtDrB63gcNVN3cMVg1Xv3Gtll0/I
         jhzWvKa8/LTiZVh6YnRrMNy9PPlth11H1QvrvoZciglLJmnZ+KtMUoIsbe5V1Sy01Zlr
         UDNP0BZDlt63CTQQPpiK2hvLjUmjyPwxeGgniKJLLaD1IHKD81/4ZQbESpdrJu2LTxPH
         AKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715289574; x=1715894374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aj/ruisSex0Kp0dBhUAYPvC4ARDFWMxrTjQLMO36++8=;
        b=sYGHHpzPEb+WA71lJ4O+tsGYpvDGwOGuGqzc8BFI6jv292USPGY485BZEhnIEw8bh4
         3Mu06GYJdjuLLzGhKR5q9E/kG3dYrPVBgMSrNYBKYkpHyE49QyM6p6PijzvMJpb30OXs
         YsMSjA3BUWYExIFsW0V0sZty7XA86CUgmE2p1gJ4lL2Ml3kR3Esp8JDZKduuMKWq2loT
         ncvY5YNvq0LkMRhlK5ArxBZHcP0KUJVPzJPkX8jIe5jASgr8VaK6SM+EubGSXCgzF3s+
         QzhatIypeWcCFssqIvYsJOXEP3KCQBE/hYbXiyA7KoVgdWMJx3xNx3I+dlbi9quBHPzC
         gtjw==
X-Forwarded-Encrypted: i=1; AJvYcCUvcSfc0QB6o4mC5UL/MVm3gPAR74hA2vOU9DFZvZVCcoLFVsRzsACADt/dQ8qWANLlQItI+y9NOrPv152ZUVIK8dH1
X-Gm-Message-State: AOJu0YwxIJ7t3q6zAsp1bEKER4D3jFEtVQXPnhGwhyYT+p5gY9BsJNML
	B/Fqik1zcRYdcOeKiF8byZxxTg8YtA7oeWteW19ob5nrL2x+98b4HJxJtfPp14B3kgq82/Bu0e8
	Y7etuGEihHyRAV9X3fU+748VfDoDzUKplwzr1
X-Google-Smtp-Source: AGHT+IGI4zzf79CVFYKmEZhPf2lhqJh1b8pYhjbZ5go+AXsEnSPUSUtKffiZRTXlmKPdbvdXpzTycKoV7ugVsV+l6ts=
X-Received: by 2002:a05:6402:222a:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-57351ffc899mr8908a12.3.1715289570474; Thu, 09 May 2024 14:19:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com> <20240509200022.253089-55-edliaw@google.com>
 <638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com>
In-Reply-To: <638a7831-493c-4917-9b22-5aa663e9ee84@efficios.com>
From: Edward Liaw <edliaw@google.com>
Date: Thu, 9 May 2024 14:19:05 -0700
Message-ID: <CAG4es9UxSmaSdRU7T5q2t_TgOJg+=8UPf8xmTV5bhP6gbDwJuA@mail.gmail.com>
Subject: Re: [PATCH v3 54/68] selftests/rseq: Drop define _GNU_SOURCE
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: shuah@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:16=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-05-09 15:58, Edward Liaw wrote:
> > _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> > redefinition warnings.
> >
> > Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
>
> The patch per se looks fine, except for the "Fixes" tag.
>
> Commit 809216233555 introduces use of asprintf in kselftest_harness.h
> which is used by (all ?) selftests, including the rseq ones. However,
> the rseq selftests each have the #define _GNU_SOURCE, which would have
> been OK without those further changes.
>
> So this patch is more about consolidating where the _GNU_SOURCE is
> defined, which is OK with me, but not so much about "fixing" an
> issue with commit 809216233555.
>
> A "Fix" is something to be backported to stable kernels, and I
> don't think this patch reaches that threshold.
>
> If anything, this patch removes a warning that gets added by
> https://lore.kernel.org/lkml/20240509200022.253089-1-edliaw@google.com/T/=
#mf8438d03de6e2b613da4f86d4f60c5fe1c5f8483
> within the same series.
>
> Arguably, each #define _GNU_SOURCE could have been first protected
> by a #ifndef guard to eliminate this transient warning, and there
> would be nothing to "fix" in this consolidation series.

That makes sense.  I can remove the fixes tags.  809216233555 will
likely be reverted first anyway, and you're right that the focus of
this patch series is on consolidating _GNU_SOURCE.


>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >   tools/testing/selftests/rseq/basic_percpu_ops_test.c | 1 -
> >   tools/testing/selftests/rseq/basic_test.c            | 2 --
> >   tools/testing/selftests/rseq/param_test.c            | 1 -
> >   tools/testing/selftests/rseq/rseq.c                  | 2 --
> >   4 files changed, 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/too=
ls/testing/selftests/rseq/basic_percpu_ops_test.c
> > index 2348d2c20d0a..5961c24ee1ae 100644
> > --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> > @@ -1,5 +1,4 @@
> >   // SPDX-License-Identifier: LGPL-2.1
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <pthread.h>
> >   #include <sched.h>
> > diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/=
selftests/rseq/basic_test.c
> > index 295eea16466f..1fed749b4bd7 100644
> > --- a/tools/testing/selftests/rseq/basic_test.c
> > +++ b/tools/testing/selftests/rseq/basic_test.c
> > @@ -2,8 +2,6 @@
> >   /*
> >    * Basic test coverage for critical regions and rseq_current_cpu().
> >    */
> > -
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <sched.h>
> >   #include <signal.h>
> > diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/=
selftests/rseq/param_test.c
> > index 2f37961240ca..48a55d94eb72 100644
> > --- a/tools/testing/selftests/rseq/param_test.c
> > +++ b/tools/testing/selftests/rseq/param_test.c
> > @@ -1,5 +1,4 @@
> >   // SPDX-License-Identifier: LGPL-2.1
> > -#define _GNU_SOURCE
> >   #include <assert.h>
> >   #include <linux/membarrier.h>
> >   #include <pthread.h>
> > diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selfte=
sts/rseq/rseq.c
> > index 96e812bdf8a4..88602889414c 100644
> > --- a/tools/testing/selftests/rseq/rseq.c
> > +++ b/tools/testing/selftests/rseq/rseq.c
> > @@ -14,8 +14,6 @@
> >    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> >    * Lesser General Public License for more details.
> >    */
> > -
> > -#define _GNU_SOURCE
> >   #include <errno.h>
> >   #include <sched.h>
> >   #include <stdio.h>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>

