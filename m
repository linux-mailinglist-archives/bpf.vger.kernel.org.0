Return-Path: <bpf+bounces-76412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BDCB2FAD
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 14:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55DB2305A60C
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D13254B8;
	Wed, 10 Dec 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TF7iQKB9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519F2ED148;
	Wed, 10 Dec 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372435; cv=none; b=f735iE5aossSx5mEKDCsPdAkC8iTAl3xTZGYsLU3j8jti5Encm5O8ZIY/2di9hzKVmAgVhyCRXJjF8ylY1heooGegNE5LiRjyt8wkXJano5bExKwhnFZKsQKZbTosMMnYbUxZUHDec9itzpAruR8AIYmrn+NqDt8SITHCle6cuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372435; c=relaxed/simple;
	bh=m2Nn+1oU0J3uuTi9iR3r2j/uvfvWBDhGvnGbUmCnCmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLPknqdVDdo3DssmrRuGlU2iTVyhQ/7f6j9EfHsxIZzPjgR2ycxLxnMnWJNsRME44hpI35J0ZFjLxb/HUOWqzR+/Ks4vBQ5KePv5hoBTGsbCIHiXG3aT81pGSK7y7esuPqHwruSTK4nrn9wzczS08FZIZPMy6VcIh4M2/t2o2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TF7iQKB9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765372434; x=1796908434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m2Nn+1oU0J3uuTi9iR3r2j/uvfvWBDhGvnGbUmCnCmQ=;
  b=TF7iQKB9AloUxrctG79kmgsKcc+FYHqJ9WF3Y3IzDG8747IvkhBYu2rs
   d7dwZ2PQBsoETuTdwRc6HGYLILJ9p79JKAOzDC+vFX0uEqcBkvvZWRms+
   Rf3+j2XvePyqUv2kYNjoJjQ0KAqDlFdGQ1uiPtBJUy3jJgeWky9cZoAAB
   BXFZDd4LHFo3SWPdJMtTpEQWYP8+JoV4aMqxbVqXyWRCpmTi7wS2c9iJI
   0/lnQBKFPLLuRsd5PuyZlkhMkrJxiS6Pke3rToNwN9DxNgTALRWcFAQDm
   7vBncQ01SyzLDC+xw36YibaGOy+pYcMN+kdQZUfWXWawhKJKzjTFJt+tO
   A==;
X-CSE-ConnectionGUID: CX+QdgVOROy2rBJPfzd/jg==
X-CSE-MsgGUID: lyOo4Vl5TvCKE5UuejRO9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="54886599"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="54886599"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 05:13:53 -0800
X-CSE-ConnectionGUID: LRtlJRVfTXmfd0pv7YW4rg==
X-CSE-MsgGUID: KiIc2YH2QJeq08XMiV1iPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="196109786"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 05:13:48 -0800
Date: Wed, 10 Dec 2025 15:13:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] bpf: Mark BPF printing functions with __printf()
 attribute
Message-ID: <aTlyCimsBUsU5QgZ@smile.fi.intel.com>
References: <20251208161800.2902699-2-andriy.shevchenko@linux.intel.com>
 <CAADnVQ+SXe-CsPHnYkB4SOKct6iMN=PkexaKRd-MJFhC3i8M0A@mail.gmail.com>
 <aTgl_bjO1O9Ddpmv@smile.fi.intel.com>
 <CAADnVQLkSoOL8+kELdmX5nzNcXm-s4VbA5+Q-MPcNySsSiu+RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLkSoOL8+kELdmX5nzNcXm-s4VbA5+Q-MPcNySsSiu+RQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 10, 2025 at 04:09:19PM +0900, Alexei Starovoitov wrote:
> On Tue, Dec 9, 2025 at 10:37 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Dec 09, 2025 at 06:12:46PM +0900, Alexei Starovoitov wrote:
> > > On Tue, Dec 9, 2025 at 1:21 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The printing functions in BPF code are using printf() type of format,
> > > > and compiler is not happy about them as is:
> > > >
> > > > kernel/bpf/helpers.c:1069:9: error: function ‘____bpf_snprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> > > >  1069 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
> > > >       |         ^~~
> > > >
> > > > kernel/trace/bpf_trace.c:377:9: error: function ‘____bpf_trace_printk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> > > >   377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
> > > >       |         ^~~
> > > >
> > > > kernel/trace/bpf_trace.c:433:9: error: function ‘____bpf_trace_vprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> > > >   433 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
> > > >       |         ^~~
> > > >
> > > > kernel/trace/bpf_trace.c:475:9: error: function ‘____bpf_seq_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> > > >   475 |         seq_bprintf(m, fmt, data.bin_args);
> > > >       |         ^~~~~~~~~~~
> > > >
> > > > Fix the compilation errors by adding __printf() attribute. For that
> > > > we need to pass it down to the BPF_CALL_x() and wrap into PRINTF_BPF_CALL_*()
> > > > to make code neater.
> >
> > > This is pointless churn to shut up a warning.
> >
> > In some cases, like mine, it's an error.
> >
> > > Teach syzbot to stop this spam instead.
> >
> > It prevents to perform `make W=1` builds with the default CONFIG_WERROR,
> > which is 'y'.
> >
> > > At the end this patch doesn't make any visible difference,
> > > since user declarations of these helpers are auto generated
> > > from uapi/bpf.h file and __printf attribute is not there.
> >
> > I see, thanks for the review.
> > Any recommendations on how to fix this properly?
> 
> Add -Wno-suggest-attribute=format
> to corresponding files in Makefile.

Thanks, I just sent a new patch.

> I think it's cleaner than __diag_ignore() in the .c

-- 
With Best Regards,
Andy Shevchenko



