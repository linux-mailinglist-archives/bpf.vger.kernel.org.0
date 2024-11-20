Return-Path: <bpf+bounces-45269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4B9D3E97
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 16:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267EC1F24289
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861611D89FE;
	Wed, 20 Nov 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LdN8nnBy"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E11C4A3C
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114652; cv=none; b=ebxlVNNed5PM1rGy+QHXSgUA0IfNsGK8n/VJTm7eh2DN2SsRi/dSSAf2lB/VMTcY6SSp5DrRfrTNoH420zTjneb6kElJhAEWduasyJC/wL3Uro5RNmltGqOP1vNYF4SM6007dPWLZ9pfF52W8UZkFkyJaAeC3Sw8WhRkPXFMsd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114652; c=relaxed/simple;
	bh=N/+L+LKAnHPIPI0TGsIUJQK3Ce8pA3wx2Y/f3NNH7LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8WDTFIf+rGqjQCk9i1VoEKe3SHtt3NoJc+16gomGY4/d5NUN1leeKGZ58ra/7G1wG6KJr2hn6yEkqJMvCCM/lhzzTZ/SB9PTmIXMIXe6CD2KZxXPLc+kwBcE68NJ9TygQV2YeOsZTGbz3ZIHXtkOk5idnPNrho3z9fD0N6bxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LdN8nnBy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Eo+mDdywb8Jf9eP+Chc4FGyJoIBcp+h8PHa9Dul2QYs=; b=LdN8nnBySFZ2QqJKHQYsI3gfI+
	HMtt1FrYVdo2x+Pgzf8RqrcWVsNw5UF7a+m/u5LHrXjEo/YLYox1JR6bpiGHQ92zTAdcYMs3169BK
	5TyBuPhhkFOUoh2GP0JTX9I3ukk2GUW5VHlmMe+EoJIag0eD0Nmv1JKO4QeCL6a2Fyfa6BGAcNt+S
	DMOx4r0wEe8fZE3y6eXgITvCcDjCHGzQDqcpLT2XmCbDsH5e1BD8RSeiF0Q0nTAaDbZiCI4W8GioS
	CcxmUVjbOitz4DdG3c3SDbFEBwf1oVD73Ay2e6u5fdidr8CiNGzzPmaOT8Xl3IsS0LVwXKNM91rIC
	gI7LJdHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDm8P-00000000TqU-3Kca;
	Wed, 20 Nov 2024 14:56:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 69FC230023F; Wed, 20 Nov 2024 15:56:49 +0100 (CET)
Date: Wed, 20 Nov 2024 15:56:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 06/15] jump_label: Add forceful jump label type
Message-ID: <20241120145649.GJ19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-7-vschneid@redhat.com>
 <20241119233902.kierxzg2aywpevqx@jpoimboe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119233902.kierxzg2aywpevqx@jpoimboe>

On Tue, Nov 19, 2024 at 03:39:02PM -0800, Josh Poimboeuf wrote:
> On Tue, Nov 19, 2024 at 04:34:53PM +0100, Valentin Schneider wrote:
> > Later commits will cause objtool to warn about non __ro_after_init static
> > keys being used in .noinstr sections in order to safely defer instruction
> > patching IPIs targeted at NOHZ_FULL CPUs.
> 
> Don't we need similar checking for static calls?
> 
> > Two such keys currently exist: mds_idle_clear and __sched_clock_stable,
> > which can both be modified at runtime.
> 
> Not sure if feasible, but it sure would be a lot simpler to just make
> "no noinstr patching" a hard rule and then convert the above keys (or at
> least their noinstr-specific usage) to regular branches.

That'll be a bit of a mess. Also, then we're adding overhead/cost for
all people for the benefit of this fringe case (NOHZ_FULL). Not a
desirable trade-off IMO.

So I do think the proposed solution (+- naming, I like your naming
proposal better) is the better one.

But I think we can make the fall-back safer, we can simply force the IPI
when we poke at noinstr code -- then NOHZ_FULL gets to keep the pieces,
but at least we don't violate any correctness constraints.

