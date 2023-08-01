Return-Path: <bpf+bounces-6638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7276C0B5
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 01:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB74E1C210BC
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88028821;
	Tue,  1 Aug 2023 23:17:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DD440C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 23:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6D6C433C8;
	Tue,  1 Aug 2023 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690931836;
	bh=88zkvAVDUFWqbW4oJyMLFNy3ju90g2621RUrlMf/Du0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YZTL4fESnAxnkfayIkA5m25sZobaFGsMuDbvhwbG5rk32Vrh/STz+FnVSkmRMuneR
	 sNDPe0AfCByyN7A7sI+zabf/sz1wHHpJp719Xh9zJaO8YwHmxP6MMEEgRMx6BqLg9Y
	 x0LnEGIn+udJHza1m+Ox1PEJI/FGssHLoQ6sNzPnvFb1fwoWU1W/bn4bofvQipirdz
	 7yD8wix5G3U6I9Ki/FRdqSdy+SCW4O1txJ+KJiBwDrX6F3gy1lxajt8wej6Q44FohZ
	 XWS6J6x0izVWJs3g5B4UgglwJ7BJyZy8teHdN+sEbDv/KNA2TJ2lgq5vIZjMx+cOZp
	 6vPF/jmjp2Y0w==
Date: Wed, 2 Aug 2023 08:17:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230802081711.7711f8775ffc730b2c32df5e@kernel.org>
In-Reply-To: <CAADnVQJ2ixjZUY7hJJMM1iUBAYY2VxdL6v--Rg8wvKypfxBsGw@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230731211527.3bde484d@gandalf.local.home>
	<CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
	<20230802001824.90819c7355283843178d9163@kernel.org>
	<CAADnVQJ2ixjZUY7hJJMM1iUBAYY2VxdL6v--Rg8wvKypfxBsGw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 1 Aug 2023 15:21:59 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Aug 1, 2023 at 8:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 31 Jul 2023 19:24:25 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Mon, Jul 31, 2023 at 6:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Mon, 31 Jul 2023 14:59:47 -0700
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > > Assuming that is addressed. How do we merge the series?
> > > > > The first 3 patches have serious conflicts with bpf trees.
> > > > >
> > > > > Maybe send the first 3 with extra selftest for above recursion
> > > > > targeting bpf-next then we can have a merge commit that Steven can pull
> > > > > into tracing?
> > > >
> > > > Would it be possible to do this by basing it off of one of Linus's tags,
> > > > and doing the merge and conflict resolution in your tree before it gets to
> > > > Linus?
> > > >
> > > > That way we can pull in that clean branch without having to pull in
> > > > anything else from BPF. I believe Linus prefers this over having tracing
> > > > having extra changes from BPF that are not yet in his tree. We only need
> > > > these particular changes, we shouldn't be pulling in anything specific for
> > > > BPF, as I believe that will cause issues on Linus's side.
> > >
> > > We can try, but I suspect git tricks won't do it.
> > > Masami's changes depend on patches for kernel/bpf/btf.c that
> > > are already in bpf-next, so git would have to follow all commits
> > > that touch this file.
> >
> > This point is strange. I'm working on probe/fixes which is based on
> > v6.5-rc3, so any bpf-next change should not be involved. Can you recheck
> > this point?
> >
> > > I don't think git is smart enough to
> > > thread the needle and split the commit into files. If one commit touches
> > > btf.c and something else that whole commit becomes a dependency
> > > that pulls another commit with all files touched by
> > > the previous commit and so on.
> >
> > As far as I understand Steve's method, we will have an intermediate branch
> > on bpf or probe tree, like
> >
> > linus(some common commit) ---- probes/btf-find-api
> >
> > and merge it to both bpf-next and probes/for-next branch
> >
> >           +----------------------bpf-next --- (merge bpf patches)
> >          /                       / merge
> > common -/\ probes/btf-find-api -/-\
> >           \                        \ merge
> >            +----------------------probes/for-next --- (merge probe patches)
> >
> > Thus, we can merge both for-next branches at next merge window without
> > any issue. (But, yes, this is not simple, and needs maxium care)
> 
> Sounds like the path of least resistance is to keep the changes
> in kernel/trace and consolidate with kernel/bpf/btf.c after the next
> merge window.

OK, sounds good to me. I will only expose the bpf_find_btf_id() then.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

