Return-Path: <bpf+bounces-71015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9916ABDF8B6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 195DB3550A6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9A2BDC13;
	Wed, 15 Oct 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL42Blju"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC0251793;
	Wed, 15 Oct 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544376; cv=none; b=ILrQ//4u67GSdjd460WTmeF1VWuyLstS8NRJ5JffnZ9YGJMmuoRNxAkXljb1zZQ8BH+WdyoR0GfqnDTc1xG21v/tUqlSXm9b811qiZOLjUxXTt3t5t4qOaC+onuEbnAtzMW0RgWFTia3Qewi2T/kJwBvPAXCGMrtwUEDcc9uCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544376; c=relaxed/simple;
	bh=C/N/NtfPmuyxAj5lAzPLaqfB56MOMHHwsLP7fdrBHU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlaXJGXS0hPA7iqhT8rknVyD9Mr4qbQ27xH+e8Ts733c3j1obR/cUwFmeiM+MMwWfXQm49yJvdosOVo6TJ56v6EHmo3C1Q+k3/Sc7nioDp/LSQZJ+pketkYkYh0d/SePTCV00eN1H2bWlozFiKV/XBz3wvpV64zo3Bi6XJ86cIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL42Blju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461DAC4CEF8;
	Wed, 15 Oct 2025 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760544376;
	bh=C/N/NtfPmuyxAj5lAzPLaqfB56MOMHHwsLP7fdrBHU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL42BljuSYvWrT4+9nK+FJZJ6TDUarvYIdGnoZByI/qGSxbGKjoT2shkuqIdrY2IG
	 0uxT9+CH0+8LRjWq0Ih5G2gWSVXI+ijQwbe3LBqSXZxvs2pftEUU5VEysUuqAcIG1J
	 g5IpPcRNkNCwk7SxHeshQ3bHm1XKf1lJ5aFD2piqiPbnppyXhDR6CTT7eIEiPLBRHe
	 YWnzTMVm2ynjGGYsRmnGli3Y5YIvi0eRy97fcHdO8xOmcBsmGr2Quo1HAo0AXokGOv
	 EZQv40IQ2PNkDh+bJBhSKisbZjCTtX3yxBFhJHZJ09Rz8bzdcfXO4lIid5dnbItj39
	 cCVQf9z5FA28Q==
Date: Wed, 15 Oct 2025 09:06:12 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, Yonghong Song <yhs@fb.com>
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <wh4eq2iw3qwiuaivz67ygyd2zvafaqrq7i6eakvbdurrbbrcg5@jjfbagedoybk>
References: <aObSyt3qOnS_BMcy@krava>
 <20251013131055.441e7d08@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013131055.441e7d08@gandalf.local.home>

On Mon, Oct 13, 2025 at 01:10:55PM -0400, Steven Rostedt wrote:
> On Wed, 8 Oct 2025 23:08:26 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > hi,
> > I'm getting no stacktrace from bpf program attached on kretprobe.multi probe
> > (which means on top of return fprobe) on x86.
> > 
> > I think we need some kind of treatment we do for rethook, AFAICS the ORC unwind
> > stops on return_to_handler, because the stack and the function itself are not
> > adjusted for unwind_recover_ret_addr call
> 
> Hmm, we do have a way to retrieve the actual return caller from a location
> for return_to_handler:
> 
>   See kernel/trace/fgraph.c: ftrace_graph_get_ret_stack()
> 
> Hmm, I think the x86 ORC unwinder needs to use this.

I'm confused, is that not what ftrace_graph_ret_addr() already does?

-- 
Josh

