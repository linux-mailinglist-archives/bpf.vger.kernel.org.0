Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F776437713
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJVM0g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 08:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhJVM0g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 08:26:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1950C061766;
        Fri, 22 Oct 2021 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nBPXAxp8jG+dtVLA+/+js/8q7VpKJL9S5SfJVd3OHdA=; b=prAUfbzX3kI1dtn/jQfO1w/jYw
        2iEJAnGPsxe54bGSf096vTBFNdj4SQk52FK0CRBmlz12rcSJdR6kT3VGSJJsO732bggy/j9fIkW6c
        yVn2ZqDWPSot/DYWt5vNnFTwsWJpbkiQawQyWroLcIuKom9MuVBnWKUCvgffOI/IZ/juSl9oSnD/k
        0XPgEtpsQZDekntwOicTmjuRUiZ49iZY1DQVcwswltXEJF2P3xGTYsOymWHyAw2Cyc023077QBJTc
        +aUj3wGRdBtUFehU99xwBmQvIuO9LjAHWQF53aojLJJ2d4IJGC8WiG6sft8lwDsMFi6IPlwEq+8QN
        h6c3lffQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdtaf-00BZsz-GH; Fri, 22 Oct 2021 12:24:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E2F79812EB; Fri, 22 Oct 2021 00:37:19 +0200 (CEST)
Date:   Fri, 22 Oct 2021 00:37:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211021223719.GY174703@worktop.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net>
 <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
 <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKD6=HwmnTw=Shup7Rav-+OTWJERRYSAn-as6iikqoHEA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 11:03:33AM -0700, Alexei Starovoitov wrote:

> > I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
> > lot more robust than the 64bit one and I couldn't figure out why the
> > difference.
> 
> Interesting. Daniel will recognize that trick then :)

> > Is there concurrency on the jit?
> 
> The JIT of different progs can happen in parallel.

In that case I don't think the patch is safe. I'll see if I can find a
variant that doesn't use static storage.
