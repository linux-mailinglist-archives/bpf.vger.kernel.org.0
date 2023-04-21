Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF66EB0F3
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjDURnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjDURn3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA72C154
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so18122165e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098989; x=1684690989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w64twY6JmweTxsVIF9KCXcjlFOp00D9p7KpnzHlj5Jk=;
        b=CBRH/F7FlDbjCkwIh4R09CaROBk41eTGhQjumR/Qj/tRCebORz9fZl4KZ3iZKgKPR7
         G4YjXLcGxuWcjbjebNaIvKFT93q8lJaPqN3HwIs6A/zJWEo40rtkn31Jn4IYEIvLw3iR
         QoPlngEe5JMDfsX+4cSysaeo494BwTFL5ISVNg+aEmnYwuHm+akJCnqjKqDvKxSm+lio
         uupsCcZcQAE+xrF76MOt9tLdj8mYM9jvdxkGGlO8FGlZFwuzYtzB/t0t34LoRjYZYi0M
         jYsJtJirsi5F7SnxJmgI/yvKqsHBLUt7RLK5J4cplsOPHrHDTynKxZMbowUHq4O0UrsR
         Rzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098989; x=1684690989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w64twY6JmweTxsVIF9KCXcjlFOp00D9p7KpnzHlj5Jk=;
        b=D2SfgOmJoKT661UoNcP1uAm+UijkapDRwt2vwEyS+7qsXKA5+hswg/WlgwBUiBTWOX
         mclhhKzxuJyYuuVvsiZxfj6+TxmnU4+ryHEFwc+ydksZBJn2Md3fsGGQD+wuJoQyECoN
         8RUQQ86P88xUNlrABKWDLGZ8Aa9fp+sWa3zj67koLFx6BWzsxglOF4Koo6nTbke4IEGW
         2sVjV0uX/PtddzXPL2G+UBvpT1URBSFll+IpKCmvvwM9poez+r+D2HSj0ay2iv8WRG3O
         CBbhb+WH+HW64nrGjNyDq931DyB7KG5aL0TzIFeNUE5mOCb3mcd1j7iVNrrWeestUqnc
         i5lA==
X-Gm-Message-State: AAQBX9esXaeXllO4riE8T8V23sGortC7UrNApSnWkOKC9j6nDJCTC/0I
        JGSBMiySApNkANoHETYLzPc164bJ+Rom6Q==
X-Google-Smtp-Source: AKy350ayp/QJc3h1+Kl0OJ4NM0fLCgXilZHbp/wK0su5xRpjBWtgN1hJEXIc/VAnsN66GyUXbM7ZFQ==
X-Received: by 2002:adf:eb11:0:b0:2ff:70c0:9a05 with SMTP id s17-20020adfeb11000000b002ff70c09a05mr6319174wrn.4.1682098988913;
        Fri, 21 Apr 2023 10:43:08 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:08 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 20/24] selftests/bpf: verifier/spin_lock converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:30 +0300
Message-Id: <20230421174234.2391278-21-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/spin_lock automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_spin_lock.c  | 533 ++++++++++++++++++
 .../selftests/bpf/verifier/spin_lock.c        | 447 ---------------
 3 files changed, 535 insertions(+), 447 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_spin_lock.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/spin_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 60bcff62d968..0ea88282859d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -52,6 +52,7 @@
 #include "verifier_search_pruning.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_spill_fill.skel.h"
+#include "verifier_spin_lock.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_uninit.skel.h"
 #include "verifier_value_adj_spill.skel.h"
