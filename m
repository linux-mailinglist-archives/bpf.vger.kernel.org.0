Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A0435D73
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 10:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUI7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 04:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhJUI7D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 04:59:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F90EC061749;
        Thu, 21 Oct 2021 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l9Tud8DIFTE8Da3d1AMxunl+NSEi9JysIEDRIg04oGA=; b=YMEbK0tLD/9mDXKsSZU5wW2IbN
        pJUVbxsKQQKgrP2D6AEMD0CHMQDWtV7Qvqvh9ff+4Tr4niMdZ2K/1yZPRqvml3OBIT/sX1Gv3QMv3
        o4geQtXgV4A1rHVlwOlnlRDYqcbJ++miJ9PiR+H+AYdugbW3hNXCF/tOkn9qaRRTMP65jNo0Hxn52
        /FnyFoacZwlyUR1Q9hjpweiSDfI35hT4KCaYvJl4E0GeRswAgx/X/HbzhnDJR8kArZijEtASywLRd
        bNTGxirPKapIZOwoAc0ZhQ1x55StDJ59lr2l81kqVcm1KzthLo8YkDonc7FuVMQfYQ1v9Zj4P1EuI
        BgWyj5Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdTpn-00D9KV-AH; Thu, 21 Oct 2021 08:54:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DADB300221;
        Thu, 21 Oct 2021 10:53:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 635B62D4101ED; Thu, 21 Oct 2021 10:53:58 +0200 (CEST)
Date:   Thu, 21 Oct 2021 10:53:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <YXEqpuKa5UiRNEfc@hirez.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <20211021000753.kdxtjl3nzre2zshb@ast-mbp.dhcp.thefacebook.com>
 <20211021001808.3ng6qeggi5lfwx7k@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021001808.3ng6qeggi5lfwx7k@treble>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 05:18:08PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 20, 2021 at 05:07:53PM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 20, 2021 at 12:44:56PM +0200, Peter Zijlstra wrote:
> > > +
> > > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
> > > +		EMIT_LFENCE();
> > > +		EMIT2(0xFF, 0xE0 + reg);
> > > +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> > > +		emit_jump(&prog, reg_thunk[reg], ip);
> > > +	} else
> > 
> > One more question.
> > What's a deal with AMD? I thought the retpoline is effective on it as well.
> > lfence is an optimization or retpoline turned out to be not enough
> > in some cases?
> 
> Yes, it's basically an optimization.  AMD recommends it presumably
> because it's quite a bit faster than a retpoline.
> 
> According to AMD it shrinks the speculative execution window enough so
> that Spectre v2 isn't a threat.

Right, also note that we've been using alternatives to patch the thunk
to lfence;jmp for AMD pretty much forever.

Inlining it is better tho; just a shame clang seems to insist on r11,
which means we cannot fit it in the thunk call site for them :/
