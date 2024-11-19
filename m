Return-Path: <bpf+bounces-45144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED49D1FFF
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 07:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8BB2825CD
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A9D1537A8;
	Tue, 19 Nov 2024 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJbzkRlD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600FE571;
	Tue, 19 Nov 2024 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996499; cv=none; b=LOaPL9c1agHd+BK54FzDp2SuPMdLn90RmYaXk1RIwk5/Qrh3k/rzkVto0uFcxRcLUf3yrohGeuqPPRhvX2MB/7sjj5MSZ4dvYdH6Z1r4gUzGL3gNfSEJ8pD30R0SEY9v3wY/t3gBMrMWLUwxxmWLQ5uCEjgJ27qCmd8POyirZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996499; c=relaxed/simple;
	bh=LT1rseeMp9QvfkONqt2wj3dfHJHXvUu+it4RFz2iTeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtjotSRJ54xV4vc7MA9EYxOgqMkpiX2iQNRN7J6OnwmJ9pYkd/mIgtJyv9PPWPM6ZbUjaTn3RZKaYFNBYGug2uwUpK53hvequN8c38QhpjZfuzPUtSWuLYUoJmAJHJXg6+1H+UBTCslhDOFOVdvK5DAkGbUH0mTVSS+7Hm4Ul4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJbzkRlD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c693b68f5so38832335ad.1;
        Mon, 18 Nov 2024 22:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731996497; x=1732601297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDJK36MwVQC+ba5/5TZMf9JMjpVxkr7gobbsTVB6WQU=;
        b=XJbzkRlD1GYxiTPRU6Q8/5oTagSTUcd7BclKbSTgnZbD8dJnS2KufRJA21DagAoIh0
         Ey33HZtDb6EYVvC2WAaNfkfLoZEIpCB5g7WqbjCvwQyL7iekMZojncaVuMfkB4LBY0S5
         h4MRzxWnTg13I3OYLEIroDukZOxQwFUDnB5sF00CR/b0X6EG+8Z9N/9f0fPAsir0QpTD
         tudnWhYxijdZwFRcGpKvWV+P6pgG01jYimZsKVSr8pQIV9dnu0pbVrHrQ0Jq3GKVJHFE
         MP1BVeGD5PWpdfv3IAgRRtnFzFJmwaeDKEDm55jKu6l4h00N6kCnw7oW5LaeLqCrN8Q4
         V7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731996497; x=1732601297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDJK36MwVQC+ba5/5TZMf9JMjpVxkr7gobbsTVB6WQU=;
        b=rzZiYO8KjWeg5OYT3AyYgGYi1L9cscIsWq5W1Sm6Tv2yur3aFQ4ea7KYxC3MHb4+nH
         TmGA8FpIHqixXMxBpARi1VraaRluENGO1kvYsLPQRoqQvI4mpA1n5RbW88y9a36wiW7v
         tVo6cEzbDasG+ZHQbcV4HZqsGtehz7dIpr6TJfJejl48RZ6H/xgZZ4YeDq0opAjR4+q+
         qY7eZwdOoe1VFDE/Cj93Ns/LvoZbBrK0JvPkumle9SebTifhlLv4+xTMDWk2eSmDOrbM
         YEPznXB2oO9vahgYZSDdHnQ0ipy1IujaShfJ+GQ5SN8tafl6kSdSZmglrQSJDgJdieV3
         Gufg==
X-Forwarded-Encrypted: i=1; AJvYcCUaLYCrbfZqiQj2OO7VqdZwuUUhpnbas6a/T9Gg6+uyqYg/oKXTsRQ3aMBr7YEGvzex0SE=@vger.kernel.org, AJvYcCUeGk0lSgLYupoBWbasgW/a1TDWFNrFCA+PpU19Tutai8TNjp3xJ1RZrcHno8NXQm4uHKyIO4A5jf8h0PqVVmJhDnPs@vger.kernel.org, AJvYcCX/03sUAoRGLVpyjbKOM6tUQ1X7xqhyTBBhd1gvqEFxHYYJcuEROslcF4Pbpv3z40Vjki9+htGUp+/3A7fc@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrq0edvVXJr9297BZsG6sE3YX1a0cYAVxJmoygqwptXoyBnoT
	MtczNvxSgZU02GALXWQM8smfHx1m6rKtIiYdRGA5sEQwDFKSh0igVDs6o1b8+3iMVHYjKse9QLE
	gOXigECH2x5tu+9i5PsuOQwnuess=
