Return-Path: <bpf+bounces-78133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8ECFF6F7
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132C230FDB52
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 17:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A621399A7C;
	Wed,  7 Jan 2026 17:14:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF64399024;
	Wed,  7 Jan 2026 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806053; cv=none; b=RzCGY/bTwhOy9m51EbkyIhjgCq41efA4PFlcXgXrHoonchIdED8yisZ/p8mnZL52iuVyfAD1QGiFkydA810kX0hKc69PicmYwopkvKc1Nz8r3YTUbLfzf1VwDRh/K09+7RXRcWwj9NrCX8sqZNuNZkUwPmmJul3TbFDl/69lDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806053; c=relaxed/simple;
	bh=P8Wc8HgFNKr9vOAd8pPm/71P3yZTRWKgefzr3RYEANo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbC1rsYDfI7rPdAHNHrpI/FN0vn+yM2mfXd4gaRb46OXaJlgvK+oCHgR3r2WgW5W/X/84s8qR1+BPa0RWoFcCyBO97ZADi5DsuJDFy9V2sCOWTehbi1lMWIdNNTZIkNxNwGB669KxDou+p7k/UvobkMcmft1DCge/0HWrKCptYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0F98113AE00;
	Wed,  7 Jan 2026 17:14:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 6B0F92F;
	Wed,  7 Jan 2026 17:14:05 +0000 (UTC)
Date: Wed, 7 Jan 2026 12:14:32 -0500
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
Message-ID: <20260107121432.73fccf84@gandalf.local.home>
In-Reply-To: <aV6PZKx9g_hCz4ZW@willie-the-truck>
References: <20260107093256.54616-1-jolsa@kernel.org>
	<aV5qpZwxgVRu2Q8w@willie-the-truck>
	<20260107110814.1dfc9ec0@gandalf.local.home>
	<aV6PZKx9g_hCz4ZW@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6B0F92F
X-Stat-Signature: x699t8kczy5smeco8119n45nwyhjh7kg
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/eu39LNRtM+1f1vTfX4QNOH6R7Y6POl28=
X-HE-Tag: 1767806045-271552
X-HE-Meta: U2FsdGVkX18bqAQ0pJDQFkJKpjD++ZFbUeHomqsNgRoCLor9V56o+Khto2aWB3wznp+gQ2/oE2h1SOvfL+LLrlkN8aerHgOvhp5QuGzQDrvm8wjk50Vo4f6vq+oc6JWvx2wiBBzZ2hZX5Vemc4FHjU/IDUy/Tv1J3di6HgNaVO+5rGvw/ktLj+UOI0+sMf/7CG5uwpl58yJgEdq7b+/+n+w28TiwBvwDT6ffskoAc39+I3kyasYoO2BbRAlNIeUQLEo/HDQr/sh/1PtHym0b+3rwzF5Hx7Cmjngd+TGtg5So6tMt07t6JeHSCHNk9YNPXZgETTRo6t3rcmtjaBukt9lCCBuUE+hd

On Wed, 7 Jan 2026 16:52:52 +0000
Will Deacon <will@kernel.org> wrote:

> diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> index 15627ceea9bc..3ebd8cdac7c6 100644
> --- a/include/linux/ftrace_regs.h
> +++ b/include/linux/ftrace_regs.h
> @@ -33,6 +33,15 @@ struct ftrace_regs;
>  #define ftrace_regs_get_frame_pointer(fregs) \
>         frame_pointer(&arch_ftrace_regs(fregs)->regs)
>  
> +#else
> +
> +static __always_inline void
> +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +       ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
> +       ftrace_regs_set_return_value(fregs, regs_return_value(regs));
> +}
> +
>  #endif /* HAVE_ARCH_FTRACE_REGS */
>  
>  /* This can be overridden by the architectures */

Hmm, maybe that would work. Of course you forgot to add the helper for the
!HAVE_ARCH_FTRACE_REGS case ;-)

-- Steve

