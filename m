Return-Path: <bpf+bounces-58337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FA5AB8DCF
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0707B6A1F
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E0F255E44;
	Thu, 15 May 2025 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDJFcJM1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3698F6E;
	Thu, 15 May 2025 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330302; cv=none; b=QjV1I0GY0Sw+JpJ1i/j0LEUTxIg2BcVcrDsCS6AtqCmQ19QMZ/CBXURs0aTf6d4KP7DjFR2Ix7lyoTpgzB7DyyxNqM82l0NjZGgArWfeyX8DQdxPBc7SW/Ne8OZrcpMHtl/P2H2hTQAXFejNEhOt1Z/PunYdIYYEMJQfAu1R8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330302; c=relaxed/simple;
	bh=578yBCCF9YgD1A2zHQsbxBb6nOWkxV7xhBGHlUk1Zc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXCHBqexB/9snrpoA13Y7hRI2lkhGBAQ83p9G/cmHjG0/bgg/WQOxY3+cZZQG8LTEFWR+TkCLFkLorOEfQ+ub8lIbQ6GaPRTq/1t4g7c3+zCS5yoisJJ5pGa85JuBjh1XS6jDHIbr0GvcwodFvIH746z4ArTltco+Pyf1MtECWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDJFcJM1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30c47918d84so1220437a91.3;
        Thu, 15 May 2025 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747330300; x=1747935100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prxVvoM1ErB3/Q5EAy9SY19xCRr1qk2RFrDCUh/b+3k=;
        b=kDJFcJM1AyG5SSO8+bT2+5MYNbpdO7Mbx09E/xP6iyRk4kChuGV3flWltaR0KJF6Ih
         tcoPMb2IEeo+ASqwhMUzHgy9YuZwHsnIavKpJ146LxRW8wjZ9LIUIEUutDhvkOGut30I
         eYfpfQoauFnNh+UXCJhy/caF0uEfVQWWq7bmSQPFr+neRoXtIyhDm12AJ+W1/1Uk/xqy
         JBBSS8IJGsE9i1DY8nbHXTZtMMv8OeKcBativto/OFOgX1j+W6i2W3omvQT+TuLgEoo+
         JFObxU+Uic+2LTKiYPUlIFhiECAa8osa71zTn0JBON+2k05FD5MBWV+tr28i5EO1CGqI
         bf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747330300; x=1747935100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prxVvoM1ErB3/Q5EAy9SY19xCRr1qk2RFrDCUh/b+3k=;
        b=pnwFqjuR8kojT+bzjAeLr3r5og4mBiE2MDAxTSST/wMoXKAf6ZVLzDy70jSoGJUh7g
         8ndaJenAl5whXNGKojY7txQaiY4+mTHtW7su4LudNwBZwA5gqQ6Ls3b4ouILsaJGhYl1
         isOHq29tkuxwZZXOYDcyzn7T1U4wnUX+ShnEGWBicpj7s+vgKf4C9Sa0OMksr3CqoKFD
         7zqzgc7JpqFOQ9qCOKvS2k/LBbi0AVU6Bgt1LrINfooe1uC3r9x2IQtx7t9I6xljbhdv
         Pr/uowf/wO5FKrrKMZsnF/WxAYMJXb9bR6+gQU6eaGmmvpdr9Gd5SQV8CSipkP392dJu
         poXA==
X-Forwarded-Encrypted: i=1; AJvYcCUIqSY9PdmRbX7M/qJ4/PJ3MR8R4RUf5HyxoIJCIE28FoP+8p2bDijLXRC0PNrzkt+ocds=@vger.kernel.org, AJvYcCVHMRPr4WRiKz2No4g4ILckcGx1rm6ODkojVSCOD7gMWUFQ1r512tg7+GoJgQXhuS/K+2opwTfqLNWKP7GQumoz8x9j@vger.kernel.org, AJvYcCXoLoFDhMA2NZGEjYqYL7/FK7pLiMFCDVIUyEUW1dsX6qTurUaAnoctxR4pxx63nAxwdamNOub5DO0ClK/l@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzNgf4ghSkZvp78BjYlrth25623o5G9HvdUsIBNTb27FtvOeW
	MLmtkkUUGtFunKpukKxh4cwfSnQIArMz1cmZYWiStPFanY4l81dPyTHv79aCHShXLRqbwMXl6/s
	02AM9NhkoZc6mVV7jLoUqpRT/hYSpkSI=
X-Gm-Gg: ASbGnctnvoimSEUECWDwglJ4SMbTcc4yLW0tZBtld2X84rHp+KC1oGBdNxOAcKYVCRn
	oLfi4EGvq0bD2VFbmT0pg0M48F8VCwNBl/bJVQDO4cDX+fXeyVmxx/EFSHQHAJC1bKXKOr0XJBh
	UMlBuP4G4Lt0KjFPI407cGOnGkwW016UfqpliY6UY+eVogdFuD
X-Google-Smtp-Source: AGHT+IEWJEP4JHBPYv3pIhsvQT0yFk8+vd0BQ6h8BcUdT6+/B+8a0NIRqXbe5Kc4av7UTEAWeTX24BqqBVmsR9UY+K0=
X-Received: by 2002:a17:90b:48ce:b0:30a:a50e:349c with SMTP id
 98e67ed59e1d1-30e7d5b77f2mr300399a91.30.1747330300315; Thu, 15 May 2025
 10:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515121121.2332905-1-jolsa@kernel.org> <20250515121121.2332905-16-jolsa@kernel.org>
