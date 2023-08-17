Return-Path: <bpf+bounces-8019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58177FF3D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA0282133
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 20:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20707198A7;
	Thu, 17 Aug 2023 20:44:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14502918
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 20:44:55 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E32698;
	Thu, 17 Aug 2023 13:44:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so3439981fa.2;
        Thu, 17 Aug 2023 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692305093; x=1692909893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKB2G1ShadBbwkQ3nqYgBQMx8SZjUO4UzWmh4ooX9M4=;
        b=PnqFP9F+NfPUJ/GHt3ZuCwUBWypL49qcFmfjeLTMLQH4EmzXVx01htjP8f2ONlADrf
         EReiqG2tRkf706TjB6pXeJibQnQ5TpguVQOYwNuiHb17/HfJjx/10GcxkNdDvBwHX7R7
         GkjpaZ3fOCsqogo1Vbq94zzoCxum8hPDPEDZCICSDC0F49UAo86UNQU43ysr2WKh6z44
         eGQEHbDqOzjXIGy/GDu53r1htgWy8eDrZEgRIbZoA5UU7NDl/Bwhtyub1p1xImRNGqlk
         TsA6O9TyGX3QvomfwU1zhDTrJh79MSAyOfRbx8onlmRn+wrR+mGDYNcX+EQW4O/nSfNN
         E3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305093; x=1692909893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKB2G1ShadBbwkQ3nqYgBQMx8SZjUO4UzWmh4ooX9M4=;
        b=esUOAA2kRmrYS6DfOpBk8AIiLaPmuDOTWqDYL0sA0izSAsHZ8nSbW8zMDDvt1czLNO
         Oh7xYpr4P46O4lninaUZbH7f25jx0oajwajdXuftawYtszabgkS3spcZSIiGzda4mFzl
         a0mxmuqHUPS5hMlhMZ1KEDzAhGyV/TNziOKIbmpmtRdxnu+XEHcAlh6q2V5opcR2ifCu
         u6Mbb2I6Wv+f3eEWKPsrqakZzAY2+xUKpAOkmz1eKhgyHvwBw6UCNRKNekkZ1xHu+mb0
         U1Ftwvk4eSvW4ueINIkSlFx7It8xSxr5Ud0fwZQBp48vC6aj9F/go2KhhP6gL28yRnBi
         2AWA==
X-Gm-Message-State: AOJu0YwQfhigsSJ+yNK02ba22GHFHEYXPxw85WuqC83YNpCF0jWmAdRK
	WGGdMrlr24LA295Ae1ihw04MgxfVccKQy8k3CJw=
X-Google-Smtp-Source: AGHT+IHITINNcbw4rEEj3o7EA22/na3TQA23asdzboKEdmcOqIzxCZLfoTs8rhCRi/f0efPXPrdNSqcyzzDYyrMhj5o=
X-Received: by 2002:a2e:88d6:0:b0:2b6:c2e4:a57a with SMTP id
 a22-20020a2e88d6000000b002b6c2e4a57amr310253ljk.38.1692305092471; Thu, 17 Aug
 2023 13:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181865486.505132.6447946094827872988.stgit@devnote2>
In-Reply-To: <169181865486.505132.6447946094827872988.stgit@devnote2>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Aug 2023 13:44:41 -0700
Message-ID: <CAADnVQ+En1sxXFrDZBefDCBSS=mChDJ3Xg_Xz+WKXmPqziSxgw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 10:37=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> +#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
> +static __always_inline unsigned long
> +ftrace_regs_get_kernel_stack_nth(struct ftrace_regs *fregs, unsigned int=
 nth)
> +{
> +       unsigned long *stackp;
> +
> +       stackp =3D (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
> +       if (((unsigned long)(stackp + nth) & ~(THREAD_SIZE - 1)) =3D=3D
> +           ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> +               return *(stackp + nth);
> +
> +       return 0;
> +}
> +#endif /* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
...
>
> @@ -140,17 +140,17 @@ process_fetch_insn(struct fetch_insn *code, void *r=
ec, void *dest,
>         /* 1st stage: get value from context */
>         switch (code->op) {
>         case FETCH_OP_STACK:
> -               val =3D regs_get_kernel_stack_nth(regs, code->param);
> +               val =3D ftrace_regs_get_kernel_stack_nth(fregs, code->par=
am);
>                 break;

Just noticed that bit.
You probably want to document that access to arguments and
especially arguments on stack is not precise. It's "best effort".
x86-64 calling convention is not as simple as it might appear.
For example if 6th argument is a 16-byte struct like sockptr_t it will be
passed on the stack and 7th actual argument (if it's <=3D 8 byte) will
be the register.

Things similar on 32-bit and there is a non-zero chance that
regs_get_kernel_argument() doesn't return the actual arg.

