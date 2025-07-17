Return-Path: <bpf+bounces-63554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5120B0836C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 05:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63FA16397C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 03:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F41F462C;
	Thu, 17 Jul 2025 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d6eI6dCD"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F21B4248;
	Thu, 17 Jul 2025 03:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752722962; cv=none; b=r5NaniuBpl0p7ubNe4CPvKxwM1m723SXRX2Oak2x+r7hAkW6GFevTM83eTwhsGQ+alybsEYMF0Y5TDJYmBfMJBFgTY62THxixEkULqpAGkLq/GLl2lQayN3raOVm6289ELnIh4Z2KFxJqbZfTVs5422iJJD7LsDa92/Qq1AmcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752722962; c=relaxed/simple;
	bh=z7X9KahpL9KLpBuE2Yl0f84xDfCkg84nlg5xmh8tl6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIi3xm95hNquNi6Pr/Y6aQk2MDvxYt2UgQ2Gv+SJ7+ylyJHdt2PF1NpaWS4W3uaXti4mgcUUxJnwBtTdV7j9GGephQKMi6B3psobgzbns9d8Yzd9Z2D/yk/fNeQ/gj33V1Yj831u1jNNNKxJ8iGX+j4bzH5PvKxtKbIyuwHzCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d6eI6dCD; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rc
	1LVsNKuf8womRfzkt5J5umHNIAJZcid8R1TPWN7LY=; b=d6eI6dCDPWjbEKQvZX
	oiEBl0d7Upuela/o+ZCqDUw7bBbvpQvCy2KQoOw/S3SeJqyF2je2qWwiu9FUZtv9
	pbjpOkNJB/yeymdeges02lVZlqrwr05PLotjn19mkpufzm85prtKcaJ98Yr41C2a
	fQ6UXrAghtTiytw0q/Pz+rqEM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3_4bdbXhoJsULFQ--.2953S3;
	Thu, 17 Jul 2025 11:28:32 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix macro redefined
Date: Thu, 17 Jul 2025 11:28:27 +0800
Message-Id: <20250717032828.500146-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717032828.500146-1-yangfeng59949@163.com>
References: <20250717032828.500146-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4bdbXhoJsULFQ--.2953S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1UGr4rtr1UCFy3GF13CFg_yoWrZr1kpr
	Z5C3WFyr4UXF48Ww1UJw4jvr1Y9w4ku3W5KrnFq34Fkw4Yqrs5XF1vkr1xZ3s3Kr4jg3sx
	XF43t390y3y8ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UprWwUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiYx+NeGh4aJOpngAAsV

From: Feng Yang <yangfeng@kylinos.cn>

When compiling a program that include <linux/bpf.h> and <bpf/bpf_helpers.h>, (For example: make samples/bpf)
the following warning will be generated:
In file included from tcp_dumpstats_kern.c:7:
samples/bpf/libbpf/include/bpf/bpf_helpers.h:321:9: warning: 'bpf_stream_printk' macro redefined [-Wmacro-redefined]
  321 | #define bpf_stream_printk(stream_id, fmt, args...)                              \
      |         ^
include/linux/bpf.h:3626:9: note: previous definition is here
 3626 | #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
      |         ^

The main reason is due to below in sample/bpf/Makefile:

$(obj)/%.o: $(src)/%.c
         @echo "  CLANG-bpf " $@
         $(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
                 -I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
                 -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
                 -D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
                 -D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
                 -Wno-gnu-variable-sized-type-not-at-end \
                 -Wno-address-of-packed-member -Wno-tautological-compare \
                 -Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
                 -fno-asynchronous-unwind-tables \
                 -I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
                 -O2 -emit-llvm -Xclang -disable-llvm-passes -c $< -o - | \
                 $(OPT) -O2 -mtriple=bpf-pc-linux | $(LLVM_DIS) | \
                 $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@

Here, some kernel data structure is needed for some particular architecture so
the initial from source to IR is compiled with native arch and after IR optimization
is done, it is switched to bpf.

So remove this line
   #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
and directly use bpf_stream_stage_printk(&ss, ...)

Fixes: 21a3afc76a31 ("libbpf: Add bpf_stream_printk() macro")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 include/linux/bpf.h     | 1 -
 kernel/bpf/core.c       | 2 +-
 kernel/bpf/rqspinlock.c | 8 ++++----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bc887831eaa5..d010a0c4e374 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3623,7 +3623,6 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 			    enum bpf_stream_id stream_id);
 int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 
-#define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
 #define bpf_stream_dump_stack(ss) bpf_stream_stage_dump_stack(&ss)
 
 #define bpf_stream_stage(ss, prog, stream_id, expr)            \
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 61613785bdd0..cc8e076f6d54 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3178,7 +3178,7 @@ static noinline void bpf_prog_report_may_goto_violation(void)
 	if (!prog)
 		return;
 	bpf_stream_stage(ss, prog, BPF_STDERR, ({
-		bpf_stream_printk(ss, "ERROR: Timeout detected for may_goto instruction\n");
+		bpf_stream_stage_printk(&ss, "ERROR: Timeout detected for may_goto instruction\n");
 		bpf_stream_dump_stack(ss);
 	}));
 #endif
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 5ab354d55d82..b176a6f9e431 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -676,11 +676,11 @@ static void bpf_prog_report_rqspinlock_violation(const char *str, void *lock, bo
 	if (!prog)
 		return;
 	bpf_stream_stage(ss, prog, BPF_STDERR, ({
-		bpf_stream_printk(ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
-		bpf_stream_printk(ss, "Attempted lock   = 0x%px\n", lock);
-		bpf_stream_printk(ss, "Total held locks = %d\n", rqh->cnt);
+		bpf_stream_stage_printk(&ss, "ERROR: %s for bpf_res_spin_lock%s\n", str, irqsave ? "_irqsave" : "");
+		bpf_stream_stage_printk(&ss, "Attempted lock   = 0x%px\n", lock);
+		bpf_stream_stage_printk(&ss, "Total held locks = %d\n", rqh->cnt);
 		for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
-			bpf_stream_printk(ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
+			bpf_stream_stage_printk(&ss, "Held lock[%2d] = 0x%px\n", i, rqh->locks[i]);
 		bpf_stream_dump_stack(ss);
 	}));
 }
-- 
2.43.0


