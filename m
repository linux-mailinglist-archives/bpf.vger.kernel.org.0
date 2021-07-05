Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D233BBE57
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhGEOmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 10:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGEOmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 10:42:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBDA16195E;
        Mon,  5 Jul 2021 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625496018;
        bh=ZdnvFTKPNqMYGq5RT15Z4gJxdJYehJ1cRy+yS+OH5bM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hk4e4xRPtsJahAiWKdJey/x8nyohKetkvaYP3y14vHjX1VnoEO1TxKZq8jOr1EdE5
         FMgmZ90/EzBuusZbCjtR7HColKmiHHNOugA9np1+eradUX0TPgdg5iHYkOdPOYN7LA
         ITb06PDjGIX7DJ6NHFnt8GJveCYzYbalAZMMaubNeOilTKhTai8XjynyLUTMwa1MOV
         k2Bz4C3YxglmEZG/QWQ9kd3sCI7kq8eh73ctPKZuGKxYJkPiWvY0L0pfR4b9OnLTOM
         NwwIKS+pkDJI+tUbbOFebT6I4hGRrmFnr1g+TsxZKJtbZ4B7JHpUJ+hywEXUYrb0d9
         RwloBPYVGbsYQ==
Date:   Mon, 5 Jul 2021 23:40:14 +0900
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
Subject: Re: [PATCH -tip v8 08/13] arm: kprobes: Make a space for
 regs->ARM_pc at kretprobe_trampoline
Message-Id: <20210705234014.4e0a9ec6a60ef2db5ff93819@kernel.org>
In-Reply-To: <YOK9Gbcd63QkU5LB@gmail.com>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
        <162399999702.506599.16339931387573094059.stgit@devnote2>
        <YOK9Gbcd63QkU5LB@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 5 Jul 2021 10:04:41 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Change kretprobe_trampoline to make a space for regs->ARM_pc so that
> > kretprobe_trampoline_handler can call instruction_pointer_set()
> > safely.
> 
> The idiom is "make space", but in any case, what does this mean?

Since arm's kretprobe_trampoline() saves partial pt_regs, regs->ARM_pc
is not accessible (it points the caller function's stack frame).
Therefore, this extends the stack frame for storing regs->ARM_pc.

> 
> Was the stack frame set up in kretprobe_trampoline() and calling 
> trampoline_handler() buggy?
> 
> If yes, then explain the bad effects of the bug, and make all of this clear 
> in the title & changelog.

This is actually buggy from the specification viewpoint. And if
the kretprobe handler sets the instruction pointer, it must be
ignored, but in reallty, it breaks the stack frame (this does
not happen in the ftrace/perf dynamic events, but a custom kretprobe
kernel module can do this.)

Thank you,

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
