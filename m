Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC38F43D173
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbhJ0TNn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbhJ0TNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 15:13:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E0C061570;
        Wed, 27 Oct 2021 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DrJ64uH8XTZmuCpTpx/lxsQinIcpSpf4J3GTzl3WK1I=; b=Ix4o12A9hwyyHhUdyl4RxI9W3n
        TI8nL5S1/C0PW40nXKxp+fAst0oDOtiQwRxEGd28WaHAnRNRnsjgHJ9JzOzmx0g/ODwp057qduBby
        nrvPQM/DyZmsTHrzvlZ30rH0mgYltGX/GFHMU1bvvDSMm2o88XM6Nz2aA4kF+JMw6v+2GxbLVhqwP
        QDOLAOSYRFLm83mJhQdkmUMmYbmgVYSoQMGJMjgZvcSvMdPVHb3mYGHJ8chvrbJZls7TEUV+3+dva
        /JnsG2Lz2sXHVG+5bPtb1ixzml6Vmx/GMydk+93fk31xbnMe4r2eNO67Oofn5l0ixdZBgc2XmCxNd
        L8D1bSBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfoK8-00CbhH-EK; Wed, 27 Oct 2021 19:10:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64D80981D35; Wed, 27 Oct 2021 21:10:54 +0200 (CEST)
Date:   Wed, 27 Oct 2021 21:10:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 10/16] x86/alternative: Implement .retpoline_sites
 support
Message-ID: <20211027191054.GM174703@worktop.programming.kicks-ass.net>
References: <20211026120132.613201817@infradead.org>
 <20211026120310.232495794@infradead.org>
 <YXmOs2oSp+6Dpi4R@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXmOs2oSp+6Dpi4R@zn.tnic>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 07:38:59PM +0200, Borislav Petkov wrote:
> On Tue, Oct 26, 2021 at 02:01:42PM +0200, Peter Zijlstra wrote:
> > +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> > +{
> > +	retpoline_thunk_t *target;
> > +	int reg, i = 0;
> > +
> > +	target = addr + insn->length + insn->immediate.value;
> > +	reg = target - __x86_indirect_thunk_array;
> > +
> > +	if (WARN_ON_ONCE(reg & ~0xf))
> > +		return -1;
> > +
> > +	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
> > +	BUG_ON(reg == 4);
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > +		return -1;
> 
> I wanna say this should be the first thing being checked on function
> entry but I get the feeling you'll be looking at other X86_FEATURE bits
> in future patches... /me goes into the future...
> 
> yap, you do. Lemme look at the whole thing first then.

I wanted the sanity checks done unconditionally.
