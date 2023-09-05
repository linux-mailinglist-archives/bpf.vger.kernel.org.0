Return-Path: <bpf+bounces-9276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DF792F44
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754E51C2094B
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BA8DF4B;
	Tue,  5 Sep 2023 19:50:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8BDDC5
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 19:50:45 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5028E90;
	Tue,  5 Sep 2023 12:50:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-500c7796d8eso4635228e87.1;
        Tue, 05 Sep 2023 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693943441; x=1694548241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg42cbfigBdt6o/PqgzC4zw7MyGmmlKWEgybEwI36h0=;
        b=PufcIXdVMKgGFV7LdnrbomGiBAEq4qLxFAM/1eJbsdAGw8KVB3CUEETAGSZ8IbVUca
         rG1maz8sIK7UdwLoWRdvrrukLhgRM0F5vQ4ya6RX6vzuI5ypeTKdH+zzqz5rswi3spkv
         rWFQWH7Y5u9Cp7Q8bTiwToLNjZ7uW6q0I1VzKclq8EnVaDYYo12ZdYg1qvqG9u/wOjYl
         /rZlIfv7tNdDfE118R/KgRinQngMhdrZFmMf6Rn8UASzCphogpS3bMI2w1OtRq+wZu8O
         qPvlHPkW0zYGm7zuE9CF29uaQPW0rxjhpjveiq7Cr6/obcxg0dz+mkDHeqRVulFnS1He
         KStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693943441; x=1694548241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg42cbfigBdt6o/PqgzC4zw7MyGmmlKWEgybEwI36h0=;
        b=TmadvMWcjfxXrEZo8Xp9vPYoHe6baGNZCtNfExqWeCyYUiPV/JLLI33xTshwcgEFDU
         VzxGTPfF7p/w39UKWBCrcnW1THQQATnFtOBnvc5Qm/RQ6H3pn2a6cU3UzZUg29HG+rsA
         A/uoDdJBzIVTLne837nsB1ZkyrbriWw3jgisAans9tQYPkyWKgMCtDLwpD7awxSY73xR
         zBZqeAUDKlNDAbrVIyEwgryQ/HlA4JMtfoigZZZICmnwkW4igOno8OX+a2JQK8xHZueM
         GY3EeP1B8OD2DZy64nnVp1S7zNoWeAAVSh7WZ1Pw0ovlgdrHaOFFfRLXCI76yj4uNhHB
         K/Sg==
X-Gm-Message-State: AOJu0Yxn6+vfKeARyQFToN/eZL8kSXv1mGRMbRb+7rqswIzdajXX7wQs
	owa4+tFX8CmdexqEqYkmHypqcSAlxKZ8AUqa/B0=
X-Google-Smtp-Source: AGHT+IF6WR559FWXLQFZoFcPQdPkC98OAi3FD7eRhhO0WNrdt335QBVGgagidnRjUoAVIKoReS3/R8R4+YmsltZEcSQ=
X-Received: by 2002:ac2:4d99:0:b0:500:9a29:bcb0 with SMTP id
 g25-20020ac24d99000000b005009a29bcb0mr561337lfe.42.1693943441165; Tue, 05 Sep
 2023 12:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
 <169280378611.282662.4078983611827223131.stgit@devnote2> <CAEf4Bzb9CBnQp1_bEW-DOhw9rpDj6jt79DMmsKL2L4a_4ts9gQ@mail.gmail.com>
 <20230826105632.e3eb35fc69a65ebaf11c7741@kernel.org>
In-Reply-To: <20230826105632.e3eb35fc69a65ebaf11c7741@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Sep 2023 12:50:28 -0700
Message-ID: <CAEf4BzY3dySkeAuOgnNCykZwowbw0ZB9FvM2rE1oBUd_=_U6oA@mail.gmail.com>
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