X-Google-Smtp-Source: AGHT+IEfLOOFtwPaPn1KDWRTJwgEqoe4Tr7dolGCzxCllwVJJn4dLnUg34N4Lw+ntRkl1TaqYKWRPfytpQx0nPxRSTY=
X-Received: by 2002:a17:90b:4e90:b0:2ea:8aac:6ab9 with SMTP id
 98e67ed59e1d1-2ea8aac6b9emr5898982a91.8.1731996497087; Mon, 18 Nov 2024
 22:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-10-jolsa@kernel.org>
 <CAEf4BzaXvdXr4dyHrozWYyMHJor5GpaHnPF8=8qy0r_5Crb3wg@mail.gmail.com> <ZzkSXTjGxNGnpzZX@krava>
In-Reply-To: <ZzkSXTjGxNGnpzZX@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Nov 2024 22:08:05 -0800
Message-ID: <CAEf4BzaCj7Sx=-CfSW28ezpO-FRNT4oXhiyhSrLyTx7RaAz63g@mail.gmail.com>
Subject: Re: [RFC bpf-next 09/11] selftests/bpf: Add usdt trigger bench
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 1:45=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Nov 14, 2024 at 03:40:53PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 5, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > Adding usdt trigger bench to meassure optimized usdt probes.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/testing/selftests/bpf/bench.c           |  2 +
> > >  .../selftests/bpf/benchs/bench_trigger.c      | 45 +++++++++++++++++=
++
> > >  .../selftests/bpf/progs/trigger_bench.c       | 10 ++++-
> > >  3 files changed, 56 insertions(+), 1 deletion(-)
> > >
> >
> > Why not just adding uprobe-nop5 benchmark instead of going all the way
> > into USDT? Seems simpler and will benchmark all the same stuff?
>
> ok, perhaps with your new usdt library and the possible nop/nop5 tricks w=
e
> might want to have specific usdt benchmarks.. but that's for later anyway
>

meh, maybe, don't know if necessary *for benchmark*.

But anyways, the USDT library is out, see [0], feel free to take a look and=
 use

  [0] https://github.com/libbpf/usdt

