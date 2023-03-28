Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C36CB395
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 04:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC1CId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 22:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjC1CIc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 22:08:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3951716
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 19:08:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so43704659edd.5
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iNBT376BEaA61gbYVX8cRtbTNE7Dhd2Y0V6AwtUt5g=;
        b=Vloy2s5Iz17JjoitgCIgaMtfyIZSXaYeh/BBvx0UbNvG5l1v9raEYB8PKLU/iPZch2
         hkGuDcNXXN9lNYAZxokNL4Hl9/AN1GHL3wzBKoqKe4+niXfRazr79YckODXj3wgzBH5n
         DR2vs3cAac94rHNMBHaUXzg7runGgoVGQ6U+aQeGpCUZTKJ8khQFfY1RUu4FkPsaRee3
         ResyCaZOWOMXjagBhSn5RNdCoap/BpoF84nqihT7AVALH0oGNxpqV4+OO7lAEFu/6Mst
         GIHTieqoG/37/KPzj5yoN1aB+QFD0EuAwiBheNPpfJcJliptez78lsqUOCoeppemnPBd
         3wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iNBT376BEaA61gbYVX8cRtbTNE7Dhd2Y0V6AwtUt5g=;
        b=8QZbVFwsPvQtUZ8ACWDFMCUNeJR6jd8SEkVe41uW1EIK0YDGLVqLRUhp+gl0pw2A+Z
         Ky3C0B2SaMmMFtvMX2xOKVC7YaCLjuxxTG+V2yqWTHOlnu2xlS098gbTq68KvaQ1E51b
         OYUQPtgq8Yxzk/3gV7GXUPb0dLossRomSDmg9xtdKQ83CeR6XJt56y5l77OlOOLVvnr6
         cdTUWNOtK9gcpcpsTF5Ehjr3PBOZZFXKwrqswkE0I56ThWTx1Aiwp60nFY+Ab7+xNS1P
         Sow/knV3YOS6fkGnSz2KuZ7mpHqAQSvJYNSOrWBDJIlwFkcrwwChOvg1O+Hl5UMjimcW
         XOeA==
X-Gm-Message-State: AAQBX9feSiW4RQjIuXmeUlLc4CMXfoz3Zy4hd/blS6p0163bMTT/aBzH
        HraRHKPKph/qAW+Q2eTl+A6SIu1xNWsQXQ==
X-Google-Smtp-Source: AKy350ZaHRQ9ai12TS4bg1V8IAUP/dhfV698EQnWR9AVMHjWM5iej7Q+zWChB5ennKYi4Gmyq9Q80g==
X-Received: by 2002:a17:907:16a6:b0:93e:1dd4:3f1e with SMTP id hc38-20020a17090716a600b0093e1dd43f1emr14729106ejc.35.1679969303987;
        Mon, 27 Mar 2023 19:08:23 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b009447277c26fsm2199573ejb.72.2023.03.27.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:08:23 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: verifier/xdp_direct_packet_access.c converted to inline assembly
Date:   Tue, 28 Mar 2023 05:08:12 +0300
Message-Id: <20230328020813.392560-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328020813.392560-1-eddyz87@gmail.com>
References: <20230328020813.392560-1-eddyz87@gmail.com>
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

Test verifier/xdp_direct_packet_access.c automatically converted to use inline assembly.
Original test would be removed in the next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../progs/verifier_xdp_direct_packet_access.c | 1722 +++++++++++++++++
 2 files changed, 1724 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a774d5b193f1..efc8cf2e18d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -40,6 +40,7 @@
 #include "verifier_var_off.skel.h"
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
+#include "verifier_xdp_direct_packet_access.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -102,3 +103,4 @@ void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
 void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
