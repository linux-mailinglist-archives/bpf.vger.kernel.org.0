Return-Path: <bpf+bounces-78129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFA3CFF1DA
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 18:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B4F831CC736
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF038BF80;
	Wed,  7 Jan 2026 16:08:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E833A01E;
	Wed,  7 Jan 2026 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802084; cv=none; b=YCGKs9idJOR6AVq+sespyyKnnsSXhR5XiaEyb1Iv5kWdRSQ02fG6pFSB7UnGMhMqj9C15ECc2LT/IZ9Te0bvCu8H7BCJ1Sutaw0KrZqA66SkizWxEQyJwdOoWoDThxxJh6aDTXreXce/vJrFw348SGr4mV2ayJYdBoDjWKqD1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802084; c=relaxed/simple;
	bh=rAdTjzfI6ZefcjNO2L8Jejw5vRP0yRdJuiyw0aoSZQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltUbPokvGAqLAA5TNnRwe5aD0i3fVzbijywg/3RTAS2VBsu6T2fcNpJKcyV+W53khQhGEZINoCCIF5+tm0GLy6UFanVqFPUSpTuYhE3MOU4cHQ8DJo9RPOp4I+b4NAVLwVPZZyzq09TaKXsajZdtRNyDViI0Pm5yk5sAjajFsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id DB827160420;
	Wed,  7 Jan 2026 16:07:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 301EF2000E;
	Wed,  7 Jan 2026 16:07:48 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:08:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mahe Tardy <mahe.tardy@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <20260107110814.1dfc9ec0@gandalf.local.home>
In-Reply-To: <aV5qpZwxgVRu2Q8w@willie-the-truck>
References: <20260107093256.54616-1-jolsa@kernel.org>
	<aV5qpZwxgVRu2Q8w@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qy4j19qy53bj957cygb9gkss444jbwzi
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 301EF2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Psz/3Po3Wu+zE9EFiNolFBPIekU7NMl0=
X-HE-Tag: 1767802068-600516
X-HE-Meta: U2FsdGVkX19MpXNmjRTzf5eqNvutq13fH6LNi6K+gfHE6MtwcqV9v17WFTdDoZ8hnovtbZRxIDPYuPGSnvVQCPErohKxIFTHtJ3uDJi0CJvWrwxOSPNMwdbhjophPBLCXWhG8yHdzUuQ6JTsnRw2906L0DpujHMONSJT/3aVtTdaEybCmKF1nYcXDFg6NwiuJoCoPl+iio7bxppqMkJx2nyNMjvkNM2F5DGs1OoayfjqZtxfFwAIADNBVxZv81v1kVsEIr92L9frvqK9SgbPTxiFrrSFhOXnUVht2QY/GD9Sh0hUXlym1QLlWvB0Jke+Gl3j9N4ImY5uAJYWmYknfOXC8irHT0XR

On Wed, 7 Jan 2026 14:16:05 +0000
Will Deacon <will@kernel.org> wrote:

> I still don't understand why we need anything new in the arch code for this.
> 
> We've selected HAVE_ARCH_FTRACE_REGS and we implement
> ftrace_regs_set_instruction_pointer() and ftrace_regs_set_return_value()
> so the core code already has everything it needs to make this work
> without additional arch support.

I believe the issue is that the BPF code takes a pt_regs and does the
update directly with that, and not the ftrace_regs.

I'm guessing this is due to BPF programs modifying the pt_regs directly,
and BPF programs do not yet understand ftrace_regs?

Because arm64 requires making a copy of pt_regs as the ftrace_regs has a
different layout, and the ftrace_regs is what does the changes, if the
pt_regs passed to the BPF program modifies the values it needs a way to
propagate that back to the ftrace_regs.

-- Steve

