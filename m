Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0540B173
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhINOlG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234270AbhINOkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:40:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C509610F9;
        Tue, 14 Sep 2021 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630360;
        bh=dLEXA0c32zAO/OxwC4RSb6MzIoMznRgqiTxAuTIvdtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfkbkcMR3qNFA4rPdoe/b8gxTIGdhxqSVs7mSOQoJzgRUOmrQZEE5Jr/eni3Fls4x
         Vv0yR7HubTr2XXVEJg99txCC+YcVsXh/ZoeHN3XkdGusyGi1ImCffbeM3DIMX2bPiq
         PN6LWj7MYUdvNpi0Ykv0dYAt3Bsk7VUlTgXQlIn0IYfqp1dX+1O9ykIdG64jUhRgEc
         EUdraEGUBQOfy5/vqPPROQWcNLaH4RxFwLlmHp+ggRdPLtMjuUiapP4TbNs+hJm87S
         r2Umb6AIlnynwwWy8O3qVjtmvtBKuD8piZYfT1xLX/hvow3RNz+bAuvJC7Rc+zd8MC
         S69Mw5g1mluSA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        yhs@fb.com, linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: [PATCH -tip v11 05/27] kprobes: Make arch_check_ftrace_location static
Date:   Tue, 14 Sep 2021 23:39:16 +0900
Message-Id: <163163035673.489837.2367816318195254104.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163163030719.489837.2236069935502195491.stgit@devnote2>
References: <163163030719.489837.2236069935502195491.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Punit Agrawal <punitagrawal@gmail.com>

arch_check_ftrace_location() was introduced as a weak function in
commit f7f242ff004499 ("kprobes: introduce weak
arch_check_ftrace_location() helper function") to allow architectures
to handle kprobes call site on their own.

Recently, the only architecture (csky) to implement
arch_check_ftrace_location() was migrated to using the common
version.

As a result, further cleanup the code to drop the weak attribute and
rename the function to remove the architecture specific
implementation.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    2 --
 kernel/kprobes.c        |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0b75549b2815..8a9412bb0d5e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -361,8 +361,6 @@ static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
-int arch_check_ftrace_location(struct kprobe *p);
-
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cfa9d3c263eb..30199bfcc74a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1524,7 +1524,7 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 	return ret;
 }
 
-int __weak arch_check_ftrace_location(struct kprobe *p)
+static int check_ftrace_location(struct kprobe *p)
 {
 	unsigned long ftrace_addr;
 
@@ -1547,7 +1547,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 {
 	int ret;
 
-	ret = arch_check_ftrace_location(p);
+	ret = check_ftrace_location(p);
 	if (ret)
 		return ret;
 	jump_label_lock();

