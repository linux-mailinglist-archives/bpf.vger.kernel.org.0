Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152483D91E0
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhG1P3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235648AbhG1P3Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jul 2021 11:29:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71B8760F91;
        Wed, 28 Jul 2021 15:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627486163;
        bh=4eOv0S36oCuufYDKfUQ15IpJrB2UwmRfcJL2L/+B+3A=;
        h=From:To:Cc:Subject:Date:From;
        b=TqbNHbt6wWfa/2LJtvPtFOg6fyhBsMKy2W7BZJ/kOq/bBVBSZ0zwbMwuGCKGgcbfM
         QB4dqILEfFRR4uK7VYqjSPPokmtsVkvfgezxRXHZbXzMHi1aIkqPSHjdMQN0klLynt
         zo2G95Zc6DvCQs9gpUbl7sM7fJfT3WPBBFGzibgKsEqKr7w02vHWGsRIffZnfb4uAs
         6oOmjfgIYjVWbVNUsP4h+jVS0Agcio5nfO6nGlDHzVqiuUHpmfgt4jHDwPTnXKwb8t
         trKdlDow1jmCxyPhneOYmqONpwAzgdZRPLoWFQP9HAhaszC4oOW4F4Mw1NIL4wGab8
         yBs0KrbdRwQig==
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
Subject: [PATCH -tip v3 0/6] kprobes: treewide: Clean up kprobe code
Date:   Thu, 29 Jul 2021 00:29:20 +0900
Message-Id: <162748615977.59465.13262421617578791515.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Here is the 3rd series of patches to cleanup the kprobes code. Previous
version is here.

 https://lore.kernel.org/bpf/162598881438.1222130.11530594038964049135.stgit@devnote2/

This version is rebased on the latest tip/master and Punit's cleanup series;

 https://lore.kernel.org/linux-csky/20210727133426.2919710-1-punitagrawal@gmail.com/

Just fixed some conflicts, basically no change.

I pushed his series and this series as the 'kprobes/cleanup' branch on my tree.
So you can pull the series (and Punit's series too) from the branch below.

 git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git kprobes/cleanup 

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
 kernel/kprobes.c                   |  313 +++++++++++++++++++-----------------
 kernel/trace/trace_kprobe.c        |    2 
 12 files changed, 226 insertions(+), 217 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
