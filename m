Return-Path: <bpf+bounces-41967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278AD99DDE3
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 08:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFA2285650
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C9185920;
	Tue, 15 Oct 2024 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B8hyAb9S"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675816B75C;
	Tue, 15 Oct 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972118; cv=none; b=AVprnENSkGXIb+Jl7YGfzAfVkR0wYLwY3s/l4btxFK03b6C1uM8jycs3vgBFD67bTBbYsSNH2nPzY9F0vH+uDWwhfS3TXyG4L+OYGbOTk1N4TXYx1oqe8sKhiugXOFCEEQVN9c1iPt7d1HnkL/Hfy9h95ZT0GrZM8M486mjTf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972118; c=relaxed/simple;
	bh=KrWbdS94PufFPbY55NpG5muUz3WCsR7A2OJn/AbXUUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ENmaUnfLJqIm5k5uYyMAXdDGq1cA/9srVi/NYd1hY/Or4catouC341agDQckUIWUoc/EtStQCbQ98PmanENefvypRHoMf7WwWQ5co4lBchIGbWeoi7Gs/aLYDTRbtXshvsUELl9fSkBhm4sIjjYBFsoexEXuIo/IECWjY43hqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B8hyAb9S; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728972111; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0znhD1Yg3CYkj0go/qbgyRSHmUouwLj2A48RQR6Tvm8=;
	b=B8hyAb9S/Qm3W8YRqY9It27kDgFSym4h7Kldb7lVBtflQ/PCf0ZsXoYFtLTIKKwS0sI4zFVtyZxhqy96ToXcs2d7GKizNSFdMJPpHA2HmGRPn/VGf5qbpJZGKdFkFWNd6Gfi8NZ9U9Eg6m8Vl9MwngPFHqrsqzPSd5GwfLuDNWc=
Received: from localhost(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0WHCIOcG_1728972110 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 14:01:51 +0800
From: Ma Qiao <mqaio@linux.alibaba.com>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	namhyung.kim@lge.com,
	oleg@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] uprobe: avoid out-of-bounds memory access of fetching args
Date: Tue, 15 Oct 2024 14:01:48 +0800
Message-ID: <20241015060148.1108331-1-mqaio@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiao Ma <mqaio@linux.alibaba.com>

Uprobe needs to fetch args into a percpu buffer, and then copy to ring
buffer to avoid non-atomic context problem.

Sometimes user-space strings, arrays can be very large, but the size of
percpu buffer is only page size. And store_trace_args() won't check
whether these data exceeds a single page or not, caused out-of-bounds
memory access.

It could be reproduced by following steps:
1. build kernel with CONFIG_KASAN enabled
2. save follow program as test.c

```
\#include <stdio.h>
\#include <stdlib.h>
\#include <string.h>

// If string length large than MAX_STRING_SIZE, the fetch_store_strlen()
// will return 0, cause __get_data_size() return shorter size, and
// store_trace_args() will not trigger out-of-bounds access.
// So make string length less than 4096.
\#define STRLEN 4093

void generate_string(char *str, int n)
{
    int i;
    for (i = 0; i < n; ++i)
    {
        char c = i % 26 + 'a';
        str[i] = c;
    }
    str[n-1] = '\0';
}

void print_string(char *str)
{
    printf("%s\n", str);
}

int main()
{
    char tmp[STRLEN];

    generate_string(tmp, STRLEN);
    print_string(tmp);

    return 0;
}
```
3. compile program
`gcc -o test test.c`

4. get the offset of `print_string()`
```
objdump -t test | grep -w print_string
0000000000401199 g     F .text  000000000000001b              print_string
```

5. configure uprobe with offset 0x1199
```
off=0x1199

cd /sys/kernel/debug/tracing/
echo "p /root/test:${off} arg1=+0(%di):ustring arg2=\$comm arg3=+0(%di):ustring"
 > uprobe_events
echo 1 > events/uprobes/enable
echo 1 > tracing_on
```

