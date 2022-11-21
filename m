Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC03631DCD
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 11:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKUKJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 05:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKUKJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 05:09:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2982C67;
        Mon, 21 Nov 2022 02:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/aiZzvyQ2GY8KI94llazD/tfmZ49/mZuXgZkC4dcxLY=; b=NZpSrhocPOpVEIzvEEu1r4IaU0
        A1L9Xa2NdSCU+3XTGRM2PMPbA7wJpAY+EoXEVzWaUPzmj0R/NNxyLFRqxZCzAw3DSg1FGn23mInX0
        UNKvxqzGNOqk5Z7gqutCPwBDR1ymYgiw4UDZ0j+Z8KX40M6hD/6iYckEM+LogGB0Y3HJ/bunEybZi
        SlEITeLvwmU1jfka5ilUxkFujg4o7QEHhji1ygTRCqxyaQDwXx3af6uRHCFaIFzDj8kWNlSQ56BR5
        2hcX2Kgbn1R3iUm1Tup890mQ+FlNJk3tHN6mW215hG8LU3P0RhV6r+gZ0nKj9CzSGZH7rn360zJ3h
        qwt3wRig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox3jw-0034mk-UW; Mon, 21 Nov 2022 10:09:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FC4830022D;
        Mon, 21 Nov 2022 11:09:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DBBC203A8986; Mon, 21 Nov 2022 11:09:22 +0100 (CET)
Date:   Mon, 21 Nov 2022 11:09:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chris Mason <clm@meta.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-ID: <Y3tOUcOjEDJrm7w6@hirez.programming.kicks-ass.net>
References: <20221108220651.24492-1-revest@chromium.org>
 <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home>
 <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home>
 <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home>
 <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
 <20221118130608.5ba89bd8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118130608.5ba89bd8@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 01:06:08PM -0500, Steven Rostedt wrote:
> How do I know that a function return was modified by BPF? If I'm debugging
> something, is it obvious to the developer that is debugging an issue
> (perhaps unaware of what BPF programs are loaded on the users machine),
> that the return of a function was tweaked by BPF and that could be the
> source of the bug?

Have it taint the kernel if something is overridden ;-) Then we can all
ignore the report until it comes back without taint.
