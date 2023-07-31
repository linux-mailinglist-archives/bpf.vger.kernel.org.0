Return-Path: <bpf+bounces-6480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87D76A33C
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456F4281656
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98F1E518;
	Mon, 31 Jul 2023 21:47:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE2B1DDDC
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 21:47:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7337133;
	Mon, 31 Jul 2023 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vTIB+9jOZpp5OUrJxulSYIOZhA9Dpc6dGOGdH6SgMUw=; b=CztjLyfqcdrFKznDsLQyVMumAI
	MN3Xna4qhxwpkV4FiIedm9yhrd8/l9X3R1rELIM6w6jiAUYNvsWeUNfNX0kRxnWuibkdN56xgYU3F
	WqI7lUf1lNSIxS51cJCvE4zW3pDRLHuMSlh2ESprJKMTkPFNV+FTAdXNCdTAMqBOQJeRw+5TDcwPk
	WLl4wnTsMUR97Exiyc0+o18OmIW+qTmQmfo7V4o+svym0ooDszJ6obRAKyK/Cz9rCAlkte3H+V4xv
	TjvBifgNXlOtGpzS09pMJuV8fsPGfHcZH+mMOCpPjhyJY51SrujtQrMqBzVhk2Ji3cQ0Vp4WSlYXg
	X1xkQqJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qQaiV-00D67t-1f;
	Mon, 31 Jul 2023 21:46:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6C4E3002D9;
	Mon, 31 Jul 2023 23:46:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7BAE620D70602; Mon, 31 Jul 2023 23:46:12 +0200 (CEST)
Date: Mon, 31 Jul 2023 23:46:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
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
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 11/20] objtool: Flesh out warning related to
 pv_ops[] calls
Message-ID: <20230731214612.GC51835@hirez.programming.kicks-ass.net>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-12-vschneid@redhat.com>
 <20230728153334.myvh5sxppvjzd3oz@treble>
 <xhsmh8raws53o.mognet@vschneid.remote.csb>
 <20230731213631.pywytiwdqgtgx4ps@treble>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731213631.pywytiwdqgtgx4ps@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 04:36:31PM -0500, Josh Poimboeuf wrote:
> On Mon, Jul 31, 2023 at 12:16:59PM +0100, Valentin Schneider wrote:
> > You're quite right - fabricating an artificial warning with a call to __flush_tlb_local():
> > 
> >   vmlinux.o: warning: objtool: pv_ops[1]: indirect call to native_flush_tlb_local() leaves .noinstr.text section
> >   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to {dynamic}() leaves .noinstr.text section
> > 
> > Interestingly the second one doesn't seem to have triggered the "pv_ops"
> > bit of call_dest_name. Seems like any call to insn_reloc(NULL, x) will
> > return NULL.
> 
> Yeah, that's weird.
> 
> > Trickling down the file yields:
> > 
> >   vmlinux.o: warning: objtool: pv_ops[1]: indirect call to native_flush_tlb_local() leaves .noinstr.text section
> >   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: call to pv_ops[0]() leaves .noinstr.text section
> > 
> > In my case (!PARAVIRT_XXL) pv_ops should look like:
> >   [0]: .cpu.io_delay
> >   [1]: .mmu.flush_tlb_user()
> > 
> > so pv_ops[1] looks right. Seems like pv_call_dest() gets it right because
> > it uses arch_dest_reloc_offset().
> > 
> > If I use the above to fix up validate_call(), would we still need
> > pv_call_dest() & co?
> 
> The functionality in pv_call_dest() is still needed because it goes
> through all the possible targets for the .mmu.flush_tlb_user() pointer
> -- xen_flush_tlb() and native_flush_tlb_local() -- and makes sure
> they're noinstr.
> 
> Ideally it would only print a single warning for this case, something
> like:
> 
>   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: indirect call to native_flush_tlb_local() leaves .noinstr.text section

But then what for the case where there are multiple implementations and
more than one isn't noinstr? IIRC that is where these double prints came
from. One is the callsite (always one) and the second is the offending
implementation (but there could be more).

> I left out "pv_ops[1]" because it's already long enough :-)

The index number is useful when also looking at the assembler, which
IIRC is an indexed indirect call.

