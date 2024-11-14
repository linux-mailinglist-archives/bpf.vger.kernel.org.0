Return-Path: <bpf+bounces-44887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D19C9635
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A761F22AD6
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567721B3725;
	Thu, 14 Nov 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et78cqeg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3501AF0BA;
	Thu, 14 Nov 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627667; cv=none; b=Rj8TmA7R8HBW+nFlASwWjnXM4NGD3mJKqpFeA3JWfPnSOOAp9OdMKgRs6TzyMrzkAi+ISgaM1a5qOC/xqtCkdGLkADyO+QCZwnDbRoTWNWr9bc+vKsBm9Th3/UvBpTDnu2xkFzOzgVWoQMBZwUY57tcboGsudGqN7r3smdOAoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627667; c=relaxed/simple;
	bh=4uP6zrGR2lcgZHcCRbq5unRCPfMDCwFbgLz2/AfPC4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6N/vwoLBrQvNDNe8xQyps7vW8xjeAwEaeIM79psilGoLo/Xg0ho5JPe6Tp4/pdm2Ma/ooIwyhfazXmi5g5OriZh55nzvuANn1L2cWGEgQllxXwdohBRsnKamlfksc1borvFhlRol92wva5VVdDjIEggznH/fZS5C4E2/hPNuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et78cqeg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea0500a300so1008711a91.0;
        Thu, 14 Nov 2024 15:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627665; x=1732232465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyoyMRZMBHfrh5qveItwCkAYFBpNWsrOGPr7w72p2rE=;
        b=et78cqegvw27ioZfE/Nf/cdSTsFxGog7EUJ5nOPh5+HVlFui1fNNaATn82e1BB/Z2Q
         xRQy9lNl5XqbGxYtgKnH0Dx0S4TgWFZ1Kvid9wu6e1CeNePpm0X03oBBAAfOIXpKSDb8
         QuKhvy0ezI7xRgInIl15j6GyswDgp/42zuXoh68pwoNEHvK1JUqiJT+xeRmQk1YgHOk1
         LCnUmauDZABv20sjUjbs/TpUY1Sr603ZXJ2pd6kJrThRnZ3BsvBze4sqx11fBuB05m43
         mdEjIeI2vh/kEP3BqFJgAnTLoJ96EIGrr6b9lf0Dp4b2a+U3bZMTtAGj3N04FdZZQB6l
         FPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627665; x=1732232465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyoyMRZMBHfrh5qveItwCkAYFBpNWsrOGPr7w72p2rE=;
        b=SrdLpRFO+5ZvEmkSU6Xd+KDx95DWsWTzLXp3LF2eLg3mGtxY7c9iI7VxadNaS6OcBZ
         gijM+vlXTk26cVDQaGDOkw7Akei4TsyfuHoQpS8dc0PiQxaaioiPIvCUTRB9V35iJ5TV
         Rvj2aMyz7qaAChoOhIlD9tU3U8hxD+QuHSnoS7F9HybGqWO6vjLc00TtgHGZV3ipA6EY
         vTSxsLub9oPQzCIGDnLtXVHG2POzEsCqVYD5sV1HAtLzZ3xzDMUJtWjNsZX41j8mzVKr
         izyLz1zudg0ygwUzw5TSKY/SPGte3DqVVZjnv4EOUMYVeatSQUWYdfytHsfKk1Dwsfbb
         jM/g==
X-Forwarded-Encrypted: i=1; AJvYcCUKvc9+23XipjiBQTUcX7yKowSR6C4w9Sn0Gch9j9gGt5Ld7tQPEmQtwgol+czx4QS7SCXcGlkjYSQckM8c@vger.kernel.org, AJvYcCUnLpLWUzyaG3KCGRWTRfIuU1NsEHY7aHwxm0+oOCKyjmwFDyVwvRsDNDHnYgj8KYqDvnU=@vger.kernel.org, AJvYcCVNT2cXrLD9zhFZZ3ewmuP2BMHb7gv5qhIWohv35zWDdu0r/4zYanvpDekAP+2TpytjBblbEyH5z+axzAY/qsv5NUzi@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhsuiJRWyxf+sMuXwhqXYMA24nkkTBem90fZZ9scbfcs5rOXG
	00UvQd2piEj52eSuLnCDr7STRFJnBzrd+WktMo+0NlTs/XDlf1hQLUueXaHhEI/fF4js4KfVJgu
	8WUtAT3rRrriU5ZH+25TlPkHY+Pc=
X-Google-Smtp-Source: AGHT+IHwBk91klljYEcb+wkITQ75hVtf9U49FSWjhQ3b6vnynPC5/5r9ymQE1WiVboXvWL3Jztk4t57fU0+fwEWPDLc=
X-Received: by 2002:a17:90a:d450:b0:2e2:9522:279e with SMTP id
 98e67ed59e1d1-2ea15582e0fmr861273a91.31.1731627665427; Thu, 14 Nov 2024
 15:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-10-jolsa@kernel.org>
