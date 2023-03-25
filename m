Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFB36C8A6A
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCYC4T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCYC4S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC0D1ADF1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so3828951wmq.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFjcaT9K8HTGjlnAluLpv/fxc4PAmBKFU8WpFpQpxiQ=;
        b=NneJfujX0IlFYCpWGRRwwz70stQ77OkC/xD3Zj+w5XJDnc8tdmidwh3N4QC3tkaLOw
         Zu93YJPFFCE0wwSgf6ydptDwgIsXGTI13KZh84GP9pBscXjTuCT2betZdKm8ihbUjajo
         aqF7Wqiu2C7MBUNlsoAtyHTAzNS5g5+dUNQDjvvCCmTzOEHQjKxpdnljaBpNA9Q70vSB
         xoBkXjaEkt3bZgU2Q5zuvyI3/w9ngI/lXEvk0YPS6Picyi2zzUFGSVb9uAptMC/m63Le
         zNWC333eylb+q8Zls3iL0JVoRFFVn0IKLn18qpBmarOIYd8l8gJwm5QO9FDSZM3lvpv/
         Vfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFjcaT9K8HTGjlnAluLpv/fxc4PAmBKFU8WpFpQpxiQ=;
        b=BN7nMKPKWmDjXKuWeR+ctzlPYJQXNSpZPW3CVWoLAP8vgjDLdPbgpYt3yeb2RN2xfp
         eZQu84crE/nIz9FpsfyDdpgQgfNNQHUKZJWLszPEqmh13PovM/waUg3qBdytoH0w94O/
         +LNqwr16GghSHijxaXnOyXHblW0DiFTHab5MMOxAqbazuVCEej1VEcTVjM1fGpNmySkb
         7KW6cJoEN9ncfQSG+cT3j9pdYSxwJaIQYxu9n3lRaQWNI4jDWnWTgYWPFqgzeeaYCH4D
         vtH8AK9jH03hToP2vqWIjOHrSA7mQOrS79Qs3b0G9AG0oxKInGj2WMqxbiLNvX5M5I8U
         ++dQ==
X-Gm-Message-State: AO0yUKVaZDnYxJOcliq2hx+ahQT/a/TBJbWXVTFh/CTXU/Ef72gotuXJ
        7W/ssb3k3shKvgfmuFH84fR5kFTm3L4=
X-Google-Smtp-Source: AK7set/lFceCYWrLtYjaIZgeO1+qxJdOutlmsvy6z4xf6sY/SpI024ogvN0KIQbk2avGlJmCXkDv7A==
X-Received: by 2002:a05:600c:2209:b0:3ee:64d5:bac9 with SMTP id z9-20020a05600c220900b003ee64d5bac9mr3666547wml.9.1679712973396;
        Fri, 24 Mar 2023 19:56:13 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:12 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 14/43] selftests/bpf: verifier/cgroup_storage.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:55 +0200
