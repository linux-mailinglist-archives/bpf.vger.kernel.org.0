Return-Path: <bpf+bounces-49594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D8A1A97F
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA6D188D4E4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B115180A80;
	Thu, 23 Jan 2025 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxgJONRZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712014F108;
	Thu, 23 Jan 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656368; cv=none; b=LdV3gixls/XATzGrA0csafcz1kydSkDE2Nz+UDRzK2/06VBc4EdI0cwDw4FVofxjl8nry/5gF6joUKHtOzBjmxoSud+X1wKb6Zko6Jx8mBoslHI3XzWKcz0GhLjgo99wr3rYjugkzroPlan+TonUNhmq7yYsknGO4LDP6PWFAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656368; c=relaxed/simple;
	bh=GvQwYvfCJtbKgiBXMvf6dFY/gAGsY/mc9X9xlMNaaRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHjoufRKDZEPjbGTTfyMKfYrsXMGh4ncSW3TYBmU5ZY7MERNSF18Qz6EEyaScAd1g7h2nfjlSmAf+1mDxAyLevTnuWyyFp46i/LoQsh2obaqK7wSJ1tVbcrX/Z4AIsUP8amZI+uZ48ihBREFDgPYo7sy4f6KmDouy4xywDYLYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxgJONRZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737656367; x=1769192367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GvQwYvfCJtbKgiBXMvf6dFY/gAGsY/mc9X9xlMNaaRQ=;
  b=PxgJONRZPaK+qLjE5Tqj+RZH2sSTRLcAt72FFzoMSsbuHxWmu3LYEDoL
   eg+BCrRq7JCE2OzatppyJGvCVTG3R7ghkpGve0S5E4BmZpz++MRTkkaUN
   wRzfouAe5Bry/CQsy8kzqHyEft+J7p+WmMne0UE9zJsfmx/DioO+uroBG
   +ltuib2wMrdH7CPDd+UPW42zm3KVnd0D2V0ubOFsNWbqZ6LkPw7QoY+qv
   qdJVqGJOlhOf1VDEykqTnq5Xieg/becLbdKLKq31yWgd+hf0Ba6ja3poQ
   0LDZhKNkDsTskz/JcqYm352GX2bWu9XCk9TLRZm1JqEj4HKQjg076jvGg
   Q==;
X-CSE-ConnectionGUID: Hyx/Qd5QRQOU7TAR1FZ+Ig==
X-CSE-MsgGUID: a06xyNx4QXu8S0EyKfawOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41930269"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="41930269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:19:27 -0800
X-CSE-ConnectionGUID: 2currXbiRM2/mGXtKLSgpQ==
X-CSE-MsgGUID: ukUmkCvcSNqWMMh4y5/A7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107376189"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:19:26 -0800
Date: Thu, 23 Jan 2025 10:19:25 -0800
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
Message-ID: <Z5KILXC9-dN4Vo1o@tassilo>
References: <20250122062332.577009-1-irogers@google.com>
 <Z5EM24qWVQF2VdI8@tassilo>
 <CAP-5=fW6ZWf6jF3Xnike81S9s_5tZ9w4DS8=8Ff1Ve87O32_Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW6ZWf6jF3Xnike81S9s_5tZ9w4DS8=8Ff1Ve87O32_Sg@mail.gmail.com>

> In certain scenarios, like data centers, it can be useful to
> statically link all your dependencies to avoid dll hell.

Yes but it won't be loaded into memory if not used. Executable
loading is all lazy. Maybe look a page fault trace for loading
perf if you don't believe me.

So you're trying to optimize disk space here?

I didn't see that in the cover letter.

It doesn't seem like a very good reason for such an intrusive patch kit.

If it's a serious concern maybe investigate an executable compressor?

> The X86
> disassembler alone in libllvm is of a size comparable to the perf tool

I agree that LLVM is a serious bloat and DLL hell concern, but I don't think 
dlopen is the answer here.

-Andi

