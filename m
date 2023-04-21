Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA816EA0C3
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 03:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjDUBCH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 21:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDUBCG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 21:02:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1710C;
        Thu, 20 Apr 2023 18:02:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-956ff2399c9so80318266b.3;
        Thu, 20 Apr 2023 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682038922; x=1684630922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/Qxqrm8bV6E0f0Hh3lVjKYLknzLW2YwfJD1Ip3Xllc=;
        b=M52xizEtxOHYEHCA9AEanHmAZLBHWboT+lAo3Mm60CMvVHyKa3EMvnkkqKW8t/mbwd
         XFa8oItqiSCxgY1SxlsVUdkvxYXc6R7p/Cth2JdQtAnYOvaYWXO/3pX1vZ+7IGTZlqxO
         Kb/adfvk39Od0i0ttDaVk69V9CmzLdiGpcoLzItw1sgjvTYYr7AUpQRV+oKWq92OaOJj
         TmkVWI7RnpZU89uyKXXrS0dtsWuZRFQ2ITiVAjJGB/HKrCzibD9ec8ap68odSRZLQ/b7
         VlkLP+9ylZVvn9Jn9aRJDyeBGmbhiB4ZrowTmcy0ZefXwlWp5gR+eY27tBSG2uqyry2z
         rlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682038922; x=1684630922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/Qxqrm8bV6E0f0Hh3lVjKYLknzLW2YwfJD1Ip3Xllc=;
        b=Bl4+LqoztaegYAaCuxWfAPB0C9bsuly++cYNZJvhZqH9e2bo1odJvTSmggtP8/+SI0
         qdA6AYeCWSj1jzJGsNiBhuL9lRYyEHLQ65F7bW2uPDn/TyFDJSq1DPG7MWungUpzSiqI
         rh6LPmPcjHUq0X5w/MZDglaESaaOQwwLofWtKKdWeJ/EtFe9J/S4Q/6x5CTvWtWkKYtb
         gqs8UM84hhjSHJWxP+bZig/TigHeNa6RKUnszXPIoQVWhA+u23ZQhXcSHB6yfCRkQzJ2
         UmbKZliZczpCmykm7JHb3lJyYFiJH7Gpr7ebRj/hTLuyISrlJzpRlCoMl5tz2DWlMwc4
         Q8Hw==
X-Gm-Message-State: AAQBX9fp5DGQakRjBB5dGeGV0Sz0b65BwF/2FirRYu/Y/gycObuvTHei
        reZKZ+HtVz0mnfvM7MUwe34i3YksPioDTopFCmY=
X-Google-Smtp-Source: AKy350aOnfMvOYWuAWw5cODgOoSgl6JhNGxHcvtjoGnTRuc+LEfMbZGmkja73G85coDDC+EBlERMLYh8RWzXd+ihR9c=
X-Received: by 2002:a17:906:d04a:b0:953:7bb3:364 with SMTP id
 bo10-20020a170906d04a00b009537bb30364mr357192ejb.3.1682038922178; Thu, 20 Apr
 2023 18:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <168198993129.1795549.8306571027057356176.stgit@mhiramat.roam.corp.google.com>
 <168198999024.1795549.1201846807114771292.stgit@mhiramat.roam.corp.google.com>
 <377888e5-c534-617d-f114-f884759cdd35@oracle.com> <20230421095647.03e3a7fb2f68885527f80f55@kernel.org>
