Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C981A3C34EF
	for <lists+bpf@lfdr.de>; Sat, 10 Jul 2021 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhGJO6I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Jul 2021 10:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhGJO6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 10:58:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A54E461356;
        Sat, 10 Jul 2021 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625928922;
        bh=xNfvoZZIvIuehy673Z/DuFsta3HB/enFrqH5E1AoTok=;
        h=From:To:Cc:Subject:Date:From;
        b=SVDMMxy761XYVlp242jTKk73I6H8ZOqNQZU7sfjna2tTX74pKBw2K5lpWuiWNiUsy
         1VvYtyMcg9S+co/f/HfaeWYH3ttTkjpGXnawSZW02Q//1BmIy7PK6skJY47Sz79Zpa
         Kls8ksFFVbWBn7yIYCMWLt0Jt6Kj+eHx6egyt/T8EijCgjosWILxM7sghC8r0zfzJv
         CigPkiBHLp9Tna/e5fS5ahuLvgNhlfT71kxlblz/PAVWmDZNT69ZbHBFgeECw01Ubc
         A68P1X6qVSBoamIRAH/UICJNqK3ZVY0u5Dl5f7FY1TxKCiVzFeLqu2aRd5+2dfZcqQ
         5n4iFXvY6GPBQ==
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
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip 0/6] kprobes: treewide: Clean up kprobe code
Date:   Sat, 10 Jul 2021 23:55:19 +0900
Message-Id: <162592891873.1158485.768824457210707916.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ingo,

Here is a series of patches to cleanup the kprobes code. I tried to fix
error message issues, comments, checkpatch.pl issues and so on. Some
of those are what you suggested and pointed in the x86 stacktrace series.

 https://lore.kernel.org/bpf/YOK39GTuueIDeaJL@gmail.com/

I decided to split this seires from the x86 stacktrace fix series because
there still be some on going discussions on that thread. The stacktrace
fix series will be rebased on this series (and I've almost done, except
for some discussion items).

Since this is a cleanup series, this does not change any functionality
(of course some error messages, warnings, lock assertions are chaneged)
but the coding styles are improved. I will continue this cleanup activities
for each architecture port, and rethink the internal coding design and
interfaces too.

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
 11 files changed, 226 insertions(+), 217 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
