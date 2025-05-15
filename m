Return-Path: <bpf+bounces-58342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63DAB8E28
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F88A05C97
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A214425A2AA;
	Thu, 15 May 2025 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PETGkpv9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528B244679;
	Thu, 15 May 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331536; cv=none; b=MDOpgTdf549sgRqatMQWantd1LKjN8qBp5Cx/MdCOfSqre8s9L4XaeflIVlVz8TaPm5/KojqfL5enApxco++zo7fA6ZI8tXO+oWxmIHVsDfQP+5wLuPTZ1uR31BqPWa7HpA3wS1kAenF8RETsS6bPgT6qW2uSs5tcJ26r1qffyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331536; c=relaxed/simple;
	bh=m/TOlmyn+s2/Ige0FOwKesnagDQC/gXqCDf28q5+pLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYq3HBFLuyqHg4Dh7z/j87lNhnayit6mjHw8vk8chx2Cd+lsW7Sx6rkrYO5EiPPfelf9bxYKUvWov/toFHmTdgk7TcC7Tw6PEE9PTcrhSJe6sgpWtpWXrCsf3zACKeq0Y9OSjIiEiuE96n8iqTvoKxBNsYrAQjjDHrk1I+DcvO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PETGkpv9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747331534; x=1778867534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m/TOlmyn+s2/Ige0FOwKesnagDQC/gXqCDf28q5+pLo=;
  b=PETGkpv9LC15U9x/ql6+8owgs+uDyCut9+QEk+eGfklI9/Po7SD14Z7j
   SUuOQjLMOQCTEk7yLH3eHrMPCixGvmBW5wAm9mxyQqgD63aRKgxT+oPSI
   hGLPQudNnM1TQgxwrHlwbEzioKA7kW6r1eUzSQ9h8l9B9TI+Nxaf9cvdG
   Osob3zAzP0b/w1wLiHIaxicp8mBsdAmyhZXGs2YrbZ+w3YEZPp60e/Kog
   kgxGSJ7erlXI+3s0FLp3Gm98C048rqI5oqFtSkSZEd2LYP5UXV2p6yPeY
   98jaMwsleQ5naL+fXl5nQLI5yCFKHj8YFlj63qHVMUWB/ppGHnG+QFlai
   Q==;
X-CSE-ConnectionGUID: 9P+FkLkyQBC6CIFeVnI74Q==
X-CSE-MsgGUID: T7yggr5PRNmQqiF8oFwduA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59941499"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="59941499"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:52:13 -0700
X-CSE-ConnectionGUID: Qruo5h3UT56HNd7t0fDJRw==
X-CSE-MsgGUID: frud17EwTh2NliK0R4UTNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="143333504"
Received: from gkhatri-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:52:13 -0700
Date: Thu, 15 May 2025 10:52:05 -0700
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
Message-ID: <20250515175205.th7pjvord6fum35a@desk>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
 <202505150911.1254C695D@keescook>
 <20250515171821.6je7a4uvmttcdiia@desk>
 <202505151039.DAA202A@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505151039.DAA202A@keescook>

On Thu, May 15, 2025 at 10:41:41AM -0700, Kees Cook wrote:
> On Thu, May 15, 2025 at 10:18:21AM -0700, Pawan Gupta wrote:
> > On Thu, May 15, 2025 at 09:51:15AM -0700, Kees Cook wrote:
> > > On Thu, May 15, 2025 at 07:51:26AM -0700, Kees Cook wrote:
> > > > On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > >There is an observable slowdown when running BPF selftests on 6.15-rc6
> > > > >kernel[1] built with tools/testing/selftests/bpf/{config,config.x86_64}.
> > > > [...]
> > > > Where can I find the .config for the slow runs?
> > > 
> > > Oops, I can read. :) Doing a build now...
> > > 
> > > > And how do I run the test myself directly?
> > > 
> > > I found:
> > > https://docs.kernel.org/bpf/bpf_devel_QA.html
> > > 
> > > But it doesn't seem to cover a bunch of stuff (no way to prebuild the
> > > tests, no info on building the test modules).
> > > 
> > > This seems to be needed:
> > > 
> > > make O=regression-bug -C tools/testing/selftests/bpf/test_kmods
> > > 
> > > But then the booted kernel doesn't load it (missing signatures?)
> > > 
> > > Anyway, I'll keep digging...
> > 
> > After struggling with this for a while, I figured vmtest.sh is the easiest
> > way to test bpf:
> > 
> > ./tools/testing/selftests/bpf/vmtest.sh -i ./test_progs
> 
> I can't even build the test_progs. :(
> 
> $ make test_progs
> ...
>   CLNG-BPF [test_progs] bpf_iter_tasks.bpf.o
> progs/bpf_iter_tasks.c:98:8: error: call to undeclared function 'bpf_copy_from_user_task_str'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    98 |         ret = bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1), ptr, task, 0
> );
>       |               ^
> 1 error generated.

I just tried on the latest upstream, and I am getting the same error. My
earlier bisection was on a stable-rc for 6.14.y:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.14.y

... where it was first reported:

https://lore.kernel.org/stable/20250515041659.smhllyarxdwp7cav@desk/

