Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA386C8A7E
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjCYC45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCYC4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2601B30F
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so3508193wrh.6
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679713000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTOf/GbJ4x3k+Kpm314wgdyKa/MSn5Z98eW6vUIxYbk=;
        b=XU3nW8sb6swyIZtCIt4WXpe9f9sWGI1qzhLGbhr3ocWvVSDtUPvzk8AaGfCCO85h//
         9el5UifR2WUwrpfToNe97GMcVaatOkK2zSvsoM7dMaI0Qg0Hpla6bkAJkmIjwF+gbkn/
         r8uwer2YSbewL4Ed+/nOw9mr/Is+PawhDPdr8ZWr6edigUE2B0p3FfP1YC/+x+dD9duU
         GzZxWpeAkZ3im3rleyVmYJhA/M7Fq/uk7wJCMCUXLODSpZhsxOisq8VU0UhtXpuyXsSc
         h0M5wLvmJm5GY2R9mmr8LQc9Mln72Vc6JT1ug3F1sj85pgkf6lWFoNeBw4juFY8jlBhB
         2DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTOf/GbJ4x3k+Kpm314wgdyKa/MSn5Z98eW6vUIxYbk=;
        b=gT1sVUlwEbKAkh3hCfrL0eKFBM3XGdIzNk006oqf7DtNdADxokRKjybSm0sKQvOaHQ
         MKcgNA2GU+b61OeQqsv3lyGmVUA34iYXeBoJ6a17hqKOUETzV1UoxoeXr7hXVbU4yPNU
         R4N9+j1PZEGlnD1r6d9pdccT4migK660WvCeQshnTELkvNXj1Bh8Mt64GvKRLwNkiH94
         N9FDybJFvnWDJ60l5gI5+zPTmRO/Ru0skKm//4DAFEuc/picovBlsCsN2S0AJJ/0XB3Y
         wJ9m1ZTh9gdwVBPmFfNoJue8qeAbNGiF603EIJCUleUES3k27NvG0d33iZJdE+uMCsIB
         1EzA==
X-Gm-Message-State: AAQBX9coY5NuFobncRx60W6Pkosq++HnF6F7YacPDhSxjPjI7VRt8vd9
        X5KX0UJABMOqfc9A+5uq+L6zFkmOBVc=
X-Google-Smtp-Source: AKy350ZOO92j64pNrhX6LqMVuWr5pWSexKFUr8kvPsD2q0jLp1FU2oYsJBfTuade8ht4NzHHKNE1Lg==
X-Received: by 2002:a5d:6344:0:b0:2ce:b7a1:c1a3 with SMTP id b4-20020a5d6344000000b002ceb7a1c1a3mr3515829wrw.3.1679713000074;
        Fri, 24 Mar 2023 19:56:40 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:39 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 34/43] selftests/bpf: verifier/spill_fill.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:15 +0200
Message-Id: <20230325025524.144043-35-eddyz87@gmail.com>
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

Test verifier/spill_fill.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_spill_fill.c | 374 ++++++++++++++++++
 .../selftests/bpf/verifier/spill_fill.c       | 345 ----------------
 3 files changed, 376 insertions(+), 345 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_spill_fill.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/spill_fill.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index df5fc6fe1647..e2b131d2ba94 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -31,6 +31,7 @@
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
 #include "verifier_ringbuf.skel.h"
