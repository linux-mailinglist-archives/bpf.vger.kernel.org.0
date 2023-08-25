Return-Path: <bpf+bounces-8643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7EB788D01
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE451C210DE
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486EE17746;
	Fri, 25 Aug 2023 16:12:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53E2571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:12:20 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007E1A6
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:18 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6bdcbde9676so841270a34.3
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979938; x=1693584738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLYb7dk0Mo8WnWmqBezYv61uZFgkXIPXZsPRzuku1AI=;
        b=QHPSipObj5KC8KPQ/5D9ZRw8LL6Qwm0JBTdxCotR+Hrpi4R7Ql1vOlghJ5Jen5a7Qz
         Pytcs/AksBzm/jrVuHdPhlmmfRs2hDVhBGxxJMhKabhACAo3sKNtBCncVYKeDzZF2rhZ
         Rf6CICb5wAY2CJw9YHgfyZsh86vHGlAorMC1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979938; x=1693584738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLYb7dk0Mo8WnWmqBezYv61uZFgkXIPXZsPRzuku1AI=;
        b=eU5ryC/kt9nu3mC5HnCUdEqReFZIt0Jtf/RtpszPhoQSx8QNnUDd+Zvai+MxqyAMmD
         4SkaCLH0gXcZg6aoCAJUDrZskQxRIcUOC1ZJodTj0rX2V/0qb4s8tV3mL6+Mtkqa8ZA9
         wmEPdQYLnsh+SV2UY78an6JbVDbeqrDeg/riFNzIqllBmrnK2yeeuJVd+DqrwkDauDXs
         xNm1LeqNHMSYdGYRprIaEjmZLS495+xMj4diM6Xb710tF5qmVd68Wekqs0AYa9YyMNxr
         9apzptFcbkM6JRm8FQ2LwyeE44bJINu0EogzqQjDmYHST7EjKRDUZCZx323bQGZQIkKe
         Tocg==
X-Gm-Message-State: AOJu0YzIGhr3ufU9D87d+ziC7NNL+g0TBclBv2KqnvlNY9GVQwu3qaDb
	1XvSAsA5nvUBcUE2BNNuS3wENK1aB1CO/iCvCahoow==
X-Google-Smtp-Source: AGHT+IH7rA4FZ/vJJkFxdDjuptllVaIjkNT1EtAAkwmLRfa9YBWXLp4oEqPt6Sfo7C+nW93YB3rhifY2GGNe3pH/kbs=
X-Received: by 2002:a05:6870:702b:b0:1c8:bae6:527d with SMTP id
 u43-20020a056870702b00b001c8bae6527dmr3545278oae.55.1692979938319; Fri, 25
 Aug 2023 09:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280379741.282662.12221517584561036597.stgit@devnote2>
In-Reply-To: <169280379741.282662.12221517584561036597.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Fri, 25 Aug 2023 18:12:07 +0200
Message-ID: <CABRcYmLcTBey7QY9Ln3aVvJPV7weeTR0FA6DOU3_QObuAM8_Zg@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 5:16=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index c60d0d9f1a95..90ad28260a9f 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> +#else /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_HAVE_PT_REGS_TO=
_FTRACE_REGS_CAST */
> +
> +/* Since fprobe handlers can be nested, pt_regs buffer need to be a stac=
k */
> +#define PERF_FPROBE_REGS_MAX   4
> +
> +struct pt_regs_stack {
> +       struct pt_regs regs[PERF_FPROBE_REGS_MAX];
> +       int idx;
> +};
> +
> +static DEFINE_PER_CPU(struct pt_regs_stack, perf_fprobe_regs);
> +
> +static __always_inline
> +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> +{
> +       struct pt_regs_stack *stack =3D this_cpu_ptr(&perf_fprobe_regs);
> +       struct pt_regs *regs;
> +
> +       if (stack->idx < PERF_FPROBE_REGS_MAX) {
> +               regs =3D stack->regs[stack->idx++];

This is missing an &:
regs =3D &stack->regs[stack->idx++];

> +               return ftrace_partial_regs(fregs, regs);

I think this is incorrect on arm64 and will likely cause very subtle
failure modes down the line on other architectures too. The problem on
arm64 is that Perf calls "user_mode(regs)" somewhere down the line,
that macro tries to read the "pstate" register, which is not populated
in ftrace_regs, so it's not copied into a "partial" pt_regs either and
Perf can take wrong decisions based on that.

I already mentioned this problem in the past:
- in the third answer block of:
https://lore.kernel.org/all/CABRcYmJjtVq-330ktqTAUiNO1=3DyG_aHd0xz=3Dc550O5=
C7QP++UA@mail.gmail.com/
- in the fourth answer block of:
https://lore.kernel.org/all/CABRcYm+esb8J2O1v6=3DC+h+HSa5NxraPUgo63w7-iZj0C=
Xbpusg@mail.gmail.com/

It is quite possible that other architectures at some point introduce
a light ftrace "args" trampoline that misses one of the registers
expected by Perf because they don't realize that this trampoline calls
fprobe which calls Perf which has specific registers expectations.

We got the green light from Alexei to use ftrace_partial_regs for "BPF
mutli_kprobe" because these BPF programs can gracefully deal with
sparse pt_regs but I think a similar conversation needs to happen with
the Perf folks.

----

On a side-note, a subtle difference between ftrace_partial_regs with
and without HAVE_PT_REGS_TO_FTRACE_REGS_CAST is that one does a copy
and the other does not. If a subsystem receives a partial regs under
HAVE_PT_REGS_TO_FTRACE_REGS_CAST, it can modify register fields and
the modified values will be restored by the ftrace trampoline. Without
HAVE_PT_REGS_TO_FTRACE_REGS_CAST, only the copy will be modified and
ftrace won't restore them. I think the least we can do is to document
thoroughly the guarantees of the ftrace_partial_regs API: users
shouldn't rely on modifying the resulting regs because depending on
the architecture this could do different things. People shouldn't rely
on any register that isn't covered by one of the ftrace_regs_get_*
helpers because it can be unpopulated on some architectures. I believe
this is the case for BPF multi_kprobe but not for Perf.

> +       }
> +       return NULL;
> +}
> +
> +static __always_inline void perf_fprobe_return_regs(struct pt_regs *regs=
)
> +{
> +       struct pt_regs_stack *stack =3D this_cpu_ptr(&perf_fprobe_regs);
> +
> +       if (WARN_ON_ONCE(regs !=3D stack->regs[stack->idx]))

This is missing an & too:
if (WARN_ON_ONCE(regs !=3D &stack->regs[stack->idx]))




> +               return;
> +
> +       --stack->idx;
> +}
> +
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_T=
O_FTRACE_REGS_CAST */

