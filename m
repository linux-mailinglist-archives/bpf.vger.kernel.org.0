Return-Path: <bpf+bounces-27960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D783C8B3ED3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927E128466E
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE416D4F5;
	Fri, 26 Apr 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9oEdUcP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88016C45B;
	Fri, 26 Apr 2024 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154624; cv=none; b=d8JdhTKw00GLGtMCH1+vyvv8Mms6E6lpLftsFwAv8QuPc1b3C87Cs3zL1TYLlg+aN+n+T1YniV9WnDBWMCisVOv5HZRT6mC7nL05ADOULBdCXWziXvX8onw0DY59cy9QY9lG594lwmjhrQsZ96hwoe+lxJb1mp0R30Jdim9ve3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154624; c=relaxed/simple;
	bh=o9C3Y4wKnnAMYR4R4XZ258dS0vNsA42AOcfW24YCujM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2wmsbI0It+GjnH8SOCR2nY/8Z8eF0PkvHq0cZi/+Hho6xmDDoCOPaU4l7LrglB0Z7P48opNlfd/DOO3kN3DGiiO4dxhUVm46iFTRaTt/zTre5fc7mCH8x5DFoCWOENpeCw3g9KQyfI1/zEljLfFxczUxPByQowIPOnnzV3Gaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9oEdUcP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eac92f7c74so16277345ad.3;
        Fri, 26 Apr 2024 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714154622; x=1714759422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zLMERCAeeJ8zabPFzTQqoiOgb5JxeqVEQwjKBN9mmA=;
        b=Y9oEdUcP2FqyBOTiYyHOoQphesh8FntxhDTrby3HX8EhCTo0gxPBSM3Ji+X0PWIBx8
         5lRmvcN8eWdt88UYoH2CBYmnaVKFs0FbsI9iueE/BWuAnCYzb6fFiwKQg0eNTbtaa94Q
         0Sc1CZ07L2Jx8bGohH2IS03GM9mnvssX9PtUaQvr5dYOUmxChnWWR5FXZISCtBDdln17
         DDQLugrTiF+HdmtRmatb7vOnwj1A+q3vk96LBFWWxv9t8+JjosS2hffTBvu9FPLJZOSG
         XtYqu1ow+Uw0PprwHK7aXhj/8s+f7DxYOB5f613rRb6oz+tRGXN1foAnD5sHMdHkdA6i
         OfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714154622; x=1714759422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zLMERCAeeJ8zabPFzTQqoiOgb5JxeqVEQwjKBN9mmA=;
        b=Siy3KH8jNzSdrUdV8jnO2HfoG7gLwWCbkC5cvFIdkHQgzU4rxE8bhHPwzLZzbssknO
         727s6fzApFFVzOH025yJb7JoYqltM16HhaZNkXs/jgivrJ6szZH7NaDCQvaCuK5vZzxu
         JKFqmxAiVvr1SMWHueOAZQRJUvCAfjcuaHEwA93JDGV+IpvFckJVpAEqDnkxgS7nrYMN
         1iuqoRn7qH7SlSKhceIV7cuiuGcwXyGeZUQ4kx4Vw2U+XGUfKqw1wgnUEhhrDBtW6fu2
         Ed1di3JtxzWCD0b43tSCuT3HL0a6mYoSDVW9DY5JOV9HzcuffmZ1KitL/wz24zzjIyOx
         xPfg==
X-Forwarded-Encrypted: i=1; AJvYcCVUqXco2LhI/nH5BY+iojsVSpM0yjrrCwI0DAAeuRcOjA1zpZsH1qkewjxHrKsv3DqTdvgKr3LZ1uqTgljB4QR4eO/vDTK5RBIfYVUWSeTDl9mH5aLycnWKRet7Zd9tQGRW4/WmSUKtfBKXzZzZk54Ezs+8jA/bLWwfJoH7AbSI4S2G/aDuUKIJwID7KoUZvdK6CL/6ILXOHuMyCwcA/R0M
X-Gm-Message-State: AOJu0YzK4pbTd1w4Ffvj5NGI98qTBs9QAyODoDxR4oU34pzHxIPCPXjr
	62j9xl4itWRpfWyonTo911Q5J3+OKoj8ZAg1caX1rBdaTr5dHT8Xr05An/orLSrwwfN5g6j9M3t
	U63965CrYgaH3Jm53RZ8JoZn7AOU=
X-Google-Smtp-Source: AGHT+IGyoj0fwtcOLjsvSxBdIcX1FXcslRfQd5W9ezMPzPQU/t+8yhXUOx1RNzzWkY6RiI0QXztWzyy63rXbrwCE1uI=
X-Received: by 2002:a17:902:c40f:b0:1e9:cf94:5bea with SMTP id
 k15-20020a170902c40f00b001e9cf945beamr4306261plk.35.1714154621816; Fri, 26
 Apr 2024 11:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421194206.1010934-1-jolsa@kernel.org> <20240421194206.1010934-6-jolsa@kernel.org>
In-Reply-To: <20240421194206.1010934-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Apr 2024 11:03:29 -0700
Message-ID: <CAEf4BzbWr9s2HiWU=7=okwH7PR8LHGFj2marmaOxKW61BWKHGg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 5/7] selftests/bpf: Add uretprobe syscall call
 from user space test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 12:43=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding test to verify that when called from outside of the
> trampoline provided by kernel, the uretprobe syscall will cause
> calling process to receive SIGILL signal and the attached bpf
> program is no executed.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 92 +++++++++++++++++++
>  .../selftests/bpf/progs/uprobe_syscall_call.c | 15 +++
>  2 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_call=
.c
>

See nits below, but overall LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> @@ -219,6 +301,11 @@ static void test_uretprobe_regs_change(void)
>  {
>         test__skip();
>  }
> +
> +static void test_uretprobe_syscall_call(void)
> +{
> +       test__skip();
> +}
>  #endif
>
>  void test_uprobe_syscall(void)
> @@ -228,3 +315,8 @@ void test_uprobe_syscall(void)
>         if (test__start_subtest("uretprobe_regs_change"))
>                 test_uretprobe_regs_change();
>  }
> +
> +void serial_test_uprobe_syscall_call(void)

does it need to be serial? non-serial are still run sequentially
within a process (there is no multi-threading), it's more about some
global effects on system.

> +{
> +       test_uretprobe_syscall_call();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c b/to=
ols/testing/selftests/bpf/progs/uprobe_syscall_call.c
> new file mode 100644
> index 000000000000..5ea03bb47198
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <string.h>
> +
> +struct pt_regs regs;
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("uretprobe//proc/self/exe:uretprobe_syscall_call")
> +int uretprobe(struct pt_regs *regs)
> +{
> +       bpf_printk("uretprobe called");

debugging leftover? we probably don't want to pollute trace_pipe from test

> +       return 0;
> +}
> --
> 2.44.0
>

