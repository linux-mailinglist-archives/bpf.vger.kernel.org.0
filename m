Return-Path: <bpf+bounces-6751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43B76D86D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 22:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724B0281E02
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D10111B4;
	Wed,  2 Aug 2023 20:12:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265210793
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 20:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB70C433C7;
	Wed,  2 Aug 2023 20:12:21 +0000 (UTC)
Date: Wed, 2 Aug 2023 16:12:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Florent Revest <revest@chromium.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230802161220.579b2220@gandalf.local.home>
In-Reply-To: <CAADnVQKrL3LZaRcgoTdGN-csPt=eyujPbw9qoxgv9tPYPmZiZA@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
	<CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
	<20230802000228.158f1bd605e497351611739e@kernel.org>
	<20230801112036.0d4ee60d@gandalf.local.home>
	<20230801113240.4e625020@gandalf.local.home>
	<CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
	<20230801190920.7a1abfd5@gandalf.local.home>
	<20230802092146.9bda5e49528e6988ab97899c@kernel.org>
	<20230801204054.3884688e@rorschach.local.home>
	<20230802225634.f520080cd9de759d687a2b0a@kernel.org>
	<CAADnVQLqXjJvCcuQLVz8HxF050jDHaSa2D7cehoYtjXdp3wGLQ@mail.gmail.com>
	<20230802143845.3ce6ed61@gandalf.local.home>
	<CAADnVQKrL3LZaRcgoTdGN-csPt=eyujPbw9qoxgv9tPYPmZiZA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Aug 2023 12:48:14 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Aug 2, 2023 at 11:38=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Wed, 2 Aug 2023 11:24:12 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > This is a non starter.
> > > bpf progs expect arch dependent 'struct pt_regs *' and we cannot chan=
ge that. =20
> >
> > If the progs are compiled into native code, isn't there optimizations t=
hat
> > could be done? That is, if ftrace_regs is available, and the bpf progra=
m is
> > just using the subset of pt_regs, is it possible that it could be compi=
led
> > to use ftrace_regs?
> >
> > Forgive my ignorance on how BPF programs turn into executables when run=
ning
> > in the kernel. =20
>=20
> Right. It's possible for the verifier to do an offset rewrite,
> forbid certain access, always return 0 on load from certain offset,
> and so on.
> It's all non trivial amount of work.
> ftrace_partial_regs() from ftrace_regs into pt_regs is so much simpler.

Sure, and the copy could be the solution we have in the near future, but if
we could optimize it in the future, then perhaps it would be worth doing it.

Also, how are the bpf programs referencing the pt_regs? Could a ftrace_regs
API be added too? If the verifier sees that the program is using
ftrace_regs, it could then use the lighter weight fprobes for access,
otherwise it falls back to the kprobe version.

-- Steve

