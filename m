Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44533927D8
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhE0Gll (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 02:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234473AbhE0Glh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 02:41:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6EB4613CC;
        Thu, 27 May 2021 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622097605;
        bh=KEe5WdEyJHtzuPMGzpiocUmfrX3xOnunn5dZvpKwBh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIOSzeubTEu12C33JR8VKMazjouMzj0FbDVGgL5wX9q7eIMNLANxeGh4NGJXbClbx
         e4NBk+zs1dbdeKqDIiX1W0NaCCjTqiBJXLYhqt2MNHXkFJU/RFIYLNgln5AAY+wNVh
         Blbi4wwxzglm/rfJTbpwwfMhaNmuUAc5vM3qrpDdiHFOiA4uZp0YxQJS7iizbyKnYf
         Py4gPw2YRUbBX4325WOGOkiZU6JFzL/tgZWDXLoLh5nrehovCr3sk8LqyhDlud6vc+
         O4dYjZToXEZKLC19U+nry5y7e3GANF2JAFvyeG8ze5eFoBcDlPK1Cssm+9cGUv/6Fy
         ao2KiMK5gXjZA==
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
Subject: [PATCH -tip v7 06/13] ARC: Add instruction_pointer_set() API
Date:   Thu, 27 May 2021 15:40:01 +0900
Message-Id: <162209760094.436794.15311301507503552258.stgit@devnote2>
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

Add instruction_pointer_set() API for arc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arc/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 4c3c9be5bd16..cca8d6583e31 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -149,6 +149,11 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return (long)regs->r0;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PTRACE_H */

