Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC834A74A
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhCZMai (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhCZMaP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 08:30:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FBD061953;
        Fri, 26 Mar 2021 12:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616761815;
        bh=LcrhRWJtXgb05ASQlIQZ+Hz25N0QWwcOZr1A52Hlftk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uk9u4wbkTU1CQCvdhhL/gPoMp/C0ZREuReNYazvLBQ789CqP/uMiQyvzzCmtF8JeN
         jJA/ghA/enGUMlUyc+wGc2TSwhpSbtAzYdMXdYSHgD+imgGgpTCiW0aZNYdD7Ji1nP
         icX9CZWT6FKMXrh46dNJ6ltL8ivQgYJkgpDap6HRoTORoaYozotLkcRvFSd9QjQodW
         bidKaZREsbxc9w35jQ2GOeB4kaEd0WIJVpKy40VT6iR37a7Jb5f08RbHHZwKpzkgnE
         fdHGn5fGdAd/t/walGea1DEcEAxiI0Yv6/mSPR+1sLXPxLg9dZNA3QDZ5/rBWY+8D3
         ypVwkglpsKVuA==
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
Subject: [PATCH -tip v5 09/12] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
Date:   Fri, 26 Mar 2021 21:30:10 +0900
Message-Id: <161676181007.330141.17120389939099483040.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161676170650.330141.6214727134265514123.stgit@devnote2>
References: <161676170650.330141.6214727134265514123.stgit@devnote2>
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

