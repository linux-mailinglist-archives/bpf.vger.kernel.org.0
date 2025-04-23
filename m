Return-Path: <bpf+bounces-56526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E7A996F4
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A04A039E
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88976283689;
	Wed, 23 Apr 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNo9Yx+V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31453DF58;
	Wed, 23 Apr 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430403; cv=none; b=mXIZepleFdPmwRZqBXJlQ7c+DNWAtQm9NngKuOcro+TUH7H9RHL+MKhymbei+1EkpfPj1x+uFY3dRI9ujYTxdEgxeJNDomjSKoxBBqhDUSy+xdu7pZKS5xq7JUXB7vaud7qy3F4qXwHoWZZzQ7ArYdDB9Gj0l4ThIMZS+uaXeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430403; c=relaxed/simple;
	bh=biO9qF+r2/A2MlZYQbH8x4xNl8bGQc1c6ERagk4XPzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAKZ0DKt0Gn0kyfdbVlyw0g3nA4nJY9wc8XOa2kvp2DqZCF2oyL5E3otrVVXblPCQnHb3sPefUB3lMMpecWyyKg+HZqSzbjF2CE/ZWb9dt5qo/SKwwQdZZo5DKgBMIPd+RJa4G61xRo2A4HUChA1Y2R+BUr4H1x9wuvMBkZFPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNo9Yx+V; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso82671a12.3;
        Wed, 23 Apr 2025 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430399; x=1746035199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXZQn8kvassAzt0nM7Nxq/3bf8QmpImuUiv4Do+uubk=;
        b=fNo9Yx+VHn0nXuhyZWtSourePGMpALME2vKzyIfeRbDbx3Vydh4v+vSMZh4MRYMy1U
         s8thpB9O9Pp70ODCr57z6jfjU9gb7yJDkDTp292I6U4+s7PWFZsnLK/ldly2icpvbR+8
         jKqbg0/Z2T7OQvAK1OWGM4SiI230aVD0jVmm3KqAdMHlO9vcqWNbflKDHBGbPnIV5gS0
         9MlgF/7ePEjtXQQzV4rZmOJHK2fC0Yk6HGTKUz8BGLTqEbdL9Sge0WytkD0oEBB6OisY
         1ZgUE+izXWKMWjzEPL0I09XyzBzABgTPVnFmv5rHz2HMcSPIN8FtKHnV7S/ydnr2tCnU
         iI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430399; x=1746035199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXZQn8kvassAzt0nM7Nxq/3bf8QmpImuUiv4Do+uubk=;
        b=d+6oQdK/E1KhvUot0iPnRKTpFkDHVfaA4vQpeF02aJu8zvBMWiX/yKvwOH9nKw1+Uj
         S2TkWdOZhVrYzT09/K7+ImIzyCPNhlXaxiJyM5RuUvJX/mwnxhU8WZfc5Te0gQprrDOQ
         csQ4dh3nGpsFsbT76vBY6CIZFmg7VhWQEPxSUEVovilPXXOgBJm8+tCQy2kbS3TskYsr
         OlbKSR6CZTGHf14iR7Yc/p0b6l9DyF9vbz5amRi42NLC9bwFwhrJ+reasGrZKucD8W7L
         Jo52I3mrshRbf5s7kpZkUQY1TUYnD08ZNO04sJWHNM0dXwapi2Kht/LT0WIBSdy9V7i1
         +kTg==
X-Forwarded-Encrypted: i=1; AJvYcCVKBc0Q74sdpIqy04hQjJb6kgJuRibvem2eJfMiJraUnoYW04HwpYmg4IbWWDNXLHvNx7I=@vger.kernel.org, AJvYcCVY1HKx8g5MyOQQOWs18yAJ6ESdzDb6E3S9MI8VAMySlHAVu9lPbIuVvqlHfXiaDwK4K5UbykVwTAPSg4P/@vger.kernel.org, AJvYcCXCwovlxuYIOC14QF2JK7fTaWi1TuILrOitgjga8iYjMrVfSU3nIDr5ZiOgHq1igLRAjySB1CZHq0widVNXmJpzuK4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8V32aHiK9DqO92WxXtgEWwGbVlYYfP551XFSwrQZV4lrUk2HN
	qHDvxXNsnBEI7XLPIwkq5scXe3eL4Xg0rBi7MKzpPOT0kz6AT5aaed3OYTZVcCQTVZkIpI/vhQ2
	AEj5t/Ea9z606VsUc9L6q1vudml8=
X-Gm-Gg: ASbGncs2a7cw4JRiUAm/GX0Ls1y6rJhFl33RwJ5pFP9kkNIcIY+gXUXZALc49rI8asG
	Fg7Aa0SYW4ZioEqejuhL/agqc2U01f4634aKgRB3Lfutn5g1fDjYnTaNQ8KJpMFtJ9nY+np0JxX
	ADdGmAMciOAQ8RFpTBygO0qDXcyZp7+Y/NlzLlfg==
