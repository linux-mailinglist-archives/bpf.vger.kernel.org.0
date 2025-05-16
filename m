Return-Path: <bpf+bounces-58435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B4ABA6A5
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 01:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6459E52E3
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36940280A4F;
	Fri, 16 May 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppqGVL9g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B9615A864;
	Fri, 16 May 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438798; cv=none; b=ogPDXqazK+0XR7PTS+akIqnznOJ7lplLyTaLubYHu7mO4beqTOgaFbGbZdfjp1F87qbZtv9CTlFwvok6HFJz7xnE/dMCT7XgjshCF7Qwb4yE4c4e82TMLLxXLw0UE0z4uUfXRpoLRzsboh8N78+kEVla0MUwQzAsM4txrPIucBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438798; c=relaxed/simple;
	bh=ZnhbJTHLnRU1UH5fVm5xDrM1RteNhU1E7+sHfCEeuI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTP4Vb6YIsnZCOC0Tg8v7R/w/d9bDd9Lc7RBGrSE6UxRr1jUVVHWvtZTXil0hJo/NmDVlOC1S+XOQYEPzE5SWU0w4gMgLubTS665iX+Kb9I9GlhNYW2GhmwU9YUvDsdjwk7crGM3PL/E2lvUDf61s2e2vO3+zWB2Xjcb6U9Fzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppqGVL9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA1BC4CEE4;
	Fri, 16 May 2025 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438798;
	bh=ZnhbJTHLnRU1UH5fVm5xDrM1RteNhU1E7+sHfCEeuI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppqGVL9g7CFrff2vjAMI/MVmwurD0YSjKo3QWfcd2JLE2KZQvtESZgVDrt19tuKoo
	 xV+W5HwVqil2fzxNswlUAFvQk36ybMfgGZCO6xG+tMrNK6hHPpyN2p8y6wxsVwipyl
	 y3Nl/mZGh507yumxQ7NoKUOqSbeF/MS1VixwFELL3iAPZNwV0RkBL48DZGbsdZ65Ls
	 6WPO2a93YNT9JK0xlhS8Y32ZvgI0NIs2UazgQXWC37oyy+V2GD2cpxzkA17SjHHaol
	 7KxE1Xp1NMrHWa+p5i6q0KZwqRmbhaXrnziOmQ/PHTkGsBqiZ27W/rrQv7VOfINt3d
	 YfgNtwZ/QTdPA==
Date: Fri, 16 May 2025 16:39:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <aCfMzJ-zN0JKKTjO@google.com>
References: <20250513223435.636200356@goodmis.org>
 <20250514132720.6b16880c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514132720.6b16880c@gandalf.local.home>

Hi Steve,

On Wed, May 14, 2025 at 01:27:20PM -0400, Steven Rostedt wrote:
> On Tue, 13 May 2025 18:34:35 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > This has modifications in x86 and I would like it to go through the x86
> > tree. Preferably it can go into this merge window so we can focus on getting
> > perf and ftrace to work on top of this.
> 
> I think it may be best for me to remove the two x86 specific patches, and
> rebuild the ftrace work on top of it. For testing, I'll just keep those two
> patches in my tree locally, but then I can get this moving for this merge
> window.

Maybe I asked this before but I don't remember if I got the answer. :)
How does it handle task exits as it won't go to userspace?  I guess it'll
lose user callstacks for exit syscalls and other termination paths.

Similarly, it will miss user callstacks in the samples at the end of
profiling if the target tasks remain in the kernel (or they sleep).
It looks like a fundamental limitation of the deferred callchains.

Thanks,
Namhyung

> 
> Next merge window, we can spend more time on getting the perf API working
> properly.
> 
> -- Steve

