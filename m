Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85640B1AD
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhINOnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 10:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234870AbhINOnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 10:43:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 330C06112E;
        Tue, 14 Sep 2021 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630517;
        bh=Z7dFFREwwQHrQdB1bENhzb91hET8Wq84SoeFv9Bi8NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r7zbmDdkUismlNm077fkPECw78l5ZmSmD+iOdcmVuM2vQlFZhow7qxuMqW76c5FvR
         rvH/u8DjDfsPgcufFcXZR0uoFlZNzKkfJSDFQAC6r8qrEboaw4UuUTPqD4eJfr8DTI
         3Z45C4ug7V/bUHTvhxEYb2nyNQnvTAarMpSTAJt8ZDjs13/yzBHAw5im2VYEYRon2a
         I2pSBwWG0SOAXa/a/DmCkYlpB0RTf6/z6o4qpDATPF81eOf2Rpv2uzgwniYx9xhKtu
         QRlf0bFeKdd+7PG84I/1PynK6KNhg+g+692Z8sPfkQ46HKme+G0+kmxzeujWDqLX3t
         tCfmGfR8K7I8w==
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
Subject: [PATCH -tip v11 21/27] ia64: Add instruction_pointer_set() API
Date:   Tue, 14 Sep 2021 23:41:52 +0900
Message-Id: <163163051195.489837.1039597819838213481.stgit@devnote2>
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

Add instruction_pointer_set() API for ia64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v9:
   - Fix "space at the start of a line" checkpatch warnings.
  Changes in v4:
   - Make the API macro for avoiding a build error.
---
 arch/ia64/include/asm/ptrace.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index 08179135905c..8a2d0f72b324 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -51,6 +51,11 @@
  * the canonical representation by adding to instruction pointer.
  */
 # define instruction_pointer(regs) ((regs)->cr_iip + ia64_psr(regs)->ri)
+# define instruction_pointer_set(regs, val)	\
+({						\
+	ia64_psr(regs)->ri = (val & 0xf);	\
+	regs->cr_iip = (val & ~0xfULL);		\
+})
 
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {

