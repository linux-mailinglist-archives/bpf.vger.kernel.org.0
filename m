Return-Path: <bpf+bounces-7341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B70775E09
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814531C21149
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1EE17FE7;
	Wed,  9 Aug 2023 11:43:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16B17744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:43:24 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889EF10C0
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:43:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99bf1f632b8so996315666b.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581399; x=1692186199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axxrwc04eHcvGTpC0q/DJGjJwM+C0owU3pNAm66KQhk=;
        b=WyDBZQMcWKnJ1XVLqTQfo6l59lCmeBQL4xd0mXI7J3hSQX393X6ximAKe/J6I/EtB2
         UIuXYUYLpm4pkShdENh7ms+Db5eyj1yOssiMbcfveDHWXqUhcoixr7cGMqOZUBfSC9Vf
         2HYVXYYWEjvI5ndlcQM4zYgtLt6OlVzqVJAimUYK6GVrboQ1UJICw7dMJGQWPfGkEzW+
         xjx7VIL3Q+Pa+rcrAvACd8MbF5ZkDjnKorc2CqTL44lqhxhoAA1Ka89oBdvTevtw8AKg
         H5s6eO13vexGKAcpf7e2cqWZpbxWMLEbG9caFf1jbqMuyTKJQfULtWpF38yBP2LPSg/y
         YyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581399; x=1692186199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axxrwc04eHcvGTpC0q/DJGjJwM+C0owU3pNAm66KQhk=;
        b=POiYb/9Iyr71WrgGimZe9ZKdG9KPmleNIE3SIV5GI2gJvwRUfC90dVizSc5oZB5V5K
         Rc1ERviROxz3K96VXZr9iGVQSH24NCLNo0nLRht+GUVzc+OH0o6yCtnSlbHN5JqwPjAZ
         UF112GRsdcMKjqcu50LO6vW6W+O1KnFER10GBBQA6056x0Y+iomrAGGoKQX5LnvB5+/w
         K1/ZnEVIywRgIM5MlQjNcDH5JrVqRRaJYCn1HVIZ9QbxZ+1kgsPqBEFPZVazP09QCshH
         G0ZQDkbv6t+Z4EPbQE0g6SEq3xbwdF3qsgDEF27xWQRhvkHKRCWmmHaAd8u6ExkDJdeo
         y79g==
X-Gm-Message-State: AOJu0YwFuO6pKFOdiaeUROpO4zX67Z3wvMQ9FD1xi813iWemWgPunrOK
	txzRZL6xT2lnJQkouosAD6yOEL6JjgFJ3TEMu1g=
X-Google-Smtp-Source: AGHT+IHC21KiuUPuPvpbaEXhWuzm4AG60VyrA7gFE9yRWY4PDfkO7n3NkWAPLbu3T64nZ7SLQ/iKDg==
X-Received: by 2002:a17:907:75d4:b0:99c:3bb:fd96 with SMTP id jl20-20020a17090775d400b0099c03bbfd96mr1851965ejc.52.1691581399386;
        Wed, 09 Aug 2023 04:43:19 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709067b8c00b00992b50fbbe9sm7949863ejo.90.2023.08.09.04.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:43:18 -0700 (PDT)
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
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 08/14] bpf: Prevent KASAN false positive with bpf_throw
Date: Wed,  9 Aug 2023 17:11:10 +0530
Message-ID: <20230809114116.3216687-9-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6190; i=memxor@gmail.com; h=from:subject; bh=NaiGOoo5s//gcTZipLf7STpGdrTi5Ez9y9d5703fRv8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJl1+9xnrE15CRT3c8NliD+b9w1U/HQ4d5x qPUEY1CbgaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R yguiEAC3d/ji8X+7OnXnWnBTWy9VcaoC7qV4VcDrOkAoiPQJPdnpHC7syFcivsm41QCGQddg1r/ 4Ra2s42KjFBVlrwiJ1jktHK/6YNb76jc5Nw2TcWYEZfqSHsQ+1P2ib/I3dU8Ancr3hE6guo4IMd b+G+1b06EG6AYbdD4ryEfPjgFQPJn94AmMnN7UZjASvJjwsrQvMeMZCV/MjLVOOjMF1U4CIZbnz y1qqHxl1jlT81f98lrugK36sdUbrCkquwZKNIpm8XfRKdC21MwypzG6D/eHR31criP89YA3CIOZ ZdkJthaspTeSYpmVoHMFDZZCMyf4RW4/dCZT5ZrsqOo8Gxsfeh4shm7PYix50GjTm2k3djBFHwF TK5bcpmD1FagCqRTzUMf2hUGPlS2+IS4shoy5r2hEOvEaB9K0sYdHTCQW7SPPOs+5S3dxMPd1ck 7Zpoq721TNpbbA+ccdOuBT9mb9dU3B39EZyYmthhBd5rlYOhXtEMNGdo2g82pyY98pHG1ntU1oD dxNZyyUPiLh/emM9+QldWkCjzy8hPr4aJn1AkNMgcbeA83hNsHpKwLe06HqeiUHujlQ9QkRnLB5 PnVGBKf4zx85seXeMBtAEh/X6ILp5T6ISuVmhe9fzjcdqRDA4h7qOvl5OpGYCfWLaBYdLYCfF5c +47L+z7OCC/LbZQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 include/linux/kasan.h | 2 ++
 kernel/bpf/helpers.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 819b6bc8ac08..7a463f814db2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -283,8 +283,10 @@ static inline bool kasan_check_byte(const void *address)
 
 #if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
 void kasan_unpoison_task_stack(struct task_struct *task);
+asmlinkage void kasan_unpoison_task_stack_below(const void *watermark);
 #else
 static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
+static inline void kasan_unpoison_task_stack_below(const void *watermark) {}
 #endif
 
 #ifdef CONFIG_KASAN_GENERIC
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index af4add1e3a31..64a07232c58f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
+#include <linux/kasan.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -2463,6 +2464,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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


