Return-Path: <bpf+bounces-45273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE539D3FA7
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA701B2C6BA
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1D1ADFE8;
	Wed, 20 Nov 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JmFUv8Vg"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77395156F39
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116171; cv=none; b=pXvFC0Fnlewihk/zhl0QcSpnTDQLM5/6e3YkdwWOTKh4lcpw5OOp+/SIG+1RyvjiANL1Qn/dnu6F9nU2zpq4zigs1Izj2+XzlfolOCdxlFD5gq+eyo6StQWSZmH8KLKR2wrvmBZ6iFQcHS16prw0UEkGTLySP5U+Ewmg/ZPv5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116171; c=relaxed/simple;
	bh=WbvCYI5FQOAQYXBCr2RLO2b6uAXeaNOyafQmb6z/s/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwOuzvGDUOZ+dhtbGg5+FTLZACBUVQUg5XtZTcPMY1hL4zMkoMgUWVJvFpiX8dw1A8fBxAHhmaVSfL9QkNZuYbx6Tlc6OqbHS7I+uQTLNxBzBJ495NAcByT3D+0xPSZJ7VsgKx+gg8j0zwUmK9jIodEKdU+93nRaW9V5EtvHVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JmFUv8Vg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MlJHDcSjdk0fhBS8nKpdUNl5QedDLuvNa80aSphcDYs=; b=JmFUv8VgUknnwgwZ6EaqnoKCN7
	coLXzZlmcSX1KYdLIMCtqubRgl/Uv2r/5y4LAXteAVjKwF7mlq/DF2eVQRM72v3S2PKorfPcKslhN
	Yh01CACceRSWGHaUtTu3tPtH54Vif9TA6Oj3RotmY5ISgzdQy7FFRSAKNn1PpM07zl8aN5pceUOsB
	LfrVCCgauvVSD0TJJ4IZDOljg1L7lFKxnBN5zTzaf/vbiOhd0jDNwPVQ0K7TpL6oNqIVAdRrJ1Il9
	AHSb4mfkbjsFEIdCzYR+AnjjfD5w6mvwRkR0s2sXIBOyjUpwF0ObMD0+T6Tnk1h+OWc/uClwNDdTl
	oKYyTSyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDmX3-00000000Tyb-3551;
	Wed, 20 Nov 2024 15:22:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5E3F300446; Wed, 20 Nov 2024 16:22:16 +0100 (CET)
Date: Wed, 20 Nov 2024 16:22:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure to
 defer kernel TLBI
Message-ID: <20241120152216.GM19989@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-14-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-14-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:35:00PM +0100, Valentin Schneider wrote:

> +void noinstr __flush_tlb_all_noinstr(void)
> +{
> +	/*
> +	 * This is for invocation in early entry code that cannot be
> +	 * instrumented. A RMW to CR4 works for most cases, but relies on
> +	 * being able to flip either of the PGE or PCIDE bits. Flipping CR4.PCID
> +	 * would require also resetting CR3.PCID, so just try with CR4.PGE, else
> +	 * do the CR3 write.
> +	 *
> +	 * XXX: this gives paravirt the finger.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_PGE))
> +		__native_tlb_flush_global_noinstr(this_cpu_read(cpu_tlbstate.cr4));
> +	else
> +		native_flush_tlb_local_noinstr();
> +}

Urgh, so that's a lot of ugleh, and cr4 has that pinning stuff and gah.

Why not always just do the CR3 write and call it a day? That should also
work for paravirt, no? Just make the whole write_cr3 thing noinstr and
voila.



