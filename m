Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F38340B140
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhINOkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbhINOkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:40:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D6C761166;
        Tue, 14 Sep 2021 14:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630331;
        bh=oAqCBuqVjpZ5iefHB0MM8nDjvpho+9id+MYRlbmVcnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHn3yMB4HYLvj7zjWfQkipry55hbyowo9RJUYfSIz4zippAHUdb61Fpy7jnzD4Ihq
         dm258oIxRRCqnYfFca+eKNf/V/BRWBz+OobD6wXIkVZQjVseAjW+XXJlME0bYdiN57
         TD+dC9mwGjISd0lu9g0jwTQogY6KCB0eoJU1cBWjRhCep4pNpboT0TSnM4fiqvajUL
         GTfnl9iiEph+UTbDIuB/2Ymd+apDYJgJvPbU+h19l5SwsGtogDA2Lw4RMYKnOxNh4T
         4aYjCFKODEZKmdmwWM7oggvlRSc8mqv0gfxNYW1yAHjXbhcnWUl3uw3A0Y6tmmXLsg
         1ddKk2JVi5FwQ==
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
Subject: [PATCH -tip v11 02/27] kprobes: Use helper to parse boolean input from userspace
Date:   Tue, 14 Sep 2021 23:38:46 +0900
Message-Id: <163163032637.489837.10678039554832855327.stgit@devnote2>
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

The "enabled" file provides a debugfs interface to arm / disarm
kprobes in the kernel. In order to parse the buffer containing the
values written from userspace, the callback manually parses the user
input to convert it to a boolean value.

As taking a string value from userspace and converting it to boolean
is a common operation, a helper kstrtobool_from_user() is already
available in the kernel. Update the callback to use the common helper
to parse the write buffer from userspace.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 1cf8bca1ea86..26fc9904c3b1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2770,30 +2770,14 @@ static ssize_t read_enabled_file_bool(struct file *file,
 static ssize_t write_enabled_file_bool(struct file *file,
 	       const char __user *user_buf, size_t count, loff_t *ppos)
 {
-	char buf[32];
-	size_t buf_size;
-	int ret = 0;
-
-	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
+	bool enable;
+	int ret;
 
-	buf[buf_size] = '\0';
-	switch (buf[0]) {
-	case 'y':
-	case 'Y':
-	case '1':
-		ret = arm_all_kprobes();
-		break;
-	case 'n':
-	case 'N':
-	case '0':
-		ret = disarm_all_kprobes();
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
 
+	ret = enable ? arm_all_kprobes() : disarm_all_kprobes();
 	if (ret)
 		return ret;
 

