Return-Path: <bpf+bounces-2168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE17728B34
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5B81C2103B
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 22:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122AF23D71;
	Thu,  8 Jun 2023 22:43:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1533FC
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 22:43:23 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC02D51;
	Thu,  8 Jun 2023 15:43:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso1993631a12.3;
        Thu, 08 Jun 2023 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686264195; x=1688856195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNrbQrLzaDyIVZlVtGLtW2jLk0N+5CabOX0/0BQtIdw=;
        b=Z8oBiTuSmda8WfrnWpSBXAFblGJZQhW+0gngR6wRk7rrGg7SictdrYmBd3xkFewYo8
         V3PSBTjd9MB1aSMDSeHmVSRelYw+nb8rnTDPXiejzg3Hj0FRIL2IQKrMBu5WFqz3qDsH
         4J68L2N6MPRx6sESdlsfwHJfOYVBMUbMLMKNW9qRzzuwWm8lyTV16OwYQ2b/E+EQsUmD
         trKPFvuBONhEsf+mPRlMrWfit/IfDDIU77VsHld20ghn7ipbcNDaE35yvVUBQbTEthli
         4pimfH8SlDCJoxXSzR0Vxhfahm4QiphI3OgMBuuKgUt2MSupdb0YglLhsFGbeKX1Ey8R
         rxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686264195; x=1688856195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNrbQrLzaDyIVZlVtGLtW2jLk0N+5CabOX0/0BQtIdw=;
        b=Xx7pG1xbEXR+cV5fe5rkBJmFnZr/WljT+w57D6ufB0SUAIzkhdxtBxTCmMqeJOGngM
         9vt4EDLVqIEI0C4UkLChMCLqxv6QMBJGXeaNfkkynI/FcJvvzWhDSBU/lHUsKqRGTUPs
         d5HGpqdnPTqzBmxFBTjZBhTwoflimiXTWiuP/nD1YoUfyPZDuRLTVaNQmtnCyjPTYnve
         TCNItvubounYcuT8EjLu2VSk0NMVq7NxBfk4gudCg6ZVy/f5lzsJ9WUDiURGfseQdhS6
         OYhYjvIAiQKrVERXyELaCYKDbPquKD1kD4T8gxeC5JAFpDXM0F5RDdSc/m0ivubcOcmx
         NAfA==
X-Gm-Message-State: AC+VfDziT5pYvflE6AI+ChJVMpAgtZeeTIxK4A4z1DQvEG46T+AYjDEn
	K8nMnswq/27arqu/zcOC3ufh9JYfeFZl3nf5BEs=
X-Google-Smtp-Source: ACHHUZ6h8iw4XdK67HugzDSJuLfkosNN7RLPVm4WF3BNjdX0x0XrF/pCVDQC4bNXIM/qYWMma4EU1YDeS+OeyMQzk1E=
X-Received: by 2002:a17:907:5c1:b0:965:fb87:4215 with SMTP id
 wg1-20020a17090705c100b00965fb874215mr514444ejb.15.1686264195492; Thu, 08 Jun
 2023 15:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608212613.424070-1-jolsa@kernel.org>
In-Reply-To: <20230608212613.424070-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 15:43:03 -0700
Message-ID: <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in available_filter_functions_addrs
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko <andrii@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Jackie Liu <liu.yun@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 2:26=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
>
> hi,
> when ftrace based tracers we need to cross check available_filter_functio=
ns
> with /proc/kallsyms. For example for kprobe_multi bpf link (based on fpro=
be)
> we need to make sure that symbol regex resolves to traceable symbols and
> that we get proper addresses for them.
>
> Looks like on the last last LSF/MM/BPF there was an agreement to add new
> file that will have available_filter_functions symbols plus addresses.
>
> This RFC is to kick off the discussion, I'm not sure Steven wants to do
> that differently ;-)
>
> thanks,
> jirka
>
>
> ---
> Adding new available_filter_functions_addrs file that shows all available
> functions (same as available_filter_functions) together with addresses,
> like:
>
>   # cat available_filter_functions_addrs | head

nit: can we have some more succinct name, like "traceable_funcs" or
something? And btw, does this have to be part of tracefs/debugfs
(never knew the difference, sorry). E.g., can it be instead exposed
through sysfs?

Either than these minor things, yep, I think this is something that
would be extremely useful, thanks, Jiri, for taking a stab at it!

