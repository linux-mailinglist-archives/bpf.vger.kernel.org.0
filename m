Return-Path: <bpf+bounces-21601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB584EF95
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B371F2275D
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3218A5224;
	Fri,  9 Feb 2024 04:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVOG1qK+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E835667
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451647; cv=none; b=VPyaHoxqfu03R3VawlFRi8mTI6p6pgPd5It5+qbZiF5iXI92VOt8wUKZurFJTeS1SCoHlEzOCDa5SZfdVrapohGoNjNu5RruXGjy7tkYDbMuexps2fGcpMxyoRCNI7GPZkhetMc9SUt4bA9KbFSd0w/CxM3TMMIAy9CqJaHvn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451647; c=relaxed/simple;
	bh=YONaFYwtRZfCUHSPP/xLCZA0fjMcy/91+vEi9K1d3BI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvcWZ2fYgu1bqvmsd8CIFHMLDunhLh1rZzzClzwl4OI/0ESRNqPD1eT0NzCwrdPBpknQ6PjNmOZTeu4TAvhyR4iGtdpCus/cn6J/zY1uz/lodV30UqhVcBjdS54VcAzpvUrkAtJpgoh1o1rxVintyrDJOBPOd3252A/oW92cMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVOG1qK+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso440878b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451645; x=1708056445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cygxMwXpUKU81RFmqoqePBosJeNZ00y1PK/p5gN4GLo=;
        b=AVOG1qK+yXhZIH57PzV+AQ3ucpbxtsqbikR211PxUN/ipyyli9UFyF9M9hn4SfR1Qx
         AJqHpmnNlXrWMmdijUCluGUX+NHHYTnAk3oLSjO4FgcKvkVZZKCod6D15nCM278fQOnk
         mBLahtxFV/eY1S+j5hDLv7Er7G8UTizCRFkB/J20rz9KeGNbuayitlhhGUoIrA0NLfpk
         owTQu/frMwdiGpfZnEQWP3zyCqp03QD3bkBEsLS8MVdFxhPt4Lc/RGCmeEHp0DA68hXx
         mkFUiIEOVIi9qtFYnQg4RPSKMQ/zZgh5Q0ZbaxsTMmjnpw9Wv5UxVxZiDpfe+P5XSONw
         wCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451645; x=1708056445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cygxMwXpUKU81RFmqoqePBosJeNZ00y1PK/p5gN4GLo=;
        b=P/sUuGk7Qg06yylDuUf4H9pGnPOMHAfJEMAtQvbHjFa9Ly3EeM7EOS9ipRtBgTpvpp
         pnIV0KB/OiuuZ8JXX3VoRgDE48uAc2uHHYR2uPVfh6j15QpPXIhEa9PvWaONJ0M6lKSF
         AddtbZbp0Bvuaq4vnajs2YajsB+FvDDV8fcmj/LsYMJG51Q0/L8KJTh1WApiP6XyT+n7
         vKQ7RWa2Uu84lH/lhYOV3FlPOiVxnbHA+73kj5kTUpnVxKcgWslMe8nVjZTLXAsSUcNU
         dYGiEFPSUQJCBbhn9Dqgg5sj2AASdjcBiEfdvqWMlATgTPKRFK3eDRQRId2fXNJUIHnM
         eOhg==
X-Gm-Message-State: AOJu0Yw+zs4aL/QFu9nstTBd+1doevwPE4bl/QY0FzVczxs/FJ9gV0Gm
	FsDXZ+pGflu4EdOQakRMF4idtmIXxgyiPah88lgTqV9XuTyaqW12VTOcnTch
X-Google-Smtp-Source: AGHT+IHaHqKC2gjT6eMMFa5TCSDFBnv1yNEkB/syWL6KEWt6hbk/NU6aBcqi1y0pyAXerAeLHX9DIA==
X-Received: by 2002:a62:f901:0:b0:6da:bcea:4cd4 with SMTP id o1-20020a62f901000000b006dabcea4cd4mr650234pfh.16.1707451645004;
        Thu, 08 Feb 2024 20:07:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKa7AoYoSTpHf4QY1MuRhoeHy/otD5YbJxf7F1nq3Kf80HMJe7T0JPldiANHIWK0RPvaLH7ALpvryppvlFYP3mvzADeCO+6W0Df2OEfEyZCy1EthA0awtTR8laxGBdXgAA+oT4niKbJetncz2Fps4xueuExRoXrm/pX3Gcvt7rdxSEJ2rWTFSq+W25Wl3Drj8BYjUFe9Ck6okd8ulBbCOHQJIDRJ8dlA6f3o17pQoFudGpIsq00Zyk6sAn17YSRtSDazpAvv0earkDd4DsTwoFLj0GNPgNctSu+ObZYiRoMJJK+zmn/wkbO9+fovsxt3aeg00hIDWktHbfbs2uiBwomv1vCaKMYx0lfUcmtBHD7mvIUD0euQ==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7850e000000b006e0825acbc3sm590230pfn.77.2024.02.08.20.07.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 17/20] selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
Date: Thu,  8 Feb 2024 20:06:05 -0800
Message-Id: <20240209040608.98927-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add unit tests for bpf_arena_alloc/free_pages() functionality
and bpf_arena_common.h with a set of common helpers and macros that
is used in this test and the following patches.

Also modify test_loader that didn't support running bpf_prog_type_syscall
programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../testing/selftests/bpf/bpf_arena_common.h  | 70 ++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_arena.c      | 91 +++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  9 +-
 6 files changed, 172 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index 5c2cc7e8c5d0..8e70af386e52 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -11,3 +11,4 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
