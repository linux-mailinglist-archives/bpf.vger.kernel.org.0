Return-Path: <bpf+bounces-22094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B86856938
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 17:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591CC1F2021D
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A841386D9;
	Thu, 15 Feb 2024 16:10:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E43133402;
	Thu, 15 Feb 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013402; cv=none; b=WAXvpHSx4+ti3+ygXjPsro5jW+iWhKPS33VoP0yzemekeJAOUV8xpZlqSEoOKn4RqXzjrSj3ZCDYs/0I5pcepOnDYDgbM0TKmA/Ghk0yWksd2v3/giKYclsjY39G5OKA9BpHangDaT/jb+CBFvOEsguX4RRi/zARlajcVRMPkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013402; c=relaxed/simple;
	bh=u0TeSmVIJ93SBLQ3hOzzlF7PCXukg0LB0O2Qw6z3JqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piMeRWhnZL52394OAs/9KG53l2MLOehGF4EL/GdrS38H7qycj2Jj+ytpuxcAPzSG+dW2audfuNQ0E2+P5/Umy4vwAnTh1csBd1U81DXr3b9NCYJM/vNSSD3uD5x1MHQdWDyxqc8umGwyZRo9gcCkHyr3pIyZSFk09qelKhNSNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF52C433F1;
	Thu, 15 Feb 2024 16:10:00 +0000 (UTC)
Date: Thu, 15 Feb 2024 11:11:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 28/36] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-ID: <20240215111134.7bfd1408@gandalf.local.home>
In-Reply-To: <170723236068.502590.9568421023325291255.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723236068.502590.9568421023325291255.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:12:40 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.

This says what this patch is doing and not why it is doing it.

-- Steve

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Florent Revest <revest@chromium.org>
> ---
>  Changes from previous series: NOTHING, just forward ported.
> ---