In-Reply-To: <20250515121121.2332905-16-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:31:28 -0700
X-Gm-Features: AX0GCFsYXtZK-ThNHMZx5N7UZfuuIZHTCObzi1QJtMdvlRR1bBbVItHq81V6p8c
Message-ID: <CAEf4Bza3cd5cMRvouUiVNrt5MRU4Nhpo7i0KEy1Gm5DTgOFszw@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core 15/22] selftests/bpf: Add hit/attach/detach
 race optimized uprobe test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:15=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that makes sure parallel execution of the uprobe and
> attach/detach of optimized uprobe on it works properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index b9152ca8cdf5..a83abbe91b01 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -15,6 +15,7 @@
>  #include <asm/prctl.h>
>  #include "uprobe_syscall.skel.h"
>  #include "uprobe_syscall_executed.skel.h"
> +#include "bpf/libbpf_internal.h"
>
>  #define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
>  #include "usdt.h"
> @@ -634,6 +635,97 @@ static void test_uretprobe_shadow_stack(void)
>         ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
>  }
>
> +static volatile bool race_stop;
> +
> +static USDT_DEFINE_SEMA(race);
> +
> +static void *worker_trigger(void *arg)
> +{
> +       unsigned long rounds =3D 0;
> +
> +       while (!race_stop) {
> +               uprobe_test();
> +               rounds++;
> +       }
> +
> +       printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
> +       return NULL;
> +}
> +
> +static void *worker_attach(void *arg)
> +{
> +       LIBBPF_OPTS(bpf_uprobe_opts, opts);
> +       struct uprobe_syscall_executed *skel;
> +       unsigned long rounds =3D 0, offset;
> +       const char *sema[2] =3D {
> +               __stringify(USDT_SEMA(race)),
> +               NULL,
> +       };
> +       unsigned long *ref;
> +       int err;
> +
> +       offset =3D get_uprobe_offset(&uprobe_test);
> +       if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
> +               return NULL;
> +
> +       err =3D elf_resolve_syms_offsets("/proc/self/exe", 1, (const char=
 **) &sema, &ref, STT_OBJECT);
> +       if (!ASSERT_OK(err, "elf_resolve_syms_offsets_sema"))
> +               return NULL;
> +
> +       opts.ref_ctr_offset =3D *ref;
> +
> +       skel =3D uprobe_syscall_executed__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"=
))
> +               return NULL;
> +
> +       while (!race_stop) {
> +               skel->links.test_uprobe =3D bpf_program__attach_uprobe_op=
ts(skel->progs.test_uprobe,
> +                                       0, "/proc/self/exe", offset, &opt=
s);
> +               if (!ASSERT_OK_PTR(skel->links.test_uprobe, "bpf_program_=
_attach_uprobe_opts"))
> +                       break;
> +
> +               bpf_link__destroy(skel->links.test_uprobe);
> +               skel->links.test_uprobe =3D NULL;
> +               rounds++;
> +       }
> +
> +       printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, =
skel->bss->executed);
> +       uprobe_syscall_executed__destroy(skel);
> +       free(ref);
> +       return NULL;
> +}
> +
> +static void test_uprobe_race(void)
> +{
> +       int err, i, nr_threads;
> +       pthread_t *threads;
> +
> +       nr_threads =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(nr_threads, 0, "libbpf_num_possible_cpus"))
> +               return;
> +       nr_threads =3D max(2, nr_threads);
> +
> +       threads =3D malloc(sizeof(*threads) * nr_threads);

leaking this? maybe just use `pthread_t thread[nr_threads];`? or alloca()?

> +       if (!ASSERT_OK_PTR(threads, "malloc"))
> +               return;
> +
> +       for (i =3D 0; i < nr_threads; i++) {
> +               err =3D pthread_create(&threads[i], NULL, i % 2 ? worker_=
trigger : worker_attach,
> +                                    NULL);
> +               if (!ASSERT_OK(err, "pthread_create"))
> +                       goto cleanup;
> +       }
> +
> +       sleep(4);

4 seconds... can we make it much shorter and allow to define the
actual runtime with envvar? So for thorough testing you'll define
something multi-second, but once things land and settle we can run it
for 100ms at most and not slow down CI significantly? All these slow
tests do add up :(

> +
> +cleanup:
> +       race_stop =3D true;
> +       for (nr_threads =3D i, i =3D 0; i < nr_threads; i++)
> +               pthread_join(threads[i], NULL);
> +
> +       ASSERT_FALSE(USDT_SEMA_IS_ACTIVE(race), "race_semaphore");
> +}
> +
>  static void __test_uprobe_syscall(void)
>  {
>         if (test__start_subtest("uretprobe_regs_equal"))
> @@ -652,6 +744,8 @@ static void __test_uprobe_syscall(void)
>                 test_uprobe_session();
>         if (test__start_subtest("uprobe_usdt"))
>                 test_uprobe_usdt();
> +       if (test__start_subtest("uprobe_race"))
> +               test_uprobe_race();
>  }
>  #else
>  static void __test_uprobe_syscall(void)
> --
> 2.49.0
>

