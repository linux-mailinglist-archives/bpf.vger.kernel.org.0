Return-Path: <bpf+bounces-61771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04196AEBFC0
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7094A7AB3
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447371F0E25;
	Fri, 27 Jun 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcStCyds"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702C20AF9C;
	Fri, 27 Jun 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052413; cv=none; b=OJYThcfCMF58fkI/t196/xnGXaOFIZbRKPuupVFR4bfIoYSMVz/aJmPONHVuPZuvqgG8BxECXHC8+dvAS2izKUoJyQDrlxMzECjVRMAzENfSRMg2REa8zo0sQRuljVG4ehUQ1A3Jt3gDeGlZ+qDHJkAQKC4F1ZwKtdA/fZ0Osqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052413; c=relaxed/simple;
	bh=kCoAehJoP4d3veWTy0DxemolidReITNQ2YabMYVknDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Oyzhfaz7ewmzkd2UOZKzlV5upoQ+H4miYnK1K9ixtIcTqCFqetmSnbtDaVbrrfAMWtqwxGD28+yn+CPRQaWPwfEBhl1EwtqgTBcsvUuIZ63KPC5cv5E+zvxqhaxSKocuvHeosps3FFYLq9tqBK85tkr7bJHY2MlOq0T8L8i2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcStCyds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0140AC4CEE3;
	Fri, 27 Jun 2025 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751052413;
	bh=kCoAehJoP4d3veWTy0DxemolidReITNQ2YabMYVknDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcStCydsxKyIDjbz3Tz51AeLrwy5mof6hG1an2zqnuWTNSnQLJUO0VkblIlnYNyzP
	 4ioTcAoJeHgAWz8nJrR/AoPshag+KCtlDO/ZzklDEDbLyKhP+iZcc2ocHDOhjDK3Av
	 erBF0XU329gNyQW7lDqBBRv8GrGHvsnR8GzkdxWe1Bvd+6V8PKvsJQkTs6QkZIC+35
	 WDWaaU0yKbjz8YqGFZFfvUT7Soth1y0BLOfdiAq6TTVPCFwpxt/uFRnzoILet9oizy
	 O8aWp2JmnMCfOBv4XY2LiWTQGVxE0aM5lo49Tuxe8VH2Dulut2dn15YAEhhxFfXAdE
	 lW+/7cDWPe8Wg==
Date: Fri, 27 Jun 2025 12:26:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
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
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 06/19] perf capstone: Support for dlopen-ing
 libcapstone.so
Message-ID: <aF7wesWHTv_Wp-8y@google.com>
References: <20250417230740.86048-1-irogers@google.com>
 <20250417230740.86048-7-irogers@google.com>
 <aF3Vd0C-7jqZwz91@google.com>
 <CAP-5=fV4x0q7YdeYJd6GAHXd48Qochpa-+jq5jsRJWK36v7rSA@mail.gmail.com>
 <CAP-5=fXLUO3yvSmM4nSnNV_qQGGLP_XTcfPgOhgOkuaNnr3Hvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXLUO3yvSmM4nSnNV_qQGGLP_XTcfPgOhgOkuaNnr3Hvw@mail.gmail.com>

On Fri, Jun 27, 2025 at 09:44:02AM -0700, Ian Rogers wrote:
> On Thu, Jun 26, 2025 at 9:53 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Jun 26, 2025 at 4:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Thu, Apr 17, 2025 at 04:07:27PM -0700, Ian Rogers wrote:
> > > > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
> > > > support dlopen-ing libcapstone.so and then calling the necessary
> > > > functions by looking them up using dlsym. Reverse engineer the types
> > > > in the API using pahole, adding only what's used in the perf code or
> > > > necessary for the sake of struct size and alignment.
> > >
> > > I still think it's simpler to require capstone headers at build time and
> > > add LIBCAPSTONE_DYNAMIC=1 or something to support dlopen.
> >
> > I agree, having a header file avoids the need to declare the header
> > file values. This is simpler. Can we make the build require
> > libcapstone and libLLVM in the same way that libtraceevent is
> > required? That is you have to explicitly build with NO_LIBTRACEEVENT=1
> > to get a no libtraceevent build to succeed. If we don't do this then
> > having LIBCAPSTONE_DYNAMIC will most likely be an unused option and
> > not worth carrying in the code base, I think that's sad. If we require
> > the libraries I don't like the idea of people arguing, "why do I need
> > to install libcapstone and libLLVM just to get the kernel/perf to
> > build now?" The non-simple, but still not very complex, approach taken
> > here was taken as a compromise to get the best result (a perf that
> > gets faster, BPF support, .. when libraries are available without
> > explicitly depending on them) while trying not to offend kernel
> > developers who are often trying to build on minimal systems.
> 
> Fwiw, a situation that I think is analogous (and was playing on my
> mind while writing the code) is that we don't require python to build
> perf and carry around empty-pmu-events.c:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/empty-pmu-events.c?h=perf-tools-next
> It would be simpler (in the code base and in general) to require
> everyone building perf to have python.
> Having python on a system seems less of a stretch than requiring
> libcapstone and libLLVM.
> 
> If we keep the existing build approach, optional capstone and libLLVM
> by detecting it as a feature, then just linking against the libraries
> is natural. Someone would need to know they care about optionality and
> enable LIBCAPSTONE_DYNAMIC=1. An average build where the libraries
> weren't present would lose the libcapstone and libLLVM support. We
> could warn about this situation but some people are upset about build
> warnings, and if we do warn we could be pushing people into just
> linking against libcapstone and libLLVM which seems like we'll fall
> foul of the, "perf has too many library dependencies," complaint. We
> could warn about linking against libraries when there is a _DYNAMIC
> alternative like this available, but again people don't like build
> warnings and they could legitimately want to link against libcapstone
> or libLLVM.
> 
> Anyway, that's why I ended up with the code in this state, to best try
> to play off all the different compromises and complaints that have
> been dealt with in the past.

I can see your point.  Adding new build flags is likely to be unused and
forgotten.

But I also think is that this dlopen support is mostly useful to distro
package managers who want to support more flexible environment and
regular dynamic linking is preferred to local builds over dlopen.  Then
adding a note to a pull request and contacting them directly (if needed)
might work?

Thanks,
Namhyung


