Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D636C8A71
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjCYC4f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCYC4c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96921B2C4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so1969765wms.2
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4pRi8I44+bAYbM9+O3F2iAetwT4upDCTsuA4kHS/wk=;
        b=Rv7alodFB4bGrd/zfiRkRRBYN5r6xFQrhNxyDul0qiuNzRTgSLCQvsHipV2EdXPiOO
         tumTcmCvOEFgRUi6WiWdMAdgky7KUkeFC6cPs/WAVRwUsqVYwFm1VxoRoC8rXTqmxf+s
         i972qzPkqKQPkIZfJRoBjyrwESD9YmO0Ah5KCsgi/iVa8OGGIeowdRAfbb5TcD83o91c
         VcnEsV+fIdwAlTQTtLOyw//BcH9+JXNQRMpFf3J73Oxu7DDZAqSHw21rkQUYMKYRgseG
         FamYghjPoIlyVqT2ks3haYWwOUBlqKRtAWok+4DJ4kp7x5RB40OB4R7iuhWkkPkUOEIW
         1smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4pRi8I44+bAYbM9+O3F2iAetwT4upDCTsuA4kHS/wk=;
        b=WFcHJPpVh1NBUVnBnH91nAvDq037AuMbuShIEZYpU06+LnOz2huNCX+dY3KcvMHg6n
         6tYLanwa4dvQPAaNXg0iWmi5uCJGsjW9JVqOBAJ5e6zfL714hK5mG0n2g9veoUJwlugz
         ziIzZrLt/vsFlL6hWtPDYI5Tgy4a7C7vzTU+sqZ910rklsrpw9FTbl/MGv7hkyBMDSc/
         VUJ+VuvEQkTDUTp5CkImtyTK8IAMAOhYzLqYaMMbrWc+4IqkCkOveZgHEd3erAB5qEP1
         6YgW2fzXLv2dSO8FzmjxSUXo/oZlFdj52l5g0meCGr5043KnZQKuUA5QHXiBEpa29nQV
         Ws5g==
X-Gm-Message-State: AO0yUKWkuTuRc5qB+Pp7AVJtEkYM6qHJOMCAor632a/vVtmCij5kMO1x
        uZk/IKpkyP6je+uYxtargSRUmdsm92U=
X-Google-Smtp-Source: AK7set9TtKY//NXFzdkrxmdu8B6RFdI4tS65ORObjitJ86i/TaGEAP4ZfjdDUEhKwIS3gSmmrwJEog==
X-Received: by 2002:a05:600c:214f:b0:3ed:5eed:5581 with SMTP id v15-20020a05600c214f00b003ed5eed5581mr3471272wml.2.1679712982913;
        Fri, 24 Mar 2023 19:56:22 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:56:22 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 21/43] selftests/bpf: verifier/helper_packet_access.c converted to inline assembly
Date:   Sat, 25 Mar 2023 04:55:02 +0200
Message-Id: <20230325025524.144043-22-eddyz87@gmail.com>
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

Test verifier/helper_packet_access.c automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_helper_packet_access.c | 550 ++++++++++++++++++
 .../bpf/verifier/helper_packet_access.c       | 460 ---------------
 3 files changed, 552 insertions(+), 460 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/helper_packet_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 22d7e152c05e..1cd162daf150 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -18,6 +18,7 @@
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
 #include "verifier_helper_access_var_len.skel.h"
+#include "verifier_helper_packet_access.skel.h"
 
 __maybe_unused
 static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
