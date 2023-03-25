Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3247F6C8A69
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjCYC4S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjCYC4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D651B2C1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4187551wmb.0
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlaIZs/IkkBptzr0u20dosL0OjImscdrFg/Y8qd3Nhs=;
        b=iwXm5sZxZNR1J+/wwUm2+oVy8rJyHSKgssrWmixC3ceLHuBYbjNm2aFkmGjghTnOIm
         3PvpI04zMPycKzVSIDUeqm76mZK5D+bM8eroz9Y+wfPP+wncrG0Yul9DmhCqFevT2+R2
         DnHpyFtfvMJHOrqM/z0R+Fo+Npcrh68yxMHB/i2HmBsZCgcXKe1YXBulpDbX9h1rQxzU
         wtkjJa1bLASSSRaym5R3wPBbC5TF/qdMfyJ7wBNxinnO/N/cYMisWSrijxgIP0/pfEhI
         Y/Mq3yZZxzMT3uMMg22iOih9vr/fywDKEI7IjECXF9BdkDHu2XdxpRwuOZvxfe4uW0gR
         7p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlaIZs/IkkBptzr0u20dosL0OjImscdrFg/Y8qd3Nhs=;
        b=ErdDd92feo1+FYGxXJtp7FklOtopmHoQwDX4hfIRqqEWIcBB9FB4iAHWut/gx1LdZ8
         xWHeWBOtqwkPHxJL+gAk69sSwo8MIqhTnhHqw+Hk4b1bp0nEQMbmi+iEvWItqHkdGhwe
         B9mvwUQSuoSea0SHHjO00UiiUbQ+NctlUfNBFWj5TuP/1R+KbXxEsWomhEsqGFW8LPpj
         0eBRnfrmgfrg4rB8apr/5XcUwniCOAPHZluI/poLWiOHpYdR0VZ2JJIN+P9Hm9mI6Zja
         44Hh4dJvt0mKZYSMHOFn+DQpo0i2qSqophwbjmP+0n9hQwwVkAFHbZEUbLiZ4581i5iY
         mr+Q==
X-Gm-Message-State: AAQBX9fBRXtZGMkj9HFA/Sg19fw7vCvHi7RINaqj0FjvpTkZEfrSU/Kq
        sIUvU+mPJaaqSfOH14DIj3cTXV6j7nA=
X-Google-Smtp-Source: AKy350b8M1EKKt6aCyVtnqmqjPQZLo60A08VAWgOJUb7Ez820FHmWxRyKm7zTdMbatuCUiOCbIBF7w==
X-Received: by 2002:a7b:c005:0:b0:3ef:5dd6:2f94 with SMTP id c5-20020a7bc005000000b003ef5dd62f94mr2374590wmb.31.1679712971583;
        Fri, 24 Mar 2023 19:56:11 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:11 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 13/43] selftests/bpf: verifier/cgroup_skb.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:54:54 +0200
Message-Id: <20230325025524.144043-14-eddyz87@gmail.com>
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

Test verifier/cgroup_skb.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_cgroup_skb.c | 227 ++++++++++++++++++
 .../selftests/bpf/verifier/cgroup_skb.c       | 197 ---------------
 3 files changed, 229 insertions(+), 197 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup_skb.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/cgroup_skb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b138c9894abb..53e41af90821 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -10,6 +10,7 @@
 #include "verifier_bounds_mix_sign_unsign.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
