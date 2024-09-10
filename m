Return-Path: <bpf+bounces-39548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E112B9745F7
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 00:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B951C218EF
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67551ABED0;
	Tue, 10 Sep 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx+/qlr0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6CA1A3BAF
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007271; cv=none; b=Z0HW4ajefngnihlyHnU0HhBajQVAczIoysF8pgB8bpSsSV8xpkzFDj7GLh/eVZe9eopdAbcw/zLoMdCuZBLslNR4hOeo9GckS/zOkGtIjSKHvnrpes4cfsk2Bysgpw7jXZTHJF6lRhmDG71FhKKq9dVdSZegCfqj9beOsXGKYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007271; c=relaxed/simple;
	bh=rtl5lz75g//6GZz2E/qYpcRAAJWHtEV0sk/MVqhSUGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpfm4fzn6rqVhf4mQBM7O0XfpEc+erniedEve8rOUbFWBmnFz8fiUzagd0BG3se57Pknwu3alRAz1sbH1R7Dc+A9L5VDusg0sF1Oyzt+2fuQCzDqeKheyig6ke8orDWt1oH3u8JIC1EXKkhMcFUx7bSc2FrcVizwJVn2LUw4Rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx+/qlr0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d892997913so3986202a91.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726007269; x=1726612069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyrPouafs4ttfN/YM/aNJX43UazVE3fubGWh0jcGbps=;
        b=Zx+/qlr0OWOBne2x/TCLMMOxbiF7bKVC3AUNzLiXf7VZ5MWHbfUukUArvleOvbMPsv
         LypJjJEfVUiuQ1Y/ajG9jEugctJK45TKgIsj5zOwpiJ3byPX+Q4cyOVmX+Q/07/zs7jR
         hwHu5jpV0cchZAdOJiUqVsHqm8I7BRfxZWUCrDsaCX8fjhUVf6HoydGBDzUHhQpQs4ka
         Qp+4OGXHpO+Oi6BJD3LNfxHuoHY9iMSqBPX1HjwPK04Yta494TJdgsRTdaqP4tdXo8pE
         h3XB98YkRJA/pwNwfRZJXWG7kRyLcTOjVqq0+6jG22mXYVb90VCEB4MuIiJ+Cg5BcBpu
         63Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726007269; x=1726612069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyrPouafs4ttfN/YM/aNJX43UazVE3fubGWh0jcGbps=;
        b=Av7x6hbqiAnY70Dooj4uW2Eywo8sXL1vGJ8sKvyogKRePWqWUvzTQzqs2a5ZuqrHb2
         eXidUtpe+YpvfkXJTiICC8UHdn+yYbXTiW1Qy99Os2fpKuK2RhDNfgn/ctHinWCPG0IH
         pG2ZIWilrBEFE77ZEreP7cX501tp/XSyt229eGBfEiegyPdKqD3bzggY6AqEYBUP/bbO
         3sx3MCYKFR5FE30XeE4DB9X3+fPrr8QVj9cpN4PKPu4HWJMb4nKtciZ9oLPH+Rg6X58M
         cOnNi2k/CV64pK3iQP6TizkvBRDfULkK9SVkpnZ7uHViGhIS8A/Bjkzr7JTwWlXvGMwe
         0gCQ==
X-Gm-Message-State: AOJu0YyEK8eZOEeuYb3tQLn1LP770YIvE3S//Ob80vj1xazo4uz4Bnib
	RgQ4aS7T5Ak1nWB0y+Y7xQAmuDmuOgG/wKANKeS+9OLsIZi656T0iPfBDY4WypbjS+a9TsGQlb7
	2hB8OalOejp0dPPJP3qx5f87FUfo=
X-Google-Smtp-Source: AGHT+IEmMSx0LMrXI5Zibf9fdZ9/BBcnNLKlYSn+m+ed3IN6a+cDBrURPiNyOGC1ND8c3JKh5mLtyps195YP4ATtkCw=
X-Received: by 2002:a17:90b:38cc:b0:2d1:ca16:5555 with SMTP id
 98e67ed59e1d1-2dad50f9e56mr19893161a91.37.1726007269131; Tue, 10 Sep 2024
 15:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910214037.3663272-1-yonghong.song@linux.dev>
