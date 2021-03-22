Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE73439BC
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCVGlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhCVGlf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 02:41:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D4B16195D;
        Mon, 22 Mar 2021 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616395295;
        bh=LcrhRWJtXgb05ASQlIQZ+Hz25N0QWwcOZr1A52Hlftk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBzqtsfEWJeIEaWucpnDdpAc4c0WG4w4gGqy6xTWvjvmoPq6qaRxj0Oz8Tpkd/uzk
         kBcLbXp77p6HjHJlPtbcaduCWB0C1/tQ4APQYFVQFLQB+sutpCSQNzSSctHI8GE/iT
         Hu7CRjiYGtEvvihsUFnMP3FkHUDXyIMYH8rVq8B64rUwkM3EOAlSs/VXh6lnLdeccB
         B05WidJe64ycEr63DTzviHWZY9bK30DLvc/v/nU9Wsf8VLv3Vs64P1iTe36dDKj3Uk
         kb8HEHaHOOeTAV8/7KfIrMcVFMSDfmMDGoLeH2soZuor39l7SG5NybtUCxXopbAg9i
         ZBsNRI0wktGRA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: [PATCH -tip v4 09/12] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
Date:   Mon, 22 Mar 2021 15:41:30 +0900
Message-Id: <161639528987.895304.3914998623946647605.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161639518354.895304.15627519393073806809.stgit@devnote2>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
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

