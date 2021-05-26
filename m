Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495D63911E2
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhEZIFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhEZIFS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:05:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45E3F613B4;
        Wed, 26 May 2021 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016227;
        bh=IjupCuH7LUBDawzWyZY7m3hIBhvkMzv28EFK3pFOSwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQr8s3XJkWkywOHXFJrqwkPjpIR3KYXk8arUIvGshrkE6iUkMaRoIvgUDVx95Y6L2
         PNpvrhp4vYdRN81oPdGdqoYbC0iHXhO4lxy9UE87xWyjsrs1SC75Pa6VSDYmmunMDT
         jMstLLc/QoU9ahAoxfJXfF8Ju+Co2Au1b24eDErK0/vmgSUnnGN1evH6xeqqTJfmf+
         msuYyhXyq3Ftj7SlI9QlF5s3feDYhnZxfiyWoWFY5/GUHTf0sKkBgRPoIhERfmF6ry
         pRKB7x2l50mD3QV7si/3VMvq3Bfw/kWdgXY3kNmSkmiwjt6js2os9OorJjTgo4t5FU
         FmUhV9O5mdO7A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH -tip v6 09/13] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
Date:   Wed, 26 May 2021 17:03:41 +0900
Message-Id: <162201622111.278331.11505326612383898085.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162201612941.278331.5293566981784464165.stgit@devnote2>
References: <162201612941.278331.5293566981784464165.stgit@devnote2>
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
index 54e5b89aad67..1598aca375c9 100644
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