6. run `test`, and kasan will report error.
==================================================================
BUG: KASAN: use-after-free in strncpy_from_user+0x1d6/0x1f0
Write of size 8 at addr ffff88812311c004 by task test/499CPU: 0 UID: 0 PID: 499 Comm: test Not tainted 6.12.0-rc3+ #18
Hardware name: Red Hat KVM, BIOS 1.16.0-4.al8 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x55/0x70
 print_address_description.constprop.0+0x27/0x310
 kasan_report+0x10f/0x120
 ? strncpy_from_user+0x1d6/0x1f0
 strncpy_from_user+0x1d6/0x1f0
 ? rmqueue.constprop.0+0x70d/0x2ad0
 process_fetch_insn+0xb26/0x1470
 ? __pfx_process_fetch_insn+0x10/0x10
 ? _raw_spin_lock+0x85/0xe0
 ? __pfx__raw_spin_lock+0x10/0x10
 ? __pte_offset_map+0x1f/0x2d0
 ? unwind_next_frame+0xc5f/0x1f80
 ? arch_stack_walk+0x68/0xf0
 ? is_bpf_text_address+0x23/0x30
 ? kernel_text_address.part.0+0xbb/0xd0
 ? __kernel_text_address+0x66/0xb0
 ? unwind_get_return_address+0x5e/0xa0
 ? __pfx_stack_trace_consume_entry+0x10/0x10
 ? arch_stack_walk+0xa2/0xf0
 ? _raw_spin_lock_irqsave+0x8b/0xf0
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? depot_alloc_stack+0x4c/0x1f0
 ? _raw_spin_unlock_irqrestore+0xe/0x30
 ? stack_depot_save_flags+0x35d/0x4f0
 ? kasan_save_stack+0x34/0x50
 ? kasan_save_stack+0x24/0x50
 ? mutex_lock+0x91/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 prepare_uprobe_buffer.part.0+0x2cd/0x500
 uprobe_dispatcher+0x2c3/0x6a0
 ? __pfx_uprobe_dispatcher+0x10/0x10
 ? __kasan_slab_alloc+0x4d/0x90
 handler_chain+0xdd/0x3e0
 handle_swbp+0x26e/0x3d0
 ? __pfx_handle_swbp+0x10/0x10
 ? uprobe_pre_sstep_notifier+0x151/0x1b0
 irqentry_exit_to_user_mode+0xe2/0x1b0
 asm_exc_int3+0x39/0x40
RIP: 0033:0x401199
Code: 01 c2 0f b6 45 fb 88 02 83 45 fc 01 8b 45 fc 3b 45 e4 7c b7 8b 45 e4 48 98 48 8d 50 ff 48 8b 45 e8 48 01 d0 ce
RSP: 002b:00007ffdf00576a8 EFLAGS: 00000206
RAX: 00007ffdf00576b0 RBX: 0000000000000000 RCX: 0000000000000ff2
RDX: 0000000000000ffc RSI: 0000000000000ffd RDI: 00007ffdf00576b0
RBP: 00007ffdf00586b0 R08: 00007feb2f9c0d20 R09: 00007feb2f9c0d20
R10: 0000000000000001 R11: 0000000000000202 R12: 0000000000401040
R13: 00007ffdf0058780 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

This commit enforces the buffer's maxlen less than a page-size to avoid
store_trace_args() out-of-memory access.

Fixes: dcad1a204f72 ("tracing/uprobes: Fetch args before reserving a ring buffer")
Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
---
 kernel/trace/trace_uprobe.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c40531d2cbadd..13f9270ed5ab4 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -875,6 +875,7 @@ struct uprobe_cpu_buffer {
 };
 static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
 static int uprobe_buffer_refcnt;
+#define MAX_UCB_BUFFER_SIZE PAGE_SIZE
 
 static int uprobe_buffer_init(void)
 {
@@ -979,6 +980,11 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
 	ucb = uprobe_buffer_get();
 	ucb->dsize = tu->tp.size + dsize;
 
+	if (WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)) {
+		ucb->dsize = MAX_UCB_BUFFER_SIZE;
+		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;
+	}
+
 	store_trace_args(ucb->buf, &tu->tp, regs, NULL, esize, dsize);
 
 	*ucbp = ucb;
@@ -998,9 +1004,6 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	WARN_ON(call != trace_file->event_call);
 
-	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
-		return;
-
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-- 
2.43.5


