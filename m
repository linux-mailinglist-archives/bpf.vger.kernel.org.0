Return-Path: <bpf+bounces-5616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE975C92F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B83282223
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97931EA6E;
	Fri, 21 Jul 2023 14:10:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48D1EA66
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 14:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD40C433C8;
	Fri, 21 Jul 2023 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689948603;
	bh=mqpc+bgxfipMEEmdMi0c2/ZJlESRyidyP20iwu1ubiU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mwXJ4tWAGVS1YQv279yKam6lNor4fbv+EyYgPE9RKEXpJy6cXNZvFlP/KKxzKOTcB
	 +lqGPmG2ffZZ0Efx0S0TqnBE8IaMzk2MnCLGRhRMBEWpOJudId0i07k3cmP/nZVUaq
	 SHQPI6oYI5J2Ttnh4Enh9amoPJh7ypEjFICnaRQdDw7U29St7RlFkhJ+D7ihhqnWOv
	 xJjOEA3EUwNJAeTjNQJuuLgeXIWPSt3vBhtsEYX+1h3uDFaCPOyDIo8LBS3B298nuq
	 TrABcFKxVgUZNpuCKIaTgVNCGRGx0+QB9sHGcYJxF9jYzQi65FyVdVCSm+wLi6c1Xq
	 S45vKWYuRh3Iw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5E67BCE097F; Fri, 21 Jul 2023 07:10:03 -0700 (PDT)
Date: Fri, 21 Jul 2023 07:10:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
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
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 16/20] rcu: Make RCU dynticks counter size
 configurable
Message-ID: <28d4abb7-8496-45ec-b270-ea2b6164537b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-17-vschneid@redhat.com>
 <xhsmhjzutu18u.mognet@vschneid.remote.csb>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhjzutu18u.mognet@vschneid.remote.csb>

On Fri, Jul 21, 2023 at 09:17:53AM +0100, Valentin Schneider wrote:
> On 20/07/23 17:30, Valentin Schneider wrote:
> > index bdd7eadb33d8f..1ff2aab24e964 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -332,4 +332,37 @@ config RCU_DOUBLE_CHECK_CB_TIME
> >         Say Y here if you need tighter callback-limit enforcement.
> >         Say N here if you are unsure.
> >
> > +config RCU_DYNTICKS_RANGE_BEGIN
> > +	int
> > +	depends on !RCU_EXPERT
> > +	default 31 if !CONTEXT_TRACKING_WORK
> 
> You'll note that this should be 30 really, because the lower *2* bits are
> taken by the context state (CONTEXT_GUEST has a value of 3).
> 
> This highlights the fragile part of this: the Kconfig values are hardcoded,
> but they depend on CT_STATE_SIZE, CONTEXT_MASK and CONTEXT_WORK_MAX. The
> static_assert() will at least capture any misconfiguration, but having that
> enforced by the actual Kconfig ranges would be less awkward.
> 
> Do we currently have a way of e.g. making a Kconfig file depend on and use
> values generated by a C header?

Why not just have something like a boolean RCU_DYNTICKS_TORTURE Kconfig
option and let the C code work out what the number of bits should be?

I suppose that there might be a failure whose frequency depended on
the number of bits, which might be an argument for keeping something
like RCU_DYNTICKS_RANGE_BEGIN for fault isolation.  But still using
RCU_DYNTICKS_TORTURE for normal testing.

Thoughts?

							Thanx, Paul

