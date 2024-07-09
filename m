Return-Path: <bpf+bounces-34243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB7792BC80
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1883BB2561B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298CD18F2CA;
	Tue,  9 Jul 2024 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKSydfxv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEF257D;
	Tue,  9 Jul 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534223; cv=none; b=ivE+WXWP1e9F0NWlORA+y498WYeVkudwBoFY7/Jm4QeIdGlkHpdDKiyuU0O+EK2C2T40zzbH+VgC036aOdq0cDdO5+ap9EYNSz8nUJ6IWXDajv7m9o6vw6lwupEAOaGz7c5fZe5oFEgiEdSKgEJ/3j7hZ2Prdjirt0cMTP8V4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534223; c=relaxed/simple;
	bh=Vrb8yjdL/D92mOVV8Vty0L+ciGQXDNHk1wnDb0gv6fQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bFdXSInDbPb6R1XSdVTulY2np1+K40tIZUmsfl4BZuuABj6s5yK2hVUlOu+J6gSi9YcsIRGg4XPtJ1WPyCpoKBDOS43EQCjTW01+pYuMLPDV5xvRUgtgG1Y1VdPo88IYdYheIJ5ObTGUijDWf31sN8yqffICQWNNOZP+ep4NJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKSydfxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F9DC3277B;
	Tue,  9 Jul 2024 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720534223;
	bh=Vrb8yjdL/D92mOVV8Vty0L+ciGQXDNHk1wnDb0gv6fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GKSydfxvBgIArCp9fJE4FC22QF8thVQloQ0WFAdJs+Sw+nw4EXHZI2btEIU7KcMhg
	 dcdN03E4/v/xk2SI6gvVWgDo0SEuylJehPw/IDyxXFmkE0gY0p+FpoKe/td3ououOa
	 ETECJhplc5lDtTXQcuRkh5GqEUVA77JC54uUdMtZZUEsNvIial20jv1FN1qdNwc7oW
	 SSqucLYfoPbE30S6xcV1LB2DGmp//uml0ewnCGQhEkepv09rns+ADLOp5Vfnozwln7
	 ZjlsQycSX7SFqjqSIfs4AsG2zQ3vUOVT0Fe11zHOgCbteBvw7FjOytfxuUuMyTcqNW
	 YxDZ3ZXYbVnmg==
Date: Tue, 9 Jul 2024 23:10:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com,
 tglx@linutronix.de, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-Id: <20240709231017.e8d5a37c96d126d1f7591a0e@kernel.org>
In-Reply-To: <20240709101133.GI27299@noisy.programming.kicks-ass.net>
References: <20240708231127.1055083-1-andrii@kernel.org>
	<20240709101133.GI27299@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 12:11:33 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 08, 2024 at 04:11:27PM -0700, Andrii Nakryiko wrote:
> > +#ifdef CONFIG_UPROBES
> > +/*
> > + * Heuristic-based check if uprobe is installed at the function entry.
> > + *
> > + * Under assumption of user code being compiled with frame pointers,
> > + * `push %rbp/%ebp` is a good indicator that we indeed are.
> > + *
> > + * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
> > + * If we get this wrong, captured stack trace might have one extra bogus
> > + * entry, but the rest of stack trace will still be meaningful.
> > + */
> > +static bool is_uprobe_at_func_entry(struct pt_regs *regs)
> > +{
> > +	struct arch_uprobe *auprobe;
> > +
> > +	if (!current->utask)
> > +		return false;
> > +
> > +	auprobe = current->utask->auprobe;
> > +	if (!auprobe)
> > +		return false;
> > +
> > +	/* push %rbp/%ebp */
> > +	if (auprobe->insn[0] == 0x55)
> > +		return true;
> > +
> > +	/* endbr64 (64-bit only) */
> > +	if (user_64bit_mode(regs) && *(u32 *)auprobe->insn == 0xfa1e0ff3)
> > +		return true;
> 
> I meant to reply to Josh suggesting this, but... how can this be? If you
> scribble the ENDBR with an INT3 things will #CP and we'll never get to
> the #BP.

Hmm, kprobes checks the instruction and reject if it is ENDBR.
Shouldn't uprobe also skip the ENDBR too?

Thank you,

> 
> Also, we tried very hard to not have a literal encode ENDBR (I really
> should teach objtool about this one :/). If it somehow makes sense to
> keep this clause, please use: gen_endbr()


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

