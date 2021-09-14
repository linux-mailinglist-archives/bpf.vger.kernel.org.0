Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A740B159
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhINOkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234058AbhINOkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75010610E6;
        Tue, 14 Sep 2021 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630340;
        bh=gXV9kTWCvJThDIWiGCWSE/MEIc6zem6E9osIJWS2Eho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVrSKpN4YZJJHWg6zx7tVFrHSa/lAl/kNqxWn85sDWav9HiFDdlHDKyASrgUyf+WD
         zTebMqfU7AB9sApCzmNJGdVj6/HpuCC2gJVnQBiYVuCM9PFPlpQ6yTRi1cmwXlCWQg
         vApcqXjPYJSKVuXCt9kSL0ZMlUVR3miyABuOewWKXEQPA5Lcwqcn4gUtwc/6se1yBh
         xokO1gtaNRXJwWMQx+01QenGd1YMiQKkLBK40ZJgyemPLhKt17gm2HoTWLn/OV+CsF
         T67emIn9173wP1GUrVUicC1XbkcXTF7X/OORlmdZZLv/2p+RiweRLA6txmPpwk1WHA
         oQxHXgn5JL5Rg==
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
Subject: [PATCH -tip v11 03/27] kprobe: Simplify prepare_kprobe() by dropping redundant version
Date:   Tue, 14 Sep 2021 23:38:57 +0900
Message-Id: <163163033696.489837.9264661820279300788.stgit@devnote2>
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

The function prepare_kprobe() is called during kprobe registration and
is responsible for ensuring any architecture related preparation for
the kprobe is done before returning.

One of two versions of prepare_kprobe() is chosen depending on the
availability of KPROBE_ON_FTRACE in the kernel configuration.

Simplify the code by dropping the version when KPROBE_ON_FTRACE is not
selected - instead relying on kprobe_ftrace() to return false when
KPROBE_ON_FTRACE is not set.

No functional change.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |    5 +++++
 kernel/kprobes.c        |   23 +++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e4f3bfe08757..0b75549b2815 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -354,6 +354,11 @@ static inline void wait_for_kprobe_optimizer(void) { }
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+#else
+static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	return -EINVAL;
+}
 #endif
 
 int arch_check_ftrace_location(struct kprobe *p);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 26fc9904c3b1..cfa9d3c263eb 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1033,15 +1033,6 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
 
-/* Must ensure p->addr is really on ftrace */
-static int prepare_kprobe(struct kprobe *p)
-{
-	if (!kprobe_ftrace(p))
-		return arch_prepare_kprobe(p);
-
-	return arch_prepare_kprobe_ftrace(p);
-}
-
 /* Caller must lock kprobe_mutex */
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
@@ -1113,11 +1104,6 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
-static inline int prepare_kprobe(struct kprobe *p)
-{
-	return arch_prepare_kprobe(p);
-}
-
 static inline int arm_kprobe_ftrace(struct kprobe *p)
 {
 	return -ENODEV;
@@ -1129,6 +1115,15 @@ static inline int disarm_kprobe_ftrace(struct kprobe *p)
 }
 #endif
 
+static int prepare_kprobe(struct kprobe *p)
+{
+	/* Must ensure p->addr is really on ftrace */
+	if (kprobe_ftrace(p))
+		return arch_prepare_kprobe_ftrace(p);
+
+	return arch_prepare_kprobe(p);
+}
+
 /* Arm a kprobe with text_mutex */
 static int arm_kprobe(struct kprobe *kp)
 {

