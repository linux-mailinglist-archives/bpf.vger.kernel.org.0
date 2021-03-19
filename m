Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422F1341CCA
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 13:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCSMXW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 08:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230268AbhCSMXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 08:23:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBA656146D;
        Fri, 19 Mar 2021 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616156597;
        bh=LcrhRWJtXgb05ASQlIQZ+Hz25N0QWwcOZr1A52Hlftk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2ANLwl7s4csgnpWOozqQPHMjY0Y/fv3o7vPE+Q6STc39tJMsidi39RDg7W5cOP29
         8lx1xDG7U6kTc7zInqhdYhuR/+Jp9vwK9Sk0Xe9V4Ykgfz8PGXOSROLxw1cbYs95pQ
         keEuOc4l64aTGI9UQ1xVBPlZe79or5OOcX3HEasjaptN2SUINDXm3W3IQU0Sw8xk7R
         mz1kLe0+u/hnFFIaOLx89V8OlAUoR89TJ/ONaHLh2hTenZv2PPt6bW8wyxgFgMyeoO
         XbirmkqnXQxE86ljJ2uvJGD/YSIznajrjbkPQ809YYdtITliyslb+4NXbFDl5Gfznw
         v8IIE++lgMH2g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org
Subject: [PATCH -tip v3 08/11] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
Date:   Fri, 19 Mar 2021 21:23:12 +0900
Message-Id: <161615659174.306069.12736134222759644948.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161615650355.306069.17260992641363840330.stgit@devnote2>
References: <161615650355.306069.17260992641363840330.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To simplify the stacktrace with pt_regs from kretprobe handler,
set the correct return address to the instruction pointer in
the pt_regs before calling kretprobe handlers.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Cast the correct_ret_addr to unsigned long.
---
 kernel/kprobes.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cf19edc038e4..4ce3e6f5d28d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1914,6 +1914,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		BUG_ON(1);
 	}
 
+	/* Set the instruction pointer to the correct address */
+	instruction_pointer_set(regs, (unsigned long)correct_ret_addr);
+
 	/* Run them. */
 	first = current->kretprobe_instances.first;
 	while (first) {

