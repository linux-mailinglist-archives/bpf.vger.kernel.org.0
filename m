Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775676EB0F7
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjDURoJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjDURng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:36 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4833F18D
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f1763eea08so21186805e9.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098994; x=1684690994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3zKftaKj5yNZCfKYhwoITJngxvnHBNofVJGf00wzGE=;
        b=AqRKr5alWkRpFw1PV4hrpQREXBM5HqGuM3q9il0i27pbO/Lf3MWJmOpU3q36tYSjsr
         teoALbkWufUnSa+D+a0b3hfY95cDZhgFkq0a+FB8SDoX/vqDWi3sT0c3XhWsNh2issPG
         7BEpMW+TcophyuHXUxNt9mzZFHCwYdSyw1e1htxnqq+T9WpaXHotYK/kfrmJTsPUlScP
         63j75ZDdiDrxd1epDFtR0pSNVUMOIFjx6tzuR8Ivllzwf8PKDyhPVPj+ujt/2+6mwoKQ
         P7NkZAoECMv2XrGZSnmsIyNRf9Pba47jRVATN5z0iL79iHBrx4TpKIJuz5AX3GvDwXgx
         3YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098994; x=1684690994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3zKftaKj5yNZCfKYhwoITJngxvnHBNofVJGf00wzGE=;
        b=klGEzWkReUtwhrQ541NmldfqcK5u0BQaM7ozPGLusIi2f4zQOSlCK/5HrPgbwk/pAI
         cOiyxYcEFUwiox/FQnq+8reiGEeZxVCQYgMt2PW2Bm87m7paCsCoCGobNbOnyOuVaLnS
         8X8VYAZKmjQ2HnnIgX3+rJ4R+Ot6DlCLmgg5xsBOUn0Mo6M+iF6GKQlyUnQ5fynG4G5c
         CePOU8g57QN1P4I7mVm6lWC9b9CjbePrDWuPmcGRizUh7p998QD6CtFQ61Fmam6ZTFda
         ihMS8SF/Yux4XH3yGRaILsu9izlIac/sY3xRfJ6/PSNn0qJqsl7KMRQtsSOwpf5RnxDv
         a4Bw==
X-Gm-Message-State: AAQBX9dYd+nntHlCDDI/nBr+Y8BtL1kV4m2rxlmrogFmkGzWG3KJbizM
        aOgtH7NvuOPoKLSgISz2e8TsA0u4n7Hldg==
X-Google-Smtp-Source: AKy350buaBQHbyqzB7TjtOqzm0HV2+CNBClI+NO562f/zaQN4sBD+f5yXruZjZHmse/BNKxzeJmSZQ==
X-Received: by 2002:adf:fd05:0:b0:2ef:b3e6:8293 with SMTP id e5-20020adffd05000000b002efb3e68293mr4306233wrr.9.1682098993733;
        Fri, 21 Apr 2023 10:43:13 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:13 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 24/24] selftests/bpf: verifier/value_ptr_arith converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:34 +0300
Message-Id: <20230421174234.2391278-25-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/value_ptr_arith automatically converted to use inline assembly.

Test cases "sanitation: alu with different scalars 2" and
"sanitation: alu with different scalars 3" are updated to
avoid -ENOENT as return value, as __retval() annotation
only supports numeric literals.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   34 +-
 .../bpf/progs/verifier_value_ptr_arith.c      | 1423 +++++++++++++++++
 .../selftests/bpf/verifier/value_ptr_arith.c  | 1140 -------------
 3 files changed, 1451 insertions(+), 1146 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/value_ptr_arith.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 56b9248a15c0..bcb955adb447 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -62,6 +62,7 @@
 #include "verifier_value.skel.h"
 #include "verifier_value_illegal_alu.skel.h"
 #include "verifier_value_or_null.skel.h"
+#include "verifier_value_ptr_arith.skel.h"
 #include "verifier_var_off.skel.h"
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
@@ -164,29 +165,50 @@ void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 
-static int init_array_access_maps(struct bpf_object *obj)
+static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
-	struct bpf_map *array_ro;
 	struct test_val value = {
 		.index = (6 + 1) * sizeof(int),
 		.foo[6] = 0xabcdef12,
 	};
