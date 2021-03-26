Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD634A981
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhCZOUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 10:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhCZOUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 10:20:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E8860190;
        Fri, 26 Mar 2021 14:20:11 +0000 (UTC)
Date:   Fri, 26 Mar 2021 10:20:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address
 at kretprobe_trampoline
Message-ID: <20210326102009.265f359c@gandalf.local.home>
In-Reply-To: <20210326210349.22f6d34b229dd3a139a53686@kernel.org>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639530062.895304.16962383429668412873.stgit@devnote2>
        <20210323223007.GG4746@worktop.programming.kicks-ass.net>
        <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
        <20210326030503.7fa72da34e25ad35cf5ed3de@kernel.org>
        <20210326210349.22f6d34b229dd3a139a53686@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Mar 2021 21:03:49 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> I confirmed this is not related to this series, but occurs when I build kernels with different
> configs without cleanup.
> 
> Once I build kernel with CONFIG_UNWIND_GUESS=y (for testing), and after that,
> I build kernel again with CONFIG_UNWIND_ORC=y (but without make clean), this
> happened. In this case, I guess ORC data might be corrupted?
> When I cleanup and rebuild, the stacktrace seems correct.

Hmm, that should be fixed. Seems like we are missing a dependency somewhere.

-- Steve
