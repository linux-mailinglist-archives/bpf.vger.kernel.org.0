Return-Path: <bpf+bounces-56520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB0A996CC
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA533921749
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3828CF68;
	Wed, 23 Apr 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjv2Ujpn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B24228A1FA;
	Wed, 23 Apr 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429798; cv=none; b=AhqvDrvX6tfZSB4hC5JVB8T++il+34Z+iQST3GOWTVTpZmHc9LM4CybsynUkVcWunZd/jXaOAOAoAwNYH4pHrLedqK8Y2nb5vYIHGoXrMyQ+qMYg/0tmaVJTYu8CCkjyvrTxNIRshr34GUQ/TJqL78s1RjqlFq7RqKvCQNgZUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429798; c=relaxed/simple;
	bh=jy+ZRKVNRiujeGKF8YIwesyEdV3DOe9oDzkNAMKTV/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccrKdDqXGhMCcMXPe8mw/T2U4WCoFek120Uh7pBfifXFIed6r5+Igvk8Pi/2rivho173/sNthp6qp23awc4mq12Ap4UpX/PWGGQJkESvGeOjKRbCjiSa7S1mGbrKG0twsOLJ3nGxKBZUTsCj1v4x+/SYGvpdxyi5XYFdFKEQ1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjv2Ujpn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af50f56b862so28029a12.1;
        Wed, 23 Apr 2025 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745429797; x=1746034597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YymHYKdRssVDIPxOqRIXyV6k16xbhfnv2bMsDvOlCdY=;
        b=Sjv2UjpnLMRi//STcbvxTvz3moh4A6zhtCBIq9MKrofYfN/R6Zc0DzKHcB+my3KSg+
         vr9g3SB+XGinoaVnIuPDSMjkz7VDTTcXhJohp/eUE0ATdXxKLm4lqb4/lIAlvsygGK4Y
         P3ZSHFcLteWE5d2wvHXAHk2hHde5XZ7ZNZ4zH8Upq8PHaOTWlYSyMG3JbG04HVQKS9ZH
         Bu1UqlY/KjgvlAaPimqU50s9zeC3HzyQ6mj8X1yRJqiQtV74yBQREFZnwJaHFuSJEd6D
         QUT/hpWWY1Pz7U1wBMIryUNCs78Ft/oMqmIZd5zrONPkT9b7Ve7vehu8FxWCJIhQ9Xx/
         DP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429797; x=1746034597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YymHYKdRssVDIPxOqRIXyV6k16xbhfnv2bMsDvOlCdY=;
        b=GaSTSI6cCgokI0swnjHdfMBFHKgrdU+LNVt6bX9wRuFBKRxXm3pzvTiaEVVNuOCDCO
         KDduBMHp9Byw8Fq5hYCol3AdnR/EeuN3yi/dEXUEzEOj0dd6YTO3Fog6qs7DXWgWkd/j
         R+mJoepIsCm9PNd0rVbOeFv8y/nB8FhtPnEY1TWabC0o/lG/dkJEgF6n/qJ0+ynfJi0v
         /1xHEgRjga1PwsH/IjEl6N1us+TcgjkpSiFM4ijzMd4xO9lMY4k5gntHYI01HkdnR560
         INPWB5PibRFRbZEmT5A4G6nm8CnZDqVX9HKTN9K8STj5CT5uJFbvxoWjE8Wh5ehJKXZ+
         SZfg==
