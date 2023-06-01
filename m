Return-Path: <bpf+bounces-1611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA271F120
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F2281834
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4E4822E;
	Thu,  1 Jun 2023 17:52:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B142501
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:52:28 +0000 (UTC)
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [IPv6:2001:41d0:203:375::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECF13D
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:52:26 -0700 (PDT)
Date: Thu, 1 Jun 2023 13:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685641944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvZu7pDDYmXHwMSg7hGT8OPLPljqdX2QIVSOdmRwors=;
	b=k8LvZJyewntoq7paLcCZpalnhHsRbUTumu8US7zZhvmAtwIA8z8+IsCufYQ/Tfop+aJHfp
	JDXGWHiSFWvBQlhh+XiaTuIo+kCh2q14Mo2ssoFXXboOjAjKsrwIOIU6mWE0ZqDl9fVgiu
	BwgDA6fuXqCDnNW3Qwm2url7MLeBoW8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 12/13] x86/jitalloc: prepare to allocate exectuatble
 memory as ROX
Message-ID: <ZHja0HOUabUxD5YS@moria.home.lan>
References: <20230601101257.530867-1-rppt@kernel.org>
 <20230601101257.530867-13-rppt@kernel.org>
 <20230601103050.GT4253@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601103050.GT4253@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 01, 2023 at 12:30:50PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 01:12:56PM +0300, Mike Rapoport wrote:
> 
> > +static void __init_or_module do_text_poke(void *addr, const void *opcode, size_t len)
> > +{
> > +	if (system_state < SYSTEM_RUNNING) {
> > +		text_poke_early(addr, opcode, len);
> > +	} else {
> > +		mutex_lock(&text_mutex);
> > +		text_poke(addr, opcode, len);
> > +		mutex_unlock(&text_mutex);
> > +	}
> > +}
> 
> So I don't much like do_text_poke(); why?

Could you share why?

I think the impementation sucks but conceptually it's the right idea -
create a new temporary mapping to avoid the need for RWX mappings.

