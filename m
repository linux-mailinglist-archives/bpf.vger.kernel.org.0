Return-Path: <bpf+bounces-45267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5B9D3E5D
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 16:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CAD1F24434
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EBA1C9B8C;
	Wed, 20 Nov 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wZK/fjZe"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783C1A9B5A
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114319; cv=none; b=LsNsXKgHSlNZQ2A5VysjwRFPHrMOzBaJtRIF/uMWyxNYzcOz9tAK/jHP3iWQlObFrHcdXVtJdEZ49LGcnd2s617180o5qUntqawKJvGh0mcrw/RT+7SuODKi9Ln8DAwRIvbgUiHHQjK6IieK0cVJDaBDoli3bg6lzY+rGEIHXzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114319; c=relaxed/simple;
	bh=4gJefIEkFg4zHIzKYkMPiQJS/Kz94ehYi8VfErbkJYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRhFrbytfzz5hrfWh4IFkTju1dLw+Q/7HZZfzYTHhHAzVZjqgyXVKGcJIcEILtsiid3UBfdKQRqVBtky7ux6zjEjkcoY+WyI0d1quTA4SQZgpnmOXHoE9SGLz9KiXDFpOZwiFX3mbhmWb7+fOYifhn2VuQcJBMncN2tK3xjh6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wZK/fjZe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tw/QhYWKrpU75sqxyl3mlwNFxdhKMu7qoH9/t8NsVhc=; b=wZK/fjZeS6+u9pVldcySVZFZMl
	+tccmauTQkw9wtI/E1FF09hgVNDeXC1RX8BI9qYZVDczXnX5DW22CFvOqon2z+stKt9IdiOrAefgE
	8hhH8bcmopGcCRtzo5Yje+DQ9NbfLZybfVPq9JczE/Z9jK5aDsDUscHvtrjFMCgZV4XoWdffPVW17
	ZJwbkSMcrnx91w2KKsm5cWyM4/WQtcghRZsF75XLRSvV4+p1PmGoMW+1UApQ/J14NHdvOYV6TmlBA
	fvMrKwiPyI1ydIIPkF6x3soeR+mpfLmuArsakav6VZn66jgHeFSS3zQmbkeR5Vd+6o77//chFqtc3
	gQ/ZSF/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDm2a-00000005MZH-1QrJ;
	Wed, 20 Nov 2024 14:50:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 345E030023F; Wed, 20 Nov 2024 15:50:49 +0100 (CET)
Date: Wed, 20 Nov 2024 15:50:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
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
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 04/15] rcu: Add a small-width RCU watching counter
 debug option
Message-ID: <20241120145049.GI19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-5-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-5-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:51PM +0100, Valentin Schneider wrote:
> A later commit will reduce the size of the RCU watching counter to free up
> some bits for another purpose. Paul suggested adding a config option to
> test the extreme case where the counter is reduced to its minimum usable
> width for rcutorture to poke at, so do that.
> 
> Make it only configurable under RCU_EXPERT. While at it, add a comment to
> explain the layout of context_tracking->state.

Note that this means it will get selected by allyesconfig and the like,
is that desired?

If no, depends on !COMPILE_TEST can help here.

