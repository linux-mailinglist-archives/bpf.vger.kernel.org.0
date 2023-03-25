Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2296C8A72
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCYC4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjCYC4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF31B2EA
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v1so3521062wrv.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK2gGpQ84fFfuSSChfCz7FwZ+pAmWYIk/5J1fuccX/Q=;
        b=OKwNiIHEWqBQCptsMJrz1VT3boK8aUQgQoK8Z5B/1d+jp5e9rCm79WlwyZ5sW8/4Jb
         bImRAkGpsZsyuG9sS4j0ufFc7hv3X4oPjxLP3D/ZlLZfMKBj1nce8Aka2pPqDdpQF9e3
         32Sr1hMs2GyHDwgaM2R/3XifSp5zpEMOFNLjGNnmdz/4A8HsCF9RYyZtD6lkr4Md/Xid
         ez2V+gpeOnU18VTur7KQf4YkYbOebS/3aP7YFi+ZH+clUUM6fh63hE3YFRSbUiptkqsJ
         jP1XzZNrbyb65FJRAKT4NG2Vmx4votzjcG6TiTDoaacBxrlsfMcyJ2j2fcV0pq4I1LR/
         sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK2gGpQ84fFfuSSChfCz7FwZ+pAmWYIk/5J1fuccX/Q=;
        b=6rU/XVuA7f001OmIv5EQVlAnxEL2qtXKyg2d7nhxdvszZrJg0mwtYzUt+P6ZTcfwbT
         iuaMUKjDMoCs+aeIAI+ilSpiLNHrVmnM+Dn8K1mlSrNAVE7/MwXWGJ/dqbdExHuQ5mG0
         V3uPG6BsN3g+Q+cE+27DLsQt0mZkjJ6nByEHhRoT6/L6QN5LnxGMZuNXprC8UKHu39A/
         l20cVZMDcsUbnasxZlmC/DZiLx3L2CCabHEXUoXNkoAQZpnVNEMFCXN/pLGtYjkdZzBA
         52mCGocYv0JOstZ2bNNd58sbCVBhafOO/FLa6BiPWnk8svMiOBcRgtZCaQM1DKuNcnNm
         R5SA==
X-Gm-Message-State: AAQBX9cF3flTL1h5kEvfP8XJ/1G0AJoYnnYXX3GD936g8zTrP1sayqUG
        FZpVht/1zLyT6ebkcirPBWxkfUNL0gg=
X-Google-Smtp-Source: AKy350ZF339Zk1bt0WrTmtFcv1xm9zhaHLMANQ9Ob9cIvVzD8LVVvD2IF6XUmaQHLdZqm0Lhh/dFhQ==
X-Received: by 2002:a5d:434a:0:b0:2db:b1cb:8e28 with SMTP id u10-20020a5d434a000000b002dbb1cb8e28mr3807386wrr.0.1679712985481;
        Fri, 24 Mar 2023 19:56:25 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:24 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 23/43] selftests/bpf: verifier/helper_value_access.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:04 +0200
Message-Id: <20230325025524.144043-24-eddyz87@gmail.com>
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

