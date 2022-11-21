Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC06327AF
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiKUPTR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 10:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKUPTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 10:19:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66509C903C;
        Mon, 21 Nov 2022 07:15:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01081612BC;
        Mon, 21 Nov 2022 15:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B49C433D6;
        Mon, 21 Nov 2022 15:15:40 +0000 (UTC)
Date:   Mon, 21 Nov 2022 10:15:37 -0500
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
Message-ID: <20221121101537.674f5aca@gandalf.local.home>
In-Reply-To: <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com>
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

On Mon, 21 Nov 2022 14:47:10 +0100
KP Singh <kpsingh@kernel.org> wrote:

> This annotation already exists, i.e. ALLOW_ERROR_INJECTION
> 
> Users, with CONFIG_FUNCTION_ERROR_INJECTION, can already modify return
> values of kernel functions using kprobes and the failure injection
> framework [1] for functions annotated with ALLOW_ERROR_INJECTION.
> 
> BPF just provides another way to do the same thing with "modify
> return" programs and this also respects the error injection list [2]
> and users can *only* attach these programs to the functions annotated
> with ALLOW_ERROR_INJECTION.

WAIT!

Looking at the Kconfigs, I see

CONFIG_FUNCTION_ERROR_INJECTION is set when
CONFIG_HAVE_FUNCTION_ERROR_INJECTION is set, and when CONFIG_KPROBES is set.

And ALLOW_ERROR_INJECTION() is set when CONFIG_FUNCTION_ERROR_INJECTION is.

There's no way to turn it off on x86 except by disabling kprobes!

WTF!

I don't want a kernel that can add error injection just because kprobes is
enabled. There's two kinds of kprobes. One that is for visibility only (for
tracing) and one that can be used for functional changes. I want the
visibility without the ability to change the kernel. The visibility portion
is very useful for security, where as the modifying one can be used to
circumvent security.

As kprobes are set in most production environments, so is error injection.
Do we really want error injection enabled on production environments?
I don't.

I think we need this patch ASAP!

-- Steve

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c3c0b077ade3..9ee72d8860c3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1874,8 +1874,14 @@ config NETDEV_NOTIFIER_ERROR_INJECT
 	  If unsure, say N.
 
 config FUNCTION_ERROR_INJECTION
-	def_bool y
+	bool "Fault-injections of functions"
 	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
+	help
+	  Add fault injections into various functions that are annotated with
+	  ALLOW_ERROR_INJECTION() in the kernel. BPF may also modify the return
+	  value of theses functions. This is useful to test error paths of code.
+
+	  If unsure, say N
 
 config FAULT_INJECTION
 	bool "Fault-injection framework"
