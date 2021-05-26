Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFD3911D9
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhEZIEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 04:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233125AbhEZIEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 04:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD3E36143C;
        Wed, 26 May 2021 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622016195;
        bh=KEe5WdEyJHtzuPMGzpiocUmfrX3xOnunn5dZvpKwBh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnVJbwPg6/PHpv6+3Vty4CWCzNAcoi/HjE84+vLrfOnDn+6Qn+xJBBuLErX/Ojc40
         Gcn0mw24OvXKa6WWti+m/bqFIokt6GqZqg1tbMUQI/A9rfbbNQaikaSQYz714L57Az
         YEOWc9de7mKRdTx3/2snzb948yGNbOTZ7TnU2Q4Xa5dLyDEQl2Btsonl8zAz6gIF94
         fQF0j4Ub7auJNj1ims2N/vuZUsfegciVi/o1SGLWW1ydolMr8lisO/Vy+cD5Catuz6
         8Ph6KFrH8fKJVvB07ktJuXu4yodA5mwSgxmEAcm/DgJheDEHxY5Eosdn2mTpj8hzIz
         c153z3YoAUm6Q==
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
Subject: [PATCH -tip v6 06/13] ARC: Add instruction_pointer_set() API
Date:   Wed, 26 May 2021 17:03:11 +0900
Message-Id: <162201619065.278331.10638125156640651686.stgit@devnote2>
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

