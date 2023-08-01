Return-Path: <bpf+bounces-6588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F076B965
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FE91C20FE4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44261ADF8;
	Tue,  1 Aug 2023 16:06:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2E1ADD9
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 16:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E4C433CA;
	Tue,  1 Aug 2023 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690906001;
	bh=BBcCALZSvC2LFhRKcMqxP8rdH2NP0e0xXifPtDkOjO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCrg74c7T3Iz63b0Kd6NgZegwDi8uBiXQoM380X5QyO9JQStSJ1vVIYg5lBwm6mGw
	 G5KOxDdFaZ7Piz25JAUwBZD/3gaIndaeQTHekVYLS3qu/aHMvXlBS74Y+fcyy1aTEk
	 ekFWbXUbEVFdALD5l54i41nQHanZW89VH2ePBQMh5U9QZ5HMo56dgNJvyaeiY04Jyl
	 Xf14Hk85AfA++XUjsYmfdUWau4GAJM10KRtVfqcqHC8KYUuOhv/aWt7bPVRl++OF56
	 Y2ze4WvLuzReIZF+YcVIa7kCLw1OcNEHpfPPSiU8sxiQPotRbp7L6618dtrmlDOhKL
	 o2cGG2hsMdBsQ==
Date: Tue, 1 Aug 2023 11:06:36 -0500
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, rcu@vger.kernel.org,
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
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 11/20] objtool: Flesh out warning related to
 pv_ops[] calls
Message-ID: <20230801160636.ko3oc4cwycwejyxy@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-12-vschneid@redhat.com>
 <20230728153334.myvh5sxppvjzd3oz@treble>
 <xhsmh8raws53o.mognet@vschneid.remote.csb>
 <20230731213631.pywytiwdqgtgx4ps@treble>
 <20230731214612.GC51835@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731214612.GC51835@hirez.programming.kicks-ass.net>

On Mon, Jul 31, 2023 at 11:46:12PM +0200, Peter Zijlstra wrote:
> > Ideally it would only print a single warning for this case, something
> > like:
> > 
> >   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: indirect call to native_flush_tlb_local() leaves .noinstr.text section
> 
> But then what for the case where there are multiple implementations and
> more than one isn't noinstr?

The warning would be in the loop in pv_call_dest(), so it would
potentially print multiple warnings, one for each potential dest.

> IIRC that is where these double prints came from. One is the callsite
> (always one) and the second is the offending implementation (but there
> could be more).

It's confusing to warn about the call site and the destination in two
separate warnings.  That's why I'm proposing combining them into a
single warning (which still could end up as multiple warnings if there
are multiple affected dests).

> > I left out "pv_ops[1]" because it's already long enough :-)
> 
> The index number is useful when also looking at the assembler, which
> IIRC is an indexed indirect call.

Ok, so something like so?

  vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: indirect call to pv_ops[1] (native_flush_tlb_local) leaves .noinstr.text section

-- 
Josh

