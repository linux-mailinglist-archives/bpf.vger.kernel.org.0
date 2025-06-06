Return-Path: <bpf+bounces-59915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6B4AD0818
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 20:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D12F1899F9C
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0C1F0995;
	Fri,  6 Jun 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlhySpem"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1B11E98F3;
	Fri,  6 Jun 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749234451; cv=none; b=Lsr3K9+JtF9ne8OGD9nGliNj+t7iCbCPBINw/S6sjP+kwl2H0wZ6e2b/vAJdjhXEXkYJ0oqweU4y39/3WqRpH4EMJKu5kog7UE+VFLX7omh+d5pphLVJxwpD2xGBoS7HG+x78fEPWoV/KyELA0p9JjylAugD08m/NMTjxoMZCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749234451; c=relaxed/simple;
	bh=coEURojyF2RYr3/NNYFNcZUu9iisklHxAaAxm1k7pW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACm2hUyPf9CVp9gTpYAmRx0JKcIwwioK0VBzr3gp5OGJnwjVLOGtsEOfufyCCLxc1aFdoLZFueEAuUdqumzWBeIDvsRg3iRYieveyAhnzgYhplXZF6Bi533QEZ2SFfYjuK4P/dU36GgMrPMuF1PTm+KtI9lGAmNtNSDp3aygGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlhySpem; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a3758b122cso1548313f8f.1;
        Fri, 06 Jun 2025 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749234448; x=1749839248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbNInwmCXurTgn6zhiZL579Qtyh8Q8n0xxLohpO7vO0=;
        b=BlhySpem2UcE2W+/TTOwseOJKvRiuz7I/wtUnzaS/wpGhUZoeIiIL80RvY+lc3Harq
         BBU4nnu7ifi/RMGNoBMpXZ7tT0His1ZLVhXsKBjxe2MNKXy4xfyB/cbxq6cleLzCw29X
         8P8+Ef/1xl+JT6ZrnJ4QzGWd2LIpDhjoai29cqxnWDj8FfCzN4cE/UwI+P9W9RioAe4W
         iPnrKcINeI3/4t5RCyew+GKR9cW3L8HqsYTY/xftcy4iuobMgQ+yMtMnNgtzfuBgoKCW
         4v7IsN4tX1WtjlZF8Rxt0Y49zJShyU/FF7D3HO64KWuVUOCIgzjsFYKxgbfaAgPzNxH+
         Zk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749234448; x=1749839248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbNInwmCXurTgn6zhiZL579Qtyh8Q8n0xxLohpO7vO0=;
        b=fJ2JCJgdWq3jccwC61AsZYgNFjSZstIy4i0j+QkoI6C/fW1cA/KTmQsIlxHlblNls7
         DgATlghe6ZCVjc5hViirVhHLQOTC1K7JgR64aa2HmfXOYfKKri1X4185BO+xDVU8bK+k
         aMn6BIsjgqFuo8xwWI5/fCgfT4WXVBk/y2vqWBLjbdTtRwnOmNkVIb5ZoiSOY8JP4tv7
         9Yro5ukIAvj5COtlO71jr4JjBQVj5uYQCPAoeoeIwo9VJuawgEjEWLT5WCCxLkwxn4To
         mnH1nU1e9dnDQSZhSlFFy8MQmuW81cCkP67yQ/Afe3VtGz6k1Xi/HOWTTK8gF7wkpCOn
         BJXA==
X-Forwarded-Encrypted: i=1; AJvYcCVqYhdX2nf4bb3y0t5WoTZrK9LJdb5gJmUQJEM/goF2wQbkot5KjZD1T03myzZTi2ToJplDN5otHxrUG9lk@vger.kernel.org, AJvYcCVzcaeHUM1BT4amATmtpI1kimsvuroy2ictiZrXkcWj8zcZVuSwN6DyGpqhBBqgr7r3j1HEMvpZwIgrzkqZf0KklA==@vger.kernel.org, AJvYcCXRWkNNpYCy4NKLG/uTPM2gaueoApJvVNhhszrlwcuDcNwqwhu32NeJdcEAVBgQ/Tjijxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydtko+e4ymTr1CI6s93gKcRHCZF3dSiPJVRM3GQR1TsnRAKuS4
	VkjUD0z+Xy8w9HuAISoBEWcHctxxrU8qLwZ0DZWcSMTPeqZFwbPl1VeGA2SHsSQTipzJgkdSDVx
	7YeDQ82PwEwhFIfYuqSO/IHpvUfYEBLk=
X-Gm-Gg: ASbGnctcVFO+sbc8LJQjlXKzBNv85CXhHBpfaGPabOzx1mxf+mNi7pN1LcUotyLdRQD
	kcQ5la0wMJ9Xz2iu6zGp+IC6H0hMu71h/dtcKXiSB9SX5SzJHZR8ge4/rxko8kyvgnBYF/9eAuq
	p+/2QwU7d7KsFlcXpDtf1S6MAN5BGtemePs7GCgLyPc+z2xszDLHQXBAuhkr7WOPmbTk0zvsve
X-Google-Smtp-Source: AGHT+IFDfg5zQNFFQhQ3znGa/eV6pg5oooCOcd3jscmyAaPp0/p7fZ9C2+elcLblHORV0vFrWJtDiExcvoa0BG3+RCo=
X-Received: by 2002:a05:6000:220d:b0:3a4:f7f3:2d02 with SMTP id
 ffacd0b85a97d-3a531abdf59mr3483496f8f.17.1749234448058; Fri, 06 Jun 2025
 11:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529065537.529937-1-howardchu95@gmail.com>
 <aDpBTLoeOJ3NAw_-@google.com> <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
 <20250602181743.1c3dabea@gandalf.local.home> <aEAfHYLEyc7xGy7E@krava>
