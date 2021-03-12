Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0304733861F
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 07:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhCLGne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 01:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhCLGnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 01:43:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0212764F80;
        Fri, 12 Mar 2021 06:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531398;
        bh=ZKbmnjFAhVf2lgJI+3UO8SYmXa3ckjhywUcY1D1JWdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcbDinAtz4kKN62kdzrTO/j55dNW9E7xAgmv2QX4VwepXl0uwgxxHmQ64qeZueAKu
         gapXpehPUbKSvnz7wJ7QKTmBWnGIJ+4H8cVhcrpQPVY+pHFDvrWvwxl0Q5lmdOQ/WY
         h8r+qMAQb05q8RWXXsNVuRoSm2rQtvFmL+fCDuux/2O/qGR90iedFpZfipB7ESlD1E
         kpF4H8JZYyiqIHwWHcM6HM4gr71AMld1vE5qpVi/3C3JTE8qC6Bo6KRNnlpuJIBSSZ
         gsDpUZDUE1lJwdHMOR4gFJIHuVSrV1IozAW3k2ofxsYlaPEJmB0RqcfvXp2DDRxO2y
         /hXiGuoLEh2lQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip v2 08/10] kprobes: Setup instruction pointer in __kretprobe_trampoline_handler
Date:   Fri, 12 Mar 2021 15:43:12 +0900
Message-Id: <161553139244.1038734.17778022007486082158.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <161553130371.1038734.7661319550287837734.stgit@devnote2>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
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
 kernel/kprobes.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2550521ff64d..51d0057382a5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1897,6 +1897,9 @@ unsigned long __kretprobe_trampoline_handler(struct pt_regs *regs,
 		BUG_ON(1);
 	}
 
+	/* Set the instruction pointer to the correct address */
+	instruction_pointer_set(regs, correct_ret_addr);
+
 	/* Run them. */
 	first = current->kretprobe_instances.first;
 	while (first) {

