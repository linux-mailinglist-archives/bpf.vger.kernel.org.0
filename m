Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0E53EB940
	for <lists+bpf@lfdr.de>; Fri, 13 Aug 2021 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbhHMP0v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 11:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240849AbhHMP0q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 11:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F66A604AC;
        Fri, 13 Aug 2021 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628868379;
        bh=PnDYHEZmtLQzD+SDpkgm+FUo4/MBMwul90100w6jt/s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gaGlUBWpFHeJQE1TfvzBOX8xCyVGsmI7prs53046uxJtuP3ST1Hx2sfHMD4WZeoaI
         0ZD62KDF3GN/EmhihlMzEuvbYTRe4LTLQqXkYYpio3CCWTxR7cmCgZHSUAQ58/xRjm
         dcrdr8zqGIFkKJw64zooKHAzH3fLvwkCpYHF1Sq2382JKHGVgH+VLv7E9qTxbvm1l6
         vup8PZmbcpuVhVdRSjw/zzFT1WgPGgUsS38xCWETfELVX3Z5lhQJHW4D5W9JE8ZG/i
         AM7ZhXoIPVXq7jngftf8rQj9RYRbPGYnh4CQjSUdueGC10qxENmEiaumFPK57/grf9
         VDsEPz0QYTfOA==
Date:   Sat, 14 Aug 2021 00:26:14 +0900
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
Subject: Re: [PATCH -tip v3 0/6] kprobes: treewide: Clean up kprobe code
Message-Id: <20210814002614.1e4711003e9013e0b60aa789@kernel.org>
In-Reply-To: <162748615977.59465.13262421617578791515.stgit@devnote2>
References: <162748615977.59465.13262421617578791515.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ingo,

Could you pick this series if no problem?
These patches do not change any functionalities. (of course some of them
changes function APIs, like the type of return value and arguments)

Thank you,

On Thu, 29 Jul 2021 00:29:20 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 3rd series of patches to cleanup the kprobes code. Previous
> version is here.
> 
>  https://lore.kernel.org/bpf/162598881438.1222130.11530594038964049135.stgit@devnote2/
> 
> This version is rebased on the latest tip/master and Punit's cleanup series;
> 
>  https://lore.kernel.org/linux-csky/20210727133426.2919710-1-punitagrawal@gmail.com/
> 
> Just fixed some conflicts, basically no change.
> 
> I pushed his series and this series as the 'kprobes/cleanup' branch on my tree.
> So you can pull the series (and Punit's series too) from the branch below.
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/cleanup 
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
>  kernel/kprobes.c                   |  313 +++++++++++++++++++-----------------
>  kernel/trace/trace_kprobe.c        |    2 
>  12 files changed, 226 insertions(+), 217 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
