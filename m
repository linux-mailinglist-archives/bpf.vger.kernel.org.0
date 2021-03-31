Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2474434F854
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhCaFow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 01:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233469AbhCaFo3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 01:44:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D92C161584;
        Wed, 31 Mar 2021 05:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617169469;
        bh=CS7Gh8VB0IiwZuCqcwMMK4GpVGupLfHsBHD/GtPj8Nk=;
        h=From:To:Cc:Subject:Date:From;
        b=f0kouHdRL6xTvol+aHtzraYXHbgUGQ4CkJeAQ+iOalBDFYwQlfhlc/CkRb4s8XsoJ
         uY02Uc9PsusMJ2rmKcdUuYww7GDJgcNh4lF5aLMA2TuPRkimX8C0v6is5PZI6ia8cY
         dUo4qygbHqj35ligO0hfSJBoYOCoNz5uriS45krVQtFjA5tU9aioxwpyD4VDRJMSZA
         GjVifDzW5i9kbqdRzHEkcOYmz/jmcFiefsEy6n7pSR5Hx47cG0JZnfGUck365JDtLO
         uJez54jQerQlLwpxGwkGbAWVL9O/QhrkRBzudo4gBVovwzFtGgPtGeFdK/2kYwMKXJ
         hrFjxKneMXc2g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH -tip 0/3] x86/kprobes,orc: Fix ORC unwinder to unwind stack with optimized probe
Date:   Wed, 31 Mar 2021 14:44:24 +0900
Message-Id: <161716946413.721514.4057380464113663840.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

These patches fixes the ORC unwinder to unwind optprobe trampoline
code on the stack correctly.
This patchset is based on the kretporbe and stacktrace fix series v5
which I sent last week.

https://lore.kernel.org/bpf/161676170650.330141.6214727134265514123.stgit@devnote2/

Note that I just confirmed the it fixes the case where the 
stacktrace called from the optprobe handler. So this should be
carefully reviewed.


Here is the test code;

cd /sys/kernel/debug/tracing
echo > trace
echo p full_proxy_read+5 >> kprobe_events
echo 1 > events/kprobes/enable
sleep 1 # wait for optimization
echo stacktrace:1 > events/kprobes/p_full_proxy_read_5/trigger
echo 1 > options/sym-offset
cat /sys/kernel/debug/kprobes/list


Without this,

             cat-138     [001] ...1     6.567662: p_full_proxy_read_5: (full_proxy_read+0x5/0x80)
             cat-138     [001] ...1     6.567711: <stack trace>
 => kprobe_trace_func+0x1d0/0x2c0
 => kprobe_dispatcher+0x39/0x60
 => opt_pre_handler+0x4f/0x80
 => optimized_callback+0xc3/0xf0
 => 0xffffffffa0006032
 => 0
 => 0


With this patch,

             cat-137     [007] ...1    17.542848: p_full_proxy_read_5: (full_proxy_read+0x5/0x80)
             cat-137     [007] ...1    17.542963: <stack trace>
 => kprobe_trace_func+0x1d0/0x2c0
 => kprobe_dispatcher+0x39/0x60
 => opt_pre_handler+0x4f/0x80
 => optimized_callback+0xc3/0xf0
 => full_proxy_read+0x5/0x80
 => vfs_read+0xab/0x1a0
 => ksys_read+0x5f/0xe0
 => do_syscall_64+0x33/0x40
 => entry_SYSCALL_64_after_hwframe+0x44/0xae
 => 0
 => 0


Thank you,

---

Masami Hiramatsu (3):
      x86/kprobes: Add ORC information to optprobe template
      kprobes: Add functions to find instruction buffer entry address
      x86/kprobes,orc: Unwind optprobe trampoline correctly


 arch/x86/include/asm/kprobes.h |    6 +++
 arch/x86/kernel/kprobes/opt.c  |   72 +++++++++++++++++++++++++++++++++++++---
 arch/x86/kernel/unwind_orc.c   |   15 +++++++-
 include/linux/kprobes.h        |    8 ++++
 kernel/kprobes.c               |   25 ++++++++++----
 5 files changed, 111 insertions(+), 15 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