>   ffffffff81000770 __traceiter_initcall_level
>   ffffffff810007c0 __traceiter_initcall_start
>   ffffffff81000810 __traceiter_initcall_finish
>   ffffffff81000860 trace_initcall_finish_cb
>   ...
>
> It's useful to have address avilable for traceable symbols, so we don't
> need to allways cross check kallsyms with available_filter_functions
> (or the other way around) and have all the data in single file.
>
> For backwards compatibility reasons we can't change the existing
> available_filter_functions file output, but we need to add new file.
>
> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/ftrace.h |  1 +
>  kernel/trace/ftrace.c  | 52 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 48 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index b23bdd414394..6e372575a8e9 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -633,6 +633,7 @@ enum {
>         FTRACE_ITER_MOD         =3D (1 << 5),
>         FTRACE_ITER_ENABLED     =3D (1 << 6),
>         FTRACE_ITER_TOUCHED     =3D (1 << 7),
> +       FTRACE_ITER_ADDRS       =3D (1 << 8),
>  };
>
>  void arch_ftrace_update_code(int command);
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 764668467155..1f33e1f04834 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3804,7 +3804,7 @@ static int __init ftrace_check_sync(void)
>  late_initcall_sync(ftrace_check_sync);
>  subsys_initcall(ftrace_check_for_weak_functions);
>
> -static int print_rec(struct seq_file *m, unsigned long ip)
> +static int print_rec(struct seq_file *m, unsigned long ip, bool print_ad=
dr)
>  {
>         unsigned long offset;
>         char str[KSYM_SYMBOL_LEN];
> @@ -3819,7 +3819,11 @@ static int print_rec(struct seq_file *m, unsigned =
long ip)
>                 ret =3D NULL;
>         }
>
> -       seq_puts(m, str);
> +       if (print_addr)
> +               seq_printf(m, "%lx %s", ip, str);
> +       else
> +               seq_puts(m, str);
> +
>         if (modname)
>                 seq_printf(m, " [%s]", modname);
>         return ret =3D=3D NULL ? -1 : 0;
> @@ -3830,9 +3834,13 @@ static inline int test_for_valid_rec(struct dyn_ft=
race *rec)
>         return 1;
>  }
>
> -static inline int print_rec(struct seq_file *m, unsigned long ip)
> +static inline int print_rec(struct seq_file *m, unsigned long ip, bool p=
rint_addr)
>  {
> -       seq_printf(m, "%ps", (void *)ip);
> +       if (print_addr)
> +               seq_printf(m, "%lx %ps", ip, (void *)ip);
> +       else
> +               seq_printf(m, "%ps", (void *)ip);
> +
>         return 0;
>  }
>  #endif
> @@ -3861,7 +3869,7 @@ static int t_show(struct seq_file *m, void *v)
>         if (!rec)
>                 return 0;
>
> -       if (print_rec(m, rec->ip)) {
> +       if (print_rec(m, rec->ip, iter->flags & FTRACE_ITER_ADDRS)) {
>                 /* This should only happen when a rec is disabled */
>                 WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
>                 seq_putc(m, '\n');
> @@ -3996,6 +4004,30 @@ ftrace_touched_open(struct inode *inode, struct fi=
le *file)
>         return 0;
>  }
>
> +static int
> +ftrace_avail_addrs_open(struct inode *inode, struct file *file)
> +{
> +       struct ftrace_iterator *iter;
> +       int ret;
> +
> +       ret =3D security_locked_down(LOCKDOWN_TRACEFS);
> +       if (ret)
> +               return ret;
> +
> +       if (unlikely(ftrace_disabled))
> +               return -ENODEV;
> +
> +       iter =3D __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*i=
ter));
> +       if (!iter)
> +               return -ENOMEM;
> +
> +       iter->pg =3D ftrace_pages_start;
> +       iter->flags =3D FTRACE_ITER_ADDRS;
> +       iter->ops =3D &global_ops;
> +
> +       return 0;
> +}
> +
>  /**
>   * ftrace_regex_open - initialize function tracer filter files
>   * @ops: The ftrace_ops that hold the hash filters
> @@ -5916,6 +5948,13 @@ static const struct file_operations ftrace_touched=
_fops =3D {
>         .release =3D seq_release_private,
>  };
>
> +static const struct file_operations ftrace_avail_addrs_fops =3D {
> +       .open =3D ftrace_avail_addrs_open,
> +       .read =3D seq_read,
> +       .llseek =3D seq_lseek,
> +       .release =3D seq_release_private,
> +};
> +
>  static const struct file_operations ftrace_filter_fops =3D {
>         .open =3D ftrace_filter_open,
>         .read =3D seq_read,
> @@ -6377,6 +6416,9 @@ static __init int ftrace_init_dyn_tracefs(struct de=
ntry *d_tracer)
>         trace_create_file("available_filter_functions", TRACE_MODE_READ,
>                         d_tracer, NULL, &ftrace_avail_fops);
>
> +       trace_create_file("available_filter_functions_addrs", TRACE_MODE_=
READ,
> +                       d_tracer, NULL, &ftrace_avail_addrs_fops);
> +
>         trace_create_file("enabled_functions", TRACE_MODE_READ,
>                         d_tracer, NULL, &ftrace_enabled_fops);
>
> --
> 2.40.1
>

