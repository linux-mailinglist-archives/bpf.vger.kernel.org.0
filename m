Return-Path: <bpf+bounces-7973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188D577F28F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D9B281DC0
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93422100B3;
	Thu, 17 Aug 2023 08:58:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F3FC0D
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:58:03 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC326A8
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:01 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc8045e09dso49362745ad.0
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262681; x=1692867481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POAewNlD9kdUICg1lGQG3PlYWuMy3Xojp9urFPwdlEk=;
        b=IgrlWgQFkAtt5JGm5sm1FANwumf2xoywP7YxePvWesmAu01lrn4ateZgbevXa4fZ5k
         EOD8zziXJPM8ETA98sHgTAwULT2vUno2nhkVEqf7FbxmCUWCuPDsJYgiIvfWLWqQAJWz
         Lj0Q/6x9hLuvZKNyY31VptHkO39tX1aThlLi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262681; x=1692867481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POAewNlD9kdUICg1lGQG3PlYWuMy3Xojp9urFPwdlEk=;
        b=hNh0TE7oT5eMIXzAB27yeTx1El6Q8KxDW9qb6U4UsoVIZYRXdZhawNn9dVMmXZR4b1
         tM8h/sQA6HhUpjzIliu5F/7I4fnRbc6j9Q+YQF86rzZV7C0iebFAe18bd23ADpFKUI87
         aZpXxVaQr3SAlaZuR1Jnd5Udl6VMGPCBLWzJuz8K4KZLhzpA8XpxTjIjGfu2lf4QOfaw
         aci8pEWFr3glvomPxzlaIznthifX1fXazCO3wuq1nxTxwOcJreJypTDa+nn6MaxViYih
         svE4pmwaRkp/+/gp0XbeT+9vt2CYMYVsgGEPndd8HUYqjhKORWEGX6CyytiiuEi2TOjH
         EZ7g==
X-Gm-Message-State: AOJu0YyuQpBenXtdMc4pLY6wH6BCROBCDEwg9ldviiYgw4LTRWau+ViV
	0gji6AhNxEUXDrmpx1BzqBBReSqCTJYi2xP4p9j1lg==
X-Google-Smtp-Source: AGHT+IGpH+pXAk8VqxIeT35jLyW0KYHgE02yw6vcZz/n1VMizwV6Ew9p2SanWxPrmSf9km59jyqbjyFHsoS+ovVRDwM=
X-Received: by 2002:a17:90a:9bca:b0:268:a26:d9ee with SMTP id
 b10-20020a17090a9bca00b002680a26d9eemr3586278pjw.46.1692262681230; Thu, 17
 Aug 2023 01:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181865486.505132.6447946094827872988.stgit@devnote2>
In-Reply-To: <169181865486.505132.6447946094827872988.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:57:50 +0200
Message-ID: <CABRcYm+ayJwS+YMaKBF9pdnHYcJvioOoOrXHWOeRAg1hPacYiA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d56304276318..6fb4ecf8767d 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -679,7 +679,6 @@ config FPROBE_EVENTS
>         select TRACING
>         select PROBE_EVENTS
>         select DYNAMIC_EVENTS
> -       depends on DYNAMIC_FTRACE_WITH_REGS

I believe that, in practice, fprobe events still rely on WITH_REGS:

> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index f440c97e050f..94c01dc061ec 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -327,14 +328,15 @@ static int fentry_dispatcher(struct fprobe *fp, uns=
igned long entry_ip,
>         struct pt_regs *regs =3D ftrace_get_regs(fregs);

Because here you require the entry handler needs ftrace_regs that are
full pt_regs.

>         int ret =3D 0;
>
> +       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> +               fentry_trace_func(tf, entry_ip, fregs);
> +
> +#ifdef CONFIG_PERF_EVENTS
>         if (!regs)
>                 return 0;
>
> -       if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> -               fentry_trace_func(tf, entry_ip, regs);
> -#ifdef CONFIG_PERF_EVENTS
>         if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> -               ret =3D fentry_perf_func(tf, entry_ip, regs);
> +               ret =3D fentry_perf_func(tf, entry_ip, fregs, regs);
>  #endif
>         return ret;
>  }
> @@ -347,14 +349,15 @@ static void fexit_dispatcher(struct fprobe *fp, uns=
igned long entry_ip,
>         struct trace_fprobe *tf =3D container_of(fp, struct trace_fprobe,=
 fp);
>         struct pt_regs *regs =3D ftrace_get_regs(fregs);

And same here with the return handler

I think fprobe events would need the same sort of refactoring as
kprobe_multi bpf: using ftrace_partial_regs so they work on build
!WITH_REGS.