@@ -58,3 +59,4 @@ void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_st
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_len); }
+void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
new file mode 100644
index 000000000000..74f5f9cd153d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/helper_packet_access.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, long long);
+	__type(value, long long);
+} map_hash_8b SEC(".maps");
+
+SEC("xdp")
+__description("helper access to packet: test1, valid packet_ptr range")
+__success __retval(0)
+__naked void test1_valid_packet_ptr_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r1 = %[map_hash_8b] ll;				\
+	r3 = r2;					\
+	r4 = 0;						\
+	call %[bpf_map_update_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_update_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("helper access to packet: test2, unchecked packet_ptr")
+__failure __msg("invalid access to packet")
+__naked void packet_test2_unchecked_packet_ptr(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(xdp_md_data, offsetof(struct xdp_md, data))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("helper access to packet: test3, variable add")
+__success __retval(0)
+__naked void to_packet_test3_variable_add(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r4 = r2;					\
+	r4 += 8;					\
+	if r4 > r3 goto l0_%=;				\
+	r5 = *(u8*)(r2 + 0);				\
+	r4 = r2;					\
+	r4 += r5;					\
+	r5 = r4;					\
+	r5 += 8;					\
+	if r5 > r3 goto l0_%=;				\
+	r1 = %[map_hash_8b] ll;				\
+	r2 = r4;					\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("helper access to packet: test4, packet_ptr with bad range")
+__failure __msg("invalid access to packet")
+__naked void packet_ptr_with_bad_range_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r4 = r2;					\
+	r4 += 4;					\
+	if r4 > r3 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("helper access to packet: test5, packet_ptr with too short range")
+__failure __msg("invalid access to packet")
+__naked void ptr_with_too_short_range_1(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[xdp_md_data]);		\
+	r3 = *(u32*)(r1 + %[xdp_md_data_end]);		\
+	r2 += 1;					\
+	r4 = r2;					\
+	r4 += 7;					\
+	if r4 > r3 goto l0_%=;				\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test6, cls valid packet_ptr range")
+__success __retval(0)
+__naked void cls_valid_packet_ptr_range(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r1 = r2;					\
+	r1 += 8;					\
+	if r1 > r3 goto l0_%=;				\
+	r1 = %[map_hash_8b] ll;				\
+	r3 = r2;					\
+	r4 = 0;						\
+	call %[bpf_map_update_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_update_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test7, cls unchecked packet_ptr")
+__failure __msg("invalid access to packet")
+__naked void test7_cls_unchecked_packet_ptr(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test8, cls variable add")
+__success __retval(0)
+__naked void packet_test8_cls_variable_add(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = r2;					\
+	r4 += 8;					\
+	if r4 > r3 goto l0_%=;				\
+	r5 = *(u8*)(r2 + 0);				\
+	r4 = r2;					\
+	r4 += r5;					\
+	r5 = r4;					\
+	r5 += 8;					\
+	if r5 > r3 goto l0_%=;				\
+	r1 = %[map_hash_8b] ll;				\
+	r2 = r4;					\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test9, cls packet_ptr with bad range")
+__failure __msg("invalid access to packet")
+__naked void packet_ptr_with_bad_range_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r4 = r2;					\
+	r4 += 4;					\
+	if r4 > r3 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test10, cls packet_ptr with too short range")
+__failure __msg("invalid access to packet")
+__naked void ptr_with_too_short_range_2(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r2 += 1;					\
+	r4 = r2;					\
+	r4 += 7;					\
+	if r4 > r3 goto l0_%=;				\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test11, cls unsuitable helper 1")
+__failure __msg("helper access to the packet")
+__naked void test11_cls_unsuitable_helper_1(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r3 = r6;					\
+	r3 += 7;					\
+	if r3 > r7 goto l0_%=;				\
+	r2 = 0;						\
+	r4 = 42;					\
+	r5 = 0;						\
+	call %[bpf_skb_store_bytes];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_skb_store_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test12, cls unsuitable helper 2")
+__failure __msg("helper access to the packet")
+__naked void test12_cls_unsuitable_helper_2(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r3 = r6;					\
+	r6 += 8;					\
+	if r6 > r7 goto l0_%=;				\
+	r2 = 0;						\
+	r4 = 4;						\
+	call %[bpf_skb_load_bytes];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test13, cls helper ok")
+__success __retval(0)
+__naked void packet_test13_cls_helper_ok(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 4;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test14, cls helper ok sub")
+__success __retval(0)
+__naked void test14_cls_helper_ok_sub(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 -= 4;					\
+	r2 = 4;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test15, cls helper fail sub")
+__failure __msg("invalid access to packet")
+__naked void test15_cls_helper_fail_sub(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 -= 12;					\
+	r2 = 4;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test16, cls helper fail range 1")
+__failure __msg("invalid access to packet")
+__naked void cls_helper_fail_range_1(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 8;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test17, cls helper fail range 2")
+__failure __msg("R2 min value is negative")
+__naked void cls_helper_fail_range_2(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = -9;					\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test18, cls helper fail range 3")
+__failure __msg("R2 min value is negative")
+__naked void cls_helper_fail_range_3(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = %[__imm_0];				\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__imm_0, ~0),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test19, cls helper range zero")
+__success __retval(0)
+__naked void test19_cls_helper_range_zero(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 0;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test20, pkt end as input")
+__failure __msg("R1 type=pkt_end expected=fp")
+__naked void test20_pkt_end_as_input(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r1 = r7;					\
+	r2 = 4;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("helper access to packet: test21, wrong reg")
+__failure __msg("invalid access to packet")
+__naked void to_packet_test21_wrong_reg(void)
+{
+	asm volatile ("					\
+	r6 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r7 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r6 += 1;					\
+	r1 = r6;					\
+	r1 += 7;					\
+	if r1 > r7 goto l0_%=;				\
+	r2 = 4;						\
+	r3 = 0;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_csum_diff];				\
+	r0 = 0;						\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_csum_diff),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/helper_packet_access.c b/tools/testing/selftests/bpf/verifier/helper_packet_access.c
deleted file mode 100644
index ae54587e9829..000000000000
--- a/tools/testing/selftests/bpf/verifier/helper_packet_access.c
+++ /dev/null
@@ -1,460 +0,0 @@
-{
-	"helper access to packet: test1, valid packet_ptr range",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 5),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.result_unpriv = ACCEPT,
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"helper access to packet: test2, unchecked packet_ptr",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1 },
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"helper access to packet: test3, variable add",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-			offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 10),
-	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_5),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 11 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"helper access to packet: test4, packet_ptr with bad range",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 7 },
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"helper access to packet: test5, packet_ptr with too short range",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct xdp_md, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 6 },
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_XDP,
-},
-{
-	"helper access to packet: test6, cls valid packet_ptr range",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 5),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_2),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_update_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test7, cls unchecked packet_ptr",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 1 },
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test8, cls variable add",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-			offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-			offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 10),
-	BPF_LDX_MEM(BPF_B, BPF_REG_5, BPF_REG_2, 0),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_5),
-	BPF_MOV64_REG(BPF_REG_5, BPF_REG_4),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_5, BPF_REG_3, 4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 11 },
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test9, cls packet_ptr with bad range",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 7 },
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test10, cls packet_ptr with too short range",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
-	BPF_MOV64_REG(BPF_REG_4, BPF_REG_2),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_3, 3),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 6 },
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test11, cls unsuitable helper 1",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_7, 4),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 42),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_store_bytes),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "helper access to the packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test12, cls unsuitable helper 2",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 8),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 3),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 4),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_skb_load_bytes),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "helper access to the packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test13, cls helper ok",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test14, cls helper ok sub",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 4),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test15, cls helper fail sub",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 12),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test16, cls helper fail range 1",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 8),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test17, cls helper fail range 2",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, -9),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R2 min value is negative",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test18, cls helper fail range 3",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, ~0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R2 min value is negative",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test19, cls helper range zero",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test20, pkt end as input",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "R1 type=pkt_end expected=fp",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-{
-	"helper access to packet: test21, wrong reg",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
-		    offsetof(struct __sk_buff, data)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
-		    offsetof(struct __sk_buff, data_end)),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 7),
-	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_7, 6),
-	BPF_MOV64_IMM(BPF_REG_2, 4),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_5, 0),
-	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_csum_diff),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid access to packet",
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-},
-- 
2.40.0