X-Google-Smtp-Source: AGHT+IFlDdIotzZmdGUhuohyhf84/GoWd15MMTbUB7VohF0qWVhNtJbadVXCr5RNeA1/OjEhELyOiYrhVKgH5hVT6dM=
X-Received: by 2002:a17:907:6e9e:b0:ace:3af9:4294 with SMTP id
 a640c23a62f3a-ace54e6c8cbmr2350066b.12.1745430399311; Wed, 23 Apr 2025
 10:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-19-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-19-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:46:24 -0700
X-Gm-Features: ATxdqUEi4MHhQHNUnV8CW4TsFrqv9Z3ZPlsGZG8pOa83e1POIp2T2kHGr4gt2l8
Message-ID: <CAEf4BzZu0T5DLROi6oisneB3PyGDKZrME9+5qvw4aHeyOyNiYQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 18/22] selftests/bpf: Add uprobe_regs_equal test
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

On Mon, Apr 21, 2025 at 2:48=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Changing uretprobe_regs_trigger to allow the test for both
> uprobe and uretprobe and renaming it to uprobe_regs_equal.
>
> We check that both uprobe and uretprobe probes (bpf programs)
> see expected registers with few exceptions.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 58 ++++++++++++++-----
>  .../selftests/bpf/progs/uprobe_syscall.c      |  4 +-
>  2 files changed, 45 insertions(+), 17 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index f001986981ab..6d88c5b0f6aa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -18,15 +18,17 @@
>
>  #pragma GCC diagnostic ignored "-Wattributes"
>
> -__naked unsigned long uretprobe_regs_trigger(void)
> +__attribute__((aligned(16)))
> +__nocf_check __weak __naked unsigned long uprobe_regs_trigger(void)
>  {
>         asm volatile (
> -               "movq $0xdeadbeef, %rax\n"
> +               ".byte 0x0f, 0x1f, 0x44, 0x00, 0x00     \n"

Is it me not being hardcore enough... But is anyone supposed to know
that this is nop5? ;) maybe add /* nop5 */ comment on the side?

> +               "movq $0xdeadbeef, %rax                 \n"

ret\n doesn't align newline, and uprobe_regs below don't either. So
maybe don't align them at all here?

>                 "ret\n"
>         );
>  }
>
> -__naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *afte=
r)
> +__naked void uprobe_regs(struct pt_regs *before, struct pt_regs *after)
>  {
>         asm volatile (
>                 "movq %r15,   0(%rdi)\n"
> @@ -47,15 +49,17 @@ __naked void uretprobe_regs(struct pt_regs *before, s=
truct pt_regs *after)
>                 "movq   $0, 120(%rdi)\n" /* orig_rax */
>                 "movq   $0, 128(%rdi)\n" /* rip      */
>                 "movq   $0, 136(%rdi)\n" /* cs       */
> +               "pushq %rax\n"
>                 "pushf\n"
>                 "pop %rax\n"
>                 "movq %rax, 144(%rdi)\n" /* eflags   */
> +               "pop %rax\n"
>                 "movq %rsp, 152(%rdi)\n" /* rsp      */
>                 "movq   $0, 160(%rdi)\n" /* ss       */
>
>                 /* save 2nd argument */
>                 "pushq %rsi\n"
> -               "call uretprobe_regs_trigger\n"
> +               "call uprobe_regs_trigger\n"
>
>                 /* save  return value and load 2nd argument pointer to ra=
x */
>                 "pushq %rax\n"
> @@ -95,25 +99,37 @@ __naked void uretprobe_regs(struct pt_regs *before, s=
truct pt_regs *after)
>  );
>  }
>
> -static void test_uretprobe_regs_equal(void)
> +static void test_uprobe_regs_equal(bool retprobe)
>  {
> +       LIBBPF_OPTS(bpf_uprobe_opts, opts,
> +               .retprobe =3D retprobe,
> +       );
>         struct uprobe_syscall *skel =3D NULL;
>         struct pt_regs before =3D {}, after =3D {};
>         unsigned long *pb =3D (unsigned long *) &before;
>         unsigned long *pa =3D (unsigned long *) &after;
>         unsigned long *pp;
> +       unsigned long offset;
>         unsigned int i, cnt;
> -       int err;
> +
> +       offset =3D get_uprobe_offset(&uprobe_regs_trigger);
> +       if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
> +               return;
>
>         skel =3D uprobe_syscall__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "uprobe_syscall__open_and_load"))
>                 goto cleanup;
>
> -       err =3D uprobe_syscall__attach(skel);
> -       if (!ASSERT_OK(err, "uprobe_syscall__attach"))
> +       skel->links.probe =3D bpf_program__attach_uprobe_opts(skel->progs=
.probe,
> +                               0, "/proc/self/exe", offset, &opts);
> +       if (!ASSERT_OK_PTR(skel->links.probe, "bpf_program__attach_uprobe=
_opts"))
>                 goto cleanup;
>
> -       uretprobe_regs(&before, &after);
> +       /* make sure uprobe gets optimized */
> +       if (!retprobe)
> +               uprobe_regs_trigger();
> +
> +       uprobe_regs(&before, &after);
>
>         pp =3D (unsigned long *) &skel->bss->regs;
>         cnt =3D sizeof(before)/sizeof(*pb);
> @@ -122,7 +138,7 @@ static void test_uretprobe_regs_equal(void)
>                 unsigned int offset =3D i * sizeof(unsigned long);
>
>                 /*
> -                * Check register before and after uretprobe_regs_trigger=
 call
> +                * Check register before and after uprobe_regs_trigger ca=
ll
>                  * that triggers the uretprobe.
>                  */
>                 switch (offset) {
> @@ -136,7 +152,7 @@ static void test_uretprobe_regs_equal(void)
>
>                 /*
>                  * Check register seen from bpf program and register afte=
r
> -                * uretprobe_regs_trigger call
> +                * uprobe_regs_trigger call (with rax exception, check be=
low).
>                  */
>                 switch (offset) {
>                 /*
> @@ -149,6 +165,15 @@ static void test_uretprobe_regs_equal(void)
>                 case offsetof(struct pt_regs, rsp):
>                 case offsetof(struct pt_regs, ss):
>                         break;
> +               /*
> +                * uprobe does not see return value in rax, it needs to s=
ee the
> +                * original (before) rax value
> +                */
> +               case offsetof(struct pt_regs, rax):
> +                       if (!retprobe) {
> +                               ASSERT_EQ(pp[i], pb[i], "uprobe rax prog-=
before value check");
> +                               break;
> +                       }
>                 default:
>                         if (!ASSERT_EQ(pp[i], pa[i], "register prog-after=
 value check"))
>                                 fprintf(stdout, "failed register offset %=
u\n", offset);
> @@ -186,13 +211,13 @@ static void test_uretprobe_regs_change(void)
>         unsigned long cnt =3D sizeof(before)/sizeof(*pb);
>         unsigned int i, err, offset;
>
> -       offset =3D get_uprobe_offset(uretprobe_regs_trigger);
> +       offset =3D get_uprobe_offset(uprobe_regs_trigger);
>
>         err =3D write_bpf_testmod_uprobe(offset);
>         if (!ASSERT_OK(err, "register_uprobe"))
>                 return;
>
> -       uretprobe_regs(&before, &after);
> +       uprobe_regs(&before, &after);
>
>         err =3D write_bpf_testmod_uprobe(0);
>         if (!ASSERT_OK(err, "unregister_uprobe"))
> @@ -605,7 +630,8 @@ static void test_uretprobe_shadow_stack(void)
>         /* Run all the tests with shadow stack in place. */
>         shstk_is_enabled =3D true;
>
> -       test_uretprobe_regs_equal();
> +       test_uprobe_regs_equal(false);
> +       test_uprobe_regs_equal(true);
>         test_uretprobe_regs_change();
>         test_uretprobe_syscall_call();
>
> @@ -728,7 +754,7 @@ static void test_uprobe_sigill(void)
>  static void __test_uprobe_syscall(void)
>  {
>         if (test__start_subtest("uretprobe_regs_equal"))
> -               test_uretprobe_regs_equal();
> +               test_uprobe_regs_equal(true);
>         if (test__start_subtest("uretprobe_regs_change"))
>                 test_uretprobe_regs_change();
>         if (test__start_subtest("uretprobe_syscall_call"))
> @@ -747,6 +773,8 @@ static void __test_uprobe_syscall(void)
>                 test_uprobe_race();
>         if (test__start_subtest("uprobe_sigill"))
>                 test_uprobe_sigill();
> +       if (test__start_subtest("uprobe_regs_equal"))
> +               test_uprobe_regs_equal(false);
>  }
>  #else
>  static void __test_uprobe_syscall(void)
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/t=
esting/selftests/bpf/progs/uprobe_syscall.c
> index 8a4fa6c7ef59..e08c31669e5a 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> @@ -7,8 +7,8 @@ struct pt_regs regs;
>
>  char _license[] SEC("license") =3D "GPL";
>
> -SEC("uretprobe//proc/self/exe:uretprobe_regs_trigger")
> -int uretprobe(struct pt_regs *ctx)
> +SEC("uprobe")
> +int probe(struct pt_regs *ctx)
>  {
>         __builtin_memcpy(&regs, ctx, sizeof(regs));
>         return 0;
> --
> 2.49.0
>

