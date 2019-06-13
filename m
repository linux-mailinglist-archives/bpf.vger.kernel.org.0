Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAEE439B2
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfFMPPe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 11:15:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38598 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbfFMNZQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 09:25:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so20780568wrs.5
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2019 06:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/XDzYueXffv1rUyJx1oEFA1jQkKQnEoAqI3KBmpQNQ=;
        b=keerC7oubO4xWDPqVdCuDXHlcwDp1ZGxBs6OtO0Jg9F0rB7opUoNZfaXAywrlZu5nM
         I+zPjctobOUMBWt7rFEArKp/IUuJNRdB1ulWSYXLeVdokX5WmkPYMWrbdMbkyTKUHevZ
         7GdZskEhnLXcF6vcGs9LuGOSp+WrsAhmO4RsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H/XDzYueXffv1rUyJx1oEFA1jQkKQnEoAqI3KBmpQNQ=;
        b=RWq7vz5eL2sKE/2RGUHLsN8k92nGu7U6i4ujOOn/LSMxHnQ1O8YlFJ0xXRLVkyEKkT
         7ZY25DC0hXtsyY9MjxzNvBWPGLqUwNxto8KWyMJMLB4JeFYglecu86ZdDcK00K1+Mj5U
         Y7qkn1p0fA7wqRqRVsxcffXphTLPgVHVr91l2cZxE4p6Wtna09udbfJvRAAk4qNN7xp4
         vDrU/9sMoxI1dOaGqSNEc08DHsQxwJ1nWs7bXTm+Xlfbi2pgm183kG+fmumO1AJJDAOa
         8i+VlVxf1YWTlyIvSRde8BY1R6w3NgVwwxHeauRZunA+f2CRAtBLPV0igtxvt/bqZ0rB
         6M/Q==
X-Gm-Message-State: APjAAAULOV1qyq9dmqmnjp7CfBg6NHo/kp39C6YxF5WXc9II0piegK/m
        wY1nkWRM5qbZcq2NwWfMyC3AVw==
X-Google-Smtp-Source: APXvYqwDEPlruy2eVqw9ZQATbv3Dsj0ZxtvE79jIaKuGvWhxiukBuyyX3IRiItW0qa3pl3HgnhuzQA==
X-Received: by 2002:adf:c5c1:: with SMTP id v1mr41961383wrg.129.1560432313294;
        Thu, 13 Jun 2019 06:25:13 -0700 (PDT)
Received: from localhost.localdomain ([147.12.216.9])
        by smtp.gmail.com with ESMTPSA id d10sm3324109wrp.74.2019.06.13.06.25.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:25:12 -0700 (PDT)
From:   Arthur Fabre <afabre@cloudflare.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH bpf-next] bpf: sk_storage: Fix out of bounds memory access
Date:   Thu, 13 Jun 2019 14:24:34 +0100
Message-Id: <20190613132433.17213-1-afabre@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_sk_storage maps use multiple spin locks to reduce contention.
The number of locks to use is determined by the number of possible CPUs.
With only 1 possible CPU, bucket_log == 0, and 2^0 = 1 locks are used.

When updating elements, the correct lock is determined with hash_ptr().
Calling hash_ptr() with 0 bits is undefined behavior, as it does:

x >> (64 - bits)

Using the value results in an out of bounds memory access.
In my case, this manifested itself as a page fault when raw_spin_lock_bh()
is called later, when running the self tests:

./tools/testing/selftests/bpf/test_verifier 773 775