X-Forwarded-Encrypted: i=1; AJvYcCUPUPn2a4Rvda4/53ELLxqicZAB+46dbH3yqRYO1QRaHjy0u4KoDvF4j7eXn+lpEBKmdcfkkZYh8MmdJsORD38+DtPx@vger.kernel.org, AJvYcCVjS+WJOroy2XsGCJr38gqccZiZszChRwIQHNhaV/IFuvuLj4XQ7+/fsw8dr6qL2cQNGEc=@vger.kernel.org, AJvYcCWfD6BGpnH+FtF1siUWEqv/vi8oo/j/YXuA9PZC0aWGzffOaqcl04dxA5H6m/X1uhuMR2ckfHcgD6KybDTV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1omGXujdoxSGVEYHjUWkk9WR3MD49aLNKJZYbZNz6huWvwfJD
	5tecp5udEI5eEzMutvMTiFMwn29KMMS+AtNpJ3mJ1+KqSnAQwHB1T/MboqWlu1a+uq6yDGOOWuc
	AXyyriP5a2wyHYX2yYwBXo4p5U5s=
X-Gm-Gg: ASbGncvHD8co6UVYig/RuXlcVWgL7iJtCTp51CoAeBYOEz3lfE88RQPDRSvl4foHJPa
	fZelkwjevDRg+oS8vj5CLfTluJyVstWWXw+GnjvXsjvVus3Wm1QTtouvtD/O6xcVYLcSYwdouUI
	xYjZT541PzDkojs2zfeRRNokYO0/BhtS0Ro5Rbwg==
X-Google-Smtp-Source: AGHT+IEi18m5O4uQoO1eHpBP62ScrettsV16PQvj6E28PxxVmqpqhRYFr9D1umr9k3JnRX+6tHhktH78VQXj5O3OwAw=
X-Received: by 2002:a17:90b:270d:b0:2ff:5357:1c7e with SMTP id
 98e67ed59e1d1-3087bb6954amr28384399a91.20.1745429796711; Wed, 23 Apr 2025
 10:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421214423.393661-1-jolsa@kernel.org> <20250421214423.393661-14-jolsa@kernel.org>
In-Reply-To: <20250421214423.393661-14-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 10:36:22 -0700
X-Gm-Features: ATxdqUEHGfNBKiuTHJ2_OrkYqvRSsVc8Vn-z9IgFkBNOkXsf9a7h8Z9OT-bwm8k
Message-ID: <CAEf4BzaseiF10Ady4FCCx=ii+es9vkcbRYLBkdaDRZ_tH8NzdQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 13/22] selftests/bpf: Rename uprobe_syscall_executed
 prog to test_uretprobe_multi
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
> Renaming uprobe_syscall_executed prog to test_uretprobe_multi
> to fit properly in the following changes that add more programs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c   | 8 ++++----
>  .../testing/selftests/bpf/progs/uprobe_syscall_executed.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 2b00f16406c8..3c74a079e6d9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -277,10 +277,10 @@ static void test_uretprobe_syscall_call(void)
>                 _exit(0);
>         }
>
> -       skel->links.test =3D bpf_program__attach_uprobe_multi(skel->progs=
.test, pid,
> -                                                           "/proc/self/e=
xe",
> -                                                           "uretprobe_sy=
scall_call", &opts);
> -       if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_=
multi"))
> +       skel->links.test_uretprobe_multi =3D bpf_program__attach_uprobe_m=
ulti(skel->progs.test_uretprobe_multi,

this is a bit long, maybe

struct bpf_link *link;

link =3D bpf_program__attach...
skel->links.test_uretprobe_multi =3D link;

?

But other than that

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> +                                                       pid, "/proc/self/=
exe",
> +                                                       "uretprobe_syscal=
l_call", &opts);
> +       if (!ASSERT_OK_PTR(skel->links.test_uretprobe_multi, "bpf_program=
__attach_uprobe_multi"))
>                 goto cleanup;
>
>         /* kick the child */
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c =
b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> index 0d7f1a7db2e2..2e1b689ed4fb 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> @@ -10,8 +10,8 @@ char _license[] SEC("license") =3D "GPL";
>  int executed =3D 0;
>
>  SEC("uretprobe.multi")
> -int test(struct pt_regs *regs)
> +int test_uretprobe_multi(struct pt_regs *ctx)
>  {
> -       executed =3D 1;
> +       executed++;
>         return 0;
>  }
> --
> 2.49.0
>