+#include "verifier_cgroup_skb.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -42,3 +43,4 @@ void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction);
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
+void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_skb.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_skb.c
new file mode 100644
index 000000000000..5ee3d349d6d0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_skb.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/cgroup_skb.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("cgroup/skb")
+__description("direct packet read test#1 for CGROUP_SKB")
+__success __failure_unpriv
+__msg_unpriv("invalid bpf_context access off=76 size=4")
+__retval(0)
+__naked void test_1_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_len]);		\
+	r5 = *(u32*)(r1 + %[__sk_buff_pkt_type]);	\
+	r6 = *(u32*)(r1 + %[__sk_buff_mark]);		\
+	*(u32*)(r1 + %[__sk_buff_mark]) = r6;		\
+	r7 = *(u32*)(r1 + %[__sk_buff_queue_mapping]);	\
+	r8 = *(u32*)(r1 + %[__sk_buff_protocol]);	\
+	r9 = *(u32*)(r1 + %[__sk_buff_vlan_present]);	\
+	r0 = r2;					\
+	r0 += 8;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_len, offsetof(struct __sk_buff, len)),
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark)),
+	  __imm_const(__sk_buff_pkt_type, offsetof(struct __sk_buff, pkt_type)),
+	  __imm_const(__sk_buff_protocol, offsetof(struct __sk_buff, protocol)),
+	  __imm_const(__sk_buff_queue_mapping, offsetof(struct __sk_buff, queue_mapping)),
+	  __imm_const(__sk_buff_vlan_present, offsetof(struct __sk_buff, vlan_present))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("direct packet read test#2 for CGROUP_SKB")
+__success __success_unpriv __retval(0)
+__naked void test_2_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r4 = *(u32*)(r1 + %[__sk_buff_vlan_tci]);	\
+	r5 = *(u32*)(r1 + %[__sk_buff_vlan_proto]);	\
+	r6 = *(u32*)(r1 + %[__sk_buff_priority]);	\
+	*(u32*)(r1 + %[__sk_buff_priority]) = r6;	\
+	r7 = *(u32*)(r1 + %[__sk_buff_ingress_ifindex]);\
+	r8 = *(u32*)(r1 + %[__sk_buff_tc_index]);	\
+	r9 = *(u32*)(r1 + %[__sk_buff_hash]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_hash, offsetof(struct __sk_buff, hash)),
+	  __imm_const(__sk_buff_ingress_ifindex, offsetof(struct __sk_buff, ingress_ifindex)),
+	  __imm_const(__sk_buff_priority, offsetof(struct __sk_buff, priority)),
+	  __imm_const(__sk_buff_tc_index, offsetof(struct __sk_buff, tc_index)),
+	  __imm_const(__sk_buff_vlan_proto, offsetof(struct __sk_buff, vlan_proto)),
+	  __imm_const(__sk_buff_vlan_tci, offsetof(struct __sk_buff, vlan_tci))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("direct packet read test#3 for CGROUP_SKB")
+__success __success_unpriv __retval(0)
+__naked void test_3_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r4 = *(u32*)(r1 + %[__sk_buff_cb_0]);		\
+	r5 = *(u32*)(r1 + %[__sk_buff_cb_1]);		\
+	r6 = *(u32*)(r1 + %[__sk_buff_cb_2]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_cb_3]);		\
+	r8 = *(u32*)(r1 + %[__sk_buff_cb_4]);		\
+	r9 = *(u32*)(r1 + %[__sk_buff_napi_id]);	\
+	*(u32*)(r1 + %[__sk_buff_cb_0]) = r4;		\
+	*(u32*)(r1 + %[__sk_buff_cb_1]) = r5;		\
+	*(u32*)(r1 + %[__sk_buff_cb_2]) = r6;		\
+	*(u32*)(r1 + %[__sk_buff_cb_3]) = r7;		\
+	*(u32*)(r1 + %[__sk_buff_cb_4]) = r8;		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_cb_0, offsetof(struct __sk_buff, cb[0])),
+	  __imm_const(__sk_buff_cb_1, offsetof(struct __sk_buff, cb[1])),
+	  __imm_const(__sk_buff_cb_2, offsetof(struct __sk_buff, cb[2])),
+	  __imm_const(__sk_buff_cb_3, offsetof(struct __sk_buff, cb[3])),
+	  __imm_const(__sk_buff_cb_4, offsetof(struct __sk_buff, cb[4])),
+	  __imm_const(__sk_buff_napi_id, offsetof(struct __sk_buff, napi_id))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("direct packet read test#4 for CGROUP_SKB")
+__success __success_unpriv __retval(0)
+__naked void test_4_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_family]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_remote_ip4]);	\
+	r4 = *(u32*)(r1 + %[__sk_buff_local_ip4]);	\
+	r5 = *(u32*)(r1 + %[__sk_buff_remote_ip6_0]);	\
+	r5 = *(u32*)(r1 + %[__sk_buff_remote_ip6_1]);	\
+	r5 = *(u32*)(r1 + %[__sk_buff_remote_ip6_2]);	\
+	r5 = *(u32*)(r1 + %[__sk_buff_remote_ip6_3]);	\
+	r6 = *(u32*)(r1 + %[__sk_buff_local_ip6_0]);	\
+	r6 = *(u32*)(r1 + %[__sk_buff_local_ip6_1]);	\
+	r6 = *(u32*)(r1 + %[__sk_buff_local_ip6_2]);	\
+	r6 = *(u32*)(r1 + %[__sk_buff_local_ip6_3]);	\
+	r7 = *(u32*)(r1 + %[__sk_buff_remote_port]);	\
+	r8 = *(u32*)(r1 + %[__sk_buff_local_port]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_family, offsetof(struct __sk_buff, family)),
+	  __imm_const(__sk_buff_local_ip4, offsetof(struct __sk_buff, local_ip4)),
+	  __imm_const(__sk_buff_local_ip6_0, offsetof(struct __sk_buff, local_ip6[0])),
+	  __imm_const(__sk_buff_local_ip6_1, offsetof(struct __sk_buff, local_ip6[1])),
+	  __imm_const(__sk_buff_local_ip6_2, offsetof(struct __sk_buff, local_ip6[2])),
+	  __imm_const(__sk_buff_local_ip6_3, offsetof(struct __sk_buff, local_ip6[3])),
+	  __imm_const(__sk_buff_local_port, offsetof(struct __sk_buff, local_port)),
+	  __imm_const(__sk_buff_remote_ip4, offsetof(struct __sk_buff, remote_ip4)),
+	  __imm_const(__sk_buff_remote_ip6_0, offsetof(struct __sk_buff, remote_ip6[0])),
+	  __imm_const(__sk_buff_remote_ip6_1, offsetof(struct __sk_buff, remote_ip6[1])),
+	  __imm_const(__sk_buff_remote_ip6_2, offsetof(struct __sk_buff, remote_ip6[2])),
+	  __imm_const(__sk_buff_remote_ip6_3, offsetof(struct __sk_buff, remote_ip6[3])),
+	  __imm_const(__sk_buff_remote_port, offsetof(struct __sk_buff, remote_port))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid access of tc_classid for CGROUP_SKB")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv
+__naked void tc_classid_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_tc_classid]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_tc_classid, offsetof(struct __sk_buff, tc_classid))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid access of data_meta for CGROUP_SKB")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv
+__naked void data_meta_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_data_meta]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data_meta, offsetof(struct __sk_buff, data_meta))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid access of flow_keys for CGROUP_SKB")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv
+__naked void flow_keys_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r0 = *(u32*)(r1 + %[__sk_buff_flow_keys]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("invalid write access to napi_id for CGROUP_SKB")
+__failure __msg("invalid bpf_context access")
+__failure_unpriv
+__naked void napi_id_for_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r9 = *(u32*)(r1 + %[__sk_buff_napi_id]);	\
+	*(u32*)(r1 + %[__sk_buff_napi_id]) = r9;	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_napi_id, offsetof(struct __sk_buff, napi_id))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("write tstamp from CGROUP_SKB")
+__success __failure_unpriv
+__msg_unpriv("invalid bpf_context access off=152 size=8")
+__retval(0)
+__naked void write_tstamp_from_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64*)(r1 + %[__sk_buff_tstamp]) = r0;		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_tstamp, offsetof(struct __sk_buff, tstamp))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("read tstamp from CGROUP_SKB")
+__success __success_unpriv __retval(0)
+__naked void read_tstamp_from_cgroup_skb(void)
+{
+	asm volatile ("					\
+	r0 = *(u64*)(r1 + %[__sk_buff_tstamp]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_tstamp, offsetof(struct __sk_buff, tstamp))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/cgroup_skb.c b/tools/testing/selftests/bpf/verifier/cgroup_skb.c
deleted file mode 100644
index 52e4c03b076b..000000000000
--- a/tools/testing/selftests/bpf/verifier/cgroup_skb.c
+++ /dev/null
@@ -1,197 +0,0 @@
-{
-	"direct packet read test#1 for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct __sk_buff, len)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1,
-		    offsetof(struct __sk_buff, pkt_type)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_6,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, queue_mapping)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
-		    offsetof(struct __sk_buff, protocol)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
-		    offsetof(struct __sk_buff, vlan_present)),
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "invalid bpf_context access off=76 size=4",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"direct packet read test#2 for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct __sk_buff, vlan_tci)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1,
-		    offsetof(struct __sk_buff, vlan_proto)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, priority)),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_6,
-		    offsetof(struct __sk_buff, priority)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, ingress_ifindex)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
-		    offsetof(struct __sk_buff, tc_index)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
-		    offsetof(struct __sk_buff, hash)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"direct packet read test#3 for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[1])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[2])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[3])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
-		    offsetof(struct __sk_buff, cb[4])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
-		    offsetof(struct __sk_buff, napi_id)),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_4,
-		    offsetof(struct __sk_buff, cb[0])),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_5,
-		    offsetof(struct __sk_buff, cb[1])),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_6,
-		    offsetof(struct __sk_buff, cb[2])),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_7,
-		    offsetof(struct __sk_buff, cb[3])),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_8,
-		    offsetof(struct __sk_buff, cb[4])),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"direct packet read test#4 for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, family)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, remote_ip4)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct __sk_buff, local_ip4)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1,
-		    offsetof(struct __sk_buff, remote_ip6[0])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1,
-		    offsetof(struct __sk_buff, remote_ip6[1])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1,
-		    offsetof(struct __sk_buff, remote_ip6[2])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1,
-		    offsetof(struct __sk_buff, remote_ip6[3])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, local_ip6[0])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, local_ip6[1])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, local_ip6[2])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, local_ip6[3])),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, remote_port)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_8, BPF_REG_1,
-		    offsetof(struct __sk_buff, local_port)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid access of tc_classid for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, tc_classid)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid access of data_meta for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_meta)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid access of flow_keys for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, flow_keys)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"invalid write access to napi_id for CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
-		    offsetof(struct __sk_buff, napi_id)),
-	BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_9,
-		    offsetof(struct __sk_buff, napi_id)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid bpf_context access",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"write tstamp from CGROUP_SKB",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0,
-		    offsetof(struct __sk_buff, tstamp)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "invalid bpf_context access off=152 size=8",
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-{
-	"read tstamp from CGROUP_SKB",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
-		    offsetof(struct __sk_buff, tstamp)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-},
-- 
2.40.0

