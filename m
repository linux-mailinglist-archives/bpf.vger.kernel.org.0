Return-Path: <bpf+bounces-39301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B29713B7
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7954B1F2536F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88081B533E;
	Mon,  9 Sep 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PHcK1SUW"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23CD1B372C;
	Mon,  9 Sep 2024 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874208; cv=none; b=p3M8vy1NnkgDvZk43AxAU8zpOz1DemVzfz5/986LrqBiDir/WOChEuDxWG2KuUKIu4wPwNaeiqt9vZjH89ZO/m/CrvG5LtlFM+ZeOaoL3Iqs+gGToeUG/Rs2nUyzffUj2BwTLFQJB4mJj7IWVPmAGXSsKKkVXP+8BbYz+hyHdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874208; c=relaxed/simple;
	bh=o/hjh/Sq8hcMxZEgqMKb/vs7eiHDdZcNb8ZaB2phBzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj6ge70W9ULCsNSaEKMy/UdaQO6PdZXGysYem0R5jX70Hjg3L+nXrsmNJzZbUurC5MiqsW12DqL92DBtekgUulfRioFNDE2OTQS1sW6QfwYs6YyA/CvBc0O1vae4lcdDf1T7blRWeBWfIQyeAp2VYFRRmU6nPJnk7rzyzDp+OvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PHcK1SUW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f16Hum48X2/PRv+OYRnrqWvXhbLKUUXP4MBg4DPZdlQ=; b=PHcK1SUWaNK+mGL/l3LU81VEdD
	D9nBb1lF9fC+k5KduxINliKCuQNtwOV9r3VV7JhDFojWrMZqtjtzwsWQR7ymjqHMdZK4/Tzo1krQG
	l72L0TWbRaFKsNxIJEvL02K4akN/vihdxELVqTsQPMZh102jhI0PE6Yrqkpm+R5bTxUWvCjPykmtq
	WlbddJH0odsLTU/9pMOdxn+PkTNa49n7N5ZvM4UD0maObK3Zd9qj9kNJXbjqHQeNmT1JTuolvrtNi
	Vpta2pPXprvf8lrp/xLulCdRHeE9tzU/AQ/jRdr1yi09xwhjfkgynp4ly+k7LQoKGQqGefX9PFflQ
	rxIuTYAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snai3-0000000AlXL-0vBQ;
	Mon, 09 Sep 2024 09:29:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80F5330047C; Mon,  9 Sep 2024 11:29:23 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:29:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 6/8] x86/module: perpare module loading for ROX
 allocations of text
Message-ID: <20240909092923.GB4723@noisy.programming.kicks-ass.net>
References: <20240909064730.3290724-1-rppt@kernel.org>
 <20240909064730.3290724-7-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909064730.3290724-7-rppt@kernel.org>

On Mon, Sep 09, 2024 at 09:47:28AM +0300, Mike Rapoport wrote:
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 8da0e66ca22d..563d9a890ce2 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c

> @@ -654,4 +656,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  }
>  #endif
>  
> +void ftrace_swap_func(void *a, void *b, int n)
> +{
> +	unsigned long t;
> +
> +	WARN_ON_ONCE(n != sizeof(t));
> +
> +	t = *((unsigned long *)a);
> +	text_poke_copy(a, b, sizeof(t));
> +	text_poke_copy(b, &t, sizeof(t));
> +}

This is insane, just force BUILDTIME_MCOUNT_SORT

