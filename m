Return-Path: <bpf+bounces-54604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D1A6D92D
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 12:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59E516D941
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0F125DD1E;
	Mon, 24 Mar 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvo9EfCF"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE91DDC08;
	Mon, 24 Mar 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816002; cv=none; b=uHrbw6UcOb5XxuWRDKY1mM9JdQ7vWA9VBuh/ET+SrYwCEmeTeiiwJyelobsKdFfdjtx//jrFSQrt4NO7occyxX2g5zFdgJgbzGircmV7M3LUclrhqgwH4PgzKb6m6/D3t20NZQDxyV5t9L0n+sSeLOZJOuV+YU0M15EFldE9D4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816002; c=relaxed/simple;
	bh=LNqKKaEMLDRc5uTdAT5VBNT4/Fzv/R+FSPFkWmRjSrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV1CRe9hPc6PL0bZv/zW9EGUY46IVx3lZM1As+SpVI2Hdw/nPTse8s0c7BYg7RVoM0gsrOIZytAxtp4P+R9T8WZlGDmZPIQbzz4lNt5rjJs+6bIF3IxT3p7mZjtkgNagnEmM1l37V+Wg5brFDAxnkIDWkrvfRZp/kNhpbfSm5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nvo9EfCF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LNqKKaEMLDRc5uTdAT5VBNT4/Fzv/R+FSPFkWmRjSrw=; b=nvo9EfCFlrSuk8fEW7PdcghMqL
	KtYr32/DfEul0FHdd1PyB+5Miar/PlB40hTsJLPl+vgiioBeoQIZIjtdw59XjHrZfIlkNDXnvnZV3
	8smSJsWs7wZH2PnW/86pw6SyD7zoNTEWRmVr+UOWMLiSpXVK9/VO2E9+/Re8dERv2ROGvaDREzHR9
	2f+hVJjxvJCr9bYrWDBWXPEekJS/V6nxaXgnknikQIXsrd6vvzzBWiJVOpruQGcNvg4IqJNxNiy6d
	kp9KvtDKgBQjJ8kMSeW8qFdLIfCDUMoRdisTkUfsbiTisx39s5fK7c3ucMmYPo5SAl7b8ok9QKdl8
	S/6XMS5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twg3F-00000005Duz-2CgV;
	Mon, 24 Mar 2025 11:33:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7D72B3004AF; Mon, 24 Mar 2025 12:33:04 +0100 (CET)
Date: Mon, 24 Mar 2025 12:33:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
	Greg Thelen <gthelen@google.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in
 poke_int3_handler()
Message-ID: <20250324113304.GB14944@noisy.programming.kicks-ass.net>
References: <20250323072511.2353342-1-edumazet@google.com>
 <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com>
 <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKwPpV7v=EnK2ac5KjHSef64eyVwUST=q=+oFaqTB95sQ@mail.gmail.com>

On Mon, Mar 24, 2025 at 08:53:31AM +0100, Eric Dumazet wrote:

> BTW the atomic_cond_read_acquire() part is never called even during my
> stress test.

Yes, IIRC this is due to text_poke_sync() serializing the state, as that
does a synchronous IPI broadcast, which by necessity requires all
previous INT3 handlers to complete.

You can only hit that case if the INT3 remains after step-3 (IOW you're
actively writing INT3 into the text). This is exceedingly rare.

