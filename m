Return-Path: <bpf+bounces-6637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB84076C0AB
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 01:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8AB281C27
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D736FB1;
	Tue,  1 Aug 2023 23:09:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020F6ABB
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 23:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47EEC433C7;
	Tue,  1 Aug 2023 23:09:22 +0000 (UTC)
Date: Tue, 1 Aug 2023 19:09:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Florent Revest <revest@chromium.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801190920.7a1abfd5@gandalf.local.home>
In-Reply-To: <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
	<CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
	<20230802000228.158f1bd605e497351611739e@kernel.org>
	<20230801112036.0d4ee60d@gandalf.local.home>
	<20230801113240.4e625020@gandalf.local.home>
	<CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Aug 2023 15:18:56 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Aug 1, 2023 at 8:32=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Tue, 1 Aug 2023 11:20:36 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > =20
> > > The solution was to come up with ftrace_regs, which just means it has=
 all
> > > the registers to extract the arguments of a function and nothing more=
. Most =20
> >
> > This isn't 100% true. The ftrace_regs may hold a fully filled pt_regs. =
As
> > the FTRACE_WITH_REGS callbacks still get passed a ftrace_regs pointer. =
They
> > will do:
> >
> >         void callback(..., struct ftrace_regs *fregs) {
> >                 struct pt_regs *regs =3D ftrace_get_regs(fregs);
> >
> >
> > Where ftrace_get_regs() will return the pt_regs only if it is fully fil=
led.
> > If it is not, then it returns NULL. This was what the x86 maintainers
> > agreed with. =20
>=20
> arch/arm64/include/asm/ftrace.h:#define arch_ftrace_get_regs(regs) NULL
>=20
> Ouch. That's very bad.
> We care a lot about bpf running well on arm64.

[ Adding Mark and Florent ]

That's because arm64 doesn't support FTRACE_WITH_REGS anymore. Their
function handlers only care about the arguments. If you want full regs at
function entry, then you need to take a breakpoint hit for a full kprobe.

In fact, fprobes isn't even supported on arm64 because it it doesn't have
DYNAMIC_FTRACE_WITH_REGS. I believe that was the reason Masami was trying
to get it to work with ftrace_regs. To get it to work on arm64.

Again, ftrace_get_regs(fregs) is only suppose to return something if the
pt_regs is fully supplied. If they are not, then it must not be used. Are
you not using a fully filled pt_regs? Because that's what both Thomas and
Peter (also added) told me not to do!

Otherwise, ftrace_regs() has support on arm64 for getting to the argument
registers and the stack. Even live kernel patching now uses ftrace_regs().

>=20
> If you guys decide to convert fprobe to ftrace_regs please
> make it depend on kconfig or something.
> bpf side needs full pt_regs.

Then use kprobes. When I asked Masami what the difference between fprobes
and kprobes was, he told me that it would be that it would no longer rely
on the slower FTRACE_WITH_REGS. But currently, it still does.

The reason I started the FTRACE_WITH_ARGS (which gave us ftrace_regs) in
the first place, was because of the overhead you reported to me with
ftrace_regs_caller and why you wanted to go the direct trampoline approach.
That's when I realized I could use a subset because those registers were
already being saved. The only reason FTRACE_WITH_REGS was created was it
had to supply full pt_regs (including flags) and emulate a breakpoint for
the kprobes interface. But in reality, nothing really needs all that.

> It's not about access to args.
> pt_regs is passed from bpf prog further into all kinds of perf event
> functions including stack walking.

ftrace_regs gives you the stack pointer. Basically, it gives you access to
anything that is required to be saved to do a function call from fentry.

> I think ORC unwinder might depend on availability of all registers.
> Other perf helpers might need it too. Like perf_event_output.
> bpf progs need to access arguments, no doubt about that.
> If ftrace_regs have them exactly in the same offsets as in pt_regs
> that might work transparently for bpf progs, but, I'm afraid,
> it's not the case on all archs.
> So we need full pt_regs to make sure all paths are still working.
>=20
> Adding Jiri and others.

Then I recommend that you give up using fprobes and just stick with kprobes
as that's guaranteed to give you full pt_regs (at the overhead of doing
things like filing in flags and such). And currently for arm64, fprobes can
only work with ftrace_regs, without the full pt_regs.

-- Steve

