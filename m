Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDEB632938
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKUQRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 11:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiKUQRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 11:17:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16905D33A5;
        Mon, 21 Nov 2022 08:17:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A713A612FB;
        Mon, 21 Nov 2022 16:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4A3C433D6;
        Mon, 21 Nov 2022 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669047428;
        bh=vgw6qULRty5er+bFvMr/c1qzEdCWYpjdzIv96EYuLis=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=O+OkL6yyqJKIQUqrwz6qWi9wjh6aew5Ak6li/blsfuhnEeiYl4H/dJi7hJ1978yG7
         GvfIMgripH41q8/Rim0aBCEE5lWP1zfo29swFWc76vsBzK1kM3RvgNAdqdr6yUeVZZ
         R+/P8hBUimPqTCIsv6G/fuVDIarHAslwmyc27I0+wroldQjArOcWQ4d1BbkrnBoZE4
         2aZxwfBM37YO0w+hhn2E/xM1/05L64akyC501d+n/ioZzlwMqDmfbyFtLgUwapg9YX
         8Dy0/2XinOr/KQZWMhI4w7YWwQUJdg80ZXw0HsaPxIagc8sGDz+g8dEoH9sZ3NLbSJ
         Xjf+IH+nUAaiA==
Date:   Mon, 21 Nov 2022 17:16:47 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
cc:     Steven Rostedt <rostedt@goodmis.org>, Chris Mason <clm@meta.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
In-Reply-To: <CACYkzJ6n-9rH7hCeFVtFYFQ9+6MOuQ+J6LwR4PJ6zUN7w3zQhA@mail.gmail.com>
Message-ID: <nycvar.YEU.7.76.2211211716270.27249@gjva.wvxbf.pm>
References: <20221108220651.24492-1-revest@chromium.org> <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com> <20221117121617.4e1529d3@gandalf.local.home> <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com> <20221117174030.0170cd36@gandalf.local.home>
 <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com> <20221118114519.2711d890@gandalf.local.home> <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com> <20221118130608.5ba89bd8@gandalf.local.home> <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
 <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com> <20221121101537.674f5aca@gandalf.local.home> <CACYkzJ6n-9rH7hCeFVtFYFQ9+6MOuQ+J6LwR4PJ6zUN7w3zQhA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 21 Nov 2022, KP Singh wrote:

> > Looking at the Kconfigs, I see
> >
> > CONFIG_FUNCTION_ERROR_INJECTION is set when
> > CONFIG_HAVE_FUNCTION_ERROR_INJECTION is set, and when CONFIG_KPROBES is set.
> >
> > And ALLOW_ERROR_INJECTION() is set when CONFIG_FUNCTION_ERROR_INJECTION is.
> >
> > There's no way to turn it off on x86 except by disabling kprobes!
> >
> > WTF!
> >
> > I don't want a kernel that can add error injection just because kprobes is
> > enabled. There's two kinds of kprobes. One that is for visibility only (for
> > tracing) and one that can be used for functional changes. I want the
> > visibility without the ability to change the kernel. The visibility portion
> > is very useful for security, where as the modifying one can be used to
> > circumvent security.
> 
> I am not sure how they can circumvent security since this needs root /
> root equivalent permissions. Fault injection is actually a very useful
> debugging tool.

There are environments where root is untrusted (e.g. secure boot), and 
there is a whole mechanism in kernel for dealing with that (all the 
CONFIG_LOCKDOWN_LSM handling). Seems like error injection should be wired 
up into lockdown handling at minimum.

-- 
Jiri Kosina
SUSE Labs
