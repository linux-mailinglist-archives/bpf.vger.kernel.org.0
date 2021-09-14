Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C899240B117
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhINOj7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233614AbhINOj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:39:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CAC1610CE;
        Tue, 14 Sep 2021 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630321;
        bh=4xQiQDDV7nXJL8Xan+15i4FwcNOTqTiYzYCdCLjItZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5F7dsm3oC3uWyspwozTKIHTqoDUSpeWzd2cFIzjDhYfwuHRmblgxYcBS5r4Q0hms
         fV6v7crr6GMxQwrgBCCrY8zspDHYWnYlynmfEFDiFfSdHSuYNpSfYCIPmyUL6uVj6C
         v6g9TBqpQQk24LXe4gWje5oEYx9+og5T5QUDYso7jq/CcYRb1pWEWy6YMhY1nlj83x
         pbsBqG8FU5CXWkJjtxzRvRL5FT2Eem287aIg7Tz9NYhMLpoWEd8NjMBExtzw0PW4tf
         9jbYizbkmoOzNSXoB+A1KHa+ItddVhB5fNLXLaNScI8Vjydfb90NMdcNPaLrRPNzxF
         O6FpkVf8diEJQ==
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
Subject: [PATCH -tip v11 01/27] kprobes: Do not use local variable when creating debugfs file
Date:   Tue, 14 Sep 2021 23:38:37 +0900
Message-Id: <163163031686.489837.4476867635937014973.stgit@devnote2>
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

debugfs_create_file() takes a pointer argument that can be used during
file operation callbacks (accessible via i_private in the inode
structure). An obvious requirement is for the pointer to refer to
valid memory when used.

When creating the debugfs file to dynamically enable / disable
kprobes, a pointer to local variable is passed to
debugfs_create_file(); which will go out of scope when the init
function returns. The reason this hasn't triggered random memory
corruption is because the pointer is not accessed during the debugfs
file callbacks.

Since the enabled state is managed by the kprobes_all_disabled global
variable, the local variable is not needed. Fix the incorrect (and
unnecessary) usage of local variable during debugfs_file_create() by
passing NULL instead.

Fixes: bf8f6e5b3e51 ("Kprobes: The ON/OFF knob thru debugfs")
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 790a573bbe00..1cf8bca1ea86 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2809,13 +2809,12 @@ static const struct file_operations fops_kp = {
 static int __init debugfs_kprobe_init(void)
 {
 	struct dentry *dir;
-	unsigned int value = 1;
 
 	dir = debugfs_create_dir("kprobes", NULL);
 
 	debugfs_create_file("list", 0400, dir, NULL, &kprobes_fops);
 
-	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
+	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
 
 	debugfs_create_file("blacklist", 0400, dir, NULL,
 			    &kprobe_blacklist_fops);

