Return-Path: <bpf+bounces-54008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D7A60438
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 23:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C2219C187F
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4E1F76B3;
	Thu, 13 Mar 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQR/dARi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B31F4630;
	Thu, 13 Mar 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904665; cv=none; b=B3AveD3xSqj33FAzb4QAa6A2y6QgFz4Ssoz1E7sj/eGxoWyXR/Lb4iWUBICeYrWvL+ELejLk2R1jJos1eGnUM3eNn7lTzNJnsls6mwujoSI1ssIHNSuJyCTy2Fv7OjjGnwW7/LrTNM+x1r9Fs1jpA7OroafpkFc+3vdJb5wIj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904665; c=relaxed/simple;
	bh=C3TTb5Ms+0aEPdd4dgKKRbOv77Nyo/jHCcFF8YqhaZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPlFbqrY9XpzOP+s/4uWtBvSak4Kj/vALHuOZpPLmtz0vHKCaxO72UTJ/y83d3zz5kezupUD4sQVhn7WrUnH5SKruO094wCfsQVVe8CmRYYtKlfrkFEIg72RkEtqlQmfA6pym44/H9LCzjU64kVP82xBz4cEzV8a6lwiaH4BtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQR/dARi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F0BC4CEDD;
	Thu, 13 Mar 2025 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741904665;
	bh=C3TTb5Ms+0aEPdd4dgKKRbOv77Nyo/jHCcFF8YqhaZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQR/dARim8x9mrB1aT27WjxqmOQRnqm1zxCXydRDRhh2Qt7E2HHIDgePOTgOLNtxH
	 5O4bKKUiWy1YbBo8+lBAIrm3zpYXJl76XWhGz1mkLy02o+HBa72O/8jvx5Dz3LdxLS
	 MSwVefC0Kaj8FwgED/bd2dNMsbYxrKf0TttEP5NJYcMZ0hqAouJVlFk6AbNtNAGlFB
	 G1r43yFKdyhIejJ2DDnf7iRoI5hoLKllChNR1xb26UoV8edo3tHZ52PGG2LKEsA6a2
	 2FPrkBaXQ5mYMvvjoo29D3g13wC6nQv2eqexu/rn6SuzktY52Kl/f6kaXPsY0ODyYb
	 lp0V0kEuf4Eqw==
Date: Thu, 13 Mar 2025 15:24:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove
 BUILD_NONDISTRO
Message-ID: <Z9NbFqaDQMjvYxcc@google.com>
References: <20250122062332.577009-1-irogers@google.com>
 <Z5K712McgLXkN6aR@google.com>
 <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
 <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
 <CAP-5=fV_z+Ev=wDt+QDwx8GTNXNQH30H5KXzaUXQBOG1Mb8hJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV_z+Ev=wDt+QDwx8GTNXNQH30H5KXzaUXQBOG1Mb8hJg@mail.gmail.com>

Hi Ian,

On Wed, Mar 12, 2025 at 02:04:30PM -0700, Ian Rogers wrote:
> On Mon, Feb 10, 2025 at 10:06 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Jan 23, 2025 at 3:36 PM Ian Rogers <irogers@google.com> wrote:
> > > On Thu, Jan 23, 2025 at 1:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > I like changes up to this in general.  Let me take a look at the
> > > > patches.
> >
> > So it would be nice to make progress with this series given some level
> > of happiness, I don't see any actions currently on the patch series as
> > is. If I may be so bold as to recap the issues that have come up:
> >
> > 1) Andi Kleen mentions that dlopen is inferior to linking against
> > libraries and those libraries aren't a memory overhead if unused.
> >
> > I agree but pointed-out the data center use case means that saving
> > size on binaries can be important to some (me). We've also been trying
> > to reduce perf's dependencies for distributions as perf dragging in
> > say the whole of libLLVM can be annoying for making minimal
> > distributions that contain perf. Perhaps somebody (Arnaldo?) more
> > involved with distributions can confirm or deny the distribution
> > problem, I'm hoping it is self-evident.
> >
> > 2) Namhyung Kim was uncomfortable with the code defining
> > types/constants that were in header files as the two may drift over
> > time
> >
> > I agree but in the same way as a function name is an ABI for dlysym,
> > the types/constants are too. Yes a header file may change, but in
> > doing so the ABI has changed and so it would be an incompatible change
> > and everything would be broken. We'd need to fix the code for this,
> > say as we did when libbpf moved to version 1.0, but using a header
> > file would only weakly guard against this problem. The problem with
> > including the header files is that then the build either breaks
> > without the header or we need to support a no linking against a
> > library and not using dlopen case. I suspect a lot of distributions
> > wouldn't understand the build subtlety in this, the necessary build
> > options and things installed, and we'd end up not using things like
> > libLLVM even when it is known to be a large performance win. I also
> > hope one day we can move from parsing text out of forked commands, as
> > it is slower and more brittle, to just directly using libraries.
> > Making dlopen the fallback (probably with a warning on failure) seems
> > like the right direction for this except we won't get it if we need to
> > drag in extra dependency header files for the build to succeed (well
> > we could have a no library or dlopen option, but then we'd probably
> > find distributions packaging this and things like perf annotate
> > getting broken as they don't even know how to dlopen a library).
> >
> > 3) Namhyung Kim (and I) also raises that the libcapstone patch can be
> > smaller by dropping the print_capstone_detail support on x86
> >
> > Note, given the similarity between capstone and libLLVM for
> > disassembly, it is curious that only capstone gives the extra detail.
> >
> > I agree. Given the capstone disassembly output will be compromised we
> > should warn for this, probably in Makefile.config to avoid running
> > afoul of -Werror. It isn't clear that having a warning is a good move
> > given the handful of structs needed to support print_capstone_detail.
> > I'd prefer to keep the structs so that we haven't got a warning that
> > looks like it needs cleaning up.
> >
> > 4) Namhyung Kim raised concerns over #if placement
> >
> > Namhyung raised that he'd prefer:
> > ```
> > #if HAVE_LIBCAPSTONE_SUPPORT
> > // lots of code
> > #else
> > // lots of code
> > #endif
> > ```
> > rather than the #ifs being inside or around individual functions. I
> > raised that the large #ifs is a problem in the current code as you
> > lose context when trying to understand a function. You may look at a
> > function but not realize it isn't being used because of a #if 10s or
> > 100s of lines above. Namhyung raised that the large #ifs is closer to
> > kernel style, I disagreed as I think kernel style is only doing this
> > when it stubs out a bunch of API functions, not when more context
> > would be useful. Hopefully as the person writing the patches the style
> > choice I've made can be respected.
> >
> > 5) Daniel Xu raised issues with the removal of libbfd for Rust
> > support, as the code implies libbfd C++ demangling is a pre-requisite
> > of legacy rust symbol demangling
> >
> > A separate patch was posted adding Rust v0 symbol demangling with no
> > libbfd dependency:
> > https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
> > The legacy support should work with the non-libbfd demanglers as
> > that's what we have today. We should really clean up Rust demangling
> > and have tests. This is blocked on the Rust community responding to:
> > https://github.com/rust-lang/rust/issues/60705

I think #ifdef placements is not a big deal, but I still don't want to
pull libcapstone details into the perf tree.

For LLVM, I think you should to build llvm-c-helpers anyway which means
you still need LLVM headers and don't need to redefine the structures.

Can we do the same for capstone?  I think it's best to use capstone
headers directly and add a build option to use dlopen().

Thanks,
Namhyung