In-Reply-To: <20241105133405.2703607-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 15:40:53 -0800
Message-ID: <CAEf4BzaXvdXr4dyHrozWYyMHJor5GpaHnPF8=8qy0r_5Crb3wg@mail.gmail.com>
Subject: Re: [RFC bpf-next 09/11] selftests/bpf: Add usdt trigger bench
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding usdt trigger bench to meassure optimized usdt probes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           |  2 +
>  .../selftests/bpf/benchs/bench_trigger.c      | 45 +++++++++++++++++++
>  .../selftests/bpf/progs/trigger_bench.c       | 10 ++++-
>  3 files changed, 56 insertions(+), 1 deletion(-)
>

Why not just adding uprobe-nop5 benchmark instead of going all the way
into USDT? Seems simpler and will benchmark all the same stuff?

> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index 1bd403a5ef7b..dc5121e49623 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -526,6 +526,7 @@ extern const struct bench bench_trig_uprobe_multi_pus=
h;
>  extern const struct bench bench_trig_uretprobe_multi_push;
>  extern const struct bench bench_trig_uprobe_multi_ret;
>  extern const struct bench bench_trig_uretprobe_multi_ret;
> +extern const struct bench bench_trig_usdt;
>
>  extern const struct bench bench_rb_libbpf;
>  extern const struct bench bench_rb_custom;
> @@ -586,6 +587,7 @@ static const struct bench *benchs[] =3D {
>         &bench_trig_uretprobe_multi_push,
>         &bench_trig_uprobe_multi_ret,
>         &bench_trig_uretprobe_multi_ret,
> +       &bench_trig_usdt,
>         /* ringbuf/perfbuf benchmarks */
>         &bench_rb_libbpf,
>         &bench_rb_custom,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 32e9f194d449..bdee8b8362d0 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -8,6 +8,7 @@
>  #include "bench.h"
>  #include "trigger_bench.skel.h"
>  #include "trace_helpers.h"
> +#include "../sdt.h"
>
>  #define MAX_TRIG_BATCH_ITERS 1000
>
> @@ -333,6 +334,13 @@ static void *uprobe_producer_ret(void *input)
>         return NULL;
>  }
>
> +static void *uprobe_producer_usdt(void *input)
> +{
> +       while (true)
> +               STAP_PROBE(trigger, usdt);
> +       return NULL;
> +}
> +
>  static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
>  {
>         size_t uprobe_offset;
> @@ -383,6 +391,37 @@ static void usetup(bool use_retprobe, bool use_multi=
, void *target_addr)
>         }
>  }
>
> +static void __usdt_setup(const char *provider, const char *name)
> +{
> +       struct bpf_link *link;
> +       int err;
> +
> +       setup_libbpf();
> +
> +       ctx.skel =3D trigger_bench__open();
> +       if (!ctx.skel) {
> +               fprintf(stderr, "failed to open skeleton\n");
> +               exit(1);
> +       }
> +
> +       bpf_program__set_autoload(ctx.skel->progs.bench_trigger_usdt, tru=
e);
> +
> +       err =3D trigger_bench__load(ctx.skel);
> +       if (err) {
> +               fprintf(stderr, "failed to load skeleton\n");
> +               exit(1);
> +       }
> +
> +       link =3D bpf_program__attach_usdt(ctx.skel->progs.bench_trigger_u=
sdt,
> +                                       -1 /* all PIDs */, "/proc/self/ex=
e",
> +                                       provider, name, NULL);
> +       if (!link) {
> +               fprintf(stderr, "failed to attach uprobe!\n");
> +               exit(1);
> +       }
> +       ctx.skel->links.bench_trigger_usdt =3D link;
> +}
> +
>  static void usermode_count_setup(void)
>  {
>         ctx.usermode_counters =3D true;
> @@ -448,6 +487,11 @@ static void uretprobe_multi_ret_setup(void)
>         usetup(true, true /* use_multi */, &uprobe_target_ret);
>  }
>
> +static void usdt_setup(void)
> +{
> +       __usdt_setup("trigger", "usdt");
> +}
> +
>  const struct bench bench_trig_syscall_count =3D {
>         .name =3D "trig-syscall-count",
>         .validate =3D trigger_validate,
> @@ -506,3 +550,4 @@ BENCH_TRIG_USERMODE(uprobe_multi_ret, ret, "uprobe-mu=
lti-ret");
>  BENCH_TRIG_USERMODE(uretprobe_multi_nop, nop, "uretprobe-multi-nop");
>  BENCH_TRIG_USERMODE(uretprobe_multi_push, push, "uretprobe-multi-push");
>  BENCH_TRIG_USERMODE(uretprobe_multi_ret, ret, "uretprobe-multi-ret");
> +BENCH_TRIG_USERMODE(usdt, usdt, "usdt");
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/te=
sting/selftests/bpf/progs/trigger_bench.c
> index 044a6d78923e..7b7d4a71e7d4 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2020 Facebook
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>  #include <asm/unistd.h>
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/usdt.bpf.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
>
> @@ -138,3 +139,10 @@ int bench_trigger_rawtp(void *ctx)
>         inc_counter();
>         return 0;
>  }
> +
> +SEC("?usdt")
> +int bench_trigger_usdt(struct pt_regs *ctx)
> +{
> +       inc_counter();
> +       return 0;
> +}
> --
> 2.47.0
>