[   16.366342] BUG: unable to handle page fault for address: ffff8fe7a66f93f8
[   16.367139] #PF: supervisor write access in kernel mode
[   16.367751] #PF: error_code(0x0002) - not-present page
[   16.368323] PGD 35a01067 P4D 35a01067 PUD 0
[   16.368796] Oops: 0002 [#1] SMP PTI
[   16.369175] CPU: 0 PID: 189 Comm: test_verifier Not tainted 5.2.0-rc2+ #10
[   16.369960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   16.371021] RIP: 0010:_raw_spin_lock_bh (/home/afabre/linux/./include/trace/events/initcall.h:48)
[ 16.371571] Code: 02 00 00 31 c0 ba ff 00 00 00 3e 0f b1 17 75 01 c3 e9 82 12 5f ff 66 90 65 81 05 ad 14 6f 41 00 02 00 00 31 c0 ba 01 00 00 00 <3e> 0f b1 17 75 01 c3 89 c6 e9 f0 02 5f ff b8 00 02 00 00 3e 0f c1
All code
========
   0:	02 00                	add    (%rax),%al
   2:	00 31                	add    %dh,(%rcx)
   4:	c0 ba ff 00 00 00 3e 	sarb   $0x3e,0xff(%rdx)
   b:	0f b1 17             	cmpxchg %edx,(%rdi)
   e:	75 01                	jne    0x11
  10:	c3                   	retq
  11:	e9 82 12 5f ff       	jmpq   0xffffffffff5f1298
  16:	66 90                	xchg   %ax,%ax
  18:	65 81 05 ad 14 6f 41 	addl   $0x200,%gs:0x416f14ad(%rip)        # 0x416f14d0
  1f:	00 02 00 00
  23:	31 c0                	xor    %eax,%eax
  25:	ba 01 00 00 00       	mov    $0x1,%edx
  2a:	3e 0f b1 17          	cmpxchg %edx,%ds:*(%rdi)		<-- trapping instruction
  2e:	75 01                	jne    0x31
  30:	c3                   	retq
  31:	89 c6                	mov    %eax,%esi
  33:	e9 f0 02 5f ff       	jmpq   0xffffffffff5f0328
  38:	b8 00 02 00 00       	mov    $0x200,%eax
  3d:	3e                   	ds
  3e:	0f                   	.byte 0xf
  3f:	c1                   	.byte 0xc1

Code starting with the faulting instruction
===========================================
   0:	3e 0f b1 17          	cmpxchg %edx,%ds:(%rdi)
   4:	75 01                	jne    0x7
   6:	c3                   	retq
   7:	89 c6                	mov    %eax,%esi
   9:	e9 f0 02 5f ff       	jmpq   0xffffffffff5f02fe
   e:	b8 00 02 00 00       	mov    $0x200,%eax
  13:	3e                   	ds
  14:	0f                   	.byte 0xf
  15:	c1                   	.byte 0xc1
[   16.373398] RSP: 0018:ffffa759809d3be0 EFLAGS: 00010246
[   16.373954] RAX: 0000000000000000 RBX: ffff8fe7a66f93f0 RCX: 0000000000000040
[   16.374645] RDX: 0000000000000001 RSI: ffff8fdaf9f0d180 RDI: ffff8fe7a66f93f8
[   16.375338] RBP: ffff8fdaf9f0d180 R08: ffff8fdafba2c320 R09: ffff8fdaf9f0d0c0
[   16.376028] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8fdafa346700
[   16.376719] R13: ffff8fe7a66f93f8 R14: ffff8fdaf9f0d0c0 R15: 0000000000000001
[   16.377413] FS:  00007fda724c0740(0000) GS:ffff8fdafba00000(0000) knlGS:0000000000000000
[   16.378204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.378763] CR2: ffff8fe7a66f93f8 CR3: 0000000139d1c006 CR4: 0000000000360ef0
[   16.379453] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.380144] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.380864] Call Trace:
[   16.381112] selem_link_map (/home/afabre/linux/./include/linux/compiler.h:221 /home/afabre/linux/net/core/bpf_sk_storage.c:243)
[   16.381476] sk_storage_update (/home/afabre/linux/net/core/bpf_sk_storage.c:355 /home/afabre/linux/net/core/bpf_sk_storage.c:414)
[   16.381888] bpf_sk_storage_get (/home/afabre/linux/net/core/bpf_sk_storage.c:760 /home/afabre/linux/net/core/bpf_sk_storage.c:741)
[   16.382285] ___bpf_prog_run (/home/afabre/linux/kernel/bpf/core.c:1447)
[   16.382679] ? __bpf_prog_run32 (/home/afabre/linux/kernel/bpf/core.c:1603)
[   16.383074] ? alloc_file_pseudo (/home/afabre/linux/fs/file_table.c:232)
[   16.383486] ? kvm_clock_get_cycles (/home/afabre/linux/arch/x86/kernel/kvmclock.c:98)
[   16.383906] ? ktime_get (/home/afabre/linux/kernel/time/timekeeping.c:265 /home/afabre/linux/kernel/time/timekeeping.c:369 /home/afabre/linux/kernel/time/timekeeping.c:754)
[   16.384243] ? bpf_test_run (/home/afabre/linux/net/bpf/test_run.c:47)
[   16.384613] ? bpf_prog_test_run_skb (/home/afabre/linux/net/bpf/test_run.c:313)
[   16.385065] ? security_capable (/home/afabre/linux/security/security.c:696 (discriminator 19))
[   16.385460] ? __do_sys_bpf (/home/afabre/linux/kernel/bpf/syscall.c:2072 /home/afabre/linux/kernel/bpf/syscall.c:2848)
[   16.385854] ? __handle_mm_fault (/home/afabre/linux/mm/memory.c:3507 /home/afabre/linux/mm/memory.c:3532 /home/afabre/linux/mm/memory.c:3666 /home/afabre/linux/mm/memory.c:3897 /home/afabre/linux/mm/memory.c:4021)
[   16.386273] ? __dentry_kill (/home/afabre/linux/fs/dcache.c:595)
[   16.386652] ? do_syscall_64 (/home/afabre/linux/arch/x86/entry/common.c:301)
[   16.387031] ? entry_SYSCALL_64_after_hwframe (/home/afabre/linux/./include/trace/events/initcall.h:10 /home/afabre/linux/./include/trace/events/initcall.h:10)
[   16.387541] Modules linked in:
[   16.387846] CR2: ffff8fe7a66f93f8
[   16.388175] ---[ end trace 891cf27b5b9c9cc6 ]---
[   16.388628] RIP: 0010:_raw_spin_lock_bh (/home/afabre/linux/./include/trace/events/initcall.h:48)
[ 16.389089] Code: 02 00 00 31 c0 ba ff 00 00 00 3e 0f b1 17 75 01 c3 e9 82 12 5f ff 66 90 65 81 05 ad 14 6f 41 00 02 00 00 31 c0 ba 01 00 00 00 <3e> 0f b1 17 75 01 c3 89 c6 e9 f0 02 5f ff b8 00 02 00 00 3e 0f c1
All code
========
   0:	02 00                	add    (%rax),%al
   2:	00 31                	add    %dh,(%rcx)
   4:	c0 ba ff 00 00 00 3e 	sarb   $0x3e,0xff(%rdx)
   b:	0f b1 17             	cmpxchg %edx,(%rdi)
   e:	75 01                	jne    0x11
  10:	c3                   	retq
  11:	e9 82 12 5f ff       	jmpq   0xffffffffff5f1298
  16:	66 90                	xchg   %ax,%ax
  18:	65 81 05 ad 14 6f 41 	addl   $0x200,%gs:0x416f14ad(%rip)        # 0x416f14d0
  1f:	00 02 00 00
  23:	31 c0                	xor    %eax,%eax
  25:	ba 01 00 00 00       	mov    $0x1,%edx
  2a:	3e 0f b1 17          	cmpxchg %edx,%ds:*(%rdi)		<-- trapping instruction
  2e:	75 01                	jne    0x31
  30:	c3                   	retq
  31:	89 c6                	mov    %eax,%esi
  33:	e9 f0 02 5f ff       	jmpq   0xffffffffff5f0328
  38:	b8 00 02 00 00       	mov    $0x200,%eax
  3d:	3e                   	ds
  3e:	0f                   	.byte 0xf
  3f:	c1                   	.byte 0xc1

