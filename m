Return-Path: <bpf+bounces-17081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0840809861
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D01E2820FE
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 01:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CAAED0;
	Fri,  8 Dec 2023 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="ejYjWszr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C291712
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 17:08:49 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so5558385a12.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 17:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701997728; x=1702602528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VamHLYhm2WN9bmNhjuvgJGDIjabCdh/6ajHFYfLgx48=;
        b=ejYjWszroPKefIQq2C/zoAAx6MRQ2r9FgeGnRe4IW20UY3wad7kf2YyUJgYMSvG6ep
         UAqCPY+xzvI5W8w1+TCZ1Cnt4lXP7kDh5sZtX/kR8Mg7f1EfrlSzDlr9pcAilMum1edu
         biwqYAxa8aWZQPbu09pEgpJ2MKc9m44ev24ld04BFx/G7/oXfdc3+3J5YtiVeMTLJPjb
         DmtO9v1uXM7cZThTsgQoWxmbPICfMIrt8IK3AYpLXk9eu3tb3NbtmN2MqKiBBQU+RDhf
         B9DUeBrDIPPj/sMNwHdbOM3Be2WqL16BvgqOnVA2s2rLfF1Os8HgiFKC+HJWnhK2+pTw
         VVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997728; x=1702602528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VamHLYhm2WN9bmNhjuvgJGDIjabCdh/6ajHFYfLgx48=;
        b=w3m2SnFUhz4dIyO3+noH7bQGZpHHVcwxvqu0oeOH+7DBWI204iQPC06VFHvRdIw/Et
         SVOC9ujZnj4J0eLCTGIYM7DIbhsiMuJZwpVeNOVprLyLf0qjXRkgSMWZ4txSfsHCTpn0
         OCr25WbMYua4pdXtchh3hMfK1xR90btE/Aib961c3lHr0lYASTK/NXwS+rjjERDR3wjv
         sQHVddN6GxB10214Cu5wAnJocqv8PKm+W1I3ghGekfA7jgkPF49N2ykheQcH9LXO18Is
         Yx4rXMPhBTK9O56IBGNX+1CyexFTXCEPMKKgxrytE+0/0jzHEHsjcp1h3sPIlGw/bqxC
         MKnQ==
X-Gm-Message-State: AOJu0YxCzs0r03HeV7g/R4GfUQHrNOP5gTN7nhC3MIe/BXxZZ3YufH0b
	Ccx4G7nXFkTsEkESZd4A3xKWk4Zt+8wGi21HFFFS+A==
X-Google-Smtp-Source: AGHT+IFKUFLgG+i0vqmy2QpCsmJ0GjKYQVijPT5fXBQGzBPdhFPbsiYoNVD7utCVpONzjpvzfQo5fozF4NZ/wqCYbqQ=
X-Received: by 2002:a17:906:1c1:b0:9a9:f0e6:904e with SMTP id
 1-20020a17090601c100b009a9f0e6904emr90727ejj.16.1701997727789; Thu, 07 Dec
 2023 17:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-4-khuey@kylehuey.com>
 <CAEf4Bzbt1abnfj2w6Hmp2w8SqVkQiCW=SimY6ss_Jp_325QyoA@mail.gmail.com>
 <CANpmjNOLojXk64jvwD+m19B+FsR5MuBwWKv95uakq-Dp1_AGXA@mail.gmail.com> <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
In-Reply-To: <CAP045AoeVP=n5K+0jt2ddBspif7kx4hzOdBM86CuxNGRCgx4VA@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 7 Dec 2023 17:08:35 -0800
Message-ID: <CAP045ArdMgodyOTs_m6-99FxrqUJzRjDth8epkaa69YQtNeSMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftest/bpf: Test a perf bpf program that
 suppresses side effects.
To: Marco Elver <elver@google.com>
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

On Thu, Dec 7, 2023 at 2:56=E2=80=AFPM Kyle Huey <me@kylehuey.com> wrote:
>
> On Thu, Dec 7, 2023 at 11:20=E2=80=AFAM Marco Elver <elver@google.com> wr=
ote:
> >
> > On Thu, 7 Dec 2023 at 20:12, Andrii Nakryiko <andrii.nakryiko@gmail.com=
> wrote:
> > >
> > > On Thu, Dec 7, 2023 at 8:35=E2=80=AFAM Kyle Huey <me@kylehuey.com> wr=
ote:
> > > >
> > > > The test sets a hardware breakpoint and uses a bpf program to suppr=
ess the
> > > > side effects of a perf event sample, including I/O availability sig=
nals,
> > > > SIGTRAPs, and decrementing the event counter limit, if the ip match=
es the
> > > > expected value. Then the function with the breakpoint is executed m=
ultiple
> > > > times to test that all effects behave as expected.
> > > >
> > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/perf_skip.c      | 145 ++++++++++++++=
++++
> > > >  .../selftests/bpf/progs/test_perf_skip.c      |  15 ++
> > > >  2 files changed, 160 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_ski=
p.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_perf_ski=
p.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/perf_skip.c b/t=
ools/testing/selftests/bpf/prog_tests/perf_skip.c
> > > > new file mode 100644
> > > > index 000000000000..f6fa9bfd9efa
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/perf_skip.c
> > > > @@ -0,0 +1,145 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#define _GNU_SOURCE
> > > > +
> > > > +/* We need the latest siginfo from the kernel repo. */
> > > > +#include <asm/siginfo.h>
> > >
> > > selftests are built with UAPI headers' copies under tools/include, so
> > > CI did catch a real issue, I think. Try copying
> > > include/uapi/asm-generic/siginfo.h into
> > > tools/include/uapi/asm-generic/siginfo.h ?
> >
> > I believe parts of this were inspired by
> > tools/testing/selftests/perf_events/sigtrap_threads.c - getting the
> > kernel headers is allowed, as long as $(KHDR_INCLUDES) is added to
> > CFLAGS. See tools/testing/selftests/perf_events/Makefile. Not sure
> > it's appropriate for this test though, if you don't want to add
> > KHDR_INCLUDES for everything.
>
> Yes, that's right. Namhyung's commit message for 91c97b36bd69 leads me
> to believe that I should copy siginfo.h over into tools/include and
> fix the perf_events self tests too.
>
> - Kyle

That doesn't really help (though perhaps it should be done anyway so
the selftests aren't reaching into include/) because the glibc headers
still redefine a ton of stuff in asm-generic/siginfo.h.

- Kyle

