Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF504632863
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKUPkD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKUPkD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:40:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0AA41995;
        Mon, 21 Nov 2022 07:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1C90B810A8;
        Mon, 21 Nov 2022 15:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F37C433C1;
        Mon, 21 Nov 2022 15:39:57 +0000 (UTC)
Date:   Mon, 21 Nov 2022 10:39:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Chris Mason <clm@meta.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20221121103956.04abbe9b@gandalf.local.home>
In-Reply-To: <CACYkzJ6n-9rH7hCeFVtFYFQ9+6MOuQ+J6LwR4PJ6zUN7w3zQhA@mail.gmail.com>
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
        <CACYkzJ6n-9rH7hCeFVtFYFQ9+6MOuQ+J6LwR4PJ6zUN7w3zQhA@mail.gmail.com>
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

On Mon, 21 Nov 2022 16:29:54 +0100
KP Singh <kpsingh@kernel.org> wrote:

> I am not sure how they can circumvent security since this needs root /
> root equivalent permissions. Fault injection is actually a very useful
> debugging tool.

On ChromeOS, we even consider root untrusted and lock down pretty
much all privileged activities (like loading modules and such).

As you said. It's a good debugging tool. Not something to allow in
production environments. Or at the very least, allow admins to disable it.

-- Steve