On Fri, Aug 25, 2023 at 6:56=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Fri, 25 Aug 2023 14:49:48 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Wed, Aug 23, 2023 at 8:16=E2=80=AFAM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > > If the architecture defines its own ftrace_regs, this copies partial
> > > registers to pt_regs and returns it. If not, ftrace_regs is the same =
as
> > > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> > >
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Acked-by: Florent Revest <revest@chromium.org>
> > > ---
> > >  Changes in v3:
> > >   - Fix to use pt_regs::regs instead of x.
> > >   - Return ftrace_regs::regs forcibly if HAVE_PT_REGS_COMPAT_FTRACE_R=
EGS=3Dy.
> > >   - Fix typo.
> > >   - Fix to copy correct registers to the pt_regs on arm64.
> > >  Changes in v4:
> > >   - Change the patch order in the series so that fprobe event can use=
 this.
> > > ---
> > >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> > >  include/linux/ftrace.h          |   17 +++++++++++++++++
> > >  2 files changed, 28 insertions(+)
> > >
> > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm=
/ftrace.h
> > > index ab158196480c..5ad24f315d52 100644
> > > --- a/arch/arm64/include/asm/ftrace.h
> > > +++ b/arch/arm64/include/asm/ftrace.h
> > > @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftra=
ce_regs *fregs)
> > >         fregs->pc =3D fregs->lr;
> > >  }
> > >
> > > +static __always_inline struct pt_regs *
> > > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs =
*regs)
> > > +{
> > > +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 9);
> > > +       regs->sp =3D fregs->sp;
> > > +       regs->pc =3D fregs->pc;
> > > +       regs->regs[29] =3D fregs->fp;
> > > +       regs->regs[30] =3D fregs->lr;
> >
> > I see that orig_x0 from pt_regs is used on arm64 to get syscall's
> > first parameter. And it seems like this ftrace_regs to pt_regs
> > conversion doesn't touch orig_x0 at all. Is it maintained/preserved
> > somewhere else, or will we lose the ability to get the first syscall's
> > argument?
>
> Thanks for checking it!
>
> Does BPF uses kprobe probe to trace syscalls? Since we have raw_syscall
> trace events, no need to use kprobe to do that. (and I don't recommend to
> use kprobe to do such fixed event)

Yeah, lots of tools and projects actually trace syscalls with kprobes.
I don't think there is anything we can do to quickly change that, so
we should avoid breaking all of them.

So getting back to my original question, is it possible to preserve orig_x0=
?

>
> >
> > Looking at libbpf's bpf_tracing.h, other than orig_x0, I think all the
> > other registers are still preserved, so this seems to be the only
> > potential problem.
>
> Great!
>
> Thank you,
>
> >
> >
> > > +       return regs;
> > > +}
> > > +
> > >  int ftrace_regs_query_register_offset(const char *name);
> > >
> > >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index c0a42d0860b8..a6ed2aa71efc 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -165,6 +165,23 @@ static __always_inline struct pt_regs *ftrace_ge=
t_regs(struct ftrace_regs *fregs
> > >         return arch_ftrace_get_regs(fregs);
> > >  }
> > >
> > > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> > > +       defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> > > +
> > > +static __always_inline struct pt_regs *
> > > +ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
> > > +{
> > > +       /*
> > > +        * If CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST=3Dy, ftrace_reg=
s memory
> > > +        * layout is the same as pt_regs. So always returns that addr=
ess.
> > > +        * Since arch_ftrace_get_regs() will check some members and m=
ay return
> > > +        * NULL, we can not use it.
> > > +        */
> > > +       return &fregs->regs;
> > > +}
> > > +
> > > +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_RE=
GS_TO_FTRACE_REGS_CAST */
> > > +
> > >  /*
> > >   * When true, the ftrace_regs_{get,set}_*() functions may be used on=
 fregs.
> > >   * Note: this can be true even when ftrace_get_regs() cannot provide=
 a pt_regs.
> > >
> > >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

