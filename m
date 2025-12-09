Return-Path: <bpf+bounces-76366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A38FCB0155
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D0E3096CC5
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CBE329376;
	Tue,  9 Dec 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+Kpbu8n"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9CC322B79;
	Tue,  9 Dec 2025 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287474; cv=none; b=gfKcDkhqgx4yHyEmoxCtwwpLIs5BDdwopBjB9cUfike2VJN55LqRbapCwSIAFNrlCn7FRZk0fxyPNOPHpKn340wJM53THxkBV0dlfgWkgilrd9I8V+jbEE5zeXvuW91Cf2d+XDSbwwGIzotz/LzP0xrwGQU2v4ByCffyvowmbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287474; c=relaxed/simple;
	bh=w4P9sfpFZ21bhYvn0gM09omdKTKjYJiWFjzvEXjpHa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVblpc5akjd8SMVs2GRU77RmFyRaFVaKShFHAHnsq5cLlNZ5s28aAoYrlP89Zs2yt5T0cMqJVwQ6QdVr1xP6w0iR//DQeMkKg8aeYGUIZ5bCIbxrrumo25hOTT/fsueGsoyUm3oD972Ol6WhM2rEAVMkadcNxuzgNdKg3BQlRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+Kpbu8n; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765287473; x=1796823473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w4P9sfpFZ21bhYvn0gM09omdKTKjYJiWFjzvEXjpHa0=;
  b=Y+Kpbu8n1NaPYzV/mFh+O9xExOW/ZoCukJyG4E+BDg2RK+uaVIODHoOL
   gQhD32WfXssSe8k3u0ODy/rA6+tm/k+/xxB6JRZtykzVEsqybqpYRw2/d
   UIr3MW1zzJsvaPRVv5950SlKNT5SHfey92bJawUNoas8OEnmJWO06QdUj
   YbOb45Lq0+E/c7N2i904mZ5oPgs/Qq5IAXvGbLAitVwvxd2tFa7OAEQUU
   SVZllh8B4V3UPUOcTCEGVDyok4R/W0ijiXkvnSSWN0eXNJWsoBPzjf3jH
   x/32Wcx2X5hIV2b+0DmlnxaLInAViP2Zg+SACepZhiQwI1qfFPUt0oJM9
   A==;
X-CSE-ConnectionGUID: tavlh+i3Th+Ts6UTLz56Bw==
X-CSE-MsgGUID: OyNS/3DzSwWfs1WhcsiaUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67135728"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="67135728"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 05:37:52 -0800
X-CSE-ConnectionGUID: NawPaxlOTZCU/zZ0R8IbTg==
X-CSE-MsgGUID: krT6qFBySm6u2l79zkrWLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="196683954"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 05:37:47 -0800
Date: Tue, 9 Dec 2025 15:37:45 +0200
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
Message-ID: <aTgl_bjO1O9Ddpmv@smile.fi.intel.com>
References: <20251208161800.2902699-2-andriy.shevchenko@linux.intel.com>
 <CAADnVQ+SXe-CsPHnYkB4SOKct6iMN=PkexaKRd-MJFhC3i8M0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+SXe-CsPHnYkB4SOKct6iMN=PkexaKRd-MJFhC3i8M0A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 09, 2025 at 06:12:46PM +0900, Alexei Starovoitov wrote:
> On Tue, Dec 9, 2025 at 1:21 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The printing functions in BPF code are using printf() type of format,
> > and compiler is not happy about them as is:
> >
> > kernel/bpf/helpers.c:1069:9: error: function ‘____bpf_snprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> >  1069 |         err = bstr_printf(str, str_size, fmt, data.bin_args);
> >       |         ^~~
> >
> > kernel/trace/bpf_trace.c:377:9: error: function ‘____bpf_trace_printk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> >   377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
> >       |         ^~~
> >
> > kernel/trace/bpf_trace.c:433:9: error: function ‘____bpf_trace_vprintk’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> >   433 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
> >       |         ^~~
> >
> > kernel/trace/bpf_trace.c:475:9: error: function ‘____bpf_seq_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> >   475 |         seq_bprintf(m, fmt, data.bin_args);
> >       |         ^~~~~~~~~~~
> >
> > Fix the compilation errors by adding __printf() attribute. For that
> > we need to pass it down to the BPF_CALL_x() and wrap into PRINTF_BPF_CALL_*()
> > to make code neater.

> This is pointless churn to shut up a warning.

In some cases, like mine, it's an error.

> Teach syzbot to stop this spam instead.

It prevents to perform `make W=1` builds with the default CONFIG_WERROR,
which is 'y'.

> At the end this patch doesn't make any visible difference,
> since user declarations of these helpers are auto generated
> from uapi/bpf.h file and __printf attribute is not there.

I see, thanks for the review.
Any recommendations on how to fix this properly?

-- 
With Best Regards,
Andy Shevchenko



