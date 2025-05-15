Return-Path: <bpf+bounces-58336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0511AB8DAF
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD9F3BC9C8
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B6259C83;
	Thu, 15 May 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnJ2YdJI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E21487ED;
	Thu, 15 May 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329896; cv=none; b=P+/EE13yygrKAelAA+FIlJru7nXQA/lBWNJboBuCShFwGC9YJ/km34apCeXaIT/8Jt2ycZF5x4fI0eg0REIdeSthfyIxWUGAid5/f+jofgSsY+UBMvdwFXymB50Ld7U5Wvc+0+G25kQ6srFHmy+T0RojiIdHdROxPmy0FSsxZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329896; c=relaxed/simple;
	bh=M3ZsFAYo8MhFQNaH2XWvMAfHv5KD/Sq78+TaOqLDLFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJrw8iF6cGjvPRx0HyuqX0DcsEsqEqsZ7Oeq+XU0Ia1YTuD/K28wxSGlkF0J+/O9DlqVzJJZuS/cF3Q1FCqMNpSG2ILRrtrsFnPbWORvTHYxdfgfJMFHHe+jeD2hGMC70eokWtlOZ+Qw025vQQfHBdpNNH2tLjJM1RJwm8mwpZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnJ2YdJI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30c54b40112so1040181a91.2;
        Thu, 15 May 2025 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747329895; x=1747934695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igmbESvSWz0cYKt/OqUk5DHc8SxwNxhWF9HAhv+GUVY=;
        b=DnJ2YdJIddSlPWFQ6ozdDaXIkY81S1y5xY7i5GkANGjMpeJB6aIaG+eMneHf0KcvtO
         pN6xQona+MWkG51b/AcahO1BSlE6LXFP08zZfZ984/C/IO6zzz1A8IhYY7YmC9Rb+6DB
         a09JSwdYksE0Lrg2QQmW2jXJKt76IdYFpYLcTuAqiza/96FV1rMpnR160c5q38MpASWL
         lf2SY06LMVXzTHrPKmTQgtdhZ5rv6SrHF2CIbsJbdgZVxOxNMuUT8IzNENn5sSXK40Kk
         /WFpN1Z9O0HWSPQ1M3YNsN6wH7VS5RGpjpp27z3cEStilJqPui1wp+Vd75l/KgoaMaIe
         /YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747329895; x=1747934695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igmbESvSWz0cYKt/OqUk5DHc8SxwNxhWF9HAhv+GUVY=;
        b=MjN1jZCLat3OIHGD01cFb/qiGCBzNWZv2lTS4xe29wyHFiQmvE28GUrhPuJPxFE1G/
         IHm3YeDSVEBzFFCwt3g/Z4vA8ZNYhTQrZ2iUA4Q59qMcLiZCR5D8oqSLxKMNzZZ3pwh9
         wCwXkElDLHQWQy+/Un72KHT6XpJqG2mIS57EOmNLKBi/2zURInamVtuUCsiKVRJx+Pec
         Ue4qJSigkDsOnSmYWHKSodGuABSl+tBm3f4pzOQx/3+3MyeLUVisbHnjN2Oh9tXQEkq7
         8/FUzsyXPuqKEHyvkWGhbbDNXKdFI608NG0N3DCWDTDJawStrldOvYV/5ff3+Y8l0q1F
         k09Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBeHEuMZfIj/Zs7ThnAYL8rkJaIDYW9sBFbc0NpsJmdtNhD8+v8jy2z7K1Ro9ZNYuKbk3unNBb8RuqrqY6ZaDL40NZ@vger.kernel.org, AJvYcCXsXZyXxbMIX3abIhg4NVszID7IaEnM+C7xPqhmgbK8pagliAOFS88Hlo/HVRs81zSPaT+gqReZrBfZ63gM@vger.kernel.org, AJvYcCXzf9yPJNWUkJrjf7uJRtUqQ5BHc4m/gbM0gmbNEYHUZ3IDA8ts2TFd0gKz1MFR3LV8S9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaxe9YQitwJ8cqgQf9xV7rG4jxIiBHKLUsHfzSCwnakKEXxeg1
	qYp28kivDOyhGWCDbrsgulJ1JvQ9VTL9shDnLv/S9cKhhqmI0GmJbptZYJANr8IvkWTdpV37K9/
	xzFJSdoH7Q8PfWA7PwI/lOuvJIvCUOww=
