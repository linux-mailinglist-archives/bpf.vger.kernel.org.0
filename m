Return-Path: <bpf+bounces-39401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216369728EA
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469A51C23C90
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 05:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F40168488;
	Tue, 10 Sep 2024 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXSLNlz0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEC38DD3
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946494; cv=none; b=KeNW5Gw+/GXpnAJRLcK4Ylpcs6MLTprH1sGWmbFH4YJwasZhG7IAo8E7i8Xh2bpb9SczOdpkXrjSvntriWDb9lSy4bYYVlwjIaIJHss3gQI9KDRUu0yhUtwbdCaucxjHEhFG4MilbVwMlNAUnvk6szG/cinZ2m++QQYtMLQyzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946494; c=relaxed/simple;
	bh=howereNxlkBVEnKWe/QkDJ3amw/e/HMhNX/4JKdnjUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cT7RoZL1LUG4dB18eD24mjvxXPAd/cZrs6dnSvpNfRek4gcul8bth0LcFEIrWmkJQPQK5D8FAcYL8BGHooKeznUR+AeNBDthR2I6VlOzmgFfAc5Ht2ysbG4z7nmOVv56d6VsbiZmrYBwrBMZBjy2OZZZ7vM0n2evG1SzvEP7hgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXSLNlz0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20688fbaeafso51146715ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 22:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725946492; x=1726551292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhTUjTD86TCrmLO5C7uW2hV/MRzN3xQr2+GboTKWvIA=;
        b=RXSLNlz0QYQRChmmqlkBrbToJ46TdQlEnNwZX5h6KItv7IYWKpdGX4kfYRlprnpPrb
         Oyud6Br7gXRDXmKY9uGe3K/T8ZtZtyIVQgKbjIPz2KGoZrRKKR0dkOhuh3PxHnSOrrs4
         RTxl4YHAepJJyIduCHnb6Skx9fjgXf0xIIZ5pd/NMMsolZYP1LfBPG3rf1RLp5d6dHpb
         uCkhNkND4jIY/lSvlFDjn7+8Ad2YbcfoQ7zBNZlRYU8brSGWiYzcKOMWka+xmYiva5og
         JasY5H3wjEtw6RwVPxjXJ/DUOwNqB2lCLYJT9+fxF+UM8YAZppZ6wceg1H+TKrAI7AJA
         YBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725946492; x=1726551292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhTUjTD86TCrmLO5C7uW2hV/MRzN3xQr2+GboTKWvIA=;
        b=QjklF2Opp+xJAQjsrYe5tdwPMuLxGcuLq9QrZ7LAJfdJ8R6jWD6w5i/704I8os80GG
         7w8GJl0dCjWf2sI2Z0TLSmNdVFveC0WKIzijKN1b1IsEU87o/bLwJ5Q/tB/7KacJ8cuG
         gYlCz5EEaTtOCn+7ReySF12q8wEsZcj7s16qA8c8ZjZArPGQvhdV0ziVSOLF12BlzKH9
         O8Q5uRkb7urqY305yMKuruwONhMGpsw8XaWTS0jNcVftHcKehTZv7K50DN3KoGINUJoB
         eWsTEOiNUCTttj386HwfaVQht0pJ4HRfHoFhAe5Hq1E3qGLldzoCdHdeuKvcSEoUGYEE
         t2Vw==
X-Gm-Message-State: AOJu0YzHf13vpwqTR/oUonzjICZzde7zSQ2l8F2WIttQoxLX//irqWrb
	SFs6yAf1FM3ZDs/8/ZMi2sk02aB9mihC8W0fMcUs1bU97y0tSYeO2TpTAP6QdRxyS3Mr+6cN9Qi
	0s8zlv57iWPSrb/uSo5E4BG5/v+Puueg9
X-Google-Smtp-Source: AGHT+IHoxrUzdsSF/89pmfjDLynoo+82Fh/dIyxFneRrVPYnek9+8bEcDyPnNVTFyehiKnwm95yJEJ3ZGLHWT263jaw=
X-Received: by 2002:a17:902:c401:b0:207:16b9:808c with SMTP id
 d9443c01a7336-20716b98155mr128893035ad.1.1725946491582; Mon, 09 Sep 2024
 22:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910034306.3122378-1-yonghong.song@linux.dev>