Code starting with the faulting instruction
===========================================
   0:	3e 0f b1 17          	cmpxchg %edx,%ds:(%rdi)
   4:	75 01                	jne    0x7
   6:	c3                   	retq
   7:	89 c6                	mov    %eax,%esi
   9:	e9 f0 02 5f ff       	jmpq   0xffffffffff5f02fe
   e:	b8 00 02 00 00       	mov    $0x200,%eax
  13:	3e                   	ds
  14:	0f                   	.byte 0xf
  15:	c1                   	.byte 0xc1
[   16.390899] RSP: 0018:ffffa759809d3be0 EFLAGS: 00010246
[   16.391410] RAX: 0000000000000000 RBX: ffff8fe7a66f93f0 RCX: 0000000000000040
[   16.392102] RDX: 0000000000000001 RSI: ffff8fdaf9f0d180 RDI: ffff8fe7a66f93f8
[   16.392795] RBP: ffff8fdaf9f0d180 R08: ffff8fdafba2c320 R09: ffff8fdaf9f0d0c0
[   16.393481] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8fdafa346700
[   16.394169] R13: ffff8fe7a66f93f8 R14: ffff8fdaf9f0d0c0 R15: 0000000000000001
[   16.394870] FS:  00007fda724c0740(0000) GS:ffff8fdafba00000(0000) knlGS:0000000000000000
[   16.395641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.396193] CR2: ffff8fe7a66f93f8 CR3: 0000000139d1c006 CR4: 0000000000360ef0
[   16.396876] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   16.397557] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   16.398246] Kernel panic - not syncing: Fatal exception in interrupt
[   16.399067] Kernel Offset: 0x3ce00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   16.400098] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
Fixes: 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
---
 net/core/bpf_sk_storage.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f40e3d35fd9c..7ae0686c5418 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -90,7 +90,13 @@ struct bpf_sk_storage {
 static struct bucket *select_bucket(struct bpf_sk_storage_map *smap,
 				    struct bpf_sk_storage_elem *selem)
 {
-	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+	/* hash_ptr is undefined behavior with 0 bits */
+	int bucket = 0;
+	if (smap->bucket_log != 0) {
+		bucket = hash_ptr(selem, smap->bucket_log);
+	}
+
+	return &smap->buckets[bucket];
 }
 
 static int omem_charge(struct sock *sk, unsigned int size)
-- 
2.20.1