@@ -144,6 +145,7 @@ void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
+void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_spill); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
new file mode 100644
index 000000000000..9c1aa69650f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/spin_lock.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct val {
+	int cnt;
+	struct bpf_spin_lock l;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct val);
+} map_spin_lock SEC(".maps");
+
+SEC("cgroup/skb")
+__description("spin_lock: test1 success")
+__success __failure_unpriv __msg_unpriv("")
+__retval(0)
+__naked void spin_lock_test1_success(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r6;					\
+	r1 += 4;					\
+	r0 = *(u32*)(r6 + 0);				\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test2 direct ld/st")
+__failure __msg("cannot be accessed directly")
+__failure_unpriv __msg_unpriv("")
+__naked void lock_test2_direct_ld_st(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r6;					\
+	r1 += 4;					\
+	r0 = *(u32*)(r1 + 0);				\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test3 direct ld/st")
+__failure __msg("cannot be accessed directly")
+__failure_unpriv __msg_unpriv("")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void lock_test3_direct_ld_st(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r6;					\
+	r1 += 4;					\
+	r0 = *(u32*)(r6 + 1);				\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test4 direct ld/st")
+__failure __msg("cannot be accessed directly")
+__failure_unpriv __msg_unpriv("")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void lock_test4_direct_ld_st(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r6;					\
+	r1 += 4;					\
+	r0 = *(u16*)(r6 + 3);				\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test5 call within a locked region")
+__failure __msg("calls are not allowed")
+__failure_unpriv __msg_unpriv("")
+__naked void call_within_a_locked_region(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r6;					\
+	r1 += 4;					\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test6 missing unlock")
+__failure __msg("unlock is missing")
+__failure_unpriv __msg_unpriv("")
+__naked void spin_lock_test6_missing_unlock(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r6;					\
+	r1 += 4;					\
+	r0 = *(u32*)(r6 + 0);				\
+	if r0 != 0 goto l1_%=;				\
+	call %[bpf_spin_unlock];			\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test7 unlock without lock")
+__failure __msg("without taking a lock")
+__failure_unpriv __msg_unpriv("")
+__naked void lock_test7_unlock_without_lock(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	if r1 != 0 goto l1_%=;				\
+	call %[bpf_spin_lock];				\
+l1_%=:	r1 = r6;					\
+	r1 += 4;					\
+	r0 = *(u32*)(r6 + 0);				\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test8 double lock")
+__failure __msg("calls are not allowed")
+__failure_unpriv __msg_unpriv("")
+__naked void spin_lock_test8_double_lock(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r6;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r6;					\
+	r1 += 4;					\
+	r0 = *(u32*)(r6 + 0);				\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test9 different lock")
+__failure __msg("unlock of different lock")
+__failure_unpriv __msg_unpriv("")
+__naked void spin_lock_test9_different_lock(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r7 = r0;					\
+	r1 = r6;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r1 = r7;					\
+	r1 += 4;					\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("spin_lock: test10 lock in subprog without unlock")
+__failure __msg("unlock is missing")
+__failure_unpriv __msg_unpriv("")
+__naked void lock_in_subprog_without_unlock(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call lock_in_subprog_without_unlock__1;		\
+	r1 = r6;					\
+	r1 += 4;					\
+	call %[bpf_spin_unlock];			\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+static __naked __noinline __attribute__((used))
+void lock_in_subprog_without_unlock__1(void)
+{
+	asm volatile ("					\
+	call %[bpf_spin_lock];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_spin_lock)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("spin_lock: test11 ld_abs under lock")
+__failure __msg("inside bpf_spin_lock")
+__naked void test11_ld_abs_under_lock(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r7 = r0;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r0 = *(u8*)skb[0];				\
+	r1 = r7;					\
+	r1 += 4;					\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("spin_lock: regsafe compare reg->id for map value")
+__failure __msg("bpf_spin_unlock of different lock")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void reg_id_for_map_value(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r6 = *(u32*)(r6 + %[__sk_buff_mark]);		\
+	r1 = %[map_spin_lock] ll;			\
+	r9 = r1;					\
+	r2 = 0;						\
+	*(u32*)(r10 - 4) = r2;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r7 = r0;					\
+	r1 = r9;					\
+	r2 = r10;					\
+	r2 += -4;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r8 = r0;					\
+	r1 = r7;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	if r6 == 0 goto l2_%=;				\
+	goto l3_%=;					\
+l2_%=:	r7 = r8;					\
+l3_%=:	r1 = r7;					\
+	r1 += 4;					\
+	call %[bpf_spin_unlock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+/* Make sure that regsafe() compares ids for spin lock records using
+ * check_ids():
+ *  1: r9 = map_lookup_elem(...)  ; r9.id == 1
+ *  2: r8 = map_lookup_elem(...)  ; r8.id == 2
+ *  3: r7 = ktime_get_ns()
+ *  4: r6 = ktime_get_ns()
+ *  5: if r6 > r7 goto <9>
+ *  6: spin_lock(r8)
+ *  7: r9 = r8
+ *  8: goto <10>
+ *  9: spin_lock(r9)
+ * 10: spin_unlock(r9)             ; r9.id == 1 || r9.id == 2 and lock is active,
+ *                                 ; second visit to (10) should be considered safe
+ *                                 ; if check_ids() is used.
+ * 11: exit(0)
+ */
+
+SEC("cgroup/skb")
+__description("spin_lock: regsafe() check_ids() similar id mappings")
+__success __msg("29: safe")
+__failure_unpriv __msg_unpriv("")
+__log_level(2) __retval(0) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void check_ids_similar_id_mappings(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	/* r9 = map_lookup_elem(...) */			\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	/* r8 = map_lookup_elem(...) */			\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_spin_lock] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l1_%=;				\
+	r8 = r0;					\
+	/* r7 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	r7 = r0;					\
+	/* r6 = ktime_get_ns() */			\
+	call %[bpf_ktime_get_ns];			\
+	r6 = r0;					\
+	/* if r6 > r7 goto +5      ; no new information about the state is derived from\
+	 *                         ; this check, thus produced verifier states differ\
+	 *                         ; only in 'insn_idx'	\
+	 * spin_lock(r8)				\
+	 * r9 = r8					\
+	 * goto unlock					\
+	 */						\
+	if r6 > r7 goto l2_%=;				\
+	r1 = r8;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+	r9 = r8;					\
+	goto l3_%=;					\
+l2_%=:	/* spin_lock(r9) */				\
+	r1 = r9;					\
+	r1 += 4;					\
+	call %[bpf_spin_lock];				\
+l3_%=:	/* spin_unlock(r9) */				\
+	r1 = r9;					\
+	r1 += 4;					\
+	call %[bpf_spin_unlock];			\
+l0_%=:	/* exit(0) */					\
+	r0 = 0;						\
+l1_%=:	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_spin_lock),
+	  __imm(bpf_spin_unlock),
+	  __imm_addr(map_spin_lock)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/spin_lock.c b/tools/testing/selftests/bpf/verifier/spin_lock.c
deleted file mode 100644
index eaf114f07e2e..000000000000
--- a/tools/testing/selftests/bpf/verifier/spin_lock.c
+++ /dev/null
@@ -1,447 +0,0 @@
-{
-	"spin_lock: test1 success",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test2 direct ld/st",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "cannot be accessed directly",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test3 direct ld/st",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "cannot be accessed directly",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"spin_lock: test4 direct ld/st",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_6, 3),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "cannot be accessed directly",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"spin_lock: test5 call within a locked region",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "calls are not allowed",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test6 missing unlock",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "unlock is missing",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test7 unlock without lock",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "without taking a lock",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test8 double lock",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "calls are not allowed",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test9 different lock",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3, 11 },
-	.result = REJECT,
-	.errstr = "unlock of different lock",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test10 lock in subprog without unlock",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3 },
-	.result = REJECT,
-	.errstr = "unlock is missing",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"spin_lock: test11 ld_abs under lock",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_LD_ABS(BPF_B, 0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 4 },
-	.result = REJECT,
-	.errstr = "inside bpf_spin_lock",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"spin_lock: regsafe compare reg->id for map value",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_6, offsetof(struct __sk_buff, mark)),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_lock),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_6, 0, 1),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_spin_unlock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 2 },
-	.result = REJECT,
-	.errstr = "bpf_spin_unlock of different lock",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.flags = BPF_F_TEST_STATE_FREQ,
-},
-/* Make sure that regsafe() compares ids for spin lock records using
- * check_ids():
- *  1: r9 = map_lookup_elem(...)  ; r9.id == 1
- *  2: r8 = map_lookup_elem(...)  ; r8.id == 2
- *  3: r7 = ktime_get_ns()
- *  4: r6 = ktime_get_ns()
- *  5: if r6 > r7 goto <9>
- *  6: spin_lock(r8)
- *  7: r9 = r8
- *  8: goto <10>
- *  9: spin_lock(r9)
- * 10: spin_unlock(r9)             ; r9.id == 1 || r9.id == 2 and lock is active,
- *                                 ; second visit to (10) should be considered safe
- *                                 ; if check_ids() is used.
- * 11: exit(0)
- */
-{
-	"spin_lock: regsafe() check_ids() similar id mappings",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	/* r9 = map_lookup_elem(...) */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 24),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
-	/* r8 = map_lookup_elem(...) */
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1,
-		      0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 18),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	/* r7 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	/* r6 = ktime_get_ns() */
-	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* if r6 > r7 goto +5      ; no new information about the state is derived from
-	 *                         ; this check, thus produced verifier states differ
-	 *                         ; only in 'insn_idx'
-	 * spin_lock(r8)
-	 * r9 = r8
-	 * goto unlock
-	 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_8),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
-	BPF_MOV64_REG(BPF_REG_9, BPF_REG_8),
-	BPF_JMP_A(3),
-	/* spin_lock(r9) */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_EMIT_CALL(BPF_FUNC_spin_lock),
-	/* spin_unlock(r9) */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
-	BPF_EMIT_CALL(BPF_FUNC_spin_unlock),
-	/* exit(0) */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_spin_lock = { 3, 10 },
-	.result = VERBOSE_ACCEPT,
-	.errstr = "28: safe",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.flags = BPF_F_TEST_STATE_FREQ,
-},
-- 
2.40.0