In-Reply-To: <aEAfHYLEyc7xGy7E@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 11:27:16 -0700
X-Gm-Features: AX0GCFtu_4copkwLu7w1Y3LJbOxFzibxvD5MnH8zkQWQwdSOwtRB3Lw8U1qWBHA
Message-ID: <CAADnVQJBG=nHRCJBcxXuEjpNp8iy1CD+Hg=g571uOTr61b8Peg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jun 02, 2025 at 06:17:43PM -0400, Steven Rostedt wrote:
> > On Fri, 30 May 2025 17:00:38 -0700
> > Howard Chu <howardchu95@gmail.com> wrote:
> >
> > > Hello Namhyung,
> > >
> > > On Fri, May 30, 2025 at 4:37=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > (Adding tracing folks)
> > >
> > > (That's so convenient wow)
> >
> > Shouldn't the BPF folks be more relevant. I don't see any of the tracin=
g
> > code involved here.
> >
> > >
> > > >
> > > > On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:
> > > > > perf trace utilizes the tracepoint utility, the only filter in pe=
rf
> > > > > trace is a filter on syscall type. For example, if perf traces on=
ly
> > > > > openat, then it filters all the other syscalls, such as readlinka=
t,
> > > > > readv, etc.
> > > > >
> > > > > This filtering is flawed. Consider this case: two perf trace
> > > > > instances are running at the same time, trace instance A tracing
> > > > > readlinkat, trace instance B tracing openat. When an openat sysca=
ll
> > > > > enters, it triggers both BPF programs (sys_enter) in both perf tr=
ace
> > > > > instances, these kernel functions will be executed:
> > > > >
> > > > > perf_syscall_enter
> > > > >   perf_call_bpf_enter
> > > > >     trace_call_bpf
> >
> > This is in bpf_trace.c (BPF related, not tracing related).
> >
> > -- Steve
> >
> >
> > > > >       bpf_prog_run_array
> > > > >
> > > > > In bpf_prog_run_array:
> > > > > ~~~
> > > > > while ((prog =3D READ_ONCE(item->prog))) {
> > > > >       run_ctx.bpf_cookie =3D item->bpf_cookie;
> > > > >       ret &=3D run_prog(prog, ctx);
> > > > >       item++;
> > > > > }
> > > > > ~~~
> > > > >
> > > > > I'm not a BPF expert, but by tinkering I found that if one of the=
 BPF
> > > > > programs returns 0, there will be no tracepoint sample. That is,
> > > > >
> > > > > (Is there a sample?) =3D ProgRetA & ProgRetB & ProgRetC
> > > > >
> > > > > Where ProgRetA is the return value of one of the BPF programs in =
the BPF
> > > > > program array.
> > > > >
> > > > > Go back to the case, when two perf trace instances are tracing tw=
o
> > > > > different syscalls, again, A is tracing readlinkat, B is tracing =
openat,
> > > > > when an openat syscall enters, it triggers the sys_enter program =
in
> > > > > instance A, call it ProgA, and the sys_enter program in instance =
B,
> > > > > ProgB, now ProgA will return 0 because ProgA cares about readlink=
at only,
> > > > > even though ProgB returns 1; (Is there a sample?) =3D ProgRetA (0=
) &
> > > > > ProgRetB (1) =3D 0. So there won't be a tracepoint sample in B's =
output,
> > > > > when there really should be one.
> > > >
> > > > Sounds like a bug.  I think it should run bpf programs attached to =
the
> > > > current perf_event only.  Isn't it the case for tracepoint + perf +=
 bpf?
> > >
> > > I really can't answer that question.
>
> bpf programs for tracepoint are executed before the perf event specific
> check/trigger in perf_trace_run_bpf_submit
>
> bpf programs array is part of struct trace_event_call so it's global per
> tracepoint, not per perf event

right.
looks like perf is attaching two different progs to the same sys_enter
tracepoint and one of them returns 0.
That's expected behavior.
The rule is all-yes-is-yes, any-no-is-no.
We apply this logic to majority (if not all) bpf prog return values.

> IIRC perf trace needs the perf event sample and the bpf program is there
> to do the filter and some other related stuff?
>
> if that's the case I wonder we could switch bpf_prog_run_array logic
> to be permissive like below, and perhaps make that as tracepoint specific
> change, because bpf_prog_run_array is used in other place

No. That might break somebody and we don't want to deviate from the rule.

> or make it somehow configurable.. otherwise I fear that might break exist=
ing
> use cases.. FWIW bpf ci tests [1] survived the change below
>
> jirka
>
>
> [1] https://github.com/kernel-patches/bpf/pull/9044
>
> ---
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5b25d278409b..4ca8afe0217c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2218,12 +2218,12 @@ bpf_prog_run_array(const struct bpf_prog_array *a=
rray,
>         const struct bpf_prog *prog;
>         struct bpf_run_ctx *old_run_ctx;
>         struct bpf_trace_run_ctx run_ctx;
> -       u32 ret =3D 1;
> +       u32 ret =3D 0;
>
>         RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
>
>         if (unlikely(!array))
> -               return ret;
> +               return 1;
>
>         run_ctx.is_uprobe =3D false;
>
> @@ -2232,7 +2232,7 @@ bpf_prog_run_array(const struct bpf_prog_array *arr=
ay,
>         item =3D &array->items[0];
>         while ((prog =3D READ_ONCE(item->prog))) {
>                 run_ctx.bpf_cookie =3D item->bpf_cookie;
> -               ret &=3D run_prog(prog, ctx);
> +               ret |=3D run_prog(prog, ctx);
>                 item++;
>         }
>         bpf_reset_run_ctx(old_run_ctx);
>

