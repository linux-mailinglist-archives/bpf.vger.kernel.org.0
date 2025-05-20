Return-Path: <bpf+bounces-58588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B3AABE0A8
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1021885143
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEA426AA91;
	Tue, 20 May 2025 16:28:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA71258CC0;
	Tue, 20 May 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758502; cv=none; b=OSBlyobcJ1JTrHwxRPs/ZxEaImYa0iWsgUMOSMqJ2t4Vo2m+rNOKmC+xKedOVDl/U1Sq/umddHon9Pz7zh3P3fdhFAEUwRuBnkvtvyr4svTtYbAipnJNFJIdNOqvzpGl8W3miQslmTiXqIdQqzjFQdPMRaqmx15cTsXQtWDhync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758502; c=relaxed/simple;
	bh=3h7pzFFp1arnliL6WNRF7D9w/8BVZFQJvxDtegXhXXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bl76TdSmiA866CDQDwFGPbIUDfWH7AwHgpObgTEuNvmUrKPgsiyBR2aG8CNQW4GsbUmBd6HU080p+9u3FajGpzimMOOiR65iKcg4OOpF5bXNQQ8HauFUZY/cAqzRmnpDV8KGf0sBiAhfngydZbdZ3Vwg3N/8n8qfST6enJj7VtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E82C4CEE9;
	Tue, 20 May 2025 16:28:19 +0000 (UTC)
Date: Tue, 20 May 2025 12:29:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrii
 Nakryiko <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, Indu
 Bhagat <indu.bhagat@oracle.com>
Subject: Re: [PATCH v9 00/13] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250520122900.42fc5b92@gandalf.local.home>
In-Reply-To: <20250520115721.7a4307a2@gandalf.local.home>
References: <20250513223435.636200356@goodmis.org>
	<20250514132720.6b16880c@gandalf.local.home>
	<aCfMzJ-zN0JKKTjO@google.com>
	<20250519113339.027c2a68@batman.local.home>
	<aCxM_BizulyIVcdb@gmail.com>
	<20250520115721.7a4307a2@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 11:57:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> For 6.16, I would just like to get the common infrastructure in the kernel
> so there's no dependency on different tracers. This patch set adds the
> changes but does not enable it yet. This way, perf, ftrace and BPF can all
> work to build on top of the changes without needing to share code.

Another thing that would work for me is not to push it this merge window,
but if you could make a separate branch based on top of v6.15 when it is
released, that has this code, where other subsystems could work on top of
that, would be great!

-- Steve