In-Reply-To: <20240910034306.3122378-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 22:34:39 -0700
Message-ID: <CAEf4BzbsYn-b7YiKZ0MPW9_VLzDq38Jv8UkocfMLVje_SAmENA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use fake pt_regs when doing bpf syscall
 tracepoint tracing
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Salvatore Benedetto <salvabenedetto@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:43=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Salvatore Benedetto reported an issue that when doing syscall tracepoint
> tracing the kernel stack is empty. For example, using the following
> command line
>   bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel Stack\n=
"); print(kstack()); }'
> the output will be
> =3D=3D=3D
>   Kernel Stack
> =3D=3D=3D
>
> Further analysis shows that pt_regs used for bpf syscall tracepoint
> tracing is from the one constructed during user->kernel transition.
> The call stack looks like
>   perf_syscall_enter+0x88/0x7c0
>   trace_sys_enter+0x41/0x80
>   syscall_trace_enter+0x100/0x160
>   do_syscall_64+0x38/0xf0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The ip address stored in pt_regs is from user space hence no kernel
> stack is printed.
>
> To fix the issue, we need to use kernel address from pt_regs.
> In kernel repo, there are already a few cases like this. For example,
> in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_regs_ptr=
)
> instances are used to supply ip address or use ip address to construct
> call stack.
>
> The patch follows the above example by using a fake pt_regs.
> The pt_regs is stored in local stack since the syscall tracepoint
> tracing is in process context and there are no possibility that
> different concurrent syscall tracepoint tracing could mess up with each
> other. This is similar to a perf_fetch_caller_regs() use case in
> kernel/trace/trace_event_perf.c with function perf_ftrace_function_call()
> where a local pt_regs is used.
>
> With this patch, for the above bpftrace script, I got the following outpu=
t
> =3D=3D=3D
>   Kernel Stack
>
>         syscall_trace_enter+407
>         syscall_trace_enter+407
>         do_syscall_64+74
>         entry_SYSCALL_64_after_hwframe+75
> =3D=3D=3D
>
> Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/trace/trace_syscalls.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Note, we need to solve the same for perf_call_bpf_exit().

pw-bot: cr

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
> index 9c581d6da843..063f51952d49 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -559,12 +559,15 @@ static int perf_call_bpf_enter(struct trace_event_c=
all *call, struct pt_regs *re

let's also drop struct pt_regs * argument into
perf_call_bpf_{enter,exit}(), they are not actually used anymore

>                 int syscall_nr;
>                 unsigned long args[SYSCALL_DEFINE_MAXARGS];
>         } __aligned(8) param;
> +       struct pt_regs fake_regs;
>         int i;
>
>         BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
>
>         /* bpf prog requires 'regs' to be the first member in the ctx (a.=
k.a. &param) */
> -       *(struct pt_regs **)&param =3D regs;
> +       memset(&fake_regs, 0, sizeof(fake_regs));

sizeof(struct pt_regs) =3D=3D 168 on x86-64, and on arm64 it's a whopping
336 bytes, so these memset(0) calls are not free for sure.

But we don't need to do this unnecessary work all the time.

I initially was going to suggest to use get_bpf_raw_tp_regs() from
kernel/trace/bpf_trace.c to get a temporary pt_regs that was already
memset(0) and used to initialize these minimal "fake regs".

But, it turns out we don't need to do even that. Note
perf_trace_buf_alloc(), it has `struct pt_regs **` second argument,
and if you pass a valid pointer there, it will return "fake regs"
struct to be used. We already use that functionality in
perf_trace_##call in include/trace/perf.h (i.e., non-syscall
tracepoints), so this seems to be a perfect fit.

> +       perf_fetch_caller_regs(&fake_regs);
> +       *(struct pt_regs **)&param =3D &fake_regs;
>         param.syscall_nr =3D rec->nr;
>         for (i =3D 0; i < sys_data->nb_args; i++)
>                 param.args[i] =3D rec->args[i];
> --
> 2.43.5
>

