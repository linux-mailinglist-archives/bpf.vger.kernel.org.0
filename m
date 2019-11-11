Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18C8F8176
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKKUnK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 15:43:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 15:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v8Ol0O2KgkQoekfGKpQJ7RmTv0ANT2upF4lfg5gtfgs=; b=KaEtiVvS/4obz2MEddl4nqO4o
        cft5Avt5jdCiLUste2am74PP68SOBOrth/jAp0leoaCZlNWBGFEl1yV5L2szUcPezk43pbTpMcbvn
        HhldQp8F3tn8fWnAU/f39bYUdy8G8YR7DUlKN9cjDbqmZStbUwkAef5E26PtIHn5t5sFmpXCdnPG/
        Och0WPWrDdOHDgBoHIP2C4mDiIWCggQ74RI2zGP5Bbne/T9a7nIfVUaMtyqBT+mVzE837OveO1hCu
        WZUJlo1O0NhKNBO4xHx0VlNs/22DYHqbeGVNIf7Hf6rt8PwvWqF26pd4cys77B0tx1e8Ttw/SDqXo
        Ok1CPT0Hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUGWL-0002fg-67; Mon, 11 Nov 2019 20:42:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53E6830018B;
        Mon, 11 Nov 2019 21:41:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C332D20302EF6; Mon, 11 Nov 2019 21:42:43 +0100 (CET)
Date:   Mon, 11 Nov 2019 21:42:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kernel-team@fb.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and more)
Message-ID: <20191111204243.GV4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111194726.udayafzpqxeqjyrj@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111194726.udayafzpqxeqjyrj@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 11, 2019 at 11:47:28AM -0800, Alexei Starovoitov wrote:

> Some of the patches I think are split too fine. I would have combined them, but
> we try hard to limit our sets to less than fifteen in bpf/netdev land fwiw.

Yeah, the series is getting too long (in fact I have a whole pile more).

I tend to try and not re-arrange a series if I don't have to in order to
avoid breaking things by accident when shuffling them around. But yes, I
could avoid some things by folding and re-ordering.

Dunno, maybe if I'm forced to do another round :/

