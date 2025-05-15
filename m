Return-Path: <bpf+bounces-58356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1AAB90C9
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AF11BC50BB
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D529B773;
	Thu, 15 May 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wdc3ReDq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04921F5827;
	Thu, 15 May 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340774; cv=none; b=a7XLOIdfFLAei99TpkXyDJvDNBZCxxFpoi5fYWmlJ7aD8ZAizjYbs8I8RrDOr6oxg5XkCGCONlSJI5ztkh/J7ZumRP1WXGsFaVOI62XHS0Cy1aFe3Eg72a1JZVthzRmiNIQDY1Vdv/w917bhG9by3IPJSAaRbd6u/A5YwCOF7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340774; c=relaxed/simple;
	bh=TxY7a/noT4+XphSwUtR0Qw3R/xm0x/v1iIZu5905ch8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYmH1T3l6j9Cdx84hzIbtU9+uMbWcJRWNBWu9rZ59W8RZWp932OkBjx/UcNi+Am1GFrXH26QhqjXpArCYxpIz/R9mOyPlWiPq9deRO5ygCqqAu0WFJxHMVhczIElsmKfJr7WXOH6IIDdQBa6LPcz/qzP6OQdTYyB2NalKkQxPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wdc3ReDq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747340772; x=1778876772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TxY7a/noT4+XphSwUtR0Qw3R/xm0x/v1iIZu5905ch8=;
  b=Wdc3ReDq+4VORUT8hc5BF66A7E9XrMEaOYgSM+eai2Tk5fF+VNUAPX+7
   tVeTQxPlCcGfDuMRMq/WMbcP39L6wHSzj1/1femB2fwDX/qShDvlQ46E/
   1ylVGcWvO/riWpmWOrlB+5RTVAZlSpdDaOfY1wN2weSMV5T5gUDTYsiIz
   XGbGj0rJPY+ga5NGrn5frV/4LJj0oz59oLXI3hBY5H2cY7S0EEDg9ql/b
   66V8whVExSXprsb7yLtmID7cvNCQqtuC4Wqmnau4zdXZeOnjsBpvw0foS
   kqsu/Ub5rLdy5qF/cMf64erqJ8/CWB/OQxlt5ccA3q7w5gJYmn8uZcLuO
   g==;
X-CSE-ConnectionGUID: t1TP3vtuSXyKYvxqFe4gPA==
X-CSE-MsgGUID: oJjOmh72QiCcWxUCfmQKqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59938533"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="59938533"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:26:11 -0700
X-CSE-ConnectionGUID: vUztFMGqQJi1FIgG+GTGMA==
X-CSE-MsgGUID: iraNBp1BRJCATn9l8/pqmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="138977709"
Received: from gkhatri-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.13])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:26:11 -0700
Date: Thu, 15 May 2025 13:26:03 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
Message-ID: <20250515202552.znxvzcnhpdjqmlbm@desk>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
 <202505150911.1254C695D@keescook>
 <20250515171821.6je7a4uvmttcdiia@desk>
 <202505151039.DAA202A@keescook>
 <20250515175205.th7pjvord6fum35a@desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515175205.th7pjvord6fum35a@desk>

On Thu, May 15, 2025 at 10:52:13AM -0700, Pawan Gupta wrote:
> On Thu, May 15, 2025 at 10:41:41AM -0700, Kees Cook wrote:
> > On Thu, May 15, 2025 at 10:18:21AM -0700, Pawan Gupta wrote:
> > > On Thu, May 15, 2025 at 09:51:15AM -0700, Kees Cook wrote:
> > > > On Thu, May 15, 2025 at 07:51:26AM -0700, Kees Cook wrote:
> > > > > On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > > >There is an observable slowdown when running BPF selftests on 6.15-rc6
> > > > > >kernel[1] built with tools/testing/selftests/bpf/{config,config.x86_64}.
> > > > > [...]
> > > > > Where can I find the .config for the slow runs?
> > > > 
> > > > Oops, I can read. :) Doing a build now...
> > > > 
> > > > > And how do I run the test myself directly?
> > > > 
> > > > I found:
> > > > https://docs.kernel.org/bpf/bpf_devel_QA.html
> > > > 
> > > > But it doesn't seem to cover a bunch of stuff (no way to prebuild the
> > > > tests, no info on building the test modules).
> > > > 
> > > > This seems to be needed:
> > > > 
> > > > make O=regression-bug -C tools/testing/selftests/bpf/test_kmods
> > > > 
> > > > But then the booted kernel doesn't load it (missing signatures?)
> > > > 
> > > > Anyway, I'll keep digging...
> > > 
> > > After struggling with this for a while, I figured vmtest.sh is the easiest
> > > way to test bpf:
> > > 
> > > ./tools/testing/selftests/bpf/vmtest.sh -i ./test_progs
> > 
> > I can't even build the test_progs. :(
> > 
> > $ make test_progs
> > ...
> >   CLNG-BPF [test_progs] bpf_iter_tasks.bpf.o
> > progs/bpf_iter_tasks.c:98:8: error: call to undeclared function 'bpf_copy_from_user_task_str'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >    98 |         ret = bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1), ptr, task, 0
> > );
> >       |               ^
> > 1 error generated.
> 
> I just tried on the latest upstream, and I am getting the same error. My
> earlier bisection was on a stable-rc for 6.14.y:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.14.y
> 
> ... where it was first reported:
> 
> https://lore.kernel.org/stable/20250515041659.smhllyarxdwp7cav@desk/

I can confirm on v6.14.7-rc2 the test verif_scale_loop3_fail is now
passing(in <10 secs) after applying your first patch (mm: vmalloc: Actually
use the in-place vrealloc region). The the test passes after applying your
second patch also.

For some reason I am unable to build the bpf selftests on latest upstream.
I may be missing something that is required on latest upstream :-(