Test verifier/helper_value_access.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../bpf/progs/verifier_helper_value_access.c  | 1245 +++++++++++++++++
 .../bpf/verifier/helper_value_access.c        |  953 -------------
 3 files changed, 1247 insertions(+), 953 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_value_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 02983d1de218..2c3745a1fdcb 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -20,6 +20,7 @@
 #include "verifier_helper_access_var_len.skel.h"
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
+#include "verifier_helper_value_access.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -62,3 +63,4 @@ void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_len); }
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
+void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
new file mode 100644
index 000000000000..692216c0ad3d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_value_access.c
@@ -0,0 +1,1245 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/helper_value_access.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+#define MAX_ENTRIES 11
+
+struct test_val {
+	unsigned int index;
+	int foo[MAX_ENTRIES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, struct test_val);
+} map_hash_48b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("tracepoint")
+__description("helper access to map: full range")
+__success
+__naked void access_to_map_full_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = %[sizeof_test_val];			\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(sizeof_test_val, sizeof(struct test_val))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: partial range")
+__success
+__naked void access_to_map_partial_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: empty range")
+__failure __msg("invalid access to map value, value_size=48 off=0 size=0")
+__naked void access_to_map_empty_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = 0;						\
+	call %[bpf_trace_printk];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_trace_printk),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: out-of-bound range")
+__failure __msg("invalid access to map value, value_size=48 off=0 size=56")
+__naked void map_out_of_bound_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) + 8)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: negative range")
+__failure __msg("R2 min value is negative")
+__naked void access_to_map_negative_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r2 = -8;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const imm): full range")
+__success
+__naked void via_const_imm_full_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += %[test_val_foo];				\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - offsetof(struct test_val, foo)),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const imm): partial range")
+__success
+__naked void via_const_imm_partial_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += %[test_val_foo];				\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const imm): empty range")
+__failure __msg("invalid access to map value, value_size=48 off=4 size=0")
+__naked void via_const_imm_empty_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += %[test_val_foo];				\
+	r2 = 0;						\
+	call %[bpf_trace_printk];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_trace_printk),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const imm): out-of-bound range")
+__failure __msg("invalid access to map value, value_size=48 off=4 size=52")
+__naked void imm_out_of_bound_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += %[test_val_foo];				\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - offsetof(struct test_val, foo) + 8),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const imm): negative range (> adjustment)")
+__failure __msg("R2 min value is negative")
+__naked void const_imm_negative_range_adjustment_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += %[test_val_foo];				\
+	r2 = -8;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const imm): negative range (< adjustment)")
+__failure __msg("R2 min value is negative")
+__naked void const_imm_negative_range_adjustment_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r1 += %[test_val_foo];				\
+	r2 = -1;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const reg): full range")
+__success
+__naked void via_const_reg_full_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = %[test_val_foo];				\
+	r1 += r3;					\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - offsetof(struct test_val, foo)),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const reg): partial range")
+__success
+__naked void via_const_reg_partial_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = %[test_val_foo];				\
+	r1 += r3;					\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const reg): empty range")
+__failure __msg("R1 min value is outside of the allowed memory range")
+__naked void via_const_reg_empty_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = 0;						\
+	r1 += r3;					\
+	r2 = 0;						\
+	call %[bpf_trace_printk];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_trace_printk),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const reg): out-of-bound range")
+__failure __msg("invalid access to map value, value_size=48 off=4 size=52")
+__naked void reg_out_of_bound_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = %[test_val_foo];				\
+	r1 += r3;					\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - offsetof(struct test_val, foo) + 8),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const reg): negative range (> adjustment)")
+__failure __msg("R2 min value is negative")
+__naked void const_reg_negative_range_adjustment_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = %[test_val_foo];				\
+	r1 += r3;					\
+	r2 = -8;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via const reg): negative range (< adjustment)")
+__failure __msg("R2 min value is negative")
+__naked void const_reg_negative_range_adjustment_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = %[test_val_foo];				\
+	r1 += r3;					\
+	r2 = -1;					\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via variable): full range")
+__success
+__naked void map_via_variable_full_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 > %[test_val_foo] goto l0_%=;		\
+	r1 += r3;					\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - offsetof(struct test_val, foo)),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via variable): partial range")
+__success
+__naked void map_via_variable_partial_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 > %[test_val_foo] goto l0_%=;		\
+	r1 += r3;					\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via variable): empty range")
+__failure __msg("R1 min value is outside of the allowed memory range")
+__naked void map_via_variable_empty_range(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 > %[test_val_foo] goto l0_%=;		\
+	r1 += r3;					\
+	r2 = 0;						\
+	call %[bpf_trace_printk];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_trace_printk),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via variable): no max check")
+__failure __msg("R1 unbounded memory access")
+__naked void via_variable_no_max_check_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	r1 += r3;					\
+	r2 = 1;						\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to adjusted map (via variable): wrong max check")
+__failure __msg("invalid access to map value, value_size=48 off=4 size=45")
+__naked void via_variable_wrong_max_check_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 > %[test_val_foo] goto l0_%=;		\
+	r1 += r3;					\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	call %[bpf_probe_read_kernel];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_probe_read_kernel),
+	  __imm_addr(map_hash_48b),
+	  __imm_const(__imm_0, sizeof(struct test_val) - offsetof(struct test_val, foo) + 1),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using <, good access")
+__success
+__naked void bounds_check_using_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 < 32 goto l1_%=;				\
+	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using <, bad access")
+__failure __msg("R1 unbounded memory access")
+__naked void bounds_check_using_bad_access_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 < 32 goto l1_%=;				\
+	r1 += r3;					\
+l0_%=:	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using <=, good access")
+__success
+__naked void bounds_check_using_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 <= 32 goto l1_%=;				\
+	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using <=, bad access")
+__failure __msg("R1 unbounded memory access")
+__naked void bounds_check_using_bad_access_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 <= 32 goto l1_%=;				\
+	r1 += r3;					\
+l0_%=:	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using s<, good access")
+__success
+__naked void check_using_s_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 s< 32 goto l1_%=;				\
+l2_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	if r3 s< 0 goto l2_%=;				\
+	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using s<, good access 2")
+__success
+__naked void using_s_good_access_2_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 s< 32 goto l1_%=;				\
+l2_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	if r3 s< -3 goto l2_%=;				\
+	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using s<, bad access")
+__failure __msg("R1 min value is negative")
+__naked void check_using_s_bad_access_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u64*)(r0 + 0);				\
+	if r3 s< 32 goto l1_%=;				\
+l2_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	if r3 s< -3 goto l2_%=;				\
+	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using s<=, good access")
+__success
+__naked void check_using_s_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 s<= 32 goto l1_%=;			\
+l2_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	if r3 s<= 0 goto l2_%=;				\
+	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using s<=, good access 2")
+__success
+__naked void using_s_good_access_2_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 s<= 32 goto l1_%=;			\
+l2_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	if r3 s<= -3 goto l2_%=;			\
+	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("helper access to map: bounds check using s<=, bad access")
+__failure __msg("R1 min value is negative")
+__naked void check_using_s_bad_access_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_48b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r1 = r0;					\
+	r3 = *(u64*)(r0 + 0);				\
+	if r3 s<= 32 goto l1_%=;			\
+l2_%=:	r0 = 0;						\
+l0_%=:	exit;						\
+l1_%=:	if r3 s<= -3 goto l2_%=;			\
+	r1 += r3;					\
+	r0 = 0;						\
+	*(u8*)(r1 + 0) = r0;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_48b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map lookup helper access to map")
+__success
+__naked void lookup_helper_access_to_map(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map update helper access to map")
+__success
+__naked void update_helper_access_to_map(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r4 = 0;						\
+	r3 = r0;					\
+	r2 = r0;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_update_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_map_update_elem),
+	  __imm_addr(map_hash_16b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map update helper access to map: wrong size")
+__failure __msg("invalid access to map value, value_size=8 off=0 size=16")
+__naked void access_to_map_wrong_size(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r4 = 0;						\
+	r3 = r0;					\
+	r2 = r0;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_update_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_map_update_elem),
+	  __imm_addr(map_hash_16b),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via const imm)")
+__success
+__naked void adjusted_map_via_const_imm(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r2 += %[other_val_bar];				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(other_val_bar, offsetof(struct other_val, bar))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via const imm): out-of-bound 1")
+__failure __msg("invalid access to map value, value_size=16 off=12 size=8")
+__naked void imm_out_of_bound_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r2 += %[__imm_0];				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__imm_0, sizeof(struct other_val) - 4)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via const imm): out-of-bound 2")
+__failure __msg("invalid access to map value, value_size=16 off=-4 size=8")
+__naked void imm_out_of_bound_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r2 += -4;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via const reg)")
+__success
+__naked void adjusted_map_via_const_reg(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r3 = %[other_val_bar];				\
+	r2 += r3;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(other_val_bar, offsetof(struct other_val, bar))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via const reg): out-of-bound 1")
+__failure __msg("invalid access to map value, value_size=16 off=12 size=8")
+__naked void reg_out_of_bound_1(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r3 = %[__imm_0];				\
+	r2 += r3;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__imm_0, sizeof(struct other_val) - 4)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via const reg): out-of-bound 2")
+__failure __msg("invalid access to map value, value_size=16 off=-4 size=8")
+__naked void reg_out_of_bound_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r3 = -4;					\
+	r2 += r3;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via variable)")
+__success
+__naked void to_adjusted_map_via_variable(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 > %[other_val_bar] goto l0_%=;		\
+	r2 += r3;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(other_val_bar, offsetof(struct other_val, bar))
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via variable): no max check")
+__failure
+__msg("R2 unbounded memory access, make sure to bounds check any such access")
+__naked void via_variable_no_max_check_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	r2 += r3;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("map helper access to adjusted map (via variable): wrong max check")
+__failure __msg("invalid access to map value, value_size=16 off=9 size=8")
+__naked void via_variable_wrong_max_check_2(void)
+{
+	asm volatile ("					\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = 0;						\
+	*(u64*)(r2 + 0) = r1;				\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r2 = r0;					\
+	r3 = *(u32*)(r0 + 0);				\
+	if r3 > %[__imm_0] goto l0_%=;			\
+	r2 += r3;					\
+	r1 = %[map_hash_16b] ll;			\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_16b),
+	  __imm_const(__imm_0, offsetof(struct other_val, bar) + 1)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/helper_value_access.c b/tools/testing/selftests/bpf/verifier/helper_value_access.c
deleted file mode 100644
index 1c7882ddfa63..000000000000
--- a/tools/testing/selftests/bpf/verifier/helper_value_access.c
+++ /dev/null
@@ -1,953 +0,0 @@
-{
-	"helper access to map: full range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val)),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: partial range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: empty range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_trace_printk),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "invalid access to map value, value_size=48 off=0 size=0",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: out-of-bound range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, sizeof(struct test_val) + 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "invalid access to map value, value_size=48 off=0 size=56",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: negative range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_2, -8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R2 min value is negative",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const imm): full range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_2,
-		      sizeof(struct test_val) -	offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const imm): partial range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const imm): empty range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_trace_printk),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "invalid access to map value, value_size=48 off=4 size=0",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const imm): out-of-bound range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_2,
-		      sizeof(struct test_val) - offsetof(struct test_val, foo) + 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "invalid access to map value, value_size=48 off=4 size=52",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const imm): negative range (> adjustment)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_2, -8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R2 min value is negative",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const imm): negative range (< adjustment)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R2 min value is negative",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const reg): full range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2,
-		      sizeof(struct test_val) - offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const reg): partial range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const reg): empty range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_trace_printk),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R1 min value is outside of the allowed memory range",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const reg): out-of-bound range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2,
-		      sizeof(struct test_val) -
-		      offsetof(struct test_val, foo) + 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "invalid access to map value, value_size=48 off=4 size=52",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const reg): negative range (> adjustment)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2, -8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R2 min value is negative",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via const reg): negative range (< adjustment)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct test_val, foo)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2, -1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R2 min value is negative",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via variable): full range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2,
-		      sizeof(struct test_val) - offsetof(struct test_val, foo)),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via variable): partial range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via variable): empty range",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_trace_printk),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R1 min value is outside of the allowed memory range",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via variable): no max check",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "R1 unbounded memory access",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to adjusted map (via variable): wrong max check",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct test_val, foo), 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_MOV64_IMM(BPF_REG_2,
-		      sizeof(struct test_val) -
-		      offsetof(struct test_val, foo) + 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.errstr = "invalid access to map value, value_size=48 off=4 size=45",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using <, good access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using <, bad access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLT, BPF_REG_3, 32, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R1 unbounded memory access",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using <=, good access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using <=, bad access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_3, 32, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R1 unbounded memory access",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using s<, good access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 0, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using s<, good access 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, -3, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using s<, bad access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLT, BPF_REG_3, -3, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R1 min value is negative",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using s<=, good access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 0, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using s<=, good access 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, -3, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"helper access to map: bounds check using s<=, bad access",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, 32, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_JMP_IMM(BPF_JSLE, BPF_REG_3, -3, -3),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_3),
-	BPF_ST_MEM(BPF_B, BPF_REG_1, 0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_48b = { 3 },
-	.result = REJECT,
-	.errstr = "R1 min value is negative",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map lookup helper access to map",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 8 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map update helper access to map",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_update_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 10 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map update helper access to map: wrong size",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_update_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 3 },
-	.fixup_map_hash_16b = { 10 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=8 off=0 size=16",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via const imm)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, offsetof(struct other_val, bar)),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 9 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via const imm): out-of-bound 1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, sizeof(struct other_val) - 4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 9 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=16 off=12 size=8",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via const imm): out-of-bound 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 9 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=16 off=-4 size=8",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via const reg)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, offsetof(struct other_val, bar)),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 10 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via const reg): out-of-bound 1",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, sizeof(struct other_val) - 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 10 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=16 off=12 size=8",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via const reg): out-of-bound 2",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_MOV64_IMM(BPF_REG_3, -4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 10 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=16 off=-4 size=8",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via variable)",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct other_val, bar), 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 11 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via variable): no max check",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 10 },
-	.result = REJECT,
-	.errstr = "R2 unbounded memory access, make sure to bounds check any such access",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-{
-	"map helper access to adjusted map (via variable): wrong max check",
-	.insns = {
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_0, 0),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, offsetof(struct other_val, bar) + 1, 4),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_16b = { 3, 11 },
-	.result = REJECT,
-	.errstr = "invalid access to map value, value_size=16 off=9 size=8",
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
-},
-- 
2.40.0

