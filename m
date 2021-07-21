Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304F83D0B48
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhGUIWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 04:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235143AbhGUINs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 04:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCD5061029;
        Wed, 21 Jul 2021 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626856982;
        bh=zaxBgl0zmqFoRCTU1TKbNY9Ob5tCMwIxamYH6mVMFV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LG0eVYN12xOURN7r0bA3jJ7dGpw6SpSOR7sqA+lH7bme3QHLolqgA5zAzqch+nu3x
         zYgRbEk2OzWL0uVLFKCk4/kgy8z0jQpK/tcBYiw13cFSR86sZA93nWU078G2HuH6oy
         rvqswbeX+wuCupd+z8FqCIWX9QGHbmhm0pjoUmahPDcy5YSqOPUDq513sljul05OE8
         VwwJl42IvVDviDvRyYsLw573rDW1lGXu87vAM+m5lCPgXrYIYf4SjYCz6MucYQ/p6F
         13lQ2lQ8tC0H1F+ZUFKDQprGCfwQpCS4KhafHjFrX0ljrHBXGOJfyGZLnc0glgeW3+
         L1pZzXedGEysQ==
Date:   Wed, 21 Jul 2021 17:42:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH -tip v2 0/6] kprobes: treewide: Clean up kprobe code
Message-Id: <20210721174258.0fc04b1ab8d8c3ebcba6295e@kernel.org>
In-Reply-To: <162598881438.1222130.11530594038964049135.stgit@devnote2>
References: <162598881438.1222130.11530594038964049135.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Sun, 11 Jul 2021 16:33:34 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 2nd series of patches to cleanup the kprobes code. Previous
> version is here.
> 
>  https://lore.kernel.org/bpf/162592891873.1158485.768824457210707916.stgit@devnote2/
> 
> This version is just add a cleanup of trace_kprobes to the [6/6], thanks
> Joe to find it out!

Does anyone have any comments? Or should I make a pull request for this change?

Thank you,

> 
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (6):
>       kprobes: treewide: Cleanup the error messages for kprobes
>       kprobes: Fix coding style issues
>       kprobes: Use IS_ENABLED() instead of kprobes_built_in()
>       kprobes: Add assertions for required lock
>       kprobes: treewide: Use 'kprobe_opcode_t *' for the code address in get_optimized_kprobe()
>       kprobes: Use bool type for functions which returns boolean value
> 
> 
>  arch/arm/probes/kprobes/core.c     |    4 
>  arch/arm/probes/kprobes/opt-arm.c  |    7 -
>  arch/arm64/kernel/probes/kprobes.c |    5 -
>  arch/csky/kernel/probes/kprobes.c  |   10 +
>  arch/mips/kernel/kprobes.c         |   11 +
>  arch/powerpc/kernel/optprobes.c    |    6 -
>  arch/riscv/kernel/probes/kprobes.c |   11 +
>  arch/s390/kernel/kprobes.c         |    4 
>  arch/x86/kernel/kprobes/opt.c      |    6 -
>  include/linux/kprobes.h            |   64 +++----
>  kernel/kprobes.c                   |  315 +++++++++++++++++++-----------------
>  kernel/trace/trace_kprobe.c        |    2 
>  12 files changed, 227 insertions(+), 218 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
