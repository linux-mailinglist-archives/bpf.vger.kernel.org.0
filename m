Return-Path: <bpf+bounces-78138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F0BCFF8DA
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F03A332D8611
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6F395DBA;
	Wed,  7 Jan 2026 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcY5Dccl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDF38E114
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808190; cv=none; b=YBoFkUz+WUonl5NUwBDlI9HR6B8jqbGrAD9NaeYItTWVmMGz1kpR56cBV0z6966FFpz91dCcjU+lm/DqQAdkNmyvN/J/RsT2Q5OWdz30cz9brvo3wKZM91Dh4Ca08I7cbrZ4b60phZCQygdlmelha70AFJ70ggEyXityJ4BKCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808190; c=relaxed/simple;
	bh=X6UKRarJWRtPWspRzmJnourQ7yTXQI81RebA43t8ovI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWEemxCJlk49PIFrU5vj0+u8BMTsKGCrfzYO07xnfWFKsmp42ymKnPsHLwYyzbmovaserAtvHO4/GQ6Ps8qZi7M6EhYQ/iKRm6uRhrMGLww62w9wcFoERuG5JVHDXngQB3yv8rSOpqCmHcXFXYEEjplq5pPq+gcZzUQy+mOdQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcY5Dccl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc305882so1226162f8f.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808178; x=1768412978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noMW5oHSw7PXB3rdW7+IEoPFpWTJ36fd52j0eUwLZBo=;
        b=PcY5DcclmeGD22A0a/iVyXNB0B7BQsbxo2YRLSbp5Kn8aeJsCjIEwk5tZ4H6KLFXUO
         ebyc56GvixNESzVycCBj6edvVEqq/eu6au/T8FUA/A+vYi0lz2p5S96CFU/E1BpuoK7+
         AOXKYIL7iJAkTDkj7PyZRK8qdBR1xUAovqaheDPu+3oERY/XauFjykscPtC+2UsWogR1
         HEVJjCQMhGnTlOMal4u0BcZ0Y5li/Zb3l9YNYFSWby0GCgW0TZtdqV/dguvev4M998hw
         tRvGtTaMEQ3QHoaDob1tf3YoVPf3gC885NFjrUnfuYEsGZywOAGQo3brdlVqqNmUuHbB
         wtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808178; x=1768412978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=noMW5oHSw7PXB3rdW7+IEoPFpWTJ36fd52j0eUwLZBo=;
        b=w6z1W6oGbw5YuGvFT8d1ljjXOp/3RCuB3RGpUsdxnIRZ+MmsPR8CzZIpi6eCyppzaJ
         /GMIiW40WUyekkqbSge5lvWJhSERWC8hAwK/Rm5/s9xfQuA7naMSL+GD2xCuA2MiI1tj
         Dt19M7aS5dNjtxOJFNZSu0SkODQmASwxGvPk1X/Z99VHWbCTcnJczXLxoMvUaHCBk8X8
         1BgHs4AQNR+t8IT1tKWANtl3CI1pX9Jn4fcWZ5NX7x7peonGtzDYPy+ahk0IlsSb8zSa
         fkEaydk+YsSAz50Lq/kcI1InPBQPni+V6sRiTJlLQqTYqOJJh4h4xLvJAEpqtpASaSUv
         xx6Q==
X-Gm-Message-State: AOJu0Yy/VSoE2R3OG2ognr1s9fyzFYGRtNV8+RPtv9LDNFYigA70Q4Or
	N1cQatHhPejkkWYIRhsx86cQq73CcILul4eYC+HBBkV44IBBC/TJwj+r
X-Gm-Gg: AY/fxX4WqvtLZ2uuCCBt1L/9iGYVh2h/YUFvzCG96altgDs1k6Oa+NymU4dXM2BcWtK
	H9hDeujUcvYVm/V4jr81XfJ5Vjj/4rW40obLgPyJ6fx5/7cSkK+ukb6+ZSAV1xSO19O23B/XB6f
	ozx09iYdQ1+Sjz4deoO8kS2i0/s/qXrsfctA4J5sxvZQgd01gHOwn7PSixUnDuF6jBT94CjLI0O
	yZZaDEHbBzylw/B7yRgvFkT+xOFLOdr3AcZMn/zE02nat3KqG8u+iKHzip6uYfpXDeYpNXSh8Yf
	/i45Z2OrcoFvv5HUjYvBt5NP2Mv3cuwneu7lS77baNZwNTiQY12fjb/xG1Kf1iBiQatcdmiurgf
	+CtT162Z4DqP69uYKJNhVGER/1WsvSeXsp9g9zFO1xzJyRwbEdu6aqmM1shD6x9+slgaeJf659Z
	htZA==
