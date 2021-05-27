Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9593927E1
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbhE0GmP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 02:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234473AbhE0GmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 02:42:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CBD2613D8;
        Thu, 27 May 2021 06:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622097633;
        bh=FkkjM9IdASzlPy5rbPRT2RtG01kVXUCEr1Rvtd2a5iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUIzp22oaxs7bdAZkppqknpu4nQorQEHVlVUIT5PVlhTfoQDkD1o75sNzoG9QpvvS
         KUsdYssxWebYiv3Zi0VuDW80Jq/hCWMR9WUbt65KHGO86xlSEN/PRHjoCnp/Xlo2c2
         ph3nsxEyj4iVj5qr9UHp7/hpo+YfeZuJ2vzeB10tUzOzKx8xG/9tk+ZuITN3rv+T0V
         enIwlgkOSJswJCw2RIFBaHmY7qndRYTBSwF8tPnwjYwUovBgMm2xWLo69uFyONi7Du
         33w4Z3iN44r9JyBv4pW0eV+OCLOllRrUorPG7FeRnarLtGUHv/iYlM0q+nV1eKOr9w
         iyaMp9wKddfuA==
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
Subject: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
Date:   Thu, 27 May 2021 15:40:29 +0900
Message-Id: <162209762943.436794.874947392889792501.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162209754288.436794.3904335049560916855.stgit@devnote2>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
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
Tested-by: Andrii Nakryik <andrii@kernel.org>
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

