Return-Path: <bpf+bounces-50007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544CFA215AC
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB681888A30
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C44117E015;
	Wed, 29 Jan 2025 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="tCrHPXrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgPZVS4T"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44216DEB3;
	Wed, 29 Jan 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110700; cv=none; b=h7Ika2aqsL57aLnqthFkHiBvYhAVIVfqfuapsSisVaR2E3gwW6YEePppf6BC49lgbyUx/sr/B2f0KreMav5zJ7Z92hdMb+7SE9KX6jNf4VV1cl7LjjXo5lpcs3nr5Z0A+tGGrOIlIULf6DRieQJw9vohm0l9svP7H75HOATou+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110700; c=relaxed/simple;
	bh=eCqeLqH9biuRPzq/KGZcQHmzNxdJAr70MWsQC6pKABk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upx/VRTUwY7NNdvsGmd0FbP4ELiRKmiWIx6ou3SlrdNjd4FvmpWrmejSO6irBW/totYyeGAB8xUVDBez9lWg6wkmW8QAZeQslOswNiJ3XOKfszmw1Q5k1VOeHgwDNmE+1bkEte/QaeJk1/zNR4tZjzq7fH3CgMHVrAQMp1qovHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=tCrHPXrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgPZVS4T; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B1BE7114010B;
	Tue, 28 Jan 2025 19:31:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 19:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738110695; x=1738197095; bh=8uxv+XnXP4
	dlGYUIe/KbHZjoyeo/fIPm1KYp4tp5OIU=; b=tCrHPXrLL3ftk2mGqGGOr0WfMp
	njYtZGJP7UuqNo89q1RLOpbKfpgZLs1OcgOl2IrI7KpBKIVno9dDM0W7beo5MHtE
	AzooU8piCEPbeNLLudA0QA5REG0tm6LlOAHr72FprIx0xeYHpIHo9XiqxJAC+vjZ
	DYvKcmmqcuqnld/z69Xy6FN6yt6bT9KxdytFnEhm0OBCU1HJMSHvb+YTTDWrXSZg
	ZSik75Sb7lKZ6F1TSg+XMDhbntgO6hi6DhDqPqtVsw4vGsc4MhOtbD9otZ8YcA6G
	K1Ukdw5Snwh7MTL8bE8TZ+2PCIbgi1LHuoMRbU9nwk/z+yeKeHkVn2/LRASg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738110695; x=1738197095; bh=8uxv+XnXP4dlGYUIe/KbHZjoyeo/fIPm1KY
	p4tp5OIU=; b=JgPZVS4TkCBlncSr+vp8Fi3bstlCh/92SKaARkejxvZXBcpwY51
	SP5WmeHq2F4vO/KP0AMF0EQGX87KgP78I1JTxvoxBXs0+uvHQfFZFwtaCHyaU8QO
	wC96grjgEQ3P/k7uz5JRaQFTAUnY0clzwQxkfultpeofc0mYpGY1M36Ks2ACGwQT
	kATHsxOvSfIxZF6/2W9bk8EnVcuFXq3/EpYBeZqAM/YzgI86VuAqZLWAvlrLJfiC
	7M5ku3Fpxm6zxKGMgrvv6OjdoId3sgBqw/3DubFvFuuPLCLspyjlMiWsSLLiPUaA
	0AOout7rf9Tses0o8hyxe//KeZwlwkrk5uQ==
X-ME-Sender: <xms:5XaZZ83_f_4kAeWdtY5DFoTrZ86U3DEhbme8F5UMQLQa_esv1SNDEw>
    <xme:5XaZZ3E0RDsz5Bpi4_jLAQv7T-HWBW-jKV38qZIoY10jk2-AhG4P8yy-0kDQFynGm
    -1iaxUUzmdm6dwEhg>
X-ME-Received: <xmr:5XaZZ04ytNBf17EHf77LH0wyuqIm8JQKPY9FvLUuinHOh8ylgSjdwJm9C0JFPVdmDF2rkV-_Jz3v5fNrNxjMoQ-oKviX8JGxU59tcU2OZSBW7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepfeetvdekkeevgeehtddvvedtgedt
    teevfedvvddvieehueetffegieekkedvieegnecuffhomhgrihhnpehruhhsthdqlhgrnh
    hgrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphhtth
    hopeefuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhrohhgvghrshesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggt
    mhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghmhhihuhhngheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhr
    tghpthhtoheprghlvgigrghnuggvrhdrshhhihhshhhkihhnsehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtohepjhholhhsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:5XaZZ13rtgrL-iDA1vQJSWBrzYWKpKAgjpmPzTLF5fG8VYXwN-XI_Q>
    <xmx:5XaZZ_GIV8Pndb_ibg6dm6Yi__jWc22aZTLGRHCn7oPbUEmFOKcwoA>
    <xmx:5XaZZ-9wYI4lKQMPtTmc3ZDtv-MBsOQVggMOAUaQ037Di-SMDXgA3w>
    <xmx:5XaZZ0lheBUjG_ZjBNUzW0GpyAaCS1FKpuzIiazlkDVbP37qoqlDtA>
    <xmx:53aZZ_i-xUbqg2iVYMZOzxfFyMh4V2jrRSQZPc0u8TXnWRf4x4NZDLFo>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 19:31:30 -0500 (EST)
Date: Tue, 28 Jan 2025 17:31:28 -0700
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
Message-ID: <gnwmibvjtwboisw7uv32bdo4ziw4qzgwzvndqg2czpa6vp4olv@44n36ndbwobc>
References: <20250122174308.350350-1-irogers@google.com>
 <20250122174308.350350-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122174308.350350-14-irogers@google.com>

Hi Ian,

On Wed, Jan 22, 2025 at 09:43:03AM -0800, Ian Rogers wrote:
> libbfd is license incompatible with perf and building requires the
> BUILD_NONDISTRO=1 build flag. Remove the code to simplify the code
> base.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-check.txt |   1 -
>  tools/perf/Makefile.config              |  38 +---
>  tools/perf/builtin-check.c              |   1 -
>  tools/perf/tests/Build                  |   1 -
>  tools/perf/tests/builtin-test.c         |   1 -
>  tools/perf/tests/pe-file-parsing.c      | 101 ----------
>  tools/perf/tests/tests.h                |   1 -
>  tools/perf/util/demangle-cxx.cpp        |  13 +-
>  tools/perf/util/disasm_bpf.c            | 166 ----------------
>  tools/perf/util/srcline.c               | 243 +-----------------------
>  tools/perf/util/symbol-elf.c            |  86 +--------
>  tools/perf/util/symbol.c                | 135 -------------
>  tools/perf/util/symbol.h                |   4 -
>  13 files changed, 7 insertions(+), 784 deletions(-)
>  delete mode 100644 tools/perf/tests/pe-file-parsing.c

[..]

I was briefly investigating why the centos build of perf was not
demangling rust v0 symbols [0]. From looking at the rust issue [1], it
appears the rust team somehow delivered support for v0 demangling
through libbfd. The code itself looked a bit odd (relying on cxx
demangle to run first?), but that's a separate thing.

The centos build does not build with libbfd for the license issues you
mentioned. So your change probably won't regress any distro use cases.
But it does remove support for motivated users who don't have
re-distribution requirements.

But since this patchset came up first in my search, I thought it'd be
good to mention that someone probably needs to add v0 support to
tools/perf/util/demangle-rust.c.

Thanks,
Daniel


[0]: https://doc.rust-lang.org/rustc/symbol-mangling/v0.html
[1]: https://github.com/rust-lang/rust/issues/60705