+verifier_arena                                   # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1a63996c0304..ded440277f6e 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -3,3 +3,4 @@
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
+verifier_arena                           # JIT does not support arena
diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
new file mode 100644
index 000000000000..07849d502f40
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+#ifndef WRITE_ONCE
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
+#endif
+
+#ifndef NUMA_NO_NODE
+#define	NUMA_NO_NODE	(-1)
+#endif
+
+#ifndef arena_container_of
+#define arena_container_of(ptr, type, member)			\
+	({							\
+		void __arena *__mptr = (void __arena *)(ptr);	\
+		((type *)(__mptr - offsetof(type, member)));	\
+	})
+#endif
+
+#ifdef __BPF__ /* when compiled as bpf program */
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE __PAGE_SIZE
+/*
+ * for older kernels try sizeof(struct genradix_node)
+ * or flexible:
+ * static inline long __bpf_page_size(void) {
+ *   return bpf_core_enum_value(enum page_size_enum___l, __PAGE_SIZE___l) ?: sizeof(struct genradix_node);
+ * }
+ * but generated code is not great.
+ */
+#endif
+
+#if defined(__BPF_FEATURE_ARENA_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#define __arena __attribute__((address_space(1)))
+#define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
+#define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
+#else
+#define __arena
+#define cast_kern(ptr) bpf_arena_cast(ptr, BPF_ARENA_CAST_KERN, 1)
+#define cast_user(ptr) bpf_arena_cast(ptr, BPF_ARENA_CAST_USER, 1)
+#endif
+
+void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
+				    int node_id, __u64 flags) __ksym __weak;
+void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
+
+#else /* when compiled as user space code */
+
+#define __arena
+#define __arg_arena
+#define cast_kern(ptr) /* nop for user space */
+#define cast_user(ptr) /* nop for user space */
+__weak char arena[1];
+
+#ifndef offsetof
+#define offsetof(type, member)  ((unsigned long)&((type *)0)->member)
+#endif
+
+static inline void __arena* bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt,
+						  int node_id, __u64 flags)
+{
+	return NULL;
+}
+static inline void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt)
+{
+}
+
+#endif
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 9c6072a19745..985273832f89 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -4,6 +4,7 @@
 
 #include "cap_helpers.h"
 #include "verifier_and.skel.h"
+#include "verifier_arena.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
@@ -118,6 +119,7 @@ static void run_tests_aux(const char *skel_name,
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
 void test_verifier_and(void)                  { RUN(verifier_and); }
+void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
new file mode 100644
index 000000000000..0e667132ef92
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 2); /* arena of two pages close to 32-bit boundary*/
+	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * 2 + 1)); /* start of mmap() region */
+} arena SEC(".maps");
+
+SEC("syscall")
+__success __retval(0)
+int basic_alloc1(void *ctx)
+{
+	volatile int __arena *page1, *page2, *no_page, *page3;
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	*page1 = 1;
+	page2 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page2)
+		return 2;
+	*page2 = 2;
+	no_page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (no_page)
+		return 3;
+	if (*page1 != 1)
+		return 4;
+	if (*page2 != 2)
+		return 5;
+	bpf_arena_free_pages(&arena, (void __arena *)page2, 1);
+	if (*page1 != 1)
+		return 6;
+	if (*page2 != 0) /* use-after-free should return 0 */
+		return 7;
+	page3 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page3)
+		return 8;
+	*page3 = 3;
+	if (page2 != page3)
+		return 9;
+	if (*page1 != 1)
+		return 10;
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int basic_alloc2(void *ctx)
+{
+	volatile char __arena *page1, *page2, *page3, *page4;
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	page2 = page1 + __PAGE_SIZE;
+	page3 = page1 + __PAGE_SIZE * 2;
+	page4 = page1 - __PAGE_SIZE;
+	*page1 = 1;
+	*page2 = 2;
+	*page3 = 3;
+	*page4 = 4;
+	if (*page1 != 1)
+		return 1;
+	if (*page2 != 2)
+		return 2;
+	if (*page3 != 0)
+		return 3;
+	if (*page4 != 0)
+		return 4;
+	bpf_arena_free_pages(&arena, (void __arena *)page1, 2);
+	if (*page1 != 0)
+		return 5;
+	if (*page2 != 0)
+		return 6;
+	if (*page3 != 0)
+		return 7;
+	if (*page4 != 0)
+		return 8;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index ba57601c2a4d..524c38e9cde4 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -501,7 +501,7 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
 	}
 }
 
-static int do_prog_test_run(int fd_prog, int *retval)
+static int do_prog_test_run(int fd_prog, int *retval, bool empty_opts)
 {
 	__u8 tmp_out[TEST_DATA_LEN << 2] = {};
 	__u8 tmp_in[TEST_DATA_LEN] = {};
@@ -514,6 +514,10 @@ static int do_prog_test_run(int fd_prog, int *retval)
 		.repeat = 1,
 	);
 
+	if (empty_opts) {
+		memset(&topts, 0, sizeof(struct bpf_test_run_opts));
+		topts.sz = sizeof(struct bpf_test_run_opts);
+	}
 	err = bpf_prog_test_run_opts(fd_prog, &topts);
 	saved_errno = errno;
 
@@ -649,7 +653,8 @@ void run_subtest(struct test_loader *tester,
 			}
 		}
 
-		do_prog_test_run(bpf_program__fd(tprog), &retval);
+		do_prog_test_run(bpf_program__fd(tprog), &retval,
+				 bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false);
 		if (retval != subspec->retval && subspec->retval != POINTER_VALUE) {
 			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
 			goto tobj_cleanup;
-- 
2.34.1