+	struct bpf_map *map;
 	int err, key = 0;
 
-	array_ro = bpf_object__find_map_by_name(obj, "map_array_ro");
-	if (!ASSERT_OK_PTR(array_ro, "lookup map_array_ro"))
+	map = bpf_object__find_map_by_name(obj, map_name);
+	if (!map) {
+		PRINT_FAIL("Can't find map '%s'\n", map_name);
 		return -EINVAL;
+	}
 
-	err = bpf_map_update_elem(bpf_map__fd(array_ro), &key, &value, 0);
-	if (!ASSERT_OK(err, "map_array_ro update"))
+	err = bpf_map_update_elem(bpf_map__fd(map), &key, &value, 0);
+	if (err) {
+		PRINT_FAIL("Error while updating map '%s': %d\n", map_name, err);
 		return err;
+	}
 
 	return 0;
 }
 
+static int init_array_access_maps(struct bpf_object *obj)
+{
+	return init_test_val_map(obj, "map_array_ro");
+}
+
 void test_verifier_array_access(void)
 {
 	run_tests_aux("verifier_array_access",
 		      verifier_array_access__elf_bytes,
 		      init_array_access_maps);
 }
+
+static int init_value_ptr_arith_maps(struct bpf_object *obj)
+{
+	return init_test_val_map(obj, "map_array_48b");
+}
+
+void test_verifier_value_ptr_arith(void)
+{
+	run_tests_aux("verifier_value_ptr_arith",
+		      verifier_value_ptr_arith__elf_bytes,
+		      init_value_ptr_arith_maps);
+}
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
new file mode 100644
index 000000000000..5ba6e53571c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -0,0 +1,1423 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/value_ptr_arith.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <errno.h>
+#include "bpf_misc.h"
+
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct test_val);
+} map_array_48b SEC(".maps");
+
+struct other_val {
+	long long foo;
+	long long bar;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct other_val);
+} map_hash_16b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+SEC("socket")
+__description("map access: known scalar += value_ptr unknown vs const")
+__success __failure_unpriv
+__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__retval(1)
+__naked void value_ptr_unknown_vs_const(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r4 = *(u8*)(r0 + 0);				\
+	if r4 == 1 goto l3_%=;				\
+	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x7;					\
+	goto l4_%=;					\
+l3_%=:	r1 = 3;						\
+l4_%=:	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr const vs unknown")
+__success __failure_unpriv
+__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__retval(1)
+__naked void value_ptr_const_vs_unknown(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r4 = *(u8*)(r0 + 0);				\
+	if r4 == 1 goto l3_%=;				\
+	r1 = 3;						\
+	goto l4_%=;					\
+l3_%=:	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x7;					\
+l4_%=:	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr const vs const (ne)")
+__success __failure_unpriv
+__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__retval(1)
+__naked void ptr_const_vs_const_ne(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r4 = *(u8*)(r0 + 0);				\
+	if r4 == 1 goto l3_%=;				\
+	r1 = 3;						\
+	goto l4_%=;					\
+l3_%=:	r1 = 5;						\
+l4_%=:	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr const vs const (eq)")
+__success __success_unpriv __retval(1)
+__naked void ptr_const_vs_const_eq(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r4 = *(u8*)(r0 + 0);				\
+	if r4 == 1 goto l3_%=;				\
+	r1 = 5;						\
+	goto l4_%=;					\
+l3_%=:	r1 = 5;						\
+l4_%=:	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr unknown vs unknown (eq)")
+__success __success_unpriv __retval(1)
+__naked void ptr_unknown_vs_unknown_eq(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r4 = *(u8*)(r0 + 0);				\
+	if r4 == 1 goto l3_%=;				\
+	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x7;					\
+	goto l4_%=;					\
+l3_%=:	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x7;					\
+l4_%=:	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr unknown vs unknown (lt)")
+__success __failure_unpriv
+__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__retval(1)
+__naked void ptr_unknown_vs_unknown_lt(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r4 = *(u8*)(r0 + 0);				\
+	if r4 == 1 goto l3_%=;				\
+	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x3;					\
+	goto l4_%=;					\
+l3_%=:	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x7;					\
+l4_%=:	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr unknown vs unknown (gt)")
+__success __failure_unpriv
+__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__retval(1)
+__naked void ptr_unknown_vs_unknown_gt(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r4 = *(u8*)(r0 + 0);				\
+	if r4 == 1 goto l3_%=;				\
+	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x7;					\
+	goto l4_%=;					\
+l3_%=:	r1 = 6;						\
+	r1 = -r1;					\
+	r1 &= 0x3;					\
+l4_%=:	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr from different maps")
+__success __success_unpriv __retval(1)
+__naked void value_ptr_from_different_maps(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r1 = 4;						\
+	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= known scalar from different maps")
+__success __failure_unpriv
+__msg_unpriv("R0 min value is outside of the allowed memory range")
+__retval(1)
+__naked void known_scalar_from_different_maps(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_16b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r1 = 4;						\
+	r0 -= r1;					\
+	r0 += r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr from different maps, but same value properties")
+__success __success_unpriv __retval(1)
+__naked void maps_but_same_value_properties(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	if r0 == 1 goto l0_%=;				\
+	r1 = %[map_hash_48b] ll;			\
+	if r0 != 1 goto l1_%=;				\
+l0_%=:	r1 = %[map_array_48b] ll;			\
+l1_%=:	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l2_%=;				\
+	r1 = 4;						\
+	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l2_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: mixing value pointer and scalar, 1")
+__success __failure_unpriv __msg_unpriv("R2 pointer comparison prohibited")
+__retval(0)
+__naked void value_pointer_and_scalar_1(void)
+{
+	asm volatile ("					\
+	/* load map value pointer into r0 and r2 */	\
+	r0 = 1;						\
+	r1 = %[map_array_48b] ll;			\
+	r2 = r10;					\
+	r2 += -16;					\
+	r6 = 0;						\
+	*(u64*)(r10 - 16) = r6;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	/* load some number from the map into r1 */	\
+	r1 = *(u8*)(r0 + 0);				\
+	/* depending on r1, branch: */			\
+	if r1 != 0 goto l1_%=;				\
+	/* branch A */					\
+	r2 = r0;					\
+	r3 = 0;						\
+	goto l2_%=;					\
+l1_%=:	/* branch B */					\
+	r2 = 0;						\
+	r3 = 0x100000;					\
+l2_%=:	/* common instruction */			\
+	r2 += r3;					\
+	/* depending on r1, branch: */			\
+	if r1 != 0 goto l3_%=;				\
+	/* branch A */					\
+	goto l4_%=;					\
+l3_%=:	/* branch B */					\
+	r0 = 0x13371337;				\
+	/* verifier follows fall-through */		\
+	if r2 != 0x100000 goto l4_%=;			\
+	r0 = 0;						\
+	exit;						\
+l4_%=:	/* fake-dead code; targeted from branch A to	\
+	 * prevent dead code sanitization		\
+	 */						\
+	r0 = *(u8*)(r0 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: mixing value pointer and scalar, 2")
+__success __failure_unpriv __msg_unpriv("R0 invalid mem access 'scalar'")
+__retval(0)
+__naked void value_pointer_and_scalar_2(void)
+{
+	asm volatile ("					\
+	/* load map value pointer into r0 and r2 */	\
+	r0 = 1;						\
+	r1 = %[map_array_48b] ll;			\
+	r2 = r10;					\
+	r2 += -16;					\
+	r6 = 0;						\
+	*(u64*)(r10 - 16) = r6;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	/* load some number from the map into r1 */	\
+	r1 = *(u8*)(r0 + 0);				\
+	/* depending on r1, branch: */			\
+	if r1 == 0 goto l1_%=;				\
+	/* branch A */					\
+	r2 = 0;						\
+	r3 = 0x100000;					\
+	goto l2_%=;					\
+l1_%=:	/* branch B */					\
+	r2 = r0;					\
+	r3 = 0;						\
+l2_%=:	/* common instruction */			\
+	r2 += r3;					\
+	/* depending on r1, branch: */			\
+	if r1 != 0 goto l3_%=;				\
+	/* branch A */					\
+	goto l4_%=;					\
+l3_%=:	/* branch B */					\
+	r0 = 0x13371337;				\
+	/* verifier follows fall-through */		\
+	if r2 != 0x100000 goto l4_%=;			\
+	r0 = 0;						\
+	exit;						\
+l4_%=:	/* fake-dead code; targeted from branch A to	\
+	 * prevent dead code sanitization, rejected	\
+	 * via branch B however				\
+	 */						\
+	r0 = *(u8*)(r0 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sanitation: alu with different scalars 1")
+__success __success_unpriv __retval(0x100000)
+__naked void alu_with_different_scalars_1(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	r1 = %[map_array_48b] ll;			\
+	r2 = r10;					\
+	r2 += -16;					\
+	r6 = 0;						\
+	*(u64*)(r10 - 16) = r6;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = *(u32*)(r0 + 0);				\
+	if r1 == 0 goto l1_%=;				\
+	r2 = 0;						\
+	r3 = 0x100000;					\
+	goto l2_%=;					\
+l1_%=:	r2 = 42;					\
+	r3 = 0x100001;					\
+l2_%=:	r2 += r3;					\
+	r0 = r2;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sanitation: alu with different scalars 2")
+__success __success_unpriv __retval(0)
+__naked void alu_with_different_scalars_2(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	r1 = %[map_array_48b] ll;			\
+	r6 = r1;					\
+	r2 = r10;					\
+	r2 += -16;					\
+	r7 = 0;						\
+	*(u64*)(r10 - 16) = r7;				\
+	call %[bpf_map_delete_elem];			\
+	r7 = r0;					\
+	r1 = r6;					\
+	r2 = r10;					\
+	r2 += -16;					\
+	call %[bpf_map_delete_elem];			\
+	r6 = r0;					\
+	r8 = r6;					\
+	r8 += r7;					\
+	r0 = r8;					\
+	r0 += %[einval];				\
+	r0 += %[einval];				\
+	exit;						\
+"	:
+	: __imm(bpf_map_delete_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_const(einval, EINVAL)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sanitation: alu with different scalars 3")
+__success __success_unpriv __retval(0)
+__naked void alu_with_different_scalars_3(void)
+{
+	asm volatile ("					\
+	r0 = %[einval];					\
+	r0 *= -1;					\
+	r7 = r0;					\
+	r0 = %[einval];					\
+	r0 *= -1;					\
+	r6 = r0;					\
+	r8 = r6;					\
+	r8 += r7;					\
+	r0 = r8;					\
+	r0 += %[einval];				\
+	r0 += %[einval];				\
+	exit;						\
+"	:
+	: __imm_const(einval, EINVAL)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, upper oob arith, test 1")
+__success __failure_unpriv
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__retval(1)
+__naked void upper_oob_arith_test_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 48;					\
+	r0 += r1;					\
+	r0 -= r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, upper oob arith, test 2")
+__success __failure_unpriv
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__retval(1)
+__naked void upper_oob_arith_test_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 49;					\
+	r0 += r1;					\
+	r0 -= r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, upper oob arith, test 3")
+__success __success_unpriv __retval(1)
+__naked void upper_oob_arith_test_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 47;					\
+	r0 += r1;					\
+	r0 -= r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= known scalar, lower oob arith, test 1")
+__failure __msg("R0 min value is outside of the allowed memory range")
+__failure_unpriv
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__naked void lower_oob_arith_test_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 47;					\
+	r0 += r1;					\
+	r1 = 48;					\
+	r0 -= r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= known scalar, lower oob arith, test 2")
+__success __failure_unpriv
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__retval(1)
+__naked void lower_oob_arith_test_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 47;					\
+	r0 += r1;					\
+	r1 = 48;					\
+	r0 -= r1;					\
+	r1 = 1;						\
+	r0 += r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= known scalar, lower oob arith, test 3")
+__success __success_unpriv __retval(1)
+__naked void lower_oob_arith_test_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 47;					\
+	r0 += r1;					\
+	r1 = 47;					\
+	r0 -= r1;					\
+	r0 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar += value_ptr")
+__success __success_unpriv __retval(1)
+__naked void access_known_scalar_value_ptr_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 4;						\
+	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, 1")
+__success __success_unpriv __retval(1)
+__naked void value_ptr_known_scalar_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 4;						\
+	r0 += r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, 2")
+__failure __msg("invalid access to map value")
+__failure_unpriv
+__naked void value_ptr_known_scalar_2_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 49;					\
+	r0 += r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, 3")
+__failure __msg("invalid access to map value")
+__failure_unpriv
+__naked void value_ptr_known_scalar_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = -1;					\
+	r0 += r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, 4")
+__success __success_unpriv __retval(1)
+__naked void value_ptr_known_scalar_4(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 5;						\
+	r0 += r1;					\
+	r1 = -2;					\
+	r0 += r1;					\
+	r1 = -1;					\
+	r0 += r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, 5")
+__success __success_unpriv __retval(0xabcdef12)
+__naked void value_ptr_known_scalar_5(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = %[__imm_0];				\
+	r1 += r0;					\
+	r0 = *(u32*)(r1 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_const(__imm_0, (6 + 1) * sizeof(int))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += known scalar, 6")
+__success __success_unpriv __retval(0xabcdef12)
+__naked void value_ptr_known_scalar_6(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = %[__imm_0];				\
+	r0 += r1;					\
+	r1 = %[__imm_1];				\
+	r0 += r1;					\
+	r0 = *(u32*)(r0 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b),
+	  __imm_const(__imm_0, (3 + 1) * sizeof(int)),
+	  __imm_const(__imm_1, 3 * sizeof(int))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += N, value_ptr -= N known scalar")
+__success __success_unpriv __retval(0x12345678)
+__naked void value_ptr_n_known_scalar(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	w1 = 0x12345678;				\
+	*(u32*)(r0 + 0) = r1;				\
+	r0 += 2;					\
+	r1 = 2;						\
+	r0 -= r1;					\
+	r0 = *(u32*)(r0 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: unknown scalar += value_ptr, 1")
+__success __success_unpriv __retval(1)
+__naked void unknown_scalar_value_ptr_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 &= 0xf;					\
+	r1 += r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: unknown scalar += value_ptr, 2")
+__success __success_unpriv __retval(0xabcdef12) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void unknown_scalar_value_ptr_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	r1 &= 31;					\
+	r1 += r0;					\
+	r0 = *(u32*)(r1 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: unknown scalar += value_ptr, 3")
+__success __failure_unpriv
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__retval(0xabcdef12) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void unknown_scalar_value_ptr_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = -1;					\
+	r0 += r1;					\
+	r1 = 1;						\
+	r0 += r1;					\
+	r1 = *(u32*)(r0 + 0);				\
+	r1 &= 31;					\
+	r1 += r0;					\
+	r0 = *(u32*)(r1 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: unknown scalar += value_ptr, 4")
+__failure __msg("R1 max value is outside of the allowed memory range")
+__msg_unpriv("R1 pointer arithmetic of map value goes out of range")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void unknown_scalar_value_ptr_4(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 19;					\
+	r0 += r1;					\
+	r1 = *(u32*)(r0 + 0);				\
+	r1 &= 31;					\
+	r1 += r0;					\
+	r0 = *(u32*)(r1 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += unknown scalar, 1")
+__success __success_unpriv __retval(1)
+__naked void value_ptr_unknown_scalar_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 &= 0xf;					\
+	r0 += r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += unknown scalar, 2")
+__success __success_unpriv __retval(0xabcdef12) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void value_ptr_unknown_scalar_2_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u32*)(r0 + 0);				\
+	r1 &= 31;					\
+	r0 += r1;					\
+	r0 = *(u32*)(r0 + 0);				\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += unknown scalar, 3")
+__success __success_unpriv __retval(1)
+__naked void value_ptr_unknown_scalar_3(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u64*)(r0 + 0);				\
+	r2 = *(u64*)(r0 + 8);				\
+	r3 = *(u64*)(r0 + 16);				\
+	r1 &= 0xf;					\
+	r3 &= 1;					\
+	r3 |= 1;					\
+	if r2 > r3 goto l0_%=;				\
+	r0 += r3;					\
+	r0 = *(u8*)(r0 + 0);				\
+	r0 = 1;						\
+l1_%=:	exit;						\
+l0_%=:	r0 = 2;						\
+	goto l1_%=;					\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr += value_ptr")
+__failure __msg("R0 pointer += pointer prohibited")
+__failure_unpriv
+__naked void access_value_ptr_value_ptr_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 += r0;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: known scalar -= value_ptr")
+__failure __msg("R1 tried to subtract pointer from scalar")
+__failure_unpriv
+__naked void access_known_scalar_value_ptr_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 4;						\
+	r1 -= r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= known scalar")
+__failure __msg("R0 min value is outside of the allowed memory range")
+__failure_unpriv
+__naked void access_value_ptr_known_scalar(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 4;						\
+	r0 -= r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= known scalar, 2")
+__success __success_unpriv __retval(1)
+__naked void value_ptr_known_scalar_2_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = 6;						\
+	r2 = 4;						\
+	r0 += r1;					\
+	r0 -= r2;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: unknown scalar -= value_ptr")
+__failure __msg("R1 tried to subtract pointer from scalar")
+__failure_unpriv
+__naked void access_unknown_scalar_value_ptr(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 &= 0xf;					\
+	r1 -= r0;					\
+	r0 = *(u8*)(r1 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= unknown scalar")
+__failure __msg("R0 min value is negative")
+__failure_unpriv
+__naked void access_value_ptr_unknown_scalar(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 &= 0xf;					\
+	r0 -= r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= unknown scalar, 2")
+__success __failure_unpriv
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range")
+__retval(1)
+__naked void value_ptr_unknown_scalar_2_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 &= 0xf;					\
+	r1 |= 0x7;					\
+	r0 += r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+	r1 &= 0x7;					\
+	r0 -= r1;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: value_ptr -= value_ptr")
+__failure __msg("R0 invalid mem access 'scalar'")
+__msg_unpriv("R0 pointer -= pointer prohibited")
+__naked void access_value_ptr_value_ptr_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r0 -= r0;					\
+	r1 = *(u8*)(r0 + 0);				\
+l0_%=:	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("map access: trying to leak tainted dst reg")
+__failure __msg("math between map_value pointer and 4294967295 is not allowed")
+__failure_unpriv
+__naked void to_leak_tainted_dst_reg(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r2 = r0;					\
+	w1 = 0xFFFFFFFF;				\
+	w1 = w1;					\
+	r2 -= r1;					\
+	*(u64*)(r0 + 0) = r2;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_48b)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("32bit pkt_ptr -= scalar")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void _32bit_pkt_ptr_scalar(void)
+{
+	asm volatile ("					\
+	r8 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r7 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r6 = r7;					\
+	r6 += 40;					\
+	if r6 > r8 goto l0_%=;				\
+	w4 = w7;					\
+	w6 -= w4;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("32bit scalar -= pkt_ptr")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void _32bit_scalar_pkt_ptr(void)
+{
+	asm volatile ("					\
+	r8 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r7 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r6 = r7;					\
+	r6 += 40;					\
+	if r6 > r8 goto l0_%=;				\
+	w4 = w6;					\
+	w4 -= w7;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c b/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
deleted file mode 100644
index 249187d3c530..000000000000
--- a/tools/testing/selftests/bpf/verifier/value_ptr_arith.c
+++ /dev/null
@@ -1,1140 +0,0 @@
-{
-	"map access: known scalar += value_ptr unknown vs const",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_1, 3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 tried to add from different maps, paths or scalars",
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr const vs unknown",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
-	BPF_MOV64_IMM(BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 tried to add from different maps, paths or scalars",
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr const vs const (ne)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
-	BPF_MOV64_IMM(BPF_REG_1, 3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_1, 5),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 tried to add from different maps, paths or scalars",
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr const vs const (eq)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 2),
-	BPF_MOV64_IMM(BPF_REG_1, 5),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-	BPF_MOV64_IMM(BPF_REG_1, 5),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr unknown vs unknown (eq)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr unknown vs unknown (lt)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x3),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 tried to add from different maps, paths or scalars",
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr unknown vs unknown (gt)",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_4, 1, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_JMP_IMM(BPF_JA, 0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_ALU64_IMM(BPF_NEG, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R1 tried to add from different maps, paths or scalars",
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr from different maps",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: value_ptr -= known scalar from different maps",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 min value is outside of the allowed memory range",
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr from different maps, but same value properties",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 5 },
-	.fixup_map_array_48b = { 8 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: mixing value pointer and scalar, 1",
-	.insns = {
-	// load map value pointer into r0 and r2
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
-	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	// load some number from the map into r1
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 3),
-	// branch A
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_JMP_A(2),
-	// branch B
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
-	// common instruction
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	// branch A
-	BPF_JMP_A(4),
-	// branch B
-	BPF_MOV64_IMM(BPF_REG_0, 0x13371337),
-	// verifier follows fall-through
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0x100000, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	// fake-dead code; targeted from branch A to
-	// prevent dead code sanitization
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 1 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R2 pointer comparison prohibited",
-	.retval = 0,
-},
-{
-	"map access: mixing value pointer and scalar, 2",
-	.insns = {
-	// load map value pointer into r0 and r2
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
-	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	// load some number from the map into r1
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
-	// branch A
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
-	BPF_JMP_A(2),
-	// branch B
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	// common instruction
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	// depending on r1, branch:
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
-	// branch A
-	BPF_JMP_A(4),
-	// branch B
-	BPF_MOV64_IMM(BPF_REG_0, 0x13371337),
-	// verifier follows fall-through
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0x100000, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	// fake-dead code; targeted from branch A to
-	// prevent dead code sanitization, rejected
-	// via branch B however
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 1 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 invalid mem access 'scalar'",
-	.retval = 0,
-},
-{
-	"sanitation: alu with different scalars 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
-	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
-	BPF_JMP_A(2),
-	BPF_MOV64_IMM(BPF_REG_2, 42),
-	BPF_MOV64_IMM(BPF_REG_3, 0x100001),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 1 },
-	.result = ACCEPT,
-	.retval = 0x100000,
-},
-{
-	"sanitation: alu with different scalars 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -16),
-	BPF_EMIT_CALL(BPF_FUNC_map_delete_elem),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 1 },
-	.result = ACCEPT,
-	.retval = -EINVAL * 2,
-},
-{
-	"sanitation: alu with different scalars 3",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, EINVAL),
-	BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, -1),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_0, EINVAL),
-	BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, -1),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_6),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_8, BPF_REG_7),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_8),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.retval = -EINVAL * 2,
-},
-{
-	"map access: value_ptr += known scalar, upper oob arith, test 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 48),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-	.retval = 1,
-},
-{
-	"map access: value_ptr += known scalar, upper oob arith, test 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 49),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-	.retval = 1,
-},
-{
-	"map access: value_ptr += known scalar, upper oob arith, test 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_IMM(BPF_REG_1, 47),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: value_ptr -= known scalar, lower oob arith, test 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_IMM(BPF_REG_1, 47),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 48),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R0 min value is outside of the allowed memory range",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-},
-{
-	"map access: value_ptr -= known scalar, lower oob arith, test 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_IMM(BPF_REG_1, 47),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 48),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-	.retval = 1,
-},
-{
-	"map access: value_ptr -= known scalar, lower oob arith, test 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_IMM(BPF_REG_1, 47),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 47),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: known scalar += value_ptr",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: value_ptr += known scalar, 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: value_ptr += known scalar, 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 49),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "invalid access to map value",
-},
-{
-	"map access: value_ptr += known scalar, 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "invalid access to map value",
-},
-{
-	"map access: value_ptr += known scalar, 4",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_IMM(BPF_REG_1, 5),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, -2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: value_ptr += known scalar, 5",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, (6 + 1) * sizeof(int)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 0xabcdef12,
-},
-{
-	"map access: value_ptr += known scalar, 6",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_IMM(BPF_REG_1, (3 + 1) * sizeof(int)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 3 * sizeof(int)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 0xabcdef12,
-},
-{
-	"map access: value_ptr += N, value_ptr -= N known scalar",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV32_IMM(BPF_REG_1, 0x12345678),
-	BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
-	BPF_MOV64_IMM(BPF_REG_1, 2),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 0x12345678,
-},
-{
-	"map access: unknown scalar += value_ptr, 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: unknown scalar += value_ptr, 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 0xabcdef12,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map access: unknown scalar += value_ptr, 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_MOV64_IMM(BPF_REG_1, -1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_MOV64_IMM(BPF_REG_1, 1),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-	.retval = 0xabcdef12,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map access: unknown scalar += value_ptr, 4",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_IMM(BPF_REG_1, 19),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R1 max value is outside of the allowed memory range",
-	.errstr_unpriv = "R1 pointer arithmetic of map value goes out of range",
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map access: value_ptr += unknown scalar, 1",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: value_ptr += unknown scalar, 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 31),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 0xabcdef12,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"map access: value_ptr += unknown scalar, 3",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 11),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 16),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 1),
-	BPF_ALU64_IMM(BPF_OR, BPF_REG_3, 1),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_3),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 2),
-	BPF_JMP_IMM(BPF_JA, 0, 0, -3),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: value_ptr += value_ptr",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R0 pointer += pointer prohibited",
-},
-{
-	"map access: known scalar -= value_ptr",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R1 tried to subtract pointer from scalar",
-},
-{
-	"map access: value_ptr -= known scalar",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_IMM(BPF_REG_1, 4),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R0 min value is outside of the allowed memory range",
-},
-{
-	"map access: value_ptr -= known scalar, 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_IMM(BPF_REG_1, 6),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_2),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.retval = 1,
-},
-{
-	"map access: unknown scalar -= value_ptr",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R1 tried to subtract pointer from scalar",
-},
-{
-	"map access: value_ptr -= unknown scalar",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R0 min value is negative",
-},
-{
-	"map access: value_ptr -= unknown scalar, 2",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0xf),
-	BPF_ALU64_IMM(BPF_OR, BPF_REG_1, 0x7),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x7),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "R0 pointer arithmetic of map value goes out of range",
-	.retval = 1,
-},
-{
-	"map access: value_ptr -= value_ptr",
-	.insns = {
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_0),
-	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R0 invalid mem access 'scalar'",
-	.errstr_unpriv = "R0 pointer -= pointer prohibited",
-},
-{
-	"map access: trying to leak tainted dst reg",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV32_IMM(BPF_REG_1, 0xFFFFFFFF),
-	BPF_MOV32_REG(BPF_REG_1, BPF_REG_1),
-	BPF_ALU64_REG(BPF_SUB, BPF_REG_2, BPF_REG_1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_array_48b = { 4 },
-	.result = REJECT,
-	.errstr = "math between map_value pointer and 4294967295 is not allowed",
-},
-{
-	"32bit pkt_ptr -= scalar",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 40),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
-	BPF_ALU32_REG(BPF_MOV, BPF_REG_4, BPF_REG_7),
-	BPF_ALU32_REG(BPF_SUB, BPF_REG_6, BPF_REG_4),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"32bit scalar -= pkt_ptr",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_7),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 40),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_8, 2),
-	BPF_ALU32_REG(BPF_MOV, BPF_REG_4, BPF_REG_6),
-	BPF_ALU32_REG(BPF_SUB, BPF_REG_4, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-- 
2.40.0

