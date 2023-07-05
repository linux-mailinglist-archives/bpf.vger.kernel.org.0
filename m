Return-Path: <bpf+bounces-4124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829074910C
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 00:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487B01C20C3A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2641549E;
	Wed,  5 Jul 2023 22:40:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48833FD
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 22:40:58 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BED1737;
	Wed,  5 Jul 2023 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Eq7GFzHwB8dLC3Kv8OaOR922WQenfWCiVLZ0gHnT8To=; b=jj71nrv2yDZIZoyg0kgVc66xE+
	LgxCxU8C3fuH26VNB+BolbkGuVU9YQIXj20ZwFO64vsBGGEEJyftWrEe1H2wtXhJkrECC6tXXmpTC
	buncs5BZihDY0ZiB/ikj8+qLq1vHaJoH4+na0H46uiJTjlFUIwcLMqsgG+s76HNOO6xmn+TbUOK6E
	Tk4ZToHymU/7/o6NPWhwRH+PyI8I57c0F7UfGYdUWtoRGlrezsIN+2ej4RPG5VKvDaxg5DC6cjPSf
	Zi1KLvtF8wCyi36QOgM3yKcycOkWi09rB/VjPbOwKfGbzqIK+PEmWVczyHGZE5G5O6BfTWV6JMcFt
	95hID4oQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qHBAH-00AUts-3n; Wed, 05 Jul 2023 22:40:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F4E83001E7;
	Thu,  6 Jul 2023 00:39:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6968B200BDD20; Thu,  6 Jul 2023 00:39:56 +0200 (CEST)
Date: Thu, 6 Jul 2023 00:39:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
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
Subject: Re: [RFC PATCH 11/14] context-tracking: Introduce work deferral
 infrastructure
Message-ID: <20230705223956.GD2813335@hirez.programming.kicks-ass.net>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705181256.3539027-12-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705181256.3539027-12-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 07:12:53PM +0100, Valentin Schneider wrote:

> Note: A previous approach by PeterZ [1] used an extra bit in
> context_tracking.state to flag the presence of deferred callbacks to
> execute, and the actual callbacks were stored in a separate atomic
> variable.
> 
> This meant that the atomic read of context_tracking.state was sufficient to
> determine whether there are any deferred callbacks to execute.
> Unfortunately, it presents a race window. Consider the work setting
> function as:
> 
>   preempt_disable();
>   seq = atomic_read(&ct->seq);
>   if (__context_tracking_seq_in_user(seq)) {
> 	  /* ctrl-dep */
> 	  atomic_or(work, &ct->work);
> 	  ret = atomic_try_cmpxchg(&ct->seq, &seq, seq|CT_SEQ_WORK);
>   }
>   preempt_enable();
> 
>   return ret;
> 
> Then the following can happen:
> 
>   CPUx                                             CPUy
> 						     CT_SEQ_WORK \in context_tracking.state
>     atomic_or(WORK_N, &ct->work);
> 						      ct_kernel_enter()
> 							ct_state_inc();
>     atomic_try_cmpxchg(&ct->seq, &seq, seq|CT_SEQ_WORK);
> 
> The cmpxchg() would fail, ultimately causing an IPI for WORK_N to be
> sent. Unfortunately, the work bit would remain set, and it can't be sanely
> cleared in case another CPU set it concurrently - this would ultimately
> lead to a double execution of the callback, one as a deferred callback and
> one in the IPI. As not all IPI callbacks are idempotent, this is
> undesirable.

So adding another atomic is arguably worse.

The thing is, if the NOHZ_FULL CPU is actually doing context transitions
(SYSCALLs etc..) then everything is fundamentally racy, there is no
winning that game, we could find the remote CPU is in-kernel, send an
IPI, the remote CPU does return-to-user and receives the IPI.

And then the USER is upset... because he got an IPI.

The whole NOHZ_FULL thing really only works if userspace does not do
SYSCALLs.

But the sad sad state of affairs is that some people think it is
acceptable to do SYSCALLs while NOHZ_FULL and cry about how slow stuff
is.



