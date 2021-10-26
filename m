Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710843B9E6
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhJZSsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbhJZSsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 14:48:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EACC061745;
        Tue, 26 Oct 2021 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S+yaSCiDrfqcbD59UNQ4Zf/BYikNKmlGYeL0rkLgDBw=; b=rPvjn026xfifCWsqNg1XtswwCx
        LLDPSquZxWWNXow0WRYsr45+lxdPugVP5iMiTMBUH16jifRfT0awqeSyWgZdkK6lcgTbOFkRwX8gm
        vhIbFkOnXvfDfQUclxST1LOi/6u4L37bazi3XXpW6bKgY60xPjHVXcksj4lk8mGBobzMNhc188HUr
        yxgeRkUgdNSKeCL318/WkAh/wEAeS0gi9CQaL4NL5BT+WXvLWyFY+P21zNJk+SdjxntD5LGcZjGU3
        wdvQeHBhgeDDxCtAOb1YHGn1IktlSxZ7RKifaE+bM9Zkbku7LWfU0alvNOM12JAZ6evX/fH3jsGvd
        RqVLU2PA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfRRq-00CPLM-9q; Tue, 26 Oct 2021 18:45:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 851C9300230;
        Tue, 26 Oct 2021 20:45:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6929C2C152329; Tue, 26 Oct 2021 20:45:19 +0200 (CEST)
Date:   Tue, 26 Oct 2021 20:45:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
Message-ID: <YXhMv6rENfn/zsaj@hirez.programming.kicks-ass.net>
References: <20211026120132.613201817@infradead.org>
 <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 11:26:57AM -0700, Alexei Starovoitov wrote:

> It's a merge conflict. The patchset failed to apply to both bpf and
> bpf-next trees:

Figures :/ I suspect it relies on tip/objtool/core at the very least and
possibly some of the x86 trees as well.

I can locally merge tip/master with bpf, but getting a CI to do that
might be tricky.
