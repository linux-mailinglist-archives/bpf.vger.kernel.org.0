Return-Path: <bpf+bounces-9564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC833799289
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32371C20D1C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7FC6FB5;
	Fri,  8 Sep 2023 22:57:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F130F9C
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:57:00 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F8E1FEF;
	Fri,  8 Sep 2023 15:56:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c73c21113so2321658f8f.1;
        Fri, 08 Sep 2023 15:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694213816; x=1694818616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrm9nFM+dmT+wC8EAx2G6BoiUrbJkZ2V45kBkAqBx/k=;
        b=e8bMNBiZ0MCbrs6is6UVebdOVV4R19ua5m/ut+GrbWvgDQmHzjLqQOj8lVdKNO8D2Z
         8T5JQd4JCGAG5sQBXbE2kdPZVmlnoNlw3MriH0yMpH8kfvOPYyJRnhWMJvL+gMw2pC7u
         4d2NalH7kB4vRujc9uu//E/t0p+ZY8ynT/where2blNZ7QBIBt7NsLZ184/JOHVZFjYr
         34OIpfRmjYh+kpr/fN3dAt9WT2toTgxjfjJbbxE37bNE2Bb4+gAykXxU+iIQE29hX9Vp
         Dc5hUN6QaiS0PMHdUMiMuknrfIODKVIrbZCe3pAIwnHmfOeK58YJFNsUJe0AcPU6Bw/7
         CXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213816; x=1694818616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrm9nFM+dmT+wC8EAx2G6BoiUrbJkZ2V45kBkAqBx/k=;
        b=dd0XwtGZDKATNHTyeryoZsLJvba8OlpxGKPSse6jCD3M/y5HeDQC3CQ3zyREUVkNVj
         I74jmLtMxlZhvMK+7soy6TMLISFCtIo6wLmXEecL9rZ7T8Z/oNcVHFNIfZaGKzTRAGbv
         z3CNXdmapFRynHIZHpzFKfk7+H2MWd3zrHIYuOZjWOzkMorlLWI/ZRpE9UkUSmUrr3EZ
         76lqXhDquVjkW9npIe4OO5DtEnyknybwoWB2KE0S/nK1PjAWQy9ZxFP3mqEedYf6dwqc
         e/FS88ZXOibyn1dDsBqPeuSc+gUW5E113oIAHfVw3Er132m4d3j9kze8JRCAejQcVQT2
         Vy5Q==
X-Gm-Message-State: AOJu0Yx4M0xACtBKgX4GKw1Z0Xf9E147CzKCg8rga1KKjfQQaBidj1it
	H3JwPX0FCCeSH7I8kfTyDFKolgd0jmxmn/YL+tQ=
X-Google-Smtp-Source: AGHT+IEZsHn4eplhM/i5rf8Vqol8Q4PBsNqkK2KiuyFh7T3+of4k5EOzRUQxRV2ogOlYujoQio41u2OkCmF1N2Z4oCc=
X-Received: by 2002:adf:fa4f:0:b0:317:e1fb:d56a with SMTP id
 y15-20020adffa4f000000b00317e1fbd56amr2936307wrr.40.1694213815837; Fri, 08
 Sep 2023 15:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
 <169280378611.282662.4078983611827223131.stgit@devnote2> <CAEf4Bzb9CBnQp1_bEW-DOhw9rpDj6jt79DMmsKL2L4a_4ts9gQ@mail.gmail.com>
 <20230826105632.e3eb35fc69a65ebaf11c7741@kernel.org> <CAEf4BzY3dySkeAuOgnNCykZwowbw0ZB9FvM2rE1oBUd_=_U6oA@mail.gmail.com>
 <20230906092845.ce5ff494d379c73cef58cb08@kernel.org>
In-Reply-To: <20230906092845.ce5ff494d379c73cef58cb08@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 15:56:43 -0700
Message-ID: <CAEf4BzYxSh5-6dd=pdADp10v5aLiKdaLh74Z5kW4AJhPuD1iYw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] ftrace: Add ftrace_partial_regs() for converting
 ftrace_regs to pt_regs
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
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

On Tue, Sep 5, 2023 at 5:28=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 5 Sep 2023 12:50:28 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Fri, Aug 25, 2023 at 6:56=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Fri, 25 Aug 2023 14:49:48 -0700
> > > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > On Wed, Aug 23, 2023 at 8:16=E2=80=AFAM Masami Hiramatsu (Google)
> > > > <mhiramat@kernel.org> wrote:
> > > > >
> > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > > Add ftrace_partial_regs() which converts the ftrace_regs to pt_re=
gs.
> > > > > If the architecture defines its own ftrace_regs, this copies part=
ial
> > > > > registers to pt_regs and returns it. If not, ftrace_regs is the s=
ame as
> > > > > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> > > > >
> > > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > Acked-by: Florent Revest <revest@chromium.org>
> > > > > ---
> > > > >  Changes in v3:
> > > > >   - Fix to use pt_regs::regs instead of x.
> > > > >   - Return ftrace_regs::regs forcibly if HAVE_PT_REGS_COMPAT_FTRA=
CE_REGS=3Dy.
> > > > >   - Fix typo.
> > > > >   - Fix to copy correct registers to the pt_regs on arm64.
> > > > >  Changes in v4:
> > > > >   - Change the patch order in the series so that fprobe event can=
 use this.
