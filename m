Return-Path: <bpf+bounces-9834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E6D79DCB2
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543F52826A4
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2F01549A;
	Tue, 12 Sep 2023 23:32:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A51429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:26 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995D310FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52f33659d09so4426760a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561544; x=1695166344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOKs/u99SYf/gok0ubo7t7akZgu34vbpaZW0BR/hrbc=;
        b=k/mBncWHGbUtSjQJpt6vAynYbgfc0uATcE/Ydu/s/2hsWJoeqQYh9Yuha8beRk+KZy
         51mWAtxgVs3JNN0ujKOoLX+jvxyz4k63z2m1h4Y6zQF90ofgWM14+YTlDG2guk94wISh
         HwVlqIhTjZgpaAyRoQv6GvBoFM4HVae8RVUZRWVtwpsBnj/3cCfF2nxzw975i8a3llf4
         wJpdPnPbzcRH2wcRWq3zebZzF7N8yTLxfW2uKuut+IbfB6azWPJX+T3OcfMwFsDLNTVz
         oO6MBgvKjTf0INWv7QzAIUE/Wq0xUtMVXsuEM9eei5USApTA3LrsQQO/nWbDPL3fA3Q7
         4okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561544; x=1695166344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOKs/u99SYf/gok0ubo7t7akZgu34vbpaZW0BR/hrbc=;
        b=CKxDo9hS9PKPyfzdqUGy0x3L4vhaFHkydebqRsi3gNuv66ZVSe77plIRDqgJaTyAmo
         LOWGUkStnX7KJi1ADHH63+YxY4nZSU2NV/36t/di+HXipfz60HkTSxANdEBGaiRCHj/S
         stjQWUT0h4NKUk1q+tgrwkriMAdrK41Sx5eMkr9jn0YzQHDXgeRBSej+uFG9WlOiJdVZ
         F2TMUvSTZEE/VUKZwnZq3ehY9bva7DIUxHaZYwNDtHmb7kK/Z0TMy88c8TKTTgx9RuV2
         av/dc1GgiiwvYOH+whtxShVe9lILwMptk4+mUCkdoSpMx9TaPgXju9tkVVoEymhCve3c
         b/uA==
X-Gm-Message-State: AOJu0YxQzLD87zEcURXBJJfnDDppw6Mz6MN9WFZ2aqRkxtkUYk1jvOFt
	QUP/vGkk021i8SNA9blqXvlbFJJuw2vF4Q==
X-Google-Smtp-Source: AGHT+IFTZcKkft5IpTMVrOLD/YFt6SphpDuF6b+NplYeVeX3iNqU7pRvWUGW3PcrR0iszxAt5sRT4Q==
X-Received: by 2002:a17:906:3297:b0:9a5:ceab:f496 with SMTP id 23-20020a170906329700b009a5ceabf496mr564053ejw.58.1694561543914;
        Tue, 12 Sep 2023 16:32:23 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906349500b00997e00e78e6sm7510766ejb.112.2023.09.12.16.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 10/17] bpf: Prevent KASAN false positive with bpf_throw
Date: Wed, 13 Sep 2023 01:32:07 +0200
Message-ID: <20230912233214.1518551-11-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5518; i=memxor@gmail.com; h=from:subject; bh=bSTo5yopY85iWI1YQjw3VCUL+qF9FG7m7CyqMtVWf9A=; b=kA0DAAgBTODIhki/EcoByyZiAGUA9K2h1AjmTj9hZ5BtbUxeM9HGT0oVh+xlV2cjxSynmN6Ys IkCMwQAAQgAHRYhBEu+Kn4G7PnVgjxhEUzgyIZIvxHKBQJlAPStAAoJEEzgyIZIvxHKHbkQAIMw w0M3YXZDj0C7re3u7VJG6Zp/wUTDKS40jqziRNEz+VPHTrTIkTBFRIe37XdinVpNguqIfGRQuGy Dh/tCvs0gLDUAJvERqBBb+xtxw69uAAIZuhAIMCqqWliZbMdi6CKW+gSZhshGFjHVzJTgG2xBf2 8sYVoN91v4HT2h22glxylsh5w66v8R+QUNoOt5amClKI5yNKgNifmqkbOBS40vKhvbHDszpXUaW 1t1De/xEzfhGRxlzSOggaF9l4uTK4QOSlxkFncV8haFcgjHCVQoYHwZeS/XoGVFkiG70heYxvH0 LssxGbzfhqfDkb4YnJ3FrAbJhY+/MZzsqYSRGndhuTD5K18XbF4M3PT1tE0RQAR4DFT6g790r3+ LQ5WfO8v7CmrgR6kmXQalgjncOtEcpPl+e5MFohqvemkxICVHaOHZSsjSR1xMUkbw4opiQ8IQ9y b3XXIFEEqZk7dBks+bMV6JsD2XP2tyGPby8iDSKGPqGoVP7sf0N1F0kqSGL8Wb6UkVhwT5Cc5dO yEk2OkQoz1VBU5/LrQGAHBBChTf7IVbF2GmJ3Wcy6ahIzK48T89eaQOQn/wlhMYHll5P+H60ZA4 7Gt5/0YD534G36PhIBLqkSW3TXU9eN5XG5mjT8Fl7vj27QLkAlpTBZCFfJXXZ6qEERHHOES6Qdu Iu/oh
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The KASAN stack instrumentation when CONFIG_KASAN_STACK is true poisons
the stack of a function when it is entered and unpoisons it when
leaving. However, in the case of bpf_throw, we will never return as we
switch our stack frame to the BPF exception callback. Later, this
discrepancy will lead to confusing KASAN splats when kernel resumes
execution on return from the BPF program.

