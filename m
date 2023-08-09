Return-Path: <bpf+bounces-7328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F5775724
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792E7281B50
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D560D14286;
	Wed,  9 Aug 2023 10:31:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55161AA91
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 10:31:18 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F32109
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 03:31:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-564af0ac494so3531456a12.0
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691577072; x=1692181872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQfIsHY5NEOAQ1OhrWSDUQtlAV+UbCmzK5iCvrQ5LSM=;
        b=IHf6FjyBrHygMbNwjb8Y/eareC9GpNDdG5vfVWnA4OOVfUtzSd/7mzUUM8Dwt5pjTE
         H1DCjwnQJGk5v0Sw5Z/aR+tjNFQ1+RXbhZYD0nJqtJ08j3TIa1xHJRiNoiBiepHnnx/l
         GIkUgxubIOcbbmEOyJmbp8nTkXt/UpUJXf9gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577072; x=1692181872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQfIsHY5NEOAQ1OhrWSDUQtlAV+UbCmzK5iCvrQ5LSM=;
        b=Di9oauPu0GCmh6kcTGc1qvHq0a1cibdCmpyHSkQLh2mlXULMuD+J175VhGCtWQdfRY
         XYNxX9wN/FmFtVcFrW7ExfIcCswRsYAVIAO6JypvLbnwFDbQxWJ9lhp/6+syM5ZcIWxn
         RAtc5z99LQ0PJQmpNCF78pUZPTv6+l1Mo8ry5dVUHUef5GVauKsDYAwozmopNXf1j8Gq
         saGle9ENaMLb5vTypHyln4orPqyyzEh//h9QIj5o06Wh2OpbVowfmT/70ukSNeZGdE07
         veuzJuJrwmn6HqG57urLu4wrjWQFHdUvYNklSxREXeWHEAH/hZ/AtnnWM3PoN5WQ1bEV
         C3TQ==
X-Gm-Message-State: AOJu0Yxr0Hi4onZBuINGHo8MKynfSvNVEwPhtgUUdhi65qXwBM4fbOuN
	7qcTHLM++XEYI3kkJDJM/rnD/i6NG9ZP1XRBSoLg9g==
X-Google-Smtp-Source: AGHT+IGt4EGmUEJug2nEf8tGVkzTEo/UX5avAbzyw42k+XHz9vAI5SZrU/cRjcAgiPDxDS+CZsNiPIi02EaK3R7qkVA=
X-Received: by 2002:a17:90a:ea0a:b0:268:b66b:d9f6 with SMTP id
 w10-20020a17090aea0a00b00268b66bd9f6mr1476419pjy.18.1691577071857; Wed, 09
 Aug 2023 03:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139095066.324433.15514499924371317690.stgit@devnote2>
In-Reply-To: <169139095066.324433.15514499924371317690.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 12:31:00 +0200
Message-ID: <CABRcYm+8-zYRGjKSPtWQ8_Vq2649=vi71fGvFx2aWM1tnOMYQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
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
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 8:49=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Allow fprobe events to be enabled with CONFIG_DYNAMIC_FTRACE_WITH_ARGS.
> With this change, fprobe events mostly use ftrace_regs instead of pt_regs=
.
> Note that if the arch doesn't enable HAVE_PT_REGS_COMPAT_FTRACE_REGS,
> fprobe events will not be able to use from perf.

nit: "to be used from perf" ?

> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -132,25 +132,30 @@ static int
>  process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
>                    void *base)
>  {
> -       struct pt_regs *regs =3D rec;
> -       unsigned long val;
> +       struct ftrace_regs *fregs =3D rec;
> +       unsigned long val, *stackp;
>         int ret;
>
>  retry:
>         /* 1st stage: get value from context */
>         switch (code->op) {
>         case FETCH_OP_STACK:
> -               val =3D regs_get_kernel_stack_nth(regs, code->param);
> +               stackp =3D (unsigned long *)ftrace_regs_get_stack_pointer=
(fregs);
> +               if (((unsigned long)(stackp + code->param) & ~(THREAD_SIZ=
E - 1)) =3D=3D
> +                   ((unsigned long)stackp & ~(THREAD_SIZE - 1)))

Maybe it'd be worth extracting a local
"ftrace_regs_get_kernel_stack_nth_addr" helper function and/or
"ftrace_regs_within_kernel_stack" ?