In-Reply-To: <20230421095647.03e3a7fb2f68885527f80f55@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Apr 2023 18:01:50 -0700
Message-ID: <CAADnVQ+U5T99ZqZDjp=jweV951SUjkKSsA_doJ3v+FFz4LR4ug@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] tracing/probes: Support function parameters if BTF
 is available
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 5:57=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Thu, 20 Apr 2023 20:08:00 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
>
> > On 20/04/2023 12:26, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > Support function or tracepoint parameters by name if BTF is available
> > > and the event is for function entry (This means it is available for
> > > kprobe-events, fprobe-events and tracepoint probe events.)
> > >
> > > BTF variable syntax is a bit special because it doesn't need any pref=
ix.
> > > Also, if only the BTF variable name is given, the argument name is
> > > also becomes the BTF variable name. e.g.
> > >
> > >  # echo 'p vfs_read count pos' >> dynamic_events
> > >  # echo 'f vfs_write count pos' >> dynamic_events
> > >  # echo 't sched_overutilized_tp rd overutilized' >> dynamic_events
> > >  # cat dynamic_events
> > > p:kprobes/p_vfs_read_0 vfs_read count=3Dcount pos=3Dpos
> > > f:fprobes/vfs_write__entry vfs_write count=3Dcount pos=3Dpos
> > > t:tracepoints/sched_overutilized_tp sched_overutilized_tp rd=3Drd ove=
rutilized=3Doverutilized
> > >
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  kernel/trace/Kconfig        |   11 ++
> > >  kernel/trace/trace.c        |    4 +
> > >  kernel/trace/trace_fprobe.c |   49 ++++++-----
> > >  kernel/trace/trace_kprobe.c |   12 +--
> > >  kernel/trace/trace_probe.c  |  192 +++++++++++++++++++++++++++++++++=
++++++++++
> > >  kernel/trace/trace_probe.h  |    9 ++
> > >  6 files changed, 248 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > > index 8e10a9453c96..e2b415b9fcd4 100644
> > > --- a/kernel/trace/Kconfig
> > > +++ b/kernel/trace/Kconfig
> > > @@ -664,6 +664,17 @@ config FPROBE_EVENTS
> > >       and the kprobe events on function entry and exit will be
> > >       transparently converted to this fprobe events.
> > >
> > > +config PROBE_EVENTS_BTF_ARGS
> > > +   depends on HAVE_FUNCTION_ARG_ACCESS_API
> > > +   depends on FPROBE_EVENTS || KPROBE_EVENTS
> > > +   depends on DEBUG_INFO_BTF && BPF_SYSCALL
> > > +   bool "Support BTF function arguments for probe events"
> > > +   default y
> > > +   help
> > > +     The user can specify the arguments of the probe event using the=
 names
> > > +     of the arguments of the probed function. This feature only work=
s if
> > > +     the probe location is a kernel function entry or a tracepoint.
> > > +
> > >  config KPROBE_EVENTS
> > >     depends on KPROBES
> > >     depends on HAVE_REGS_AND_STACK_ACCESS_API
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index 9da9c979faa3..0d9c48197a5c 100644
> > > --- a/kernel/trace/trace.c
> > > +++ b/kernel/trace/trace.c
> > > @@ -5670,7 +5670,11 @@ static const char readme_msg[] =3D
> > >     "\t     args: <name>=3Dfetcharg[:type]\n"
> > >     "\t fetcharg: (%<register>|$<efield>), @<address>, @<symbol>[+|-<=
offset>],\n"
> > >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > > +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> > > +   "\t           $stack<index>, $stack, $retval, $comm, $arg<N>, <ar=
gname>\n"
> > > +#else
> > >     "\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
> > > +#endif
> > >  #else
> > >     "\t           $stack<index>, $stack, $retval, $comm,\n"
> > >  #endif
> > > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.=
c
> > > index cd91bf57baac..d88079c2d2e3 100644
> > > --- a/kernel/trace/trace_fprobe.c
> > > +++ b/kernel/trace/trace_fprobe.c
> > > @@ -387,6 +387,7 @@ static void free_trace_fprobe(struct trace_fprobe=
 *tf)