X-Google-Smtp-Source: AGHT+IEz7qSfw5IFHqa1e5dM73SOBDU+E5IU2kKhHrYTfLSM7MrdBWiDPoABpgGJClE8v2rSkFWhnw==
X-Received: by 2002:a05:6000:40df:b0:431:9b2:61c0 with SMTP id ffacd0b85a97d-432c3632d11mr4385873f8f.24.1767808178405;
        Wed, 07 Jan 2026 09:49:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df96asm11403997f8f.28.2026.01.07.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:38 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:06 +0000
Subject: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async
 operations
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=8423;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=I4HvxoShB6kAfdk+Apv50HsoWDl/U2i6Ej465yC6jnc=;
 b=OJ5mvh8d1zZVjV0tPz+Ui8+sUf2slflGK6zZnG3+eugbZRlFm48Zc1UxomH/9TYb2WQfefN/t
 Mm/v4HhWDo2BkBvabfbIbruaGe15SUEYyNIYw4hPJpO1oowEPN+Qw4m
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce mpmc_cell, a lock-free cell primitive designed to support
concurrent writes to struct in NMI context (only one writer advances),
allowing readers to consume consistent snapshot.

Implementation details:
 Double buffering allows writers run concurrently with readers (read
 from one cell, write to another)

 The implementation uses a sequence-number-based protocol to enable
 exclusive writes.
  * Bit 0 of seq indicates an active writer
  * Bits 1+ form a generation counter
  * (seq & 2) >> 1 selects the read cell, write cell is opposite
  * Writers atomically set bit 0, write to the inactive cell, then
    increment seq to publish
  * Readers snapshot seq, read from the active cell, then validate
    that seq hasn't changed

mpmc_cell expects users to pre-allocate double buffers.

Key properties:
 * Writers never block (fail if lost the race to another writer)
 * Readers never block writers (double buffering), but may require
 retries if write updates the snapshot concurrently.

This will be used by BPF timer and workqueue helpers to defer NMI-unsafe
operations (like hrtimer_start()) to irq_work effectively allowing BPF
programs to initiate timers and workqueues from NMI context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/mpmc_cell.c |  62 +++++++++++++++++++++++++++
 kernel/bpf/mpmc_cell.h | 112 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 79cf22860a99ba31a9daf08a29de0f3a162ba89f..753fa63e0c24dc0a332d86c2c424894300f2d611 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o mpmc_cell.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/mpmc_cell.c b/kernel/bpf/mpmc_cell.c
