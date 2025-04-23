Return-Path: <bpf+bounces-56521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CAAA996E3
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8508460503
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD628BA93;
	Wed, 23 Apr 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/s4JRSP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3F265CB9;
	Wed, 23 Apr 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430073; cv=none; b=HFHbSflx5WtFYqNKOMmhYisH5C9arr1EWapeKsfGM4kenl/D1pheK7mBtwrH3e2mV+zFHRrJOteEkw7vQWijfEjF2qJHtYoa3Lb6d6o/S96qre0XgeBJnFwBh+9bDFAPb3r/R+mTvoJAuzr1kMbIsuu6kkdpXTKE71GEXlOjG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430073; c=relaxed/simple;
	bh=CPYGI0S42fxI0+qQOSZFrPRZZexVV8fdCyzWkFIfTAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo8RxhC/pWx1jt2iPSrRkdh1zXo2MiQx+y3DLa8bEVfQgH7FQZToNQ7k+1KT/HiNlLMvHMvbbjjdKtrATv9ZEjl2AMIlS5EHhlVC36ITn5ETO//N5lox7c7kUekW1froaL1U/cy3jzRL4pIx9v6LkqclAWN0JQ/cuwImtCJvpOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/s4JRSP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7398d65476eso110443b3a.1;
        Wed, 23 Apr 2025 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430071; x=1746034871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR8+QvWrjOg6GeEjmJtzezg7Wu31lEARL9s8Pr8Mnz4=;
        b=d/s4JRSPYtieTp2muUl+PUkFwXoUcymF/0toIpaoR0Ej+kamgDmDgMar1hd7DJ3iJQ
         32msuWO5Avc8yJHjYyQhaUnHQfQAzCfgMronJIyB6WM8zQ4+fgDt4CmHHBW2qIXnd6z4
         393Rmwn4iGlsmIoTTxvnx5tT0fzFAS/riszbxg3bSf2aatOZw4ZismSZkp3U5xGXPMyn
         RIJLgqKEVG1gNtmFqU9jNru9WCw2da6yhBuEbY8ehun8k+TVE+Cut6mAj49A+2Nu2Lej
         9xNwEIhz1vemvJzsbf3tC9luJm61T8kZ1f7lyfMuJr7vynrxZvGlC3qA+CH4cy0ksvtD
         xaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430071; x=1746034871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR8+QvWrjOg6GeEjmJtzezg7Wu31lEARL9s8Pr8Mnz4=;
        b=W28WrRJ151za2EqXYSgs0sx6iRSXHAIHhfYDnSHQNmct2Cqt2r60YJ6IlZBJ0F/EzH
         NF2AQoWydOe6eTnilF4NP0f1HU1O9cXmfQJT5IhPms3SanIK/uVVGQIiPu+EYZQ8+mhw
         jr6NzMFeaLizWWTz0owXeknSVUjqLyq/c9NHEqLpeVJsmgzfuAb+6ej0I4RiLjpbBVnT
         dnqZ/v11k/qtnneS/ZxLGnYaRBdhsi9y9SNobCPbTVRvaLIIZzUCAc5mWVf/7KM9aGy4
         +tdI3GDf3l8mHpHrxhi05B76bUv0e1W1Q7VC3A+/kp2KjKKDCYVEMRP0Feq/fhdsquLD
         lr1g==
X-Forwarded-Encrypted: i=1; AJvYcCUBVMd333pmZcatXVHOOXrJK+DXGOeSGF6UOnysllH4LYZBNVpSlQux+5XAxafoQKUghcE=@vger.kernel.org, AJvYcCVAoihZgfH/qVy1y+dinXbSIlChrkhgHSlmyFaT0uI+hjHbJuwXM/GAsNGDGoaQtMpGj0sP0HmQWYfDJgvBv1x6y5kL@vger.kernel.org, AJvYcCVML2rJP2yOxpeUk0F6jeDQxJXuIvm/+0RvU0Gfv1wvJhR6dJxbm673sXeXRmlajDJQ0lp3E2VJqcf9trjf@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOCC7DUcTH8IjZH3l/1PGQ90MRxvwVml9eaCu6a9PuWyiz2f3
	u+hagTBTAnwIhn9IOApuN8fHjEHQYZpfzlnYl9Hp6gQ9hn2nEFS107blGxtHdOW9HfZu9V7gNfM
	OsiAey/fH2QR2cornMH8wi4klna8=
X-Gm-Gg: ASbGncvsVhUpg0YO7oOjYifzAk7ioVWY6ea2Yra6setWC/Vs6sAHkkHlLiy9P5IuECM
	yiRjc6BAAadWOUp7cCGWgl1n1h71zZlppMaOjUSEc6ufOjhOSlgw4H9gzm8QqjaJ8MkkR9K5ktC
	a463mTYbN03wwvNTyYZ9QkwCTivoz/APEOxKF6Ig==
X-Google-Smtp-Source: AGHT+IF7SEF8WyzUpBf+fyjUVU0MZA0pXQjAHCtbEd6ShJvWdkBOr/j1CX14JgGPVXRlETGiRmp2MBa6i8GHow1q1Qg=
X-Received: by 2002:a05:6a00:3903:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-73e229bf712mr84824b3a.12.1745430070913; Wed, 23 Apr 2025
 10:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-15-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-15-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:40:58 -0700
X-Gm-Features: ATxdqUHAjf-I_8XVrjPhhMuAQcUQ82CaH4mjwOB661YeAlC4GtbULVflWYnMQUo
Message-ID: <CAEf4BzaK+as2YtN1L6aNT6m6R+iRs_VjOdV7mtDNAvKFdouoEA@mail.gmail.com>
Subject: Re: [PATCH perf/core 14/22] selftests/bpf: Add uprobe/usdt syscall tests
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

On Mon, Apr 21, 2025 at 2:47=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding tests for optimized uprobe/usdt probes.
>
> Checking that we get expected trampoline and attached bpf programs
> get executed properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 278 +++++++++++++++++-
>  .../bpf/progs/uprobe_syscall_executed.c       |  37 +++
>  2 files changed, 314 insertions(+), 1 deletion(-)
>

[...]

>  static void __test_uprobe_syscall(void)
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c =
b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> index 2e1b689ed4fb..7bb4338c3ee2 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/usdt.bpf.h>
>  #include <string.h>
>
>  struct pt_regs regs;
> @@ -9,9 +11,44 @@ char _license[] SEC("license") =3D "GPL";
>
>  int executed =3D 0;
>
> +SEC("uprobe")
> +int BPF_UPROBE(test_uprobe)
> +{

I'd add a PID filter to all of these to guard against potential
unrelated triggerings if in the future there is some parallel test
that attaches to all uprobes or something like that. Better safe than
sorry.

> +       executed++;
> +       return 0;
> +}
> +
> +SEC("uretprobe")
> +int BPF_URETPROBE(test_uretprobe)
> +{
> +       executed++;
> +       return 0;
> +}
> +
> +SEC("uprobe.multi")
> +int test_uprobe_multi(struct pt_regs *ctx)
> +{
> +       executed++;
> +       return 0;
> +}
> +
>  SEC("uretprobe.multi")
>  int test_uretprobe_multi(struct pt_regs *ctx)
>  {
>         executed++;
>         return 0;
>  }
> +
> +SEC("uprobe.session")
> +int test_uprobe_session(struct pt_regs *ctx)
> +{
> +       executed++;
> +       return 0;
> +}
> +
> +SEC("usdt")
> +int test_usdt(struct pt_regs *ctx)
> +{
> +       executed++;
> +       return 0;
> +}
> --
> 2.49.0
>

