Return-Path: <bpf+bounces-7327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC78775722
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AA1281B95
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A035918005;
	Wed,  9 Aug 2023 10:31:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4418C1F
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 10:31:00 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874B1FDF
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 03:30:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686e0213c0bso4811008b3a.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691577058; x=1692181858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23g0gx1mJ/i6nRH5VGmrsxzbfsWW5yRYcO+lPEfm/DE=;
        b=jp3VGD+7skOjlcKJcE3cOuRsgGl5UdBMGNdL81BmEfQEEYBfhLjyi5dAl2oeKpgH+s
         mJXGjz9IbaLi2Fr4/PTORDZN5koD3RmEy7B6Y5XVG4gutxeWFG9KcfYaGa9aUEvk1vSz
         n4l/DD9NJelfHBqVPA2LwJNhmwi0ON6Yh26Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691577058; x=1692181858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23g0gx1mJ/i6nRH5VGmrsxzbfsWW5yRYcO+lPEfm/DE=;
        b=YxzZjlnR+opS3LJxYLkT00SOuDQAdtgSN4PRYrZQYUL5NUjKD4Sb6QPnEwOhD2KBAt
         INF5E+D9ZYNSTRINnUdk56IiFLX0FkrozDa2GzZPyelJVGev8LZ+IGVQuL5sR/gNYlcT
         5Nag0HUz0JdCiaDAA5A0r4e5wuFUPMwQJ2vwjSsl2zRGgC2/UIQXfPxyqWMYkp0PmC5J
         7b5Umf/yA9BQRAA0b3Q2ijd/oYgRMgxQPOvuHivj9USeALkA0leBNuBHR7RuNjHPRaKL
         8BYeU4vzyUrQe7ne/PBNDMJsEj5FGejci1NtxGpj4Xc6gWTSKMgzYNncRuZYMR413LLX
         sMNw==
X-Gm-Message-State: AOJu0YxCxrjMVHjAUoCDuvJy1dybixfCWqnBylg+G1Idv4hT24zNk7jf
	CBOs3BEonVzb6bsnIfOoJxgRTO99g2rL0I0WOzuJaA==
X-Google-Smtp-Source: AGHT+IENNhAKXc6vRR9MNsgE+lFZuSE5AnVa5gOWg0oQMGBY95PLF9PgWQzI4SkTi8qPGbQ3pRlDjdsV9zyqQh7Ab1k=
X-Received: by 2002:a17:90a:6c05:b0:268:c5c7:f7ed with SMTP id
 x5-20020a17090a6c0500b00268c5c7f7edmr1558772pjj.30.1691577058150; Wed, 09 Aug
 2023 03:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139093899.324433.3739544465888158332.stgit@devnote2>
In-Reply-To: <169139093899.324433.3739544465888158332.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Aug 2023 12:30:47 +0200
Message-ID: <CABRcYmK6X6okNKNu9ZjgLEO+JMGL42j7idE8QPZ_EpYA9S9UZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fprobe: rethook: Use fprobe_regs in fprobe
 exit handler and rethook
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The title says "Use fprobe_regs", I think you meant ftrace_regs (we
have enough problems with two regs structs already! :o) ) same comment
for patch 1

On Mon, Aug 7, 2023 at 8:49=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Change the fprobe exit handler and rethook to use ftrace_regs data struct=
ure
> instead of pt_regs. This also introduce HAVE_FTRACE_REGS_COMPATIBLE_WITH_=
PT_REGS

The macro name in the patch description doesn't match the one in the
patch (HAVE_PT_REGS_COMPAT_FTRACE_REGS)

> which means the ftrace_regs is equal to the pt_regs so that those are
> compatible. Only if it is enabled, kretprobe will use rethook since kretp=
robe
> requires pt_regs for backward compatibility.
>
> This means the archs which currently implement rethook for kretprobes nee=
ds to
> set that flag and it must ensure struct ftrace_regs is same as pt_regs.

nit: I'm a bit confused when you say that these structures are "the
same". Let's take x86 as an example, ftrace_regs is "the same" as
pt_regs in the sense that they use the same space in memory and have
the same fields alignment but my understanding of ftrace_regs is that
it can either be a full pt_regs or a sparse pt_regs. If the trampoline
doesn't go through ftrace_regs_caller_op_ptr, registers like CS will
be missing and ftrace_get_regs will return NULL, I don't call it being
"the same". I guess what you mean here is that a pt_regs can be casted
back into a ftrace_regs. Maybe HAVE_PT_REGS_TO_FTRACE_REGS_CAST would
be a clearer name ?