> > >  static struct trace_fprobe *alloc_trace_fprobe(const char *group,
> > >                                            const char *event,
> > >                                            const char *symbol,
> > > +                                          struct tracepoint *tpoint,
> > >                                            int maxactive,
> > >                                            int nargs, bool is_return)
> > >  {
> > > @@ -406,6 +407,7 @@ static struct trace_fprobe *alloc_trace_fprobe(co=
nst char *group,
> > >     else
> > >             tf->fp.entry_handler =3D fentry_dispatcher;
> > >
> > > +   tf->tpoint =3D tpoint;
> > >     tf->fp.nr_maxactive =3D maxactive;
> > >
> > >     ret =3D trace_probe_init(&tf->tp, event, group, false);
> > > @@ -949,8 +951,12 @@ static int __trace_fprobe_create(int argc, const=
 char *argv[])
> > >     int maxactive =3D 0;
> > >     char buf[MAX_EVENT_NAME_LEN];
> > >     char gbuf[MAX_EVENT_NAME_LEN];
> > > -   unsigned int flags =3D TPARG_FL_KERNEL;
> > > +   char sbuf[KSYM_NAME_LEN];
> > >     bool is_tracepoint =3D false;
> > > +   struct tracepoint *tpoint =3D NULL;
> > > +   struct traceprobe_parse_context ctx =3D {
> > > +           .flags =3D TPARG_FL_KERNEL | TPARG_FL_FENTRY,
> > > +   };
> > >
> > >     if ((argv[0][0] !=3D 'f' && argv[0][0] !=3D 't') || argc < 2)
> > >             return -ECANCELED;
> > > @@ -1014,12 +1020,6 @@ static int __trace_fprobe_create(int argc, con=
st char *argv[])
> > >             goto parse_error;
> > >     }
> > >
> > > -   flags |=3D TPARG_FL_FENTRY;
> > > -   if (is_return)
> > > -           flags |=3D TPARG_FL_RETURN;
> > > -   if (is_tracepoint)
> > > -           flags |=3D TPARG_FL_TPOINT;
> > > -
> > >     trace_probe_log_set_index(0);
> > >     if (event) {
> > >             ret =3D traceprobe_parse_event_name(&event, &group, gbuf,
> > > @@ -1031,7 +1031,8 @@ static int __trace_fprobe_create(int argc, cons=
t char *argv[])
> > >     if (!event) {
> > >             /* Make a new event name */
> > >             if (is_tracepoint)
> > > -                   strscpy(buf, symbol, MAX_EVENT_NAME_LEN);
> > > +                   snprintf(buf, MAX_EVENT_NAME_LEN, "%s%s",
> > > +                            isdigit(*symbol) ? "_" : "", symbol);
> > >             else
> > >                     snprintf(buf, MAX_EVENT_NAME_LEN, "%s__%s", symbo=
l,
> > >                              is_return ? "exit" : "entry");
> > > @@ -1039,8 +1040,25 @@ static int __trace_fprobe_create(int argc, con=
st char *argv[])
> > >             event =3D buf;
> > >     }
> > >
> > > +   if (is_return)
> > > +           ctx.flags |=3D TPARG_FL_RETURN;
> > > +
> > > +   if (is_tracepoint) {
> > > +           ctx.flags |=3D TPARG_FL_TPOINT;
> > > +           tpoint =3D find_tracepoint(symbol);
> > > +           if (!tpoint) {
> > > +                   trace_probe_log_set_index(1);
> > > +                   trace_probe_log_err(0, NO_TRACEPOINT);
> > > +                   goto parse_error;
> > > +           }
> > > +           ctx.funcname =3D kallsyms_lookup(
> > > +                           (unsigned long)tpoint->probestub,
> > > +                           NULL, NULL, NULL, sbuf);
> > > +   } else
> > > +           ctx.funcname =3D symbol;
> > > +
> > >     /* setup a probe */
> > > -   tf =3D alloc_trace_fprobe(group, event, symbol, maxactive,
> > > +   tf =3D alloc_trace_fprobe(group, event, symbol, tpoint, maxactive=
,
> > >                             argc - 2, is_return);
> > >     if (IS_ERR(tf)) {
> > >             ret =3D PTR_ERR(tf);
> > > @@ -1049,24 +1067,15 @@ static int __trace_fprobe_create(int argc, co=
nst char *argv[])
> > >             goto out;       /* We know tf is not allocated */
> > >     }
> > >
> > > -   if (is_tracepoint) {
> > > -           tf->tpoint =3D find_tracepoint(tf->symbol);
> > > -           if (!tf->tpoint) {
> > > -                   trace_probe_log_set_index(1);
> > > -                   trace_probe_log_err(0, NO_TRACEPOINT);
> > > -                   goto parse_error;
> > > -           }
> > > +   if (is_tracepoint)
> > >             tf->mod =3D __module_text_address(
> > >                             (unsigned long)tf->tpoint->probestub);
> > > -   }
> > >
> > >     argc -=3D 2; argv +=3D 2;
> > > -
> > >     /* parse arguments */
> > >     for (i =3D 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> > > -           struct traceprobe_parse_context ctx =3D { .flags =3D flag=
s };
> > > -
> > >             trace_probe_log_set_index(i + 2);
> > > +           ctx.offset =3D 0;
> > >             ret =3D traceprobe_parse_probe_arg(&tf->tp, i, argv[i], &=
ctx);
> > >             if (ret)
> > >                     goto error;     /* This can be -ENOMEM */
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.=
c
> > > index fd62de2a2f51..aff6c1a5e161 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -742,7 +742,7 @@ static int __trace_kprobe_create(int argc, const =
char *argv[])
> > >     void *addr =3D NULL;
> > >     char buf[MAX_EVENT_NAME_LEN];
> > >     char gbuf[MAX_EVENT_NAME_LEN];
> > > -   unsigned int flags =3D TPARG_FL_KERNEL;
> > > +   struct traceprobe_parse_context ctx =3D { .flags =3D TPARG_FL_KER=
NEL };
> > >
> > >     switch (argv[0][0]) {
> > >     case 'r':
> > > @@ -823,10 +823,10 @@ static int __trace_kprobe_create(int argc, cons=
t char *argv[])
> > >                     goto parse_error;
> > >             }
> > >             if (is_return)
> > > -                   flags |=3D TPARG_FL_RETURN;
> > > +                   ctx.flags |=3D TPARG_FL_RETURN;
> > >             ret =3D kprobe_on_func_entry(NULL, symbol, offset);
> > >             if (ret =3D=3D 0)
> > > -                   flags |=3D TPARG_FL_FENTRY;
> > > +                   ctx.flags |=3D TPARG_FL_FENTRY;
> > >             /* Defer the ENOENT case until register kprobe */
> > >             if (ret =3D=3D -EINVAL && is_return) {
> > >                     trace_probe_log_err(0, BAD_RETPROBE);
> > > @@ -856,7 +856,7 @@ static int __trace_kprobe_create(int argc, const =
char *argv[])
> > >
> > >     /* setup a probe */
> > >     tk =3D alloc_trace_kprobe(group, event, addr, symbol, offset, max=
active,
> > > -                          argc - 2, is_return);
> > > +                           argc - 2, is_return);
> > >     if (IS_ERR(tk)) {
> > >             ret =3D PTR_ERR(tk);
> > >             /* This must return -ENOMEM, else there is a bug */
> > > @@ -866,10 +866,10 @@ static int __trace_kprobe_create(int argc, cons=
t char *argv[])
> > >     argc -=3D 2; argv +=3D 2;
> > >
> > >     /* parse arguments */
> > > +   ctx.funcname =3D symbol;
> > >     for (i =3D 0; i < argc && i < MAX_TRACE_ARGS; i++) {
> > > -           struct traceprobe_parse_context ctx =3D { .flags =3D flag=
s };
> > > -
> > >             trace_probe_log_set_index(i + 2);
> > > +           ctx.offset =3D 0;
> > >             ret =3D traceprobe_parse_probe_arg(&tk->tp, i, argv[i], &=
ctx);
> > >             if (ret)
> > >                     goto error;     /* This can be -ENOMEM */
> > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > index 84a9f0446390..f55d633b3e2a 100644
> > > --- a/kernel/trace/trace_probe.c
> > > +++ b/kernel/trace/trace_probe.c
> > > @@ -300,6 +300,174 @@ static int parse_trace_event_arg(char *arg, str=
uct fetch_insn *code,
> > >     return -ENOENT;
> > >  }
> > >
> > > +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> > > +
> > > +static DEFINE_MUTEX(tp_btf_mutex);
> > > +static struct btf *traceprobe_btf;
> > > +
> > > +static struct btf *traceprobe_get_btf(void)
> > > +{
> > > +   if (!traceprobe_btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> > > +           mutex_lock(&tp_btf_mutex);
> > > +           if (!traceprobe_btf)
> > > +                   traceprobe_btf =3D btf_parse_vmlinux();
> >
> > Apologies if I missed this in previous discussion, but should we
> > use bpf_get_btf_vmlinux() here instead, since it will
> > return an already-parsed BTF? There's a bunch of additional
> > work that btf_parse_vmlinux() does that's not needed from
> > a tracing POV.
>
> I thought bpf_get_btf_vmlinux() was only for BPF subsystem because
> it is exposed in bpf.h, not btf.h. But yeah, it is useless if we
> have 2 BTF instance. So I'll use it.
>
> By the way, I eventually would like to use the BTF things even if the
> BPF_SYSCALL is not enabled. Can we make it, or is it hard to decouple
> the BTF things from BPF?

It's hard. I'd rather keep it as-is. The test matrix is already huge.
