Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F7632887
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKUPqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiKUPqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:46:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B6A5656C;
        Mon, 21 Nov 2022 07:45:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D516129B;
        Mon, 21 Nov 2022 15:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E07C433C1;
        Mon, 21 Nov 2022 15:45:50 +0000 (UTC)
Date:   Mon, 21 Nov 2022 10:45:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Message-ID: <20221121104548.4a7aa3de@gandalf.local.home>
In-Reply-To: <CAADnVQJzRTEWkJoB3B4tgFLtoVRHWnsUvB5ZKSfBsswV3ck1zw@mail.gmail.com>
References: <20221108220651.24492-1-revest@chromium.org>
        <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
        <20221117121617.4e1529d3@gandalf.local.home>
        <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
        <20221117174030.0170cd36@gandalf.local.home>
        <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
        <20221118114519.2711d890@gandalf.local.home>
        <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
        <20221118130608.5ba89bd8@gandalf.local.home>
        <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
        <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com>
        <20221121101537.674f5aca@gandalf.local.home>
        <CAADnVQJzRTEWkJoB3B4tgFLtoVRHWnsUvB5ZKSfBsswV3ck1zw@mail.gmail.com>
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

On Mon, 21 Nov 2022 07:40:11 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> >
> > As kprobes are set in most production environments, so is error injection.
> > Do we really want error injection enabled on production environments?  
> 
> We absolutely want it enabled in production.
> 
> > I don't.  
> 
> Speak for yourself, because your employer thinks otherwise.

And speak for yourself! Just because you want it in production, does not
mean that everyone else is forced to do so too.

It's a DEBUG feature. It's in Kconfig.debug. Why is it enabled by default???

-- Steve