Message-Id: <20230325025524.144043-15-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test verifier/cgroup_storage.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_cgroup_storage.c       | 308 ++++++++++++++++++
 .../selftests/bpf/verifier/cgroup_storage.c   | 220 -------------
 3 files changed, 310 insertions(+), 220 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cgroup_storage.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 53e41af90821..3b47620a1f42 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -11,6 +11,7 @@
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
+#include "verifier_cgroup_storage.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -44,3 +45,4 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_u
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
+void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
new file mode 100644
index 000000000000..9a13f5c11ac7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_storage.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/cgroup_storage.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+	__uint(max_entries, 0);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, char[TEST_DATA_LEN]);
+} cgroup_storage SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__uint(max_entries, 0);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, char[64]);
+} percpu_cgroup_storage SEC(".maps");
+
+SEC("cgroup/skb")
+__description("valid cgroup storage access")
+__success __success_unpriv __retval(0)
+__naked void valid_cgroup_storage_access(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[cgroup_storage] ll;			\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid cgroup storage access 1")
+__failure __msg("cannot pass map_type 1 into func bpf_get_local_storage")
+__failure_unpriv
+__naked void invalid_cgroup_storage_access_1(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid cgroup storage access 2")
+__failure __msg("fd 1 is not pointing to valid bpf_map")
+__failure_unpriv
+__naked void invalid_cgroup_storage_access_2(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	.8byte %[ld_map_fd];				\
+	.8byte 0;					\
+	call %[bpf_get_local_storage];			\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_insn(ld_map_fd, BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_1, BPF_PSEUDO_MAP_FD, 0, 1))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid cgroup storage access 3")
+__failure __msg("invalid access to map value, value_size=64 off=256 size=4")
+__failure_unpriv
+__naked void invalid_cgroup_storage_access_3(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[cgroup_storage] ll;			\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 256);				\
+	r1 += 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid cgroup storage access 4")
+__failure __msg("invalid access to map value, value_size=64 off=-2 size=4")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void invalid_cgroup_storage_access_4(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[cgroup_storage] ll;			\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 - 2);				\
+	r0 = r1;					\
+	r1 += 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid cgroup storage access 5")
+__failure __msg("get_local_storage() doesn't support non-zero flags")
+__failure_unpriv
+__naked void invalid_cgroup_storage_access_5(void)
+{
+	asm volatile ("					\
+	r2 = 7;						\
+	r1 = %[cgroup_storage] ll;			\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid cgroup storage access 6")
+__failure __msg("get_local_storage() doesn't support non-zero flags")
+__msg_unpriv("R2 leaks addr into helper function")
+__naked void invalid_cgroup_storage_access_6(void)
+{
+	asm volatile ("					\
+	r2 = r1;					\
+	r1 = %[cgroup_storage] ll;			\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("valid per-cpu cgroup storage access")
+__success __success_unpriv __retval(0)
+__naked void per_cpu_cgroup_storage_access(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[percpu_cgroup_storage] ll;		\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(percpu_cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid per-cpu cgroup storage access 1")
+__failure __msg("cannot pass map_type 1 into func bpf_get_local_storage")
+__failure_unpriv
+__naked void cpu_cgroup_storage_access_1(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid per-cpu cgroup storage access 2")
+__failure __msg("fd 1 is not pointing to valid bpf_map")
+__failure_unpriv
+__naked void cpu_cgroup_storage_access_2(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	.8byte %[ld_map_fd];				\
+	.8byte 0;					\
+	call %[bpf_get_local_storage];			\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_insn(ld_map_fd, BPF_RAW_INSN(BPF_LD | BPF_DW | BPF_IMM, BPF_REG_1, BPF_PSEUDO_MAP_FD, 0, 1))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid per-cpu cgroup storage access 3")
+__failure __msg("invalid access to map value, value_size=64 off=256 size=4")
+__failure_unpriv
+__naked void cpu_cgroup_storage_access_3(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[percpu_cgroup_storage] ll;		\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 256);				\
+	r1 += 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(percpu_cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid per-cpu cgroup storage access 4")
+__failure __msg("invalid access to map value, value_size=64 off=-2 size=4")
+__failure_unpriv
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void cpu_cgroup_storage_access_4(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	r1 = %[cgroup_storage] ll;			\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 - 2);				\
+	r0 = r1;					\
+	r1 += 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid per-cpu cgroup storage access 5")
+__failure __msg("get_local_storage() doesn't support non-zero flags")
+__failure_unpriv
+__naked void cpu_cgroup_storage_access_5(void)
+{
+	asm volatile ("					\
+	r2 = 7;						\
+	r1 = %[percpu_cgroup_storage] ll;		\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(percpu_cgroup_storage)
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid per-cpu cgroup storage access 6")
+__failure __msg("get_local_storage() doesn't support non-zero flags")
+__msg_unpriv("R2 leaks addr into helper function")
+__naked void cpu_cgroup_storage_access_6(void)
+{
+	asm volatile ("					\
+	r2 = r1;					\
+	r1 = %[percpu_cgroup_storage] ll;		\
+	call %[bpf_get_local_storage];			\
+	r1 = *(u32*)(r0 + 0);				\
+	r0 = r1;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_local_storage),
+	  __imm_addr(percpu_cgroup_storage)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/cgroup_storage.c b/tools/testing/selftests/bpf/verifier/cgroup_storage.c
deleted file mode 100644
index 97057c0a1b8a..000000000000
--- a/tools/testing/selftests/bpf/verifier/cgroup_storage.c
+++ /dev/null
@@ -1,220 +0,0 @@
-{
-	"valid cgroup storage access",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_cgroup_storage = { 1 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid cgroup storage access 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1 },
-	.result = REJECT,
-	.errstr = "cannot pass map_type 1 into func bpf_get_local_storage",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid cgroup storage access 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "fd 1 is not pointing to valid bpf_map",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid cgroup storage access 3",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=64 off=256 size=4",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid cgroup storage access 4",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=64 off=-2 size=4",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid cgroup storage access 5",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 7),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "get_local_storage() doesn't support non-zero flags",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid cgroup storage access 6",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "get_local_storage() doesn't support non-zero flags",
-	.errstr_unpriv = "R2 leaks addr into helper function",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"valid per-cpu cgroup storage access",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_percpu_cgroup_storage = { 1 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid per-cpu cgroup storage access 1",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1 },
-	.result = REJECT,
-	.errstr = "cannot pass map_type 1 into func bpf_get_local_storage",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid per-cpu cgroup storage access 2",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 1),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "fd 1 is not pointing to valid bpf_map",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid per-cpu cgroup storage access 3",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 256),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_percpu_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=64 off=256 size=4",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid per-cpu cgroup storage access 4",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, -2),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=64 off=-2 size=4",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"invalid per-cpu cgroup storage access 5",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 7),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_percpu_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "get_local_storage() doesn't support non-zero flags",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid per-cpu cgroup storage access 6",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
-	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_percpu_cgroup_storage = { 1 },
-	.result = REJECT,
-	.errstr = "get_local_storage() doesn't support non-zero flags",
-	.errstr_unpriv = "R2 leaks addr into helper function",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-- 
2.40.0

