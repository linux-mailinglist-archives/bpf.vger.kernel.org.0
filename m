Return-Path: <bpf+bounces-78131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30144CFFBBF
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 20:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD5A8301EA26
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371B36B056;
	Wed,  7 Jan 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnoEz4Jt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A936AB6C;
	Wed,  7 Jan 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804778; cv=none; b=spOcJ73qkqLkLAxznXfAe+o5MgFjm0OkC+xByldxxeKfkzLtGUhFTvrcobEY1YmBUUbOw7diMdxYOGP3KXdpvgcSTRQSd5/wInY+RC9wN0RoepSBAr+q1T3JWYVRXH9Z7P5X5R6RxGMytDoOdCvV0AWSGYvEOa1KyGqXgSrhU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804778; c=relaxed/simple;
	bh=Shd5mmE6P/nw2xrOG+cMibnmSWeGIUUuJFYBTbfi5iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4+a8WOtAS5CYDPkm2SsGsUotKzwpOpHcTICs3Tz5ln63ad+UTVx3s29YWY3rMpj0CK2Vl1TOCL/Xuwg3i2C4DAwvMPg/4TA6Rw1AOepKLPmLE1Sox9WInrVXybyCfR6h07tgfBZgslh6PEB8dlq2ZK98QDi4wqHi2m38JjEiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnoEz4Jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F72FC4CEF1;
	Wed,  7 Jan 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767804777;
	bh=Shd5mmE6P/nw2xrOG+cMibnmSWeGIUUuJFYBTbfi5iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnoEz4JtCLop4X4PmitW0XkO8WuKzicKzFLLTRTvi8ez8CGlhK54G4YScYsh9Ny5S
	 4FeGWKN/7H+ylfe6GSdmvtSgPm0tx2MGAM0ncv1D7TgCEOPZWHM/6w5grHuSm9RQrQ
	 rKRxdpls3RItooMiVVpE8eSHq/vRIf1Hg2bqtKZpZlYzdAVFuXzQn//ya/AQaFQnAp
	 JoVf+NygHhhbt/Dl9xa/Jk+iqK6u+8VeUw6zK+Liy2ipvCRPW+HbFjImnISDkwWLZC
	 XDTnAOHFZTietBXOkVibkpFNiEzUwSPjq1jomQ+E6bomd+y+5+VA/X1e65HUBkUqNX
	 xLkxAWB3iaMeA==
Date: Wed, 7 Jan 2026 16:52:52 +0000
From: Will Deacon <will@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV6PZKx9g_hCz4ZW@willie-the-truck>
References: <20260107093256.54616-1-jolsa@kernel.org>
 <aV5qpZwxgVRu2Q8w@willie-the-truck>
 <20260107110814.1dfc9ec0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107110814.1dfc9ec0@gandalf.local.home>

On Wed, Jan 07, 2026 at 11:08:14AM -0500, Steven Rostedt wrote:
> On Wed, 7 Jan 2026 14:16:05 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > I still don't understand why we need anything new in the arch code for this.
> > 
> > We've selected HAVE_ARCH_FTRACE_REGS and we implement
> > ftrace_regs_set_instruction_pointer() and ftrace_regs_set_return_value()
> > so the core code already has everything it needs to make this work
> > without additional arch support.
> 
> I believe the issue is that the BPF code takes a pt_regs and does the
> update directly with that, and not the ftrace_regs.
> 
> I'm guessing this is due to BPF programs modifying the pt_regs directly,
> and BPF programs do not yet understand ftrace_regs?
> 
> Because arm64 requires making a copy of pt_regs as the ftrace_regs has a
> different layout, and the ftrace_regs is what does the changes, if the
> pt_regs passed to the BPF program modifies the values it needs a way to
> propagate that back to the ftrace_regs.

Sure, but isn't that exactly what selecting HAVE_ARCH_FTRACE_REGS says,
and so any other architecture (i.e. riscv) using a separate structure
will run into the same problem?

In other words, add the helper to the core code along the lines of the
diff below (purely untested, just to illustrate what I'm trying to get
at).

Will

--->8

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index 15627ceea9bc..3ebd8cdac7c6 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -33,6 +33,15 @@ struct ftrace_regs;
 #define ftrace_regs_get_frame_pointer(fregs) \
        frame_pointer(&arch_ftrace_regs(fregs)->regs)
 
+#else
+
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+       ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
+       ftrace_regs_set_return_value(fregs, regs_return_value(regs));
+}
+
 #endif /* HAVE_ARCH_FTRACE_REGS */
 
 /* This can be overridden by the architectures */


