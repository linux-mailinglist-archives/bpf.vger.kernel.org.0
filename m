Return-Path: <bpf+bounces-49877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB93A1DC74
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 20:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB688161D2F
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 19:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF018FDD5;
	Mon, 27 Jan 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD3Xdq8A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533F18F2EF
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004981; cv=none; b=Gat/8CUy9S20kgp+HF+19Xi4p4FOPIcl8M70TQGSYd3Zq3YJSe3yCndF7420BMN4g8kXbccRKMOi/+Sy04BBImeJV9OR0ZPCQk6/SMmM7/nEKjRDtrtxZK/nr8dKeSrc5L3+UaZPA1+K9yf/6l6Dx84zBAyi4n0gBp/N0bDXClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004981; c=relaxed/simple;
	bh=WCBi0uFA1w/vrQyPc9Md8iAVsBqAF3gkrX0hr2MnRxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/t54NcL4xo2h4ou4UxLAKXdiZcwDaf7i2mvWfpe9EyWv1bOBjCMFxwtBcvE3ft4hYn/1b4+HfrL6MbAW2VlCIKNVQUk0tYtPLlPgLLqTidoMMCWVGfGWaNE0zIpKpePBzkvAdJfgMutJqgCkkpXgLmXeEfzQ/ZHqb2KerWXNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD3Xdq8A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so88979245ad.0
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 11:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004979; x=1738609779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5d0HiSQfoxLwelA3zsPdRYSx5mlXCq7nXU6pGffMQ8=;
        b=YD3Xdq8A2yLcUmHFOKQrIUuOf1GbjFhcfMzTSH6AniOg2eorPBpt3k/tA/r/egrH/o
         TovzewvOh/7QtScxnUvnhZsmao/a+L/sxdTYy4ti83MtlO15ZxvBfRL1BW/gSr0fNSa7
         W7tTDNclEzT9Ta4OnftuYYP4lBcoYgJ/P1pl4WO9SE8qe01161wi/vu1jsNAzO7YQfen
         PAyvyaipiwBGY40fGP9NLn4OVDH+LLJ7E0fFAoqQ35F4lBeG+GjRl0AOpwdC14NkLmse
         ugctG/bHIQ1IPYdfSnAwDExuLVLZ6K7yC+mzJGgnECmU6l560AddEXhVziZVOkWaPUq7
         qGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004979; x=1738609779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5d0HiSQfoxLwelA3zsPdRYSx5mlXCq7nXU6pGffMQ8=;
        b=r0ezMFhgouqfgXkrBOrnePGMpCzV8fdC/Uzjs29MjIo51Cn8FaWL+tW31JkBoJ1vAa
         Yi/h85PD8Pc2msoiz4XAe3Sv17lFs6ildp2B6VPXceOULikStd+bqld7RGPNe5z3xHxB
         3GtNLWnqKGWvP7f3B+tXXkJ+1mR43ykCCXyvelRbxtIsFgGfzmMPavY+GVFCmgv0rd2Q
         j5ZvvdF4wqXlTF17gvLnJr81eDrf7HdOMG4uHeYpIm8An6o93XA//ed0jPHWSFLdwHvz
         g0gU3g4MH53AEQjt4G8GaO5ERQvPUGc/NCwyCJO/Y6vJ+eiyotVCYfu8oNCgZsTBbowj
         W8bg==
X-Forwarded-Encrypted: i=1; AJvYcCViXTqNQZ+DtBaX9oq6NsxWPdqFTT8kGmQJjalXxzTm7f0wQ7iyoTFK56VtdKzcw2iSHog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytDbYHMBAZNv661QZg7Bxz+fKKTrKyAp/rxeVFcwxCrznTelL
	efPUBKofM8d6A+UexFK3jYKL8wGdy5CWIcO3mdP9sr8BneCqEzmXdFX7EESr6YfCd+z+1nL9JmU
	jileIUc40W6gJHri5MuW3VsXhkKY=
X-Gm-Gg: ASbGncuwnfzfeqqAsGz59ej7e4y86khG+MH6foZHSckQ135om+qCOm5tabKtZhOQFNz
	go7fyqt+AB1iOvAUfzsf/W15venPg2wgQ17YYTnopW9o+Za9tRX0lQHfjxOcp3kT75ZPDd/LAPp
	HnXg==
X-Google-Smtp-Source: AGHT+IEqz1gSZEP46cE9+4SpNWjg6x9NTZ7baVQ8MKeY65rzY+AY6cjEnooW5vvzsQwegMcmHPHiWuBN/YpqQ/dTYrk=
X-Received: by 2002:a05:6a21:32a9:b0:1d9:2705:699e with SMTP id
 adf61e73a8af0-1eb2145cbc3mr69578445637.7.1738004979231; Mon, 27 Jan 2025
 11:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>
 <Z5N4N6MUMt8_EwGS@krava> <Z5O0shrdgeExZ2kF@krava> <20250126234005.70cb3b43193b08ed8a211553@kernel.org>
 <Z5ax5AKwIaD6ONM-@krava>
