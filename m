Return-Path: <bpf+bounces-6602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEA76BC17
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7071F2819CF
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C3F235B8;
	Tue,  1 Aug 2023 18:14:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC923589
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 18:14:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB61723;
	Tue,  1 Aug 2023 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WCvORc63Xc/jlm9uhOtZxAQJTdnogdSx3B9Dg3F/tt8=; b=EG3k5D0X6i7MCDl7fPlu0Os/T9
	P3DWozrpKZNiiTwIBKQbwpm6VZvqHcqh7vAhLujXPTORzLj8CF/HM4qZkvrXeBx7bFnKTsYO3WqWE
	bfWAfHbPGIYvejU5QbtqQx0o+6xAJQHWzVYVP8KX85kXbMgunY/JYMFk92i3U5+HepWLcYPvoEiBw
	5zkkL3cy2U7+suRvx85VDiz+0m0G0BqTaOpB8ACt4WMUTt9BOyTdUC1F3BdlG3LcB4+k7LUJeTGaS
	sHJ2p05k/d1NF2jIFFJjlyNPNnnPCFx1SmRwdSU4C1BrS2bJZ1eskX0IZPg16ydkyxbSIuEmbP+8P
	iQLxh1XQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qQtre-00EpOw-2F;
	Tue, 01 Aug 2023 18:12:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A4593002D3;
	Tue,  1 Aug 2023 20:12:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C6BC201C57DC; Tue,  1 Aug 2023 20:12:55 +0200 (CEST)
Date: Tue, 1 Aug 2023 20:12:55 +0200
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
Message-ID: <20230801181255.GE11704@hirez.programming.kicks-ass.net>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-12-vschneid@redhat.com>
 <20230728153334.myvh5sxppvjzd3oz@treble>
 <xhsmh8raws53o.mognet@vschneid.remote.csb>
 <20230731213631.pywytiwdqgtgx4ps@treble>
 <20230731214612.GC51835@hirez.programming.kicks-ass.net>
 <20230801160636.ko3oc4cwycwejyxy@treble>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801160636.ko3oc4cwycwejyxy@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 11:06:36AM -0500, Josh Poimboeuf wrote:
> On Mon, Jul 31, 2023 at 11:46:12PM +0200, Peter Zijlstra wrote:
> > > Ideally it would only print a single warning for this case, something
> > > like:
> > > 
> > >   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: indirect call to native_flush_tlb_local() leaves .noinstr.text section
> > 
> > But then what for the case where there are multiple implementations and
> > more than one isn't noinstr?
> 
> The warning would be in the loop in pv_call_dest(), so it would
> potentially print multiple warnings, one for each potential dest.
> 
> > IIRC that is where these double prints came from. One is the callsite
> > (always one) and the second is the offending implementation (but there
> > could be more).
> 
> It's confusing to warn about the call site and the destination in two
> separate warnings.  That's why I'm proposing combining them into a
> single warning (which still could end up as multiple warnings if there
> are multiple affected dests).
> 
> > > I left out "pv_ops[1]" because it's already long enough :-)
> > 
> > The index number is useful when also looking at the assembler, which
> > IIRC is an indexed indirect call.
> 
> Ok, so something like so?
> 
>   vmlinux.o: warning: objtool: __flush_tlb_all_noinstr+0x4: indirect call to pv_ops[1] (native_flush_tlb_local) leaves .noinstr.text section

Sure, that all would work I suppose.

