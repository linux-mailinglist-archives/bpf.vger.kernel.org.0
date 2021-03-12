Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0533861D
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 07:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhCLGnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Mar 2021 01:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhCLGnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Mar 2021 01:43:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1E9464F7E;
        Fri, 12 Mar 2021 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615531387;
        bh=w5JaQqYBFBJXj+c2YX362brlwOI7wcwZPwdIYDk/GVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgiTCWzgOLJ+EYJ9MT1iygK8libL/Ze4XDVzm/YeOujITrMAFzwsX11B3TV3Y5/oH
         qJzX986FJJbk1Uwxg1HxrM/B+UEjeup9fRQHZ4ViaZo+1Gu8CMNGmCAvbM1is6PtiN
         9pBbgsCsVXxKp7UZcB2m7xWOn3YLHlUv0HyxpMX4XiPOOGD4NRHDUCZ6IEKujXnRgn
         z8wVr0rUrXwwKiB9jN9DVC63o8mbGjVbB+fbI/B7buu/Ha5OT8Zxnu+7yBnisB/qjw
         mrpy2mMRqdDIq8bPEkZB7YuAC+9qlwrMqKbY3SOPJq/JwsOjq9kP6LK1ItyRmaF1j3
         53+SHwUPRcczA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip v2 07/10] ia64: Add instruction_pointer_set() API
Date:   Fri, 12 Mar 2021 15:43:01 +0900
Message-Id: <161553138146.1038734.1781283504485314206.stgit@devnote2>
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

Add instruction_pointer_set() API for ia64.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/ia64/include/asm/ptrace.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index b3aa46090101..dbd9e85cbc77 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -71,6 +71,12 @@ static inline long regs_return_value(struct pt_regs *regs)
 		return -regs->r8;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs, unsigned long val)
+{
+	ia64_psr(regs)->ri = (val & 0xf);
+	regs->cr_iip = (val & ~0xfULL);
+}
+
 /* Conserve space in histogram by encoding slot bits in address
  * bits 2 and 3 rather than bits 0 and 1.
  */

