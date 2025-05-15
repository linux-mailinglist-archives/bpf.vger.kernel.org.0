Return-Path: <bpf+bounces-58333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8015FAB8D8D
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8307169659
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45CB25B1F7;
	Thu, 15 May 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeJrTNXr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1F25A323;
	Thu, 15 May 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329509; cv=none; b=T2dQvYsOJzF3zW/ouCFC+38kYSITcU0TsHFZ2cRh+GanlwPZaQdSpfpHThhJZct0Rdgec6rYQiBUD1loikJhpIPYrdsl1M7/jPeyPriKgnp59IRIQ1i0UCw6/yprcZ1eafPnPwTQ6ap0rHX+EY4cH261Cd6Vbp6RbtlQ/WhQ0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329509; c=relaxed/simple;
	bh=jLsjmy6XbR3/FzmrHbEaCohAPEq2r3hRO6K/9SXIuJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdB3uOahmYWHh6I/H5Es3e4MKcw2Z1asdfwPnhdAeeAv7EzoRu4fmMNlm8ailkFD/7v+rkMYkEMpdGxkNaaDf5Nj1b6KeqbztdNRyNmMDmI3Fn0YkzQ2Om9SG9+RbFsnGW9i3U3TNdo9TowGskJ0YCLN9fGznBQRk7AnOu3ahJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeJrTNXr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747329507; x=1778865507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jLsjmy6XbR3/FzmrHbEaCohAPEq2r3hRO6K/9SXIuJ0=;
  b=NeJrTNXrJR9upcqFQX1eU70PQL0QSlMXZYLsFkA89Qzo2PGt9P2nsIPY
   +THPW66ys+qrLwf9GfQMMiyW9HKyZVIyVxbSMmQrmK/2WuVHmlUTYDO++
   WdOt2kMwIGVcJCOyIOIJ3tB+tnsBqvAVLRHX+p6BMJMLCjD5PMigRWs7P
   Tw4HN/+ZWSq2Je4oj9NVcVT2t+4BCXzZN0fyjNcaOwifB0irBRqE1k+sd
   3494SJlSO1xj/HcLwdMkzyw1ywkkpCHhPBoDBjKbFDjDYfhiIjcj9MtFp
   o1FY/Y3kJ2kVENVIA2sg7s010cDVh40YInTqw/VspZKeZuLmQRhTXn2sF
   Q==;
X-CSE-ConnectionGUID: 4sxXWMGTTf+0BQQyHJr3ow==
X-CSE-MsgGUID: bOuaWFw2RMa+9pP2zK3mqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="71793893"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="71793893"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:18:27 -0700
X-CSE-ConnectionGUID: N3nhctrSSnavYWRNPqzbJg==
X-CSE-MsgGUID: MUo9qKZJTXiui09gg8s7Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="175559623"
Received: from gkhatri-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:18:27 -0700
Date: Thu, 15 May 2025 10:18:21 -0700
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
Message-ID: <20250515171821.6je7a4uvmttcdiia@desk>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
 <202505150911.1254C695D@keescook>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505150911.1254C695D@keescook>

On Thu, May 15, 2025 at 09:51:15AM -0700, Kees Cook wrote:
> On Thu, May 15, 2025 at 07:51:26AM -0700, Kees Cook wrote:
> > On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > >There is an observable slowdown when running BPF selftests on 6.15-rc6
> > >kernel[1] built with tools/testing/selftests/bpf/{config,config.x86_64}.
> > [...]
> > Where can I find the .config for the slow runs?
> 
> Oops, I can read. :) Doing a build now...
> 
> > And how do I run the test myself directly?
> 
> I found:
> https://docs.kernel.org/bpf/bpf_devel_QA.html
> 
> But it doesn't seem to cover a bunch of stuff (no way to prebuild the
> tests, no info on building the test modules).
> 
> This seems to be needed:
> 
> make O=regression-bug -C tools/testing/selftests/bpf/test_kmods
> 
> But then the booted kernel doesn't load it (missing signatures?)
> 
> Anyway, I'll keep digging...

After struggling with this for a while, I figured vmtest.sh is the easiest
way to test bpf:

./tools/testing/selftests/bpf/vmtest.sh -i ./test_progs

To test just the failing case, you can run:

./tools/testing/selftests/bpf/vmtest.sh -i -- timeout 20 ./test_progs -t verif_scale_loop3_fail