+#include "verifier_spill_fill.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -84,3 +85,4 @@ void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack); }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
+void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
new file mode 100644
index 000000000000..136e5530b72c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/spill_fill.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} map_ringbuf SEC(".maps");
+
+SEC("socket")
+__description("check valid spill/fill")
+__success __failure_unpriv __msg_unpriv("R0 leaks addr")
+__retval(POINTER_VALUE)
+__naked void check_valid_spill_fill(void)
+{
+	asm volatile ("					\
+	/* spill R1(ctx) into stack */			\
+	*(u64*)(r10 - 8) = r1;				\
+	/* fill it back into R2 */			\
+	r2 = *(u64*)(r10 - 8);				\
+	/* should be able to access R0 = *(R2 + 8) */	\
+	/* BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 8), */\
+	r0 = r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check valid spill/fill, skb mark")
+__success __success_unpriv __retval(0)
+__naked void valid_spill_fill_skb_mark(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	*(u64*)(r10 - 8) = r6;				\
+	r0 = *(u64*)(r10 - 8);				\
+	r0 = *(u32*)(r0 + %[__sk_buff_mark]);		\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check valid spill/fill, ptr to mem")
+__success __success_unpriv __retval(0)
+__naked void spill_fill_ptr_to_mem(void)
+{
+	asm volatile ("					\
+	/* reserve 8 byte ringbuf memory */		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_ringbuf_reserve];			\
+	/* store a pointer to the reserved memory in R6 */\
+	r6 = r0;					\
+	/* check whether the reservation was successful */\
+	if r0 == 0 goto l0_%=;				\
+	/* spill R6(mem) into the stack */		\
+	*(u64*)(r10 - 8) = r6;				\
+	/* fill it back in R7 */			\
+	r7 = *(u64*)(r10 - 8);				\
+	/* should be able to access *(R7) = 0 */	\
+	r1 = 0;						\
+	*(u64*)(r7 + 0) = r1;				\
+	/* submit the reserved ringbuf memory */	\
+	r1 = r7;					\
+	r2 = 0;						\
+	call %[bpf_ringbuf_submit];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_submit),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check with invalid reg offset 0")
+__failure __msg("R0 pointer arithmetic on ringbuf_mem_or_null prohibited")
+__failure_unpriv
+__naked void with_invalid_reg_offset_0(void)
+{
+	asm volatile ("					\
+	/* reserve 8 byte ringbuf memory */		\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = 8;						\
+	r3 = 0;						\
+	call %[bpf_ringbuf_reserve];			\
+	/* store a pointer to the reserved memory in R6 */\
+	r6 = r0;					\
+	/* add invalid offset to memory or NULL */	\
+	r0 += 1;					\
+	/* check whether the reservation was successful */\
+	if r0 == 0 goto l0_%=;				\
+	/* should not be able to access *(R7) = 0 */	\
+	r1 = 0;						\
+	*(u32*)(r6 + 0) = r1;				\
+	/* submit the reserved ringbuf memory */	\
+	r1 = r6;					\
+	r2 = 0;						\
+	call %[bpf_ringbuf_submit];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ringbuf_reserve),
+	  __imm(bpf_ringbuf_submit),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check corrupted spill/fill")
+__failure __msg("R0 invalid mem access 'scalar'")
+__msg_unpriv("attempt to corrupt spilled")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void check_corrupted_spill_fill(void)
+{
+	asm volatile ("					\
+	/* spill R1(ctx) into stack */			\
+	*(u64*)(r10 - 8) = r1;				\
+	/* mess up with R1 pointer on stack */		\
+	r0 = 0x23;					\
+	*(u8*)(r10 - 7) = r0;				\
+	/* fill back into R0 is fine for priv.		\
+	 * R0 now becomes SCALAR_VALUE.			\
+	 */						\
+	r0 = *(u64*)(r10 - 8);				\
+	/* Load from R0 should fail. */			\
+	r0 = *(u64*)(r0 + 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check corrupted spill/fill, LSB")
+__success __failure_unpriv __msg_unpriv("attempt to corrupt spilled")
+__retval(POINTER_VALUE)
+__naked void check_corrupted_spill_fill_lsb(void)
+{
+	asm volatile ("					\
+	*(u64*)(r10 - 8) = r1;				\
+	r0 = 0xcafe;					\
+	*(u16*)(r10 - 8) = r0;				\
+	r0 = *(u64*)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("check corrupted spill/fill, MSB")
+__success __failure_unpriv __msg_unpriv("attempt to corrupt spilled")
+__retval(POINTER_VALUE)
+__naked void check_corrupted_spill_fill_msb(void)
+{
+	asm volatile ("					\
+	*(u64*)(r10 - 8) = r1;				\
+	r0 = 0x12345678;				\
+	*(u32*)(r10 - 4) = r0;				\
+	r0 = *(u64*)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("Spill and refill a u32 const scalar.  Offset to skb->data")
+__success __retval(0)
+__naked void scalar_offset_to_skb_data_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	w4 = 20;					\
+	*(u32*)(r10 - 8) = r4;				\
+	r4 = *(u32*)(r10 - 8);				\
+	r0 = r2;					\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */	\
+	r0 += r4;					\
+	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
+	if r0 > r3 goto l0_%=;				\
+	/* r0 = *(u32 *)r2 R0=pkt,off=20,r=20 R2=pkt,r=20 R3=pkt_end R4=20 */\
+	r0 = *(u32*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("Spill a u32 const, refill from another half of the uninit u32 from the stack")
+/* in privileged mode reads from uninitialized stack locations are permitted */
+__success __failure_unpriv
+__msg_unpriv("invalid read from stack off -4+0 size 4")
+__retval(0)
+__naked void uninit_u32_from_the_stack(void)
+{
+	asm volatile ("					\
+	w4 = 20;					\
+	*(u32*)(r10 - 8) = r4;				\
+	/* r4 = *(u32 *)(r10 -4) fp-8=????rrrr*/	\
+	r4 = *(u32*)(r10 - 4);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("Spill a u32 const scalar.  Refill as u16.  Offset to skb->data")
+__failure __msg("invalid access to packet")
+__naked void u16_offset_to_skb_data(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	w4 = 20;					\
+	*(u32*)(r10 - 8) = r4;				\
+	r4 = *(u16*)(r10 - 8);				\
+	r0 = r2;					\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
+	r0 += r4;					\
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
+	if r0 > r3 goto l0_%=;				\
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
+	r0 = *(u32*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("Spill u32 const scalars.  Refill as u64.  Offset to skb->data")
+__failure __msg("invalid access to packet")
+__naked void u64_offset_to_skb_data(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	w6 = 0;						\
+	w7 = 20;					\
+	*(u32*)(r10 - 4) = r6;				\
+	*(u32*)(r10 - 8) = r7;				\
+	r4 = *(u16*)(r10 - 8);				\
+	r0 = r2;					\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
+	r0 += r4;					\
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
+	if r0 > r3 goto l0_%=;				\
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
+	r0 = *(u32*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data")
+__failure __msg("invalid access to packet")
+__naked void _6_offset_to_skb_data(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	w4 = 20;					\
+	*(u32*)(r10 - 8) = r4;				\
+	r4 = *(u16*)(r10 - 6);				\
+	r0 = r2;					\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
+	r0 += r4;					\
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
+	if r0 > r3 goto l0_%=;				\
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
+	r0 = *(u32*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("Spill and refill a u32 const scalar at non 8byte aligned stack addr.  Offset to skb->data")
+__failure __msg("invalid access to packet")
+__naked void addr_offset_to_skb_data(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	w4 = 20;					\
+	*(u32*)(r10 - 8) = r4;				\
+	*(u32*)(r10 - 4) = r4;				\
+	r4 = *(u32*)(r10 - 4);				\
+	r0 = r2;					\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=U32_MAX */\
+	r0 += r4;					\
+	/* if (r0 > r3) R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */\
+	if r0 > r3 goto l0_%=;				\
+	/* r0 = *(u32 *)r2 R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */\
+	r0 = *(u32*)(r2 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("Spill and refill a umax=40 bounded scalar.  Offset to skb->data")
+__success __retval(0)
+__naked void scalar_offset_to_skb_data_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = *(u64*)(r1 + %[__sk_buff_tstamp]);		\
+	if r4 <= 40 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	/* *(u32 *)(r10 -8) = r4 R4=umax=40 */		\
+	*(u32*)(r10 - 8) = r4;				\
+	/* r4 = (*u32 *)(r10 - 8) */			\
+	r4 = *(u32*)(r10 - 8);				\
+	/* r2 += r4 R2=pkt R4=umax=40 */		\
+	r2 += r4;					\
+	/* r0 = r2 R2=pkt,umax=40 R4=umax=40 */		\
+	r0 = r2;					\
+	/* r2 += 20 R0=pkt,umax=40 R2=pkt,umax=40 */	\
+	r2 += 20;					\
+	/* if (r2 > r3) R0=pkt,umax=40 R2=pkt,off=20,umax=40 */\
+	if r2 > r3 goto l1_%=;				\
+	/* r0 = *(u32 *)r0 R0=pkt,r=20,umax=40 R2=pkt,off=20,r=20,umax=40 */\
+	r0 = *(u32*)(r0 + 0);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(__sk_buff_tstamp, offsetof(struct __sk_buff, tstamp))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("Spill a u32 scalar at fp-4 and then at fp-8")
+__success __retval(0)
+__naked void and_then_at_fp_8(void)
+{
+	asm volatile ("					\
+	w4 = 4321;					\
+	*(u32*)(r10 - 4) = r4;				\
+	*(u32*)(r10 - 8) = r4;				\
+	r4 = *(u64*)(r10 - 8);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
deleted file mode 100644
index d1463bf4949a..000000000000
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ /dev/null
@@ -1,345 +0,0 @@
-{
-	"check valid spill/fill",
-	.insns = {
-	/* spill R1(ctx) into stack */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	/* fill it back into R2 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -8),
-	/* should be able to access R0 = *(R2 + 8) */
-	/* BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 8), */
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "R0 leaks addr",
-	.result = ACCEPT,
-	.result_unpriv = REJECT,
-	.retval = POINTER_VALUE,
-},
-{
-	"check valid spill/fill, skb mark",
-	.insns = {
-	BPF_ALU64_REG(BPF_MOV, BPF_REG_6, BPF_REG_1),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0,
-		    offsetof(struct __sk_buff, mark)),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.result_unpriv = ACCEPT,
-},
-{
-	"check valid spill/fill, ptr to mem",
-	.insns = {
-	/* reserve 8 byte ringbuf memory */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	/* store a pointer to the reserved memory in R6 */
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	/* spill R6(mem) into the stack */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, -8),
-	/* fill it back in R7 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, -8),
-	/* should be able to access *(R7) = 0 */
-	BPF_ST_MEM(BPF_DW, BPF_REG_7, 0, 0),
-	/* submit the reserved ringbuf memory */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 1 },
-	.result = ACCEPT,
-	.result_unpriv = ACCEPT,
-},
-{
-	"check with invalid reg offset 0",
-	.insns = {
-	/* reserve 8 byte ringbuf memory */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_reserve),
-	/* store a pointer to the reserved memory in R6 */
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
-	/* add invalid offset to memory or NULL */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
-	/* check whether the reservation was successful */
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	/* should not be able to access *(R7) = 0 */
-	BPF_ST_MEM(BPF_W, BPF_REG_6, 0, 0),
-	/* submit the reserved ringbuf memory */
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_ringbuf_submit),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_ringbuf = { 1 },
-	.result = REJECT,
-	.errstr = "R0 pointer arithmetic on ringbuf_mem_or_null prohibited",
-},
-{
-	"check corrupted spill/fill",
-	.insns = {
-	/* spill R1(ctx) into stack */
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	/* mess up with R1 pointer on stack */
-	BPF_ST_MEM(BPF_B, BPF_REG_10, -7, 0x23),
-	/* fill back into R0 is fine for priv.
-	 * R0 now becomes SCALAR_VALUE.
-	 */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	/* Load from R0 should fail. */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 8),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "attempt to corrupt spilled",
-	.errstr = "R0 invalid mem access 'scalar'",
-	.result = REJECT,
-	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
-},
-{
-	"check corrupted spill/fill, LSB",
-	.insns = {
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_ST_MEM(BPF_H, BPF_REG_10, -8, 0xcafe),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "attempt to corrupt spilled",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.retval = POINTER_VALUE,
-},
-{
-	"check corrupted spill/fill, MSB",
-	.insns = {
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0x12345678),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
-	BPF_EXIT_INSN(),
-	},
-	.errstr_unpriv = "attempt to corrupt spilled",
-	.result_unpriv = REJECT,
-	.result = ACCEPT,
-	.retval = POINTER_VALUE,
-},
-{
-	"Spill and refill a u32 const scalar.  Offset to skb->data",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	/* r4 = 20 */
-	BPF_MOV32_IMM(BPF_REG_4, 20),
-	/* *(u32 *)(r10 -8) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
-	/* r4 = *(u32 *)(r10 -8) */
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
-	/* r0 = r2 */
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
-	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	/* r0 = *(u32 *)r2 R0=pkt,off=20,r=20 R2=pkt,r=20 R3=pkt_end R4=20 */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"Spill a u32 const, refill from another half of the uninit u32 from the stack",
-	.insns = {
-	/* r4 = 20 */
-	BPF_MOV32_IMM(BPF_REG_4, 20),
-	/* *(u32 *)(r10 -8) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
-	/* r4 = *(u32 *)(r10 -4) fp-8=????rrrr*/
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "invalid read from stack off -4+0 size 4",
-	/* in privileged mode reads from uninitialized stack locations are permitted */
-	.result = ACCEPT,
-},
-{
-	"Spill a u32 const scalar.  Refill as u16.  Offset to skb->data",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	/* r4 = 20 */
-	BPF_MOV32_IMM(BPF_REG_4, 20),
-	/* *(u32 *)(r10 -8) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
-	/* r4 = *(u16 *)(r10 -8) */
-	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -8),
-	/* r0 = r2 */
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
-	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"Spill u32 const scalars.  Refill as u64.  Offset to skb->data",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	/* r6 = 0 */
-	BPF_MOV32_IMM(BPF_REG_6, 0),
-	/* r7 = 20 */
-	BPF_MOV32_IMM(BPF_REG_7, 20),
-	/* *(u32 *)(r10 -4) = r6 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_6, -4),
-	/* *(u32 *)(r10 -8) = r7 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7, -8),
-	/* r4 = *(u64 *)(r10 -8) */
-	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -8),
-	/* r0 = r2 */
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
-	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	/* r4 = 20 */
-	BPF_MOV32_IMM(BPF_REG_4, 20),
-	/* *(u32 *)(r10 -8) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
-	/* r4 = *(u16 *)(r10 -6) */
-	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -6),
-	/* r0 = r2 */
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
-	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"Spill and refill a u32 const scalar at non 8byte aligned stack addr.  Offset to skb->data",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	/* r4 = 20 */
-	BPF_MOV32_IMM(BPF_REG_4, 20),
-	/* *(u32 *)(r10 -8) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
-	/* *(u32 *)(r10 -4) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
-	/* r4 = *(u32 *)(r10 -4),  */
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
-	/* r0 = r2 */
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=U32_MAX */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
-	/* if (r0 > r3) R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
-	/* r0 = *(u32 *)r2 R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"Spill and refill a umax=40 bounded scalar.  Offset to skb->data",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1,
-		    offsetof(struct __sk_buff, tstamp)),
-	BPF_JMP_IMM(BPF_JLE, BPF_REG_4, 40, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	/* *(u32 *)(r10 -8) = r4 R4=umax=40 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
-	/* r4 = (*u32 *)(r10 - 8) */
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
-	/* r2 += r4 R2=pkt R4=umax=40 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_4),
-	/* r0 = r2 R2=pkt,umax=40 R4=umax=40 */
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
-	/* r2 += 20 R0=pkt,umax=40 R2=pkt,umax=40 */
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 20),
-	/* if (r2 > r3) R0=pkt,umax=40 R2=pkt,off=20,umax=40 */
-	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 1),
-	/* r0 = *(u32 *)r0 R0=pkt,r=20,umax=40 R2=pkt,off=20,r=20,umax=40 */
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"Spill a u32 scalar at fp-4 and then at fp-8",
-	.insns = {
-	/* r4 = 4321 */
-	BPF_MOV32_IMM(BPF_REG_4, 4321),
-	/* *(u32 *)(r10 -4) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
-	/* *(u32 *)(r10 -8) = r4 */
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
-	/* r4 = *(u64 *)(r10 -8) */
-	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-- 
2.40.0