new file mode 100644
index 0000000000000000000000000000000000000000..ca91b4308c8b552bc81cfefa2d975290a64b596d
--- /dev/null
+++ b/kernel/bpf/mpmc_cell.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include "mpmc_cell.h"
+
+static u32 read_cell_idx(struct bpf_mpmc_cell_ctl *ctl, u32 seq)
+{
+	return (seq & 2) >> 1;
+}
+
+void bpf_mpmc_cell_init(struct bpf_mpmc_cell_ctl *ctl, void *cell1, void *cell2)
+{
+	atomic_set(&ctl->seq, 0);
+	ctl->cell[0] = cell1;
+	ctl->cell[1] = cell2;
+}
+
+void *bpf_mpmc_cell_read_begin(struct bpf_mpmc_cell_ctl *ctl, u32 *seq)
+{
+	*seq = atomic_read_acquire(&ctl->seq);
+	/* Mask out acive writer bit */
+	*seq &= ~1;
+
+	return ctl->cell[read_cell_idx(ctl, *seq)];
+}
+
+int bpf_mpmc_cell_read_end(struct bpf_mpmc_cell_ctl *ctl, u32 seq)
+{
+	u32 new_seq;
+
+	/* Ensure cell reads complete before checking seq */
+	smp_rmb();
+
+	new_seq = atomic_read_acquire(&ctl->seq);
+	new_seq &= ~1; /* Ignore active write bit */
+	/* Check if seq changed between begin and end, if it did, new snapshot is available */
+	if (new_seq != seq)
+		return -EAGAIN;
+
+	return 0;
+}
+
+void *bpf_mpmc_cell_write_begin(struct bpf_mpmc_cell_ctl *ctl)
+{
+	u32 seq;
+
+	/*
+	 * Try to set the lowest bit, on success, writer owns cell exclusively,
+	 * other writers fail
+	 */
+	seq = atomic_fetch_or_acquire(1, &ctl->seq);
+	if (seq & 1) /* Check if another writer is active */
+		return NULL;
+
+	/* Write to opposite to read buffer */
+	return ctl->cell[read_cell_idx(ctl, seq) ^ 1];
+}
+
+void bpf_mpmc_cell_write_commit(struct bpf_mpmc_cell_ctl *ctl)
+{
+	atomic_fetch_add_release(1, &ctl->seq);
+}
diff --git a/kernel/bpf/mpmc_cell.h b/kernel/bpf/mpmc_cell.h
new file mode 100644
index 0000000000000000000000000000000000000000..8b57226927a6c51460fae3113b94d8631173da63
--- /dev/null
+++ b/kernel/bpf/mpmc_cell.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#ifndef __BPF_MPMC_CELL_H__
+#define __BPF_MPMC_CELL_H__
+#include <linux/smp.h>
+
+/**
+ * DOC: BPF MPMC Cell
+ *
+ * Multi-producer, multi-consumer lock-free double buffer.
+ * Designed for writers producing data in NMI context where locking is not possible.
+ *
+ * Writers never block or wait, but may fail (return NULL) if another writer is active
+ * (assume these writers are overridden)
+ * Readers never block writers. Readers may need to retry if a write
+ * completes during the read window (return -EAGAIN)
+ *
+ * User should provide two allocated cells.
+ *
+ * Typical usage:
+ *
+ *   // Writer (from NMI or any context):
+ *   cell = bpf_mpmc_cell_write_begin(ctl);
+ *   if (!IS_ERR(cell)) {
+ *       memcpy(cell, data, size);
+ *       bpf_mpmc_cell_write_commit(ctl);
+ *   }
+ *
+ *   // Reader (from irq_work or similar):
+ *   cell = bpf_mpmc_cell_read_begin(ctl, &seq);
+ *   memcpy(local, cell, size);
+ *   ret = bpf_mpmc_cell_read_end(ctl, seq);
+ *   if (ret == 0)
+ *       process(local);  // success, we own this snapshot
+ *   else if (ret == -EAGAIN)
+ *       retry;           // snapshot changed or lost race
+ */
+
+/**
+ * struct bpf_mpmc_cell_ctl - control structure for mpmc cell
+ * @seq: sequence number (odd = write active, seq/2 = generation)
+ * @cell: pointers to two allocated cells to support double buffering
+ *
+ */
+struct bpf_mpmc_cell_ctl {
+	atomic_t seq;
+	void *cell[2];
+};
+
+/**
+ * bpf_mpmc_cell_init() - initialize mpmc cell control structure
+ * @ctl: pointer to control structure to initialize
+ * @cell1: pointer to an allocated cell
+ * @cell2: pointer to another same sized cell
+ *
+ * Must be called before any read/write operations.
+ * Caller must allocate two same sized cells (buffers, structs) and pass
+ * them to this function, those two cells are used for double-buffering,
+ * supporting concurrent reads/writes: readers use one cell, writers another.
+ *
+ * Context: Any context.
+ * Return: void.
+ */
+void bpf_mpmc_cell_init(struct bpf_mpmc_cell_ctl *ctl, void *cell1, void *cell2);
+
+/**
+ * bpf_mpmc_cell_read_begin() - begin a read operation
+ * @ctl: pointer to control structure
+ * @seq: output parameter, sequence number for this read
+ *
+ * Returns: pointer to the current read cell. Caller must copy data
+ * out and then call bpf_mpmc_cell_read_end() to validate.
+ */
+void *bpf_mpmc_cell_read_begin(struct bpf_mpmc_cell_ctl *ctl, u32 *seq);
+
+/**
+ * bpf_mpmc_cell_read_end() - validate read operation.
+ * @ctl: pointer to control structure
+ * @seq: sequence number from matching bpf_mpmc_cell_read_begin()
+ *
+ * Validates that the snapshot read between bpf_mpmc_cell_read_begin()
+ * and bpf_mpmc_cell_read_end() is consistent.
+ *
+ * Return:
+ *   0        - success, snapshot is consistent
+ *   -EAGAIN  - snapshot invalidated (another writer completed)
+ */
+int bpf_mpmc_cell_read_end(struct bpf_mpmc_cell_ctl *ctl, u32 seq);
+
+/**
+ * bpf_mpmc_cell_write_begin() - begin a write operation
+ * @ctl: pointer to control structure
+ *
+ * Attempts to acquire exclusive writer access. Only one writer can be
+ * active at a time. On success, caller must write data and call
+ * bpf_mpmc_cell_write_commit(). There is no write abort mechanism.
+ *
+ * Return: Pointer to the write cell, or NULL if another writer is
+ * active.
+ */
+void *bpf_mpmc_cell_write_begin(struct bpf_mpmc_cell_ctl *ctl);
+
+/**
+ * bpf_mpmc_cell_write_commit() - complete a write operation
+ * @ctl: pointer to control structure
+ *
+ * Publishes the written data, making it visible to readers.
+ * Must be called after successful bpf_mpmc_cell_write_begin().
+ */
+void bpf_mpmc_cell_write_commit(struct bpf_mpmc_cell_ctl *ctl);
+
+#endif

-- 
2.52.0