> jirka
>
> >
> > > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/self=
tests/bpf/bench.c
> > > index 1bd403a5ef7b..dc5121e49623 100644
> > > --- a/tools/testing/selftests/bpf/bench.c
> > > +++ b/tools/testing/selftests/bpf/bench.c
> > > @@ -526,6 +526,7 @@ extern const struct bench bench_trig_uprobe_multi=
_push;
> > >  extern const struct bench bench_trig_uretprobe_multi_push;
> > >  extern const struct bench bench_trig_uprobe_multi_ret;
> > >  extern const struct bench bench_trig_uretprobe_multi_ret;
> > > +extern const struct bench bench_trig_usdt;
> > >
> > >  extern const struct bench bench_rb_libbpf;
> > >  extern const struct bench bench_rb_custom;
> > > @@ -586,6 +587,7 @@ static const struct bench *benchs[] =3D {
> > >         &bench_trig_uretprobe_multi_push,
> > >         &bench_trig_uprobe_multi_ret,
> > >         &bench_trig_uretprobe_multi_ret,
> > > +       &bench_trig_usdt,
> > >         /* ringbuf/perfbuf benchmarks */
> > >         &bench_rb_libbpf,
> > >         &bench_rb_custom,
> > > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/too=
ls/testing/selftests/bpf/benchs/bench_trigger.c
> > > index 32e9f194d449..bdee8b8362d0 100644
> > > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > @@ -8,6 +8,7 @@
> > >  #include "bench.h"
> > >  #include "trigger_bench.skel.h"
> > >  #include "trace_helpers.h"
> > > +#include "../sdt.h"
> > >
> > >  #define MAX_TRIG_BATCH_ITERS 1000
> > >
> > > @@ -333,6 +334,13 @@ static void *uprobe_producer_ret(void *input)
> > >         return NULL;
> > >  }
> > >
> > > +static void *uprobe_producer_usdt(void *input)
> > > +{
> > > +       while (true)
> > > +               STAP_PROBE(trigger, usdt);
> > > +       return NULL;
> > > +}
> > > +
> > >  static void usetup(bool use_retprobe, bool use_multi, void *target_a=
ddr)
> > >  {
> > >         size_t uprobe_offset;
> > > @@ -383,6 +391,37 @@ static void usetup(bool use_retprobe, bool use_m=
ulti, void *target_addr)
> > >         }
> > >  }
> > >
> > > +static void __usdt_setup(const char *provider, const char *name)
> > > +{
> > > +       struct bpf_link *link;
> > > +       int err;
> > > +
> > > +       setup_libbpf();
> > > +
> > > +       ctx.skel =3D trigger_bench__open();
> > > +       if (!ctx.skel) {
> > > +               fprintf(stderr, "failed to open skeleton\n");
> > > +               exit(1);
> > > +       }
> > > +
> > > +       bpf_program__set_autoload(ctx.skel->progs.bench_trigger_usdt,=
 true);
> > > +
> > > +       err =3D trigger_bench__load(ctx.skel);
> > > +       if (err) {
> > > +               fprintf(stderr, "failed to load skeleton\n");
> > > +               exit(1);
> > > +       }
> > > +
> > > +       link =3D bpf_program__attach_usdt(ctx.skel->progs.bench_trigg=
er_usdt,
> > > +                                       -1 /* all PIDs */, "/proc/sel=
f/exe",
> > > +                                       provider, name, NULL);
> > > +       if (!link) {
> > > +               fprintf(stderr, "failed to attach uprobe!\n");
> > > +               exit(1);
> > > +       }
> > > +       ctx.skel->links.bench_trigger_usdt =3D link;
> > > +}
> > > +
> > >  static void usermode_count_setup(void)
> > >  {
> > >         ctx.usermode_counters =3D true;
> > > @@ -448,6 +487,11 @@ static void uretprobe_multi_ret_setup(void)
> > >         usetup(true, true /* use_multi */, &uprobe_target_ret);
> > >  }
> > >
> > > +static void usdt_setup(void)
> > > +{
> > > +       __usdt_setup("trigger", "usdt");
> > > +}
> > > +
> > >  const struct bench bench_trig_syscall_count =3D {
> > >         .name =3D "trig-syscall-count",
> > >         .validate =3D trigger_validate,
> > > @@ -506,3 +550,4 @@ BENCH_TRIG_USERMODE(uprobe_multi_ret, ret, "uprob=
e-multi-ret");
> > >  BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop")=
;
> > >  BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-pus=
h");
> > >  BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret")=
;
> > > +BENCH_TRIG_USERMODE(usdt, usdt, "usdt");
> > > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tool=
s/testing/selftests/bpf/progs/trigger_bench.c
> > > index 044a6d78923e..7b7d4a71e7d4 100644
> > > --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > @@ -1,8 +1,9 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  // Copyright (c) 2020 Facebook
> > > -#include <linux/bpf.h>
> > > +#include "vmlinux.h"
> > >  #include <asm/unistd.h>
> > >  #include <bpf/bpf_helpers.h>
> > > +#include <bpf/usdt.bpf.h>
> > >  #include <bpf/bpf_tracing.h>
> > >  #include "bpf_misc.h"
> > >
> > > @@ -138,3 +139,10 @@ int bench_trigger_rawtp(void *ctx)
> > >         inc_counter();
> > >         return 0;
> > >  }
> > > +
> > > +SEC("?usdt")
> > > +int bench_trigger_usdt(struct pt_regs *ctx)
> > > +{
> > > +       inc_counter();
> > > +       return 0;
> > > +}
> > > --
> > > 2.47.0
> > >