> > > > > ---
> > > > >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> > > > >  include/linux/ftrace.h          |   17 +++++++++++++++++
> > > > >  2 files changed, 28 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include=
/asm/ftrace.h
> > > > > index ab158196480c..5ad24f315d52 100644
> > > > > --- a/arch/arm64/include/asm/ftrace.h
> > > > > +++ b/arch/arm64/include/asm/ftrace.h
> > > > > @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct =
ftrace_regs *fregs)
> > > > >         fregs->pc =3D fregs->lr;
> > > > >  }
> > > > >
> > > > > +static __always_inline struct pt_regs *
> > > > > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_r=
egs *regs)
> > > > > +{
> > > > > +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> > > > > +       regs->sp =3D fregs->sp;
> > > > > +       regs->pc =3D fregs->pc;
> > > > > +       regs->regs[29] =3D fregs->fp;
> > > > > +       regs->regs[30] =3D fregs->lr;
> > > >
> > > > I see that orig_x0 from pt_regs is used on arm64 to get syscall's
> > > > first parameter. And it seems like this ftrace_regs to pt_regs
> > > > conversion doesn't touch orig_x0 at all. Is it maintained/preserved
> > > > somewhere else, or will we lose the ability to get the first syscal=
l's
> > > > argument?
> > >
> > > Thanks for checking it!
> > >
> > > Does BPF uses kprobe probe to trace syscalls? Since we have raw_sysca=
ll
> > > trace events, no need to use kprobe to do that. (and I don't recommen=
d to
> > > use kprobe to do such fixed event)
> >
> > Yeah, lots of tools and projects actually trace syscalls with kprobes.
> > I don't think there is anything we can do to quickly change that, so
> > we should avoid breaking all of them.
>
> Yes, ah, but anyway, this is the fprobe case, not kprobe. Do you use
> multi_kprobes for tracing syscalls?
>
> Jiri, do you know when the multi-kprobe feature is used? Is that used
> implicitly or explicitly?

ah, ok, so all this fprobe machinery is not used for (single-)kprobes?
This makes it a bit less painful for end users, I believe most syscall
tracing kprobes right now are not multi-kprobes.

>
> >
> > So getting back to my original question, is it possible to preserve ori=
g_x0?
>
> I'm curious that the orig_x0 is stored to pt_regs of the kprobes itself
> because it is not a real register. There is no way to access it. You can
> use regs->x0 instead of that.
>
> I think the orig_x0 is stored when the syscall happened because it has
> another user pt_regs on the stack, right?
>
> If so, we don't need to save orig_x0 on the pt_regs for kprobes, but user=
 can
> dig the stack to find the orig_x0. Here the arm64, syscall entry handler,
>
> static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>                            const syscall_fn_t syscall_table[])
> {
>         unsigned long flags =3D read_thread_flags();
>
>         regs->orig_x0 =3D regs->regs[0];
>         regs->syscallno =3D scno;
>
> (BTW, it seems syscall number is saved on regs->syscallno.)
>
> It seems that if you probe the el0_svc_common() for tracing syscall,
> all you need is tracing $arg1 =3D=3D pt_regs and $arg2 =3D=3D syscall num=
ber.
>
> Thank you,
>
> >
> > >
> > > >
> > > > Looking at libbpf's bpf_tracing.h, other than orig_x0, I think all =
the
> > > > other registers are still preserved, so this seems to be the only
> > > > potential problem.
> > >
> > > Great!
> > >
> > > Thank you,
> > >
> > > >
> > > >
> > > > > +       return regs;
> > > > > +}
> > > > > +
> > > > >  int ftrace_regs_query_register_offset(const char *name);
> > > > >
> > > > >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> > > > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > > > index c0a42d0860b8..a6ed2aa71efc 100644
> > > > > --- a/include/linux/ftrace.h
> > > > > +++ b/include/linux/ftrace.h
> > > > > @@ -165,6 +165,23 @@ static __always_inline struct pt_regs *ftrac=
e_get_regs(struct ftrace_regs *fregs
> > > > >         return arch_ftrace_get_regs(fregs);
> > > > >  }
> > > > >
> > > > > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> > > > > +       defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> > > > > +
> > > > > +static __always_inline struct pt_regs *
> > > > > +ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *r=
egs)
> > > > > +{
> > > > > +       /*
> > > > > +        * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=3Dy, ftrace=
_regs memory
> > > > > +        * layout is the same as pt_regs. So always returns that =
address.
> > > > > +        * Since arch_ftrace_get_regs() will check some members a=
nd may return
> > > > > +        * NULL, we can not use it.
> > > > > +        */
> > > > > +       return &fregs->regs;
> > > > > +}
> > > > > +
> > > > > +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_P=
T_REGS_TO_FTRACE_REGS_CAST */
> > > > > +
> > > > >  /*
> > > > >   * When true, the ftrace_regs_{get,set}_*() functions may be use=
d on fregs.
> > > > >   * Note: this can be true even when ftrace_get_regs() cannot pro=
vide a pt_regs.
> > > > >
> > > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

