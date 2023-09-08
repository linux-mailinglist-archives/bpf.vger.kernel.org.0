Return-Path: <bpf+bounces-9531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7C798BE9
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 20:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281381C20CAA
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829731429C;
	Fri,  8 Sep 2023 18:02:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428013AFA
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 18:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955A2C433D9;
	Fri,  8 Sep 2023 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196153;
	bh=+yIye7JzDwrKLqLolNpGU0vRcq5V9EywPX5jFKl87jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PijsPi/c+Y8QaudVnr1IF8leB/bb73d0hZlHOXReokWHG4MjxfuinBQ7KGa61jyJx
	 2iveiJA4qnYqN1hfua0n8hfmX06Gq5P3uoJqEM8P3j6HA4HhY7RaunHEWBNYs8/fcM
	 WareVlHCpfY3rDuAxu4jP5gcBLTtWoPKnvu+iLM1HMtIkDmPU1UmvoXMj8jCl52brT
	 JyHFw+x9DaiGH+82BX1yjkC9DERq8y8U6eRbtkbs3FgKHEq1b0G4ySoCjbBXjl3P6F
	 Mpnpj0oLN9d5InH3Pw/6kigJ3SqHVSQqNu/s7CyFRkgLuF6AOELmlbapQF5D9zpCii
	 Pcvfhrpr12+/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomislav Novak <tnovak@meta.com>,
	Samuel Gosselin <sgosselin@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/10] hw_breakpoint: fix single-stepping when using bpf_overflow_handler
Date: Fri,  8 Sep 2023 14:02:00 -0400
Message-Id: <20230908180203.3458330-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180203.3458330-1-sashal@kernel.org>
References: <20230908180203.3458330-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit

From: Tomislav Novak <tnovak@meta.com>

[ Upstream commit d11a69873d9a7435fe6a48531e165ab80a8b1221 ]

Arm platforms use is_default_overflow_handler() to determine if the
hw_breakpoint code should single-step over the breakpoint trigger or
let the custom handler deal with it.

Since bpf_overflow_handler() currently isn't recognized as a default
handler, attaching a BPF program to a PERF_TYPE_BREAKPOINT event causes
it to keep firing (the instruction triggering the data abort exception
is never skipped). For example:

  # bpftrace -e 'watchpoint:0x10000:4:w { print("hit") }' -c ./test
  Attaching 1 probe...
  hit
  hit
  [...]
  ^C

(./test performs a single 4-byte store to 0x10000)

This patch replaces the check with uses_default_overflow_handler(),
which accounts for the bpf_overflow_handler() case by also testing
if one of the perf_event_output functions gets invoked indirectly,
via orig_default_handler.

Signed-off-by: Tomislav Novak <tnovak@meta.com>
Tested-by: Samuel Gosselin <sgosselin@google.com> # arm64
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/linux-arm-kernel/20220923203644.2731604-1-tnovak@fb.com/
Link: https://lore.kernel.org/r/20230605191923.1219974-1-tnovak@meta.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
 arch/arm64/kernel/hw_breakpoint.c |  4 ++--
 include/linux/perf_event.h        | 22 +++++++++++++++++++---
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 054e9199f30db..dc0fb7a813715 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 	hw->address &= ~alignment_mask;
 	hw->ctrl.len <<= offset;
 
-	if (is_default_overflow_handler(bp)) {
+	if (uses_default_overflow_handler(bp)) {
 		/*
 		 * Mismatch breakpoints are required for single-stepping
 		 * breakpoints.
@@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		 * Otherwise, insert a temporary mismatch breakpoint so that
 		 * we can single-step over the watchpoint trigger.
 		 */
-		if (!is_default_overflow_handler(wp))
+		if (!uses_default_overflow_handler(wp))
 			continue;
 step:
 		enable_single_step(wp, instruction_pointer(regs));
@@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 		info->trigger = addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
 		perf_bp_event(wp, regs);
-		if (is_default_overflow_handler(wp))
+		if (uses_default_overflow_handler(wp))
 			enable_single_step(wp, instruction_pointer(regs));
 	}
 
@@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (is_default_overflow_handler(bp))
+			if (uses_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index b29a311bb0552..9659a9555c63a 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, unsigned long esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(bp))
+		if (uses_default_overflow_handler(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 static int watchpoint_report(struct perf_event *wp, unsigned long addr,
 			     struct pt_regs *regs)
 {
-	int step = is_default_overflow_handler(wp);
+	int step = uses_default_overflow_handler(wp);
 	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
 
 	info->trigger = addr;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0031f7b4d9aba..63fae3c7ae430 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1139,15 +1139,31 @@ extern int perf_event_output(struct perf_event *event,
 			     struct pt_regs *regs);
 
 static inline bool
-is_default_overflow_handler(struct perf_event *event)
+__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 {
-	if (likely(event->overflow_handler == perf_event_output_forward))
+	if (likely(overflow_handler == perf_event_output_forward))
 		return true;
-	if (unlikely(event->overflow_handler == perf_event_output_backward))
+	if (unlikely(overflow_handler == perf_event_output_backward))
 		return true;
 	return false;
 }
 
+#define is_default_overflow_handler(event) \
+	__is_default_overflow_handler((event)->overflow_handler)
+
+#ifdef CONFIG_BPF_SYSCALL
+static inline bool uses_default_overflow_handler(struct perf_event *event)
+{
+	if (likely(is_default_overflow_handler(event)))
+		return true;
+
+	return __is_default_overflow_handler(event->orig_overflow_handler);
+}
+#else
+#define uses_default_overflow_handler(event) \
+	is_default_overflow_handler(event)
+#endif
+
 extern void
 perf_event_header__init_id(struct perf_event_header *header,
 			   struct perf_sample_data *data,
-- 
2.40.1


