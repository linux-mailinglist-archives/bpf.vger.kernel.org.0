Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F132EF16
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 16:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCEPj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 10:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhCEPjD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Mar 2021 10:39:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B547F64F04;
        Fri,  5 Mar 2021 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614958742;
        bh=1KT8OJo41htNsD2Osx55R/4Ki4krEHC4Gp1XUp9nDLM=;
        h=From:To:Cc:Subject:Date:From;
        b=H9obW2d7OS6xZ/yYPNXXpivPNNeHWV/WYnnuaPOOuF36rFinbH/wz4vJcKp+Wb5oj
         KnLfiDJKH0jCJtLPD7ORB4q5tVhOx4SxpwTWgvDbY813teZtpBCvnqN0G6QIkh/Xzh
         g223sx4CkGuCuoNmDE6eOckuzF/1PBwRp96ToPr0k3JsWeDLJ4K1VpbYQXXDk0l73N
         tmhRd+oK1OPSSrAZMlEmUZX7iVR1QKcAmr1pq6sepFnDqOGkvRA9rBuzKhBpygHuEb
         sVP686FBc+Thjl7DHAbFXObhn4q18P7eHbWdhmIN3rzumv2sxG9Wes+3A2QlwgMsoX
         s3kxn8V2EAq5A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com
Subject: [PATCH -tip 0/5] kprobes: Fix stacktrace in kretprobes
Date:   Sat,  6 Mar 2021 00:38:57 +0900
Message-Id: <161495873696.346821.10161501768906432924.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Here is a series of patches for kprobes and stacktracer to fix the kretprobe
entries in the kernel stack. This was reported by Daniel Xu. I thought that
was in the bpftrace, but it is actually more generic issue.
So I decided to fix the issue in arch independent part.

While fixing the issue, I found a bug in ia64 related to kretprobe, which is
fixed by [1/5]. [2/5] and [3/5] is a kind of cleanup before fixing the main
issue. [4/5] is the patch to fix the stacktrace, which involves kretprobe
internal change. And [5/5] removing the stacktrace kretprobe fixup code in
ftrace. 

Daniel, can you also check that this fixes your issue too? I hope it is.

Note that this doesn't fixup all cases. Unfortunately, stacktracing the
other tasks (non current task) on the arch which doesn't support ARCH_STACKWALK,
I can not fix it in the arch independent code. Maybe each arch dependent
stacktrace implementation must fixup by themselves.

Thank you,

---

Masami Hiramatsu (5):
      ia64: kprobes: Fix to pass correct trampoline address to the handler
      kprobes: treewide: Replace arch_deref_entry_point() with dereference_function_descriptor()
      kprobes: treewide: Remove trampoline_address from kretprobe_trampoline_handler()
      kprobes: stacktrace: Recover the address changed by kretprobe
      tracing: Remove kretprobe unknown indicator from stacktrace


 arch/arc/kernel/kprobes.c          |    2 -
 arch/arm/probes/kprobes/core.c     |    3 -
 arch/arm64/kernel/probes/kprobes.c |    3 -
 arch/csky/kernel/probes/kprobes.c  |    2 -
 arch/ia64/kernel/kprobes.c         |   15 ++----
 arch/mips/kernel/kprobes.c         |    3 -
 arch/parisc/kernel/kprobes.c       |    4 +-
 arch/powerpc/kernel/kprobes.c      |   13 -----
 arch/riscv/kernel/probes/kprobes.c |    2 -
 arch/s390/kernel/kprobes.c         |    2 -
 arch/sh/kernel/kprobes.c           |    2 -
 arch/sparc/kernel/kprobes.c        |    2 -
 arch/x86/kernel/kprobes/core.c     |    2 -
 include/linux/kprobes.h            |   32 +++++++++++--
 kernel/kprobes.c                   |   89 ++++++++++++++++++++++--------------
 kernel/stacktrace.c                |   21 ++++++++
 kernel/trace/trace_output.c        |   27 ++---------
 lib/error-inject.c                 |    3 +
 18 files changed, 126 insertions(+), 101 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
