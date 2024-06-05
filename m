Return-Path: <bpf+bounces-31440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBEE8FD06F
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EED1F26941
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CA17996;
	Wed,  5 Jun 2024 14:08:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FEC10A36;
	Wed,  5 Jun 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596481; cv=none; b=tYcVxTH3CSI+7jWmue3PHg2EvySTVSvFPYNbN6EXBoNkl6XD4CXuePHYwaQfrQK8jSHn8OMCqu1pmYgpStSeZh78dYpmPkm0ygVdl0Tjeo2G5YA1EoJ1/2Lpt20BDGWxexYxfAlQNOskMfoho/bYgJ0p7KZ1eo7NyIWaufUWleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596481; c=relaxed/simple;
	bh=b+SI0Tg90J/6xJIl7KUZqAmw1jv9An2oJ/VG+j4rTMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBIM8k+YfKNYMsWCEN6gQUmhTOebaegkL93BrDIewaICVU0cNUOSZzTh4q4O7SWwvtS0IYRQLdA9TXiPv2N31pC5Fpa0FvDVifEHWA1gt4nhLfOzvU2yfVzLO0oNkAibXtR8h97QSrYOhzPPqVzPE2xbL41lewNq1JwPeg+84oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 087C3339;
	Wed,  5 Jun 2024 07:08:23 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D9D33F792;
	Wed,  5 Jun 2024 07:07:55 -0700 (PDT)
Date: Wed, 5 Jun 2024 15:07:49 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Florent Revest <revest@chromium.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 00/27] function_graph: Allow multiple users for
 function graph tracing
Message-ID: <ZmBxNcLtvx0A2asd@J2N7QTR9R3>
References: <20240603190704.663840775@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603190704.663840775@goodmis.org>

On Mon, Jun 03, 2024 at 03:07:04PM -0400, Steven Rostedt wrote:
> This is a continuation of the function graph multi user code.
> I wrote a proof of concept back in 2019 of this code[1] and
> Masami started cleaning it up. I started from Masami's work v10
> that can be found here:
> 
>  https://lore.kernel.org/linux-trace-kernel/171509088006.162236.7227326999861366050.stgit@devnote2/
> 
> This is *only* the code that allows multiple users of function
> graph tracing. This is not the fprobe work that Masami is working
> to add on top of it. As Masami took my proof of concept, there
> was still several things I disliked about that code. Instead of
> having Masami clean it up even more, I decided to take over on just
> my code and change it up a bit.

FWIW, this is useful to me as-is for testing stacktracing.

Before this series I had some horrid hacks to manipulate the global
filters, and after this series I just need to manipulate the filters in
fgraph_ops::ops, which is *much* nicer.

I've pushed out my WIP to:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stacktrace/tests

... which is all to say, this is useful and I've given this some testing
beyond the usual ftrace tests.

Mark.