> If not, it must be either disabling kretprobe or implementing kretprobe
> trampoline separately from rethook trampoline.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/Kconfig                    |    1 +
>  arch/loongarch/Kconfig          |    1 +
>  arch/s390/Kconfig               |    1 +
>  arch/x86/Kconfig                |    1 +
>  arch/x86/kernel/rethook.c       |    9 ++++++---
>  include/linux/fprobe.h          |    2 +-
>  include/linux/rethook.h         |   11 ++++++-----
>  kernel/kprobes.c                |    9 +++++++--
>  kernel/trace/Kconfig            |    7 +++++++
>  kernel/trace/bpf_trace.c        |    6 +++++-
>  kernel/trace/fprobe.c           |    6 +++---
>  kernel/trace/rethook.c          |   16 ++++++++--------
>  kernel/trace/trace_fprobe.c     |    6 +++++-
>  lib/test_fprobe.c               |    6 +++---
>  samples/fprobe/fprobe_example.c |    2 +-
>  15 files changed, 56 insertions(+), 28 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index aff2746c8af2..e321bdb8b22b 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -201,6 +201,7 @@ config KRETPROBE_ON_RETHOOK
>         def_bool y
>         depends on HAVE_RETHOOK
>         depends on KRETPROBES
> +       depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS || !HAVE_DYNAMIC_FTRAC=
E_WITH_ARGS
>         select RETHOOK
>
>  config USER_RETURN_NOTIFIER
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e55511af4c77..93a4336b0a94 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -102,6 +102,7 @@ config LOONGARCH
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
>         select HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +       select HAVE_PT_REGS_COMPAT_FTRACE_REGS
>         select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS
>         select HAVE_EBPF_JIT
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 5b39918b7042..299ba17d3316 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -165,6 +165,7 @@ config S390
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
>         select HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +       select HAVE_PT_REGS_COMPAT_FTRACE_REGS
>         select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS
>         select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7422db409770..df1b7a2791e8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -207,6 +207,7 @@ config X86
>         select HAVE_DYNAMIC_FTRACE
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS
>         select HAVE_DYNAMIC_FTRACE_WITH_ARGS    if X86_64
> +       select HAVE_PT_REGS_COMPAT_FTRACE_REGS  if X86_64
>         select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         select HAVE_SAMPLE_FTRACE_DIRECT        if X86_64
>         select HAVE_SAMPLE_FTRACE_DIRECT_MULTI  if X86_64
> diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> index 8a1c0111ae79..79a52bfde562 100644
> --- a/arch/x86/kernel/rethook.c
> +++ b/arch/x86/kernel/rethook.c
> @@ -83,7 +83,8 @@ __used __visible void arch_rethook_trampoline_callback(=
struct pt_regs *regs)
>          * arch_rethook_fixup_return() which called from this
>          * rethook_trampoline_handler().
>          */
> -       rethook_trampoline_handler(regs, (unsigned long)frame_pointer);
> +       rethook_trampoline_handler((struct ftrace_regs *)regs,
> +                                  (unsigned long)frame_pointer);
>
>         /*
>          * Copy FLAGS to 'pt_regs::ss' so that arch_rethook_trapmoline()
> @@ -104,9 +105,10 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
>  STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
>
>  /* This is called from rethook_trampoline_handler(). */
> -void arch_rethook_fixup_return(struct pt_regs *regs,
> +void arch_rethook_fixup_return(struct ftrace_regs *fregs,
>                                unsigned long correct_ret_addr)
>  {
> +       struct pt_regs *regs =3D ftrace_get_regs(fregs);
>         unsigned long *frame_pointer =3D (void *)(regs + 1);
>
>         /* Replace fake return address with real one. */
> @@ -114,8 +116,9 @@ void arch_rethook_fixup_return(struct pt_regs *regs,
>  }
>  NOKPROBE_SYMBOL(arch_rethook_fixup_return);
>
> -void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs,=
 bool mcount)
> +void arch_rethook_prepare(struct rethook_node *rh, struct ftrace_regs *f=
regs, bool mcount)
>  {
> +       struct pt_regs *regs =3D ftrace_get_regs(fregs);
>         unsigned long *stack =3D (unsigned long *)regs->sp;
>
>         rh->ret_addr =3D stack[0];
> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index 36c0595f7b93..b9c0c216dedb 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -38,7 +38,7 @@ struct fprobe {
>                              unsigned long ret_ip, struct ftrace_regs *re=
gs,
>                              void *entry_data);
>         void (*exit_handler)(struct fprobe *fp, unsigned long entry_ip,
> -                            unsigned long ret_ip, struct pt_regs *regs,
> +                            unsigned long ret_ip, struct ftrace_regs *re=
gs,
>                              void *entry_data);
>  };
>
> diff --git a/include/linux/rethook.h b/include/linux/rethook.h
> index 26b6f3c81a76..138d64c8b67b 100644
> --- a/include/linux/rethook.h
> +++ b/include/linux/rethook.h
> @@ -7,6 +7,7 @@
>
>  #include <linux/compiler.h>
>  #include <linux/freelist.h>
> +#include <linux/ftrace.h>
>  #include <linux/kallsyms.h>
>  #include <linux/llist.h>
>  #include <linux/rcupdate.h>
> @@ -14,7 +15,7 @@
>
>  struct rethook_node;
>
> -typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsign=
ed long, struct pt_regs *);
> +typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsign=
ed long, struct ftrace_regs *);
>
>  /**
>   * struct rethook - The rethook management data structure.
> @@ -64,12 +65,12 @@ void rethook_free(struct rethook *rh);
>  void rethook_add_node(struct rethook *rh, struct rethook_node *node);
>  struct rethook_node *rethook_try_get(struct rethook *rh);
>  void rethook_recycle(struct rethook_node *node);
> -void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool =
mcount);
> +void rethook_hook(struct rethook_node *node, struct ftrace_regs *regs, b=
ool mcount);
>  unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned lo=
ng frame,
>                                     struct llist_node **cur);
>
>  /* Arch dependent code must implement arch_* and trampoline code */
> -void arch_rethook_prepare(struct rethook_node *node, struct pt_regs *reg=
s, bool mcount);
> +void arch_rethook_prepare(struct rethook_node *node, struct ftrace_regs =
*regs, bool mcount);
>  void arch_rethook_trampoline(void);
>
>  /**
> @@ -84,11 +85,11 @@ static inline bool is_rethook_trampoline(unsigned lon=
g addr)
>  }
>
>  /* If the architecture needs to fixup the return address, implement it. =
*/
> -void arch_rethook_fixup_return(struct pt_regs *regs,
> +void arch_rethook_fixup_return(struct ftrace_regs *regs,
>                                unsigned long correct_ret_addr);
>
>  /* Generic trampoline handler, arch code must prepare asm stub */
> -unsigned long rethook_trampoline_handler(struct pt_regs *regs,
> +unsigned long rethook_trampoline_handler(struct ftrace_regs *regs,
>                                          unsigned long frame);
>
>  #ifdef CONFIG_RETHOOK
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 1fc6095d502d..ccbe41c961c3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2120,7 +2120,7 @@ static int pre_handler_kretprobe(struct kprobe *p, =
struct pt_regs *regs)
>         if (rp->entry_handler && rp->entry_handler(ri, regs))
>                 rethook_recycle(rhn);
>         else
> -               rethook_hook(rhn, regs, kprobe_ftrace(p));
> +               rethook_hook(rhn, (struct ftrace_regs *)regs, kprobe_ftra=
ce(p));

I think there are two things that can be meant with "rethook uses ftrace_re=
gs":

- rethook callbacks receive a ftrace_regs (that's what you do further down)
- rethook can hook to a traced function using a ftrace_regs (that's
what you use in fprobe now)

But I think the second proposition shouldn't imply that rethook_hook
can _only_ hook to ftrace_regs. For the kprobe use case, I think there
should also be a rethook_hook_pt_regs() that operates on a pt_regs. We
could have a default implementation of rethook_hook that calls into
the other (or vice versa) on HAVE_FTRACE_REGS_COMPATIBLE_WITH_PT_REGS
but I think it's good to separate these two APIs

