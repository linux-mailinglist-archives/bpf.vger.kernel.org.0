Return-Path: <bpf+bounces-28459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A158B9EAE
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B2D28118B
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9D149E1F;
	Thu,  2 May 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U70ROTZK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB02EB11;
	Thu,  2 May 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667642; cv=none; b=YU15qB1K4aFeFM4+8bdPzhyAc2yaAeSLswHGu7CU5gz88VguJgUJVArC8wQQNoKotLNGRF1QfCzxO88ZtC3ColuIiYRfnawXlZH6D5g9Ad466Hf5PjU74UDFtgN32NfKVBtOLUhvRoRIjf6h/dmb/jPQy9tNpNwSvytQ3QyOmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667642; c=relaxed/simple;
	bh=JW/An3S/SKt2uQx2Q8+8XVjpWu5NSs5jUx7EZtrEqoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjT49aeKxdWFVOgE93M918lh7k/coPBFpvFIvX4RKpGsJcjoK6I6z8JozV8eQx5H3wlenpvPIAh+uvNokgWiRwc802moqVjcbQW13ukT1SKmbZ2l+4z66WetCUb1UrszuF0dc2wKnKdxDXJT6J0PnT+IILTBFF88Yb0TyN08KL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U70ROTZK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so6424774a12.3;
        Thu, 02 May 2024 09:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714667641; x=1715272441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Pdcql/TWdHiSv0vDa5qsoa70UOu80L7gQU54+gQbek=;
        b=U70ROTZK1wPLa5uqZZSL9CoLYv6Ih1Qd8lSSDaeaNtUorg5dx6Qjx50YTHGjt2C/Ep
         odDd55OaHXG4VMcG+anRDAEbD0D9RJco44q3P4aDd0OB+z6tjHd8CMlJ9klcw3zM8v0x
         u9K6e/yBURXqJeBYNCVDvjZzje4rMZ+5pO5sk/BLfXlwvvS73YVhnDqzMdKN7UZLFk1E
         4HNY0FnMszeYe+lyzoEsy8ej3KFGEozy73rks7iALxzRJpK9rEE12CfHFm5WalZxzRal
         0vOqFoyJoV1hbRDmJFeqk8tjyZsddCcC6aWQPzbk878SPuQ+tbQKXT/mDPGocrZuwba+
         rutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667641; x=1715272441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Pdcql/TWdHiSv0vDa5qsoa70UOu80L7gQU54+gQbek=;
        b=gxqJWuCr5jjODbNbSUMANlhviY/4fhz+V1jjAe3gQeQxfOxRgVIdSR1YmxBfrdp/N+
         vNwzrREGQJHbg6oeybAEDnAVHp1kO32V08kEo3poGaGk+/bUScOTrHIoFrilpM4UEMj2
         lL8iKdNm/Qw1USEtlbjAOgGWrONMuQNGe0m8W7ERTEEh+ufc4utB391zG9JogUAMtVNb
         LNWRp7indxxCx3vX1YGi/FimnurmG6f/s7zm1+YTu4o8YqIZH6klbmWRD0pAo4I0Tgl2
         wCbDGTmqyfIyDvekBrLewecDo8IANHf1p9JCTZu9h0pmj9fd++trzQfltM3UjcxsVx9i
         /4hA==
X-Forwarded-Encrypted: i=1; AJvYcCWM98HYUfSExKwdWwVSOgqskzsNLvznUc22CYr+b6iE1kj8TVQStB0BdR5ah/JOghQdonlUqio3zK6xZBCCRys1VxzWKkv6vRPN8haTRSM7EhPqXNbW4xVoT/YgUxb2jd6acf0eRxswTd2LBJGWG5r0b4fIRT2WzlK0Q9JRmDEGOgJO3Mqjw1rh0wix/EDgZG9ULlda3oRWm6QnMFJaxWkRfV75/rPemqMog8bJHDplCQPCDujbYKIRtiA0
X-Gm-Message-State: AOJu0YwARV97MA7m4pVTDTWzMuXFHJB3nLMIKWlexUYJLaUYFUTEk1D5
	miZTQ2ltpok/AVy4QCGrgnTedU5fJWjy6P9H29xsUeEtWoreAPD58qoO7NaLbQZVqHqxa8XubtW
	6thaAeFYncbObfqQvctvCCYysWgk=
X-Google-Smtp-Source: AGHT+IGI0cU95F1idQiM2ErD6YaeIjs/+ntGtNh7G3RVoDvemiooXFoQbso4kOUQOARe7FE7WhiNGsM3fIjylH0JKOo=
X-Received: by 2002:a17:90a:9f88:b0:2a4:b831:5017 with SMTP id
 o8-20020a17090a9f8800b002a4b8315017mr261052pjp.48.1714667640704; Thu, 02 May
 2024 09:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502122313.1579719-1-jolsa@kernel.org> <20240502122313.1579719-6-jolsa@kernel.org>
In-Reply-To: <20240502122313.1579719-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 May 2024 09:33:48 -0700
Message-ID: <CAEf4BzY75dm6EryjZHKkAuBn8NzRV2POEa=Sbqr8kA2LgemUpw@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 5/7] selftests/bpf: Add uretprobe syscall call
 from user space test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:24=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test to verify that when called from outside of the
> trampoline provided by kernel, the uretprobe syscall will cause
> calling process to receive SIGILL signal and the attached bpf
> program is not executed.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 95 +++++++++++++++++++
>  .../bpf/progs/uprobe_syscall_executed.c       | 17 ++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_exec=
uted.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 1a50cd35205d..c6fdb8c59ea3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -7,7 +7,10 @@
>  #include <unistd.h>
>  #include <asm/ptrace.h>
>  #include <linux/compiler.h>
> +#include <linux/stringify.h>
> +#include <sys/wait.h>
>  #include "uprobe_syscall.skel.h"
> +#include "uprobe_syscall_executed.skel.h"
>
>  __naked unsigned long uretprobe_regs_trigger(void)
>  {
> @@ -209,6 +212,91 @@ static void test_uretprobe_regs_change(void)
>         }
>  }
>
> +#ifndef __NR_uretprobe
> +#define __NR_uretprobe 462
> +#endif
> +
> +__naked unsigned long uretprobe_syscall_call_1(void)
> +{
> +       /*
> +        * Pretend we are uretprobe trampoline to trigger the return
> +        * probe invocation in order to verify we get SIGILL.
> +        */
> +       asm volatile (
> +               "pushq %rax\n"
> +               "pushq %rcx\n"
> +               "pushq %r11\n"
> +               "movq $" __stringify(__NR_uretprobe) ", %rax\n"
> +               "syscall\n"
> +               "popq %r11\n"
> +               "popq %rcx\n"
> +               "retq\n"
> +       );
> +}
> +
> +__naked unsigned long uretprobe_syscall_call(void)
> +{
> +       asm volatile (
> +               "call uretprobe_syscall_call_1\n"
> +               "retq\n"
> +       );
> +}
> +
> +static void test_uretprobe_syscall_call(void)
> +{
> +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
> +               .retprobe =3D true,
> +       );
> +       struct uprobe_syscall_executed *skel;
> +       int pid, status, err, go[2], c;
> +
> +       if (pipe(go))
> +               return;

very unlikely to fail, but still, ASSERT_OK() would be in order here

But regardless:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

