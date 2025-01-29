Return-Path: <bpf+bounces-50037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD13A22206
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558477A183F
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B91DF75C;
	Wed, 29 Jan 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="U9hDD9mF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LBrTDyEr"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E101DE892;
	Wed, 29 Jan 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169226; cv=none; b=WTLmu8diIpKCWg158PfS3Z+zYnhmlCycAGj4MS/ZESnhnM5ixG1Gxj8ENnnapNw42SpYlLZXMmgKeYdT68NP7wCZD/fULFEWySzFZTFRiK1Rzl6B+KK6AMZ+SSWmVOcDI1xLVAOuB08CJ2uQ4TbDoFyUJuT7q8Fq7/SY+2MD2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169226; c=relaxed/simple;
	bh=r1nG52j9rH5FCWzEjjRLiGuF+MRwAEw2xmFk2SM8rMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us0YviHC1gJfiYIjk8Ax7ZOdMgLgTQ6IVHONVuCRT7POZ6Mjjs/MzibJsNbfZ7w1mBEzdUPO5ahFezyU8WNwnzKKWd4ifmRwG1GmhgRPNX1a00lQbFJS1CF6Bkhj3Jg0loIVGqdUYZMWpiKnJOiMwaQZFAO/vlk5BkBp0kl6DBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=U9hDD9mF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LBrTDyEr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 397321380B1F;
	Wed, 29 Jan 2025 11:47:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jan 2025 11:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738169222;
	 x=1738255622; bh=hxHNdS7WS0R6RbySdyoltquzgKovzLwAMtD/wCqj+rw=; b=
	U9hDD9mFL2aSc9BQcw/Eqm3mgMLVqKE0fkRF7wL98R0gWrMtIA+by/gvelFG7lHO
	hJ3F2jFIliIi294xipHz/raU3hKqp8SSaqFoIKg4FhxH0yM4GC95FsQvfCRKcxdv
	b5Pk3rMvyuKDqh7aL/nwmoD6z9q9exZD/Dsvqic9mZaoprgBECqUm8EKagK19EAM
	mhK07xmum4wk9WzYjE3ZZoxoHfKhQiDZ+jKo06chwqheq8fq9s1l49uie8Tqu1uZ
	J5MrZBQcGCVnLVUMBWDbYZgs8263ihd349OYhUDi0MzZv2bfafWpPDbYMuQoo2wB
	gHzb9GVl4eEWlnaHcMa7AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738169222; x=
	1738255622; bh=hxHNdS7WS0R6RbySdyoltquzgKovzLwAMtD/wCqj+rw=; b=L
	BrTDyEr5ZzhuSGtRlzjV/kcWlY1/DbnWnvXZsjbyVBmk6FwtWvErNCB0FBWm6cYs
	Is8UogEGm+G1Ba5CVQD2P2xLCdTKVQJ+7d33yUgO70QwX7axY1yaS/1pW3nhRW8c
	+xajFw57brgHltQ2ClZxyucqbx2gboGmuGy5lRrQlwY8ZyknIuZf1JZ6jfNACGCq
	NRS+3qMoCAEII4l5eTWKElte1t/zePostkJtHNczwPFPuST+Mr2/231ZmQpj0igJ
	55IMC7VbDAFw0Ez8ebSJE1khCF6U8tm3BGR48z/qIrg1hKPjSwW7J5fRXm4tyvoT
	odca5uM/I78dRaIVHAx+w==
X-ME-Sender: <xms:hFuaZwv57J0VT4o0lStYEjEsIMnEQKLce7_rYEMcsYnmWYy0EqZ3nQ>
    <xme:hFuaZ9cHwI3r-xyNnmnj59HyVm7n-z86IH-nvz0RX6PcJYliRnyDtS3yNYdo7WMkw
    WYPH_Bw6Kdc2z_WnA>
X-ME-Received: <xmr:hFuaZ7zYYoXKBcC6BCyCfCvGe-ZFP_Nf35O9-Kr2o4Nj2BmqFHfnTpg4iVaf0qSSr1CW7Xk9AZdj55ihAHHrQclUpvTioY-yu1frTkS3Ds8J8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeffudfhgfduheeuieeivdehgfej
    udegueevheevgeehfeekieduhffhheelvdfgudenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphhtthhope
    efuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhrohhgvghrshesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggtmhgv
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghmhhihuhhngheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghp
    thhtoheprghlvgigrghnuggvrhdrshhhihhshhhkihhnsehlihhnuhigrdhinhhtvghlrd
    gtohhmpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:hFuaZzOcArRnJ_FJ2Vtn3w4gjlBNtLTx_BUQIRwVR7OWoh7EY_xPwQ>
    <xmx:hFuaZw8YunJUVdW1yEsxaLGkCqypTU7cNXui_uO6NFoi3lDJMWrYtQ>
    <xmx:hFuaZ7VUlLvYdM80h17oLgxKy8vHudbw9MEJPiZuaSMdhquZYuMCgA>
    <xmx:hFuaZ5dAvKH0Im2uZFBvUm1c-P7MuDcfAIml-ERSoFM30wZOMrh9tg>
    <xmx:hluaZx5kTHbOJ_5lvg0et1AUXGoEdBrEL0XCC_Pmhe3ubgBgLy734eYg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 11:46:57 -0500 (EST)
