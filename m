Return-Path: <bpf+bounces-256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7EE6FCC3D
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED269281370
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A91AF9F2;
	Tue,  9 May 2023 17:01:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D317FE0
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 17:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817A2C433D2;
	Tue,  9 May 2023 17:01:13 +0000 (UTC)
Date: Tue, 9 May 2023 13:01:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, David Vernet
 <void@manifault.com>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
Message-ID: <20230509130111.62d587f1@rorschach.local.home>
In-Reply-To: <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
References: <20230508163751.841-1-beaub@linux.microsoft.com>
	<CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 May 2023 08:24:29 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, May 8, 2023 at 9:38=E2=80=AFAM Beau Belgrave <beaub@linux.microso=
ft.com> wrote:
> >
> > Programs that utilize user_events today only get the event payloads via
> > perf or ftrace when writing event data. When BPF programs are attached
> > to tracepoints created by user_events the BPF programs do not get run
> > even though the attach succeeds. This causes confusion by the users of
> > the programs, as they expect the data to be available via BPF programs
> > they write. We have several projects that have hit this and requested
> > BPF program support when publishing data via user_events from their
> > user processes in production.
> >
> > Swap out perf_trace_buf_submit() for perf_trace_run_bpf_submit() to
> > ensure BPF programs that are attached are run in addition to writing to
> > perf or ftrace buffers. This requires no changes to the BPF infrastruct=
ure
> > and only utilizes the GPL exported function that modules and other
> > components may use for the same purpose. This keeps user_events consist=
ent
> > with how other kernel, modules, and probes expose tracepoint data to al=
low
> > attachment of a BPF program. =20
>=20
> Sorry, I have to keep my Nack here.
>=20
> I see no practical use case for bpf progs to be connected to user events.

That's not a technical reason. Obviously they have a use case.

This is only connecting to BPF through the API. It makes no changes to
BPF itself, so I'm not sure your NACK has jurisdiction here. Their
alternative is to to do it with an external module as the only
connections to BPF it uses is via an EXPORT_SYMBOL_GPL() function!

Again, what is your technical reason for nacking this? It's like me
nacking a user of ftrace because I don't see a use case for it. That's
not a valid reason to issue a nack.

>=20
> There must be a different way to solve your user needs
> and this is not bpf.

Why not use BPF?

-- Steve

