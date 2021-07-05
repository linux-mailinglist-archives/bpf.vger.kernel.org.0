Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F443BBACF
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhGEKIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 06:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhGEKIg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 06:08:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15B32613C1;
        Mon,  5 Jul 2021 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625479559;
        bh=clEEcgpo77QbxqDt1/fBWykvR1xsS7DG0yP3rdAU9PY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fLaUWjUYTr+Z3zSFPGeZb8zhTkaPYVxEbjpFL1yX2V+VJErywpmKzASeDT3UCaJQe
         Hum163aD6NfubuujXBh2f4XHDrv3MmJr41yfmcRqj3uK+Ykg9O17//M8fz2fXxaWvB
         2j5zwCN/nQii0pPLPa173SYTUBf7m7v9MVUNT5WdDgo0xz6oZLf+rPH+M8qYOMCxaR
         gXY4AG1ibb3K3IUP3Y+qmOg9YwI0QQY6kgPeKjNOxAOYieih64UFN5FMvPJhO19YaH
         Lb+qrZ2ozf/zOgAvQFIa1ACdiafC4Ots4TgVpP0vhVx6AyR6wJEtvVDCEAezXVaBAk
         Lyo2cQBrh42mA==
Date:   Mon, 5 Jul 2021 19:05:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 01/13] ia64: kprobes: Fix to pass correct
 trampoline address to the handler
Message-Id: <20210705190555.7c02f53dc92a6a3191a17fb1@kernel.org>
In-Reply-To: <YOK42eM70kb9fd6r@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399993125.506599.11062077324255866677.stgit@devnote2>
        <YOK42eM70kb9fd6r@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Jul 2021 09:46:33 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Commit e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
> > missed to pass the wrong trampoline address (it passes the descriptor address
> > instead of function entry address).
> > This fixes it to pass correct trampoline address to __kretprobe_trampoline_handler().
> > This also changes to use correct symbol dereference function to get the
> > function address from the kretprobe_trampoline.
> > 
> > Fixes: e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> A better changelog:
> 
>   The following commit:
> 
>      Commit e792ff804f49 ("ia64: kprobes: Use generic kretprobe trampoline handler")
> 
>   Passed the wrong trampoline address to __kretprobe_trampoline_handler(): it
>   passes the descriptor address instead of function entry address.
> 
>   Pass the right parameter.
> 
>   Also use correct symbol dereference function to get the function address
>   from 'kretprobe_trampoline' - an IA64 special.

Thanks for rewriting! OK, I'll update it.

> 
> (Although I realize that much of this goes away just a couple of patches 
> later.)

Yes, but since this is a real bug. I think I should split it for backporting
to stable trees. (Oh, I also forgot to add Cc: stable. Sorry about that.)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
