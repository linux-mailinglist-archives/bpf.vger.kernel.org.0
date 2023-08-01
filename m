Return-Path: <bpf+bounces-6551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750B76B5FA
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D162812D0
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBE522EE2;
	Tue,  1 Aug 2023 13:35:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8E1E503
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E6C433C8;
	Tue,  1 Aug 2023 13:35:29 +0000 (UTC)
Date: Tue, 1 Aug 2023 09:35:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801093527.369e046e@gandalf.local.home>
In-Reply-To: <CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230731211527.3bde484d@gandalf.local.home>
	<CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Jul 2023 19:24:25 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jul 31, 2023 at 6:15=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg>
> wrote:
> >
> > On Mon, 31 Jul 2023 14:59:47 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > =20
> > > Assuming that is addressed. How do we merge the series?
> > > The first 3 patches have serious conflicts with bpf trees.
> > >
> > > Maybe send the first 3 with extra selftest for above recursion
> > > targeting bpf-next then we can have a merge commit that Steven can
> > > pull into tracing? =20
> >
> > Would it be possible to do this by basing it off of one of Linus's tags,
> > and doing the merge and conflict resolution in your tree before it gets
> > to Linus?
> >
> > That way we can pull in that clean branch without having to pull in
> > anything else from BPF. I believe Linus prefers this over having tracing
> > having extra changes from BPF that are not yet in his tree. We only need
> > these particular changes, we shouldn't be pulling in anything specific
> > for BPF, as I believe that will cause issues on Linus's side. =20
>=20
> We can try, but I suspect git tricks won't do it.
> Masami's changes depend on patches for kernel/bpf/btf.c that
> are already in bpf-next, so git would have to follow all commits

You mean other patches that Masami has sent are in the bpf tree already and
these are on top of them?

-- Steve

> that touch this file. I don't think git is smart enough to
> thread the needle and split the commit into files. If one commit touches
> btf.c and something else that whole commit becomes a dependency
> that pulls another commit with all files touched by
> the previous commit and so on.
> tbh for this set, the easiest for everyone, is to land the whole thing
> through bpf-next, since there are no conflicts on fprobe side.


