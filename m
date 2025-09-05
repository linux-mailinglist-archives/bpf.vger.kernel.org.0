Return-Path: <bpf+bounces-67636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C318FB46615
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071971D232D1
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA22F7453;
	Fri,  5 Sep 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXE8L5pH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CF2F3C16;
	Fri,  5 Sep 2025 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108446; cv=none; b=PQeAZzE2I7PBjCH9Q6JwpC77ToGUishgy5ptyDyGFIvh0r5F0QzdAbLcrH6Ergwt8cGUIyTsHRDCOMNHEwzuweKaWzmAFvApFmoPeN3FeJdkOCJ4TPykxXpvcpNbExT4qeT5Bt7IYRekHM840ksL9UYiP2k4c2bC0bMQAyfohes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108446; c=relaxed/simple;
	bh=FDY959cO9wwTENDJzS2+XGN7bG6tY4hhG8E4UV3KT4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/zmByHK7KIBiyjXit9cL6Gah+HX4jjeobaIglIwwFquBavUGqnSeosJIN/WZoMzkIhb7jbGSPevdSF6NopEJJ6NHln818UZYu740CuxPWQ8H81d3fM1Zbr8NDp7PFRPbldy17UsB3XD9uZd4aiMW9ujLsZ/O9XfQcytKWjoPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXE8L5pH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so3079977a12.0;
        Fri, 05 Sep 2025 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757108442; x=1757713242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjQFGEB6YpkPaQvXYN6qaYlcf1r3Th/NOUzoCak8BuA=;
        b=bXE8L5pHRd6u+fsIX6U2kTDfQw5nxX/x+NCwEplzrWYDUbiTSAOuYyhrLgLulPvdE9
         zGvx/ADrmyYzyXo00Ga2SMD7Hw2ASRGDS6zAgZJjj3MqqUfgNOUI/+wGKpdHFEFtzexp
         b3Ai70nhiluK5rKBZGM85Z+Ruz5RZ1vwpRWk/Zg2i/ArSRdlORLGawfot4bix2vol7Br
         2chhgmWR2NkPhDan/qjekTjQvWMe6wuIoF7VYJwmEWcuGZpPPtvM0i0fIOqTTix7Culb
         5V4E/bFj3vmsK3u40JJoep3fyVkMoVt0+jG2STPaJkLSbBt7206jkSNj9Q1aqAbIsM23
         dTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108442; x=1757713242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjQFGEB6YpkPaQvXYN6qaYlcf1r3Th/NOUzoCak8BuA=;
        b=PDDFkfPilFJOaJNAt8wGnjuAQXTegEwe23VdhB1mx+NQyE0WI/Ct3l9U8uX+T8mlIW
         aqsiNkYuUylAfzmaocSxyJZkNz5eSf1OblwDtSdS8viFUr33shxof2Unm1dxPGkaeo1D
         jjorU+zGGZ/u/tV6V7rWJx3wEl2AWv9C1z0WO1+vZYclrylyEpbIBA6CH7JUpht3jnNW
         0AXfOq9jhFOaTXAy2tj6NcVyerMDljIVIGaKX604e4T2gRdcZyxVi/gfUX0QglDRLk0R
         bp7YNL8LdWnd3c6o3RkEp+NjjHf/9YLMwYllfgsjIYO1ZrRXSXZAhc79xD7dVYwqonEF
         idjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSOMP1Gj1OheQLCSH8kmOeYjdfOGAIX1r+QQcVhRi5+Qlt1tKbbQDNoVzgJmU4o3yv7+N3tg8b0G+1QNW5j/QlxI2O@vger.kernel.org, AJvYcCVemXP9HK/j1LH16JM12naTllHfOo2jamP35AblTGHD9Ph2LJwIm0Uvwf0DsDXcGFYhyZrXHTGUQLeoFKvN@vger.kernel.org, AJvYcCVpnCIvkvF0WqH37ad2qJ4reNoTRX4u5DJpiXaFTq1CLmI6dI3NyyjWJ3bOP+nyNSA2RuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRy5bSUbf32DgPNKOXy4ck1nZKxUVZn6cnCUgwkROmit+V0MA3
	xgsarobAFFhjsNQKkAA5XEhlKuoxHn1zHgxDtiTNU/CZJ1zVSsilb68/XRoOa5SKYU7+De3kjDw
	r3zDLf+fSrfiuvVFDom1w8v4NwKnjsBE=
