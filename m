Return-Path: <bpf+bounces-17113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F01B809DE5
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 09:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496B01F21311
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 08:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7D1097E;
	Fri,  8 Dec 2023 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srwMtj4l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504881722
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 00:07:13 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-464754e1120so604532137.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 00:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702022832; x=1702627632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEw+eNRqoUePvlNP+vM/gZ6U0RswZAXJxDfoxrXFyT8=;
        b=srwMtj4l44hWigI0nabg4uiLe1aL/0FuFq8qu/jVKrr+AzJYrQ2C0Pxdxs1viA2xJA
         fQTMUKeOBnpTZey9g9F/a1e7WId37MJdrQfjnr4yjK4x9d6po5B/JsWztzyX5InrE9CZ
         savxKBt43lah9p1K8GAp3YKBlJy2q1BCE43S0tvF5KMqA9jl6lYAVhka8sVfUzpUlTZt
         jsoL0dzIYtuq4VKzGvA+0OAKypVFFN46DgrUcUFUExTs4STyHRZ0Weq99QcZP/BrRjgH
         G3itOUvGl0KbIKmpALFm7Mk3L+FvhvxPUJCx2ZVOhuYjoQSbkwqCBKCuMv6TSnmlg6Th
         Ujmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702022832; x=1702627632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEw+eNRqoUePvlNP+vM/gZ6U0RswZAXJxDfoxrXFyT8=;
        b=QeniWjD731nd7NW3fbdBMQQbl5tE9diPyx9h54fwDa3v05Gr1SBNszWKa386u9w20E
         cujTfO3HpdZDTeth8AyKYYq27nruBlAyFeUSgh8O4ebvwopSmt5dGomYV1Po9Z27ft+O
         /9lUbeuKWtaHm74czogKuHmUEEekU4X/YwUesbsrZxdzlJiUZVGcCO7E7AEDPU6iEotD
         3H0GO7A6P1wxqO3uZKQi3w4OHUt0TT9vYaP3an4s9NAv9be6eVRdpPS4F0JSayeed78M
         RM4cG7qAOWD5Hykn/JSMfxXSiZeE1S/EuZdxOwesm9BulSkEtYNXhz5dQ/H2FvhCPov/
         eGTA==
X-Gm-Message-State: AOJu0YzYboDQ/396/uLrk/Y2qeUmWfZxhr2AK9Qmlt1ri9S3bETElD3y
	et56FOkHfA9UN+M7ETyjVZeE7Pla0jRUxiM8pO1jDw==
X-Google-Smtp-Source: AGHT+IETivK6vakE0mPN9i0YcmJIWlEnH/r0hTZTSMmElPjRgLwVDdNRf+FLfsYhTtRFT1Arwxnu1JuRyw7AIAKnPS4=
X-Received: by 2002:a05:6102:5489:b0:464:44e0:8f9 with SMTP id
 bk9-20020a056102548900b0046444e008f9mr4692152vsb.35.1702022832220; Fri, 08
 Dec 2023 00:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
 <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com>
 <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com> <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com>
In-Reply-To: <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 8 Dec 2023 09:06:33 +0100
Message-ID: <CANpmjNMehFp7dM7QhR7AQgp33i-a0s0R-J9ZPweyroY45eCizQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Kyle Huey <me@kylehuey.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kyle Huey <khuey@kylehuey.com>, 
	linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Dec 2023 at 02:08, Kyle Huey <me@kylehuey.com> wrote:
>
> On Thu, Dec 7, 2023 at 2:56=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
> >
> > On Thu, Dec 7, 2023 at 11:20=E2=80=AFAM Marco Elver <elver@google.com> =
wrote:
> > >
> > > On Thu, 7 Dec 2023 at 20:12, Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> =
wrote:
> > > > >
> > > > > The test sets a hardware breakpoint and uses a bpf program to sup=
press the
> > > > > side effects of a perf event sample, including I/O availability s=
ignals,
> > > > > SIGTRAPs, and decrementing the event counter limit, if the ip mat=
ches the
> > > > > expected value. Then the function with the breakpoint is executed=
 multiple
> > > > > times to test that all effects behave as expected.
> > > > >
> > > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > > > ---
> > > > >  .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++=
++++++
> > > > >  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
> > > > >  2 files changed, 160 insertions(+)
> > > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_s=
kip.c
> > > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_s=
kip.c
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b=
/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > > > > new file mode 100644
> > > > > index 000000000000..f6fa9bfd9efa
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > > > > @@ -0,0 +1,145 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +#define _GNU_SOURCE
> > > > > +
> > > > > +/* We need the latest siginfo from the kernel repo. */
> > > > > +#include <asm/siginfo.h>
> > > >
> > > > selftests are built with UAPI headers' copies under tools/include, =
so
> > > > CI did catch a real issue, I think. Try copying
> > > > include/uapi/asm-generic/siginfo.h into
> > > > tools/include/uapi/asm-generic/siginfo.h ?
> > >
> > > I believe parts of this were inspired by
> > > tools/testing/selftests/perf_events/sigtrap_threads.c - getting the
> > > kernel headers is allowed, as long as $(KHDR_INCLUDES) is added to
> > > CFLAGS. See tools/testing/selftests/perf_events/Makefile. Not sure
> > > it's appropriate for this test though, if you don't want to add
> > > KHDR_INCLUDES for everything.
> >
> > Yes, that's right. Namhyung's commit message for 91c97b36bd69 leads me
> > to believe that I should copy siginfo.h over into tools/include and
> > fix the perf_events self tests too.
> >
> > - Kyle
>
> That doesn't really help (though perhaps it should be done anyway so
> the selftests aren't reaching into include/) because the glibc headers
> still redefine a ton of stuff in asm-generic/siginfo.h.

From what I can see your test doesn't actually refer to any of the
si_perf_* fields, but only needs it for this:

> +       ASSERT_EQ(info->si_code, TRAP_PERF, "wrong si_code");

I think that's easy to fix by just defining TRAP_PERF yourself or
leaving out the assert completely. If you get an unexpected SIGTRAP
your asserts checking sigtrap_count elsewhere will fail, too. It'd
just be harder to debug.

