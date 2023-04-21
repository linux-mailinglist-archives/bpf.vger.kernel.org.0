Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E636EB0EC
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjDURnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjDURna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568A976A
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2f4c431f69cso1263496f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098988; x=1684690988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydckA1JcBTo2MUAJ0/P0uEz3gxR1TZN7874ZRgf9Fb4=;
        b=LJEbhdRxyZT7kXX546bFrJPIVLvBn7HS+WZuJedp35F3EFuwWmhLp+qfYBXvTG9pBY
         w3MmKIw4L7rqyDkTThFzzVqq5t+2+3OhTzQVIl9f+yvREzBKXuwCeCxFo2DgjdzAh+zb
         Xk9thAdHFgTHaYeCGTDf3xdhZfCRvgTGJEaIeRGMPddQ5/QrQbwwhGu7tUTlvZPEZvLP
         t3JsI5pFV4Uxk2LUr4w21eLLDHfAbpohpiOvrZ2oejV9LmJ+8DdRQVvbdfPIqJL4UPC4
         DvOdr6iCcjaSu2iuQS5NhsqWdwi0z214HUpf8mtFIUWfLunrPQM5QBMI5v7k6Q607Xt4
         dKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098988; x=1684690988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydckA1JcBTo2MUAJ0/P0uEz3gxR1TZN7874ZRgf9Fb4=;
        b=Tvkbr4Sw6pUorRdjv3QDMiOZshpq9vwV/9tym234Oe6dh5kqA/6ZsEr74fOo+xllC+
         cOkC+gxmeJyriR2m50M3kJBWOWBrx6Zs98ryKWun/7KfpNtiCMU6cFIUvqAcjHc4c6OO
         keGvlBbYp1jyFedoynw9JGEtZLkpYGTAoNAFzOOdO/KBbzXjZ9hCWs66cTrbTzrhprRc
         6kq0U5Getp+qjXUI+XWGHykV0zkmL8zaCPd1cmy2/vw+YnPU6Y1C1HOyv1/hcoDuiSd3
         QQPvejVzDjiB+ZyFis+LhZC28kEUo8Jlk8WQMYYuLJXj8FgO01r0t8sakiHcB6GGdndO
         P3DQ==
X-Gm-Message-State: AAQBX9eLjJ0NCBOwxus2om2Rd29jx7TqZRbUEvo07aYvh8gL1FiqZAL9
        ooJk2qCxMRfXjR7jyq+S8Gdpv0nMTtoVYw==
X-Google-Smtp-Source: AKy350bJFeUTY25kfDhEJgXGC47UAS0GV1OoxMQFQRH8VvdCtVBK/Wm5xe2M9GECOo55dI92P4MTbg==
X-Received: by 2002:a05:6000:1b85:b0:2fb:2a43:4a97 with SMTP id r5-20020a0560001b8500b002fb2a434a97mr4277808wru.39.1682098987815;
        Fri, 21 Apr 2023 10:43:07 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:43:07 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 19/24] selftests/bpf: verifier/sock converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:29 +0300
Message-Id: <20230421174234.2391278-20-eddyz87@gmail.com>
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

Test verifier/sock automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_sock.c       | 980 ++++++++++++++++++
 tools/testing/selftests/bpf/verifier/sock.c   | 706 -------------
 3 files changed, 982 insertions(+), 706 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sock.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/sock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 1ef44e699e9c..60bcff62d968 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -50,6 +50,7 @@
 #include "verifier_ringbuf.skel.h"
 #include "verifier_runtime_jit.skel.h"
 #include "verifier_search_pruning.skel.h"
