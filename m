Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD362FC2A
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 19:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbiKRSGP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 13:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiKRSGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 13:06:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6166679E2F;
        Fri, 18 Nov 2022 10:06:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15140B824EB;
        Fri, 18 Nov 2022 18:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDEBC433D6;
        Fri, 18 Nov 2022 18:06:09 +0000 (UTC)
Date:   Fri, 18 Nov 2022 13:06:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Mason <clm@meta.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-ID: <20221118130608.5ba89bd8@gandalf.local.home>
In-Reply-To: <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
References: <20221108220651.24492-1-revest@chromium.org>
        <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
        <20221117121617.4e1529d3@gandalf.local.home>
        <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
        <20221117174030.0170cd36@gandalf.local.home>
        <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
        <20221118114519.2711d890@gandalf.local.home>
        <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 18 Nov 2022 12:44:00 -0500
Chris Mason <clm@meta.com> wrote:

> > My biggest concern is changing functionality of arbitrary functions by BPF.
> > I would much rather limit what functions BPF could change with some
> > annotation.
> > 
> > int __bpf_modify foo()
> > {
> > 	...
> > }
> > 
> > 
> > That way if somethings not working, you can see directly in the code that
> > the function could be modified by a BPF program, instead of getting some
> > random bug report because a function returned an unexpected result that the
> > code of that function could never produce.
> >  
> 
> The good news is that BPF generally confines the function replacement
> through struct ops interfaces.

What struct ops interfaces?

>  There are also explicit allow lists to
> limit functions where you can do return value overrides etc, so I think

Where are these lists.

> it's fair to say these concerns are already baked in.  I'm sure they can

How do I know that a function return was modified by BPF? If I'm debugging
something, is it obvious to the developer that is debugging an issue
(perhaps unaware of what BPF programs are loaded on the users machine),
that the return of a function was tweaked by BPF and that could be the
source of the bug?

> be improved over the long term, but I don't think that's related to this
> set of functionality on ARM.

I disagree. These issues may have been added to x86, but perhaps we should
take a deeper look at them again before extending them to other
architectures.

-- Steve

