Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B25ECBD3
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2019 00:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKAXTB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Nov 2019 19:19:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:50472 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAXTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 19:19:01 -0400
Received: from 38.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.38] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iQgC1-0000T7-E6; Sat, 02 Nov 2019 00:18:57 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, andrii.nakryiko@gmail.com,
        john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v3 5/8] bpf: Switch BPF probe insns to bpf_probe_read_kernel
Date:   Sat,  2 Nov 2019 00:18:00 +0100
Message-Id: <d2b90827837685424a4b8008dfe0460558abfada.1572649915.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1572649915.git.daniel@iogearbox.net>
References: <cover.1572649915.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25620/Fri Nov  1 10:04:15 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 2a02759ef5f8 ("bpf: Add support for BTF pointers to interpreter")
explicitly states that the pointer to BTF object is a pointer to a kernel
object or NULL. Therefore we should also switch to using the strict kernel
probe helper which is restricted to kernel addresses only when architectures
have non-overlapping address spaces.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 673f5d40a93e..76452326fd8e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1309,11 +1309,12 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 __weak bpf_probe_read(void * dst, u32 size, const void * unsafe_ptr)
+u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
 {
 	memset(dst, 0, size);
 	return -EFAULT;
 }
+
 /**
  *	__bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -1569,9 +1570,9 @@ static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u6
 	LDST(W,  u32)
 	LDST(DW, u64)
 #undef LDST
-#define LDX_PROBE(SIZEOP, SIZE)						\
-	LDX_PROBE_MEM_##SIZEOP:						\
-		bpf_probe_read(&DST, SIZE, (const void *)(long) SRC);	\
+#define LDX_PROBE(SIZEOP, SIZE)							\
+	LDX_PROBE_MEM_##SIZEOP:							\
+		bpf_probe_read_kernel(&DST, SIZE, (const void *)(long) SRC);	\
 		CONT;
 	LDX_PROBE(B,  1)
 	LDX_PROBE(H,  2)
-- 
2.21.0

