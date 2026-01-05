Return-Path: <bpf+bounces-77883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFCCF5A93
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 22:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 393E630B6B6D
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC622DF3EA;
	Mon,  5 Jan 2026 21:22:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B452C0F9A;
	Mon,  5 Jan 2026 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648131; cv=none; b=GUxvL1soNWssohy4aglG6a4emWPfryoJ1/6dotpSaEPz+Kmw9wi6BDxPVoExHvHmBQEjoGNnRhNKf11r5GvCCPc7TQnkXuMvpvhLOI2b7ZzfpfNC3M4rpj7Qawohb04Oee4LCsVpwg5tg9FBKk09n9pjfoaxQQwfUB0GYa1JzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648131; c=relaxed/simple;
	bh=/4LG7CDdqJUY6pZpMD1nOz2/+uLhL8GybzhjhqfdOu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grTfY47K+5h02mvt5x3zyRm66e8YLPnc5IJBYpAd998DTBuKNNX4yIrSIHY9A6Xc9IiSET0CvTTL4lQ31+uuDyvMcRVnbSuHRbqe3JU9/ayA3HIdEL9hEVHmwmJj0au1nkvshUI/H9pV5Na+bJi+SHl/bGpRIZOML6CqGkDnh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 078001A0230;
	Mon,  5 Jan 2026 21:22:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 5A2488000F;
	Mon,  5 Jan 2026 21:21:58 +0000 (UTC)
Date: Mon, 5 Jan 2026 16:22:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Yonghong Song <yhs@fb.com>, Song Liu
 <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <20260105162220.6ba5129a@gandalf.local.home>
In-Reply-To: <20260104223415.0a31f423c861c0b651de966b@kernel.org>
References: <20251105125924.365205-1-jolsa@kernel.org>
	<aVfbqYsWdGXu4lh8@willie-the-truck>
	<20260104223415.0a31f423c861c0b651de966b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5A2488000F
X-Stat-Signature: xt5nzh7j77fp944s7jzizhee1d83wp5j
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19QBzPgleTeDd4xKX+cLaHUy58FxQPd0Kc=
X-HE-Tag: 1767648118-884322
X-HE-Meta: U2FsdGVkX1+rGfZVoK/OULBRFq26IDTCOyJJZkPrf1/Qa14p2mE3SqwSd2AimRvlIvDVEd8pQgw0Y72mGmizrkSEvnjFQ91d+SsTt2Ihf1ODGxFW+OEY6DInWgnHijwrMtbOQ58FqR6KY7yGryX5bEkGZExbO4di5WotTjnQacEQ42hk8Ktkd7J9fG0WrCvcO97/OKDk+be0YtNFkroPVr4HXRGjix1N8zS6oUsNujtLAyaaVLmj5YsKDUOXe9fRTNDkdHckDe1ArW4kboKsHf2mGMb2i4ClK7czP2og0vQZQniUMj3+3yvA4v+IhIQWnzBFXkWNPqDrdzlbtpx/y5s3DpEYaggy

On Sun, 4 Jan 2026 22:34:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > This looks a bit grotty to me and presumably other architectures would
> > need similar treatement. Wouldn't it be cleaner to reuse the existing
> > API instead? For example, by calling ftrace_regs_set_instruction_pointer()
> > and ftrace_regs_set_return_value() to update the relevant registers from
> > the core code?  
> 
> I agreed with using the generic APIs. Also, ftrace_partial_regs_fix() is
> not self-explained. Maybe ftrace_regs_set_by_regs()?

Or perhaps: ftrace_partial_regs_update() where you call it if you need to
update the regs.

/*
 * ftrace_partial_regs_update - update the original ftrace_regs from regs
 * @fregs: The ftrace_regs to update from @regs
 * @regs: The partial regs from ftrace_partial_regs() that was updated
 *
 * Some architectures have the partial regs living in the ftrace_regs
 * structure, whereas other architectures need to make a different copy
 * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
 * if the code using @regs updates a field (like the instruction pointer or
 * stack pointer) it may need to propagate that change to the original @fregs
 * it retrieved the partial @regs from. Use this function to guarantee that
 * update happens.
 */
static __always_inline void
ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) {
	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);

	if (afregs->pc != regs->pc) {
		afregs->pc = regs->pc;
		afregs->regs[0] = regs->regs[0];
	}
}

-- Steve