In-Reply-To: <20240910214037.3663272-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 15:27:35 -0700
Message-ID: <CAEf4BzbTTx1sCAbMd17rdcLtu4pVHTaJvHdscA3SU+uEJzDAJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Use fake pt_regs when doing bpf syscall
 tracepoint tracing
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Salvatore Benedetto <salvabenedetto@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:40=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Salvatore Benedetto reported an issue that when doing syscall tracepoint
> tracing the kernel stack is empty. For example, using the following
> command line
>   bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel Stack\n=
"); print(kstack()); }'
>   bpftrace -e 'tracepoint:syscalls:sys_exit_read { print("Kernel Stack\n"=
); print(kstack()); }'
> the output for both commands is
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
> To fix the issue, kernel address from pt_regs is required.
> In kernel repo, there are already a few cases like this. For example,
> in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_regs_ptr=
)
> instances are used to supply ip address or use ip address to construct
> call stack.
>
> Instead of allocate fake_regs in the stack which may consume
> a lot of bytes, the function perf_trace_buf_alloc() in
> perf_syscall_{enter, exit}() is leveraged to create fake_regs,
> which will be passed to perf_call_bpf_{enter,exit}().
>
> For the above bpftrace script, I got the following output with this patch=
:
> for tracepoint:syscalls:sys_enter_read
> =3D=3D=3D
>   Kernel Stack
>
>         syscall_trace_enter+407
>         syscall_trace_enter+407
>         do_syscall_64+74
>         entry_SYSCALL_64_after_hwframe+75
> =3D=3D=3D
> and for tracepoint:syscalls:sys_exit_read
> =3D=3D=3D
> Kernel Stack
>
>         syscall_exit_work+185
>         syscall_exit_work+185

this duplication is unfortunate, but we have the same with non-syscall
tracepoint, so it's not really a new "issue"

>         syscall_exit_to_user_mode+305
>         do_syscall_64+118
>         entry_SYSCALL_64_after_hwframe+75
> =3D=3D=3D
>
> Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/trace/trace_syscalls.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>

Looks great, thank you!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
> index 9c581d6da843..785733245ead 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -564,6 +564,7 @@ static int perf_call_bpf_enter(struct trace_event_cal=
l *call, struct pt_regs *re
>         BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
>
>         /* bpf prog requires 'regs' to be the first member in the ctx (a.=
k.a. &param) */
> +       perf_fetch_caller_regs(regs);
>         *(struct pt_regs **)&param =3D regs;
>         param.syscall_nr =3D rec->nr;
>         for (i =3D 0; i < sys_data->nb_args; i++)
> @@ -575,6 +576,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
>  {
>         struct syscall_metadata *sys_data;
>         struct syscall_trace_enter *rec;
> +       struct pt_regs *fake_regs;
>         struct hlist_head *head;
>         unsigned long args[6];
>         bool valid_prog_array;
> @@ -602,7 +604,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
>         size =3D ALIGN(size + sizeof(u32), sizeof(u64));
>         size -=3D sizeof(u32);
>
> -       rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
> +       rec =3D perf_trace_buf_alloc(size, &fake_regs, &rctx);
>         if (!rec)
>                 return;
>
> @@ -611,7 +613,7 @@ static void perf_syscall_enter(void *ignore, struct p=
t_regs *regs, long id)
>         memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_arg=
s);
>
>         if ((valid_prog_array &&
> -            !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, =
rec)) ||
> +            !perf_call_bpf_enter(sys_data->enter_event, fake_regs, sys_d=
ata, rec)) ||
>             hlist_empty(head)) {
>                 perf_swevent_put_recursion_context(rctx);
>                 return;
> @@ -666,6 +668,7 @@ static int perf_call_bpf_exit(struct trace_event_call=
 *call, struct pt_regs *reg
>         } __aligned(8) param;
>
>         /* bpf prog requires 'regs' to be the first member in the ctx (a.=
k.a. &param) */
> +       perf_fetch_caller_regs(regs);
>         *(struct pt_regs **)&param =3D regs;
>         param.syscall_nr =3D rec->nr;
>         param.ret =3D rec->ret;
> @@ -676,6 +679,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
>  {
>         struct syscall_metadata *sys_data;
>         struct syscall_trace_exit *rec;
> +       struct pt_regs *fake_regs;
>         struct hlist_head *head;
>         bool valid_prog_array;
>         int syscall_nr;
> @@ -701,7 +705,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
>         size =3D ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
>         size -=3D sizeof(u32);
>
> -       rec =3D perf_trace_buf_alloc(size, NULL, &rctx);
> +       rec =3D perf_trace_buf_alloc(size, &fake_regs, &rctx);
>         if (!rec)
>                 return;
>
> @@ -709,7 +713,7 @@ static void perf_syscall_exit(void *ignore, struct pt=
_regs *regs, long ret)
>         rec->ret =3D syscall_get_return_value(current, regs);
>
>         if ((valid_prog_array &&
> -            !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
> +            !perf_call_bpf_exit(sys_data->exit_event, fake_regs, rec)) |=
|
>             hlist_empty(head)) {
>                 perf_swevent_put_recursion_context(rctx);
>                 return;
> --
> 2.43.5
>

