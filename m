Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB26326B6
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiKUOsU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 09:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiKUOrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 09:47:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B93D29A3;
        Mon, 21 Nov 2022 06:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41017B8106E;
        Mon, 21 Nov 2022 14:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE78BC433C1;
        Mon, 21 Nov 2022 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669041628;
        bh=adn/oebRPSLoCRPxZEVPB8mg0QA8QCN70vqucPnJ/uo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sV0pofivIR9RlYIUXkTCnGWYK4YjbLiM4kYu/V8Gjn5+uJuQGTqu4kOgSRqIFPrif
         PGSbno7Et5no0hFBLW6dSFJTIrqadajvIBecYfdx8jfEeKiTJlKhkvw8tC6FWxdUl8
         /f2eaDpr7UVzW41AF+BX8paNYu8EEC+6tfQikJAoN+1UBmwQOf/jFPmL2p2MtIFJTK
         If4tARvrH3cQe45iLjOY3o7KrTURnEMv7j41qpsh2sBfL1sFI4XyQy0Ap4f83GF2bG
         jAN5ckQ1wleA6sXHgfFAegki1cMNROb/HJ+ESYOUzEcuQ3S0gG21TNamZI+KgT5mt0
         rN2ozM3c8jKYA==
Date:   Mon, 21 Nov 2022 23:40:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-Id: <20221121234023.0a8d3a89bf26ad463cf11ad4@kernel.org>
In-Reply-To: <Y3tOUcOjEDJrm7w6@hirez.programming.kicks-ass.net>
References: <20221108220651.24492-1-revest@chromium.org>
        <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
        <20221117121617.4e1529d3@gandalf.local.home>
        <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
        <20221117174030.0170cd36@gandalf.local.home>
        <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
        <20221118114519.2711d890@gandalf.local.home>
        <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
        <20221118130608.5ba89bd8@gandalf.local.home>
        <Y3tOUcOjEDJrm7w6@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 21 Nov 2022 11:09:21 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Nov 18, 2022 at 01:06:08PM -0500, Steven Rostedt wrote:
> > How do I know that a function return was modified by BPF? If I'm debugging
> > something, is it obvious to the developer that is debugging an issue
> > (perhaps unaware of what BPF programs are loaded on the users machine),
> > that the return of a function was tweaked by BPF and that could be the
> > source of the bug?
> 
> Have it taint the kernel if something is overridden ;-) Then we can all
> ignore the report until it comes back without taint.

Hmm, indeed. BTW, error injection should set that too.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