X-Gm-Gg: ASbGncsFqmZH206farTd4rjlLGjSDxk9F6zCkSiHuSNWUe46U3cy9YOZOxG4x4U/u0c
	L5kQwi631Gc+8M4vXRnIG7l090W2dKabvSDWb7MZ2G2ivs7g9UQnpFYDsXs9ply3PN9oHvc7drc
	kOGkbIHXFI3/dKwnXXdhw7OE2+FG7GQ0uuaKoAHP/vsrmh92Wz
X-Google-Smtp-Source: AGHT+IFusYz1noTbECUuIh/Be3orN9zbflzTKg6uthrWJkmyLS16uFAXX14WD727WquN20xvgJSbOCxI/tw3xDOK6Pg=
X-Received: by 2002:a17:90b:2b90:b0:30c:4a09:d1c0 with SMTP id
 98e67ed59e1d1-30e7d5be356mr297114a91.33.1747329894574; Thu, 15 May 2025
 10:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515121121.2332905-1-jolsa@kernel.org> <20250515121121.2332905-14-jolsa@kernel.org>
In-Reply-To: <20250515121121.2332905-14-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 10:24:42 -0700
X-Gm-Features: AX0GCFtJU3H8MnZ95Tdl2dkGmPse2VAu0nh1QT27G57wNgd7_kd-kViKRiWLVIw
Message-ID: <CAEf4BzZ4975boVLbDXhVkjbiY_gp=RTTzJZ9zhfXc0zrgs4obw@mail.gmail.com>
Subject: Re: [PATCHv2 perf/core 13/22] selftests/bpf: Rename
 uprobe_syscall_executed prog to test_uretprobe_multi
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

On Thu, May 15, 2025 at 5:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Renaming uprobe_syscall_executed prog to test_uretprobe_multi
> to fit properly in the following changes that add more programs.
>
> Plus adding pid filter and increasing executed variable.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c       | 12 ++++++++----
>  .../selftests/bpf/progs/uprobe_syscall_executed.c   | 13 ++++++++++---
>  2 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 2b00f16406c8..1cce50b5d18c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -252,6 +252,7 @@ static void test_uretprobe_syscall_call(void)
>         );
>         struct uprobe_syscall_executed *skel;
>         int pid, status, err, go[2], c;
> +       struct bpf_link *link;
>
>         if (!ASSERT_OK(pipe(go), "pipe"))
>                 return;
> @@ -277,11 +278,14 @@ static void test_uretprobe_syscall_call(void)
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
> +       skel->bss->pid =3D pid;
> +
> +       link =3D bpf_program__attach_uprobe_multi(skel->progs.test_uretpr=
obe_multi,
> +                                               pid, "/proc/self/exe",
> +                                               "uretprobe_syscall_call",=
 &opts);
> +       if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
>                 goto cleanup;
> +       skel->links.test_uretprobe_multi =3D link;
>
>         /* kick the child */
>         write(go[1], &c, 1);
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c =
b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> index 0d7f1a7db2e2..c4c3447378ba 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> @@ -8,10 +8,17 @@ struct pt_regs regs;
>  char _license[] SEC("license") =3D "GPL";
>
>  int executed =3D 0;
> +int pid;
>
> -SEC("uretprobe.multi")
> -int test(struct pt_regs *regs)
> +static int inc_executed(void)
>  {
> -       executed =3D 1;
> +       if (bpf_get_current_pid_tgid() >> 32 =3D=3D pid)
> +               executed++;

it's customary (and makes sense to me) with filtering like this to not
add nestedness:


if (bpf_get_current_pid_tgid() >> 32 !=3D pid)
    return 0;

executed +=3D 1;
return 0;

>         return 0;
>  }
> +
> +SEC("uretprobe.multi")
> +int test_uretprobe_multi(struct pt_regs *ctx)
> +{
> +       return inc_executed();
> +}
> --
> 2.49.0
>