+#include "verifier_sock.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_uninit.skel.h"
@@ -141,6 +142,7 @@ void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_pruning); }
+void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
new file mode 100644
index 000000000000..ee76b51005ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -0,0 +1,980 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/sock.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_REUSEPORT_SOCKARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} map_reuseport_array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} map_sockhash SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} map_sockmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} map_xskmap SEC(".maps");
+
+struct val {
+	int cnt;
+	struct bpf_spin_lock l;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(max_entries, 0);
+	__type(key, int);
+	__type(value, struct val);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} sk_storage_map SEC(".maps");
+
+SEC("cgroup/skb")
+__description("skb->sk: no NULL check")
+__failure __msg("invalid mem access 'sock_common_or_null'")
+__failure_unpriv
+__naked void skb_sk_no_null_check(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	r0 = *(u32*)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("skb->sk: sk->family [non fullsock field]")
+__success __success_unpriv __retval(0)
+__naked void sk_family_non_fullsock_field_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u32*)(r1 + %[bpf_sock_family]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_family, offsetof(struct bpf_sock, family))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("skb->sk: sk->type [fullsock field]")
+__failure __msg("invalid sock_common access")
+__failure_unpriv
+__naked void sk_sk_type_fullsock_field_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r0 = *(u32*)(r1 + %[bpf_sock_type]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_sk_fullsock(skb->sk): no !skb->sk check")
+__failure __msg("type=sock_common_or_null expected=sock_common")
+__failure_unpriv
+__naked void sk_no_skb_sk_check_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	call %[bpf_sk_fullsock];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): no NULL check on ret")
+__failure __msg("invalid mem access 'sock_or_null'")
+__failure_unpriv
+__naked void no_null_check_on_ret_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	r0 = *(u32*)(r0 + %[bpf_sock_type]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->type [fullsock field]")
+__success __success_unpriv __retval(0)
+__naked void sk_sk_type_fullsock_field_2(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + %[bpf_sock_type]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->family [non fullsock field]")
+__success __success_unpriv __retval(0)
+__naked void sk_family_non_fullsock_field_2(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + %[bpf_sock_family]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_family, offsetof(struct bpf_sock, family))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->state [narrow load]")
+__success __success_unpriv __retval(0)
+__naked void sk_sk_state_narrow_load(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r0 + %[bpf_sock_state]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_state, offsetof(struct bpf_sock, state))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->dst_port [word load] (backward compatibility)")
+__success __success_unpriv __retval(0)
+__naked void port_word_load_backward_compatibility(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + %[bpf_sock_dst_port]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_dst_port, offsetof(struct bpf_sock, dst_port))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->dst_port [half load]")
+__success __success_unpriv __retval(0)
+__naked void sk_dst_port_half_load(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u16*)(r0 + %[bpf_sock_dst_port]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_dst_port, offsetof(struct bpf_sock, dst_port))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->dst_port [half load] (invalid)")
+__failure __msg("invalid sock access")
+__failure_unpriv
+__naked void dst_port_half_load_invalid_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u16*)(r0 + %[__imm_0]);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__imm_0, offsetof(struct bpf_sock, dst_port) + 2),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->dst_port [byte load]")
+__success __success_unpriv __retval(0)
+__naked void sk_dst_port_byte_load(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r2 = *(u8*)(r0 + %[bpf_sock_dst_port]);		\
+	r2 = *(u8*)(r0 + %[__imm_0]);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__imm_0, offsetof(struct bpf_sock, dst_port) + 1),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_dst_port, offsetof(struct bpf_sock, dst_port))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->dst_port [byte load] (invalid)")
+__failure __msg("invalid sock access")
+__failure_unpriv
+__naked void dst_port_byte_load_invalid(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r0 + %[__imm_0]);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__imm_0, offsetof(struct bpf_sock, dst_port) + 2),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): past sk->dst_port [half load] (invalid)")
+__failure __msg("invalid sock access")
+__failure_unpriv
+__naked void dst_port_half_load_invalid_2(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u16*)(r0 + %[bpf_sock_dst_port__end]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_dst_port__end, offsetofend(struct bpf_sock, dst_port))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->dst_ip6 [load 2nd byte]")
+__success __success_unpriv __retval(0)
+__naked void dst_ip6_load_2nd_byte(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r0 + %[__imm_0]);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__imm_0, offsetof(struct bpf_sock, dst_ip6[0]) + 1),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->type [narrow load]")
+__success __success_unpriv __retval(0)
+__naked void sk_sk_type_narrow_load(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r0 + %[bpf_sock_type]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): sk->protocol [narrow load]")
+__success __success_unpriv __retval(0)
+__naked void sk_sk_protocol_narrow_load(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r0 + %[bpf_sock_protocol]);		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_protocol, offsetof(struct bpf_sock, protocol))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("sk_fullsock(skb->sk): beyond last field")
+__failure __msg("invalid sock access")
+__failure_unpriv
+__naked void skb_sk_beyond_last_field_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + %[bpf_sock_rx_queue_mapping__end]);\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_sock_rx_queue_mapping__end, offsetofend(struct bpf_sock, rx_queue_mapping))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(skb->sk): no !skb->sk check")
+__failure __msg("type=sock_common_or_null expected=sock_common")
+__failure_unpriv
+__naked void sk_no_skb_sk_check_2(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	call %[bpf_tcp_sock];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(skb->sk): no NULL check on ret")
+__failure __msg("invalid mem access 'tcp_sock_or_null'")
+__failure_unpriv
+__naked void no_null_check_on_ret_2(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_tcp_sock];				\
+	r0 = *(u32*)(r0 + %[bpf_tcp_sock_snd_cwnd]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_tcp_sock_snd_cwnd, offsetof(struct bpf_tcp_sock, snd_cwnd))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(skb->sk): tp->snd_cwnd")
+__success __success_unpriv __retval(0)
+__naked void skb_sk_tp_snd_cwnd_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 = *(u32*)(r0 + %[bpf_tcp_sock_snd_cwnd]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_tcp_sock_snd_cwnd, offsetof(struct bpf_tcp_sock, snd_cwnd))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(skb->sk): tp->bytes_acked")
+__success __success_unpriv __retval(0)
+__naked void skb_sk_tp_bytes_acked(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 = *(u64*)(r0 + %[bpf_tcp_sock_bytes_acked]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_tcp_sock_bytes_acked, offsetof(struct bpf_tcp_sock, bytes_acked))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(skb->sk): beyond last field")
+__failure __msg("invalid tcp_sock access")
+__failure_unpriv
+__naked void skb_sk_beyond_last_field_2(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r0 = *(u64*)(r0 + %[bpf_tcp_sock_bytes_acked__end]);\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_tcp_sock_bytes_acked__end, offsetofend(struct bpf_tcp_sock, bytes_acked))
+	: __clobber_all);
+}
+
+SEC("cgroup/skb")
+__description("bpf_tcp_sock(bpf_sk_fullsock(skb->sk)): tp->snd_cwnd")
+__success __success_unpriv __retval(0)
+__naked void skb_sk_tp_snd_cwnd_2(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l2_%=;				\
+	exit;						\
+l2_%=:	r0 = *(u32*)(r0 + %[bpf_tcp_sock_snd_cwnd]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk)),
+	  __imm_const(bpf_tcp_sock_snd_cwnd, offsetof(struct bpf_tcp_sock, snd_cwnd))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("bpf_sk_release(skb->sk)")
+__failure __msg("R1 must be referenced when passed to release function")
+__naked void bpf_sk_release_skb_sk(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 == 0 goto l0_%=;				\
+	call %[bpf_sk_release];				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_release),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("bpf_sk_release(bpf_sk_fullsock(skb->sk))")
+__failure __msg("R1 must be referenced when passed to release function")
+__naked void bpf_sk_fullsock_skb_sk(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	call %[bpf_sk_release];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_sk_release),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("bpf_sk_release(bpf_tcp_sock(skb->sk))")
+__failure __msg("R1 must be referenced when passed to release function")
+__naked void bpf_tcp_sock_skb_sk(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_tcp_sock];				\
+	if r0 != 0 goto l1_%=;				\
+	exit;						\
+l1_%=:	r1 = r0;					\
+	call %[bpf_sk_release];				\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_release),
+	  __imm(bpf_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("sk_storage_get(map, skb->sk, NULL, 0): value == NULL")
+__success __retval(0)
+__naked void sk_null_0_value_null(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r4 = 0;						\
+	r3 = 0;						\
+	r2 = r0;					\
+	r1 = %[sk_storage_map] ll;			\
+	call %[bpf_sk_storage_get];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_sk_storage_get),
+	  __imm_addr(sk_storage_map),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("sk_storage_get(map, skb->sk, 1, 1): value == 1")
+__failure __msg("R3 type=scalar expected=fp")
+__naked void sk_1_1_value_1(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r4 = 1;						\
+	r3 = 1;						\
+	r2 = r0;					\
+	r1 = %[sk_storage_map] ll;			\
+	call %[bpf_sk_storage_get];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_sk_storage_get),
+	  __imm_addr(sk_storage_map),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("sk_storage_get(map, skb->sk, &stack_value, 1): stack_value")
+__success __retval(0)
+__naked void stack_value_1_stack_value(void)
+{
+	asm volatile ("					\
+	r2 = 0;						\
+	*(u64*)(r10 - 8) = r2;				\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	call %[bpf_sk_fullsock];			\
+	if r0 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r4 = 1;						\
+	r3 = r10;					\
+	r3 += -8;					\
+	r2 = r0;					\
+	r1 = %[sk_storage_map] ll;			\
+	call %[bpf_sk_storage_get];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_sk_fullsock),
+	  __imm(bpf_sk_storage_get),
+	  __imm_addr(sk_storage_map),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("bpf_map_lookup_elem(smap, &key)")
+__failure __msg("cannot pass map_type 24 into func bpf_map_lookup_elem")
+__naked void map_lookup_elem_smap_key(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[sk_storage_map] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(sk_storage_map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__description("bpf_map_lookup_elem(xskmap, &key); xs->queue_id")
+__success __retval(0)
+__naked void xskmap_key_xs_queue_id(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_xskmap] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r0 = *(u32*)(r0 + %[bpf_xdp_sock_queue_id]);	\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_xskmap),
+	  __imm_const(bpf_xdp_sock_queue_id, offsetof(struct bpf_xdp_sock, queue_id))
+	: __clobber_all);
+}
+
+SEC("sk_skb")
+__description("bpf_map_lookup_elem(sockmap, &key)")
+__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__naked void map_lookup_elem_sockmap_key(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_sockmap] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_sockmap)
+	: __clobber_all);
+}
+
+SEC("sk_skb")
+__description("bpf_map_lookup_elem(sockhash, &key)")
+__failure __msg("Unreleased reference id=2 alloc_insn=6")
+__naked void map_lookup_elem_sockhash_key(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_sockhash] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_sockhash)
+	: __clobber_all);
+}
+
+SEC("sk_skb")
+__description("bpf_map_lookup_elem(sockmap, &key); sk->type [fullsock field]; bpf_sk_release(sk)")
+__success
+__naked void field_bpf_sk_release_sk_1(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_sockmap] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = r0;					\
+	r0 = *(u32*)(r0 + %[bpf_sock_type]);		\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_sk_release),
+	  __imm_addr(map_sockmap),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("sk_skb")
+__description("bpf_map_lookup_elem(sockhash, &key); sk->type [fullsock field]; bpf_sk_release(sk)")
+__success
+__naked void field_bpf_sk_release_sk_2(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_sockhash] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	if r0 != 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	r1 = r0;					\
+	r0 = *(u32*)(r0 + %[bpf_sock_type]);		\
+	call %[bpf_sk_release];				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_sk_release),
+	  __imm_addr(map_sockhash),
+	  __imm_const(bpf_sock_type, offsetof(struct bpf_sock, type))
+	: __clobber_all);
+}
+
+SEC("sk_reuseport")
+__description("bpf_sk_select_reuseport(ctx, reuseport_array, &key, flags)")
+__success
+__naked void ctx_reuseport_array_key_flags(void)
+{
+	asm volatile ("					\
+	r4 = 0;						\
+	r2 = 0;						\
+	*(u32*)(r10 - 4) = r2;				\
+	r3 = r10;					\
+	r3 += -4;					\
+	r2 = %[map_reuseport_array] ll;			\
+	call %[bpf_sk_select_reuseport];		\
+	exit;						\
+"	:
+	: __imm(bpf_sk_select_reuseport),
+	  __imm_addr(map_reuseport_array)
+	: __clobber_all);
+}
+
+SEC("sk_reuseport")
+__description("bpf_sk_select_reuseport(ctx, sockmap, &key, flags)")
+__success
+__naked void reuseport_ctx_sockmap_key_flags(void)
+{
+	asm volatile ("					\
+	r4 = 0;						\
+	r2 = 0;						\
+	*(u32*)(r10 - 4) = r2;				\
+	r3 = r10;					\
+	r3 += -4;					\
+	r2 = %[map_sockmap] ll;				\
+	call %[bpf_sk_select_reuseport];		\
+	exit;						\
+"	:
+	: __imm(bpf_sk_select_reuseport),
+	  __imm_addr(map_sockmap)
+	: __clobber_all);
+}
+
+SEC("sk_reuseport")
+__description("bpf_sk_select_reuseport(ctx, sockhash, &key, flags)")
+__success
+__naked void reuseport_ctx_sockhash_key_flags(void)
+{
+	asm volatile ("					\
+	r4 = 0;						\
+	r2 = 0;						\
+	*(u32*)(r10 - 4) = r2;				\
+	r3 = r10;					\
+	r3 += -4;					\
+	r2 = %[map_sockmap] ll;				\
+	call %[bpf_sk_select_reuseport];		\
+	exit;						\
+"	:
+	: __imm(bpf_sk_select_reuseport),
+	  __imm_addr(map_sockmap)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("mark null check on return value of bpf_skc_to helpers")
+__failure __msg("invalid mem access")
+__naked void of_bpf_skc_to_helpers(void)
+{
+	asm volatile ("					\
+	r1 = *(u64*)(r1 + %[__sk_buff_sk]);		\
+	if r1 != 0 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	r6 = r1;					\
+	call %[bpf_skc_to_tcp_sock];			\
+	r7 = r0;					\
+	r1 = r6;					\
+	call %[bpf_skc_to_tcp_request_sock];		\
+	r8 = r0;					\
+	if r8 != 0 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_skc_to_tcp_request_sock),
+	  __imm(bpf_skc_to_tcp_sock),
+	  __imm_const(__sk_buff_sk, offsetof(struct __sk_buff, sk))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
deleted file mode 100644
index 108dd3ee1edd..000000000000
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ /dev/null
@@ -1,706 +0,0 @@
-{
-	"skb->sk: no NULL check",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid mem access 'sock_common_or_null'",
-},
-{
-	"skb->sk: sk->family [non fullsock field]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, offsetof(struct bpf_sock, family)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"skb->sk: sk->type [fullsock field]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, offsetof(struct bpf_sock, type)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid sock_common access",
-},
-{
-	"bpf_sk_fullsock(skb->sk): no !skb->sk check",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "type=sock_common_or_null expected=sock_common",
-},
-{
-	"sk_fullsock(skb->sk): no NULL check on ret",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid mem access 'sock_or_null'",
-},
-{
-	"sk_fullsock(skb->sk): sk->type [fullsock field]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->family [non fullsock field]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, family)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->state [narrow load]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, state)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->dst_port [word load] (backward compatibility)",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->dst_port [half load]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->dst_port [half load] (invalid)",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid sock access",
-},
-{
-	"sk_fullsock(skb->sk): sk->dst_port [byte load]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_0, offsetof(struct bpf_sock, dst_port)),
-	BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->dst_port [byte load] (invalid)",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_port) + 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid sock access",
-},
-{
-	"sk_fullsock(skb->sk): past sk->dst_port [half load] (invalid)",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_0, offsetofend(struct bpf_sock, dst_port)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid sock access",
-},
-{
-	"sk_fullsock(skb->sk): sk->dst_ip6 [load 2nd byte]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, dst_ip6[0]) + 1),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->type [narrow load]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): sk->protocol [narrow load]",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, protocol)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"sk_fullsock(skb->sk): beyond last field",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetofend(struct bpf_sock, rx_queue_mapping)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid sock access",
-},
-{
-	"bpf_tcp_sock(skb->sk): no !skb->sk check",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "type=sock_common_or_null expected=sock_common",
-},
-{
-	"bpf_tcp_sock(skb->sk): no NULL check on ret",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_tcp_sock, snd_cwnd)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid mem access 'tcp_sock_or_null'",
-},
-{
-	"bpf_tcp_sock(skb->sk): tp->snd_cwnd",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_tcp_sock, snd_cwnd)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"bpf_tcp_sock(skb->sk): tp->bytes_acked",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_tcp_sock, bytes_acked)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"bpf_tcp_sock(skb->sk): beyond last field",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, offsetofend(struct bpf_tcp_sock, bytes_acked)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = REJECT,
-	.errstr = "invalid tcp_sock access",
-},
-{
-	"bpf_tcp_sock(bpf_sk_fullsock(skb->sk)): tp->snd_cwnd",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_tcp_sock, snd_cwnd)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
-	.result = ACCEPT,
-},
-{
-	"bpf_sk_release(skb->sk)",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "R1 must be referenced when passed to release function",
-},
-{
-	"bpf_sk_release(bpf_sk_fullsock(skb->sk))",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "R1 must be referenced when passed to release function",
-},
-{
-	"bpf_sk_release(bpf_tcp_sock(skb->sk))",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_tcp_sock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_MOV64_IMM(BPF_REG_0, 1),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "R1 must be referenced when passed to release function",
-},
-{
-	"sk_storage_get(map, skb->sk, NULL, 0): value == NULL",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_sk_storage_map = { 11 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"sk_storage_get(map, skb->sk, 1, 1): value == 1",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 1),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_sk_storage_map = { 11 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "R3 type=scalar expected=fp",
-},
-{
-	"sk_storage_get(map, skb->sk, &stack_value, 1): stack_value",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_sk_storage_map = { 14 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = ACCEPT,
-},
-{
-	"bpf_map_lookup_elem(smap, &key)",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_sk_storage_map = { 3 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "cannot pass map_type 24 into func bpf_map_lookup_elem",
-},
-{
-	"bpf_map_lookup_elem(xskmap, &key); xs->queue_id",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -8, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_xdp_sock, queue_id)),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_xskmap = { 3 },
-	.prog_type = BPF_PROG_TYPE_XDP,
-	.result = ACCEPT,
-},
-{
-	"bpf_map_lookup_elem(sockmap, &key)",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_sockmap = { 3 },
-	.prog_type = BPF_PROG_TYPE_SK_SKB,
-	.result = REJECT,
-	.errstr = "Unreleased reference id=2 alloc_insn=5",
-},
-{
-	"bpf_map_lookup_elem(sockhash, &key)",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_sockhash = { 3 },
-	.prog_type = BPF_PROG_TYPE_SK_SKB,
-	.result = REJECT,
-	.errstr = "Unreleased reference id=2 alloc_insn=5",
-},
-{
-	"bpf_map_lookup_elem(sockmap, &key); sk->type [fullsock field]; bpf_sk_release(sk)",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_sockmap = { 3 },
-	.prog_type = BPF_PROG_TYPE_SK_SKB,
-	.result = ACCEPT,
-},
-{
-	"bpf_map_lookup_elem(sockhash, &key); sk->type [fullsock field]; bpf_sk_release(sk)",
-	.insns = {
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, offsetof(struct bpf_sock, type)),
-	BPF_EMIT_CALL(BPF_FUNC_sk_release),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_sockhash = { 3 },
-	.prog_type = BPF_PROG_TYPE_SK_SKB,
-	.result = ACCEPT,
-},
-{
-	"bpf_sk_select_reuseport(ctx, reuseport_array, &key, flags)",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -4),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_select_reuseport),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_reuseport_array = { 4 },
-	.prog_type = BPF_PROG_TYPE_SK_REUSEPORT,
-	.result = ACCEPT,
-},
-{
-	"bpf_sk_select_reuseport(ctx, sockmap, &key, flags)",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -4),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_select_reuseport),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_sockmap = { 4 },
-	.prog_type = BPF_PROG_TYPE_SK_REUSEPORT,
-	.result = ACCEPT,
-},
-{
-	"bpf_sk_select_reuseport(ctx, sockhash, &key, flags)",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_4, 0),
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -4),
-	BPF_LD_MAP_FD(BPF_REG_2, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_select_reuseport),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_sockmap = { 4 },
-	.prog_type = BPF_PROG_TYPE_SK_REUSEPORT,
-	.result = ACCEPT,
-},
-{
-	"mark null check on return value of bpf_skc_to helpers",
-	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
-	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-	BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_request_sock),
-	BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_8, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0),
-	BPF_EXIT_INSN(),
-	},
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid mem access",
-	.result_unpriv = REJECT,
-	.errstr_unpriv = "unknown func",
-},
-- 
2.40.0

