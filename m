Return-Path: <bpf+bounces-44753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DF9C75B6
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF02B23A0B
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D8202653;
	Wed, 13 Nov 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dUN837Gt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D42022F0
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508086; cv=none; b=vEz4P9vFLkVpTCfooc4abKOWXUw4fOJeX4NF+chGu1DQ2VOBYTrrA1/uueQ6jecNILkp0i9PWMO8l74Y4mW8iQMe2zrupREDY2rkIuZ94L4ewF1W/iNLSALItJk/bsQ8FIriiJnIVG5WBgtcz1uQxGcm9zEEBtxTdHyXl5c9x9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508086; c=relaxed/simple;
	bh=e3tKvAENgT1t91Jk2QWLaDwnuAoEYVDBIwQYDspG3d8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kiyi/nkTekPfuXQVrLusU5pjTJluZhAuaxnk3m7vIGNOu2718AzxHBZwUwrhLy3yKgD9kXHYPp0qqznv+94TDBliV4ZzKoB/DsiCXmEb8GQSP1Uf6dZvwNLc4SlbkdLjeaxl2LMeccRPcad0X9fo8Qoehzv1H0EK5Gn4KQCGGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dUN837Gt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b152a23e9aso474999785a.0
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 06:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731508083; x=1732112883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEHbh/duNWJqgspUZhgQYf55G1Gom+pwpEcdzlYloE8=;
        b=dUN837GtgJ1JDKlkS1aIv5lpzvtAy9vPRbrlOPisGmBrgMBKR9TlmNlsP6lZ9kdi0P
         4JJ1DlLCj/4ivN42Dc5sbwX/omIjjRjk7lc0JRJW8ejRcD5akBmkeMhqYA2vWbop+G+Q
         NLr1WS5iRiSuTyS4ctzKT/p5lCUE80DXa6NF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508083; x=1732112883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEHbh/duNWJqgspUZhgQYf55G1Gom+pwpEcdzlYloE8=;
        b=ddulTiUscaLqWvzqqQX2UkQWrPL79cgIERcLKvq41tQLYkAansHWYdNjNpgHQBxTTK
         zlwOd3h8ayhsx3Ap45RT4RyQWSRxr7/HgXO4N6yJVWGsZi1sGKWn6CWpCks5UOi4iStj
         1teGFkngjgsGoqU55mMbHGkMstqfBl8TFc0RAE0SLpY6RiKjyk6+gHgZ41uAi6e/4mwu
         YyYmidAwDKsUXZomd84Y6ouOOkvSKiNi3Wt6I1fJ86iJp10M4iiL3KxSligLRQf/ZKmm
         DgDsRUN0L+L5cej6AlXDYuWxsGmLIxp+WcNXPoMPAfoRD6Y7JpzreDUXTB/EulsC00fI
         xSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmQIamq3Uj6rIUn/LjZUfKgmi6SpVhReRfpq0t8CtZ91ts5168RDP5DD7ivD9XXIl8nVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVWWz06X08sOWXp/cQHVzbDm3RJKGPcwIYh7/sZ7Rt00obho6
	XKRM3RksII1ETkn+UMj49MgQlc/ihc6c3zXQ4Ec/b8iazC0EDTQ1nFhlGB5lQw==
X-Google-Smtp-Source: AGHT+IGKsfb5qCjLVoyCtZSg3Na9acwl7ff97AOrrv2+jJxIw+mkA/tSW7GMk8T0IzM/qYZJ/Czvyg==
X-Received: by 2002:a05:6214:4990:b0:6cb:3c08:6a6a with SMTP id 6a1803df08f44-6d39e1ce9b1mr331094176d6.49.1731508083409;
        Wed, 13 Nov 2024 06:28:03 -0800 (PST)
Received: from vb004028-vm1.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961defe5sm85134976d6.10.2024.11.13.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:28:02 -0800 (PST)
From: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mqaio@linux.alibaba.com,
	namhyung.kim@lge.com,
	oleg@redhat.com,
	andrii@kernel.org,
	jolsa@kernel.org,
	sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Subject: [PATCH v6.1 2/2] uprobe: avoid out-of-bounds memory access of fetching args
Date: Wed, 13 Nov 2024 14:27:34 +0000
Message-Id: <20241113142734.2406886-3-vamsi-krishna.brahmajosyula@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20241113142734.2406886-1-vamsi-krishna.brahmajosyula@broadcom.com>
References: <20241113142734.2406886-1-vamsi-krishna.brahmajosyula@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiao Ma <mqaio@linux.alibaba.com>

[ Upstream commit 373b9338c9722a368925d83bc622c596896b328e ]

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

Link: https://lore.kernel.org/all/20241015060148.1108331-1-mqaio@linux.alibaba.com/

Fixes: dcad1a204f72 ("tracing/uprobes: Fetch args before reserving a ring buffer")
Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
---
 kernel/trace/trace_uprobe.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index e09eef65d32f..a6a3ff2a441e 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -862,6 +862,7 @@ struct uprobe_cpu_buffer {
 };
 static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
 static int uprobe_buffer_refcnt;
+#define MAX_UCB_BUFFER_SIZE PAGE_SIZE
 
 static int uprobe_buffer_init(void)
 {
@@ -960,6 +961,11 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
 	ucb = uprobe_buffer_get();
 	ucb->dsize = tu->tp.size + dsize;
 
+	if (WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)) {
+		ucb->dsize = MAX_UCB_BUFFER_SIZE;
+		dsize = MAX_UCB_BUFFER_SIZE - tu->tp.size;
+	}
+
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
 	return ucb;
@@ -978,9 +984,6 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	WARN_ON(call != trace_file->event_call);
 
-	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
-		return;
-
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
-- 
2.39.4