Date: Wed, 29 Jan 2025 09:46:56 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 	Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, 	Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 	Kan Liang <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 	Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, 	Justin Stitt <justinstitt@google.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 	"Steinar H. Gunderson" <sesse@google.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 	Changbin Du <changbin.du@huawei.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>,
 	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Li Huafei <lihuafei1@huawei.com>, 	Dmitry Vyukov <dvyukov@google.com>,
 Andi Kleen <ak@linux.intel.com>,
 	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 13/18] perf build: Remove libbfd support
Message-ID: <jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd6wvrsu@fcz6vrvepybb>
References: <20250122174308.350350-1-irogers@google.com>
 <20250122174308.350350-14-irogers@google.com>
 <gnwmibvjtwboisw7uv32bdo4ziw4qzgwzvndqg2czpa6vp4olv@44n36ndbwobc>
 <CAP-5=fW9nM9zoQ5SQOq2HQfkougRotm=EBw99cvGDOpD=giK2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW9nM9zoQ5SQOq2HQfkougRotm=EBw99cvGDOpD=giK2g@mail.gmail.com>

On Tue, Jan 28, 2025 at 05:40:44PM -0800, Ian Rogers wrote:
> On Tue, Jan 28, 2025 at 4:31 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Jan 22, 2025 at 09:43:03AM -0800, Ian Rogers wrote:
> > > libbfd is license incompatible with perf and building requires the
> > > BUILD_NONDISTRO=1 build flag. Remove the code to simplify the code
> > > base.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/Documentation/perf-check.txt |   1 -
> > >  tools/perf/Makefile.config              |  38 +---
> > >  tools/perf/builtin-check.c              |   1 -
> > >  tools/perf/tests/Build                  |   1 -
> > >  tools/perf/tests/builtin-test.c         |   1 -
> > >  tools/perf/tests/pe-file-parsing.c      | 101 ----------
> > >  tools/perf/tests/tests.h                |   1 -
> > >  tools/perf/util/demangle-cxx.cpp        |  13 +-
> > >  tools/perf/util/disasm_bpf.c            | 166 ----------------
> > >  tools/perf/util/srcline.c               | 243 +-----------------------
> > >  tools/perf/util/symbol-elf.c            |  86 +--------
> > >  tools/perf/util/symbol.c                | 135 -------------
> > >  tools/perf/util/symbol.h                |   4 -
> > >  13 files changed, 7 insertions(+), 784 deletions(-)
> > >  delete mode 100644 tools/perf/tests/pe-file-parsing.c
> >
> > [..]
> >
> > I was briefly investigating why the centos build of perf was not
> > demangling rust v0 symbols [0]. From looking at the rust issue [1], it
> > appears the rust team somehow delivered support for v0 demangling
> > through libbfd. The code itself looked a bit odd (relying on cxx
> > demangle to run first?), but that's a separate thing.
> 
> There is still C++ demangling support by way of cxxabi:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/demangle-cxx.cpp?h=perf-tools-next#n44
> that was in libstdc++ (GNU) and libcxx (LLVM) when I looked.
> 
> > The centos build does not build with libbfd for the license issues you
> > mentioned. So your change probably won't regress any distro use cases.
> > But it does remove support for motivated users who don't have
> > re-distribution requirements.
> >
> > But since this patchset came up first in my search, I thought it'd be
> > good to mention that someone probably needs to add v0 support to
> > tools/perf/util/demangle-rust.c.
> 
> So I don't see any libbfd dependencies in demangle-rust.c:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/demangle-rust.c?h=perf-tools-next#n8
> Unusually we don't have any tests on the Rust demangling, we do for
> Java and OCaml:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/demangle-java-test.c?h=perf-tools-next
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/demangle-ocaml-test.c?h=perf-tools-next
> 
> Reading a bit more it seems that previous libiberty was coming to the
> rescue by way of C++ demangling. I'll see if I can write a demangler
> by way of lex and yacc.

Cool :)

> If we have a v0 standard one is there any
> value in the existing demangler or legacy demangling? It seems this
> has been broken for the best part of 5 years.

I believe the "legacy" symbol format is still the rust default. So
probably can't remove that. Looks like there's some desire to change
that, probably probably not very soon [0].

That probably also explains why nobody reported the breakage - only very
cool kids are using v0 scheme currently.

Thanks,
Daniel


[0]: https://github.com/rust-lang/rust/pull/89917

