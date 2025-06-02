Return-Path: <bpf+bounces-59459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF76ACBD2A
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 00:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5329516C098
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF801E521A;
	Mon,  2 Jun 2025 22:16:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D82C3254;
	Mon,  2 Jun 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748902596; cv=none; b=rXFO93M3xTFgDFXxiJ13h5T+jatscxKLqle9BmvMdu+hdbrKA/1q+3pnsDCGFjNIW1EhT15NBFwCpNSVClldue+W9Z4xQRz3lKpEkFzMQDMg4Fi0mrByaq6Z2bB8XFk5e/KVJlXcxB7Q+NlJd/jusIunV5/apRmyRLVo9auCzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748902596; c=relaxed/simple;
	bh=SjiaE8Mx135bBY5XzHbSmvcZrGy8SqtHZrrGihjp0MM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itKw3pxss8T7vtR+B74X8jg++87uWqgvCi+t4pIDQ/Jlqyqb0ZNwIaVgOFra8FRrdvfquay7V+Oq5HUf1fukA/O4wQsmI+Ex1m9I/5ZJew547i6Wfit/bJOdq3FfxANlwm7Ljh0RXvCnc16M4fhQFwXNDRPQ0aVTwzf3WjGfWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FD6C4CEEB;
	Mon,  2 Jun 2025 22:16:31 +0000 (UTC)
Date: Mon, 2 Jun 2025 18:17:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, acme@kernel.org, mingo@redhat.com,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
 bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
Message-ID: <20250602181743.1c3dabea@gandalf.local.home>
In-Reply-To: <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
References: <20250529065537.529937-1-howardchu95@gmail.com>
	<aDpBTLoeOJ3NAw_-@google.com>
	<CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 May 2025 17:00:38 -0700
Howard Chu <howardchu95@gmail.com> wrote:

> Hello Namhyung,
>=20
> On Fri, May 30, 2025 at 4:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > (Adding tracing folks) =20
>=20
> (That's so convenient wow)

Shouldn't the BPF folks be more relevant. I don't see any of the tracing
code involved here.

>=20
> >
> > On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote: =20
> > > perf trace utilizes the tracepoint utility, the only filter in perf
> > > trace is a filter on syscall type. For example, if perf traces only
> > > openat, then it filters all the other syscalls, such as readlinkat,
> > > readv, etc.
> > >
> > > This filtering is flawed. Consider this case: two perf trace
> > > instances are running at the same time, trace instance A tracing
> > > readlinkat, trace instance B tracing openat. When an openat syscall
> > > enters, it triggers both BPF programs (sys_enter) in both perf trace
> > > instances, these kernel functions will be executed:
> > >
> > > perf_syscall_enter
> > >   perf_call_bpf_enter
> > >     trace_call_bpf

This is in bpf_trace.c (BPF related, not tracing related).

-- Steve


> > >       bpf_prog_run_array
> > >
> > > In bpf_prog_run_array:
> > > ~~~
> > > while ((prog =3D READ_ONCE(item->prog))) {
> > >       run_ctx.bpf_cookie =3D item->bpf_cookie;
> > >       ret &=3D run_prog(prog, ctx);
> > >       item++;
> > > }
> > > ~~~
> > >
> > > I'm not a BPF expert, but by tinkering I found that if one of the BPF
> > > programs returns 0, there will be no tracepoint sample. That is,
> > >
> > > (Is there a sample?) =3D ProgRetA & ProgRetB & ProgRetC
> > >
> > > Where ProgRetA is the return value of one of the BPF programs in the =
BPF
> > > program array.
> > >
> > > Go back to the case, when two perf trace instances are tracing two
> > > different syscalls, again, A is tracing readlinkat, B is tracing open=
at,
> > > when an openat syscall enters, it triggers the sys_enter program in
> > > instance A, call it ProgA, and the sys_enter program in instance B,
> > > ProgB, now ProgA will return 0 because ProgA cares about readlinkat o=
nly,
> > > even though ProgB returns 1; (Is there a sample?) =3D ProgRetA (0) &
> > > ProgRetB (1) =3D 0. So there won't be a tracepoint sample in B's outp=
ut,
> > > when there really should be one. =20
> >
> > Sounds like a bug.  I think it should run bpf programs attached to the
> > current perf_event only.  Isn't it the case for tracepoint + perf + bpf=
? =20
>=20
> I really can't answer that question.
>=20
> > =20
> > >
> > > I also want to point out that openat and readlinkat have augmented
> > > output, so my example might not be accurate, but it does explain the
> > > current perf-trace-in-parallel dilemma.
> > >
> > > Now for augmented output, it is different. When it calls
> > > bpf_perf_event_output, there is a sample. There won't be no ProgRetA &
> > > ProgRetB... thing. So I will send another RFC patch to enable
> > > parallelism using this feature. Also, augmented_output creates a samp=
le
> > > on it's own, so returning 1 will create a duplicated sample, when
> > > augmented, just return 0 instead. =20
> >
> > Yes, it's bpf-output and tracepoint respectively.  Maybe we should
> > always return 1 not to drop syscalls unintentionally and perf can
> > discard duplicated samples. =20
>=20
> I like this.
>=20
> >
> > Another approach would be return 0 always and use bpf-output for
> > unaugmented syscalls too.  But I'm afraid it'd affect other perf tools
> > using tracepoints. =20
>=20
> Yep.
>=20
> > =20
> > >
> > > Is this approach perfect? Absolutely not, there will likely be some
> > > performance overhead on the kernel side. It is just a quick dirty fix
> > > that makes perf trace run in parallel without failing. This patch is =
an
> > > explanation on the reason of failures and possibly, a link used in a
> > > nack comment. =20
> >
> > Thanks for your work, but I'm afraid it'd still miss some syscalls as it
> > returns 0 sometimes. =20
>=20
> My bad... For example this:
>=20
> if (pid_filter__has(&pids_filtered, getpid()))
>    return 0;
>=20
> This patch is practically meaningless, but it passes the parallel tests.
>=20
> Thanks,
> Howard