Fix this by unpoisoning everything below the stack pointer of the BPF
program, which should cover the range that would not be unpoisoned. An
example splat is below:

BUG: KASAN: stack-out-of-bounds in stack_trace_consume_entry+0x14e/0x170
Write of size 8 at addr ffffc900013af958 by task test_progs/227

CPU: 0 PID: 227 Comm: test_progs Not tainted 6.5.0-rc2-g43f1c6c9052a-dirty #26
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-2.fc39 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x4a/0x80
 print_report+0xcf/0x670
 ? arch_stack_walk+0x79/0x100
 kasan_report+0xda/0x110
 ? stack_trace_consume_entry+0x14e/0x170
 ? stack_trace_consume_entry+0x14e/0x170
 ? __pfx_stack_trace_consume_entry+0x10/0x10
 stack_trace_consume_entry+0x14e/0x170
 ? __sys_bpf+0xf2e/0x41b0
 arch_stack_walk+0x8b/0x100
 ? __sys_bpf+0xf2e/0x41b0
 ? bpf_prog_test_run_skb+0x341/0x1c70
 ? bpf_prog_test_run_skb+0x341/0x1c70
 stack_trace_save+0x9b/0xd0
 ? __pfx_stack_trace_save+0x10/0x10
 ? __kasan_slab_free+0x109/0x180
 ? bpf_prog_test_run_skb+0x341/0x1c70
 ? __sys_bpf+0xf2e/0x41b0
 ? __x64_sys_bpf+0x78/0xc0
 ? do_syscall_64+0x3c/0x90
 ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
 kasan_save_stack+0x33/0x60
 ? kasan_save_stack+0x33/0x60
 ? kasan_set_track+0x25/0x30
 ? kasan_save_free_info+0x2b/0x50
 ? __kasan_slab_free+0x109/0x180
 ? kmem_cache_free+0x191/0x460
 ? bpf_prog_test_run_skb+0x341/0x1c70
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2b/0x50
 __kasan_slab_free+0x109/0x180
 kmem_cache_free+0x191/0x460
 bpf_prog_test_run_skb+0x341/0x1c70
 ? __pfx_bpf_prog_test_run_skb+0x10/0x10
 ? __fget_light+0x51/0x220
 __sys_bpf+0xf2e/0x41b0
 ? __might_fault+0xa2/0x170
 ? __pfx___sys_bpf+0x10/0x10
 ? lock_release+0x1de/0x620
 ? __might_fault+0xcd/0x170
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_blkcg_maybe_throttle_current+0x10/0x10
 __x64_sys_bpf+0x78/0xc0
 ? syscall_enter_from_user_mode+0x20/0x50
 do_syscall_64+0x3c/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7f0fbb38880d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d
89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f3 45 12 00 f7 d8 64
89 01 48
RSP: 002b:00007ffe13907de8 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffe13908708 RCX: 00007f0fbb38880d
RDX: 0000000000000050 RSI: 00007ffe13907e20 RDI: 000000000000000a
RBP: 00007ffe13907e00 R08: 0000000000000000 R09: 00007ffe13907e20
R10: 0000000000000064 R11: 0000000000000206 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f0fbb532000 R15: 0000000000cfbd90
 </TASK>

The buggy address belongs to stack of task test_progs/227
KASAN internal error: frame info validation failed; invalid marker: 0

The buggy address belongs to the virtual mapping at
 [ffffc900013a8000, ffffc900013b1000) created by:
 kernel_clone+0xcd/0x600

The buggy address belongs to the physical page:
page:00000000b70f4332 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11418f
flags: 0x2fffe0000000000(node=0|zone=2|lastcpupid=0x7fff)
page_type: 0xffffffff()
raw: 02fffe0000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffc900013af800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900013af880: 00 00 00 f1 f1 f1 f1 00 00 00 f3 f3 f3 f3 f3 00
>ffffc900013af900: 00 00 00 00 00 00 00 00 00 00 00 f1 00 00 00 00
                                                    ^
 ffffc900013af980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900013afa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
Disabling lock debugging due to kernel taint

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 78e8f4de6750..2c8e1ee97b71 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
+#include <linux/kasan.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -2483,6 +2484,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 		WARN_ON_ONCE(!ctx.aux->exception_boundary);
 	WARN_ON_ONCE(!ctx.bp);
 	WARN_ON_ONCE(!ctx.cnt);
+	/* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
+	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
+	 * which skips compiler generated instrumentation to do the same.
+	 */
+	kasan_unpoison_task_stack_below((void *)ctx.sp);
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
 }
 
-- 
2.41.0