In-Reply-To: <Z5ax5AKwIaD6ONM-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 11:09:27 -0800
X-Gm-Features: AWEUYZkI_0NRrpmqwg3tN4azmDFz6Ft_TQJHEHH9DrHGwDS35r51lT3pTnHqpxE
Message-ID: <CAEf4BzaT8Vw+82b974S_7pDUjA+PGYKsoSzoTuO33ZQJwgrcMA@mail.gmail.com>
Subject: Re: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 2:06=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Jan 26, 2025 at 11:40:05PM +0900, Masami Hiramatsu wrote:
> > On Fri, 24 Jan 2025 16:41:38 +0100
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > On Fri, Jan 24, 2025 at 12:23:35PM +0100, Jiri Olsa wrote:
> > > > On Thu, Jan 23, 2025 at 02:32:38PM -0800, Martin KaFai Lau wrote:
> > > > > Hi Jiri,
> > > > >
> > > > > The "missed/kprobe_recursion" fails consistently on s390. It seem=
s to start
> > > > > failing after the recent bpf and bpf-next tree ffwd.
> > > > >
> > > > > An example:
> > > > > https://github.com/kernel-patches/bpf/actions/runs/12934431612/jo=
b/36076956920
> > > > >
> > > > > Can you help to take a look?
> > > > >
> > > > > afaict, it only happens on s390 so far, so cc IIya if there is an=
y recent
> > > > > change that may ring the bell.
> > > >
> > > > hi,
> > > > I need to check more but I wonder it's the:
> > > >   7495e179b478 s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> > > >
> > > > which seems to add recursion check and bail out before we have
> > > > a chance to trigger it in bpf code
> > >
> > > so the test attaches bpf program test1 to bpf_fentry_test1 via kprobe=
.multi
> > >
> > >     SEC("kprobe.multi/bpf_fentry_test1")
> > >     int test1(struct pt_regs *ctx)
> > >     {
> > >             bpf_kfunc_common_test();
> > >             return 0;
> > >     }
> > >
> > > and several other programs are attached to bpf_kfunc_common_test func=
tion
> > >
> > >
> > > I can't test this on s390, but looks like following is happening:
> > >
> > > kprobe.multi uses fprobe, so the test kernel path goes:
> > >
> > >     bpf_fentry_test1
> > >       ftrace_graph_func
> > >         function_graph_enter_regs
> > >        fprobe_entry
> > >          kprobe_multi_link_prog_run
> > >            test1 (bpf program)
> > >              bpf_kfunc_common_test
> > >                kprobe_ftrace_handler
> > >                  kprobe_perf_func
> > >                    trace_call_bpf
> > >                      -> bpf_prog_active check fails, missed count is =
incremented
> > >
> > >
> > > kprobe_ftrace_handler calls/takes ftrace_test_recursion_trylock (ftra=
ce recursion lock)
> > >
> > > but s390 now calls/takes ftrace_test_recursion_trylock already in ftr=
ace_graph_func,
> > > so s390 stops at kprobe_ftrace_handler and does not get to trace_call=
_bpf to increment
> > > prog->missed counters
> >
> > Oops, good catch! I missed to remove it from s390. We've already moved =
it
> > in function_graph_enter_regs().
> >
> >
> > >
> > > adding Sven, Masami, any idea?
> > >
> > > if the ftrace_test_recursion_trylock is needed ftrace_graph_func on s=
390, then
> > > I think we will need to fix our test to skip s390 arch
> >
> > Yes. Please try this patch;
> >
> >
> > From 12fcda79d0b1082449d5f7cfb8039b0237cf246d Mon Sep 17 00:00:00 2001
> > From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> > Date: Sun, 26 Jan 2025 23:38:59 +0900
> > Subject: [PATCH] s390: fgraph: Fix to remove ftrace_test_recursion_tryl=
ock()
> >
> > Fix to remove ftrace_test_recursion_trylock() from ftrace_graph_func()
> > because commit d576aec24df9 ("fgraph: Get ftrace recursion lock in
> > function_graph_enter") has been moved it to function_graph_enter_regs()
> > already.
> >
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > Fixes: d576aec24df9 ("fgraph: Get ftrace recursion lock in function_gra=
ph_enter")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> great, ci is passing with this fix
>
> Tested-by: Jiri Olsa <jolsa@kernel.org>

Masami,

Are you going to land this fix in your tree? We can create a temporary
patch for BPF CI once you have the commit in the tree.

>
> thanks,
> jirka
>
>
> > ---
> >  arch/s390/kernel/ftrace.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
> > index c0b2c97efefb..63ba6306632e 100644
> > --- a/arch/s390/kernel/ftrace.c
> > +++ b/arch/s390/kernel/ftrace.c
> > @@ -266,18 +266,13 @@ void ftrace_graph_func(unsigned long ip, unsigned=
 long parent_ip,
> >                      struct ftrace_ops *op, struct ftrace_regs *fregs)
> >  {
> >       unsigned long *parent =3D &arch_ftrace_regs(fregs)->regs.gprs[14]=
;
> > -     int bit;
> >
> >       if (unlikely(ftrace_graph_is_dead()))
> >               return;
> >       if (unlikely(atomic_read(&current->tracing_graph_pause)))
> >               return;
> > -     bit =3D ftrace_test_recursion_trylock(ip, *parent);
> > -     if (bit < 0)
> > -             return;
> >       if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
> >               *parent =3D (unsigned long)&return_to_handler;
> > -     ftrace_test_recursion_unlock(bit);
> >  }
> >
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> > --
> > 2.43.0
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