+void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
new file mode 100644
index 000000000000..df2dfd1b15d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
@@ -0,0 +1,1722 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/xdp_direct_packet_access.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end mangling, bad access 1")
+__failure __msg("R3 pointer arithmetic on pkt_end")
+__naked void end_mangling_bad_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	r3 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end mangling, bad access 2")
+__failure __msg("R3 pointer arithmetic on pkt_end")
+__naked void end_mangling_bad_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	r3 -= 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' > pkt_end, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void end_corner_case_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' > pkt_end, bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_end_bad_access_1_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 4);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' > pkt_end, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_end_bad_access_2_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' > pkt_end, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 9);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' > pkt_end, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end > pkt_data', good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void end_pkt_data_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end > pkt_data', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 6);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end > pkt_data', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 > r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end > pkt_data', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end > pkt_data', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' < pkt_end, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_pkt_end_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' < pkt_end, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 6);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' < pkt_end, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_end_bad_access_2_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 < r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' < pkt_end, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void end_corner_case_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' < pkt_end, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end < pkt_data', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end < pkt_data', bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_1_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 4);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end < pkt_data', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 < r1 goto l0_%=;				\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end < pkt_data', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 9);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end < pkt_data', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' >= pkt_end, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_pkt_end_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u32*)(r1 - 5);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' >= pkt_end, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_5(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 6);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' >= pkt_end, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_end_bad_access_2_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 >= r3 goto l0_%=;				\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' >= pkt_end, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void end_corner_case_good_access_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' >= pkt_end, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_5(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end >= pkt_data', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end >= pkt_data', bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_1_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 4);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end >= pkt_data', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 >= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end >= pkt_data', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_6(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 9);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end >= pkt_data', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_6(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' <= pkt_end, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void end_corner_case_good_access_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' <= pkt_end, bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_end_bad_access_1_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 4);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' <= pkt_end, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_end_bad_access_2_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 <= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' <= pkt_end, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_7(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 9);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data' <= pkt_end, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_7(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end <= pkt_data', good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void end_pkt_data_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u32*)(r1 - 5);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end <= pkt_data', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_8(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 6);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end <= pkt_data', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 <= r1 goto l0_%=;				\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end <= pkt_data', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_end <= pkt_data', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_8(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' > pkt_data, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_5(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' > pkt_data, bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_1_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 4);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' > pkt_data, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_5(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' > pkt_data, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_9(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 9);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' > pkt_data, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_9(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 > r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data > pkt_meta', good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_pkt_meta_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data > pkt_meta', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_10(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 6);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data > pkt_meta', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_meta_bad_access_2_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 > r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data > pkt_meta', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void meta_corner_case_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data > pkt_meta', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_10(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 > r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' < pkt_data, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void meta_pkt_data_good_access_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' < pkt_data, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_11(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 6);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' < pkt_data, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_6(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 < r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' < pkt_data, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_6(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' < pkt_data, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_11(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 < r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data < pkt_meta', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void meta_corner_case_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data < pkt_meta', bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_meta_bad_access_1_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 4);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data < pkt_meta', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_meta_bad_access_2_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 < r1 goto l0_%=;				\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data < pkt_meta', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_12(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 9);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data < pkt_meta', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_12(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 < r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' >= pkt_data, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void meta_pkt_data_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u32*)(r1 - 5);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' >= pkt_data, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_13(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 6);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' >= pkt_data, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_7(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 >= r3 goto l0_%=;				\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' >= pkt_data, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_7(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' >= pkt_data, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_13(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 >= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data >= pkt_meta', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void meta_corner_case_good_access_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data >= pkt_meta', bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_meta_bad_access_1_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 4);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data >= pkt_meta', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_meta_bad_access_2_3(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 >= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data >= pkt_meta', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_14(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 9);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data >= pkt_meta', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_14(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 >= r1 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' <= pkt_data, corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_corner_case_good_access_8(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 8);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' <= pkt_data, bad access 1")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_1_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 4);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' <= pkt_data, bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_data_bad_access_2_8(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 <= r3 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' <= pkt_data, corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_15(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 9;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 9);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_meta' <= pkt_data, corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_15(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r1 <= r3 goto l0_%=;				\
+	goto l1_%=;					\
+l0_%=:	r0 = *(u64*)(r1 - 7);				\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data <= pkt_meta', good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void data_pkt_meta_good_access_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u32*)(r1 - 5);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data <= pkt_meta', corner case -1, bad access")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_bad_access_16(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 6;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 6);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data <= pkt_meta', bad access 2")
+__failure __msg("R1 offset is outside of the packet")
+__flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_meta_bad_access_2_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 <= r1 goto l0_%=;				\
+l0_%=:	r0 = *(u32*)(r1 - 5);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data <= pkt_meta', corner case, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void meta_corner_case_good_access_4(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 7;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 7);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("XDP pkt read, pkt_data <= pkt_meta', corner case +1, good access")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void corner_case_1_good_access_16(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data_meta]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r3 <= r1 goto l0_%=;				\
+	r0 = *(u64*)(r1 - 8);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_meta, offsetof(struct xdp_md, data_meta))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.40.0