X-Gm-Gg: ASbGnct+Zuh9mJknjxjuqsw0iGkO7CCiiYCEHSfZGnlvZLocwAF3Zt4/F5/rBfPVKK7
	dM+cbP9RfVV+dzf91AXeeDrgYMevkR916BzU2WM0+wTVP4Di8FODvtZHF3JRK/JFFfs3BR4rWuM
	mAKVcLxaRZyRDspnCf6l/Raye9kx3X0jBnTOMpXJ7FL3jWf9YITw5iMxPLd3Q6hCEk22PPjzZ4C
	NQCQh41bdOkjE9yzkyFNOor2Q==
X-Google-Smtp-Source: AGHT+IFZfG8mZqRvQ/99I3k+YKlP8EPpxCHHBeoBZvG3bPIr/jsBy+2GreK7+mcbhzjpnK50IxYgO09KjN/nC7yPV4s=
X-Received: by 2002:a17:907:94c1:b0:ae0:d1f3:f7f4 with SMTP id
 a640c23a62f3a-b04b13cd58bmr25664466b.13.1757108442262; Fri, 05 Sep 2025
 14:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905205731.1961288-1-jolsa@kernel.org> <20250905205731.1961288-3-jolsa@kernel.org>
In-Reply-To: <20250905205731.1961288-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:40:26 -0700
X-Gm-Features: Ac12FXwbNGJ3otrnN6W2Jgm_ZRnGxpsFDGJFYKQUsNpWsEdtmyGy6UEoMuQMrfI
Message-ID: <CAEf4BzYnr1UEk-6b73Won4HqcQ_c3Tg+zsHaBXM1P4n3LjKzAQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 2/3] selftests/bpf: Fix uprobe_sigill test for
 uprobe syscall error value
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>, Alejandro Colomar <alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:58=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The uprobe syscall now returns -ENXIO errno when called outside
> kernel trampoline, fixing the current sigill test to reflect that
> and renaming it to uprobe_error.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 34 ++++---------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 5da0b49eeaca..6d75ede16e7c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -757,34 +757,12 @@ static void test_uprobe_race(void)
>  #define __NR_uprobe 336
>  #endif
>
> -static void test_uprobe_sigill(void)
> +static void test_uprobe_error(void)
>  {
> -       int status, err, pid;
> +       long err =3D syscall(__NR_uprobe);
>
> -       pid =3D fork();
> -       if (!ASSERT_GE(pid, 0, "fork"))
> -               return;
> -       /* child */
> -       if (pid =3D=3D 0) {
> -               asm volatile (
> -                       "pushq %rax\n"
> -                       "pushq %rcx\n"
> -                       "pushq %r11\n"
> -                       "movq $" __stringify(__NR_uprobe) ", %rax\n"
> -                       "syscall\n"
> -                       "popq %r11\n"
> -                       "popq %rcx\n"
> -                       "retq\n"
> -               );
> -               exit(0);
> -       }
> -
> -       err =3D waitpid(pid, &status, 0);
> -       ASSERT_EQ(err, pid, "waitpid");
> -
> -       /* verify the child got killed with SIGILL */
> -       ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
> -       ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
> +       ASSERT_EQ(err, -1, "error");
> +       ASSERT_EQ(errno, ENXIO, "errno");
>  }
>
>  static void __test_uprobe_syscall(void)
> @@ -805,8 +783,8 @@ static void __test_uprobe_syscall(void)
>                 test_uprobe_usdt();
>         if (test__start_subtest("uprobe_race"))
>                 test_uprobe_race();
> -       if (test__start_subtest("uprobe_sigill"))
> -               test_uprobe_sigill();
> +       if (test__start_subtest("uprobe_error"))
> +               test_uprobe_error();
>         if (test__start_subtest("uprobe_regs_equal"))
>                 test_uprobe_regs_equal(false);
>         if (test__start_subtest("regs_change"))
> --
> 2.51.0
>

