Return-Path: <bpf+bounces-49490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B1A194FE
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 16:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83E0168FD3
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453C2144A1;
	Wed, 22 Jan 2025 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BW400wqW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A902135B9;
	Wed, 22 Jan 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559263; cv=none; b=AJ+13G19J/5YRkoxAgPQSDb3z3jt1t7pa11jD8+f7DINpR8fkcLGi1/NEUpBJhsZK5cIS3on5nl6PHjeotUdWQTLjHZqGFWIcJKJ3+ea0QuVpztaeW4vZYpXEzQ9u42HxiHP2ztEr5KUu5ol8uQGYXn2fQfreZzzIo6EqtbbMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559263; c=relaxed/simple;
	bh=3rguBu7d6l8oqA29EsdGgBXCuRaX/mEzmEacYDnc8MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTPbfFoKr4zuu48atQtbc1kVC5gh3GjTdpgj+4G8yTkxJj+oLePUgugl1f7sh1sRqDoPauACD6xOW7cUE56EphQzN5pMRSB9meSz5v4vWzNdc+31viNzxP+0TsWLc2okdoeOu7KEbTI4kX1MVw1GQhIPZe+L4tPmVEwn/cbB1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BW400wqW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737559262; x=1769095262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3rguBu7d6l8oqA29EsdGgBXCuRaX/mEzmEacYDnc8MQ=;
  b=BW400wqWC9lUljiQ+YLKac9h+mZHB/2oDBd7gL/er43o51u9KjLZxvJH
   uCvziaJ6rntxKQFe/lMQ6rVzlpfBy9c+LB1vxqFjfkOrbCNAh3i9AZKIs
   bFx6OmOxHe4u7CgXdTcNdjYNIeIDEcfiBuRA/4RI9663zmnoLLV/YyctG
   G0iqCUjPMvVpIOq1TkRZ04Hur9pZdmHsJj79jFKGJAQyA/8FX5g7hl6+I
   /X53byMcaf8TEUR3ATQBSxvM7qkuAJjC9kRtv0V4bsLpnK+UMkW4QA9CP
   RVpbY/SogUdpiIC0wMood87sheYcbUgYP3bGycvRXZqhzXrhNLzXDsUpV
   w==;
X-CSE-ConnectionGUID: 642tkySITcqh0lVkfCwcHw==
X-CSE-MsgGUID: FqUAAPxlQ6mvGV1hhH6dgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37905044"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="37905044"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 07:21:01 -0800
X-CSE-ConnectionGUID: VxdqHyfOTmq4kmu3CfVvEg==
X-CSE-MsgGUID: kmpLDOPgR2uydCgruscnyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="107701138"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 07:21:00 -0800
Date: Wed, 22 Jan 2025 07:20:59 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Dmitry Vyukov <dvyukov@google.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove
 BUILD_NONDISTRO
Message-ID: <Z5EM24qWVQF2VdI8@tassilo>
References: <20250122062332.577009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122062332.577009-1-irogers@google.com>

On Tue, Jan 21, 2025 at 10:23:15PM -0800, Ian Rogers wrote:
> Linking against libcapstone and libLLVM can be a significant increase
> in dependencies and size of memory footprint. For something like `perf
> record` the disassembler and addr2line functionality won't be
> used. Support dynamically loading these libraries using dlopen and
> then calling the appropriate functions found using dlsym.

It's unclear to me what this actually fixes. If the code is not used
it should not be faulted in and the dynamic linker is lazy too, so 
if it's not used, it won't even be linked. 

I don't see any numbers, but it won't surprise me if it improved
actual run time or memory usage significantly.

-Andi


