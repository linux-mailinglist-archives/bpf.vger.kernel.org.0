Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61133C3B02
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhGKHgc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 03:36:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhGKHgc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Jul 2021 03:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1D5661351;
        Sun, 11 Jul 2021 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625988826;
        bh=Gkry7L4/a6oK7rD4bkVSprWsqRBKKhrxcAhOuwFyCPg=;
        h=From:To:Cc:Subject:Date:From;
        b=sJepMvu+zYY4IIcqXsn12uNUEEK02Wj8VBt8lha08kBUtrUv4wXwMtOH4GrItKkxa
         g9RUBIOU058HFTmY7Kf6sAYpB3jSZIAtG97FdIIBOhdC9gn7XlJcnm0QpRDDzkI50r
         PjvYCU2SMgv8X464rTU/BzUNfTmlhLICJcwJaHpqaeehEhI0rgKr6pcEAMIwnl9is/
         LY48HP1QE5bda/YBGYHvFPUd5sXqUjA9qaXB9p33dxRjMGqJwWyPaC4hKiZv9lwtvZ
         X5VxOPOIib+7AeChXHqWXngPEIuwPH+EnnJOXDs/8XPdAEmnlni+BNaFMcZfZrQYu4
         KIfwSLspbpLFw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     X86 ML <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH -tip v2 0/6] kprobes: treewide: Clean up kprobe code
Date:   Sun, 11 Jul 2021 16:33:34 +0900
Message-Id: <162598881438.1222130.11530594038964049135.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Here is the 2nd series of patches to cleanup the kprobes code. Previous
version is here.

 https://lore.kernel.org/bpf/162592891873.1158485.768824457210707916.stgit@devnote2/

This version is just add a cleanup of trace_kprobes to the [6/6], thanks
Joe to find it out!


Thank you,

---

Masami Hiramatsu (6):
      kprobes: treewide: Cleanup the error messages for kprobes
      kprobes: Fix coding style issues
      kprobes: Use IS_ENABLED() instead of kprobes_built_in()
      kprobes: Add assertions for required lock
      kprobes: treewide: Use 'kprobe_opcode_t *' for the code address in get_optimized_kprobe()
      kprobes: Use bool type for functions which returns boolean value


 arch/arm/probes/kprobes/core.c     |    4 
 arch/arm/probes/kprobes/opt-arm.c  |    7 -
 arch/arm64/kernel/probes/kprobes.c |    5 -
 arch/csky/kernel/probes/kprobes.c  |   10 +
 arch/mips/kernel/kprobes.c         |   11 +
 arch/powerpc/kernel/optprobes.c    |    6 -
 arch/riscv/kernel/probes/kprobes.c |   11 +
 arch/s390/kernel/kprobes.c         |    4 
 arch/x86/kernel/kprobes/opt.c      |    6 -
 include/linux/kprobes.h            |   64 +++----
 kernel/kprobes.c                   |  315 +++++++++++++++++++-----------------
 kernel/trace/trace_kprobe.c        |    2 
 12 files changed, 227 insertions(+), 218 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
